<%@include file="../share/directives.jsp"%>
<%
String strStatus=Helper.correctNull((String) hshValues.get("addkbow_status")); 
session.setAttribute("strappstatus", strStatus);
String strBtnnenable = Helper.correctNull((String) hshValues.get("btnenable"));
session.setAttribute("strBtnnenable", strBtnnenable);
String strSanBranch=Helper.correctNull((String) hshValues.get("ADDKBOW_SANCTIONING_BRANCH"));
%>
<html>
<head>
<title>Add k - Power Details</title>
<script language="javascript">
var app_id = "<%=Helper.correctNull((String) hshValues.get("addkbow_app_id"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varaddkbow_Periodmonth="<%=Helper.correctNull((String) hshValues.get("addkbow_Periodmonth"))%>";
var varaddkbow_RateofInterest="<%=Helper.correctNull((String) hshValues.get("addkbow_RateofInterest"))%>";
var varaddkbow_RateofIntaddmin="<%=Helper.correctNull((String) hshValues.get("addkbow_RateofIntaddmin"))%>";
var varaddkbow_Sanctioned="<%=Helper.correctNull((String) hshValues.get("addkbow_Sanctioned"))%>";
var varADDKBOW_SANCTIONING_DEPT="<%=Helper.correctNull((String) hshValues.get("ADDKBOW_SANCTIONING_DEPT"))%>";
var varAction="<%=Helper.correctNull((String) hshValues.get("hidAction"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varsanbranch="<%=strSanBranch%>";
function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function CallWorkflow()
{
	if (varaddkbow_Sanctioned!= "")
	{
    document.forms[0].action=appURL+"action/com_addkpowerworkfolw.jsp?hidBeanId=comsolvency&hidBeanGetMethod=getKpowerHistroy&hidDemoId="+app_id;
	document.forms[0].submit();
	}
	else {
		alert("Please Enter the K-Power Details to proceed further ");
    }
}

