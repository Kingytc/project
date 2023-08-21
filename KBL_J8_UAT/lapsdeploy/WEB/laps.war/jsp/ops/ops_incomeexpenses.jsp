<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%String pageid = Helper.correctNull((String) request
					.getParameter("pageid"));
			String strApplnt = Helper.correctNull((String) request
					.getParameter("applnt"));
			if (strApplnt.equals("C")) {
				strApplnt = "CoApplicant";
			} else {
				strApplnt = "Guarantor";
			}

			String peremployment = Helper.correctNull((String) request
					.getParameter("txt_employment"));
			if (peremployment.equalsIgnoreCase("")) {
				peremployment = Helper.correctNull((String) hshValues
						.get("peremployment"));
			}
			String peremploystatus = "";
			String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidCategoryType"));
			String strprom = Helper.correctNull((String) request
					.getParameter("hidpromoter"));
			String strSSIType = Helper.correctNull((String) request
					.getParameter("hidSSIType"));
			//System.out.print("strSSIType---------->" + strSSIType);
			//System.out.print("strCategoryType---------->" + strCategoryType);
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
textarea {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perincexpensesdispco.js"> </script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
	var varempstatus="<%=Helper.correctNull((String)hshValues.get("peremploy"))%>";
	var appURL = "<%=ApplicationParams.getAppUrl()%>";
	var peremployment ="<%=peremployment%>";
	var peremploystatus ="<%=peremploystatus%>";
	var perinc_assetandliab="<%=Helper.correctNull((String)hshValues.get("perinc_assetandliab"))%>";
	var perinc_itreturn="<%=Helper.correctNull((String)hshValues.get("perinc_itreturn"))%>";
	//var perinc_selfincometype1="<%//=Helper.correctNull((String)hshValues.get("perinc_selfincometype"))%>";
	var incpatternval = "<%=Helper.correctNull((String)hshValues.get("perinc_pattern"))%>";
	var incproofval = "<%=Helper.correctNull((String)hshValues.get("perinc_proof"))%>";
	var incloyalty =  "<%=Helper.correctNull((String)hshValues.get("perinc_loyalty"))%>";
	var inchistory =  "<%=Helper.correctNull((String)hshValues.get("perinc_history"))%>";
	var varinctype="<%=Helper.correctNull((String)hshValues.get("perinctype"))%>";
	

function showDedc(val)
{
	if(val=="y")
	{
		document.all.dover.style.visibility="visible";
	}
	else if(val =="n")
	{
		document.all.dover.style.visibility="hidden";
	}	
}

function showTotDedc(val)
{
	if(val=="y")
	{
		document.all.dover2.style.visibility="visible";
	}
	else if(val =="n")
	{
		document.all.dover2.style.visibility="hidden";
	}
}
function callApplicantTab(page)
{
	if(page=="facilities")
	{
		document.forms[0].hidBeanMethod.value="getOPSFacilityData";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_facilities.jsp";
	}	  
	if(page=="subsidy")
	{
			document.forms[0].hidBeanId.value="comssiaboveten";
			document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_subsidy.jsp";
	}
	if(page=="customerprofile")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_applicantdisp1.jsp";
	}
	if(page=="ops_employment")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_employment.jsp";
	}
	if(page=="accountdetails")
	{
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanGetMethod.value="getAccountDetails";
		document.forms[0].action=appURL+"action/ops_accountdetails.jsp";
		document.forms[0].submit();
	}
	document.forms[0].submit();
}
function callLink(page,bean,method)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}


</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="callonLoad();calcincdeduc()">
<form name="appform" method="post" action="">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
		Home -&gt;
