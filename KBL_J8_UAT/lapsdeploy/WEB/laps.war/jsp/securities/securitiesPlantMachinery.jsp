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
		//	out.println(strProfilestatus);
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
var varworkcondition="<%=Helper.correctNull((String)hshValues.get("sel_workcondition"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";
var varTypevalue="<%=Helper.correctNull((String)hshValues.get("SEC_MACHINERY_TYPE"))%>";
var varBelongsTo="<%=Helper.correctNull((String)hshValues.get("SEC_MACHINERY_BELONGS"))%>";

function callLoad()
{
	callDisable(true);
	if(varBelongsTo!="")
	{
		document.forms[0].sel_salutation.value=varBelongsTo;
		document.forms[0].old_sel_salutationText.value = document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text; 	
	}
	else
	{
		document.forms[0].sel_salutation.value="";
		document.forms[0].old_sel_salutationText.value =""; 
	}
	
	if(varworkcondition!="" && varworkcondition!="0")
	{
		document.forms[0].sel_workcondition.value=varworkcondition;
		document.forms[0].old_sel_workconditionText.value = document.forms[0].sel_workcondition.options[document.forms[0].sel_workcondition.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_workcondition.value="";
		document.forms[0].old_sel_workconditionText.value =""; 
	}
	if(varTypevalue!="" && varTypevalue!="0")
	{		
		document.forms[0].sel_type.value=varTypevalue;
		document.forms[0].old_sel_typeText.value = document.forms[0].sel_type.options[document.forms[0].sel_type.selectedIndex].text; 		
	}
	else
	{
		document.forms[0].sel_type.value="";
		document.forms[0].old_sel_typeText.value =""; 
	}
	
	<%if(grpRights.charAt(18)=='r'){%>
	document.forms[0].cmdedit.disabled=true;
<%}%>

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
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
	document.forms[0].hidAction.value="update"
	document.forms[0].txt_dealercountry.readOnly=true;
	document.forms[0].txt_dealerdistrict.readOnly=true;
	document.forms[0].txt_dealerstate.readOnly=true;
	document.forms[0].txt_dealercity.readOnly=true;
	document.forms[0].txt_locationcity.readOnly=true;
	document.forms[0].txt_locationdistrict.readOnly=true;
	document.forms[0].txt_locationstate.readOnly=true;
	document.forms[0].txt_locationcountry.readOnly=true;
	document.forms[0].txt_cbscustid.readOnly=true;
	if(document.forms[0].txt_cbscustid.value!=""){
		document.forms[0].sel_salutation.disabled=true;
		document.forms[0].txt_belongsto.readOnly=true;
		//document.forms[0].txt_doorno.readOnly=true;
		document.forms[0].txt_add1.readOnly=true;
		document.forms[0].txt_add2.readOnly=true;
		}
	
}

function doSave()
{
	document.forms[0].hidsalutation.value=document.forms[0].sel_salutation.value;
	if(trim(document.forms[0].txt_machinerytype.value) == "")
	{
		document.forms[0].txt_machinerytype.value="";
		ShowAlert('121','Machinery Type');
		document.forms[0].txt_machinerytype.focus();
		return;
	}
	if(document.forms[0].sel_workcondition.value == "")
	{
		ShowAlert('111','Whether in working condition');
		document.forms[0].sel_workcondition.focus();
		return;
	}
	if(document.forms[0].txt_purinvprice.value == "" || document.forms[0].txt_purinvprice.value == "0.00")
	{
		ShowAlert('121','Purchase price/Invoice price');
		document.forms[0].txt_purinvprice.focus();
		return;
	}
	if(document.forms[0].txt_prebookval.value == "" || document.forms[0].txt_prebookval.value == "0.00")
	{
		ShowAlert('121','Present/Book Value');
		document.forms[0].txt_prebookval.focus();
		return;
	}
	if(document.forms[0].txt_valvaluate.value == "" || document.forms[0].txt_valvaluate.value == "0.00")
	{
		ShowAlert('121','Value as per valuation');
		document.forms[0].txt_valvaluate.focus();
		return;
	}
	if(document.forms[0].txt_forcedsale.value == "" || document.forms[0].txt_forcedsale.value == "0.00")
	{
		ShowAlert('121','Realisable/Forced Sale Value');
		document.forms[0].txt_forcedsale.focus();
		return;
	}

	if(document.forms[0].txt_dealer_name.value=="")
	{
		alert("Enter Dealer Name");
		document.forms[0].txt_dealer_name.focus();
		return;
	}else if(document.forms[0].txt_dealercont.value=="")
	{
		alert("Enter Dealer Contact Number");
		document.forms[0].txt_dealercont.focus();
		return;	
	}else if(document.forms[0].txt_dealeraddress1.value=="")
	{
		alert("Enter Dealer Address");
		document.forms[0].txt_dealeraddress1.focus();
		return;	
	}else if(document.forms[0].txt_dealercity.value=="")
	{
		alert("Select Dealer City");
		document.forms[0].txt_dealercity.focus();
		return;	
	}else if(document.forms[0].txt_dealeraddress2.value=="")
	{
		alert("Enter Dealer Address");
		document.forms[0].txt_dealeraddress2.focus();
		return;	
	}else if(document.forms[0].txt_dealerstate.value=="")
	{
		alert("Select Dealer State");
		document.forms[0].txt_dealerstate.focus();
		return;	
	}else if(document.forms[0].txt_dealerdistrict.value=="")
	{
		alert("Select Dealer District");
		document.forms[0].txt_dealerdistrict.focus();
		return;	
	}else if(document.forms[0].txt_dealercountry.value=="")
	{
		alert("Select Dealer Country");
		document.forms[0].txt_dealercountry.focus();
		return;	
	}else if(document.forms[0].txt_dealerpin.value=="")
	{
		alert("Enter Dealer Pin");
		document.forms[0].txt_dealerpin.focus();
		return;	
	}
	else if(document.forms[0].txt_dealercode.value=="")
	{
		alert("Enter Dealer Code");
		document.forms[0].txt_dealercode.focus();
		return;	
	}
	else if(document.forms[0].txt_dealertin.value=="")
	{
		alert("Enter Dealer Tin/GST No.");
		document.forms[0].txt_dealertin.focus();
		return;	
	}
	if(document.forms[0].sel_type.value == "")
	{
		ShowAlert('111','Type');
		document.forms[0].sel_type.focus();
		return;
	}
	if(document.forms[0].sel_salutation.value == "")
	{
		ShowAlert('111','Saluatation type');
		document.forms[0].sel_salutation.focus();
		return;
	}
	if(document.forms[0].txt_belongsto.value == "")
	{
		ShowAlert('121','Belonging to');
		document.forms[0].txt_belongsto.focus();
		return;
	}
	if(document.forms[0].txt_doorno.value == "")
	{
		ShowAlert('121','Door no');
		document.forms[0].txt_doorno.focus();
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
	document.forms[0].hidSourceUrl.value="/action/securitiesPlantMachinery.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updatePlantMachinery";
	document.forms[0].hidBeanGetMethod.value="getPlantMachinery";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{

	var temp="";
	var tempname="";

	document.forms[0].sel_workconditionText.value=document.forms[0].sel_workcondition.options[document.forms[0].sel_workcondition.selectedIndex].text;
	document.forms[0].sel_salutationText.value=document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text;
	document.forms[0].sel_typeText.value=document.forms[0].sel_type.options[document.forms[0].sel_type.selectedIndex].text;
	

	if(document.forms[0].sel_workconditionText.value!=document.forms[0].old_sel_workconditionText.value)
	{
		temp=temp+"old_sel_workconditionText"+"@"; 		tempname=tempname+"Whether in working condition "+"@";
	}
	if(document.forms[0].txt_machinerytype.value!=document.forms[0].old_txt_machinerytype.value)
	{
		temp=temp+"old_txt_machinerytype"+"@"; 	tempname=tempname+"Machinery Type "+"@";
	}
	if(document.forms[0].txt_manufacture.value!=document.forms[0].old_txt_manufacture.value)
	{
		temp=temp+"old_txt_manufacture"+"@"; 	tempname=tempname+"Manufacturing Company"+"@";
	}
	if(document.forms[0].txt_model.value!=document.forms[0].old_txt_model.value)
	{
		temp=temp+"old_txt_model"+"@"; 	tempname=tempname+"Model No"+"@";
	}
	if(document.forms[0].txt_yearmanufact.value!=document.forms[0].old_txt_yearmanufact.value)
	{
		temp=temp+"old_txt_yearmanufact"+"@"; 	tempname=tempname+"Year of Manufacture "+"@";
	}
	if(document.forms[0].txt_purinvprice.value!=document.forms[0].old_txt_purinvprice.value)
	{
		temp=temp+"old_txt_purinvprice"+"@"; 	tempname=tempname+"Purchase price/Invoice price "+"@";
	}
	if(document.forms[0].txt_prebookval.value!=document.forms[0].old_txt_prebookval.value)
	{
		temp=temp+"old_txt_prebookval"+"@"; 	tempname=tempname+"Present/Book Value"+"@";
	}
	if(document.forms[0].txt_balsheetval.value!=document.forms[0].old_txt_balsheetval.value)
	{
		temp=temp+"old_txt_balsheetval"+"@"; 	tempname=tempname+"Balance Sheet Value"+"@";
	}
	if(document.forms[0].txt_balsheetdate.value!=document.forms[0].old_txt_balsheetdate.value)
	{
		temp=temp+"old_txt_balsheetdate"+"@"; 	tempname=tempname+"Balance Sheet Date"+"@";
	}

	//last inspiration date
	if(document.forms[0].txt_lst_inspdate.value!=document.forms[0].old_txt_lst_inspdate.value)
	{
		temp=temp+"old_txt_lst_inspdate"+"@"; 	tempname=tempname+"Last Inspection Date"+"@";
	}

	
	if(document.forms[0].txt_valvaluate.value!=document.forms[0].old_txt_valvaluate.value)
	{
		temp=temp+"old_txt_valvaluate"+"@"; 	tempname=tempname+"Value as per valuation "+"@";
	}
	if(document.forms[0].txt_forcedsale.value!=document.forms[0].old_txt_forcedsale.value)
	{
		temp=temp+"old_txt_forcedsale"+"@"; 	tempname=tempname+"Realisable/Forced Sale Value"+"@";
	}


	//Name of the Dealer
	if(document.forms[0].txt_dealer_name.value!=document.forms[0].old_txt_dealer_name.value)
	{
		temp=temp+"old_txt_dealer_name"+"@"; 		tempname=tempname+"Name of the Dealer"+"@";
	}

	//Dealer Contact No
	if(document.forms[0].txt_dealercont.value!=document.forms[0].old_txt_dealercont.value)
	{
		temp=temp+"old_txt_dealercont"+"@"; 		tempname=tempname+"Dealer Contact No"+"@";
	}

	//Dealer Address1 
	if(document.forms[0].txt_dealeraddress1.value!=document.forms[0].old_txt_dealeraddress1.value)
	{
		temp=temp+"old_txt_dealeraddress1"+"@"; 		tempname=tempname+"Dealer Address1"+"@";
	}

	//Dealer City
	if(document.forms[0].txt_dealercity.value!=document.forms[0].old_txt_dealercity.value)
	{
		temp=temp+"old_txt_dealercity"+"@"; 		tempname=tempname+"Dealer City"+"@";
	}

	//Dealer Address2
	if(document.forms[0].txt_dealeraddress2.value!=document.forms[0].old_txt_dealeraddress2.value)
	{
		temp=temp+"old_txt_dealeraddress2"+"@"; 		tempname=tempname+"Dealer Address2"+"@";
	}
	
	//Dealer state
	if(document.forms[0].txt_dealerstate.value!=document.forms[0].old_txt_dealerstate.value)
	{
		temp=temp+"old_txt_dealerstate"+"@"; 		tempname=tempname+"Dealer State"+"@";
	}

	//Dealer District
	if(document.forms[0].txt_dealerdistrict.value!=document.forms[0].old_txt_dealerdistrict.value)
	{
		temp=temp+"old_txt_dealerdistrict"+"@"; 		tempname=tempname+"Dealer District"+"@";
	}
	
	//Dealer Country
	if(document.forms[0].txt_dealercountry.value!=document.forms[0].old_txt_dealercountry.value)
	{
		temp=temp+"old_txt_dealercountry"+"@"; 		tempname=tempname+"Dealer Country"+"@";
	}

	//Dealer Pin Code
	if(document.forms[0].txt_dealerpin.value!=document.forms[0].old_txt_dealerpin.value)
	{
		temp=temp+"old_txt_dealerpin"+"@"; 		tempname=tempname+"Dealer Pin Code"+"@";
	}

	//Dealer Mail ID
	if(document.forms[0].txt_dealermail.value!=document.forms[0].old_txt_dealermail.value)
	{
		temp=temp+"old_txt_dealermail"+"@"; 		tempname=tempname+"Dealer Mail ID"+"@";
	}

	//Dealer Code  
	if(document.forms[0].txt_dealercode.value!=document.forms[0].old_txt_dealercode.value)
	{
		temp=temp+"old_txt_dealercode"+"@"; 		tempname=tempname+"Dealer Code "+"@";
	}

	// Dealer Tin/GST No 
	if(document.forms[0].txt_dealertin.value!=document.forms[0].old_txt_dealertin.value)
	{
		temp=temp+"old_txt_dealertin"+"@"; 		tempname=tempname+" Dealer Tin/GST No. "+"@";
	}

	if(document.forms[0].txt_belongsto.value!=document.forms[0].old_txt_belongsto.value)
	{
		temp=temp+"old_txt_belongsto"+"@"; 		tempname=tempname+"Belongs to. "+"@";
	}

	if(document.forms[0].txt_doorno.value!=document.forms[0].old_txt_doorno.value)
	{
		temp=temp+"old_txt_doorno"+"@"; 		tempname=tempname+"Door No. "+"@";
	}
	if(document.forms[0].txt_pincode.value!=document.forms[0].old_txt_pincode.value)
	{
		temp=temp+"old_txt_pincode"+"@"; 		tempname=tempname+"Pin Code. "+"@";
	}
	if(document.forms[0].txt_add1.value!=document.forms[0].old_txt_add1.value)
	{
		temp=temp+"old_txt_add1"+"@"; 		tempname=tempname+"Address line 1. "+"@";
	}
	if(document.forms[0].txt_add2.value!=document.forms[0].old_txt_add2.value)
	{
		temp=temp+"old_txt_add2"+"@"; 		tempname=tempname+"Address line 2. "+"@";
	}
	if(document.forms[0].txt_locationcity.value!=document.forms[0].old_txt_locationcity.value)
	{
		temp=temp+"old_txt_locationcity"+"@"; 		tempname=tempname+"city. "+"@";
	}
	if(document.forms[0].txt_locationdistrict.value!=document.forms[0].old_txt_locationdistrict.value)
	{
		temp=temp+"old_txt_locationdistrict"+"@"; 		tempname=tempname+"District. "+"@";
	}
	if(document.forms[0].txt_locationstate.value!=document.forms[0].old_txt_locationstate.value)
	{
		temp=temp+"old_txt_locationstate"+"@"; 		tempname=tempname+"State. "+"@";
	}
	if(document.forms[0].txt_locationcountry.value!=document.forms[0].old_txt_locationcountry.value)
	{
		temp=temp+"old_txt_locationcountry"+"@"; 		tempname=tempname+"Country. "+"@";
	}
	if(document.forms[0].sel_salutationText.value!=document.forms[0].old_sel_salutationText.value)
	{
		temp=temp+"old_sel_salutationText"+"@"; 		tempname=tempname+"Saluatation name "+"@";
	}
	if(document.forms[0].sel_typeText.value!=document.forms[0].old_sel_typeText.value)
	{
		temp=temp+"old_sel_typeText"+"@"; 		tempname=tempname+"Name "+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
}
function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster"
		document.forms[0].hidBeanGetMethod.value="getPlantMachinery";
		document.forms[0].action=appURL+"action/securitiesPlantMachinery.jsp";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securitiesPlantMachinery.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updatePlantMachinery";
		document.forms[0].hidBeanGetMethod.value="getPlantMachinery";
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

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled == true)
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function callCalender(name)
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,name);
	}
}
function callCalender1(name)
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,name);
	}
}


