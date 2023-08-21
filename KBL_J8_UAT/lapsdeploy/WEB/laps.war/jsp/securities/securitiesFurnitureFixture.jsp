<%@include file="../share/directives.jsp"%>
<%
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));	
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);
			String strProfilestatus = Helper.correctNull((String) hshValues
					.get("strProfilestatus"));
			String tempProfile = "";
			if (strProfilestatus.equalsIgnoreCase("Y")) {
				tempProfile = "Completed";
			} else {
				tempProfile = " Not Completed";
			}
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
			String strCattype=Helper.correctNull(request.getParameter("hidCategoryType"));
			String strappname=Helper.correctNull((String)request.getParameter("txtperapp_fname"));
			if(strappname.equals(""))
			{
				strappname=Helper.correctNull((String)request.getParameter("hidapp_name"));
			}
		//	out.println(hshValues);
		String pageid = Helper.correctNull((String) request.getParameter("pageid"));
		String strEmployment=(String)session.getAttribute("strEmployment");
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

var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
var varcusttype="<%=Helper.correctNull((String)hshValues.get("custtype"))%>";
var varform="<%=Helper.correctNull((String)hshValues.get("form"))%>";
var varaccount="<%=Helper.correctNull((String)hshValues.get("account"))%>";
var varofac="<%=Helper.correctNull((String)hshValues.get("ofac"))%>";
var varremittance="<%=Helper.correctNull((String)hshValues.get("remittance"))%>";
var varsleeppartner="<%=Helper.correctNull((String)hshValues.get("kyc_sleeppartner"))%>";
var varpoliticalexpose="<%=Helper.correctNull((String)hshValues.get("kyc_politicalexposed"))%>";
var varfamilyshare="<%=Helper.correctNull((String)hshValues.get("kyc_familyshare"))%>";
var varcons="<%=Helper.correctNull((String)hshValues.get("perapp_constitution"))%>";
var varstatus="<%=Helper.correctNull((String)hshValues.get("perapp_status"))%>";
var ownership="<%=Helper.correctNull((String)hshValues.get("comapp_ownership"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";
var varBelongsto="<%=Helper.correctNull((String)hshValues.get("SEC_SALUTATION"))%>";

function callLoad()
{
	callDisable(true);
	if(varBelongsto!="")
	{
		document.forms[0].sel_salutation.value=varBelongsto;
		document.forms[0].old_sel_salutationText.value = document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text; 	
	}
	else
	{
		document.forms[0].sel_salutation.value="";
		document.forms[0].old_sel_salutationText.value =""; 
	}
	<%if(grpRights.charAt(18)=='r'){%>
	document.forms[0].cmdedit.disabled=true;
<%}%>

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
}

