<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%HashMap hash1 = (HashMap) hshValues.get("hshValues1");
			HashMap hash2 = (HashMap) hshValues.get("hshValues2");
			HashMap hash3 = (HashMap) hshValues.get("hshValues3");
			HashMap hash5 = (HashMap) hshValues.get("hshValues5");
			HashMap hashprint = (HashMap) hshValues.get("hshPrint");
			HashMap hashsec = (HashMap) hshValues.get("hshSec");
			HashMap hashmeans = (HashMap) hshValues.get("hshMeans");
			HashMap hshCons = (HashMap) hshValues.get("hshcons");
			HashMap hshMul = (HashMap) hshValues.get("hshmul");

			HashMap hshSignatories = (HashMap) hshValues.get("hshSignatories");
			HashMap hshRecommendations=(HashMap)hshValues.get("hshRecommendations");
			ArrayList vecRow = (ArrayList) hashprint.get("vecRow");
			ArrayList vecCol = new ArrayList();

			ArrayList vecRow1 = (ArrayList) hashsec.get("vecRow");
			ArrayList vecCol1 = new ArrayList();

			String bank1 = "";

			String bank_arr = Helper.correctNull((String) hash1
					.get("bankarrangement"));
			if (!bank_arr.equalsIgnoreCase("")
					|| bank_arr.equalsIgnoreCase("null")) {
				if (bank_arr.equalsIgnoreCase("1")) {
					bank1 = "Sole";
				}
				if (bank_arr.equalsIgnoreCase("2")) {
					bank1 = "Consortium";
				}
				if (bank_arr.equalsIgnoreCase("3")) {
					bank1 = "Multiple Banking";
				}
			}

			ArrayList arr1 = new ArrayList();
			ArrayList arr2 = new ArrayList();

			String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidtype"));
			if (strCategoryType == "") {
				strCategoryType = Helper.correctNull((String) hshValues
						.get("strCategoryType"));
			}
			String pur1 = "", pur2 = "", pur3 = "", pur4 = "", pur5 = "", pur6 = "", pur8 = "";
			String disposed = Helper.correctNull((String) hash3
					.get("sec_disposed"));
			if (disposed != "") {
				if (disposed.equals("y")) {
					pur1 = "Yes";
				}
				if (disposed.equals("n")) {
					pur1 = "No";
				}

			}
			String possible = Helper.correctNull((String) hash3
					.get("sec_possible"));
			if (possible != "") {
				if (possible.equals("y")) {
					pur2 = "Yes";
				}
				if (possible.equals("n")) {
					pur2 = "No";
				}

			}
			String account = Helper.correctNull((String) hash3
					.get("ots_account"));
			if (account != "") {
				if (account.equals("y")) {
					pur3 = "Yes";
				}
				if (account.equals("n")) {
					pur3 = "No";
				}

			}
			String overdue = Helper.correctNull((String) hash3
					.get("ots_overdue"));
			if (overdue != "") {
				if (overdue.equals("y")) {
					pur4 = "Yes";
				}
				if (overdue.equals("n")) {
					pur4 = "No";
				}

			}
			String defaulte = Helper.correctNull((String) hash3
					.get("defaulter"));
			if (defaulte != "") {
				if (defaulte.equals("y")) {
					pur5 = "Yes";
				}
				if (defaulte.equals("n")) {
					pur5 = "No";
				}

			}
			String account2 = Helper.correctNull((String) hash3.get("account"));
			if (account2 != "") {
				if (account2.equals("y")) {
					pur6 = "Yes";
				}
				if (account2.equals("n")) {
					pur6 = "No";
				}

			}
			String bank = "";
			String borr_dispute = Helper.correctNull((String) hash3
					.get("account"));
			if (borr_dispute != "") {
				if (borr_dispute.equals("y")) {
					bank = "Yes";
				}
				if (borr_dispute.equals("n")) {
					bank = "No";
				}

			}

			String complaintsar = Helper.correctNull((String) hash2
					.get("COMPLAINT_REC"));
			if (complaintsar != "") {
				if (complaintsar.equals("y")) {
					pur8 = "Yes";
				}
				if (complaintsar.equals("n")) {
					pur8 = "No";
				}

			}
			double total = 0.0;
			double tot = 0.0;
			String strSanctauth = Helper.correctNull((String) hshSignatories
					.get("sancauth"));
			%>

