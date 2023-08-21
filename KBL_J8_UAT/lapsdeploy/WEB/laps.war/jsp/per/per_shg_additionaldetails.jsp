<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
String strappstatus=Helper.correctNull((String)request.getParameter("appstatus"));
String strSno=Helper.correctNull((String)request.getParameter("varSno"));
if(strSno.equalsIgnoreCase(""))
{
	strSno=Helper.correctNull((String)hshValues.get("varSno"));
}
String strType=Helper.correctNull((String)request.getParameter("varType"));
if(strType.equalsIgnoreCase(""))
{
	strType=Helper.correctNull((String)hshValues.get("varType"));
}
String strAppId=Helper.correctNull((String)request.getParameter("hidDemoId"));
if(strAppId.equalsIgnoreCase(""))
{
	strAppId=Helper.correctNull((String)hshValues.get("hidDemoId"));
}

%>	
	
<html>
<head>
<title>Additional details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varBank = "<%=Helper.correctDouble((String)hshValues.get("SHGINFO_BANK"))%>";
var varStatus = "<%=Helper.correctDouble((String)hshValues.get("SHGINFO_STATUS"))%>";
var varappstatus = "<%=strappstatus%>";

function disableEditButtons(bool1, bool2, bool3,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool6;
}

function doClose()
{
	if(confirm("Do you want to Close the window?"))
	{
		window.close();
	}
}

function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
}

function doSave()
{  
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="commappmaster";
	document.forms[0].hidBeanMethod.value="updateSHGAddtnDetail";
	document.forms[0].hidBeanGetMethod.value="getSHGAddtnDetail";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/per_shg_additionaldetails.jsp";
	document.forms[0].submit();

}


function doEdit()
{
	disableEditButtons(true, false, false, true);
	disabledFields(false);
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSHGAddtnDetail";
		document.forms[0].hidBeanId.value="commappmaster";
		document.forms[0].action=appUrl+"action/per_shg_additionaldetails.jsp";
		document.forms[0].submit(); 		
	}
}

function onloading()
{
	disabledFields(true);
	if(varappstatus == "true")
		disableEditButtons(true, true, true ,false);
	else
		disableEditButtons(false, true, true ,false);
	
	if(varBank != "")
		document.forms[0].sel_lendingbank.value = varBank;
	else
		document.forms[0].sel_lendingbank.value = "s";
	<%if(strType.equalsIgnoreCase("EXE")){%>
	if(varStatus != "")
		document.forms[0].sel_status.value = varStatus;
	else
		document.forms[0].sel_status.value = "s";
	<%}%>
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="Financial" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; SHG -&gt; Members details -&gt; Additional Information</td>
	</tr>
</table>
<br>
<table width="90%" border="1" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center">
				<tr class="dataheader">
				<td colspan="2" align="center">Additional Information</td>
				</tr>
				<tr>
				<td align="left" width="50%">Name of the SHG</td>
				<td align="left" width="50%"><input type="text" name="txt_shgname" maxlength="40" size="40" onKeypress="allowAlphaNumericSpace()" value="<%=Helper.correctNull((String)hshValues.get("SHGINFO_NAME"))%>"></td>
				</tr>
				<%if(strType.equalsIgnoreCase("EXE")){%>
				<tr>
				<td align="left">SHG loan Account Number</td>
				<td align="left"><input type="text" name="txt_shgAccNo" maxlength="40" size="40" value="<%=Helper.correctNull((String)hshValues.get("SHGINFO_ACCNO"))%>" onKeypress="allowAlphaNumeric()"></td>
				</tr>
				<%} %>
				<tr>
				<td align="left">Name of the lending Bank</td>
				<td align="left">
					<select name="sel_lendingbank">
					<option value="s">--Select--</option>
					<lapschoice:StaticDataTag apptype="147"/>
					</select>
				</td>
				</tr>
				<tr>
				<td align="left">Amount borrowed</td>
				<td align="left"><input type="text" name="txt_borrowed" style="text-align:right" maxlength="20" size="30" onBlur="roundVal(document.forms[0].txt_borrowed.value)" value="<%=Helper.correctDouble((String)hshValues.get("SHGINFO_BORROW"))%>" onKeypress="allowNumber(this)"></td>
				</tr>
				<tr>
				<td align="left">Amount outstanding</td>
				<td align="left"><input type="text" name="txt_os" maxlength="20" style="text-align:right" size="30" onBlur="roundVal(document.forms[0].txt_borrowed.value)" value="<%=Helper.correctDouble((String)hshValues.get("SHGINFO_OS"))%>" onKeypress="allowNumber(this)"></td>
				</tr>
				<%if(strType.equalsIgnoreCase("EXE")){%>
				<tr>
				<td align="left">Status of the Account</td>
				<td align="left">
					<select name="sel_status">
					<option value="s">--Select--</option>
					<lapschoice:StaticDataTag apptype="187"/>
					</select>
				</td>
				</tr>
				<%} %>
			  </table>
		</td>
      </tr>
   </table>
   <br>
  <table width="50%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td>	
 	
 		<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
			 <lapschoice:combuttonnew btnnames='Edit _Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		<% } else {  %>
		<div style="display: none; ">
			<lapschoice:combuttonnew btnnames='Edit _Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		</div>		
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	<% } %>
	
		  </td>
    </tr>
 </table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 


<input type="hidden" name="hidDemoId" value="<%=strAppId%>"> 
<input type="hidden" name="hid_Sno" value="<%=strSno%>">
<input type="hidden" name="hidType" value="<%=strType%>">
 



</form>
</body>
</html>


