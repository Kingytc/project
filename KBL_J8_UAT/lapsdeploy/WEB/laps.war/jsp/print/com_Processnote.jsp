<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
	request.setAttribute("_cache_refresh", "true");
%>
<laps:handleerror/>
<%
	String strOrgLevel = (String) session.getAttribute("strOrgLevel");
	double dblVal = 0.00,dblMOFinttot=0.00;
	double dblintMOFtot=0.00;
	double dblintMOFtot1=0.00;
	double dblMOFinttot1=0.00;
	ArrayList arrColCons = new ArrayList();
	ArrayList arrCol = new ArrayList();
	ArrayList arrFacRow = new ArrayList();
	ArrayList arrRecommRow = new ArrayList();
	ArrayList arrGroupRow = new ArrayList();
	ArrayList arrERatingRow = new ArrayList();
	ArrayList arrSoleBARow = new ArrayList();
	ArrayList arrConsBARow = new ArrayList();
	ArrayList arrBARow = new ArrayList();
	ArrayList arrFAConlyRow = new ArrayList();
	ArrayList arrImpScheRow = new ArrayList();
	ArrayList arrDeleRow = new ArrayList();
	ArrayList arrCOPRow = new ArrayList();
	ArrayList arrMOFRow = new ArrayList();
	ArrayList arrMOFMjrRow = new ArrayList();
	ArrayList arrCOPMjrRow = new ArrayList();
	ArrayList arrRelPatrnRow = new ArrayList();
	ArrayList arrRelPatrnMjrRow = new ArrayList();
	ArrayList arrTORow = new ArrayList();
	ArrayList arrExpRow = new ArrayList();
	ArrayList arrFACexistingRow = new ArrayList();
	ArrayList arrSingleCons = new ArrayList();
	ArrayList arrMultipleCons = new ArrayList();
	ArrayList arrMultiple = new ArrayList();
	ArrayList arrSingleConsWC = new ArrayList();
	ArrayList arrMultipleConsWC = new ArrayList();
	ArrayList arrMultipleWC = new ArrayList();
	ArrayList arrMultiBnk = new ArrayList();

	ArrayList arrRowIL1 = new ArrayList();
	ArrayList arrRowIL2 = new ArrayList();
	ArrayList arrRowIL3 = new ArrayList();
	ArrayList arrRowIL4 = new ArrayList();
	ArrayList arrRowIL5 = new ArrayList();
	ArrayList arrImpHeadRow= new ArrayList();
	ArrayList arrImplSchRow  = new ArrayList();
	ArrayList arrRowRatingRMD  = new ArrayList();

	ArrayList arrRowprop= new ArrayList();
	ArrayList arrColprop= new ArrayList();
	
	ArrayList arrFacilityTerm0 = (ArrayList) hshValues
			.get("arrFacilityTerm0");
	ArrayList arrFacilityTermType0 = (ArrayList) hshValues
			.get("arrFacilityTermType0");
	ArrayList arrFacilityIdVal0 = (ArrayList) hshValues
			.get("arrFacilityIdVal0");
	ArrayList arrFacilityTermStatus0 = (ArrayList) hshValues
			.get("arrFacilityTermStatus0");
	ArrayList arrParentID0 = (ArrayList) hshValues.get("arrParentID0");
	ArrayList arrFacilityTermApp0 = (ArrayList) hshValues
			.get("arrFacilityTermApp0");
	ArrayList arrFacilityTermTypeApp0 = (ArrayList) hshValues
			.get("arrFacilityTermTypeApp0");
	ArrayList arrFacilityIdAppVal0 = (ArrayList) hshValues
			.get("arrFacilityIdAppVal0");
	ArrayList arrFacilityTermStatusapp0 = (ArrayList) hshValues
			.get("arrFacilityTermStatusapp0");
	ArrayList arrFacilityTerm1 = (ArrayList) hshValues
			.get("arrFacilityTerm1");
	ArrayList arrFacilityIdVal1 = (ArrayList) hshValues
			.get("arrFacilityIdVal1");
	ArrayList arrParentID1 = (ArrayList) hshValues.get("arrParentID1");
	ArrayList arrFacilityTermApp1 = (ArrayList) hshValues
			.get("arrFacilityTermApp1");
	ArrayList arrFacilityTerm2 = (ArrayList) hshValues
			.get("arrFacilityTerm2");
	ArrayList arrFacilityIdVal2 = (ArrayList) hshValues
			.get("arrFacilityIdVal2");
	ArrayList arrParentID2 = (ArrayList) hshValues.get("arrParentID2");
	ArrayList arrFacilityTermApp2 = (ArrayList) hshValues
			.get("arrFacilityTermApp2");
	ArrayList arrFacilityTerm3 = (ArrayList) hshValues
			.get("arrFacilityTerm3");
	ArrayList arrFacilityIdVal3 = (ArrayList) hshValues
			.get("arrFacilityIdVal3");
	ArrayList arrParentID3 = (ArrayList) hshValues.get("arrParentID3");
	ArrayList arrFacilityTermApp3 = (ArrayList) hshValues
			.get("arrFacilityTermApp3");
	ArrayList arrFacilityTerm4 = (ArrayList) hshValues
			.get("arrFacilityTerm4");
	ArrayList arrFacilityIdVal4 = (ArrayList) hshValues
			.get("arrFacilityIdVal4");
	ArrayList arrParentID4 = (ArrayList) hshValues.get("arrParentID4");
	ArrayList arrFacilityTermApp4 = (ArrayList) hshValues
			.get("arrFacilityTermApp4");
	ArrayList arrFacilityTerm5 = (ArrayList) hshValues
			.get("arrFacilityTerm5");
	ArrayList arrFacilityIdVal5 = (ArrayList) hshValues
			.get("arrFacilityIdVal5");
	ArrayList arrParentID5 = (ArrayList) hshValues.get("arrParentID5");
	ArrayList arrFacilityTermApp5 = (ArrayList) hshValues
			.get("arrFacilityTermApp5");
	ArrayList arrFacdesc = (ArrayList) hshValues.get("arrFacdesc");
	ArrayList arrFacTerm = (ArrayList) hshValues.get("arrFacpreTerm");
	ArrayList arrFacIdVal = (ArrayList) hshValues.get("arrFacpreIdVal");
	ArrayList arrFacParentID = (ArrayList) hshValues
			.get("arrFacpreParentID");
	ArrayList arrFacTermApp = (ArrayList) hshValues
			.get("arrFacpreTermApp");
	ArrayList arrFacTermTypeApp = (ArrayList) hshValues
			.get("arrFacpreTermTypeApp");
	ArrayList arrFacIdAppVal = (ArrayList) hshValues
			.get("arrFacpreIdAppVal");
	ArrayList arrFacTermStatusapp = (ArrayList) hshValues
			.get("arrFacpreTermStatusapp");
	ArrayList arrFacPostTerm = (ArrayList) hshValues
			.get("arrFacPostTerm");
	ArrayList arrFacPostIdVal = (ArrayList) hshValues
			.get("arrFacPostIdVal");
	ArrayList arrFacPostParentID = (ArrayList) hshValues
			.get("arrFacPostParentID");
	ArrayList arrFacilityTermApp = (ArrayList) hshValues
			.get("arrFacPostTermApp");
	ArrayList arrFacilityTermTypeApp = (ArrayList) hshValues
			.get("arrFacPostTermTypeApp");
	ArrayList arrFacPostIdAppVal = (ArrayList) hshValues
			.get("arrFacPostIdAppVal");
	ArrayList arrFacPostTermStatusapp = (ArrayList) hshValues
			.get("arrFacPostTermStatusapp");

	ArrayList arrLimit = new ArrayList();
	ArrayList arrRowLimit = new ArrayList();
	ArrayList arrInland = new ArrayList();
	ArrayList arrRowInland = new ArrayList();
	ArrayList arrRowInlandYr = new ArrayList();
	ArrayList arrInlandYr1 = new ArrayList();
	ArrayList arrInlandYr2 = new ArrayList();
	ArrayList arrInlandYr3 = new ArrayList();
	ArrayList arrInlandYr4 = new ArrayList();
	ArrayList arrInlandYr5 = new ArrayList();
	ArrayList arrColIL1 = new ArrayList();
	ArrayList arrColIL2 = new ArrayList();
	ArrayList arrColIL3 = new ArrayList();
	ArrayList arrColIL4 = new ArrayList();
	ArrayList arrColIL5 = new ArrayList();
	ArrayList arrRowNonBr = new ArrayList();
	ArrayList arrColNonBr = new ArrayList();
	ArrayList arrMCLRRow = new ArrayList();

	String strOutstandingDate = "", strRatiCount = "", strValuesIn = "", str_arry = "", strPreWC = "", strExiWC = "";
	String strSanctioningAuthority = "";
	String strWhetherBRAvail = "N";
	int intRatiCount = 0;

	ArrayList arrInFromCropsRow = new ArrayList();
	ArrayList arrInFromCropsCol = new ArrayList();
	ArrayList arrRow1 = new ArrayList();
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrCropAsseRow = new ArrayList();
	ArrayList arrCropAsseCol = new ArrayList();
	ArrayList arrAssmntRow = new ArrayList();
	ArrayList arrAssmntCol = new ArrayList();
	ArrayList arrCOPNewRow = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrsecCol = new ArrayList();

	ArrayList arryInland = new ArrayList();
	ArrayList arrCodeDescRow = new ArrayList();
	ArrayList arrCodeDescCol = new ArrayList();
	ArrayList arrExistingWC = new ArrayList();
	ArrayList arrPresentWC = new ArrayList();
	ArrayList arrPresentTL = new ArrayList();
	HashMap hshRepayNE = new HashMap();
	ArrayList arrRowcgssd= new ArrayList();
	ArrayList arrColcgssd= new ArrayList();
	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
		arrRowNonBr = (ArrayList) hshValues.get("arrRowNonBr");
		arrMCLRRow = (ArrayList) hshValues.get("arrMCLR");
		arrCodeDescRow = (ArrayList) hshValues.get("arrCodeDescRow");
		hshRepayNE = (HashMap) hshValues.get("hshRepayNE");
		arrImplSchRow = (ArrayList) hshValues.get("arrImplSchRow");
		arrRowprop= (ArrayList)hshValues.get("arrRowprop");

	}

	ArrayList arrReleaseRow = new ArrayList();
	HashMap hshFarm1 = new HashMap();
	String strSancAuth = "";
	if (hshValues != null) {
		arrAssmntRow = (ArrayList) hshValues.get("arrAssmntRow");
		arrFacRow = (ArrayList) hshValues.get("arrFacRow");
		arrRecommRow = (ArrayList) hshValues.get("arrRecommRow");
		arrGroupRow = (ArrayList) hshValues.get("arrGroupRow");
		arrERatingRow = (ArrayList) hshValues.get("arrERatingRow");
		arrSoleBARow = (ArrayList) hshValues.get("arrSoleBARow");
		arrConsBARow = (ArrayList) hshValues.get("arrConsBARow");
		arrBARow = (ArrayList) hshValues.get("arrBARow");
		arrFAConlyRow = (ArrayList) hshValues.get("arrFAConlyRow");
		//arrImpScheRow = (ArrayList) hshValues.get("arrImpScheRow");
		arrDeleRow = (ArrayList) hshValues.get("arrDeleRow");
		arrCOPRow = (ArrayList) hshValues.get("arrCOPRow");
		arrMOFRow = (ArrayList) hshValues.get("arrMOFRow");
		arrMOFMjrRow = (ArrayList) hshValues.get("arrMOFMjrRow");
		arrCOPMjrRow = (ArrayList) hshValues.get("arrCOPMjrRow");
		arrRelPatrnRow = (ArrayList) hshValues.get("arrRelPatrnRow");
		arrRelPatrnMjrRow = (ArrayList) hshValues
				.get("arrRelPatrnMjrRow");
		arrTORow = (ArrayList) hshValues.get("TurnOver");
		arrExpRow = (ArrayList) hshValues.get("arrExpRow");
		arrRowLimit = (ArrayList) hshValues.get("arrRowLimit");
		arrRowInland = (ArrayList) hshValues.get("arrRowInland");
		arrRowInlandYr = (ArrayList) hshValues.get("arrRowInlandYr");
		arrFACexistingRow = (ArrayList) hshValues
				.get("arrFACexistingRow");

		arrSingleCons = (ArrayList) hshValues.get("arrSingleCons");
		arrMultipleCons = (ArrayList) hshValues.get("arrMultipleCons");
		arrMultiple = (ArrayList) hshValues.get("arrMultiple");
		arrSingleConsWC = (ArrayList) hshValues.get("arrSingleConsWC");
		arrMultipleConsWC = (ArrayList) hshValues
				.get("arrMultipleConsWC");
		arrMultipleWC = (ArrayList) hshValues.get("arrMultipleWC");
		arrMultiBnk = (ArrayList) hshValues.get("arrMultiBnk");

		arryInland = (ArrayList) hshValues.get("Inland");

		strOutstandingDate = Helper.correctNull((String) hshValues
				.get("strOutstandingDate"));
		strSanctioningAuthority = Helper.correctNull((String) hshValues
				.get("com_sancauthorityVal"));
		arrRow1 = (ArrayList) hshValues.get("arrData");
		hshFarm1 = (HashMap) hshValues.get("hshFarm");
		arrCropAsseRow = (ArrayList) hshValues.get("arrCropAssessment");
		strRatiCount = Helper.correctInt((String) hshValues
				.get("rati_Count"));
		intRatiCount = Integer.parseInt(strRatiCount);
		strSancAuth = Helper.correctNull((String) hshValues
				.get("com_sancauthority"));
		strWhetherBRAvail = Helper.correctNull((String) hshValues
				.get("strWhetherBRAvail"));
		arrCOPNewRow = (ArrayList) hshValues.get("arrCOPNewRow");
		arrReleaseRow = (ArrayList) hshValues.get("arrReleaseRow");
		str_arry = Helper
				.correctNull((String) hshValues.get("str_arr"));
		arrImpHeadRow = (ArrayList) hshValues.get("arrReleaseRow");
		arrExistingWC = (ArrayList) hshValues.get("arrExistingWC");
		arrPresentWC = (ArrayList) hshValues.get("arrPresentWC");
		arrPresentTL = (ArrayList) hshValues.get("arrPresentTL");
		arrRowcgssd= (ArrayList)hshValues.get("arrRowcgssd");

	}

	if (arrRowInland != null && arrRowInland.size() > 0) {
		arrColIL1 = (ArrayList) arrRowInland.get(0);
		arrColIL2 = (ArrayList) arrRowInland.get(1);
		arrColIL3 = (ArrayList) arrRowInland.get(2);
		arrColIL4 = (ArrayList) arrRowInland.get(3);
		arrColIL5 = (ArrayList) arrRowInland.get(4);
	}

	String strSno[] = { "I", "II", "III", "IV", "V", "VI", "VII",
			"VIII", "IX", "X", "XI", "XII", "XII" };
	String strTOLabel[] = {
			"Particulars",
			"Projected Sales",
			"Accepted projected Sales",
			"25% of accepted sales",
			"Minimum Margin required (5% of accepted sales)",
			"Eligible Finance as per Norms",
			"Actual Margin available in the System",
			"Eligible Bank Finance as per availability of actual Margin",
			"Permissible Bank Finance", "Limits sought",
			"Limit proposed", "Required margin",
			"Surplus/ Shortfall(-) in required Margin" };
	String strExpLabel[] = { "Particulars", "Projected expenditure",
			"Accepted projected expenditure",
			"Operational cycle(45/ 60/ 75/ 90 days)",
			"Eligible expenditure", "Permisible finance",
			"Limits sought", "Limit proposed" };

	String strValIn = Helper.correctNull((String) hshValues
			.get("strValuesIn"));
	String strTLValIn = "";

	if (strValIn.equalsIgnoreCase("Rs")) {
		strValuesIn = "(Amount in  " + strValIn + ".)";
		strTLValIn = "";
	} else {
		strValuesIn = "(Rs. in  " + strValIn + ")";
		strTLValIn = strValIn;
	}

	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);

	int intVal = 0, iVal = 0;
	String strFBFlag = "", strNFBFlag = "", strNil = "Nil", strNotApplicatble = "Not Applicatble", strVal = "";

	String strLoanType = "", strKccFlagValue = "";
	if (hshValues != null) {
		strLoanType = Helper.correctNull((String) hshValues
				.get("strLoanTypeNew"));
		strKccFlagValue = Helper.correctNull((String) hshValues
				.get("strKccFlag"));
	}

	ArrayList arrRow2 = new ArrayList();
	ArrayList arrCol2 = new ArrayList();
	ArrayList arrCol3 = new ArrayList();
	ArrayList arrRowP = new ArrayList();
	ArrayList arrColP = new ArrayList();
	ArrayList arrRowTot = new ArrayList();
	ArrayList arrColTot = new ArrayList();
	ArrayList arrRowInc = new ArrayList();
	ArrayList arrColInc = new ArrayList();
	ArrayList arrRowFac = new ArrayList();
	ArrayList arrColFac = new ArrayList();

	if (hshFarm1 != null) {
		arrRow2 = (ArrayList) hshFarm1.get("arrRow");
		arrRowP = (ArrayList) hshFarm1.get("arrRowP");
		arrRowTot = (ArrayList) hshFarm1.get("arrRowTot");
		arrRowInc = (ArrayList) hshFarm1.get("arrRowInc");
		arrRowFac = (ArrayList) hshFarm1.get("arrRowFac");

	}
	int arraySize = 0;
	if (arrRow2 != null) {
		arraySize = arrRow2.size();
	}
	String StrSchemeType = request.getParameter("strschemeType");
	int facTenor = 0;
	if (hshFarm1 != null) {
		facTenor = Integer.parseInt(Helper.correctInt((String) hshFarm1
				.get("facTenor")));
	}

	int p = 0, q = 0;

	//Added by vinoth for Phisical and Financials page
	HashMap hshPhysicsAndFinValues = new HashMap();
	HashMap hshDSS = new HashMap();
	HashMap hshForCalc = new HashMap();
	HashMap hshForExist = new HashMap();
	HashMap hshForProposed = new HashMap();
	HashMap hshFinlValues = new HashMap();

	ArrayList arrRowPhyFin = new ArrayList();
	ArrayList arrColPhyFin = new ArrayList();
	ArrayList arrCol1PhyFin = new ArrayList();
	ArrayList arrCollPhyFin = new ArrayList();
	ArrayList arrSubtotal = new ArrayList();

	hshPhysicsAndFinValues = (HashMap) hshValues
			.get("hshPhysicsAndFinValues");
	hshFinlValues = (HashMap) hshValues.get("hshFinlValues");
	if (hshPhysicsAndFinValues != null) {
		arrRowPhyFin = (ArrayList) hshPhysicsAndFinValues.get("arrRow");
		arrSubtotal = (ArrayList) hshPhysicsAndFinValues
				.get("arrYears");
	}

	// Added by vinoth kumar for DSS page

	hshDSS = (HashMap) hshValues.get("hshDSSData");
	ArrayList arrRowDSS = new ArrayList();
	ArrayList arrColDSS = new ArrayList();
	ArrayList arrBankRow = new ArrayList();
	ArrayList arrBankCol = new ArrayList();
	ArrayList arrBankPropRow = new ArrayList();
	ArrayList arrBankPropCol = new ArrayList();
	ArrayList arrBankExisEmiDataRow = new ArrayList();
	ArrayList arrBankExisEmiDataCol = new ArrayList();
	ArrayList arrBankPropEmiDataRow = new ArrayList();
	ArrayList arrBankPropEmiDataCol = new ArrayList();
	ArrayList arrTotalAmountExisting = new ArrayList();
	ArrayList arrTotalAmountProposed = new ArrayList();
	ArrayList arrOthBankRow = new ArrayList();
	ArrayList arrOthBankCol = new ArrayList();
	ArrayList arrOthBankDataRow = new ArrayList();
	ArrayList arrOthBankDataCol = new ArrayList();

	if (hshDSS != null) {
		arrRowDSS = (ArrayList) hshDSS.get("arrRow");
		arrBankRow = (ArrayList) hshDSS.get("arrBankRow");
		arrBankPropRow = (ArrayList) hshDSS.get("arrBankPropRow");
		arrOthBankRow = (ArrayList) hshDSS.get("arrOthBankRow");
	}
	int arraySizeDSS = arrRowDSS.size();

	int arrBankExisSize = 0;
	int arrBankPropSize = 0;
	if (arrBankRow != null && arrBankRow.size() > 0) {
		arrBankExisSize = arrBankRow.size();
	}
	arrBankPropSize = arrBankPropRow.size();

	double dblAverageVal = 0.00;
	double dblNetIncome = 0.00;
	double dblOtherIncome = 0.00;
	double dblTotIncome = 0.00;
	double dblNetsurplus = 0.00;
	double dblPerFarmSurplus = 0.00;
	double dblPerSurplus = 0.00;

	ArrayList vec = new ArrayList();
	ArrayList vecrec = new ArrayList();
	ArrayList vecBench = new ArrayList();
	ArrayList vecBenchrec = new ArrayList();
	int vecsize = 0;
	int vecrecsize = 0;
	int vecBenchsize = 0;
	int vecBenchrecsize = 0;
	HashMap hshBenchmark=new HashMap();
	hshBenchmark=(HashMap)hshValues.get("hshBenchValues");
	if (hshBenchmark != null) {
		vec = (ArrayList) hshBenchmark.get("vecData");
	}
	if (vec != null) {
		vecsize = vec.size();
	}
	ArrayList g1 = new ArrayList();
	ArrayList g2 = new ArrayList();

	//	ArrayList arrFacilityTermApp0 = (ArrayList)hshValues.get("arrFacilityTermApp0");
	//	ArrayList arrFacilityTermApp1 = (ArrayList)hshValues.get("arrFacilityTermApp1");

	ArrayList arrGeneralTC0 = (ArrayList) hshValues
			.get("arrGeneralTC0");
	ArrayList arrGeneralTC1 = (ArrayList) hshValues
			.get("arrGeneralTC1");

	HashMap hshFinmethod1 = new HashMap();
	hshFinmethod1 = (HashMap) hshValues.get("method1");

	HashMap hshFinmethod2 = new HashMap();
	hshFinmethod2 = (HashMap) hshValues.get("method2");

	HashMap hshFinmethod3 = new HashMap();
	hshFinmethod3 = (HashMap) hshValues.get("method3");

	HashMap hshFinDSCR = new HashMap();
	hshFinDSCR = (HashMap) hshValues.get("DSCRhshFinValues");

	HashMap hshFinSEN = new HashMap();
	hshFinSEN = (HashMap) hshValues.get("SENSITIVITYhshFinValues");
	boolean booAssFlag = true;

	ArrayList arrGrpExp = (ArrayList) hshValues.get("arrGrpExpDet");
	ArrayList arrColExp = new ArrayList();
	double dblgrpexptot = 0;
	dblgrpexptot = Double.parseDouble(Helper
			.correctDouble((String) hshValues.get("dblGrpExpVal")));

	double dblExptot = Double.parseDouble(Helper
			.correctDouble((String) hshValues.get("dblExposureTot")));
	double dblTotExp = Double.parseDouble(Helper
			.correctDouble((String) hshValues.get("dblTotExp")));

	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	ArrayList arrImplSchCol = new ArrayList();
	String strPreSancSecComments = Helper.correctNull((String)hshValues.get("cmt_presanccomments")).trim();
	String strPostSancSecComments = Helper.correctNull((String)hshValues.get("cmt_postsanccomments")).trim();
	ArrayList arrCOPcommRow = (ArrayList) hshValues.get("COP_comments");
	String strAmountvalue=Helper.correctNull((String) hshValues.get("com_amountvalue"));
	String strFinvaluesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
	String  strpurpose= Helper.correctNull((String)hshValues.get("prd_purpose"));
	if(strFinvaluesIn.equalsIgnoreCase("Rs"))
	{
		strFinvaluesIn	= "(Amount in  "+strFinvaluesIn+".)";
	}
	else
	{
		strFinvaluesIn	= "(Rs. in  "+strFinvaluesIn+")";
	}

	String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
	String stramtValIn=Helper.correctNull((String)hshValues.get("strAmtValueIn"));
	if(strAmtValueIn.equalsIgnoreCase("Rs"))
	{
		strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
	}
	else
	{
		strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
	}

	String TakeOvercheck=Helper.correctNull((String)hshValues.get("strTakeOvercheck"));
	ArrayList arrRowTakeover = (ArrayList) hshValues.get("arrTakeoverVal");
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strFinancialrequired=Helper.correctNull((String)hshValues.get("Financialrequired"));
double dblLimitTot=0.0,dblOutstandTot=0.0,dblExposureTot=0.0,dblFreshLimit=0.0,dblPropLimitTot=0.0,dblTotalExp=0.0,dblLimitTot1=0.0;
ArrayList arrRBIGuidliness=new ArrayList();
arrRBIGuidliness=(ArrayList)hshValues.get("arrRBIGuidliness");
int a=0;
arrRowRatingRMD=(ArrayList)hshValues.get("arrRowRatingRMD");

