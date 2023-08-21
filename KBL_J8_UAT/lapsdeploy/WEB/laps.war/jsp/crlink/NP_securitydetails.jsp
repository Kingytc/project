<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<% String stroptions=" "; 
String strApplnt = request.getParameter("applnt");
String loantype=Helper.correctNull((String)hshValues.get("loan_selecttype"));
String strCanaraSyndBank=ApplicationParams.getStrCbsInterfaceflag();
String strsecurityOff="";
if(strCanaraSyndBank.equalsIgnoreCase("C")){
strsecurityOff=Helper.correctNull((String)hshValues.get("SECURITY_OFFERED"));
String strAreaUnit="Sq.Ft";
}
//out.println(hshValues);
%>
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 350;
  overflow: auto;
}

a:hover {  color: #FF3300}
</STYLE>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script LANGUAGE="JavaScript"	src="<%=ApplicationParams.getAppUrl()%>js/share/browservalidation.js"></script>
<script>
var editlockflag="<%=hshValues.get("editlock")%>";
var editflag = 1;
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strvalue="";
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var varappgurantor = "<%=Helper.correctNull((String)hshValues.get("app_gurantor"))%>";
var varsecurityOff = "<%=strsecurityOff%>";
var varCanaraSyndBank = "<%=strCanaraSyndBank%>";
var varLocation = "<%=Helper.correctNull((String)hshValues.get("COLL_LOCATION"))%>";
var varPropertyType = "<%=Helper.correctNull((String)hshValues.get("COLL_TYPEOFPROPERTY"))%>";
var varCollateraltype = "<%=Helper.correctNull((String)hshValues.get("COLL_PAGETYPE"))%>"; 
//alert(appURL);
 function callCalender()
 {
	 showCal(appURL,'valuationdate');
 }
 function callCalender1()
 {
	 showCal(appURL,'inspectiondate');
 }
 function callCalender2()
 {
	 showCal(appURL,'valuationdate1');
 }
 
function placeValues()
{
	document.forms[0].sel_securityoff.disabled=true;
/*if(varappgurantor!="")
			{
				document.forms[0].appguarantor.value=varappgurantor;
				
				
			}
			else 
			{
				document.forms[0].appguarantor.value=0;
			}*/
	disableFields(true);
	<%if(!Helper.correctNull((String)hshValues.get("advocate_opinion")).equalsIgnoreCase("")){ %>
	document.forms[0].advocateopinion.value = "<%=Helper.correctNull((String)hshValues.get("advocate_opinion"))%>"
	<%}%>
	if (document.forms[0].appstatus.value != "Open/Pending")
	{
		alert("Cannot modify --> APPROVED APPLICATION !!!")
		callDisableControls(true,true,true,true,false);
	}else if(strappeditsameregbranch!="")
	{
		if(strappeditsameregbranch=="disablefalse")
		{
			callDisableControls(false,true,true,true,false);
		}
		else if(strappeditsameregbranch=="disabletrue")
		{
			callDisableControls(true,true,true,true,false);
		}
	}
	
//	document.forms[0].appguarantor.disabled=true;
	document.forms[0].advocateopinion.disabled=true;
	if(varCanaraSyndBank=="C"){
		if(varsecurityOff!=""){
		document.forms[0].sel_securityoff.value=varsecurityOff;
		document.forms[0].sel_securityoff.disabled = true;
		}
		if(varsecurityOff == "Y")
		{
			if(varCollateraltype!=""){
			document.forms[0].sel_collateraltype.value=varCollateraltype;
			}
			else
			{
			document.forms[0].sel_collateraltype.value="S";
			}
			if(varCollateraltype == "1")
			{
			if(varPropertyType!=""){
			document.forms[0].sel_propertytype.value=varPropertyType;
			}
			else
			{
			document.forms[0].sel_propertytype.value="0";
			}
			document.forms[0].txt_areaunit.disabled=true;			
			}
		}
		onchangepropertycollateral();
		onchangeleased();
		onchangeCollateraltype();
	}
}
function callDisableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	document.forms[0].cmddel.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				 document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="Select-One")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			
		}

	}
