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
	double dblVal = 0.00;

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

	String strOutstandingDate = "", strRatiCount = "";
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
	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
		arrRowNonBr = (ArrayList) hshValues.get("arrRowNonBr");
	}

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
		arrImpScheRow = (ArrayList) hshValues.get("arrImpScheRow");
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
			"Limit proposed",
			"Surplus/ Shortfall(-) in required Margin" };
	String strExpLabel[] = { "Particulars", "Projected expenditure",
			"Accepted projected expenditure",
			"Operational cycle(45/ 60/ 75/ 90 days)",
			"Eligible expenditure", "Permisible finance",
			"Limits sought", "Limit proposed" };

	String strValuesIn = "";
	String strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));

	if(strValIn.equalsIgnoreCase("Rs"))
	{
		strValuesIn	= "(Amount in  "+strValIn+".)";
	}
	else
	{
		strValuesIn	= "(Rs. in  "+strValIn+")";
	}

	java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);

	int intVal = 0, iVal = 0;
	String strFBFlag = "", strNFBFlag = "", strNil = "Nil", strNotApplicatble = "Not Applicatble", strVal = "";

	String strLoanType = "", strKccFlagValue = "",strGoodsFlag="";
	if (hshValues != null) {
		strLoanType = Helper.correctNull((String) hshValues
				.get("strLoanTypeNew"));
		strKccFlagValue = Helper.correctNull((String) hshValues
				.get("strKccFlag"));
		strGoodsFlag = Helper.correctNull((String) hshValues
				.get("strGoodsFlag"));
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
	ArrayList arrPHRow = new ArrayList();
	ArrayList arrPHCol = new ArrayList();

	if (hshFarm1 != null) {
		arrRow2 = (ArrayList) hshFarm1.get("arrRow");
		arrRowP = (ArrayList) hshFarm1.get("arrRowP");
		arrRowTot = (ArrayList) hshFarm1.get("arrFBtotRow");
		arrRowInc = (ArrayList) hshFarm1.get("arrRowInc");
		arrRowFac = (ArrayList) hshFarm1.get("arrRowFac");
		arrPHRow = (ArrayList) hshFarm1.get("arrPHRow");

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

	ArrayList arrRowPhyFin = new ArrayList();
	ArrayList arrColPhyFin = new ArrayList();
	ArrayList arrCol1PhyFin = new ArrayList();
	ArrayList arrCollPhyFin = new ArrayList();
	ArrayList arrSubtotal = new ArrayList();

	hshPhysicsAndFinValues = (HashMap) hshValues
			.get("hshPhysicsAndFinValues");
	

	if (hshPhysicsAndFinValues != null) {
		arrRowPhyFin = (ArrayList) hshPhysicsAndFinValues.get("arrRow");
		arrSubtotal = (ArrayList) hshPhysicsAndFinValues
				.get("arrYears");
	}

	// Added by vinoth kumar for DSS page
	if (hshValues != null) {
		hshDSS = (HashMap) hshValues.get("hshDSSData");
	}
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
	
	HashMap hshkccIntSubVen=new HashMap();

	//added for Crop Assessment	
	HashMap hshCropAss = new HashMap();
	HashMap hshGoods = new HashMap();
	if (hshValues != null) {
		hshCropAss = (HashMap) hshValues.get("hshCropAss");
		hshkccIntSubVen=(HashMap)hshValues.get("hshkccIntSubVen");
		hshCropAss = (HashMap) hshValues.get("hshCropAss");
		hshGoods = (HashMap) hshValues.get("hshGoods");
	}
	
	ArrayList arrRowIntSub=new ArrayList();
	ArrayList arrColIntSub=new ArrayList();
	ArrayList arrCol1IntSub= new ArrayList();
	ArrayList arrCol2IntSub= new ArrayList();
	ArrayList arrCol3IntSub= new ArrayList();
	ArrayList arrCol4IntSub= new ArrayList();
	String maxROI="";	
	if(hshkccIntSubVen!=null)
	{
		arrRowIntSub=(ArrayList)hshkccIntSubVen.get("arrRow");
		maxROI = Helper.correctDouble((String) hshkccIntSubVen.get("maxCropROI"));
		if(Helper.correctNull((String) hshkccIntSubVen.get("strCropFlag")).equalsIgnoreCase("N"))
			maxROI = Helper.correctDouble((String) hshkccIntSubVen.get("maxOtherCropROI"));
	}
	if (arrRowIntSub != null && arrRowIntSub.size() > 0) 
	{
		arrColIntSub = (ArrayList) arrRowIntSub.get(0);
		arrCol1IntSub = (ArrayList) arrRowIntSub.get(1);
		arrCol2IntSub = (ArrayList) arrRowIntSub.get(2);
		arrCol3IntSub = (ArrayList) arrRowIntSub.get(3);
		arrCol4IntSub = (ArrayList) arrRowIntSub.get(4);
		
	}
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);

	ArrayList arrDataCropNew = new ArrayList();
	ArrayList arrDataCropNew1 = new ArrayList();
	ArrayList arrMaster = new ArrayList();
	double strtenor = 0.00;
	String strAssess="";
	if (hshCropAss != null) {
		arrDataCropNew = (ArrayList) hshCropAss.get("arrData");
		arrMaster = (ArrayList) hshCropAss.get("arrMasterValues");
		strtenor = Double.parseDouble(Helper
				.correctDouble((String) hshCropAss.get("strtenor")));
		strAssess=Helper.correctNull((String)hshCropAss.get("strAssessType"));
	}
	//end
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
	if (hshValues != null) {
		vec = (ArrayList) hshValues.get("vecData");
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
	
	ArrayList arrDataGoodsRow = new ArrayList();
	ArrayList arrDataGoodsCol = new ArrayList();
	if (hshGoods != null) {
		arrDataGoodsRow = (ArrayList) hshGoods.get("arrRow");
		
	}
%>

<tr>
		<td class="title">Agriculture Assessment :</td>
	</tr>
	
	
		
	<!-- <%//if(!Helper.correctNull((String)hshValues.get("cmt_intercommentsphysicalfin")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_intercommentsphysicalfin"))%></td>
	</tr>
	<%//} %>
	 -->
	<!-- End Here .... -->


	<!-- Added by Vinoth Kumar for Display Physical and Financial Program and DSS page -->
	
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td class="title"><br>Physical and Financial Programme :</td>
	 		<td align="right">&nbsp;</td>
	 		</tr>
 		</table>
 		</td>
 	</tr> 
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td>&nbsp;</td>
	 		<td align="right"><%=strValuesIn%></td>
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
				<td width="10%" align="center"><b>Programme Year</b></td>
				<td width="20%" align="center">&nbsp;<b>Activity Name</b></td>
				<td width="25%" align="center">&nbsp;<b>Specifications</b></td>
				<td width="8%" align="center">&nbsp;<b>No.</b></td>
				<td width="7%" align="center">&nbsp;<b>Units</b></td>
				<td width="20%" align="center">&nbsp;<b>Unit Cost</b></td>
				<td width="10%" align="center">&nbsp;<b>Total cost</b></td>
				<td width="5%" align="center">&nbsp;<b>Margin (%)</b></td>
				<td width="13%" align="center">&nbsp;<b>Bank Loan</b></td>
			</tr>
			<%
			ArrayList arrRowCol=new ArrayList();
				if (arrRowPhyFin != null && arrRowPhyFin.size() > 0) {
						int j = 0;
						double dblFirst = 0;
						double dblSecond = 0;
						int intFirst = 0;
						int k = 0;
						String strFacSno="0";
						for (int i = 0; i < arrRowPhyFin.size(); i++) {
							
							arrColPhyFin = (ArrayList) arrRowPhyFin.get(i);
						
							if(arrColPhyFin!=null && arrColPhyFin.size()>0)
							{
								for(int a=0;a<arrColPhyFin.size();a++)
								{
									arrRowCol = (ArrayList)arrColPhyFin.get(a);
								j = a;
							
							if (a < arrColPhyFin.size() - 1)
								arrCol1PhyFin = (ArrayList) arrColPhyFin.get(++j);
							else
								arrCol1PhyFin = (ArrayList) arrColPhyFin.get(j);
							dblFirst = Double.parseDouble(Helper
									.correctDouble((String) Helper
											.correctNull((String) arrRowCol
													.get(8))));
							dblSecond = Double.parseDouble(Helper
									.correctDouble((String) Helper
											.correctNull((String) arrRowCol
													.get(8))));
							intFirst = (int) dblFirst;
							strFacSno=Helper.correctInt((String)arrRowCol.get(10));
			
		if(a==0){
		%>
		<tr>
		<td colspan="8"><%=Helper.correctNull((String)arrRowCol.get(9))%></td>
		</tr>
		<%} %>
			<tr>
				<td align="center""><%=Helper.correctNull((String) arrRowCol
										.get(0))%></td>
				<td><%=Helper.correctNull((String) arrRowCol
										.get(1))%></td>
										<td><%=Helper.correctNull((String) arrRowCol
										.get(11))%></td>
				<td align="right"><%=Helper.correctInt((String) arrRowCol.get(2))%></td>
				<td align="center"><%=Helper.correctNull((String) arrRowCol
										.get(3))%></td>
				<td align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) Helper
																		.correctNull((String) arrRowCol
																				.get(4)))))%></td>
				<td align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) Helper
																		.correctNull((String) arrRowCol
																				.get(5)))))%></td>
				<td align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) Helper
																		.correctNull((String) arrRowCol
																				.get(6)))))%></td>
				<td align="right"><%=jtn
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) Helper
																		.correctNull((String) arrRowCol
																				.get(7)))))%></td>
			</tr>
			
			<%
				}%>
				
				
				<%
				if(arrSubtotal.size()>0)
				{
								arrCollPhyFin = (ArrayList) arrSubtotal.get(i);
								{
									//++k;
			%>
			<tr>
				<td colspan="5" align="right"><b><%=Helper
														.correctNull((String) arrCollPhyFin
																.get(1))%></b>&nbsp;:&nbsp;</td>
				<td align="right""><%=jtn
														.format(Double
																.parseDouble(Helper
																		.correctDouble((String) Helper
																				.correctNull((String) arrCollPhyFin
																						.get(3)))))%></td>
				<td align="right"">&nbsp;</td>
				<td align="right""><%=jtn
														.format(Double
																.parseDouble(Helper
																		.correctDouble((String) Helper
																				.correctNull((String) arrCollPhyFin
																						.get(2)))))%></td>
			</tr>
				
					<%		}
						}%>
					<tr>
				<td colspan="6" align="right"><b>Total cost of the project
				:</b>&nbsp;&nbsp;<%=jtn.format(Double.parseDouble(Helper
								.correctDouble((String) hshPhysicsAndFinValues
										.get

										("totalprojectcost"+strFacSno))))%></td>
				<td align="right" nowrap="nowrap"><b>Margin to Project
				cost:</b>&nbsp;&nbsp;<%=jtn.format(Double.parseDouble(Helper
								.correctDouble((String) hshPhysicsAndFinValues
										.get

										("totalmarg"+strFacSno))))%>%</td>
				<td align="right" nowrap="nowrap"><b>Total Bank Loan :</b>&nbsp;&nbsp;<%=jtn.format(Double.parseDouble(Helper
								.correctDouble((String) hshPhysicsAndFinValues
										.get

										("totalbankloan"+strFacSno))))%></td>
			</tr>
			<tr>
				<td colspan="6" align="right"><b>Margin : <%=Helper.checkDecimal(Helper
								.correctDouble((String) hshPhysicsAndFinValues
										.get("consmargin"+strFacSno)))%>
				%</b>
				<td nowrap="nowrap"><b>Recommended Bank Loan :</b></td>
				<td align="right"><%=Helper.checkDecimal(Helper
								.correctDouble((String) hshPhysicsAndFinValues
										.get("consbl"+strFacSno)))%></td>
			</tr>
				
					<%}}
					} else {
			%>
			<tr>
				<td colspan="8" align="center">&nbsp;No Data Found</td>
			</tr>
			<%
				}
			%>
			

		</table>
		</div>
		</td>
	</tr>
	<%if(!Helper.correctNull((String)hshValues.get("cmt_commentsphysicalfin")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_commentsphysicalfin"))%></td>
	</tr>
	<%} %>	
	
	<%
		if (arrRow1 != null && arrRow1.size() > 0) {
	%>
	<tr>
		<td class="title"><b>Income From Crops:</b></td>
	</tr>
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td>&nbsp;</td>
	 		<td align="right"><%=strValuesIn%></td>
	 		</tr>
 		</table>
 		</td>
 	</tr> 
	<tr>
		<td>
		<div id="top">
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td width="6%" align="center" class="title">&nbsp;Type</td>
				<td width="7%" align="center" class="title">&nbsp;Season</td>
				<td width="10%" align="center" class="title">&nbsp;Crop Name</td>
				<td width="6%" align="center" class="title">&nbsp;Unit</td>
				<td width="5%" align="center" class="title">&nbsp;Area</td>
				<td width="6%" align="center" class="title">&nbsp;Unit</td>
				<td width="7%" align="center" class="title">&nbsp;Yield</td>
				<td width="7%" align="center" class="title">&nbsp;Total Yield</td>
				<td width="7%" align="center" class="title">&nbsp;Price</td>
				<td width="9%" align="center" class="title">&nbsp;Total Income
				</td>
				<td width="13%" align="center" class="title">&nbsp;Cost of
				cultivation</td>
				<td width="12%" align="center" class="title">&nbsp;Total cost
				of cultivation</td>
				<td width="10%" align="center" class="title">&nbsp;Surplus</td>
			</tr>
			<%
				if (arrRow1 != null && arrRow1.size() > 0) {

							for (int i = 0; i < arrRow1.size(); i++) {
								arrCol1 = (ArrayList) arrRow1.get(i);
								String strYear = Helper
										.correctNull((String) arrCol1.get(0));
								arrInFromCropsRow = (ArrayList) arrCol1.get(1);
			%>
			<tr>
				<td colspan="13"><b>Year&nbsp;<%=strYear%></b></td>
			</tr>
			<%
				if (arrInFromCropsRow != null
										&& arrInFromCropsRow.size() > 0) {
									for (int j = 0; j < arrInFromCropsRow.size(); j++) {
										arrInFromCropsCol = (ArrayList) arrInFromCropsRow
												.get(j);
										String strexitype = Helper
												.correctNull((String) arrInFromCropsCol
														.get(13));
										String strexiprotyp = null;
										String strAreUnits = "", strYeildUnit = "";
										if (strexitype.equalsIgnoreCase("1")) {
											strexiprotyp = "Existing";
										} else if (strexitype.equalsIgnoreCase("2")) {
											strexiprotyp = "Proposed";
										} else {
											strexiprotyp = "";

										}
			%>
			<tr>

				<td width="6%" align="center">&nbsp;<%=strexiprotyp%></td>
				<td width="7%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrInFromCropsCol
																	.get(0))%></td>
				<td width="10%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrInFromCropsCol
																	.get(12))%></td>
				<td width="6%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrInFromCropsCol
																	.get(14))%></td>
				<td width="5%" align="center">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(2))%></td>
				<td width="6%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrInFromCropsCol
																	.get(15))%></td>
				<td width="7%" align="center">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(3))%></td>
				<td width="7%" align="center">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(4))%></td>
				<td width="7%" align="right">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(5))%></td>
				<td width="9%" align="right">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(6))%></td>
				<td width="10%" align="right">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(7))%></td>
				<td width="10%" align="right">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(8))%></td>
				<td width="10%" align="right">&nbsp;<%=Helper
															.checkDecimal((String) arrInFromCropsCol
																	.get(9))%></td>
			</tr>
			<%
				}
								}

							}

						}
			%>

		</table>
		</div>
		</td>
	</tr>
	<% } %>
	<%if(!Helper.correctNull((String)hshValues.get("cmt_commentscropincome")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_commentscropincome"))%></td>
	</tr>
	<%} %>
	<!-- <%//if(!Helper.correctNull((String)hshValues.get("cmt_intercommentscropincome")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_intercommentscropincome"))%></td>
	</tr>
	<%//} %>
	 -->
	<% if (hshFarm1 != null) { 
	//out.println("facTenor===="+facTenor);
	int intSection_count=0;
	int intQuotient = (facTenor / 5);
	int intRemainder = (facTenor % 5);
	if(facTenor > 5)
	{
		if(intRemainder == 0)
			intSection_count = intQuotient;
		else
			intSection_count = intQuotient + 1;
	}
	else
	{
		intSection_count = 1;
	}
	%>
	
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td class="title"><br>Farm Budget:</td>
	 		<td align="right">&nbsp;</td>
	 		</tr>
 		</table>
 		</td>
 	</tr> 
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td>&nbsp;</td>
	 		<td align="right"><%=strValuesIn%></td>
	 		</tr>
 		</table>
 		</td>
 	</tr> 
 	<% int r=0;
 	int t=0;
	 for(int s=0;s<intSection_count;s++)
		{ 
		if(s==0)
		{r=0;t=5;
		if(facTenor<5)
			t=facTenor;
		} %>
	<tr>
		<td>
		<div id="top">
		<table width="95%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td width="30%"><b>Financial Year</b></td>
				<%
					for (p = r; p < t; p++) {
				%>
				<td align="center"><b>YEAR <%=p + 1%></b></td>
				<% } %>
			</tr>
			<tr>
				<td width="30%">Net Income from Existing Crops</td>
				<%
					for (p = r; p < t; p++) {
					if (arrRow2 != null && arrRow2.size() > 0) {

					arrCol2 = (ArrayList) arrRow2.get(p);
				%>
				<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrCol2.get(0)))%></td>
				<% } else { %>
				<td align="center">&nbsp;</td>

				<% } } %>
			</tr>

			<tr>
				<td width="30%">Net Income from Proposed Crops</td>
				<%
					for (p = r; p < t; p++) {
					if (arrRowP != null && arrRowP.size() > 0) {

					arrColP = (ArrayList) arrRowP.get(p);
				%>
				<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColP.get(0)))%></td>
				<% } else { %>
				<td align="center">&nbsp;</td>

				<% } } %>
			</tr>
			<%
				if (arrPHRow != null && arrPHRow.size() > 0) {
				for (q = 0; q < arrPHRow.size(); q++) {

				arrPHCol = (ArrayList) arrPHRow.get(q);
			%>
			<tr>
				<td width="30%">Net Income from Proposed Activity [&nbsp;<%=Helper.correctNull((String) arrPHCol.get(0))%>&nbsp;]</td>
				<%
					for (p = r+1; p <= t; p++) {
					if (p <= 15) {
				%>
				<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrPHCol.get(p))))%></td>
				<% } else { %>
				<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrPHCol.get(15))))%></td>
				<% } } %>
			</tr>
			<% } } else { %>
			<tr>
				<td width="30%">Net Income from Proposed Activity</td>
				<%
					for (p = r; p < t; p++) {
				%>
				<td align="right">0.00</td>
				<% } %>
			</tr>
			<% } %>

			<tr>
				<td width="30%">Other Net Income from allied Activities</td>
				<%
					for (p = r; p < t; p++) {
					if (arrRowInc != null && arrRowInc.size() > 0) {

					arrColInc = (ArrayList) arrRowInc.get(p);
				%>
				<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColInc.get(0)))%></td>
				<% } else { %>
				<td align="center">&nbsp;</td>
				<% } } %>
			</tr>

			<tr>
				<td width="30%">Total Net Income</td>
				<%
					for (p = r; p < t; p++) {
					if (arrRowTot != null && arrRowTot.size() > 0) {

					arrColTot = (ArrayList) arrRowTot.get(p);
				%>
				<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColTot.get(0)))%></td>
				<% } else { %>
				<td align="center">&nbsp;</td>
				<% } } %>
		</table>
		</div>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<% 
	facTenor=facTenor-5;
	r=r+5;
	if(facTenor>5)
	{
		t=t+5;
	}
	else
	{
		t=t+facTenor;
	}
		}
	} %>
	<%if(!Helper.correctNull((String)hshValues.get("cmt_commentsagrifarmbudget")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_commentsagrifarmbudget"))%></td>
	</tr>
	<%} %>
	
		<%
		if (strKccFlagValue.equalsIgnoreCase("Y")) {
	
		if (arrDataCropNew != null && arrDataCropNew.size() > 0) {
	%>
	
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td class="title"><br>Assessment of Limit:</td>
	 		<td align="right">&nbsp;</td>
	 		</tr>
 		</table>
 		</td>
 	</tr>  
 	
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td>&nbsp;</td>
	 		<td align="right"><%=strValuesIn%></td>
	 		</tr>
 		</table>
 		</td>
 	</tr> 
	<tr>
		<td>
		<div id="top">
		<%if(strAssess.equalsIgnoreCase("130")){ %>
		<table width="95%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td width="20%" align="center" class="title">Crops</td>
				<td width="10%" align="center" class="title">Area in acres</td>
				<td width="14%" align="center" class="title">Scale of Finance<br>
				per acre</td>
				<td width="14%" align="center" class="title">Limit as per <br>
				scale of finance</td>
				<td width="14%" align="center" class="title">Eligible limit</td>
				<td width="14%" align="center" class="title">Limit recommended</td>
				<td width="14%" align="center" class="title">Limit sanctioned</td>
			</tr>
			<%
				if (arrDataCropNew != null && arrDataCropNew.size() > 0) {
								double total = 0.0;
								for (int j = 0; j < arrDataCropNew.size(); j++) {
									arrDataCropNew1 = (ArrayList) arrDataCropNew
											.get(j);
									double area = Double.parseDouble(Helper
											.correctDouble((String) arrDataCropNew1
													.get(5)));
									double scale_fin = Double.parseDouble(Helper
											.correctDouble((String) arrDataCropNew1
													.get(6)));
									double limit_scaleoffin = area * scale_fin;
									total = total + limit_scaleoffin;
			%>
			<tr>
				<td>&nbsp;<%=Helper
														.correctNull((String) arrDataCropNew1
																.get(2))%>&nbsp;</td>
				<td align='right'><%=nf
														.format(Double
																.parseDouble((Helper
																		.correctDouble((String) arrDataCropNew1
																				.get(5)))))%>&nbsp;</td>
				<td align='right'><%=nf
														.format(Double
																.parseDouble((Helper
																		.correctDouble((String) arrDataCropNew1
																				.get(6)))))%>&nbsp;</td>
				<td align='right'><%=nf.format(limit_scaleoffin)%>&nbsp;</td>
				<td align='right'><%=nf.format(limit_scaleoffin)%>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="4" align='right'><b>Total</b></td>
				<td align='right'><b><%=nf.format(total)%>&nbsp;</b></td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		<%
			double ph_expenses = 0.0;
							double frm_maintainance = 0.0;
							double sec_year = 0.0;
							double thrd_year = 0.0;
							double fourth_year = 0.0;
							double fifth_year = 0.0;

							double ph_expenses_value = 0.0;
							double frm_maintainance_value = 0.0;
							double total_value = 0.0;
							double sec_year_value = 0.0;
							double thrd_year_value = 0.0;
							double fourth_year_value = 0.0;
							double fifth_year_value = 0.0;

							if (arrMaster != null) {
								if (arrMaster.size() > 0) {
									ph_expenses = Double.parseDouble(Helper
											.correctDouble((String) arrMaster
													.get(0)));
									frm_maintainance = Double
											.parseDouble(Helper
													.correctDouble((String) arrMaster
															.get(1)));
									sec_year = Double.parseDouble(Helper
											.correctDouble((String) arrMaster
													.get(2)));
									thrd_year = Double.parseDouble(Helper
											.correctDouble((String) arrMaster
													.get(3)));
									fourth_year = Double.parseDouble(Helper
											.correctDouble((String) arrMaster
													.get(4)));
									fifth_year = Double.parseDouble(Helper
											.correctDouble((String) arrMaster
													.get(5)));

									ph_expenses_value = Double
											.parseDouble(nf
													.format(((ph_expenses * total) / 100.00)));
									frm_maintainance_value = Double
											.parseDouble(nf
													.format(((frm_maintainance * total) / 100.00)));
									total_value = total + ph_expenses_value
											+ frm_maintainance_value;
									sec_year_value = Double
											.parseDouble(nf
													.format((total_value * (sec_year / 100.00))))
											+ total_value;
									thrd_year_value = Double
											.parseDouble(nf
													.format((sec_year_value * (thrd_year / 100.00))))
											+ sec_year_value;
									fourth_year_value = Double
											.parseDouble(nf
													.format((thrd_year_value * (fourth_year / 100.00))))
											+ thrd_year_value;
									fifth_year_value = Double
											.parseDouble(nf
													.format((fourth_year_value * (fifth_year / 100.00))))
											+ fourth_year_value;
								}
							}
		%>
			<tr>
				<td width='58%' align='left' colspan="4">&nbsp;<%=nf.format(ph_expenses)%>% towards Post harvest / house hold expense / consumption</td>
				<td align='right' width='14%'><%=nf.format(ph_expenses_value)%>&nbsp;</td>
				<td width="14%">&nbsp;</td>
				<td width="14%">&nbsp;</td>
			</tr>
			<tr>
				<td align='left'  colspan="4">&nbsp;<%=nf.format(frm_maintainance)%>% towards farm maintenance</td>
				<td align='right'><%=nf.format(frm_maintainance_value)%>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align='left'  colspan="4">&nbsp;Eligible Limit of Crop Loan for the First year</td>
				<td align='right'><%=nf.format(total_value)%>&nbsp;</td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("recommval0")))))%></td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("sancval0")))))%></td>
			</tr>
			<%
				if (strtenor > 12) {
			%>
			<tr>
				<td align='left'  colspan="4">&nbsp;Limit for the Second Year (Add <%=nf.format(sec_year)%>% on First Year Limit)</td>
				<td align='right'><%=nf.format(sec_year_value)%>&nbsp;</td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("recommval1")))))%></td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("sancval1")))))%></td>
			</tr>
			<tr>
				<td align='left'  colspan="4">&nbsp;Limit for the Third Year (Add <%=nf.format(thrd_year)%>% on Second Year Limit)</td>
				<td align='right'><%=nf.format(thrd_year_value)%>&nbsp;</td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("recommval2")))))%></td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("sancval2")))))%></td>
			</tr>
			<tr>
				<td align='left'  colspan="4">&nbsp;Limit for the Fourth Year (Add <%=nf.format(fourth_year)%>% on Third Year Limit)</td>
				<td align='right'><%=nf.format(fourth_year_value)%>&nbsp;</td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("recommval3")))))%></td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("sancval3")))))%></td>
			</tr>
			<tr>
				<td align='left'  colspan="4">&nbsp;Limit for the Fifth Year (Add <%=nf.format(fifth_year)%>% on Fourth Year Limit)</td>
				<td align='right'><%=nf.format(fifth_year_value)%>&nbsp;</td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("recommval4")))))%></td>
				<td align="right"><%=nf.format(Double.parseDouble((Helper.correctDouble((String) hshCropAss.get("sancval4")))))%></td>
			</tr>
			<% } } %>
			<%}else{ %>
			
			<table width="100%" border="0" cellspacing="1"  cellpadding="1" class="outertable" align="center" id="idothers">
			<tr>
				<td width="10%" align="center">Nature of Activity</td>
				<td width="9%" align="center">No. of Units</td>
				<td width="9%" align="center">Scale of Finance</td>
				<td width="10%" align="center">Limit as per <br> scale of finance</td>
				<td width="9.99%" align="center">Limit Recommended</td>
			</tr>
			<%
			if(arrDataCropNew!=null && arrDataCropNew.size()>0) 
			{
				double total=0.0,limit_scaleoffin=0.0;
				for(int j=0;j<arrDataCropNew.size();j++)
				{
					arrDataCropNew1=(ArrayList)arrDataCropNew.get(j);
					limit_scaleoffin+=Double.parseDouble((Helper.correctDouble((String)arrDataCropNew1.get(9))));
				%>
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String)arrDataCropNew1.get(2))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrDataCropNew1.get(15)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrDataCropNew1.get(6)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrDataCropNew1.get(7)))))%>&nbsp;</td>
						<td align='right'><%=nf.format(Double.parseDouble((Helper.correctDouble((String)arrDataCropNew1.get(9)))))%>&nbsp;</td>
					</tr>
				<%
				}
				%>
				<tr>
					<td colspan="4" align='right'>
					<b>Total</b>
					</td>
					<td align='right'>
					<b><%=nf.format(limit_scaleoffin)%>&nbsp;</b>
					</td>
				</tr>
				<%} %>
				</table>
			<%} %>
		</table>
		</div>
	</td>
	</tr>
