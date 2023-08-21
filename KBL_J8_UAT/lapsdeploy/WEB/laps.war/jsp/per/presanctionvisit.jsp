<%@include file="../share/directives.jsp"%>
<%
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String stremployment = Helper.correctNull((String) session.getAttribute("perapp_employment"));
	String strvehicleduplikeyobtain = Helper.correctNull((String) hshValues.get("pre_vehicleduplikeyobtain"));
	String strpropcompleted = Helper.correctNull((String) hshValues.get("pre_propcompleted"));
	String strpermissionobtained = Helper.correctNull((String) hshValues.get("pre_permissionobtained"));
	String strpropvalreportobtained = Helper.correctNull((String) hshValues.get("pre_propvalreportobtained"));
	String strpropdesc = Helper.correctNull((String) hshValues.get("pre_propdesc"));
	String strproptopurchase = Helper.correctNull((String) hshValues.get("pre_proptopurchase"));
	String strproposed = Helper.correctNull((String) hshValues.get("pre_proposed"));
	String strapplnamedisplayed = Helper.correctNull((String) hshValues.get("pre_applnamedisplayed"));
	String straccdetailsverifyfrom = Helper.correctNull((String) hshValues.get("pre_accdetailsverifyfrom"));
	String strproptype = Helper.correctNull((String) hshValues.get("pre_proptype"));
	String strownernature = Helper.correctNull((String) hshValues.get("pre_ownernature"));
	String strSector = Helper.correctNull((String) request.getParameter("hidsector"));
	String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
	String strapplevel = Helper.correctNull((String)request.getParameter("applevel"));
	String strstatus = Helper.correctNull((String) request.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper.correctNull((String) hshValues.get("status"));
%>
<html>
<head>
<title>Pre Sanction Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varResidence="<%=Helper.correctNull((String) hshValues.get("pre_residence"))%>";
var loan_receivedate="<%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%>";
var stremployment="<%=stremployment%>";
var varOrgLevel="<%=strOrgLevel%>";	
var varright= "<%=Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18)%>";

function whileLoading()
{	
	if(varResidence!="")
	{
		document.forms[0].sel_residence.value=varResidence;
	}
	else
	{
		document.forms[0].sel_residence.value="S";
	}
		
	 if(stremployment=="1")
 	  {
   	 	document.all.verify.innerHTML='Details Verified by/through <br> Personal Visit to Office on <b><span class="mantatory">*&nbsp;</span</b>';
 	  }	
//Added By Zahoorunnisa.S for Button Functionality after discussion with Suresh
	
	//If access through the Loan Application Register and its at Branch 
	if("<%=strSaral%>"=="saral" && "<%=strOrgLevel%>"=="A"){ 
		//If the Application is in open status
		if("<%=strstatus%>"=="O" && varright=="w"){
		    enableButtons(false,true,true,true,false);
		}else{
			enableButtons(true,true,true,true,false);	
		}
	}else if("<%=strSaral%>"=="saral" && "<%=strapplevel%>" == ""){ 
		enableButtons(true,true,true,true,false);	
    }else{
		if("<%=strapplevel%>" == "S"){
			enableButtons(true,true,true,true,false);
		}
	}
	//End
	disableFields(true);	
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if((document.forms[0].elements[i].type=="text")||(document.forms[0].elements[i].type=="textarea"))
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		 if(document.forms[0].elements[i].type=="select-one")
		 {
		   document.forms[0].elements[i].disabled=val;		  
		  }		  
	}
}	
function doCancel()
{
	if(ConfirmMsg('102'))
	{	      			
		document.forms[0].action=appURL+"controllerservlet";
		 document.forms[0].hidBeanId.value="Inspection";		
		document.forms[0].hidBeanGetMethod.value="getPDCCharges";
		document.forms[0].action=appURL+"action/presanctionvisit.jsp";	
		document.forms[0].submit();		
	}	
}
function doEdit()
{
	document.forms[0].hidMethod.value="";
	disableFields(false);
	enableButtons(true,false,false,false,false);
	if(varOrgLevel=='A' && "<%=strSaral%>" != "saral")
	{
		document.forms[0].txt_applicant.readOnly=true;
		document.forms[0].txt_father.readOnly=true;
		document.forms[0].txt_address.readOnly=true;	
	}
}
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}
function doSave()
{
	if(document.forms[0].txt_loanpurpose.value=="")
		{
		ShowAlert(112,"Purpose of loan");
		document.forms[0].txt_loanpurpose.focus();
		return;
		}
	if(document.forms[0].txt_visitofficercomment.value=="")
		{
		ShowAlert(112,"Comments of Visiting Officer");
		document.forms[0].txt_visitofficercomment.focus();
		return;
		}
	if(document.forms[0].txt_signplace.value=="")
		{
		ShowAlert(112,"Place of Visiting Officer");
		document.forms[0].txt_signplace.focus();
		return;
		}
	if(document.forms[0].txt_visitofficername.value=="")
		{
		ShowAlert(112,"Name of Visiting Officer");
		document.forms[0].txt_visitofficername.focus();
		return;
		}
	if(document.forms[0].txt_signdate.value=="")
		{
		ShowAlert(112,"Date of Visit");
		document.forms[0].txt_signdate.focus();
		return;
		}
	if(document.forms[0].txt_visitofficerdesign.value=="")
		{
		ShowAlert(112,"Designation of Visiting Officer");
		document.forms[0].txt_visitofficerdesign.focus();
		return;
		}
         if(stremployment=="1")
	  	  {
			if(document.forms[0].txt_employerverify.value=="")
		  	{
				ShowAlert(112,"Details verified by/through personal visit to office on ");
				document.forms[0].txt_employerverify.focus();
				return;
			}
		  }	
    document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanGetMethod.value="getPDCCharges";
	document.forms[0].hidBeanId.value="Inspection";
	document.forms[0].action=appURL+"action/presanctionvisit.jsp";	
	document.forms[0].submit();
}
function doDelete()
{
if(ConfirmMsg(101))
		{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanGetMethod.value="getPDCCharges";
		document.forms[0].hidBeanId.value="Inspection";
		document.forms[0].action=appURL+"action/presanctionvisit.jsp";	
		document.forms[0].submit();
		}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{		
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
			{
				document.forms[0].method="post";
				document.forms[0].action=appURL+"action/mainnav.jsp";
				document.forms[0].submit();
			}
			else
			{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>"+"action/perpropertydetails.jsp";
				document.forms[0].submit();
			}
	}
}
function doPrint()
{
if(("<%=strSaral%>"=="saral"))
	{
		var inwardno=document.forms[0].inwardno.value;
		var varsaral="<%=strSaral%>";
		var appname=document.forms[0].appname.value;
		var hidsector=document.forms[0].hidsector.value;
		var purl = appURL+"action/presanction_newreport.jsp?hidBeanGetMethod=getPDCCharges&hidBeanId=Inspection&inwardno="+inwardno+"&hidsaral="+varsaral+"&appname="+appname+"&hidsector="+hidsector;
		prop = "scrollbars=yes,width=750,height=550,statusbar=yes,menubar=yes";	
		xpos = (screen.width - 750) / 2;
		ypos = (screen.height - 650) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print1";	
		window.open(purl,title,prop);
	}
	else
	{
	    var inwardno=document.forms[0].inwardno.value;
		appno = document.forms[0].appno.value;	
		var purl = appURL+"action/presanction_newreport.jsp?hidBeanGetMethod=getPDCCharges&hidBeanId=Inspection&appno="+appno+"&inwardno="+inwardno;
		prop = "scrollbars=yes,width=750,height=550,statusbar=yes,menubar=yes";	
		xpos = (screen.width - 750) / 2;
		ypos = (screen.height - 650) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print1";	
		window.open(purl,title,prop);
	}
}
function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
		if(pgdt.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(maxdt))
			{
				alert("Date of Inspection cannot be lesser than Application Received Date");
				document.forms[0].txt_signdate.value="";
				document.forms[0].txt_signdate.focus();								
			}			
		}
}
</script>
</head>
<body onload="javascript:whileLoading();">
<form name="existpropos" method="post" class="normal"> <%if (strSaral.equalsIgnoreCase("saral")) {%> 
<lapschoice:saralreportTag tabid="3" sector="<%=strSector%>" /> <lapschoice:inward /> 
<%} else { %> <jsp:include page="../share/Applurllinkper.jsp" flush="true"> <jsp:param name="pageid" value="10" /> 
</jsp:include> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"> 
<tr> <td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Pre-Sanction 
Report</td></tr> </table><lapschoice:application /> <jsp:include page="../share/apprlinktab.jsp" flush="true"> 
<jsp:param name="tabid" value="9" /> </jsp:include><%}%> <table width="97%" border="0" class="outertable" align="center"> <tr> 
<td align="center"><b>Pre-Sanction Visit Details  For Retail Loans</b></td></tr> 
</table><table width="97%" align="center" border="1" cellspacing="0" cellpadding="3" class="outertable"> 
<tr> <td> <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center" class="outertable"> 
<tr> <td ><b>Name of the Applicant</b></td><td ><b>Father&#146;s / Husband&#146;s 
Name</b></td><td colspan="2" ><b>Residential Address</b></td></tr> <%
				String title = Helper.correctNull((String) hshValues.get("perapp_title"));
				String fat_hus_name = "";
				if (title.equalsIgnoreCase("MRS")) {
					fat_hus_name = Helper.correctNull((String) hshValues.get("perapp_husname"));
				} else {
					fat_hus_name = Helper.correctNull((String) hshValues.get("perapp_fatname"));
				}
			%> <tr> <td><input type="text" name="txt_applicant" maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_name"))%>"> 