String StrverCFR=Helper.correctNull((String)hshValues.get("COM_CFR_VERIFIED"));
String StrNameCFR=Helper.correctNull((String)hshValues.get("COM_CFR_BORNAME"));
String strStatus=Helper.correctNull((String)hshValues.get("STATUS_VERIFIED"));
String temp = "";
ArrayList arrCol12 = new ArrayList();
ArrayList arrRow12 = new ArrayList();
if (hshValues != null)
	arrRow12 = (ArrayList) hshValues.get("arrRow2");
String strratingperc=Helper.correctNull((String)hshValues.get("COM_CGSSDPERC"));
String strDesc[] = { "Capital of the entity", "Promoters Stake",
		"Eligible Amount", "Amount Applied", "Liability of the entity",
		"Maximum loan under the scheme","Recommended (lower of 3,4,5,6)",
		"Entity Name","Operative account number where the borrower is a promoter","Status of the entity","NPA Date"};

%>
<html>
<head>
<title>Process Note</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

<script>
var strratingperc="<%=strratingperc%>";
function callLoad()
{
	var varspan=document.getElementsByTagName('span');
	var space="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
	for(i in varspan)
	{
		if(document.getElementsByTagName('span')[i].title=="pagebreak")
		{
			document.getElementsByTagName('span')[i].innerHTML=space;
			document.getElementsByTagName('span')[i].title="Press 'Enter' for line space";
		}
	}
}
//Allow Enter , ctrl+z , ctrl+y , ctrl+a and ctrl+ckey Only
function callKeyDown()
{
	var pressedKey=String.fromCharCode(event.keyCode).toLowerCase();
    var key=window.event.keyCode;
    if(! ( (key==8)|| (key==13) || (event.ctrlKey && pressedKey=="z") || (event.ctrlKey && pressedKey=="y") || (event.ctrlKey && pressedKey=="a") || (event.ctrlKey && pressedKey=="c")))
	{
	   window.event.returnValue=false;
	}
}
</script>

</head>
<body contentEditable="false" designMode="on" onKeyDown="callKeyDown();" onload="callLoad();">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>

<%
	{%>
<%if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("008")){ %>
<tr><td align="center" width="50%">Credit LCFD<%//=Helper.correctNull((String) hshValues.get("com_sancdept")).toUpperCase()%>&nbsp;&nbsp;<%//=Helper.correctNull((String) hshValues.get("com_sancbranch")).toUpperCase()%></td></tr>
<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("010")){ 
String strComSancbranchcode=Helper.correctNull((String)hshValues.get("com_sancbranchcode"));
if(strComSancbranchcode.equalsIgnoreCase("MCFD"))
	strComSancbranchcode="Credit MCFD";
else
	strComSancbranchcode="Credit RFD";
%>
<tr><td align="center" width="50%"><%=strComSancbranchcode%><%//=Helper.correctNull((String) hshValues.get("com_sancdept")).toUpperCase()%>&nbsp;&nbsp;<%//=Helper.correctNull((String) hshValues.get("com_sancbranch")).toUpperCase()%></td></tr>
<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("013")){ %>
<tr><td align="center" width="50%">Credit RFD</td></tr>
<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("014")){ %>
<tr><td align="center" width="50%">Credit MCFD</td></tr>
<%}
else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("015")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("016")){
	%>
<tr><td align="center" width="50%"><%=Helper.correctNull((String)hshValues.get("strSanctiondept"))%></td></tr>
<%}
else{ %>
<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("username")).toUpperCase()%></td></tr>
<%} %>
<%}  %>
<tr>
<td align="right">
<table width="100%" cellpadding="3" cellspacing="0" border="0">

<tr>
<td align="left" width="20%">AGENDA ITEM No: <br>OFFICE NOTE:</td>
<td align="right" width="50%">Date&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues
							.get("com_processnotedate"))%></td>
</tr>

<tr><td align="left" width="30%">PARTY FILE NO&nbsp;:&nbsp;
<%
	if (strOrgLevel.equalsIgnoreCase("A")) {
%>
<%=Helper.correctNull((String) hshValues
								.get("com_partyfileno"))%>
<%
	} else {
%>
<%=Helper.correctNull((String) hshValues
										.get("com_roho"))%>
<%
	}
%>
</td>
<td align="right" width="50%"><b>Proposal No&nbsp;:&nbsp;</b><%=Helper.correctNull((String)request.getParameter("appno"))%></td></tr>
<tr><td align="left">BRANCH&nbsp;:&nbsp;<%=Helper.changetoTitlecase(Helper
							.correctNull((String) hshValues.get("org_name"))).toUpperCase()%></td></tr>
<tr><td align="left">REGION&nbsp;:&nbsp;<%=Helper
							.changetoTitlecase(Helper
									.correctNull((String) hshValues
											.get("Reg_org_name"))).toUpperCase()%></td></tr>


</table>
</td>
</tr>

<tr>
<td>
<table width="100%" align="right" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="50%">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

</table>
</td>
<td width="50%">
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="center" colspan="2">PROPOSAL FLOW CHART</td></tr>
<tr>
<td align="left" width="40%">Date of Credit Application</td>
<td align="center" width="10%"><%=Helper.correctNull((String) hshValues
							.get("inward_appliedon"))%></td>
</tr>
<tr>
<td align="left">Date of receipt at HO/RO with Branch recommendations</td>
<td align="center"><%=Helper.correctNull((String) hshValues
							.get("com_branchrcvddate"))%></td>
</tr>
<%if(!Helper.correctNull((String)hshValues.get("strLodgedDate")).equalsIgnoreCase("")){ %>
<tr  style="border-style:none; ">
<td colspan="2" valign="top" style="padding:0px;">
<table width="100%" align="center" cellpadding="0" cellspacing="0" border="0">
<tr>
<td width="30%" style="border-top:0px; border-bottom:0px;">Lodged On :</td>
<td width="20%" align="center" style="border-top:0px; border-bottom:0px;"><%=Helper.correctNull((String)hshValues.get("strLodgedDate")) %>&nbsp;</td>
<td width="30%" style="border-top:0px; border-bottom:0px;">Delodged On :</td>
<td width="20%" align="center" style="border-top:0px; border-bottom:0px;"><%=Helper.correctNull((String)hshValues.get("strDelodgedDate")) %>&nbsp;</td>
</tr>
</table>
</td>
</tr>
<%} %>
<tr>
<td align="left">Date of receipt of complete information/ papers at HO/RO</td>
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
	<td align="center">
		<br>
		<b>
		<%
			if (strSancAuth.equalsIgnoreCase("15")
					|| strSancAuth.equalsIgnoreCase("16")) {
		%>
			FOR THE MEETING OF <%=Helper.correctNull((String) hshValues
								.get("com_meeting"))%> DATED <%=Helper.correctNull((String) hshValues
								.get("com_meetingdate"))%>
		<%
			} else {
		%>
		SUBMITTED TO THE <%=Helper.correctNull(
								(String) hshValues.get("com_submittedto"))
								.toUpperCase()%>
		<%
			}
		%>
		<br>---------------------------------------------
		</b>
	</td>
</tr>

<tr><td class="title"><br><%=strSno[a]%><%a++; %>&nbsp;Introduction :</td></tr>

<tr>
<td>
This is a  Fresh/ Renewal proposal received from <b><%=Helper.correctNull((String) hshValues.get("org_name"))%></b> Branch for considering the following 
credit facilities to <b><%=Helper.correctNull((String) hshValues
									.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues
									.get("perapp_name"))%></b>&nbsp; under Sole/Multiple/Consortium banking arrangement:
<br>
<p align="justify"><%=Helper.correctNull((String) hshValues.get("GistOfProp"))%></p>
</td>
</tr>
<!-- Facilities -->

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" align="left">Details of proposal :</td>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			
			<%
							if (arrFacRow != null && arrFacRow.size() > 0) {
						%>
			<tr>
				<td align="center" width="3%">SI.No.</td>
				<td align="center" width="37%">Nature of facility</td>
				<td align="center" width="10%">Existing Limit</td>
				<td align="center" width="10%">Outstanding as on <%=strOutstandingDate%></td>
				<td align="center" width="10%">Existing exposure</td>
				<td align="center" width="10%">Additional / Fresh Limit sought by Borrower</td>
				<td align="center" width="10%">Additional / Fresh Limit Proposed</td>
				<td align="center" width="10%">Proposed Exposure</td>
			</tr>
			<%
				for (int i = 0; i < arrFacRow.size(); i++) {
						arrCol = (ArrayList) arrFacRow.get(i);

						if (Helper.correctNull((String) arrCol.get(8))
								.equalsIgnoreCase("F")) {
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper
										.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<%
					if (Helper.correctNull((String) arrCol.get(9))
										.equalsIgnoreCase("Main-Limit")) {
				%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%></td>
				<%
					} else {
				%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%>)</td>
				<%
					}
				%>
				<%
					if (Helper.correctNull((String) arrCol.get(9))
										.equalsIgnoreCase("Main-Limit")) {
				%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))),strAmountvalue)%></td>
				<%
					} else {
				%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))),strAmountvalue)%>)</td>
				<%
					}
				%>
				<%
					if (Helper.correctNull((String) arrCol.get(9))
										.equalsIgnoreCase("Main-Limit")) {
				%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%></td>
				<%
					} else {
				%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%>)</td>
				<%
					}
				%>
				<%
					if (Helper.correctNull((String) arrCol.get(9))
										.equalsIgnoreCase("Main-Limit")) {
				%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(5))))),strAmountvalue)%></td>
				<%
					} else {
				%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(5))))),strAmountvalue)%>)</td>
				<%
					}
				%>
				<%
					if (Helper.correctNull((String) arrCol.get(9))
										.equalsIgnoreCase("Main-Limit")) {
				%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
								.get(6))))),strAmountvalue)%></td>
				<%
					} else {
				%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
								.get(6))))),strAmountvalue)%>)</td>
				<%
					}
				%>
				<!-- 		<td align="right"><%=jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%></td>   -->
				<%
					if (Helper.correctNull((String) arrCol.get(9))
										.equalsIgnoreCase("Main-Limit")) {
				%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(7))))),strAmountvalue)%></td>
				<%
					} else {
				%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(7))))),strAmountvalue)%>)</td>
				<%
					}
				if (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")) {
				dblLimitTot=dblLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				dblOutstandTot=dblOutstandTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
				dblExposureTot=dblExposureTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
				dblFreshLimit=dblFreshLimit+Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
				dblPropLimitTot=dblPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
				dblTotalExp=dblTotalExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
				}
				
				if (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")||Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit"))
					dblLimitTot1=dblLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				%>
			</tr>
			<%
				} else {
			%>
				<tr>
					<td align="center"><%=i + 1%>.</td>
					<td align="left"><%=Helper.changetoTitlecase(Helper
										.correctNull((String) arrCol.get(0))).toUpperCase()%></td>
					<%
						if (Helper.correctNull((String) arrCol.get(9))
											.equalsIgnoreCase("Main-Limit")) {
					%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%></td>
					<%
						}else if (Helper.correctNull((String) arrCol.get(9))
								.equalsIgnoreCase("Adhoc-Limit")) {
							%>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
													.correctDouble((String) arrCol
															.get(1))))),strAmountvalue)%></td>
							<%
						} else {
					%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%>)</td>
					<%
						}
					%>
					<%
						if (Helper.correctNull((String) arrCol.get(9))
											.equalsIgnoreCase("Main-Limit")) {
					%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))),strAmountvalue)%></td>
					<%
						} else {
					%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(2))))),strAmountvalue)%>)</td>
					<%
						}
					%>
					<%
						if (Helper.correctNull((String) arrCol.get(9))
											.equalsIgnoreCase("Main-Limit")) {
					%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%></td>
					<%
						} else {
					%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))),strAmountvalue)%>)</td>
					<%
						}
					%>
					<%
						if (Helper.correctNull((String) arrCol.get(9))
											.equalsIgnoreCase("Main-Limit")) {
					%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(5))))),strAmountvalue)%></td>
					<%
						} else {
					%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(5))))),strAmountvalue)%>)</td>
					<%
						}
					%>
					<%
						if (Helper.correctNull((String) arrCol.get(9))
											.equalsIgnoreCase("Main-Limit")) {
					%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(6))))),strAmountvalue)%></td>
					<%
						} else {
					%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(6))))),strAmountvalue)%>)</td>
					<%
						}
					%>
					
	<!--  			<td align="right"><%=jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))%></td>	 -->
					<%
						if (Helper.correctNull((String) arrCol.get(9))
											.equalsIgnoreCase("Main-Limit")) {
					%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(7))))),strAmountvalue)%></td>
					<%
						} else {
					%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(7))))),strAmountvalue)%>)</td>
					<%
						}
					if (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")) {
					dblLimitTot=dblLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
					dblOutstandTot=dblOutstandTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
					dblExposureTot=dblExposureTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
					dblFreshLimit=dblFreshLimit+Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
					dblPropLimitTot=dblPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
					dblTotalExp=dblTotalExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
					}
					
					if (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")||Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit"))
						dblLimitTot1=dblLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
					%>
				</tr>
			<%
				}
					}
			%>
			<tr>
				<td align="center" colspan="2">TOTAL</td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblLimitTot1)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblOutstandTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblLimitTot)),strAmountvalue)%></td>
	<!--  		<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblExposureTot)),strAmountvalue)%></td>	 -->
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblFreshLimit)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblPropLimitTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblTotalExp)),strAmountvalue)%></td>
			</tr>
			<%
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

<!-- Group Concern Exposure -->
<%
	if (arrGroupRow != null && arrGroupRow.size() > 0) {
%>

<tr>
	<td class="title"><br>Exposure</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			double dblTemp=0.00;
				if (arrGroupRow != null && arrGroupRow.size() > 0) {
			%>
				<tr>
					<td width="3%" align="center">SI.No.</td>
					<td width="60%" align="center">Name</td>
					<td width="10%" align="center">Exposure</td>
				</tr>
				<tr>
					<td align="center">1.</td>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("perapp_name"))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblTotalExp)),strAmountvalue)%></td>
				</tr>
			<%
				for (int i = 0; i < arrGroupRow.size(); i++) {
							arrCol = (ArrayList) arrGroupRow.get(i);

							if (i == 0) {
								iVal = 1;
							}
			%>
				<tr>
					<td align="left"><%=++iVal%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(1))%></td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctInt((String) arrCol.get(2))))%></td>
										
					<%dblTemp=dblTemp+Double.parseDouble(Helper
							.correctInt((String) arrCol.get(2))) ;%>
				</tr>
			<%
				}
			%>
				<tr>
					<td align="left" colspan="2">Total Group Exposure</td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblTotalExp+dblTemp)),strAmountvalue)%></td>
				</tr>
			<%
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
	}
%>

<!-- Permissible Exposure -->

<tr>
	<td>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">Permissible exposure for the rating category of borrower :</td>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td width="50%" align="center">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="left"> Individual Rating Grade : &nbsp;&nbsp;&nbsp;</td>
							<td style="border-bottom: 0px;border-left: 0px;border-right: 0px;border-top: 0px;">
							<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td align="left" width="25%">Rating As on</td>
								<td align="left" width="25%">Rating Grade</td>
							</tr>
							<%boolean flag=true;
							if(arrRowRatingRMD!=null && arrRowRatingRMD.size()>0){
								flag=false;
								for(int i=0;i<arrRowRatingRMD.size();i++) {
									arrColExp	= (ArrayList)arrRowRatingRMD.get(i);%>
								<tr>
								<td align="left"><%=Helper.correctNull((String)arrColExp.get(0))%> (<%=Helper.correctNull((String)arrColExp.get(1))%>)</td>
								<td align="left"><%=Helper.correctNull((String)arrColExp.get(2))%></td>
								</tr>
								<%}
							}
							if(!Helper.correctNull((String)hshValues.get("cre_weight")).equalsIgnoreCase("")){ 
							flag=false;%>
							<tr>
								<td><%=Helper.correctNull((String)hshValues.get("crermd_rating_year")) %> &nbsp; ( <%=Helper.correctNull((String)hshValues.get("crermd_rating_yeartype")) %> )</td>
								<td><%=Helper.correctNull((String)hshValues.get("cre_weight")) %></td>
							</tr>
							<%}
							if(flag){ %>
							<tr>
							<td align="center" colspan="2">- Nil -</td>
							</tr>
							<%} %>
						</table>
						</td>
							
						</tr>
						</table>

					</td>
					<td width="40%" align="center">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="left" width="50%">Permitted</td>
							<td align="left" width="50%">Actual</td>
						</tr>
						<tr>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(Helper.correctDouble((String) hshValues
									.get("dblIndVal"))),strAmountvalue)%></td>
							<td align="right" width="50%">&nbsp;<%=Helper.converAmount(Helper.correctNull(jtn.format(dblTotalExp)),strAmountvalue)%>&nbsp;</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="50%" align="center">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<%
							if (arrGrpExp != null && arrGrpExp.size() > 0) {
						%> 
						<tr>
						
							<td align="left" colspan="4"> Group : </td>
						</tr>
						
						<tr>
							<td align="left" width="25%">Name</td>
							<td align="left" width="25%">Rating Grade</td>
							<td align="left" width="25%">Rating as on</td>
							<td align="left" width="25%">Exposure</td>
						</tr>
						<%
							for (int i = 0; i < arrGrpExp.size(); i++) {
									arrColExp = (ArrayList) arrGrpExp.get(i);
						%>
						<tr>
							<td align="left" width="25%"><%=Helper.correctNull((String) arrColExp.get(0))%></td>
							<td align="left" width="25%"><%=Helper.correctNull((String) arrColExp.get(1))%></td>
							<td align="left" width="25%"><%=Helper.correctNull((String) arrColExp.get(2))%></td>
							<td align="left" width="25%"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrColExp.get(3))))),strAmountvalue)%></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td align="left" width="75%" colspan="3">Total</td>
							<td align="left" width="25%"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblgrpexptot)),strAmountvalue)%></td>
						</tr>
						<%
							} else {
						%>
						<tr>
						
							<td align="left" colspan="4"> Group : Nil </td>
						</tr>
						<%
							}
						%>
						</table>

					</td>
					<td width="50%" align="center">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="left" width="50%">Permitted</td>
							<td align="left" width="50%">Actual</td>
						</tr>
						<tr>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(Helper.correctDouble((String) hshValues
									.get("dblGrpVal"))),strAmountvalue)%></td>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblgrpexptot
									+ dblTotalExp)),strAmountvalue)%></td>
						</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</td>
</tr>


<!-- External Rating -->


<tr>
	<td>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" align="left">External Rating :</td>
			</tr>
			<%
				if (Helper.correctNull((String) hshValues.get("rating_type"))
						.equalsIgnoreCase("Y")) {
			%>
			<tr>			
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrERatingRow != null && arrERatingRow.size() > 0) {
			%>
				<tr>
					<td width="3%" align="center">SI.No.</td>
					<td width="15%" align="center">Name of the rating agency</td>
					<td width="15%" align="center">Date of rating/press release</td>
					<td width="25%" align="center">Particulars of facility rated</td>
					<td width="10%" align="center">Amount rated</td>
					<td width="12%" align="center">Rating assigned</td>
					<td width="25%" align="center">Description</td>
					<td width="10%" align="center">Due Date</td>
					<td width="10%" align="center">Risk Weight</td>
				</tr>
			<%
				for (int i = 0; i < arrERatingRow.size(); i++) {
							arrCol = (ArrayList) arrERatingRow.get(i);
			%>
				<tr>
					<td align="center"><%=i + 1%>.</td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(0))%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(6))%></td>
					<td align="left"><%=Helper.changetoTitlecase((String) arrCol
										.get(1))%></td>
					<td align="right">
					<%
						double dblAmtRatedConver = 0.0;
									double dblAmtMultiply = 1.0;
									if (strValIn.equalsIgnoreCase("Crore")) {
										dblAmtMultiply = 0.0000001;
									} else if (strValIn.equalsIgnoreCase("Lacs")) {
										dblAmtMultiply = 0.00001;
									}
									if (Double.parseDouble(Helper
											.correctInt((String) arrCol.get(2))) > 0) {
										dblAmtRatedConver = Double.parseDouble(Helper
												.correctInt((String) arrCol.get(2)))
												* dblAmtMultiply;
									}
					%>
					<%=Helper.converAmount(Helper.correctNull(jtn.format(dblAmtRatedConver)),strAmountvalue)%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(3))%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(4))%></td>
					<td align="center"><%=Helper.correctNull((String) arrCol.get(5))%></td>
					<td align="center"><%=Helper.correctNull((String) arrCol.get(7))%> %</td>
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
</div>
</td>
</tr>
<%
	}
%>
<%
	if (!Helper.correctNull(
			(String) hshValues.get("ExternalRatingComments"))
			.equalsIgnoreCase("")) {
%>

<tr>
	<td><%=Helper.correctNull((String) hshValues
								.get("ExternalRatingComments"))%></td>
</tr>
<%
	}
%>
<tr>
	<td><br><b>Dealing with us since&nbsp;:&nbsp;</b>
	<%if(Helper.correctNull((String) hshValues.get("perapp_bank")).equalsIgnoreCase("1")){ %>
	<%=Helper.correctNull((String) hshValues.get("perapp_banksince"))%>
	<%}else{ %>
	 New Borrowal Account
	<%} %>
	</td>
</tr>


<tr>
	<td>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
	if (!Helper.correctNull((String) hshValues.get("presentBankArng"))
			.equalsIgnoreCase("")) {
%>
<tr>
	<td class="title"><br>Present Banking Arrangement :</td>
</tr>
<%
	}
%>
			
		</table>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<div align="left" id="top">
			<jsp:include page="../print/com_consortiumPrint.jsp" flush="true">
			<jsp:param name="pagevalue" value="PROPOSAL"/>
			<jsp:param name="pagevalueAmt" value="<%=strAmtValueIn %>"/>
			</jsp:include>
		</div>
	</td>
</tr>

<%
	if (!Helper.correctNull(
			(String) hshValues.get("fin_commentsbankargmnt"))
			.equalsIgnoreCase("")) {
%>
<tr><td><br><b>Remarks:</b></td></tr>
<tr><td style="text-align: justify;"><%=Helper.correctNull((String) hshValues
								.get("fin_commentsbankargmnt"))%></td></tr>
<%
	}
%>

<tr>
	<td class="title"><br><%=strSno[a]%>.<%a++; %>&nbsp;History & Background:</td>
</tr>
<%
	if (!Helper
			.correctNull((String) hshValues.get("com_commentsbrief"))
			.equalsIgnoreCase("")) {
%>
<tr>
	<td><%=Helper.correctNull((String) hshValues
								.get("com_commentsbrief"))%></td>
</tr>
<%
	}
%>

<tr>
	<td>The Profile of the applicant concern is furnished in Annexure-II.</td>
</tr>
<tr>
	<td>The swot analysis and the inter company comparison is given in Annexure VI.</td>
</tr>
<tr>
	<td class="title"><br><%=strSno[a]%>.<%a++; %>&nbsp;Details of existing credit facilities and the Security position :</td>
</tr>
<%
	if (!(Helper.correctNull((String) hshValues
			.get("com_commentssecoverage"))).equalsIgnoreCase("")) {
%>
<tr>
	<td><%=Helper.correctNull((String) hshValues
								.get("com_commentssecoverage"))%></td>
</tr>
<%
	}