function showCitySearch1(val1) {
	if (val1 == "MACH") {
		if (document.forms[0].cmdsave.disabled == false ) {
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
function showCitySearch2(val1) {
	if (val1 == "MACH1") {
		if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_cbscustid.value=="") {
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


function callCntrySearch1(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].txt_cbscustid.value=="")
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
	}
	
}
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
	}
	
}

function callDistrict1() {
	
	var varstate = document.forms[0].hid_dealerstate.value;
	if (document.forms[0].cmdsave.disabled == false) {
		if (document.forms[0].txt_dealercity.value == "") {
			ShowAlert(112, "City");
			document.forms[0].txt_dealercity.focus();
			return;
		}
		if (document.forms[0].hid_dealerstate.value == "") {
			alert("Please Reselect the City");
			document.forms[0].txt_dealercity.focus();
			return;
		} else {
			var varQryString = appURL+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+ varstate + "&code=MACH";
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
			prop = prop + ",left=200,top=200";
			window.open(varQryString, title, prop);
		}
	}
}
function callDistrict2() {
	
	var varstate = document.forms[0].hid_locationstate.value;
	if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_cbscustid.value=="") {
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
			var varQryString = appURL+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+ varstate + "&code=MACH1";
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
			prop = prop + ",left=200,top=200";
			window.open(varQryString, title, prop);
		}
	}
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?&pagename=sec_plantmachinery";
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
				<jsp:param name="subpageid" value="209" />
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Plant & Machinery</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="19" />
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
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Plant & Machinery</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="209" />
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
	<jsp:param name="pageid" value="19" />
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
		<jsp:param name="pageid" value="19" />
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
		<td class="page_flow">Home -&gt; Securities -&gt; Plant & Machinery</td>
	</tr>