</td><td ><input type="text" name="txt_father" maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("perapp_fatname"))%>" readOnly="readonly"> 
</td><td colspan="2" ><textarea name="txt_address" cols="50" rows="3" onKeyPress="textlimit(this,200)"onkeyup="checkTextArealimit(this,200);"><%=Helper.correctNull((String) hshValues.get("pre_address"))%></textarea></td></tr> 
<tr> <td width="30%">Distance from Branch (Kms)</td><td width="20%"><input type="text" name="txt_distance"
					maxlength="5" size="10" onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_distance"))%>"> 
</td><td width="30%">Date of Visit</td><td width="20%"> <input type="text" name="txt_visitdate" maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)" size="12"
							value="<%=Helper.correctNull((String) hshValues.get("pre_visitdate"))%>"> 
<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_visitdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender"></a> 
</td></tr> <tr> <td>Purpose of Loan<b><span class="mantatory">*</span></b></td><td ><input type="text" size="43"
					name="txt_loanpurpose" maxlength="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_loanpurpose"))%>"> 
</td><td>Name of the nearest branch of our bank</td><td ><input type="text" name="txt_nearestbranch"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_nearestbranch"))%>"> 
</td></tr> <tr> <td >Residence is</td><td ><select name="sel_residence"> <option value="S" selected="selected">Select</option> 
<option value="1">Owned</option> <option value="2">Rented</option> <option value="3">Leased</option> 
<option value="4">Others</option> <option value="5">Provided by Employer</option> 
</select></td><td >Staying since</td><td ><input type="text" name="txt_stayingsince"
					maxlength="4" size="6" onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_stayingsince"))%>"> 
