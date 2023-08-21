<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%	if (objValues instanceof java.util.HashMap) 
			{
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vec = new ArrayList();
			ArrayList vecrec = new ArrayList();
			int vecsize = 0;
			int vecrecsize = 0;
			if (hshValues != null) 
			{
				vec = (ArrayList) hshValues.get("vecData");
				vecrec = (ArrayList) hshValues.get("vecData2");
			}
			if (vecrec != null) 
			{
				vecsize = vec.size();
			}
			if (vecrec != null) 
			{
				vecrecsize = vecrec.size();
			}
			ArrayList g1 = new ArrayList();
			ArrayList g2 = new ArrayList();
			String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));
			String strsponsor="";
			if(strsponsor.equalsIgnoreCase(""))
			{
				strsponsor=Helper.correctNull((String)hshValues.get("strsponsor"));
			}%>			 
<html>
<head>
<title>Appraisal Confirmation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var strOption ="<%=Helper.correctNull((String)hshValues.get("strOption"))%>";
var strDet ="<%=Helper.correctNull((String)hshValues.get("strDet"))%>";
var str="<%=Helper.correctNull((String)hshValues.get("str"))%>";
var str1="<%=vecsize%>";
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
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

function callonLoad()
{
	document.forms[0].hidAction.value="select";		
	disablefields(true);	
	var varrecsize="<%=vecrecsize%>";
	if(varrecsize != 0 && document.forms[0].btnenable.value=="Y")
	{
		enableButtons(false, true, true, false);	
	}
	else
	{
		enableButtons(true, true, true, false);	
	}	
}
function doSave()
{	
	document.forms[0].hidBeanId.value="govtsponschklist";
	document.forms[0].hidBeanMethod.value="updategovtQuestParameters";
	document.forms[0].hidBeanGetMethod.value="getgovtQuestParameters";
	document.forms[0].hidSourceUrl.value="/action/ops_checklist.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	enableButtons(true, false, false, true);
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action ="<%=ApplicationParams.getAppUrl()%>action/agrpage.jsp";
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
		//document.forms[0].hidBeanMethod.value="updategovtQuestParameters";
		document.forms[0].hidBeanGetMethod.value="getgovtQuestParameters";
		document.forms[0].action=appURL+"action/ops_checklist.jsp";
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="New";
   	enableButtons(true, false, false, true);
   	disablefields(false);   	
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update"
	enableButtons(true, false, false, true);
	disablefields(false);
	document.forms[0].cmddelete.disabled=false;
}

function doDelete(){
		if(ConfirmMsg(101)){
	document.forms[0].hidAction.value="Delete";
	document.forms[0].hidBeanMethod.value="updategovtQuestParameters";
	document.forms[0].hidBeanGetMethod.value="getgovtQuestParameters";	
	document.forms[0].hidBeanId.value="govtsponschklist";
	document.forms[0].hidSourceUrl.value="/action/ops_checklist.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
		}
}
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="outertable">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="31" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Check List-&gt; Sponsor Scheme</td>
	</tr>
</table>
<span style="visibility:hidden">
<lapschoice:borrowertype /></span> <lapschoice:application/>
<lapschoice:TerGovtSponsorTag pageid="3" govtsponsor='<%=strsponsor%>' />
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">			
			<tr>
				<td valign="top">
				<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
					<tr>
						<td valign="top" >
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
									<tr align="center" class="dataheader">
										<td nowrap width="60%"><b>Appraisal</b></td>
										<td nowrap width="5%"><b>Value</b></td>
										<td nowrap width="35%"><b>Remarks</b></td>
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
										<td valign="top" align="center"><textarea name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote()"
											rows="2" cols="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="virtual"><%=Helper.correctNull((String) g2.get(1))%></textarea>
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
									<tr class="datagrid">
										<td><br>
										<%=l + 1%>. <%=Helper.correctNull((String) g1.get(1))%><br>
										<input type="hidden" name="txt_staticdataid" value=""></td>
										<td valign="center" align="center"><select name="sel_option"
											value="">
											<option selected value="1">Yes</option>
											<option value="2">No</option>
										</select></td>
										<td valign="center" align="center"><textarea
											name="txt_comments"
											onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote()"
											rows="2" cols="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="virtual"></textarea></td>

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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
