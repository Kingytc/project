<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="../share/directives.jsp"%>
    <%
    String pageid = Helper.correctNull((String) request.getParameter("pageid"));
   
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Security Crop</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var measurement ="<%=Helper.correctNull((String)hshValues.get("SEC_MEASUREMENT"))%>";
var salutation ="<%=Helper.correctNull((String)hshValues.get("SEC_SALUTATION"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";

function onLoad()
{	

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	
	if(measurement!="")
	{
		document.forms[0].sel_Measurement.value= measurement;
		document.forms[0].old_sel_MeasurementTxt.value=document.forms[0].sel_Measurement.options[document.forms[0].sel_Measurement.selectedIndex].text;
	}else
	{
		document.forms[0].sel_Measurement.value= "";
		document.forms[0].old_sel_MeasurementTxt.value="";
	}

	if(salutation!="")
	{
		document.forms[0].sel_salutation.value= salutation;
		document.forms[0].old_sel_salutation.value=document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text;
	}else
	{
		document.forms[0].sel_Measurement.value= "";
		document.forms[0].old_sel_salutation.value="";
	}
	 calldisable(true);
}

function modifyCheck()
{
	var temp="";
	var tempname="";
	document.forms[0].sel_MeasurementTxt.value=document.forms[0].sel_Measurement.options[document.forms[0].sel_Measurement.selectedIndex].text;
	document.forms[0].sel_salutationTxt.value=document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text;

	if(document.forms[0].sel_MeasurementTxt.value!=document.forms[0].old_sel_MeasurementTxt.value)
	{
		temp=temp+"old_sel_MeasurementTxt"+"@"; 		tempname=tempname+"Measurement "+"@";
	}
	if(document.forms[0].sel_salutationTxt.value!=document.forms[0].old_sel_salutation.value)
	{
		temp=temp+"old_sel_salutation"+"@"; 		tempname=tempname+"salutation "+"@";
	}
	if(document.forms[0].txt_Area.value!=document.forms[0].old_txt_Area.value)
	{
		temp=temp+"old_txt_Area"+"@"; 		tempname=tempname+"Area "+"@";
	}
	if(document.forms[0].txt_belonging.value!=document.forms[0].old_txt_belonging.value)
	{
		temp=temp+"old_txt_belonging"+"@"; 	tempname=tempname+"Belonging "+"@";
	}
	if(document.forms[0].txt_surveyNo.value!=document.forms[0].old_txt_surveyNo.value)
	{
		temp=temp+"old_txt_surveyNo"+"@"; 		tempname=tempname+"Survey NO"+"@";
	}
	if(document.forms[0].txt_cropaddress1.value!=document.forms[0].old_txt_cropaddress1.value)
	{
		temp=temp+"old_txt_cropaddress1"+"@"; 		tempname=tempname+"Address1"+"@";
	}
	if(document.forms[0].txt_cropaddress1.value!=document.forms[0].old_txt_cropaddress1.value)
	{
		temp=temp+"old_txt_cropaddress2"+"@"; 		tempname=tempname+"address2 "+"@";
	}
	if(document.forms[0].txt_cropcity.value!=document.forms[0].old_txt_cropcity.value)
	{
		temp=temp+"old_txt_cropcity"+"@"; 		tempname=tempname+"City"+"@";
	}
	if(document.forms[0].txt_cropdistrict.value!=document.forms[0].old_txt_cropdistrict.value)
	{
		temp=temp+"old_txt_cropdistrict"+"@"; 		tempname=tempname+"District"+"@";
	}
	if(document.forms[0].txt_cropstate.value!=document.forms[0].old_txt_cropstate.value)
	{
		temp=temp+"old_txt_cropstate"+"@"; 		tempname=tempname+"State"+"@";
	}
	if(document.forms[0].txt_cropcountry.value!=document.forms[0].old_txt_cropcountry.value)
	{
		temp=temp+"old_txt_cropcountry"+"@"; 		tempname=tempname+"Country"+"@";
	}
	if(document.forms[0].txt_croppin.value!=document.forms[0].old_txt_croppin.value)
	{
		temp=temp+"old_txt_croppin"+"@"; 		tempname=tempname+"pin"+"@";
	}
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
	
}
function calldisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
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

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";	
		document.forms[0].hidBeanGetMethod.value="getSecurityCrop";
		document.forms[0].action=appURL+"action/securitiesCrop.jsp";	
		document.forms[0].submit();		
	}	
}

