<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@include file="../share/directives.jsp"%>
 <%
String sectype = Helper.correctNull((String) request.getParameter("hidsectype"));
String strsecID = Helper.correctNull((String) request.getParameter("hidsecid"));
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
		
		String pageid = Helper.correctNull((String) request.getParameter("pageid"));
		String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
		String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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
var var_sal="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_SAL"))%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";


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
function callLoad()
{	

	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	} 
	
	if(var_sal!="")
	{
		document.forms[0].sel_salutation.value=var_sal;
		document.forms[0].old_sel_salutationText.value = document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text; 
	}
	else
	{
		document.forms[0].sel_salutation.value="";
		document.forms[0].old_sel_salutationText.value = ""; 
	}

	callDisable(true);
}

function doEdit() 
{
	callDisable(false);
	disableControls(true,false,false,false,false);
	document.forms[0].txt_city.readOnly =true;
	document.forms[0].txt_state.readOnly =true;
	document.forms[0].txt_district.readOnly =true;
	document.forms[0].txt_country.readOnly =true;
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
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/securitiesStock.jsp";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateSecurityStock";
		document.forms[0].hidBeanGetMethod.value="getSecurityStock";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="securitymaster";	
		document.forms[0].hidBeanGetMethod.value="getSecurityStock";
		document.forms[0].action=appURL+"action/securitiesStock.jsp";	
		document.forms[0].submit();		
	}	
}
function modifyCheck()
{
	
	
	var temp="";
	var tempname="";

	document.forms[0].sel_salutationText.value=document.forms[0].sel_salutation.options[document.forms[0].sel_salutation.selectedIndex].text;
	if(document.forms[0].sel_salutationText.value!=document.forms[0].old_sel_salutationText.value)
	{
		temp=temp+"old_sel_salutationText"+"@"; 		tempname=tempname+"salutation"+"@";
	}
	if(document.forms[0].txt_belongsto.value!=document.forms[0].old_txt_belongsto.value)
	{
		temp=temp+"old_txt_belongsto"+"@"; 		tempname=tempname+"Belonging to "+"@";
	}
	if(document.forms[0].txt_Surveyno.value!=document.forms[0].old_txt_Surveyno.value)
	{
		temp=temp+"old_txt_Surveyno"+"@"; 		tempname=tempname+"Survey no"+"@";
	}
	if(document.forms[0].txt_address1.value!=document.forms[0].old_txt_address1.value)
	{
		temp=temp+"old_txt_address1"+"@"; 		tempname=tempname+"Address 1"+"@";
	}
	if(document.forms[0].txt_address2.value!=document.forms[0].old_txt_address2.value)
	{
		temp=temp+"old_txt_address2"+"@"; 		tempname=tempname+"Address 2"+"@";
	}
	if(document.forms[0].txt_city.value!=document.forms[0].old_txt_city.value)
	{
		temp=temp+"old_txt_city"+"@"; 		tempname=tempname+"City "+"@";
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
	
	  document.forms[0].hidmodifiedvalue.value = temp;
	  document.forms[0].hidmodifiedField.value = tempname;
	
}
function doSave()
{
	document.forms[0].hidsalutation.value=document.forms[0].sel_salutation.value;
	if(document.forms[0].txt_belongsto.value=="")
	{
		alert("Enter Stock belongs to");
		document.forms[0].txt_belongsto.focus();
		return;	
	}
	else if(document.forms[0].txt_Surveyno.value=="")
	{
		alert("Enter Survey Number");
		document.forms[0].txt_Surveyno.focus();
		return;	
	}
	else if(document.forms[0].sel_salutation.value=="")
	{
		alert("Select Salutation");
		document.forms[0].sel_salutation.focus();
		return;	
	}
	else if(document.forms[0].txt_address1.value=="")
	{
		alert("Enter Address");
		document.forms[0].txt_address1.focus();
		return;	
	}
	else if(document.forms[0].txt_address2.value=="")
	{
		alert("Enter Address");
		document.forms[0].txt_address2.focus();
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
		alert("Enter Pin Code");
		document.forms[0].txt_pin.focus();
		return;	
	}
	modifyCheck();
	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidSourceUrl.value="/action/securitiesStock.jsp";
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateSecurityStock";
	document.forms[0].hidBeanGetMethod.value="getSecurityStock";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
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
function callDistrict() 
{
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
			var varQryString = appURL+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+ varstate + "&code=stock";
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
			prop = prop + ",left=200,top=200";
			window.open(varQryString, title, prop);
		}
	}
}
function showCitySearch(val1)
{
	if(val1 == "stock")
	 {
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
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?&pagename=sec_stock";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
</SCRIPT>
</head>
<body onLoad="callLoad()">
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
		<td class="page_flow">Home -&gt; Securities -&gt; Stock</td>
	</tr>
	
</table>
<table width="50%" border="0" cellspacing="1" cellpadding="0" align="center"
			class="outertable">
		<tr>
			<td class="sub_tab_inactive_new" WIDTH="15%" align="center">
				<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">
				Security Details</a></b>
			</td>
			<td class="sub_tab_active_new" align="center"><b> Stock </b></td>
			</tr>
</table>
<table width="98%" align="center" cellspacing="0" cellpadding="0" border="1" class="outertable">
    <tr> 
      <td> 
        <table width="100%" cellspacing="0" cellpadding="5" align="center" class="outertable">				
			<tr>
					<td colspan="4"> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("strSecID"))%> </span>  </td>	
			</tr>
			<tr>
					<td colspan="4" class="dataheader"><b>Storage Details: </b></td>
			</tr>
			<tr>
					<td width="13%">CBS Cust ID</td>
				<td id="idsearch" width="34%"><input type="text"
					name="txt_cbscustid" size="12" maxlength="10" onBlur="readOnly" 
					value="<%=Helper.correctNull((String)hshValues.get("sec_cbsid"))%>">
				<b><span onClick="javascript:callDescCBS()" style="cursor: hand" ><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>
					</tr>
			<tr>
					<td width="20%">Belonging to<span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%">
						<select name="sel_salutation" style="width:35%">
						<option value="">---Select-----</option>
						<%
							String apptypecon = "1";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
						</select>&nbsp;&nbsp; 
						
						<input type="text" name="txt_belongsto" maxlength="20" size="25" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_NAME"))%>">
					</td>
					<td width="20%">Survey Number<span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txt_Surveyno" tabindex="11" maxlength="15" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_SURVEY"))%>"></td>
			</tr>
			<tr>
					<td width="20%" valign="top">Address <span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txt_address1" tabindex="12" maxlength="50" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_ADDRESS1"))%>"></td>
					<td width="20%">City<span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txt_city" tabindex="15" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_CITYNAME"))%>">
						<input type="hidden" name="hid_city" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_CITY"))%>">
						<a onClick="showCitySearch('stock');" style="cursor: hand" tabindex="13">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
						</a>
					</td>
			</tr>
			<tr>
					<td width="20%">&nbsp;</td>	
					<td width="30%"><input type="text" name="txt_address2" tabindex="14" maxlength="50" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_ADDRESS2"))%>"></td>
					<td width="20%">State<span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txt_state" tabindex="16" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_STATENAME"))%>">
						<input type="hidden" name="hid_state" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_STATE"))%>"></td>
			</tr>
			<tr>
					<td width="20%">District<span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txt_district" tabindex="13" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_DISTNAME"))%>">
						<input type="hidden" name="hid_district" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_DIST"))%>">
						<a onClick="callDistrict();" style="cursor: hand" tabindex="14">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
						</a>
					</td>
					<td width="20%">Country<span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txt_country" tabindex="17" size="30" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_COUNTRYNAME"))%>">
						<input type="hidden" name="hid_country" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_COUNTRY"))%>"> 
						<a onClick="callCntrySearch('txt_country','hid_country')" style="cursor:hand" tabindex="8">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="21">
						</a> 
					</td>
			</tr>
			<tr>
					<td width="20%">Pin Code<span class="mantatory">&nbsp;*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txt_pin" tabindex="18" maxlength="6" size="15" value="<%=Helper.correctNull((String)hshValues.get("SEC_STOCK_ZIP"))%>" onKeyPress="allowNumber(this)" > </td>
					<td width="20%">&nbsp;</td>	
					<td width="30%">&nbsp;</td>	
			</tr>
		</table>
	</td>
 </tr>
</table>
<br>

<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

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
<input type="hidden" name="old_txt_belongsto" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_NAME"))%>">
<input type="hidden" name="old_txt_Surveyno" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_SURVEY"))%>">
<input type="hidden" name="old_txt_address1" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_ADDRESS1"))%>">
<input type="hidden" name="old_txt_address2" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_ADDRESS2"))%>">
<input type="hidden" name="old_txt_city" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_CITYNAME"))%>">
<input type="hidden" name="old_txt_state" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_STATENAME"))%>">
<input type="hidden" name="old_txt_district" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_DISTNAME"))%>">
<input type="hidden" name="old_txt_country" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_COUNTRYNAME"))%>">
<input type="hidden" name="old_txt_pin" value="<%=Helper.correctNull((String) hshValues.get("SEC_STOCK_ZIP"))%>">
<input type="hidden" name="old_sel_salutationText">
<input type="hidden" name="sel_salutationText">

<input type="hidden" name="hid_VerificationFlag" value="<%=Helper.correctNull((String) hshValues.get("hid_VerificationFlag"))%>" />
<input type="hidden" name="hidsalutation"> 

</form>
</body>
</html>