function doEdit()
{
//	document.forms[0].sel_securityoff.disabled=false;
	document.forms[0].sel_securityoff.disabled=true;
	disableFields(false);
	enableButtons(true,false,false,true,true);
		document.forms[0].advocateopinion.disabled = false;
		//document.forms[0].appguarantor.disabled=false;

		//document.forms[0].collateral_code1.re=true;   
		document.forms[0].collateral_code1.readOnly=true;  
		if(document.forms[0].sel_securityoff.value == "Y")
		{
		if(document.forms[0].sel_collateraltype.value == "2")
		{
		document.forms[0].txt_CollCode.readOnly=true;  
		}
		}    
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateSupply";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comrawsupply.jsp";
		document.forms[0].submit();
	 }
		
}
function doApply()
{
		/*if(document.forms[0].property.value=="")
		{
			alert("Security Particulars for Housing/Vehicle Loans(Furnish details of security such as extent,Sy.No, Khatha No, Address and the name of the owner/owners,Model of Vehicle, Name of the Vehicle, etc.,) ");
			document.forms[0].property.focus();
			return false;
		}
		if(document.forms[0].appguarantor.value == "0")
		{
	      alert("Select Guarantor Status");
		  document.forms[0].appguarantor.focus();
		  return false;
		}*/
		if(varCanaraSyndBank=="C"){
			if(document.forms[0].sel_securityoff.value == "s" || document.forms[0].sel_securityoff.value == ""){
			      alert("Select Whether Offered as Security");
				  document.forms[0].sel_securityoff.focus();
				  return false;	
			}
			if(document.forms[0].sel_securityoff.value == "Y")
			{
			if(document.forms[0].sel_collateraltype.value == "S" || document.forms[0].sel_collateraltype.value == ""){
			      alert("Select Collateral Type");
				  document.forms[0].sel_collateraltype.focus();
				  return false;	
			}	
			if(document.forms[0].sel_collateraltype.value == "1"){
			if(document.forms[0].sel_location.value == ""){
			      alert("Enter Property Location");
				  document.forms[0].sel_location.focus();
				  return false;	
			}
			if(document.forms[0].txt_areaunit.value == ""){
			      alert("Enter Area Unit");
				  document.forms[0].txt_areaunit.focus();
				  return false;	
			}
			if(document.forms[0].totalarea.value == ""){
			      alert("Enter Total Area");
				  document.forms[0].totalarea.focus();
				  return false;	
			}
			if(document.forms[0].sel_propertytype.value == "S" || document.forms[0].sel_propertytype.value == ""){
			      alert("Select Type of Property");
				  document.forms[0].sel_propertytype.focus();
				  return false;	
			}
			if(document.forms[0].sel_propertytype.value == "1")
			{
			if(document.forms[0].txt_expirydate.value == ""){
			      alert("Enter Date of Expiry");
				  document.forms[0].txt_expirydate.focus();
				  return false;	
			}
			}
			if(document.forms[0].forced_shareval.value == ""){
			      alert("Enter Forced sale Value");
				  document.forms[0].forced_shareval.focus();
				  return false;	
			}
			if(document.forms[0].txt_propdescription.value == ""){
			      alert("Enter Property Description");
				  document.forms[0].txt_propdescription.focus();
				  return false;	
			}
            var varPropDesc = document.forms[0].txt_propdescription.value;
			
			if(varPropDesc.length > 40){
				alert("Property Description should be less than 40 character");
				document.forms[0].txt_propdescription.focus();
				return false;
			}
			if(document.forms[0].collateral_code1.value == ""){
			      alert("Select Collateral Code");
				  document.forms[0].collateral_code1.focus();
				  return false;	
			}
			if(document.forms[0].txt_deeddetails.value == ""){
			      alert("Enter Deed details");
				  document.forms[0].txt_deeddetails.focus();
				  return false;	
			}
			document.forms[0].txt_areaunit.disabled=false;
			}
			else
			{
				if(document.forms[0].sel_collateraltype.value != "2"){
			if(document.forms[0].txt_noofunit.value == ""){
			      alert("Enter No of Units");
				  document.forms[0].txt_noofunit.focus();
				  return false;	
			}
			if(document.forms[0].txt_serialNo.value == ""){
			      alert("Enter Serial No");
				  document.forms[0].txt_serialNo.focus();
				  return false;	
			}
			if(document.forms[0].txt_details.value == ""){
			      alert("Enter Details");
				  document.forms[0].txt_details.focus();
				  return false;	
			}
			if(document.forms[0].collateral_code.value == ""){
			      alert("Select Collateral Code");
				  document.forms[0].collateral_code.focus();
				  return false;	
			}
			}
			}			
			}
			if(document.forms[0].sel_collateraltype.value == "1"){
				if(document.forms[0].valuationvalue.value == "0"){
				      alert("Valuation value should be greater than 0");
					  document.forms[0].valuationvalue.focus();
					  return false;	
				}
			}
		}
		var flag=validate();
		if(flag )
		{
		//document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="NationalPortal"
		document.forms[0].hidBeanMethod.value="updateProcess2Data";
		document.forms[0].hidBeanGetMethod.value="getprocessData2";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/NP_securitydetails.jsp";
		document.forms[0].submit();
		}
		
		
}
function onchangepropertycollateral()
{
	if(document.forms[0].sel_securityoff.value == "Y")
	{
		document.all.id_property.style.display="table-row";
		document.all.id_property0.style.display="table-row";
		document.all.id_property1.style.display="table-row";
		document.all.id_property2.style.display="table-row";
		document.all.id_property3.style.display="table-row";
		document.all.id_property4.style.display="table-row";
		document.all.id_property5.style.display="table-row";
		document.all.id_property6.style.display="table-row";
		document.all.id_property7.style.display="table-row";
		document.all.id_property8.style.display="table-row";
		document.all.id_property9.style.display="table-row";
		
		//added on 08-01-2021
		document.all.fieldtohide1.style.display="table-row";
		document.all.fieldtohide2.style.display="table-row";
		document.all.fieldtohide3.style.display="table-row";
		document.all.fieldtohide4.style.display="table-row";  
		document.all.fieldtohide5.style.display="table-row"; 
		document.all.fieldtohide6.style.display="table-row";
		document.all.fieldtohide7.style.display="table-row";
		document.all.fieldtohide8.style.display="none";
		document.all.fieldtohide9.style.display="none";
		document.all.fieldtohide10.style.display="none";//hide it for client requirements

		document.all.id_TD1.style.display="table-row";
		document.all.id_TD2.style.display="table-row";
		document.all.id_TD3.style.display="table-row";
		document.all.id_TD4.style.display="table-row";
		document.all.id_TD5.style.display="table-row";
		document.all.id_TD6.style.display="table-row";
		document.all.id_TD7.style.display="table-row";
		document.all.id_TD8.style.display="table-row";
		document.all.id_TD9.style.display="table-row";
		document.all.id_TD10.style.display="table-row";
		document.all.id_property10.style.display="table-row";
	}
	else
	{
		document.all.id_property.style.display="none";
		document.all.id_property0.style.display="none";
		document.all.id_property1.style.display="none";
		document.all.id_property2.style.display="none";
		document.all.id_property3.style.display="none";
		document.all.id_property4.style.display="none";
		document.all.id_property5.style.display="none";
		document.all.id_property6.style.display="none";
		document.all.id_property7.style.display="none";
		document.all.id_property8.style.display="none";
		document.all.id_property9.style.display="none";
		//added on 08-01-2021
		document.all.fieldtohide1.style.display="none";
		document.all.fieldtohide2.style.display="none";
		document.all.fieldtohide3.style.display="none"; 
		document.all.fieldtohide4.style.display="none"; 
		document.all.fieldtohide5.style.display="none"; 
		document.all.fieldtohide6.style.display="none";
		document.all.fieldtohide7.style.display="none";
		document.all.fieldtohide8.style.display="none";
		document.all.fieldtohide9.style.display="none";
		document.all.fieldtohide10.style.display="none";

		document.all.id_TD1.style.display="none";
		document.all.id_TD2.style.display="none";
		document.all.id_TD3.style.display="none";
		document.all.id_TD4.style.display="none";
		document.all.id_TD5.style.display="none";
		document.all.id_TD6.style.display="none";
		document.all.id_TD7.style.display="none";
		document.all.id_TD8.style.display="none";
		document.all.id_TD9.style.display="none";
		document.all.id_TD10.style.display="none";
		document.all.id_property10.style.display="none";
		
	}
 onchangeCollateraltype();
	
}
function onchangeleased()
{
	if(document.forms[0].sel_propertytype.value == "1")
	{
		document.all.id_leased1.style.display="table-row";
		document.all.id_leased2.style.display="table-row";
	}
	else
	{
		document.forms[0].txt_expirydate.value="";
		document.all.id_leased1.style.display="none";
		document.all.id_leased2.style.display="none";
	}
}
function onchangeCollateraltype()
{		
	if(document.forms[0].sel_securityoff.value == "Y")
	{
		if(document.forms[0].sel_collateraltype.value == "1")
		{
		document.all.id_property0.style.display="table-row";
		document.all.id_property1.style.display="table-row";
		document.all.id_property2.style.display="table-row";
		document.all.id_property3.style.display="table-row";
		document.all.id_property4.style.display="table-row";
		document.all.id_property9.style.display="table-row";
		document.all.id_property5.style.display="none";
		document.all.id_property6.style.display="none";
		document.all.id_property7.style.display="none";
		document.all.id_property8.style.display="none";
		document.forms[0].txt_noofunit.value="";
		document.forms[0].txt_serialNo.value="";
		document.forms[0].txt_details.value="";
		document.forms[0].collateral_code.value="";
		document.all.id_TD1.style.display="none";
		document.all.id_TD2.style.display="none";
		document.all.id_TD3.style.display="none";
		document.all.id_TD4.style.display="none";
		document.all.id_TD5.style.display="none";
		document.all.id_TD6.style.display="none";
		document.all.id_TD7.style.display="none";
		document.all.id_TD8.style.display="none";
		document.all.id_TD9.style.display="none";
		document.all.id_TD10.style.display="none";
		document.all.id_property10.style.display="table-row";

		document.all.fieldtohide1.style.display="table-row";
		document.all.fieldtohide2.style.display="table-row";
		document.all.fieldtohide3.style.display="table-row";
		document.all.fieldtohide4.style.display="table-row";  
		document.all.fieldtohide5.style.display="table-row"; 
		document.all.fieldtohide6.style.display="table-row";
		document.all.fieldtohide7.style.display="table-row";
		document.all.fieldtohide8.style.display="none";
		document.all.fieldtohide9.style.display="none";
		document.all.fieldtohide10.style.display="none";//hide it for client requirements
		}
		else if(document.forms[0].sel_collateraltype.value == "4")		
		{
		document.all.id_property0.style.display="none";
		document.all.id_property1.style.display="none";
		document.all.id_property2.style.display="none";
		document.all.id_property3.style.display="none";
		document.all.id_property4.style.display="none";
		document.all.id_property9.style.display="none";
		document.all.id_property5.style.display="table-row";
		document.all.id_property6.style.display="table-row";
		document.all.id_property7.style.display="table-row";
		document.all.id_property8.style.display="table-row";
		document.forms[0].sel_location.value="";
		document.forms[0].totalarea.value="";
	    document.forms[0].sel_propertytype.value="S";
		document.forms[0].txt_expirydate.value="";
		document.forms[0].forced_shareval.value="";
		document.forms[0].txt_propdescription.value="";
		document.forms[0].collateral_code1.value="";
		document.all.id_TD1.style.display="none";
		document.all.id_TD2.style.display="none";
		document.all.id_TD3.style.display="none";
		document.all.id_TD4.style.display="none";
		document.all.id_TD5.style.display="none";
		document.all.id_TD6.style.display="none";
		document.all.id_TD7.style.display="none";
		document.all.id_TD8.style.display="none";
		document.all.id_TD9.style.display="none";
		document.all.id_TD10.style.display="none";
		document.all.id_property10.style.display="table-row";

		document.all.fieldtohide1.style.display="table-row";
		document.all.fieldtohide2.style.display="table-row";
		document.all.fieldtohide3.style.display="table-row";
		document.all.fieldtohide4.style.display="table-row";  
		document.all.fieldtohide5.style.display="table-row"; 
		document.all.fieldtohide6.style.display="table-row";
		document.all.fieldtohide7.style.display="table-row";
		document.all.fieldtohide8.style.display="none";
		document.all.fieldtohide9.style.display="none";
		document.all.fieldtohide10.style.display="none";//hide it for client requirements
		}
		else if(document.forms[0].sel_collateraltype.value == "2")		
		{
		document.all.id_property0.style.display="none";
		document.all.id_property1.style.display="none";
		document.all.id_property2.style.display="none";
		document.all.id_property3.style.display="none";
		document.all.id_property4.style.display="none";
		document.all.id_property9.style.display="none";
		document.all.id_property5.style.display="none";
		document.all.id_property6.style.display="none";
		document.all.id_property7.style.display="none";
		document.all.id_property8.style.display="none";
		
		document.all.id_TD1.style.display="table-row";
		document.all.id_TD2.style.display="table-row";
		document.all.id_TD3.style.display="table-row";
		document.all.id_TD4.style.display="table-row";
		document.all.id_TD5.style.display="table-row";
		document.all.id_TD6.style.display="table-row";
		document.all.id_TD7.style.display="table-row";
		document.all.id_TD8.style.display="table-row";
		document.all.id_TD9.style.display="table-row";
		document.all.id_TD10.style.display="table-row";
		document.all.id_property10.style.display="none";

		document.all.fieldtohide1.style.display="none";
		document.all.fieldtohide2.style.display="none";
		document.all.fieldtohide3.style.display="none"; 
		document.all.fieldtohide4.style.display="none"; 
		document.all.fieldtohide5.style.display="none"; 
		document.all.fieldtohide6.style.display="none";
		document.all.fieldtohide7.style.display="none";
		document.all.fieldtohide8.style.display="none";
		document.all.fieldtohide9.style.display="none";
		document.all.fieldtohide10.style.display="none";
		
		}
		else
		{
		document.all.id_property0.style.display="none";
		document.all.id_property1.style.display="none";
		document.all.id_property2.style.display="none";
		document.all.id_property3.style.display="none";
		document.all.id_property4.style.display="none";
		document.all.id_property5.style.display="none";
		document.all.id_property6.style.display="none";
		document.all.id_property7.style.display="none";
		document.all.id_property8.style.display="none";
		document.all.id_property9.style.display="none";
		document.all.id_TD1.style.display="none";
		document.all.id_TD2.style.display="none";
		document.all.id_TD3.style.display="none";
		document.all.id_TD4.style.display="none";
		document.all.id_TD5.style.display="none";
		document.all.id_TD6.style.display="none";
		document.all.id_TD7.style.display="none";
		document.all.id_TD8.style.display="none";
		document.all.id_TD9.style.display="none";
		document.all.id_TD10.style.display="none";
		document.all.id_property10.style.display="none";

		document.all.fieldtohide1.style.display="table-row";
		document.all.fieldtohide2.style.display="table-row";
		document.all.fieldtohide3.style.display="table-row";
		document.all.fieldtohide4.style.display="table-row";  
		document.all.fieldtohide5.style.display="table-row"; 
		document.all.fieldtohide6.style.display="table-row";
		document.all.fieldtohide7.style.display="table-row";
		document.all.fieldtohide8.style.display="none";
		document.all.fieldtohide9.style.display="none";
		document.all.fieldtohide10.style.display="none";//hide it for client requirements
		
		}	
	}
}
function  validate()
{ 
return true;

}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="NationalPortal"
		document.forms[0].hidBeanGetMethod.value="getprocessData2";
		//document.forms[0].action=appURL+"controllerservlet";
		//document.forms[0].hidSourceUrl.value="/action/perprocessnotedata1.jsp";
		document.forms[0].action=appURL+"action/NP_securitydetails.jsp";
		document.forms[0].submit();
	 }
}
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdapply.disabled)
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
function doAudit()
{

}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
	
}


