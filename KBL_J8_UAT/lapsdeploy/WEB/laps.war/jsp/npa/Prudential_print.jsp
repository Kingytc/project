<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%//out.println(hshValues);
			HashMap hsh1 = new HashMap();
			HashMap hsh2 = new HashMap();
			HashMap hsh3 = new HashMap();
			HashMap hsh4 = new HashMap();
			HashMap hsh5 = new HashMap();
			HashMap hsh6 = new HashMap();
			HashMap hsh7 = new HashMap();
			HashMap hsh8 = new HashMap();
			HashMap hsh9 = new HashMap();
			HashMap hsh10 = new HashMap();
			HashMap hshSignatories = new HashMap();
			HashMap hshRecommendations=new HashMap();
			
			hsh1 = (HashMap) hshValues.get("hsh1");
			hsh2 = (HashMap) hshValues.get("hsh2");
			hsh3 = (HashMap) hshValues.get("hsh3");
			hsh4 = (HashMap) hshValues.get("hsh4");
			hsh5 = (HashMap) hshValues.get("hsh5");
			hsh6 = (HashMap) hshValues.get("hsh6");
			hsh7 = (HashMap) hshValues.get("hsh7");
			hsh8 = (HashMap) hshValues.get("hsh8");
			hsh9 = (HashMap) hshValues.get("hsh9");
			hsh10 = (HashMap) hshValues.get("hsh10");
			hshSignatories = (HashMap) hshValues.get("hshSignatories");
			hshRecommendations=(HashMap)hshValues.get("hshRecommendations");
			ArrayList arrRow = null;
			ArrayList arrCol = new ArrayList();
			ArrayList vecRow = null;
			ArrayList vecCol = new ArrayList();
			int intsno = 0;
			String strSanctauth = Helper.correctNull((String) hshSignatories
					.get("sancauth"));
			
			String proposal = "";
			String strproposal = Helper.correctNull((String) hsh1
					.get("propfor"));
			if (!strproposal.equalsIgnoreCase("")) {
				if (strproposal.equalsIgnoreCase("1")) {
					proposal = "PRUDENTIAL WRITE-OFF";
				}
				if (strproposal.equalsIgnoreCase("2")) {
					proposal = "ABSOLUTE WRITE-OFF";
				}

			}
