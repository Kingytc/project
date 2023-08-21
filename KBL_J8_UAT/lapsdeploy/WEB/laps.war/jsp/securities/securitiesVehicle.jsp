<%@include file="../share/directives.jsp"%>

<%   String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
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
String pageid = Helper.correctNull((String) request.getParameter("pageid"));
String strEmployment=(String)session.getAttribute("strEmployment");
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
String strvehtype= Helper.correctNull((String) session.getAttribute("sec_vehicletype"));
%>
<html>
<head>
<title>Securities - Vehicles</title>
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

var sel_VehicleType = "<%=Helper.correctNull((String)hshValues.get("sec_vehicletype"))%>";
var sel_Category = "<%=Helper.correctNull((String)hshValues.get("sec_vehiclecat"))%>";
var varValuationDate = "<%=Helper.correctNull((String)hshValues.get("SEC_VALUATION_DATE"))%>";
var varValSubmittedDate = "<%=Helper.correctNull((String)hshValues.get("CUS_VALSUBMITTEDDATE"))%>";
var varValRecvDate = "<%=Helper.correctNull((String)hshValues.get("CUS_VALRECVDATE"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";
var varSEC_VEH_REGSTATE="<%=Helper.correctNull((String)hshValues.get("SEC_VEH_REGSTATE"))%>";
var VALUER_VALUEDLOC="<%=Helper.correctNull((String)hshValues.get("VALUER_VALUEDLOC"))%>";
var vardocs="<%=Helper.correctNull((String)hshValues.get("SEC_DOCS"))%>"
var varSalutation="<%=Helper.correctNull((String)hshValues.get("SEC_SALUTATION"))%>";

var registrationno="<%=Helper.correctNull((String)hshValues.get("sec_regno"))%>";
var chasisno="<%=Helper.correctNull((String)hshValues.get("SEC_CHASSISNO"))%>";
var engineno="<%=Helper.correctNull((String)hshValues.get("sec_hpno"))%>";
var rcsubdate="<%=Helper.correctNull((String)hshValues.get("sec_hpno"))%>";
	