function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}


 function callApplicantTab(page)
  { 
   	
	if (document.forms[0].cmdapply.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	    	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }
		  document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
	
	
  }

function calldetail()
	{
		
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getprocessData1";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_perprocessnotedata.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}
		
	}

	function calldetail2()
	{
		
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
		document.forms[0].hidBeanId.value="printapp";
		document.forms[0].hidBeanGetMethod.value="getprocessData3";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perprocessnotedata2.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}
		
	}
function callTerms()
{
	if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}document.forms[0].sel_termstype.value="C";
		document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	
	document.forms[0].action=appURL+"action/NP_borrapptermsandcondns.jsp";
	document.forms[0].submit();

}
function callAppraisal()
	{
		
		if(!document.forms[0].cmdapply.disabled)
		{
			ShowAlert('103');
			return;
		}
		else
		{
		document.forms[0].hidBeanId.value="NationalPortal";			
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/NP_perappsanctionsanction.jsp";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
		}
		
	}
function checkval()
{
	var valuationvalue = parseInt(document.forms[0].valuationvalue.value)
	if(isNaN(valuationvalue))
   {
    alert("Enter Value ")
    document.forms[0].valuationvalue.value=""
    //document.forms[0].valuationvalue.focus();
   }
}	
function checkval1()
{
	var valuationvalue1 = parseInt(document.forms[0].valuationvalue1.value)
	if(isNaN(valuationvalue1))
   {
    alert("Enter Value")
    document.forms[0].valuationvalue1.value=""
    //document.forms[0].valuationvalue1.focus();
   }
}
function ShowPRDCodesproperty()
{
	var varCollType = document.forms[0].sel_collateraltype.value;
	var url=appURL+"action/collateralproducts_Canara.jsp?hidBeanId=collateral&hidBeanGetMethod=getCollateralSetupData_Canara&hidpage=newretail&CollateraType="+varCollType; 
	var prop="scrollbars=yes,menubar=yes,width=550,height=500,top=30,center=30";
	window.open(url,"collateral",prop);
}
function ShowPRDCodes()
{
	var url=appURL+"action/collateralproducts_Canara.jsp?hidBeanId=collateral&hidBeanGetMethod=getCollateralSetupData_Canara&hidpage=newretail"; 
	var prop="scrollbars=yes,menubar=yes,width=550,height=500,top=30,center=30";
	window.open(url,"collateral",prop);
}
function DisableCopyPaste(e) 
{
 // Message to display
 var message = "Cntrl key/ Right Click Option disabled";
 // check mouse right click or Ctrl key press
var kCode = e.keyCode; 
//FF and Safari use e.charCode, while IE use e.keyCode
 if (kCode == 17 || kCode == 0)
 {
 alert(message);
 return false;
 }
 else{
	 allowNumeric(kCode)
 }
}

