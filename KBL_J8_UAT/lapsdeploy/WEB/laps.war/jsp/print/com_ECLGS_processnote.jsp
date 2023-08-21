<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	request.setAttribute("_cache_refresh", "true");
%>
<laps:handleerror />
<%
	String strOrgLevel = (String) session.getAttribute("strOrgLevel");
	String strFinancialrequired = "";
	String strLoanType = "";
	boolean finacial_flag = false;
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ArrayList arrFacRow = new ArrayList();
	ArrayList arrRecommRow = new ArrayList();
	ArrayList arrRowNonBr = new ArrayList();
	ArrayList arrColNonBr = new ArrayList();
	ArrayList arrDeleRow = new ArrayList();
	ArrayList arrBAOurRow = new ArrayList();
	ArrayList arrFACexistingRow = new ArrayList();
	ArrayList arrFAConlyRow = new ArrayList();
	ArrayList arrGECL = new ArrayList();
	ArrayList arrGECL1 = new ArrayList();
	ArrayList arrRowtemp= new ArrayList();
	ArrayList arrColtemp= new ArrayList();
	ArrayList arrRowprop= new ArrayList();  
	ArrayList arrColprop= new ArrayList();

	ArrayList arrFacilityTerm0 = (ArrayList) hshValues
			.get("arrFacilityTerm0");
	ArrayList arrFacilityIdVal0 = (ArrayList) hshValues
			.get("arrFacilityIdVal0");
	ArrayList arrParentID0 = (ArrayList) hshValues.get("arrParentID0");
	ArrayList arrFacilityTermApp0 = (ArrayList) hshValues
			.get("arrFacilityTermApp0");

	ArrayList arrPresentTL = new ArrayList();
	ArrayList arrMCLRRow = new ArrayList();
	ArrayList arrRowcgssd= new ArrayList();
	ArrayList arrColcgssd= new ArrayList();

	double dblVal = 0.00;
	boolean booAssFlag = true;
	int count = 0;

	String str_arry = Helper.correctNull((String) hshValues
			.get("str_arr"));

	if (hshValues != null && hshValues.size() > 0) {
		arrRow = (ArrayList) hshValues.get("arrRow");
		arrFacRow = (ArrayList) hshValues.get("arrFacRow");
		arrRecommRow = (ArrayList) hshValues.get("arrRecommRow");
		arrRowNonBr = (ArrayList) hshValues.get("arrRowNonBr");
		arrDeleRow = (ArrayList) hshValues.get("arrDeleRow");
		arrBAOurRow = (ArrayList) hshValues.get("arrBAOurRow");
		arrGECL = (ArrayList) hshValues.get("arrGECL");
		arrGECL1=(ArrayList) hshValues.get("arrGECL1");
		arrFACexistingRow = (ArrayList) hshValues
				.get("arrFACexistingRow");
		arrFAConlyRow = (ArrayList) hshValues.get("arrFAConlyRow");
		strLoanType = Helper.correctNull((String) hshValues
				.get("strLoanTypeNew"));
		strFinancialrequired = Helper.correctNull((String) hshValues
				.get("Financialrequired"));
		arrRowprop= (ArrayList)hshValues.get("arrRowprop");

		if (strLoanType.equalsIgnoreCase("a")) {
			if (strFinancialrequired.equalsIgnoreCase("Y")) {
				finacial_flag = true;

			}

		} else {
			finacial_flag = true;
		}

		arrPresentTL = (ArrayList) hshValues.get("arrPresentTL");
		arrMCLRRow = (ArrayList) hshValues.get("arrMCLR");
		arrRowcgssd= (ArrayList)hshValues.get("arrRowcgssd");
	}

	String strOutstandingDate = Helper.correctNull((String) hshValues
			.get("strOutstandingDate"));
	String strWhetherBRAvail = Helper.correctNull((String) hshValues
			.get("strWhetherBRAvail"));
	String strValIn = Helper.correctNull((String) hshValues
			.get("strValuesIn"));
	String strTLValIn = "", strValuesIn = "", strNil = "Nil", strPreWC = "", strExiWC = "";
	String strAmountValue = Helper.correctNull((String) hshValues
			.get("strAmountValue"));
	String strAmtValueIn = Helper.correctNull((String) hshValues
			.get("strAmtValueIn"));
	String strFinValuesIn = Helper.correctNull((String) hshValues
			.get("strFinvalues"));
	if (strValIn.equalsIgnoreCase("Rs")) {
		strValuesIn = "(Amount in  " + strValIn + ".)";
		strTLValIn = "";
	} else {
		strValuesIn = "(Rs. in  " + strValIn + ")";
		strTLValIn = strValIn;
	}

	if (strAmtValueIn.equalsIgnoreCase("Rs")) {
		strAmtValueIn = "(Amount in  " + strAmtValueIn + ".)";
	} else {
		strAmtValueIn = "(Rs. in  " + strAmtValueIn + ")";
	}
	if (strFinValuesIn.equalsIgnoreCase("C")) {
		strFinValuesIn = "( Rs. in Crore )";
	} else if (strFinValuesIn.equalsIgnoreCase("L")) {
		strFinValuesIn = "( Rs. in Lacs )";
	} else {
		strFinValuesIn = "( Amount in Rs. )";
	}
	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);

	String strSancAuth = Helper.correctNull((String) hshValues
			.get("com_sancauthority"));
	String strGroupSecFlag="",strSec_groupcomments="";
	String strProposedSecurity = "", strProposedSecurityComments = "";
	HashMap hshAN3 = new HashMap();
	ArrayList arrpropsecCollRow = new ArrayList();
	ArrayList arrproposedFacility = new ArrayList();
	ArrayList arrproposedCollateralSec = new ArrayList();
	ArrayList arrproposedSecfacwise = new ArrayList();
	ArrayList arrRowCollSec = new ArrayList();
	ArrayList arrpropsecurityRow=new ArrayList();
	String strFlag = "";
	String strAppSecFlag = "";
	String strAppSecManualFlag = "", str_presanccommentsforannex = "", str_postsanccommentsforannex = "";
	hshAN3 = (HashMap) hshValues.get("AN3");
	HashMap hshSecdata = new HashMap();
	if (hshAN3 != null) {
		strGroupSecFlag=Helper.correctNull((String)hshAN3.get("COMSEC_GROUPCOVERAGE"));
		strSec_groupcomments=Helper.correctNull((String)hshAN3.get("COMSEC_GROUPCOMMENTS"));
		arrpropsecurityRow=(ArrayList)hshAN3.get("arrExistingSecfacwise");
		arrpropsecCollRow = (ArrayList) hshAN3
				.get("arrcollateralforEF");
		arrproposedCollateralSec = (ArrayList) hshAN3
				.get("arrproposedCollateralSec");
		arrproposedFacility = (ArrayList) hshAN3
				.get("arrproposedFacility");
		strProposedSecurity = Helper.correctNull((String) hshAN3
				.get("strProposedSecurity"));
		strProposedSecurityComments = Helper
				.correctNull((String) hshAN3
						.get("strProposedSecurityComments"));
		strAppSecFlag = Helper.correctNull((String) hshAN3
				.get("COMSEC_APPCOVERAGE"));
		strAppSecManualFlag = Helper.correctNull((String) hshAN3
				.get("COMSEC_SECTYPE"));
		arrproposedSecfacwise = (ArrayList) hshAN3
				.get("arrproposedSecfacwise");
		arrRowCollSec = (ArrayList) hshAN3.get("arrRowCollSec");
		hshSecdata = (HashMap) hshAN3.get("hshsecdet");
		if (hshSecdata != null)
			strFlag = Helper.correctNull((String) hshSecdata
					.get("strFlag"));

	}
	str_presanccommentsforannex = Helper.correctNull((String) hshValues
			.get("cmt_presanccomments"));
	str_postsanccommentsforannex = Helper
			.correctNull((String) hshValues.get("cmt_postsanccomments"));
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	ArrayList arrMISRow = (ArrayList) hshValues.get("arrMISRow");
	ArrayList arrColMIS = new ArrayList();
	HashMap hshValuesPromotor = (HashMap)hshValues.get("PROPOSALLC");
	String strratingperc=Helper.correctNull((String)hshValues.get("COM_CGSSDPERC"));
	String strDesc[] = { "Capital of the entity", "Promoters Stake",
			"Eligible Amount", "Amount Applied", "Liability of the entity",
			"Maximum loan under the scheme","Recommended (lower of 3,4,5,6)",
			"Entity Name","Operative account number where the borrower is a promoter","Status of the entity","NPA Date"};
	String strmisDesc[] = { "Facility Desc","Type of Facility and Facility Serial Number",
			"Activity Code", "Main Activity", "Sub Activity",
			"Agriculture/Industry/Service Category type","Sector",
			"Sub sector","Sensitive sector",
			"StandUp India","Government announced scheme","Guarantee Cover By",
			"Guarantee Covered Amount","Sales Turnover of the Applicant",
			"Sales Turnover As on Date",
			"Criteria for Sales Turnover","Investment in Plant & Machineries/Equipments","Industry Name",
			"Investment value as on Date","Criteria for Investment value","Weaker Section","Whether Start up as per definition of Ministry of Commerce and Industry"
			};
	String strAppType=Helper.correctNull((String)hshValues.get("strAppType"));
	String strgecltype=Helper.correctNull((String) hshValues.get("COM_GECLTYPE"));
	if(strAppType.equalsIgnoreCase("S")){
		if(strgecltype.equalsIgnoreCase("GECL1")){
			strgecltype="GECL1-Restructure";
		}
	}else{
		strgecltype=Helper.correctNull((String) hshValues.get("COM_GECLTYPE"));
	}
	
