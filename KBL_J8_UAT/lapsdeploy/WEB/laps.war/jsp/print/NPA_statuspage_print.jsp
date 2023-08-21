<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			String strCategoryType = "";
			ArrayList vecRow = null;
			ArrayList vecCol = new ArrayList();
			strCategoryType = Helper.correctNull((String) hshValues
					.get("strCategoryType"));
			if (strCategoryType.equals("")) {
				strCategoryType = Helper.correctNull((String) request
						.getParameter("strCategoryType"));
			}

			String strQuater = Helper.correctNull((String) request
					.getParameter("quater"));
			int year = Integer.parseInt(Helper.getCurrentDateTime().substring(
					6, 10));

			if (strQuater.equalsIgnoreCase("1")) {
				strQuater = "31/06/" + year;
			} else if (strQuater.equalsIgnoreCase("2")) {
				strQuater = "30/09/" + year;
			} else if (strQuater.equalsIgnoreCase("3")) {
				strQuater = "31/12/" + year;
			} else if (strQuater.equalsIgnoreCase("4")) {
				strQuater = "31/03/" + (year);
			}

			HashMap hsh1 = null;
			HashMap hsh2 = new HashMap();
			HashMap hsh3 = new HashMap();
			HashMap hsh4 = new HashMap();
			HashMap hsh5 = new HashMap();
			HashMap hsh6 = new HashMap();
			HashMap hsh7 = new HashMap();
			HashMap hsh8 = new HashMap();
			HashMap hsh9 = new HashMap();
			HashMap hsh10 = new HashMap();
			HashMap hsh11 = new HashMap();
			HashMap hsh12 = new HashMap();
			HashMap hsh13 = new HashMap();
			HashMap hsh14 = new HashMap();
			hsh1 = (HashMap) hshValues.get("hsh1");
			hsh2 = (HashMap) hshValues.get("hsh2");
			hsh5 = (HashMap) hshValues.get("hsh5");
			hsh6 = (HashMap) hshValues.get("hsh6");
			hsh3 = (HashMap) hshValues.get("hsh3");
			hsh4 = (HashMap) hshValues.get("hsh4");
			hsh7 = (HashMap) hshValues.get("hsh7");
			hsh8 = (HashMap) hshValues.get("hsh8");
			hsh9 = (HashMap) hshValues.get("hsh9");
			hsh10 = (HashMap) hshValues.get("hsh10");
			hsh11 = (HashMap) hshValues.get("hsh11");
			hsh12 = (HashMap) hshValues.get("hsh12");
			hsh13 = (HashMap) hshValues.get("hsh13");
			hsh14 = (HashMap) hshValues.get("hsh14");

			%>

<%String facprem = Helper.correctNull((String) hsh1
					.get("facpremises"));
			if (facprem.equalsIgnoreCase("0")) {
				facprem = "";
			}
			if (facprem.equalsIgnoreCase("1")) {
				facprem = "Rented";
			}
			if (facprem.equalsIgnoreCase("2")) {
				facprem = "Owned";
			}
			if (facprem.equalsIgnoreCase("3")) {
				facprem = "Leased";
			}

			String sta_bankarrangement = Helper.correctNull((String) hsh1
					.get("bankarrangement"));
			String bankarrange = "";
			if (sta_bankarrangement.equalsIgnoreCase("1")) {
				bankarrange = "Sole";
			} else if (sta_bankarrangement.equalsIgnoreCase("2")) {
				bankarrange = "Consortium";
				arrRow = (ArrayList) hsh11.get("arrRow");
			} else if (sta_bankarrangement.equalsIgnoreCase("3")) {
				bankarrange = "Multiple Banking";
				arrRow = (ArrayList) hsh12.get("arrRow");
			}

			String sta_unit = Helper.correctNull((String) hsh1
					.get("unitstatus"));
			String sta_working = Helper.correctNull((String) hsh1
					.get("unitrunfor"));
			String tempval = "";
			String tempwork = "";
			if (sta_unit.equalsIgnoreCase("1")) {
				tempval = "Working";

			} else if (sta_unit.equalsIgnoreCase("2")) {
				tempval = "Closed";
			}

			if (sta_working.equalsIgnoreCase("1")) {
				tempwork = "Own Account";
			} else if (sta_working.equalsIgnoreCase("2")) {
				tempwork = "Doing Job Work";
			}

			String strCourtname = Helper.correctNull((String) hsh10
					.get("suit_courtname"));

			if (strCourtname.equalsIgnoreCase("1")) {
				strCourtname = "Civil";
			} else if (strCourtname.equalsIgnoreCase("2")) {
				strCourtname = "DRT";
			} else if (strCourtname.equalsIgnoreCase("3")) {
				strCourtname = "Revenue Recovery";
			} else if (strCourtname.equalsIgnoreCase("4")) {
				strCourtname = "High Court";
			} else if (strCourtname.equalsIgnoreCase("5")) {
				strCourtname = "Others";
			}

			%>
