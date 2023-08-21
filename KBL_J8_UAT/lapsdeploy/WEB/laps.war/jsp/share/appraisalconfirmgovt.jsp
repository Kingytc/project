<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%		ArrayList vec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			int vecsize = 0;
			int vecrecsize = 0;
			if (hshValues != null) {
				vec = (ArrayList) hshValues.get("vecData");
				vecrec = (ArrayList) hshValues.get("vecData2");
			}
			if (vecrec != null) {
				vecsize = vec.size();
			}
			if (vecrec != null) {
				vecrecsize = vecrec.size();
			}
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));
			%>
			 
<html>
<head>
<title>Appraisal Confirmation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var strOption ="<%=Helper.correctNull((String)hshValues.get("strOption"))%>";
var strDet ="<%=Helper.correctNull((String)hshValues.get("strDet"))%>";
var stat_data_sno ="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>";
var str="<%=Helper.correctNull((String)hshValues.get("str"))%>";
var str1="<%=vecsize%>";

function getalldata1()
{
    if(document.forms[0].hidAction.value!="update")
    {
	    document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].hidSourceUrl.value="/action/appraisalconfirm.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function getAllData()
{
	document.forms[0].hid_option.value="";
	if(document.forms[0].sel_option.selectedIndex == "1")
	{
		document.forms[0].hid_option.value = document.forms[0].sel_option.value;
	}
	else
	{
		for(var i = 0; i <= document.forms[0].sel_option.length - 1; i++)
		{
			if(document.forms[0].sel_option[i].selectedIndex == "1")
			{
				document.forms[0].hid_option.value = document.forms[0].sel_option[i].value;
			}
			if(document.forms[0].sel_option[i].selectedIndex == "1")
			{
				document.forms[0].hid_option.value = document.forms[0].hid_option.value + "," + document.forms[0].sel_option[i].value;			
			}
			if(document.forms[0].sel_option[i].selectedIndex == "2")
			{
				document.forms[0].hid_option.value = document.forms[0].sel_option[i].value;
			}
			if(document.forms[0].sel_option[i].selectedIndex == "2")
			{
				document.forms[0].hid_option.value = document.forms[0].hid_option.value + "," + document.forms[0].sel_option[i].value;			
			}
		}
	}
}

function getcall()
{
	document.forms[0].hid_option.value = "";	
	if(document.forms[0].sel_option.selectedIndex == "1")
	{
		document.forms[0].hid_option.value = document.forms[0].sel_option.value;
	}	
	else
	{
		for(var i = 0; i <= document.forms[0].sel_option.length - 1; i++)
		{
			if(document.forms[0].sel_option[i].selectedIndex == "1")
			{
				if(document.forms[0].hid_option.value == "")
				{
					document.forms[0].hid_option.value = document.forms[0].sel_option[i].value;
				}
				else
				{
					document.forms[0].hid_option.value= document.forms[0].hid_option.value + "," + document.forms[0].sel_option[i].value;
				}
			}
		}
	}
}

function callonLoad()
{
	document.forms[0].hidAction.value="select";		
    document.forms[0].appno1.value="<%=(String)request.getParameter("appno")%>";
    //var appno1="<%//=(String)request.getParameter("appno")%>";   
	disablefields(true);	
	/*var varrecsize="<%//=vecrecsize%>";
	if(varrecsize != 0){
	enableButtons(false, true, true, false);	
	}
	else{
	enableButtons(true, true, true, false);	
	}*/
	document.all.cmddel.style.visibility="hidden";
	document.all.cmddel.style.position="absolute";
}

function doSave()
{	
    var appno1=document.forms[0].appno1.value;
   
	document.forms[0].hidBeanId.value="govtsponschklist";
	document.forms[0].hidBeanMethod.value="updategovtQuestParameters";
	document.forms[0].hidBeanGetMethod.value="getgovtQuestParameters";
	document.forms[0].hidSourceUrl.value="/action/appraisalconfirmgovt.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	enableButtons(true, false, false, true);
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		if("<%=strPgDist%>"=="P")
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/retailpge.jsp";
		}
		else
		{
			document.forms[0].action ="<%=ApplicationParams.getAppUrl()%>action/corppge.jsp";
		}		

		document.forms[0].submit();
	}
}
  



function doCancel()
{	
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].hidBeanId.value="govtsponschklist";
		document.forms[0].hidBeanMethod.value="updategovtQuestParameters";
		document.forms[0].hidBeanGetMethod.value="getgovtQuestParameters";
		document.forms[0].hidSourceUrl.value="/action/appraisalconfirmgovt.jsp";
		document.forms[0].submit();
	}
}

function callNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="New";
   	enableButtons(true, false, false, true);
   	disablefields(false);   	
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update"
   	document.forms[0].hid_option.value="";
	enableButtons(true, false, false, true);
	disablefields(false);
}
   
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable border1" height="20">
    <tr> 
      <td> 
         <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="10" />
        </jsp:include>
       	</td>
       </tr>
       
       </table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		
      <td class="page_flow">Home -&gt; 
        Retail -&gt;  Appraisal 
        -&gt; Government Sponser Check List</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td id="mainlnk1"><lapschoice:application /></td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable border1">
	<tr>
		<td><jsp:include page="../share/apprlinktab.jsp"
			flush="true">
			<jsp:param name="tabid" value="8" />
		</jsp:include></td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0"
	
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">			
			<tr>
				<td valign="top">
				<table width="98%" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable">
					<tr>
						<td valign="top" height="76">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td valign="top" class="cellcontainer">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable">
									<tr height="22" align="center" class="dataheader">
										<td nowrap width="60%"><b>
											Appraisal</b></td>
										<td nowrap width="5%">
											<b>Value</b></td>
										<td nowrap width="35%">
											<b>Remarks</b></td>
									</tr>
									<%if (vecrecsize != 0 && vecsize!=0) {
										if(vecrecsize==vecsize)
										{
				for (int l = 0; l < vecsize; l++) {
					if (l < vecsize) {
						g1 = (ArrayList) vec.get(l);
						g2 = (ArrayList) vecrec.get(l);

						String strtype = Helper.correctNull((String) g1
								.get(0));
						%>
									<tr class="datagrid">
										<td><br>
										<%=l + 1%>. <%=Helper.correctNull((String) g1.get(1))%><br>
										<input type="hidden" name="txt_staticdataid"
											value="<%=Helper.correctNull((String)g2.get(0))%>"></td>
										<td valign="center" align="center"><%String str11 = Helper.correctNull((String) g2
								.get(0));

						%> <select name="sel_option" value="">


											<%if (str11.equals("1")) {

						%>
											<option value="1" selected>Yes</option>
											<%} else {

						%>
											<option value="1">Yes</option>
											<%}

						%>
											<%if (str11.equals("2")) {

						%>
											<option value="2" selected>No</option>
											<%} else {

						%>
											<option value="2">No</option>
											<%}

						%>
										</select></td>
										<td valign="top" align="right"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)"
											rows="2" cols="25" wrap="virtual"><%=Helper.correctNull((String) g2.get(1))%></textarea>
										</td>

										<%					
					}
				}
				}
			}
			if (vecrecsize == 0 && vecsize == 0) {
				for (int l = 0; l < vecsize; l++) {
					if (l < vecsize) {
						g1 = (ArrayList) vec.get(l);

						%>
									<tr>
										<td><br>
										<%=l + 1%>. <%=Helper.correctNull((String) g1.get(1))%><br>
										<input type="hidden" name="txt_staticdataid" value=""></td>
										<td valign="center" align="center"><select name="sel_option"
											value="">
											<option selected value="1">Yes</option>
											<option value="2">No</option>
										</select></td>
										<td valign="center" align="right"><textarea
											name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)"
											rows="2" cols="25" wrap="virtual"></textarea></td>

										<%}
				}
			}

			%>
								</table>
								</td>
							</tr>
						</table>
						<table>

						</table>

						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<lapschoice:hiddentag/>
<input type="hidden" name="txt_staticdataid"> 
<input type="hidden" name="hidslno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
<input type="hidden" name="hidstate" value="2"> 
<input type="hidden" name="hidstatenew" value=""> 
<input type="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="hid_option" value="<%=Helper.correctNull((String)hshValues.get("strOption"))%>"> 
<input type="hidden" name="appno1" value="<%=(String)request.getParameter("appno")%>"> 
<input type="hidden" name="comappid" value= "<%=session.getAttribute("comappid")%>">
<input type="hidden" name="bowid" value= "<%=session.getAttribute("comappid")%>">
<INPUT TYPE="hidden" name="id" value="<%=Helper.correctNull((String)session.getAttribute("comappid"))%>">
<INPUT TYPE="hidden" name="compname" value="<%=Helper.correctNull((String)hshValues.get("id"))%>">

</form>
</body>
</html>