%>

<html>
<head>
<title>KBL - ECLGS Process Note</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}

#top {
	background-color: #ffffff;
}

#top table {
	border-collapse: collapse;
}

#top td {
	border: 0.5pt solid #000000;
	FONT-SIZE: 16px;
	COLOR: #000000;
	LINE-HEIGHT: 16px;
	FONT-FAMILY: "Book Antiqua"
}

.title {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
	font-weight: bold !important;
}
</style>

</head>
<body contentEditable="false" designMode="on">
<table width="95%" align="center" cellpadding="3" cellspacing="0"
	border="0">
	<tr>
		<td align="center"><br>
		<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	</tr>

	<%
		{
	%>
	<%
		if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("008")) {
	%>
	<tr>
		<td align="center" width="50%">Credit LCFD
		</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("010")) {
				String strComSancbranchcode = Helper
						.correctNull((String) hshValues
								.get("com_sancbranchcode"));
				if (strComSancbranchcode.equalsIgnoreCase("MCFD"))
					strComSancbranchcode = "Credit MCFD";
				else
					strComSancbranchcode = "Credit RFD";
	%>
	<tr>
		<td align="center" width="50%"><%=strComSancbranchcode%>
		</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("013")) {
	%>
	<tr>
		<td align="center" width="50%">Credit RFD</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("014")) {
	%>
	<tr>
		<td align="center" width="50%">Credit MCFD</td>
	</tr>
	<%
		} else if (Helper.correctNull(
					(String) hshValues.get("com_sancdeptcode"))
					.equalsIgnoreCase("015")
					|| Helper.correctNull(
							(String) hshValues.get("com_sancdeptcode"))
							.equalsIgnoreCase("016")) {
	%>
	<tr>
		<td align="center" width="50%"><%=Helper.correctNull((String) hshValues
									.get("strSanctiondept"))%></td>
	</tr>
	<%
		} else {
	%>
	<tr>
		<td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull(
									(String) hshValues.get("strOrgName"))
									.toUpperCase()%></td>
	</tr>
	<%
		}
	%>
	<%
		}
	%>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class="title" align="center"><br>
		
		KBL - <%=strgecltype%> Process Note</td>
	</tr>
	<tr>
		<td align="right" width="50%">Date&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues
							.get("com_processnotedate"))%></td>
	</tr>
	<tr>
		<td align="right" width="50%"><b>Proposal No&nbsp;:&nbsp;</b><%=Helper.correctNull((String) request
									.getParameter("appno"))%></td>
	</tr>
	<tr>
		<td width="50%">
		<table width="95%" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td>
				<table width="95%" cellpadding="3" cellspacing="0" border="0">

					<tr>
						<td align="left" width="30%">PARTY FILE NO&nbsp;:&nbsp; <%
 	if (strOrgLevel.equalsIgnoreCase("A")) {
 %> <%=Helper.correctNull((String) hshValues
								.get("com_partyfileno"))%> <%
 	} else {
 %> <%=Helper.correctNull((String) hshValues
										.get("com_roho"))%> <%
 	}
 %>
						</td>
					</tr>
					<tr>
						<td align="left">BRANCH&nbsp;:&nbsp;<%=Helper.changetoTitlecase(
							Helper.correctNull((String) hshValues
									.get("org_name"))).toUpperCase()%></td>
					</tr>
					<tr>
						<td align="left">REGION&nbsp;:&nbsp;<%=Helper.changetoTitlecase(
							Helper.correctNull((String) hshValues
									.get("Reg_org_name"))).toUpperCase()%></td>
					</tr>


				</table>
				</td>
				<td width="50%">
				<div id="top">
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td align="center" colspan="2">PROPOSAL FLOW CHART</td>
					</tr>
					<tr>
						<td align="left" width="40%">Date of Credit Application</td>
						<td align="center" width="10%"><%=Helper.correctNull((String) hshValues
							.get("inward_appliedon"))%></td>
					</tr>
					<tr>
						<td align="left">Date of receipt at HO/RO with Branch
						recommendations</td>
						<td align="center"><%=Helper.correctNull((String) hshValues
							.get("com_branchrcvddate"))%></td>
					</tr>
					<%
						if (!Helper.correctNull((String) hshValues.get("strLodgedDate"))
								.equalsIgnoreCase("")) {
					%>
					<tr style="border-style: none;">
						<td colspan="2" valign="top" style="padding: 0px;">
						<table width="100%" align="center" cellpadding="0" cellspacing="0"
							border="0">
							<tr>
								<td width="30%" style="border-top: 0px; border-bottom: 0px;">Lodged
								On :</td>
								<td width="20%" align="center"
									style="border-top: 0px; border-bottom: 0px;"><%=Helper.correctNull((String) hshValues
								.get("strLodgedDate"))%>&nbsp;</td>
								<td width="30%" style="border-top: 0px; border-bottom: 0px;">Delodged
								On :</td>
								<td width="20%" align="center"
									style="border-top: 0px; border-bottom: 0px;"><%=Helper.correctNull((String) hshValues
								.get("strDelodgedDate"))%>&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<%
						}
					%>
					<tr>
						<td align="left">Date of receipt of complete information/
						papers at HO/RO</td>
						<td align="center"><%=Helper.correctNull((String) hshValues
							.get("com_branchcompletedate"))%></td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><br>
		<b> <%
 	if (strSancAuth.equalsIgnoreCase("15")
 			|| strSancAuth.equalsIgnoreCase("16")) {
 %> FOR THE MEETING OF <%=Helper.correctNull((String) hshValues
								.get("com_meeting"))%> DATED <%=Helper.correctNull((String) hshValues
								.get("com_meetingdate"))%> <%
 	} else {
 %> SUBMITTED TO THE <%=Helper.correctNull(
								(String) hshValues.get("com_submittedto"))
								.toUpperCase()%> <%
 	}
 %> <br>
		--------------------------------------------- </b></td>
	</tr>

	<tr>
		<td>This is a proposal received from <b><%=Helper.correctNull((String) hshValues.get("org_name"))%></b>
		Branch for considering the following credit facilities to <b><%=Helper.correctNull((String) hshValues
									.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues
									.get("perapp_name"))%></b>
		<br>
		<p align="justify"><%=Helper.correctNull((String) hshValues.get("GistOfProp"))%></p>
		</td>
	</tr>
	<tr>
		<td>
		<table width="95%" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td colspan="2">As per the Loan Application, the applicant has
				sought the following facilities: </td>
			</tr>
			<tr></tr>
			<tr><td align="right" width="100%" colspan="6">&nbsp;&nbsp;<%=strAmtValueIn%></td></tr>
			<tr>
				<td colspan="2">1. Fund Based</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;a. Working Capital</td>
				<td width="80%"><%=Helper.converAmount(Helper.formatDoubleValue(Double
							.parseDouble((String) hshValues
									.get("INWARD_WCLOANAMT"))),strAmountValue)%></td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;b. Term Loan</td>
				<td><%=Helper.converAmount(Helper.formatDoubleValue(Double
							.parseDouble((String) hshValues
									.get("INWARD_TERMLOANAMT"))),strAmountValue)%></td>
			</tr>
			<tr>
				<td>2. Non Fund Based</td>
				<td><%=Helper.converAmount(Helper.formatDoubleValue(Double
							.parseDouble((String) hshValues
									.get("INWARD_NONWCLOANAMT"))),strAmountValue)%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><!-- APPLICANT'S PROFILE -->
		<table width="100%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td><jsp:include page="../print/com_AnnexureII.jsp"
					flush="true">
					<jsp:param name="pageVal" value="ECLGS" />
				</jsp:include></td>
			</tr>
		</table>
		<!-- END --></td>
	</tr>
	<tr>
		<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0"
			border="0">
			<tr>
				<td class="title"><br>
				Details of the existing Credit facilities:</td>
			</tr>
			<%
				if (arrBAOurRow != null && arrBAOurRow.size() > 0) {
			%>
			<tr>
				<td align="right"><%=strAmtValueIn%></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td>
				<div id="top">
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<%
						if (arrBAOurRow != null && arrBAOurRow.size() > 0) {
					%>
					<tr>
						<td width="3%" align="center"><b>S.No</b></td>
						<td width="17%" align="center"><b>Nature of facility</b></td>
						<td width="10%" align="center"><b>Limit</b></td>
						<td width="10%" align="center"><b>Purpose</b></td>
						<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
						<td width="10%" align="center"><b>ROI/ Com %</b></td>
						<td width="10%" align="center"><b>Balance as on <%=strOutstandingDate%></b></td>
						<td width="10%" align="center"><b>Due Date</b></td>
						<td width="10%" align="center"><b>Arrears if any</b></td>
					</tr>
					<%
						double dbLimitTotal = 0.00, dbbalanceTotal = 0.00;
							for (int i = 0; i < arrBAOurRow.size(); i++) {
								arrCol = (ArrayList) arrBAOurRow.get(i);
								dbLimitTotal = dbLimitTotal
										+ Double.parseDouble(Helper
												.correctDouble((String) arrCol.get(2)));
								dbbalanceTotal = dbbalanceTotal
										+ Double.parseDouble(Helper
												.correctDouble((String) arrCol.get(6)));
					%>
					<tr>
						<td align="left"><%=i + 1%></td>
						<td align="left"><%=Helper.changetoTitlecase(
									Helper.correctNull((String) arrCol.get(0)))
									.toUpperCase()%></td>
						<td align="right"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(2))))),
													strAmountValue)%></td>
						<td align="left"><%=Helper.correctNull((String) arrCol.get(10))%></td>
						<td align="left"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;-&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
						<td align="right"><%=Helper.correctNull((String) arrCol.get(11))%>&nbsp;+&nbsp;<%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(5))))%>%
						p.a presently at &nbsp;<%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(12))))%>%
						p.a</td>
						<td align="right"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(6))))),
													strAmountValue)%></td>
						<td align="center"><%=Helper.correctNull((String) arrCol.get(8))%></td>
						<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td colspan="2" align="right"><b>Total</b></td>
						<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper
								.formatDoubleValue(dbLimitTotal)),
								strAmountValue)%></b></td>
						<td colspan="3">&nbsp;</td>
						<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper
								.formatDoubleValue(dbbalanceTotal)),
								strAmountValue)%></b></td>
						<td colspan="2">&nbsp;</td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td style="border: none;">- <%=strNil%> -</td>
					</tr>
					<%
						}
					%>
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					align="center">
					<tr>
						<td><br>
						<b>Asset classification :</b>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("strAssetClassification"))%>
						&nbsp;as on &nbsp;<%=Helper.correctNull((String) hshValues
							.get("com_asscladate"))%>
						</td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td>
				<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><u>SECURITIES : </u></b></td>
					</tr>
				</table>
				</td>
			</tr>
			
			<%
