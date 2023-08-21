<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%//out.println(hshValues);
			HashMap hshComprogeneral = new HashMap();
			HashMap hshValues2 = new HashMap();
			HashMap hshValues3 = new HashMap();
			HashMap hshValues6 = new HashMap();
			HashMap hshValues7 = new HashMap();
			HashMap hshValues8 = new HashMap();
			HashMap hshborrower = new HashMap();
			HashMap hshEvaluation = new HashMap();
			HashMap hshReliefSought = new HashMap();
			HashMap hshModulardues = new HashMap();
			HashMap hshComments = new HashMap();
			HashMap hshTermscond = new HashMap();
			HashMap hshSignatories = new HashMap();

			hshComprogeneral = (HashMap) hshValues.get("hshgeneral");
			hshValues2 = (HashMap) hshValues.get("hshValues2");
			hshValues3 = (HashMap) hshValues.get("hshValues3");
			hshValues7 = (HashMap) hshValues.get("hshValues7");
			hshborrower = (HashMap) hshValues.get("hshborrower");
			hshEvaluation = (HashMap) hshValues.get("hshEvaluation");
			hshReliefSought = (HashMap) hshValues.get("hshReliefSought");
			hshModulardues = (HashMap) hshValues.get("hshModulardues");
			hshComments = (HashMap) hshValues.get("hshComments");
			hshTermscond = (HashMap) hshValues.get("hshTermscond");
			hshSignatories = (HashMap) hshValues.get("hshSignatories");
			//out.println(hshComments);

			//out.print(hshComments);
			String proposal = "";
			String strproposal = Helper.correctNull((String) hshComprogeneral
					.get("propfor"));
			if (!strproposal.equalsIgnoreCase("")) {
				if (strproposal.equalsIgnoreCase("1")) {
					proposal = "COUNTER OFFER";
				}
				if (strproposal.equalsIgnoreCase("2")) {
					proposal = "COMPROMISE SETTLEMENT";
				}

			}

			hshValues3 = (HashMap) hshValues.get("hshValues3");

			hshValues6 = (HashMap) hshValues.get("hshValues6");

			hshValues7 = (HashMap) hshValues.get("hshValues7");
			hshValues8 = (HashMap) hshValues.get("hshValues8");
			//hshborrower=(HashMap)hshValues.get("hshborrower");
			ArrayList vecCol = new ArrayList();
			ArrayList vecRow = new ArrayList();

			String strCategoryType = Helper.correctNull((String) request
					.getParameter("hidtype"));
			if (strCategoryType == "") {
				strCategoryType = Helper.correctNull((String) hshValues
						.get("strCategoryType"));
			}
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}

			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);

			java.text.NumberFormat nf1 = java.text.NumberFormat.getInstance();
			nf1.setMaximumFractionDigits(1);
			nf1.setMinimumFractionDigits(1);
			nf1.setGroupingUsed(false);
			String strProposalin = Helper.correctNull((String) hshValues
					.get("proposalin"));
			String strProposalsin = "";
			if (strProposalin.equalsIgnoreCase("A")) {
				strProposalsin = "Rs.";
			} else if (strProposalin.equalsIgnoreCase("T")||strProposalin.equalsIgnoreCase("HC")) {
				strProposalsin = "Thousands";
			} else if (strProposalin.equalsIgnoreCase("L")) {
				strProposalsin = "Lacs";
			} else if (strProposalin.equalsIgnoreCase("C")) {
				strProposalsin = "Crores";
			}
			String strSanctauth = Helper.correctNull((String) hshSignatories
					.get("sancauth"));
			%>



<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="25px"
	topmargin="25px" marginwidth="25px" marginheight="25px">