</table>
<table width="50%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="sub_tab_inactive_new" WIDTH="50%" align="center">
			<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
			Security Details</a></b>
		</td>
		<td class="sub_tab_active_new" align="center"><b>Plant & Machinery</b></td>
	</tr>
</table>
<%} %>
<table width="98%" border="0" cellpadding="3" cellspacing="0"
			align="center" class="outertable" style="border: 2px solid #dccada;">
	<tr>
		<td>
		<table width="95%" border="0" cellspacing="0" cellpadding="0"
			class="outertable" align="center">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="3" cellpadding="3"
					align="center" class="outertable">
									<tr>
										   <td> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
									</tr>
									<tr><td>Type<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td>
									<td><select name="sel_type">
									<option value="">--select--</option>
									<option value="Old">Old</option>
									<option value="New">New</option>
									</select>
									</td>
									</tr>
									<tr>
										  <td width="24%">Machinery description/Name <b><span class="mantatory">*&nbsp;</span></b></td>
										  <td width="3%">&nbsp;</td>
						                  <td width="22%" nowrap>
						                  	<input type="text" name="txt_machinerytype" size="30" maxlength="50"
													value="<%=Helper.correctNull((String)hshValues.get("txt_machinerytype"))%>">
										  </td>
						
												
						                  <td width="26%">Whether in working condition <b><span class="mantatory">*&nbsp;</span></b></td>
						                  <td width="3%">&nbsp;</td>
						                  <td width="22%" nowrap> 
						                    <select name="sel_workcondition" onchange="">
						                          <option value="" selected>--Select--</option>
						                          <option value="Y">Yes</option>
						                          <option value="N">No</option>
						                        </select>
						                  </td>
									</tr>
									<tr>	
							                 <td>Manufacturing Company</td>
											 <td width="3%">&nbsp;</td>	
							                 <td><input type="text" name="txt_manufacture" size="30" value="<%=Helper.correctNull((String)hshValues.get("txt_manufacture"))%>" maxlength="50" >
											 </td>
													
										  	 <td>Model No/ Year of Manufacture </td>
											 <td width="3%">&nbsp;</td>	
							                 <td><input type="text" name="txt_model" size="10" maxlength="20"
														value="<%=Helper.correctNull((String) hshValues.get("txt_model"))%>">&nbsp;
														<input type="text" name="txt_yearmanufact" 
														 onKeyPress="allowNumber(this)" size="10" maxlength="4"
														value="<%=Helper.correctNull((String) hshValues.get("txt_yearmanufact"))%>"  onblur="checkcurrentyear(this);">
											</td>
									</tr>
								    <tr>
									
				                  			<td>Purchase price/Invoice price <b><span class="mantatory">*&nbsp;</span></b>	
				                  			</td>
										
						                    <td>Rs.</td>
						                    <td> 
						                    <lapschoice:CurrencyTag name="txt_purinvprice" maxlength="10"  style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													size="15" value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("txt_purinvprice"))))%>' /></td>
												
						                   <td nowrap>Present/Book Value<b><span class="mantatory">*&nbsp;</span></b></td>
												
						                   <td>Rs.</td>
						                   <td><lapschoice:CurrencyTag name="txt_prebookval"
													size="15" maxlength="10" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_prebookval")))))%>'/>
										  </td>
								  </tr>
									<tr>
										
						                  <td>Balance Sheet Value</td>
												
						                  <td>Rs.</td> 
						                    <td><lapschoice:CurrencyTag name="txt_balsheetval" maxlength="10"  style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													size="15" value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_balsheetval"))))%>'/>	</td>
												
						                  <td nowrap>Balance Sheet Date</td>
											<td width="3%">&nbsp;</td>
						                  <td><input type="text" name="txt_balsheetdate"
													size="15" maxlength="10" style="text-align: right" 	onBlur="checkDate(this);"
													value="<%=Helper.correctNull((String)hshValues.get("txt_balsheetdate"))%>">&nbsp; <a href="#"
													onClick="callCalender('txt_balsheetdate')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													border="0"></a>
										  </td>
									</tr>
									<tr>
										
						                  <td>Value as per valuation <b><span class="mantatory">*&nbsp;</span></b></td>
												
						                  <td>Rs.</td> 
						                  <td><lapschoice:CurrencyTag name="txt_valvaluate" maxlength="10"  style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													size="15" value='<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_valvaluate")))))%>'/>	</td>
												
						                  <td nowrap>Realisable/Forced Sale Value <b><span class="mantatory">*&nbsp;</span></b></td>
												
						                  <td>Rs.</td> 
						                  <td><lapschoice:CurrencyTag  name="txt_forcedsale"
													size="15" maxlength="10" style="text-align: right" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													value='<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_forcedsale")))))%>'/>
										 </td>
									</tr>
					
					
									<tr>
										 <td>Last Inspection Date </td>
										 <td width="3%">&nbsp;</td>
							             <td> <input type="text" name="txt_lst_inspdate"
														size="15" maxlength="10" style="text-align: right" 	onBlur="checkDate(this);checkmaxdate(this,curdate);"
														value="<%=Helper.correctNull((String)hshValues.get("txt_lst_inspdate"))%>">&nbsp; <a href="#"
														onClick="callCalender1('txt_lst_inspdate')"
														title="Click to view calender" border=0><img
														src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
														border="0"></a>
										  </td>
						                  <td nowrap>&nbsp;</td>
												
						                  <td>&nbsp;</td> 
						                  <td>&nbsp;</td>
									</tr>
					
									<tr>
										<td colspan="6" class="datagrid">Dealer Details</td>
									</tr>
									
									<tr>
										<td>Name of the Dealer<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealer_name" tabindex="10" onKeyPress="allowAlphabetsForName()"
										maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealer_name"))%>"></td>
										<td>Contact No<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercont" tabindex="11"
										maxlength="10" size="18"  onKeyPress="allowNumber(this)"  value="<%=Helper.correctNull((String)hshValues.get("txt_dealercont"))%>"></td>
									</tr>
									<tr>
										<td rowspan="2" valign="top">Address <span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td rowspan="2">&nbsp;</td>
										<td><input type="text" name="txt_dealeraddress1" tabindex="12" 
										maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealeraddress1"))%>"></td>
										<td>City<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercity" tabindex="15" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercity"))%>" >
										<input type="hidden" name="hid_dealercity" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercity1"))%>" > &nbsp;  <a onClick="showCitySearch1('MACH');" style="cursor: hand" tabindex="13">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
										</tr>
									<tr>
										<td><input type="text" name="txt_dealeraddress2" tabindex="14"
										maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealeraddress2"))%>"></td>
										<td>State<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealerstate" tabindex="16" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerstate"))%>" >
										<input type="hidden" name="hid_dealerstate" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerstate1"))%>" > &nbsp; </td>
									</tr>
									<tr>
										<td>District<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealerdistrict" tabindex="13" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerdistrict"))%>" >
										<input type="hidden" name="hid_dealerdistrict"value="<%=Helper.correctNull((String)hshValues.get("txt_dealerdistrict1"))%>" > &nbsp; <a onClick="callDistrict1();" style="cursor: hand" tabindex="14">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
									
										<td>Country<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercountry" tabindex="17" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercountry"))%>" >
										<input type="hidden" name="hid_dealercountry" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercountry1"))%>" > &nbsp; <a 
										onClick="callCntrySearch('txt_dealercountry','hid_dealercountry')"
										style="cursor:hand" tabindex="8"><img
										src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
										border="0" tabindex="21"></a> </td>
									</tr>
									<tr>
										<td>Pin Code<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealerpin" tabindex="18"
										maxlength="6" size="10" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerpin"))%>" onKeyPress="allowNumber(this)" > </td>
										<td>Mail ID</td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealermail" 	onBlur="isEmailAddr(document.forms[0].txt_dealermail.value,document.forms[0].txt_dealermail)"
										tabindex="18"
										maxlength="25" size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealermail"))%>" > </td>
									</tr>
									<tr>
										<td>Dealer Code <span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercode" tabindex="18" onKeyPress="allowAlphaNumeric()"
										maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercode"))%>"> </td>
										<td> Dealer Tin/GST No.<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealertin" tabindex="18" maxlength="15" onKeyPress="allowAlphaNumeric()"
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealertin"))%>" > </td>
									</tr>
									<tr>
										<td colspan="6" class="datagrid">Belonging To</td>
									</tr>
									<tr>
									
					<td width="13%" >CBS Cust ID</td><td>&nbsp;</td>
				<td id="idsearch" width="34%"><input type="text"
					name="txt_cbscustid" size="12" maxlength="10" onBlur="readOnly" 
					value="<%=Helper.correctNull((String)hshValues.get("sec_cbsid"))%>">
				<b><span onClick="javascript:callDescCBS()" style="cursor: hand" ><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>
					</tr>
					<tr>
						<td>Belonging to<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td>
						<td><select name="sel_salutation" style="width:45%">
						<option value="">---Select-----</option>
						<%
							String apptypecon = "1";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
						</select>&nbsp;&nbsp;
  						 
  						   <input type="text" name="txt_belongsto" maxlength="20" value='<%=Helper.correctNull((String)hshValues.get("SEC_MACHINERY_BELONGS_NAME"))%>'/ ></td>
  						
  						<td>Door No<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td><td><input type="text" name="txt_doorno" value='<%=Helper.correctNull((String)hshValues.get("SEC_BELONGSTO_DOORNO"))%>'/></td>
  				   </tr>
  				    <tr>
  				   <td valign="top">Address</td><td>&nbsp;</td><td><input type="text" name="txt_add1" size="25" value='<%=Helper.correctNull((String)hshValues.get("SEC_ADDRESS1"))%>'/><br></td>
  				   <td>City<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td>
  				   <td><input type="text" name="txt_locationcity" tabindex="15" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercity2"))%>" >
										<input type="hidden" name="hid_locationcity" value="<%=Helper.correctNull((String)hshValues.get("SEC_CITY"))%>" > &nbsp;  <a onClick="showCitySearch2('MACH1');" style="cursor: hand" tabindex="13">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
  				   </tr>
  				   
  				   <tr>
  				    	<td>&nbsp;</td>
	  				   <td>&nbsp;</td>
	  				   <td><input type="text" name="txt_add2" size="25" value='<%=Helper.correctNull((String)hshValues.get("SEC_ADDRESS2"))%>'/></td>
	  				   <td>&nbsp;</td>
	  				   <td>&nbsp;</td>
  				   </tr>
  				   <tr>
  				   <td>District<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td>
  				   <td><input type="text" name="txt_locationdistrict" tabindex="13" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerdistrict2"))%>" >
										<input type="hidden" name="hid_locationdistrict" value="<%=Helper.correctNull((String)hshValues.get("SEC_DISTRICT"))%>" > &nbsp; <a onClick="callDistrict2();" style="cursor: hand" tabindex="14">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
  				   <td>State<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td>
  				   <td><input type="text" name="txt_locationstate" tabindex="16" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerstate2"))%>" >
										<input type="hidden" name="hid_locationstate" value="<%=Helper.correctNull((String)hshValues.get("SEC_STATE"))%>" > &nbsp; </td>
  				   </tr>
  				   
  				   <tr>
  				   <td>Pin Code<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td>
  				   <td><input type="text" name="txt_pincode" maxlength="6" value='<%=Helper.correctNull((String)hshValues.get("SEC_PINCODE"))%>' onKeyPress="allowNumber(this)"/></td>
  				   <td>Country<span class="mantatory">&nbsp;*&nbsp;</span></td><td>&nbsp;</td>
  				   <td><input type="text" name="txt_locationcountry" tabindex="17" 
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercountry2"))%>" >
										<input type="hidden" name="hid_locationcountry" value="<%=Helper.correctNull((String)hshValues.get("SEC_COUNTRY"))%>" > &nbsp; <a 
										onClick="callCntrySearch1('txt_locationcountry','hid_locationcountry')"
										style="cursor:hand" tabindex="8"><img
										src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
										border="0" tabindex="21"></a> </td>
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

