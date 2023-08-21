<%@include file="../share/directives.jsp"%>
<%
String pageid = Helper.correctNull((String)request.getParameter("pageid"));
String strApplnt = Helper.correctNull((String)request.getParameter("applnt"));
String strapptype = Helper.correctNull((String)request.getParameter("corp"));

if(strApplnt.equals("C"))
{
	strApplnt = "CoApplicant";
}
else
{
	strApplnt = "Guarantor";
}
String strEmployment=(String)session.getAttribute("strEmployment");

String peremployment = Helper.correctNull((String)request.getParameter("txt_employment"));
if(peremployment.equalsIgnoreCase(""))
	{
	peremployment=Helper.correctNull((String)hshValues.get("peremployment")); 
	}
String peremploystatus="";
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perincexpensesdispco.js"> </script>
<SCRIPT LANGUAGE="JavaScript">

	var value1="<%=Helper.correctNull((String)hshValues.get("perinc_id"))%>";
	var varempstatus="<%=Helper.correctNull((String)hshValues.get("peremploy"))%>";
	var appURL = "<%=ApplicationParams.getAppUrl()%>";
	var peremployment ="<%=peremployment%>";
	var peremploystatus ="<%=peremploystatus%>";
	var perinc_assetandliab="<%=Helper.correctNull((String)hshValues.get("perinc_assetandliab"))%>";
	var perinc_itreturn="<%=Helper.correctNull((String)hshValues.get("perinc_itreturn"))%>";
	var incpatternval = "<%=Helper.correctNull((String)hshValues.get("perinc_pattern"))%>";
	var incproofval = "<%=Helper.correctNull((String)hshValues.get("perinc_proof"))%>";
	var incloyalty =  "<%=Helper.correctNull((String)hshValues.get("perinc_loyalty"))%>";
	var inchistory =  "<%=Helper.correctNull((String)hshValues.get("perinc_history"))%>";
	var varinctype="<%=Helper.correctNull((String)hshValues.get("perinctype"))%>";
	var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();calcincdeduc()">

<div id="dover" style="position:absolute; left:286px; top:195px; width:89px; height:13px; z-index:1; visibility: hidden"> 
  <table width="100" border="1" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td align="center">PF 
        + IT + Prof. Tax + Deductions for LIC / ULIP etc.</td>
    </tr>
  </table>
</div>
<div id="dover2" style="position:absolute; left:286px; top:221px; width:89px; height:13px; z-index:1; visibility: hidden"> 
  <table width="100" border="1" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td align="center">PF 
        + IT + Prof. Tax + Deductions for LIC / ULIP + Total Loan Repayment + 
        Rent Paid </td>
    </tr>
  </table>
</div>
<form name="appform" method="post" action="" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="26" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="26"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="26"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
  <div align="center"> </div>
 <%if(!strCategoryType.equalsIgnoreCase("OPS"))
	{ if(strapptype.equalsIgnoreCase("C")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;
		<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
		Agriculture -&gt;
		<%}else{%>
		Corporate &amp; SME -&gt;
		<%} %>
		
		 Application -&gt; Applicant-&gt; customer profile -&gt; Income &amp; Expenses</td>
	</tr>
  </table>
	<%} else if(strapptype.equalsIgnoreCase("R")){ %>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td >
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
         </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
    <%if(strCategoryType.equals("AGR"))
   { %>Agriculture <% }
    else if(strCategoryType.equals("LAD"))
    {
    %> Loan Against Gold Ornaments & Deposits  
  <%} 
   else { %> Retail(including schematic) <%} %> -&gt; Application -&gt; Applicant/Guarantor -&gt; Income &amp; Expenses</td>
    </tr>
  </table>
  <%} %>
   <lapschoice:application />
  <%}else if(strCategoryType.equalsIgnoreCase("OPS")){ %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
      <tr> 
        <td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
      </tr> <tr> 
      <td class="page_flow">     
   Home
		-&gt; Tertiary -&gt; Application -&gt; Applicant/Guarantor -&gt;  Income &amp; Expenses</td></tr> </table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:TerPromoterTag pageid="3"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%} %>
