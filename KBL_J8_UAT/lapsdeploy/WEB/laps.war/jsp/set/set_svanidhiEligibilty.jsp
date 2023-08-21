<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	ArrayList arrData = new ArrayList();
ArrayList arrRow = new ArrayList();
int arrsize = 0;
if (hshValues != null) {
	arrData = (ArrayList) hshValues.get("arrRowSvanidhi");
	
}
if(arrData!=null){
	arrsize=arrData.size();
}
session.setAttribute("com_svanidhi", Helper.correctNull((String)hshValues.get("COM_SVANIDHITYPE")));

%>
<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Svanidhi Eligibility</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String strProductType = Helper.correctNull((String) session.getAttribute("strProductType"));
%>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var scheme = "<%=Helper.correctNull((String) hshValues.get("schemetype"))%>";
var fac_id ="<%=Helper.correctNull(request.getParameter("fac_id"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varSchemeType="<%=Helper.correctNull((String)hshValues.get("COM_BANKSCHEME"))%>";
var varSvanidhiType="<%=Helper.correctNull((String)hshValues.get("COM_SVANIDHITYPE"))%>";

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
	    if(document.forms[0].elements[i].type=="text") 
		{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-multiple')
	 	{
			document.forms[0].elements[i].disabled=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}
function doSave()
{
	if(document.forms[0].svanidhi_mindays.value =="" ){
		alert("The Minimum days Should not be empty");
		document.forms[0].svanidhi_mindays.focus();
		return;
	}
	if(document.forms[0].svanidhi_maxdays.value =="" ){
		alert("The Maximum days Should not be empty");
		document.forms[0].svanidhi_maxdays.focus();
		return;
	}
	
	
	if(document.forms[0].svanidhi_maxdays.value !="" && document.forms[0].svanidhi_maxdays.value !=""){
	if(Number(document.forms[0].svanidhi_maxdays.value)==Number(document.forms[0].svanidhi_mindays.value))
	{
	alert("The Minimum and Maximum days Should not be equal");
	document.forms[0].svanidhi_mindays.value="";
	document.forms[0].svanidhi_mindays.focus();
	return;
	}
	else if(Number(document.forms[0].svanidhi_maxdays.value) < Number(document.forms[0].svanidhi_mindays.value))
	{
	alert("The Minimum days  Should Be Less Than Maximum days");
	document.forms[0].svanidhi_mindays.value="";
	document.forms[0].svanidhi_mindays.focus();
	return;
	}
	else if(Number(document.forms[0].svanidhi_maxdays.value)==Number(document.forms[0].svanidhi_mindays.value))
	{
	alert("The Minimum and Maximum days Should not be equal");
	document.forms[0].svanidhi_maxdays.value="";
	document.forms[0].svanidhi_maxdays.focus();
	return;
	}
	
	}

	if(document.forms[0].svanidhi_eligible_percentage.value =="" ){
		alert("The Eligible Percentage Should not be empty");
		document.forms[0].svanidhi_eligible_percentage.focus();
		return;
	}
	 document.forms[0].cmdsave.disabled = true;
	
    
	document.forms[0].hidBeanId.value="corporatefacility"
	document.forms[0].hidBeanMethod.value="update_svanidhi";
	document.forms[0].hidBeanGetMethod.value="get_svanidhi";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/set_svanidhiEligibilty.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="corporatefacility"
		document.forms[0].hidBeanMethod.value="update_svanidhi";
		document.forms[0].hidBeanGetMethod.value="get_svanidhi";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/set_svanidhiEligibilty.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="corporatefacility"
		document.forms[0].hidBeanMethod.value="update_svanidhi";
		document.forms[0].hidBeanGetMethod.value="get_svanidhi";
		document.forms[0].hidSourceUrl.value="/action/set_svanidhiEligibilty.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"comfacilityhome.jsp";
		document.forms[0].submit();
	}
}
function onLoading()
{
		disableFields(true);
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		disableFields(true);
		
		document.forms[0].cmdnew.disabled =false;		
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	
	
	if(val=="new")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	
}
function selectValues(val1,val2,val3,val4)
{
	
	document.forms[0].svanidhi_mindays.value=val1;
	document.forms[0].svanidhi_maxdays.value=val2;
	document.forms[0].svanidhi_eligible_percentage.value=val3;
	document.forms[0].hid_sno.value=val4;
	
 	 disableCommandButtons("radioselect");
	
}
function doNew()
{
	disableFields(false);
	disableCommandButtons("new");	
	document.forms[0].hidAction.value ="insert";
document.forms[0].hideditflag.value="Y";
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons("edit");	
}