<input type="hidden" name="old_txt_machinerytype"	value="<%=Helper.correctNull((String) hshValues.get("txt_machinerytype"))%>">
<input type="hidden" name="old_txt_manufacture"	value="<%=Helper.correctNull((String) hshValues.get("txt_manufacture"))%>">
<input type="hidden" name="old_txt_model"	value="<%=Helper.correctNull((String) hshValues.get("txt_model"))%>">
<input type="hidden" name="old_txt_yearmanufact"	value="<%=Helper.correctNull((String) hshValues.get("txt_yearmanufact"))%>">
<input type="hidden" name="old_txt_purinvprice"	value="<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_purinvprice")))))%>">
<input type="hidden" name="old_txt_prebookval"	value="<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_prebookval")))))%>">
<input type="hidden" name="old_txt_balsheetval"	value="<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_balsheetval")))))%>">
<input type="hidden" name="old_txt_balsheetdate"	value="<%=Helper.correctNull((String) hshValues.get("txt_balsheetdate"))%>">
<input type="hidden" name="old_txt_valvaluate"	value="<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_valvaluate")))))%>">
<input type="hidden" name="old_txt_forcedsale"	value="<%=nf.format(Double.parseDouble(Helper.correctDouble(((String) hshValues.get("txt_forcedsale")))))%>">
<input type="hidden" name="old_txt_lst_inspdate"	value="<%=Helper.correctNull((String) hshValues.get("txt_lst_inspdate"))%>">