function callCollDetails(){

	if (document.forms[0].txt_CustId.value =="")
	{
		alert("Enter Customer ID");
		document.forms[0].txt_CustId.focus();
		return;
	}
	var varcbsid=document.forms[0].txt_CustId.value;
	var varOrgScode=document.forms[0].strOrgShortCode.value;
	var varQryString = appURL+"action/Edu_TDsecurityDetails.jsp?hidBeanGetMethod=getTDAccount&hidBeanId=printapp&txt_cbsid="+varcbsid+"&strOrgScode="+varOrgScode;
	var title = "CollateralDetails";
	var prop = "scrollbars=yes,width=1250,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(varQryString,title,prop);
}


function notAllowEnter(evt)
{
	
	evt=(evt) ? evt : window.event;
	var key = (evt.which) ? evt.which : evt.keyCode;
	if(key==13)
	{
		//alert("key"+key);
		return false;
	}	
	return true;
}

function youCannotCopy()
{
	alert("copy is restricted");
	return false;
}

function youCannotPaste()
{
	alert("paste is restricted");
	return false;
}

</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="placeValues();funEDappstatus()" class="bgcolor">
<jsp:include page="../share/help.jsp" flush="true"> 
</jsp:include>

<form method="post" >
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
        <jsp:param name="pageid" value="10" />
        </jsp:include>
         </td>
    </tr>
  </table>
   <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="20"><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i> 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        Retail</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; Existing </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Process Note</i></b></font></td>
    </tr>
  </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td> <laps:application /> </td>
    </tr>
  </table>

  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                  <tr> 
      <td height="20" class="outertablecolor"> 
        <table width="50%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="50%" class="tabinactive"><b><font size="1" face="MS Sans Serif" ><a href="javascript:callTerms()" class="blackfont">Terms 
              and Conditions</a></font></b></td>
            <td width="30%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="javascript:callAppraisal()" class="blackfont">Appraisal</a></font></b></td>
		    <td width="30%" class="tabactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Process Note</font></b></td>
          </tr>
        </table>
      </td>
    </tr>
     <table width="70%" border="0" cellspacing="3" cellpadding="3" align="left">
                      <tr> 
                        <td width="15%" align="center" id="prm" class="tabinactive"> 
                          <b><font size="1" face="MS Sans Serif" color="#FFFFFF"><a href="JavaScript:calldetail()" class="blackfont"><b><font size="1" face="MS Sans Serif">Additional Details</a> </font></b></td>
                        <td width="15%" align="center" id="com2" class="tabactive"><font size="1" face="MS Sans Serif" color="#FFFFFF"><b>Security Details</b></td><!--
                        <td width="15%" align="center" id="com2" class="tabinactive"> 
                          <a href="JavaScript:calldetail2()" class="blackfont"><b><font size="1" face="MS Sans Serif"><a href="JavaScript:calldetail2()" class="blackfont"><b>Take Over </a></font></b></a></td>
						  
                        --><td width="15%" align="center"> <font size="1" face="MS Sans Serif" color="#FF0000">All 
                          Values are in Rs</font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="1" cellspacing="0" cellpadding="3" width="100%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                        <div Class = "cellContainer">
						  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr> 
                              <td width="10%"><font size="1" face="MS Sans Serif"><b>Security 
                                Details</b> </font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%">&nbsp;</td>
                              <td width="25%">&nbsp; </td>
                            </tr>
                            <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                            <tr>
                            <td width="10%"><font size="1" face="MS Sans Serif">Whether Offered Security 
                                 </font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                             <td width="10%"><select name="sel_securityoff" style="width:40%" onchange="onchangepropertycollateral();">
                                 <option value="s" >----Select----</option>
                                 <option value="Y">Yes</option>
                                 <option value="N">No</option>
                                 </select>
                            </td>
                            </tr>
                            <%} %>
                            <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                              <tr id="id_property"> 
                                <td><font size="1" face="MS Sans Serif">Collateral Type</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font> </td>
								<td width="15%" align="left"><font size="1"
								face="MS Sans Serif"> <select name="sel_collateraltype" onchange="onchangeCollateraltype();">
								<option value="S">---Select---</option>
								<option value="1">Property</option>
								<option value="2">TD Security</option>
								<!--<option value="4">Financial</option>
								--></select>
								</font></td>
                            </tr>
							<tr class="accord-header"   id="id_property0" style="width:60; background-color: #00aedf">
							<td width="25%"><b><font size="1" face="MS Sans Serif">Property Security</font></b></td>
							<td width="25%">&nbsp;</td>
							<td width="25%">&nbsp;</td>
							<td width="25%">&nbsp;</td>
							</tr >
							<tr id="id_property1">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Property Location <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="sel_location" size="25"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_LOCATION"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Area Unit</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_areaunit" size="8"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "Sq.Ft" tab index="14"></font>
                            </tr>	
						    <tr id="id_property2">
                                 <td width="25%"><font size="1" face="MS Sans Serif">Total Area</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><input type="text" name="totalarea"  size="8"  maxlength="8"  
                                 onKeyPress="return allowIntegerOne(event)"
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_TOTALAREA"))%>" tab index="14"></
                                <font size="1" face="MS Sans Serif">Sq.ft</font> </td>  
                                <td><font size="1" face="MS Sans Serif">Type of property</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font> </td>
								<td width="15%" align="left"><font size="1"
								face="MS Sans Serif"> <select name="sel_propertytype" onchange="onchangeleased();">
								<option value="S">---Select---</option>
								<option value="0">Freehold</option>
								<option value="1">Leased</option>
								</select>
								</font></td>
                            </tr>
                             <tr id="id_property3">
                              <td align="left" width="25%"><font size="1" face="MS Sans Serif">Forced Sale Value</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
				              <td align="left" width="25%"><input type="text"
					           name="forced_shareval" onKeyPress="return allowIntegerOne(event)" value="<%=Helper.correctNull((String)hshValues.get("COLL_FORCEDSHAREVAL")) %>"> </td>				
                              <td width="25%" id="id_leased1"><font size="1" face="MS Sans Serif">Date of expiry</font></td>
				              <td width="25%" id="id_leased2"><font size="1" face="MS Sans Serif"><input type="text"name="txt_expirydate" size="12" maxlength="10" onKeyPress="allowDate()" value="<%=Helper.correctNull((String) hshValues.get("COLL_DATEOFEXPIRY"))%>"  onkeyup="todate(this)" onBlur="checkDate(this)"></font></td>				   
                               </tr>
                            <tr id="id_property4">
                            <td align="left" width="25%"><font size="1"
							face="MS Sans Serif">Property Description<font size="1"
							face="MS Sans Serif" color="#FF0000">*</font></font></td>
							<td align="left" width="25%" >
							<textarea rows="4" cols="50" name="txt_propdescription" 
							onKeyPress="textlimit(this,40);return allowAlphaNumericOne(event);" onKeyUp="textlimit(this,100)" onCopy="return youCannotCopy();" onPaste="return youCannotPaste();" onMouseDown="return DisableCopyPaste(event)" onKeyDown="return notAllowEnter(event);" ><%=Helper.correctNull((String)hshValues.get("COLL_DESC1")) %></textarea>
						</td>
						 <td align="left" width="25%"><font size="1"
					    face="MS Sans Serif">Collateral Code</font></td>  
				        <td align="left" width="25%"><input type="text" name="collateral_code1" readonly="readonly" value="<%=Helper.correctNull((String)hshValues.get("COLL_CODE")) %>">
				        <span  id="search_icon"><a href="javascript:ShowPRDCodesproperty()"
								title="Click to View Product Codes" class="blackfont" >
							<img src="<%=ApplicationParams.getAppUrl()%>img/Search.png"
								style="border: none" align="middle">
								</a></span>
				        <input type="hidden" name="hidcolldesc"></td>
				        <td width="5%">&nbsp;</td>
						</tr>
						 <tr id="id_property9">    
						    <td align="left" width="25%"><font size="1"
							face="MS Sans Serif">Deed Details</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						    <td align="left" width="25%"><input type="text" name="txt_deeddetails" onKeyDown="return DisableCopyPaste(event)" onKeyDown="return notAllowEnter(event);" onMouseDown="return DisableCopyPaste(event)" onKeypress="return allowAlphaNumericOne(event);" value="<%=Helper.correctNull((String)hshValues.get("COLL_DEEDDATA")) %>">
						   </td>	
						 </tr>
						<tr class="accord-header" style="width:60; background-color: #00aedf"  id="id_property5">
						<td width="25%"><b><font size="1" face="MS Sans Serif">Financial Security</font></b></td>
						<td width="25%">&nbsp;</td>
						<td width="25%">&nbsp;</td>
						<td width="25%">&nbsp;</td>
						</tr >
						<tr id="id_property6">
						 <td width="25%"><font size="1" face="MS Sans Serif">No of Units</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_noofunit"  size="8"  maxlength="8"  
                                 onKeyPress="return allowIntegerOne(event)"
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_FINACLEUNITS"))%>" tab index="14"></font>
                                 </td>
						   </tr> 
						   <tr id="id_property7">
						    <td width="25%"><font size="1" face="MS Sans Serif">Serial No</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_serialNo"  size="25"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_FINACLESRNO1"))%>" tab index="14"></font>
                                 </td>
                           <td align="left" width="25%"><font size="1" face="MS Sans Serif">Details<font size="1"
							face="MS Sans Serif" color="#FF0000">*</font></font></td>
							<td align="left" width="25%" >
							<textarea rows="4" cols="50" name="txt_details" 
							onKeyPress="textlimit(this,100)" onKeyUp="textlimit(this,100)"><%=Helper.correctNull((String)hshValues.get("COLL_FINACLESRNO2")) %></textarea>
						</td>
						   </tr>
	                   <tr id="id_property8">
	                    <td align="left" width="25%"><font size="1"
					    face="MS Sans Serif">Collateral Code</font></td>
				        <td align="left" width="25%"><input type="text" name="collateral_code" readonly="readonly" value="<%=Helper.correctNull((String)hshValues.get("COLL_CODE")) %>">
				        <span  id="search_icon"><a href="javascript:ShowPRDCodes()"
								title="Click to View Product Codes" class="blackfont" >
							<img src="<%=ApplicationParams.getAppUrl()%>img/Search.png"
								style="border: none" align="middle">
								</a></span>
				        <input type="hidden" name="hidcolldesc"></td>
				        <td width="5%">&nbsp;</td>
	                   </tr>
	                   <tr id="id_TD1">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Collateral Code <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td align="left" width="25%"><input type="text" name="txt_CollCode" readonly="readonly" size="20"
						        value="<%=Helper.correctNull((String)hshValues.get("COLL_CODE")) %>">
				                     <span  id="search_icon"><a href="javascript:ShowPRDCodesproperty()" title="Click to View Product Codes" class="blackfont" >
							         <img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle">
								     </a></span></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Name of the collateral</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_CollName" size="20"  maxlength="50"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String)hshValues.get("COLL_NAME")) %>" tab index="14"></font>
                        </tr>
                        <tr id="id_TD2">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Customer id <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_CustId" size="20"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" value = "<%=Helper.correctNull((String)hshValues.get("TD_CUSTOMERID")) %>"></font>
                                     <span  id="search_icon1"><a href="javascript:callCollDetails();" title="Click to View Collateral Details" class="blackfont" >
							         <img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle">
								     </a></span></td>
						         <td width="25%">&nbsp;</td>
                                 <td width="25%">&nbsp;</td>
                        </tr>
                        <!--<tr id="">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Currency <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><select name="sel_currency" onchange="">
								<option value="S">---Select---</option>
								<option value="1" selected="selected">INR</option></select></td>
						         <td width="25%">&nbsp;</td>
                                 <td width="25%">&nbsp;</td>
                        </tr> -->
                        <tr id="id_TD3">
                                <td width="25%" colspan="4"><font size="1" face="MS Sans Serif"><b>Collateral details</b> </font></td>
                        </tr>
                        <tr id="id_TD4">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Deposit Account No <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_DepAcctNo" size="20"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("TD_DEPOSITACCTNO"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Deposit Number</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_DepNum" size="20"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String)hshValues.get("TD_DEPOSITNUMBER")) %>" tab index="14"></font>
                        </tr>
                        <tr id="id_TD5">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Status <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_status" size="20"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("TD_STATUS"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Depositor Name</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_DepCode" size="20"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String)hshValues.get("TD_DEPOSITORNAME")) %>" tab index="14"></font>
                        </tr>
                        <tr id="id_TD6">
                                <td width="25%" ><font size="1" face="MS Sans Serif">CurrencyCode <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_CurrCode" size="20"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("TD_CURRENCYCODE"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Deposit Date</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_DepDate" size="20"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String)hshValues.get("TD_DEPOSITDATE")) %>" tabindex="14"></font>
                        </tr> 
                        <tr id="id_TD7">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Maturity Date <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_MatDate" size="20"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("TD_MATURITYDATE"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Period Months/Days</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_Period" size="20"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String)hshValues.get("TD_PERIODMONTHS_DAYS")) %>" tab index="14"></font>
                        </tr>  
                        <tr id="id_TD8">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Deposit ROI <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_ROI" size="20"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("TD_DEPOSITROI"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Principal Balance</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_PrincpleBal" size="20"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String)hshValues.get("TD_PRINCIPALBALANCE")) %>" tab index="14"></font>
                        </tr>  
                        <tr id="id_TD9">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Deposit Account Balance <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_DepAcctBal" size="20"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("TD_DEPOSITACCTBAL"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Lien Amount</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_LienAmt" size="20"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String)hshValues.get("TD_LIENAMOUNT")) %>" tab index="14"></font>
                        </tr> 
                        <tr id="id_TD10">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Lien% <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_Lien" size="20"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("TD_LIENPERCENTAGE"))%>" tab index="14"></font></td>
                        </tr>     
                            
	                   <tr><td colspan="4">&nbsp;</td></tr> 
	                   <tr class="accord-header"   id="id_property10" style="width:60; background-color: #00aedf">
							<td width="25%"><b><font size="1" face="MS Sans Serif">Valuation Details</font></b></td>
							<td width="25%">&nbsp;</td>
							<td width="25%">&nbsp;</td>
							<td width="25%">&nbsp;</td>
							</tr >
						   <%} %>
						   <tr><td colspan="4">&nbsp;</td></tr>
                            <tr id="fieldtohide1"> 
                              <td width="30%" height="56"><font size="1" face="MS Sans Serif">Security 
                                Particulars for Housing/Vehicle Loans(Furnish details of security such as 
                                extent,Sy.No, Khatha No, Address and the name of 
                                the owner/owners,Model of Vehicle, Name of the Vehicle, etc.,)</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
                              <td colspan="2" height="56"> 
                                <textarea name="property" rows="4" cols="50" readonly="readonly" onKeypress="textlimit(this,'4000')" onBlur="textlimit(this,'4000')"><%=Helper.correctNull((String)hshValues.get("property_particulars"))%></textarea>
                              </td>
                            </tr>
                            <tr id="fieldtohide2"> 
                              <td width="30%" height="94"><font size="1" face="MS Sans Serif">Whether 
                                already owned or to be bought</font></td>
                              <td colspan="2" height="94"> 
                                <textarea name="owned" rows="4" cols="50" readonly="readonly" onKeypress="textlimit(this,'4000')" onBlur="textlimit(this,'4000')"><%=Helper.correctNull((String)hshValues.get("already_owned"))%></textarea>
                              </td>
                            </tr>
                            <tr id="fieldtohide3"> 
                              <td width="30%" height="34"><font size="1" face="MS Sans Serif">Advocates 
                                Opinion: Whether the vendor/applicant has cleared, 
                                valid marketable title (Furnish reference of advocate)</font></td>
                              <td width="25%" height="34"> 
                                <select name="advocateopinion" >
                                  <option value="S" selected>Select</option>
                                  <option value="Y">Yes</option>
                                  <option value="N">No</option>
								  <option value="A">Not Applicable</option>
                                </select>
                              </td>
                              <td width="25%" height="34"><font size="1" face="MS Sans Serif"> 
                                <B>REF</B>: 
                                <textarea name="advocateref" cols="55" readonly="readonly" rows="2" onKeypress="textlimit(this,'4000')" onBlur="textlimit(this,'4000')"><%=Helper.correctNull((String)hshValues.get("advocate_ref"))%></textarea>
                                </font></td>
                            </tr>
                            <tr id="fieldtohide4"> 
                              <td width="30%" height="71"><font size="1" face="MS Sans Serif">Valuation</font></td>
                              <td colspan="2" height="71"> 
                                <table width="75%" border="1"  cellspacing="0" cellpadding="1" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  class="tabinactive">
                                  <tr class="tabactive"> 
                                    <td width="37%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">By</font></b></div>
                                    </td>
                                    <td width="34%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Value</font></b></div>
                                    </td>
                                    <td width="29%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Date</font></b></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="37%"> 
                                      <div align="center"> 
                                        <input type="text" name="valuationby" size="20"  maxlength="100"  value="<%=Helper.correctNull((String)hshValues.get("valuation_by"))%>">
                                      </div>
                                    </td>
                                    <td width="34%"> 
                                      <div align="center"> 
                                        <input type="text" name="valuationvalue" size="15"  onKeyPress="allowDecimals(this.value);allowNumber(this)" onBlur="checkval()" maxlength="100"  value="<%=Helper.correctNull((String)hshValues.get("valuation_value"))%>" style="text-align:right" >
                                      </div>
                                    </td>
                                    <td width="29%"> 
                                      <div align="center"> 
                                        <input type="text" name="valuationdate" size="12" onBlur="checkDate(this)" maxlength="10"  value="<%=Helper.correctNull((String)hshValues.get("valuation_date"))%>"><a alt="Select date from calender"  href="#" onClick="callCalender()" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border=0 alt="Select date from calender"></a>
                                      </div>
                                    </td>
                                  </tr>
                                  <!-- SATHIYA -->
                                   <tr> 
                                    <td width="37%"> 
                                      <div align="center"> 
                                        <input type="text" name="valuationby1" size="20"  maxlength="100"  value="<%=Helper.correctNull((String)hshValues.get("VALUATION_BY1"))%>">
                                      </div>
                                    </td>
                                    <td width="34%"> 
                                      <div align="center"> 
                                        <input type="text" name="valuationvalue1" size="15"  maxlength="100" onKeyPress="allowDecimals(this.value);allowNumber(this)" onBlur="checkval1()"  value="<%=Helper.correctNull((String)hshValues.get("VALUATION_VALUE1"))%>" style="text-align:right" onKeyPress="allowDecimals(this)">
                                      </div>
                                    </td>
                                    <td width="29%"> 
                                      <div align="center"> 
                                        <input type="text" name="valuationdate1" size="12" onBlur="checkDate(this)" maxlength="10"  value="<%=Helper.correctNull((String)hshValues.get("VALUATION_DATE1"))%>"><a alt="Select date from calender"  href="#" onClick="callCalender2()" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border=0 alt="Select date from calender"></a>
                                      </div>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr id="fieldtohide5"> 
                              <td width="30%" height="71"><font face="MS Sans Serif" size="1">Inspection 
                                of property by</font></td>
                              <td colspan="2" height="71"> 
                                <table width="75%" border="1" cellspacing="0" cellpadding="1" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  class="tabinactive">
                                  <tr class="tabactive"> 
                                    <td width="37%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif"  color="#FFFFFF">Name</font></b></div>
                                    </td>
                                    <td width="29%"> 
                                      <div align="center"><b><font size="1" face="MS Sans Serif"  color="#FFFFFF">Date</font></b></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="37%"> 
                                      <div align="center"> 
                                        <input type="text" name="inspectionname" size="25"  maxlength="100"   value="<%=Helper.correctNull((String)hshValues.get("inspection_name"))%>">
                                      </div>
                                    </td>
                                    <td width="29%"> 
                                      <div align="center"> 
                                        <input type="text" name="inspectiondate" size="12" onBlur="checkDate(this)" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("inspection_date"))%>" ><a alt="Select date from calender"  href="#" onClick="callCalender1()" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border=0 alt="Select date from calender"></a>
                                      </div>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr id="fieldtohide6"> 
                              <td width="30%" height="28"><font size="1" face="MS Sans Serif">Residual 
                                life of the property as per valuation report[in 
                                case of old houses)</font></td>
                              <td colspan="2" height="28"> 
                                <input type="text" name="residual" size="10"  maxlength="100"  value="<%=Helper.correctNull((String)hshValues.get("residual_life"))%>" style="text-align:right">
                                <font size="1" face="MS Sans Serif">[Years]</font></td>
                            </tr>
                          <!--  <tr> 
                              <td width="38%" height="34"><font size="1" face="MS Sans Serif">Additional 
                                security offered,if any</font></td>
                              <td colspan="2" height="34"> 
                                <textarea name="additional" cols="70" readonly="readonly" rows="2"><%=Helper.correctNull((String)hshValues.get("additional_security"))%></textarea>
                              </td>
                            </tr>-->
                            <tr id="fieldtohide7"> 
                              <td width="30%" height="34"><font size="1" face="MS Sans Serif">Whether 
                                approved plan ,EC,Latest tax paid receipts obtained</font></td>
                              <td colspan="2" height="34"> 
                                <textarea name="approved" cols="70" readonly="readonly" rows="2" onKeypress="textlimit(this,'4000')" onBlur="textlimit(this,'4000')"><%=Helper.correctNull((String)hshValues.get("whether_approved"))%></textarea>
                              </td>
                            </tr>
                           <!--  <tr> 
                              <td width="38%" height="34"><font size="1" face="MS Sans Serif">Applicant 
                                dealing with other banks/branches and whether 
                                the opinion received are satisfactory [if not 
                                specify] </font></td>
                              <td colspan="2" height="34"> 
                                <textarea name="dealings" cols="70" readonly="readonly" rows="2"><%=Helper.correctNull((String)hshValues.get("applicant_dealing"))%></textarea>
                              </td>
                            </tr> -->
                            <tr id="fieldtohide8"> 
                              <td width="30%" height="34"><font size="1" face="MS Sans Serif">Whether 
                                applicant/s are existing customers, if so furnish 
                                details</font></td>
                              <td colspan="2" height="34"> 
                                <textarea name="existing" cols="70" readonly="readonly" rows="2" onKeypress="textlimit(this,'4000')" onBlur="textlimit(this,'4000')"><%=Helper.correctNull((String)hshValues.get("existing_customers"))%></textarea>
                              </td>
                            </tr>
                            <tr id="fieldtohide9"> 
                              <td width="30%" height="34"><font size="1" face="MS Sans Serif">Additional 
                                Informations</font></td>
                              <td colspan="2" height="34"> 
                                <textarea name="additional" cols="70" readonly="readonly" rows="2" onKeypress="textlimit(this,'4000')" onBlur="textlimit(this,'4000')"><%=Helper.correctNull((String)hshValues.get("additional_security"))%></textarea>
                              </td>
                            </tr>
							  <tr id="fieldtohide10"> 
                              <td width="30%" height="34"><font size="1" face="MS Sans Serif">Borrower/Guarantor surety for someone else<font size="1" face="MS Sans Serif" color="#FF0000">*</font>
                                </font></td>
                              									<td colspan="3"><font size="1" face="MS Sans Serif"> 
												<select name="appguarantor" >
										 <option value="0" selected> <----Select----> 
                                          </option>
												 	
                                               <lapschoice:StaticDataTag  apptype="22"/>				</select> </font>
													<font size="1" face="MS Sans Serif">&nbsp;</font>
                              </td>
                            </tr>
                             <!--<%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                              <tr id="id_property"> 
                                <td><font size="1" face="MS Sans Serif">Collateral Type</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font> </td>
								<td width="15%" align="left"><font size="1"
								face="MS Sans Serif"> <select name="sel_collateraltype" onchange="onchangeCollateraltype();">
								<option value="S">---Select---</option>
								<option value="1">Property</option>
								<option value="4">Financial</option>
								</select>
								</font></td>
                            </tr>
							<tr class="accord-header"   id="id_property0" style="width:60; background-color: #00aedf">
							<td width="25%"><b><font size="1" face="MS Sans Serif">Property Security</font></b></td>
							<td width="25%">&nbsp;</td>
							<td width="25%">&nbsp;</td>
							<td width="25%">&nbsp;</td>
							</tr >
							<tr id="id_property1">
                                <td width="25%" ><font size="1" face="MS Sans Serif">Property Location <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font></b></td>
						        <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="sel_location" size="25"  maxlength="8"  
                                 onkeypress="allowAlphabets();" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_LOCATION"))%>" tab index="14"></font></td>
						     <td width="25%"><font size="1" face="MS Sans Serif">Area Unit</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_areaunit" size="8"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "Sq.Ft" tab index="14"></font>
                            </tr>	
						    <tr id="id_property2">
                                 <td width="25%"><font size="1" face="MS Sans Serif">Total Area</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><input type="text" name="totalarea"  size="8"  maxlength="8"  
                                 onKeyPress="return allowIntegerOne(event)"
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_TOTALAREA"))%>" tab index="14"></
                                <font size="1" face="MS Sans Serif">Sq.ft</font> </td>  
                                <td><font size="1" face="MS Sans Serif">Type of property</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font> </td>
								<td width="15%" align="left"><font size="1"
								face="MS Sans Serif"> <select name="sel_propertytype" onchange="onchangeleased();">
								<option value="S">---Select---</option>
								<option value="0">Freehold</option>
								<option value="1">Leased</option>
								</select>
								</font></td>
                            </tr>
                             <tr id="id_property3">
                              <td align="left" width="25%"><font size="1" face="MS Sans Serif">Forced Sale Value</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
				              <td align="left" width="25%"><input type="text"
					           name="forced_shareval" onKeyPress="return allowIntegerOne(event)" value="<%=Helper.correctNull((String)hshValues.get("COLL_FORCEDSHAREVAL")) %>"> </td>				
                              <td width="25%" id="id_leased1"><font size="1" face="MS Sans Serif">Date of expiry</font></td>
				              <td width="25%" id="id_leased2"><font size="1" face="MS Sans Serif"><input type="text"name="txt_expirydate" size="12" maxlength="10" onKeyPress="allowDate()" value="<%=Helper.correctNull((String) hshValues.get("COLL_DATEOFEXPIRY"))%>"  onkeyup="todate(this)" onBlur="checkDate(this)"></font></td>				   
                               </tr>
                            <tr id="id_property4">
                            <td align="left" width="25%"><font size="1"
							face="MS Sans Serif">Property Description<font size="1"
							face="MS Sans Serif" color="#FF0000">*</font></font></td>
							<td align="left" width="25%" >
							<textarea rows="4" cols="50" name="txt_propdescription" 
							onKeyPress="textlimit(this,40);return allowAlphaNumericOne(event);" onKeyUp="textlimit(this,100)" onKeyDown="return DisableCopyPaste(event)" onMouseDown="return DisableCopyPaste(event)"><%=Helper.correctNull((String)hshValues.get("COLL_DESC1")) %></textarea>
						</td>
						 <td align="left" width="25%"><font size="1"
					    face="MS Sans Serif">Collateral Code</font></td>  
				        <td align="left" width="25%"><input type="text" name="collateral_code1" readonly="readonly" value="<%=Helper.correctNull((String)hshValues.get("COLL_CODE")) %>">
				        <span  id="search_icon"><a href="javascript:ShowPRDCodesproperty()"
								title="Click to View Product Codes" class="blackfont" >
							<img src="<%=ApplicationParams.getAppUrl()%>img/Search.png"
								style="border: none" align="middle">
								</a></span>
				        <input type="hidden" name="hidcolldesc"></td>
				        <td width="5%">&nbsp;</td>
						</tr>
						 <tr id="id_property9">    
						    <td align="left" width="25%"><font size="1"
							face="MS Sans Serif">Deed Details</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
						    <td align="left" width="25%"><input type="text" name="txt_deeddetails" value="<%=Helper.correctNull((String)hshValues.get("COLL_DEEDDATA")) %>">
						   </td>	
						 </tr>
						<tr class="accord-header" style="width:60; background-color: #00aedf"  id="id_property5">
						<td width="25%"><b><font size="1" face="MS Sans Serif">Financial Security</font></b></td>
						<td width="25%">&nbsp;</td>
						<td width="25%">&nbsp;</td>
						<td width="25%">&nbsp;</td>
						</tr >
						<tr id="id_property6">
						 <td width="25%"><font size="1" face="MS Sans Serif">No of Units</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_noofunit"  size="8"  maxlength="8"  
                                 onKeyPress="return allowIntegerOne(event)"
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_FINACLEUNITS"))%>" tab index="14"></font>
                                 </td>
						   </tr> 
						   <tr id="id_property7">
						    <td width="25%"><font size="1" face="MS Sans Serif">Serial No</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                 <td width="25%"><font size="1" face="MS Sans Serif"><input type="text" name="txt_serialNo"  size="25"  maxlength="25"  
                                 onKeyPress="allowDecimals(this.value)" 
                                 value = "<%=Helper.correctNull((String) hshValues.get("COLL_FINACLESRNO1"))%>" tab index="14"></font>
                                 </td>
                           <td align="left" width="25%"><font size="1" face="MS Sans Serif">Details<font size="1"
							face="MS Sans Serif" color="#FF0000">*</font></font></td>
							<td align="left" width="25%" >
							<textarea rows="4" cols="50" name="txt_details" 
							onKeyPress="textlimit(this,100)" onKeyUp="textlimit(this,100)"><%=Helper.correctNull((String)hshValues.get("COLL_FINACLESRNO2")) %></textarea>
						</td>
						   </tr>
	                   <tr id="id_property8">
	                    <td align="left" width="25%"><font size="1"
					    face="MS Sans Serif">Collateral Code</font></td>
				        <td align="left" width="25%"><input type="text" name="collateral_code" readonly="readonly" value="<%=Helper.correctNull((String)hshValues.get("COLL_CODE")) %>">
				        <span  id="search_icon"><a href="javascript:ShowPRDCodes()"
								title="Click to View Product Codes" class="blackfont" >
							<img src="<%=ApplicationParams.getAppUrl()%>img/Search.png"
								style="border: none" align="middle">
								</a></span>
				        <input type="hidden" name="hidcolldesc"></td>
				        <td width="5%">&nbsp;</td>
	                   </tr> 
						   <%} %>
                          --></table>
                          </div>
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
  <br>

  <%String strappno = request.getParameter("appno");

		if(strappno.equalsIgnoreCase("new")){strappno ="";}
  %>
    <lapschoice:combuttons  apporgcode="<%=strappno%>" strSource=""/>