<table width="90%" border="0" cellspacing="0" cellpadding="3"
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
		<td align="center"><b><%=Helper.correctNull((String) hshValues.get("branchname"))%></b>&nbsp;<hr></td>
	</tr>
	
	<tr>
		<td align="center"><strong>CREDIT RECOVERY &amp; LEGAL SERVICES
		DEPARTMENT</strong></td>
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
		<td align="center"><b>PROPOSAL FOR &nbsp;<%=proposal%></b></td>
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
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			align="center">
			<tr>
				<td width="5%" valign="top"><b>1.&nbsp;</b></td>
				<td valign="top"><b>ACCOUNT</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) request
							.getParameter("borrowername"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>BRANCH</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="49%">&nbsp;<%=Helper.correctNull((String) hshValues.get("branchname"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>REGION</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="49%">&nbsp;<%=Helper.correctNull((String) hshValues.get("regionname"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>ZONE</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="49%">&nbsp;<%=Helper.correctNull((String) hshValues.get("zonalname"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>2.&nbsp;</b></td>
				<td width="44%" valign="top"><b>PRESENT CLASSIFICATION</b></td>
				<td width="1%" valign="top"><b>:</b></td>
				<td width="50%" valign="top">&nbsp;<%=Helper.correctNull((String) hshComprogeneral
							.get("presentclassification"))%></td>
			</tr>
			<tr>
				<td valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>RUNNING LEDGER OUTSTANDING</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("totalrunningledger"))))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>CRYSTALLISED DUES</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues3
									.get("crystaliseddues"))))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>PROVISION HELD</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshComprogeneral
									.get("provision"))))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>OTS AMOUNT PROPOSED</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshComprogeneral
									.get("propamt"))))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top"><b>EFFECT ON PROFITABILTY</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hshComprogeneral
							.get("compro_effectprofit"))%></td>
			</tr>
			<tr>
				<td valign="top"><b>3.a.&nbsp;</b></td>
				<td><b>CONSTITUTION</b></td>
				<td><b>:</b></td>
				<td>&nbsp;<%=Helper.correctNull((String) hshComprogeneral
							.get("constitution"))%></td>
			</tr>
			<tr>
				<td valign="top"><b>3.b.&nbsp;</b></td>
				<td><b>NAME OF PARTNERS/ PROPRIETOR/ DIRECTORS/ GUARANTORS</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td><b>&nbsp;</b></td>
				<td colspan="3">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr class="tblhead">
						<td>S.no</td>
						<td>TYPE OF APPLICANT</td>
						<td>NAME OF APPLICANT</td>
						<td>NATURE OF BUSINESS</td>
					</tr>
					<%vecRow = (ArrayList) hshborrower.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
					<tr>
						<td align="center"><font size="1" face="MS Sans Serif"> <%=i + 1%></font></td>
						<%String applicant = Helper.correctNull((String) vecCol
							.get(1));
					if (applicant.equalsIgnoreCase("app")) {
						applicant = "APPLICANT";
					} else if (applicant.equalsIgnoreCase("gua")) {
						applicant = "GUARANTOR";
					}%>
						<td align="center">&nbsp;<%=applicant%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
					</tr>
					<%}
			}%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%"><b>3.c.&nbsp;</b></td>
				<td valign="top"><b>BANKING SINCE</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hshComprogeneral
							.get("banksince"))%></td>
			</tr>
			<tr>
				<td valign="top"><b>3.d.&nbsp;</b></td>
				<td valign="top"><b>ADVANCE SINCE</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hshComprogeneral
							.get("advancesince"))%></td>
			</tr>
			<tr>
				<td valign="top"><b>3.e.&nbsp;</b></td>
				<td valign="top"><b>SECTOR CODE</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hshComprogeneral
							.get("sector"))%></td>
			</tr>
			<%String strfraud = "";
			String fraud = Helper.correctNull((String) hshComprogeneral
					.get("fraud"));
			if (!fraud.equalsIgnoreCase("null")) {
				if (fraud.equalsIgnoreCase("1")) {
					strfraud = "Yes";
				}
				if (fraud.equalsIgnoreCase("2")) {
					strfraud = "No";
				}
			}

			%>
			<tr>
				<td valign="top"><b>3.f.&nbsp;</b></td>
				<td valign="top"><b>WHETHER ACCOUNT IS CLASSIFIED AS FRAUD?</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=strfraud%>
			</tr>
			<%String strdefault = "";
			String default1 = Helper.correctNull((String) hshComprogeneral
					.get("defaulter"));
			if (!default1.equalsIgnoreCase("null")) {
				if (default1.equalsIgnoreCase("1")) {
					strdefault = "Yes";
				}
				if (default1.equalsIgnoreCase("2")) {
					strdefault = "No";
				}
			}

			%>
			<tr>
				<td valign="top"><b>3.g.&nbsp;</b></td>
				<td valign="top"><b>WHETHER ACCOUNT IS CLASSIFIED AS WILFULL
				DEFAULTER?</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=strdefault%></td>
			</tr>
			<tr>
				<td width="5%"><b>4.a.&nbsp;</b></td>
				<td valign="top"><b>NPA SINCE</b></td>
				<td valign="top"><b>:</b></td>
				<td valign="top">&nbsp;<%=Helper.correctNull((String) hshComprogeneral
							.get("npasince"))%></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>4.b.&nbsp;</b></td>
				<td valign="top"><b>REASONs FOR ACCOUNT TURNING IRREGULAR/NPA</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshValues2
							.get("irregularreasons"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>4.c.&nbsp;</b></td>
				<td valign="top"><b>STEPS TAKEN TO RECOVER DUES</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshValues2
							.get("recoverduesteps"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>4.d.&nbsp;</b></td>
				<td valign="top"><b>DETAILS OF LEGAL ACTION INITIATED</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshValues2
									.get("legalaction"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>4.e.&nbsp;</b></td>
				<td valign="top"><b>DETAILS OF SARFAESIA ACTION INITIATED</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshValues2
							.get("sarfaesiaaction"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>4.f.&nbsp;</b></td>
				<td valign="top"><b>DETAILS OF BIRF ACTION, IF ANY</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshValues2
									.get("bifraction"))%>&nbsp;</p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>5.&nbsp;</b></td>
				<td valign="top"><b>BRIEF HISTORY</b></td>
				<td valign="top"><b>:</b></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td valign="top" colspan="3">
				<p><%=Helper.correctNull((String) hshValues2
							.get("briefhistory"))%>&nbsp;</p>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="5%" valign="top"><b>6.&nbsp;</b></td>
				<td><b>PRESENT POSITION</b></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><b>(Amount in <%=strProposalsin%>)</b>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
				<div id="top">
				<table width="80%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr class="tblhead">
						<td>NATURE OF LIMIT</td>
						<td>AMOUNT OF LIMIT</td>
						<td>RUNNING LEDGER O/S</td>
						<td>PRUD ENTI ALLY WRIT TEN OFF</td>
						<td>ECGC / DICGC / CGFT CLAIM APPROP RIATED</td>
						<td>SUB - TOTAL</td>
						<td>UN RECOV ERED INT</td>
						<td>NET DUES</td>
						<td>DUMMY LEDGER INT</td>
						<td>LEGAL / OTHER EXP</td>
						<td>TOTAL DUES</td>
					</tr>
					<%vecRow = (ArrayList) hshValues7.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
					<tr>
						<td width="10%">&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(2)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(3)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(4)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(5)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(6)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(7)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(8)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(11)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(12)),
									strProposalin)%></td>
						<td width="10%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(13)),
									strProposalin)%></td>
					</tr>
					<%}
			}

			%>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="5%" valign="top"><b>6.a.&nbsp;</b></td>
				<td><b>SECURITIES</b></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><b>(Amount in <%=strProposalsin%>)</b>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr class="tblhead">
						<td width="3%" rowspan="2">S.No</td>
						<td width="13%" rowspan="2" align="center"><b>TYPE OF SECURITY</b></td>
						<td width="13%" rowspan="2" align="center"><b>NATURE</b></td>
						<td colspan="2" align="center"><b>AT THE TIME OF RENEWAL</b></td>
						<td colspan="4" align="center"><b>PRESENT POSITION</b></td>
					</tr>
					<tr class="tblhead">
						<td width="13%" align="center"><b>VALUATION DATE</b></td>
						<td width="13%" align="center"><b> VALUATION AMOUNT</b></td>
						<td width="13%" align="center"><b> VALUATION DATE</b></td>
						<td width="13%" align="center"><b>VALUATION AMOUNT</b></td>
						<td width="8%" align="center"><b>INSPECTION DATE</b></td>
						<td width="11%" align="center"><b>INSPECTED BY</b></td>
					</tr>
					<%vecRow = (ArrayList) hshValues8.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
					<tr>
						<td width="3%" align=center>&nbsp;<%=i + 1%></td>
						<%String security = Helper.correctNull((String) vecCol
							.get(1));
					if (security.equalsIgnoreCase("p")) {
						security = "PRIMARY";
					} else if (security.equalsIgnoreCase("c")) {
						security = "COLLATERAL";
					}

					%>
						<td width="13%">&nbsp;<%=security%></td>
						<td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
						<td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(4)),
									strProposalin)%></td>
						<td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(6)),
									strProposalin)%></td>
						<td width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
						<td width="11%">&nbsp;<%=Helper.correctNull((String) vecCol.get(8))%></td>
					</tr>
					<%}
			} else {

			%>
					<tr>
						<td align center colspan="11"><font size="1" face="MS Sans Serif">No
						Data Found</font></td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
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
				<td width="5%" valign="top"><b>6.b.&nbsp;</b></td>
				<td><b>MEANS</b></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><b>(Amount in <%=strProposalsin%>)</b>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr class="tblhead">
						<td width="3%" rowspan="2" class="tabactive">S.No</td>
						<td width="17%" rowspan="2" class="tabactive" align="center"><b>TYPE
						OF APPLICANT</b></td>
						<td width="20%" rowspan="2" class="tabactive" align="center"><b>NAME
						OF APPLICANT</b></td>
						<td colspan="2" class="tabactive" align="center"><b>AT THE TIME OF
						RENEWAL</b></td>
						<td class="tabactive" align="center" colspan="2"><b>PRESENT
						POSITION</b></td>
					</tr>
					<tr class="tblhead">

						<td width="15%" class="tabactive" align="center"><b>MEANS</b></td>
						<td width="16%" class="tabactive" align="center"><b>DATE</b></td>
						<td width="13%" class="tabactive" align="center"><b>MEANS</b></td>
						<td width="16%" class="tabactive" align="center"><b>DATE</b></td>
					</tr>
					<%vecRow = (ArrayList) hshborrower.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);

					%>
					<tr>
						<td width="3%" align=center>&nbsp;<%=(i + 1)%></td>


						<td width="17%">&nbsp;<%=Helper.correctNull((String) vecCol
											.get(11))%></td>
						<td width="20%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
						<td width="15%" align="right">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(4)),
									strProposalin)%></td>
						<td width="16%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) vecCol.get(6)),
									strProposalin)%></td>
						<td width="16%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
					</tr>
					<%}
			} else {

			%>
					<tr>
						<td align center colspan="9" height="12"><font size="1"
							face="MS Sans Serif">No Data Found</font></td>
					</tr>
					<%}

			%>
				</table>
				</div>
				</td>
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
				<td width="5%" valign="top"><b>7.&nbsp;</b></td>
				<td width="95%"><b>SETTLEMENT PROPOSAL</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshComments
							.get("settlementproposal"))%></p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>7.a.&nbsp;</b></td>
				<td width="95%"><b>SCHEDULE OF PAYMENT : </b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshComments
							.get("paymentschedule"))%></p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>8.&nbsp;</b></td>
				<td width="95%"><b>ECGC/DICGC/CGFT CLAIM: </b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshComments
							.get("claimdetails"))%></p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>9.&nbsp;</b></td>
				<td width="95%"><b>SOURCE OF PAYMENT:</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshComments
							.get("paymentsource"))%></p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>10.&nbsp;</b></td>
				<td width="95%"><b>NON FUND BASED DUES AND PROPOSED TREATMENT</b>:</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshComments
							.get("nfbduestreatment"))%></p>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>11.&nbsp;</b></td>
				<td width="95%"><b>EVALUATION MODULE :</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr class="tblhead">
						<td width="7%">&nbsp;SR.NO</td>
						<td width="47%">PARAMETER</td>
						<td width="31%">PARTICULARS</td>
						<td width="15%">POINTS</td>
					</tr>
					<tr>
						<td width="7%" align="center">1</td>
						<td width="47%">REALISABLE VALUE OF SECURITIES</td>
						<td width="31%">&nbsp;<%=Helper.correctNull((String) hshEvaluation
							.get("MarketDesc"))%></td>
						<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues3
							.get("securities_value"))%></td>
					</tr>
					<tr>
						<td width="7%" align="center">2</td>
						<td width="47%">AGGREGATE MEANS OF THE BORROWER/GUARANTORS</td>
						<td width="31%">&nbsp;<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshEvaluation
									.get("aggregatemeansparticulars"))))%>% of crystalised Dues</td>
						<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues3
									.get("means_value"))%></td>
					</tr>
					<tr>
						<td width="7%" align="center">3</td>
						<td width="47%">AGE OF NPA</td>
						<td width="31%">&nbsp;<%=Helper.correctNull((String) hshValues3.get("npa_age"))%>
						Years</td>
						<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues3.get("npa_value"))%></td>
					</tr>
					<tr>
						<td width="7%" align="center">4</td>
						<td width="47%">LEGAL POSITION</td>
						<td width="31%">&nbsp;<%=Helper.correctNull((String) hshValues3
							.get("Legal_position"))%></td>
						<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues3
							.get("legalposition_value"))%></td>
					</tr>
					<tr>
						<td width="7%">&nbsp;</td>
						<td width="47%" align="center"><b>NET SCORE</b></td>
						<td width="31%">&nbsp;</td>
						<td width="15%">&nbsp;<%=Helper.correctNull((String) hshValues3
							.get("netscore_points"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right"><b>(Amount in <%=strProposalsin%>)</b>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr>
						<td>Realisable Value of available securities</td>
						<td><%=Helper.converAmount(Helper
							.correctNull((String) hshValues3
									.get("realisablevalue")), strProposalin)%></td>
					</tr>
					<tr>
						<td>Rate to be applied for discount purposes(R)</td>
						<td><%=Helper.correctNull((String) hshValues3.get("roi"))%>&nbsp;%</td>
					</tr>
					<tr>
						<td>Time Period for which the value is dicounted(n)</td>
						<td><%=Helper.correctNull((String) hshValues3
									.get("years"))%> &nbsp; years</td>
					</tr>
					<tr>
						<td>Then Net Present value (NPV)</td>
						<td><%=Helper.converAmount(Helper
							.correctNull((String) hshValues3.get("npv")),
							strProposalin)%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>12.&nbsp;</b></td>
				<td width="95%"><b>MODULAR DUES:</b></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><b>(Amount in <%=strProposalsin%>)</b>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<div id="top">
				<table border="0" cellspacing="0" cellpadding="3" align="center">
					<tr>
						<td width="51%">AMOUNT PAYABLE AS PER MODULE:</td>
						<td>&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshModulardues
									.get("moduleminamt")), strProposalin)%>-<%=Helper.converAmount(Helper
							.correctNull((String) hshModulardues
									.get("modulemaxamt")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="51%">SETTLEMENT AMOUNT OFFERED</td>
						<td>&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshModulardues
									.get("settlementamt")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="51%">DEVIATION IF ANY, AND JUSTIFICATION THEREOF</td>
						<td>&nbsp;<%=Helper.correctNull((String) hshModulardues
							.get("deviationreason"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>13.&nbsp;</b></td>
				<td width="95%"><b>RELIEF SOUGHT</b></td>
			</tr>
			<tr>
				<td colspan="2" align="right"><b>(Amount in <%=strProposalsin%>)</b>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr class="tblhead">
						<td width="49%">&nbsp;</td>
						<td width="24%">AS PER CONTRACTUAL RATES</td>
						<td width="27%">AS PER NOTIONAL RATE</td>
					</tr>
					<tr>
						<td width="49%">RUNNING LEDGER AS ON <%=Helper.correctNull((String) hshReliefSought
							.get("npa_runningledgerdate"))%></td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) hshReliefSought
											.get("runningoutstanding")),
									strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) hshReliefSought
											.get("runningoutstanding")),
									strProposalin)%></td>
					</tr>
					<tr>
						<td width="49%">LESS: UNRECOVERED INTEREST</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("unrecoveredint")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("unrecoveredint")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="49%">NETDUES</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("netdues")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("netdues")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="49%">UNAPPLIED INTEREST(DUMMY INTEREST FROM&nbsp;<%=Helper.correctNull((String) hshReliefSought
							.get("datefrom"))%> TO &nbsp;<%=Helper.correctNull((String) hshReliefSought
									.get("dateto"))%></td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("dummyamt")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("dummyamt")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="49%">LEGAL CHARGES/OTHER EXPENSES</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("legalotrexp")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("legalotrexp")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="49%">TOTAL DUES</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
									.correctNull((String) hshReliefSought
											.get("Contractualtotdues")),
									strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("Notionaltotdues")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="49%">SETTLEMENT AMOUNT</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("settlementamt")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("settlementamt")), strProposalin)%></td>
					</tr>
					<tr>
						<td width="49%">SACRIFICE AMOUNT</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("Contractualsacrificeamt")),
							strProposalin)%></td>
						<td align="right" width="27%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("Notionalsacrificeamt")),
							strProposalin)%></td>
					</tr>
					<tr>
						<td colspan="3">OF WHICH</td>
					</tr>
					<tr>
						<td width="49%">WRITE-OFF</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("sacrificewriteoff")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp; <%//=nf.format(Double.parseDouble(Helper.correctDouble((String)hshReliefSought.get("writeoff"))))%>
						</td>
					</tr>
					<tr>
						<td width="49%">WAIVER OF INTEREST</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("waiveramt")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp; <%//=nf.format(Double.parseDouble(Helper.correctDouble((String)hshReliefSought.get("waiver"))))%>
						</td>
					</tr>
					<tr>
						<td width="49%">LEGAL EXPENSES</td>
						<td align="right" width="24%">&nbsp;<%=Helper.converAmount(Helper
							.correctNull((String) hshReliefSought
									.get("legalotrexp")), strProposalin)%></td>
						<td align="right" width="27%">&nbsp; <%//=nf.format(Double.parseDouble(Helper.correctDouble((String)hshReliefSought.get("absorptionlegal"))))%>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>

			<tr>
				<td width="5%" valign="top"><b>14.&nbsp;</b></td>
				<td width="95%"><b>STAFF ACCOUNTABILITY</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshValues2
							.get("staffaccountability"))%>&nbsp;</p>
				</td>
			</tr>
			<%if (!Helper.formatTextAreaData(
					(String) hshValues6.get("BRrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="95%"><b>BRANCH RECOMMENDATION</b></td>
			</tr>


			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshValues6
								.get("BRrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshValues6.get("ROrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="95%"><b>REGIONAL OFFICE RECOMMENDATION</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshValues6
								.get("ROrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshValues6.get("FGMOrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="95%"><b>FGMO RECOMMENDATION</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshValues6
								.get("FGMOrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<%if (!Helper.formatTextAreaData(
					(String) hshValues6.get("CRLDrecommendation"))
					.equalsIgnoreCase("")) {

				%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="95%"><b>C.R.L.D., CENTRAL OFFICE RECOMMENDATION</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshValues6
								.get("CRLDrecommendation"))%>&nbsp;</p>
				</td>
			</tr>
			<%}

			%>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td width="95%"><b>TERMS AND CONDITIONS:</b></td>
			</tr>
			<tr>
				<td width="5%" valign="top"><b>&nbsp;</b></td>
				<td>
				<p><%=Helper.formatTextAreaData((String) hshTermscond
							.get("termscond"))%>&nbsp;</p>
				</td>
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