</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <tr> <td colspan="4"><b>Nearby 
landmark for identification : </b></td></tr> <tr> <td>East</td><td><input type="text" name="txt_homeaddreastlandmark"
					maxlength="45" size="45" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_homeaddreastlandmark"))%>"> 
</td><td>West</td><td><input type="text" name="txt_homeaddrwestlandmark"
					maxlength="45" size="45" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_homeaddrwestlandmark"))%>"> 
</td></tr> <tr> <td>North</td><td><input type="text" name="txt_homeaddrnorthlandmark"
					maxlength="45" size="45" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_homeaddrnorthlandmark"))%>"> 
</td><td>South</td><td><input type="text" name="txt_homeaddrsouthlandmark"
					maxlength="45" size="45" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_homeaddrsouthlandmark"))%>"> 
</td></tr> <tr> <td colspan="4" >Proof for verification of Residential address 
--- Ration Card No., Voters ID Card No., Passport No./PAN Card No.,Rent Agreement, 
Electricity/Telephone 6 months and -1-latest bill). Whether residing with parents/relatives</td></tr> 
<tr> <td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td><td >&nbsp;</td></tr> <tr> <td >Name of the Supplier</td><td ><input type="text" name="txt_supplier"
					maxlength="40" onKeyPress="notAllowSplChar()" size="43"
					value="<%=Helper.correctNull((String) hshValues.get("pre_supplier"))%>"> 
</td><td >Purchase price (incl Tax)</td><td ><lapschoice:CurrencyTag
					name="txt_purchaseprice" maxlength="12" size="15"
					value='<%=Helper.correctNull((String) hshValues.get("pre_purchaseprice"))%>' /> 
</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <tr> <td colspan="4" ><b>Genuineness 
of Quotation verified</b></td></tr> <tr> <td height="19" >Over Phone No.</td><td height="19" ><input type="text"
					name="txt_genuinessphone" style="text-align: left" maxlength="15"
					onKeyPress="allowPhone()" size="20"
					value="<%=Helper.correctNull((String) hshValues.get("pre_genuinessphone"))%>"> 
</td><td height="19" >Name of the Person Contacted</td><td height="19" ><input type="text"
					name="txt_genphcontperson" maxlength="40" size="43"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_genphcontperson"))%>"> 
</td></tr> <tr> <td >By Personal Visit</td><td ><input type="text"
					name="txt_genuinesspersonal" onKeyPress="notAllowSplChar()"
					size="43" maxlength="40"
					value="<%=Helper.correctNull((String) hshValues.get("pre_genuinesspersonal"))%>"> 
</td><td >Name of the Person Contacted</td><td ><input type="text"
					name="txt_genpercontperson" maxlength="40" size="43"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_genpercontperson"))%>"> 
</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <tr> <td colspan="4" ><b>Occupation 
of Applicant (Give Details) :</b></td></tr> <%
				if ((strSaral.equalsIgnoreCase("saral"))
						|| (stremployment.equalsIgnoreCase("1"))) {
			%> <tr> <td colspan="2" ><b>Service </b></td><td colspan="2" ><b>Employment 
Details </b></td></tr> <tr> <td >Name of Employer</td><td ><input type="text" name="txt_employername"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employername"))%>"> 
</td><td id="verify">Details Verified by / Through<br>Personal Visit to office on</td><td ><input type="text"
					name="txt_employerverify" size="43" maxlength="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employerverify"))%>"> 
</td></tr> <tr> <td >Address</td><td ><textarea name="txt_employeraddress"
					onKeyPress="notAllowSplChar();textlimit(this,100)" wrap="VIRTUAL" cols="40" onkeyup="checkTextArealimit(this,100);"><%=Helper.correctNull((String) hshValues.get("pre_employeraddress"))%></textarea> 
</td><td >Name of the Person Contacted</td><td ><input type="text"
					name="txt_emppersoncontact" size="43" maxlength="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_emppersoncontact"))%>"> 
</td></tr> <tr> <td >Designation</td><td ><input type="text" name="txt_employeedesig"
					size="43" maxlength="40" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employeedesig"))%>"> 
</td><td >Gross Annual / Monthly income -<br>If any deviation found</td><td ><lapschoice:CurrencyTag
					name="txt_employeeincome" maxlength="12" size="15"
					value='<%=Helper.correctNull((String) hshValues.get("pre_employeeincome"))%>' /> 
</td></tr> <tr> <td >Working Since</td><td ><input type="text"
					name="txt_employeeworksince" size="6" maxlength="4"
					onKeyPress="allowInteger()" onBlur="checkcurrentyear(this)"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employeeworksince"))%>"> 
</td><td >Employee No.</td><td ><input type="text" name="txt_employeeno"
					size="18" maxlength="15" onKeyPress="notAllowSplChar();allowAlphaNumeric()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employeeno"))%>"> 
</td></tr> <tr> <td >Whether Confirmed/ Probation/ or On contract basis</td><td ><input type="text"
					name="txt_employerconfirm" size="43" maxlength="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employerconfirm"))%>"> 
</td><td >&nbsp;</td><td >&nbsp;</td></tr> <tr> <td >Phone No.</td><td >Office</td><td >Residence</td><td>Mobile</td></tr> 
<tr> <td >&nbsp;</td><td ><input type="text"
					name="txt_employerofficephone" size="18" maxlength="15"
					onKeyPress="allowPhone()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employerofficephone"))%>"> 