<input type="hidden" name="old_txt_dealer_name" value="<%=Helper.correctNull((String) hshValues.get("txt_dealer_name"))%>">
<input type="hidden" name="old_txt_dealercont" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercont"))%>">
<input type="hidden" name="old_txt_dealeraddress1" value="<%=Helper.correctNull((String) hshValues.get("txt_dealeraddress1"))%>">
<input type="hidden" name="old_txt_dealercity" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercity"))%>">
<input type="hidden" name="old_txt_dealeraddress2" value="<%=Helper.correctNull((String) hshValues.get("txt_dealeraddress2"))%>">
<input type="hidden" name="old_txt_dealerstate" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerstate"))%>">
<input type="hidden" name="old_txt_dealerdistrict" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerdistrict"))%>">
<input type="hidden" name="old_txt_dealercountry" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercountry"))%>">
<input type="hidden" name="old_txt_dealerpin" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerpin"))%>">
<input type="hidden" name="old_txt_dealermail" value="<%=Helper.correctNull((String) hshValues.get("txt_dealermail"))%>">

<input type="hidden" name="old_txt_dealercode" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercode"))%>">
<input type="hidden" name="old_txt_dealertin" value="<%=Helper.correctNull((String) hshValues.get("txt_dealertin"))%>">