<html>
<head>
<title>StatusNote Document</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="80%" border="0" cellspacing="0" cellpadding="5"
	align="center">
	<%-- %>
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="17%"><b>Application No : </b></td>
				<td width="33%"><b><%=(String) request.getParameter("npa_appno")%></b>
				<INPUT type="hidden" name="npa_appno"
					value="<%=(String)request.getParameter("npa_appno")%>" /></td>
				<td width="20%"><b> Application Name : </b></td>
				<td width="30%"><b><%=Helper.decodeAmpersand((String) request
							.getParameter("borrowername"))%></b>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	--%>
	<tr>
		<td align="center" colspan="2"><img
			src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><b><%=Helper.correctNull((String) hsh1.get("strOrgName"))%></b></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><b>CREDIT RECOVERY &amp; LEGAL SERVICES
		DEPARTMENT</b></td>
	</tr>
	<tr>
		<td align="center" colspan="2"><%=Helper.correctNull((String) hshValues.get("branchname"))%>
		<hr />
		</td>
	</tr>

	<tr>
		<td align="left"><b>Ref. No&nbsp;:&nbsp;</b><%=Helper.correctNull((String) request
							.getParameter("npa_appno"))%></td>
		<td align="right"><b>Date&nbsp;:&nbsp;</b><%=strQuater%></td>
	</tr>
	<tr>
		<%String status_note = Helper.correctNull((String) hsh1
					.get("propfor"));
			String strStatus = "";
			if (status_note.equalsIgnoreCase("1")) {
				strStatus = "NPA";
			} else if (status_note.equalsIgnoreCase("2")) {
				strStatus = "PWO";
			}%>
		<td align="center" colspan="2"><b><u>STATUS OF ACCOUNT <%=strStatus%>&nbsp;AS
		ON Quarter ended <%=strQuater%></u></b></td>
	</tr>
	<tr>
		<td colspan="2">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
				<table align="center" width="100%" border="0" cellspacing="5"
					cellpadding="3">
					<tr>
						<td width="5%">&nbsp;</td>
						<td width="43%"><b>Name of the Account</b></td>
						<td width="2%"><b>:</b></td>
						<td width="50%"><%=Helper.decodeAmpersand((String) request
							.getParameter("borrowername"))%></td>
					</tr>
					<tr>
						<td width="5%">&nbsp;</td>
						<td width="43%"><b>Branch</b></td>
						<td width="2%"><b>:</b></td>
						<td width="50%"><%=Helper.correctNull((String) hshValues.get("branchname"))%></td>
					</tr>
					<tr>
						<td width="5%">&nbsp;</td>
						<td width="43%"><b>Region</b></td>
						<td width="2%"><b>:</b></td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("regionname"))%></td>
					</tr>
					<tr>
						<td width="5%">&nbsp;</td>
						<td width="43%"><b>Zone</b></td>
						<td width="2%"><b>:</b></td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("zonalname"))%></td>
					</tr>
					<tr>
						<td width="5%">&nbsp;</td>
						<td valign="top"><b>Registered Office at</b></td>
						<td width="2%" valign="top"><b>:</b></td>
						<td><%=Helper.correctNull((String) hsh1.get("regoffaddr"))%></td>
					</tr>
					<tr>
						<td width="5%" valign="top">&nbsp;</td>
						<td valign="top"><b>Factory Address</b></td>
						<td width="2%" valign="top"><b>:</b></td>
						<td><%=Helper.correctNull((String) hsh1.get("facoffaddr"))%></td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Factory Premises</b></td>
						<td valign="top"><b>:</b></td>
						<td><%=facprem%></td>
					</tr>
					<tr>
						<td valign="top"><b>1.&nbsp;</b></td>
						<td><b>Banking since</b></td>
						<td><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1.get("banksince"))%></td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td><b>Advance since</b></td>
						<td><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1.get("advancesince"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>2.&nbsp;</b></td>
						<td><b>Constitution</b></td>
						<td><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1.get("constitution"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>3.&nbsp;</b></td>
						<td><b>Activity</b></td>
						<td><b>:</b></td>
						<td><%=Helper.correctNull((String) hsh1.get("activity"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>4.&nbsp;</b></td>
						<td valign="top"><b>Name/s of Directors/ Partners/ Proprietor/
						Gurarantor and their means</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td colspan="3">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="tblhead">
								<td rowspan="2" class="tabactive">S.no</td>
								<td rowspan="2" class="tabactive" align="center">TYPE OF
								APPLICANT</td>
								<td rowspan="2" class="tabactive" align="center">NAME OF
								APPLICANT</td>
								<td rowspan="2" class="tabactive" align="center">ACTIVITY</td>
								<td rowspan="2" align="center">PHONE</td>
								<td colspan="2" class="tabactive" align="center">&nbsp;AT THE
								TIME OF RENEWAL</td>
								<td colspan="2" class="tabactive" align="center">&nbsp;PRESENT
								POSITION</td>
							</tr>
							<tr class="tblhead">
								<td width="10%" class="tabactive" align="center">MEANS</td>
								<td width="10%" class="tabactive" align="center">DATE</td>
								<td width="10%" class="tabactive" align="center">MEANS</td>
								<td width="10%" class="tabactive" align="center">DATE</td>
							</tr>
							<%vecRow = (ArrayList) hsh7.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
							<tr bgcolor="">
								<td width="3%" align=center valign="top"><%=(i + 1)%>.&nbsp;</td>

								<td width="10%" valign="top"><%=Helper.correctNull((String) vecCol
											.get(11))%>&nbsp;</td>
								<td width="15%" valign="top"><%=Helper.correctNull((String) vecCol.get(2))%>&nbsp;</td>
								<td width="18%" valign="top"><%=Helper.correctNull((String) vecCol.get(3))%>&nbsp;</td>
								<td width="14%" valign="top">&nbsp;<%=Helper.correctNull((String) vecCol
											.get(10))%></td>
								<td width="10%" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
								<td width="10%" valign="top"><%=Helper.correctNull((String) vecCol.get(5))%>&nbsp;</td>
								<td width="10%" align="right" valign="top">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
								<td width="10%" valign="top"><%=Helper.correctNull((String) vecCol.get(7))%>&nbsp;</td>
							</tr>
							<%}
			}%>
						</table>
						</div>
						</td>
					</tr>
					<tr>
						<td>5.&nbsp;</td>
						<td><b>Banking arrangement</b></td>
						<td><b>:</b></td>
						<td>&nbsp;<%=bankarrange%></td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td colspan="3">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<%if (sta_bankarrangement.equalsIgnoreCase("2")) {%>
							<tr class="tblhead">
								<td align="center">&nbsp;S.No</td>
								<td align="center">&nbsp; Name of the Bank</td>
								<td align="center">&nbsp;Limit Sanctioned</td>
								<td align="center">&nbsp;Sharing Pattern</td>
								<td align="center">&nbsp;Present O/s.,</td>
								<td align="center">&nbsp;Status of A/c.,</td>
							</tr>
							<%if (arrRow != null && arrRow.size() > 0) {

					int size = 0;
					size = arrRow.size();
					for (int i = 0; i < size; i++) {
						arrCol = (ArrayList) arrRow.get(i);
						if (arrCol != null && arrCol.size() > 0) {
							String constatus = Helper
									.correctNull((String) arrCol.get(5));
							if (constatus.equalsIgnoreCase("1")) {
								constatus = "Regular";
							} else if (constatus.equalsIgnoreCase("2")) {
								constatus = "NPA";
							} else if (constatus.equalsIgnoreCase("0")) {
								constatus = "";
							}

							%>
							<tr>
								<td valign="top">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(0))%></td>
								<td valign="top">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
								<td valign="top" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(2))))%></td>
								<td valign="top">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(3))%></td>
								<td valign="top" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(4))))%></td>
								<td valign="top">&nbsp;<%=constatus%></td>
							</tr>
							<%}
					}
				}
			}

			%>

						</table>
						</div>
						</td>
					</tr>
					<%if (sta_bankarrangement.equalsIgnoreCase("3")) {%>
					<tr>
						<td valign="top">&nbsp;</td>
						<td colspan="3">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>&nbsp;S.no</td>
								<td>&nbsp; Name of the Bank</td>
								<td>&nbsp;Limit Sanctioned</td>
								<td>&nbsp;Present O/s.</td>
								<td>&nbsp;Status of A/c.</td>
							</tr>
							<%arrRow = (ArrayList) hsh1.get("arrRow");
				if (arrRow != null && arrRow.size() > 0) {

					%>
							<%int size = 0;
					size = arrRow.size();
					for (int i = 0; i < size; i++) {
						arrCol = (ArrayList) arrRow.get(i);
						if (arrCol != null && arrCol.size() > 0) {
							String constatus = Helper
									.correctNull((String) arrCol.get(4));
							if (constatus.equalsIgnoreCase("1")) {
								constatus = "Regular";
							} else if (constatus.equalsIgnoreCase("2")) {
								constatus = "NPA";
							} else if (constatus.equalsIgnoreCase("0")) {
								constatus = "";
							}

							%>
							<tr>
								<td>&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(0))%></td>
								<td>&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(2))%></td>
								<td>&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(3))))%></td>
								<td>&nbsp;<%=constatus%></td>
							</tr>
							<%}
					}
				}

			%>
						</table>
						</div>
						</td>
					</tr>
					<%}

			%>
					<%arrRow = (ArrayList) hsh13.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				%>
					<tr>
						<td>&nbsp;</td>
						<td><b>Indicate names of Term Lending institutions</b></td>
						<td><b>:</b></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="3">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="tblhead">
								<td>&nbsp;S.no</td>
								<td>&nbsp;Name of the Institution</td>
								<td>&nbsp;Limit Sanctioned</td>
								<td>&nbsp;Outstanding</td>
							</tr>

							<%int size = 0;
				size = arrRow.size();
				for (int i = 0; i < size; i++) {
					arrCol = (ArrayList) arrRow.get(i);
					if (arrCol != null && arrCol.size() > 0) {%>
							<tr>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
								<td>&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%></td>
							</tr>
							<%}
				}

			%>
						</table>
						</div>
						</td>
					</tr>
					<%}%>
					<%arrRow = (ArrayList) hsh14.get("arrRow");
			//System.out.println(arrRow);
			if (arrRow != null && arrRow.size() > 0) {

				%>
					<tr>
						<td>&nbsp;</td>
						<td><b>Details of connected A/c</b></td>
						<td><b>:</b></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="3">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="tblhead">
								<td>&nbsp;S.no</td>
								<td>&nbsp;Name</td>
								<td>&nbsp;Name of the Partners</td>
								<td>&nbsp;Bankers</td>
								<td>&nbsp;Limit Enjoyed</td>
								<td>&nbsp;Status</td>
							</tr>
							<%int size = 0;
				size = arrRow.size();
				for (int i = 0; i < size; i++) {
					arrCol = (ArrayList) arrRow.get(i);
					if (arrCol != null && arrCol.size() > 0) {%>
							<tr>
								<td>&nbsp;<%=(i + 1)%>.</td>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
								<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(6))
										.equals("1") ? "NPA" : "Regular"%></td>
							</tr>
							<%}
				}

			%>
						</table>
						</div>
						</td>
					</tr>
					<%}

			%>
					<tr>
						<td rowspan="3" valign="top"><b>6.&nbsp;</b></td>
						<td rowspan="3" valign="top">
						<p><b>Whether unit is working/closed since when.If working,whether
						own account or doing job work.If closed,borrowers source of
						livelihood.</b></p>
						</td>
						<td rowspan="3" valign="top"><b>:</b></td>
						<td valign="top"><%=tempval%></td>
					</tr>
					<%if (sta_unit.equalsIgnoreCase("1")) {

				%>
					<tr>
						<td><%=tempwork%></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<%} else if (sta_unit.equalsIgnoreCase("2")) {

				%>
					<tr>
						<td>Date : &nbsp;<%=Helper.correctNull((String) hsh1
								.get("unitclosedsince"))%></td>
					</tr>
					<tr>
						<td>Sources of Livelihood :&nbsp;<%=Helper.correctNull((String) hsh1.get("livehoodsrc"))%></td>
					</tr>
					<%}else{%>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<%} %>
					<tr>
						<td valign="top"><b>7.1.&nbsp;</b></td>
						<td valign="top"><b>NPA since</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull((String) hsh1.get("npasince"))%>
						</td>
					</tr>
					<tr>
						<td><b>7.2.&nbsp;</b></td>
						<td valign="top"><b>Present Asset Classification</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull((String) hsh1
							.get("presentclassification"))%></td>
					</tr>
					<tr>

						<td><b>7.3.&nbsp;</b></td>
						<td valign="top"><b>Provision held &nbsp;</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1.get("provision"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>8.1.&nbsp;</b></td>
						<td valign="top"><b>Date of last review</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull((String) hsh1
									.get("lastrevdate"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>8.2.&nbsp;</b></td>
						<td valign="top"><b>Last reviewed by</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull((String) hsh1
									.get("sta_lastreviewby"))%></td>
					</tr>
					<tr>
						<td><b>8.2.a.&nbsp;</b></td>
						<td><b>Designation</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1.get("sta_design"))%></td>
					</tr>
					<tr>
						<td><b>8.2.b.&nbsp;</b></td>
						<td><b>&nbsp;Scale</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1.get("sta_scale"))%></td>
					</tr>
					<tr>
						<td><b>8.3.&nbsp;</b></td>
						<td><b>Last financial statement held on record</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1
							.get("sta_lastfinancedate"))%></td>
					</tr>

					<tr>
						<td valign="top"><b>9.1.&nbsp;</b></td>
						<td valign="top"><b>Date since A/c., is in excess</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh1.get("sta_excessdate"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>9.2.&nbsp;</b></td>
						<td><b>Maximum excess allowed</b></td>
						<td valign="top"><b>:</b></td>
						<td colspan="4">&nbsp;<%=Helper.correctNull((String) hsh1
							.get("sta_maxexcessallowed"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>9.3.&nbsp;</b></td>
						<td><b>Steps taken for adjustment.</b></td>
						<td valign="top"><b>:</b></td>
						<td colspan="4">&nbsp;<%=Helper.correctNull((String) hsh1.get("sta_stepstaken"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>10.&nbsp;</b></td>
						<td valign="top"><b>Whether the account was classified as 'EAS /
						SMA' category</b></td>
						<td valign="top"><b>:</b></td>
						<%String ACCOUNT_CLASSIFIED = Helper.correctNull((String) hsh2
					.get("ACCOUNT_CLASSIFIED"));
			String account = "";
			if (ACCOUNT_CLASSIFIED.equalsIgnoreCase("1")) {
				account = "EAS1";
			} else if (ACCOUNT_CLASSIFIED.equalsIgnoreCase("2")) {
				account = "EAS2";
			} else if (ACCOUNT_CLASSIFIED.equalsIgnoreCase("3")) {
				account = "SMA";
			} else if (ACCOUNT_CLASSIFIED.equalsIgnoreCase("4")) {
				account = "NO";
			}

			%>
						<td>&nbsp;<%=account%></td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top">
						<p><b>Reasons for classifiying A/c. as 'EAS/ SMA' category, such
						as overdues, turnover below projected sales, non- submission of
						statements /DBC , sanction stipulation not complied / audit
						irregularites not rectified, continuous losses etc. and efforts
						made to upgrade the same.</b></p>
						</td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="3">
						<p><%=Helper.formatTextAreaData((String) hsh2
							.get("ACCOUNT_CLASSIFIED_REASON"))%></p>
						</td>
					</tr>
					<tr>
						<td valign="top"><b>11. a.&nbsp;</b></td>
						<td valign="top">
						<p><b>Whether account placed under nursing/rehabilitation. if not,
						whether rehabilitation likely to improve status of account. It
						yes, whether the account suffers from any previous history of
						serious material irregularity, diversion of funds, non-viability
						or fraud.</b></p>
						</td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull(
							(String) hsh2.get("ACCOUNT_PLACEDUNDER"))
							.equalsIgnoreCase("1") ? "YES" : Helper
					.correctNull((String) hsh2.get("ACCOUNT_PLACEDUNDER"))
					.equalsIgnoreCase("2") ? "NO" : ""%></td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top" colspan="3">
						<p><%=Helper.formatTextAreaData((String) hsh2
							.get("ACCOUNT_PLACEDUNDER_REASON"))%></p>
						</td>
					</tr>
					<!--ots starts -->

					<%String isotsapprove = Helper.correctNull((String) hsh8
					.get("sta_ots"));
			String WhetherOTS = Helper.correctNull((String) hsh8
					.get("sta_otspossible"));

			%>
					<%if (isotsapprove.equals("0")) {%>
					<tr>
						<td><b>11.b.&nbsp;</b></td>
						<td><b>Is OTS approved</b></td>
						<td><b>:</b></td>
						<td>&nbsp;</td>
					</tr>
					<%}%>
					<%if (isotsapprove.equals("1")) {%>
					<tr>
						<td><b>11.b.&nbsp;</b></td>
						<td><b>Is OTS approved</b></td>
						<td><b>:</b></td>
						<td>Yes</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><b>Date of Sanction</b></td>
						<td><b>:</b></td>
						<td><%=Helper.correctNull((String) hsh8
								.get("sta_sanctiondate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><b>Sanctioning Authority</b></td>
						<td><b>:</b></td>
						<td><%=Helper.correctNull((String) hsh8
								.get("sta_sanctionauth"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>O/s. in R/L including PWO amount if any at the
						time of settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_pwoamount"))))%></td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td><b>O/s. in D/L at the time of settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_dummyamount"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td><b>Legal Charges at the time of settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_legalcharge"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td><b>Total Dues at the time of settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_totaldues"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Claim Settled amount at the time of settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_claimamount"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Settlement Amount Approved at the time of
						settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_settleamount"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Write-off sanctioned at the time of settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_writeoff"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Waiver sanctioned at the time of settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double
								.parseDouble(Helper.correctDouble((String) hsh8
										.get("sta_waiver"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Absorption of Expenditure at the time of
						settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_absortion"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Total Relief sanctioned at the time os
						settlement</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_totalrelief"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Recovery effected after sanction</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_recoveryeffect"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Balance Recovery</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_balanceeffect"))))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
						<td valign="top"><b>Overdue Recovery</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh8
										.get("sta_overdues"))))%>&nbsp;</td>
					</tr>
					<%}%>
					<%if ((isotsapprove.equals("2")) && (WhetherOTS.equals("0"))) {

			%>
					<tr>
						<td valign="top"><b>11.b.&nbsp;</b></td>
						<td valign="top"><b>Is OTS approved</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<%}%>
					<%if ((isotsapprove.equals("2")) && (WhetherOTS.equals("1"))) {

				%>
					<tr>
						<td valign="top"><b>11.b.&nbsp;</b></td>
						<td valign="top"><b>Is OTS approved</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether OTS possible?</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Give Details</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">
						<p><%=Helper.formatTextAreaData((String) hsh8
								.get("sta_details"))%>&nbsp;</p>
						</td>
					</tr>
					<%}%>
					<%if ((isotsapprove.equals("2")) && (WhetherOTS.equals("2"))) {

				%>
					<tr>
						<td valign="top"><b>11.b.&nbsp;</b></td>
						<td width="47%"><b>Is OTS approved</b></td>
						<td valign="top"><b>:</b></td>
						<td width="49%">No</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether OTS possible?</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Give measures suggetsed for resolving</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">
						<p><%=Helper.formatTextAreaData((String) hsh8
								.get("sta_measures"))%>&nbsp;</p>
						</td>
					</tr>
					<%}%>

					<!--end ots  -->
					<tr>
						<td valign="top"><b>12.&nbsp;</b></td>
						<td valign="top"><b>Position of ECGC claim / ROD lodged</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td colspan="3">
						<p><%=Helper.correctNull((String) hsh2.get("ECGC_POSITION"))%>&nbsp;</p>
						</td>
					</tr>
					<%String BIFR_ACCOUNT = Helper.correctNull((String) hsh2
					.get("BIFR_ACCOUNT"));
			String bifr = "";
			if (BIFR_ACCOUNT.equalsIgnoreCase("1")) {
				bifr = "YES";
			} else if (BIFR_ACCOUNT.equalsIgnoreCase("2")) {
				bifr = "NO";
			}

			%>
					<tr>
						<td valign="top"><b>13.&nbsp;</b></td>
						<td><b>Whether account is referred to BIFR. if yes reference nos.
						&amp; date</b></td>
						<td valign="top"><b>:</b></td>
						<td><%=bifr%></td>
					</tr>
					<%if (BIFR_ACCOUNT.equalsIgnoreCase("1")) {

				%>
					<tr>
						<td>&nbsp;</td>
						<td colspan="3">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">

							<%arrRow = (ArrayList) hsh2.get("arrRow");
				if (arrRow != null && arrRow.size() > 0) {

					%>
							<tr class="tblhead">
								<td align="center"><b>&nbsp;S.no</b></td>
								<td align="center"><b>Reference No.</b></td>
								<td align="center"><b>Reference Date</b></td>
								<td align="center"><b>Hearing Status</b></td>
							</tr>
							<%int size = 0;
					size = arrRow.size();
					for (int i = 0; i < size; i++) {
						arrCol = (ArrayList) arrRow.get(i);
						if (arrCol != null && arrCol.size() > 0) {
							String sta = Helper.correctNull((String) arrCol
									.get(3));
							String staStatus = "";
							if (sta.equalsIgnoreCase("1")) {
								staStatus = "Regular";
							} else if (sta.equalsIgnoreCase("2")) {
								staStatus = "NPA";
							} else {
								staStatus = "";
							}

							%>
							<tr>
								<td valign="top">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(0))%>.</td>
								<td valign="top"><%=Helper
													.correctNull((String) arrCol
															.get(1))%>&nbsp;</td>
								<td valign="top"><%=Helper
													.correctNull((String) arrCol
															.get(2))%>&nbsp;</td>
								<td valign="top"><%=Helper
													.correctNull((String) arrCol
															.get(3))%>&nbsp;</td>
							</tr>
							<%}
					}
				}%>
						</table>
						</div>
						</td>
					</tr>
					<%}

			%>
					<%String TAKEOVER_ACCOUNT = Helper.correctNull((String) hsh2
					.get("TAKEOVER_ACCOUNT"));
			String takeover = "";
			if (TAKEOVER_ACCOUNT.equalsIgnoreCase("1")) {
				takeover = "YES";
			} else if (TAKEOVER_ACCOUNT.equalsIgnoreCase("2")) {
				takeover = "NO";
			}

			%>
					<tr>
						<td valign="top"><b>14.&nbsp;</b></td>
						<td valign="top"><b>Whether account is a take-over account. if
						yes, give bank from whom taken over</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=takeover%> - <%=Helper.correctNull((String) hsh2.get("TAKEOVER_BANK"))%></td>
					</tr>
					<%String GUARANTEE = Helper.correctNull((String) hsh2
					.get("GUARANTEE"));
			String guarant = "";
			if (GUARANTEE.equalsIgnoreCase("1")) {
				guarant = "YES";
			} else if (GUARANTEE.equalsIgnoreCase("2")) {
				guarant = "NO";
			}

			%>
					<tr>
						<td valign="top"><b>15.&nbsp;</b></td>
						<td valign="top"><b>Whether State/Central government guarantee is
						avilable</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=guarant%></td>
					</tr>
					<%if (GUARANTEE.equalsIgnoreCase("1")) {

				%>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Particulars of Guarantee</b></td>
						<td valign="top"><b>:</b></td>
						<td>
						<p><%=Helper.correctNull((String) hsh2
								.get("PARTICULAR_GUARANTEE"))%>&nbsp;</p>
						</td>
					</tr>
					<%}

			%>
					<%String FRAUD_ACCOUNT = Helper.correctNull((String) hsh2
					.get("FRAUD_ACCOUNT"));
			String fraud = "";

			if (FRAUD_ACCOUNT.equalsIgnoreCase("1")) {
				fraud = "YES";
			} else if (FRAUD_ACCOUNT.equalsIgnoreCase("2")) {
				fraud = "NO";
			}

			%>
					<tr>
						<td valign="top"><b>16.&nbsp;</b></td>
						<td valign="top"><b>Whether account is reported as Fraud</b></td>
						<td valign="top"><b>:</b></td>
						<td width="12%">&nbsp;<%=fraud%></td>
					</tr>
					<%if (FRAUD_ACCOUNT.equalsIgnoreCase("1")) {

				%>
					<tr>
						<td>&nbsp;</td>
						<td valign="top"><b>Date in which account is reported as fraud</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh2
								.get("FRAUD_ACCOUNTDATE"))%>&nbsp;</td>
					</tr>
					<%}

			%>

					<%String TERMS_SANCTION = Helper.correctNull((String) hsh2
					.get("TERMS_SANCTION"));
			String term = "";
			if (TERMS_SANCTION.equalsIgnoreCase("1")) {
				term = "YES";
			} else if (TERMS_SANCTION.equalsIgnoreCase("2")) {
				term = "NO";
			}

			%>
					<tr>
						<td valign="top"><b>17. a.&nbsp;</b></td>
						<td valign="top"><b>Whether all terms of sanction complied with.</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=term%></td>
					</tr>
					<%if (TERMS_SANCTION.equalsIgnoreCase("2")) {%>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Terms of Sanction not Complied</b></td>
						<td valign="top" colspan="2"><b>:</b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="3" valign="top">
						<p><%=Helper.formatTextAreaData((String) hsh2
								.get("TERMS_SANCTION_NOT_COMPLIED"))%>&nbsp;</p>
						</td>
					</tr>
					<%}

			%>

					<tr>
						<td valign="top"><b>17. b.&nbsp;</b></td>
						<td valign="top"><b>Date of latest doc</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull((String) hsh2.get("LATEST_DOCDATE"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>17. c.&nbsp;</b></td>
						<td valign="top"><b>Date of DBC</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh2.get("DBC_DATE"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>17. d.&nbsp;</b></td>
						<td valign="top">
						<p><b>Whether documents are vetted by Advocates</b></p>
						</td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull(
							(String) hsh2.get("VETTED_BY_ADVOCATES"))
							.equalsIgnoreCase("1") ? "Yes" : Helper
					.correctNull((String) hsh2.get("VETTED_BY_ADVOCATES"))
					.equalsIgnoreCase("2") ? "No" : ""%></td>
					</tr>
					<%if (Helper.correctNull((String) hsh2.get("VETTED_BY_ADVOCATES"))
					.equalsIgnoreCase("1")) {

				%>
					<tr>
						<td valign="top" align="right"><b>(i)&nbsp;</b></td>
						<td><b>Date of certificate</b></td>
						<td valign="top"><b>:</b></td>
						<td colspan="4">&nbsp;<%=Helper.correctNull((String) hsh2.get("VETTEDDATE"))%></td>
					</tr>
					<%String VETTED_BY_ADVOCATES = Helper.correctNull((String) hsh2
						.get("VETTED_BY_ADVOCATES"));
				String advocate = "";
				if (VETTED_BY_ADVOCATES.equalsIgnoreCase("1")) {
					advocate = "Advocate";
				} else if (VETTED_BY_ADVOCATES.equalsIgnoreCase("2")) {
					advocate = "Bank Official";
				}%>
					<tr>
						<td valign="top" align="right"><b>(ii)&nbsp;</b></td>
						<td valign="top"><b>Vetting Authority</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=advocate%> - <%=Helper.correctNull((String) hsh2
								.get("ADVOCATES_NAME"))%></td>
					</tr>
					<tr>
						<td valign="top" align="right"><b>(iii)&nbsp;</b></td>
						<td valign="top"><b>Discrepancies</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.correctNull((String) hsh2
										.get("DISCREPANCIES"))%></td>
					</tr>
					<%}

			%>
					<%String suit_decreed = Helper.correctNull((String) hsh10
					.get("suit_decreed"));
			String suit_olappointed = Helper.correctNull((String) hsh10
					.get("suit_olappointed"));
			if (suit_decreed.equals("2")) {

				%>

					<tr>
						<td valign="top"><b>18.&nbsp;</b></td>
						<td valign="top"><b>Whether suit filed/decreed?</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Why not suit filed / decreed?</b></td>
						<td valign="top"><b>:</b></td>
						<td width="49%"><%=Helper.correctNull((String) hsh10
								.get("suit_noreason"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>What under process etc should be given.</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
										.get("suit_process"))%></td>
					</tr>
					<%} else if (suit_decreed.equals("1")) {%>
					<tr>
						<td valign="top"><b>18.&nbsp;</b></td>
						<td valign="top"><b>Whether suit filed / decreed?</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Sectoral Category of Advance</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_sectoralcat"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td colspan="3">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top" width="20%"><b>Amount of suit</b></td>
								<td valign="top" width="30%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh10
										.get("suit_amount"))))%>&nbsp;</td>
								<td valign="top" width="20%"><b>Name of Court</b></td>
								<td valign="top" width="30%"><%=strCourtname%>&nbsp;</td>
							</tr>
							<tr>
								<td valign="top"><b>Suit No</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10.get("suit_no"))%>&nbsp;</td>
								<td valign="top"><b>Suit Date</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10.get("suit_date"))%>&nbsp;</td>
							</tr>
							<tr>
								<td valign="top"><b>Running Ledger O/s.</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
										.get("siut_running"))%>&nbsp;</td>
								<td valign="top"><b>Dummy Ledger O/s.</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("siut_outstanding"))%>&nbsp;</td>
							</tr>
							<tr>
								<td valign="top"><b>Value of Security on the date of advance</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("siut_securityvalueadvance"))%>&nbsp;</td>
								<td valign="top"><b>Present Market Value</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("siut_presentmarketvalue"))%>&nbsp;</td>
							</tr>
							<tr>
								<td valign="top"><b>Date of Valuation for present market value</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_dateofvaluation"))%>&nbsp;</td>
								<td valign="top"><b>Recovery during the current half year</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_recoveryhalf"))%>&nbsp;</td>

							</tr>
							<tr>
								<td valign="top"><b>Total recovery till date</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_totalrecovery"))%>&nbsp;</td>
								<td valign="top"><b>Date of Decree</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_dateofdecree"))%>&nbsp;</td>
							</tr>
							<tr>
								<td valign="top"><b>Decree Amount</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("decree_amount"))%>&nbsp;</td>
								<td valign="top"><b>Date of filing EP</b></td>
								<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_dateoffilling"))%>&nbsp;</td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Name of Advocate</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_advocatename"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Address</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
										.get("suit_address"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Phone no.</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
										.get("suit_phoneno"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Present position of suit</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_presentposition"))%>&nbsp;</td>
					</tr>
					<%if (suit_olappointed.equals("1")) {%>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether OL appointed</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Status of Sale of Assets</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
									.get("suit_saleofstatus"))%>&nbsp;</td>
					</tr>
					<%} else if (suit_olappointed.equals("2")) {%>

					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether OL appointed</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No&nbsp;</td>
					</tr>
					<%}

				%>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Facility</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_facility"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Details of legal proceedings by other secured
						creditors/unsecured creditors/workers</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_legalproceeding"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Details of any counter claim ny the borrower</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_counterclaim"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Details of third party liability</b></td>
						<td valign="top" colspan="2"><b>&nbsp;</b></td>
					</tr>
					<tr>
						<td valign="top" align="right"><b>a.&nbsp;</b></td>
						<td valign="top"><b>Worker's Compensation</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_workercompensation"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top" align="right"><b>b.&nbsp;</b></td>
						<td valign="top"><b>Statutory Liabilities</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_Statliabilities"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top" align="right"><b>c.&nbsp;</b></td>
						<td valign="top"><b>Contingent Liabilities</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_Contiliabilities"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top" align="right"><b>d.&nbsp;</b></td>
						<td valign="top"><b>Others</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
										.get("suit_Others"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Details of pending criminal complaints</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_pendingcriminal"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Any attachment/decree against any of the
						primary / collateral security obtained by any of the
						authorities/lenders</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh10
								.get("suit_attachment"))%>&nbsp;</td>
					</tr>
					<%} else if (suit_decreed.equals("0")) {%>

					<tr>
						<td valign="top"><b>18. &nbsp;</b></td>
						<td valign="top"><b>Whether suit filed/decreed?</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;</td>
					</tr>
					<%}%>
					<%String sta_undersarfaesia = Helper.correctNull((String) hsh9
					.get("sta_undersarfaesia"));
			String sta_positionnotice = Helper.correctNull((String) hsh9
					.get("sta_positionnotice"));
			String sta_positiontaken = Helper.correctNull((String) hsh9
					.get("sta_positiontaken"));
			String sta_approached = Helper.correctNull((String) hsh9
					.get("sta_approached"));

			arrRow = new ArrayList();
			arrCol = new ArrayList();

			%>

					<%if (sta_undersarfaesia.equals("0")) {%>
					<tr>
						<td valign="top"><b>19.&nbsp;</b></td>
						<td valign="top"><b>Action Under sarfaesia</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"></td>
					</tr>
					<%} else if (sta_undersarfaesia.equals("2")) {%>
					<tr>
						<td valign="top"><b>19.&nbsp;</b></td>
						<td valign="top"><b>Action Under sarfaesia</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<%} else if ((sta_undersarfaesia.equals("1"))
					&& (sta_positionnotice.equals("0"))) {%>
					<tr>
						<td valign="top"><b>19.&nbsp;</b></td>
						<td valign="top"><b>Action Under sarfaesia</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of Demand notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_demandnoticedate"))%>&nbsp;</td>
					</tr>
					<%} else if ((sta_undersarfaesia.equals("1"))
					&& (sta_positionnotice.equals("2"))) {%>
					<tr>
						<td valign="top"><b>19.&nbsp;</b></td>
						<td valign="top"><b>Action Under sarfaesia</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of Demand notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_demandnoticedate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether possession Notice given</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Reasons for not issuing possession notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) hsh9
								.get("sta_notpositionreason"))%>&nbsp;</td>
					</tr>
					<%} else if ((sta_undersarfaesia.equals("1"))
					&& (sta_positionnotice.equals("1"))
					&& (sta_positiontaken.equals("0"))) {%>
					<tr>
						<td valign="top"><b>19.&nbsp;</b></td>
						<td valign="top"><b>Action Under sarfaesia</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of Demand notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_demandnoticedate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether possession Notice given</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of possession Notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_positionnoticedate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether Possession taken</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><b>&nbsp;</b></td>
					</tr>
					<%} else if ((sta_undersarfaesia.equals("1"))
					&& (sta_positionnotice.equals("1"))
					&& (sta_positiontaken.equals("2"))) {%>
					<tr>
						<td valign="top"><b>19.&nbsp;</b></td>
						<td valign="top"><b>Action Under sarfaesia</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of Demand notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_demandnoticedate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether possession Notice given</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of possession Notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_positionnoticedate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether Possession taken</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether DM / CMM approached</b></td>
						<td valign="top"><b>:</b></td>
						<%if ((sta_approached.equals("2"))) {

					%>
						<td valign="top">No</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Reasons for not taking possession</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) hsh9
									.get("sta_nottakingposition"))%>&nbsp;</td>
						<%} else if ((sta_approached.equals("1"))) {%>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Details of status of application</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.formatTextAreaData((String) hsh9
									.get("sta_detailsofapplication"))%>&nbsp;</td>
						<%} else {%>
						<td valign="top">&nbsp;</td>
						<%}

			%>
					</tr>
					<%} else if ((sta_undersarfaesia.equals("1"))
					&& (sta_positionnotice.equals("1"))
					&& (sta_positiontaken.equals("1"))) {%>
					<tr>
						<td valign="top"><b>19.&nbsp;</b></td>
						<td valign="top"><b>Action Under sarfaesia</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of Demand notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_demandnoticedate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether possession Notice given</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Date of possession Notice</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top"><%=Helper.correctNull((String) hsh9
								.get("sta_positionnoticedate"))%>&nbsp;</td>
					</tr>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Whether Possession taken</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td colspan="4">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr class="tblhead">
								<td rowspan="2" width="23%">Nature of Security</td>
								<td colspan="2" align="center">Present Position</td>
								<td rowspan="2" width="11%">Date of Sale Notice</td>
								<td rowspan="2" width="11%">Date of Auction</td>
								<td rowspan="2" width="11%">Sale Amount</td>
								<td rowspan="2" width="11%">Date of Sale Confirmation</td>
								<td rowspan="2" width="11%">Date sale amount appropriated to
								account</td>
							</tr>
							<tr class="tblhead">
								<td width="11%">Valuation Date</td>
								<td width="11%">Valuation Amount</td>
							</tr>
							<!--iframe start-->
							<%arrRow = (ArrayList) hsh9.get("arrRow");
				if (arrRow != null && arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);
						if (arrCol != null && arrCol.size() > 0) {%>
							<tr>
								<td><%=Helper
													.correctNull((String) arrCol
															.get(0))%></td>
								<td><%=Helper
													.correctNull((String) arrCol
															.get(1))%>&nbsp;</td>
								<td align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(2))))%></td>
								<td><%=Helper
													.correctNull((String) arrCol
															.get(3))%>&nbsp;</td>
								<td><%=Helper
													.correctNull((String) arrCol
															.get(4))%>&nbsp;</td>
								<td align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(5))))%></td>
								<td><%=Helper
													.correctNull((String) arrCol
															.get(6))%>&nbsp;</td>
								<td><%=Helper
													.correctNull((String) arrCol
															.get(7))%>&nbsp;</td>
							</tr>
							<%}
					}
				}

			%>
						</table>
						</div>
						</td>
					</tr>
					<%}%>
					<%String AGENT_APPOINTED = Helper.correctNull((String) hsh2
					.get("AGENT_APPOINTED"));
			String agent = "";
			if (AGENT_APPOINTED.equalsIgnoreCase("1")) {
				agent = "YES";
			} else if (AGENT_APPOINTED.equalsIgnoreCase("2")) {
				agent = "NO";
			}

			%>
					<tr>
						<td valign="top"><b>20.&nbsp;</b></td>
						<td valign="top"><b>Whether any agent appointed</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=agent%></td>
					</tr>
					<%if (agent.equalsIgnoreCase("YES")) {%>
					<tr>
						<td valign="top"><b>&nbsp;</b></td>
						<td valign="top"><b>Details of appointment and present status</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.formatTextAreaData((String) hsh2
								.get("AGENT_REASON"))%></td>
					</tr>
					<%}

			%>
					<%if (status_note.equalsIgnoreCase("1")) {%>
					<tr>
						<td valign="top"><b>21.&nbsp;</b></td>
						<td valign="top"><b>Whether prudentially written off account?</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">No</td>
					</tr>
					<%} else if (status_note.equalsIgnoreCase("2")) {

				%>
					<tr>
						<td valign="top"><b>21.&nbsp;</b></td>
						<td valign="top"><b>Whether prudentially written off account?</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">Yes</td>
					</tr>
					<tr>
						<td valign="top"><b>21.a.&nbsp;</b></td>
						<td valign="top"><b>Amount Written Off</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh2.get("pwo_amt"))))%></td>
					</tr>
					<tr>
						<td valign="top"><b>21.b.&nbsp;</b></td>
						<td valign="top"><b>Date of Written Off</b></td>
						<td valign="top"><b>:</b></td>
						<td>&nbsp;<%=Helper.correctNull((String) hsh2.get("pwo_date"))%></td>
					</tr>
					<tr>
						<td valign="top"><b>21.c.&nbsp;</b></td>
						<td valign="top"><b>Recovery after Write Off</b></td>
						<td valign="top"><b>:</b></td>
						<td valign="top">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh2
										.get("pwo_recovery"))))%></td>
					</tr>
					<%}

			%>
			</table>
		</td>
		</tr>
		</table>
		</td>
		</tr>
		<tr>
		<td colspan="2">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="4"><b><U>PRESENT POSITION OF ACCOUNT :</U></b></td>
					</tr>
					<tr>
						<td colspan="4">
						<div id="top">
						<table width="70%" border="0" cellspacing="0" cellpadding="0">
							<tr class="tblhead">
								<td>Nature of limit</td>
								<td>Amount</td>
								<td>Running ledger o/s.</td>
								<td>Amount pruden tially written off,if any</td>
								<td>ECGC / DICGC / CGFT claim appro priated</td>
								<td>Sub- total</td>
								<td>Unreco vered int</td>
								<td>Net dues</td>
								<td>Dummy ledger int amount</td>
								<td>Legal / other exp</td>
								<td>Total dues</td>
							<tr>
								<%vecRow = (ArrayList) hsh3.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				double dbltotaldues = 0.0;
				double dbllegal = 0.0;
				double dbldummy = 0.0;
				double dblunrecover = 0.0;
				double dblsubtotal = 0.0;
				double dblecgc = 0.0;
				double dblprodent = 0.0;
				double dblrunning = 0.0;
				double dblamount = 0.0;

				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					dblamount = dblamount
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(2)));
					dblrunning = dblrunning
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(3)));
					dblprodent = dblprodent
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(4)));
					dblecgc = dblecgc
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(5)));
					dblsubtotal = dblsubtotal
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(6)));
					dblunrecover = dblunrecover
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(7)));
					dbldummy = dbldummy
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(11)));
					dbllegal = dbllegal
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(12)));
					dbltotaldues = dbltotaldues
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(13)));

					%>
							<tr>
								<td><b><%=Helper.correctNull((String) vecCol.get(1))%></b></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(2))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(3))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(5))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(7))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(8))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(11))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(12))))%></td>
								<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(13))))%></td>
							</tr>
							<%}
			}

			%>
						</table>
						</div>
						</td>
					<tr>
					<tr>
						<td colspan="4">If development of Lc/invocation of gtee., give
						details such as name of drawee/beneficiary, margin held and
						whether credited or not.</td>
					</tr>
					<tr>
						<td colspan="4"><b>PRESENT POSITION OF SECURITIES</b></td>
					</tr>
					<tr>
						<td colspan="4">
						<div id="top">
						<table width="96%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td rowspan="2">SNO</td>
								<td rowspan="2">TYPE OF SECURITY</td>
								<td rowspan="2">NATURE</td>
								<td colspan="2" align="center">AT THE TIME OF RENEWAL</td>
								<td colspan="4" align="center">PRESENT POSITION</td>
							</tr>
							<tr>
								<td width="12%">VALUATION DATE</td>
								<td width="12%">VALUATION AMOUNT</td>
								<td width="12%">VALUATION DATE</td>
								<td width="12%">VALUATION AMOUNT</td>
								<td width="14%">INSPECTION DATE</td>
								<td width="14%" align="center">INSPECTED BY</td>
							</tr>
							<%vecRow = (ArrayList) hsh4.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					String security = Helper.correctNull((String) vecCol
							.get(1));
					if (security.equalsIgnoreCase("p")) {
						security = "PRIMARY";
					} else if (security.equalsIgnoreCase("c")) {
						security = "COLLATERAL";
					}

					%>
							<tr>
								<td width="4%">&nbsp;<%=i + 1%></td>
								<td width="9%">&nbsp;<%=security%></td>
								<td width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
								<td width="12%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
								<td width="12%">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
								<td width="12%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
								<td width="12%">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
								<td width="14%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
								<td width="14%">&nbsp;<%=Helper.correctNull((String) vecCol.get(8))%></td>
							</tr>
							<%}
			}%>
						</table>
						</div>
						</td>
					</tr>
					<tr>
						<td colspan="4">
						<ul>
							<li>In case of stock/book-debt, specify realisable value.</li>
							<li>Land/bldg., P&amp;M, house propertt, size, Plot No.,
							constructed area, age of bldg., location, ownership,
							marketability &amp; realisable value, valuation &amp; date.</li>
						</ul>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="4"><b>BRIEF HISTORY</b></td>
					</tr>
					<tr>
						<!-- <td valign="top">&nbsp;</td> -->
						<td valign="top" colspan="4">
						<p><%=Helper.formatTextAreaData((String) hsh5
							.get("briefhistory"))%></p>
						</td>

					</tr>
					<tr>
						<td valign="top" colspan="4"><b>REASONS FOR ACCOUNT TURNING
						IRREGULAR</b></td>
					</tr>
					<tr>
						<td valign="top" colspan="4">
						<p>(The Reason should be business related like diversion of
						funds,non-viability of venture, lack of demand, competition,
						fradulent activities etc and merely interest not serviced,
						installments not paid etc.)</p>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="4">
						<p><%=Helper.formatTextAreaData((String) hsh5
							.get("irregularreasons"))%></p>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="4"><b>STAFF ACCOUNTABILITY</b></td>
					</tr>
					<tr>
						<td valign="top" colspan="4">
						<p>(Specify date examined and sent to Reviewing Authority also. If
						no accountability is fixed, the basis on which the decision was
						arrived at to be reported.)</p>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="4">
						<p><%=Helper.formatTextAreaData((String) hsh5
							.get("staffaccountability"))%></p>
						</td>
					</tr>
					<tr>
						<td valign="top" colspan="4"><b>AUDIT OBSERVATIONS: (in brief)</b></td>
					</tr>
					<%arrRow = (ArrayList) hsh6.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				%>
					<%int size = 0;
				size = arrRow.size();
				for (int i = 0; i < size; i++) {
					arrCol = (ArrayList) arrRow.get(i);
					String type = Helper.correctNull((String) arrCol.get(3));
					if (type.equalsIgnoreCase("1")) {%>
					<tr>
						<td valign="top" colspan="4"><b>Internal Audit</b></td>
					</tr>
					<tr>
						<td valign="top" colspan="4"><b>Date of Report : </b><%=Helper.correctNull((String) arrCol.get(2))%></td>
					</tr>
					<tr>
						<td valign="top" colspan="4">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="47%" align="center">OBSERVATIONS</td>
								<td width="49%" align="center">COMPLAINCE</td>
							</tr>
							<tr>
								<td width="47%">&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
								<td width="49%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
					<%}
				}
			}%>
					<%arrRow = (ArrayList) hsh6.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				%>
					<%int size = 0;
				size = arrRow.size();
				for (int i = 0; i < size; i++) {
					arrCol = (ArrayList) arrRow.get(i);
					String type = Helper.correctNull((String) arrCol.get(3));
					if (type.equalsIgnoreCase("2")) {%>
					<tr>
						<td valign="top" colspan="4"><b>Concurrent Audit</b></td>
					</tr>
					<tr>
						<td valign="top" colspan="4"><b>Date of Report : </b><%=Helper.correctNull((String) arrCol.get(2))%></td>
					</tr>
					<tr>
						<td valign="top" colspan="4">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="47%" align="center">OBSERVATIONS</td>
								<td width="49%" align="center">COMPLAINCE</td>
							</tr>
							<tr>
								<td width="47%">&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
								<td width="49%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
					<%}
				}
			}%>
					<%arrRow = (ArrayList) hsh6.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				%>
					<%int size = 0;
				size = arrRow.size();
				for (int i = 0; i < size; i++) {
					arrCol = (ArrayList) arrRow.get(i);
					String type = Helper.correctNull((String) arrCol.get(3));
					if (type.equalsIgnoreCase("3")) {%>
					<tr>
						<td valign="top" colspan="4"><b>Statutory/RBI Audit</b></td>
					</tr>
					<tr>
						<td valign="top" colspan="4"><b>Date of Report : </b><%=Helper.correctNull((String) arrCol.get(2))%></td>
					</tr>
					<tr>
						<td valign="top" colspan="4">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="47%" align="center">OBSERVATIONS</td>
								<td width="49%" align="center">COMPLAINCE</td>
							</tr>
							<tr>
								<td width="47%">&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
								<td width="49%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
							</tr>
						</table>
						</div>
						</td>
					</tr>
					<%}
				}
			}%>
					<tr>
						<td colspan="4"><u><b>ACTION PLAN/PRESENT POSITION/REMARKS:</b></u></td>
					</tr>
					<tr>
						<td colspan="4">
						<p><i>Please ensure that the progress with respect to following
						points viz. (a) Suit at DRT against the Co. (b) BIFR hearing (c)
						Action under 'SARFAESI' Act (d) Whether recovery/enforcement
						agents etc are appointed (e) Consortium meeting details (f)
						Recovery prospects and action planned etc. are included.</i></p>
						</td>
					</tr>
					<tr>
						<td colspan="4">
						<p><%=Helper.formatTextAreaData((String) hsh5
									.get("recoverduesteps"))%></p>
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td align="center" width="96%">
						<p><br>
						<br>
						</p>
						<p>&nbsp;</p>
						<p>&nbsp;</p>
						<table width="96%">
							<tr>
								<td width="40%">
								<div align="center"><b>BRANCH MANAGER</b></div>
								</td>
								<td width="40%">
								<div align="center"><b>REGIONAL HEAD</b></div>
								</td>
							</tr>
						</table>
					</tr>
				</table>
				</td>
			</tr>
		</table>
</body>
</html>