%>
<%String strAppSecurity=Helper.correctNull((String)hshValues.get("COMSEC_APPCOVERAGE"));
if(!strAppSecurity.equalsIgnoreCase("M")){%>
<tr>
	<td valign="top">
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="50%" align="right"><%=strAmtValueIn%>&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<div align="left" id="top">
			<jsp:include page="../print/Securitiesprint.jsp" flush="true">
			<jsp:param name="pageVal" value="Security"/>
			</jsp:include>
		</div>
	</td>
</tr>
<%}else if(strAppSecurity.equalsIgnoreCase("M")){ %>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS"))%></td>
</tr>
<%} %>
<%
	String year1 = Helper.correctNull((String) hshFinlValues
			.get("txt_year1"));
		if (!(Helper.correctNull((String) hshValues
				.get("com_commentssecoverage1"))).equalsIgnoreCase("")) {
%>

<tr><td><%=Helper.correctNull((String) hshValues
									.get("com_commentssecoverage1"))%></td></tr>
<%
	}if (!year1.equalsIgnoreCase("")) {
%>

<tr><td><br>The details of the existing credit facilities and the securities available are enclosed in annexure III.</td></tr>
<tr>
	<td>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
			<tr>
				<td class="title" valign="top"><br><%=strSno[a]%>.<%a++; %>&nbsp;Financial & Business Performance :</td>
			</tr>
		</table>
	</td>
</tr>
<tr><td>Detailed Analysis of the financial statements of last 3 years is furnished in  annexure IV.
The brief financial indicators are highlighted below :</td></tr>



<tr>
<td><%=Helper.correctNull((String) hshValues.get("fin_comments_interfirm")) %></td>
</tr>

<%
	String year2 = Helper.correctNull((String) hshFinlValues
				.get("txt_year2"));
		String year3 = Helper.correctNull((String) hshFinlValues
				.get("txt_year3"));
		String year4 = Helper.correctNull((String) hshFinlValues
				.get("txt_year4"));
		String year5 = Helper.correctNull((String) hshFinlValues
				.get("txt_year5"));
%>
<tr><td align="right"><%=strFinvaluesIn%>&nbsp;</td></tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
				<tr> 
                	<td width="25%">&nbsp;Year</td>
                	<%
                		if (!year1.equalsIgnoreCase("")) {
                	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year1"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year2.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year2"))%>&nbsp;</td>
					<%
						}
					%>                  
                    <%
                                      	if (!year3.equalsIgnoreCase("")) {
                                      %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year3"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year4.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year4"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year5.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year5"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Type</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type1"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type2"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type3"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type4"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type5"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Sales</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
              
               <%
                             	if (!((Double.parseDouble(Helper
                             				.correctDouble((String) hshFinlValues
                             						.get("FINGRPCONCERN_FREETEXT41"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT42"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT43"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT44"))) == 0) && (Double
                             				.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT45"))) == 0))) {
                             %>
               			
               			
               	<tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("COM_FREETEXT4"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT41"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT42"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT43"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT44"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT45"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
             <%
                            	}
                            %>
              
               <%
                             	if (!((Double.parseDouble(Helper
                             				.correctDouble((String) hshFinlValues
                             						.get("txt_netprofit1"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit2"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit3"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit4"))) == 0) && (Double
                             				.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit5"))) == 0))) {
                             %>
               		
               	<tr> 
                  <td width="25%">&nbsp;Net Profit</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               		
               		  <%
               		               		  	if (!((Double.parseDouble(Helper
               		               		  				.correctDouble((String) hshFinlValues
               		               		  						.get("txt_tangnet1"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet2"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet3"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet4"))) == 0) && (Double
               		               		  				.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet5"))) == 0))) {
               		               		  %>
          		
          		   <tr> 
                  <td width="25%">&nbsp;Net Worth</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
          		
          		<%
          		          			}
          		          		%>	 
              
            
            	
               		  <%
	                                       	               		  	if (!((Double.parseDouble(Helper
	                                       	               		  				.correctDouble((String) hshFinlValues
	                                       	               		  						.get("txt_toltnw1"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw2"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw3"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw4"))) == 0) && (Double
	                                       	               		  				.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw5"))) == 0))) {
	                                       	               		  %>
          		
          		 <tr> 
                  <td width="25%">&nbsp;Debt-Equity Ratio</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
          		<%
          			}
          		%>
          		
          		
          		  <%
          		          		          		  	if (!((Double.parseDouble(Helper
          		          		          		  				.correctDouble((String) hshFinlValues
          		          		          		  						.get("txt_currratio1"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio2"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio3"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio4"))) == 0) && (Double
          		          		          		  				.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio5"))) == 0))) {
          		          		          		  %>
               <tr> 
                  <td width="25%">&nbsp;TOL/TNW</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
               
                <%
                                              	if (!((Double.parseDouble(Helper
                                              				.correctDouble((String) hshFinlValues
                                              						.get("txt_estproturn1"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn2"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn3"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn4"))) == 0) && (Double
                                              				.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn5"))) == 0))) {
                                              %>
          		
          		<tr> 
                  <td width="25%">&nbsp;Current Ratio</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
          		<%
                         			}
                         		%>
               
               
                  <%
                                                	if (!((Double.parseDouble(Helper
                                                				.correctDouble((String) hshFinlValues
                                                						.get("txt_freetext1"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext2"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext3"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext4"))) == 0) && (Double
                                                				.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext5"))) == 0))) {
                                                %>
          		
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt1"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
               
                 <%
                                               	if (!((Double.parseDouble(Helper
                                               				.correctDouble((String) hshFinlValues
                                               						.get("txt_freetext11"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext12"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext13"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext14"))) == 0) && (Double
                                               				.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext15"))) == 0))) {
                                               %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt2"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext11"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext12"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext13"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext14"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext15"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
                <%
                               	if (!((Double.parseDouble(Helper
                               				.correctDouble((String) hshFinlValues
                               						.get("txt_freetext21"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext22"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext23"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext24"))) == 0) && (Double
                               				.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext25"))) == 0))) {
                               %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt3"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext21"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext22"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext23"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext24"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext25"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               <%
               	}
               %>
			</table>
		</div>
	</td>
</tr>

<tr>
<td><%=Helper.correctNull((String) hshValues.get("fin_comments_interfirm1")) %></td>
</tr>



<%
	}
%>


<tr><td class="title"><br><%=strSno[a]%>.<%a++; %>&nbsp;Transactions in the existing accounts :</td></tr>
<tr><td>
<%=Helper.correctNull((String) hshValues
							.get("term_com_comments"))%>
</td></tr>
<tr><td>The conduct of the accounts along with the audit observations are furnished in annexure V.</td></tr>

<tr><td class="title"><br><%=strSno[a]%>.<%a++; %>&nbsp;Present Proposal:</td></tr>
<tr><td>
<%=Helper.correctNull((String) hshValues
							.get("presentproposal_comment"))%>
</td></tr>

<!-- Term Loan Assessment -->
<%
	if (str_arry.contains("EXPORTCF@")) {
%>
<tr><td class="title"><br>Assessment of TL</td></tr>
<%if(arrPresentTL!=null && arrPresentTL.size()>0){ %>
<tr><td>&nbsp;</td></tr>
<tr><td class="title">Details of proposed facilities:</td></tr>
<tr>			
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
<tr>
		<td align="left" width="">
		<div id="top">
			<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr><td align="center">Facility</td><td align="center">Limit</td></tr>
			<%for(int j=0;j<arrPresentTL.size();j++){ 
					arrCol=(ArrayList)arrPresentTL.get(j);%>
				<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0)) %></td>
				<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(1)),strAmountvalue) %></td>
				</tr>
				<%} %>
			</table>
		</div>
		</td>
</tr>
<% }%>
<%
	}
%>

<!-- COP -->
<%
	String strFACSno = "";
	double dblTotalCOP=0.00,dblTotalMOF=0.00;
	ArrayList arrColMOF=new ArrayList();
	int intValofZ = Integer.parseInt(Helper
			.correctInt((String) hshValues.get("ValofM")));

	if (arrCOPNewRow != null && arrCOPNewRow.size() > 0) {
%>
<%
	for (int i = 0; i < arrCOPNewRow.size(); i++) {
			arrCol = (ArrayList) arrCOPNewRow.get(i);
			strFACSno = Helper.correctInt((String) arrCol.get(0));
			dblTotalCOP=Double.parseDouble( Helper.correctDouble((String)arrCol.get(3)));
			
			/*if(arrMOFMjrRow!=null && arrMOFMjrRow.size()>0)
			{
				arrColMOF=(ArrayList)arrMOFMjrRow.get(i);
				dblTotalMOF=Double.parseDouble(Helper.correctDouble((String)arrColMOF.get(2)));
			}*/
%>
<%
	if (arrCOPNewRow.size() > 0) {
%>
<tr><td class="title"><br>
<%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;-
<%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2)))),strAmountvalue)%>&nbsp;<%=stramtValIn%>
</td></tr>
<%
	}
%>
<%
	if (!Helper.correctNull(
					(String) hshValues.get("COM_COMMENTS_COP" + strFACSno))
					.equalsIgnoreCase("")) {
%>
	<tr>
		<td><br><b>Brief Details of the project : </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String) hshValues
										.get("COM_COMMENTS_COP" + strFACSno))%></td>
	</tr>
<%
	}
%>
<% if(!Helper.correctNull((String)hshValues.get("COM_COMMENTS_COProj"+strFACSno)).equalsIgnoreCase("") ) 
{ %>
	<tr>
		<td><br><b>Comments on Project: </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_COProj"+strFACSno))%></td>
	</tr>
	<%} %>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			double dblCOPtot=0.00;
			dblintMOFtot=0.00;
			String strCOPFlag="true",strTotalCOPFlag="False";
				if (arrCOPRow != null && arrCOPRow.size() > 0) {
			%>
				
				<%int k=1;
									for (int j = 0; j < arrCOPRow.size(); j++) {

													arrCol = (ArrayList) arrCOPRow.get(j);
													if (strFACSno.equals(Helper	.correctInt((String) arrCol.get(2)))) {
														dblVal = Double.parseDouble(Helper
																.correctDouble((String) arrCol.get(1)));
														if(dblTotalCOP!=0.00)
														dblMOFinttot= Double.parseDouble(String.valueOf((dblVal * 100)/ dblTotalCOP));
														dblintMOFtot=dblintMOFtot+dblMOFinttot;
														dblCOPtot=dblCOPtot+dblVal;
														if (strFACSno.equals(Helper	.correctInt((String) arrCol.get(2))) && strCOPFlag.equalsIgnoreCase("true")) {
															strCOPFlag="false";
															strTotalCOPFlag="true";
								%>
				<tr>
				<td align="left" width="50%" colspan="4"  style="border:none"><b>Cost of the project:</b></td>
				</tr>
				<tr>
				<td align="right" width="50%"  colspan="4" style="border:none"><%=strFinvaluesIn%></td>
				</tr>
						 
				<tr>
					<td align="center" width="3%">SI.No</td>
					<td align="center" width="57%">Particulars</td>
					<td align="center" width="20%">Amount</td>
					<td align="center" width="20%">% to total cost</td>
				</tr>
				
				<%
									}
								%>
				
				<tr>
					<td align="left"><%=k%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol
												.get(0))%></td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
					<td align="right"><%=jtn.format(dblMOFinttot)%></td>
				</tr>
				<%k++;
					}
								}
								if (strTotalCOPFlag.equalsIgnoreCase("true")) {
				%>
				<tr>
					<td colspan="2" align="center">TOTAL</td>
					<td align="right"><%=jtn.format(dblCOPtot)%></td>
					<td align="right"><%=jtn.format(dblintMOFtot)%></td>
				</tr>
				<%
					}
							} 
				//else {
				%>
				<!-- <tr><td style="border: none;"><%//=strNil%></td></tr> -->
				<%
					//}
				%>
			</table>
		</div>
	</td>
</tr>

<!-- MOF -->

<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%double dblMOFtot=0.00;
			dblintMOFtot1=0.00;
			String strMOFFlag="true",strTotalMOFFlag="False";
				if (arrMOFRow != null && arrMOFRow.size() > 0) {
					for(int j=0;j<arrMOFRow.size();j++){
						arrCol	= (ArrayList)arrMOFRow.get(j);
						if(strFACSno.equals( Helper.correctInt((String)arrCol.get(2))))
						{
						dblTotalMOF+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
					
					}}
					
							int k=1;
									for (int j = 0; j < arrMOFRow.size(); j++) {
													arrCol = (ArrayList) arrMOFRow.get(j);
													if (strFACSno.equals(Helper.correctInt((String) arrCol.get(2)))) {
														dblVal = Double.parseDouble(Helper
																.correctDouble((String) arrCol.get(1)));
														if(dblTotalMOF!=0.00)
														dblMOFinttot1= Double.parseDouble(String
																.valueOf((dblVal * 100)
																		/dblTotalMOF));
														dblintMOFtot1=dblintMOFtot1+dblMOFinttot1;
														dblMOFtot=dblMOFtot+dblVal;
														if (strFACSno.equals(Helper.correctInt((String) arrCol.get(2))) && strMOFFlag.equalsIgnoreCase("true")) {
															strMOFFlag="false";
															strTotalMOFFlag="true";
								%>
						<tr>
							<td align="left" width="50%" colspan="4" style="border:none"><b>Means of Finance:</b></td>
						</tr>
						<tr>
							<td align="right" width="50%"   colspan="4" style="border:none"><%=strFinvaluesIn%></td>
						</tr>
					 
				 <tr>
					<td align="center" width="3%">SI.No</td>
					<td align="center" width="57%">Particulars</td>
					<td align="center" width="20%">Amount</td>
					<td align="center" width="20%">% to total finance</td>
				</tr>
				<%
					}
				%>
				<tr>
					<td align="left"><%=k%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol
												.get(0))%></td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
					<td align="right"><%=jtn.format(dblMOFinttot1)%></td>
				</tr>
				<% k++;
					}
								}
								if (strTotalMOFFlag.equalsIgnoreCase("true")) {
				%>
				<tr>
					<td align="center">&nbsp;</td>
					<td align="center">TOTAL</td>
					<td align="right"><%=jtn.format(dblMOFtot)%></td>
					<td align="right"><%=jtn.format(dblintMOFtot1)%></td>
				</tr>
				<%
					}
							} 
				//else {
				%>
				<!-- <tr><td style="border: none;"><%//=strNil%></td></tr> -->
				<%
					//}
				%>
			</table>
		</div>
	</td>
</tr>
<%
	if (strMOFFlag.equalsIgnoreCase("false")) {
%>
<tr>
	<td><br><b>Debt : Equity : </b>&nbsp;&nbsp;<%=Helper.correctNull((String) hshValues
										.get("dbl_Debit" + strFACSno))%></td>
</tr>
<%
	}
%>

<%
	if (!Helper.correctNull(
					(String) hshValues.get("COM_COMMENTS_SOM" + strFACSno))
					.equalsIgnoreCase("")) {
%>
	<tr>
		<td><br><b>Source of margin money: </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String) hshValues
										.get("COM_COMMENTS_SOM" + strFACSno))%></td>
	</tr>
<%
	}
%>
<%
	}

	} else if (intValofZ == 0 || intValofZ > 0) {
%>
	<%
		for (int j = 0; j <= intValofZ; j++) {

				if (!Helper.correctNull(
						(String) hshValues.get("COM_COMMENTS_COP" + j))
						.equalsIgnoreCase("")) {

					if (arrCOPNewRow != null && arrCOPNewRow.size() > 0) {
						ArrayList arrCOPNewCol = new ArrayList();

						for (int x = 0; x < arrCOPNewRow.size(); x++) {
							arrCOPNewCol = (ArrayList) arrCOPNewRow.get(x);
							if (x == j) {
								booAssFlag = false;
	%>
					<tr><td class="title"><br> <%=Helper
															.correctNull((String) arrCOPNewCol
																	.get(1))%></td></tr>
				 
				 	<tr>
				 		<td><br><b>Details of Present Proposal: </b></td>
				 	</tr>
				 	<tr>
				 		<td><%=Helper
															.correctNull((String) hshValues
																	.get("COM_COMMENTS_COP"
																			+ j))%></td>
				 	</tr>
				 <%
				 	}
				 					}

				 				}
				 			}

				 		}
				 %>
<%
	} else {
		if (booAssFlag) {
%>
		<tr><td style="border: none;"><%=strNil%></td></tr>
	<%
		}

		}
	%>
<!-- DSCR -->
<%
	if (hshFinDSCR != null && hshFinDSCR.size() > 0) {
%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>DSCR</td>
			</tr>
		</table>
	</td>
</tr>
<tr><td>
<%=Helper.correctNull((String) hshValues
								.get("fin_comments_dscr"))%>
</td></tr>
<tr>
<td align="right" width=""><%=strFinvaluesIn%></td>
</tr>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<div align="left" id="top">
			<jsp:include page="../print/DSCR_Print.jsp" flush="true">
			<jsp:param name="pageVal" value="DSCR"/>
			</jsp:include>
		</div>
	</td>
</tr>
<tr>
	<td><%=Helper.correctNull((String) hshValues
								.get("fin_comments1_dscr"))%></td>
</tr>
<%
	}
%>

<!-- Sensitivity Ananlysis -->

<%
	if (hshFinSEN != null && hshFinSEN.size() > 0) {
%>


<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Sensitivity Analysis:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments_sensitive"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments_sensitive"))%></td></tr>
<%
	}
%>
<tr>
<td align="right"><%=strFinvaluesIn%></td>
</tr>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<div align="left" id="top">
			<jsp:include page="../print/sensitivity_print.jsp" flush="true">
			<jsp:param name="pageVal" value="SENSITIVITY"/>
			</jsp:include>
		</div>
	</td>
</tr>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments1_sensitive"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments1_sensitive"))%></td></tr>
<%
	}
%>
<%
	}
%>
<tr>
<td>
<%
	String str_array[] = { "<b>Particulars</b>", "SOURCES OF FINANCE",
			"Opening Balance", "Promoters Equity", "Bank Finance",
			"Unsecured Loan", "Advance Received",
			"Sale proceeds net of Advance", "TOTAL",
			"APPLICATION OF FINANCE", "Cost of Land",
			"Premium FSI & Approval Cost", "Construction Cost",
			"Marketing Expenses", "Administrative Expenses", "Others",
			"Interest", "Repayment", "Provision of tax", "TOTAL",
			"Closing Balance" };

	int count = Integer.parseInt(Helper.correctInt((String) hshValues
			.get("CashCount")));
	if (count > 0) {
%>
	
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td>
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title"><br>Cash Flow Method</td>
						<td align="right" width="">&nbsp;</td>
					</tr>
					<%
						if (!Helper.correctNull(
									(String) hshValues.get("fin_comments_cashflow"))
									.equalsIgnoreCase("")) {
					%>
<tr><td colspan="2"><%=Helper.correctNull((String) hshValues
									.get("fin_comments_cashflow"))%></td></tr>
<%
	}
%>
				</table>
			</td>
		</tr>
	</table>
	<%
		for (int h = 0; h < count; h++) {
				ArrayList arrRows = (ArrayList) hshValues.get("CashFlow"
						+ (h + 1));
				ArrayList arrRows6 = (ArrayList) hshValues.get("CashFlowTOT");
				int val = Integer.parseInt(Helper
						.correctInt((String) hshValues.get("rowcount"
								+ (h + 1))));
	%>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td>
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title">Financial Year : <%=Helper.correctNull((String) hshValues
									.get("finyear" + (h + 1)))%></td>
					</tr>
					<tr>
						<td align="right" width=""><%=strFinvaluesIn%></td>
					</tr>
				</table>
			</td>
		</tr>
		</table>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
			int c = 0, b = 0;
					ArrayList arrCols = (ArrayList) arrRows.get(c++);
					ArrayList arrCols1 = (ArrayList) arrRows.get(c++);
					ArrayList arrCols2 = (ArrayList) arrRows.get(c++);
					ArrayList arrCols3 = (ArrayList) arrRows.get(c++);
					ArrayList arrCols4 = (ArrayList) arrRows.get(c++);
					ArrayList arrCols5 = (ArrayList) arrRows.get(c++);
					ArrayList arrCols6 = (ArrayList) arrRows6.get(0);

					for (int g = 0; g < 21; g++) {
		%>
			<tr>
				<%
					if (g == 1 || g == 9) {
				%>
				
					<td  colspan="<%=val%>"><b><%=str_array[g]%></b></td>
				<%
					} else {
				%>	
					<td width ="25%"><%=str_array[g]%></td>
					
					<%
											if (b == 0) {
										%>
					<%
						if (!Helper.correctNull(
													(String) arrCols6.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="center" width ="15%"><%=Helper
															.correctNull((String) arrCols6
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols1.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="center" width ="15%"><%=Helper
															.correctNull((String) arrCols1
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols2.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="center" ><%=Helper
															.correctNull((String) arrCols2
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols3.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="center" ><%=Helper
															.correctNull((String) arrCols3
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols4.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="center" ><%=Helper
															.correctNull((String) arrCols4
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols5.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="center" ><%=Helper
															.correctNull((String) arrCols5
																	.get(b))%>&nbsp;</td>
					
					<%
											}
															} else {
										%>
					<%
						if (!Helper.correctNull(
													(String) arrCols6.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="right" width ="15%"><%=Helper
															.correctNull((String) arrCols6
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols1.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="right" width ="15%"><%=Helper
															.correctNull((String) arrCols1
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols2.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="right" ><%=Helper
															.correctNull((String) arrCols2
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols3.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="right" ><%=Helper
															.correctNull((String) arrCols3
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols4.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="right" ><%=Helper
															.correctNull((String) arrCols4
																	.get(b))%>&nbsp;</td>
					<%
						}
											if (!Helper.correctNull(
													(String) arrCols5.get(0))
													.equalsIgnoreCase("")) {
					%>
					<td align="right" ><%=Helper
															.correctNull((String) arrCols5
																	.get(b))%>&nbsp;</td>
					
					<%
											}
															}
															b++;
														}
													}
										%>
			</tr>
			</table><br>
		</div>
		<%
			}
		%>
<%
	}
%>
</td>
</tr>
<%
	if (!Helper.correctNull(
			(String) hshValues.get("fin_comments1_cashflow"))
			.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
								.get("fin_comments1_cashflow"))%></td></tr>
<%
	}
%>
<%
	if (strLoanType.equalsIgnoreCase("a")) {
%>

		<tr>
	<td>
		<div align="left" id="top">
			<jsp:include page="../print/com_agrassessment_process.jsp" flush="true">
			<jsp:param name="pageVal" value="PROCESS"/>
			</jsp:include>
		</div>
	</td>
</tr>
<%
	}
%>
	
<%
		if (!Helper.correctNull(
				(String) hshValues.get("com_tlassessment_comments"))
				.equalsIgnoreCase("")) {
	%>	
<tr><td class="title">Other Term Loan Assessment : </td></tr>
<tr><td ><%=Helper.correctNull((String) hshValues
								.get("com_tlassessment_comments"))%></td></tr>
<%
	}
%>

<!-- Mode of Repayment -->
<%
	if (str_arry.contains("EXPORTCF@")) {
%>
<tr><td class="title"><br>Mode of Repayment:</td></tr>
<tr>
	<td align="right" width=""><%=strAmtValueIn%></td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrFAConlyRow != null && arrFAConlyRow.size() > 0) {
			%>
			<tr>
				<td align="center" width="3%">S.No</td>
				<td align="center" width="47%">Facility</td>
				<td align="center" width="30%">Mode of Repayment</td>
				<td align="center" width="20%">Amount</td>
			</tr>
				<%
					for (int i = 0; i < arrFAConlyRow.size(); i++) {
								arrCol = (ArrayList) arrFAConlyRow.get(i);

								if (Helper.correctNull((String) arrCol.get(4))
										.equalsIgnoreCase("2")) {
				%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td><%=Helper.correctNull((String) arrCol
											.get(0)).toUpperCase()%></td>
				<td><%=Helper
													.correctNull((String) arrCol
															.get(1))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol
															.get(2))))),strAmountvalue)%></td>
			</tr>
			<%
				}
						}
					}
			%>
			</table>
		</div>
	</td>
</tr>
<%
		if (false) {
	%>
	<tr><td class="title">Comments&nbsp;:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
								.get("fin_comments_repay"))%></td></tr>
	<tr><td>&nbsp;</td></tr>
<%
	}
%>
<%
	}
%>

	
<%
if (str_arry.contains("CGSSD@")) {
%>
	<tr>
		<td style="border: none;"  class="title" align="left">Assessment for KBL CGSSD Scheme :</td>
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
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(0))))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
	<tr>
				<td><b>2.<%=strDesc[1] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(1))))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>3.<%=strDesc[2] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(2))))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>4.<%=strDesc[3] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(3))))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>5.<%=strDesc[4] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(4))))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>6.<%=strDesc[5] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(5))))),strAmountvalue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>7.<%=strDesc[6] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(6))))),strAmountvalue)%></td>
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
<tr><td>&nbsp;</td></tr>
<!-- Release Pattern Started -->
<%
	if (arrReleaseRow != null && arrReleaseRow.size() > 0) {
		ArrayList arrReleaseCol = new ArrayList();%>
		 <tr><td class="title" valign="top"><br>Release pattern/ margin requirement:</td></tr>
				  <tr><td align="right" ><%=strFinvaluesIn%></td></tr>
		<%for (int i = 0; i < arrReleaseRow.size(); i++) {
			arrReleaseCol = (ArrayList) arrReleaseRow.get(i);
			String strRel = Helper.correctNull((String) arrReleaseCol.get(2));
			//String strImpl = Helper.correctNull((String) arrReleaseCol.get(7));
			//String strEstimate = Helper.correctNull((String) arrReleaseCol.get(9));
			String strImpl="",strEstimate="";
			String fachead =Helper.correctNull((String) arrReleaseCol.get(1));
	 		if (arrReleaseCol != null && arrReleaseCol.size() > 0) { 
				ArrayList arrRowPattern = new ArrayList();
				ArrayList arrColPattern = new ArrayList();
				arrRowPattern = (ArrayList) hshValues.get("arrRowPattern" + i);
				if (arrRowPattern != null && arrRowPattern.size() > 0) {
					%>
					
				 <% if (strRel.equalsIgnoreCase("ReleasePattern")) { %>
					<tr>
					<td>
						<div id="top">
							<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
							<tr><td valign="top" colspan="7"><b>
				  <%=Helper.correctNull((String) arrReleaseCol.get(1))%>&nbsp; of Rs. - <%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrReleaseCol.get(5)))),strAmountvalue)%> &nbsp;<%=stramtValIn%></b>
				  </td></tr>
 												<%
 												for (int k = 0; k < arrRowPattern.size(); k++) {
 													arrColPattern = (ArrayList) arrRowPattern
 															.get(k);
					 						%>
									 
				  <% if(k==0) { %>
												<tr>
												<td align="center" width="3%">SI.No</td>
												<td align="center" width="37%">Particulars</td>
												<td align="center" width="12%">Total cost</td>
												<td align="center" width="12%">Margin brought by the Company</td>
												<td align="center" width="12%">% to cost</td>
												<td align="center" width="12%">Bank Loan</td>
												<td align="center" width="12%">% to cost</td>
												</tr>
												<% } %>
												<tr>
												<td align="left" width="3%"><%=k + 1%></td>
												<td align="left" width="37%"><%=Helper
															.correctNull((String) arrColPattern
																	.get(0))%></td>
												<td align="right" width="12%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrColPattern
																					.get(1))))%></td>
												<td align="right" width="12%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrColPattern
																					.get(2))))%></td>
												<td align="right" width="12%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrColPattern
																					.get(3))))%></td>
												<td align="right" width="12%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrColPattern
																					.get(4))))%></td>
												<td align="right" width="12%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrColPattern
																					.get(5))))%></td>
												</tr>
												
												<%
																									if (k == arrRowPattern.size() - 1) {
																								%>
												<tr>
												<td colspan="2" align="center">TOTAL</td>
												<td align="right"><%=jtn
																.format(Double
																		.parseDouble(Helper
																				.correctDouble((String) hshValues
																						.get("dblRPTotCost"
																								+ i))))%></td>
												<td align="right"><%=jtn
																.format(Double
																		.parseDouble(Helper
																				.correctDouble((String) hshValues
																						.get("dblRPTotMargin"
																								+ i))))%></td> 
												<td align="right"></td>
												<td align="right"><%=jtn
																.format(Double
																		.parseDouble(Helper
																				.correctDouble((String) hshValues
																						.get("dblRPTotLoan"
																								+ i))))%></td>
												<td align="right"></td>
												</tr>
												<%
													}
												%>
											
							<%
								} %>
								</table>
										</div>
									</td>
								</tr>
								<% } } } %>
				  <% if (strEstimate.equalsIgnoreCase("Estimate")) { %>
				  	<tr><td class="title"><br>Estimated Commercial Operation Date :&nbsp;<%=Helper.correctNull((String) arrReleaseCol
										.get(8))%></td></tr>
				 <%
				 	} } }
				 %>