function onLoad()
{
    disabledFields(true);
	if(varaddkbow_Sanctioned!="")
	{
		document.forms[0].sel_SancAuth.value=varaddkbow_Sanctioned;
	}
	else
	{
		document.forms[0].sel_SancAuth.value="s";
	}

	if(varADDKBOW_SANCTIONING_DEPT!="")
	{
		document.forms[0].sel_SancDept.value=varADDKBOW_SANCTIONING_DEPT;
	}
	else
	{
		document.forms[0].sel_SancDept.value="s";
	}

	funsanctiondept(varaddkbow_Sanctioned);
	funsancrefno();
	if(varsanbranch!="")
	{
		document.forms[0].sel_SancBranch.value =varsanbranch;
	}
	
	if(varaddkbow_Periodmonth!="")
	{
	
	document.forms[0].sel_month.value=varaddkbow_Periodmonth;
	}
	else
	{
		document.forms[0].sel_month.value="1";
	}


	if(varaddkbow_RateofInterest!="")
	{
	   document.forms[0].sel_ratinterest.value=varaddkbow_RateofInterest;
	}
	else
	{
		document.forms[0].sel_ratinterest.value="s"
	}
	
	if(varaddkbow_RateofIntaddmin!="")
	{
		 document.forms[0].sel_ratmaxmin.value=varaddkbow_RateofIntaddmin;
	}
	else
	{
		 document.forms[0].sel_ratmaxmin.value="1";
	}
 
	 if(document.forms[0].btnenable.value=="Y")
	 {
		<%if (strStatus.equalsIgnoreCase("PR") || strStatus.equalsIgnoreCase("PA")) {%>
				 enableButtons(true,true,true,true,false,false);
	    <%} else {%>
				 enableButtons(false,true,true,true,false,false);
		<%}%>
	 }
	
	 
	 
	 if(varAction=="new")
     {
        enableButtons(true,false,true,true,false,false);
		document.forms[0].hidAction.value = "new";
		disabledFields(false);
   	 }
	   
	    document.forms[0].txt_address.readOnly = true;
		document.forms[0].txt_addresstwo.readOnly = true;
		document.forms[0].txt_village.readOnly = true;
		document.forms[0].txt_city.readOnly = true;
		document.forms[0].txt_district.readOnly = true;
		document.forms[0].txt_state.readOnly = true;
		document.forms[0].txt_permzip.readOnly = true;
		document.forms[0].txtperapp_country.readOnly = true;
		document.forms[0].txt_nameborrower.readOnly = true;
		document.forms[0].hid_appid.readOnly = true;
		document.forms[0].txt_applno.readOnly = true;
		document.forms[0].txt_cbsid.readOnly = true;
		document.forms[0].txt_grossannincome.readOnly = true;
		document.forms[0].txt_Networth.readOnly = true; 
		document.forms[0].txt_grossannincome.readOnly = true;
		document.forms[0].old_appid.readOnly = true;
		document.forms[0].txt_netasondate.readOnly = true;
}
function doEdit()
{	
	disabledFields(false);
	enableButtons(true,false,false,false,false,false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].txt_address.readOnly = true;
	document.forms[0].txt_addresstwo.readOnly = true;
	document.forms[0].txt_village.readOnly = true;
	document.forms[0].txt_city.readOnly = true;
	document.forms[0].txt_district.readOnly = true;
	document.forms[0].txt_state.readOnly = true;
	document.forms[0].txt_permzip.readOnly = true;
	document.forms[0].txtperapp_country.readOnly = true;
	document.forms[0].txt_nameborrower.readOnly = true;
	document.forms[0].hid_appid.readOnly = true;
	document.forms[0].txt_applno.readOnly = true;
	document.forms[0].txt_cbsid.readOnly = true;
	document.forms[0].txt_grossannincome.readOnly = true;
	document.forms[0].txt_Networth.readOnly = true; 
	document.forms[0].txt_grossannincome.readOnly = true;
	document.forms[0].old_appid.readOnly = true;
	document.forms[0].txt_netasondate.readOnly = true;
}