function callIncomeExpenses()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{	
			if(document.forms[0].hidModuleName.value == 'T'){
				
				document.forms[0].hidBeanGetMethod.value="getIncome";
				document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=T";
				document.forms[0].submit();
				
			}else{
				
				document.forms[0].hidBeanGetMethod.value="getIncome";
				document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
				document.forms[0].submit();
			}
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callDemographics()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			if(document.forms[0].hidModuleName.value=="T")
				document.forms[0].action=appURL+"action/ops_applicant.jsp?applnt=T";
			else
				document.forms[0].action=appURL+"action/perapplicant.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callEmployer()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callDescHelp(id)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appURL+"action/ops_sanctionhelp.jsp?id="+id+"&pagename=kycnorms&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";
		var title = "CBS_DATAS_HELP";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function callDisable(one)
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
	document.all.idsearch.disabled=one;
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

function disableControls(bcmdEdit,bcmdSave,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdSave;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

function doEdit() 
{
	callDisable(false);
	disableControls(true,false,false,false,true);
	document.forms[0].hidAction.value="update";
	document.forms[0].txt_locationcountry.readOnly=true;
	document.forms[0].txt_locationdistrict.readOnly=true;
	document.forms[0].txt_locationstate.readOnly=true;
	document.forms[0].txt_locationcity.readOnly=true;
	document.forms[0].txt_cbscustid.readOnly=true;
	if(document.forms[0].txt_cbscustid.value!=""){
		document.forms[0].sel_salutation.disabled=true;
		document.forms[0].txt_belongsto.readOnly=true;
		document.forms[0].txt_surveyno.readOnly=true;
		document.forms[0].txt_add1.readOnly=true;
		document.forms[0].txt_add2.readOnly=true;
	}

}

function doSave()
{
	document.forms[0].hidsalutation.value=document.forms[0].sel_salutation.value;
	if(trim(document.forms[0].txt_natureasset.value) == "")
	{
		document.forms[0].txt_natureasset.value="";
		ShowAlert('121','Nature of Asset');
		document.forms[0].txt_natureasset.focus();
		return;
	}
	if(document.forms[0].txt_purchseinvceval.value == "" ||
			document.forms[0].txt_purchseinvceval.value == "0.00")
	{
		document.forms[0].txt_purchseinvceval.value="";
		ShowAlert('121','Purchase/Invoice Value');
		document.forms[0].txt_purchseinvceval.focus();
		return;
	}
	if(document.forms[0].txt_presentbookvalue.value == "" ||
			document.forms[0].txt_presentbookvalue.value == "0.00")
	{
		document.forms[0].txt_presentbookvalue.value="";
		ShowAlert('121','Present/Book Value');
		document.forms[0].txt_presentbookvalue.focus();
		return;
	}
	if(document.forms[0].txt_valuepervaluate.value == "" ||
			document.forms[0].txt_valuepervaluate.value == "0.00")
	{
		document.forms[0].txt_valuepervaluate.value="";
		ShowAlert('121','Value as per Valuation');
		document.forms[0].txt_valuepervaluate.focus();
		return;
	}
	if(trim(document.forms[0].txt_natureasset.value) == "")
	{
		document.forms[0].txt_natureasset.value="";
		ShowAlert('121','Nature of Asset');
		document.forms[0].txt_natureasset.focus();
		return;
	}
	if(document.forms[0].sel_salutation.value == "")
	{
		ShowAlert('111','Salutation Type');
		document.forms[0].sel_salutation.focus();
		return;
	}
	if(document.forms[0].txt_belongsto.value == "")
	{
		ShowAlert('121','Name');
		document.forms[0].txt_belongsto.focus();
		return;
	}
	if(document.forms[0].txt_surveyno.value == "")
	{
		ShowAlert('121','Survey Number');
		document.forms[0].txt_surveyno.focus();
		return;
	}
	if(document.forms[0].txt_add1.value == "")
	{
		ShowAlert('121','Address');
		document.forms[0].txt_add1.focus();
		return;
	}
	if(document.forms[0].txt_add2.value == "")
	{
		ShowAlert('121','Address');
		document.forms[0].txt_add2.focus();
		return;
	}
	if(document.forms[0].txt_locationcity.value == "")
	{
		ShowAlert('111','City');
		document.forms[0].txt_locationcity.focus();
		return;
	}
	
	if(document.forms[0].txt_locationdistrict.value == "")
	{
		ShowAlert('111','District');
		document.forms[0].txt_locationdistrict.focus();
		return;
	}
	if(document.forms[0].txt_locationstate.value == "")
	{
		ShowAlert('111','State');
		document.forms[0].txt_locationstate.focus();
		return;
	}
	if(document.forms[0].txt_locationcountry.value == "")
	{
		ShowAlert('111','Country');
		document.forms[0].txt_locationcountry.focus();
		return;
	}
	if(document.forms[0].txt_pincode.value == "")
	{
		ShowAlert('121','Pincode');
		document.forms[0].txt_pincode.focus();
		return;
	}
	
	modifyCheck();
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/securitiesFurnitureFixture.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateFurnitures";
	document.forms[0].hidBeanGetMethod.value="getFurnitures";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}	

function modifyCheck()
{
	var temp="";
	var tempname="";
	document.forms[0].sel_salutationText.value=document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text;
	
	if(document.forms[0].txt_natureasset.value!=document.forms[0].old_txt_natureasset.value)
	{
		temp=temp+"old_txt_natureasset"+"@"; 		tempname=tempname+"Nature of Asset "+"@";
	}
	if(document.forms[0].txt_make.value!=document.forms[0].old_txt_make.value)
	{
		temp=temp+"old_txt_make"+"@"; 		tempname=tempname+"Make "+"@";
	}
	if(document.forms[0].txt_model.value!=document.forms[0].old_txt_model.value)
	{
		temp=temp+"old_txt_model"+"@"; 		tempname=tempname+"Model"+"@";
	}
	if(document.forms[0].txt_yearmanufacture.value!=document.forms[0].old_txt_yearmanufacture.value)
	{
		temp=temp+"old_txt_yearmanufacture"+"@"; 		tempname=tempname+"Year of Manufacture"+"@";
	}
	if(document.forms[0].txt_purchseinvceval.value!=document.forms[0].old_txt_purchseinvceval.value)
	{
		temp=temp+"old_txt_purchseinvceval"+"@"; 		tempname=tempname+"Purchase/Invoice Value"+"@";
	}
	if(document.forms[0].txt_presentbookvalue.value!=document.forms[0].old_txt_presentbookvalue.value)
	{
		temp=temp+"old_txt_presentbookvalue"+"@"; 		tempname=tempname+"Present/Book Value "+"@";
	}
	if(document.forms[0].txt_valuepervaluate.value!=document.forms[0].old_txt_valuepervaluate.value)
	{
		temp=temp+"old_txt_valuepervaluate"+"@"; 		tempname=tempname+"Value as per Valuation"+"@";
	}
	if(document.forms[0].txt_belongsto.value!=document.forms[0].old_txt_belongsto.value)
	{
		temp=temp+"old_txt_belongsto"+"@"; 		tempname=tempname+"Dealer name"+"@";
	}
	if(document.forms[0].txt_surveyno.value!=document.forms[0].old_txt_surveyno.value)
	{
		temp=temp+"old_txt_surveyno"+"@"; 		tempname=tempname+"Survey No"+"@";
	}
	if(document.forms[0].txt_pincode.value!=document.forms[0].old_txt_pincode.value)
	{
		temp=temp+"old_txt_pincode"+"@"; 		tempname=tempname+"Pin Code"+"@";
	}
	if(document.forms[0].txt_add1.value!=document.forms[0].old_txt_add1.value)
	{
		temp=temp+"old_txt_add1"+"@"; 		tempname=tempname+"Address line 1"+"@";
	}
	if(document.forms[0].txt_add2.value!=document.forms[0].old_txt_add2.value)
	{
		temp=temp+"old_txt_add2"+"@"; 		tempname=tempname+"Address line 2"+"@";
	}
	if(document.forms[0].txt_locationcity.value!=document.forms[0].old_txt_locationcity.value)
	{
		temp=temp+"old_txt_locationcity"+"@"; 		tempname=tempname+"City"+"@";
	}
	if(document.forms[0].txt_locationdistrict.value!=document.forms[0].old_txt_locationdistrict.value)
	{
		temp=temp+"old_txt_locationdistrict"+"@"; 		tempname=tempname+"District"+"@";
	}
	if(document.forms[0].txt_locationstate.value!=document.forms[0].old_txt_locationstate.value)
	{
		temp=temp+"old_txt_locationstate"+"@"; 		tempname=tempname+"State"+"@";
	}
	if(document.forms[0].txt_locationcountry.value!=document.forms[0].old_txt_locationcountry.value)
	{
		temp=temp+"old_txt_locationcountry"+"@"; 		tempname=tempname+"Country"+"@";
	}
	if(document.forms[0].sel_salutationText.value!=document.forms[0].old_sel_salutationText.value)
	{
		temp=temp+"old_sel_salutationText"+"@"; 		tempname=tempname+"Salutation Type "+"@";
	}
	
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
}
function doClose()
{
	if (ConfirmMsg(100)) 
	{
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanGetMethod.value="getFurnitures";
		document.forms[0].action=appURL+"action/securitiesFurnitureFixture.jsp";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securitiesFurnitureFixture.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateFurnitures";
		document.forms[0].hidBeanGetMethod.value="getFurnitures";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function showCitySearch1(val1) {
	if (val1 == "FURN") {
		if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_cbscustid.value =="") {
			var varQryString = appURL + "action/searchCity.jsp?mis=" + val1;
			var title = "City";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString, title, prop);
		}
	}
}
function callDistrict1() {
	
	var varstate = document.forms[0].hid_locationstate.value;
	if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_cbscustid.value =="") {
		if (document.forms[0].txt_locationcity.value == "") {
			ShowAlert(112, "City");
			document.forms[0].txt_locationcity.focus();
			return;
		}
		if (document.forms[0].hid_locationstate.value == "") {
			alert("Please Reselect the City");
			document.forms[0].txt_locationcity.focus();
			return;
		} else {
			var varQryString = appURL+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+ varstate + "&code=FURN";
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
			prop = prop + ",left=200,top=200";
			window.open(varQryString, title, prop);
		}
	}
}
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].txt_cbscustid.value =="")
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
	}
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?&pagename=sec_furniture";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callLoad()">
<form method="post" class="normal">
<%if(strPagefrom.equalsIgnoreCase("appl")){
	if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
	if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="210" />
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Furniture & Fixtures</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="20" />
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
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt;  Furniture & Fixtures</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="210" />
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
	<jsp:param name="pageid" value="20" />
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
		<jsp:param name="pageid" value="<%=pageid %>" />
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
		<td class="page_flow">Home -&gt; Securities -&gt; Furniture & Fixtures</td>
	</tr>
	
</table>
<table width="50%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="sub_tab_inactive_new" WIDTH="50%" align="center">
			<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
			Security Details</a></b>
		</td>
		<td class="sub_tab_active_new" align="center"><b>Furniture & Fixtures</b></td>
	</tr>
</table>
<%} %>
<table width="98%" border="0" cellpadding="3" cellspacing="0"
			align="center" class="outertable" style="border: 2px solid #dccada;">
	<tr>
		<td>
				<table width="95%" border="0" cellspacing="3" cellpadding="3" align="center" class="outertable">
				<tr>
					<td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
				</tr>
				<tr>
                  <td width="21%">Nature of Asset <b><span class="mantatory">*&nbsp;</span></b></td>
						
                  <td width="29%" nowrap> 
                    <input type="text"
							name="txt_natureasset" size="30" maxlength="50"
							value="<%=Helper.correctNull((String)hshValues.get("txt_natureasset"))%>">
						</td>

						
                  <td width="21%">Make & Model</td>

						
                  <td width="29%">
							<input type="text" name="txt_make" size="10" maxlength="50"
							value="<%=Helper.correctNull((String) hshValues.get("txt_make"))%>">&nbsp;
							<input type="text" name="txt_model" size="10" maxlength="20"
							value="<%=Helper.correctNull((String) hshValues.get("txt_model"))%>"></td>
					</tr>
					
					<tr>	
						
                  <td>Year of Manufacture</td>
						
                  <td> 
                    <input type="text" name="txt_yearmanufacture"
							size="8" value="<%=Helper.correctNull((String)hshValues.get("txt_yearmanufacture"))%>" 
							maxlength="4" onKeyPress="allowNumber(this)" onblur="checkcurrentyear(this)">
						</td>
						
						
						
                  <td>Purchase/Invoice Value <b><span class="mantatory">*&nbsp;</span></b></td>
						
                  <td>
		<lapschoice:CurrencyTag name="txt_purchseinvceval" maxlength="10"  style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
							size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_purchseinvceval"))%>'/>
							</td>
					</tr>
					<tr>
						
                  <td>Present/Book Value Rs. <b><span class="mantatory">*&nbsp;</span></b></td>
						
                  <td> 
                   <lapschoice:CurrencyTag name="txt_presentbookvalue"
							size="15" maxlength="10" style="text-align: right" onKeyPress="allowNumber(this)"	onBlur="roundtxt(this);"
							value='<%=Helper.correctNull((String)hshValues.get("txt_presentbookvalue"))%>'/>
						</td>
						
                  <td >Value as per Valuation<b><span class="mantatory">*&nbsp;</span></b></td>
						
                  <td>
			<lapschoice:CurrencyTag name="txt_valuepervaluate"
							size="15" maxlength="10" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
							value='<%=Helper.correctNull((String)hshValues.get("txt_valuepervaluate"))%>'/>
						</td>
					</tr>
					<tr>
						<td colspan="6" class="dataheader">Location Details</td>
					</tr>
					<tr>
					<td width="13%" >CBS Cust ID</td>
				<td id="idsearch" width="34%" ><input type="text"
					name="txt_cbscustid" size="12" maxlength="10" readonly="readonly"
					value="<%=Helper.correctNull((String)hshValues.get("sec_cbsid"))%>">
				<b><span onClick="javascript:callDescCBS()" style="cursor: hand" ><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>
					</tr>
					<tr>
						<td>Belonging to<span class="mantatory">&nbsp;*&nbsp;</span></td>
						<td><select name="sel_salutation" style="width:35%">
						<option value="">---Select-----</option>
						<%
							String apptypecon = "1";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
						</select>&nbsp;&nbsp;
						
  						 
  						   <input type="text" name="txt_belongsto" maxlength="20" value='<%=Helper.correctNull((String)hshValues.get("SEC_SALUTATION_NAME"))%>'/ ></td>
  						
  						<td>Survey No<span class="mantatory">&nbsp;*&nbsp;</span></td><td><input type="text" name="txt_surveyno" size="25" maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("SEC_SURVEYNO"))%>'/></td>
  				   </tr>
  				   
  				   <tr>
	  				   <td valign="top">Address<span class="mantatory">&nbsp;*&nbsp;</span></td>
	  				   <td><input type="text" name="txt_add1" size="25" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("SEC_ADDRESS1"))%>'/></td>
	  				   <td>City<span class="mantatory">&nbsp;*&nbsp;</span></td>
	  				   <td><input type="text" name="txt_locationcity" tabindex="15" 
											size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercity"))%>" >
											<input type="hidden" name="hid_locationcity" value="<%=Helper.correctNull((String)hshValues.get("SEC_CITY"))%>" > &nbsp;  <a href="#" onClick="showCitySearch1('FURN');" style="cursor: hand" tabindex="13">
											<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
											</a></td>
  				   </tr>
  				   <tr>
	  				   <td>&nbsp;</td>
	  				   <td><input type="text" name="txt_add2" size="25" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("SEC_ADDRESS2"))%>'/></td>
	  				   <td>&nbsp;</td>
	  				   <td>&nbsp;</td>
  				   </tr>
  				   
  				   <tr>
  				   <td>District<span class="mantatory">&nbsp;*&nbsp;</span></td>
  				   <td><input type="text" name="txt_locationdistrict" tabindex="13" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerdistrict"))%>" >
										<input type="hidden" name="hid_locationdistrict" value="<%=Helper.correctNull((String)hshValues.get("SEC_DISTRICT"))%>" > &nbsp; <a href="#" onClick="callDistrict1();" style="cursor: hand" tabindex="14">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
  				   <td>State<span class="mantatory">&nbsp;*&nbsp;</span></td>
  				   <td><input type="text" name="txt_locationstate" tabindex="16" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerstate"))%>" >
										<input type="hidden" name="hid_locationstate" value="<%=Helper.correctNull((String)hshValues.get("SEC_STATE"))%>" > &nbsp; </td>
  				   </tr>
  				   
  				   
  				   <tr>
  				   <td>Pin Code<span class="mantatory">&nbsp;*&nbsp;</span></td>
  				   <td><input type="text" name="txt_pincode" maxlength="6" size="25" value='<%=Helper.correctNull((String)hshValues.get("SEC_PINCODE"))%>'/></td>
  				   <td>Country<span class="mantatory">&nbsp;*&nbsp;</span></td>
  				   <td><input type="text" name="txt_locationcountry" tabindex="17" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercountry"))%>" >
										<input type="hidden" name="hid_locationcountry" value="<%=Helper.correctNull((String)hshValues.get("SEC_COUNTRY"))%>" > &nbsp; <a href="#"
										onClick="callCntrySearch('txt_locationcountry','hid_locationcountry')"
										style="cursor:hand" tabindex="8"><img
										src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
										border="0" tabindex="21"></a> </td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<%} %>
