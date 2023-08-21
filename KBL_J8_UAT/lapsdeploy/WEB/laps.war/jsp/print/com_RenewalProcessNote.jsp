<%@include file="../share/directives.jsp"%>
<%
	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	ArrayList arrNFBRowIM = new ArrayList();
	ArrayList arrNFBRow = new ArrayList();
	ArrayList arrBGLmtRow = new ArrayList();
	ArrayList arrBCLmtRow = new ArrayList();
	int intODCCRow = 0;
	ArrayList arrOthDetRow = new ArrayList();
	
	ArrayList arrCol = new ArrayList();
	ArrayList arrODCCRow = new ArrayList();
	ArrayList arrBPCRow = new ArrayList();
	ArrayList arrPCSRow = new ArrayList();
	ArrayList arrBPurRow = new ArrayList();
	ArrayList arrBPurEXRow = new ArrayList();
	ArrayList arrRecommRow = new ArrayList();

	ArrayList arrImpoCollection = new ArrayList();
	ArrayList arrGoodsLoan = new ArrayList();
	ArrayList arrWareHouseRec = new ArrayList();
	ArrayList arrChequeDiscou = new ArrayList();
	ArrayList arrInLBillsDisco = new ArrayList();
	ArrayList arrRowRating = new ArrayList();
	ArrayList arrColRating = new ArrayList();
	ArrayList arrBAOtherRow	= new ArrayList();
	ArrayList arrBuyerDeatails	= new ArrayList();
	ArrayList arrSellerDeatails	= new ArrayList();
	ArrayList arrKeyPersonInfo	= new ArrayList();
	String strratingperc=Helper.correctNull((String)hshValues.get("COM_CGSSDPERC"));
	if (hshValues != null) {
		
		arrBuyerDeatails = (ArrayList)hshValues.get("arrBuyerInfo");
		arrSellerDeatails = (ArrayList)hshValues.get("arrSellerInfo");
		arrKeyPersonInfo=(ArrayList)hshValues.get("arrKeyPersonInfo");
		arrBAOtherRow	= (ArrayList)hshValues.get("arrBAOtherRowNew");
		arrODCCRow = (ArrayList) hshValues.get("arrODCCRow");
		arrRecommRow = (ArrayList) hshValues.get("arrRecommRow");
		arrNFBRow = (ArrayList) hshValues.get("arrNFBRow");
		arrBGLmtRow = (ArrayList) hshValues.get("arrBGLmtRow");
		arrBCLmtRow = (ArrayList) hshValues.get("arrBCLmtRow");
		arrBPCRow = (ArrayList) hshValues.get("arrBPCRow");
		arrPCSRow = (ArrayList) hshValues.get("arrPCSRow");
		arrBPurRow = (ArrayList) hshValues.get("arrBPurRow");
		arrBPurEXRow = (ArrayList) hshValues.get("arrBPurEXRow");
		arrNFBRowIM = (ArrayList) hshValues.get("arrNFBRowIM");
		arrOthDetRow = (ArrayList) hshValues.get("arrOthDetRow");

		arrImpoCollection = (ArrayList) hshValues
				.get("arrImpoCollection");
		arrGoodsLoan = (ArrayList) hshValues.get("arrGoodsLoan");
		arrWareHouseRec = (ArrayList) hshValues.get("arrWareHouseRec");
		arrChequeDiscou = (ArrayList) hshValues.get("arrChequeDiscou");
		arrInLBillsDisco = (ArrayList) hshValues
				.get("arrInLBillsDisco");

		if (arrOthDetRow != null)
			intODCCRow = arrOthDetRow.size();

		if (intODCCRow == 0)
			intODCCRow = 1;
	}

	ArrayList vec = new ArrayList();
	ArrayList g2 = new ArrayList();
	int vecsize = 0;
	HashMap hshBenchmark = new HashMap();
	hshBenchmark = (HashMap) hshValues.get("hshBenchValues");
	if (hshBenchmark != null) {
		vec = (ArrayList) hshBenchmark.get("vecData");
	}
	if (vec != null) {
		vecsize = vec.size();
	}

	String strAmountValue = Helper.correctNull((String) hshValues
			.get("strAmountValue"));
	String strAmtValueIn = Helper.correctNull((String) hshValues
			.get("strAmtValueIn"));

	if (strAmountValue.equalsIgnoreCase("C")) {
		strAmtValueIn = "( Rs. in Crore )";
	} else if (strAmountValue.equalsIgnoreCase("L")) {
		strAmtValueIn = "( Rs. in Lacs )";
	} else {
		strAmtValueIn = "( Amount in Rs. )";
	}
	boolean booAssFlag = true;

	HashMap hshAddeDetails = new HashMap();
	HashMap hshAddeDetails1 = new HashMap();
	HashMap hshConsDetails = new HashMap();
	double dblLimitTot = 0.0, dblOutstandTot = 0.0, dblExposureTot = 0.0, dblPropLimitTot = 0.0, dblTotalExp = 0.0, dblLimitTot1 = 0.0, dblTLExposure = 0.0, dblMLimitTot = 0.0, dblMOutstandTot = 0.0, dblMExposureTot = 0.0, dblMPropLimitTot = 0.0, dblMTotalExp = 0.0, dblMLimitTot1 = 0.0, dblTotExp = 0.0, dblFreshLimit = 0.0;

	String strAd1 = "", strAd2 = "", strAd3 = "", strDis = "", strCity = "", strState = "", strCountry = "", app_constitution = "", strAddress = "";
	String Address = "", strZipcode = "", strCommaddress = "", strPerAddress = "", strAdminAddress = "";
	String strResidentstatus = "", strSancAuth = "", strHeaderFlag = "true";
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();

	String strLoanType = Helper.correctNull((String) hshValues
			.get("strLoanTypeNew"));
	StringBuilder strBanking = new StringBuilder();

	ArrayList arrPromoterRow = new ArrayList();
	ArrayList arrFacRow = new ArrayList();
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrRowRatingRMD = new ArrayList();
	ArrayList arrColExp = new ArrayList();
	ArrayList arrCOPNewRow = new ArrayList();
	ArrayList arrReleaseRow = new ArrayList();
	ArrayList arrPresentTL = new ArrayList();
	ArrayList arrCOPRow = new ArrayList();
	ArrayList arrMOFRow = new ArrayList();
	ArrayList arrMOFMjrRow = new ArrayList();
	ArrayList arrCOPMjrRow = new ArrayList();
	ArrayList arrRelPatrnRow = new ArrayList();
	ArrayList arrRelPatrnMjrRow = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrImplSchRow = new ArrayList();
	ArrayList arrImplSchCol = new ArrayList();
	ArrayList arrTORow = new ArrayList();
	ArrayList arrExpRow = new ArrayList();
	ArrayList arryInland = new ArrayList();
	ArrayList arrColIL1 = new ArrayList();
	ArrayList arrColIL2 = new ArrayList();
	ArrayList arrColIL3 = new ArrayList();
	ArrayList arrColIL4 = new ArrayList();
	ArrayList arrColIL5 = new ArrayList();
	ArrayList arrRowIL1 = new ArrayList();
	ArrayList arrRowIL2 = new ArrayList();
	ArrayList arrRowIL3 = new ArrayList();
	ArrayList arrRowIL4 = new ArrayList();
	ArrayList arrRowIL5 = new ArrayList();
	ArrayList arrSwotAnalysis = new ArrayList();
	ArrayList arrOutCol = new ArrayList();
	ArrayList arrGuaRow = new ArrayList();
	ArrayList arrRowRelation = new ArrayList();
	ArrayList arrColRelation = new ArrayList();
	ArrayList arrRowDefault = new ArrayList();
	ArrayList arrRowEcgc = new ArrayList();
	ArrayList arrFactoryDetails = new ArrayList();
	ArrayList arrColDefault = new ArrayList();
	ArrayList arrPresentWC = new ArrayList();
	ArrayList arrExistingWC = new ArrayList();
	ArrayList arrAssmntRow = new ArrayList();
	ArrayList arrRowCIBIL = new ArrayList();
	ArrayList arrColCIBIL = new ArrayList();
	ArrayList arrRowTakeover = (ArrayList) hshValues
			.get("arrTakeoverVal");
	ArrayList arrDrawDown = (ArrayList) hshValues.get("arrDrawDown");
	ArrayList arrBanking = (ArrayList) hshValues.get("arrBanking");
	ArrayList arrRating = (ArrayList) hshValues.get("arrRating");
	ArrayList arrLeaderBankTL = new ArrayList();
	ArrayList arrLeaderBankWC = new ArrayList();
	ArrayList arrOtherBankTL = new ArrayList();
	ArrayList arrOtherBankWC = new ArrayList();
	ArrayList arrGroupRow = new ArrayList();
	arrGroupRow = (ArrayList) hshValues.get("arrGroupRow");
	ArrayList arrSingleCons = new ArrayList();
	ArrayList arrMultipleCons = new ArrayList();
	ArrayList arrMultiple = new ArrayList();
	ArrayList arrConsortDet = new ArrayList();
	ArrayList arrMultipleConsWC1 = new ArrayList();
	ArrayList arrMechRow = new ArrayList();
	ArrayList arrRowWFDefault = new ArrayList();
	ArrayList arrMISRow = new ArrayList();
	ArrayList arrColMIS=new ArrayList();
	ArrayList arrYear = (ArrayList) hshValues.get("arrYear");
	ArrayList arrGrowth = (ArrayList) hshValues.get("arrGrowth");
	ArrayList arrAchievement = (ArrayList) hshValues
			.get("arrAchievement");
	ArrayList arrSalesProj = (ArrayList) hshValues.get("arrSalesProj");
	ArrayList arrSalesAct = (ArrayList) hshValues.get("arrSalesAct");
	ArrayList arColRatingRMD = new ArrayList();
	ArrayList arrRowcgssd= new ArrayList();
	ArrayList arrColcgssd= new ArrayList();
	if (arrBanking != null && arrBanking.size() > 0) {
		for (int a = 0; a < arrBanking.size(); a++) {
			if (strBanking.length() == 0)
				strBanking.append(Helper
						.correctNull((String) arrBanking.get(a)));
			else
				strBanking.append(" / ").append(
						Helper.correctNull((String) arrBanking.get(a)));
		}
	}

	if (hshValues != null) {
		strSancAuth = Helper.correctNull((String) hshValues
				.get("com_sancauthority"));
		hshAddeDetails1 = (HashMap) hshValues.get("PROPOSALLC");
		hshConsDetails = (HashMap) hshValues.get("PROPOSAL");
		arrRowCIBIL = (ArrayList) hshValues.get("arrRowCIBIL");
		if (hshAddeDetails1 != null) {
			hshAddeDetails = (HashMap) hshAddeDetails1
					.get("hshRespDetails");
			arrPromoterRow = (ArrayList) hshAddeDetails1
					.get("arrPromoterRow");
			arrGuaRow = (ArrayList) hshAddeDetails1.get("arrGuaRow");
			arrRowRelation = (ArrayList) hshAddeDetails1
					.get("Relationship");
			arrRowDefault = (ArrayList) hshAddeDetails1
					.get("arrRowDefault");
			arrRowEcgc = (ArrayList) hshAddeDetails1.get("arrRowEcgc");
			arrFactoryDetails = (ArrayList) hshAddeDetails1
					.get("arrFactoryDetails");
			arrRowCIBIL = (ArrayList) hshAddeDetails1
					.get("arrRowCIBIL");
			arrRowRatingRMD = (ArrayList) hshAddeDetails1
					.get("arrRowRatingRMD");
			arrRowRating = (ArrayList) hshAddeDetails1
					.get("arrRowRating");
			arrRowWFDefault = (ArrayList) hshAddeDetails1
			.get("arrRowWFDefault");

			//arrRowCIBIL = (ArrayList)hshValues.get("arrRowCIBIL");
		}
		if (hshConsDetails != null) {
			arrLeaderBankTL = (ArrayList) hshConsDetails
					.get("arrLeaderBankTL");
			arrLeaderBankWC = (ArrayList) hshConsDetails
					.get("arrLeaderBankWC");
			arrOtherBankTL = (ArrayList) hshConsDetails
					.get("arrOtherBankTL");
			arrOtherBankWC = (ArrayList) hshConsDetails
					.get("arrOtherBankWC");

			arrSingleCons = (ArrayList) hshConsDetails
					.get("arrSingleCons");
			arrMultipleCons = (ArrayList) hshConsDetails
					.get("arrMultipleCons");
			arrMultiple = (ArrayList) hshConsDetails.get("arrMultiple");
			arrConsortDet = (ArrayList) hshConsDetails
					.get("arrConsortDet");
			arrMultipleConsWC1 = (ArrayList) hshConsDetails
					.get("arrMultipleConsWC1");
		}
	}

	int RowCount = 0;
	if (hshAddeDetails != null) {
		strResidentstatus = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("strResidentstatus")));
		strAd1 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_address1")));
		strAd2 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_address2")));
		strAd3 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_address3")));
		strCity = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_city")));
		strDis = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_district")));
		strState = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_state")));
		strZipcode = Helper.correctNull((String) hshAddeDetails
				.get("txtperapp_zip"));

		app_constitution = Helper.correctNull((String) hshAddeDetails
				.get("app_constitution"));
		if (!strAd1.equalsIgnoreCase("")) {
			Address = strAd1;
		}
		if (!strAd2.equalsIgnoreCase("")) {
			Address = Address + "," + strAd2;
		}
		if (!strAd3.equalsIgnoreCase("")) {
			Address = Address + "," + strAd3;
		}
		if (!strCity.equalsIgnoreCase("")) {
			Address = Address + "," + strCity;
		}
		if (!strDis.equalsIgnoreCase("")) {
			Address = Address + "," + strDis;
		}
		if (!strState.equalsIgnoreCase("")) {
			Address = Address + "," + strState;
			if (!strZipcode.equalsIgnoreCase("")) {
				Address = Address + "-" + strZipcode;
			}
		}
		if (!strAd1.equalsIgnoreCase("")) {
			strCommaddress = Address;
			RowCount++;
		}
		strAd1 = "";
		Address = "";
		strAd1 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_permadd1")));
		strAd2 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_permadd2")));
		strAd3 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_permadd3")));
		strCity = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_permcity")));
		strDis = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_permdistrict")));
		strState = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_permstate")));
		strZipcode = Helper.correctNull((String) hshAddeDetails
				.get("txtperapp_permzip"));
