<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrproposedsecurityRow = (ArrayList) hshValues.get("arrproposedFacility");
	ArrayList arrpropsecCollRow = (ArrayList) hshValues.get("arrproposedCollateralSec");
	ArrayList arrpropsecurityCol = new ArrayList();
	ArrayList arrpropsecurity = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	HashMap hshAN3 = new HashMap();
	ArrayList arrpropsecurityRow = new ArrayList();
	ArrayList arrproposedFacility = new ArrayList();
	ArrayList arrproposedCollateralSec = new ArrayList();
	ArrayList arrproposedSecfacwise = new ArrayList();
	ArrayList arrRowCollSec = new ArrayList();
	
	ArrayList arrRowRating		= new ArrayList();
	ArrayList arrColRating		= new ArrayList();
	
	ArrayList arrRowRatingRMD=new ArrayList();
	
	ArrayList arrOutCol			= new ArrayList();
	String strFlag = "";
	String strAppSecFlag = "";
	String strAppSecManualFlag = "", str_presanccommentsforannex = "", str_postsanccommentsforannex = "";
	hshAN3 = (HashMap) hshValues.get("AN3");
	HashMap hshSecdata = new HashMap();
	if (hshAN3 != null) {
		arrpropsecurityRow = (ArrayList) hshAN3.get("arrExistingSecfacwise");
		arrpropsecCollRow = (ArrayList) hshAN3.get("arrcollateralforEF");

		arrproposedCollateralSec = (ArrayList) hshAN3.get("arrproposedCollateralSec");
		arrproposedFacility = (ArrayList) hshAN3.get("arrproposedFacility");
		strAppSecFlag = Helper.correctNull((String) hshAN3.get("COMSEC_APPCOVERAGE"));
		strAppSecManualFlag = Helper.correctNull((String) hshAN3.get("COMSEC_SECTYPE"));
		arrproposedSecfacwise = (ArrayList) hshAN3.get("arrproposedSecfacwise");
		arrRowCollSec = (ArrayList) hshAN3.get("arrRowCollSec");
		hshSecdata = (HashMap) hshAN3.get("hshsecdet");
		if (hshSecdata != null)
			strFlag = Helper.correctNull((String) hshSecdata.get("strFlag"));

	}

	ArrayList arrBorrarr = new ArrayList();
	ArrayList arrBorrcol = new ArrayList();

	ArrayList arrRecommRow = new ArrayList();

	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);

	arrRow = (ArrayList) hshValues.get("arrRow");
	arrBorrarr = (ArrayList) hshValues.get("arrBorrarr");
	String secValue = "";
	int sno = 1;

	String strIntIndx = Helper.correctNull((String) hshValues.get("strIntIndexid"));
	String strProcessFee = Helper.correctNull((String) hshValues.get("strProcessingFee"));
	if (strProcessFee.equalsIgnoreCase("0.00")) {
		strProcessFee = Helper.correctNull((String) hshValues.get("KF_APP_FEE"));
	}

	String strAppno = Helper.correctNull((String) hshValues.get("appno"));
	String strNil = "No Data";
	String strmisDesc[] = { "Facility Desc", "Type of Facility and Facility Serail Number", "Activity Code",
			"Main Activity", "Sub Activity", "Agriculture/Industry/Service Category type", "Sector",
			"Sub sector", "Sensitive sector", "StandUp India", "Government announced scheme",
			"Guarantee Cover By", "Guarantee Covered Amount", "Sales Turnover of the Applicant",
			"Sales Turnover As on Date", "Criteria for Sales Turnover",
			"Investment in Plant & Machineries/Equipments", "Industry Name", "Investment value as on Date",
			"Criteria for Investment value", "Weaker Section",
			"Whether Start up as per definition of Ministry of Commerce and Industry" };
	ArrayList arrMISRow = (ArrayList) hshValues.get("arrMISRow");
	ArrayList arrColMIS = new ArrayList();
	ArrayList arrColtemp = new ArrayList();
	ArrayList arrRowtemp = new ArrayList();
	String strAmountValue = Helper.correctNull((String) hshValues.get("strAmountValue"));
	String strAmtValueIn = Helper.correctNull((String) hshValues.get("strAmtValueIn"));

	ArrayList arrBAOurRow = new ArrayList();
	ArrayList arrlistofotherbnk = new ArrayList();

	String strOutstandingDate = "";
	if (hshValues != null && hshValues.size() > 0) {
		arrBAOurRow = (ArrayList) hshValues.get("arrBAOurRow");
		arrlistofotherbnk = (ArrayList) hshValues.get("arrlistofotherbank");
		strOutstandingDate = Helper.correctNull((String) hshValues.get("strOutstandingDate"));
		arrRecommRow = (ArrayList) hshValues.get("arrRecommRow");
	}

	String strFormat = Helper.correctNull((String) request.getParameter("strFormat"));
	str_presanccommentsforannex = Helper.correctNull((String) hshValues.get("cmt_presanccomments"));
	str_postsanccommentsforannex = Helper.correctNull((String) hshValues.get("cmt_postsanccomments"));
	//out.println(hshValues);
	ArrayList arrOutRow1 = (ArrayList) hshValues.get("arrOutRow2");
	ArrayList arrOutCol1 = new ArrayList();

	String stramtValIn = Helper.correctNull((String) hshValues.get("strAmtValueIn"));

	if (strAmtValueIn.equalsIgnoreCase("Rs")) {
		strAmtValueIn = "(Amount in  " + strAmtValueIn + ".)";
	} else {
		strAmtValueIn = "(Rs. in  " + strAmtValueIn + ")";
	}
	String IntRat=Helper.correctNull((String)hshValues.get("IntRat"));
	arrRowRating = (ArrayList)hshValues.get("arrRowRating");
	arrRowRatingRMD=(ArrayList)hshValues.get("arrRowRatingRMD");
	String strNot="----No Data----";
	String strnodata="Not Applicable";
	
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Proposal Summary</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
</head>
<body>
	<form name="dopost();">
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
			<td align="center"><br>
			<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
			</td>
		</tr>
		<tr align="center"> 
			<td> <b>PROPOSAL NUMBER:&nbsp;<%=Helper.correctNull((String) hshValues.get("proposalnumber"))%> </b></td>
		</tr>
		
		<tr align="center">
							<td>
							<b>PROPOSAL SUMMARY</b></td>
	</tr>
		
			<tr>
				<td>
					<table width="100%" align="center" cellpadding="3" cellspacing="0"
						border="0">
						
					</table>
					<table width="100%" align="center" cellpadding="3" cellspacing="0"
						border="1">
						<tr>
							<td align="left"><b>Sanctioning Department</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("sanctiondept"))%></td>
						</tr>
						<tr>
							<td align="left"><b>Sanctioning Authority</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("sanctionauthority"))%></td>
						</tr>
						<tr>
							<td align="left"><b>Borrower Name</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("borrowername"))%></td>
						</tr>
						<tr>
							<td align="left"><b>CBSID</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("PERAPP_CBSID"))%></td>
						</tr>
						<tr>
							<td align="left"><b>Branch Name</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("ORG_NAME"))%></td>
						</tr>
						<tr>
							<td align="left"><b>Branch SOL ID</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("ORG_SCODE"))%></td>
						</tr>
						<tr>
							<td align="left"><b>Constitution</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("CONSTITUTION"))%></td>
						</tr>
						<tr>
							<td align="left"><b>Pan</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("PERAPP_PANNO"))%></td>
						</tr>
						<tr>
							<td align="left"><b>Nature of Business/Activity</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("KYC_natofBussActivity"))%></td>
						</tr>
						
						<tr>
							<td align="left"><b>Type of proposal</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("Typeofproposal"))%></td>
						</tr>


					</table>


					<table width="100%" align="center" cellpadding="3" cellspacing="0"
						border="0">
						<tr>
							<td class="title"><br>1. NATURE OF FACILITY AND LIMITS (Proposed):</td>
						</tr>
						<tr>
							<td align="right" width=""><%=strAmtValueIn%></td>
						</tr>
					</table> <!-- </td>