</td><td ><input type="text"
					name="txt_employerresiphone" size="18" maxlength="15"
					onKeyPress="allowPhone()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employerresiphone"))%>"> 
</td><td ><input type="text"
					name="txt_employermobile" size="15" maxlength="10"
					onKeyPress="allowPhone()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_employermobile"))%>"> 
</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <%
				}
				if ((strSaral.equalsIgnoreCase("saral"))
						|| stremployment.equalsIgnoreCase("2")) {
			%> <tr> <td colspan="4" ><b>Business</b></td></tr> <tr> 
<td >Name of the firm</td><td ><input type="text"
					name="txt_businessfirmname" maxlength="40" size="43"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_businessfirmname"))%>"> 
</td><td >Address</td><td ><textarea name="txt_businessfirmaddr"
					onKeyPress="notAllowSplChar();textlimit(this,100)" wrap="VIRTUAL" cols="40" onkeyup="checkTextArealimit(this,100);" ><%=Helper.correctNull((String) hshValues.get("pre_businessfirmaddr"))%></textarea> 
</td></tr> <tr> <td >Registration No.</td><td ><input type="text"
					name="txt_businessfirmregno" maxlength="35" size="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_businessfirmregno"))%>"> 
</td><td >License No.</td><td ><input type="text"
					name="txt_busifirmlicenceno" maxlength="35" size="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmlicenceno"))%>"> 
</td></tr> <tr> <td colspan="4"><b>Nearby landmark for identification :</b></td></tr> 
<tr> <td>East</td><td><input type="text" name="txt_busifirmeastlandmark"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmeastlandmark"))%>"> 
</td><td>West</td><td><input type="text" name="txt_busifirmwestlandmark"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmwestlandmark"))%>"> 
</td></tr> <tr> <td>North</td><td><input type="text" name="txt_busifirmnorthlandmark"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmnorthlandmark"))%>"> 
</td><td>South</td><td><input type="text" name="txt_busifirmsouthlandmark"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmsouthlandmark"))%>"> 
</td></tr> <tr> <td  colspan="4">&nbsp;</td></tr> <tr> <td >Applicant's position in the Firm</td><td ><input type="text"
					name="txt_busifirmposition" maxlength="40" size="43"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmposition"))%>"> 
</td><td >Year of Establishment</td><td ><input type="text"
					name="txt_busifirmestabyr" maxlength="4" size="5"
					onKeyPress="allowInteger()" onBlur="checkcurrentyear(this)"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmestabyr"))%>"> 
</td></tr> <tr> <td >Nature of business</td><td ><input type="text"
					name="txt_busifirmnature" size="43" maxlength="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_busifirmnature"))%>"> 
</td><td >Applicant's Name board displayed</td><td ><select name="sel_applnamedisplayed"> 
<%
						if (strapplnamedisplayed.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strapplnamedisplayed.trim().equalsIgnoreCase("Y")) {
					%> <option value="Y" selected="selected">Yes</option> 
<%
						} else {
					%> <option value="Y">Yes</option> <%
						}
							if (strapplnamedisplayed.trim().equalsIgnoreCase("N")) {
					%> <option value="N" selected="selected">No</option> 
<%
						} else {
					%> <option value="N">No</option> <%
						}
					%> </select></td></tr> <%
				}
				if ((strSaral.equalsIgnoreCase("saral"))
						|| stremployment.equalsIgnoreCase("3")) {
			%> <tr> <td colspan="4" ><b>Self - Employment &amp; Professional 
</b></td></tr> <tr> <td >Occupation</td><td ><input type="text"
					name="txt_selfoccupation" maxlength="40" size="43"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfoccupation"))%>"> 
</td><td >Business Address</td><td ><textarea name="txt_selfempaddress"
					wrap="VIRTUAL" cols="40" onKeyPress="textlimit(this,100)" onkeyup="checkTextArealimit(this,100);><%=Helper.correctNull((String) hshValues.get("pre_selfempaddress"))%></textarea> 
</td></tr> <tr> <td >Registration No.</td><td ><input type="text" name="txt_selfempregno"
					maxlength="20" size="40" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempregno"))%>"> 
</td><td >License No.</td><td ><input type="text"
					name="txt_selfemplicenceno" maxlength="20" size="40"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfemplicenceno"))%>"> 
</td></tr> <tr> <td colspan="4"><b>Nearby landmark of Identification</b></td></tr> 
<tr> <td>East</td><td><input type="text" name="txt_selfempeastlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempeastlandmark"))%>"> 
</td><td>West</td><td><input type="text" name="txt_selfempwestlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempwestlandmark"))%>"> 
</td></tr> <tr> <td>North</td><td><input type="text" name="txt_selfempnorthlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempnorthlandmark"))%>"> 
</td><td>South</td><td><input type="text" name="txt_selfempsouthlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempsouthlandmark"))%>"> 
</td></tr> <tr> <td >Phone No.</td><td >Office</td><td >Residence</td><td >Mobile</td></tr> 
<tr> <td >&nbsp;</td><td ><input type="text" size="18"
					name="txt_selfempofficephone" maxlength="15"
					onKeyPress="allowPhone()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempofficephone"))%>"> 
</td><td ><input type="text"
					name="txt_selfempresiphone" size="18" maxlength="15"
					onKeyPress="allowPhone()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempresiphone"))%>"> 
</td><td ><input type="text" size="15"
					name="txt_selfempmobile" maxlength="10" onKeyPress="allowPhone()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_selfempmobile"))%>"> 