<br>
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

<input type="hidden" name="old_txt_natureasset" value="<%=Helper.correctNull((String) hshValues.get("txt_natureasset"))%>">
<input type="hidden" name="old_txt_make" value="<%=Helper.correctNull((String) hshValues.get("txt_make"))%>">
<input type="hidden" name="old_txt_model" value="<%=Helper.correctNull((String) hshValues.get("txt_model"))%>">
<input type="hidden" name="old_txt_yearmanufacture" value="<%=Helper.correctNull((String) hshValues.get("txt_yearmanufacture"))%>">
<input type="hidden" name="old_txt_purchseinvceval" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_purchseinvceval"))))%>">
<input type="hidden" name="old_txt_presentbookvalue" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_presentbookvalue"))))%>">
<input type="hidden" name="old_txt_valuepervaluate" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_valuepervaluate"))))%>">

<input type="hidden" name="old_txt_belongsto" value="<%=Helper.correctNull((String) hshValues.get("SEC_SALUTATION_NAME"))%>">
<input type="hidden" name="old_txt_surveyno" value="<%=Helper.correctNull((String) hshValues.get("SEC_SURVEYNO"))%>">
<input type="hidden" name="old_txt_pincode" value="<%=Helper.correctNull((String) hshValues.get("SEC_PINCODE"))%>">
<input type="hidden" name="old_txt_add1" value="<%=Helper.correctNull((String) hshValues.get("SEC_ADDRESS1"))%>">
<input type="hidden" name="old_txt_add2" value="<%=Helper.correctNull((String) hshValues.get("SEC_ADDRESS2"))%>">
<input type="hidden" name="old_txt_locationcity" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercity"))%>">
<input type="hidden" name="old_txt_locationdistrict" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerdistrict"))%>">
<input type="hidden" name="old_txt_locationstate" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerstate"))%>">
<input type="hidden" name="old_txt_locationcountry" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercountry"))%>">

<input type="hidden" name="old_sel_salutationText" value="<%=Helper.correctNull((String) hshValues.get("SEC_SALUTATION"))%>">
<input type="hidden" name="sel_salutationText">
<input type="hidden" name="hidsalutation">
</form>
</body>
</html>