function callLoad()
{
	hidd();
	placeval();
	
	if(sel_VehicleType!="" && sel_VehicleType!="0")
	{
		document.forms[0].sel_VehicleType.value=sel_VehicleType;
		document.forms[0].old_sel_VehicleTypeText.value = document.forms[0].sel_VehicleType.options[document.forms[0].sel_VehicleType.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_VehicleType.value="0";
		document.forms[0].old_sel_VehicleTypeText.value = ""; 
	}
	if(varSalutation!="")
	{
		document.forms[0].sel_salutation.value=varSalutation;
		if(document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text=="---Select-----")
		{
			document.forms[0].old_sel_salutationText.value = "";
		}
		else
		{
			document.forms[0].old_sel_salutationText.value = document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text; 
		}
		
			
	}
	else
	{
		document.forms[0].sel_salutation.value="";
		document.forms[0].old_sel_salutationText.value =""; 
	}
	if(sel_Category!="")
	{
		document.forms[0].sel_Category.value=sel_Category;
		document.forms[0].old_sel_CategoryText.value = document.forms[0].sel_Category.options[document.forms[0].sel_Category.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_Category.value="0";
		document.forms[0].old_sel_CategoryText.value = ""; 
	}

	if(varSEC_VEH_REGSTATE!="")
	{
		document.forms[0].sel_state.value=varSEC_VEH_REGSTATE;
		document.forms[0].old_sel_stateText.value = document.forms[0].sel_state.options[document.forms[0].sel_state.selectedIndex].text; 
	}

	calldisable(true);
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
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
		if (document.forms[0].elements[i].type == "checkbox") 
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
	document.all.idsearch.disabled=one;
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";	
		document.forms[0].hidBeanGetMethod.value="getSecurityVehicle";
		document.forms[0].action=appURL+"action/securitiesVehicle.jsp";	
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
	document.forms[0].sel_VehicleType.focus();
	document.forms[0].txt_district.readOnly=true;
	document.forms[0].txt_city.readOnly=true;
	document.forms[0].txt_state.readOnly=true;
	document.forms[0].txt_country.readOnly=true;
	document.forms[0].txt_dealercity.readOnly=true;
	document.forms[0].txt_dealerstate.readOnly=true;
	document.forms[0].txt_dealerdistrict.readOnly=true;
	document.forms[0].txt_dealercountry.readOnly=true;
	document.forms[0].txt_cbscustid.readOnly=true;
	if(document.forms[0].txt_cbscustid.value!=""){
		document.forms[0].sel_salutation.disabled=true;
		document.forms[0].txt_belongsto.readOnly=true;
		document.forms[0].txt_address1.readOnly=true;
		document.forms[0].txt_address2.readOnly=true;
		}
}
function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
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

function doSave()
{
	document.forms[0].hidsalutation.value=document.forms[0].sel_salutation.value;
	var s="";
	for(i=0;i<document.forms[0].chk_doc.length;i++)
    {
	
		if(document.forms[0].chk_doc[i].checked==true)
     		{
	     		s = s+ document.forms[0].chk_doc[i].value+"@"; 
          	}
		document.forms[0].hidchk_doc.value = s;
	}

 	if(document.forms[0].sel_VehicleType.value=="1"||document.forms[0].sel_VehicleType.value=="0")
	{
			document.forms[0].txt_tax_paid.value ="";	
			document.forms[0].txt_ins_valid.value ="";
			document.forms[0].chk_doc.value ="";		
	}
	
	if(trim(document.forms[0].sel_VehicleType.value)=="0")
	{
		alert("Select Vehicle Type");
		document.forms[0].sel_VehicleType.focus();
		return;
	}
	if(trim(document.forms[0].sel_Category.value)=="0")
	{
		alert("Select Vehicle Category");
		document.forms[0].sel_Category.focus();
		return;
	}
	
	if(document.forms[0].txt_company.value=="")
	{
		alert("Enter Company");
		document.forms[0].txt_company.focus();
		return;
	}
	if(document.forms[0].txt_make.value=="")
	{
		alert("Enter Make");
		document.forms[0].txt_make.focus();
		return;
	}
	if(document.forms[0].txt_model.value=="")
	{
		alert("Enter Model");
		document.forms[0].txt_model.focus();
		return;
	}
	if(document.forms[0].txt_vehicleage.value=="")
	{
		alert("Enter Age of the vehicle");
		document.forms[0].txt_vehicleage.focus();
		return;
	}
	if(document.forms[0].sel_VehicleType.value=="2")
	{
		if(document.forms[0].txt_regno.value=="")
		{
			alert("Enter Registration No");
			document.forms[0].txt_regno.focus();
			return;
		}
		if(document.forms[0].txt_engineno.value=="")
		{
			alert("Enter Engine No. / HP");
			document.forms[0].txt_engineno.focus();
			return;
		}
		if(document.forms[0].txt_chassisno.value=="")
		{
			alert("Enter Chassis No.");
			document.forms[0].txt_chassisno.focus();
			return;
		}
	}
	if(trim(document.forms[0].txt_PurcInvoice_Price.value)=="0.00" ||
			trim(document.forms[0].txt_PurcInvoice_Price.value)=="")
	{
		document.forms[0].txt_PurcInvoice_Price.value="";
		alert("Enter Purchase Price / Invoice Price");
		document.forms[0].txt_PurcInvoice_Price.focus();
		return;
	}
	if(trim(document.forms[0].txt_Present_BookVal.value)=="0.00" ||
			trim(document.forms[0].txt_Present_BookVal.value)=="")
	{
		document.forms[0].txt_Present_BookVal.value="";
		alert("Enter Present / Book Value");
		document.forms[0].txt_Present_BookVal.focus();
		return;
	}
	if(document.forms[0].sel_state.value=="")
	{
		alert("Select Registration State");
		document.forms[0].sel_state.focus();
		return;	
	}


		
	if(document.forms[0].sel_VehicleType.value!="2")
	{
		//dealer alerts
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
		}else if(document.forms[0].txt_dealertin.value=="")
		{
			alert("Enter Dealer Tin/GST No");
			document.forms[0].txt_dealertin.focus();
			return;	
		}
	}
	else
	{
		//dealer alerts
	 	if(document.forms[0].txt_dealer_name.value=="")
		{
			alert("Enter Dealer/Seller Name");
			document.forms[0].txt_dealer_name.focus();
			return;
		}else if(document.forms[0].txt_dealercont.value=="")
		{
			alert("Enter Dealer/Seller Contact Number");
			document.forms[0].txt_dealercont.focus();
			return;	
		}else if(document.forms[0].txt_dealeraddress1.value=="")
		{
			alert("Enter Dealer/Seller Address");
			document.forms[0].txt_dealeraddress1.focus();
			return;	
		}else if(document.forms[0].txt_dealercity.value=="")
		{
			alert("Select Dealer/Seller City");
			document.forms[0].txt_dealercity.focus();
			return;	
		}else if(document.forms[0].txt_dealeraddress2.value=="")
		{
			alert("Enter Dealer/Seller Address");
			document.forms[0].txt_dealeraddress2.focus();
			return;	
		}else if(document.forms[0].txt_dealerstate.value=="")
		{
			alert("Select Dealer/Seller State");
			document.forms[0].txt_dealerstate.focus();
			return;	
		}else if(document.forms[0].txt_dealerdistrict.value=="")
		{
			alert("Select Dealer/Seller District");
			document.forms[0].txt_dealerdistrict.focus();
			return;	
		}else if(document.forms[0].txt_dealercountry.value=="")
		{
			alert("Select Dealer/Seller Country");
			document.forms[0].txt_dealercountry.focus();
			return;	
		}else if(document.forms[0].txt_dealerpin.value=="")
		{
			alert("Enter Dealer/Seller Pin");
			document.forms[0].txt_dealerpin.focus();
			return;	
		}
	}
	
//Vehicle to be parked in 	
	if(document.forms[0].txt_belongsto.value=="")
	{
		alert("Enter Vehicle belongs to");
		document.forms[0].txt_belongsto.focus();
		return;	
	}
	else if(document.forms[0].txt_doorno.value=="")
	{
		alert("Enter Door No.");
		document.forms[0].txt_doorno.focus();
		return;	
	}
	else if(document.forms[0].txt_address1.value=="")
	{
		alert("Enter Address");
		document.forms[0].txt_address1.focus();
		return;	
	}
	else if(document.forms[0].txt_district.value=="")
	{
		alert("select District");
		document.forms[0].txt_district.focus();
		return;	
	}
	else if(document.forms[0].txt_city.value=="")
	{
		alert("Select City");
		document.forms[0].txt_city.focus();
		return;	
	}
	else if(document.forms[0].txt_state.value=="")
	{
		alert("Select State");
		document.forms[0].txt_state.focus();
		return;	
	}
	else if(document.forms[0].txt_country.value=="")
	{
		alert("Select Country");
		document.forms[0].txt_country.focus();
		return;	
	}
	else if(document.forms[0].txt_pin.value=="")
	{
		alert("Enter Pin");
		document.forms[0].txt_pin.focus();
		return;	
	}
	/*var varsel_state=document.forms[0].sel_state.value;
	if(!(VALUER_VALUEDLOC.indexOf(varsel_state)>=0))
	{
		alert("The valuer attached to this security not eligible to Valuate Vehicle. Please reattach valuer");
		return false;
	}*/
	/*var varsel_state=document.forms[0].sel_state.value;
	var varBflag="false";
	if(VALUER_VALUEDLOC!="")
	{
		var varSplit=VALUER_VALUEDLOC.split("@");
		if(varSplit.length>=1)
		{
			for(var i=0;i<varSplit.length;i++)
			{
				var varSplit1=varSplit[i].split("~");
				if(varSplit1.length>1)
				{
					if(varSplit1[0]==varsel_state && varBflag=="false")
					{
						varBflag="true";
					}
				}
			}
		}
	}
	if(varBflag=="false")
	{
		alert("The valuer attached to this security not eligible to Valuate Vehicle. Please reattach valuer");
		return false;
	}*/
	
	modifyCheck();
	var registrationno="<%=Helper.correctNull((String)hshValues.get("sec_regno"))%>";
	var chasisno="<%=Helper.correctNull((String)hshValues.get("SEC_CHASSISNO"))%>";
	var engineno="<%=Helper.correctNull((String)hshValues.get("sec_hpno"))%>";
	var rcsubdate="<%=Helper.correctNull((String)hshValues.get("sec_hpno"))%>";
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSourceUrl.value="/action/securitiesVehicle.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityVehicle";
	document.forms[0].hidBeanGetMethod.value="getSecurityVehicle";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function modifyCheck()
{
	
	
	var temp="";
	var tempname="";

	document.forms[0].sel_CategoryText.value=document.forms[0].sel_Category.options[document.forms[0].sel_Category.selectedIndex].text;
	document.forms[0].sel_VehicleTypeText.value=document.forms[0].sel_VehicleType.options[document.forms[0].sel_VehicleType.selectedIndex].text;
	document.forms[0].sel_stateText.value=document.forms[0].sel_state.options[document.forms[0].sel_state.selectedIndex].text;
	document.forms[0].sel_salutationText.value=document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text;

	if(document.forms[0].sel_CategoryText.value!=document.forms[0].old_sel_CategoryText.value)
	{
		temp=temp+"old_sel_CategoryText"+"@"; 		tempname=tempname+"Vehicle Category "+"@";
	}
	if(document.forms[0].sel_VehicleTypeText.value!=document.forms[0].old_sel_VehicleTypeText.value)
	{
		temp=temp+"old_sel_VehicleTypeText"+"@"; 	tempname=tempname+"Vehicle Type "+"@";
	}
	if(document.forms[0].sel_stateText.value!=document.forms[0].old_sel_stateText.value)
	{
		temp=temp+"old_sel_stateText"+"@"; 		tempname=tempname+"Registration State"+"@";
	}
	if(document.forms[0].txt_company.value!=document.forms[0].old_txt_company.value)
	{
		temp=temp+"old_txt_company"+"@"; 		tempname=tempname+"Company"+"@";
	}
	if(document.forms[0].txt_make.value!=document.forms[0].old_txt_make.value)
	{
		temp=temp+"old_txt_make"+"@"; 		tempname=tempname+"Make "+"@";
	}
	if(document.forms[0].txt_model.value!=document.forms[0].old_txt_model.value)
	{
		temp=temp+"old_txt_model"+"@"; 		tempname=tempname+"Model"+"@";
	}
	if(document.forms[0].txt_vehicleage.value!=document.forms[0].old_txt_vehicleage.value)
	{
		temp=temp+"old_txt_vehicleage"+"@"; 		tempname=tempname+"Age of the vehicle"+"@";
	}
	if(document.forms[0].txt_PurcInvoice_Price.value!=document.forms[0].old_txt_PurcInvoice_Price.value)
	{
		temp=temp+"old_txt_PurcInvoice_Price"+"@"; 		tempname=tempname+"Purchase Price  "+"@";
	}
	if(document.forms[0].txt_Present_BookVal.value!=document.forms[0].old_txt_Present_BookVal.value)
	{
		temp=temp+"old_txt_Present_BookVal"+"@"; 		tempname=tempname+"Present / Book Value"+"@";
	}
	if(document.forms[0].txt_regno.value!=document.forms[0].old_txt_regno.value)
	{
		temp=temp+"old_txt_regno"+"@"; 		tempname=tempname+"Registration No"+"@";
	}
	if(document.forms[0].txt_engineno.value!=document.forms[0].old_txt_engineno.value)
	{
		temp=temp+"old_txt_engineno"+"@"; 		tempname=tempname+"Engine No "+"@";
	}
	if(document.forms[0].txt_chassisno.value!=document.forms[0].old_txt_chassisno.value)
	{
		temp=temp+"old_txt_chassisno"+"@"; 		tempname=tempname+"Chassis No"+"@";
	}
	if(document.forms[0].txt_belongsto.value!=document.forms[0].old_txt_belongsto.value)
	{
		temp=temp+"old_txt_belongsto"+"@"; 		tempname=tempname+"Belonging to "+"@";
	}
	if(document.forms[0].txt_doorno.value!=document.forms[0].old_txt_doorno.value)
	{
		temp=temp+"old_txt_doorno"+"@"; 		tempname=tempname+"Door No"+"@";
	}
	if(document.forms[0].txt_address1.value!=document.forms[0].old_txt_address1.value)
	{
		temp=temp+"old_txt_address1"+"@"; 		tempname=tempname+"Address 1"+"@";
	}
	if(document.forms[0].txt_city.value!=document.forms[0].old_txt_city.value)
	{
		temp=temp+"old_txt_city"+"@"; 		tempname=tempname+"City "+"@";
	}
	if(document.forms[0].txt_address2.value!=document.forms[0].old_txt_address2.value)
	{
		temp=temp+"old_txt_address2"+"@"; 		tempname=tempname+"Address 2"+"@";
	}
	if(document.forms[0].txt_state.value!=document.forms[0].old_txt_state.value)
	{
		temp=temp+"old_txt_state"+"@"; 		tempname=tempname+"State"+"@";
	}
	if(document.forms[0].txt_district.value!=document.forms[0].old_txt_district.value)
	{
		temp=temp+"old_txt_district"+"@"; 		tempname=tempname+"District "+"@";
	}
	if(document.forms[0].txt_country.value!=document.forms[0].old_txt_country.value)
	{
		temp=temp+"old_txt_country"+"@"; 		tempname=tempname+"Country "+"@";
	}
	if(document.forms[0].txt_pin.value!=document.forms[0].old_txt_pin.value)
	{
		temp=temp+"old_txt_pin"+"@"; 		tempname=tempname+"Pin Code "+"@";
	}
	
	//RC Book Submission Date
	if(document.forms[0].txt_rcsubdate.value!=document.forms[0].old_txt_rcsubdate.value)
	{
		temp=temp+"old_txt_rcsubdate"+"@"; 		tempname=tempname+"RC Book Submission Date"+"@";
	}
	//Vehicle Hypothecation Date
	if(document.forms[0].txt_veh_hypodate.value!=document.forms[0].old_txt_veh_hypodate.value)
	{
		temp=temp+"old_txt_veh_hypodate"+"@"; 		tempname=tempname+"Vehicle Hypothecation Date"+"@";
	}
	//Last Inspection Date
	if(document.forms[0].txt_lst_inspdate.value!=document.forms[0].old_txt_lst_inspdate.value)
	{
		temp=temp+"old_txt_lst_inspdate"+"@"; 		tempname=tempname+"Last Inspection Date"+"@";
	}

	//Tax paid up to
	if(document.forms[0].txt_tax_paid.value!=document.forms[0].old_txt_tax_paid.value)
	{
		temp=temp+"old_txt_tax_paid"+"@"; 		tempname=tempname+"Tax paid up to"+"@";
	}

	//Insurance valid up to
	if(document.forms[0].txt_ins_valid.value!=document.forms[0].old_txt_ins_valid.value)
	{
		temp=temp+"old_txt_ins_valid"+"@"; 		tempname=tempname+"Insurance valid up to"+"@";
	}

	//Name of the Dealer
	if(document.forms[0].txt_dealer_name.value!=document.forms[0].old_txt_dealer_name.value)
	{
		temp=temp+"old_txt_dealer_name"+"@"; 		tempname=tempname+"Name of the Dealer"+"@";
	}

	//Contact No
	if(document.forms[0].txt_dealercont.value!=document.forms[0].old_txt_dealercont.value)
	{
		temp=temp+"old_txt_dealercont"+"@"; 		tempname=tempname+"Dealer Contact No"+"@";
	}

	//Address1 
	if(document.forms[0].txt_dealeraddress1.value!=document.forms[0].old_txt_dealeraddress1.value)
	{
		temp=temp+"old_txt_dealeraddress1"+"@"; 		tempname=tempname+"Dealer Address1"+"@";
	}

	//City
	if(document.forms[0].txt_dealercity.value!=document.forms[0].old_txt_dealercity.value)
	{
		temp=temp+"old_txt_dealercity"+"@"; 		tempname=tempname+"Dealer City"+"@";
	}

	//Address2
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

	//Dealer TIN
	if(document.forms[0].txt_dealertin.value!=document.forms[0].old_txt_dealertin.value)
	{
		temp=temp+"old_txt_dealertin"+"@"; 		tempname=tempname+"Dealer Tin/GST No "+"@";
	}
	if(document.forms[0].sel_salutationText.value=="---Select-----")
	{
		document.forms[0].sel_salutationText.value="";
	}
	
	if(document.forms[0].sel_salutationText.value!=document.forms[0].old_sel_salutationText.value)
	{
		temp=temp+"old_sel_salutationText"+"@"; 		tempname=tempname+"Saluatation name "+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securitiesVehicle.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateSecurityVehicle";
		document.forms[0].hidBeanGetMethod.value="getSecurityVehicle";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function callDistrict() {
	var varstate = document.forms[0].hid_state.value;
	if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_cbscustid.value =="") {
		if (document.forms[0].txt_city.value == "") {
			ShowAlert(112, "City");
			document.forms[0].txt_city.focus();
			return;
		}
		if (document.forms[0].hid_state.value == "") {
			alert("Please Reselect the City");
			document.forms[0].txt_city.focus();
			return;
		} else {
			var varQryString = appURL+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+ varstate + "&code=VEH";
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
			prop = prop + ",left=200,top=200";
			window.open(varQryString, title, prop);
		}
	}
}

function callDistrict1() {
	
	var varstate = document.forms[0].hid_dealerstate.value;
	if (document.forms[0].cmdsave.disabled == false ) {
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
			var varQryString = appURL+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+ varstate + "&code=VEH1";
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
			prop = prop + ",left=200,top=200";
			window.open(varQryString, title, prop);
		}
	}
}
function showCitySearch1(val1) {
	if ((val1 == "VEH1")) {
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
function showCitySearch(val1) {
	if ((val1 == "VEH")) {
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
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false )
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
	}
	
}
function callCntrySearch1(varTextControl,varHidControl)
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
function chkvaluationdet()
{
	var varAlert="";
	if(document.forms[0].sel_VehicleType.value=="2" && varValuationDate=="")
	{
		varAlert="Date of Valuation (as per report)"+"\n";
	}
	if(document.forms[0].sel_VehicleType.value=="2" && varValSubmittedDate=="")
	{
		varAlert=varAlert+"Date of submission of request for valuation by bank"+"\n";
	}
	if(document.forms[0].sel_VehicleType.value=="2" && varValRecvDate=="")
	{
		varAlert=varAlert+"Date of receipt of valuation report by bank"+"\n";
	}

	if(varAlert!="")
	{
		alert("Enter following Details in securities tab,\n"+varAlert);
		document.forms[0].cmdsave.disabled=true;
		return;
	}
}


function callCalender(fname)
{
	if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL,fname);
		}
}


function getdata()
{
	if(document.all.sel_VehicleType.value=="2")
	{
		document.all.old.style.display="table-row";	
		document.all.old1.style.display="table-row";
		document.all.cha_no.style.display="table-cell";	
		document.all.eng_no.style.display="block";	
		document.all.reg_no.style.display="block";	
		document.all.id1.innerHTML="*";	
		document.all.id2.innerHTML="*";	
		document.all.id3.innerHTML="*";	
		document.all.id4.innerHTML="*";	
		document.all.id5.innerHTML="*";	
		document.all.id6.innerHTML="*";	
		document.all.id7.innerHTML="*";	
		document.all.id8.innerHTML="*";	
		document.all.id9.innerHTML="";	
		document.all.id10.innerHTML="";	
		document.all.iddealer.innerHTML="Dealer/Seller Details";
		document.all.iddealer1.innerHTML="Name of the Dealer/Seller";
		
	}else if(document.all.sel_VehicleType.value=="1"||document.all.sel_VehicleType.value=="0")
	{
		document.all.old.style.display="none";	
		document.all.old1.style.display="none";
		document.all.cha_no.style.display="none";	
		document.all.eng_no.style.display="none";	
		document.all.reg_no.style.display="none";	
		document.all.id1.innerHTML="*";	
		document.all.id2.innerHTML="*";	
		document.all.id3.innerHTML="*";	
		document.all.id4.innerHTML="*";	
		document.all.id5.innerHTML="*";	
		document.all.id6.innerHTML="*";	
		document.all.id7.innerHTML="*";	
		document.all.id8.innerHTML="*";	
		document.all.id9.innerHTML="*";	
		document.all.id10.innerHTML="*"	;
		document.all.iddealer.innerHTML="Dealer Details";
		document.all.iddealer1.innerHTML="Name of the Dealer";
	}
}	


function hidd()
{
	if(sel_VehicleType=="1"||sel_VehicleType=="0"||sel_VehicleType=="")
	{
		document.all.old.style.display="none";
		document.all.old1.style.display="none";
	}
	if(document.all.sel_VehicleType.value=="1" || document.all.sel_VehicleType.value=="0"){
		document.all.cha_no.style.display="none";	
		document.all.eng_no.style.display="none";	
		document.all.reg_no.style.display="none";
	}
	if(sel_VehicleType=="2")
	{
		document.all.id1.innerHTML="*";	
		document.all.id2.innerHTML="*";	
		document.all.id3.innerHTML="*";	
		document.all.id4.innerHTML="*";	
		document.all.id5.innerHTML="*";	
		document.all.id6.innerHTML="*";	
		document.all.id7.innerHTML="*";	
		document.all.id8.innerHTML="*";	
		document.all.id9.innerHTML="";	
		document.all.id10.innerHTML="";	
		document.all.iddealer.innerHTML="Dealer/Seller Details";
		document.all.iddealer1.innerHTML="Name of the Dealer/Seller";
		
	}else
	{
		document.all.id1.innerHTML="*";	
		document.all.id2.innerHTML="*";	
		document.all.id3.innerHTML="*";	
		document.all.id4.innerHTML="*";	
		document.all.id5.innerHTML="*";	
		document.all.id6.innerHTML="*";	
		document.all.id7.innerHTML="*";	
		document.all.id8.innerHTML="*";	
		document.all.id9.innerHTML="*";	
		document.all.id10.innerHTML="*"	
		document.all.iddealer.innerHTML="Dealer Details";
		document.all.iddealer1.innerHTML="Name of the Dealer";	
	}
	
}		

function placeval()
{
	var docs = vardocs.split("@");
	 for(i=0;i<docs.length;i++)
	  {
		if(docs[i]=="RC")
		{
			document.forms[0].chk_doc[0].checked=true;
		}
		else if(docs[i]=="TPR")
		{
			document.forms[0].chk_doc[1].checked=true;
		}
		else if(docs[i]=="VR")
		{
			document.forms[0].chk_doc[2].checked=true;
		}
		else if(docs[i]=="CND")
		{
			document.forms[0].chk_doc[3].checked=true;
		}
		else if(docs[i]=="IP")
		{
			document.forms[0].chk_doc[4].checked=true;
		}
	  }
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?&pagename=sec_vehicle";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
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
				<jsp:param name="subpageid" value="208" />
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
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Vehicle Details</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="18" />
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
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Vehicle Details</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="208" />
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
	<jsp:param name="pageid" value="18" />
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
		<jsp:param name="pageid" value="18" />
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
				<td class="page_flow" colspan="2">Home -&gt; Securities -&gt; Vehicle</td>
			</tr>
		</table>
		<table width="50%" border="0" cellspacing="1" cellpadding="0" align="center"
			class="outertable">
			<tr>
			<td class="sub_tab_inactive_new" WIDTH="50%" align="center">
				<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
				Security Details</a></b>
			</td>
			<td class="sub_tab_active_new" align="center"><b>Vehicle</b></td>
			</tr>
		</table>
<%} %>
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
										<td width="20%">Vehicle Type <span class="mantatory">*&nbsp;</span></td>

										<td width="3%">&nbsp;</td>
										<td width="27%" nowrap><select name="sel_VehicleType" id="sel_VehicleType"
											tabindex="1" onchange="chkvaluationdet();getdata();">
										  <option value="0">&lt;----Select----&gt;</option>
										  <option value="1">New</option>
										  <option value="2">Old</option>
										</select></td>
										<td width="20%">Company<span class="mantatory">*&nbsp;</span></td>
										<td width="3%" nowrap>&nbsp;</td>
										<td width="27%" nowrap><input
											name="txt_company" type="text" id="txt_company" tabindex="2"
											value="<%=Helper.correctNull((String)hshValues.get("sec_company"))%>" size="30"
											maxlength="50"></td>
									</tr>
									
									 <tr id="old"> 
							        	<td >Tax paid up to</td>
							        	<td width="3%" nowrap>&nbsp;</td> 
							        	
							        	<td >
						                    <input type="text" name="txt_tax_paid" onBlur="checkDate(this);"
											value="<%=Helper.correctNull((String)hshValues.get("sec_taxpaid"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
											<a style="vertical-align: middle" onClick="callCalender('txt_tax_paid')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>&nbsp;&nbsp;
										</td>
							        
							        	<td >Insurance valid up to</td>  
							        	<td width="3%" nowrap>&nbsp;</td> 
							        	
							        	<td >
						                    <input type="text" name="txt_ins_valid" onBlur="checkDate(this);"
											value="<%=Helper.correctNull((String)hshValues.get("sec_insvalid"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
											<a style="vertical-align: middle" onClick="callCalender('txt_ins_valid')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
											alt="Select date from calender"></a>&nbsp;&nbsp;
										</td>
							        </tr>
						            <tr id="old1"> 
							        	<td colspan="2">Documents verified with the Originals</td>
							        	<td colspan="4">
											<input type="checkbox" style="border-style:none" name="chk_doc" value="RC"/> Copy of RC &nbsp; 
											<input type="checkbox" style="border-style:none" name="chk_doc" value="TPR"/> Tax paid receipt &nbsp; 
											<input type="checkbox" style="border-style:none" name="chk_doc" value="VR"/> Valuation report &nbsp; 
											<input type="checkbox" style="border-style:none" name="chk_doc" value="CND"/> Charge noted details &nbsp;
											<input type="checkbox" style="border-style:none" name="chk_doc" value="IP"/> Insurance policy  &nbsp; 
											 
										</td>   
						            </tr>
	           
									<tr>
										<td>Vehicle Category <span class="mantatory">*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><select name="sel_Category" id="sel_Category" tabindex="3">
										  <option value="0" selected>&lt;----Select----&gt;</option>
										  <option value="1">Two Wheeler</option>
										  <option value="2">Three Wheeler</option>
										  <option value="3">Four Wheeler</option>
										</select></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>Make / Model<span class="mantatory">*&nbsp;</span></td>

										<td>&nbsp;</td>
										<td><input type="text" name="txt_make" size="20"
											maxlength="20" tabindex="4"
											value="<%=Helper.correctNull((String) hshValues.get("sec_make"))%>">&nbsp;<input
											type="text" name="txt_model" size="20" maxlength="20" tabindex="5"
											value="<%=Helper.correctNull((String) hshValues.get("sec_model"))%>" onkeypress="allowNumber(this);">
										</td>
										<td>Age of the vehicle<span class="mantatory">*&nbsp;</span></td>

										<td>&nbsp;</td>
									  <td><input name="txt_vehicleage" type="text" id="txt_vehicleage" style="text-align: right"
											onKeyPress="allowNumber(this)" tabindex="6"
											value="<%=Helper.correctNull((String)hshValues.get("sec_age"))%>" size="6"
											maxlength="3">
&nbsp;(in
									  Years)</td>
									</tr>
									<tr>
										<td nowrap="nowrap">Purchase Price / Invoice Price <span class="mantatory">*&nbsp;</span></td>
										<td><%=ApplicationParams.getCurrency()%></td>
										<td><lapschoice:CurrencyTag
						  		name="txt_PurcInvoice_Price" tabindex="6" size="12" maxlength="12" 
						  		value='<%=Helper.correctNull((String)hshValues.get("sec_purchasevalue"))%>'/></td>
										<td nowrap="nowrap">Present / Book Value <span class="mantatory">*&nbsp;</span></td>
										<td><%=ApplicationParams.getCurrency()%></td>
										<td><lapschoice:CurrencyTag
						  		name="txt_Present_BookVal" tabindex="7" size="12" maxlength="12" 
						  		value='<%=Helper.correctNull((String)hshValues.get("sec_bookvalue"))%>'/></td>
									</tr>
									<tr>
										<td nowrap="nowrap">Registration No.<span id="reg_no" class="mantatory">*</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_regno" size="25"
											maxlength="50" style="text-align: left" tabindex="8"
											value="<%=Helper.correctNull((String)hshValues.get("sec_regno"))%>">
										</td>
										<td width="133" nowrap="nowrap">Engine No./ HP<span id="eng_no" class="mantatory">*</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_engineno" tabindex="9"
											maxlength="50" style="text-align: left" size="25"
											value="<%=Helper.correctNull((String)hshValues.get("sec_hpno"))%>">
										</td>
									</tr>
									<tr>
										<td nowrap="nowrap">Chassis No.<span id="cha_no" class="mantatory">*</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_chassisno" size="25"
											maxlength="50" style="text-align: left" tabindex="8"
											value="<%=Helper.correctNull((String)hshValues.get("SEC_CHASSISNO"))%>">
										</td>
										<td>Registration State<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><b> 
											<select name="sel_state" >
												<option value="">--Select--</option>
												<lapschoice:statemaster apptype="Code"/>
											</select> </b>
										</td>
									</tr>
									
									<tr>
										<td nowrap>RC Book Submission Date</td>

										<td>&nbsp;</td>
										<td> <input type="text" name="txt_rcsubdate" onBlur="checkDate(this);checkmaxdate(this,curdate);"
												value="<%=Helper.correctNull((String)hshValues.get("SEC_RC_SUBDATE"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
												<a style="vertical-align: middle" onClick="callCalender('txt_rcsubdate');"
												onMouseOver="window.status='Date Picker';return true;"
												onMouseOut="window.status='';return true;"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
												alt="Select date from calender"></a>
										</td>
										<td>Vehicle Hypothecation Date</td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_veh_hypodate" onBlur="checkDate(this);checkmaxdate(this,curdate);"
												value="<%=Helper.correctNull((String)hshValues.get("SEC_VEH_HYPODATE"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
												<a style="vertical-align: middle" onClick="callCalender('txt_veh_hypodate')"
												onMouseOver="window.status='Date Picker';return true;"
												onMouseOut="window.status='';return true;"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
												alt="Select date from calender"></a>
										
										</td>
									</tr>
									<tr>
										<td nowrap>Last Inspection Date</td>

										<td>&nbsp;</td>
										<td> <input type="text" name="txt_lst_inspdate" onBlur="checkDate(this);checkmaxdate(this,curdate);"
												value="<%=Helper.correctNull((String)hshValues.get("SEC_LAST_INSPDATE"))%>" maxlength="10" size="15" alt="Select date from calender" href="#">
												<a style="vertical-align: middle" onClick="callCalender('txt_lst_inspdate')"
												onMouseOver="window.status='Date Picker';return true;"
												onMouseOut="window.status='';return true;"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
												alt="Select date from calender"></a>
										
										</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									
									
									<tr>
									<td colspan="6" class="datagrid"><span id="iddealer">Dealer Details</span></td>
									</tr>
									
									<tr>
										<td><span id="iddealer1">Name of the Dealer</span><span class="mantatory" id="id1">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealer_name" tabindex="10" onKeyPress="allowAlphabetsForName()"
										maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_dealername"))%>"></td>
										<td>Contact No<span class="mantatory" id="id2">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercont" tabindex="11" onKeyPress="allowNumber(this)" 
										maxlength="10" size="18" value="<%=Helper.correctNull((String)hshValues.get("sec_dealercont"))%>"></td>
									</tr>
									<tr>
										<td rowspan="2" valign="top">Address<span class="mantatory" id="id3">&nbsp;*&nbsp;</span> </td>
										<td rowspan="2">&nbsp;</td>
										<td><input type="text" name="txt_dealeraddress1" tabindex="12"
										maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_dealeraddress1"))%>"></td>
										<td>City<span class="mantatory" id="id4">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercity" tabindex="15"
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercity"))%>" >
										<input type="hidden" name="hid_dealercity" value="<%=Helper.correctNull((String)hshValues.get("sec_dealercitycode"))%>"> &nbsp;  <a href="#" onClick="showCitySearch('VEH');" style="cursor: hand" tabindex="13">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
										</tr>
									<tr>
										<td><input type="text" name="txt_dealeraddress2" tabindex="14"
										maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_dealeraddress2"))%>"></td>
										<td>State<span class="mantatory" id="id5">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealerstate" tabindex="16"
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerstate"))%>" >
										<input type="hidden" name="hid_dealerstate" value="<%=Helper.correctNull((String)hshValues.get("sec_dealerstatecode"))%>"> &nbsp; </td>
									</tr>
									<tr>
										<td>District<span class="mantatory" id="id6">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealerdistrict" tabindex="13"
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealerdistrict"))%>" >
										<input type="hidden" name="hid_dealerdistrict"value="<%=Helper.correctNull((String)hshValues.get("sec_dealerdistrictcode"))%>"> &nbsp; <a href="#" onClick="callDistrict1();" style="cursor: hand" tabindex="14">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
									
										<td>Country<span class="mantatory" id="id7">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercountry" tabindex="17"
										size="25" value="<%=Helper.correctNull((String)hshValues.get("txt_dealercountry"))%>" >
										<input type="hidden" name="hid_dealercountry" value="<%=Helper.correctNull((String)hshValues.get("sec_dealercountrycode"))%>"> &nbsp; <a href="#"
										onClick="callCntrySearch('txt_dealercountry','hid_dealercountry')"
										style="cursor:hand" tabindex="8"><img
										src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
										border="0" tabindex="21"></a> </td>
									</tr>
									<tr>
										<td>Pin Code<span class="mantatory" id="id8">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealerpin" tabindex="18"
										maxlength="6" size="10" value="<%=Helper.correctNull((String)hshValues.get("sec_dealerpin"))%>" onKeyPress="allowNumber(this)" > </td>
										<td>Mail ID</td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealermail" 	onBlur="isEmailAddr(document.forms[0].txt_dealermail.value,document.forms[0].txt_dealermail)"
										tabindex="18"
										maxlength="25" size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_dealermail"))%>" > </td>
									</tr>
									
									<tr>
										<td>Dealer Code <span class="mantatory" id="id9">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealercode" tabindex="18" onKeyPress="allowAlphaNumeric()"
										maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("sec_dealercode"))%>"> </td>
										<td> Dealer Tin/GST No.<span class="mantatory" id="id10">&nbsp;*&nbsp;</span></td>
										<td>&nbsp;</td>
										<td><input type="text" name="txt_dealertin" tabindex="18" maxlength="15" onKeyPress="allowAlphaNumeric()"
										size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_dealertin"))%>" > </td>
									</tr>
									
						
									<tr>
									<td colspan="6" class="datagrid">Vehicle to be parked in </td>
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
									<td>Belonging to<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>&nbsp;</td>
									<td><select name="sel_salutation" style="width:25%">
											<option value="">---Select-----</option>
											<%
												String apptypecon = "1";
											%>
										<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
										</select>&nbsp;&nbsp;
										<input type="text" name="txt_belongsto" tabindex="10"
									maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_ownername"))%>"></td>
									<td>Door No<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>&nbsp;</td>
									<td><input type="text" name="txt_doorno" tabindex="11"
									maxlength="10" size="7" value="<%=Helper.correctNull((String)hshValues.get("sec_ownerdoorno"))%>"></td>
									</tr>
									<tr>
									<td rowspan="2" valign="top">Address <span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td rowspan="2">&nbsp;</td>
									<td><input type="text" name="txt_address1" tabindex="12"
									maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_owneraddress1"))%>"></td>
									<td>City<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>&nbsp;</td>
									<td><input type="text" name="txt_city" tabindex="15"
									size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_ownercityname"))%>">
									<input type="hidden" name="hid_city" value="<%=Helper.correctNull((String)hshValues.get("sec_ownercitycode"))%>"> &nbsp;  <a href="#" onClick="showCitySearch1('VEH1');" style="cursor: hand" tabindex="13">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
								</a></td>
									</tr>
									<tr>
									<td><input type="text" name="txt_address2" tabindex="14"
									maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_owneraddress2"))%>"></td>
									<td>State<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>&nbsp;</td>
									<td><input type="text" name="txt_state" tabindex="16"
									size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_ownerstatename"))%>">
									<input type="hidden" name="hid_state" value="<%=Helper.correctNull((String)hshValues.get("sec_ownerstatecode"))%>"> &nbsp; </td>
									</tr>
									<tr>
									<td>District<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>&nbsp;</td>
									<td><input type="text" name="txt_district" tabindex="13"
									size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_ownerdistrictname"))%>">
									<input type="hidden" name="hid_district"value="<%=Helper.correctNull((String)hshValues.get("sec_ownerdistrictcode"))%>"> &nbsp; <a href="#" onClick="callDistrict();" style="cursor: hand" tabindex="14">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
									</a></td>
									
									<td>Country<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>&nbsp;</td>
									<td><input type="text" name="txt_country" tabindex="17"
									size="25" value="<%=Helper.correctNull((String)hshValues.get("sec_ownercountryname"))%>">
									<input type="hidden" name="hid_country" value="<%=Helper.correctNull((String)hshValues.get("sec_ownercountrycode"))%>"> &nbsp; <a href="#"
													onClick="callCntrySearch1('txt_country','hid_country')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> </td>
									</tr>
									<tr>
									<td>Pin Code<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>&nbsp;</td>
									<td><input type="text" name="txt_pin" tabindex="18"
									maxlength="6" size="10" value="<%=Helper.correctNull((String)hshValues.get("sec_ownerzipcode"))%>" onKeyPress="allowNumber(this)" > </td>
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
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
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