</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <%
				}
				if ((strSaral.equalsIgnoreCase("saral"))
						|| stremployment.equalsIgnoreCase("3")
						|| stremployment.equalsIgnoreCase("2")
						|| stremployment.equalsIgnoreCase("1")) {
			%> <tr> <td colspan="4" ><b>Details verified from : </b> 
</td></tr> <tr> <td >a. Form No. 16 (For the Financial year ended March 20....)</td><td ><INPUT TYPE="text" NAME="txt_form16"
					SIZE="12" MAXLENGTH="10" ONKEYPRESS="notAllowSplChar()"
					VALUE="<%=Helper.correctNull((String) hshValues.get("pre_form16"))%>"></td><td >b. 
Last Salary Slip (For the Month of)</td><td ><input type="text" name="txt_salslip"
					size="25" maxlength="20" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_salslip"))%>"> 
</td></tr> <tr> <td >c. Income Tax return for A.Y. (Along with original copy of 
Tax challan period)</td><td ><input type="text" size="30"
					name="txt_taxreturn" maxlength="25" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_taxreturn"))%>"> 
</td><td >&nbsp;</td><td >&nbsp;</td></tr> <%
				}
			%> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <tr> 
<td><b>Present bankers</b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <tr> <td>Name 
of the Bank</td><td><input type="text" name="txt_presentbank" maxlength="40"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_presentbank"))%>"> 
</td><td>Branch</td><td><input type="text" name="txt_presentbankbranch"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_presentbankbranch"))%>"> 
</td></tr> <tr> <td>Type of A/C.</td><td><input type="text" name="txt_presentbankactype"
					maxlength="18" size="20" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_presentbankactype"))%>"> 
</td><td>A/C No.</td><td><input type="text" name="txt_presentbankaccno"
					maxlength="18" size="20" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_presentbankaccno"))%>"> 
</td></tr> <tr> <td>Details of A/C. Verified From</td><td><select name="sel_accdetailsverifyfrom"> 
<%
						if (straccdetailsverifyfrom.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
						if (straccdetailsverifyfrom.trim().equalsIgnoreCase("1")) {
					%> <option value="1" selected="selected">Bank 
Statement</option> <%
						} else {
					%> <option value="1">Bank Statement</option> 
<%
						}
						if (straccdetailsverifyfrom.trim().equalsIgnoreCase("2")) {
					%> <option value="2" selected="selected">Pass 
Book</option> <%
						} else {
					%> <option value="2">Pass Book</option> 
<%
						}
					%> </select></td><td>&nbsp;</td><td>&nbsp;</td></tr> 
<tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <tr> <td><b>Loan Outstanding</b></td><td><b> 
With our Bank</b></td><td><b>With other Bank</b></td><td>&nbsp;</td></tr> <tr> <td>Name of the Branch</td><td><input type="text" name="txt_ourbankname" maxlength="43"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_ourbankname"))%>"> 
</td><td><input type="text" name="txt_otherbankname" maxlength="43"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_otherbankname"))%>"> 
</td><td>&nbsp;</td></tr> <tr> <td>Type of Loan</td><td><input type="text" name="txt_ourbankloantype"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_ourbankloantype"))%>"> 
</td><td><input type="text" name="txt_otherbankloantype"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_otherbankloantype"))%>"> 
</td><td>&nbsp;</td></tr> <tr> <td>Amount Sanctioned</td><td><lapschoice:CurrencyTag name="txt_ourbanksancamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_ourbanksancamt"))%>' /> 
</td><td><lapschoice:CurrencyTag name="txt_otherbanksancamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_otherbanksancamt"))%>' /> 
</td><td>&nbsp;</td></tr> <tr> <td>Balance Outstanding</td><td><lapschoice:CurrencyTag name="txt_ourbankosamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_ourbankosamt"))%>' /> 
</td><td><lapschoice:CurrencyTag name="txt_otherbankosamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_otherbankosamt"))%>' /> 
</td><td>&nbsp;</td></tr> <tr> <td>Overdue Amount, if any</td><td><lapschoice:CurrencyTag name="txt_ourbankoverdueamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_ourbankoverdueamt"))%>' /> 
</td><td><lapschoice:CurrencyTag name="txt_otherbankoverdueamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_otherbankoverdueamt"))%>' /> 
</td><td>&nbsp;</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <%
				if ((strSaral.equalsIgnoreCase("saral"))
						|| stremployment.equalsIgnoreCase("9")) {
			%> <tr> <td><b>Pension </b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
<tr> <td>Pension Account No.</td><td><input type="text" name="txt_pensionaccno" maxlength="30"
					size="35" onKeyPress="notAllowSplChar();allowAlphaNumeric()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_pensionaccno"))%>"> 
</td><td>Name of the Branch</td><td><input type="text" name="txt_pensionaccbranch"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_pensionaccbranch"))%>"> 
</td></tr> <tr> <td>Monthly pension Amount</td><td><lapschoice:CurrencyTag name="txt_pensionamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_pensionamt"))%>' /> 
</td><td>PPO No.</td><td><input type="text" name="txt_pensionpayorderno"
					maxlength="20" size="25" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_pensionpayorderno"))%>"> 
</td></tr> <tr> <td>Name of the Nominee for Pension</td><td><input type="text" name="txt_pensionnominee" maxlength="40"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_pensionnominee"))%>"> 
</td><td>&nbsp;</td><td>&nbsp;</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <%
				}
			%> <tr> <td colspan="4"><b>Inspection Details</b></td></tr> 
