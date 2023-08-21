<%@include file="../share/directives.jsp"%>
<%
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
	HashMap hshRecord = (HashMap) hshValues.get("hshRecord");
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
	String pageid = Helper.correctNull((String) request
			.getParameter("pageid"));
	String strEmployment = (String) session
			.getAttribute("strEmployment");
	String strModuleName = Helper.correctNull(request
			.getParameter("hidModuleName"));
	String strModName = "";
	if (strModuleName.equalsIgnoreCase("T")) {
		strModName = "Tertiary";
	} else if (strModuleName.equalsIgnoreCase("P")) {
		strModName = "Retail";
	} else {
		strModName = "Corporate & SME";
	}
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String grpRights = Helper.correctNull((String) session
			.getAttribute("strGroupRights"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<title>Financial Documents &ndash; Tradeable</title>
</head>
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var sel_SecuExchCode = "<%=Helper.correctNull((String)hshValues.get("sec_exccode"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";

function callOnload()
{
	if(sel_SecuExchCode!="" && sel_SecuExchCode!="0")
	{
		document.forms[0].sel_SecuExchCode.value=sel_SecuExchCode;
		document.forms[0].old_sel_SecuExchCodeText.value = document.forms[0].sel_SecuExchCode.options[document.forms[0].sel_SecuExchCode.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_SecuExchCode.value="0";
		document.forms[0].old_sel_SecuExchCodeText.value = ""; 
	}
	calldisable(true);
	ToggleSecurityExCode();
	<%if(grpRights.charAt(18)=='r'){%>
	document.forms[0].cmdedit.disabled=true;
<%}%>

if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
}
function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
		showCal(appURL,name);
}
function ToggleSecurityExCode()
{
	if(document.forms[0].sel_SecuExchCode.value=="004")
	{
		document.all.SecuExCodeOthers1.style.display="table-cell";
		document.all.SecuExCodeOthers2.style.display="table-cell";
		document.all.SecuExCodeOthers3.style.display="table-cell";
	}
	else 
	{
		document.all.SecuExCodeOthers1.style.display="none";
		document.all.SecuExCodeOthers2.style.display="none";
		document.all.SecuExCodeOthers3.style.display="none";
	}
}
function calcTotalSecurity()
{
	var unitsHeld=NanNumber(document.forms[0].txt_Units_Held.value);
	var presentRate=NanNumber(document.forms[0].txt_Present_Quoted_Rate.value);
	if(trim(unitsHeld)=="") document.forms[0].txt_Units_Held.value="0";
	document.forms[0].txt_Security_TotValue.value= NanNumber(unitsHeld*presentRate);
	roundNumber(document.forms[0].txt_Security_TotValue,2);
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";	
		document.forms[0].hidBeanGetMethod.value="getFinDocTradeable";
		document.forms[0].action=appURL+"action/setFinDocTradeable.jsp";	
		document.forms[0].submit();		
	}	
}
function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].txt_Security_TotValue.readOnly=true;
	document.forms[0].hidAction.value ="insert";
}
function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function doSave()
{
	if(trim(document.forms[0].txt_Units_Held.value)=="" ||
			trim(document.forms[0].txt_Units_Held.value)=="0")
	{
		document.forms[0].txt_Units_Held.value="";
		alert("Enter No. of Units Held");
		document.forms[0].txt_Units_Held.focus();
		return;
	}
	if(trim(document.forms[0].txt_Present_Quoted_Rate.value)=="" ||
			trim(document.forms[0].txt_Present_Quoted_Rate.value)=="0.00")
	{
		document.forms[0].txt_Present_Quoted_Rate.value="";
		alert("Enter Present Quoted Rate");
		document.forms[0].txt_Present_Quoted_Rate.focus();
		return;
	}
	if(trim(document.forms[0].txt_Matu_Value.value)=="" ||
			trim(document.forms[0].txt_Matu_Value.value)=="0.00")
	{
		document.forms[0].txt_Matu_Value.value="";
		alert("Enter Maturity Value");
		document.forms[0].txt_Matu_Value.focus();
		return;
	}
	if(trim(document.forms[0].txt_Matu_Date.value)=="")
	{
		document.forms[0].txt_Matu_Date.value="";
		alert("Enter Maturity Date");
		document.forms[0].txt_Matu_Date.focus();
		return;
	}

	modifyCheck();
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/setFinDocTradeable.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateFinDocTradeable";
	document.forms[0].hidBeanGetMethod.value="getFinDocTradeable";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{
	var temp="";
	var tempname="";

	if(document.forms[0].sel_SecuExchCode.value=="0")
		document.forms[0].sel_SecuExchCodeText.value="";
	else
		document.forms[0].sel_SecuExchCodeText.value=document.forms[0].sel_SecuExchCode.options[document.forms[0].sel_SecuExchCode.selectedIndex].text;

	if(document.forms[0].sel_SecuExchCodeText.value!=document.forms[0].old_sel_SecuExchCodeText.value)
	{
		temp=temp+"old_sel_SecuExchCodeText"+"@"; 
		tempname=tempname+"Security Exchange Code"+"@";
	}
	if(document.forms[0].txt_Other_Specify.value!=document.forms[0].old_txt_Other_Specify.value)
	{
		temp=temp+"old_txt_Other_Specify"+"@"; 
		tempname=tempname+"Specify"+"@";
	}
	if(document.forms[0].txt_Units_Held.value!=document.forms[0].old_txt_Units_Held.value)
	{
		temp=temp+"old_txt_Units_Held"+"@"; 
		tempname=tempname+"No. of Units Held"+"@";
	}
	if(document.forms[0].txt_Present_Quoted_Rate.value!=document.forms[0].old_txt_Present_Quoted_Rate.value)
	{
		temp=temp+"old_txt_Present_Quoted_Rate"+"@"; 
		tempname=tempname+"Present Quoted Rate "+"@";
	}
	if(document.forms[0].txt_Security_TotValue.value!=document.forms[0].old_txt_Security_TotValue.value)
	{
		temp=temp+"old_txt_Security_TotValue"+"@"; 
		tempname=tempname+"Total Value of Security"+"@";
	}
	if(document.forms[0].old_txt_Matu_Value.value!=document.forms[0].old_txt_Matu_Value.value)
	{
		temp=temp+"old_txt_Matu_Value"+"@"; 
		tempname=tempname+"Maturity Value "+"@";
	}
	if(document.forms[0].old_txt_Matu_Date.value!=document.forms[0].old_txt_Matu_Date.value)
	{
		temp=temp+"old_txt_Matu_Date"+"@"; 
		tempname=tempname+"Maturity Date "+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
}

function dobtnClose()
{
	if (ConfirmMsg(100)) 
	{
		<%if(strPagefrom.equalsIgnoreCase("appl")&&(strSessionModuleType.equalsIgnoreCase("RET"))){%>
		document.forms[0].hidBeanId.value="bankappfi"
		document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
		document.forms[0].action=appURL+"action/securitymaster_retail.jsp";
		document.forms[0].submit();
	<%}else if(strPagefrom.equalsIgnoreCase("secmailbox")){%>
		window.close();
	<%}else{%>
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanGetMethod.value="getSecurityValuesDetails";
		document.forms[0].action=appURL+"action/securitiesMasterPage.jsp";
		document.forms[0].submit();
		<%}%>
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/setFinDocTradeable.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateFinDocTradeable";
		document.forms[0].hidBeanGetMethod.value="getFinDocTradeable";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="callOnload()">
	<form method="post" class="normal">
		<jsp:include page="../share/help.jsp" flush="true"/>

<%if(strPagefrom.equalsIgnoreCase("appl")){
	if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
	if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="203" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
			</td>
		</tr>
	</table>
	<%}else{%>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Tradeable</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="6" />
		</jsp:include>
		</td>
	</tr>
</table>
<%}else if(strSessionModuleType.equalsIgnoreCase("RET")){
if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
<jsp:param name="pageid" value="<%=pageid%>" />
</jsp:include>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Tradeable</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="203" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td valign="top">
<jsp:include page="../set/appurlsectabs.jsp" flush="true">
	<jsp:param name="pageid" value="6" />
</jsp:include>
</td>
</tr>
</table>
<%
}}else if(strPagefrom.equals("secmailbox")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td valign="top">
	<jsp:include page="../set/appurlsectabs.jsp" flush="true">
		<jsp:param name="pageid" value="6" />
	</jsp:include>
	</td>
</tr>
</table>		
<%}else{%>
<table width="98%" border="0" cellspacing="1" cellpadding="3"	class="outertable" align="center">
	<tr class="dataheader">
		<td align="left" width="10%"><b>Customer Name</b></td>
		<td align="left" width="30%"><b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer CBSID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer LAPS ID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>&nbsp;</b></td>
	</tr>
</table> 
		<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
		<tr>
			<td class="page_flow" colspan="2">Home -&gt; Securities -&gt; Financial Documents &ndash; Tradeable</td>
		</tr>
		</table>
		<table width="50%" border="0" cellspacing="1" cellpadding="0" align="center"
			class="outertable">
			<tr>
			<td WIDTH="50%" class="sub_tab_inactive" align="center">
				<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
				Security Details</a></b>
			</td>
			<td class="sub_tab_active" align="center"><b>Financial Documents &ndash; Tradeable / Transferable</b></td>
			</tr>
		</table>
	<%} %>
		<table width="98%" border="0" cellpadding="3" cellspacing="0"
			align="center" class="outertable" style="border: 2px solid #dccada;">
			<tr>
				<td>
					<table width="90%" border="0" cellspacing="3" cellpadding="3"
						align="center" class="outertable">
						<tr>
							<td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
						</tr>
						
						<tr valign="top">
							<td width="20%">Security Exchange Code </td>
							<td width="3%">&nbsp;</td>
							<td width="27%""><select name="sel_SecuExchCode" id="sel_SecuExchCode" onChange="ToggleSecurityExCode()" tabindex="1">
							  <option value="0" selected>&lt;---Select---&gt;</option>
							  <lapschoice:StaticDataNewTag apptype="119" />
							</select></td>
							<td id="SecuExCodeOthers1">Specify</td>
							<td id="SecuExCodeOthers2">&nbsp;</td>
							<td id="SecuExCodeOthers3"><input name="txt_Other_Specify" type="text" id="txt_Other_Specify" 
							value="<%=Helper.correctNull((String)hshValues.get("sec_specify"))%>" tabindex="2"
								size="30" maxlength="30" /></td>
						</tr>
						<tr>
							<td>No. of Units Held <span class="mantatory">*&nbsp;</span></td>
							<td>&nbsp;</td>
							<td>
						    <input name="txt_Units_Held" type="text" id="txt_Units_Held" 
						    value="<%=Helper.correctNull((String)hshValues.get("sec_units"))%>" tabindex="3"
								size="20" maxlength="6" onKeyPress="allowNumber(document.forms[0].txt_Units_Held);" 
								onBlur="calcTotalSecurity();"/></td>

							<td width="20%">Present Quoted Rate <span class="mantatory">*&nbsp;</span><br>(in Rs. per unit) &nbsp;</td>
							<td width="3%"><%=ApplicationParams.getCurrency()%></td>
							<td width="27%"><lapschoice:CurrencyTag
						  		name="txt_Present_Quoted_Rate" tabindex="4" size="12" maxlength="10" 
						  		value='<%=Helper.correctNull((String)hshValues.get("sec_presentrate"))%>'
						  		onKeyPress="calcTotalSecurity()" onBlur="calcTotalSecurity()"/></td>
						</tr>
						
						<tr>
						  <td nowrap="nowrap">Total Value of Security  </td>
						  <td align="right"><%=ApplicationParams.getCurrency()%></td>
						  <td><lapschoice:CurrencyTag
						  		name="txt_Security_TotValue" tabindex="5" size="12" maxlength="12" 
						  		value='<%=Helper.correctNull((String)hshValues.get("sec_totalvalue"))%>'/></td>
						  <td>&nbsp;</td>
						  <td align="right">
					      
						  <td ></td>
					  </tr>
						<tr>
						  <td nowrap="nowrap">Maturity  Value <span class="mantatory">*&nbsp;</span></td>
						  <td align="right"><%=ApplicationParams.getCurrency()%>
						  <td><lapschoice:CurrencyTag
						  		name="txt_Matu_Value" tabindex="6" size="12" maxlength="10" 
						  		value='<%=Helper.correctNull((String)hshValues.get("sec_maturityvalue"))%>'/></td>
						  <td>Maturity Date <span class="mantatory">*&nbsp;</span></td>
						  <td >&nbsp;</td>
						  <td><input type="text" name="txt_Matu_Date"
								size="11" value="<%=Helper.correctNull((String)hshValues.get("sec_maturitydate"))%>" tabindex="7"
								onBlur="checkDate(this);checkmindate(this,curdate)"
								maxlength="12"> <a alt="Select date from calender"
								href="#" onClick="callCalender('txt_Matu_Date')"
								onMouseOver="window.status='Date Picker';return true;"
								onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0" alt="Select date from calender" tabindex="29"></a>(dd/mm/yyyy)</td>
					  </tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
<%if(strPagefrom.equalsIgnoreCase("appl")||strPagefrom.equalsIgnoreCase("secmailbox")){%>
 <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
  <tr><td align="center"> 
    <input type="button" name="cmdclose" value="Close" onClick="dobtnClose()"  class="buttonClose"> 
  </td></tr>
 </table>
<%}else{ %>
		<lapschoice:combuttonnew
			btnnames='Edit _Save_Cancel_Delete_Audit Trail'
			btnenable='<%=Helper.correctNull((String) request
					.getParameter("btnenable"))%>' />
<%} %>
		<br>
		<%
			String strappno = request.getParameter("appno");
		%>
		<lapschoice:hiddentag pageid='<%=pageid%>' />
		<input type="hidden" name="txtperapp_appid"
			value="<%=Helper.correctNull((String) hshValues.get("applicantId"))%>">
		<input type="hidden" name="hidDemoId"
			value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
		<input type="hidden" name="hidSecurityId"
			value="<%=Helper.correctNull((String)request.getParameter("hidSecurityId"))%>">
<input type="hidden" name="hidsectype" value="<%=sectype%>">
<input type="hidden" name="hidsecid" value="<%=strsecID%>">

<input type="hidden" name="hidmodifiedvalue">  
<input type="hidden" name="hidmodifiedField">  


<input type="hidden" name="old_sel_SecuExchCodeText" >
<input type="hidden" name="old_txt_Other_Specify" value="<%=Helper.correctNull((String)hshValues.get("sec_specify"))%>" >
<input type="hidden" name="old_txt_Units_Held" value="<%=Helper.correctNull((String)hshValues.get("sec_units"))%>" >
<input type="hidden" name="old_txt_Present_Quoted_Rate" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_presentrate"))))%>" >
<input type="hidden" name="old_txt_Security_TotValue" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_totalvalue"))))%>">
<input type="hidden" name="old_txt_Matu_Value" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_maturityvalue"))))%>">
<input type="hidden" name="old_txt_Matu_Date" value="<%=Helper.correctNull((String)hshValues.get("sec_maturitydate"))%>">

<input type="hidden" name="sel_SecuExchCodeText" >

	</form>
</body>
</html>