String secValue = "";
if(!strGroupSecFlag.equalsIgnoreCase("M")){
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>A. Already available for the existing facilities : </b><div align="right"><%=strAmtValueIn%></div></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td>
</tr>
<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>

<tr>
<td colspan="4"><b>Prime :</b></td>
</tr>

<% 

ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
	for(int i=0;i<arrpropsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
				  secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%> (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		 <td  align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>	
		<%} else {%>
		<tr><td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		</tr>
		<%	}}
	}
} }
%>
<%if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
<td colspan="4"><b>Collateral :</b></td>
</tr>
<% 
ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
	for(int i=0;i<arrpropsecCollRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
		 %>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td  align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	
	}
} }
%>
</TABLE>
</div><br>
</td>
</tr>
</table>
</td>
</tr>
<% }else{ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>A. Already available for the existing facilities : </b> Nil</td></tr>
</table>
</td></tr>
<%}}else if(strGroupSecFlag.equalsIgnoreCase("M")) {%>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>A. Already available for the existing facilities : </b> </td></tr>
<tr><td><%=strSec_groupcomments%></td></tr>
</table>
</td>
</tr>
<%} %>

			<%

				ArrayList arrpropsecurity = new ArrayList();
				ArrayList arrpropsecurityCol = new ArrayList();
				if ((arrproposedFacility != null && arrproposedFacility.size() > 0)
						|| (arrproposedCollateralSec != null && arrproposedCollateralSec.size() > 0)) {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						B.Additional / Fresh securities offered for the proposed
						facilities/Security released :</b>
						<div align="right"><%=strAmtValueIn%></div>
						</td>
					</tr>
					<tr>
						<td><b>Additional / Fresh Securities Offered :</b></td>
					</tr>
					<tr>
						<td>
						<div id="top">
						<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">


							<tr>
								<td align="center" width="20%"><b>Facility</b></td>
								<td align="center" width="55%"><b>Details of Security</b></td>
								<td align="center" width="10%"><b>Value</b></td>
								<td align="center" width="15%"><b>Date of Valuation</b></td>
							</tr>
							<%
								if (arrproposedFacility != null
											&& arrproposedFacility.size() > 0) {
							%>
							<tr align="left">
								<td colspan="4"><b>Prime :</b></td>
							</tr>
							<%
								for (int i = 0; i < arrproposedFacility.size(); i++) {
											arrpropsecurityCol = (ArrayList) arrproposedFacility
													.get(i);
											for (int k = 0; k < arrpropsecurityCol.size(); k++) {
												arrpropsecurity = (ArrayList) arrpropsecurityCol
														.get(k);
												if (k == 0) {
													secValue = Helper
															.converAmount(
																	Helper
																			.formatDoubleValue(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrpropsecurity
																									.get(3)))),
																	strAmountValue);
													if (secValue.equals("0.00"))
														secValue = " ";
							%>
							<tr>
								<td><%=Helper
														.correctNull((String) arrpropsecurity
																.get(0))%>
								(<%=Helper
														.converAmount(
																Helper
																		.correctNull(Helper
																				.formatDoubleValue(Double
																						.parseDouble(Helper
																								.correctDouble((String) arrpropsecurity
																										.get(1))))),
																strAmountValue)%>)</td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
														.correctNull((String) arrpropsecurity
																.get(2))%></td>
								<td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
														.correctNull((String) arrpropsecurity
																.get(4))%></td>
							</tr>
							<%
								} else {
							%>
							<tr>
								<td><%=Helper
														.correctNull((String) arrpropsecurity
																.get(0))%>
								(<%=Helper
														.converAmount(
																Helper
																		.correctNull(Helper
																				.formatDoubleValue(Double
																						.parseDouble(Helper
																								.correctDouble((String) arrpropsecurity
																										.get(1))))),
																strAmountValue)%>)</td>
							</tr>
							<%
								}
											}
										}
									}

									arrpropsecurity = new ArrayList();
									arrpropsecurityCol = new ArrayList();
									secValue = "";
							%>
							<%
								if (arrproposedCollateralSec != null
											&& arrproposedCollateralSec.size() > 0) {
							%>
							<tr align="left">
								<td colspan="4"><b>Collateral :</b></td>
							</tr>
							<%
								for (int i = 0; i < arrproposedCollateralSec.size(); i++) {
											arrpropsecurityCol = (ArrayList) arrproposedCollateralSec
													.get(i);
											secValue = Helper
													.converAmount(
															Helper
																	.formatDoubleValue(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrpropsecurityCol
																							.get(1)))),
															strAmountValue);
											if (secValue.equals("0.00"))
												secValue = " ";
							%>
							<tr>
								<td colspan="2"><%=Helper
												.correctNull((String) arrpropsecurityCol
														.get(0))%></td>
								<td align="right"><%=Helper.correctNull(secValue)%></td>
								<td><%=Helper
												.correctNull((String) arrpropsecurityCol
														.get(2))%></td>
							</tr>
							<%
								}
									}
							%>
						</table>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						 B.Additional / Fresh securities offered for the proposed
						facilities/Security released :</b> Nil</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
			%>


			<%
				if (!strProposedSecurity.equalsIgnoreCase("M")) {
					if ((arrproposedSecfacwise != null && arrproposedSecfacwise
							.size() > 0)
							|| (arrRowCollSec != null && arrRowCollSec.size() > 0)) {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						C.Securities for the proposed / renewed facilities : </b>
						<div align="right"><%=strAmtValueIn%></div>
						</td>
					</tr>
					<tr>
						<td>
						<div id="top">
						<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">

							<tr>
								<td align="center" width="20%"><b>Facility</b></td>
								<td align="center" width="55%"><b>Details of Security</b></td>
								<td align="center" width="10%"><b>Value</b></td>
								<td align="center" width="15%"><b>Date of Valuation</b></td>
							</tr>
							<%
								if ((arrproposedSecfacwise != null && arrproposedSecfacwise
												.size() > 0)) {
							%>
							<tr align="left">
								<td colspan="4"><b>Prime :</b></td>
							</tr>
							<%
								arrpropsecurityCol = new ArrayList();
											arrpropsecurity = new ArrayList();
											secValue = "";
											if (arrproposedSecfacwise != null
													&& arrproposedSecfacwise.size() > 0) {
												for (int i = 0; i < arrproposedSecfacwise.size(); i++) {
													arrpropsecurityCol = (ArrayList) arrproposedSecfacwise
															.get(i);
													for (int k = 0; k < arrpropsecurityCol.size(); k++) {
														arrpropsecurity = (ArrayList) arrpropsecurityCol
																.get(k);
														if (k == 0) {
															secValue = Helper
																	.converAmount(
																			Helper
																					.formatDoubleValue(Double
																							.parseDouble(Helper
																									.correctDouble((String) arrpropsecurity
																											.get(3)))),
																			strAmountValue);
															if (secValue.equals("0.00"))
																secValue = " ";
							%>
							<tr>
								<td><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(0))%>
								( <%=Helper
																.converAmount(
																		Helper
																				.correctDouble(Helper
																						.formatDoubleValue(Double
																								.parseDouble(Helper
																										.correctDouble((String) arrpropsecurity
																												.get(1))))),
																		strAmountValue)%>)</td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(2))%></td>
								<td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
								<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(4))%></td>
							</tr>
							<%
								} else {
							%>
							<tr>
								<td><%=Helper
																.correctNull((String) arrpropsecurity
																		.get(0))%>
								( <%=Helper
																.converAmount(
																		Helper
																				.correctDouble(Helper
																						.formatDoubleValue(Double
																								.parseDouble(Helper
																										.correctDouble((String) arrpropsecurity
																												.get(1))))),
																		strAmountValue)%>)</td>
							</tr>
							<%
								}
													}
												}
											}
										}
										if ((arrRowCollSec != null && arrRowCollSec.size() > 0)) {
							%>
							<tr>
								<td colspan="4" align="left"><b>Collateral:</b></td>
							</tr>
							<%
								arrpropsecurityCol = new ArrayList();
											arrpropsecurity = new ArrayList();
											secValue = "";
											if (arrRowCollSec != null && arrRowCollSec.size() > 0) {
												for (int i = 0; i < arrRowCollSec.size(); i++) {
													arrpropsecurityCol = (ArrayList) arrRowCollSec
															.get(i);
													secValue = Helper
															.converAmount(
																	Helper
																			.formatDoubleValue(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrpropsecurityCol
																									.get(1)))),
																	strAmountValue);
													if (secValue.equals("0.00"))
														secValue = " ";
							%>
							<tr>
								<td colspan="2"><%=Helper
														.correctNull((String) arrpropsecurityCol
																.get(0))%></td>
								<td align="right"><%=Helper.correctNull(secValue)%></td>
								<td><%=Helper
														.correctNull((String) arrpropsecurityCol
																.get(2))%></td>
							</tr>
							<%
								}
											}
										}
							%>
						</TABLE>
						</div>
						<br>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						C.Securities for the proposed / renewed facilities :</b> Nil</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
				} else if (strProposedSecurity.equalsIgnoreCase("M")) {
			%>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td><b><br>
						C.Securities for the proposed / renewed facilities :</b></td>
					</tr>
					<tr>
						<td><%=strProposedSecurityComments%></td>
					</tr>
				</table>
				</td>
			</tr>
			<%
				}
			%>


			<%