<!-- Schedule of Implementation -->
<%
arrRow = new ArrayList();
arrCol = new ArrayList();
boolean titleFlag=true;
if (arrImplSchRow != null && arrImplSchRow.size() > 0) {
	%>
	<tr><td class="title"><br>Schedule of Implementation:</td></tr> 
		   <tr>
		  <td>
		  <div id="top">
		  <table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	
	<%
	
	String facName = "";
	for (int i = 0; i < arrImplSchRow.size(); i++) {
		arrImplSchCol = (ArrayList) arrImplSchRow.get(i);
		//facName = Helper.correctNull((String) arrImplSchCol.get(1));
		arrRow = (ArrayList) arrImplSchCol.get(2);
		if (arrRow != null && arrRow.size() > 0) {
			for (int j = 0; j < arrRow.size(); j++) {
				arrCol = (ArrayList) arrRow.get(j);
				if (arrCol != null && arrCol.size() > 0) {
					if(j==0) {
				%>
					<tr> <td colspan="5"><%=Helper.correctNull((String) arrImplSchCol.get(1)) %> of Rs.  - <%=Helper.converAmount(Helper.correctNull((String) arrImplSchCol.get(3)),strAmountvalue) %> <%=stramtValIn%></td> </tr>
					<tr>
					  <td width="3%" align="center">S.No</td>
					  <td width="47%" align="center">Description</td>
					  <td width="10%" align="center">Date of Commencement</td>
					  <td width="10%" align="center">Date of Completion</td>
					  <td width="30%" align="center">Present Status</td>
					  </tr>
					  <% } %>
					  <tr>
					  <td align="left"><%=j + 1%></td>
					  <td align="left"><%=Helper.correctNull((String) arrCol.get(1))%></td>
					  <td align="center"><%=Helper.correctNull((String) arrCol.get(2))%></td>
					  <td align="center"><%=Helper.correctNull((String) arrCol.get(3))%></td>
					  <td align="left"><%=Helper.correctNull((String) arrCol.get(4))%></td>
					  </tr>
			
		<% } } } } %>
		</table>
		  </div>
		  </td>
		  </tr>
<% } %>
<%if(arrPresentWC!=null && arrPresentWC.size()>0){ %>
<tr><td class="title" valign="top">Assessment of fund based working capital limits :</td></tr>
<tr>
	<td>
	<span title="pagebreak" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr><td align="right" width="100%" colspan="6">&nbsp;&nbsp;<%=strAmtValueIn%></td></tr>	
			<tr>
			<td align="left" width="50%" class="title">i) Fund Based :</td>
			</tr>
		</table>
	</td>
</tr>
<%} %>
<%if(arrExistingWC!=null && arrExistingWC.size()>0){ %>
<tr><td width="30%" class="title">Details of existing fund based limits&nbsp;:&nbsp;</td></tr>
<tr>			
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
<tr>
	<td>
		<div id="top">
				<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr><td align="center">Facility</td><td align="center">Limit</td></tr>
				<%for(int j=0;j<arrExistingWC.size();j++){ 
					arrCol=(ArrayList)arrExistingWC.get(j);%>
				<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0)) %></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull((String) arrCol.get(1)),strAmountvalue) %></td>
				</tr>
				<%} %>
				</table>
			</div>
		</td>
</tr>
<% }%>
<%if(arrPresentWC!=null && arrPresentWC.size()>0){ %>
<tr><td class="title">Details of proposed facilities:</td></tr>
<tr>			
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
<tr>
		<td align="left" width="">
		<div id="top">
			<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr><td align="center">Facility</td><td align="center">Limit</td></tr>
			<%for(int j=0;j<arrPresentWC.size();j++){ 
					arrCol=(ArrayList)arrPresentWC.get(j);%>
				<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0)) %></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull((String) arrCol.get(1)),strAmountvalue)  %></td>
				</tr>
				<%} %>
			</table>
		</div>
		</td>
</tr>
<% }%>
<!-- Estimates of sales -->
<%
	if (!Helper.correctNull((String) hshValues.get("strLastYrEst"))
			.equalsIgnoreCase("")) {
%>
<tr>
	<td>	
		<div>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Estimates and actual for last three years:</td>
				</tr>
				<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strLastYrEst"))%></td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<%
	}
%>

<%
	if (!Helper.correctNull((String) hshValues.get("strCurrYrEst"))
			.equalsIgnoreCase("")) {
%>
<tr>
	<td>	
		<div>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Estimates of sales for the current year & for the next year:</td>
				</tr>
				<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strCurrYrEst"))%></td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<%
	}
%>

<!-- Justification for sales -->
 
<%
 	if (!Helper.correctNull((String) hshValues.get("strJustification"))
 			.equalsIgnoreCase("")) {
 %>
<tr>
	<td>	
		<div>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Justification for sales:</td>
				</tr>
				<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strJustification"))%></td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<%
	}
%>
<%
	if (arrTORow != null && arrTORow.size() > 0) {
%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Turnover Method:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_commentsturnover"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_commentsturnover"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%
	}
%>

<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td>&nbsp;</td>
			
				<td align="right" width=""><%=strFinvaluesIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrTORow != null && arrTORow.size() > 0) {
			%>
				<%
					for (int i = 0; i < 13; i++) {
				%>
				<tr>
					<td width="3%" align="center"><%
						if (i > 0) {
					%><%=i%>.<%
						} else {
					%>&nbsp;<%
						}
					%></td>
					<td width="47%"><%=strTOLabel[i]%></td>
					<%
						for (int j = 0; j < arrTORow.size(); j++) {
										arrCol = (ArrayList) arrTORow.get(j);
										if (!Helper.correctNull((String) arrCol.get(0))
												.equals("")) {
					%>
						<%
							if (i == 0) {
						%><td align="center" width="10%"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%></td><%
							}
						%>
						<%
							if (i == 1) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td><%
							}
						%>
						<%
							if (i == 2) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(2))))%></td><%
							}
						%>
						<%
							if (i == 3) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(3))))%></td><%
							}
						%>
						<%
							if (i == 4) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(4))))%></td><%
							}
						%>
						<%
							if (i == 5) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(5))))%></td><%
							}
						%>
						<%
							if (i == 6) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(6))))%></td><%
							}
						%>
						<%
							if (i == 7) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(7))))%></td><%
							}
						%>
						<%
							if (i == 8) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(8))))%></td><%
							}
						%>
						<%
							if (i == 9) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(9))))%></td><%
							}
						%>
						<%
							if (i == 10) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(10))))%></td><%
							}
						%>
						<%
							if (i == 11) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(11))))%></td><%
							}
						%>
						<%
							if (i == 12) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(12))))%></td><%
							}
						%>
						<%
							if (i == 13) {
						%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(13))))%></td><%
							}
						%>
						<%
							}
										}
									}
						%>
				</tr>
				<%
					} else {
				%>
				<tr style="visibility: hidden;position: absolute;"><td style="border: none;"><%=strNil%></td></tr>
				<%
					}
				%>
			</table>
		</div>
	</td>
</tr>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments1turnover"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments1turnover"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%
	}
	}
%>


<!-- Expenditure Method -->

<%
	if (arrExpRow != null && arrExpRow.size() > 0) {
%>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Expenditure Method:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_commentsexpenditure"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_commentsexpenditure"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%
	}