<tr> <td>Title deed</td><td colspan="3"><input type="text" name="txt_titledeed"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_titledeed"))%>"> 
</td></tr> <tr> <td>Deed No.</td><td><input type="text" name="txt_titledeedno" maxlength="30"
					size="35" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_titledeedno"))%>"> 
</td><td>Name of Sub - Registrar office</td><td><input type="text" name="txt_subregoffice" size="43"
					maxlength="40" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_subregoffice"))%>"> 
</td></tr> <tr> <td>Name of the Owner/s of the Property</td><td><input type="text" name="txt_propownername" maxlength="40"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propownername"))%>"> 
</td><td>Property type</td><td><select name="sel_proptype"> <%
						if (strproptype.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---select---&gt;</option> 
<%
						}
						if (strproptype.trim().equalsIgnoreCase("1")) {
					%> <option value="1" selected="selected">Residential</option> 
<%
						} else {
					%> <option value="1">Residential</option> 
<%
						}
						if (strproptype.trim().equalsIgnoreCase("2")) {
					%> <option value="2" selected="selected">Commerical</option> 
<%
						} else {
					%> <option value="2">Commerical</option> 
<%
						}
					%> </select></td><tr> <td>Nature of Ownership</td><td><select name="sel_ownernature" size="1"> 
<%
						if (strownernature.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
						if (strownernature.trim().equalsIgnoreCase("1")) {
					%> <option value="1" selected="selected">Free Hold</option> <%
						} else {
					%> <option value="1">Free Hold</option> 
<%
						}
						if (strownernature.trim().equalsIgnoreCase("2")) {
					%> <option value="2" selected="selected">Lease Hold</option> <%
						} else {
					%> <option value="2">Lease Hold</option> 
<%
						}
						if (strownernature.trim().equalsIgnoreCase("3")) {
					%> <option value="3" selected="selected">Licence</option> 
<%
						} else {
					%> <option value="3">Licence</option> 
<%
						}
						if (strownernature.trim().equalsIgnoreCase("4")) {
					%> <option value="4" selected="selected">Undivided Interest (Give details of Share)</option> 
					<% } else {
					%> <option value="4">Undivided Interest (Give details of Share)</option> 
					<% }
						if (strownernature.trim().equalsIgnoreCase("5")) {
					%> <option value="5" selected="selected">Trust Property</option> <%
						} else {
					%> <option value="5">Trust Property</option> 
<%
						}
						if (strownernature.trim().equalsIgnoreCase("6")) {
					%> <option value="6" selected="selected">Assignee</option> 
<%
						} else {
					%> <option value="6">Assignee</option> 
<%
						}
						if (strownernature.trim().equalsIgnoreCase("7")) {
					%> <option value="7" selected="selected">Title Only by Possession</option> <%
						} else {
					%> <option value="7">Title Only by Possession</option> 
<%
						}
						if (strownernature.trim().equalsIgnoreCase("8")) {
					%> <option value="8" selected="selected">As a Member / Share holder of Society</option> <%
						} else {
					%> <option value="8">As a Member / Share holder of Society</option> <%
						}
					%> </select></td><td>&nbsp;</td><td>&nbsp;</td></tr> 
<tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <%
				if ((strSaral.equalsIgnoreCase("saral"))
						|| prd_type.equalsIgnoreCase("pH")) {
			%> <tr> <td colspan="4"><b>Details of Property</b></td></tr> 
<tr> <td>To be Purchased - Plot, House, Flat</td><td><select name="sel_proptopurchase"> 
<%
						if (strproptopurchase.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strproptopurchase.trim().equalsIgnoreCase("Y")) {
					%> <option value="Y" selected="selected">Yes</option> 
<%
						} else {
					%> <option value="Y">Yes</option> <%
						}
							if (strproptopurchase.trim().equalsIgnoreCase("N")) {
					%> <option value="N" selected="selected">No</option> 
<%
						} else {
					%> <option value="N">No</option> <%
						}
					%> </select></td><td>Proposed</td><td><select name="sel_proposed"> 
<%
						if (strproposed.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strproposed.trim().equalsIgnoreCase("Y")) {
					%> <option value="Y" selected="selected">Yes</option> 
<%
						} else {
					%> <option value="Y">Yes</option> <%
						}
							if (strproposed.trim().equalsIgnoreCase("N")) {
					%> <option value="N" selected="selected">No</option> 
<%
						} else {
					%> <option value="N">No</option> <%
						}
					%> </select></td></tr> <tr> <td>Address</td><td><textarea name="txt_propaddress" wrap="VIRTUAL" cols="40" onKeyPress="textlimit(this,100)"  onkeyup="checkTextArealimit(this,100);"><%=Helper.correctNull((String) hshValues
								.get("pre_propaddress"))%></textarea> 
</td><td>Description of Property</td><td><select name="sel_propdesc"> <%
						if (strpropdesc.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strpropdesc.trim().equalsIgnoreCase("R")) {
					%> <option value="R" selected="selected">Residential</option> 
<%
						} else {
					%> <option value="R">Residential</option> 
<%
						}
							if (strpropdesc.trim().equalsIgnoreCase("C")) {
					%> <option value="C" selected="selected">Commercial</option> 
<%
						} else {
					%> <option value="C">Commercial</option> 
<%
						}
							if (strpropdesc.trim().equalsIgnoreCase("M")) {
					%> <option value="M" selected="selected">Mixed</option> 
<%
						} else {
					%> <option value="M">Mixed</option> <%
						}
					%> </select></td></tr> <tr> <td>Plot No.</td><td><input type="text" name="txt_propplotno" maxlength="10"
					size="15" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propplotno"))%>"> 
</td><td>Survey No.</td><td><input type="text" name="txt_propsurveyno" maxlength="10"
					size="15" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propsurveyno"))%>"> 
</td></tr> <tr> <td>Street No.</td><td><input type="text" name="txt_propstreetno" maxlength="10"
					size="15" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propstreetno"))%>"> 
</td><td>Ward No.</td><td><input type="text" name="txt_propwardno" maxlength="10"
					size="15" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propwardno"))%>"> 
</td></tr> <tr> <td colspan="4"><b>Nearby landmark for Identification</b></td></tr> 
<tr> <td>East</td><td><input type="text" name="txt_propeastlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propeastlandmark"))%>"> 
</td><td>West</td><td><input type="text" name="txt_propwestlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propwestlandmark"))%>"> 
</td></tr> <tr> <td>North</td><td><input type="text" name="txt_propnorthlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propnorthlandmark"))%>"> 
</td><td>South</td><td><input type="text" name="txt_propsouthlandmark"
					maxlength="43" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propsouthlandmark"))%>"> 