if(!strAppSecFlag.equalsIgnoreCase("M")){%>
	<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td><b>D. Security coverage for Bank's exposure to the applicant :</b><div align="right"><%=strAmtValueIn%></div></td>
</tr>
<tr>
		<td align="left"><%=str_presanccommentsforannex%></td>
</tr>
<tr>
	<td>
	
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
		<div align="left" id="top">
			<jsp:include page="../print/Securitiesprint.jsp" flush="true">
			<jsp:param name="pageVal" value="shortnote"/>
			</jsp:include>
			
		</div>
		</td>
			</tr>
			</table>
	</td>
</tr>
<tr>
	<td align="left"><%=str_postsanccommentsforannex %> </td>
</tr>
</table>
</td>
</tr>
<%
	}else if(strAppSecFlag.equalsIgnoreCase("M")){ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td><b>D.Security coverage for Bank's exposure to the applicant:</b></td>
</tr>
<tr>
		<td align="left"><%=str_presanccommentsforannex %></td>
</tr>
<tr>
<td>
<%if(hshAN3!=null){ %>
<%=Helper.correctNull((String)hshAN3.get("COMSEC_APPCOMMENTS"))%>
<%} %>&nbsp;</td>
</tr>
<tr>
	<td align="left"><%=str_postsanccommentsforannex %> </td>
</tr>
</table>
</td>
</tr>
<%} %>
			<tr>
				<td>
				<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<jsp:include page="../print/com_AnnexureV.jsp" flush="true">
						<jsp:param name="pageVal" value="shortnote" />
						<jsp:param name="pagevalue" value="ANN5" />
					</jsp:include>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="95%" align="center" cellpadding="0" cellspacing="0"
					border="0">
					<tr>
						<td class="title"><br>
						Present proposal:</td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String) hshValues
							.get("presentproposal_comment"))%></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td>
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<%
						if (arrPresentTL != null && arrPresentTL.size() > 0) {
					%>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
						<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="0">
							<tr>
								<td class="title">Details of proposed facilities:</td>
							</tr>
							<tr>
								<td align="right" width="50%"><%=strAmtValueIn%></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td align="left" width="">
						<div id="top">
						<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="0">
							<tr>
								<td align="center">Facility</td>
								<td align="center">Limit</td>
							</tr>
							<%
								for (int j = 0; j < arrPresentTL.size(); j++) {
										arrCol = (ArrayList) arrPresentTL.get(j);
							%>
							<tr>
								<td><%=Helper.correctNull((String) arrCol.get(0))%></td>
								<td align="right"><%=Helper.converAmount(Helper
									.correctNull((String) arrCol.get(1)),
									strAmountValue)%></td>
							</tr>
							<%
								}
							%>
						</table>
						</div>
						</td>
					</tr>
					<%
						}
					%>
					</table>
					</td>
					</tr>
					<tr>
						<td>
						<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">
							<tr>
								<td class="title">Eligibility criteria under KBL <%=strgecltype%> scheme:</td>
							</tr>
							<%if(!Helper.correctNull((String)hshValues.get("strGECLEligBasedon")).equalsIgnoreCase("")){ %>
							<tr>
								<td>Type of Borrower: <%=Helper.correctNull((String)hshValues.get("strGECLEligBasedon")) %>&nbsp;</td>
							</tr>
							<%} %>
						</table>
						</td>
					</tr>
											<tr>
					<td align="center">
					<div id="top">
					<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">
							<tr class="title" align="center">
							<td width="5%">Sl.No</td>
							<td width="40%">Parameters under </td>
							<td width="35%">Instant case</td>
							<td width="5%">Eligible</td>
							</tr>
							<%if(arrGECL!=null && arrGECL.size()>0){ 
							for(int a=0;a<arrGECL.size();a++){
							arrCol=(ArrayList)arrGECL.get(a);
							%>
							<tr>
							<td align="center"><%=a+1 %></td>
							<td><%=Helper.correctNull((String)arrCol.get(0)) %></td>
							<%if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("LC")){ %>
							<td>LEI Code :<%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp; Expiry Date : <%=Helper.correctNull((String)arrCol.get(3)) %></td>
							<%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("GRN")){ %>
							<td>
							<%String[] strArr1=Helper.correctNull((String)arrCol.get(1)).split("@");
							for(int z=0;z<strArr1.length;z++)
							{
								%>
							<%=strArr1[z] %><br/>
										 
							<%} %>
							</td>
							<%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("OCC")){ %>
						<td><%=Helper.converAmount(Helper
								.correctNull((String) arrCol.get(1)),
								strAmountValue)%> &nbsp;</td>
							
							<%}
							else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EM")){ %>
							<td><%=Helper.converAmount(Helper
									.correctNull((String) arrCol.get(1)),
									strAmountValue)%> &nbsp;</td>
								
								<%}
							else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("IMM")){ %>
							<td><%=Helper.converAmount(Helper
									.correctNull((String) arrCol.get(1)),
									strAmountValue)%> &nbsp;</td>
								
								<%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("NS")){ %>
								<td><%=Helper.correctNull((String)arrCol.get(5))%> &nbsp;</td>
									
									<%}
							else{ %>
							<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
							<%} %>
							<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
							</tr>
							<%}}else{ %>
							<tr><td colspan="4" align="center">- Nil-</td></tr>
							<%} %>
					</table>
					</div>
					</td>
					</tr>
					
					<tr>
						<td>
						<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">
							<tr>
								<td class="title">Assessment for KBL <%=strgecltype%> scheme:</td>
							</tr>
							<tr>
								<td align="right" width="50%"><%=strAmtValueIn%></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
					<td align="center">
					<div id="top">
					<table width="95%" align="center" cellpadding="3" cellspacing="0"
							border="0">
							<%if(arrGECL1!=null && arrGECL1.size()>0){ 
							for(int a=0;a<arrGECL1.size();a++){
							arrCol=(ArrayList)arrGECL1.get(a);%>
							<tr>
							<!-- <td align="center"><%//=a+1 %></td> -->
							<td><%=Helper.correctNull((String)arrCol.get(0)) %></td>
							<%if(Helper.isNumeric(Helper.correctNull((String)arrCol.get(1)))){ %>
							<td align="right"><%=Helper.converAmount(Helper
									.correctNull((String) arrCol.get(1)),
									strAmountValue)%>&nbsp;</td>
							<%}else{ %>
							<td align="right"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
							<%}%>
							</tr>
							<%}}else{ %>
							<tr><td colspan="4" align="center">- Nil-</td></tr>
							<%} %>						
					</table>
					</div>
					</td>
					</tr>
					