function doEdit()
{
	calldisable(false);
	callDisableControls(true,false,false,false,false);
	document.forms[0].txt_cropcity.readOnly=true;
	document.forms[0].txt_cropstate.readOnly=true;
	document.forms[0].txt_cropdistrict.readOnly=true;	
	document.forms[0].txt_cropcountry.readOnly=true;
	if(document.forms[0].txt_cbscustid.value!=""){
		document.forms[0].sel_salutation.disabled=true;
		document.forms[0].txt_belonging.readOnly=true;
		document.forms[0].txt_surveyNo.readOnly=true;
		document.forms[0].txt_cropaddress1.readOnly=true;
		document.forms[0].txt_cropaddress2.readOnly=true;
	}
	
}

function doClose()
{
	if (ConfirmMsg(100)) 
	{
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function callDistrict() {
	
	var varstate = document.forms[0].hid_cropstate.value;
	if (document.forms[0].cmdsave.disabled == false && document.forms[0].txt_cbscustid.value =="") {
		if (document.forms[0].txt_cropcity.value == "") {
			ShowAlert(112, "City");
			document.forms[0].txt_cropcity.focus();
			return;
		}
		if (document.forms[0].txt_cropstate.value == "") {
			alert("Please Reselect the City");
			document.forms[0].txt_cropcity.focus();
			return;
		} else {
			var varQryString = appURL+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+ varstate + "&code=crop";
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
			prop = prop + ",left=200,top=200";
			window.open(varQryString, title, prop);
		}
	}
}
function showCitySearch(val1) 
{
  if(val1 == "crop")
   {
	if(document.forms[0].cmdsave.disabled == false && document.forms[0].txt_cbscustid.value =="")
	  {
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
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].txt_cbscustid.value =="")
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
	}
	
}

function doSave()
{
	document.forms[0].hidsalutation.value=document.forms[0].sel_salutation.value;
	if(document.forms[0].txt_Area.value=="")
	{
		alert("Enter Extent of area of cultivation ");
		document.forms[0].txt_Area.focus();
		return;
	}
	if(document.forms[0].sel_salutation.value=="")
	{
		alert("Select Salutation");
		document.forms[0].sel_salutation.focus();
		return;	
	}
	if(document.forms[0].txt_belonging.value=="")
	{
		alert("Enter Belonging name ");
		document.forms[0].txt_belonging.focus();
		return;
	}
	if(document.forms[0].txt_surveyNo.value=="")
	{
		alert("Enter Survey No ");
		document.forms[0].txt_surveyNo.focus();
		return;
	}
	if(document.forms[0].txt_cropaddress1.value=="")
	{
		alert("Enter address ");
		document.forms[0].txt_cropaddress1.focus();
		return;
	}
	if(document.forms[0].txt_cropaddress2.value=="")
	{
		alert("Enter address ");
		document.forms[0].txt_cropaddress2.focus();
		return;
	}
	if(document.forms[0].txt_cropcity.value=="")
	{
		alert("Select City ");
		document.forms[0].txt_cropcity.focus();
		return;
	}
	if(document.forms[0].txt_cropstate.value=="")
	{
		alert("Select State ");
		document.forms[0].txt_cropstate.focus();
		return;
	}
	if(document.forms[0].txt_cropdistrict.value=="")
	{
		alert("Select District ");
		document.forms[0].txt_cropdistrict.focus();
		return;
	}
	if(document.forms[0].txt_cropcountry.value=="")
	{
		alert("Select Country ");
		document.forms[0].txt_cropcountry.focus();
		return;
	}
	if(document.forms[0].txt_croppin.value=="")
	{
		alert("Enter Pin Code");
		document.forms[0].txt_croppin.focus();
		return;
	}
	modifyCheck();

	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityCrop";
	document.forms[0].hidBeanGetMethod.value="getSecurityCrop";
	document.forms[0].hidSourceUrl.value="/action/securitiesCrop.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callDisableControls(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled = bool1;
	document.forms[0].cmdsave.disabled = bool2;
	document.forms[0].cmdcancel.disabled = bool3;
	document.forms[0].cmddelete.disabled = bool4;
	document.forms[0].cmdclose.disabled = bool5;
}

function doDelete()
{		
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value="delete"; 
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityCrop";
	document.forms[0].hidBeanGetMethod.value="getSecurityCrop";
	document.forms[0].hidSourceUrl.value="/action/securitiesCrop.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?&pagename=sec_crop";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
</script>
</head>
<body onload="onLoad();">
<form method="post" class="normal">

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
				<td class="page_flow" colspan="2">Home -&gt; Securities -&gt; Crop</td>
			</tr>
		</table>
		<table width="35%" border="0" cellspacing="1" cellpadding="0"
			class="outertable">
			<tr>
			<td class="sub_tab_inactive_new" align="center" nowrap="nowrap">
				<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
				Security Details</a></b>
			</td>
			<td class="sub_tab_active_new" align="center"><b>CROP</b></td>
			</tr>
			</table>
			
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
										<td> Security ID : <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span> </td>	
									</tr>
									
									<tr>
									<td>Extent of area of cultivation:<span class="mantatory">&nbsp;*&nbsp;</span></td>
									<td>
						<input type="text" name="txt_Area" size="12" value="<%=Helper.correctNull((String)hshValues.get("SEC_AREA"))%>" maxlength="10" tabindex="4" onKeyPress="allowNumber(this);">&nbsp;
						<select name="sel_Measurement"  tabindex="5" >
                    	<option value="">--Select--</option>
                    	<lapschoice:StaticDataNewTag apptype="135"/></select>
					</td>
									</tr>
									<tr>
					<td width="13%" >CBS Cust ID</td>
				<td id="idsearch" width="34%" ><input type="text"
					name="txt_cbscustid" size="12" maxlength="10" onBlur="readOnly" 
					value="<%=Helper.correctNull((String)hshValues.get("sec_cbsid"))%>">
				<b><span onClick="javascript:callDescCBS()" style="cursor: hand" ><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>
					</tr>
									<tr>
										<td>Belonging to:<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td><select name="sel_salutation" style="width:35%">
										<option value="">---Select-----</option>
										<%
											String apptypecon = "1";
										%>
										<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
										</select>&nbsp;&nbsp;
                    					<input type="text" name="txt_belonging" tabindex="15"  maxlength="20" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_BELONGING"))%>" ></td>
									</tr>
									<tr>
										<td>Survey No:<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td><input type="text" name="txt_surveyNo" tabindex="15" maxlength="15 size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_SUR_NO"))%>" ></td>
									</tr>
									<tr>
										<td rowspan="2" valign="top">Address<span class="mantatory">&nbsp;*&nbsp;</span> </td>
										
										<td><input type="text" name="txt_cropaddress1" tabindex="12"
										maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_ADDRESS_1"))%>"></td>
										<td>City<span class="mantatory">&nbsp;*&nbsp;</span></td>
										
										<td><input type="text" name="txt_cropcity" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_CITY"))%>" >
										<input type="hidden" name="hid_cropcity" value="<%=Helper.correctNull((String)hshValues.get("SEC_CITYCODE"))%>">
										<a  onClick="showCitySearch('crop');" style="cursor: hand" tabindex="13">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
									</tr>
									<tr>
										<td><input type="text" name="txt_cropaddress2" maxlength="50" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_ADDRESS_2"))%>"></td>
										
										<td>State<span class="mantatory">&nbsp;*&nbsp;</span></td>
										<td><input type="text" name="txt_cropstate" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_STATE"))%>" >
										<input type="hidden" name="hid_cropstate" value="<%=Helper.correctNull((String)hshValues.get("SEC_STATECODE"))%>"> </td>
									</tr>
									<tr>
										<td>District<span class="mantatory">&nbsp;*&nbsp;</span></td>
										
										<td><input type="text" name="txt_cropdistrict" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_DIST"))%>" >
										<input type="hidden" name="hid_cropdistrict" value="<%=Helper.correctNull((String)hshValues.get("SEC_DISTCODE"))%>"> 
										<a onClick="callDistrict();" style="cursor: hand" tabindex="14">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a></td>
									
										<td>Country<span class="mantatory">&nbsp;*&nbsp;</span></td>
										
										<td><input type="text" name="txt_cropcountry" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_COUNTRY"))%>" >
										<input type="hidden" name="hid_cropcountry" value="<%=Helper.correctNull((String)hshValues.get("SEC_COUNTRYCODE"))%>"> 
										<a onClick="callCntrySearch('txt_cropcountry','hid_cropcountry')" style="cursor:hand" tabindex="8">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="21"></a> </td>
									</tr>
									<tr>
										<td>Pin Code<span class="mantatory">&nbsp;*&nbsp;</span></td>
										
										<td><input type="text" name="txt_croppin" tabindex="18" maxlength="6" size="10" value="<%=Helper.correctNull((String)hshValues.get("SEC_PIN"))%>" onKeyPress="allowNumber(this)" > </td>
								
									</tr>
									</table>
									</td></tr></table>
									</td></tr></table>