function doSave()
{

	if (document.forms[0].txt_nameborrower.value == "") {
		ShowAlert('121', "Name of the Borrower");
		document.forms[0].txt_nameborrower.focus();
		return;
	}
	if (document.forms[0].txt_limitsanc.value == "" || document.forms[0].txt_limitsanc.value == "0.00") {
		ShowAlert('121', "Limit Sanctioned");
		document.forms[0].txt_limitsanc.focus();
		return;
	}
	if (document.forms[0].txt_address.value == "") {
		ShowAlert('121', "Address");
		document.forms[0].txt_address.focus();
		return;
	}
	if (document.forms[0].txt_primaryfinacno.value == "") {
		ShowAlert('121', "Primary Finacle account No");
		document.forms[0].txt_primaryfinacno.focus();
		return;
	}
	if (document.forms[0].txt_addresstwo.value == "") {
		ShowAlert('121', "Address");
		document.forms[0].txt_addresstwo.focus();
		return;
	}
	if (document.forms[0].txt_city.value == "") {
		ShowAlert('121', "city");
		document.forms[0].txt_city.focus();
		return;
	}
	if (document.forms[0].txt_permonth.value == "") {
		ShowAlert('121', "Period in");
		document.forms[0].txt_permonth.focus();
		return;
	}

	if (document.forms[0].txt_district.value == "") {
		ShowAlert('121', "District");
		document.forms[0].txt_district.focus();
		return;
	}
	
	if (document.forms[0].sel_ratinterest.value == "s") {
		ShowAlert('121', "Rate of Interest");
		document.forms[0].sel_ratinterest.focus();
		return;
	}
	if (document.forms[0].sel_ratmaxmin.value == "") {
		ShowAlert('121', "Rate of Interest");
		document.forms[0].sel_ratmaxmin.focus();
		return;
	}	
	if (document.forms[0].txt_grossannincome.value == "") {
		ShowAlert('121', " Gross Annual income ");
		document.forms[0].txt_grossannincome.focus();
		return;
	}	
	if (document.forms[0].txt_grossdate.value == "") {
		ShowAlert('121', "As on Date ");
		document.forms[0].txt_grossdate.focus();
		return;
	}	
	if (document.forms[0].txt_permzip.value == "") {
		ShowAlert('121', "Pincode");
		document.forms[0].txt_permzip.focus();
		return;
	}	
	if (document.forms[0].txtperapp_country.value == "") {
		ShowAlert('121', "country ");
		document.forms[0].txtperapp_country.focus();
		return;
	}	
	if (document.forms[0].txt_Networth.value == "") {
		ShowAlert('121', "Networth");
		document.forms[0].txt_Networth.focus();
		return;
	}
	if(document.forms[0].sel_SancDept.value=="s")
	{
		ShowAlert('111', "Sanctioning Department"); 	
		document.forms[0].sel_SancDept.focus();
		return;	
	}
	if((document.forms[0].sel_SancDept.value=="010" || document.forms[0].sel_SancDept.value=="008" || document.forms[0].sel_SancDept.value=="013" || document.forms[0].sel_SancDept.value=="014"|| document.forms[0].sel_SancDept.value=="015"|| document.forms[0].sel_SancDept.value=="016") && document.forms[0].sel_SancBranch.value=="")
   	{
   		alert("Select Sanctioning Branch");
   		document.forms[0].sel_SancBranch.focus();
   		return;
   	}	
	if (document.forms[0].sel_SancAuth.value == ""||document.forms[0].sel_SancAuth.value == "s")
	{
		ShowAlert('111', "Sanctioning Authority");
		document.forms[0].sel_SancAuth.focus();
		return;
	}
	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		if(document.forms[0].txt_sancrefno.value=="")
		{
			ShowAlert('121', "Sanction Reference No"); 	
			document.forms[0].txt_sancrefno.focus();
			return;	
		}
		if(document.forms[0].sanctiondate.value=="")
		{
			ShowAlert('111', "Sanction Date"); 	
			document.forms[0].sanctiondate.focus();
			return;	
		}
	}
	
	
	 enableButtons(true,true,true,true,false,false);
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="UpdateKpowerdetailsData";
	document.forms[0].hidSourceUrl.value="/action/com_addkpowerdetails.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value = "comsolvency";
		document.forms[0].hidBeanGetMethod.value = "getKpowerdetailsData";
		document.forms[0].action=appURL+"action/com_addkpowerdetails.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	if (ConfirmMsg(100)) 
	{
		document.forms[0].action = appURL + "action/com_searchaddkpowerdetails.jsp";
		document.forms[0].submit();
	}
}


function showstate() {
	
	var val1 = document.forms[0].hidcity.value;
	var val2 = document.forms[0].hidstate.value;
	if (val1 != "") {
		document.forms[0].hidcity1.value = val1;
	}
	if (val2 != "") {
		document.forms[0].hidstate1.value = val2;
	}
}


function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanMethod.value="UpdateKpowerdetailsData";	
	document.forms[0].hidBeanGetMethod.value="getKpowerdetailsData";				
	document.forms[0].hidSourceUrl.value="action/com_addkpowerdetails.jsp";	
	document.forms[0].submit();	
	
	alert("Application Deleted Sucessfully");
	document.forms[0].hidSourceUrl.value = "action/com_searchaddkpowerdetails.jsp";
	document.forms[0].submit();
	}
}

function calculateint()
{
	var totValue;
	var strVal = document.forms[0].sel_ratinterest.value;
	
	var arr = strVal.split("@")
  
	if(document.forms[0].sel_ratmaxmin.value =="1")
	{
		totValue = eval(arr[1])+eval(document.forms[0].txt_Interest.value);
	}
	else
	{
		totValue = eval(arr[1])-eval(document.forms[0].txt_Interest.value);
	}
	document.forms[0].txt_total.value = totValue;
}