<%
if (str_arry.contains("CGSSD@")) {
%>
	<tr>
		<td style="border: none;"  class="title" align="left">&nbsp;&nbsp;&nbsp;Assessment for KBL CGSSD Scheme :</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>	
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	
	<%
			int intlength=0;
			
				intlength=(strDesc.length);
				String strstatus="";
			%>
			<tr>
				<td><b>1.<%=strDesc[0] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(0))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
	<tr>
				<td><b>2.<%=strDesc[1] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(1))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>3.<%=strDesc[2] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(2))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>4.<%=strDesc[3] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(3))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>5.<%=strDesc[4] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(4))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>6.<%=strDesc[5] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(5))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>7.<%=strDesc[6] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(6))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>8.<%=strDesc[7] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(7))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>9.<%=strDesc[8] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(8))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>10.<%=strDesc[9] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
				 strstatus= Helper.correctNull((String)arrColcgssd.get(9));
				if(strstatus.equalsIgnoreCase("S")){
					strstatus="Standard";
				}else if(strstatus.equalsIgnoreCase("N")){
					strstatus="NPA";
				}else{
					strstatus="";
				}
			   %>
			   <td align="right"><%=strstatus%></td>
			   <%} %>
			 </tr>
			 
	        <tr>
				<td><b>11.<%=strDesc[10] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(10))%></td>
			   <%} %>
			 </tr>
	</table>
	</div>
	</td>
	</tr>