<input type="hidden" name="old_txt_pincode" value="<%=Helper.correctNull((String) hshValues.get("SEC_PINCODE"))%>">
<input type="hidden" name="old_txt_belongsto" value="<%=Helper.correctNull((String) hshValues.get("SEC_MACHINERY_BELONGS_NAME"))%>">
<input type="hidden" name="old_txt_doorno" value="<%=Helper.correctNull((String) hshValues.get("SEC_BELONGSTO_DOORNO"))%>">
<input type="hidden" name="old_txt_add1" value="<%=Helper.correctNull((String) hshValues.get("SEC_ADDRESS1"))%>">
<input type="hidden" name="old_txt_add2" value="<%=Helper.correctNull((String) hshValues.get("SEC_ADDRESS2"))%>">
<input type="hidden" name="old_txt_locationcity" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercity2"))%>">
<input type="hidden" name="old_txt_locationdistrict" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerdistrict2"))%>">
<input type="hidden" name="old_txt_locationstate" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerstate2"))%>">
<input type="hidden" name="old_txt_locationcountry" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercountry2"))%>">



<input type="hidden" name="old_sel_workconditionText">	
<input type="hidden" name="sel_workconditionText">

<input type="hidden" name="old_sel_salutationText">	
<input type="hidden" name="sel_salutationText">

<input type="hidden" name="old_sel_typeText">	
<input type="hidden" name="sel_typeText">
<input type="hidden" name="hidsalutation">
</form>
</body>
</html>