function funsanctiondept(varfname)
{
	var varsancdept=document.forms[0].sel_SancDept.value;
	if((varsancdept=="008") || (varsancdept=="010")||(varsancdept=="013") || (varsancdept=="014")|| (varsancdept=="015")|| (varsancdept=="016"))
	{
		document.all.idsanbranch.style.display="table-cell";
		funsancbranchvalues();
	}
	else{
		document.all.idsanbranch.style.display="none";
		document.forms[0].sel_SancBranch.value="";
	}
	document.all.ifrmsancauthority.src=appURL+"action/iframesancauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept+"&sancauth="+varfname;
	
}
function funsancbranchvalues()
{
	var varsancdept=document.forms[0].sel_SancDept.value;
	document.all.ifrmsancbranch.src=appURL+"action/ifrmsancbranches.jsp?hidBeanGetMethod=getSancBranches&hidBeanId=comproposal&sancdept="+varsancdept+"&sancbranch="+varsanbranch;
}
function funsancrefno()
{
	
	if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
	{
		document.all.sanrefno.style.display = "table-cell";
		document.all.sanrefval.style.display = "table-cell";
		document.all.sancdate1.style.display = "table-cell";
		document.all.sancdate2.style.display = "table-cell";	
	}
	else
	{
		document.all.sanrefno.style.display = "none";
		document.all.sanrefval.style.display = "none";
		document.all.sancdate1.style.display = "none";
		document.all.sancdate2.style.display = "none";	
		document.forms[0].txt_sancrefno.value="";
		document.forms[0].sanctiondate.value="";
	}		
}

function callCalender2()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,'sanctiondate');
	}
}



</script>
</head>
<body onload="onLoad()">
<form method="post" name="add_kpower" class="normal">

<table style="border-collapse: collapse;">
	<tr>
		<td width="50%" align="center" class="sub_tab_active">K-Power
		Details</td>

		<td width="50%" align="center" class="sub_tab_inactive"><a
			href="javascript:CallWorkflow();"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Applicant';return true;"> <b>
		K-Power WorkFlow </b></a></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
   	<tr>
		<td class="page_flow" colspan="3">Home -> K-Power Details</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="0"
	class="outertable" align="center">
	<tr class="dataheader" align="center">
		        <td width="20%">CBS Customer ID</td>
				<td width="20%">Applicant ID</td>
				<td width="20%">Application No.</td>
				<td width="15%">K-Power No.</td>
				<td width="25%">Status:
				
				<%if(strStatus.equalsIgnoreCase("")){%>
                  New
                <%}
                 else if(strStatus.equalsIgnoreCase("OP")){%>
                  Open/Pending 
                 <%}
                 else if(strStatus.equalsIgnoreCase("PA")){%>
                 Processed/Approved
                 <%}else if(strStatus.equalsIgnoreCase("PR")){%>
                  Processed/Rejected 
                 <%} else if(strStatus.equalsIgnoreCase("CA")){%>
                 Closed/Approved
                 <%} else if(strStatus.equalsIgnoreCase("CR")){%>
                 Closed/Rejected
                 <%}%>
				</td>
	</tr>
	
	<tr align="center" class="padtable">
		<td><input type="text" name="txt_cbsid"
			class="finaclefieldsbgcolor" size="10" style="text-align: center"
			maxlength="10"
			value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_cbs_id"))%>"></td>
							
		<td><input type="text" name="old_appid"
			class="finaclefieldsbgcolor" size="8" style="text-align: center"
			maxlength="15"
			value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_oldid"))%>">
		</td>
		
		<input type="hidden" name="hid_appid"
			class="finaclefieldsbgcolor" size="8" style="text-align: center"
			maxlength="15" value="<%=Helper.correctNull((String) hshValues.get("addkbow_app_id"))%>">
			
		<td><input type="text" name="txt_applno"
			class="finaclefieldsbgcolor" size="16" style="text-align: center" maxlength="15"
			value="<%=Helper.correctNull((String) hshValues.get("addkbow_app_no"))%>"></td>
			
		<td><input type="text" name="txt_kpowno"
			 size="16" style="text-align: center" maxlength="15" onkeypress="allowAlphaNumeric()"
			value="<%=Helper.correctNull((String) hshValues.get("addkbow_kpowno"))%>"></td>
		
	</tr>