<%}%>
					<tr>
					<td align="center">
						<table width="95%" align="center" cellpadding="0" cellspacing="0"
							border="0">
							<tr><td>Sanctioning Authority: &nbsp; <%=Helper.correctNull((String) hshValues.get("com_sancauthorityVal"))%></td></tr>
						</table>
					</td>
					</tr>
					<tr>
						<td align="center">
						<table width="95%" align="center" cellpadding="0" cellspacing="0"
							border="0">
							<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										Recommendations</td>
									</tr>
									<tr>
										<td style="text-align: justify;"><br>
										In light of the above,<b> M/s.&nbsp;<%=Helper.correctNull((String) hshValues
									.get("perapp_name"))%>.,</b>
										be sanctioned the following facilities on the terms and
										conditions, mentioned hereunder under sole/ consortium /
										multiple banking arrangement :</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										NATURE OF FACILITY AND LIMITS:</td>
									</tr>
									<tr>
										<td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<div id="top">
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
										if (arrRecommRow != null && arrRecommRow.size() > 0) {
									%>
									<tr>
										<td width="3%" align="center">Sl.No</td>
										<td width="25%" align="center">Type of Facility</td>
										<td width="15%" align="center">Type of Limit</td>
										<td width="15%" align="center">Nature of Facility</td>
										<td align="center" colspan="2">Amount</td>
										<td width="27%" align="center">Facility Availing Branch</td>
									</tr>
									<%
										for (int i = 0; i < arrRecommRow.size(); i++) {
												arrCol = (ArrayList) arrRecommRow.get(i);
									%>
									<%
										if (Double.parseDouble(Helper.correctDouble((String) arrCol
														.get(13))) != 0) {
									%>
									<tr>
										<td align="center" rowspan="3"><%=i + 1%>.</td>
										<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(0))
										.toUpperCase()%></td>
										<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(5))%></td>
										<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(22))%></td>
										<td>Loan Sanction Amount</td>
										<%
											if (!Helper.correctNull((String) arrCol.get(16))
																.equalsIgnoreCase("SF")) {
										%>
										<td align="right"><%=Helper
													.converAmount(
															jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(1)))
																			- Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(13)))),
															strAmountValue)%></td>
										<%
											} else {
										%>
										<td align="right"><%=Helper
													.converAmount(
															jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(1)))),
															strAmountValue)%></td>
										<%
											}
										%>
										<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(14))%></td>
									</tr>
									<tr>
										<td><%=Helper.correctNull((String) arrCol.get(15))%></td>
										<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(13))))),
										strAmountValue)%></td>
									</tr>
									<tr class="title">
										<td>Total Loan Sanction Limit</td>
										<td align="right"><%=Helper.converAmount(jtn.format(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1)))),
										strAmountValue)%></td>
										<%
											} else {
										%>
									
									<tr>
										<td align="center"><%=i + 1%>.</td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
										.toUpperCase()%></td>
										<td align="left"><%=Helper.changetoTitlecase((String) arrCol
										.get(5))%></td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(22))%></td>
										<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))),
										strAmountValue)%><br />
										Without any insurance coverage.</td>
										<td align="left" rowspan=""><%=Helper.correctNull((String) arrCol.get(14))%></td>

										<%
											}
										%>
									</tr>
									<%
										}
										} else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>
								</table>
								</div>
								</td>
							</tr>

							<tr>
								<td>
								<div id="top"><br></br>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
										int w = 0;
										if (arrRecommRow != null && arrRecommRow.size() > 0) {
											boolean bflag = false;

											for (int i = 0; i < arrRecommRow.size(); i++) {
												arrCol = (ArrayList) arrRecommRow.get(i);
												{
													if (Helper.correctNull((String) arrCol.get(16))
															.equalsIgnoreCase("SF"))
														bflag = true;
												}
											}
									%>
									<%
										for (int i = 0; i < arrRecommRow.size(); i++) {
												arrCol = (ArrayList) arrRecommRow.get(i);
												if (!Helper.correctNull((String) arrCol.get(16))
														.equalsIgnoreCase("NC")
														&& !Helper.correctNull((String) arrCol.get(16))
																.equalsIgnoreCase("")) {
													w++;
									%>
									<%
										if (w == 1) {
									%>
									<tr>
										<td width="3%" align="center">Sl.No</td>
										<td width="20%" align="center">Type of Facility</td>
										<td width="15%" align="center">Insurance Covered Under</td>
										<td width="7%" align="center">Premium Tenor<br>
										(in Months)</td>
										<td width="10%" align="center">Loan amount covered under
										the scheme</td>
										<%
											if (bflag) {
										%>
										<td width="10%" align="center">Premium Amount</td>
										<td width="10%" align="center">Operative account number
										from which<br>
										premium account will be debited</td>
										<td width="10%" align="center">Company Name</td>
										<%
											}
										%>
									</tr>
									<%
										}
									%>
									<tr>
										<td align="center"><%=w%>.</td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
										.toUpperCase()%></td>

										<td align="left"><%=Helper.correctNull((String) arrCol.get(15))%></td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(17))%></td>
										<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(18))))),
										strAmountValue)%></td>
										<%
											if (Helper.correctNull((String) arrCol.get(16))
																.equalsIgnoreCase("SF")) {
										%>
										<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(13))))),
															strAmountValue)%></td>
										<td align="left"><%=Helper.correctNull((String) arrCol
											.get(19))%></td>
										<td align="left"><%=Helper.correctNull((String) arrCol
											.get(21))%></td>
										<%
											} else if (bflag) {
										%>
										<td align="right" colspan="3">&nbsp;</td>
										<%
											}
										%>

									</tr>
									<%
										}
											}
									%>

									<%
										}
									%>
								</table>
								</div>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										RATE OF INTEREST/ COMMISSION:</td>
									</tr>
									<tr>
										<td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<div id="top">
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
										if (arrRecommRow != null && arrRecommRow.size() > 0
												&& strWhetherBRAvail.equalsIgnoreCase("Y")) {
											int j = 0;
									%>
									<tr>
										<td width="3%" align="center">Sl.No</td>
										<td width="47%" align="center">Type of Facility</td>
										<td width="20%" align="center">Limit</td>
										<td width="30%" align="center">Rate of
										Interest/Commission</td>
									</tr>
									<%
										for (int i = 0; i < arrRecommRow.size(); i++) {
												arrCol = (ArrayList) arrRecommRow.get(i);
												if (Helper.correctNull((String) arrCol.get(12))
														.equalsIgnoreCase("BR")
														|| Helper.correctNull((String) arrCol.get(12))
																.equalsIgnoreCase("MCLR")
														|| Helper.correctNull((String) arrCol.get(12))
																.equalsIgnoreCase("SMTB")
														|| Helper.correctNull((String) arrCol.get(12))
																.equalsIgnoreCase("EBLEC")
														|| Helper.correctNull((String) arrCol.get(12))
																.equalsIgnoreCase("TYGS")) {
													j = j + 1;
									%>
									<tr>
										<td align="center"><%=j%>.</td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
										.toUpperCase()%></td>
										<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))),
										strAmountValue)%></td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(3))%></td>
									</tr>
									<%
										}
											}
										} else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>
								</table>
								</div>
								</td>
							</tr>

							<%
								if (arrRowNonBr != null) {
									if (arrRowNonBr.size() > 0) {
										for (int k = 0; k < arrRowNonBr.size(); k++) {
											arrColNonBr = (ArrayList) arrRowNonBr.get(k);
											if (arrColNonBr.size() > 0) {
							%>
							<tr>
								<td>
								<div id="top">
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td><b><%=Helper.correctNull((String) arrColNonBr
											.get(0))%></b></td>
									</tr>
									<tr>
										<td><%=Helper.correctNull((String) arrColNonBr
											.get(1))%></td>
									</tr>
								</table>
								</div>
								</td>
							</tr>
							<%
								}
										}
									}
								}
							%>
							<%
								if (arrMCLRRow != null && arrMCLRRow.size() > 0) {
							%>
							<tr>
								<td>
								<div id="top">
								<table width="100%" align="cente
	
"3"
									cellspacing="0" border="0">
									<tr>
										<td>
										<%
											for (int k = 0; k < arrMCLRRow.size(); k++) {
										%> <%=Helper.correctNull((String) arrMCLRRow.get(k))%><br />
										<%
											}
										%>
										</td>
									</tr>
								</table>
								</div>
								</td>
							</tr>
							<%
								}
							%>

							<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										MARGIN:</td>
									</tr>
									<tr><td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<div id="top">
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
										if (arrRecommRow != null && arrRecommRow.size() > 0) {
									%>
									<tr>
										<td width="3%" align="center">Sl.No</td>
										<td width="47%" align="center">Type of Facility</td>
										<td width="20%" align="center">Limit</td>
										<td width="30%" align="center">Margin</td>
									</tr>
									<%
										for (int i = 0; i < arrRecommRow.size(); i++) {
												arrCol = (ArrayList) arrRecommRow.get(i);
									%>
									<tr>
										<td align="center"><%=i + 1%>.</td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
									.toUpperCase()%></td>
										<td align="right"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(1))))),
													strAmountValue)%></td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(10))%></td>
									</tr>
									<%
										}
										} else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>
								</table>
								</div>
								</td>
							</tr>

							<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										PERIOD:</td>
									</tr>
									<tr>
										<td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<div id="top">
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
										if (arrRecommRow != null && arrRecommRow.size() > 0) {
									%>
									<tr>
										<td width="3%" align="center">Sl.No</td>
										<td width="47%" align="center">Type of Facility</td>
										<td width="20%" align="center">Limit</td>
										<td width="15%" align="center">Tenor <br>
										(in Months)</td>
										<td width="15%" align="center">Initial Holiday/
										Gestation/ Moratorium Period <br>
										(in Months)</td>
									</tr>
									<%
										for (int i = 0; i < arrRecommRow.size(); i++) {
												arrCol = (ArrayList) arrRecommRow.get(i);
									%>
									<tr>
										<td align="center"><%=i + 1%>.</td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
									.toUpperCase()%></td>
										<td align="right"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(1))))),
													strAmountValue)%></td>
										<td align="right"><%=Helper.correctInt((String) arrCol.get(6))%></td>
										<td align="right"><%=Helper.correctNull((String) arrCol.get(11))%></td>
									</tr>
									<%
										}
										} else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>
								</table>
								</div>
								</td>
							</tr>

							<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										MODE OF REPAYMENT:</td>
									</tr>
									<tr>
										<td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<div id="top">
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
										if (arrRecommRow != null && arrRecommRow.size() > 0) {
									%>
									<tr>
										<td width="3%" align="center">Sl.No</td>
										<td width="47%" align="center">Type of Facility</td>
										<td width="20%" align="center">Limit</td>
										<td width="30%" align="center">Mode of Repayment</td>
									</tr>
									<%
										for (int i = 0; i < arrRecommRow.size(); i++) {
												arrCol = (ArrayList) arrRecommRow.get(i);
									%>
									<tr>
										<td align="center"><%=i + 1%>.</td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
									.toUpperCase()%></td>
										<td align="right"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(1))))),
													strAmountValue)%></td>
										<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
									</tr>
									<%
										}
										} else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>
								</table>
								</div>
								</td>
							</tr>

							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td><b>REPAYMENT SCHEDULE COMMENTS:</b></td>
							</tr>
							<tr>
								<td>&nbsp;
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
										ArrayList arrOutRow1 = (ArrayList) hshValues.get("arrOutRow2");
										ArrayList arrOutCol1 = new ArrayList();
										if (arrOutRow1 != null && arrOutRow1.size() > 0) {
											for (int i = 0; i < arrOutRow1.size(); i++) {
												arrOutCol1 = (ArrayList) arrOutRow1.get(i);
									%>
									<tr>
										<td align="left" width="20%" class="title">&nbsp;<u><%=Helper.correctNull((String) arrOutCol1.get(0))%>-<%=Helper.correctNull((String) arrOutCol1.get(1))%>
										:</u></td>
									</tr>
									<tr>
										<td align="left" width="50%"><%=Helper.correctNull((String) arrOutCol1.get(2))%></td>
									</tr>
									 <%String StrStageWiseRelease=Helper.correctNull((String) arrOutCol1.get(3));
										if(StrStageWiseRelease.equalsIgnoreCase("Y")){
											StrStageWiseRelease="Yes";
										}else if(StrStageWiseRelease.equalsIgnoreCase("N")){
											StrStageWiseRelease="No";
										}else{
											StrStageWiseRelease="";
										}%>
										<% if(!StrStageWiseRelease.equalsIgnoreCase("")){%>
									<tr><td><b>Stage Wise Release Of Loan &nbsp;<b>:</b>&nbsp;&nbsp;&nbsp;</b><%=StrStageWiseRelease%></td></tr>
									<%}
										}
										} else {
									%>
									<tr>
										<td align="center">&nbsp;Nil</td>
									</tr>
									<%
										}
									%>
								</table>
								</td>
							</tr>

							<tr>
								<td>&nbsp;</td>
							</tr>
							<%
