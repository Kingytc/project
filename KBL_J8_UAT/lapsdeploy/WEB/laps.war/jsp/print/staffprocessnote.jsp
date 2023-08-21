<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%ArrayList arryCol = null;
			ArrayList arryRowinternal = (ArrayList) hshValues.get("arrDocsId");
			ArrayList arryRowapplicant = (ArrayList) hshValues
					.get("arrDocsapplicant");
			String prd_type = Helper.correctNull((String) hshValues
					.get("prd_type"));
			ArrayList arrRow = (ArrayList) hshValues.get("mailcomments");
			String PrincipalRatio = Helper.correctNull((String) hshValues
					.get("PrincipalRatio"));
			String InterestRatio = Helper.correctNull((String) hshValues
					.get("InterestRatio"));
			String strInterstType = "";
			if (InterestRatio.equals("0") || PrincipalRatio.equals("0")) {
				strInterstType = "Compound";
			} else if (!(InterestRatio.equals("0") || PrincipalRatio
					.equals("0"))) {
				strInterstType = "Simple";
			} else {
				strInterstType = "";
			}
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = null;

			java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			//out.println(hshValues);

			%>
<html>
<head>
<title>Staff Process Note</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">

</head>

<body bgcolor="#FFFFFF" text="#000000">
<form>
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	bordercolor="#999999">
	<tr>
		<td>
		<table width="100%" border="1" cellpadding="5" cellspacing="0"
			bordercolor="#999999">
			<tr>
				<td width="50%"><b>KARNATAKA BANK LTD.<br>
				HUMAN RESOURCES MANAGEMENT DEPT.<br>
				PERSONNEL ADMIN.DEVISION.,C.O.</b></td>
				<td width="50%" valign="top"><b> <%if (prd_type.equalsIgnoreCase("pH")) {
				out
						.print("APPRAISAL FORM FOR STAFF HOUSING LOAN AND COMMERCIAL RATE OF INTERST FOR OFFICERS/CLERKS/SUB-STAFF");
			} else if (prd_type.equalsIgnoreCase("pP")) {
				if (Helper.correctNull((String) hshValues.get("nscproduct"))
						.equalsIgnoreCase("1")) {
					out
							.print("Appraisal Form for N.S.C Loan for officers/clearks/sub staff ");
				} else if (Helper.correctNull(
						(String) hshValues.get("productloantype"))
						.equalsIgnoreCase("OD")) {
					out
							.print("Apprasal Form for Clean Overdraft for officers/clerks/sub-staff ");
				} else
					out
							.print("COMMON APPRAISAL FORM FOR CLEAN LOAN FOR OFFICERS/CLERKS/SUB-STAFF");
			} else if (prd_type.equalsIgnoreCase("pA")) {
				out
						.print("APPRAISAL FORM FOR CONVEYANCE LOAN FOR PURCHASE OF NEW/SECOND HAND FOUR/TWO WHEELER AND REPAIRS OF FOUR WHEELER FOR OFFICERS");
			} else if (prd_type.equalsIgnoreCase("pD")) {
				out
						.print("APPRAISAL FORM FOR COMPUTER LOAN FOR CLERKS/SUB-STAFF");
			}

			%> </b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellpadding="3" cellspacing="0"
			bordercolor="#999999">
			<tr>
				<td width="9%">NAME</td>
				<td width="23%">&nbsp;<b><%=Helper.correctNull((String) hshValues.get("Title"))%><%=Helper.correctNull((String) hshValues.get("appname"))%></b></td>
				<td width="12%">P.F.NO.</td>
				<td width="17%">&nbsp;<b><%=Helper.correctNull((String) hshValues.get("pfno"))%></b></td>
				<td width="24%">DESIGNATION</td>
				<td width="15%">&nbsp;<b><%=Helper.correctNull((String) hshValues
							.get("peremp_design"))%></b></td>
			</tr>
			<tr>
				<td width="9%">LOCATION</td>
				<td width="23%">&nbsp;<b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b></td>
				<td width="12%">DATE OF JOINING</td>
				<td width="17%">&nbsp;<b><%=Helper.correctNull((String) hshValues
							.get("perapp_staffdoj"))%></b></td>
				<td width="24%">SERVICE PERIOD AVAILABLE</td>
				<td width="15%"><b>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("yearsofservice"))%>&nbsp;yrs</b></td>
			</tr>
			<tr>
				<td colspan="2">SERVICE RECORD</td>
				<td colspan="4">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("perapp_servicerecord"))%></td>
			</tr>
			<tr>
				<td colspan="3">NAME OF THE NOMINEE FOR P.F.</td>
				<td width="17%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("perapp_nomineepfname"))%></td>
				<td width="24%">RELATIONSHIP</td>
				<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("perapp_pfrelation"))%></td>
			</tr>
			<tr>
				<td colspan="3">NAME OF NOMINEE FOR GRATUITY</td>
				<td width="17%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("perapp_nomineegratuityname"))%></td>
				<td width="24%">RELATIONSHIP</td>
				<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("perapp_gratuityrelation"))%></td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td>
		<table width="100%" border="1" cellpadding="5" cellspacing="0"
			bordercolor="#999999">

		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellpadding="5" cellspacing="0"
			bordercolor="#999999">
			<tr>
				<td width="25%">AMOUNT APPLIED FOR</td>
				<td width="21%">&nbsp;<b><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) hshValues
													.get("amtreqd"))))%></b></td>
				<td width="12%">PURPOSE</td>
				<td width="42%">&nbsp;<b><%=Helper.correctNull((String) hshValues
							.get("loan_purposeofloan"))%></b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>&nbsp;SALARY PARTICULARS</b></td>
	</tr>
	<tr>
		<td align="center" width="60%">
		<table width="72%" border="1" cellpadding="3" cellspacing="0"
			bordercolor="#999999">
			<tr>
				<!-- <td width="15%">BASIC</td> -->
				<td width="29%">GROSS EARNINGS</td>
				<td width="31%">TOTAL DEDUCTION</td>
				<td width="25%">NET SALARY</td>
			</tr>
			<tr>
				<!--  <td width="15%">&nbsp;</td> -->
				<td width="29%">&nbsp;<b><%=Helper.formatDoubleValue((Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("perinc_monsalary"))) + Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("perinc_otherincome")))))%></b></td>
				<td width="31%">&nbsp;<b><%=Helper.formatDoubleValue((Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("perinc_deduction"))) + Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("perinc_otherdeduction")))))%></b></td>
				<td width="25%">&nbsp;<b><%=Helper.formatDoubleValue(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("netsalary"))))%></b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="22">&nbsp;</td>
	</tr>
	<tr>
		<td><b>ELIGIBILITY</b></td>
	</tr>
	<tr>
		<td align="center" width="60%">
		<table width="60%" border="1" cellpadding="3" cellspacing="0"
			bordercolor="#999999">
			<tr>
				<td width="42%">Maximum eligible</td>
				<td width="58%">Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("rangeto"/*"sancamount"*/))))%></td>
			</tr>
			<tr>
				<td width="42%">Amount eligible as per Income criteria</td>
				<td width="58%">Rs.<b><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("dblRepaycapacityeligibility"))))%></b></td>
			</tr>
			<tr>
				<td width="42%">Margin Amount</td>
				<td width="58%">Rs.<b><%=Helper
									.formatDoubleValue(Double
											.parseDouble(Helper
													.correctDouble((String) hshValues
															.get("offeredmargin"/*"loan_margin_amt"*/))))%></b></td>
			</tr>
			<tr>
				<td width="42%">Sanctioned amount</td>
				<td width="58%">Rs.<b><%=Helper.formatDoubleValue(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("sancamount"))))%></b></td>
			</tr>
			<%String type = Helper.correctNull((String) hshValues
					.get("loan_inttype"));
			if (type.equalsIgnoreCase("slab")) {

				%>
			<tr>
				<td width="42%" valign="top">Interest Rate</td>
				<td width="58%" valign="top"><b> <%vecRow = (ArrayList) hshValues.get("vecRowslab");
				if (vecRow != null && vecRow.size() > 0) {%>
				<table width="100%" border="1" cellspacing="0" cellpadding="0"
					valign="top">
					<tr valign="top">
						<td>Range From</td>
						<td>Range To</td>
						<td>Slab Interest</td>
					</tr>
					<%for (int i = 0; i < vecRow.size(); i++) {%>

					<%vecCol = (ArrayList) vecRow.get(i);
						if (vecCol != null && vecCol.size() > 0) {%>
					<tr valign="top">
						<td><%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) vecCol
																			.get(0))))%></td>

						<%if (i == (vecRow.size() - 1)) {%>
						<td><%=Helper
														.formatDoubleValue(Double
																.parseDouble(Helper
																		.correctDouble((String) hshValues
																				.get("sancamount"))))%></td>
						<%} else {%>
						<td><%=Helper
														.formatDoubleValue(Double
																.parseDouble(Helper
																		.correctNull((String) vecCol
																				.get(1))))%></td>
						<%}

							%>
						<td><%=Helper
													.correctNull((String) vecCol
															.get(2))%></td>
					</tr>
					<%}%>

					<%}%>

				</table>
				<%}

			%> &nbsp; </b></td>
			</tr>
			<%} else {%>
			<tr>
				<td width="42%">Interest Rate</td>
				<td width="58%">&nbsp;<b><%=Helper.correctNull((String) hshValues
										.get("mintrate"))%><%=" % "%>(<%=Helper.correctNull((String) hshValues
								.get("loan_inttype"))%>)</b></td>
			</tr>
			<%}

			%>
			<tr>
				<td width="42%">Interest Type</td>
				<td width="58%">&nbsp;<b><%=strInterstType%></b></td>
			</tr>
			<tr>
				<td width="42%">Interest Frequency</td>
				<td width="58%">&nbsp;<b><%//=Helper.correctNull((String)hshValues.get("prd_principal"))%><!--:--><%//=Helper.correctNull((String)hshValues.get("prd_interest"))%></b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>INCOME CRITERIA</b></td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Net pay should be
		<%=Helper.correctNull((String) hshValues.get("sustanence"))%>% of
		Gross Salary after including notional instalment for the loan to be
		sanctioned.</td>
	</tr>
	<tr>
		<%//String percenGrossSalary=Helper.correctNull((String)hshValues.get("percenGrossSalary"));
			//double dbsalary=Double.parseDouble(percenGrossSalary);%>
		<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Present Net
		Pay,after including notional instalment for the loan, is <b><%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("percenGrossSalary"))))%></b>
		% of Gross salary.</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>Document submitted:-</b></td>
	</tr>
	<tr>
		<td><%if (arryRowapplicant != null && arryRowapplicant.size() > 0) {
				for (int i = 0; i < arryRowapplicant.size(); i++) {
					arryCol = (ArrayList) arryRowapplicant.get(i);
					if (arryCol != null) {

						%> <%=i + 1%>)&nbsp;<%=Helper.correctNull((String) arryCol.get(0))%><br>
		<%}
				}
			}// else{
			//out.println("<b>Applicant Doesn't submitted documents</b>");
			//}

			%></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b> Document to be obtained at the time of disbursement of Loan:-</b></td>
	</tr>
	<tr>
		<td><%if (arryRowinternal != null) {
				for (int i = 0; i < arryRowinternal.size(); i++) {
					arryCol = (ArrayList) arryRowinternal.get(i);
					if (arryCol != null) {

						%> <%=i + 1%>)&nbsp;<%=Helper.correctNull((String) arryCol.get(1))%><br>
		<%}
				}
			}

			%></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>----------------------------------------------------------------------------------------------------------------------------
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>RECOMMENDATION:</b></td>
	</tr>
	<%-- 
    <tr> 
      <td> <b><%=Helper.correctNull((String)hshValues.get("Title"))%></b><b><%=Helper.correctNull((String)hshValues.get("appname"))%></b> 
        &nbsp;MAY BE GRANTED STAFF <%=Helper.correctNull((String)hshValues.get("subcategory")) %> OF RS.  <B><%=Helper.formatDoubleValue(Double.parseDouble(Helper
  						.correctDouble((String) hshValues.get("sancamount"))))%></B></td>
    </tr>--%>
	<%if (arrRow != null && arrRow.size() > 0) {%>
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0"
			bordercolor="#999999">
			<%for (int i = 0; i < arrRow.size(); i++) {
					ArrayList arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
			<tr>
				<td valign="top" width="15%"><%=arrCol.get(0)%>&nbsp;</td>
				<td valign="top" width="2%">:&nbsp;</td>
				<td valign="top" width="83%">
				<P><%=arrCol.get(1)%>&nbsp;</P>
				</td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
	<%}

			%>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td align="center" class="td_bg"><strong>Sanctioned / Declined</strong></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0"
			bordercolor="#999999">
			<tr>
				<td valign="top"><%=Helper.correctNull((String) hshValues.get("sancauth"))%>&nbsp;</td>
				<td valign="top">:&nbsp;</td>
				<td valign="top">
				<p><%=Helper.correctNull((String) hshValues
							.get("sancofficercomments"))%>&nbsp;</p>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr ALIGN="CENTER">
		<td><b>SANCTIONING AUTHORITY</b></td>
	</tr>
</table>
</form>
</body>
</html>