</table>

<table width="95%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1 tableBg" align="center" style="margin-top:10px;">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="3" cellpadding="1"
			class="outertable" align="center">
			<tr>
				<td width="20%">Name of the Borrower<span class="mantatory">*</span></td>
				<td width="25%"><input type="text" name="txt_nameborrower"
					class="finaclefieldsbgcolor" size="35" maxlength="50"
					onkeypress="allowAlphabetsForName();notAllowSplChar1(this)" tabindex="1"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_BorrowerName"))%>'></td>
				<td width="25%">Limit Sanctioned<span class="mantatory">*</span></td>
				<td width="25%"><lapschoice:CurrencyTag name="txt_limitsanc"
					size="15" maxlength="12" tabindex="11"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);"
					value='<%=Helper.correctDouble((String) hshValues
							.get("addkbow_LimitSanctioned"))%>' /></td>
			</tr>

			<tr>
				<td>Address<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_address" size="35"
					class="finaclefieldsbgcolor" maxlength="50" tabindex="2"
					value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_address_one"))%>"></td>

				<td width="20%">Primary Finacle account No<span
					class="mantatory">*</span></td>
				<td width="30%"><input type="text" name="txt_primaryfinacno"
					style="text-align: right" size="20" maxlength="16" tabindex="12"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_primaryFineacNo"))%>'></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="text" name="txt_addresstwo" tabindex="3"
					class="finaclefieldsbgcolor" size="35" maxlength="50"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_address_two"))%>'></td>
				<td>Date Sanctioned</td>

				<td><input type="text" name="txt_datesanction" maxlength="10" tabindex="13"
					size="15"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_DateSanctioned"))%>'
					alt="Select date from calender" href="#" onBlur="checkDate(this);">&nbsp;<a
					style="vertical-align: middle"
					onClick="callCalender('txt_datesanction')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td>Village/Taluk/Town</td>
				<td><input type="text" class="finaclefieldsbgcolor" tabindex="4"
					name="txt_village" size="35" maxlength="50"
					value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_village"))%>"
					onKeyPress="allowAlphabetsForName();"></td>
				<td>Due Date</td>

				<td><input type="text" name="txt_Duedate" maxlength="10" tabindex="14"
					size="15"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_DueDate"))%>'
					alt="Select date from calender" href="#" onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_datesanction.value);">&nbsp;<a
					style="vertical-align: middle"
					onClick="callCalender('txt_Duedate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;</td>

			</tr>
			<tr>
				<td>City<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_city" size="25"
					class="finaclefieldsbgcolor" maxlength="20" tabindex="5"
					value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_city"))%>"
					onKeyPress="">&nbsp;

					<input type="hidden"
					name="hidperapp_city" size="5"
					value="<%=Helper.correctNull((String) hshValues
									.get("addkbow_city"))%>">
				</td>

				<td>Period in <span class="mantatory">*</span></td>
				<td><input type="text" name="txt_permonth" size="12"
					maxlength="2" style="text-align: right" tabindex="15"
					onkeypress="allowInteger();"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_Periodin"))%>'>

				&nbsp;<select name="sel_month" style="width: 60px;" tabindex="">
					<option value="1">Months</option>
					<option value="2">Year</option>
				</select></td>
			<tr>
			<tr>
				<td>District<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_district"
					class="finaclefieldsbgcolor" size="21" maxlength="20" tabindex="6"
					value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_district"))%>"
					onKeyPress="notallowInteger()">&nbsp;
					
					<input type="hidden"
					name="hidperapp_permstate" size="5"
					value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_district"))%>">
							
				<td>Rate of Interest<span class="mantatory">*</span></td>

				<td nowrap="nowrap"><select name="sel_ratinterest" style="width: 160px;"
					tabindex="16" onchange="calculateint();">
					<option value="s" selected>----select----</option>
					<lapschoice:MCLRTag/>
