<%@include file="../share/directives.jsp"%>
<%
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
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
	String pageid = Helper.correctNull((String) request
			.getParameter("pageid"));
	String strEmployment = (String) session
			.getAttribute("strEmployment");
	String strFldName = request.getParameter("forgname");
	String strFldCode = request.getParameter("forgscode");
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
%>
<html>
<head>
<title>Personal - Applicant Securities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";

var sel_bank = "<%=Helper.correctNull((String)hshValues.get("sec_banktype"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";

function callLoad()
{
	calldisable(true);
	if(sel_bank!="" && sel_bank!="0")
	{
		document.forms[0].sel_bank.value=sel_bank;
		document.forms[0].old_sel_bankText.value = document.forms[0].sel_bank.options[document.forms[0].sel_bank.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_bank.value="0";
		document.forms[0].old_sel_bankText.value = ""; 
	}
	selbank();
	<%if(grpRights.charAt(18)=='r'){%>
	document.forms[0].cmdedit.disabled=true;
<%}%>

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
}

function calldisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		 	document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";	
		document.forms[0].hidBeanGetMethod.value="getSecurityBankDeposit";
		document.forms[0].action=appURL+"action/securitiesBankDeposits.jsp";	
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
	document.forms[0].hidAction.value ="insert";
	document.forms[0].sel_bank.focus();
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
	if(trim(document.forms[0].sel_bank.value)=="0")
	{
		alert("Select Bank");
		document.forms[0].sel_bank.focus();
		return;
	}
	if(trim(document.forms[0].txt_Issue_Date.value)=="")
	{
		document.forms[0].txt_Issue_Date.value="";
		alert("Enter Date of issue");
		document.forms[0].txt_Issue_Date.focus();
		return;
	}
	if(trim(document.forms[0].txt_accountno.value)=="")
	{
		document.forms[0].txt_accountno.value="";
		alert("Enter Account No.");
		document.forms[0].txt_accountno.focus();
		return;
	}
	if(trim(document.forms[0].txt_Face_PrinciValue.value)=="0.00" ||
			trim(document.forms[0].txt_Face_PrinciValue.value)=="")
	{
		document.forms[0].txt_Face_PrinciValue.value="";
		alert("Enter Face / Principal Value");
		document.forms[0].txt_Face_PrinciValue.focus();
		return;
	}
	if(trim(document.forms[0].txt_Present_BookValue.value)=="0.00" ||
			trim(document.forms[0].txt_Present_BookValue.value)=="")
	{
		document.forms[0].txt_Present_BookValue.value="";
		alert("Enter Present / Book Value");
		document.forms[0].txt_Present_BookValue.focus();
		return;
	}
	if(trim(document.forms[0].txt_Maturity_Value.value)=="0.00" ||
			trim(document.forms[0].txt_Maturity_Value.value)=="")
	{
		document.forms[0].txt_Maturity_Value.value="";
		alert("Enter Maturity Value");
		document.forms[0].txt_Maturity_Value.focus();
		return;
	}
	if(trim(document.forms[0].txt_Due_Date.value)=="")
	{
		document.forms[0].txt_Due_Date.value="";
		alert("Enter Due Date");
		document.forms[0].txt_Due_Date.focus();
		return;
	}

	modifyCheck();
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/securitiesBankDeposits.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityBankDeposit";
	document.forms[0].hidBeanGetMethod.value="getSecurityBankDeposit";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{

	var temp="";
	var tempname="";

	document.forms[0].sel_bankText.value=document.forms[0].sel_bank.options[document.forms[0].sel_bank.selectedIndex].text;

	if(document.forms[0].sel_bankText.value!=document.forms[0].old_sel_bankText.value)
	{
		temp=temp+"old_sel_bankText"+"@"; 
		tempname=tempname+"Bank"+"@";
	}
	if(document.forms[0].strFldName.value!=document.forms[0].old_strFldName.value)
	{
		temp=temp+"old_strFldName"+"@"; 
		tempname=tempname+"Name of the branch"+"@";
	}
	if(document.forms[0].txt_Issue_Date.value!=document.forms[0].old_txt_Issue_Date.value)
	{
		temp=temp+"old_txt_Issue_Date"+"@"; 
		tempname=tempname+"Date of Issue "+"@";
	}
	if(document.forms[0].txt_accountno.value!=document.forms[0].old_txt_accountno.value)
	{
		temp=temp+"old_txt_accountno"+"@"; 
		tempname=tempname+"Account No"+"@";
	}
	if(document.forms[0].txt_rateintrest.value!=document.forms[0].old_txt_rateintrest.value)
	{
		temp=temp+"old_txt_rateintrest"+"@"; 
		tempname=tempname+"Rate of Interest "+"@";
	}
	if(document.forms[0].txt_Face_PrinciValue.value!=document.forms[0].old_txt_Face_PrinciValue.value)
	{
		temp=temp+"old_txt_Face_PrinciValue"+"@"; 
		tempname=tempname+"Face / Principal Value"+"@";
	}
	if(document.forms[0].txt_Present_BookValue.value!=document.forms[0].old_txt_Present_BookValue.value)
	{
		temp=temp+"old_txt_Present_BookValue"+"@"; 
		tempname=tempname+"Present / Book Value "+"@";
	}
	if(document.forms[0].txt_Maturity_Value.value!=document.forms[0].old_txt_Maturity_Value.value)
	{
		temp=temp+"old_txt_Maturity_Value"+"@"; 
		tempname=tempname+"Maturity Value "+"@";
	}
	if(document.forms[0].txt_Due_Date.value!=document.forms[0].old_txt_Due_Date.value)
	{
		temp=temp+"old_txt_Due_Date"+"@"; 
		tempname=tempname+"Due Date"+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securitiesBankDeposits.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateSecurityBankDeposit";
		document.forms[0].hidBeanGetMethod.value="getSecurityBankDeposit";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
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

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
		showCal(appURL,name);
}

function showOrgSearch(path, forgscode, forgname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
		var title = "Organization";
		var prop = "scrollbars=yes,width=650,height=500,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function selbank()
{
	var varSelectBank=document.forms[0].sel_bank.value;
	if(varSelectBank=="1")
	{
		document.forms[0].strFldName.readOnly=true;
		document.all.img1.style.visibility="visible";
		document.all.img1.style.position="relative";
	}
	else if(varSelectBank=="2")
	{
		document.forms[0].strFldName.readOnly=false;
		document.all.img1.style.visibility="hidden";
	}
	else
	{
		document.forms[0].strFldName.readOnly=false;
		document.all.img1.style.visibility="hidden";
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callLoad()">
	<form method="post" class="normal">
<%if(strPagefrom.equalsIgnoreCase("appl")){
	if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
	if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="204" />
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Securities -&gt; Bank Deposits</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
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
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Securities -&gt; Bank Deposits</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="204" />
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
	<jsp:param name="pageid" value="7" />
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
		<jsp:param name="pageid" value="7" />
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
				<td class="page_flow" colspan="2">Home -&gt; Securities -&gt; Bank Deposits</td>
			</tr>
		</table> 
		<table width="50%" border="0" cellspacing="1" cellpadding="0" 
			class="outertable">
			<tr>
			<td class="sub_tab_inactive" WIDTH="50%" align="center">
				<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
				Security Details</a></b>
			</td>
			<td class="sub_tab_active" align="center"><b>Bank Deposits</b></td>
			</tr>
		</table>
<%}%>
		<table width="98%" border="0" cellpadding="3" cellspacing="0"
			align="center" class="outertable" style="border: 2px solid #dccada;">
			<tr>
				<td align="center">
					<table width="90%" border="0" cellspacing="0" cellpadding="0"
						class="outertable">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="3" cellpadding="3"
									align="center" class="outertable">
									<tr>
											<td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
									</tr>		
									<tr>
										<td width="18%">Bank <span class="mantatory">*&nbsp;</span></td>
										<td width="3%">&nbsp;</td>
										<td width="29%"><select name="sel_bank" tabindex="1"
											onChange="selbank();">
												<option value="0" selected>&lt;----Select----&gt;</option>
												<option value="1">Our Bank</option>
												<option value="2">3rd Party</option>
										</select></td>
										<td width="21%"></td>
										<td width="3%"></td>
										<td width="26%"></td>
									</tr>
									<tr>
										<td>Name of the branch</td>
										<td width="1">&nbsp;</td>
										<td><input type="text" name="strFldName" maxlength="50"
											style="text-align: left" size="40"
											value="<%=Helper.correctNull((String) hshValues.get("sec_branchname"))%>"
											tabindex="2">&nbsp;<input type="hidden"
											name="strFldCode" maxlength="50" style="display: none;"
											size="40"
											value="<%=Helper.correctNull((String) hshValues.get("sec_branchscode"))%>"
											tabindex=""> <img style="cursor: hand" id="img1"
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											onClick="showOrgSearch('<%=ApplicationParams.getAppUrl()%>','strFldCode','strFldName')"
											border="0"></td>
										<td>Date of Issue <span class="mantatory">*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_Issue_Date" size="11"
											value="<%=Helper.correctNull((String) hshValues
					.get("sec_dateofissue"))%>"
											tabindex="3"
											onBlur="checkDate(this);checkmaxdate(this,curdate)"
											maxlength="12"> <a alt="Select date from calender"
											href="#" onClick="callCalender('txt_Issue_Date')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0" alt="Select date from calender" tabindex="29"></a>&nbsp;(dd/mm/yyyy)</td>
									</tr>
									<tr>
										<td>Account No. <span class="mantatory">*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_accountno" size="25"
											maxlength="50" tabindex="4"
											value="<%=Helper.correctNull((String) hshValues.get("sec_accno"))%>">
										</td>
										<td>Rate of Interest ( % )</td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_rateintrest"
											maxlength="6" style="text-align: right" onBlur="roundtxt(this);checkPercentage(this)"
											onKeyPress="allowNumber(this)" size="6"
											value="<%=Helper.correctNull((String) hshValues.get("sec_roi"))%>"
											tabindex="5"></td>
									</tr>
									<tr>
										<td nowrap>Face / Principal Value <span class="mantatory">*&nbsp;</span></td>
										<td><%=ApplicationParams.getCurrency()%></td>
										<td><lapschoice:CurrencyTag name="txt_Face_PrinciValue"
												tabindex="6" size="12" maxlength="12"
												value='<%=Helper.correctNull((String) hshValues
					.get("sec_facevalue"))%>' /></td>
										<td>Present / Book Value <span class="mantatory">*&nbsp;</span></td>
										<td><%=ApplicationParams.getCurrency()%></td>
										<td><lapschoice:CurrencyTag name="txt_Present_BookValue"
												tabindex="7" size="12" maxlength="12"
												value='<%=Helper.correctNull((String) hshValues
					.get("sec_bookvalue"))%>' /></td>
									</tr>
									<tr>
										<td nowrap>Maturity Value <span class="mantatory">*&nbsp;</span></td>
										<td><%=ApplicationParams.getCurrency()%></td>
										<td><lapschoice:CurrencyTag name="txt_Maturity_Value"
												tabindex="8" size="12" maxlength="12"
												value='<%=Helper.correctNull((String) hshValues
					.get("sec_maturityvalue"))%>' /></td>
										<td>Due Date <span class="mantatory">*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_Due_Date" size="11"
											value="<%=Helper.correctNull((String) hshValues
					.get("sec_duedate"))%>"
											tabindex="9"
											onBlur="checkDate(this);checkmindate(this,curdate)"
											maxlength="12"> <a alt="Select date from calender"
											href="#" onClick="callCalender('txt_Due_Date')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0" alt="Select date from calender" tabindex="29"></a>&nbsp;(dd/mm/yyyy)</td>
									</tr>
									<tr>
									</tr>
								</table>
							</td>
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
			btnnames='Edit_Save_Cancel_Delete_Audit Trail'
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

<input type="hidden" name="old_sel_bankText">
<input type="hidden" name="old_strFldName" value="<%=Helper.correctNull((String) hshValues.get("sec_branchname"))%>">
<input type="hidden" name="old_txt_Issue_Date" value="<%=Helper.correctNull((String) hshValues.get("sec_dateofissue"))%>">
<input type="hidden" name="old_txt_accountno" value="<%=Helper.correctNull((String) hshValues.get("sec_accno"))%>" >
<input type="hidden" name="old_txt_rateintrest" value="<%=Helper.correctNull((String) hshValues.get("sec_roi"))%>">
<input type="hidden" name="old_txt_Face_PrinciValue" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_facevalue"))))%>">
<input type="hidden" name="old_txt_Present_BookValue" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_bookvalue"))))%>">
<input type="hidden" name="old_txt_Maturity_Value" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_maturityvalue"))))%>">
<input type="hidden" name="old_txt_Due_Date" value="<%=Helper.correctNull((String) hshValues.get("sec_duedate"))%>">

<input type="hidden" name="sel_bankText">


</form>
</body>
</html>