</tr> 
<tr>
	<td>-->

					<table width="100%" align="center" cellpadding="3" cellspacing="0"
						border="1">
				<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="25%" align="center">Type of Facility</td>
				<td width="15%" align="center">Type of Limit</td>
				<td width="15%" align="center">Nature of Facility</td>
				<td align="center" colspan="2">Amount</td>
				<td width="27%" align="center">Facility Availing Branch</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<%if(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13)))!=0){ %>
			<tr>
				<td align="center" rowspan="3"><%=i + 1%>.</td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(22))%></td>
				<td>Loan Sanction Amount</td>
				<%if(!Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))-Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(13)))),strAmountValue)%></td>
				<%}else{ %>
				<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))),strAmountValue)%></td>
				<%} %>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(14))%></td>	
				</tr>
				<tr>
					<td><%=Helper.correctNull((String) arrCol.get(15))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(13))))),strAmountValue)%></td>
				</tr>
				<tr class="title">
					<td>Total Loan Sanction Limit</td>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)))),strAmountValue)%></td>
				<%}else{ %>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(22))%></td>
				<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%><br/>Without any insurance coverage.</td>
				<td align="left" rowspan=""><%=Helper.correctNull((String) arrCol.get(14))%></td>	
	
			<%} %>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>
			</table>
	<!--</td>