<!--					<lapschoice:interestratekpower />-->
				</select> &nbsp; <select name="sel_ratmaxmin" style="width: 40px;"
					onchange="calculateint();">
					<option value="1"><b>+</b></option>
					<option value="2"><b>-</b></option>
				</select> &nbsp;<lapschoice:CurrencyTag name="txt_Interest" size="5"
					maxlength="5" tabindex="" onKeyPress="allowDecimals(this)"
					style="text-align:right" onBlur="roundtxt(this);calculateint();"
					value='<%=Helper.correctDouble((String) hshValues
							.get("addkbow_RateofInt"))%>' />
				&nbsp;<lapschoice:CurrencyTag name="txt_total" size="7"
					maxlength="10" tabindex="" onKeyPress="allowDecimals(this)"
					style="text-align:right" onBlur="roundtxt(this);"
					value='<%=Helper.correctDouble((String) hshValues
							.get("addkbow_RateofInttotal"))%>' />
				</td>
			</tr>
			<tr>
				<td>State</td>
				<td><input type="text" class="finaclefieldsbgcolor"
					name="txt_state" size="21" maxlength="25" tabindex="7"
					value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_permstate"))%>"
					 onKeyPress="allowAlphabets();" onBlur=""> <input
					type="hidden" name="hidperapp_state" size="5"
					value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_state"))%>"></td>

				<td>Gross Annual income (in Rs.)<span class="mantatory">*</span></td>
				<td width="25%"><lapschoice:CurrencyTag
					name="txt_grossannincome" other="class='finaclefieldsbgcolor'"
					size="15" maxlength="14" tabindex="17"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);"
					value='<%=Helper.correctDouble((String) hshValues
							.get("addkbow_GrossAnnincome"))%>' /></td>
			</tr>
			<tr>
				<td>Pincode<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_permzip" tabindex="8"
					class="finaclefieldsbgcolor" size="12" maxlength="6"
					value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_pincode"))%>"
					 style="text-align: left" onKeyPress="allowInteger()"
					onBlur=""></td>

				<td>As on Date <span class="mantatory">*</span>&nbsp;</td>
				<td><input type="text" name="txt_grossdate" maxlength="10" tabindex="18"
					size="15"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_grossAsonDate"))%>'
					alt="Select date from calender" href="#" onBlur="checkDate(this);checkmaxdate(this,currdate);">&nbsp;<a
					style="vertical-align: middle"
					onClick="callCalender('txt_grossdate')"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender"></a>&nbsp;&nbsp;</td>

			</tr>
			<tr>
				<td>Country<span class="mantatory">*</span></td>
				<td><input type="text" class="finaclefieldsbgcolor"
					name="txtperapp_country" size="25" maxlength="15"
					value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_country"))%>"
					tabindex="9" style="text-align: left"
					onKeyPress="allowAlphabets();"> <input type="hidden"
					name="hidperapp_country"
					value="<%=Helper.correctNull((String) hshValues
							.get("addkbow_country"))%>">
							
					</td>
					
				<td>Networth (in Rs.)<span class="mantatory">*</span></td>
				<td width="25%"><lapschoice:CurrencyTag name="txt_Networth" other="class='finaclefieldsbgcolor'"
					size="15" maxlength="14" tabindex="19"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);"
					value='<%=Helper.correctDouble((String) hshValues
							.get("addkbow_Networth"))%>' /></td>
			</tr>
	
			<tr>		
			<td>Sanctioning Department<span class="mantatory"><b>*</b></span></td>
			<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
			<td>
			<select name="sel_SancDept"  onchange="funsanctiondept('s');">
			<option value="s">--Select--</option>
			<lapschoice:CBSStaticDataNewTag apptype="26" />
			</select>
			</td>
			<td id="idsanbranch">
			<select name="sel_SancBranch" >
			<option value="">--Select--</option>
			</select>
			</td>
			</tr>
			</table>
			</td>						
			</tr>
			<tr>
				<td>Sanctioning Authority<span class="mantatory">*</span></td>

				<td><select name="sel_SancAuth" style="width: 200px;" tabindex="10"  onChange="funsancrefno()">
					<option value="">--Select--</option>
					<lapschoice:CBSStaticDataNewTag apptype="15" />
				</select></td>

				<td>As on date<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_netasondate" maxlength="10"
					size="15" tabindex="20"
					value='<%=Helper.correctNull((String) hshValues
							.get("addkbow_NetworthAsonDate"))%>'
					 onBlur="checkDate(this);" class="finaclefieldsbgcolor"></td>
			</tr>
			<tr>
				<td id="sanrefno">Sanction Reference No.<b><span class="mantatory">*</span></b></td>
				<td id="sanrefval"><input type="text" name="txt_sancrefno" size="37" maxlength="25"	value="<%=Helper.correctNull((String) hshValues.get("Sanc_Ref_No"))%>"></td>
				<td id="sancdate1">Sanction date <b><span class="mantatory">*</span></b></td>	
				<td id="sancdate2">
					<input type="text" name="sanctiondate" maxlength="10" 
					onBlur="checkDate(this);checkmaxdate(this,currentDate);" size="12"
					onKeyPress="notAllowSplChar()"
					value="<%=Helper.correctNull((String) hshValues.get("Sanction_Date"))%>">
				  	&nbsp;<a alt="Select date from calender" href="#"
					onClick="callCalender2()"
					onMouseOver="window.status='Date Picker';return true;"
					onMouseOut="window.status='';return true;"><img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
					alt="Select date from calender" align="middle"></a></td>			
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String) session.getAttribute("strBtnnenable"))%>'/>
<iframe height="0" width="0" name="ifrmsancauthority" frameborder="0" style="border:0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0" style="border:0"></iframe>
<input type="hidden" name="hidBeanId"> <input type="hidden" name="hidBeanMethod"> <input type="hidden" name="hidBeanGetMethod"> <input type="hidden" name="hidSo">
<input type="hidden" name="hidAction"> <input type="hidden" name="hidSourceUrl"> <input type="hidden" name="hidcity" value="<%=Helper.correctNull((String) hshValues.get("perapp_city_code"))%>">
<input type="hidden" name="hidstate" value='<%=Helper.correctNull((String) hshValues.get("perapp_state_code"))%>'>
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidAvailFlg" value="<%=Helper.correctNull((String) hshValues.get("strDataAvlFlag"))%>">
<input type="hidden" name="hidAppno" value="<%=Helper.correctNull((String) hshValues.get("addkbow_app_no"))%>">
<input type="hidden" name="hidAppnmae" value="<%=Helper.correctNull((String) hshValues.get("addkbow_BorrowerName"))%>">
<input type="hidden" name="hidStatus" value="<%=Helper.correctNull((String) hshValues.get("addkbow_status"))%>">
<input type="hidden" name="hidAppholder" value="<%=Helper.correctNull((String) hshValues.get("addkbow_applnholder"))%>">
<input type="hidden" name="hidRecdfrom" value="<%=Helper.correctNull((String) hshValues.get("org_name"))%>">
<input type="hidden" name="btnenable" value="<%=strBtnnenable%>">
</form>
</body>
</html>