if(!strProposedSecurity.equalsIgnoreCase("M")){
if((arrproposedSecfacwise!=null && arrproposedSecfacwise.size()>0) || (arrRowCollSec!=null && arrRowCollSec.size()>0)){ %>
<tr><td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Securities&nbsp;:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if((arrproposedSecfacwise!=null && arrproposedSecfacwise.size()>0)) { %>
<tr align="left">
<td colspan="4"><b>Prime :</b></td>
</tr>
<% 

arrpropsecurityCol=new ArrayList();
arrpropsecurity=new ArrayList();
secValue = "";
if(arrproposedSecfacwise!=null && arrproposedSecfacwise.size()>0){
	for(int i=0;i<arrproposedSecfacwise.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrproposedSecfacwise.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
				  secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue)%>)</td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		  <td align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>
		<%} else {
		%>
		<tr>
		 <td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue)%>)</td>
		</tr>		
		<%	}}
	}
} }
if((arrRowCollSec!=null && arrRowCollSec.size()>0)){ %>
<tr>
<td colspan="4" align="left"><b>Collateral:</b></td>
</tr>
<% 
arrpropsecurityCol=new ArrayList();
arrpropsecurity=new ArrayList();
secValue = "";
if(arrRowCollSec!=null && arrRowCollSec.size()>0){
	for(int i=0;i<arrRowCollSec.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrRowCollSec.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	}
} }
%>
</TABLE>
</div>
</td>
</tr>
<% }}else if(strProposedSecurity.equalsIgnoreCase("M")){%>
<tr><td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Securities&nbsp;:</td>
			</tr>
			<tr>
				<td><%=strProposedSecurityComments%></td>
			</tr>
		</table>
</td>
</tr>
<%} %>

<%ArrayList arrPromoterRow	= (ArrayList)hshValuesPromotor.get("arrGuaRow");
boolean bflag1=true;
if(arrPromoterRow!=null&&arrPromoterRow.size()>0) {%>
<tr>
<td>
    <table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
		<td class="title"><br><b>Co-Obligants/ Guarantors:</b></td>
		</tr>
	</table>
	</td>
</tr>
<br>
<tr>
	<td>
	<div id="top">
	<table width="70%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
	<td width="5%" align="center" class="title">S.No</td>
	<td width="65%" align="center" class="title">Name</td>
	<td width="20%" align="center" class="title">Type</td>
	</tr>
<%
ArrayList arrOutCol=new ArrayList();
String strAppltype="";
int x=0;
if(arrPromoterRow!=null&&arrPromoterRow.size()>0){
	for(int i=0;i<arrPromoterRow.size();i++) {
		arrOutCol	= (ArrayList)arrPromoterRow.get(i);
		if(arrOutCol!=null&&arrOutCol.size()>0){
		if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("G") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("CO")){
		bflag1=false;
		if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("G")){
			strAppltype="Guarantor";
		}else if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("CO")){
			strAppltype="Co-Obligant";
		}
		else{
			strAppltype="";
		}%>
			<tr>
				<td><%x=x+1; %><%=x %></td>
				<td><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
				<td><%=strAppltype%></td>
			</tr>
		<%}}
	}
}
if(bflag1)
{%>
<tr>
				<td colspan="3" align="center"> - Nil -</td>
			</tr>
<%}
%>
</table>
</div>
		</td>