<input type="hidden" name="old_txt_company" value="<%=Helper.correctNull((String) hshValues.get("sec_company"))%>">
<input type="hidden" name="old_txt_make" value="<%=Helper.correctNull((String) hshValues.get("sec_make"))%>">
<input type="hidden" name="old_txt_model" value="<%=Helper.correctNull((String) hshValues.get("sec_model"))%>">
<input type="hidden" name="old_txt_vehicleage" value="<%=Helper.correctNull((String) hshValues.get("sec_age"))%>">
<input type="hidden" name="old_txt_PurcInvoice_Price" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_purchasevalue"))))%>">
<input type="hidden" name="old_txt_Present_BookVal" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("sec_bookvalue"))))%>">
<input type="hidden" name="old_txt_regno" value="<%=Helper.correctNull((String) hshValues.get("sec_regno"))%>">
<input type="hidden" name="old_txt_engineno" value="<%=Helper.correctNull((String) hshValues.get("sec_hpno"))%>">
<input type="hidden" name="old_txt_chassisno" value="<%=Helper.correctNull((String) hshValues.get("SEC_CHASSISNO"))%>">
<input type="hidden" name="old_txt_belongsto" value="<%=Helper.correctNull((String) hshValues.get("sec_ownername"))%>">
<input type="hidden" name="old_txt_doorno" value="<%=Helper.correctNull((String) hshValues.get("sec_ownerdoorno"))%>">
<input type="hidden" name="old_txt_address1" value="<%=Helper.correctNull((String) hshValues.get("sec_owneraddress1"))%>">
<input type="hidden" name="old_txt_city" value="<%=Helper.correctNull((String) hshValues.get("sec_ownercityname"))%>">
<input type="hidden" name="old_txt_address2" value="<%=Helper.correctNull((String) hshValues.get("sec_owneraddress2"))%>">
<input type="hidden" name="old_txt_state" value="<%=Helper.correctNull((String) hshValues.get("sec_ownerstatename"))%>">
<input type="hidden" name="old_txt_district" value="<%=Helper.correctNull((String) hshValues.get("sec_ownerdistrictname"))%>">
<input type="hidden" name="old_txt_country" value="<%=Helper.correctNull((String) hshValues.get("sec_ownercountryname"))%>">
<input type="hidden" name="old_txt_pin" value="<%=Helper.correctNull((String) hshValues.get("sec_ownerzipcode"))%>">