</script>
</head>
<body onload="onLoading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div></div>
<form name="documentsfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<jsp:include page="../share/help.jsp" flush="true"/>
		<jsp:include page="../share/menus.jsp" flush="true"/>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="19" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Svanidhi Eligibility</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				<tr>
					<td valign="top">
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
								<tr>
									<td><lapschoice:facility /></td>
								</tr>
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
	</td>
</tr>
</table>
          <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable"
	 >
	<tr>
	  <td valign="top">
	  <fieldset> 
	  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
               
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
              <tr>
                <td><table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                 
                    <tr >
                      <td width="23%">Min No of days
                       </td>
                      <td width="26%"><input type="text" name="svanidhi_mindays"
											size="25" tabindex="11" onKeyPress="allowNumber(this)"
											 maxlength="12"
											value="" style="text-align:right" onPaste="window.event.returnValue=false"></td>
                      <td width="12%">Max No of days</td>
                      <td width="39%"><input type="text" name="svanidhi_maxdays"
											size="25" tabindex="12" onKeyPress="allowNumber(this)"
											 maxlength="12" value=""
											style="text-align:right" onPaste="window.event.returnValue=false"></td>
                    </tr>
                   
                    <tr>
                    
                        <td width="23%" height="35">Eligible Percentage(%)</td>

                        <td colspan="3" height="35">
<input
											type="text" name="svanidhi_eligible_percentage" size="8"
											onKeyPress="allowNumber(this)" maxlength="6" onBlur="roundtxt(this);"
											style="text-align:right" tabindex="13" onPaste="window.event.returnValue=false" 
											value="">
                      </td>
                    </tr>
          </table></td>
        </tr>
      </table>
      </td>
      </tr>
      </table>
      </fieldset>
      </td>
      </tr>
      </table>
     


<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br>
                          <table width="85%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                             
                              <tr>

<td width="3%"></td>
<td width="10%"><b>Min No. of Days</b></td>
<td width="10%"><b>Max No. of Days</b></td>
<td width="10%"><b>Percentage eligible(%)</b></td>

</tr>            
<%      
                 if (arrData != null && arrsize>0) {
												
													
														
														
														for (int i = 0; i < arrsize; i++) {
															arrRow = (ArrayList) arrData.get(i);%>
                              <tr class="datagrid"> 
                                <td width="3%" align="center"> 
                                  <input type="radio"
											style="border:none" name="radiobutton" value="radiobutton"
											onClick="javascript:selectValues(
											    '<%=Helper.correctNull((String)arrRow.get(0))%>',
												'<%=Helper.correctNull((String)arrRow.get(1))%>',
												'<%=Helper.correctNull((String)arrRow.get(2))%>',
												'<%=Helper.correctNull((String)arrRow.get(3))%>'
												)">
                                </td>
                               <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrRow.get(0))%></td>
                                <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrRow.get(1))%></td>
                                <td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arrRow.get(2))%></td>
                                
                               </tr>
                              <%}}%>
                             
                            </table>
                            <br>
                            <br>
                      
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="prd_code" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="repaytype">
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="hidindtype" value="">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
<input type="hidden" name="hid_array">
<input type="hidden" name="hid_sno">


</form>
</body>
</html>