%>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td>&nbsp;</td>
				<td align="right" width=""><%=strFinvaluesIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrExpRow != null && arrExpRow.size() > 0) {
			%>
				<%
					for (int i = 0; i < 8; i++) {
				%>
				<tr>
					<td width="3%" align="center"><%
						if (i > 0) {
					%><%=i%>.<%
						} else {
					%>&nbsp;<%
						}
					%></td>
					<td width="47%"><%=strExpLabel[i]%></td>
				<%
					for (int j = 0; j < arrExpRow.size(); j++) {
									arrCol = (ArrayList) arrExpRow.get(j);
									if (!Helper.correctNull((String) arrCol.get(0))
											.equals("")) {
				%>
				<%
					if (i == 7) {
				%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(7))))%></td><%
					}
				%>
				<%
					if (i == 0) {
				%><td align="center" width="10%"><%=Helper
															.correctNull((String) arrCol
																	.get(0))%></td><%
					}
				%>
				<%
					if (i == 1) {
				%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(1))))%></td><%
					}
				%>
				<%
					if (i == 2) {
				%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(2))))%></td><%
					}
				%>
				<%
					if (i == 3) {
				%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(3))))%></td><%
					}
				%>
				<%
					if (i == 4) {
				%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(4))))%></td><%
					}
				%>
				<%
					if (i == 5) {
				%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(5))))%></td><%
					}
				%>
				<%
					if (i == 6) {
				%><td align="right" width="10%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrCol
																					.get(6))))%></td><%
					}
				%>
				<%
					}
								}
							}
				%>
				</tr>
				
			<%
								} else {
							%>
				<tr style="visibility: hidden;position: absolute;"><td style="border: none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments1expenditure"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments1expenditure"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%
	}
	}
%>

<tr><td>
<%
	String str_arr[] = { "Particulars", "<b>Cash Inflows</b>",
			"Net contract receipts", "Sub contrcat Receipts",
			"Other Receipts", "Total Receipts", "<b>Cash Outflows</b>",
			"Materials", "Salaries & Wages", "Salaries & Wages",
			"Hire Charges", "Labour Charges",
			"Diesel & Petrol Charges ", "Repair & Maintenance",
			"Travelling Expenses", "Other Operating Expenses",
			"Bank Interest & Charges", "Tax payable ",
			"Administrative expenses ", "Other expenses ",
			"Total Outflows ", "Surplus / Deficit" };
	HashMap hshRecord = new HashMap();
	count = Integer.parseInt(Helper.correctInt((String) hshValues
			.get("count")));
	if (count > 0) {
%>
	
	<%
			for (int h = 0; h < count; h++) {

					ArrayList arrRows = (ArrayList) hshValues
							.get("y" + (h + 1));
					if (arrRows != null && arrRows.size() > 0) {
		%>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td>
						<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
							<tr>
								<td class="title"><br>Cash Budget Method:</td>
							</tr>
							<tr>
								<td align="right" width=""><%=strFinvaluesIn%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<%
			if(h==0){
				if (!Helper.correctNull(
									(String) hshValues
											.get("fin_commentscashbudget"))
									.equalsIgnoreCase("")) {
			%>
<table><tr><td><%=Helper.correctNull((String) hshValues
											.get("fin_commentscashbudget"))%></td></tr></table>
<%
	}}
%>
			
			<%
							int rowcount = Integer.parseInt(Helper
												.correctInt((String) hshValues.get("rowtype"
														+ (h + 1))));
										int val = Integer.parseInt(Helper
												.correctInt((String) hshValues.get("rowcount"
														+ (h + 1))));
										if (rowcount == 12) {
											int c = 0, f = 0, b = 0;
											ArrayList arrCols = (ArrayList) arrRows.get(c++);
											ArrayList arrCols1 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols2 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols3 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols4 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols5 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols6 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols7 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols8 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols9 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols10 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols11 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols12 = (ArrayList) arrRows.get(c++);
											ArrayList arrCols13 = (ArrayList) arrRows.get(c++);
						%>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr><td>
				<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		 <b>Financial Year : <%=Helper.correctNull((String) hshValues
											.get("cb_finyear" + (h + 1)))%></b></td></tr>
			</table>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				for (; f < 22; f++) {
			%>
				<tr><td width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
			<%
				if (f == 1 || f == 6) {
			%>
				<td colspan="<%=val%>">&nbsp;</td>
				<%
					} else {
				%>
				
					<%
										if (b == 0) {
									%>
						<%
							if (!Helper.correctNull(
																(String) arrCols.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols1.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols1
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols2.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols2
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols3.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols3
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols4.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols4
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols5.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols5
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols6.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols6
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols7.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols7
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols8.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols8
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols9.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols9
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols10.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols10
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols11.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols11
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols12.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols12
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols13.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="center" ><%=Helper
																	.correctNull((String) arrCols13
																			.get(b))%></td>
					
					<%
											}
																	} else {
										%>
						<%
							if (!Helper.correctNull(
																(String) arrCols.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols1.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols1
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols2.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols2
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols3.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols3
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols4.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols4
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols5.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols5
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols6.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols6
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols7.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols7
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols8.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols8
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols9.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols9
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols10.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols10
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols11.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols11
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols12.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols12
																			.get(b))%></td>
						<%
							}
														if (!Helper.correctNull(
																(String) arrCols13.get(0))
																.equalsIgnoreCase("")) {
						%>
						<td align="right" ><%=Helper
																	.correctNull((String) arrCols13
																			.get(b))%></td>
					<%
						}
												}
												b++;
											}
					%>
			</tr>
		<%
			}
		%>
		</table>
	</div>
	<br>
	<%
		} else if (rowcount == 4) {
						int c = 0, f = 0, b = 0;
						ArrayList arrCols = (ArrayList) arrRows.get(c++);
						ArrayList arrCols1 = (ArrayList) arrRows.get(c++);
						ArrayList arrCols2 = (ArrayList) arrRows.get(c++);
						ArrayList arrCols3 = (ArrayList) arrRows.get(c++);
						ArrayList arrCols4 = (ArrayList) arrRows.get(c++);
						ArrayList arrCols5 = (ArrayList) arrRows.get(c++);
	%>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				for (; f < 22; f++) {
			%>
				<tr><td width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
			<%
				if (f == 1 || f == 6) {
			%>
				<td colspan="<%=val%>">&nbsp;</td>
				<%
					} else {
				%>
					<%
						if (!Helper.correctNull(
														(String) arrCols.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols
																		.get(b))%></td>
					<%
						}
												if (!Helper.correctNull(
														(String) arrCols1.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols1
																		.get(b))%></td>
					<%
						}
												if (!Helper.correctNull(
														(String) arrCols2.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols2
																		.get(b))%></td>
					<%
						}
												if (!Helper.correctNull(
														(String) arrCols3.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols3
																		.get(b))%></td>
					<%
						}
												if (!Helper.correctNull(
														(String) arrCols4.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols4
																		.get(b))%></td>
					<%
						}
												if (!Helper.correctNull(
														(String) arrCols5.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols5
																		.get(b))%></td>
					<%
						}
												b++;
					%>
					<%
						}
										}
					%>
			</tr>
		</table>
	</div>
	<br>
	<%
		} else if (rowcount == 2) {
						int c = 0, f = 0, b = 0;
						ArrayList arrCols = (ArrayList) arrRows.get(c++);
						ArrayList arrCols1 = (ArrayList) arrRows.get(c++);
						ArrayList arrCols2 = (ArrayList) arrRows.get(c++);
						ArrayList arrCols3 = (ArrayList) arrRows.get(c++);
	%>
				<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
					for (; f < 22; f++) {
				%>
					<tr><td  width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
				<%
					if (f == 1 || f == 6) {
				%>
					<td colspan="<%=val%>">&nbsp;</td>
					<%
						} else {
					%>
						<%
							if (!Helper.correctNull(
															(String) arrCols.get(0))
															.equalsIgnoreCase("")) {
						%>
						<td align="right"><%=Helper
																.correctNull((String) arrCols
																		.get(b))%></td>
						<%
							}
													if (!Helper.correctNull(
															(String) arrCols1.get(0))
															.equalsIgnoreCase("")) {
						%>
						<td align="right"><%=Helper
																.correctNull((String) arrCols1
																		.get(b))%></td>
						<%
							}
													if (!Helper.correctNull(
															(String) arrCols2.get(0))
															.equalsIgnoreCase("")) {
						%>
						<td align="right"><%=Helper
																.correctNull((String) arrCols2
																		.get(b))%></td>
						<%
							}
													if (!Helper.correctNull(
															(String) arrCols3.get(0))
															.equalsIgnoreCase("")) {
						%>
						<td align="right"><%=Helper
																.correctNull((String) arrCols3
																		.get(b))%></td>
						<%
							}
													b++;
						%>
						<%
							}
											}
						%>
				</tr>
			</table>
		</div>
		<br>
		<%
			} else if (rowcount == 1) {
							int c = 0, f = 0, b = 0;
							ArrayList arrCols = (ArrayList) arrRows.get(c++);
							ArrayList arrCols1 = (ArrayList) arrRows.get(c++);
							ArrayList arrCols2 = (ArrayList) arrRows.get(c++);
		%>
				<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
					for (; f < 22; f++) {
				%>
					<tr><td width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
						
				
				<%
															if (f == 1 || f == 6) {
														%>
					<td colspan="<%=val%>">&nbsp;</td>
					<%
						} else {
					%>
					<%
						if (!Helper.correctNull(
														(String) arrCols.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols
																		.get(b))%></td>
					<%
						}
												if (!Helper.correctNull(
														(String) arrCols1.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols1
																		.get(b))%></td>
					<%
						}
												if (!Helper.correctNull(
														(String) arrCols2.get(0))
														.equalsIgnoreCase("")) {
					%>
					<td align="right"><%=Helper
																.correctNull((String) arrCols2
																		.get(b))%></td>
					<%
						}
												b++;
					%>
					<%
						}
										}
					%>
				</tr>
			</table>
		</div>
		</td>
		</tr>
		<%
			}
					}
				}
			} else {
		%>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_commentscashbudget"))
				.equalsIgnoreCase("")) {
%>
<tr ><td class="title">Cash Budget Method : </td></tr>
<tr style="visibility: hidden;position: absolute;"><td style="border: none;"><%=strNil%></td></tr>
<%
	}
	}
%>

<%
	if (!Helper.correctNull(
			(String) hshValues.get("fin_comments1cashbudget"))
			.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
								.get("fin_comments1cashbudget"))%></td></tr>
<%
	}
%>

<!-- Assessment of Method 1/Method 2/Working Capital -->
<%
	if (hshFinmethod1 != null && hshFinmethod1.size() > 0) {
%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">Method I of lending other than export limits:</td>
			</tr>
		</table>
	</td>
</tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments_method1"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments_method1"))%></td></tr>
<%
	}
%>
<tr><td align="right"><%=strFinvaluesIn%></td></tr>
<tr><td>
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method1"/>
</jsp:include></td></tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments1_method1"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments1_method1"))%></td></tr>
<%
	}
%>
<%
	}
%>

<%
	if (hshFinmethod2 != null && hshFinmethod2.size() > 0) {
%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">Method II of lending other than export limits:</td>
			</tr>
		</table>
	</td>
</tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments_method2"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments_method2"))%></td></tr>
<%
	}
%>
<tr><td align="right"><%=strFinvaluesIn%></td></tr>
<tr><td>
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method2"/>
</jsp:include></td></tr>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments1_method2"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments1_method2"))%></td></tr>
<%
	}
%>
<%
	}
%>

<%
	if (hshFinmethod3 != null && hshFinmethod3.size() > 0) {
%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" valign="top"><br>Working Capital gap method for export limits:</td>
			</tr>
		</table>
	</td>
</tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments_wcg"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments_wcg"))%></td></tr>
<%
	}
%>
<tr><td align="right"><%=strFinvaluesIn%></td></tr>
<tr><td>
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method3"/>
</jsp:include></td></tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("fin_comments1_wcg"))
				.equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("fin_comments1_wcg"))%></td></tr>
<%
	}
%>
<%
	}
%>

<!-- Financial Comments 

<%if (!Helper.correctNull((String) hshValues.get("FIComments1"))
					.equalsIgnoreCase("")) {%>
<tr><td class="title"><br><span  class="title">Inventory :</span></td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
								.get("FIComments1"))%></td></tr><%}%>

<%if (!Helper.correctNull((String) hshValues.get("FIComments3"))
					.equalsIgnoreCase("")) {%>
<tr><td class="title"><br><span  class="title">Receivables :</span></td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
								.get("FIComments3"))%></td></tr><%}%>

<%if (!Helper.correctNull((String) hshValues.get("FIComments5"))
					.equalsIgnoreCase("")) {%>
<tr><td class="title"><br><span  class="title">Creditors :</span></td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
								.get("FIComments5"))%></td></tr><%}%>

<%if (!Helper.correctNull((String) hshValues.get("FIComments6"))
					.equalsIgnoreCase("")) {%>
<tr><td class="title"><br><span  class="title">Other Current Assets and Liabilities :</span></td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
								.get("FIComments6"))%></td></tr><%}%>
-->

<%
	if (!Helper.correctNull((String) hshValues.get("strInv"))
			.equalsIgnoreCase("")
			|| !Helper.correctNull((String) hshValues.get("strReceiv"))
					.equalsIgnoreCase("")
			|| !Helper.correctNull(
					(String) hshValues.get("strCreditors"))
					.equalsIgnoreCase("")
			|| !Helper.correctNull(
					(String) hshValues.get("strOtherAssets"))
					.equalsIgnoreCase("")) {
%>
<tr>
	<td>	
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<div>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left">Comments:</td>
				</tr>
				<%
					if (!Helper.correctNull((String) hshValues.get("strInv"))
								.equalsIgnoreCase("")) {
				%>
				<tr>
					<td class="title" align="left">Inventory:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("strInv"))%></td>
				</tr>
				<%
					}
				%>
				<%
					if (!Helper.correctNull((String) hshValues.get("strReceiv"))
								.equalsIgnoreCase("")) {
				%>
				<tr>
					<td class="title" align="left">Receivables:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("strReceiv"))%></td>
				</tr>
				<%
					}
				%>
				<%
					if (!Helper.correctNull((String) hshValues.get("strCreditors"))
								.equalsIgnoreCase("")) {
				%>
				<tr>
					<td class="title" align="left">Creditors:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("strCreditors"))%></td>
				</tr>
				<%
					}
				%>
				<%
					if (!Helper.correctNull(
								(String) hshValues.get("strOtherAssets"))
								.equalsIgnoreCase("")) {
				%>
				<tr>
					<td class="title" align="left">Other current Assets and liabilities:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("strOtherAssets"))%></td>
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
<!-- Other Assessment Comments -->
<tr>
	<td>
		<div >
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				
				<%
									if (!Helper.correctNull(
											(String) hshValues.get("com_wcassessment_comments"))
											.equalsIgnoreCase("")) {
								%>
				<tr><td class="title" align="left"><b>Other Working Capital Assessment : </b></td></tr>
				
				
				<tr><td><%=Helper.correctNull((String) hshValues
								.get("com_wcassessment_comments"))%></td></tr>
				
				<tr><td class="title" align="left"><b>&nbsp;</b></td></tr><%
									}
								%>

			</table>
		</div>
	</td>