</tr>  -->







	<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
<tr>
<td class="title" align="left" colspan="3">
<div>2. Rating profile : External agency 
</div>
 <% if(arrRowRating!=null&&arrRowRating.size()>0)
{%>
<div align="right"><%=strAmtValueIn%>
</div>
<%} %>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowRating!=null&&arrRowRating.size()>0)
{
for(int i=0;i<arrRowRating.size();i++) {
	arrColRating	= (ArrayList)arrRowRating.get(i);
%>
<%if(i==0){ %>
<tr>
<td align="center">Name of rating agency</td>
<td align="center">Date of rating/press release</td>
<td align="center">Particulars of facility rated</td>
<td align="center">Amount rated <br/></td>
<td align="center">Rating assigned</td>
<td align="center">Description</td>
<td align="center">Due date</td>
<td align="center">Risk Weight</td>
</tr>
<%} %>
<tr>
<td><%=Helper.correctNull((String)arrColRating.get(2))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(3))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(4))%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColRating.get(5))))),strAmountValue)%></td>
<td><%=Helper.correctNull((String)arrColRating.get(6))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(7))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(8))%></td>
<td><%=Helper.correctNull((String)arrColRating.get(9))%>%</td>
</tr>
<%}%>
<%if(!Helper.correctNull((String)hshValues.get("cmt_ratingcomments")).equalsIgnoreCase("")){ %>
<tr>
<td colspan="8" align="left">Reason for downgrading: <%=Helper.correctNull((String)hshValues.get("cmt_ratingcomments"))%></td>
</tr>
<%} %>
<%}else{%>
<tr><td align="center" style="border:none;"><%=strnodata%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>

<tr>
<td class="title" align="left" colspan="3"><b>3. Rating profile : Internal as confirmed by RMD 
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<%boolean bflag1=true; %>
<%if(IntRat.equalsIgnoreCase("Y")){ %>
<tr>
<td align="center" width="20%">Year</td>
<td align="center" width="30%">Type</td>
<td align="center" width="30%">Rating</td>
</tr>
<%if(arrRowRatingRMD!=null&&arrRowRatingRMD.size()>0){
	for(int i=0;i<arrRowRatingRMD.size();i++) {
	arrOutCol	= (ArrayList)arrRowRatingRMD.get(i);%>
	<%if(i==0 && !Helper.correctNull((String)hshValues.get("cre_weight")).equalsIgnoreCase("")){
	bflag1=false;%>
<tr>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_ratyear"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_rattype"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_weight"))%></td>
</tr>
<% }%>
<tr>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(0))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(1))%></td>
<td align="left"><%=Helper.correctNull((String)arrOutCol.get(2))%></td>
</tr>
<%}} } else if(bflag1 && !Helper.correctNull((String)hshValues.get("cre_weight")).equalsIgnoreCase("")){%>
<tr>
<td align="center" width="20%">Year</td>
<td align="center" width="30%">Type</td>
<td align="center" width="30%">Rating</td>
</tr>
<tr>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_ratyear"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_rattype"))%></td>
<td align="left"><%=Helper.correctNull((String)hshValues.get("cre_weight"))%></td>
</tr>
<%} else{ %>
<tr><td align="center" style="border:none;"><%=strNot%></td></tr>
<% }%>
<%if(!Helper.correctNull((String)hshValues.get("strInternalrating_comment")).equalsIgnoreCase("")){ %>
	<tr>
	<td colspan="8" align="left">Reason for downgrading: <%=Helper.correctNull((String)hshValues.get("strInternalrating_comment"))%></td>
	</tr>
<%} %>
</table>
</div>
</td>
</tr>
</table>












	

<table width="100%" align="center" cellpadding="3" cellspacing="0"
						border="0">
<tr>
							<td>