ArrayList arrratifrow1= new ArrayList();
 ArrayList   arrratifcol1= new ArrayList();
		if (!strAd1.equalsIgnoreCase("")) {
			Address = strAd1;
		}
		if (!strAd2.equalsIgnoreCase("")) {
			Address = Address + "," + strAd2;
		}
		if (!strAd3.equalsIgnoreCase("")) {
			Address = Address + "," + strAd3;
		}
		if (!strCity.equalsIgnoreCase("")) {
			Address = Address + "," + strCity;
		}
		if (!strDis.equalsIgnoreCase("")) {
			Address = Address + "," + strDis;
		}
		if (!strState.equalsIgnoreCase("")) {
			Address = Address + "," + strState + ".";
			if (!strZipcode.equalsIgnoreCase("")) {
				Address = Address + "-" + strZipcode + ".";
			}
		}
		if (!strAd1.equalsIgnoreCase("")) {
			strPerAddress = Address;
			RowCount++;

		}
		strAd1 = "";
		Address = "";
		strAd1 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_adminadd1")));
		strAd2 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_adminadd2")));
		strAd3 = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_adminadd3")));
		strCity = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_admincity")));
		strDis = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_admindistrict")));
		strState = Helper.changetoTitlecase(Helper
				.correctNull((String) hshAddeDetails
						.get("txtperapp_adminstate")));
		strZipcode = Helper.correctNull((String) hshAddeDetails
				.get("txtperapp_adminzip"));
		if (!strAd1.equalsIgnoreCase("")) {
			Address = strAd1;
		}
		if (!strAd2.equalsIgnoreCase("")) {
			Address = Address + "," + strAd2;
		}
		if (!strAd3.equalsIgnoreCase("")) {
			Address = Address + "," + strAd3;
		}
		if (!strCity.equalsIgnoreCase("")) {
			Address = Address + "," + strCity;
		}
		if (!strDis.equalsIgnoreCase("")) {
			Address = Address + "," + strDis;
		}
		if (!strState.equalsIgnoreCase("")) {
			Address = Address + "," + strState + ".";
			if (!strZipcode.equalsIgnoreCase("")) {
				Address = Address + "-" + strZipcode + ".";
			}
		}
		if (!strAd1.equalsIgnoreCase("")) {
			strAdminAddress = Address;
			if (!app_constitution.equalsIgnoreCase("01"))
				RowCount++;
		}
	}
	String strAmountvalue = Helper.correctNull((String) hshValues
			.get("com_amountvalue"));
	String strNil = "Nil", str_arry = "";
	String strOutstandingDate = "";
	String TakeOvercheck = Helper.correctNull((String) hshValues
			.get("strTakeOvercheck"));

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
	int a = 0;
	int count = 0;

	double dblgrpexptot = Double.parseDouble(Helper
			.correctDouble((String) hshValues.get("dblGrpExpVal")));
	if (strAmtValueIn.equalsIgnoreCase("Rs")) {
		strAmtValueIn = "(Amount in  " + strAmtValueIn + ".)";
	} else {
		strAmtValueIn = "(Rs. in  " + strAmtValueIn + ")";

	}
	String strFinvaluesIn = Helper.correctNull((String) hshValues
			.get("strFinvaluesIn"));
	if (strFinvaluesIn.equalsIgnoreCase("Rs")) {
		strFinvaluesIn = "(Amount in  " + strFinvaluesIn + ".)";
	} else {
		strFinvaluesIn = "(Rs. in  " + strFinvaluesIn + ")";
	}

	if (hshValues != null) {

		arrFacRow = (ArrayList) hshValues.get("arrFacRow");
		arrRowRatingRMD = (ArrayList) hshValues.get("arrRowRatingRMD");
		arrCOPNewRow = (ArrayList) hshValues.get("arrCOPNewRow");
		arrReleaseRow = (ArrayList) hshValues.get("arrReleaseRow");
		arrPresentTL = (ArrayList) hshValues.get("arrPresentTL");
		arrCOPRow = (ArrayList) hshValues.get("arrCOPRow");
		arrMOFRow = (ArrayList) hshValues.get("arrMOFRow");
		arrMOFMjrRow = (ArrayList) hshValues.get("arrMOFMjrRow");
		arrCOPMjrRow = (ArrayList) hshValues.get("arrCOPMjrRow");
		arrRelPatrnRow = (ArrayList) hshValues.get("arrRelPatrnRow");
		arrRelPatrnMjrRow = (ArrayList) hshValues.get("arrRelPatrnMjrRow");
		str_arry = Helper
				.correctNull((String) hshValues.get("str_arr"));
		arrImplSchRow = (ArrayList) hshValues.get("arrImplSchRow");
		arrPresentWC = (ArrayList) hshValues.get("arrPresentWC");
		arrExistingWC = (ArrayList) hshValues.get("arrExistingWC");
		arrTORow = (ArrayList) hshValues.get("TurnOver");
		arrExpRow = (ArrayList) hshValues.get("arrExpRow");
		arrAssmntRow = (ArrayList) hshValues.get("arrAssmntRow");
		arryInland = (ArrayList) hshValues.get("Inland");
		arrSwotAnalysis = (ArrayList) hshValues.get("arrSwotAnalysis");
		arrRowcgssd= (ArrayList)hshValues.get("arrRowcgssd");
		arrMISRow	= (ArrayList)hshValues.get("arrMISRow");
	}
	ArrayList arrGrpExp = (ArrayList) hshValues.get("arrGrpExpDet");

	strOutstandingDate = Helper.correctNull((String) hshValues
			.get("strOutstandingDate"));

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

	HashMap hshValuesAN3 = (HashMap) hshValues.get("AN3");
	boolean finacial_flag = false;
	String strFinancialrequired = Helper.correctNull((String) hshValues
			.get("Financialrequired"));
	if (strLoanType.equalsIgnoreCase("a")) {
		if (strFinancialrequired.equalsIgnoreCase("Y")) {
			finacial_flag = true;

		}

	} else {
		finacial_flag = true;
	}
	String strconstType1 = Helper.correctNull((String) hshValues
			.get("perapp_constitution_type"));

	String IntRat = Helper
			.correctNull((String) hshValues.get("IntRat"));

	if (strAmountValue.equalsIgnoreCase("C")) {
		strAmtValueIn = "( Rs. in Crore )";
	} else if (strAmountValue.equalsIgnoreCase("L")) {
		strAmtValueIn = "( Rs. in Lacs )";
	} else {
		strAmtValueIn = "( Amount in Rs. )";
	}

	String str_birflag = Helper.correctNull((String) hshValues
			.get("bir_flag"));
	


	



if(strAmountValue.equalsIgnoreCase("C")){
	strAmtValueIn="( Rs. in Crore )";
}else if(strAmountValue.equalsIgnoreCase("L")){
	strAmtValueIn="( Rs. in Lacs )";
}else{
	strAmtValueIn="( Amount in Rs. )";
}
String strinward1="";
ArrayList arrratifrow= new ArrayList();
 ArrayList arrratifcol= new ArrayList();
String strinward=Helper.correctNull((String)hshValues.get("inw_leadno"));
	 if(strinward.equalsIgnoreCase("NA")){
		strinward1="Not Applicable";
	  }
	 else if(!strinward.equalsIgnoreCase(""))
		{
			strinward1=strinward;
		}
	 else{
		strinward1=" ";
	  }
	 
	String strFlag = "",strAppSecFlag="",strAppSecManualFlag="";
	
	String StrverCFR=Helper.correctNull((String)hshValues.get("COM_CFR_VERIFIED"));
	String StrNameCFR=Helper.correctNull((String)hshValues.get("COM_CFR_BORNAME"));
	String strStatus=Helper.correctNull((String)hshValues.get("STATUS_VERIFIED"));
	String strDesc[] = { "Capital of the entity", "Promoters Stake",
			"Eligible Amount", "Amount Applied", "Liability of the entity",
			"Maximum loan under the scheme","Recommended (lower of 3,4,5,6)",
			"Entity Name","Operative account number where the borrower is a promoter","Status of the entity","NPA Date"};
%>

<html>
<head>
<title>Simplified Renewal Process Note</title>
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
<script>
var TakeOvercheck="<%=Helper.correctNull((String) hshValues
							.get("strTakeOvercheck"))%>";
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
//Allow Enter and ctrl+z and ctrl+y  key Only
function callKeyDown()
{
	var pressedKey=String.fromCharCode(event.keyCode).toLowerCase();
    var key=window.event.keyCode;
    if(! ( (key==13) || (event.ctrlKey && pressedKey=="z") || (event.ctrlKey && pressedKey=="y") ))
	 {
     window.event.returnValue=false;
	 }
}
</script>

</head>
<body contentEditable="false" designMode="on" onKeyDown="callKeyDown();"
	onload="callLoad();">