</tr>
<!-- Assessment Holding level comments -->
<%
	if (arrAssmntRow.size() > 0 && arrAssmntRow != null) {
%>
<tr>
	<td>	
		<div>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
					if (!Helper.correctNull((String) hshValues.get("strBreakup"))
								.equalsIgnoreCase("")) {
				%>
				<tr>
					<td class="title" align="left">Break up of limits:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("strBreakup"))%></td>
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

<!-- Assessment of Inland / Import LC -->


<tr>
<td>
<%
	String str_aray[] = { "<b>Accepted for the year ending</b>",
			"Sales", "Purchases", "Projected purchases under LC",
			"Avg. monthly purchases under LC",
			"Normal credit period (in months)",
			"Transit Period (in months)", "LC requirement",
			"Applied limit", "Recommended limit" };

	count = Integer.parseInt(Helper.correctInt((String) hshValues
			.get("InlandCount")));
	if (count > 0) {
%>
	
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
			<td class="title" align="left"><b>Assessment of non fund based working capital limits : </b></td>
	</tr>
		<tr>
			<td>
			<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title"><br>Assessment of Inland / Import LC:</td>
						<td align="right" width="">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right" ><%=strFinvaluesIn%></td>
					</tr>
					<%
					if (!Helper.correctNull(
							(String) hshValues.get("fin_commentsinlandComments"))
							.equalsIgnoreCase("")) {
				%>
				<tr><td colspan="2"><%=Helper.correctNull((String) hshValues
								.get("fin_commentsinlandComments"))%></td></tr>
				<%
					}
				%>
				</table>
			</td>
		</tr>
	</table>
	
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
			if (arryInland != null && arryInland.size() > 0) {
					for (int m = 0; m < count; m++) {
						if (m == 0) {
							arrColIL1 = new ArrayList();
							arrColIL1 = (ArrayList) arryInland.get(0);
							arrRowIL1 = (ArrayList) arrColIL1.get(0);
						}
						if (m == 1) {
							arrColIL2 = new ArrayList();
							arrColIL2 = (ArrayList) arryInland.get(1);
							arrRowIL2 = (ArrayList) arrColIL2.get(0);
						}
						if (m == 2) {
							arrColIL3 = new ArrayList();
							arrColIL3 = (ArrayList) arryInland.get(2);
							arrRowIL3 = (ArrayList) arrColIL3.get(0);
						}
						if (m == 3) {
							arrColIL4 = new ArrayList();
							arrColIL4 = (ArrayList) arryInland.get(3);
							arrRowIL4 = (ArrayList) arrColIL4.get(0);
						}
						if (m == 4) {
							arrColIL5 = new ArrayList();
							arrColIL5 = (ArrayList) arryInland.get(4);
							arrRowIL5 = (ArrayList) arrColIL5.get(0);
						}
					}
					for (int g = 0; g < 10; g++) {
		%>
			<tr>
					<%
						if (g == 0) {
					%>
					<td width ="3%">&nbsp;</td>
					<%
						} else {
					%>
					<td width ="3%" align="center"><%=g%>.</td>
					<%
						}
					%>
					<td width ="40%"><%=str_aray[g]%></td>
					
					<%
											if (g == 0) {
										%>
					<%
						if (arrRowIL1 != null && arrRowIL1.size() > 0) {
					%>
					<td align="center" ><%=Helper.correctNull((String) arrRowIL1
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL2 != null && arrRowIL2.size() > 0) {
					%>
					<td align="center" ><%=Helper.correctNull((String) arrRowIL2
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL3 != null && arrRowIL3.size() > 0) {
					%>
					<td align="center" ><%=Helper.correctNull((String) arrRowIL3
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL4 != null && arrRowIL4.size() > 0) {
					%>
					<td align="center" ><%=Helper.correctNull((String) arrRowIL4
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL5 != null && arrRowIL5.size() > 0) {
					%>
					<td align="center" ><%=Helper.correctNull((String) arrRowIL5
												.get(g))%>&nbsp;</td>
					
					<%
											}
														} else {
										%>
					<%
						if (arrRowIL1 != null && arrRowIL1.size() > 0) {
					%>
					<td align="right" ><%=Helper.correctNull((String) arrRowIL1
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL2 != null && arrRowIL2.size() > 0) {
					%>
					<td align="right" ><%=Helper.correctNull((String) arrRowIL2
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL3 != null && arrRowIL3.size() > 0) {
					%>
					<td align="right" ><%=Helper.correctNull((String) arrRowIL3
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL4 != null && arrRowIL4.size() > 0) {
					%>
					<td align="right" ><%=Helper.correctNull((String) arrRowIL4
												.get(g))%>&nbsp;</td>
					<%
						}
										if (arrRowIL5 != null && arrRowIL5.size() > 0) {
					%>
					<td align="right" ><%=Helper.correctNull((String) arrRowIL5
												.get(g))%>&nbsp;</td>
					
					<%
											}
														}
													}
												}
										%>
			</tr>
			</table><br>
		</div>
<%
	}
%>
</td>
</tr>
<tr>
	<td>
		<div >
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<% if (!Helper.correctNull((String)hshValues.get("fin_comments1inlandComments")).equalsIgnoreCase("")) { %>
				<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1inlandComments"))%></td></tr>
				<tr><td class="title" align="left"><b>&nbsp;</b></td></tr><%} %>
			</table>
		</div>
	</td>
</tr>
<%
	if (str_arry.contains("BGA@")) {
%>

<tr>
	<td>	
		<div>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
					if (!Helper.correctNull(
								(String) hshValues.get("com_assessment_comments35"))
								.equalsIgnoreCase("")) {
				%>
				<tr>
					<td class="title" align="left"><br>Bank Guarantee:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("com_assessment_comments35"))%></td>
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

<%
	if (!Helper.correctNull(
			(String) hshValues.get("com_nonfund_comments"))
			.equalsIgnoreCase("")) {
%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td class="title"><br>Any other Non fund based limits:</td>
		</tr>
		<tr>
			<td align="left"><%=Helper.correctNull((String) hshValues
								.get("com_nonfund_comments"))%></td>
		</tr>
		</table>
	</td>
</tr>
<%
	}
%>

<%
	if (str_arry.contains("ACOM@")) {
%>
<tr>
	<td>	
		<div>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
					if (!Helper
								.correctNull((String) hshValues.get("strCashmargin"))
								.equalsIgnoreCase("")) {
				%>
				<tr>
					<td class="title" align="left"><br>Cash Margin:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String) hshValues
									.get("strCashmargin"))%></td>
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
if (str_arry.contains("AOR@")) {
%>
	<tr>
		<td style="border: none;"  class="title" align="left">Assessment of Restructuring :</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>	
	<div id="top">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	
	<%if(Helper.correctNull((String)hshValues.get("strRestrAss")).equalsIgnoreCase("true")){ %>
	<tr>
	<td><b>Details of the project & credit facilities sanctioned :</b><br>
	<%=Helper.correctNull((String)hshValues.get("com_proj_details"))%></td>
	</tr>
	<tr>
	<td><b>Reasons for Restructuring :</b><br>
	<%=Helper.correctNull((String)hshValues.get("com_restr_reasons"))%></td>
	</tr>
	<tr>
	<td><b>Justification for Restructuring :</b><br>
	<%=Helper.correctNull((String)hshValues.get("com_restr_justification"))%></td>
	</tr>
	<tr>
	<td><b>Existing Repayment Schedule :</b><br>
	<%=Helper.correctNull((String)hshValues.get("com_exi_repayschedule"))%></td>
	</tr>
	<tr>
	<td><b>Revised Repayment Schedule :</b><br>
	<%=Helper.correctNull((String)hshValues.get("com_revised_repayschedule"))%></td>
	</tr>
	<%}else{ %>
	<tr>
	<td style="border: none;"  align="left" colspan="2" > - Nil -</td>
	</tr>
	<%} %>
	</table>
	</div>
	</td>
	</tr>
<%} %>

<%if(str_arry.contains("AAF@")) { %>
<tr>
<td>	
	<div>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(!Helper.correctNull((String)hshValues.get("strAdhocFacAssessment")).equalsIgnoreCase("")){ %>
			<tr>
				<td class="title" align="left"><br>Assessment for Adhoc Facilities:</td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String)hshValues.get("strAdhocFacAssessment"))%></td>
			</tr>
			<% }%>
		</table>
	</div>
</td>
</tr>
<%}if(str_arry.contains("MMithra@")) { 
	ArrayList listRow=(ArrayList)hshValues.get("listMMithra");
	%>
	<tr>
		<td style="border: none;"  class="title" align="left">Assessment for KBL Micro Mithra upto Rs. 2 lakhs</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
	<tr>
	<td>	
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%if(listRow!=null && listRow.size()>0){
					for(int i=0;i<listRow.size();i++){
						arrCol=(ArrayList)listRow.get(i);
						if(i==0){%>
						<tr>
						<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
					</tr>
						<%}else{ %>
					<tr>
						<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(1)),strAmountvalue) %>&nbsp;</td>
					</tr>
					<%} %>
					<%}}
				else{%>
				<tr>
					<td class="title" align="center">Nil</td>
				</tr>
				<%} %>
			</table>
		</div>
	</td>
	</tr>
	<%} %>
<!-- Recommendations -->
 <%
 if(strSessionModuleType.equalsIgnoreCase("CORP")|| (strSessionModuleType.equalsIgnoreCase("AGR"))){
 	if (vecsize != 0 && vec != null) {
 %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br><%=strSno[6]%>&nbsp;Deviation if any in loan policy:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strFinvaluesIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
			   	<tr >
					<td width="10%" align="center"><b>Particulars</b></td>
					<td width="10%" align="center"><b>BenchMark Value</b></td>
					<td width="10%" align="center"><b>Current Value</b></td>
					<td width="10%" align="center"><b>Remarks</b></td>
				</tr>
				 <%
				 	for (int l = 0; l < vecsize; l++) {
				 			if (l < vecsize) {
				 				g2 = (ArrayList) vec.get(l);
				 %>
                     <tr> 
                       <td align="left" nowrap width="30%">&nbsp;<%=Helper.correctNull((String) g2.get(2))%></td>
                       <td align="center" nowrap width="20%"><%=Helper.correctNull((String) g2.get(3))%></td>
                       <td align="right" nowrap width="20%"><%=Helper
												.correctNull((String) g2
														.get(5))%></td>
                       <td align="left" width="30%"><%=Helper.correctNull((String) g2.get(6))%></td>
                     </tr>
                 <%
                 	}
                 		}
                 %>
			</table>
		</div>
	</td>
</tr>
<%if(!Helper.correctNull((String) hshValues.get("fin_benchmarkcmts")).equalsIgnoreCase("")) {%>
<tr><td class="title">Comments:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues.get("fin_benchmarkcmts")) %></td></tr>
 <%
}}}
 %>


<!-- Other Relevant Information -->
<%
	int m = 1;
%>

<%
	count = Integer.parseInt(Helper.correctInt((String) hshValues
			.get("OtherRelevantInfo")));
	if (count == 1) {
%>
<tr><td class="title"><br><%=strSno[7]%> Other relevant information:</td></tr>
<%
	if (!Helper
				.correctNull((String) hshValues.get("MgmtComments8"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) In principle clearance details:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments8"))%></td></tr><%
	}
%>

<%
	if (!Helper
				.correctNull((String) hshValues.get("MgmtComments9"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) Account clearance:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments9"))%></td></tr><%
	}
%>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments10"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) Others:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments10"))%></td></tr><%
	}
%>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments11"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) ALCO clearance:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments11"))%></td></tr><%
	}
%>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments12"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) Period of renewal:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments12"))%></td></tr><%
	}
%>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments13"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) Interest rate and commission:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments13"))%></td></tr><%
	}
%>

<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments16"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) Others information:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments16"))%></td></tr><%
	}
%>
<%
	if (intRatiCount > 0) {
%>
<tr><td class="title"><b>Ratification: </b></td></tr>

 <%
 	for (int i = 0; i < intRatiCount; i++) {
 %>
	<tr><td class="title"><%=Helper.correctNull((String) hshValues
										.get("rati_desc" + i))%></td></tr>
	<tr><td><%=Helper.correctNull((String) hshValues
										.get("rati_comments" + i))%></td></tr>
<%
	}
		}else{%>
		<tr><td class="title"><b>Recommendation/Ratification : &nbsp; Nill</b></td></tr>
		<%}
	}
%>
<%boolean boolflag=true;
int z=0;
if(arrRBIGuidliness!=null && arrRBIGuidliness.size()>0){ %>
<tr>
<td class="title" valign="top">
<%=strSno[a] %>. <%a++; %>RBI Guidelines /Compliances for Restructuring
</td>
</tr>
<tr>
	<td>
<div id="top">
<table width="100%" cellpadding="3" cellspacing="0" border="0"  align="center">
<%for(int i=0;i<arrRBIGuidliness.size();i++){ 
arrCol=(ArrayList)arrRBIGuidliness.get(i);

if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("G")){%>
<%if(boolflag){ 
	boolflag=false;%>
<tr>
<td colspan="3"><b>General Principles and Prudential Norms for Restructured Accounts</b></td>
</tr>
<tr>
<td width="5%" align="center"><b>S.No</b></td>
<td width="25%"><b>Guidelines</b></td>
<td width="35%"><b>Compliances</b></td>
</tr>
<%} %>
<tr>
<td align="center"><%=++z %></td>
<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
<td><%=Helper.correctNull((String)arrCol.get(2)) %></td>
</tr>
<%}}%>
</table>
</div>
</td>
</tr>
<%} %>
<%if(arrRBIGuidliness!=null && arrRBIGuidliness.size()>0){
	boolflag=true;
	z=0;%>
<tr>
	<td>
<div id="top">
<table width="100%" cellpadding="3" cellspacing="0" border="0" align="center">
<%for(int i=0;i<arrRBIGuidliness.size();i++){ 
arrCol=(ArrayList)arrRBIGuidliness.get(i);
if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("S")){%>
<%if(boolflag){ 
boolflag=false;%>
<tr>
<td colspan="3"><b>Special Regulatory Treatment for Asset classification</b></td>
<tr>
<td width="5%" align="center"><b>S.No</b></td>
<td width="25%"><b>Guidelines</b></td>
<td width="35%"><b>Compliances</b></td>
</tr>
<%} %>
<tr>
<td align="center"><%=++z %></td>
<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
<td><%=Helper.correctNull((String)arrCol.get(3)) %></td>
</tr>
<%}}%>
</table>
</div>
</td>
</tr>
<%} %>
<% if(Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("S")){ %>
<tr>
<td class="title" valign="top">
<%=strSno[a] %>. <%a++; %>Comments on Fair Value Calculation 
</td>
</tr>
<%if(!Helper.correctNull((String)hshValues.get("strFVCComments")).equalsIgnoreCase("")){ %>
<tr>
<td>
<%=Helper.correctNull((String)hshValues.get("strFVCComments")) %>
</td>
</tr>
<%} else{%>
<tr>
<td align="center"><b>- NIL -</b></td>
</tr>
<%}} %>
<%if(TakeOvercheck.equalsIgnoreCase("y") && arrRowTakeover!=null && arrRowTakeover.size()>0){ %>
<tr><td class="title" valign="top"><br>Take Over Norms :</td></tr>

<tr><td align="center">
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td align="center" width="50%"><b>NORMS</b></td>
                                    <td align="center" width="13%">&nbsp;</td>
                                    <td align="center" width="35%"><b>COMPLIANCE</b></td>
                                    </tr>
                                    <%if(arrRowTakeover!=null && arrRowTakeover.size()>0)
  								  {
    								  	for(int i=0;i<arrRowTakeover.size();i++)	
    									{
    								  		arrCol=(ArrayList)arrRowTakeover.get(i);
    										if(arrCol!=null && arrCol.size()>0)
    										{ %>
    										<tr>
    										<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
    										<td><%=Helper.correctNull((String)arrCol.get(2))%></td>
    										<td><%=Helper.correctNull((String)arrCol.get(3))%></td>
    										</tr>
    										 <%}
								  }
								  }%>
</table>
</div>
</td></tr>
 <%if(!Helper.correctNull((String)hshValues.get("strTakeoverComments")).equalsIgnoreCase("")){ %>
 <tr> 
   <td> 
     <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
	 <tr>
		<td class="title">Comments</td>
	 </tr>
	 <tr>
	 	<td>
 			<%=Helper.correctNull((String)hshValues.get("strTakeoverComments")) %>
 		</td>
 	</tr>
 	</table>
 	</td>
 </tr>
 <%} %>
<%}else{ %>
<tr><td class="title" valign="top"><br>Take Over Norms : NA </td></tr>
<%} %>
<tr><td class="title" valign="top"><br>Sanctioning Authority :</td></tr>
<tr> <td><%=Helper.correctNull((String) hshValues
							.get("com_sancauthorityVal"))%></td>
</tr>


<tr><td class="title"><br><%=strSno[a]%>.<%a++; %>&nbsp;Recommendations:</td></tr>
<%
	if (Helper.correctNull((String) hshValues.get("com_sancauthority"))
			.equals("15")
			|| Helper.correctNull(
					(String) hshValues.get("com_sancauthority"))
					.equals("16")) {
%>
<tr><td>In the light of the above, we recommend for considering the proposal and the following resolution may be passed with or without modifications.<br><br>
"Resolved that <b><%=Helper.correctNull((String) hshValues
								.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues
								.get("perapp_name"))%></b> be sanctioned the following facilities on the terms and conditions, mentioned here under:
</tr>
<%
	} else {
%>
<tr><td>In the light of the above,<b><%=Helper.correctNull((String) hshValues
								.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues
								.get("perapp_name"))%></b> be sanctioned the following facilities on the terms and conditions, mentioned here under :</td></tr>
<%
	}
%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>NATURE OF FACILITY AND LIMITS:</td>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="25%" align="center">Type of Facility</td>
				<td width="15%" align="center">Type of Limit</td>
				<td width="15%" align="center">Nature of Facility</td>
				<td align="center" colspan="2">Amount</td>
				<td width="27%" align="center" nowrap="nowrap">Facility Availing Branch</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				
				<%if(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17)))!=0){ %>
				<td align="center" rowspan="3"><%=i + 1%>.</td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(26))%></td>
				<td>Loan Sanction Amount</td>
				<%if(!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF")){ %>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))-Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17)))),strAmountvalue)%></td>
					<%}else{ %>
				<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))),strAmountvalue)%></td>
				<%} %>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(18))%></td>		
				</tr>
				<tr>
					<td><%=Helper.correctNull((String) arrCol.get(19))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17))))),strAmountvalue)%></td>
				</tr>
				<tr class="title">
					<td>Total Loan Sanction Limit</td>
					
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)))),strAmountvalue)%></td>
				<%}else{ %>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(26))%></td>
				<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%><br/>Without any insurance coverage.</td>
				<td align="left" rowspan=""><%=Helper.correctNull((String) arrCol.get(18))%></td>
				<%} %>
				</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% int w=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0){ 
			
			boolean bflag=false;
			
			for(int i=0;i<arrRecommRow.size();i++)
			{
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					if(Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF"))
						bflag=true;
				}
			}%>
			 <%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					 if(!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("NC")&&!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("")){
					w++;
		
			if(w==1) {%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="20%" align="center">Type of Facility</td>
				<td width="15%"align="center">Insurance Covered Under</td>
				<td width="7%" align="center" >Premium Tenor<br>(in Months)</td>
				<td width="10%" align="center">Loan amount covered under the scheme</td>
				<%if(bflag){ %>
				<td width="10%" align="center">Premium Amount</td>
				<td width="10%" align="center">Operative account number from which<br> premium account will be debited </td>
				<td width="10%" align="center">Company Name </td>
				<%} %>
			 </tr>
			 <%} %>
			
			<tr>
				<td align="center"><%=w%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(19))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(21))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(22))))),strAmountvalue)%></td>
				<%if(Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17))))),strAmountvalue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(23))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(25))%></td>
				<%}
				else if(bflag)
				{%>
				<td align="right" colspan="3">&nbsp;</td>
				<%} %>
				
				
		   	</tr>
			<%}}} %>
			
	 <%} %>
	 </table>
	 </div>
	 </td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>RATE OF INTEREST/ COMMISSION:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<%if(strSessionModuleType.equalsIgnoreCase("CORP")){ %>
<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%int j=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0 && strWhetherBRAvail.equalsIgnoreCase("Y")){ 
				 %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||
						Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB")
						||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS")
						){
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
			</tr>
			<%} }}%>