</td></tr> <tr> <td>No. of Floors</td><td><input type="text" size="7" name="txt_propnooffloors"
					maxlength="2" onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propnooffloors"))%>"> 
</td><td>Proposed flat on Floor No.</td><td><input type="text" size="7" name="txt_propfloorno"
					maxlength="5" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propfloorno"))%>"> 
</td></tr> <tr> <td>Age of Building</td><td><input type="text" size="7" name="txt_propage"
					maxlength="2" onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propage"))%>"> 
</td><td>Balance life of building</td><td><input type="text" size="7" name="txt_propagebalance"
					maxlength="2" onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propagebalance"))%>"> 
</td></tr> <tr> <td>Any prior charges</td><td><input type="text" size="43" name="txt_proppriorcharges"
					maxlength="9" onKeyPress="allowNumber(this)"
					value="<%=Helper.correctNull((String) hshValues.get("pre_proppriorcharges"))%>"
					style="text-align: right"></td><td>Valuation report from Architect / Engineer obtained</td><td><select name="sel_propvalreportobtained"> 
<%
						if (strpropvalreportobtained.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strpropvalreportobtained.trim().equalsIgnoreCase("Y")) {
					%> <option value="Y" selected="selected">Yes</option> 
<%
						} else {
					%> <option value="Y">Yes</option> <%
						}
							if (strpropvalreportobtained.trim().equalsIgnoreCase("N")) {
					%> <option value="N" selected="selected">No</option> 
<%
						} else {
					%> <option value="N">No</option> <%
						}
					%> </select></td></tr> <tr> <td>Sale Amount</td><td><lapschoice:CurrencyTag name="txt_propsaleamt"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues
								.get("pre_propsaleamt"))%>' /> 
</td><td>Facilities Available</td><td><textarea name="txt_propfacilityavailable" wrap="VIRTUAL"
					cols="40" onKeyPress="textlimit(this,100)" onkeyup="checkTextArealimit(this,100);"><%=Helper.correctNull((String) hshValues
								.get("pre_propfacilityavailable"))%></textarea> 
</td></tr> <tr> <td>Value as per Valuation Report, Value indicated in the sale
deed may also be taken into account in case of wide variation, Comments required</td><td><input type="text" name="txt_propvalreport" size="43"
					maxlength="40" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propvalreport"))%>"> 
</td><td>Name of the person representing seller/ builder</td><td><input type="text" name="txt_proprepresentative" size="43"
					maxlength="40" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_proprepresentative"))%>"> 
</td></tr> <tr> <td>Area in Sq.ft. as per Sale agreement</td><td><input type="text" name="txt_proparea" maxlength="10"
					size="15" onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_proparea"))%>"> 
</td><td>Whether Owner Occupied/ rented/ Leased</td><td><input type="text" name="txt_propowner" maxlength="35"
					size="40" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propowner"))%>"> 
</td></tr> <tr> <td>Comments on Taxes paid</td><td><input type="text" name="txt_proptaxpaidcomments"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_proptaxpaidcomments"))%>"> 
</td><td>Maintenance of Building</td><td><input type="text" name="txt_propmaintanance"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_propmaintanance"))%>"> 
</td></tr> <tr> <td>Valuation of property as per Inspecting<br>official</td><td><lapschoice:CurrencyTag name="txt_propvalasperinsofficial"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_propvalasperinsofficial"))%>' /> 
</td><td>&nbsp;</td></tr> <tr> <td colspan="4">&nbsp;</td></tr> <tr> <td colspan="4"><b>Construction
/ Repairs / Improvement / Extension of House / Flat</b></td></tr> <tr> <td>Permission 
for Construction/ Repair obtained?</td><td><select name="sel_permissionobtained"> 
<%
						if (strpermissionobtained.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strpermissionobtained.trim().equalsIgnoreCase("Y")) {
					%> <option value="Y" selected="selected">Yes</option> 
<%
						} else {
					%> <option value="Y">Yes</option> <%
						}
							if (strpermissionobtained.trim().equalsIgnoreCase("N")) {
					%> <option value="N" selected="selected">No</option> 
<%
						} else {
					%> <option value="N">No</option> 
					<%}%>
					</select></td><td>House/ Flat is Completed?</td><td><select name="sel_propcompleted">
