<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%java.text.NumberFormat nf = java.text.NumberFormat
					.getNumberInstance();
			nf.setGroupingUsed(false);
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);

			String strLandtype = "";
			if (Helper.correctNull((String) hshValues.get("landtype"))
					.equalsIgnoreCase("C")) {
				strLandtype = "Cents";
			} else {
				strLandtype = "Gunthas";
			}

			ArrayList vecdata = new ArrayList();
			ArrayList vecdrydata = new ArrayList();
			ArrayList vecirridata = new ArrayList();
			ArrayList vecnonculdata = new ArrayList();
			ArrayList vecGuarantor = new ArrayList();
			ArrayList vecEncumbrance = new ArrayList();
			ArrayList arrCoapplicant = new ArrayList();
			int vecGua_size = 0;
			int arrcoapp_size = 0;
			if (hshValues != null) {
				vecdata = (ArrayList) hshValues.get("vecData");
				vecGuarantor = (ArrayList) hshValues.get("vecGuarantor");
				vecEncumbrance = (ArrayList) hshValues.get("vecEncumbrance");
				arrCoapplicant = (ArrayList) hshValues.get("arrCoapplicant");
			}
			vecGua_size = vecGuarantor.size();
			arrcoapp_size = arrCoapplicant.size();
			if (vecdata != null) {
				vecdrydata = (ArrayList) vecdata.get(0);
				vecirridata = (ArrayList) vecdata.get(1);
				vecnonculdata = (ArrayList) vecdata.get(2);
			}
			String perinc_history = Helper.correctNull((String) hshValues
					.get("perinc_history"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI Process note for Agriculture</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>

<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="5"
			bordercolor="#999999">
			<tr>
				<td width="100%">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td rowspan="3"></td>
					</tr>
					<tr>
						<td align="center"><img
							src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
					</tr>
					<tr>
						<td align="center"><strong><%=Helper.correctNull((String) hshValues.get("branchname"))%>&nbsp;Branch</strong></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td align="center">Agriculture Credit - &nbsp;<%=Helper.correctNull((String) hshValues
							.get("facility_name"))%></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td width="30%"><b>Application for loan of </b></td>
						<td width="70%">Rs.&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues
									.get("amtrequested"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td width="30%"><b>Purpose</b></td>
						<td width="70%"><%=Helper.correctNull((String) hshValues
									.get("loanpurpose"))%>&nbsp;</td>
					</tr>
					<tr>
						<td><b>Name of the Account&nbsp;</b></td>
						<td><%=Helper.correctNull((String) hshValues.get("title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues.get("name"))%>&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td align="center">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td width="30%">1. <b>Name of the Applicant</b></td>
						<td width="70%">&nbsp;<%=Helper.correctNull((String) hshValues.get("title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues.get("name"))%></td>
					</tr>
					<tr>
						<td>2. <b>Address</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("address1"))%></td>

					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("address2"))%>,&nbsp;<%=Helper.correctNull((String) hshValues.get("address3"))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("city"))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("state"))%>-&nbsp;<%=Helper.correctNull((String) hshValues.get("zip"))%></td>
					</tr>
					<tr>
						<td>&nbsp;Phone / Mobile No.</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("phone"))%></td>
					</tr>
				</table>
				</td>
			</tr>
			<!-- Co -Applicants  -->
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td width="30%"><b>3. Details of Co-Applicant/s:</b></td>
						<td width="70%">&nbsp;</td>
					</tr>

					<%if (arrcoapp_size != 0) {
				ArrayList arrcoapp = new ArrayList();

				for (int l = 0; l < arrcoapp_size; l++) {
					arrcoapp = (ArrayList) arrCoapplicant.get(l);

					%>
					<tr>
						<td><b>Name:</td>
						<td>&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(0))%>.&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(1))%></td>
					</tr>
					<tr>
						<td><b>Address:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(2))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(3))%>&nbsp;,<%=Helper.correctNull((String) arrcoapp
											.get(4))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(5))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(6))%>-&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(7))%></td>
					</tr>
					<tr>
						<td>Phone / Mobile No.</td>
						<td>&nbsp;<%=Helper.correctNull((String) arrcoapp
											.get(8))%></td>
					</tr>
					<tr>
						<td><b>Means of Coapplicant:</b></td>
						<td>&nbsp;Rs.&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) arrcoapp
													.get(9))))%></td>
					</tr>  
					<tr>
						<td colspan="2">&nbsp;</td>
					</tr>
					<%}
			}

			%>
				</table>
				</td>
			</tr>
			<!--  -->
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td width="30%">4. <b>Constitution:</b></td>
						<td width="70%">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("constitution"))%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td colspan="2">5. <b>Particulars of Land Owned: </b></td>
					</tr>
					<tr>
						<td width="5%">&nbsp;</td>
						<td>
						<div id="top">
						<table width="75%" border="0" cellspacing="0" cellpadding="0">
							<tr class="tblhead">
								<td align="center" width="40%"><b>Particulars of the land owned</b></td>
								<td align="center" width="15%"><b>Acre</b></td>
								<td align="center" width="15%"><b><%=strLandtype%></b></td>
								<td align="center" width="30%"><b>Value (Rs. in Lacs)</b></td>
							</tr>
							<tr>

								<td align="left" width="40%"><b>Irrigated</b></td>
								<td align="center" width="15%"><%=Helper.correctNull((String) vecdrydata.get(0))%></td>
								<td align="center" width="15%"><%=Helper.correctNull((String) vecdrydata.get(1))%></td>
								<td align="right" width="30%"><%=Helper.correctNull((String) vecdrydata.get(2))%></td>
							</tr>
							<tr>

								<td align="left" width="40%"><b>Dry</b></td>
								<td align="center" width="15%"><%=Helper.correctNull((String) vecirridata.get(0))%></td>
								<td align="center" width="15%"><%=Helper.correctNull((String) vecirridata.get(1))%></td>
								<td align="right" width="30%"><%=Helper.correctNull((String) vecirridata.get(2))%></td>
							</tr>
							<tr>
								<td align="left" width="40%"><b>Non-Cultivable</b></td>
								<td align="center" width="15%"><%=Helper.correctNull((String) vecnonculdata.get(0))%></td>
								<td align="center" width="15%"><%=Helper.correctNull((String) vecnonculdata.get(1))%></td>
								<td align="right" width="30%"><%=Helper.correctNull((String) vecnonculdata.get(2))%></td>
							</tr>

						</table>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td colspan="2"><b>6. Encumbrance, if any:</b></td>
					</tr>
					<tr>
						<%
			if (vecEncumbrance != null && vecEncumbrance.size() != 0) {
				ArrayList vecEncumdata = new ArrayList();%>
						<td width="5%">&nbsp;</td>
						<td width="95%"><%for (int i = 0; i < vecEncumbrance.size(); i++) {
					vecEncumdata = (ArrayList) vecEncumbrance.get(i);
					if (vecEncumdata != null && vecEncumdata.size() != 0) {

						%> <%=(i + 1)%>.&nbsp; <%=Helper.correctNull((String) vecEncumdata
										.get(1))%><br>
						<%}
				}

			%></td>
						<%} else {

			%>
						<td width="100%">&nbsp;</td>
						<%}

			%>
					</tr>
				</table>
				</td>
			</tr>
			<!-- <tr>
        <td>*Value of land: Market rate or Govt. Rate which ever is less.</td>
        </tr> -->
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">

					<tr>

						<td colspan="2">7. <B>Last three years production data (Gross)</B></td>
					</tr>
					
					<tr>
						<td width="5%">&nbsp;</td>
						<td>
						<div id="top">
						<table width="70%" border="0" cellspacing="0" cellpadding="0">
						<tr class="tblhead">
							
							<td width="30%">Year</td>
							<td width="20%">&nbsp;<%=Helper.correctNull((String) hshValues.get("year1"))%></td>
							<td width="20%">&nbsp;<%=Helper.correctNull((String) hshValues.get("year2"))%></td>
							<td width="20%">&nbsp;<%=Helper.correctNull((String) hshValues.get("year3"))%></td>
						</tr>
						<tr>
							<td>Gross Income (Rs.)</td>
							<td align="right">&nbsp;<%=nf.format(Double
								.parseDouble(Helper
										.correctDouble((String) hshValues
												.get("grossinc1"))))%></td>
							<td align="right">&nbsp;<%=nf.format(Double
								.parseDouble(Helper
										.correctDouble((String) hshValues
												.get("grossinc2"))))%></td>
							<td align="right">&nbsp;<%=nf.format(Double
								.parseDouble(Helper
										.correctDouble((String) hshValues
												.get("grossinc3"))))%></td>
						</tr>
						</table>
						</div>
						</td>
						</tr>
					</table>
				</td>
			</tr>
				<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">	
					<%if (perinc_history.equalsIgnoreCase("1")) {

				perinc_history = "Regular/Advance Payment during the year";
			} else if (perinc_history.equalsIgnoreCase("2")) {

				perinc_history = "Account is regular but occasional default during the year";
			} else if (perinc_history.equalsIgnoreCase("3")) {

				perinc_history = "One Installment / EMI due for the latest month only";
			} else if (perinc_history.equalsIgnoreCase("4")) {

				perinc_history = "One EMI/Installments continuously in arrears";
			} else if (perinc_history.equalsIgnoreCase("5")) {

				perinc_history = "Two EMI/Installments continuously in arrears ";
			} else if (perinc_history.equalsIgnoreCase("6")) {

				perinc_history = "Installment/Instant OD for > 3 months";
			} else if (perinc_history.equalsIgnoreCase("7")) {

				perinc_history = "Account Closed by way of W/O compromise settlement";
			} else if (perinc_history.equalsIgnoreCase("8")) {

				perinc_history = "No Borrowings";
			} else {
				perinc_history = "";
			}%>
					<tr>

						<td width="30%"><b>8. Past dealings with Bank:</b></td>
						<td><%=perinc_history%></td>
					</tr>
					<tr>

						<td width="30%"><b>9. Means of the applicant: </b></td>
						<td> Rs. <%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("Total_MEANS"))))%> Lacs</td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td width="30%">10. Details of Guarantor/s:</td>
						<td width="70%">&nbsp;</td>
					</tr>

					<%if (vecGua_size != 0) {
				ArrayList vecGua = new ArrayList();

				for (int l = 0; l < vecGua_size; l++) {
					vecGua = (ArrayList) vecGuarantor.get(l);

					%>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>Name:</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecGua.get(0))%>.&nbsp;<%=Helper.correctNull((String) vecGua.get(1))%></td>
					</tr>
					<tr>
						<td>Address:</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecGua.get(2))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecGua.get(3))%>&nbsp;,<%=Helper.correctNull((String) vecGua.get(4))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecGua.get(5))%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecGua.get(6))%>-&nbsp;<%=Helper.correctNull((String) vecGua.get(7))%></td>
					</tr>
					<tr>
						<td>Phone / Mobile No.</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecGua.get(8))%></td>
					</tr>
					<tr>
						<td>Means of Guarantor:</td>
						<td>&nbsp;Rs.&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecGua
													.get(9))))%></td>
					</tr>
					<%}
			}

			%>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="50%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td colspan="2">11. <b>Particular of Annual Income:</b></td>
						<!-- <td width="34%">&nbsp;</td>-->
					</tr>
					<tr class="tblhead">
						<td width="27%" align="center"><b>Source</b></td>
						<td width="39%" align="center">&nbsp;</td>
						<!--<td align="center">Expected <br />
              (After utilisation of loan)</td>-->
					</tr>
					<tr>
						<td><b>Agriculture</b></td>
						<td>Rs. <%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("strAgriIncome"))))%></td>

						<!--<td>Rs.</td>-->
					</tr>
					<tr>
						<td><b>Other</b></td>
						<td>Rs. <%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("strOtherIncome"))))%></td>
						<!-- <td>Rs.</td>-->
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<!--<td>&nbsp;</td>-->
					</tr>
					<tr>
						<td><b>Total</b></td>
						<td>Rs. <%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("strAgriIncome")))
							+ Double.parseDouble(Helper.correctDouble((String) hshValues.get("strOtherIncome"))))%></td>
						<!--<td>Rs.</td>-->
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td>12.<b>General Comments:</b></td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String) hshValues.get("Comments"))%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>

						<td>13.<b> Recommendations:</b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><%ArrayList vecRow = (ArrayList) hshValues.get("recommendations");
			if (vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					out.print(vecRow.get(i) + "<br>");
				}
			}

		%></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>Signature: <br />
				<br />
				Name of Processing officer: <br />
				<br />
				P. A. No. <br />
				<br />
				Date:</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>