<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
  <tr><td align="center"> 
  <lapschoice:combuttonnew
			btnnames='Edit_Save_Cancel_Delete'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
			</td>
			</tr>
			</table>
			<lapschoice:hiddentag pageid='<%=pageid%>'/>
		<input type="hidden" name="txtperapp_appid"
			value="<%=Helper.correctNull((String) hshValues.get("applicantId"))%>">
		<input type="hidden" name="hidDemoId"
			value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
		<input type="hidden" name="hidSecurityId"
			value="<%=Helper.correctNull((String)request.getParameter("hidSecurityId"))%>">
			
		<input type="hidden" name="old_txt_Area" value="<%=Helper.correctNull((String) hshValues.get("SEC_AREA"))%>">
		
		<input type="hidden" name="hid_VerificationFlag" value="<%=Helper.correctNull((String) hshValues.get("hid_VerificationFlag"))%>" />
		
		<input type="hidden" name="old_txt_belonging" value="<%=Helper.correctNull((String) hshValues.get("SEC_BELONGING"))%>">
		<input type="hidden" name="old_txt_surveyNo" value="<%=Helper.correctNull((String) hshValues.get("SEC_SUR_NO"))%>">
 		<input type="hidden" name="old_txt_cropaddress1" value="<%=Helper.correctNull((String) hshValues.get("SEC_ADDRESS_1"))%>">
 		<input type="hidden" name="old_txt_cropaddress2" value="<%=Helper.correctNull((String) hshValues.get("SEC_ADDRESS_2"))%>">
 		<input type="hidden" name="old_txt_cropcity" value="<%=Helper.correctNull((String) hshValues.get("SEC_CITY"))%>">
 		<input type="hidden" name="old_txt_cropstate" value="<%=Helper.correctNull((String) hshValues.get("SEC_STATE"))%>">
 		<input type="hidden" name="old_txt_cropdistrict" value="<%=Helper.correctNull((String) hshValues.get("SEC_DIST"))%>">
 		<input type="hidden" name="old_txt_cropcountry" value="<%=Helper.correctNull((String) hshValues.get("SEC_COUNTRY"))%>">
 		<input type="hidden" name="old_txt_croppin" value="<%=Helper.correctNull((String) hshValues.get("SEC_PIN"))%>">
 		<input type="hidden" name="old_sel_MeasurementTxt">
 		<input type="hidden" name="old_sel_salutation">
 		<input type="hidden" name="hidmodifiedvalue">  
		<input type="hidden" name="hidmodifiedField">  
		<input type="hidden" name="sel_MeasurementTxt">
 		<input type="hidden" name="sel_salutationTxt">
 		<input type="hidden" name="hidsalutation"> 
</form>
</body>
</html>