</tr>
<%} %>							<tr>
								<td><span title="pagebreak" contentEditable="TRUE"
									onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										MIS Classification</td>
									</tr>
									<tr>
										<td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
							<%
										if (arrMISRow != null && arrMISRow.size() > 0) {
											
											int lensize=0;
									%>
									<%for(int i=0;i<arrMISRow.size();i++) {
										
										if(lensize < 4){
											
										arrColtemp.add(i);
										lensize++;
										
										}else{
											arrRowtemp.add(arrColtemp);
											arrColtemp= new ArrayList();
											lensize=0;
											arrColtemp.add(i);
											lensize++;
										}
										
									}
									arrRowtemp.add(arrColtemp);
									}%>
									<%
										if (arrMISRow != null && arrMISRow.size() > 0) {
											arrColtemp= new ArrayList();
											for(int k=0;k<arrRowtemp.size();k++){
												arrColtemp=(ArrayList)arrRowtemp.get(k);
											
									%>
									<tr>
								<td>
								<div id="top"><span title="pagebreak"
									contentEditable="TRUE" onPaste="event.returnValue=false"
									onKeyDown="callKeyDown()"></span>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
			int intlength=0;
			String val="";						
				intlength=(strmisDesc.length);
				String strstatus="",strrestruc="";
			%>
		
			<tr>
				<td><b><%=strmisDesc[1] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(21))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[2] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(3))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[3] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.changetoTitlecase((String)arrColMIS.get(1))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[4] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.changetoTitlecase((String)arrColMIS.get(2))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[5] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(18))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[6] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(4))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[7] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(5))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[8] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(6))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[20] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(22))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[9] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(7))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[10] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(8))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[11] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(9))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[12] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(11)))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[13] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(13)))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[14] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(14))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[15] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(15))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[16] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(16)))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[17] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(17))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[18] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(19))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[19] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(20))%></td>
			   <%} %>
			 </tr>
			 <%if(Helper.correctNull((String)arrColMIS.get(24)).equalsIgnoreCase("Y")){%>
			 <tr>
				<td><b><%=strmisDesc[21] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(23))%></td>
			   <%}} %>
			 </tr>
			 
				</table>
								</div>
								</td>
							</tr>					<%
										}
											}
										else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>
							<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td><br>
										Processing Charges : Rs. <b><%=Helper.correctNull((String) hshValues
							.get("com_processingfee"))%></b>
										+ Applicable Taxes</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>

									<tr>
										<td>
										<table width="100%" align="center" cellpadding="3"
											cellspacing="0" border="0">
											<tr>
												<td class="title"><br>
												TERMS AND CONDITIONS:</td>
											</tr>
										</table>
										</td>
									</tr>
									<%
										int j = 0;
										int sub = 0;
										int main = 0;
										String prevSno = "";
										String currParentId = "";
										String termsno = "";
										boolean booflag = true;
										boolean subflag = true;

										if (arrFacilityTerm0 != null && arrFacilityTerm0.size() > 0) {
									%>
									<tr>
										<td>
										<table width="100%" align="center" cellpadding="3"
											cellspacing="0" border="0">
											<tr>
												<td class="title"><b>Specific:</b></td>
											</tr>
											<%
												j = arrFacilityTerm0.size();
													for (int i = 0; i < arrFacilityTerm0.size(); i++) {
														termsno = Helper.correctNull((String) arrFacilityIdVal0
																.get(i));
														currParentId = Helper.correctNull((String) arrParentID0
																.get(i));
														if (currParentId.equalsIgnoreCase("0") && subflag == true) {
															booflag = true;
															sub = 0;
														}
														if (booflag) {
															main = main + 1;
															prevSno = Helper.correctNull((String) arrFacilityIdVal0
																	.get(i));
															booflag = false;
														}
											%>
											<%
												if (currParentId.equalsIgnoreCase("0")) {
															subflag = true;
											%>
											<tr>
												<td valign="top" nowrap="nowrap">
												<table cellpadding="3" cellspacing="0" width="95%">
													<tr>
														<td width="2%" valign="top"><%=main%>.</td>
														<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
													</tr>
												</table>
												</td>
											</tr>
											<%
												}
														if (prevSno.equalsIgnoreCase(currParentId)
																&& (!currParentId.equalsIgnoreCase("0"))) {
											%>
											<tr>
												<td valign="top" nowrap="nowrap">
												<table cellpadding="3" cellspacing="0" width="98%"
													align="right">
													<tr>
														<td width="2%" valign="top">&nbsp;<%=main%>.<%=++sub%></td>
														<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
													</tr>
												</table>
												</td>
											</tr>

											<%
												}
													}
											%>
										</table>
										</td>
									</tr>
									<%
										}
									%>
									<%
										if (arrFacilityTermApp0 != null) {
									%>
									<tr>
										<td>
										<table width="100%" align="center" cellpadding="3"
											cellspacing="0" border="0">
											<%
												for (int i = 0; i < arrFacilityTermApp0.size(); i++)

													{
														main = main + 1;
											%>
											<tr>
												<td align="center">
												<div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
												</td>
											</tr>
											<%
												}
											%>
										</table>
										</td>
									</tr>
									<%
										}
									%>

									<tr>
										<td><!-- Terms and Conditon - General --> <jsp:include
											page="../print/com_AnnexureVII.jsp" flush="true">
											<jsp:param name="pagetype" value="sancborrower" />
										</jsp:include> <!-- End --></td>
									</tr>

								</table>
								</td>
							</tr>
						</table>

						<table width="90%" align="center" cellpadding="0" cellspacing="0"
							border="0">
							<%
								if (arrDeleRow != null && arrDeleRow.size() > 0) {
									for (int i = 0; i < arrDeleRow.size(); i++) {
										arrCol = (ArrayList) arrDeleRow.get(i);
										boolean bflag = false;
										if (Helper.correctNull((String) arrCol.get(2))
												.equalsIgnoreCase("021")
												&& !Helper.correctNull(
														(String) hshValues.get("com_griddate"))
														.equalsIgnoreCase("")) {
											bflag = true;
										}
							%>
							<%
								if (i % 2 == 0) {
							%>
							<tr>
								<td><br>
								<%=Helper.correctNull((String) arrCol.get(0))%></td>
							</tr>
							<tr>
								<td><%=Helper.correctNull((String) arrCol.get(1))%></td>
							</tr>
							<%
								if (bflag) {
							%>
							<tr>
								<td align="left">Discussed and cleared in the Credit
								approval GRID on <%=Helper.correctNull((String) hshValues
											.get("com_griddate"))%>
								</td>
							</tr>
							<%
								}
										} else {
							%>
							<tr>
								<td align="right"><br>
								<%=Helper.correctNull((String) arrCol.get(0))%></td>
							</tr>
							<tr>
								<td align="right"><%=Helper.correctNull((String) arrCol.get(1))%>
								</td>
							</tr>
							<%
								if (bflag) {
							%>
							<tr>
								<td align="right">Discussed and cleared in the Credit
								approval GRID on <%=Helper.correctNull((String) hshValues
											.get("com_griddate"))%>
								</td>
							</tr>
							<%
								}
										}
							%>
							<%
								}
								}
							%>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
						

						
</body>
</html>