<%
						if (strpropcompleted.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strpropcompleted.trim().equalsIgnoreCase("Y")) {
					%> <option value="Y" selected="selected">Yes</option> 
<%
						} else {
					%> <option value="Y">Yes</option><%
						}
							if (strpropcompleted.trim().equalsIgnoreCase("N")) {
					%> <option value="N" selected="selected">No</option> 
<%
						} else {
					%> <option value="N">No</option> <%
						}
					%> </select></td></tr> <tr> <td>Present status of Construction</td><td><textarea name="txt_propconstructstatus"
					onKeyPress="notAllowSplChar();textlimit(this,100)" cols="40" wrap="VIRTUAL" onkeyup="checkTextArealimit(this,100);"><%=Helper.correctNull((String) hshValues
								.get("pre_propconstructstatus"))%></textarea> 
</td><td>Comments on Adverse Features</td><td><textarea name="txt_propfeatures"
					onKeyPress="notAllowSplChar();textlimit(this,100)" cols="40" wrap="VIRTUAL" onkeyup="checkTextArealimit(this,100);"><%=Helper.correctNull((String) hshValues
								.get("pre_propfeatures"))%></textarea> 
</td></tr> <tr> <td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <%
				}
				if ((strSaral.equalsIgnoreCase("saral"))
						|| prd_type.equalsIgnoreCase("pA")) {
			%> <tr> <td><b>Old Vehicles</b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
<tr> <td>Type of Vehicle</td><td><input type="text" name="txt_vechicletype" maxlength="40"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_vechicletype"))%>"> 
</td><td>Age of Vehicle</td><td><input type="text" name="txt_vehicleage" maxlength="2"
					size="7" onKeyPress="allowInteger()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_vehicleage"))%>"> 
</td></tr> <tr> <td>Value of the Vehicle</td><td><lapschoice:CurrencyTag name="txt_vehiclevalue"
					maxlength="15" size="20"
					value='<%=Helper.correctNull((String) hshValues.get("pre_vehiclevalue"))%>' /> 
</td><td>Valued by &amp; Date</td><td><input type="text" name="txt_valueby" maxlength="40"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_valueby"))%>"> 
</td></tr> <tr> <td>Any prior charges</td><td><textarea name="txt_vehiclepriorcharges" cols="40"
					wrap="VIRTUAL" onKeyPress="textlimit(this,50)" onkeyup="checkTextArealimit(this,50);"><%=Helper.correctNull((String) hshValues.get("pre_vehiclepriorcharges"))%></textarea></td><td>Registration No.
</td><td><input type="text" name="txt_vehicleregno" maxlength="20"
					size="43" onKeyPress="notAllowSplChar();allowAlphaNumeric()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_vehicleregno"))%>"> 
</td><tr> <td>Chassis No.</td><td><input type="text" name="txt_vehiclechasisno" size="43"
					maxlength="20" onKeyPress="notAllowSplChar();allowAlphaNumeric()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_vehiclechasisno"))%>"> 
</td><td>Engine No.</td><td><input type="text" name="txt_vehicleengineno" size="43"
					maxlength="20" onKeyPress="notAllowSplChar();allowAlphaNumeric()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_vehicleengineno"))%>"> 
</td></tr> <tr> <td>Duplicate keys obtained by the branch</td><td><select name="sel_vehicleduplikeyobtain"> 
<%
						if (strvehicleduplikeyobtain.trim().equalsIgnoreCase("S")) {
					%> <option value="S" selected="selected">&lt;---Select---&gt;</option> 
<%
						} else {
					%> <option value="S">&lt;---Select---&gt;</option> 
<%
						}
							if (strvehicleduplikeyobtain.trim().equalsIgnoreCase("1")) {
					%> <option value="1" selected="selected">Yes</option> 
<%
						} else {
					%> <option value="1">Yes</option> <%
						}
							if (strvehicleduplikeyobtain.trim().equalsIgnoreCase("2")) {
					%> <option value="2" selected="selected">No</option> 
<%
						} else {
					%> <option value="2">No</option> <%
						}
					%> </select></td><td>&nbsp;</td><td>&nbsp;</td></tr> 
<tr> <td></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> <%
				}
			%> <tr> <td><b>Comments of visiting officer</b></td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
<tr> <td colspan="2">General remarks / Observations / Comments of visiting officer  
<b><span class="mantatory">*</span></b></td><td colspan="2"><textarea name="txt_visitofficercomment"
					cols="60" wrap="VIRTUAL" onKeyPress="textlimit(this,1000)" onkeyup="checkTextArealimit(this,1000);"><%=Helper.correctNull((String) hshValues
							.get("pre_visitofficercomment"))%></textarea></td></tr> 
<tr> <td>Place<b><span class="mantatory">*</span></b></td><td><input type="text" name="txt_signplace" maxlength="40"
					size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_signplace"))%>"> 
</td><td>Name <b><span class="mantatory">*</span></b></td><td><input type="text" name="txt_visitofficername"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_visitofficername"))%>"> 
</td></tr> <tr> <td>Date <b><span class="mantatory">*</span></b></td><!--<table border="0">--> 
<td><input type="text" name="txt_signdate" maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate(loan_receivedate,document.forms[0].txt_signdate.value)"
							" size="12"
							value="<%=Helper.correctNull((String) hshValues.get("pre_signdate"))%>"> 
<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_signdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a></td><!--</table>--> 
<td>Designation with PA No <b><span class="mantatory">*</span></b></td><td><input type="text" name="txt_visitofficerdesign"
					maxlength="40" size="43" onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("pre_visitofficerdesign"))%>"> 
</td></tr> </table></td></tr> </table><br> <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail_Print' btnenable='<%=Helper.correctNull((String) request .getParameter("btnenable"))%>' /> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>  <input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="auditflag" value="<%=Helper.correctNull((String)hshValues.get("audit_flag"))%>">
 </form>
</body>
</html>