<%
	if (arrBAOurRow.size() != 0 || arrlistofotherbnk.size() != 0) {
%>
<br>

<br>
			<div align="left">
									<b>4. Details of existing credit facilities with our Bank and other Bank</b>
								</div>
<%
	} else {
%>
									
						<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>	

		
<br>
<br>	
<div align="left">
							<b>A.Existing credit facilities with our Bank</b>
						</div>
<br>
<%
	if (arrBAOurRow.size() != 0) {
%>
<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="1">
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<%
	if (!strFormat.equalsIgnoreCase("Y")) {
%>
<td width="10%" align="center"><b>Type of Limit</b></td>
<%
	}
%>
<td width="10%" align="center"><b>Limit</b></td>
<td width="10%" align="center"><b>Purpose</b></td>
<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
<td width="10%" align="center"><b>ROI/ Com %</b></td>
<td width="10%" align="center"><b>Balance as on <%=strOutstandingDate%></b></td>
<td width="10%" align="center"><b>Due Date</b></td>
<td width="10%" align="center"><b>Arrears if any</b></td>
</tr>
<%
	double dbLimitTotal = 0.00, dbbalanceTotal = 0.00, dblExposure = 0.0;
		for (int i = 0; i < arrBAOurRow.size(); i++) {
			arrCol = new ArrayList();
			arrCol = (ArrayList) arrBAOurRow.get(i);
			System.out.println(arrCol);
			if (Helper.correctNull((String) arrCol.get(13)).equalsIgnoreCase("0")) {
				dbLimitTotal = dbLimitTotal + Double.parseDouble(Helper.correctDouble((String) arrCol.get(2)));
				dbbalanceTotal = dbbalanceTotal
						+ Double.parseDouble(Helper.correctDouble((String) arrCol.get(6)));
				dblExposure += Double.parseDouble(Helper.correctDouble((String) arrCol.get(18)));
			}
%>
<tr>
<td align="left"><%=i + 1%></td>
<td align="left"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(0))).toUpperCase()%></td>
<%
	if (!strFormat.equalsIgnoreCase("Y")) {
%>
<td align="left"><%=Helper.correctNull((String) arrCol.get(14))%></td>
<%
	}
			if (Helper.correctNull((String) arrCol.get(13)).equalsIgnoreCase("0")) {
%>
<td align="right"><%=Helper.converAmount(
								Helper.correctNull(
										jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))),
								strAmountValue)%></td>
<%
	} else {
%>
<td align="right">(<%=Helper.converAmount(
								Helper.correctNull(
										jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2))))),
								strAmountValue)%>)</td>
<%
	}
%>
<td align="left"><%=Helper.correctNull((String) arrCol.get(10))%></td>
<td align="left"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;-&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
<%
	if (Helper.correctNull((String) arrCol.get(11)).equalsIgnoreCase("BR")
					|| Helper.correctNull((String) arrCol.get(11)).equalsIgnoreCase("MCLEC")
					|| Helper.correctNull((String) arrCol.get(11)).equalsIgnoreCase("MCLR")) {
%>
<td align="right"><%=Helper.correctNull((String) arrCol.get(11))%>&nbsp;+&nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(5))))%>% p.a presently at &nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(12))))%>% p.a</td>
<%
	} else {
%>
<td align="right">&nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(12))))%></td>
<%
	}
			if (Helper.correctNull((String) arrCol.get(13)).equalsIgnoreCase("0")) {
%>
<td align="right"><%=Helper.converAmount(
								Helper.correctNull(
										jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))),
								strAmountValue)%></td>
<%
	} else {
%>
<td align="right">(<%=Helper.converAmount(
								Helper.correctNull(
										jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))),
								strAmountValue)%>)</td>
<%
	}
%>
<td align="center"><%=Helper.correctNull((String) arrCol.get(8))%></td>
<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
</tr>
<%
	}
%>
</table>
<%
	} else {
%>
<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="1">
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									</table>
									<%
										}
									%>



<br>
			<div align="left">
							<b>B.Existing credit facilities with other Bank</b>
						</div>			
