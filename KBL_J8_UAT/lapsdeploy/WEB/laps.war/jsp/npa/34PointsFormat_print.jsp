<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%HashMap hshValues1 = new HashMap();
			HashMap hshValues2 = new HashMap();
			HashMap hshValues3 = new HashMap();
			HashMap hshValues4 = new HashMap();
			HashMap hshValues5 = new HashMap();
			HashMap hshValues6 = new HashMap();
			HashMap hshValues7 = new HashMap();
			HashMap hshValues8 = new HashMap();
			HashMap hshValues9 = new HashMap();
			HashMap hshValues10 = new HashMap();
			HashMap hshValues11 = new HashMap();
			HashMap hshValues12 = new HashMap();
			HashMap hshValues13 = new HashMap();
			HashMap hshValues14 = new HashMap();
			HashMap hshValues15 = new HashMap();
			HashMap hshValues16 = new HashMap();
			HashMap hshHistory=new HashMap();
			
			HashMap hshValues17 = new HashMap();
			HashMap hshSignatories = new HashMap();

			hshValues1 = (HashMap) hshValues.get("hshValues1");
			//out.println(hshValues1);
			hshValues2 = (HashMap) hshValues.get("hshValues2");
			hshValues3 = (HashMap) hshValues.get("hshValues3");
			hshValues4 = (HashMap) hshValues.get("hshValues4");

			hshValues5 = (HashMap) hshValues.get("hshValues5");

			hshValues6 = (HashMap) hshValues.get("hshValues6");

			hshValues7 = (HashMap) hshValues.get("hshValues7");

			hshValues8 = (HashMap) hshValues.get("hshValues8");

			hshValues9 = (HashMap) hshValues.get("hshValues9");

			hshValues10 = (HashMap) hshValues.get("hshValues10");
			hshValues12 = (HashMap) hshValues.get("hshValues12");
			hshValues13 = (HashMap) hshValues.get("hshValues13");
			hshValues14 = (HashMap) hshValues.get("hshValues14");
			hshValues15 = (HashMap) hshValues.get("hshValues15");
			hshValues16 = (HashMap) hshValues.get("hshValues16");
			
			hshSignatories = (HashMap) hshValues.get("hshSignatories");
			hshValues17=(HashMap)hshValues.get("hshRecommendations");
			hshHistory=(HashMap)hshValues.get("hshHistory");
			ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidtype"));
			if (strCategoryType == "") {
				strCategoryType = Helper.correctNull((String) hshValues
						.get("strCategoryType"));
			}

			ArrayList vecRow = null;
			ArrayList vecCol = new ArrayList();

			ArrayList vecRow1 = null;
			ArrayList vecCol1 = new ArrayList();

			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);
			String strSanctauth = Helper.correctNull((String) hshSignatories
					.get("sancauth"));
			%>