<html>
<head>
<title>SARFAESI_PRINT</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>
<body>
<table width="80%" border="0" cellpadding="3" cellspacing="0">
	<%if (strSanctauth.equals("7")) {%>
		 <tr align="right">
		 	<td>
		 	<table border="0" cellspacing="0" cellpadding="3" width="">
	    		<tr>
	    		<td align="left">
	      		Agenda Item No:<%=Helper.correctNull((String) hshSignatories
								.get("agendano"))%>
	      		<br>MCM of: <%=Helper.correctNull((String) hshSignatories
										.get("mcmof"))%>
	      		</td>
	      		</tr>
	      	</table>
	      	</td>
      	</tr>
      	<%}

			%>
	<tr>
		<td align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
	</tr>
	<tr>
		<td align="center"><b>CREDIT RECOVERY &amp; LEGAL SERVICES DEPARTMENT
		</b>
		</td>
	</tr>
	<tr>
				<td align="center"><b><%=Helper.correctNull((String) hshValues.get("branchname"))%></b>&nbsp;<hr></td>
			</tr>
			<%if (strSanctauth.equals("7")) { %>
			<tr>
				<td align="center"><b><u>MEMORANDUM TO MANAGEMENT COMMITTEE</u></b></td>
			</tr>
			<%} %>
			<tr align="right"> 
 			<td>
 				<table border="0" cellspacing="0" cellpadding="6">
 					<tr>
 					<%if (strSanctauth.equals("4") || strSanctauth.equals("5")) {

				%>
		        	<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/executive/GM.jpg" width="55" height="77"></td>
		        	<td>&nbsp;&nbsp;</td>
				<%}
			if (strSanctauth.equals("5") || strSanctauth.equals("6")
					|| strSanctauth.equals("7")) {

				%>
					<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/executive/ED.jpg" width="55" height="77"></td>
					<td>&nbsp;&nbsp;</td>
				<%}
			if (strSanctauth.equals("6") || strSanctauth.equals("7")) {

				%>
					<td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/executive/CMD.jpg" width="55" height="77"></td>
				<%}

			%>
					</tr>
				</table>
			</td>
		</tr>
		<tr> 
			    <td height="2"> 
			      <table width="100%" border="0" cellspacing="0" cellpadding="3">
			        <tr> 
			          <td width="10%"><b>Ref No:</b></td>
			          <td width="60%"><%=Helper.correctNull((String) hshSignatories.get("refno"))%>&nbsp;</td>
			          <td width="17%" align="right"><b>Date :&nbsp;</b></td>
			          <td width="13%" align="right"><%=Helper.correctNull((String) hshSignatories.get("propdate"))%>&nbsp;</td>
			        </tr>
			      </table>
   				 </td>
   			</tr>
	<tr>
		<td align="center"><b>PROPOSAL FOR ENFORCEMENT OF SECURITY</b></td>
	</tr>
	<tr>
		<td align="center"><u><b>INTEREST UNDER 'SARFAESI' ACT</b></U></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td><b>We identified the following account for enforcing our security
		interest under the Act.</b></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td width="5%"><b>A)&nbsp;</b></td>
				<td colspan="3"><b>ACCOUNT PROFlLE</b></td>
			</tr>
			<tr>
				<td width="5%"><b>1.&nbsp;</b></td>
				<td width="44%"><b>NAME OF THE ACCOUNT</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%"><%=Helper.correctNull((String) request
							.getParameter("borrowername"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%"><b>2.&nbsp;</b></td>
				<td valign="top"><b>BRANCH</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top"><%=Helper.correctNull((String) hshValues.get("branchname"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%"><b>3.&nbsp;</b></td>
				<td valign="top"><b>ACTIVITY FOR WHICH FINANCED</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top"><%=Helper.correctNull((String) hash1.get("activity"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%"><b>4.&nbsp;</b></td>
				<td valign="top"><b>CONSTITUTION</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top"><%=Helper.correctNull((String) hash1.get("constitution"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%"><b>5.&nbsp;</b></td>
				<td valign="top"><b>BANKING ARRANGEMENT</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top"><%=bank1%></td>
			</tr>
			<%if (bank_arr.equalsIgnoreCase("2")
					|| bank_arr.equalsIgnoreCase("3")) {

				%>
			<tr>
				<td colspan="4" align="right"><b>(Amount in Rs.)</b></td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="3" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td><b>Name of Consortium Members</b></td>
						<%if (bank_arr.equalsIgnoreCase("2")) {

				%>
						<td><b>Sharing Pattern</b></td>
						<%}

				%>
						<td><b>Limit Sanctioned</b></td>
						<td><b>Present O/s.,</b></td>
						<td><b>Status of A/c.,</b></td>
					</tr>
					<%if (bank_arr.equalsIgnoreCase("2")) {
					arr1 = (ArrayList) hshCons.get("arrRow");
				} else if (bank_arr.equalsIgnoreCase("3")) {
					arr1 = (ArrayList) hshMul.get("arrRow");
				}
				int size1 = 0;
				size1 = arr1.size();
				if (arr1 != null || arr1.size() > 0) {
					for (int i = 0; i < size1; i++) {
						arr2 = (ArrayList) arr1.get(i);

						%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) arr2
												.get(1))%></td>
						<%if (bank_arr.equalsIgnoreCase("2")) {

							%>
						<td>&nbsp;<%=Helper.correctNull((String) arr2.get(3))%></td>
						<%}

						%>
						<td>&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arr2
														.get(2))))%></td>
						<td>&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arr2
														.get(4))))%></td>
						<td>&nbsp; <%String stat = "";
						String sta = Helper.correctNull((String) arr2.get(5));
						if (sta != "") {
							if (sta.equalsIgnoreCase("1")) {
								stat = "Regular";
							}
							if (sta.equalsIgnoreCase("2")) {
								stat = "NPA";
							}

						}

						%> <%=stat%></td>
					</tr>
					
					
					<%}
				}%>
				</table>
				</div>
				</td>
			</tr>
			<%}

			%>
				
			<tr>
				<td width="5%"><b>6.&nbsp;</b></td>
				<td valign="top"><b>ADVANCE SINCE</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hash1.get("advancesince"))%></td>
			</tr>
			<tr>
				<td width="5%"><b>7.&nbsp;</b></td>
				<td valign="top"><b>NPA SINCE</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hash1.get("npasince"))%></td>
			</tr>
			<tr>
				<td width="5%"><b>8.&nbsp;</b></td>
				<td valign="top"><b>ASSET CLASSIFICATION</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hash1
							.get("presentclassification"))%></td>
			</tr>
			<tr>
				<td width="5%"><b>9.&nbsp;</b></td>
				<td valign="top"><b>PROVISION HELD</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hash1.get("provision"))))%></td>
			</tr>
			<tr>
				<td width="5%"><b>B)&nbsp;</b></td>
				<td colspan="3"><b>BORROWER'S/GUARANTOR DETAILS</b></td>
			</tr>
			<tr>
				<td colspan="4" align="right"><b>(Amount in Rs.)</b></td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr class="tblhead">
						<td rowspan="2" valign="top" width="3%">S.NO</td>
						<td rowspan="2" valign="top" align="center">TYPE OF APPLICANT</td>
						<td rowspan="2" valign="top" align="center"><b>NAME OF APPLICANT</b></td>
						<td rowspan="2" align="center"><b>ACTIVITY OF APPLICANT</b></td>
						<td colspan="2" align="center"><b>AT THE TIME OF RENEWAL</b></td>
						<td align="center" colspan="2"><b>PRESENT POSITION</b></td>
					</tr>
					<tr class="tblhead">
						<td align="center"><b>MEANS</b></td>
						<td align="center"><b>DATE</b></td>
						<td align="center"><b>MEANS </b></td>
						<td align="center"><b>DATE</b></td>
					</tr>
					<%vecRow = (ArrayList) hashmeans.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
					<tr>
						<td width="3%" align=center>&nbsp;<%=i + 1%></td>

						<td>&nbsp;<%=Helper.correctNull((String) vecCol
											.get(11))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
						<td align="right">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
					</tr>
					<%}
			} else {

			%>
					<tr>
						<td align center colspan="8">No Data Found</td>
					</tr>
					<%}

			%>
				</table>
				</td>
			</tr>
			<tr>
				<td width="5%"><b>C)&nbsp;</b></td>
				<td colspan="3"><b>STATUS OF THE ACCOUNT</b></td>
			</tr>
			<tr>
				<td colspan="4" align="right"><b>(Amount in Rs.)</b></td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr align="center" class="tblhead">
						<td>Nature of Limit</td>
						<td>Amount of Limit</td>
						<td>O/s in R.L.</td>
						<td>Int in D.L.</td>
						<td>Total</td>
					</tr>
					<%vecRow = (ArrayList) hashprint.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(2))))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(3))))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(11))))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(13))))%></td>
					</tr>
					<%tot = Double.parseDouble(Helper
							.correctDouble((String) vecCol.get(2)));
					total = total + tot;
					/*tot1=Double.parseDouble(Helper.correctDouble((String)vecCol.get(3)));
					 total1=total1+tot1;
					 
					 tot2=Double.parseDouble(Helper.correctDouble((String)vecCol.get(11)));
					 total2=total2+tot2;
					 
					 tot3=Double.parseDouble(Helper.correctDouble((String)vecCol.get(13)));
					 total3=total3+tot3;*/
				}
			}

			%>
					<tr>
						<td align="right">&nbsp;Total</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(total)%></td>

						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%"><b>D)&nbsp;</b></td>
				<td colspan="3"><b>POSITION OF SECURITIES CHARGED TO THE BANK</b></td>
			</tr>
			<tr>
				<td colspan="4" align="right"><b>(Amount in Rs.)</b></td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					align="center">

					<tr class="tblhead">
						<td width="3%" rowspan="2" valign="top">S.No</td>
						<td align="center" valign="top" rowspan="2">TYPE OF SECURITY</td>
						<td align="center" valign="top" rowspan="2"><b>NATURE &amp;
						LOCATION</b></td>
						<td colspan="2" align="center"><b>AT THE TIME OF RENEWAL</b></td>
						<td colspan="4" align="center"><b>PRESENT POSITION</b></td>
					</tr>
					<tr class="tblhead">
						<td align="center"><b>VALUATION DATE</b></td>
						<td align="center"><b>VALUATION AMOUNT</b></td>
						<td align="center"><b>VALUATION DATE</b></td>
						<td align="center"><b>VALUATION AMOUNT</b></td>
						<td align="center"><b>INSPECTION DATE</b></td>
						<td align="center"><b>INSPECTED BY</b></td>
					</tr>


					<%vecRow1 = (ArrayList) hashsec.get("vecRow");
			if (vecRow1.size() > 0 && vecRow1 != null) {
				for (int i = 0; i < vecRow1.size(); i++) {
					vecCol1 = (ArrayList) vecRow1.get(i);

					%>
					<tr>
						<td width="3%">&nbsp;<%=i + 1%></td>
						<td align="center">&nbsp; <%String security = "";
					String sec = Helper.correctNull((String) vecCol1
							.get(1));
					if (sec.equalsIgnoreCase("c")) {
						security = "COLLATERAL";
					}
					if (sec.equalsIgnoreCase("p")) {
						security = "PRIMARY";
					}

					%> <%=security%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(2))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(3))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol1
													.get(4))))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(5))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol1
													.get(6))))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(7))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(8))%></td>
					</tr>
					<%}
			}else {

			%>
					<tr>
						<td align center colspan="9">No Data Found</td>
					</tr>
					<%}

			%>

				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td><b>E)&nbsp;</b></td>
				<td colspan="3"><b>DETAILS OF DOCUMENTATION</b></td>
			</tr>
			<tr>
				<td><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr class="tblhead">
						<td width="3%">S.No</td>
						<td align="center"><b>DOCUMENT NAME</b></td>
						<td align="center"><b>DATE OF DOCUMENTATION</b></td>
						<td align="center"><b>EXPIRY DATE OF DOCUMENT</b></td>
						<td align="center"><b>WHETHER DOCUMENTS ARE ENFORCEABLE</b></td>
						<td align="center"><b>DATE OF CERTIFICATION</b></td>
						<td align="center"><b>TYPE OF DOCUMENT</b></td>
					</tr>
					<%vecRow = (ArrayList) hash5.get("arrRow");
			if (vecRow != null && vecRow.size() > 0) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
					<tr>
						<td width="3%" align=center>&nbsp;<%=i + 1%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
						<td>&nbsp;<%if (Helper.correctNull((String) vecCol.get(4))
							.equalsIgnoreCase("3")) {
						out.println("No");
					} else if (Helper.correctNull((String) vecCol.get(4))
							.equalsIgnoreCase("2")) {
						out.println("Yes");
					}%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>

						<%String typ = "";
					String type = Helper.correctNull((String) vecCol
							.get(6));
					if (!type.equalsIgnoreCase("null")) {
						if (type.equalsIgnoreCase("2")) {
							typ = "CHARGE";
						}
						if (type.equalsIgnoreCase("3")) {
							typ = "HYPOTHECATION";
						}
						if (type.equalsIgnoreCase("4")) {
							typ = "MORTGAGE";
						}
					}

					%>
						<td>&nbsp;<%=typ%></td>
					</tr>
					<%}
			} else {

			%>
					<tr>
						<td align center colspan="7">No Data Found</td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><b>WHETHER ANY COMPLAINT WAS RECIEVED BY THE BRANCH REGARDING
				THIS ADVANCE.</b></td>
				<td><b>:</b></td>
				<td><%=pur8%>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><b>IF SO, DETAILS OF THE COMPLAINT</b></td>
				<td><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<p><%=Helper.correctNull((String) hash2
							.get("COMPLAINT_RECEIVED"))%></p>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><b>DETAILS OF DISPOSAL OF THE COMPLAINT</b></td>
				<td><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<p><%=Helper.correctNull((String) hash2
							.get("COMPLAINT_DISPOSAL"))%></p>
				</td>
			</tr>
			<tr>
				<td><b>F)&nbsp;</b></td>
				<td colspan="3"><b>ASPECTS ON DISPOSAL OF SECURITIES</b></td>
			</tr>
			<tr>
				<td valign="top"><b>1.&nbsp;</b></td>
				<td valign="top"><b>WHETHER SECURITIES CAN BE EASILY DISPOSED</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp; <%=pur1%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p><%=Helper.correctNull((String) hash3
							.get("sec_disposedetails"))%></p>
				</td>
			</tr>

			<tr>
				<td valign="top"><b>2.&nbsp;</b></td>
				<td valign="top"><b>HAS THE BORROWER DISPUTED BANK'S DUES</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp; <%=bank%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p><%=Helper.correctNull((String) hash3
							.get("borr_disputedetails"))%></p>
				</td>
			</tr>
			<tr>
				<td valign="top"><b>3.&nbsp;</b></td>
				<td valign="top"><b>WHETHER PEACEFUL POSSESSION SECURITIES POSSIBLE</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp; <%=pur2%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p><%=Helper.correctNull((String) hash3
							.get("sec_possibledetails"))%></p>
				</td>
			</tr>
			<tr>
				<td valign="top"><b>4.&nbsp;</b></td>
				<td valign="top"><b>APPROXIMATE TIME FRAME FOR DISPOSAL OF
				SECURITIES</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp; <%=Helper.correctNull((String) hash3
									.get("approxtime"))%></td>
			</tr>
			<tr>
				<td valign="top"><b>5.&nbsp;</b></td>
				<td valign="top"><b>WHETHER OTS IS APPROVED IN THIS ACCOUNT AND IF
				SO DETAILS THEREOF</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp; <%=pur3%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p><%=Helper.correctNull((String) hash3
							.get("ots_accountdetails"))%></p>
				</td>
			</tr>
			<tr>
				<td valign="top"><b>6.&nbsp;</b></td>
				<td valign="top"><b>IF OTS APPROVED IS OVERDUE IN PAYMENTS , CHANCES
				OF RECOVERY OF AMOUNT AS PER OTS</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=pur4%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p><%=Helper.correctNull((String) hash3
							.get("ots_overduedetails"))%></p>
				</td>
			</tr>

			<tr>
				<td valign="top"><b>7.&nbsp;</b></td>
				<td valign="top"><b>WHETHER BORROWER IS IDENTIFIED AS WILFUL
				DEFAULTER IF SO DETAILS</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=pur5%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p><%=Helper.correctNull((String) hash3
							.get("defaulter_details"))%></p>
				</td>
			</tr>
			<tr>
				<td valign="top"><b>7.&nbsp;</b></td>
				<td valign="top"><b>IF THE ACCOUNT IS UNDER CONSORITUM / MULTIPLE
				BANKING ARRANGEMENT , WHETHER BANKER'S MEETING CALLED FOR AND IF SO
				DETAILS THEREOF INCLUDING DECISIONS TAKEN</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=pur6%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p><%=Helper.correctNull((String) hash3
									.get("account_details"))%></p>
				</td>
			</tr>

			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top"><b>OUR COMMENTS:</b></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<p>Following points were considered for identifying this account to
				exercise security interest right under Section 13 of the Act.</p>
				</td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3" valign="top">
				<ul>
					<%String npasince = Helper.correctNull((String) hash1
					.get("NPA_SINCE"));
			String suit = Helper.correctNull((String) hash2.get("SUIT_FILED"));
			String suit_date = Helper.correctNull((String) hash2
					.get("SUIT_DATE"));
			if (!suit.equalsIgnoreCase("null")) {
				if (suit.equalsIgnoreCase("y")) {

					%>
					<li>The account is NPA since &nbsp;<%=npasince%> &nbsp;and suit has
					been filed at <%=suit_date%>.</li>

					<%} else {%>

					<li>The account is NPA since &nbsp;<%=npasince%> &nbsp;and suit has
					not been filed as yet.</li>
					<%}
			}

			%>
					<%if (account.equalsIgnoreCase("y")) {%>
					<li>Despite our persuasion directly with the promoter party . There
					are no chances of recovery of balance amount of OTS.</li>
					<%} else {

			%>
					<li>Despite our persuasion directly with the promoter party has not
					come forward for any OTS.</li>
					<%}

			%>
					<li>There are no primary securities either in the form of stocks or
					receivables.</li>

					<%String bifr_acct = Helper.correctNull((String) hash2
					.get("BIFR_ACCT"));
			String bifr_date = Helper.correctNull((String) hash2
					.get("HEARING_DATE"));
			if (!bifr_acct.equalsIgnoreCase("null")) {
				if (bifr_acct.equalsIgnoreCase("y")) {

					%>

					<li>This is a BIFR referred account. Last hearing was held in <%=bifr_date%>
					Bank has requested BIFR for early hearing in order to decide the
					reference made by the Company.</li>
					<%}
			}

			%>

					<li>The fixed assets of the Company are charged to and Bank has no
					charge.</li>

					<li>The documents have been duly vetted and are valid for
					enforcement.</li>
					<%String min_date = Helper.correctNull((String) hash5
					.get("min_certificationdate"));
			if (!min_date.equalsIgnoreCase("null")) {

				%>
					<li>Mortgage is valid upto <%=min_date%></li>
					<%}%>
					<li>The Notice may put the party under pressure and as they are
					reported to have means to settle the bank account, they may respond
					to the Notice by coming forward for negotiations.</li>
				</ul>
				</td>
			</tr>
			<%if (!Helper.formatTextAreaData(
					(String) hshRecommendations.get("BRrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="44%"><b>BRANCH RECOMMENDATION</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>


			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshRecommendations
								.get("BRrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshRecommendations.get("ROrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="44%"><b>REGIONAL OFFICE RECOMMENDATION</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshRecommendations
								.get("ROrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshRecommendations.get("FGMOrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="44%"><b>FGMO RECOMMENDATION</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshRecommendations
								.get("FGMOrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshRecommendations.get("CRLDrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="44%"><b>C.R.L.D., CENTRAL OFFICE RECOMMENDATION</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshRecommendations
								.get("CRLDrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3"><p>Submitted for approval to issue the Notice as per Section 13 of
				the Securitisation for Reconstruction of Financial Asset and
				Enforcement of Securities Interest Act in 2002.</p></td>
			</tr>
			
			<%if (!Helper.correctNull(
					(String) hshSignatories.get("mcmresolution"))
					.equalsIgnoreCase("")) {%>
			<tr>
				<td width="10%">&nbsp;</td>
				<td  align="left" colspan="3"><p><b>MCM Resolution:</b></p>
				<p><b>If approved,</b> the MANAGEMENT COMMITTEE <b>is requested to
				adopt the following resolution: </b></p>
				<p><%=Helper.formatTextAreaData((String) hshSignatories
								.get("mcmresolution"))%></p></td>
			</tr>

			<%}

			%>
			<tr>
				<td valign="top" align="left" colspan="2">&nbsp;<br>
				<br>
				</td>
			</tr>
			
			<%if (!Helper.correctNull(
					(String) hshSignatories.get("commobservations"))
					.equalsIgnoreCase("")) {%>
			<tr>
				<td width="5%">&nbsp;</td>
				<td valign="top" align="left" colspan="3"><b>COMMITTEE'S
				OBSERVATIONS/RECOMMENDATIONS&nbsp;</b></td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td valign="top" colspan="3"><p><%=Helper.correctNull((String) hshSignatories
								.get("commobservations"))%></p></td>
			</tr>
			<%}

			%>
			<tr>
				<td valign="top" align="left" colspan="4"><p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p></td>
			</tr>
			<tr>
				<td width="10%">&nbsp;</td>
				<td valign="top" colspan="3" align="left"><b><%=Helper.correctNull((String) hshValues.get("signatures"))%></b></td>
			</tr>
			
		</table>
		</td>
	</tr>
</table>

</body>
</html>