<br>
<%
	if (arrlistofotherbnk.size() != 0) {
%>	
<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="1">
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="20%" align="center"><b>Name of the Bank</b></td>
<td width="15%" align="center"><b>Limit</b></td>
<td width="20%" align="center"><b>Nature of facility</b></td>
<td width="15%" align="center"><b>Limit Type</b></td>
<td width="15%" align="center"><b>Outstanding</b></td>
<td width="15%" align="center"><b>Interest(%)</b></td>
<td width="20%" align="center"><b>Branch Name</b></td>
<td width="15%" align="center"><b>Email ID</b></td>

</tr>
<%
	for (int i = 0; i < arrlistofotherbnk.size(); i++) {
			arrCol = new ArrayList();
			arrCol = (ArrayList) arrlistofotherbnk.get(i);
%>
	<tr>
	<td align="left"><%=i + 1%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(0)))%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(1)))%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(6)))%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(7)))%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(2)))%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(3)))%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(4)))%></td>
	<td align="center"><%=Helper.correctNull(Helper.correctNull((String) arrCol.get(5)))%></td>
	
	</tr>
	<%
		}
	%>
</table>


<%
	} else {
%>
<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="1">
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									</table>
									<%
										}
									%>

</td>
	</tr>
	</table>
	

<table width="100%" align="center" cellpadding="3" cellspacing="0"
						border="0">
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0"
						border="0">
			<tr>
				<td class="title"><br>5. MODE OF REPAYMENT:</td>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="0">
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
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(
							Helper.correctNull(
									jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(1))))),
							strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr>
								<td align="left" style="border:none;"><%=strNil%></td>
							</tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>
</table>


<br>
<br>

<table width="100%" align="center" cellpadding="3" cellspacing="0"
				border="0">	
	<%
			if (!strAppSecFlag.equalsIgnoreCase("M")) {
				//if(strFlag.equalsIgnoreCase("E")){
		%>
	<tr>
					<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0"
							border="0">
<tr>
<td><b> 6. Security coverage for Bank's exposure to the applicant :</b>
								<div align="right"><%=strAmtValueIn%></div></td>
</tr>
<tr>
		<td align="left"><%=str_presanccommentsforannex%></td>
</tr>
<tr>
	<td>
	
	<table width="100%" align="center" cellpadding="3" cellspacing="0"
										border="0">
<tr>
<td>
		<div align="left" id="top">
			<jsp:include page="../print/Securitiesprint.jsp" flush="true">
			<jsp:param name="pageVal" value="shortnote" />
			</jsp:include>
			
		</div>
		</td>
			</tr>
			</table>
	</td>
</tr>
<tr>
	<td align="left"><%=str_postsanccommentsforannex%> </td>
</tr>
</table>
</td>
</tr>
<%
	//}else{
%>
<!--<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td><b>D.Security coverage for Bank's exposure to the applicant:</b><%=strNil%></td>
</tr>
</table>
</td>
</tr>
-->
				<%
					//}
					} else if (strAppSecFlag.equalsIgnoreCase("M")) {
				%><t r>
					<td>
					
					
					
<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
<tr>
<td><b>6. Security coverage for Bank's exposure to the applicant:</b></td>
</tr>
<tr>
		<td align="left"><%=str_presanccommentsforannex%></td>
</tr>
<tr>
<td>
<%
	if (hshAN3 != null) {
%>
<%=Helper.correctNull((String) hshAN3.get("COMSEC_APPCOMMENTS"))%>
<%
	}
%>&nbsp;</td>
</tr>
<tr>
	<td align="left"><%=str_postsanccommentsforannex%> </td>
</tr>
</table>
</td>
</tr>
<%
	}
%>
	
</table>	

	
	
