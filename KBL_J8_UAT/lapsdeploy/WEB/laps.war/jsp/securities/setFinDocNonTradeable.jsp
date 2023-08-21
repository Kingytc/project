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
<title>Financial Documents &ndash; Non Tradeable</title>
</head>
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var sel_Instru_Rated = "<%=Helper.correctNull((String)hshValues.get("sec_rated"))%>";
var sel_Issued_By = "<%=Helper.correctNull((String)hshValues.get("sec_issuedby"))%>";
var sel_Currency_Type = "<%=Helper.correctNull((String)hshValues.get("sec_currencytype"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";

function callOnload()
{
	if(sel_Instru_Rated!="" && sel_Issued_By!="0" )
	{
		document.forms[0].sel_Instru_Rated.value=sel_Instru_Rated;
		document.forms[0].old_sel_Instru_RatedText.value = document.forms[0].sel_Instru_Rated.options[document.forms[0].sel_Instru_Rated.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_Instru_Rated.value="0";
		document.forms[0].old_sel_Instru_RatedText.value = ""; 
	}
	if(sel_Issued_By!="" && sel_Issued_By!="0")
	{
		document.forms[0].sel_Issued_By.value=sel_Issued_By;
		document.forms[0].old_sel_Issued_ByText.value = document.forms[0].sel_Issued_By.options[document.forms[0].sel_Issued_By.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_Issued_By.value="0";
		document.forms[0].old_sel_Issued_ByText.value =""; 
	}
	if(sel_Currency_Type!="" && sel_Issued_By!="0")
	{
		document.forms[0].sel_Currency_Type.value=sel_Currency_Type;
		document.forms[0].old_sel_Currency_TypeText.value = document.forms[0].sel_Currency_Type.options[document.forms[0].sel_Currency_Type.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_Currency_Type.value="0";
		document.forms[0].old_sel_Currency_TypeText.value = ""; 
	}
	calldisable(true);
	ToggleRating();
	Toggle_IssuedBy();
	<%if(grpRights.charAt(18)=='r'){%>
	document.forms[0].cmdedit.disabled=true;
<%}%>

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
}
function showAgency(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchagencylist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&hidvalue=agency&yeartype="+val;
		var title = "Agencylist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function showSymbol(val,val1)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(val1 == "P")
		{
			if(document.forms[0].txt_pre_agency.value != "")
			{
				var agency = document.forms[0].txt_pre_agency.value;
			}
			else
			{
				alert("Please select previous year Agency Name");
				return;
			}
		}
		else if(val1 == "C")
		{
			if(document.forms[0].txt_cur_agency.value != "")
			{
				var agency = document.forms[0].txt_cur_agency.value;
			}
			else
			{
				alert("Please select current year Agency Name");
				return;
			}
		}
		var type = val;
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchsymbollist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&agency="+agency+"&type="+type+"&yeartype="+val1+"&hidvalue=symbol";
		var title = "Symbollist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
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
function ToggleRating()
{
	if(document.forms[0].sel_Instru_Rated.value=="1")
	{
		document.all.rating.style.display="block";
	}
	else
	{
		document.all.rating.style.display="none";
		document.forms[0].txt_pre_agency.value="";
		document.forms[0].txt_pre_longsymbol.value="";
	}
}
function Toggle_IssuedBy()
{
	if(document.forms[0].sel_Issued_By.value=="004")
	{
		document.all.IssuedOthers1.style.display="block";
		document.all.IssuedOthers2.style.display="block";
		document.all.IssuedOthers3.style.display="block";
	}
	else 
	{
		document.all.IssuedOthers1.style.display="none";
		document.all.IssuedOthers2.style.display="none";
		document.all.IssuedOthers3.style.display="none";
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";	
		document.forms[0].hidBeanGetMethod.value="getFinDocNonTradeable";
		document.forms[0].action=appURL+"action/setFinDocNonTradeable.jsp";	
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

function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
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
	if(trim(document.forms[0].txt_policy_certi_no.value)=="")
	{
		document.forms[0].txt_policy_certi_no.value="";
		alert("Enter Policy / Certificate No");
		document.forms[0].txt_policy_certi_no.focus();
		return;
	}
	if(trim(document.forms[0].txt_Face_Value.value)=="" ||
			trim(document.forms[0].txt_Face_Value.value)=="0.00")
	{
		document.forms[0].txt_Face_Value.value="";
		alert("Enter Face Value");
		document.forms[0].txt_Face_Value.focus();
		return;
	}
	if(trim(document.forms[0].txt_Book_Surr_Value.value)=="" ||
			trim(document.forms[0].txt_Book_Surr_Value.value)=="0.00")
	{
		document.forms[0].txt_Book_Surr_Value.value="";
		alert("Enter Book / Surrender Value");
		document.forms[0].txt_Book_Surr_Value.focus();
		return;
	}
	if(trim(document.forms[0].txt_Matu_Assu_Value.value)=="" ||
			trim(document.forms[0].txt_Matu_Assu_Value.value)=="0.00")
	{
		document.forms[0].txt_Matu_Assu_Value.value="";
		alert("Enter Maturity / Assured Value");
		document.forms[0].txt_Matu_Assu_Value.focus();
		return;
	}
	
	if(trim(document.forms[0].sel_Issued_By.value)=="0")
	{
		document.forms[0].sel_Issued_By.value="0";
		alert("Select Issued by");
		document.forms[0].sel_Issued_By.focus();
		return;
	}
	if(trim(document.forms[0].txt_Due_Matu_Date.value)=="")
	{
		document.forms[0].txt_Due_Matu_Date.value="";
		alert("Enter Due / Maturity Date");
		document.forms[0].txt_Due_Matu_Date.focus();
		return;
	}

	modifyCheck();

	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/setFinDocNonTradeable.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateFinDocNonTradeable";
	document.forms[0].hidBeanGetMethod.value="getFinDocNonTradeable";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{
	var temp="";
	var tempname="";

	if(document.forms[0].sel_Instru_Rated.value=="0")
		document.forms[0].sel_Instru_RatedText.value="";
	else
		document.forms[0].sel_Instru_RatedText.value=document.forms[0].sel_Instru_Rated.options[document.forms[0].sel_Instru_Rated.selectedIndex].text;

	if(document.forms[0].sel_Issued_By.value=="0")
		document.forms[0].sel_Issued_ByText.value="";
	else
		document.forms[0].sel_Issued_ByText.value=document.forms[0].sel_Issued_By.options[document.forms[0].sel_Issued_By.selectedIndex].text;

	if(document.forms[0].sel_Currency_Type.value=="0")
		document.forms[0].sel_Currency_TypeText.value="";
	else
		document.forms[0].sel_Currency_TypeText.value=document.forms[0].sel_Currency_Type.options[document.forms[0].sel_Currency_Type.selectedIndex].text;
	
	if(document.forms[0].sel_Instru_RatedText.value!=document.forms[0].old_sel_Instru_RatedText.value)
	{
		temp=temp+"old_sel_Instru_RatedText"+"@"; 
		tempname=tempname+"Whether the instrument is rated"+"@";
	}
	if(document.forms[0].sel_Issued_ByText.value!=document.forms[0].old_sel_Issued_ByText.value)
	{
		temp=temp+"old_sel_Issued_ByText"+"@"; 
		tempname=tempname+"Issued by "+"@";
	}
	if(document.forms[0].sel_Currency_TypeText.value!=document.forms[0].old_sel_Currency_TypeText.value)
	{
		temp=temp+"old_sel_Currency_TypeText"+"@"; 
		tempname=tempname+"Currency Type"+"@";
	}
	if(document.forms[0].txt_pre_agency.value!=document.forms[0].old_txt_pre_agency.value)
	{
		temp=temp+"old_txt_pre_agency"+"@"; 
		tempname=tempname+"Rating Agency"+"@";
	}
	if(document.forms[0].txt_pre_longsymbol.value!=document.forms[0].old_txt_pre_longsymbol.value)
	{
		temp=temp+"old_txt_pre_longsymbol"+"@"; 
		tempname=tempname+"Rating Symbol"+"@";
	}
	if(document.forms[0].txt_policy_certi_no.value!=document.forms[0].old_txt_policy_certi_no.value)
	{
		temp=temp+"old_txt_policy_certi_no"+"@"; 
		tempname=tempname+"Policy Certificate No "+"@";
	}
	if(document.forms[0].txt_date.value!=document.forms[0].old_txt_date.value)
	{
		temp=temp+"old_txt_date"+"@"; 
		tempname=tempname+"Date"+"@";
	}
	if(document.forms[0].txt_Other_Specify.value!=document.forms[0].old_txt_Other_Specify.value)
	{
		temp=temp+"old_txt_Other_Specify"+"@"; 
		tempname=tempname+"Other Specify"+"@";
	}
	if(document.forms[0].txt_Face_Value.value!=document.forms[0].old_txt_Face_Value.value)
	{
		temp=temp+"old_txt_Face_Value"+"@"; 
		tempname=tempname+"Face Value"+"@";
	}
	if(document.forms[0].txt_Book_Surr_Value.value!=document.forms[0].old_txt_Book_Surr_Value.value)
	{
		temp=temp+"old_txt_Book_Surr_Value"+"@"; 
		tempname=tempname+"Book / Surrender Value "+"@";
	}
	if(document.forms[0].txt_Matu_Assu_Value.value!=document.forms[0].old_txt_Matu_Assu_Value.value)
	{
		temp=temp+"old_txt_Matu_Assu_Value"+"@"; 
		tempname=tempname+"Maturity / Assured Value"+"@";
	}
	if(document.forms[0].txt_Due_Matu_Date.value!=document.forms[0].old_txt_Due_Matu_Date.value)
	{
		temp=temp+"old_txt_Due_Matu_Date"+"@"; 
		tempname=tempname+"Due / Maturity Date "+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/setFinDocNonTradeable.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateFinDocNonTradeable";
		document.forms[0].hidBeanGetMethod.value="getFinDocNonTradeable";
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
				<jsp:param name="subpageid" value="202" />
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Non Tradeable</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="5" />
		</jsp:include>
		</td>
	</tr>
</table>
<%}else if(strSessionModuleType.equalsIgnoreCase("RET")){
	if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
<jsp:param name="pageid" value="<%=pageid%>" />
</jsp:include>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt;  Financial Documents &ndash; Non Tradeable</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td valign="top">
<jsp:include page="../set/appurlsectabs.jsp" flush="true">
	<jsp:param name="pageid" value="5" />
</jsp:include>
</td>
</tr>
</table>
<%
} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="202" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}
}}else if(strPagefrom.equals("secmailbox")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="5" />
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
			<td class="page_flow" colspan="2">Home -&gt; Securities -&gt; Financial Documents &ndash; Non Tradeable</td>
		</tr>
		</table> 
		<table width="50%" border="0" cellspacing="1" cellpadding="0" align="center"
			class="outertable">
			<tr>
			<td  WIDTH="50%" nowrap="nowrap" class="sub_tab_inactive" align="center">
				<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
				Security Details</a></b>
			</td>
			<td class="sub_tab_active" align="center"><b>Financial Documents &ndash; Non Tradeable or Non Transferable</b></td>
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
							<td width="20%" nowrap="nowrap">Whether the instrument is rated</td>
							<td width="5%">&nbsp;</td>
							<td width="25%"><select name="sel_Instru_Rated" id="sel_Instru_Rated" onChange="ToggleRating()" tabindex="1">
									<option value="0" selected>&lt;---Select---&gt;</option>
									<option value="1">Yes</option>
									<option value="2">No</option>
							</select></td>
							<td width="10%">&nbsp;</td>
							<td width="5%">&nbsp;</td>
							<td width="35%">&nbsp;</td>
						</tr>
						<tr id="rating">
							<td>Rating Agency</td>
							<td>&nbsp;</td>
							<td><input type="text" name="txt_pre_agency" size="35" tabindex="2"
								value="<%=Helper.correctNull((String)hshValues.get("sec_agency"))%>"> <b><span onClick="showAgency('P');"
									style="cursor: hand"><font size="1" face="MS Sans Serif"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></font></span></b>&nbsp;</td>

							<td>Rating Symbol &nbsp;</td>
							<td>&nbsp;</td>
							<td><input type="text" name="txt_pre_longsymbol" tabindex="3"
								size="35" value="<%=Helper.correctNull((String)hshValues.get("sec_symbol"))%>"> <b><span
									onClick="showSymbol('L','P');" style="cursor: hand"><font
										size="1" face="MS Sans Serif"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></font></span></b>&nbsp;</td>
						</tr>

						<tr>
							<td nowrap="nowrap">Policy / Certificate No <span class="mantatory">*&nbsp;</span></td>
							<td>&nbsp;</td>
							<td><input type="text" name="txt_policy_certi_no" size="30" tabindex="4"
								maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("sec_policyno"))%>" /></td>
							<td>Date</td>
							<td>&nbsp;</td>
							<td><input type="text" name="txt_date" tabindex="5"
								size="11" value="<%=Helper.correctNull((String)hshValues.get("sec_policydate"))%>"
								onBlur="checkDate(this);checkmaxdate(this,curdate)"
								maxlength="12"> <a alt="Select date from calender" style=""
								href="#" onClick="callCalender('txt_date')"
								onMouseOver="window.status='Date Picker';return true;"
								onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0" alt="Select date from calender" tabindex="29"></a>(dd/mm/yyyy)</td>
						</tr>
						<tr>
							<td nowrap="nowrap">Issued by <span class="mantatory">*&nbsp;</span></td>
							<td>&nbsp;</td>
							<td><select name="sel_Issued_By" id="sel_Issued_By" onChange="Toggle_IssuedBy()" tabindex="6">
                              <option value="0" selected>&lt;---Select---&gt;</option>
                              <lapschoice:StaticDataNewTag apptype="117" />
                            </select></td>
							<td id="IssuedOthers1">Specify</td>
							<td id="IssuedOthers2">&nbsp;</td>
							<td id="IssuedOthers3"><input name="txt_Other_Specify" type="text" id="txt_Other_Specify" 
							value="<%=Helper.correctNull((String)hshValues.get("sec_specify"))%>" tabindex="7"
								size="30" maxlength="30" /></td>
						</tr>
						<tr>
							<td nowrap="nowrap">Currency Type</td>
							<td>&nbsp;</td>
							<td><select name="sel_Currency_Type" id="sel_Currency_Type" onChange="" tabindex="8">
                              <option value="0" selected>&lt;---Select---&gt;</option>
                              <lapschoice:StaticDataNewTag apptype="118" />
                            </select></td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td colspan="2">&nbsp;</td>
						</tr>
						<tr>
						  <td nowrap="nowrap">Face Value <span class="mantatory">*&nbsp;</span></td>
						  <td align="right"><%=ApplicationParams.getCurrency()%></td>
						  <td><lapschoice:CurrencyTag
						  		name="txt_Face_Value" tabindex="9" size="12" maxlength="12" 
								value='<%=Helper.correctNull((String)hshValues.get("sec_facevalue"))%>'/>
						  </td>
						  <td nowrap="nowrap">Book / Surrender Value <span class="mantatory">*&nbsp;</span></td>
						  <td align="right"><%=ApplicationParams.getCurrency()%>
						  <td ><lapschoice:CurrencyTag
						  		name="txt_Book_Surr_Value" tabindex="10" size="12" maxlength="12" 
								value='<%=Helper.correctNull((String)hshValues.get("sec_surrendervalue"))%>'/></td>
					  </tr>
						<tr>
						  <td nowrap="nowrap">Maturity / Assured Value <span class="mantatory">*&nbsp;</span></td>
						  <td align="right"><%=ApplicationParams.getCurrency()%>
						  <td><lapschoice:CurrencyTag
						  		name="txt_Matu_Assu_Value" tabindex="11" size="12" maxlength="12" 
								value='<%=Helper.correctNull((String)hshValues.get("sec_maturityvalue"))%>'/></td>
						  <td>Due / Maturity Date <span class="mantatory">*&nbsp;</span></td>
						  <td >&nbsp;</td>
						  <td><input type="text" name="txt_Due_Matu_Date"
								size="11" value="<%=Helper.correctNull((String)hshValues.get("sec_maturitydate"))%>" tabindex="12"
								onBlur="checkDate(this);checkmindate(this,curdate)"
								maxlength="12"> <a alt="Select date from calender"
								href="#" onClick="callCalender('txt_Due_Matu_Date')"
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
				<%}%>
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

<input type="hidden" name="old_sel_Instru_RatedText">
<input type="hidden" name="old_txt_pre_agency" value="<%=Helper.correctNull((String)hshValues.get("sec_agency"))%>">
<input type="hidden" name="old_txt_pre_longsymbol" value="<%=Helper.correctNull((String)hshValues.get("sec_symbol"))%>">
<input type="hidden" name="old_txt_policy_certi_no"  value="<%=Helper.correctNull((String)hshValues.get("sec_policyno"))%>">
<input type="hidden" name="old_txt_date" value="<%=Helper.correctNull((String)hshValues.get("sec_policydate"))%>">
<input type="hidden" name="old_sel_Issued_ByText">
<input type="hidden" name="old_txt_Other_Specify" value="<%=Helper.correctNull((String)hshValues.get("sec_specify"))%>">
<input type="hidden" name="old_sel_Currency_TypeText">
<input type="hidden" name="old_txt_Face_Value" value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_facevalue"))))%>'>
<input type="hidden" name="old_txt_Book_Surr_Value" value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_surrendervalue"))))%>'>
<input type="hidden" name="old_txt_Matu_Assu_Value" value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sec_maturityvalue"))))%>'>
<input type="hidden" name="old_txt_Due_Matu_Date" value='<%=Helper.correctNull((String)hshValues.get("sec_maturitydate"))%>'>


<input type="hidden" name="sel_Instru_RatedText">
<input type="hidden" name="sel_Issued_ByText">
<input type="hidden" name="sel_Currency_TypeText">


	</form>
</body>
</html>