<%if(!strCategoryType.equalsIgnoreCase("OPS"))
	{ %> 
   <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%} if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){%>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="26"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
  <%}}} %>
  <table width="100%" border="0" cellspacing="0" cellpadding="3"
	height="400" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			height="100%" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					height="100%" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<tr>
								<td width="50%" valign="top">

								<table width="100%" border="1" cellspacing="0" cellpadding="3"
									height="212%" class="outertable">
									<tr>
										<td height="150" valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr>

												<td colspan="5"><b>Primary Income Details <span
													class="mantatory">*&nbsp;</span> <select name="incometype" tabindex="1">
													<option value="0" selected>--Select--</option>
													<option value="1">Monthly</option>
													<option value="2">Yearly</option>
												</select> </b></td>
											</tr>
											<tr>
												<td width="30%">&nbsp;</td>
												<td align="right" width="5%">&nbsp;</td>
												<td width="29%">Monthly</td>
												<td width="6%">&nbsp;</td>
												<td width="30%">Yearly</td>
											</tr>
											<tr>
												<td width="30%">Gross Income (Salary/Pension)</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%>
												</td>
												<td width="29%"><lapschoice:CurrencyTag tabindex="2" name="txtperinc_monsalary" size="12" maxlength="12"
													value='<%=Helper.correctNull((String) hshValues.get("perinc_monsalary"))%>' /></td>
												<td width="6%"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"><lapschoice:CurrencyTag tabindex="7" name="txtperinc_Yearlysalary" size="12" maxlength="12"
													value='<%=Helper.correctNull((String) hshValues.get("perinc_yearsalary"))%>' /></td>
											</tr>
											<tr>
												<td width="30%">Income Tax</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="29%"><input type="text" tabindex="3" name="txtperinc_deduction1" size="12" maxlength="12"
													style="text-align: right" value="<%=Helper.correctNull((String) hshValues.get("perinc_deduction"))%>" readonly="readonly"
													onMouseOver="showDedc('y')" onMouseOut="showDedc('n')"></td>
												<td width="6%"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"><input type="text" tabindex="8" name="txtperinc_yeardeduction" size="12"
													value="<%=Helper.correctNull((String) hshValues.get("perinc_yeardeduction"))%>" maxlength="12" style="text-align: right" readonly="readonly"></td>
											</tr>
											<tr>
												<td width="30%"><span onMouseOver="showDedc('y')" onMouseOut="showDedc('n')"> Net Income </span></td>
												<td align="right" width="5%"><%=ApplicationParams.getCurrency()%></td>
												<td width="29%"><input type="text" tabindex="4" size="12" maxlength="12" style="text-align: right" name="txtperinc_deduc" readonly="readonly" /></td>
												<td width="6%"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"><lapschoice:CurrencyTag name="txtperinc_yearnetincome" tabindex="9" size="12" maxlength="12" /></td>
											</tr>
											<tr>
												<td width="30%">Other Deductions</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%>
												</td>
												<td width="29%"><input type="text" tabindex="5" size="12" maxlength="12" style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues.get("perinc_otherdeduction"))%>" name="txt_otherdeduction" readonly="readonly"></td>
												<td width="6%"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"><input type="text" name="txtperinc_yearotherdedec" tabindex="10" value="<%=Helper.correctNull((String) hshValues.get("perinc_yearotherdeduc"))%>"
													size="12" maxlength="12" style="text-align: right" readonly="readonly"></td>
											</tr>
											<tr>
												<td width="30%">Other Income</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%>
												</td>
												<td width="29%"><input readonly="readonly" type="text"
													tabindex="6" name="txtperinc_otherincome" size="12"
													maxlength="12" style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues.get("perinc_otherincome"))%>">
												</td>
												<td width="6%"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"><lapschoice:CurrencyTag
													name="txtperinc_yearotherincome" tabindex="11" size="12"
													maxlength="12" /></td>
											</tr>
											<tr>
												<td width="30%">Total Net Income</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="29%"><lapschoice:CurrencyTag
													name="txtperinc_totincome" size="12" maxlength="12" /></td>
												<td width="6%"><%=ApplicationParams.getCurrency()%></td>
												<td width="30%"><lapschoice:CurrencyTag name="txtperinc_yeartotalincome" value='<%=Helper.correctNull((String) hshValues.get("perinc_takehome"))%>' size="12" maxlength="12" /></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										
                              <td><b><u>Note:</u></b><span class="mantatory">In 
                                case of non salaried borrowers, please enter the 
                                average of last 2 years income as per Income Tax 
                                Returns in the income fields.</span></td>
									</tr>
								</table>
								</td>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									height="200%" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr>
												<td colspan="3"><b>Other Income Details</b></td>
												<td>Description</td>
											</tr>
											<tr>
												<td width="25%">Rent</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"><lapschoice:CurrencyTag tabindex="16"
													name="txtperinc_rent" value='<%=Helper.correctNull((String) hshValues.get("perinc_rent"))%>' size="12" maxlength="12" /></td>
												<td width="25%" rowspan="4"><textarea name="txtperinc_secdesc" cols="50" rows="7" wrap="VIRTUAL" tabindex="19" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("perinc_secdesc"))%></textarea></td>
											</tr>
											<tr>
												<td width="25%">Agriculture</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"><input type="text" tabindex="17" name="txtperinc_agriculture" size="12" maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("perinc_agriculture"))%>" style="text-align: right">
												</td>
											</tr>
											<tr>
												<td width="25%">Others</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"><input type="text" tabindex="18"  name="txtperinc_others" size="12" maxlength="12" style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues.get("perinc_others"))%>"></td>
											</tr>
											<tr>
												<td width="25%">Total</td>
												<td width="5%" align="right"><%=ApplicationParams.getCurrency()%></td>
												<td width="25%"><input readonly="readonly" type="text" name="txtperinc_othertotal" size="12" maxlength="12" style="text-align: right">
												</td>
												<td width="25%">&nbsp;</td>
											</tr>
											<!-- <tr>
												<td colspan="3"><b>Length of Relationship with the
												Bank <span class="mantatory">*&nbsp;</span></b></td>
												<td><select name="cbo_loyalty" tabindex="20">
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
												<td colspan="3"><b>Record of Repayment <span
													class="mantatory">*&nbsp;</span></b></td>
												<td><select name="cbo_history" tabindex="21">
													<option value="0" selected>---Select-----</option>
													<option value="1">Regular/Advance Payment during
													the year</option>
													<option value="2">Account is regular but
													occasional default during the year</option>
													<option value="3">One Installment / EMI due for
													the latest month only</option>
													<option value="4">One EMI/Installments
													continuously in arrears</option>
													<option value="5">Two EMI/Installments
													continuously in arrears</option>
													<option value="6">Installment/Instant OD for &gt;
													3 months</option>
													<option value="7">Account Closed by way of W/O
													compromise settlement</option>
													<option value="8">No Borrowings</option>

												</select></td>
											</tr>-->
											<tr>
												<td colspan="3"><b>Annual Income Pattern </b><b></b></td>
												<td><select name="incpattern" tabindex="22">
													<option value="0" selected>---Select-----</option>
													<option value="1">Steady Growth</option>
													<option value="2">No Change</option>
													<option value="3">Decline</option>
													<option value="4">Irregular / Haphazard</option>
												</select></td>
											</tr>
											<tr>
												<td colspan="3"><b>Income Tax Details <b><span
													class="mantatory">*&nbsp;</span></b> </b></td>
												<td><select name="incproof" tabindex="23">
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
								<table width="100%" border="1" cellspacing="0"
									cellpadding="4
									height=" 200%" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr>
												<td colspan="3"><b> Breakup for Other
												deductions(Only for Information)</b></td>
											</tr>
											<tr>
												<td>Total Loan Repayment</td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td><input type="text" tabindex="13" name="txtperinc_autoloanexp" value="<%=Helper.correctNull((String) hshValues.get("perinc_autoloanexp"))%>"
													size="12" maxlength="12" style="text-align: right"></td>
											</tr>
											<tr>
												<td>Insurance</td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td><input type="text" tabindex="14" value="<%=Helper.correctNull((String) hshValues.get("perinc_domesticexp"))%>" name="txtperinc_domexp" size="12" maxlength="12"
													style="text-align: right"></td>
											</tr>
											<tr>
												<td>Other Deductions 1</td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td><input type="text" tabindex="14" name="txtperinc_rentexp" value="<%=Helper.correctNull((String) hshValues.get("perinc_rentexp"))%>"
													size="12" maxlength="12" style="text-align: right"></td>
											</tr>
											<tr>
												<td>Other Deductions 2</td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td><input type="text" tabindex="15" name="txtperinc_otherexp" value="<%=Helper.correctNull((String) hshValues.get("perinc_otherexp"))%>"
													size="12" maxlength="12" style="text-align: right"></td>
											</tr>
											<tr>
												<td>Total</td>
												<td align="right"><%=ApplicationParams.getCurrency()%></td>
												<td><input type="text" name="txtperinc_total" size="12"
													maxlength="12" style="text-align: right"></td>
											</tr>
											<tr>
												<td>Description</td>
												<td colspan="2" align="right"><textarea name="txa_desc"
													cols="65" wrap="VIRTUAL" rows="2" tabindex="33"><%=Helper.correctNull((String) hshValues.get("txa_desc"))%></textarea>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
								<td width="50%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									height="275%" class="outertable">
									<tr>
										<td valign="top" height="110">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr>
												<td width="49%" colspan="2"><b>Other Details</b></td>
												<td width="51%" colspan="2">&nbsp;</td>
											</tr>
											<tr>
												<td width="35%">Latest I.T. Return verified ?</td>
												<td width="10%"><select name="cboitreturn"
													tabindex="25">
													<option value="Y">Yes</option>
													<option value="N">No</option>
												</select></td>
												<td width="45%">Statement of Assets &amp; Liabilities verfied ?</td>
												<td width="10%"><select name="cboassetliability" tabindex="26">
													<option value="Y">Yes</option>
													<option value="N">No</option>
												</select></td>
											</tr>
											<tr>
												<td><b>Annual Income </b></td>
												<td>&nbsp;</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
			                                    <td width="332">&nbsp;</td>
			                                    <td width="133" align="center" valign="middle"><b>Year&nbsp;1</b></td>
			                                    <td width="153" align="center" valign="middle"><b>Year&nbsp;2</b></td>
											</tr>
											<tr>
			                                    <td width="332">&nbsp;</td>
			                                    <td width="133" align="center" valign="middle"><b>(Rs.)</b></td>
			                                    <td width="153" align="center" valign="middle"><b>(Rs.)</b></td>
											</tr>
											<tr>
                                    			<td align="right" width="332"><b>Income as per ITR/FS/Declaration</b></td>
                                   	 			<td align="center" valign="middle" width="133"> 
                                      				<input name="txt_yearincome1" type="text" size="15" tabindex="28" maxlength="12" style="text-align: right" value="<%=Helper.correctDouble((String) hshValues.get("perinc_year1_income"))%>"></td>
                                    			<td align="center" valign="middle" width="153"> 
                                      				<input name="txt_yearincome2" type="text" size="15" tabindex="30" maxlength="12" style="text-align: right" value="<%=Helper.correctDouble((String) hshValues.get("perinc_year2_income"))%>"></td>
											</tr>
											<tr>
			                                    <td align="right" width="332"><b>Add: Depreciation</b></td>
			                                    <td align="center" valign="middle" width="133"> 
                                      			<input name="txt_year1_depreciation" type="text" size="15" tabindex="28" maxlength="12" style="text-align: right"
													value="<%=Helper.correctDouble((String) hshValues.get("perinc_depreciation_year1"))%>">
												</td>
                                    			<td align="center" valign="middle" width="153"> 
                                      			<input name="txt_year2_depreciation" type="text" size="15" tabindex="30" maxlength="12" style="text-align: right"
													value="<%=Helper.correctDouble((String) hshValues.get("perinc_depreciation_year2"))%>"></td>
											</tr>
											<tr>
			                                    <td align="right" width="332"><b>Add: Interest 
			                                      of Existing liabilites whose Interest is 
			                                      considered in P&L</b></td>
	                                    		<td align="center" valign="middle" width="133"> 
	                                      		<input name="txt_year1_intonliab" type="text" size="15" tabindex="28" maxlength="12" style="text-align: right"
														value="<%=Helper.correctDouble((String) hshValues.get("perinc_intonliab_year1"))%>"></td>
	                                    		<td align="center" valign="middle" width="153"> 
	                                      		<input name="txt_year2_intonliab" type="text" size="15" tabindex="30" maxlength="12" style="text-align: right"
														value="<%=Helper.correctDouble((String) hshValues.get("perinc_intonliab_year2"))%>"></td>
											</tr>
											<tr>
												<td colspan="3">
													<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr valign="top">
                                    					<td align="left" width="271">Particulars of income tax &amp; sales tax assesment</td>
                                    					<td align="left" valign="middle" colspan="2">
														<textarea name="textarea_it" cols="50" rows="3" wrap="VIRTUAL" tabindex="34" onKeyPress="textlimit(this,2499)" onKeyUp="textlimit(this,2499)"><%=Helper.correctNull((String) hshValues.get("perinc_it"))%></textarea>
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
		</td>
	</tr>
</table>
  <br>
 <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId %>'/>
<INPUT TYPE="hidden" name="hidAppType">
<INPUT TYPE="hidden" name="hidApp_type" value="A">
<INPUT TYPE="hidden" name="page" value="ep">
<input type="hidden" name="txtperinc_secincome" size="12" maxlength="12" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("perinc_secincome"))%>">
<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
<INPUT TYPE="hidden" name="pageid" value="<%=pageid%>">
<INPUT TYPE="hidden" name="hidPage" value="<%=pageid%>">
<INPUT TYPE="hidden" name="applntype" value="<%=(String)request.getParameter("applnt")%>" >
<input type="hidden" name="hidpromoter" value="">
<input type="hidden" name="otherGetMethod" value="">
<input type="hidden" name="cmdsave" value="" disabled>
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<input type="hidden" name="hidEmployment" value="<%=Helper.correctNull((String)request.getParameter("hidEmployment"))%>">
</form>
</body>
</html>
 