<table width="100%" align="center" cellpadding="3" cellspacing="0"
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
		<td align="center" width="50%">Credit LCFD&nbsp;&nbsp;</td>
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
		<%
			//=Helper.correctNull((String) hshValues.get("com_sancdept")).toUpperCase()
		%>&nbsp;&nbsp;<%
			//=Helper.correctNull((String) hshValues.get("com_sancbranch")).toUpperCase()
		%>
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
									(String) hshValues.get("username"))
									.toUpperCase()%></td>
	</tr>
	<%
		}
	%>
	<%
		}
	%>
	<tr>
		<td><br>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td align="left"><br>
				OFFICE NOTE:</td>
				<td align="right" width="50%">Date&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues
							.get("com_processnotedate"))%></td>
			</tr>
			<tr>
				<td align="right" colspan="2"><b>Proposal No&nbsp;:&nbsp;</b><%=Helper.correctNull((String) request
									.getParameter("appno"))%></td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td align="center">Renewal Appraisal Annexure for Overdraft Loans
		up to Rs 500.00 lakhs.</td>
	</tr>
	<tr>
	<td align="right"><%=strAmtValueIn %>&nbsp;</td>
	</tr>

	<tr>
		<td>
		<div id="top">
		<table width="95%" cellpadding="3" align="center">
			<tr>
				<td width="55%" class="title">Sanctioning Authority</td>
				<td width="45%"><%=Helper.correctNull((String) hshValues
							.get("strSanctionAuthDesc"))%></td>
			</tr>
			<tr>
				<td class="title">PF Number</td>
				<%
					String strPFNumber = "";
					if (strOrgLevel.equalsIgnoreCase("A")) {
				%>
				<%
					strPFNumber = Helper.correctNull((String) hshValues
								.get("com_partyfileno"));
				%>
				<%
					} else {
				%>
				<%
					strPFNumber = Helper.correctNull((String) hshValues
								.get("com_roho"));
				%>
				<%
					}
				%>
				<td>
				<p><%=strPFNumber%></p>
				</td>
			</tr>
			<tr>
				<td class="title">Proposal Received date</td>
				<td><%=Helper.correctNull((String) hshValues
							.get("com_branchrcvddate"))%>&nbsp;</td>
			</tr>
			<tr>
				<td class="title">LMS Number /LAR Number</td>
				<td><%if(Helper.correctNull((String) hshValues.get("INW_LEADNO")).equalsIgnoreCase("NA")){%>Not Applicable<%}else{%><%=Helper.correctNull((String) hshValues.get("INW_LEADNO"))%><%}%>/<%=Helper.correctNull((String) hshValues
									.get("APP_INWARDNO"))%> (<%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble((String)hshValues.get("INWARD_WCLOANAMT"))+Double.parseDouble((String)hshValues.get("INWARD_TERMLOANAMT"))+Double.parseDouble((String)hshValues.get("INWARD_NONWCLOANAMT"))),strAmountValue)%>)</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>

	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td class="title" align="left">I.Borrowers Profile:</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="95%" cellpadding="3" align="center">
			<tr style="border-bottom-color: white;">
				<td width="36%">Branch&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("org_name"))
							.toUpperCase()%></td>
				<td width="30%">Branch Code&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("org_scode"))
							.toUpperCase()%></td>
				<td width="33%">Region&nbsp;:&nbsp;<%=Helper.correctNull(
									(String) hshValues.get("Reg_org_name"))
									.toUpperCase()%></td>
			</tr>
		</table>
		<table width="95%" cellpadding="3" align="center">
			<tr>
				<td width="40%">Name of the Borrower</td>
				<td width="60%"><%=Helper.correctNull((String) hshValues
									.get("perapp_title"))%> <%=Helper.correctNull((String) hshValues
									.get("perapp_name"))
							+ "&nbsp;"
							+ "(Customer ID &nbsp;&nbsp;<b>:&nbsp;</b>"
							+ Helper.correctNull((String) hshValues
									.get("perapp_cbsid")) + ")"%>
				</td>
			</tr>
			<tr>
				<td>Type of Proposal (Renewal/Short Review)</td>
				<td>
				<p><%=Helper.correctNull((String) hshValues
							.get("FACILITY_SEL_TYPE"))%></p>
				</td>
			</tr>
			<tr>
				<td>&nbsp;Regd. Office address</td>
				<td>
				<p><%=strCommaddress.toUpperCase()%></p>
				</td>
			</tr>
			<tr>
				<td>&nbsp;Regd. Corporate address</td>
				<td>
				<p><%=strPerAddress.toUpperCase()%></p>
				</td>
			</tr>
			<tr>
				<td>&nbsp;Regd.Factory&nbsp; address</td>
				<td>
				<p><%=strAdminAddress.toUpperCase()%></p>
				</td>
			</tr>
			<tr>
				<td>Constitution</td>
				<td>
				<p><%=Helper.correctNull((String) hshValues
							.get("perapp_constitution"))%></p>
				</td>
			</tr>
			<%
				if (!strconstType1.equalsIgnoreCase("01")
						&& !strconstType1.equalsIgnoreCase("02")) {
			%>
			<tr>
				<td>Date of establishment&nbsp;</td>
				<td><%=Helper.correctNull((String) hshValues
								.get("perapp_dob"))%>&nbsp;</td>
			</tr>
			<tr>
				<td>Date of Incorporation&nbsp;</td>
				<td><%=Helper.correctNull((String) hshValues
								.get("cominfo_incorporation_date"))%></td>
			</tr>
			<%
				} else {
			%>
			<tr>
				<td>Date of Birth&nbsp;</td>
				<td><%=Helper.correctNull((String) hshValues
								.get("perapp_dob"))%></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td>Nature of Business/Activity</td>
				<td>
				<p><%=Helper.correctNull((String) hshAddeDetails1
							.get("NatureofActivity"))%></p>
				</td>
			</tr>
			<tr>
				<td>&nbsp;Banking with us since</td>
				<td>
				<p><%=Helper.correctNull((String) hshValues
							.get("perapp_banksince"))%></p>
				</td>
			</tr>
			<tr>
				<td>&nbsp;Banking arrangement</td>
				<td>
				<p><%=strBanking%></p>
				</td>
			</tr>
			<tr>
				<td colspan="2" width="66%"  class="title">Name of the
				Proprietor/Partners/Directors- <br>
				<br>
				<table width="98%" align="center" cellpadding="3" cellspacing="0">
					<%
						int Promsno = 0;
						if (arrPromoterRow != null && arrPromoterRow.size() > 0) {
					%>
					<%
						for (int i = 0; i < arrPromoterRow.size(); i++) {
								arrOutCol = (ArrayList) arrPromoterRow.get(i);
								if (strHeaderFlag.equalsIgnoreCase("true")) {
									strHeaderFlag = "false";
					%>

					<tr class="title">
						<td align="center" width="3%">Sl.No</td>
						<td align="center" width="42%">Name of the Proprietor/
						Partners/ Director/ Trustee/Karta/Power of Attorney/Others</td>
						<td align="center" width="5%">Age <br>
						(Yrs)</td>
						<td align="center" width="25%">Relationship among themselves</td>
						<td align="center" width="10%">Net Worth as on <br />
						</td>
						<td align="center" width="15%">Income for Year ended</td>
					</tr>
					<%
						}
					%>
					<tr>
						<td align="left"><%=++Promsno%></td>
						<td align="left"><%=Helper.correctNull((String) arrOutCol.get(0))
							+ "&nbsp;" + "(Customer ID <B>:&nbsp;</B>"
							+ Helper.correctNull((String) arrOutCol.get(11))
							+ ")"%>
						 <%
 	if (!Helper.correctNull((String) arrOutCol.get(9))
 					.equalsIgnoreCase("")) {
 %><br />
						&nbsp;DIN No.<%=Helper.correctNull((String) arrOutCol
												.get(9))%>
						<%
							}
						%>
						</td>
						<td align="right"><%=Helper.correctNull((String) arrOutCol.get(1))%></td>
						<td align="left"><%=Helper.correctNull((String) arrOutCol.get(8))%></td>
						<td align="left" nowrap="nowrap"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrOutCol
																							.get(4))))),
													strAmountvalue)%>
						&nbsp;-&nbsp;<%=Helper.correctNull((String) arrOutCol.get(5))%></td>
						<td align="right"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrOutCol
																							.get(2))))),
													strAmountvalue)%>
						- <%=Helper.correctNull((String) arrOutCol.get(7))%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>
				<br>
				</td>

			</tr>
			<tr>
				<td colspan="2" class="title">&nbsp;Name of the Co-Obligants/Guarantors <br>
				<br>
				<table width="98%" align="center" cellpadding="3" cellspacing="0">
					<%
						int sno = 0;
						String strPrevCusID = "";

						strHeaderFlag = "true";

						if (arrGuaRow != null && arrGuaRow.size() > 0) {
					%>
					<%
						for (int i = 0; i < arrGuaRow.size(); i++) {
								arrOutCol = (ArrayList) arrGuaRow.get(i);
								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrOutCol.get(9)))) {
									continue;
								} else {
									strPrevCusID = Helper.correctNull((String) arrOutCol
											.get(9));
								}
								if (Helper.correctNull((String) arrOutCol.get(6))
										.equalsIgnoreCase("G")
										|| Helper.correctNull((String) arrOutCol.get(6))
												.equalsIgnoreCase("CO")) {
									if (strHeaderFlag.equalsIgnoreCase("true")) {
										strHeaderFlag = "false";
					%>
					<div align="right"><%=strAmtValueIn%></div>
					<tr class="title">
						<td align="center" width="3%">Sl.No</td>
						<td align="center" width="42%">Name of Co-obligants/
						Guarantors</td>
						<td align="center" width="5%">Age <br>
						(Yrs)</td>
						<td align="center" width="25%">Relationship to borrower</td>
						<td align="center" width="10%">Net Worth as on</td>
						<td align="center" width="15%">Income for Year ended</td>

					</tr>
					<%
						}
					%>
					<tr>
						<td align="left"><%=++sno%></td>
						<td align="left"><%=Helper.correctNull((String) arrOutCol
												.get(0))
										+ "&nbsp;"
										+ "(Customer ID <B>:&nbsp;</B>"
										+ Helper.correctNull((String) arrOutCol
												.get(11)) + ")"%></td>
						<td align="right"><%=Helper.correctInt((String) arrOutCol.get(1))%></td>
						<td align="left"><%=Helper.correctNull((String) arrOutCol
												.get(3))%></td>
						<td align="left" nowrap="nowrap"><%=Helper
												.converAmount(
														Helper
																.correctNull(jtn
																		.format(Double
																				.parseDouble(Helper
																						.correctDouble((String) arrOutCol
																								.get(4))))),
														strAmountValue)%>
						&nbsp;-&nbsp;<%=Helper.correctNull((String) arrOutCol
												.get(5))%></td>
						<td align="right"><%=Helper
												.converAmount(
														Helper
																.correctNull(jtn
																		.format(Double
																				.parseDouble(Helper
																						.correctDouble((String) arrOutCol
																								.get(2))))),
														strAmountValue)%>
						- <%=Helper.correctNull((String) arrOutCol
												.get(7))%></td>
					</tr>
					<%
						}
							}
						}
						if (sno == 0) {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>

				<br>
				</td>
			</tr>

			<tr>
				<td colspan="2"  class="title">Any relation to Bank Staff/Executive/Director <br>
				<br>
				<table width="98%" align="center" cellpadding="3" cellspacing="0">
					<%
						if (arrRowRelation != null && arrRowRelation.size() > 0) {
					%>


					<tr class="title">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="40%">Name</td>
						<td align="center" width="55%">Relationship</td>
					</tr>
					<%
						strPrevCusID = "";
							int j = 0;
							for (int i = 0; i < arrRowRelation.size(); i++) {
								arrColRelation = (ArrayList) arrRowRelation.get(i);
								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrColRelation.get(0)))) {
									continue;
								} else {
									strPrevCusID = Helper
											.correctNull((String) arrColRelation.get(0));
								}
								j = j + 1;
					%>
					<tr>
						<td width="5%"><%=j%></td>
						<td width="40%"><%=Helper
											.correctNull((String) arrColRelation
													.get(1))%></td>
						<td width="55%"><%=Helper
											.correctNull((String) arrColRelation
													.get(2))%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>
				<br>

				</td>

			</tr>
			<tr>
				<td>GST /UAN Certificate, If applicable</td>
				<td>
				<p>
				<%
					if (Helper.correctNull(
							(String) hshAddeDetails1.get("COMINFO_GSTINREG"))
							.equalsIgnoreCase("Y")) {
				%>

				<%
					String[] strArr = Helper.correctNull(
								(String) hshAddeDetails1.get("COMINFO_GSTIN")).split(
								"@");

						for (int i = 0; i < strArr.length; i++) {
							if (i == 0) {
				%><%=strArr[i]%> <%
 	} else {
 %> , <%=strArr[i]%> <%
 	}
 		}
 	}
 %>
				</p>
				</td>
			</tr>


			<tr>
				<td>&nbsp;Udyog Aadhaar Number </td>
				<td>
				<p><%=Helper.correctNull((String) hshValues
							.get("PERAPP_UDYOG_AADHAR"))%></p>
				</td>
			</tr>
					<%if(!Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO")).equalsIgnoreCase("")){ %>
			<tr>
			<td align="left" >Udyam Registration Certificate Number</td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO"))%></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE")).equalsIgnoreCase("")){ %>
			<tr>
			<td align="left" >Udyam Certification Date</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE"))%></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION")).equalsIgnoreCase("")){ %>
			<tr>
			<td align="left" >MSME Classification as per Udyam Registration Certificate</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION"))%></td>
			</tr>
			<%} %>
			<tr>
			<td align="left" >Borrower status</td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("perapp_status"))%></td>
			</tr>
			<tr>
			<td align="left" >Any relation to Bank Staff/Executive/Director </td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff"))%></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("005")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("006")){ %>
			<tr>
			<td align="left" >Staff ID </td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relat_staffid"))%></td>
			</tr>
			<tr>
			<td align="left" >Staff Name</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%} else{%>
			<tr>
			<td align="left" >Name of Bank's Director</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%}%>
			<tr>
			<td align="left" >Relation to the borrower</td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_blood_relation"))%></td>
			</tr>
			
			
			<tr>
				<td>&nbsp;CIN </td>
				<td>
				<p><%=Helper.correctNull((String) hshValues
							.get("cominfo_cin"))%></p>
				</td>
			</tr>
			<tr>
				<td>&nbsp;LEI Code </td>
				<td>
				<p><%=Helper.correctNull((String)hshValues.get("PERAPP_LEGAL_ENTITYID"))%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Valid upto)<%=Helper.correctNull((String)hshValues.get("PERAPP_LEGAL_EXPIRYDATE"))%></p>
				</td>
			</tr>


			<tr>
				<td>Any Change in constitution of the applicant, if yes give
				the details:</td>
				<td>
				<p><%=Helper.correctNull((String) hshValues
									.get("COM_COMMENTS"))%></p>
				</td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("indinfo_is_staff")).equalsIgnoreCase("02")){ %>
			
			<tr>
			<td colspan="2" width="66%" class="title">Staff Details : <br>

			<table width="98%" align="center" cellpadding="3" cellspacing="0" >
			<tr>
			<td align="left" >Staff ID </td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("indinfo_staff_id"))%></td>
			</tr>
			<tr>
			<td align="left" >Department Name</td>
			<td align="left"  ><%=Helper.correctNull((String)hshValues.get("peremp_department"))%></td>
			</tr>
			<tr>
			<td align="left" >Date of Joining </td>
			<td align="left"  ><%=Helper.correctNull((String)hshValues.get("indinfo_dateof_joining"))%></td>
			</tr>
			<tr>
			<td align="left" > Retirement Date</td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("peremp_retdate"))%></td>
			</tr>
			</table>
			</td></tr>
			<%} %>
			<tr>
				<td colspan="2" width="66%" class="title">CRIF Score and details of
				credit History <br>

				<table width="98%" align="center" cellpadding="3" cellspacing="0">

					<tr class="title">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="20%">Whether referred to CRIF ?</td>
						<td align="center" width="20%">CRIF Score</td>
						<td align="center" width="25%">CRIF Details</td>
						<td align="center" width="35%">CRIF Reported date</td>

					</tr>
					<%
						if (arrRowCIBIL != null && arrRowCIBIL.size() > 0) {
					%>
					<%
						boolean bflag = true;
							strPrevCusID = "";
							int j = 0;
							for (int i = 0; i < arrRowCIBIL.size(); i++) {
								arrColCIBIL = (ArrayList) arrRowCIBIL.get(i);
								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrColCIBIL.get(0)))) {
									continue;
								} else {
									strPrevCusID = Helper.correctNull((String) arrColCIBIL
											.get(0));
								}
								j = j + 1;
					%>
					<tr>
						<td width="5%"><%=j%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColCIBIL.get(1))%></td>
						<td width="10%" align="center"><%=Helper.correctNull((String) arrColCIBIL.get(10))%></td>
						<td width="10%" align="center"><%=Helper.correctNull((String) arrColCIBIL.get(11))%></td>
						<td width="10%"><%=Helper.correctNull((String) arrColCIBIL.get(12))%></td>
						<td width="50%"><%=Helper.correctNull((String) arrColCIBIL.get(13))%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td align="center" colspan="6">- No Record Found -</td>
					</tr>
					<%
						}
					%>
				</table>

				<br>
				CIBIL Score and details of credit History
				<table width="98%" align="center" cellpadding="3" cellspacing="0">

					<tr class="title">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="10%">CIBIL Refered</td>
						<td align="center" width="10%">Reported Date</td>
						<td align="center" width="10%">CIBIL Score</td>
						<td align="center" width="50%">CIBIL Details</td>
					</tr>
					<%
						if (arrRowCIBIL != null && arrRowCIBIL.size() > 0) {
					%>
					<%
						strPrevCusID = "";
							int j = 0;
							for (int i = 0; i < arrRowCIBIL.size(); i++) {
								arrColCIBIL = (ArrayList) arrRowCIBIL.get(i);
								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrColCIBIL.get(0)))) {
									continue;
								} else {
									strPrevCusID = Helper.correctNull((String) arrColCIBIL
											.get(0));
								}
								j = j + 1;
					%>
					<tr>
						<td width="5%"><%=j%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColCIBIL.get(1))%></td>
						<td width="10%" align="center"><%=Helper.correctNull((String) arrColCIBIL.get(2))%></td>
						<td width="10%"><%=Helper.correctNull((String) arrColCIBIL.get(3))%></td>
						<td width="10%" align="right"><%=Helper.correctNull((String) arrColCIBIL.get(4))%></td>
						<td width="50%"><%=Helper.correctNull((String) arrColCIBIL.get(5))%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td align="center" style="border: none;" colspan="6"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>
				<br>

				</td>

			</tr>
			<tr>
				<td colspan="2" width="66%"  class="title">&nbsp;CRILC&nbsp; Details<br>

				<table width="98%" align="center" cellpadding="3" cellspacing="0">


					<tr class="title">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="30%">Name</td>
						<td align="center" width="20%">Whether Reported to CRILC?</td>
						<td align="center" width="25%">Reported to CRILC</td>
						<td align="center" width="30%">CRILC Details</td>
					</tr>
					<%
						if (arrRowCIBIL != null && arrRowCIBIL.size() > 0) {
					%>
					<%
						boolean bflag = true;
							strPrevCusID = "";
							int j = 0;
							for (int i = 0; i < arrRowCIBIL.size(); i++) {
								arrColCIBIL = (ArrayList) arrRowCIBIL.get(i);

								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrColCIBIL.get(0)))) {
									continue;
								} else {
									strPrevCusID = Helper.correctNull((String) arrColCIBIL
											.get(0));
								}

								if (true) {
									bflag = false;
									j = j + 1;
					%>
					<tr>
						<td width="5%"><%=j%></td>
						<td width="30%"><%=Helper.correctNull((String) arrColCIBIL
										.get(1))%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColCIBIL
										.get(6))%></td>
						<td width="25%"><%=Helper.correctNull((String) arrColCIBIL
										.get(9))%></td>
						<td width="30%"><%=Helper.correctNull((String) arrColCIBIL
										.get(7))%></td>
					</tr>
					<%
						}
							}
							if (bflag) {
					%>
					<tr>
						<td align="center" colspan="5">- No Record Found -</td>
					</tr>
					<%
						}
						}
					%>
				</table>
				<br>


				</td>
			</tr>
			<tr>
				<td class="title" align="left" colspan="2">Whether RBI Defaulter<br />
				<table width="98%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<%
						if (arrRowDefault != null && arrRowDefault.size() > 0) {
					%>


					<tr class="title">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="10%">Defaulters List</td>
						<td align="center" width="20%">As on date</td>
						<td align="center" width="45%">Comments</td>
					</tr>
					<%
						strPrevCusID = "";
							int j = 0;
							for (int i = 0; i < arrRowDefault.size(); i++) {
								arrColDefault = (ArrayList) arrRowDefault.get(i);

								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrColDefault.get(0)))) {
									continue;
								} else {
									strPrevCusID = Helper
											.correctNull((String) arrColDefault.get(0));
								}
								j = j + 1;
					%>
					<tr>
						<td width="5%"><%=j%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColDefault
											.get(1))%></td>
						<td width="10%" align="center"><%=Helper.correctNull((String) arrColDefault
											.get(2))%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColDefault
											.get(3))%></td>
						<td width="45%"><%=Helper.correctNull((String) arrColDefault
											.get(4))%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>
				</td>
			</tr>
			
			<tr>
				<td class="title" align="left" colspan="2">Whether Willful Defaulter<br />
				<table width="98%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<%
						if (arrRowWFDefault != null && arrRowWFDefault.size() > 0) {
					%>


					<tr class="title">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="10%">Willful Defaulter</td>
						<td align="center" width="20%">As on date</td>
						<td align="center" width="45%">Comments</td>
					</tr>
					<%
						strPrevCusID = "";
							int j = 0;
							for (int i = 0; i < arrRowWFDefault.size(); i++) {
								arrColDefault = (ArrayList) arrRowWFDefault.get(i);

								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrColDefault.get(0)))) {
									continue;
								} else {
									strPrevCusID = Helper
											.correctNull((String) arrColDefault.get(0));
								}
								j = j + 1;
					%>
					<tr>
						<td width="5%"><%=j%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColDefault
											.get(1))%></td>
						<td width="10%" align="center"><%=Helper.correctNull((String) arrColDefault
											.get(2))%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColDefault
											.get(3))%></td>
						<td width="45%"><%=Helper.correctNull((String) arrColDefault
											.get(4))%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>
				</td>
			</tr>


			<tr>
				<td class="title" align="left" colspan="2">Whether in ECGCI
				specific approval List<br />
				<table width="98%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<%
						if (arrRowEcgc != null && arrRowEcgc.size() > 0) {
					%>


					<tr class="title">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="10%">Whether appearing in SAL</td>
						<td align="center" width="20%">As on date</td>
						<td align="center" width="45%">Comments</td>
					</tr>
					<%
						strPrevCusID = "";
							int j = 0;
							for (int i = 0; i < arrRowEcgc.size(); i++) {
								ArrayList arrColEcgc = (ArrayList) arrRowEcgc.get(i);

								if (strPrevCusID.equalsIgnoreCase(Helper
										.correctNull((String) arrColEcgc.get(0)))) {
									continue;
								} else {
									strPrevCusID = Helper.correctNull((String) arrColEcgc
											.get(0));
								}
								j = j + 1;
					%>
					<tr>
						<td width="5%"><%=j%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColEcgc.get(1))%></td>
						<td width="10%" align="center"><%=Helper.correctNull((String) arrColEcgc.get(2))%></td>
						<td width="20%"><%=Helper.correctNull((String) arrColEcgc.get(3))%></td>
						<td width="45%"><%=Helper.correctNull((String) arrColEcgc.get(4))%></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>
				</td>
			</tr>
			<tr>
		<td colspan="2">
		<div id="top">
			<table width="98%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
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
		</tr>
		<tr>
<td class="title" align="left" colspan="3" width="50%">Whether suit filed, whether action initiated by other bank/ financial institutions still pending <br/>
<div id="top">
	<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
	 <% if(arrRowDefault!=null&&arrRowDefault.size()>0)
	{%>
	 
	
	<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="30%">Name</td>
	<td align="center" width="20%">Whether suit filed</td>
	<td align="center" width="40%">Comments</td>
	</tr>
	<%
	strPrevCusID="";int j=0;
	for(int i=0;i<arrRowDefault.size();i++) {
		arrColDefault	= (ArrayList)arrRowDefault.get(i);
		
		if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColDefault.get(0))))
		{
			continue;
		}
		else
		{
			strPrevCusID = Helper.correctNull((String)arrColDefault.get(0));		
		}j=j+1;
	%>
	<tr>
	<td width="5%"><%=j%></td>
	<td width="30%"><%=Helper.correctNull((String)arrColDefault.get(1))%></td>
	<td width="20%" align="center"><%=Helper.correctNull((String)arrColDefault.get(5))%></td>
	<%if(Helper.correctNull((String)arrColDefault.get(5)).equalsIgnoreCase("No")){%>
	<td width="40%">Not Applicable</td>
	<%}else{ %>
	<td width="40%"><%=Helper.correctNull((String)arrColDefault.get(6))%></td>
	<%} %>
	</tr>
	<%}}else{%>
	<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
	<%} %>
	</table>