<% }} %>
	<%if(!Helper.correctNull((String)hshValues.get("cmt_commentscropass")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_commentscropass"))%></td>
	</tr>
	<%} %>
 	<!-- <%//if(!Helper.correctNull((String)hshValues.get("cmt_intercommentscroploan")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_intercommentscroploan"))%></td>
	</tr>
	<%//} %>
 	 -->
 	
	<%
		if (strGoodsFlag.equalsIgnoreCase("Y")) {
	
		if (arrDataGoodsRow != null && arrDataGoodsRow.size() > 0) {
	%>
	
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td class="title"><br>Details of Goods:</td>
	 		<td align="right">&nbsp;</td>
	 		</tr>
 		</table>
 		</td>
 	</tr>  
	
	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td>&nbsp;</td>
	 		<td align="right"><%=strValuesIn%></td>
	 		</tr>
 		</table>
 		</td>
 	</tr> 
	<tr>
		<td>
		<div id="top">
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td width="6%" align="center" class="title">&nbsp;Name & Description of the goods to be pledged</td>
				<td width="7%" align="center" class="title">&nbsp;Document of title to goods & or warehouse Receipts</td>
				<td width="10%" align="center" class="title">&nbsp;No. of units to be Pledged</td>
				<td width="6%" align="center" class="title">&nbsp;Weight / Measurement units</td>
				<td width="5%" align="center" class="title">&nbsp;Market rate per unit</td>
				<td width="6%" align="center" class="title">&nbsp;Total Market Value</td>
				<td width="7%" align="center" class="title">&nbsp;Value as per warehouse receipt</td>
				<td width="7%" align="center" class="title">&nbsp;Margin (%)</td>
				<td width="7%" align="center" class="title">&nbsp;Bank Loan</td>
				<td width="7%" align="center" class="title">&nbsp;Date of Receipt Loan</td>
				
			</tr>
			<%
				if (arrDataGoodsRow != null && arrDataGoodsRow.size() > 0) {

							for (int i = 0; i < arrDataGoodsRow.size(); i++) {
								arrDataGoodsCol = (ArrayList) arrDataGoodsRow.get(i);
								
			%>
		
			<tr>

				<td width="7%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrDataGoodsCol
																	.get(1))%></td>
				<td width="10%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrDataGoodsCol
																	.get(2))%></td>
				<td width="6%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrDataGoodsCol
																	.get(3))%></td>
				<td width="5%" align="center">&nbsp;<%=Helper
															.checkDecimal((String) arrDataGoodsCol
																	.get(4))%></td>
				<td width="6%" align="center">&nbsp;<%=Helper
															.correctNull((String) arrDataGoodsCol
																	.get(6))%></td>
				<td width="7%" align="center">&nbsp;<%=Helper
															.checkDecimal((String) arrDataGoodsCol
																	.get(7))%></td>
				<td width="7%" align="center">&nbsp;<%=Helper
															.checkDecimal((String) arrDataGoodsCol
																	.get(8))%></td>
				<td width="7%" align="right">&nbsp;<%=Helper
															.checkDecimal((String) arrDataGoodsCol
																	.get(12))%></td>
				<td width="9%" align="right">&nbsp;<%=Helper
															.checkDecimal((String) arrDataGoodsCol
																	.get(11))%></td>
				<td width="9%" align="right">&nbsp;<%=Helper
															.correctNull((String) arrDataGoodsCol
																	.get(9))%></td>
				

			</tr>
			<%
				}
								}

							}%>
		</table>
		</div>
		</td>
						<%}else {
			%>

		
	</tr>
	<% } %>
 	
 	
 	
	
	<!-- <%//if(!Helper.correctNull((String)hshValues.get("cmt_intercommentsagrifarmbudget")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_intercommentsagrifarmbudget"))%></td>
	</tr>
	<%//} %>
	 -->
	
			
				<% if (arraySizeDSS != 0) {
					int width=arraySizeDSS*15;
					width=width+25;
					if(width>100)
					{
						width=95;
					}
					%>	
					

						<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td class="title"><br>Debt Servicing Statement :</td>
	 		<td align="right">&nbsp;</td>
	 		</tr>
 		</table>
 		</td>
 	</tr>  
					
		<%
		int sizeyearval=arraySizeDSS;
		int intSection_count=0;
		int intQuotient = (sizeyearval / 5);
		int intRemainder = (sizeyearval % 5);
		if(sizeyearval > 5)
		{
			if(intRemainder == 0)
				intSection_count = intQuotient;
			else
				intSection_count = intQuotient + 1;
		}
		else
		{
			intSection_count = 1;
		}
		 int t=0;
		 for(int s=0;s<intSection_count;s++)
			{ 
			if(s==0)
			{p=0;t=5;
			if(sizeyearval<5)
				t=sizeyearval;
			}
		%>		    		  
		<tr>
		  <td>
			<table border="0" align="center" cellspacing="0" cellpadding="0" width="<%=width%>%">
				<tr>			
				<td valign="top"  width="25%">
				<div id="top">
					<table border="0" cellspacing="0" cellpadding="2" width="95%">
						<tr height="25"><td><b>Financial Year</b></td></tr>					
						<tr height="25"><td>Net Income from Farm</td></tr>
						<tr height="25"><td>Other Income</td></tr>
					
					<%if(arrBankRow!=null && arrBankRow.size()>0)
					{
					%>
						<tr height="25">
							<td><b>Existing Loans - Our Bank</b></td>
						</tr>
						<% for(int b=0;b<arrBankRow.size();b++)
						{
							arrBankCol=(ArrayList)arrBankRow.get(b);
						%>
							<tr height="25">
								<td nowrap="nowrap"><b><%=Helper.correctNull((String)arrBankCol.get(0))%></b></td>
							</tr>
							<%if((Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("E")))
							{ %>
								<tr height="25">
									<td>Installments</td>
								</tr>
							<%}else if( (Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("TL"))   && (!Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("E")) && (!Helper.correctNull((String)arrBankCol.get(1)).equalsIgnoreCase("")))
							{ %>
								<tr height="25">
									<td>Installments</td>
								</tr>
								<tr height="25">
									<td>Interest</td>
								</tr>
							<%}else if( (Helper.correctNull((String)arrBankCol.get(2)).equalsIgnoreCase("OD")))
							{ %>
								<tr height="25">
									<td>Interest</td>
								</tr>
							<%} %>
					<%}
					
					} %>
					
					<%if(arrOthBankRow!=null && arrOthBankRow.size()>0){%>
					<tr height="25">
						<td ><b>Existing Loans - Other Bank</b></td>
					</tr>
						<% for(int b=0;b<arrOthBankRow.size();b++){
							arrOthBankCol=(ArrayList)arrOthBankRow.get(b);
						%>
						<tr height="25">
						<td nowrap="nowrap"><b><%=Helper.correctNull((String)arrOthBankCol.get(0))%></b></td></tr>
						<%if((Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase("E"))){ %>
						<tr height="25">
						<td>Installments</td>
						</tr>
						<%}else if( (Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("TL"))  && (!Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase("E")) && (!Helper.correctNull((String)arrOthBankCol.get(1)).equalsIgnoreCase(""))){ %>

					<tr height="25">
						<td>Installments</td>
					</tr>
					
					<tr height="25">
						<td>Interest</td>
					</tr>
					<%} else if((Helper.correctNull((String)arrOthBankCol.get(2)).equalsIgnoreCase("OD"))){%>
					<tr height="25">
						<td>Interest</td>
					</tr>
					<%} %>
					<%}} %>

					<%if(arrBankPropRow!=null && arrBankPropRow.size()>0)
					{ %>
					<tr height="25">
						<td><b>Proposed Loans</b></td>
					</tr>
						<%for(int b=0;b<arrBankPropRow.size();b++)
						{
							arrBankPropCol=(ArrayList)arrBankPropRow.get(b);
						%>
							<tr height="25">
								<td nowrap="nowrap"><b><%=Helper.correctNull((String)arrBankPropCol.get(0))%></b></td>
							</tr>
							
							<%if((Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("E")))
							{%>
								<tr height="25">
									<td>Installments</td>
								</tr>
							<%}else if( (Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("TL")) && (!Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("E")) && (!Helper.correctNull((String)arrBankPropCol.get(2)).equalsIgnoreCase("")))
							{ %>
								<tr height="25">
									<td>Installments</td>
								</tr>
								<tr height="25">
									<td>Interest</td>
								</tr>
							<%}else if(Helper.correctNull((String)arrBankPropCol.get(1)).equalsIgnoreCase("OD"))
							{ %>
								<tr height="25">
									<td>Interest</td>
								</tr>
							<%} %>
					<%}
						
					} %>
					<tr height="25"><td>Total Commitment</td></tr>
					<tr height="25"><td>Net Surplus</td></tr>
					<tr height="25"><td>% Farm Net Surplus</td></tr>
					<tr height="25"><td>% of Net Surplus</td></tr>
				</table>
				</div>
			</td>

				<%
					for (int i = p; i < t; i++) {
							arrColDSS = new ArrayList();
							arrColDSS = (ArrayList) arrRowDSS.get(i);
							double totalValue = 0.00;
							double totalValue1 = 0.00;
				%>
				<td valign="top"  width="15%">
				<div id="top">
				<table border="0" cellspacing="0" cellpadding="2" width="95%">
					<tr height="25">
						<td align="center" nowrap="nowrap">&nbsp;<b>Year&nbsp; <%=i+1%></b>&nbsp;</td></tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(6))))%></td>
						<%hshForCalc.put("Netincome"+i,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(6)))));%>
					</tr>
						<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(5))))%></td>
						<%hshForCalc.put("OtherIncome"+i,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(5))))); %>
					</tr>
					
					<%
					if(arrBankRow!=null && arrBankRow.size()>0){%>
					
					<tr height="25">
						<td align="right">&nbsp;</td>
					</tr>
						<% 
						//arrBankExisEmiDataRow = (ArrayList)hshDSS.get("arrBankExisEmiDataRow"+i+0);
						for(int b=0;b<arrBankRow.size();b++){
							arrBankExisEmiDataRow = (ArrayList)hshDSS.get("arrBankExisEmiDataRow"+i+b);
							arrBankCol=(ArrayList)arrBankRow.get(b);
					
							arrBankExisEmiDataCol = (ArrayList)arrBankExisEmiDataRow.get(0);
						%>						
						<%if((Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("E"))){
							totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(0)));
							%>
							<tr height="25" >
						       <td align="right">&nbsp;</td>
					       </tr>
						<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(0))))%></td>
						</tr>
						<%}else if( (Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (!Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase("E")) && (!Helper.correctNull((String)arrBankExisEmiDataCol.get(3)).equalsIgnoreCase(""))){ 
							totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(0)));
							totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(1)));
						%>
						<tr height="25" >
						   <td align="right">&nbsp;</td>
					    </tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(0))))%></td>
					</tr>
					<tr height="25"><td align="right"><%=arrBankExisEmiDataCol.get(1)%></td>
					</tr>
						<%}else if(Helper.correctNull((String)arrBankExisEmiDataCol.get(2)).equalsIgnoreCase("OD")){
							totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(1)));
							%>
							<tr height="25" >
						<td align="right">&nbsp;</td>
					</tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankExisEmiDataCol.get(1))))%></td>
					</tr>
					<%}}
					}%>
					
										<%
					if(arrOthBankRow!=null && arrOthBankRow.size()>0){%>
					
					<tr height="25">
						<td align="right">&nbsp;</td>
					</tr>
						<% 
					//	arrOthBankDataRow = (ArrayList)hshDSS.get("arrOthBankExisDataRow"+i+0);
						for(int b=0;b<arrOthBankRow.size();b++){
							arrOthBankDataRow = (ArrayList)hshDSS.get("arrOthBankExisDataRow"+i+b);
							arrBankCol=(ArrayList)arrOthBankRow.get(b);
						
							arrOthBankDataCol = (ArrayList)arrOthBankDataRow.get(0);
						%>
						<%if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("E"))){
							totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(0)));
						%>
								
							<tr height="25" >
						<td align="right">&nbsp;</td>
					</tr>
						<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(0))))%></td>
						</tr>
						<%}else if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("TL")) && (!Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase("E")) && (!Helper.correctNull((String)arrOthBankDataCol.get(3)).equalsIgnoreCase(""))){
						totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(0)));
						totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(1)));%>
						<tr height="25" >
						<td align="right">&nbsp;</td>
					</tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(0))))%></td>
					</tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=arrOthBankDataCol.get(1)%>
							</td>
					</tr>
					<%}else if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("OD"))){%>
						<tr height="25" >
						<td align="right">&nbsp;</td>
					</tr>
						<tr height="25">
						<td align="right" nowrap="nowrap"><%=arrOthBankDataCol.get(1)%>
							</td>
					</tr>
						<% }}
					}%>
					<%
					if(arrBankPropRow!=null && arrBankPropRow.size()>0){%>
					<tr height="25" >
						<td align="right">&nbsp;</td>
					</tr>
						<% 
						//arrBankPropEmiDataRow = (ArrayList)hshDSS.get("arrBankPropEmiDataRow"+i+0);
						//out.println("arrBankPropEmiDataRow====="+arrBankPropEmiDataRow);
						for(int b=0;b<arrBankPropRow.size();b++){
							arrBankPropEmiDataRow = (ArrayList)hshDSS.get("arrBankPropEmiDataRow"+i+b);
							arrBankPropEmiDataCol = (ArrayList)arrBankPropEmiDataRow.get(0);							
							%>
					<tr height="25">
						<td align="right">&nbsp;</td>
					</tr>
										
					<%if( (Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("E"))){ 
						totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(0)));
					%>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(0))))%></td>
					</tr>
					<%}else if( (Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("TL")) && (!Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase("E")) && (!Helper.correctNull((String)arrBankPropEmiDataCol.get(3)).equalsIgnoreCase(""))){
						totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(0)));
						totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(1)));
						%>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(0))))%></td>
					</tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=arrBankPropEmiDataCol.get(1)%></td>
					</tr>
					<%}else if(Helper.correctNull((String)arrBankPropEmiDataCol.get(2)).equalsIgnoreCase("OD")){
						totalValue1 = totalValue1 + Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(1)));
						%>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrBankPropEmiDataCol.get(1))))%></td>
					</tr>
					<%}}}
					hshForProposed.put("Total"+i,Double.toString(totalValue1));
					%>
	                 
					<tr height="25">
					    <%
					    if(hshForProposed.size()>0 && hshForProposed!=null)
					    {					    	
					    %>					  
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshForProposed.get("Total"+i))))%></td>
						<%}%>											  
					</tr>
					    <%
					    dblNetIncome = Double.parseDouble(Helper.correctDouble((String)hshForCalc.get("Netincome"+i)));
					    dblOtherIncome = Double.parseDouble(Helper.correctDouble((String)hshForCalc.get("OtherIncome"+i)));
					    dblTotIncome = Double.parseDouble(Helper.correctDouble((String)hshForProposed.get("Total"+i)));
					    dblNetsurplus = dblNetIncome - dblTotIncome;%>
					    <tr height="25">					   
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(dblNetsurplus)%></td>
					</tr>
					    <%
					    if(dblNetsurplus<0)
					    {
					    	dblNetsurplus=0;
					    }
					    if((dblNetIncome+dblOtherIncome)>0)
					    {
					    	dblPerSurplus =((dblNetsurplus+dblOtherIncome)/(dblNetIncome+dblOtherIncome))*100;
					    }
					    else
					    {
					    	dblPerSurplus =0.00;
					    }
					    if(dblNetIncome>0)
					    {
					    	dblPerFarmSurplus =((dblNetsurplus)/(dblNetIncome))*100;
					    }
					    else
					    {
					    	dblPerFarmSurplus =0.00;
					    }
					    dblAverageVal = dblAverageVal + dblPerSurplus;
					    %>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(dblPerFarmSurplus)%></td>
					</tr>
					<tr  height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(dblPerSurplus)%></td>
					</tr>					
				</table>
				</div>
				</td>
				<%
					}%>
					</tr>
			<tr height="25">
				<td align="left"  width="25%">&nbsp;<b>Average % of Net Surplus :</b></td>
				<td align="right" colspan='<%=arraySizeDSS%>'><%=Helper.formatDoubleValue((dblAverageVal/arraySizeDSS))%></td>
			</tr>
			
			</table>
		</td>
	</tr>
		<% 
		sizeyearval=sizeyearval-5;
		p=p+5;
		if(sizeyearval>5)
		{
			t=t+5;
		}
		else
		{
			t=t+sizeyearval;
		}
			}} %>
		
	<%if(!Helper.correctNull((String)hshValues.get("cmt_commentsassdss")).equalsIgnoreCase("")){ %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("cmt_commentsassdss"))%></td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<%} %>
 	<%if(arrRowIntSub != null && arrRowIntSub.size() > 0){ %>
 	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td class="title"><br>Interest Subvention Details:</td>
	 		<td align="right">&nbsp;</td>
	 		</tr>
 		</table>
 		</td>
 	</tr> 
 	<tr>
 		<td>
 		<table width="95%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td>&nbsp;</td>
	 		<td align="right"><%=strValuesIn%></td>
	 		</tr>
 		</table>
 		</td>
 	</tr>  		   		  
 	<tr>
		<td>
		 <div id="top">
			<table width="95%" border="0" cellspacing="0" cellpadding="3">
				<tr>
	               <td align="center" rowspan="2" width="15%"><b>Year</b></td>
	               <td align="center" rowspan="2" width="15%"><b>Limit Sanctioned</b> </td>
	               <td align="center" colspan="2" width="35%"><b>Sub limit as per SOF and post harvest expenses eligible for interest subvention</b></td>
	               <td align="center" colspan="2" width="35%"><b>Sub limit for ineligible amount for interest subvention</b></td>
	            </tr>
	            <tr>
                   <td align="center"><b>Amount</b></td>
                   <td align="center"><b>ROI %</b></td>
                   <td align="center"><b>Amount</b></td>
                   <td align="center"><b>ROI %</b></td>
                </tr>
                <tr>
                   <td align="center">I Year<input type="hidden" name="txt_year" value="I Year"></td>
                   <%if (arrRowIntSub != null && arrRowIntSub.size() > 0) {%>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrColIntSub.get(0)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrColIntSub.get(3)))%></td>
                   <td align="right"><%=nf.format(Double.parseDouble(maxROI))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrColIntSub.get(5)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrColIntSub.get(6)))%></td>
                   <%}%>
                </tr>
                <tr>
                   <td align="center">II Year<input type="hidden" name="txt_year" value="II Year"></td>
                   <%if (arrRowIntSub != null && arrRowIntSub.size() > 0) {%>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1IntSub.get(0)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1IntSub.get(3)))%></td>
                   <td align="right"><%=nf.format(Double.parseDouble(maxROI))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1IntSub.get(5)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol1IntSub.get(6)))%></td>
                   <%}%>                   
                </tr>
                <tr>
                   <td align="center">III Year<input type="hidden" name="txt_year" value="III Year"></td>
                   <%if (arrRowIntSub != null && arrRowIntSub.size() > 0) {%>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2IntSub.get(0)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2IntSub.get(3)))%></td>
                   <td align="right"><%=nf.format(Double.parseDouble(maxROI))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2IntSub.get(5)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol2IntSub.get(6)))%></td>
                   <%}%>                   
                </tr>
                <tr>
                   <td align="center">IV Year<input type="hidden" name="txt_year" value="IV Year"></td>
                   <%if (arrRowIntSub != null && arrRowIntSub.size() > 0) {%>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3IntSub.get(0)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3IntSub.get(3)))%></td>
                   <td align="right"><%=nf.format(Double.parseDouble(maxROI))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3IntSub.get(5)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol3IntSub.get(6)))%></td>
                   <%}%>                  
                </tr>
                <tr>
                   <td align="center">V Year<input type="hidden" name="txt_year" value="V Year"></td>
                   <%if (arrRowIntSub != null && arrRowIntSub.size() > 0) {%>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4IntSub.get(0)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4IntSub.get(3)))%></td>
                   <td align="right"><%=nf.format(Double.parseDouble(maxROI))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4IntSub.get(5)))%></td>
                   <td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol4IntSub.get(6)))%></td>
                   <%}%>                   
                </tr>
			</table>
			</div>
		</td>
	</tr>
	<%} %>
		

	
	
	
