<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");
String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String strproduct = "";
strproduct = prd_type.substring(0, 1);
%>
<html>
<head>
<title>Personal - Financial Liabilities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perfinancialliab.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varApptype="<%=Helper.correctNull((String) hshValues.get("strAppValue"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var strvalue="loan_appretail_fin_liab.htm";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
function checkbankvalue()
{
	if(document.forms[0].checkourbank.checked==true)
	{
		document.forms[0].txtliab_inst.value="Karnataka Bank Ltd";
		document.forms[0].txtliab_inst.readOnly=true;
	}
	else
	{
		document.forms[0].txtliab_inst.value="";
		document.forms[0].txtliab_inst.readOnly=true;
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()">
<form name="finForm" method="post" class="normal">
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="3" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Securities -&gt; Liabilities</td>
	</tr>
</table>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>				
				<td align="center" class="sub_tab_inactive" width="50%"><b><a href="JavaScript:callInvestment()" >Securities</a></b></td>
				<!-- <td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callInsurancePolicy()" >Insurance Policies</a></b></td> -->
				<td align="center" class="sub_tab_active" width="50%"><b>Liabilities</b></td>
				<!-- <td align="center" class="sub_tab_inactive" width="15%"><b><a href="JavaScript:callLifeStyle()" >LifeStyle</a></b></td> -->
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">		
								<table width="100%" border="0" cellspacing="3" cellpadding="3" align="center" class="outertable">
									<tr>
										<td align="right"><a href="JavaScript:callApplicant()"> </a>Applicant Type</td>
										<td><select name="selapptype" onChange="getCollData()">
											<option value="">&lt;---- Select ----&gt;</option>
											<lapschoice:fincoappguarantor />
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
											<tr>
												<td width="13%">Name of the Institution<b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="19%"><input type="text" name="txtliab_inst"
													value="" size="20" maxlength="50" style="text-align:left"
													onKeyPress="notAllowSingleQuote()"></td>
												<td width="19%">Our Bank</td>
												<td width="17%"><input type="checkbox" name="checkourbank"
													style="border-style:none" onClick="checkbankvalue()"></td>
												<td width="15%">Loan Type<b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="17%"><select name="choliab_loantype"
													style="Width:180">
													<option value="">--Select--</option>
													<option value="HL">Housing Loan</option>
													<option value="CL">Cash Loan</option>
													<option value="VL">Vehicle Loan</option>
													<option value="CD">Consumer Durables Loan</option>
													<option value="EL">Education Loan</option>
													<option value="ML">Mortgage Loan</option>
													<option value="AL">Health Loan</option>
													<option value="GL">Gold Loan</option>
													<option value="TL">Top Up</option>
													<option value="SL">Smiles Loan</option>
													<option value="CC">Credit Card</option>
													<option value="PL">Personal Loan</option>
													<option value="OL">Others</option>
												</select> <input type="hidden" name="hid_choliab_loantype">
												</td>
											</tr>
											<tr>
												<td width="13%">Purpose of Loan</td>
												<td width="19%"><input type="text" name="txtliab_accountno"
													size="20" style="text-align:left" maxlength="280"
													onKeyPress="notAllowSingleQuote()"></td>
												<td width="19%">Loan Amount <b>(<%=ApplicationParams.getCurrency()%>)</b><b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="17%"><lapschoice:CurrencyTag
													name="txtliab_loanamt" size="12" maxlength="12" /></td>
												<td width="15%">Outstanding Balance <b>(<%=ApplicationParams.getCurrency()%>)</b><b><span class="mantatory">*&nbsp;</span></b></td>
												<td width="17%"><lapschoice:CurrencyTag
													name="txtliab_balance" size="12" maxlength="12" value='' /></td>
											</tr>
											<tr>
												<td width="13%">Of Which Overdue <b>(<%=ApplicationParams.getCurrency()%>)</b></td>
												<td width="19%"><lapschoice:CurrencyTag
													name="txtliab_overdueamount" size="12" maxlength="12"
													value='' /></td>
												<td width="19%">Overdue since</td>
												<td width="17%"><input type="text"
													name="txtliab_overduesince" size="10"
													style="text-align:right" maxlength="10"
													onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
													alt="Select date from calender" href="#"
													onClick="callCalender('txtliab_overduesince')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender"></a></td>
												<td width="13%"><%if (strproduct.equalsIgnoreCase("p")) {%> 
												Monthly/Min Payment <b>(<%=ApplicationParams.getCurrency()%>)</b>
												<%} else if (!strproduct.equalsIgnoreCase("p")) {%> 
												Instalment Amt Payable during Year <b>(<%=ApplicationParams.getCurrency()%>)</b>
												<%}%><b><span class="mantatory">*&nbsp;</span></b>
												</td>
												<td width="19%"><lapschoice:CurrencyTag name="txtliab_minpayment" size="12" maxlength="12" /></td>
											</tr>
											<tr>
												<td width="13%">Securities Offered</td>
												<td width="19%"><textarea name="txtliab_secur" cols="35"
													rows="5" onKeyPress="textlimit(this,'199')" onKeyUp="textlimit(this,199)" wrap="VIRTUAL"></textarea>
												</td>
												<td width="19%">Sanction Ref. No</td>
												<td width="17%"><input type="text" name="txtliab_sancrefno"
													size="20" style="text-align:left" maxlength="20"
													onKeyPress="notAllowSingleQuote()"></td>
												<td width="13%">Present Status</td>
												<td width="19%"><input type="text" name="txtliab_presentstatus"
													size="20" style="text-align:left" maxlength="20"
													onKeyPress="notAllowSingleQuote()"></td>
											</tr>
										</table>
										</td>
									</tr>
									</table>
									</td>
									</tr>
									</table><br>
									<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail_Comments' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
											<tr class="dataheader">
												<td width="5%" >&nbsp;</td>
												<td width="25%" align="center" ><b>Name of the Institution</b></td>
												<td width="6%" align="center" ><b>Ourbank</b></td>
												<td width="19%" align="center" ><b>Loan Amount (<%=ApplicationParams.getCurrency()%>)</b></td>
												<td width="15%" align="center" ><b>Outstanding Balance (<%=ApplicationParams.getCurrency()%>)</b></td>
												<td width="13%" align="center" ><b>Overdue Amount (<%=ApplicationParams.getCurrency()%>)</b></td>
												<td width="17%" align="center" ><b>Securities Offered</b></td>
											</tr>
											<%if (arrRow != null && arrRow.size()>0) {
			for (int i = 0; i < arrRow.size(); i++) {
				arrCol = (ArrayList) arrRow.get(i);
					String checkourbank = "";
					String checkourbankvalue = "";
					checkourbank = Helper.correctNull((String) arrCol.get(9));
					if (checkourbank.equalsIgnoreCase("Y")) {
						checkourbankvalue = "Yes";
					} else {
						checkourbankvalue = "No";
					}%>
													<tr class="datagrid">
														<td width="4%"><input type="radio" name="sel"
															style="border-style:none"
															onClick=" selectvalues ('<%=Helper.correctNull((String) arrCol.get(0))%>',
																							'<%=Helper.correctNull((String) arrCol.get(1))%>',
																							'<%=Helper.correctNull((String) arrCol.get(2))%>',
																							'<%=Helper.correctNull((String) arrCol.get(3))%>',
																							'<%=Helper.correctNull((String) arrCol.get(4))%>',
																							'<%=Helper.correctNull((String) arrCol.get(5))%>',
																							'<%=Helper.correctNull((String) arrCol.get(6))%>',
																							'<%=Helper.correctNull((String) arrCol.get(7))%>',
																							'<%=Helper.correctNull((String) arrCol.get(9))%>',
																							'<%=Helper.correctNull((String) arrCol.get(10))%>',
																							'<%=Helper.correctNull((String) arrCol.get(11))%>',
																							'<%=Helper.correctNull((String) arrCol.get(12))%>',
																							'<%=i%>','<%=arrRow.size()%>')">
														<input type="hidden" name="hidliab_secur" value="<%=Helper.correctNull((String) arrCol.get(8))%>"></td>
														<td width="26%" >&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
														<td width="6%" >&nbsp;<%=checkourbankvalue%></td>
														<td width="19%" align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
														<td width="15%" align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
														<td width="13%" align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
														<td width="17%" >&nbsp; <%=Helper.correctNull((String)arrCol.get(8))%></td>
													</tr>
													<%}}%>
													<tr class="datagrid">
														<td width="4%">&nbsp;</td>
														<td width="26%">&nbsp;</td>
														<td width="6%">&nbsp;</td>
														<td width="19%">&nbsp;</td>
														<td width="15%">&nbsp;</td>
														<td width="13%">&nbsp;</td>
														<td width="17%">&nbsp;</td>
													</tr>
													<tr class="datagrid">
														<td width="4%">&nbsp;</td>
														<td width="26%">&nbsp;</td>
														<td width="6%">&nbsp;</td>
														<td width="19%">&nbsp;</td>
														<td width="15%">&nbsp;</td>
														<td width="13%">&nbsp;</td>
														<td width="17%">&nbsp;</td>
													</tr>
												</table>
												<br>
<lapschoice:hiddentag pageid='<%=PageId %>'/>
<INPUT TYPE="hidden" name="hidAppType"> 
<INPUT TYPE="hidden" name="radLoan" value="Y"> 
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidCommentPage" value="L">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)hshValues.get("strAppNo"))%>">
</form>
</body>
</html>