</div>
</td>
</tr>
			<tr>
				<td>Whether referred to Probe 42?</td>
				<td><%=Helper.correctNull((String) hshValues.get("strProbe"))%>
				&nbsp;<%
					if (Helper.correctNull((String) hshValues.get("strProbe")).equals(
							"Yes")) {
				%><br /><%=Helper.correctNull((String) hshValues
								.get("strProbeCmts"))%>
				<%
					}
				%>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" width="66%"  class="title">RMD Rating&nbsp; details along with
				rating category wise exposure limits along with limits proposed to
				category of borrowers <br>
				<%
					if (arrRowRating != null && arrRowRating.size() > 0) {
				%>
				<div align="right"><%=strAmtValueIn%></div>
				<%
					}
				%>
				<table width="98%" align="center" cellpadding="3" cellspacing="0">
					<%
						if (arrRowRating != null && arrRowRating.size() > 0) {
							for (int i = 0; i < arrRowRating.size(); i++) {
								arrColRating = (ArrayList) arrRowRating.get(i);
					%>
					<%
						if (i == 0) {
					%>
					<tr class="title">
						<td align="center">Name of rating agency</td>
						<td align="center">Date of rating/press release</td>
						<td align="center">Particulars of facility rated</td>
						<td align="center">Amount rated <br />
						</td>
						<td align="center">Rating assigned</td>
						<td align="center">Description</td>
						<td align="center">Due date</td>
						<td align="center">Risk Weight</td>
					</tr>
					<%
						}
					%>
					<tr>
						<td><%=Helper.correctNull((String) arrColRating.get(2))%></td>
						<td><%=Helper.correctNull((String) arrColRating.get(3))%></td>
						<td><%=Helper.correctNull((String) arrColRating.get(4))%></td>
						<td align="right"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrColRating
																							.get(5))))),
													strAmountValue)%></td>
						<td><%=Helper.correctNull((String) arrColRating.get(6))%></td>
						<td><%=Helper.correctNull((String) arrColRating.get(7))%></td>
						<td><%=Helper.correctNull((String) arrColRating.get(8))%></td>
						<td><%=Helper.correctNull((String) arrColRating.get(9))%>%</td>
					</tr>
					<%
						}
					%>
					<%
						if (!Helper.correctNull(
									(String) hshValues.get("cmt_ratingcomments"))
									.equalsIgnoreCase("")) {
					%>
					<tr>
						<td colspan="8" align="left">Reason for downgrading: <%=Helper.correctNull((String) hshAddeDetails1
									.get("cmt_ratingcomments"))%></td>
					</tr>
					<%
						}
					%>
					<%
						} else {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
				</table>
				<br>
				</td>
			</tr>
			<tr>
				<td colspan="2" width="66%"  class="title">Rating profile : Internal as
				confirmed by RMD <br>
				<table width="98%" align="center" cellpadding="3" cellspacing="0">
					<%
						boolean bflag1 = true;
					%>
					<%
						if (IntRat.equalsIgnoreCase("Y")) {
					%>
					<tr class="title">
						<td align="center" width="20%">Year</td>
						<td align="center" width="30%">Type</td>
						<td align="center" width="30%">Rating</td>
					</tr>
					<%
						if (arrRowRatingRMD != null && arrRowRatingRMD.size() > 0) {
								for (int i = 0; i < arrRowRatingRMD.size(); i++) {
									arColRatingRMD = (ArrayList) arrRowRatingRMD.get(i);
					%>
					<%
						if (i == 0
											&& !Helper.correctNull(
													(String) hshAddeDetails1
															.get("cre_weight"))
													.equalsIgnoreCase("")) {
										bflag1 = false;
					%>
					<tr>
						<td align="left"><%=Helper
													.correctNull((String) hshAddeDetails1
															.get("cre_ratyear"))%></td>
						<td align="left"><%=Helper
													.correctNull((String) hshAddeDetails1
															.get("cre_rattype"))%></td>
						<td align="left"><%=Helper
													.correctNull((String) hshAddeDetails1
															.get("cre_weight"))%></td>
					</tr>
					<%
						}
					%>
					<tr>
						<td align="left"><%=Helper.correctNull((String) arColRatingRMD
										.get(0))%></td>
						<td align="left"><%=Helper.correctNull((String) arColRatingRMD
										.get(1))%></td>
						<td align="left"><%=Helper.correctNull((String) arColRatingRMD
										.get(2))%></td>
					</tr>
					<%
						}
							}
						} else {
					%>
					<tr>
						<td align="center" style="border: none;"><%=strNil%></td>
					</tr>
					<%
						}
					%>
					<%
						if (bflag1
								&& !Helper.correctNull(
										(String) hshAddeDetails1.get("cre_weight"))
										.equalsIgnoreCase("")) {
					%>
					<tr>
						<td align="left"><%=Helper.correctNull((String) hshAddeDetails1
								.get("cre_ratyear"))%></td>
						<td align="left"><%=Helper.correctNull((String) hshAddeDetails1
								.get("cre_rattype"))%></td>
						<td align="left"><%=Helper.correctNull((String) hshAddeDetails1
								.get("cre_weight"))%></td>
					</tr>
					<%
						}
					%>
					<%
						if (!Helper.correctNull(
								(String) hshValues.get("strInternalrating_comment"))
								.equalsIgnoreCase("")) {
					%>
					<tr>
						<td colspan="8" align="left">Reason for downgrading: <%=Helper.correctNull((String) hshAddeDetails1
								.get("strInternalrating_comment"))%></td>
					</tr>
					<%
						}
					%>
				</table>
				<br>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0">

			<tr>
				<td>
				<table width="98%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td class="title" nowrap="nowrap">Permissible exposure for
						the rating category of borrower :</td>
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
				<table width="98%" align="center" cellpadding="3" cellspacing="0">
					<tr>
						<td width="50%" align="center">
						<table width="95%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td align="left" colspan="3">Individual Rating Grade :
								&nbsp;</td>

							</tr>
							<%
								if (!Helper.correctNull((String) hshValues.get("creweight_recent"))
										.equalsIgnoreCase("")) {
							%>
							<tr>
								<td align="center" width="25%">Year</td>
								<td align="center" width="25%">Type</td>
								<td align="center" width="50%">Rating</td>
							</tr>
							<tr>
								<td align="center" width="25%"><%=Helper.correctNull((String) hshValues
								.get("creratyear_recent"))%></td>
								<td align="center" width="25%"><%=Helper.correctNull((String) hshValues
								.get("crerattype_recent"))%></td>
								<td align="center" width="50%"><%=Helper.correctNull((String) hshValues
								.get("creweight_recent"))%></td>
							</tr>
							<%
								}
							%>
						</table>

						</td>
						<td width="40%" align="center">
						<table width="95%" cellpadding="0" cellspacing="0" border="0">
							<tr>
								<td align="left" width="50%">Permitted</td>
								<td align="left" width="50%">Actual</td>
							</tr>
							<tr>
								<td align="right" width="50%"><%=Helper
									.converAmount(Helper.correctNull(Helper
											.correctDouble((String) hshValues
													.get("dblIndVal"))),
											strAmountValue)%></td>
								<td align="right" width="50%">&nbsp;<%=Helper.converAmount(Helper.correctNull(jtn
							.format(dblTotExp)), strAmountValue)%>&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td align="center">
						<table width="95%" cellpadding="0" cellspacing="0" border="0">
							<%
								if (arrGrpExp != null && arrGrpExp.size() > 0) {
							%>
							<tr>

								<td align="left" colspan="4">Group :</td>
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
								<td align="left" width="25%"><%=Helper
											.converAmount(
													Helper
															.correctNull(jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrColExp
																							.get(3))))),
													strAmountValue)%></td>
							</tr>
							<%
								}
							%>
							<tr>
								<td align="left" width="75%" colspan="3">Total</td>
								<td align="left" width="25%"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblgrpexptot)), strAmountValue)%></td>
							</tr>
							<%
								} else {
							%>
							<tr>

								<td align="left" colspan="4">Group : Nil</td>
							</tr>
							<%
								}
							%>
						</table>

						</td>
						<td width="50%" align="center">
						<table width="95%" cellpadding="0" cellspacing="0">
							<tr>
								<td align="left" width="50%">Permitted</td>
								<td align="left" width="50%">Actual</td>
							</tr>
							<tr>
								<td align="right" width="50%"><%=Helper.converAmount(
							Helper.correctDouble((String) hshValues
									.get("dblGrpVal")), strAmountValue)%></td>
								<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(jtn
									.format(dblgrpexptot + dblTotExp)),
									strAmountValue)%></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>

			<tr>
				<td>
				<table width="95%" cellpadding="0" cellspacing="0">

					<tr>
						<td class="title">Brief History and background of the
						Borrower/Co Obligant/Guarantor:</td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String) hshValues
							.get("com_commentsbrief"))%>&nbsp;
						</td>
					</tr>
					
					<% if (!Helper.correctNull((String)hshValues.get("cmt_Briefhistory2")).equalsIgnoreCase("")) { 	%>
					<tr>
						<td class="title">Brief History and background of the
						Borrower/Co Obligant/Guarantor:</td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String) hshValues
							.get("cmt_Briefhistory2"))%>&nbsp;
						</td>
					</tr>
					<%} %>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments1")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Management :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments1"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments2")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Activity :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments2"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments3")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Products/ Services :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments3"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments4")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Manufacturing process :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments4"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments5")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Details of suppliers :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments5"))%></td></tr>
					<%
					
					if(arrSellerDeatails!=null && arrSellerDeatails.size()>0){

					%>
					<tr>
					<td class="title"><b>List of Major Suppliers :</b></td>
					</tr>
					<tr>
					<td>
					<div id="top">
					<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
					<td width="25%">Domestic</td>
					<td width="25%">Place</td>
					<td width="25%">Overseas</td>
					<td width="25%">Place</td>
					</tr>
					<%for(int i=0;i<arrSellerDeatails.size();i++){ 
					arrCol=(ArrayList)arrSellerDeatails.get(i);%>
					<tr>
					<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
					</tr>
					<%} %>
					</table>
					</div>
					</td>
					</tr>
					<%
					}%>
					<%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments6")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Details of buyers:</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments6"))%></td></tr>
					<%
					if(arrBuyerDeatails!=null && arrBuyerDeatails.size()>0){

						%>
						<tr>
						<td class="title"><b>List of Major Buyers/Customers :</b></td>
						</tr>
						<tr>
						<td>
						<div id="top">
						<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
						<tr>
						<td width="25%">Domestic</td>
						<td width="25%">Place</td>
						<td width="25%">Overseas</td>
						<td width="25%">Place</td>
						</tr>
						<%for(int i=0;i<arrBuyerDeatails.size();i++){ 
						arrCol=(ArrayList)arrBuyerDeatails.get(i);%>
						<tr>
						<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
						</tr>
						<%} %>
						</table>
						</div>
						</td>
						</tr>
						<%
						}
					%>
					<%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments8")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Memorandum and articles of association :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments8"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments9")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Partnership / Reconstitution deed :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments9"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments10")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Trust deed / bye Laws :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments10"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments11")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Search Report from ROC :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments11"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments12")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Production & Infrastructural Facilities :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments12"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments13")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Raw Material :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments13"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments14")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Selling & Marketing Arrangements :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments14"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments15")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Details of Key Managerial Persons other than directors/promoters :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments15"))%></td></tr>
					<%if(arrKeyPersonInfo!=null && arrKeyPersonInfo.size()>0){ %>
						<tr>
						<td>
						<div id="top">
						<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
						<tr class="title">
						<td width="25%">Name</td>
						<td width="25%">Age</td>
						<td width="25%">Qualification</td>
						<td width="25%">Experience</td>
						</tr>
						<%for(int i=0;i<arrKeyPersonInfo.size();i++){ 
						arrCol=(ArrayList)arrKeyPersonInfo.get(i);%>
						<tr>
						<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
						</tr>
						<%} %>
						</table>
						</div>
						</td>
						</tr>
						<%} %>
					<%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments16")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Sourcing of Proposal & Market Enquiry :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments16"))%></td></tr><%}%>
					
					<% if (!Helper.correctNull((String)hshValues.get("MgmtComments7")).equalsIgnoreCase("")){ %>
					<tr><td class="title">Others :</td></tr>
					<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments7"))%></td></tr><%}%>
					
				</table>
				</td>
			</tr>

			<tr>
				<td><span title="pagebreak" contentEditable="TRUE"
					onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>

				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td class="title" align="left">II: Credit facilities (Existing and Proposed):</td>
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
				<table width="95%" align="center" cellpadding="3" cellspacing="0"
					border="0">

					<%
						if (arrFacRow != null && arrFacRow.size() > 0) {
					%>
					<tr class="title">
						<td align="center" width="3%">Sl.No.</td>
						<td align="center" width="37%">Nature of facility</td>
						<td align="center" width="10%">Existing Limit</td>
						<td align="center" width="10%">Outstanding as on <%=strOutstandingDate%></td>
						<td align="center" width="10%">Existing exposure</td>
						<td align="center" width="10%">Additional / Fresh Limit
						sought by Borrower</td>
						<td align="center" width="10%">Additional / Fresh Limit
						Proposed</td>
						<td align="center" width="10%">Proposed Exposure</td>
						<td align="center" width="10%">Justification for
						Enhancement/Reduction</td>

					</tr>
					<%
						for (int i = 0; i < arrFacRow.size(); i++) {
								arrCol = (ArrayList) arrFacRow.get(i);
								if (Helper.correctNull((String) arrCol.get(8))
										.equalsIgnoreCase("F")) {
					%>
					<tr>
						<td align="center"><%=i + 1%>.</td>
						<td align="left"><%=Helper.correctNull((String) arrCol.get(0))
										.toUpperCase()%></td>
						<%
							if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")) {
						%>
						<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(1))))),
															strAmountValue)%></td>
						<%
							} else {
						%>
						<td align="right">(<%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(1))))),
															strAmountValue)%>)</td>
						<%
							}
						%>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(2))))),
										strAmountValue)%></td>
						<!--				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))),
										strAmountValue)%></td>-->
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))),
										strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(5))))),
										strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(6))))),
										strAmountValue)%></td>
						<%
							if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")) {
						%>
						<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(7))))),
															strAmountValue)%></td>
						<%
							} else {
						%>
						<td align="right">(<%=Helper
													.converAmount(
															jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(7)))),
															strAmountValue)%>)</td>
						<%
							}
										if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")) {
											dblLimitTot = dblLimitTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(1)));
											dblOutstandTot = dblOutstandTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(2)));
											dblExposureTot = dblExposureTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(4)));
											dblFreshLimit = dblFreshLimit
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(5)));
											dblPropLimitTot = dblPropLimitTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(6)));
											dblTotExp = dblTotExp
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(7)));
										}

										if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")
												|| Helper.correctNull((String) arrCol.get(9))
														.equalsIgnoreCase("Adhoc-Limit"))
											dblLimitTot1 = dblLimitTot1
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(1)));
						%>
						<td><%=Helper.correctNull((String) arrCol.get(13))%>&nbsp;</td>

					</tr>
					<%
						}

								else {
					%>
					<tr>
						<td align="center"><%=i + 1%>.</td>
						<td align="left"><%=Helper.correctNull(Helper
										.correctNull((String) arrCol.get(0)))%></td>
						<%
							if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")) {
						%>
						<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(1))))),
															strAmountValue)%></td>
						<%
							} else {
						%>
						<td align="right">(<%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(1))))),
															strAmountValue)%>)</td>
						<%
							}
						%>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(2))))),
										strAmountValue)%></td>
						<!--				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))),
										strAmountValue)%></td>-->
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(4))))),
										strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(5))))),
										strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
										.format(Double.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(6))))),
										strAmountValue)%></td>
						<%
							if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")) {
						%>
						<td align="right"><%=Helper
													.converAmount(
															Helper
																	.correctNull(jtn
																			.format(Double
																					.parseDouble(Helper
																							.correctDouble((String) arrCol
																									.get(7))))),
															strAmountValue)%></td>
						<%
							} else {
						%>
						<td align="right">(<%=Helper
													.converAmount(
															jtn
																	.format(Double
																			.parseDouble(Helper
																					.correctDouble((String) arrCol
																							.get(7)))),
															strAmountValue)%>)</td>
						<%
							}
										if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")) {
											dblLimitTot = dblLimitTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(1)));
											dblOutstandTot = dblOutstandTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(2)));
											dblExposureTot = dblExposureTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(4)));
											dblFreshLimit = dblFreshLimit
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(5)));
											dblPropLimitTot = dblPropLimitTot
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(6)));
											dblTotExp = dblTotExp
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(7)));
										}

										if (Helper.correctNull((String) arrCol.get(9))
												.equalsIgnoreCase("Main-Limit")
												|| Helper.correctNull((String) arrCol.get(9))
														.equalsIgnoreCase("Adhoc-Limit"))
											dblLimitTot1 = dblLimitTot1
													+ Double.parseDouble(Helper
															.correctDouble((String) arrCol
																	.get(1)));
						%>
						<td><%=Helper.correctNull((String) arrCol.get(13))%>&nbsp;</td>

					</tr>
					<%
						}
							}
					%>
					<tr>
						<td align="center" colspan="2">TOTAL</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblLimitTot1)), strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblOutstandTot)), strAmountValue)%></td>
						<!--				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblLimitTot)), strAmountValue)%></td>-->
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblExposureTot)), strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblFreshLimit)), strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblPropLimitTot)), strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn
								.format(dblTotExp)), strAmountValue)%></td>
						<td>&nbsp;</td>
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
					<tr>
					</tr>
				</table>
				</div>
				</td>
			</tr>
			
			<tr>
	<td>
	<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<jsp:include page="../print/com_AnnexureIII.jsp" flush="true">
		<jsp:param name="pageVal" value="AN3"/>
		<jsp:param name="proposalFormat" value="RPN"/>
		</jsp:include>
		</td>
		</tr>
		</table>
	</td>