<input type="hidden" name="propertytype" value="<%=((String)hshValues.get("prop_type"))%>" >
<input type="hidden" name="hidstageprop" value="<%=((String)hshValues.get("prop_stage"))%>" >
<input type="hidden" name="hidqtyconst" value= "<%=((String)hshValues.get("prop_quality"))%>" >
<input type="hidden" name="hidlocationval" value= "<%=((String)hshValues.get("prop_loc_status"))%>" >
<input type="hidden" name="hidamenities" value= "<%=((String)hshValues.get("prop_amenity"))%>" >
<input type="hidden" name="hidmarketability" value = "<%=((String)hshValues.get("prop_market"))%>">

<INPUT TYPE="hidden" name="hidCoDemoId" value="<%=(String)request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=(String)request.getParameter("hidGuaDemoId")%>">
  <INPUT TYPE="hidden" name="hidAppType" value="">
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
<INPUT TYPE="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hideditflag" >
<input type="hidden" name="trapEdit" >
<input type="hidden" name="hidEditMode" >
<input type="hidden" name="hidEditLock" >

<!--- modified for other links-->

<INPUT TYPE="hidden" name="hiPgDist" value="P">
<INPUT TYPE="hidden" name="radLoan" value="Y">
<INPUT TYPE="hidden" name="page" value="ep">
<INPUT TYPE="hidden" name="hidApp_type" value="A">
<INPUT TYPE="hidden" name="hidauto_type">
<INPUT TYPE="hidden" name="newappid">
<INPUT TYPE="hidden" name="newapptype">
 <input type="hidden" name="sel_termstype"value="">
 <input type="hidden" name="hidUserId" value="<%=(String)session.getAttribute("strUserId")%>">
 <input type="hidden" name="strOrgShortCode" value="<%=(String)session.getAttribute("strOrgShortCode")%>">
</form>
</body>
</html>