<input type="hidden" name="old_txt_rcsubdate" value="<%=Helper.correctNull((String) hshValues.get("SEC_RC_SUBDATE"))%>">
<input type="hidden" name="old_txt_veh_hypodate" value="<%=Helper.correctNull((String) hshValues.get("SEC_VEH_HYPODATE"))%>">
<input type="hidden" name="old_txt_lst_inspdate" value="<%=Helper.correctNull((String) hshValues.get("SEC_LAST_INSPDATE"))%>">

<input type="hidden" name="old_txt_dealer_name" value="<%=Helper.correctNull((String) hshValues.get("sec_dealername"))%>">
<input type="hidden" name="old_txt_dealercont" value="<%=Helper.correctNull((String) hshValues.get("sec_dealercont"))%>">
<input type="hidden" name="old_txt_dealeraddress1" value="<%=Helper.correctNull((String) hshValues.get("sec_dealeraddress1"))%>">
<input type="hidden" name="old_txt_dealercity" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercity"))%>">
<input type="hidden" name="old_txt_dealeraddress2" value="<%=Helper.correctNull((String) hshValues.get("sec_dealeraddress2"))%>">
<input type="hidden" name="old_txt_dealerstate" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerstate"))%>">
<input type="hidden" name="old_txt_dealerdistrict" value="<%=Helper.correctNull((String) hshValues.get("txt_dealerdistrict"))%>">
<input type="hidden" name="old_txt_dealercountry" value="<%=Helper.correctNull((String) hshValues.get("txt_dealercountry"))%>">
<input type="hidden" name="old_txt_dealerpin" value="<%=Helper.correctNull((String) hshValues.get("sec_dealerpin"))%>">
<input type="hidden" name="old_txt_dealermail" value="<%=Helper.correctNull((String) hshValues.get("sec_dealermail"))%>">
<input type="hidden" name="old_txt_tax_paid" value="<%=Helper.correctNull((String) hshValues.get("sec_taxpaid"))%>">
<input type="hidden" name="old_txt_ins_valid" value="<%=Helper.correctNull((String) hshValues.get("sec_insvalid"))%>">
<input type="hidden" name="old_txt_docs" value="<%=Helper.correctNull((String) hshValues.get("SEC_DOCS"))%>">

<input type="hidden" name="old_txt_dealercode" value="<%=Helper.correctNull((String) hshValues.get("sec_dealercode"))%>">
<input type="hidden" name="old_txt_dealertin" value="<%=Helper.correctNull((String) hshValues.get("sec_dealertin"))%>">


<input type="hidden" name="hidchk_doc">
<input type="hidden" name="old_sel_salutationText">	
<input type="hidden" name="sel_salutationText">
<input type="hidden" name="hidsalutation">
<input type="hidden" name="old_sel_CategoryText">
<input type="hidden" name="old_sel_VehicleTypeText">

<input type="hidden" name="sel_CategoryText">
<input type="hidden" name="sel_VehicleTypeText">

<input type="hidden" name="sel_stateText">
<input type="hidden" name="old_sel_stateText">

</form>
</body>
</html>