<html>
<head>
<title>Filing of suit</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">
</head>
<body>
<table width="80%" border="0" cellspacing="3" cellpadding="5"
	align="center">
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
		<td align="center" colspan=""><b><%=Helper.correctNull((String) hshValues.get("branchname"))%></b>
		<hr>
		</td>
	</tr>
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
		<%if (strSanctauth.equals("7")) { %>
	<tr>
		<td align="center"><b><u>MEMORANDUM TO MANAGEMENT COMMITTEE</u></b></td>
	</tr>
	<tr>
		<td align="center"><b>FOR APPROVAL</b></td>
	</tr>
	<%} else if (strSanctauth.equals("6") || strSanctauth.equals("5")) {%>
	<tr>
		<td align="center"><b>FOR APPROVAL OF ED/ CMD</b></td>
	</tr>
	<%} %>
	<tr>
		<td align="center" width="80%"><B><strong><U>FORMAT TO BE SUBMITTED BY
		BRANCHES RECOMMENDING FILING OF SUIT</U></strong></B></td>
	</tr>
	<tr> 
    <td> 
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="10%" nowrap="nowrap"><b>1. a.&nbsp;</b></td>
				<td width="39%"><b>Name of the Borrower</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("borrowername"))%></td>
			</tr>
			<tr>
				<td width="10%"><b>1. b.&nbsp;</b></td>
				<td width="39%"><b>Branch</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("branchname"))%></td>
			</tr>
			<tr>
				<td width="10%"><b>1. c.&nbsp;</b></td>
				<td width="39%"><b>Region</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("regionname"))%></td>
			</tr>
			<tr>
				<td width="10%"><b>1. d.&nbsp;</b></td>
				<td width="39%"><b>Sectoral category</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues1.get("sector"))%></td>
			</tr>
			<%String regprem = Helper.correctNull((String) hshValues1
					.get("facpremises"));
			if (regprem.equalsIgnoreCase("0")) {
				regprem = "";
			}
			if (regprem.equalsIgnoreCase("1")) {
				regprem = "Rented";
			}
			if (regprem.equalsIgnoreCase("2")) {
				regprem = "Owned";
			}
			if (regprem.equalsIgnoreCase("3")) {
				regprem = "Leased";
			}
			String offprem = Helper.correctNull((String) hshValues1
					.get("regoffpremises"));
			if (offprem.equalsIgnoreCase("0")) {
				offprem = "";
			}
			if (offprem.equalsIgnoreCase("1")) {
				offprem = "Rented";
			}
			if (offprem.equalsIgnoreCase("2")) {
				offprem = "Owned";
			}
			if (offprem.equalsIgnoreCase("3")) {
				offprem = "Leased";
			}

			%>
			<tr valign="top">
				<td width="10%"><b>2.&nbsp;</b></td>
				<td width="39%"><b>Address of the Borrower</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr valign="top">
				<td width="10%" valign="top"><b>2. a.&nbsp;</b></td>
				<td width="39%" valign="top"><b>Office / Factory</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top"><%=Helper.correctNull((String) hshValues1
									.get("facoffaddr"))%><br>
				Premises: <%=regprem%></td>
			</tr>
			<tr valign="top">
				<td width="10%" valign="top"><b>2. b.&nbsp;</b></td>
				<td width="39%" valign="top"><b>Regd.Office</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td valign="top"><%=Helper.correctNull((String) hshValues1
									.get("regoffaddr"))%> <br>
				Premises: <%=offprem%></td>
			</tr>
			<tr valign="top">
				<td width="10%" valign="top"><b>3.&nbsp;</b></td>
				<td width="39%" valign="top"><b>Constitution</b></td>
				<td width="1%"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hshValues1
							.get("constitution"))%></td>
			</tr>
			<tr valign="top">
				<td width="10%" valign="top"><b>4.&nbsp;</b></td>
				<td width="39%" valign="top"><b>Name(s) residential Address/es and
				Telephone Number/s.</b></td>
				<td width="1%"><b>:</b></td>
				<td valign="top">&nbsp;</td>
			</tr>
			<tr valign="top">
				<td width="10%" valign="top"><b>&nbsp;</b></td>
				<td colspan="3" valign="top">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr align="center" class="tblhead">
						<td valign="top">No.</td>
						<td valign="top">Name of Proprietor / partners / Directors of the
						Firm</td>
						<td valign="top">Address</td>
						<td valign="top">Telephone Numbers</td>
					</tr>

					<%vecRow1 = (ArrayList) hshValues8.get("vecRow");
			if (vecRow1 != null && vecRow1.size() > 0) {

				%>
					<%int size = 0;
				size = vecRow1.size();
				for (int i = 0; i < size; i++) {

					vecCol1 = (ArrayList) vecRow1.get(i);
					if (vecCol1 != null && vecCol1.size() > 0) {

						%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(0))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(2))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(9))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(10))%></td>

					</tr>
					<%}
				}
			} else {

			%>
					<tr>
						<td align="center" colspan="4">N.A</td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>5.&nbsp;</b></td>
				<td valign="top"><b>Nature of Business</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1.get("activity"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top" nowrap="nowrap"><b>6. a)&nbsp;</b></td>
				<td valign="top"><b>Date of Establishment / incorporation</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1.get("do_ieb"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>6. b)&nbsp;</b></td>
				<td valign="top"><b>Date account opened</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1
							.get("advancesince"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>6. c)&nbsp;</b></td>
				<td valign="top"><b>Date of credit facilities &amp; sanctioning
				Authority</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>Originally sanctioned date</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1
							.get("DATE_SACTIONED"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>Disbursed date</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1
							.get("DATE_DISBURSED"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>Last Review date</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1
							.get("DATE_NPAREVIEW"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>6. d)&nbsp;</b></td>
				<td valign="top"><b>NPA Since</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1.get("npasince"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>7.&nbsp;</b></td>
				<td valign="top"><b>Details of limits sanctioned</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4" align="right"><b>(Rs. in lacs)</b></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr align="center" class="tblhead">
						<td>No.</td>
						<td>Nature of Facility(ies)</td>
						<td>Amount</td>
						<td>Rate of Int.</td>
						<td>security/ douments obtained</td>
						<td>Date of documents obtained</td>
					</tr>

					<%vecRow = (ArrayList) hshValues2.get("vecRow");
			if (vecRow != null && vecRow.size() > 0) {

				%>
					<%int size = 0;
				size = vecRow.size();
				for (int i = 0; i < size; i++) {

					vecCol = (ArrayList) vecRow.get(i);
					if (vecCol != null && vecCol.size() > 0) {

						%>
					<tr>
						<td><%=Helper.correctNull((String) vecCol.get(0))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecCol.get(1))%>&nbsp;</td>
						<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecCol.get(2))))%></td>
						<td><%=Helper.correctNull((String) vecCol.get(3))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecCol.get(4))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecCol.get(5))%>&nbsp;</td>
					</tr>
					<%}
				}
			} else {

			%>
					<tr>
						<td colspan="6" align="center"><b>N.A</b></td>
					</tr>
					<%}

			%>
					<tr>
				</table>
				</div>
				</td>
			</tr>
			<%String sel_sanctionAuthority = Helper
					.correctNull((String) hshValues1
							.get("FIL_SANCTIONAUTORITY"));

			if (sel_sanctionAuthority.equalsIgnoreCase("2")) {
				sel_sanctionAuthority = "MCM";
			} else if (sel_sanctionAuthority.equalsIgnoreCase("3")) {
				sel_sanctionAuthority = "MD";

			} else if (sel_sanctionAuthority.equalsIgnoreCase("4")) {
				sel_sanctionAuthority = "ED";

			} else if (sel_sanctionAuthority.equalsIgnoreCase("5")) {
				sel_sanctionAuthority = "GM";

			} else if (sel_sanctionAuthority.equalsIgnoreCase("6")) {
				sel_sanctionAuthority = "DGM";

			} else {
				sel_sanctionAuthority = "&nbsp;";
			}

			%>
			<tr valign="top">
				<td valign="top"><b>8.&nbsp;</b></td>
				<td valign="top"><b>Sanctioning Authority(ies)</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=sel_sanctionAuthority%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>9.&nbsp;</b></td>
				<td valign="top"><b>Whether Collateral security(ies) held</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%if (Helper.correctNull((String) hshValues3.get("strrecords"))
					.equalsIgnoreCase("Y")) {
				out.println("Yes");
			} else {
				out.println("No");
			}%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>Details of Security</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr align="center" class="tblhead">
						<td>No.</td>
						<td>Security Type</td>
						<td>Location</td>
						<td>Description</td>
						<td>Owner of the Property</td>
						<td>Date of EM</td>
						<td>Present postion of security</td>
					</tr>
					<%vecRow1 = (ArrayList) hshValues3.get("vecRow");
			if (vecRow1 != null && vecRow1.size() > 0) {
				int size = 0;
				size = vecRow1.size();
				for (int i = 0; i < size; i++) {

					vecCol1 = (ArrayList) vecRow1.get(i);
					if (vecCol1 != null && vecCol1.size() > 0) {

						%>
					<tr>
						<%String scur_type = "";
						if ("1".equals(Helper.correctNull((String) vecCol1
								.get(5))))
							scur_type = "Primary";
						else if ("2".equals(Helper.correctNull((String) vecCol1
								.get(5))))
							scur_type = "Collateral";

						%>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(0))%></td>
						<td>&nbsp;<%=scur_type%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(1))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(2))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(3))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(4))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(6))%></td>
					</tr>
					<%}
				}
			} else {

			%>
					<tr>
						<td colspan="7" align="center"><b>N.A</b></td>
					</tr>
					<%}%>
				</table>
				</div>
				</td>
			</tr>

			<tr valign="top">
				<td valign="top"><b>10.&nbsp;</b></td>
				<td valign="top"><b>Details of registration</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%if (!Helper.correctNull((String) hshValues1.get("constitution"))
					.equalsIgnoreCase("PUB.LTD COMPANIES")
					&& !Helper.correctNull(
							(String) hshValues1.get("constitution"))
							.equalsIgnoreCase("PVT.LTD COMPANIES")) {
				out.print("N.A");
			}%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="80%" border="0" cellspacing="0" cellpadding="3">
					<%if (Helper.correctNull((String) hshValues1.get("constitution"))
					.equalsIgnoreCase("PUB.LTD COMPANIES")
					|| Helper.correctNull(
							(String) hshValues1.get("constitution"))
							.equalsIgnoreCase("PVT.LTD COMPANIES")) {%>
					<tr align="center">
						<td>No.</td>
						<td>Name of ROC</td>
						<td>Date of Registration</td>
						<td>Amount of Charges</td>
						<td>Type of Charges</td>
					</tr>
					<%vecRow1 = (ArrayList) hshValues10.get("vecRow");
				if (vecRow1 != null && vecRow1.size() > 0) {
					int size = 0;
					size = vecRow1.size();
					for (int i = 0; i < size; i++) {

						vecCol1 = (ArrayList) vecRow1.get(i);
						if (vecCol1 != null && vecCol1.size() > 0) {

							%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(0))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(1))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(2))%></td>
						<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) vecCol1
													.get(3))))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1
											.get(4))%></td>
					</tr>
					<%}
					}
				} else {

				%>
					<tr>
						<td colspan="5" align="center"><b>No Data Found</b></td>
					</tr>
					<%}
			}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>11.&nbsp;</b></td>
				<td valign="top"><b>Name/s and Address/es of the Guarantor(s) Surety
				(ies) with their occupation and Means</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td>No</td>
						<td>Name of the Guarantor</td>
						<td>Address</td>
						<td>Means at the time of renewal</td>
						<td>Present Means</td>
					</tr>
					<%vecRow1 = (ArrayList) hshValues8.get("vecRow");
			if (vecRow1 != null && vecRow1.size() > 0) {

				%>
					<%int size = 0;
				size = vecRow1.size();
				for (int i = 0; i < size; i++) {

					vecCol1 = (ArrayList) vecRow1.get(i);
					if (vecCol1 != null && vecCol1.size() > 0) {

						%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(0))%></td>

						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(11))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(9))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
										.parseDouble(Helper
												.correctDouble((String) vecCol1
														.get(4))))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
										.parseDouble(Helper
												.correctDouble((String) vecCol1
														.get(6))))%></td>
					</tr>
					<%}
				}
			} else {

			%>

					<tr align="center">
						<td colspan="5"><b>N.A</b></td>
					</tr>

					<%}

			%>
					<tr>
				</table>
				</div>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>12.&nbsp;</b></td>
				<td valign="top"><b>Whether the terms and conditions are stipulated
				in the Sanction Advice and/or as required for while granting credit
				facility(ies) to the borrower(s) originally and subsequently were
				fulfilled or not: - (Tick Suitably)</b></td>
				<td valign="top"><b>:</b></td>
				<%String terms_condts = Helper.correctNull((String) hshValues6
					.get("terms_condts"));
			if (terms_condts.equalsIgnoreCase("0")) {
				terms_condts = "Yes";
			} else if (terms_condts.equalsIgnoreCase("1")) {
				terms_condts = "No";

			} else {
				terms_condts = "";
			}

			%>
				<td>&nbsp;<%=terms_condts%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>If no, brief reasons:-</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshValues6
							.get("reasons"))%></p>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>13.&nbsp;</b></td>
				<td valign="top"><b>Whether credit facility (ies) were subsequently
				renewed and / or enhanced. If so, give detailed particulars thereof
				as follows: -</b></td>
				<td valign="top"><b>:</b></td>
				<%String sel_enforce = Helper.correctNull((String) hshValues1
					.get("fil_sel_enforce"));
			if (sel_enforce.equalsIgnoreCase("y")) {
				sel_enforce = "Yes";
			} else {
				sel_enforce = "No";
			}

			%>
				<td>&nbsp;<%=sel_enforce%></td>
			</tr>
			<%if (sel_enforce.equalsIgnoreCase("yes")) {%>
			<tr>
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>No.</td>
						<td>Nature of Facility(ies)</td>
						<td>Amount</td>
						<td>Rate of Int.</td>
						<td>security/ douments obtained</td>
						<td>Date of documents obtained</td>
					</tr>
					<%vecRow = (ArrayList) hshValues2.get("vecRow");
				if (vecRow != null && vecRow.size() > 0) {

					%>
					<%int size = 0;
					size = vecRow.size();
					for (int i = 0; i < size; i++) {
						vecCol = (ArrayList) vecRow.get(i);
						if (vecCol != null && vecCol.size() > 0) {

							%>
					<tr>
						<td>&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(0))%></td>
						<td>&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(1))%></td>
						<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(2))))%></td>
						<td>&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(3))%></td>
						<td>&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(4))%></td>
						<td>&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(5))%></td>
					</tr>
					<%}
					}
				} else {

				%>
					<tr>
						<td colspan="6" align="center"><b>N.A.</b></td>
					</tr>
					<%}

			%>

				</table>
				</div>
				</td>
			</tr>
			<%}

			%>
			<tr valign="top">
				<td valign="top"><b>14.&nbsp;</b></td>
				<td valign="top"><b>Details of Term Loan</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr align="center" class="tblhead">
						<td>Name of term loan</td>
						<td>Type of term loan</td>
						<td>No of instalments</td>
						<td>Instalment amount</td>
						<td>Start Date</td>
					</tr>
					<%vecRow1 = (ArrayList) hshValues4.get("vecRow");
			if (vecRow1 != null && vecRow1.size() > 0) {

				%>
					<%int size = 0;
				size = vecRow1.size();
				for (int i = 0; i < size; i++) {

					vecCol1 = (ArrayList) vecRow1.get(i);
					if (vecCol1 != null && vecCol1.size() > 0) {

						%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(1))%></td>
						<%String termloantype = Helper
								.correctNull((String) vecCol1.get(2));
						if (termloantype.equalsIgnoreCase("1")) {
							termloantype = "";
						} else if (termloantype.equalsIgnoreCase("2")) {
							termloantype = "Short Term";
						} else if (termloantype.equalsIgnoreCase("3")) {
							termloantype = "medium Term";
						} else if (termloantype.equalsIgnoreCase("4")) {
							termloantype = "Long Term";
						}%>
						<td>&nbsp;<%=termloantype%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(3))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
										.parseDouble(Helper
												.correctDouble((String) vecCol1
														.get(4))))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(5))%></td>
					</tr>
					<%}
				}
			} else {

			%>
					<tr>
						<td colspan="5" align="center"><b>No Data Found</b></td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr align="center" class="tblhead">
						<td>Last instalment end date</td>
						<td>Date of loan first disbursed</td>
						<td>No of instalments received</td>
						<td width="19%">Amount of instalment received</td>
						<td>Date of last instalment received</td>
						<td>Date from when default in payment is started</td>
						<%vecRow1 = (ArrayList) hshValues4.get("vecRow");
			if (vecRow1 != null && vecRow1.size() > 0) {

				%>
						<%int size = 0;
				size = vecRow1.size();
				for (int i = 0; i < size; i++) {

					vecCol1 = (ArrayList) vecRow1.get(i);
					if (vecCol1 != null && vecCol1.size() > 0) {

						%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(6))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(7))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(8))%></td>
						<td align="right" width="19%">&nbsp;<%=nf.format(Double
										.parseDouble(Helper
												.correctDouble((String) vecCol1
														.get(9))))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(10))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(11))%></td>
					</tr>
					<%}
				}
			} else {

			%>
					<tr>
						<td colspan="6" align="center"><b>No Data Found</b></td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>15.&nbsp;</b></td>
				<td valign="top"><b>PRESENT POSITION OF ACCOUNT</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>


			<tr>
				<td valign="top"><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td>Nature of limit</td>
						<td>Amount</td>
						<td>Running ledger o/s.</td>
						<td>Sub- total</td>
						<td>Unreco vered int</td>
						<td>Net dues</td>
						<td>Dummy ledger int amount</td>
						<td>Legal / other exp</td>
						<td>Total dues</td>
					<tr>
						<%vecRow = (ArrayList) hshValues7.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				double dbltotaldues = 0.0;
				double dbllegal = 0.0;
				double dblinterstamount = 0.0;
				double dblnetdues = 0.0;
				double dblrecoverint = 0.0;
				double dblsubtotal = 0.0;
				double dblRunningoutstan = 0.0;
				double dblAmountlimit = 0.0;

				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					dblAmountlimit = dblAmountlimit
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(2)));
					dblRunningoutstan = dblRunningoutstan
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(3)));
					dblsubtotal = dblsubtotal
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(6)));
					dblrecoverint = dblrecoverint
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(7)));
					dblnetdues = dblnetdues
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(8)));
					dblinterstamount = dblinterstamount
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
			<tr valign="top">
				<td valign="top"><b>16.&nbsp;</b></td>
				<td valign="top"><b>Provision ammount</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues1.get("provision"))%></td>
			</tr>

			<tr valign="top">
				<td valign="top"><b>17.&nbsp;</b></td>
				<td valign="top"><b>Details of DICGC/ECGC claim</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues6.get("fil_claim"))%></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>18.&nbsp;</b></td>
				<td valign="top"><b>Brief History of the account from the date of
				availing facilities first with dates and detailed particulars of the
				changes in constitution. together with a renewals of the limit (s)
				from time to time and security documents taken. etc.</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>

			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshHistory
							.get("briefhistory"))%></p>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>19.&nbsp;</b></td>
				<td valign="top"><b>When and what were the signs and symptoms of the
				irregularities/ sickness. etc. in the account first observed and the
				remedial measures taken:</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshHistory
							.get("irregularreasons"))%></p>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>20.&nbsp;</b></td>
				<td valign="top"><b>Does the borrower(s) Bank with any of the other
				branches of our Bank</b></td>
				<td valign="top"><b>:</b></td>
				<%String ourbank = Helper.correctNull((String) hshValues9
					.get("fil_symptoms"));
			if (ourbank.equalsIgnoreCase("y")) {
				ourbank = "Yes";
			} else if (ourbank.equalsIgnoreCase("2")) {
				ourbank = "No";
			} else {
				ourbank = "";
			}

			%>
				<td>&nbsp;<%=ourbank%></td>

			</tr>
			<%if (Helper.correctNull((String) hshValues9.get("fil_symptoms"))
					.equals("y")) {

				%>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshValues9
								.get("fil_account_history"))%></p>
				</td>

			</tr>
			<%}

			%>
			<tr valign="top">
				<td valign="top"><b>21.&nbsp;</b></td>
				<td valign="top"><b>Does the borrower(s) Bank with with any other
				Bank. financial institution. etc .. and credit facility (ies)
				availed therefrom?</b></td>
				<td valign="top"><b>:</b></td>
				<%String sel_bank_arrangement = Helper
					.correctNull((String) hshValues1.get("bankarrangement"));
			if (sel_bank_arrangement.equalsIgnoreCase("1")) {
				sel_bank_arrangement = "Sole";
			} else if (sel_bank_arrangement.equalsIgnoreCase("2")) {
				sel_bank_arrangement = "Consortium";
			} else if (sel_bank_arrangement.equalsIgnoreCase("3")) {
				sel_bank_arrangement = "Multiple Banking";
			} else {
				sel_bank_arrangement = "";
			}

			%>
				<td>&nbsp;<%=sel_bank_arrangement%></td>
			</tr>
			<%if (Helper.correctNull((String) hshValues1.get("bankarrangement"))
					.equalsIgnoreCase("2")
					|| Helper.correctNull(
							(String) hshValues1.get("bankarrangement"))
							.equalsIgnoreCase("3")) {

				%>
			<tr>
				<td valign="top" nowrap><b>21. a.&nbsp;</b></td>
				<td valign="top"><b>Details of Borrower(s) Bank with other Bank</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td><b>Name of Consortium Members</b></td>
						<%if (Helper.correctNull(
						(String) hshValues1.get("bankarrangement"))
						.equalsIgnoreCase("2")) {

				%>
						<td><b>Sharing Pattern</b></td>
						<%}

				%>
						<td><b>Limit Sanctioned</b></td>
						<td><b>Present O/s.</b></td>
						<td><b>Status of A/c.</b></td>
					</tr>
					<%if (Helper.correctNull(
						(String) hshValues1.get("bankarrangement"))
						.equalsIgnoreCase("2")) {
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues13.get("arrRow");
				} else {
					arrRow = new ArrayList();
					arrRow = (ArrayList) hshValues14.get("arrRow");
				}

				if (arrRow != null && arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {

						arrCol = (ArrayList) arrRow.get(i);
						if (arrCol != null && arrCol.size() > 0) {
							String Bank_arrange = Helper
									.correctNull((String) arrCol.get(5));
							String status = "";
							if (Bank_arrange.equalsIgnoreCase("1")) {
								status = "Regular";
							} else if (Bank_arrange.equalsIgnoreCase("2")) {
								status = "Npa";
							}

							%>
					<tr>
						<td>&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
						<%if (Helper.correctNull(
									(String) hshValues1.get("bankarrangement"))
									.equalsIgnoreCase("2")) {

								%>
						<td>&nbsp;<%=Helper.correctNull((String) arrCol
												.get(3))%></td>
						<%}

							%>
						<td align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(2))))%></td>
						<td align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) arrCol
																			.get(4))))%></td>
						<td>&nbsp;<%=status%></td>
					</tr>
					<%}
					}
				} else {%>
					<tr>
						<td colspan="5">N.A.</td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<%}

			%>
			<%arrRow = (ArrayList) hshValues15.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td valign="top" nowrap><b>21. b.&nbsp;</b></td>
				<td valign="top"><b>Details of Borrower(s) Bank with Financial
				Institution</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;</td>
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
			<%arrRow = (ArrayList) hshValues16.get("arrRow");
			//System.out.println(arrRow);
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td valign="top"><b>22.&nbsp;</b></td>
				<td valign="top"><b>Does the borrower(s) have any other associate/
				sister and/or other connected account(s) with any of our Bank's
				branches and/or with any other Bank. and availing credit (ies)
				therefrom?</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;Yes</td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td valign="top" colspan="3">
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
			<%} else {

			%>
			<tr>
				<td valign="top">22.&nbsp;</td>
				<td valign="top"><b>Does the borrower(s) have any other associate/
				sister and/or other connected account(s) with any of our Bank's
				branches and/or with any other Bank. and availing credit (ies)
				therefrom?</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;No</td>
			</tr>
			<%}

			%>
			<tr valign="top">
				<td valign="top"><b>23.&nbsp;</b></td>
				<td valign="top"><b>Does the borrower(s) have any Savings Bank
				Account and/or Term Deposit Account. either in the personal name(s)
				of the partners. their family members. etc. in your branch. or with
				gny other Branch of our Bank and/or with any other Bank?</b></td>
				<td valign="top"><b>:</b></td>
				<%String sel_accountholder = Helper.correctNull((String) hshValues9
					.get("sel_accountholder"));
			if (sel_accountholder.equalsIgnoreCase("y")) {
				sel_accountholder = "Yes";
			} else if (sel_accountholder.equalsIgnoreCase("n")) {
				sel_accountholder = "No";
			} else {
				sel_accountholder = "";
			}

			%>
				<td>&nbsp;<%=sel_accountholder%></td>
			</tr>
			<tr>
				<td valign="top">&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>Name of Account Holder</td>
						<td width="13%">Relation</td>
						<td>Type Of Account</td>
						<td>Outstanding Amount</td>
					</tr>
					<%String[] stractholdname = new String[5];
			String[] strrelation = new String[5];
			String[] straccounttype = new String[5];
			String[] stroutstandingamount = new String[5];

			stractholdname = (String[]) hshValues9.get("fil_actholdname");
			strrelation = (String[]) hshValues9.get("fil_relation");
			straccounttype = (String[]) hshValues9.get("fil_accounttype");
			stroutstandingamount = (String[]) hshValues9
					.get("fil_outstandingamount");

			if (!stractholdname.equals("") && stractholdname != null) {
				for (int i = 0; i < 5; i++) {

					%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull(stractholdname[i])%></td>
						<td>&nbsp;<%=Helper.correctNull(strrelation[i])%></td>
						<td>&nbsp;<%=Helper.correctNull(straccounttype[i])%></td>
						<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
									.correctDouble(stroutstandingamount[i])))%></td>
					</tr>
					<%}
			} else {%>
					<tr align="center">
						<td colspan="4"><b>No Data Found</b></td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>24.&nbsp;</b></td>
				<td valign="top"><b>Present rate of interest applicable to the
				facilities</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top"><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr valign="top" align="center" class="tblhead">
						<td valign="top">No.</td>
						<td>Present Nature</td>
						<td>Present rate of interest</td>
						<td>Date up to which interest is charged</td>
						<td>Amount of DBC</td>
						<td>Date of DBC</td>
					</tr>
					<%vecRow1 = (ArrayList) hshValues5.get("vecRow");
			if (vecRow1 != null && vecRow1.size() > 0) {

				%>
					<%int size = 0;
				size = vecRow1.size();
				for (int i = 0; i < size; i++) {

					vecCol1 = (ArrayList) vecRow1.get(i);
					if (vecCol1 != null && vecCol1.size() > 0) {

						%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(0))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(1))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(2))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(3))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
										.parseDouble(Helper
												.correctDouble((String) vecCol1
														.get(4))))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(5))%></td>
					</tr>
					<%}
				}
			} else {

			%>
					<tr>
						<td colspan="6" align="center"><b>N.A</b></td>
					</tr>
					<%}%>
				</table>
				</div>
				</td>
			</tr>


			<tr valign="top">
				<td valign="top"><b>25.&nbsp;</b></td>
				<td valign="top"><b>Cash Deposit entries in the account with Amount
				and Date of entries</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top"><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">

					<tr valign="top" align="center" class="tblhead">
						<td>No.</td>
						<td>Facility(ies)</td>
						<td>Amount deposited</td>

						<td>Date of remittance</td>
						<td>&nbsp;Details of remittance</td>

					</tr>
					<%vecRow1 = (ArrayList) hshValues11.get("vecRow");
			if (vecRow1 != null && vecRow1.size() > 0) {

				%>
					<%int size = 0;
				size = vecRow1.size();
				for (int i = 0; i < size; i++) {

					vecCol1 = (ArrayList) vecRow1.get(i);
					if (vecCol1 != null && vecCol1.size() > 0) {

						%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(0))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(1))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
										.parseDouble(Helper
												.correctDouble((String) vecCol1
														.get(2))))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(4))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol1.get(3))%></td>
					</tr>
					<%}
				}
			} else {

			%>

					<tr align="center">
						<td colspan="5"><b>N.A</b></td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>26.&nbsp;</b></td>
				<td valign="top"><b>Please elaborate the actions taken by your branch
				for the safeguard of the securities held and the recovery of the
				outstanding advance granted to the borrower</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3"><p><%=Helper.formatTextAreaData((String) hshHistory
							.get("recoverduesteps"))%></p></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>27.&nbsp;</b></td>
				<td valign="top"><b>Please elaborate the future course of action.
				towards the recovery of the advances</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3"><p><%=Helper.formatTextAreaData((String) hshValues6
							.get("fil_elaborate"))%></p></td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>28.&nbsp;</b></td>
				<td valign="top"><b>Whether Business is continued ?</b></td>
				<td valign="top"><b>:</b></td>
				<%String business_cont = Helper.correctNull((String) hshValues6
					.get("business_cont"));
			if (business_cont.equalsIgnoreCase("0")) {
				business_cont = "Yes";
			} else if (business_cont.equalsIgnoreCase("1")) {
				business_cont = "No";

			} else {
				business_cont = "";
			}

			%>
				<td>&nbsp;<%=business_cont%></td>
			</tr>
			<%if (Helper.correctNull((String) hshValues6.get("business_cont"))
					.equals("1")) {%>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>if no, brief reasons</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3"><p><%=Helper.correctNull((String) hshValues6
								.get("present_act"))%></p></td>
			</tr>
			<%} %>
			<tr valign="top">
				<td valign="top"><b>29.&nbsp;</b></td>
				<td valign="top"><b>Are the assets possessed by the
				borrower/guarantor presently free of any charge</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues6
									.get("fil_assets"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>30.&nbsp;</b></td>
				<td width="44%"><b>AUDIT IRREGULARITIES</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues12.get("arrRow");

			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {

					%>
			<%arrCol = (ArrayList) arrRow.get(i);
					if (arrCol != null && arrCol.size() > 0) {
						if (Helper.correctNull((String) arrCol.get(3))
								.equalsIgnoreCase("1")) {

							%>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>Internal Audit </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>Date of Report </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(2))%></td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%" align="center"><b>OBSERVATIONS</b></td>
						<td width="50%" align="center"><b>COMPLAINCE</b></td>
					</tr>
					<tr>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(0))%></td>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(1))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%} else if (Helper.correctNull((String) arrCol.get(3))
								.equalsIgnoreCase("2")) {%>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>Concurrent Audit</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>Date of Report </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(2))%></td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%" align="center"><b>OBSERVATIONS</b></td>
						<td width="50%" align="center"><b>COMPLAINCE</b></td>
					</tr>
					<tr>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(0))%></td>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(1))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%} else if (Helper.correctNull((String) arrCol.get(3))
								.equalsIgnoreCase("3")) {%>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>RBI Inspection Audit </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>Date of Report </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(2))%></td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%" align="center"><b>OBSERVATIONS</b></td>
						<td width="50%" align="center"><b>COMPLAINCE</b></td>
					</tr>
					<tr>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(0))%></td>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(1))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%} else if (Helper.correctNull((String) arrCol.get(3))
								.equalsIgnoreCase("4")) {%>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>RBI Inspection Audit </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>Date of Report </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(2))%></td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%" align="center"><b>OBSERVATIONS</b></td>
						<td width="50%" align="center"><b>COMPLAINCE</b></td>
					</tr>
					<tr>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(0))%></td>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(1))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%} else if (Helper.correctNull((String) arrCol.get(3))
								.equalsIgnoreCase("5")) {%>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>RBI Inspection Audit </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td><b>Date of Report </b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper
													.correctNull((String) arrCol
															.get(2))%></td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="50%" align="center"><b>OBSERVATIONS</b></td>
						<td width="50%" align="center"><b>COMPLAINCE</b></td>
					</tr>
					<tr>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(0))%></td>
						<td width="50%" valign="top">&nbsp;<%=Helper.formatTextAreaData((String) arrCol
											.get(1))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<%}

					%>
			<%}
				}
			}

			%>
			<%if (!Helper.correctNull(
					(String) hshValues17.get("BRrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>31.&nbsp;</b></td>
				<td colspan="3"><b>BRANCH RECOMMENDATION</b></td>
			</tr>


			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td  colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshValues17
								.get("BRrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshValues17.get("ROrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td  colspan="3"><b>REGIONAL OFFICE RECOMMENDATION</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td  colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshValues17
								.get("ROrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshValues17.get("FGMOrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td  colspan="3"><b>FGMO RECOMMENDATION</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td  colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshValues17
								.get("FGMOrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshValues17.get("CRLDrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td  colspan="3"><b>C.R.L.D., CENTRAL OFFICE RECOMMENDATION</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td  colspan="3">
				<p><%=Helper.formatTextAreaData((String) hshValues17
								.get("CRLDrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			
			<tr valign="top">
				<td valign="top"><b>32.&nbsp;</b></td>
				<td valign="top"><b>Any further comments you wish to incorporate therein</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr valign="top">
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3"><p><%=Helper.correctNull((String) hshValues6
									.get("fil_further"))%></p></td>
			</tr>

		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<%if (!Helper.correctNull(
					(String) hshSignatories.get("mcmresolution"))
					.equalsIgnoreCase("")) {%>
			<tr>
				<td width="10%">&nbsp;</td>
				<td valign="top" align="left" class="just"><b>Resolution:</b><br>
				<br>
				<b>If approved,</b> the MANAGEMENT COMMITTEE <b>is requested to
				adopt the following resolution: </b><br>
				<br>
				<%=Helper.formatTextAreaData((String) hshSignatories
								.get("mcmresolution"))%></td>
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
				<td width="10%">&nbsp;</td>
				<td valign="top" align="left"><b>COMMITTEE'S
				OBSERVATIONS/RECOMMENDATIONS&nbsp;</b></td>
			</tr>
			<tr>
				<td width="10%">&nbsp;</td>
				<td valign="top" class="just"><%=Helper.correctNull((String) hshSignatories
								.get("commobservations"))%></td>
			</tr>
			<%}

			%>
			<tr>
				<td valign="top" align="left" colspan="2">&nbsp;<br>
				<br>
				</td>
			</tr>
			<tr>
				<td valign="top" align="left" colspan="2">&nbsp;<br>
				<br>
				</td>
			</tr>
			<tr>
				<td width="10%">&nbsp;</td>
				<td valign="top" align="left"><b><%=Helper.correctNull((String) hshValues.get("signatures"))%></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>