<%-- <table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">		
		<tr>
		<td>&nbsp;
			<table width="100%" align="center" cellpadding="3" cellspacing="0"
								border="0">
	<%
		if (arrOutRow1 != null && arrOutRow1.size() > 0) {
			for (int i = 0; i < arrOutRow1.size(); i++) {
				arrOutCol1 = (ArrayList) arrOutRow1.get(i);
	%>
				<tr>
					<td align="left" width="20%" class="title">&nbsp;<u><%=Helper.correctNull((String) arrOutCol1.get(0))%>-<%=Helper.correctNull((String) arrOutCol1.get(1))%> :</u></td>
								</tr>
				<tr>
									<td align="left" width="50%"><%=Helper.correctNull((String) arrOutCol1.get(2))%></td>
								</tr>
	
	       <%
		       	String StrStageWiseRelease = Helper.correctNull((String) arrOutCol1.get(3));
		       			if (StrStageWiseRelease.equalsIgnoreCase("Y")) {
		       				StrStageWiseRelease = "Yes";
		       			} else if (StrStageWiseRelease.equalsIgnoreCase("N")) {
		       				StrStageWiseRelease = "No";
		       			} else {
		       				StrStageWiseRelease = "";
		       			}
		       %>
										<%
											if (!StrStageWiseRelease.equalsIgnoreCase("")) {
										%>
									<tr>
									<td><b>Stage Wise Release Of Loan &nbsp;<b>:</b>&nbsp;&nbsp;&nbsp;</b><%=StrStageWiseRelease%></td>
								</tr>
									<%
										}
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
	
	</table>
	 --%>
	
	

<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
			<tr>
				<td class="title"><br><b>7. MIS Details</b></td>
			</tr>
		</table>
		<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="1">
	<%
		if (arrMISRow != null && arrMISRow.size() > 0) {

			int lensize = 0;
	%>
									<%
										for (int i = 0; i < arrMISRow.size(); i++) {

												if (lensize < 4) {

													arrColtemp.add(i);
													lensize++;

												} else {
													arrRowtemp.add(arrColtemp);
													arrColtemp = new ArrayList();
													lensize = 0;
													arrColtemp.add(i);
													lensize++;
												}

											}
											arrRowtemp.add(arrColtemp);
										}
									%>
									<%
										if (arrMISRow != null && arrMISRow.size() > 0) {
											arrColtemp = new ArrayList();
											for (int k = 0; k < arrRowtemp.size(); k++) {
												arrColtemp = (ArrayList) arrRowtemp.get(k);
									%>
									<tr>
								<td>
								<table width="100%" align="center" cellpadding="3"
								cellspacing="0" border="1">
									<%
										int intlength = 0;
												String val = "";
												intlength = (strmisDesc.length);
												String strstatus = "", strrestruc = "";
									%>
		
			<tr>
				<td><b><%=strmisDesc[1]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(21))%></td>
			   <%
			   	}
			   %>
			 </tr>
	
			 <tr>
				<td><b><%=strmisDesc[2]%></b><br></td>
				<%
					for (int i = 0; i < arrColtemp.size(); i++) {
								val = arrColtemp.get(i).toString();
								arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
				%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(3))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[3]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.changetoTitlecase((String) arrColMIS.get(1))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[4]%></b><br></td>
				<%
					for (int i = 0; i < arrColtemp.size(); i++) {
								val = arrColtemp.get(i).toString();
								arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
				%>
			   <td align="right"><%=Helper.changetoTitlecase((String) arrColMIS.get(2))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[5]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(18))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[6]%></b><br></td>
				<%
					for (int i = 0; i < arrColtemp.size(); i++) {
								val = arrColtemp.get(i).toString();
								arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
				%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(4))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[7]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(5))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[8]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(6))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[20]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(22))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[9]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(7))%></td>
			   <%
			   	}
			   %>
			 </tr>
			  
			 <tr>
				<td><b><%=strmisDesc[10]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(8))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[11]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(9))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[12]%></b><br></td>
				<%
					for (int i = 0; i < arrColtemp.size(); i++) {
								val = arrColtemp.get(i).toString();
								arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
				%>
			   <td align="right"><%=Helper.converAmount(
								Helper.formatDoubleValue(
										Double.parseDouble(Helper.correctDouble((String) arrColMIS.get(11)))),
								strAmountValue)%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[13]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.converAmount(
								Helper.formatDoubleValue(
										Double.parseDouble(Helper.correctDouble((String) arrColMIS.get(13)))),
								strAmountValue)%></td>
			   <%
			   	}
			   %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[14]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(14))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[15]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(15))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[16]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.converAmount(
								Helper.formatDoubleValue(
										Double.parseDouble(Helper.correctDouble((String) arrColMIS.get(16)))),
								strAmountValue)%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[17]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(17))%></td>
			   <%
			   	}
			   %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[18]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(19))%></td>
			   <%
			   	}
			   %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[19]%></b><br></td>
					<%
						for (int i = 0; i < arrColtemp.size(); i++) {
									val = arrColtemp.get(i).toString();
									arrColMIS = (ArrayList) arrMISRow.get(Integer.parseInt(val));
					%>
			   <td align="right"><%=Helper.correctNull((String) arrColMIS.get(20))%></td>
			   <%
			   	}
			   %>
			 </tr>
			 <%
			 	if (Helper.correctNull((String) arrColMIS.get(24)).equalsIgnoreCase("Y")) {
			 %>
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
</table>		
</td>
</tr>
</table>
<br>
<br>
<br>
</form>
</body>
</html>