</tr>
		

			<!-- Assesment Types -->
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
<%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(2)))),strAmountvalue)%>&nbsp;<%=strAmtValueIn%>
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
			double dblintMOFtot=0.00,dblMOFinttot=0.0,dblVal=0.0;
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
			double dblintMOFtot1=0.00,dblMOFinttot1=0.0;
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

	count = Integer.parseInt(Helper.correctInt((String) hshValues
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
				  <%=Helper.correctNull((String) arrReleaseCol.get(1))%>&nbsp; of Rs. - <%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrReleaseCol.get(5)))),strAmountvalue)%> &nbsp;<%=strAmtValueIn%></b>
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
					<tr> <td colspan="5"><%=Helper.correctNull((String) arrImplSchCol.get(1)) %> of Rs.  - <%=Helper.converAmount(Helper.correctNull((String) arrImplSchCol.get(3)),strAmountvalue) %> <%=strAmtValueIn%></td> </tr>
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
	if (true) {
%>
<tr>
	<td>	
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Estimates and actual for last three years:</td>
				</tr>
				<%if(arrYear!=null && arrYear.size()>0){ %>
				<tr>			
								<td align="right" width=""><%=strFinvaluesIn%></td>
							</tr>
				<tr>
				<td>
				<div id="top">
				<table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center" >
				<tr  align="center">
				<%for(int i=0;i<arrYear.size();i++){
				if(i==0){%>
				<td rowspan="2">As on/for the year end</td>
				<%} %>
				<td colspan="2"><%=Helper.correctNull((String)arrYear.get(i)) %></td>
				<%} %>
				</tr>
				<tr align="center">
				<%for(int i=0;i<arrYear.size();i++){%>
				<td width="10%">Proj</td>
				<td width="10%">Actual</td>
				<%} %>
				</tr>
				<tr>
				<%for(int i=0;i<arrSalesProj.size();i++){
				if(i==0){%>
				<td width="10%">Sales</td>
				<%} %>
				<td width="10%"  align="right"><%=Helper.correctNull((String)arrSalesProj.get(i)) %></td>
				<td width="10%" align="right"><%=Helper.correctNull((String)arrSalesAct.get(i)) %></td>
				<%} %>
				</tr>
				<tr>
				<%for(int i=0;i<arrAchievement.size();i++){
				if(i==0){%>
				<td width="10%">Achievement</td>
				<%} %>
				<td width="10%" colspan="2" align="right"><%=Helper.correctNull((String)arrAchievement.get(i)) %></td>
				<%} %>
				</tr>
				<tr>
				<%for(int i=0;i<arrGrowth.size();i++){
				if(i==0){%>
				<td width="10%">Growth</td>
				<%} %>
				<td width="10%" colspan="2" align="right"><%=Helper.correctNull((String)arrGrowth.get(i)) %></td>
				<%} %>
				</tr>
				</table>
				</div>
				</td>
				</tr>
				<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strLastYrEst"))%></td>
				</tr>
				<%}else{ 
					  if (!Helper.correctNull((String) hshValues.get("strLastYrEst"))
					 			.equalsIgnoreCase("")) {
					 %>
						<tr>
						<td align="left"><%=Helper.correctNull((String) hshValues
										.get("strLastYrEst"))%></td>
						</tr>
					<%
						}else{%>
					  <tr><td><%=strNil %></td></tr>
					  <%}} %>
			</table>
	</td>
</tr>
<%
	}