Tertiary-&gt; Existing Application-&gt; Applicant-&gt; Income &amp;
Expenses
		</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF">
	<tr>
		<td colspan="2" valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3">
			<tr align="center">
				<td width="12%" class="tabactivenew"><b><a
					href="javascript:callApplicantTab('facilities')" class="blackfont">Facilities</a></b></td>
				<td width="12%" class="tabactivenew"><a
					href="javascript:callApplicantTab('subsidy')" class="blackfont"><b>Subsidy
				</b></a></td>
				<td width="12%" class="tabactivenew"><a
					href="javascript:callApplicantTab('accountdetails')"
					class="blackfont"><b>Account Details </b></a></td>
				<td width="12%" class="tabactivenew"><b><a
					href="javascript:callApplicantTab('customerprofile')"
					class="blackfont">Customer Profile </a></b></td>
				<td width="12%" bgcolor="#71694F"><b>Income
				&amp; Expenses </b></td>
				<td width="12%" class="tabactivenew"><a
					href="javascript:callApplicantTab('ops_employment')"
					class="blackfont"><b>Employment </b></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="3"
	height="400" bordercolorlight="#8F8369"
	bordercolordark="#FFFFFB">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="5"
							align="center">
							<tr>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="200%">
									<tr>
										<td height="150" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr bordercolor="#CCCCFF">
												<td height="10" colspan="5">
												<p><b> Primary Income Details <select
													name="incometype" onChange="callIncomeEnable()"
													tabindex="1">
													<option value="0" selected>--Select--</option>
													<option value="1">Monthly</option>
													<option value="2">Yearly</option>
												</select> </b>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td>&nbsp;</td>
												<td align="right">&nbsp;</td>
												<td>Monthly</td>
												<td>&nbsp;</td>
												<td>Yearly</td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td width="30%">Gross Income (Salary/Pension) </td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"> <input type="text"
													tabindex="2" name="txtperinc_monsalary" size="12"
													maxlength="12" style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_monsalary"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_monsalary)"
													onBlur="roundtxt(document.forms[0].txtperinc_monsalary);calcincdeduc()"></td>
												<td width="5%%"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"> <input type="text" tabindex="4"
													name="txtperinc_Yearlysalary" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_yearsalary"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_Yearlysalary)"
													onBlur="roundtxt(document.forms[0].txtperinc_Yearlysalary);calcincdeduc()"></td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td><span onMouseOver="showDedc('y')"
													onMouseOut="showDedc('n')">Statutory Deductions</span></td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text" tabindex="3"
													name="txtperinc_deduction1" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_deduction"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_deduction1)"
													onBlur="roundtxt(document.forms[0].txtperinc_deduction1);calcincdeduc()"
													readonly onMouseOver="showDedc('y')"
													onMouseOut="showDedc('n')"></td>
												<td width="0"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text" tabindex="5"
													name="txtperinc_yeardeduction" size="12"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_yeardeduction"))%>"
													maxlength="12" style="text-align:right"
													onKeyPress="allowNumber(document.forms[0].txtperinc_yeardeduction)"
													onBlur="roundtxt(document.forms[0].txtperinc_yeardeduction);calcincdeduc()"
													readonly></td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td><span onMouseOver="showDedc('y')"
													onMouseOut="showDedc('n')">Net Income </span></td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_takehome"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_takehome)"
													name="txtperinc_deduc" readonly></td>
												<td width="0"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text"
													name="txtperinc_yearnetincome" size="12" maxlength="12"
													style="text-align:right"
													onKeyPress="allowNumber(document.forms[0].txtperinc_yearnetincome)"
													onBlur="roundtxt(document.forms[0].txtperinc_yearnetincome);"></td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td>Other Deductions </td>
												<td width="5%" align="right"> <%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_otherdeduction"))%>"
													name="txt_otherdeduction" readonly></td>
												<td width="0"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text"
													name="txtperinc_yearotherdedec" size="12" maxlength="12"
													style="text-align:right" readonly></td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td>Other Income </td>
												<td width="5%" align="right"> <%=ApplicationParams.getCurrency()%></td>
												<td> <input readonly type="text"
													name="txtperinc_otherincome" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_otherincome"))%>"></td>
												<td width="0"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text"
													name="txtperinc_yearotherincome" size="12" maxlength="12"
													style="text-align:right"
													onKeyPress="allowNumber(document.forms[0].txtperinc_yearotherincome)"></td>
											</tr>
											<tr bordercolor="#CCCCFF">
												<td>Total Net Income </td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text" name="txtperinc_totincome"
													size="12" maxlength="12" style="text-align:right"></td>
												<td width="0"><%=ApplicationParams.getCurrency()%></td>
												<td> <input type="text"
													name="txtperinc_yeartotalincome" size="12" maxlength="12"
													style="text-align:right"></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="200%">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td colspan="3"><b>Other Income Details</b></td>
												<td>Description</td>
											</tr>
											<tr>
												<td width="25%">Rent</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"> <lapschoice:CurrencyTag
													tabindex="11" name="txtperinc_rent"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_rent"))%>'
													size="12" maxlength="12" onBlur="calcincdeduc()" /></td>
												<td width="25%" rowspan="4"> <textarea
													name="txtperinc_secdesc" cols="50" rows="7" tabindex="14"
													onKeyPress="notAllowSplChar();textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("perinc_secdesc"))%></textarea></td>
											</tr>
											<tr>
												<td width="25%">Agriculture</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"> <lapschoice:CurrencyTag
													tabindex="12" name="txtperinc_agriculture" size="12"
													maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_agriculture"))%>'
													onBlur="calcincdeduc()" /></td>
											</tr>
											<tr>
												<td width="25%">Others</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"> <lapschoice:CurrencyTag
													tabindex="13" name="txtperinc_others" size="12"
													maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_others"))%>'
													onBlur="calcincdeduc();" /></td>
											</tr>
											<tr>
												<td width="25%">Total</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"> <input readonly type="text"
													name="txtperinc_othertotal" size="12" maxlength="12"
													style="text-align:right"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_otherincome"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperinc_othertotal)"
													onBlur="roundtxt(document.forms[0].txtperinc_othertotal)"></td>
												<td width="25%">&nbsp;</td>
											</tr>
											<tr>
												<td colspan="3"><b>Length of Relationship with the
												Bank <span class="redfont">*</span></b></td>
												<td><select name="cbo_loyalty" tabindex="15">
													<option value="0" selected>---Select-----</option>
													<option value="1">3 years &amp; above</option>
													<option value="2">2 years to less than 3 years</option>
													<option value="3">6 months to less than 2 years</option>
													<option value="4">Less than 6 months</option>
													<option value="5">New Customer</option>
													<option value="6">Not Applicable</option>
												</select></td>
											</tr>
											<tr>
												<td colspan="3"><b>Record of Repayment</b><b><span class="redfont">*</span></b></td>
												<td><select name="cbo_history" tabindex="16">
													<option value="0" selected>---Select-----</option>
													<option value="1">Regular/Advance Payment during the year</option>
													<option value="2">Account is regular but occasional default
													during the year</option>
													<option value="3">One Installment / EMI due for the latest
													month only</option>
													<option value="4">One EMI/Installments continuously in
													arrears</option>
													<option value="5">Two EMI/Installments continuously in
													arrears</option>
													<option value="6">Installment/Instant OD for &gt; 3 months</option>
													<option value="7">Account Closed by way of W/O compromise
													settlement</option>
													<option value="8">No Borrowings</option>
												</select></td>
											</tr>
											<tr>
												<td colspan="3"><b>Annual Income Pattern </b></td>
												<td><select name="incpattern" tabindex="17">
													<option value="0" selected>---Select-----</option>
													<option value="1">Steady Growth</option>
													<option value="2">No Change</option>
													<option value="3">Decline</option>
													<option value="4">Irregular / Haphazard</option>
												</select></td>
											</tr>
											<tr>
												<td colspan="3"><b>Income Tax Details <span class="redfont">*</span></b></td>
												<td><select name="incproof" tabindex="18">
													<option value="0" selected>---Select-----</option>
													<option value="1">IT Assesse</option>
													<option value="2">Non-Assesse</option>
												</select></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="200%">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td colspan="3"><b> Breakup for Other
												deductions(Only for Information)</b></td>
											</tr>
											<tr>
												<td>Total Loan Repayment </td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <lapschoice:CurrencyTag tabindex="6"
													name="txtperinc_autoloanexp"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_autoloanexp"))%>'
													size="12" maxlength="12" onBlur="calcincdeduc()" /></td>
											</tr>
											<tr>
												<td>Insurance </td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <lapschoice:CurrencyTag tabindex="7"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_domesticexp"))%>'
													name="txtperinc_domexp" size="12" maxlength="12"
													onBlur="calcincdeduc()" /></td>
											</tr>
											<tr>
												<td>Other Deductions 1 </td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <lapschoice:CurrencyTag tabindex="8"
													name="txtperinc_rentexp"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_rentexp"))%>'
													size="12" maxlength="12" onBlur="calcincdeduc()" /></td>
											</tr>
											<tr>
												<td>Other Deductions 2</td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <lapschoice:CurrencyTag tabindex="9"
													name="txtperinc_otherexp"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_otherexp"))%>'
													size="12" maxlength="12" onBlur="calcincdeduc()" /></td>
											</tr>
											<tr>
												<td>Total</td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td> <lapschoice:CurrencyTag
													name="txtperinc_total" size="12" maxlength="12" /></td>
											</tr>
											<tr>
												<td>Description</td>
												<td colspan="2" align="right"><textarea name="txa_desc"
													cols="65" rows="2" tabindex="10"
													onKeyPress="textlimit(this,3000)" onKeyUp="textlimit(this,3000)"><%=Helper.correctNull((String) hshValues.get("txa_desc"))%></textarea>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									height="275%">
									<tr>
										<td valign="top" height="110">
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td><!--  Constitution--></td>
												<td colspan=3><!--   <select name="choperinc_selfincometype" tabindex="19">
                                        <option value="0">---Select-----</option>-->
												<%//String apptype="14"; %> <!--<lapschoice:StaticDataNewTag apptype="14"/> 
                                      </select>--> <!-- <option value="4">Guardian</option>
                                        <option value="5">Minor</option> -->
												</td>
											</tr>
											<tr>
												<td width="49%" colspan=2><b>Other Details</b></td>
												<td width="51%" colspan=2>&nbsp; </td>
											</tr>
											<tr>
												<td width="35%">Latest I.T. Return verified ? </td>
												<td width="10%"><select name="cboitreturn" tabindex="20">
													<option value="Y">Yes</option>
													<option value="N">No</option>
												</select></td>
												<!--  </tr>
                                  <tr> -->
												<td width="45%">Statement of Assets &amp;
												Liabilities verfied ?</td>
												<td width="10%"><select name="cboassetliability"
													tabindex="21">
													<option value="Y">Yes</option>
													<option value="N">No</option>
												</select></td>
											</tr>
											<tr>
												<td><b>Annual Income </b></td>
												<td>&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td width="37%"> Year (Ex. 2005-2006) </td>
												<td width="21%" align="center" valign="middle"><input
													name="txt_year1" type="text" size="10" tabindex="22"
													maxlength="9"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_year1"))%>"
													onKeyPress="allowInteger()"></td>
												<td width="21%" align="center" valign="middle"><input
													name="txt_year2" type="text" size="10" tabindex="24"
													maxlength="9"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_year2"))%>"
													onKeyPress="allowInteger()"></td>
												<td width="21%" align="center" valign="middle"><input
													name="txt_year3" type="text" size="10" tabindex="26"
													maxlength="9"
													value="<%=Helper.correctNull((String)hshValues.get("perinc_year3"))%>"
													onKeyPress="allowInteger()"></td>
											</tr>
											<tr>
												<td align="right" width="37%"> <%=ApplicationParams.getCurrency()%></td>
												<td align="center" valign="middle" width="20%"><lapschoice:CurrencyTag
													name="txt_yearincome1" size="15" tabindex="23"
													maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_year1_income"))%>' />
												</td>
												<td align="center" valign="middle" width="21%"><lapschoice:CurrencyTag
													name="txt_yearincome2" size="15" tabindex="25"
													maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_year2_income"))%>' />
												</td>
												<td align="center" valign="middle" width="21%"><lapschoice:CurrencyTag
													name="txt_yearincome3" size="15" tabindex="27"
													maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("perinc_year3_income"))%>' />
												</td>
											</tr>
											<tr valign="top">
												<td align="left" width="38%">Particulars of income tax
												&amp; sales tax assesment</td>
												<td align="left" valign="middle" colspan="3" width="62"><textarea
													name="textarea_it" cols="50" rows="3" tabindex="28"
													onKeyPress="textlimit(this,3000)"  onKeyUp="textlimit(this,3000)"><%=Helper.correctNull((String) hshValues.get("perinc_it"))%></textarea>
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
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="top">
				<td height="0"><input type="button" name="cmdEdit" value="Edit"
					class="buttonStyle"></td>
				<td height="0"><input type="button" name="cmdapply" value="Save"
					class="buttonStyle"></td>
				<td height="0"><input type="button" name="cmdCancel" value="Cancel"
					class="buttonStyle"></td>
				<td height="0"><input type="button" name="cmddel" value="Delete"
					class="buttonStyle" disabled></td>
				<!-- <td height="0"> 
              <input type="button" name="cmdHelp" value="Help" class="buttonHelp" onClick="dohlp()">
            </td>-->
				<td height="0">
				<div align="center"><input type="button" name="cmdClose"
					value="Close" class="buttonClose" onClick="doClose()"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag/>
<INPUT TYPE="hidden" name="hidAppType"> 
<INPUT TYPE="hidden" name="hidApp_type" value="A">
<INPUT TYPE="hidden" name="page" value="ep"> 
<input type="hidden" name="txtperinc_secincome" size="12" maxlength="12" value="<%=Helper.correctNull((String)hshValues.get("perinc_secincome"))%>"> 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>"> 
<INPUT TYPE="hidden" name="pageid" value="<%=pageid%>"> 
<INPUT TYPE="hidden" name="applntype" value="<%=(String)request.getParameter("applnt")%>">
<input type="hidden" name="hidpromoter" value=""> 
</body>
</html>