<%if(arrRowNonBr!=null && arrRowNonBr.size()>0)
	{
		for(int k=0;k<arrRowNonBr.size();k++)
		{
			arrColNonBr=(ArrayList)arrRowNonBr.get(k);
			if(arrColNonBr.size()>0)
			{
			%>
			<tr>
			<td align="center"><%=j+1%>.</td>
			<td><%=Helper.correctNull((String)arrColNonBr.get(0)).toUpperCase()%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrColNonBr.get(2))))),strAmountvalue)%></td>
			<td><%=Helper.correctNull((String)arrColNonBr.get(1))%></td>
			</tr>
			<%	
			}
			j=j+1;
		}
	}%>
	
	<%if(arrMCLRRow!=null && arrMCLRRow.size()>0){ %>
	<tr>
	<td colspan="4">
	<%for(int k=0;k<arrMCLRRow.size();k++)
	{ %>
	<%=Helper.correctNull((String)arrMCLRRow.get(k))%><br/>
	<%} %>
	</td>
	</tr>
	<%} %>
	</table>
		</div>
	<%
}else{%>
	<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ 
				int j=0; %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<%if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLEC")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS")){ %>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
				<%}else{ %>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(16))%> at the Rate of <%=Helper.correctNull((String)arrCol.get(3))%> % </td>
				<%} %>
			</tr>
			<%}}%>
			
				<%if(arrMCLRRow!=null && arrMCLRRow.size()>0){ %>
				<tr>
				<td colspan="4">
				<%for(int k=0;k<arrMCLRRow.size();k++)
				{ %>
				<%=Helper.correctNull((String)arrMCLRRow.get(k))%><br/>
				<%} %>
				</td>
				</tr>
				<%} %>
			</table>
		</div>
	</td>
</tr>
<%}%>



<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MARGIN:</td>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="30%" align="center">Margin</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(10))%><br/>
				<%if(!Helper.correctNull((String) arrCol.get(29)).equalsIgnoreCase("")){ %>Relaxation in margin as per RBI COVID relief Package Policy : <%=Helper.correctNull((String) arrCol.get(29))%><%} %></br>
				<%if(!Helper.correctNull((String) arrCol.get(27)).equalsIgnoreCase("")){ %>Actual Margin(%) :<%=Helper.correctNull((String) arrCol.get(27)) %> <%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(28)).equalsIgnoreCase("")){ %>Relaxed Margin(%):<%=Helper.correctNull((String) arrCol.get(28)) %> <%} %></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>PERIOD:</td>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0) {
			%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="37%" align="center">Type of Facility</td>
				<td width="20%" align="center">Amount</td>
				<td width="15%" align="center">Tenor <br>(in Months)</td>
				<td width="15%" align="center">Initial Holiday/ Gestation/ Moratorium Period <br>(in Months)</td>
				<td width="15%" align="center">Due Date</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))),strAmountvalue)%></td>
				<td align="right"><%=Helper.correctInt((String) arrCol.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String) arrCol.get(11))%></td>
				<%if(!Helper.correctNull((String) arrCol.get(15)).equalsIgnoreCase("")){ %>
				<td align="center"><%=Helper.correctNull((String) arrCol.get(15))%></td>
				<%}else{ %>
				<td align="center">-</td>
				<%} %>
			</tr>
			<%
				}
				} else {
			%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%
				}
			%>
			</table>
		</div>
	</td>
</tr>
	<tr>
		<td>&nbsp;</td>
		<tr>
<tr>
			<td><b> Hunter Details:</b></td>
			</tr>
			<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
					<tr class="tblhead">
						<td align="center" width="5%">S.No</td>
						<td align="center" width="30%">Name</td>
						<td align="center" width="30%">Hunter Score</td>
					</tr>	
					
					
												<%
										 if(arrRow12!=null && arrRow12.size()>0){ 
											for(int n=0;n<arrRow12.size();n++){
											arrCol12=(ArrayList)arrRow12.get(n);
											%>
												<tr align="center" style="border-left:1px;" >
												
												<td><%=n+1 %></td>	
												<td><%=Helper.correctNull((String)arrCol12.get(2))%></td>
												<td ><%=Helper.correctNull((String)arrCol12.get(1))%></td>
																						</tr>
											<%} }else{%>
					
													<tr>
													<td align="center"> - Nil -</td>
													</tr>
					<%} %>
					
				</table>
			</div>
			</td>
			</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MODE OF REPAYMENT:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>


<tr>
	<td>
		
			<%
				if (arrRecommRow != null && arrRecommRow.size() > 0 )
				{
			%>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td width="4%" align="center">Sl.No</td>
				<td width="46%" align="center">Type of Facility</td>
				<td width="46%" align="center">Mode of Repayment</td>
			</tr>
			<%
				for (int i = 0; i < arrRecommRow.size(); i++) {
						arrCol = (ArrayList) arrRecommRow.get(i);
					//	arrOutCol1 = (ArrayList) arrOutRow1.get(i);
			%>
			<tr>
				<td align="center"><%=i + 1%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(9))%></td>
				
			</tr>
			<%
				}		%>
				</table>
		</div>
				<%}else{ %>
			Nil
			<%} %>
	</td>
</tr>
<%
		ArrayList arrOutCol1	= new ArrayList();
		ArrayList arrOutRow1	= (ArrayList) hshValues.get("arrOutRow1");
	%>
	
	
	<tr><td><b>REPAYMENT SCHEDULE COMMENTS:</b></td></tr>
	<tr>
		<td>&nbsp;
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<%
				if (arrOutRow1 != null && arrOutRow1.size() > 0 )
				{
					for (int i = 0; i < arrOutRow1.size(); i++) 
					{
						arrOutCol1 = (ArrayList) arrOutRow1.get(i);
			%>
				<tr>
					<td align="left" width="20%"  class="title">&nbsp;<u><%=Helper.correctNull((String) arrOutCol1.get(0))%>-<%=Helper.correctNull((String) arrOutCol1.get(1))%> :</u></td></tr>
				<tr><td align="left" width="50%"><%=Helper.correctNull((String) arrOutCol1.get(2))%></td></tr>
	
	<%
		}
			}else{		
	%>
	<tr><td align="center">&nbsp;Nil</td></tr>
	<%} %>
			</table>
		</td>
	</tr>
<tr>
<%if(strpurpose.equals("PC")){%>

	<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b>(Inclusive of all Taxes)</td>

<%}else{%>
	<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> + Applicable Taxes</td>
<%}%>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
		<!-- <tr>
		<td>
		<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				<%if(StrverCFR.equalsIgnoreCase("Y")) {%>
				<tr>
					<td colspan="2" class="title">CFR Verification Details</td>
				</tr>
				<tr>
					<td width="40%">Verification done at Central Fraud Registry Database</td>
					<td width="60%">&nbsp;<b>Yes</b></td>
				</tr>
				<tr>
					<td width="40%">Applicant/Co-applicant/Guarantor/<br>Proprietor/Partner name appears in CFR List</td>
					<td width="60%">&nbsp;<b><%if(StrNameCFR.equalsIgnoreCase("Y")){ %>Yes<%}else{ %>No<%} %></b></td>
				</tr>
				<%
				}if(StrNameCFR.equalsIgnoreCase("Y")) {%>	
				<tr>
					<td width="40%">CFR Deviation Reference Number</td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("COM_CFR_DEV_RENFO"))%></b></td>
				</tr>
				<%}
				if(strStatus.equalsIgnoreCase("A")||strStatus.equalsIgnoreCase("R")) { %>	
				<tr>
					<td width="40%">Deviation approval Status</td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strStatusVer"))%></b></td>
				</tr>
				<tr>
					<td width="40%"><%if(strStatus.equalsIgnoreCase("A")){ %>CFR Deviation Approved By<%}else{ %>CFR Deviation Rejected By<%} %></td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("appuserid"))%></b></td>
				</tr>
				<tr>
					<td width="40%"><%if(strStatus.equalsIgnoreCase("A")){ %>Approved Date<%}else{ %>Rejected Date<%} %></td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("LOAN_APPR_DATE"))%></b></td>
				</tr>
					<%} %>
				
			</table>
		</div></td>
		</tr> -->
		<tr>
	<td>
	<table class="Table" style="width:98.0%; border-collapse:collapse; border:solid black 1.0pt" width="98%">
	<tbody>
	<tr>
			<td colspan="2" style="border:solid black 1.0pt; width:66.2%; border-top:none; padding:0in 5.4pt 0in 5.4pt" valign="top" width="66%">
			<p style="text-align:justify; margin:0in 0in 0.0001pt"><span style="font-size:10pt"><span style="font-family:Calibri,sans-serif"><b><span lang="EN-IN" style="font-size:12.0pt"><span antiqua="" book="" style="font-family:">Interest Deviation Ref No</span></span></b></span></span></p>
			</td>
			<td style="border-bottom:solid black 1.0pt; width:33.8%; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0in 5.4pt 0in 5.4pt" valign="top" width="33%">
			<p style="text-align:justify; margin:0in 0in 0.0001pt"><%=Helper.correctNull((String)hshValues.get("com_interest_refno"))%></p>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="border:solid black 1.0pt; width:66.2%; border-top:none; padding:0in 5.4pt 0in 5.4pt" valign="top" width="66%">
			<p style="text-align:justify; margin:0in 0in 0.0001pt"><span style="font-size:10pt"><span style="font-family:Calibri,sans-serif"><b><span lang="EN-IN" style="font-size:12.0pt"><span antiqua="" book="" style="font-family:">&nbsp; Permission Proposal No</span></span></b></span></span></p>
			</td>
			<td style="border-bottom:solid black 1.0pt; width:33.8%; border-top:none; border-left:none; border-right:solid black 1.0pt; padding:0in 5.4pt 0in 5.4pt" valign="top" width="33%">
			<p style="text-align:justify; margin:0in 0in 0.0001pt"><%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%></p>
			</td>
		</tr>
		</table>
		</td>
		</tr>
<tr><td class="title"><br><br><b>Security :</b> The details of the Securities available are enclosed in Annexure III -C</td></tr>

<tr><td class="title">TERMS AND CONDITIONS:</td></tr>

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
		<tr><td class="title"><b>Specific:</b></td></tr>
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
		      	<table cellpadding="3" cellspacing="0" width="100%" >
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
		      	<table cellpadding="3" cellspacing="0" width="98%" align="right">
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
					}
				%>
	<%
		if (arrFacilityTermApp0 != null) {
			for (int i = 0; i < arrFacilityTermApp0.size(); i++) {
				main = main + 1;
	%>
		<tr > 
		  <td align="center"> 
		    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
		  </td>
		</tr>
		<%
			}
			}
		%>

<tr>
	<td>
		 <table width="95%" align="center" cellpadding="3" cellspacing="0" border="1">
	 		<tr align="center"> 
	 			<td> Details</td> <td>Appraised By</td> 
			 </tr>
			 <%if(arrRowprop!=null && arrRowprop.size()>0){
					for(int i=0;i<arrRowprop.size();i++){
						arrColprop=(ArrayList)arrRowprop.get(i);
						String strdetails=Helper.correctNull((String)arrColprop.get(7));
						%>
					<%if(strdetails.equalsIgnoreCase("A")){ %>
			 <tr> 
	 			<td> Name</td> <td><%=Helper.correctNull((String)arrColprop.get(6))%> &nbsp;</td> 
			 </tr>
			  <tr> 
	 			<td> Designation</td> <td><%=Helper.correctNull((String)arrColprop.get(4))%>&nbsp;</td> 
	 			
			 </tr>
			  <tr> 
	 			<td> Date</td> <td><%=Helper.correctNull((String)arrColprop.get(8))%> &nbsp;</td>
	 			
			 </tr>
			 <%}}}%>
			 <tr align="center"> 
	 			 <td colspan="2">Vetted By</td> 
			 </tr>
			 <%if(arrRowprop!=null && arrRowprop.size()>0){
					for(int i=0;i<arrRowprop.size();i++){
						arrColprop=(ArrayList)arrRowprop.get(i);
						String strdetails=Helper.correctNull((String)arrColprop.get(7));
						%>
					<%if(strdetails.equalsIgnoreCase("V")){ %>
			 <tr> 
	 			<td> Name</td> <td><%=Helper.correctNull((String)arrColprop.get(6))%> &nbsp;</td> 
			 </tr>
			  <tr> 
	 			<td> Designation</td> <td><%=Helper.correctNull((String)arrColprop.get(4))%>&nbsp;</td> 
	 			
			 </tr>
			  <tr> 
	 			<td> Date</td> <td><%=Helper.correctNull((String)arrColprop.get(8))%> &nbsp;</td>
	 			
			 </tr>
			 <%}}}%>
			 <tr align="center"> 
	 			 <td colspan="2">Sanctioned By</td> 
			 </tr>
			 <%if(arrRowprop!=null && arrRowprop.size()>0){
					for(int i=0;i<arrRowprop.size();i++){
						arrColprop=(ArrayList)arrRowprop.get(i);
						String strdetails=Helper.correctNull((String)arrColprop.get(7));
						%>
					<%if(strdetails.equalsIgnoreCase("S")){ %>
			 <tr> 
	 			<td> Name</td> <td><%=Helper.correctNull((String)arrColprop.get(6))%> &nbsp;</td> 
			 </tr>
			  <tr> 
	 			<td> Designation</td> <td><%=Helper.correctNull((String)arrColprop.get(4))%>&nbsp;</td> 
	 			
			 </tr>
			  <tr> 
	 			<td> Date</td> <td><%=Helper.correctNull((String)arrColprop.get(8))%> &nbsp;</td>
	 			
			 </tr>
			 <%}}}%>
	 	</table>
	</td>
</tr>

<tr><td class="title"><b>General:</b> &nbsp;Indicated in Annexure VII</td></tr>
<tr>
<td>
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
	if (arrDeleRow != null && arrDeleRow.size() > 0) {
		for (int i = 0; i < arrDeleRow.size(); i++) {
			arrCol = (ArrayList) arrDeleRow.get(i);
			boolean bflag=false;
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("021") && !Helper.correctNull((String)hshValues.get("com_griddate")).equalsIgnoreCase(""))
			{
				bflag=true;
			}
%>
<%
	if (i % 2 == 0) {
%>
<tr><td align="left"><br> <%=Helper.correctNull((String) arrCol.get(0))%> </td></tr>
<tr><td align="left"> <%=Helper.correctNull((String) arrCol.get(1))%> </td></tr>
<%if(bflag){ %>
<tr><td align="left"> Discussed and cleared in the Credit approval GRID on <%=Helper.correctNull((String)hshValues.get("com_griddate"))%> </td></tr>
<%
}} else {
%>
<tr><td align="right"><br> <%=Helper.correctNull((String) arrCol.get(0))%> </td></tr>
<tr><td align="right"> <%=Helper.correctNull((String) arrCol.get(1))%> </td></tr>
<%
if(bflag){ %>
<tr><td align="right"> Discussed and cleared in the Credit approval GRID on  <%=Helper.correctNull((String)hshValues.get("com_griddate"))%> </td></tr>
<%
}
	}
%>
<%
	}
	}
%>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>

</table>
<div id="top" >
<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0" style="page-break-before:always">
	<tr>
		<td>Annexure No</td>
		<td>Particulars</td>
	</tr>
	<tr>
		<td>I</td>
		<td>Branch Indices</td>
	</tr>
	<tr>
		<td>II</td>
		<td>Applicant's Profile</td>
	</tr>
	<tr>
		<td>III</td>
		<td>Details Of Credit Facilities</td>
	</tr>
	<tr>
		<td>IV</td>
		<td>Financial Statements/ Ratio Analysis </td>
	</tr>
	<tr>
		<td>V</td>
		<td>Conduct Of Operations Under The Existing Facilities</td>
	</tr>
	<tr>
		<td>VI</td>
		<td>Industry And Swot Analysis</td>
	</tr>
	<tr>
		<td>VII</td>
		<td>General Conditions</td>
	</tr>

		<tr>
			<td>VIII</td>
			<td>Projected Financial Statements</td>
		</tr>

</table>
</div>

</body>
</html>