%>

<%
	if (true) {
%>
<tr>
	<td>	
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Estimates of sales for the current year:</td>
				</tr>
				<%if(!Helper.correctNull((String)hshValues.get("strCYearFrom")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("strCYearTo")).equalsIgnoreCase("")){ %>
		<tr>			
				<td align="right" width=""><%=strFinvaluesIn%></td>
			</tr>
		<tr>
  <td>
  <div id="top">
  <table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center">
		<tr align="center">
		<td width="20%" align="center"> Particulars</td>
		<td width="20%">Estimates for the current  year <%=Helper.correctNull((String)hshValues.get("strCYearFrom")) %> - <%=Helper.correctNull((String)hshValues.get("strCYearTo")) %></td>
		<td width="20%">Accepted for the current  year <%=Helper.correctNull((String)hshValues.get("strCYearFrom")) %> - <%=Helper.correctNull((String)hshValues.get("strCYearTo")) %></td>
		</tr>
		<tr>
		<td>Export </td>
		<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strEstimatedCEXPORT")),strAmountvalue) %></td>
		<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAcceptedCEXPORT")),strAmountvalue) %></td>
		</tr>
		<tr>
		<td>Domestic</td>
		<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strEstimatedCDOMESTIC")),strAmountvalue) %></td>
		<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAcceptedCDOMESTIC")),strAmountvalue) %></td>
		</tr>
		<tr>
		<td>Total Sales</td>
		<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strEstimatedCSALES")),strAmountvalue) %></td>
		<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAcceptedCSALES")),strAmountvalue) %></td>
		</tr>
		
		</table>
		</div>
  </td>
  </tr> 
  <%}else{ %>
  <tr><td><%=strNil %></td></tr>
  <%} %>
  <tr>
		<td class="title">Estimates of sales for the Next year</td>
		</tr>
		<%if(!Helper.correctNull((String)hshValues.get("strNYearFrom")).equalsIgnoreCase("")||!Helper.correctNull((String)hshValues.get("strNYearTo")).equalsIgnoreCase("")){ %>
		<tr>			
				<td align="right" width=""><%=strFinvaluesIn%></td>
			</tr>
		<tr>
  <td>
  <div id="top">
  <table width="100%"  border="0"   cellpadding="4"  class="outertable" align="center">
			<tr align="center">
			<td width="20%" align="center"> Particulars</td>
			<td width="20%">Estimates for the next year <%=Helper.correctNull((String)hshValues.get("strNYearFrom")) %> - <%=Helper.correctNull((String)hshValues.get("strNYearTo")) %> </td>
			<td width="20%">Accepted for the next year <%=Helper.correctNull((String)hshValues.get("strNYearFrom")) %> - <%=Helper.correctNull((String)hshValues.get("strNYearTo")) %> </td>
			</tr>
			<tr>
			<td>Export </td>
			<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strEstimatedNEXPORT")),strAmountvalue) %></td>
			<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAcceptedNEXPORT")),strAmountvalue) %></td>
			</tr>
			<tr>
			<td>Domestic</td>
			<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strEstimatedNDOMESTIC")),strAmountvalue) %></td>
			<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAcceptedNDOMESTIC")),strAmountvalue) %></td>
			</tr>
			<tr>
			<td>Total Sales</td>
			<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strEstimatedNSALES")),strAmountvalue) %></td>
			<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAcceptedNSALES")),strAmountvalue) %></td>
			</tr>
			
			</table>
			</div>
  </td>
  </tr>
  <%
  if (!Helper.correctNull((String) hshValues.get("strCurrYrEst"))
			.equalsIgnoreCase("")) {
%>
<tr>
<td align="left"><%=Helper.correctNull((String) hshValues
				.get("strCurrYrEst"))%></td>
</tr>
<%
	}
  %>
  <%}else{ 
  if (!Helper.correctNull((String) hshValues.get("strCurrYrEst"))
 			.equalsIgnoreCase("")) {
 %>
	<tr>
	<td align="left"><%=Helper.correctNull((String) hshValues
					.get("strCurrYrEst"))%></td>
	</tr>
<%
	}else{%>
  <tr><td><%=strNil %></td></tr>
  <%}} %>
			</table>
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
<%}}
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
					for (int i=0;i<arrAssmntRow.size();i++) {
						arrCol=(ArrayList)arrAssmntRow.get(i);
						
				%>
				<tr>
					<td class="title" align="left"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
				</tr>
				<%if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("15")){ %>
				<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="90%"  border="0"   cellpadding="4"  align="center">
							  <tr>
									<td width="20%" align="center"> Particulars</td>
									<td  width="25%" align="center"> Amount</td>
							</tr>
							<tr>
							<td>Projected Inventories (Accepted) </td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsPIA")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Projected Receivables</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strAssCmtsPR")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Projected Advance paid to suppliers</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsPAPS")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Total</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsTOT1")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Less: Trade Creditors (Accepted)</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsTC")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Less: Projected Advance received from customers</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsPARC")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Total</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsTOT2")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Less Margin</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsLM")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Drawing Power Available</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsDPA")))),strAmountvalue) %>&nbsp;</td>
							</tr>
							<tr>
							<td>Limit Recommended</td>
							<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String)hshValues.get("strAssCmtsLR")))),strAmountvalue) %>&nbsp;</td>
							</tr>
				</table>
				</div>
				</td>
			</tr>
				<%} %>
				<tr>
					<td align="left"><%=Helper.correctNull((String)arrCol.get(1))%></td>
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


	<!-- Assesment End -->
	<%
		ArrayList arrpropsecurityRow = new ArrayList();
		ArrayList arrpropsecCollRow = new ArrayList();
		arrpropsecurityRow = (ArrayList) hshValuesAN3
				.get("arrproposedSecfacwise");
		arrpropsecCollRow = (ArrayList) hshValuesAN3.get("arrRowCollSec");
		String strProposedSecurity = Helper
				.correctNull((String) hshValuesAN3
						.get("strProposedSecurity"));
		if ((arrpropsecurityRow != null && arrpropsecurityRow.size() > 0)
				|| (arrpropsecCollRow != null && arrpropsecCollRow.size() > 0)) {
	%>
	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td class="title"><br>
				III. Securities&nbsp;:</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<%
			String strGroupSecFlag = Helper
						.correctNull((String) hshValuesAN3
								.get("COMSEC_GROUPCOVERAGE"));
				String strSec_groupcomments = Helper
						.correctNull((String) hshValuesAN3
								.get("COMSEC_GROUPCOMMENTS"));
				arrpropsecurityRow = (ArrayList) hshValuesAN3
						.get("arrExistingSecfacwise");
				arrpropsecCollRow = (ArrayList) hshValuesAN3
						.get("arrcollateralforEF");
				ArrayList arrproposedCollateralSec = (ArrayList) hshValuesAN3
						.get("arrproposedCollateralSec");
				ArrayList arrproposedFacility = (ArrayList) hshValuesAN3
						.get("arrproposedFacility");
				strProposedSecurity = Helper.correctNull((String) hshValuesAN3
						.get("strProposedSecurity"));
				String strProposedSecurityComments = Helper
						.correctNull((String) hshValuesAN3
								.get("strProposedSecurityComments"));
				strAppSecFlag = Helper.correctNull((String) hshValuesAN3
						.get("COMSEC_APPCOVERAGE"));
				strAppSecManualFlag = Helper
						.correctNull((String) hshValuesAN3
								.get("COMSEC_SECTYPE"));
				ArrayList arrproposedSecfacwise = (ArrayList) hshValuesAN3
						.get("arrproposedSecfacwise");
				ArrayList arrRowCollSec = (ArrayList) hshValuesAN3
						.get("arrRowCollSec");
				HashMap hshSecdata = (HashMap) hshValuesAN3.get("hshsecdet");
				if (hshSecdata != null)
					strFlag = Helper.correctNull((String) hshSecdata
							.get("strFlag"));
				String secValue = "";
				if (!strGroupSecFlag.equalsIgnoreCase("M")) {
					if ((arrpropsecurityRow != null && arrpropsecurityRow
							.size() > 0)
							|| (arrpropsecCollRow != null && arrpropsecCollRow
									.size() > 0)) {
		%>
		
	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td><b><br>
				A. Already available for the existing facilities : </b>
				<div align="right"><%=strAmtValueIn%></div>
				</td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td align="center" width="20%"><b>Facility</b></td>
						<td align="center" width="35%"><b>Details of Security</b></td>
						<td align="center" width="10%"><b>Value</b></td>
						<td align="center" width="15%"><b>Date of Valuation</b></td>
						<td align="center" width="10%"><b>Security ID</b></td>
						<td align="center" width="20%"><b>CERSAI ID</b></td>
					</tr>
					<%
						if ((arrpropsecurityRow != null && arrpropsecurityRow
											.size() > 0)) {
					%>

					<tr>
						<td colspan="4"><b>Prime :</b></td>
					</tr>

					<%
						ArrayList arrpropsecurityCol = new ArrayList();
										ArrayList arrpropsecurity = new ArrayList();
										if (arrpropsecurityRow != null
												&& arrpropsecurityRow.size() > 0) {
											for (int i = 0; i < arrpropsecurityRow.size(); i++) {
												arrpropsecurityCol = (ArrayList) arrpropsecurityRow
														.get(i);
												for (int k = 0; k < arrpropsecurityCol
														.size(); k++) {
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
																			.get(0))%> (<%=Helper
																	.converAmount(
																			Helper
																					.correctNull(Helper
																							.formatDoubleValue(Double
																									.parseDouble(Helper
																											.correctDouble((String) arrpropsecurity
																													.get(1))))),
																			strAmountValue)%>)</td>
						<td rowspan="<%=(arrpropsecurityCol
															.size())%>"><%=Helper
																	.correctNull((String) arrpropsecurity
																			.get(2))%></td>
						<td align="right" rowspan="<%=(arrpropsecurityCol
															.size())%>"><%=Helper
																	.correctNull(secValue)%></td>
						<td rowspan="<%=(arrpropsecurityCol
															.size())%>"><%=Helper
																	.correctNull((String) arrpropsecurity
																			.get(4))%></td>
						<td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(6))%></td>
						<td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(5))%></td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td><%=Helper
																	.correctNull((String) arrpropsecurity
																			.get(0))%> (<%=Helper
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
									}
					%>
					<%
						if ((arrpropsecCollRow != null && arrpropsecCollRow
											.size() > 0)) {
					%>
					<tr>
						<td colspan="4"><b>Collateral :</b></td>
					</tr>
					<%
						ArrayList arrpropsecurityCol = new ArrayList();
										ArrayList arrpropsecurity = new ArrayList();
										if (arrpropsecCollRow != null
												&& arrpropsecCollRow.size() > 0) {
											for (int i = 0; i < arrpropsecCollRow.size(); i++) {
												arrpropsecurityCol = (ArrayList) arrpropsecCollRow
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
						<td align="right"><%=Helper
															.correctNull(secValue)%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(2))%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(4))%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(3))%></td>
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
				A. Already available for the existing facilities : </b> Nil</td>
			</tr>
		</table>
		</td>
	</tr>
	<%
		}
			} else if (strGroupSecFlag.equalsIgnoreCase("M")) {
	%>
	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td><b><br>
				A. Already available for the existing facilities : </b></td>
			</tr>
			<tr>
				<td><%=strSec_groupcomments%></td>
			</tr>
		</table>
		</td>
	</tr>
	<%
		}
	%>

	<%
		ArrayList arrpropsecurity = new ArrayList();
			ArrayList arrpropsecurityCol = new ArrayList();
			if ((arrproposedFacility != null && arrproposedFacility.size() > 0)
					|| (arrproposedCollateralSec != null && arrproposedCollateralSec
							.size() > 0)) {
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
						<td align="center" width="35%"><b>Details of Security</b></td>
						<td align="center" width="10%"><b>Value</b></td>
						<td align="center" width="15%"><b>Date of Valuation</b></td>
						<td align="center" width="10%"><b>Security ID</b></td>
						<td align="center" width="10%"><b>CERSAI ID</b></td>
					</tr>
					<%
						if (arrproposedFacility != null
										&& arrproposedFacility.size() > 0) {
					%>
					<tr align="left">
						<td colspan="6"><b>Prime :</b></td>
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
																	.get(0))%> (<%=Helper
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
						<td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
															.correctNull(secValue)%></td>
						<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
															.correctNull((String) arrpropsecurity
																	.get(4))%></td>
						<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
															.correctNull((String) arrpropsecurity
																	.get(6))%></td>
						<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper
															.correctNull((String) arrpropsecurity
																	.get(5))%></td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td><%=Helper
															.correctNull((String) arrpropsecurity
																	.get(0))%> (<%=Helper
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
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(2))%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(4))%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(3))%></td>
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
						<td align="center" width="35%"><b>Details of Security</b></td>
						<td align="center" width="10%"><b>Value</b></td>
						<td align="center" width="15%"><b>Date of Valuation</b></td>
						<td align="center" width="10%"><b>Security ID</b></td>
						<td align="center" width="10%"><b>CERSAI ID</b></td>
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
											for (int i = 0; i < arrproposedSecfacwise
													.size(); i++) {
												arrpropsecurityCol = (ArrayList) arrproposedSecfacwise
														.get(i);
												for (int k = 0; k < arrpropsecurityCol
														.size(); k++) {
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
																			.get(0))%> ( <%=Helper
																	.converAmount(
																			Helper
																					.correctDouble(Helper
																							.formatDoubleValue(Double
																									.parseDouble(Helper
																											.correctDouble((String) arrpropsecurity
																													.get(1))))),
																			strAmountValue)%>)</td>
						<td rowspan="<%=(arrpropsecurityCol
															.size())%>"><%=Helper
																	.correctNull((String) arrpropsecurity
																			.get(2))%></td>
						<td align="right" rowspan="<%=(arrpropsecurityCol
															.size())%>"><%=Helper
																	.correctNull(secValue)%></td>
						<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String) arrpropsecurity.get(4))%></td>
						<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String) arrpropsecurity.get(5))%></td>
						<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String) arrpropsecurity.get(6))%></td>
					</tr>
					<%
						} else {
					%>
					<tr>
						<td><%=Helper
																	.correctNull((String) arrpropsecurity
																			.get(0))%> ( <%=Helper
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
										if (arrRowCollSec != null
												&& arrRowCollSec.size() > 0) {
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
						<td align="right"><%=Helper
															.correctNull(secValue)%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(2))%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(3))%></td>
						<td><%=Helper.correctNull((String) arrpropsecurityCol.get(4))%></td>
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

<tr>
			<td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% 
			ArrayList arrpropsecurityCersaiQues=new ArrayList();
			arrpropsecurityCersaiQues=(ArrayList)hshValuesAN3.get("arrOutCersaiQues");
			//out.println("arrpropsecurityCersaiQues==>>"+arrpropsecurityCersaiQues);
			if(arrpropsecurityCersaiQues!=null && arrpropsecurityCersaiQues.size()>0)
					{
			%>
			<tr class="tblhead"><td colspan="11"><span style="float: left;"><b>CERSAI Search details : </b></span></td></tr>
					<tr>
					<td  align="center" width="10%"><b>Security ID</b></td>
					<td  align="center" width="10%"><b>CERSAI Search Ref No</b></td>
					<td  align="center" width="5%"><b>CERSAI search Date</b></td>
					<td  align="center" width="10%"><b>CERSAI ID</b></td>
					<td  align="center" width="5%"><b>CERSAI ID Creation Date</b></td>
					<td  align="center" width="10%"><b>Whether property offered is already mortgaged to our Bank</b></td>
					<td  align="center" width="10%"><b>Whether our bank charge reflected</b></td>
					<td  align="center" width="10%"><b>Reason for other bank charge being reflected</b></td>
					<td  align="center" width="10%"><b>Reason for our bank charge not reflecting</b></td>
					<td  align="center" width="10%"><b>Any charge on the property observed</b></td>
					<td  align="center" width="10%"><b>Reason/Remarks For Any charge on the property observed</b></td>
					</tr>
					<%
					arrpropsecurityCol=new ArrayList();
			String SEC_ALREADY_MORTG="",SEC_CHARG_REFLECT="",SEC_OTHERBNK_REMARK="",SEC_REMARK_NOT_REFLECT="",SEC_PROP_OBSERVED="",SEC_REMARKS="";
					
						for(int q=0;q<arrpropsecurityCersaiQues.size();q++)
						{
		
							arrpropsecurityCol=(ArrayList)arrpropsecurityCersaiQues.get(q);
						  
							SEC_ALREADY_MORTG=Helper.correctNull((String)arrpropsecurityCol.get(1));
							if(!SEC_ALREADY_MORTG.equalsIgnoreCase("")){
								if(SEC_ALREADY_MORTG.equalsIgnoreCase("Y"))
								{
									SEC_ALREADY_MORTG = "YES";
								}else if(SEC_ALREADY_MORTG.equalsIgnoreCase("N")){
									SEC_ALREADY_MORTG = "NO";
								}
							}
							SEC_CHARG_REFLECT=Helper.correctNull((String)arrpropsecurityCol.get(2));
							if(!SEC_CHARG_REFLECT.equalsIgnoreCase("")){
								if(SEC_CHARG_REFLECT.equalsIgnoreCase("Y"))
								{
									SEC_CHARG_REFLECT = "YES";
								}else if(SEC_CHARG_REFLECT.equalsIgnoreCase("YO"))
								{
									SEC_CHARG_REFLECT = "Yes, but along with other bank";
								}else if(SEC_CHARG_REFLECT.equalsIgnoreCase("N")){
									SEC_CHARG_REFLECT = "NO";
								}
							}
							SEC_OTHERBNK_REMARK=Helper.correctNull((String)arrpropsecurityCol.get(3));
							SEC_REMARK_NOT_REFLECT=Helper.correctNull((String)arrpropsecurityCol.get(4));
							if(SEC_REMARK_NOT_REFLECT.equalsIgnoreCase("")){
								SEC_REMARK_NOT_REFLECT = "-";
							}
							SEC_PROP_OBSERVED=Helper.correctNull((String)arrpropsecurityCol.get(5));
							
							if(!SEC_PROP_OBSERVED.equalsIgnoreCase("")){
								if(SEC_PROP_OBSERVED.equalsIgnoreCase("Y"))
								{
									SEC_PROP_OBSERVED = "YES";
								}else if(SEC_PROP_OBSERVED.equalsIgnoreCase("N")){
									SEC_PROP_OBSERVED = "NO";
								}
							}else{
								SEC_PROP_OBSERVED = "-";
							}
							SEC_REMARKS=Helper.correctNull((String)arrpropsecurityCol.get(6));
							if(SEC_REMARKS.equalsIgnoreCase("")){
								SEC_REMARKS = "-";
							}
							String Secid = Helper.correctNull((String)arrpropsecurityCol.get(7));
							String cerSearchid = Helper.correctNull((String)arrpropsecurityCol.get(9));
							String cerSearchDate = Helper.correctNull((String)arrpropsecurityCol.get(10));
							String cerid = Helper.correctNull((String)arrpropsecurityCol.get(8));
							String cerDate = Helper.correctNull((String)arrpropsecurityCol.get(11));
							%>
					<tr>
					<% 	if(!Secid.equalsIgnoreCase("")){ %>
					<td  align="center" width="10%"><%=Secid%></td>
					<%}else{ %>
					<td  align="center" width="10%">-</td>
					<%}if(!cerSearchid.equalsIgnoreCase("")){ %>
					<td align="center" width="10%">
											 <% 
												
												String strArr1[]=cerSearchid.split(",");
												for(int r1=0;r1<strArr1.length;r1++)
												{
												%>
												<%=strArr1[r1]%>
												<%	}
												%>
					</td>
					<%}else{ %>	
					<td  align="center" width="10%">-</td>
					<%} %>
					<%if(!cerSearchDate.equalsIgnoreCase("")){ %>
					<td align="center" width="5%"><%
											 String strArr2[]=cerSearchDate.split(",");
												for(int r2=0;r2<strArr2.length;r2++)
												{
													%>
													<%=strArr2[r2]%><br/>
											 <%	}%></td>
					<%}else{ %>
					<td  align="center" width="5%">-</td>
					<%} if(!cerid.equalsIgnoreCase("")){%>
					<td align="center" width="10%">
											 <% 
												String strArr3[]=cerid.split(",");
												for(int r3=0;r3<strArr3.length;r3++)
												{
											%>
												<%=strArr3[r3]%><br/>
												 
											<%	}
												%></td>	
						<%}else{ %>	
						<td  align="center" width="10%">-</td>
						<%} if(!cerDate.equalsIgnoreCase("")){%>					
						<td align="center" width="5%"><%
											 String strArr4[]=cerDate.split(",");
												for(int r4=0;r4<strArr4.length;r4++)
												{
													%>
													<%=strArr4[r4]%><br/>
											 <%	}%></td>
						<%}else{ %>
						<td  align="center" width="5%">-</td>
						<%} if(!SEC_ALREADY_MORTG.equalsIgnoreCase("")){%>
						<td  align="center" width="10%"><%=SEC_ALREADY_MORTG%></td>
						<%}else{ %>
						<td  align="center" width="10%">-</td>
						<%}if(!SEC_CHARG_REFLECT.equalsIgnoreCase("")){ %>
						<td  align="center" width="10%"><%=SEC_CHARG_REFLECT%></td>
						<%}else{ %>
						<td  align="center" width="10%">-</td>
						<%}if(!SEC_OTHERBNK_REMARK.equalsIgnoreCase("")){ %>
						<td  align="center" width="10%"><%=SEC_OTHERBNK_REMARK%></td>
						<%}else{ %>
						<td  align="center" width="10%">-</td>
						<%} %>
						<td  align="center" width="10%"><%=SEC_REMARK_NOT_REFLECT%></td>
						<td  align="center" width="10%"><%=SEC_PROP_OBSERVED%></td>
						<td  align="center" width="10%"><%=SEC_REMARKS%></td>
			</tr>
			<% }} %>
			</table>
			</div>	
			</td> 
			</tr>
	<%
		if (!strAppSecFlag.equalsIgnoreCase("M")) {
	%>
	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td><b>D. Security coverage for Bank's exposure to the
				applicant :</b>
				<div align="right"><%=strAmtValueIn%></div>
				</td>
			</tr>
			<tr>
				<td>

				<table width="100%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr>
						<td>
						<div align="left" id="top"><jsp:include
							page="../print/Securitiesprint.jsp" flush="true">
							<jsp:param name="pageVal" value="shortnote" />
						</jsp:include></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<%
		} else if (strAppSecFlag.equalsIgnoreCase("M")) {
	%>
	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td><b>D.Security coverage for Bank's exposure to the
				applicant:</b></td>
			</tr>
			<tr>
				<td>
				<%
					if (hshValuesAN3 != null) {
				%> <%=Helper.correctNull((String) hshValuesAN3
										.get("COMSEC_APPCOMMENTS"))%>
				<%
					}
				%>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<%
		}
		}
	%>

	<!--  Legal Opinion -->

	<tr>
		<td>
		<div id="top">
		<table width="95%" align="center" cellpadding="3" cellspacing="0">
			<tr class="title">
				<td width="5%">Sl No</td>
				<td width="15%">Sec Id</td>
				<td width="15%">Value</td>
				<td width="15%">Date of valuation</td>
				<td width="15%">Valuer Name</td>
				<td width="15%">Legal Opinion Date</td>
				<td width="15%">Panel Advocate Name</td>
				<td width="15%">Supplementary Legal opinion Date</td>
				<td width="15%">Legal Audit Date</td>
				<td width="15%">Legal Audit Adviser</td>
			</tr>

			<%
				 arrratifrow = new ArrayList();
				 arrratifcol = new ArrayList();
				arrratifrow = (ArrayList) hshValues.get("legalopinonarrRow1");

				if (arrratifrow != null && arrratifrow.size() > 0) {
					for (int j = 0; j < arrratifrow.size(); j++) {
						arrratifcol = (ArrayList) arrratifrow.get(j);
			%>
			<tr>
				<TD><%=j + 1%></TD>
				<td><%=Helper.correctNull((String) arrratifcol.get(0))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrratifcol.get(1)),strAmountValue)%></td>
				<td><%=Helper.correctNull((String) arrratifcol.get(2))%></td>
				<td><%=Helper.correctNull((String) arrratifcol.get(3))%></td>
				<td><%=Helper.correctNull((String) arrratifcol.get(4))%></td>
				<td><%=Helper.correctNull((String) arrratifcol.get(5))%></td>
				<td><%=Helper.correctNull((String) arrratifcol.get(6))%></td>
				<td><%=Helper.correctNull((String) arrratifcol.get(7))%></td>
				<td><%=Helper.correctNull((String) arrratifcol.get(8))%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr>
				<td align="center" colspan="10"><%=strNil%></td>
			</tr>
			<%
				}
			%>
		</table>
		</td>
	</tr>
	
	<%
	if(!Helper.correctNull((String)hshValuesAN3.get("security_legalopinioncmts")).equalsIgnoreCase("")){ %>
	<tr class="title">
	<td>
	
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td class="title"><br>
				Comments on Legal opinion / Valuation Report :</td>
			</tr>
			<tr>
			<td><%=Helper.correctNull((String)hshValuesAN3.get("security_legalopinioncmts")) %></td>
			</tr>
		</table>
	</td>
	</tr>
	<%}
	%>

							
	<%
		if (finacial_flag) {
	%>
	<tr>
		<td><span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>

		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td class="title"><br>
				IV. Performance and Financial Indicators</td>
			</tr>
		</table>

		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="0">
			<tr>
				<td><br>
				<b>1. ANALYSIS OF BALANCE SHEET</b><br>
				</td>
			</tr>
		</table>

		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>

		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="0">
			<tr>
				<td align="left"><br>
				<b> LIABILITIES :</b></td>
			</tr>
			<tr>
				<td align="right"><%=strFinvaluesIn%></td>
			</tr>
		</table>

		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="0">
			<tr>
				<td>
				<div id="top"><jsp:include
					page="../print/com_financialprint.jsp" flush="true">
					<jsp:param name="pagevalue" value="hshReqValues" />
				</jsp:include></div>
				</td>
			</tr>
		</table>

		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="0">
			<tr>
				<td align="left"><br>
				<b>ASSETS : </b></td>
			</tr>
			<tr>
				<td align="right"><%=strFinvaluesIn%></td>
			</tr>
		</table>

		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="0">
			<tr>
				<td>
				<div id="top"><jsp:include
					page="../print/com_financialprint.jsp" flush="true">
					<jsp:param name="pagevalue" value="hshReqValues1" />
				</jsp:include></div>
				</td>
			</tr>
		</table>
		<br>
		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="0">
			<tr>
				<td align="left"><b> PROFIT AND LOSS ACCOUNT:</b></td>
			</tr>
			<tr>
				<td align="right"><%=strFinvaluesIn%></td>
			</tr>
		</table>
		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="0">
			<tr>
				<td><jsp:include page="../print/com_financialprint.jsp"
					flush="true">
					<jsp:param name="pagevalue" value="hshReqValues2" />
				</jsp:include></td>
			</tr>
		</table>
		<br>
		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="3">
			<tr>
				<td><b>RATIO ANALYSIS:</b></td>
			</tr>
		</table>
		<span title="pagebreak" contentEditable="TRUE"
			onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" border="0" cellspacing="0" align="center"
			cellpadding="3">
			<tr>
				<td align="left"><br>
				<b>CAPITALISATION/COVERAGE/LIQUIDITY RATIOS :</b></td>
			</tr>
			<tr>
				<td align="right"><%=strFinvaluesIn%></td>
			</tr>
			<tr>
				<td>
				<div id="top"><jsp:include
					page="../print/com_financialprint.jsp" flush="true">
					<jsp:param name="pagevalue" value="hshReqValues3" />
				</jsp:include></div>
				</td>
			</tr>
			<tr>
				<td align="left"><br>
				<b>PROFITABILITY/TURN OVER/ OPERATING : </b></td>
			</tr>
			<tr>
				<td align="right"><%=strFinvaluesIn%></td>
			</tr>
			<tr>
				<td>
				<div id="top"><jsp:include
					page="../print/com_financialprint.jsp" flush="true">
					<jsp:param name="pagevalue" value="hshReqValues4" />
				</jsp:include></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>

</table>
<%
	}