%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css" />
</head>
<body>
<table width="75%" border="0" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
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
				<td align="center"><b>CREDIT RECOVERY &amp; LEGAL SERVICES
				DEPARTMENT</b></td>
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
		<%if (strSanctauth.equals("7")) { %>
			<tr>
				<td align="center"><b>FOR APPROVAL</b></td>
			</tr>
			<tr>
				<td align="center"><b>PROPOSAL FOR <%=proposal%></b></td>
			</tr>
			<%}else{ %>
			<tr>
				<td align="center"><b>FOR APPROVAL OF SETTLEMENT ADVISORY COMMITTEE (SAC)</b></td>
			</tr>
			<tr>
				<td align="center"><b><%=proposal%></b></td>
			</tr>
			<%} %>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%"><b>ACCOUNT </b></td>
						<td width="1%"><b>:</b></td>
						<td width="50%">&nbsp;<b><%=Helper.correctNull((String) hshValues.get("appname"))%></b></td>
					</tr>
					<tr>
						<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%"><b>BRANCH</b></td>
						<td width="1%"><b>:</b></td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("branchname"))%></td>
					</tr>
					<tr>
						<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%"><b>REGION</b></td>
						<td width="1%"><b>:</b></td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("regionname"))%></td>
					</tr>
					<tr>
						<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%"><b>ZONE</b></td>
						<td width="1%"><b>:</b></td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("zonalname"))%></td>
					</tr>
					<tr>
						<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%"><b>CONSTITUTION</b></td>
						<td width="1%"><b>:</b></td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hsh1.get("constitution"))%></td>
					</tr>
					<tr>
						<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%" valign="top"><b>NAME OF THE COMPANY / PARTNERS /
						DIRECTOR / PROPRIETOR</b></td>
						<td width="1%" valign="top"><b>:</b></td>
						<td width="50%">&nbsp;</td>
					</tr>
					<tr>
						<td width="5%"><b>&nbsp;</b></td>
						<td colspan="4">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr class="tblhead">
								<td rowspan="2" align="center"><b>NAME </b></td>
								<td colspan="2" align="center"><b>At the time of last Renewal /
								Original Sanction</b></td>
								<td colspan="2" align="center"><b>Present</b></td>
								<%-- <td rowspan="2" width="12%" align="center"><b>Present Activity </b></td>--%>
							</tr>
							<tr class="tblhead">
								<td align="center"><b>As on</b></td>
								<td align="center"><b>Means</b></td>
								<td align="center"><b>As on</b></td>
								<td align="center"><b>Means</b></td>
							</tr>
							<%vecRow = new ArrayList();
			vecRow = (ArrayList) hsh6.get("vecRow");
			if (vecRow != null && vecRow.size() > 0) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					if (vecCol != null && vecCol.size() > 0) {
						if (!Helper.correctNull((String) vecCol.get(1))
								.equalsIgnoreCase("gua")) {

							%>
							<tr valign="top">
								<td valign="top"><%=Helper
													.correctNull((String) vecCol
															.get(2))%>&nbsp;</td>
								<td valign="top"><%=Helper
													.correctNull((String) vecCol
															.get(5))%>&nbsp;</td>
								<td valign="top" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) vecCol
																			.get(4))))%></td>
								<td valign="top"><%=Helper
													.correctNull((String) vecCol
															.get(7))%>&nbsp;</td>
								<td valign="top" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) vecCol
																			.get(6))))%></td>
								<%-- <td valign="top"><%=Helper
													.correctNull((String) vecCol
															.get(3))%>&nbsp;</td>--%>
							</tr>
							<%}
					}
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
					<tr>
						<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%"><b>ACTIVITY</b></td>
						<td><b>:</b></td>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hsh1.get("activity"))%></td>
					</tr>
					<tr>
						<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
						<td width="44%"><b>BANKING ARRANGEMENT</b></td>
						<td><b>:</b></td>
						<td width="50%">&nbsp;<%if (Helper.correctNull((String) hsh1.get("bankarrangement"))
					.equalsIgnoreCase("1")) {
				out.println("Sole Banking");
			} else if (Helper.correctNull((String) hsh1.get("bankarrangement"))
					.equalsIgnoreCase("2")) {
				out.println("Consortium Banking");
			} else if (Helper.correctNull((String) hsh1.get("bankarrangement"))
					.equalsIgnoreCase("3")) {
				out.println("Multiple Banking");
			}

			%></td>
					</tr>
					<%if (Helper.correctNull((String) hsh1.get("bankarrangement"))
					.equalsIgnoreCase("2")
					|| Helper.correctNull((String) hsh1.get("bankarrangement"))
							.equalsIgnoreCase("3")) {

				%>
					<tr>
						<td width="5%">&nbsp;</td>
						<td colspan="4">
						<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr class="tblhead">
								<td><b>Name of Consortium Members</b></td>
								<%if (Helper.correctNull((String) hsh1.get("bankarrangement"))
						.equalsIgnoreCase("2")) {

				%>
								<td><b>Sharing Pattern</b></td>
								<%}

				%>
								<td><b>Limit Sanctioned</b></td>
								<td><b>Present O/s.</b></td>
								<td><b>Status of A/c.</b></td>
							</tr>
							<%if (Helper.correctNull((String) hsh1.get("bankarrangement"))
						.equalsIgnoreCase("2")) {
					arrRow = new ArrayList();
					arrRow = (ArrayList) hsh8.get("arrRow");
				} else {
					arrRow = new ArrayList();
					arrRow = (ArrayList) hsh9.get("arrRow");
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
									(String) hsh1.get("bankarrangement"))
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
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>ADVANCE SINCE</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hsh1.get("advancesince"))%></td>
			</tr>
			<tr>
				<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>NPA SINCE</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hsh1.get("npasince"))%></td>
			</tr>
			<tr>
				<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>DOUBTFUL SINCE/ LOSS SINCE</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hsh1.get("lossdoubtsince"))%></td>
			</tr>
			<tr>
				<td width="5%"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>PROVISION</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hsh1.get("provision"))))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%" valign="top"><b>NAME OF GUARANTORS WITH MEANS</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td rowspan="2" align="center"><b>NAME OF THE GUARANTORS</b></td>
						<td colspan="2" align="center"><b>At the time of last Renewal /
						Original Sanction</b></td>
						<td colspan="2" align="center"><b>Present Position</b></td>
						<%-- <td rowspan="2" width="12%" align="center"><b>Present Activity </b></td>--%>
					</tr>
					<tr class="tblhead">
						<td align="center"><b>As on</b></td>
						<td align="center"><b>Means</b></td>
						<td align="center"><b>As on</b></td>
						<td align="center"><b>Means</b></td>
					</tr>
					<%vecRow = new ArrayList();
			vecRow = (ArrayList) hsh6.get("vecRow");
			String strguaflag = "N";
			if (vecRow != null && vecRow.size() > 0) {

				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					if (vecCol != null && vecCol.size() > 0) {

						if (Helper.correctNull((String) vecCol.get(1))
								.equalsIgnoreCase("gua")) {
							strguaflag = "Y";

							%>
					<tr valign="top">
						<td width="21%">&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(2))%></td>
						<td>&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(5))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) vecCol
																			.get(4))))%></td>
						<td width="13%">&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(7))%></td>
						<td width="12%" align="right">&nbsp;<%=Helper
													.formatDoubleValue(Double
															.parseDouble(Helper
																	.correctDouble((String) vecCol
																			.get(6))))%></td>
						<%-- <td width="12%">&nbsp;<%=Helper
													.correctNull((String) vecCol
															.get(3))%></td>--%>
					</tr>
					<%}
					}
				}
				//out.print(strguaflag);
			}
			if (strguaflag.equalsIgnoreCase("N")) {
				//out.print(strguaflag);%>

					<tr>
						<td colspan="5">N.A.</td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>WHETHER UNIT IS RUNNING OR CLOSED. If
				closed,since when</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;<%if (Helper.correctNull((String) hsh1.get("unitstatus"))
					.equalsIgnoreCase("1")) {
				out.println("Running - ");
				if (Helper.correctNull((String) hsh1.get("unitrunfor"))
						.equalsIgnoreCase("1")) {
					out.println("Own Account");
				} else if (Helper.correctNull((String) hsh1.get("unitrunfor"))
						.equalsIgnoreCase("2")) {
					out.println("Job Work");
				}
			} else if (Helper.correctNull((String) hsh1.get("unitstatus"))
					.equalsIgnoreCase("2")) {
				out.println("Closed  Since");
				out.println(Helper.correctNull((String) hsh1
						.get("unitclosedsince")));
			}%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%" valign="top"><b>BORROWERS' /GUARANTORS' PRESENT
				OCCUPATION /MEANS OF LIVELIHOOD </b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="50%" valign="top">&nbsp;<%=Helper.correctNull((String) hsh1
									.get("livehoodsrc"))%></td>
			</tr>
			
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%" valign="top"><b>DICGC / ECGC CLAIMS SETTLED</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="50%" valign="top">&nbsp;<%if (Helper.correctNull((String) hsh1.get("ecgcclaimed"))
					.equals("1")) {
				out.println("Yes");
			} else {
				out.println("No");
			}

			%></td>
			</tr>
			
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%" valign="top"><b>DATE OF SETTLEMENT</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="50%" valign="top">&nbsp;<%=Helper.correctNull((String) hsh1
									.get("sinceexcess"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>PRESENT POSITION OF ACCOUNT</b></td>
				<td><b>:</b></td>
				<td></td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="4">
				<div id="top">
				<table width="80%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td valign="top"><b>NATURE OF LIMIT</b></td>
						<td valign="top"><b>AMT OF LIMIT</b></td>
						<td valign="top"><b>RUNNING LEDGER OS</b></td>
						<%if(Helper.correctNull((String) hsh1.get("ecgcclaimed")).equals("1")){ %>
						<td valign="top"><b>ECGC / DICGC / CGFT CLAIM APPROP RIATED</b></td>
						<%} %>
						<%-- <td valign="top"><b>SUB TOTAL</b></td>
						<td valign="top"><b>UNREC OVERED INT.</b></td>
						<td valign="top"><b>NET DUES</b></td>--%>
						<td valign="top"><b>DUMMY LEDGER INT AMT FROM </b><%=Helper.correctNull((String) hsh4.get("intfrom"))%>&nbsp;
						<b>TO</b> <%=Helper.correctNull((String) hsh4.get("intto"))%>&nbsp;</td>
						<td valign="top"><b>LEGAL / OTHER EXP</b></td>
						<td valign="top"><b>TOTAL DUES</b></td>
					</tr>
					<%vecRow = (ArrayList) hsh4.get("vecRow");
			double outstanding = 0.0;
			double dbllegal = 0.0;
			if (vecRow.size() > 0 && vecRow != null) {

				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					outstanding = outstanding
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(3)));
					dbllegal = dbllegal
							+ Double.parseDouble(Helper
									.correctDouble((String) vecCol.get(12)));

					%>
					<tr>
						<td><%=Helper.correctNull((String) vecCol.get(1))%>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
						<%if(Helper.correctNull((String) hsh1.get("ecgcclaimed")).equals("1")){ %>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
						<%} %>
						<%-- <td>&nbsp;<%=Helper.correctNull((String) vecCol.get(6))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(8))%></td>--%>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(11))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(12))%></td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(13))%></td>
					</tr>
					<%}
			}%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%" valign="top"><b>DATE OF LAST REVIEW / ENHANCEMENT</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="50%" valign="top">&nbsp;<%=Helper.correctNull((String) hsh2.get("lastreview_date"))%></td>
			</tr>
			<%-- <tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%" valign="top"><b>FAVOURABLE POINTS MENTIONED BY
				RECOMMENDING AUTHORITY AT THE TIME OF REVIEW / RENEWAL</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="50%" valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="3">
				<p><%=Helper.correctNull((String) hsh2
									.get("txt_enhancements"))%>&nbsp;</p>
				</td>
			</tr>--%>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>DATE OF LAST INSPECTION</b></td>
				<td><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hsh2
							.get("lastinspection_date"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>DATE WHEN SUIT FILED</b></td>
				<td><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hsh2.get("suit_date"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>AMOUNT OF SUIT</b></td>
				<td><b>:</b></td>
				<td>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hsh2.get("suit_amt"))))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>POSITION OF SUIT</b></td>
				<td><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b>&nbsp;</b></td>
				<td colspan="3">
				<p><%=Helper.correctNull((String) hsh2.get("suitposition"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>PROSPECTS OF RECOVERY</b></td>
				<td><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b>&nbsp;</b></td>
				<td colspan="3">
				<p><%=Helper.correctNull((String) hsh2.get("prospects"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>STAFF ACCOUNTABILITY</b></td>
				<td><b>:</b></td>
				<td></td>
			</tr>
			<tr>
				<td><b>&nbsp;</b></td>
				<td colspan="3">
				<p><%=Helper.correctNull((String) hsh3
							.get("staffaccountability"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>PRESENT POSITION OF SECURITIES</b></td>
				<td><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td rowspan="2" valign="top"><b>TYPE OF SECURITY</b></td>
						<td rowspan="2" valign="top"><b>NATURE</b></td>
						<td colspan="2" valign="top" align="center"><b>VALUATION AT THE
						TIME OF RENEWAL</b></td>
						<td colspan="2" valign="top" align="center"><b>PRESENT VALUATION</b></td>
						<td rowspan="2" valign="top"><b>INSPECTION DATE</b></td>
						<%-- <td rowspan="2" valign="top"><b>INSPE CTED BY </b></td>--%>
					</tr>
					<tr class="tblhead">
						<td width="10%" valign="top"><b>DATE</b></td>
						<td width="10%" valign="top"><b>AMOUNT</b></td>
						<td width="10%" valign="top"><b>DATE</b></td>
						<td width="10%" valign="top"><b>AMOUNT</b></td>
					</tr>
					<%vecRow = (ArrayList) hsh5.get("vecRow");
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
					<tr valign="top">
						<td><%=security%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecCol.get(2))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecCol.get(3))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
						<td><%=Helper.correctNull((String) vecCol.get(5))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
						<td><%=Helper.correctNull((String) vecCol.get(7))%>&nbsp;</td>
						<%--	<td><%=Helper.correctNull((String) vecCol.get(8))%>&nbsp;</td>--%>
					</tr>
					<%}
			} else {%>
					<tr>
						<td colspan="8">N.A.</td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td><b>DUES OF FINANCIAL INSTITUTIONS</b></td>
				<td><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%"><b>&nbsp;</b></td>
				<td colspan="4">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr class="tblhead">
						<td><b>Name of FI</b></td>
						<td><b>Principal Amt</b></td>
						<td><b>*Pre. O/S</b></td>
						<td><b>Nature of security</b></td>
						<td><b>Present value of security</b></td>
					</tr>

					<%arrRow = new ArrayList();
			arrRow = (ArrayList) hsh10.get("arrRow");

			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {

					arrCol = (ArrayList) arrRow.get(i);
					if (arrCol != null && arrCol.size() > 0) {

						%>
					<tr valign="top">
						<td>&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(2))))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%></td>
						<td><%=Helper.formatTextAreaData((String) arrCol
										.get(6))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(7))))%></td>
					</tr>
					<%}
				}
			}%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>BRIEF HISTORY &amp; BACKGROUND</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3">
				<p><%=Helper.formatTextAreaData((String) hsh3
							.get("briefhistory"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>REASONS FOR ACCOUNT BECOMING NPA/CLOSURE OF
				BUSINESS</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3">
				<p><%=Helper.formatTextAreaData((String) hsh3
							.get("irregularreasons"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b><%=++intsno%>.&nbsp;</b></td>
				<td width="44%"><b>AUDIT IRREGULARITIES</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hsh7.get("arrRow");

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
				<td width="5%">&nbsp;</td>
				<td width="44%"><b>RECOMMENDATIONS</b></td>
				<td width="1%"><b>:</b></td>
				<td width="50%">&nbsp;</td>
			</tr>
			<tr>
				<td width="5%">&nbsp;</td>
				<td colspan="3"><p>The Bank is holding provision of <%=ApplicationParams.getCurrency()%>
				&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hsh1.get("provision"))))%> against the
				ledger outstanding of <%=ApplicationParams.getCurrency()%>&nbsp; <%=Helper.formatDoubleValue(outstanding)%>
				in this account.</p>
				<p>
				Resorting to write-off in the account, will not prejudice the Bank's
				right of recovery and recovery efforts will continue. 
				</p><p>
				In view of the above, we recommend the following:- </p><p>
				The balance outstanding in the running ledger amounting to <%=ApplicationParams.getCurrency()%>&nbsp;
				<%=Helper.formatDoubleValue(outstanding)%> , which is fully / partly provided
				for, be written-off to the debit of Contingency Account <%if (Helper.correctNull((String) hsh1.get("propfor"))
					.equalsIgnoreCase("1")) {

				%> ,leaving a nominal balance of <%=ApplicationParams.getCurrency()%>&nbsp;
				<%=Helper.formatDoubleValue(Double.parseDouble(Helper
								.correctDouble((String) hsh1
										.get("nominalbalance"))))%> for maintaining identity of the
				account and also for recording further debit / credit transactions,
				if any. <%}%> </p><p>
				Legal and other Expenses of <%=ApplicationParams.getCurrency()%> <%=Helper.formatDoubleValue(dbllegal)%>
				were already absorbed to Expenditure Account. </p><p>
				<%if (Helper.correctNull((String) hsh1.get("propfor"))
					.equalsIgnoreCase("1")) {

			%> Branch is advised not to divulge the information regarding
				prudential write-off to the borrower and shall continue to make
				efforts to recover the dues and to carry out the legal action
				initiated to its logical end. <%}%></p></td>
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