%>
<br>

<%
	if (strSessionModuleType.equalsIgnoreCase("CORP")
			|| (strSessionModuleType.equalsIgnoreCase("AGR") && strFinancialrequired
					.equalsIgnoreCase("Y"))) {
		if (vecsize != 0 && vec != null) {
%>
<tr>
	<td><span title="pagebreak" contentEditable="TRUE"
		onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<tr>
			<td class="title"><br>
			&nbsp;Deviation if any in loan policy:</td>
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
	<table width="95%" border="0" cellspacing="0" cellpadding="2"
		align="center">
		<tr>
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
			<td align="left" nowrap width="30%">&nbsp;<%=Helper.correctNull((String) g2
											.get(2))%></td>
			<td align="center" nowrap width="20%"><%=Helper.correctNull((String) g2
											.get(3))%></td>
			<%
				if (Helper.correctNull((String) g2.get(5))
										.equalsIgnoreCase("M")) {
			%>
			<td align="right" nowrap width="20%"><%=Helper.correctNull((String) g2
												.get(7))%></td>
			<%
				} else {
			%>
			<td align="right" nowrap width="20%"><%=Helper.correctNull((String) g2
												.get(5))%></td>
			<%
				}
			%>
			<td align="left" width="30%"><%=Helper.correctNull((String) g2
											.get(6))%></td>
		</tr>
		<%
			}
					}
		%>
	</table>
	</div>
	</td>
</tr>
<%
	if (!Helper.correctNull(
					(String) hshValues.get("fin_benchmarkcmts"))
					.equalsIgnoreCase("")) {
%>
<tr>
	<td><span title="pagebreak" contentEditable="TRUE"
		onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" align="center" cellpadding="3" cellspacing="0"
		border="0">
		<tr>
			<td class="title">Comments:</td>
		</tr>
		<tr>
			<td><%=Helper.correctNull((String) hshValues
										.get("fin_benchmarkcmts"))%></td>
		</tr>
	</table>
	</td>
</tr>
<%
	}
%>
<%
	}
	}
%>
<tr>
	<td>&nbsp;</td>
</tr>







<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<div align="left" id="top">
			<jsp:include page="../print/com_ProcessnoteNewcond1.jsp" flush="true">
			<jsp:param name="pagevalue" value="LC"/>
			</jsp:include>
		</div>
	</td>
</tr>
		
	</table>
</body>
</html>