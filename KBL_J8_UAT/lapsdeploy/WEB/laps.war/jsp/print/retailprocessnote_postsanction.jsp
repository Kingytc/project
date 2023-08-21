<%@include file="../share/directives.jsp"%>


<%
String strProcessDate=Helper.correctNull((String)hshValues.get("app_processdate"));
if(strProcessDate.equalsIgnoreCase(""))
	strProcessDate=Helper.getCurrentDateTime();
long lngDatediff=Helper.dateDiff(ApplicationParams.getStrRetailTCEffectDate(),strProcessDate);
	int i=1;
    int k=0;
	String strTakeover = Helper.correctNull((String)hshValues.get("strtake"));
	String strEmpStatus = Helper.correctNull((String)hshValues.get("empemployment"));
	HashMap hshResult=new HashMap();
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrayCol=new ArrayList();
	ArrayList arrAppLiabRow=new ArrayList();
	ArrayList arrAppLiabCol=new ArrayList();
	ArrayList arrJAppLiabRow=new ArrayList();
	ArrayList arrJAppLiabCol=new ArrayList();
	ArrayList arrGuarLiabRow=new ArrayList();
	ArrayList arrGuarLiabCol=new ArrayList();
	ArrayList arrOthrbnkRow=new ArrayList();
	ArrayList arrOthrbnkCol=new ArrayList();
	ArrayList arrIncAssessmentData = new ArrayList();
	ArrayList arrAssessmentData = new ArrayList();
	ArrayList arrAssessmentDisp = new ArrayList();
	ArrayList arrIncAssessmentDisp = new ArrayList();
	ArrayList arrayRow=new ArrayList();
	ArrayList arrayRow1=new ArrayList();
	ArrayList arrROI=new ArrayList();
	
	String strSessionModuleType="AGR";
	//System.out.println("hshValues retail ==> " + hshValues);
	HashMap hshFarm=new HashMap();
	ArrayList arrRow1 = new ArrayList();
	ArrayList arrCol1 = new ArrayList();
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
	ArrayList arrRowTotPer = new ArrayList();
	ArrayList arrGurdetails = new ArrayList();
	ArrayList arrProperitierdetailsRow = new ArrayList();
	int facTenor=0;
	ArrayList arrDeleRow=(ArrayList)hshValues.get("arrDelRow");
	ArrayList arrSecLegal=(ArrayList)hshValues.get("arrSecLegal");
if(hshValues!=null)
{
	hshFarm = (HashMap) hshValues.get("hshFarm");
	if(hshFarm!=null)
	{
		arrRow1 = (ArrayList)hshFarm.get("arrRow");
		arrRowP = (ArrayList)hshFarm.get("arrRowP");
		arrRowTotPer = (ArrayList)hshFarm.get("arrRowTot");
		arrRowInc = (ArrayList)hshFarm.get("arrRowInc");
		arrRowFac = (ArrayList)hshFarm.get("arrRowFac");
		arrPHRow = (ArrayList)hshFarm.get("arrPHRow");
		arrRowTot = (ArrayList)hshFarm.get("arrFBtotRow");
		facTenor=Integer.parseInt(Helper.correctInt((String)hshFarm.get("facTenor")));
	}
}
int arraySize=0;
if(arrRow!=null)
{
   arraySize=arrRow.size();
}
	if(hshValues!=null){
	arrRow = (ArrayList) hshValues.get("arrRow");
	arrayRow = (ArrayList) hshValues.get("arrayRow");
	arrayRow1 = (ArrayList) hshValues.get("arrayRow1");
	arrAppLiabRow = (ArrayList) hshValues.get("arrFacRow");
	arrJAppLiabRow = (ArrayList) hshValues.get("arrJAFacRow");
	arrGuarLiabRow = (ArrayList) hshValues.get("arrGuarLiabRow");
	arrOthrbnkRow = (ArrayList) hshValues.get("arrOthrbnkRow");
	arrGurdetails=(ArrayList)hshValues.get("arrGuardetailsRow");
	arrProperitierdetailsRow=(ArrayList)hshValues.get("arrProperitierdetailsRow");
	hshResult=(HashMap)hshValues.get("hshResult");
	arrROI= (ArrayList) hshValues.get("arrROI");
	}
	HashMap hshIncAssessmentValues = new HashMap();
	if(hshResult!=null&&hshResult.size()>0)
	{
		if (hshResult.get("hshInc") != null) 
		{
			hshIncAssessmentValues = (HashMap) hshResult.get("hshInc");
		}
		if (hshIncAssessmentValues.get("arrIncAssessment") != null) 
		{
			arrIncAssessmentData = (ArrayList) hshIncAssessmentValues.get("arrIncAssessment");
		}
		if (hshResult.get("arrAssessment") != null) 
		{
			arrAssessmentData = (ArrayList) hshResult.get("arrAssessment");
		}
	}
	int intarrSize1=0;
	if(arrRow!=null)
	{
		intarrSize1=arrRow.size();
	}
	
		ArrayList arrEligCol=new ArrayList();
		ArrayList arrApptypeCol=new ArrayList();
		String eligible="";
		String strPrdtype = Helper.correctNull((String)hshValues.get("prd_type"));
		String schemeCode = Helper.correctNull((String) session.getAttribute("schemeCode"));
		
		HashMap hshRepayment= new HashMap();
		ArrayList arrRepayCapacityData = new ArrayList();
		ArrayList arrRepayCapacityDisp = new ArrayList();
		if(hshValues!=null)
		{
			hshRepayment = (HashMap)hshValues.get("hshRepayment");
			if(hshRepayment!=null)
			{
				if (hshRepayment.get("arrRepayCapacity") != null) 
				{
					arrRepayCapacityData = (ArrayList) hshRepayment.get("arrRepayCapacity");
				}
			}
			
		}
		String strRepayType = Helper.correctNull((String)hshValues.get("loan_repaymenttype"));
		String prd_purpose=Helper.correctNull((String)hshValues.get("prd_purpose"));
		String Staffproduct=Helper.correctNull((String)hshValues.get("staffproduct"));
		//String Employmentstatus=Helper.correctNull((String)hshValues.get("strNewEmployment"));
		String Employmentstatus=Helper.correctNull((String) session.getAttribute("perapp_employment"));
		if(Employmentstatus.equalsIgnoreCase(""))
			Employmentstatus=Helper.correctNull((String)hshValues.get("perapp_employment"));
		String strPrimaryComments = Helper.correctNull((String)hshValues.get("cmt_retailprimarycomments")).trim();
		String strCollateralComments = Helper.correctNull((String)hshValues.get("cmt_retailcollateralcomments")).trim();
		String strSchemeCode=Helper.correctNull((String) session.getAttribute("schemeCode"));
		HashMap hshSecdetail=new HashMap();
		hshSecdetail=(HashMap)hshValues.get("hshsecdet1");
		HashMap hshFinValues=(HashMap)hshValues.get("DSCRhshFinValues");
		
		HashMap hshDSS = new HashMap();
		HashMap hshForCalc = new HashMap();
		HashMap hshForExist = new HashMap();
		HashMap hshForProposed = new HashMap();
		
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
		double dblAverageVal = 0.00;
		double dblNetIncome = 0.00;
		double dblOtherIncome = 0.00;
		double dblTotIncome = 0.00;
		double dblNetsurplus = 0.00;
		double dblPerFarmSurplus = 0.00;
		double dblPerSurplus = 0.00;
		
		ArrayList arrRBIGuidliness=new ArrayList();
		ArrayList arrRepaySchedule=new ArrayList();
		arrRBIGuidliness=(ArrayList)hshValues.get("arrRBIGuidliness");
		arrRepaySchedule = (ArrayList)hshValues.get("arrRepaySchedule");
		
		String secValue="";
		ArrayList arrpropsecurityRow=new ArrayList();
		ArrayList arrpropsecCollRow=new ArrayList();
		ArrayList arrpropsecurityCol=new ArrayList();
		ArrayList arrpropsecurity=new ArrayList();
		arrpropsecurityRow=(ArrayList)hshValues.get("arrRowPri");
		arrpropsecCollRow=(ArrayList)hshValues.get("arrRowColl");
		ArrayList arrGroupInfo=new ArrayList();
		arrGroupInfo=(ArrayList)hshValues.get("arrGroupInfo");
		
		ArrayList arrAppBasicInfo=new ArrayList();
		arrAppBasicInfo=(ArrayList)hshValues.get("arrAppBasicInfo");
		String strTemp="";
		int intTemp=0;
		String strAmountForm=Helper.correctNull((String)request.getParameter("strAmountVal"));
		String strAmountVal="Rs.";
		if(strAmountForm.equalsIgnoreCase("L"))
			strAmountVal="Lakhs";
		else if(strAmountForm.equalsIgnoreCase("C"))
			strAmountVal="Crores";
	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
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
<title>Process Note</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>

<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center">
  <tr>
		<td>
		
      <table width="100%" border="0" cellpadding="3" cellspacing="0"  align="center">
	        <tr><td>
	            <table width="100%" border="0" align="center" cellpadding="3"
						cellspacing="0">
	              <tr> 
	                <td align="center" colspan="4"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	              </tr>
	              <tr align="center" > 
	                <td colspan="4"> 
	                 <b> Branch&nbsp;/&nbsp;Office:&nbsp;<%=Helper.correctNull((String) session.getAttribute("strOrgName"))%></b> 
	                </td>
	              </tr>
	            </table>
			</td></tr>
			
			<tr><td>
			<div id="top">
				    <table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    	<tr>
				    		<td width="16%"><b>Proposal ID</b></td>
				    		<td width="16%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strApplicationNo"))%></td>
				    		<td width="16%"><b>Proposal Type</b></td>
				    		<td width="20%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strAppType"))%></td>
				    		<td width="16%"><b>Borrower ID</b></td>
				    		<td width="16%">&nbsp;<%=Helper.correctNull((String) hshValues.get("cbsid"))%></td>
				    	</tr>
					</table>
					</div>
			</td></tr>
			
			<tr><td>
				<div id="top">
				    <table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
						
						<tr>
				    		<td width="16%"><b>Branch:</b></td>
				    		<td width="32%">&nbsp;<%=Helper.correctNull((String)hshValues.get("homebranch"))%></td>
				    		<td width="16%"><b>Region:</b></td>
				    		<td width="52%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strOrgRegionName"))%></td>
				    	</tr>
					</table>
					</div>
			</td></tr>
			
			<tr><td>
			<div id="top">
				    <table width="100%" border="0" align="right" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    	<tr>
				    		<td width="32%"><b>Date Of Credit Application</b></td>
				    		<td width="16%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strAppReceivedDate"))%></td>
				    		<td width="32%"><b>Date of Receipt @ CLPU</b></td>
				    		<td width="20%">&nbsp;<%=Helper.correctNull((String)hshValues.get("clpudate"))%></td>
				    	</tr>
						<tr>
							<td><b>Date of receipt of complete information @ CLPU</b></td>
				    		<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("app_clpudate"))%></td>
				    		<td><b>Date of receipt of complete information @ CPC</b></td>
				    		<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("app_cpcdate"))%></td>
				    	</tr>
					</table>
					</div>
			</td></tr>
			<tr>
				<td>
					<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    	<tr><td colspan="4"><b>Reg:</b>&nbsp;<%=Helper.correctNull((String)hshValues.get("subject"))%></td></tr>
						<tr>
							<td width="3%"><b><%=i++%>.</b></td>
							<td width="27%"><b>(a) Sanctioning Authority</b></td>
							<td width="5%" align="center">:</td>
							<td width="65%">&nbsp;<%=Helper.correctNull((String)hshValues.get("sancauth"))%></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><b>(b) Sanctioned facility</b></td>
							<td width="10%" align="center">:</td>
							<td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
						</tr>
						
						<%if(Helper.correctNull((String)hshValues.get("strPageParam")).equalsIgnoreCase("")){ %>
			
			<tr>
			<td>&nbsp;</td>
			<td>&nbsp;<b>Post Sanction Request</b></td>
			</tr>
			
			<%String strTerms[]=Helper.correctNull((String)hshValues.get("strpostsancterms")).split("@");%>
			<tr>
			<td>&nbsp;</td>
			<td colspan="3">
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
					<tr class="tblhead" align="center">
						<td width="10%" >Sl. No</td>
						<td align="center" width="100%">Description</td>
						</tr>
			
			<%for(int z=0;z<strTerms.length;z++)
			{
				strTemp=strTerms[z];
				if(strTemp.equalsIgnoreCase("MRS")){strTemp="Modifications to Repayment Schedule without restructuring";}
				else if(strTemp.equalsIgnoreCase("SEC")){strTemp="Addition/Substitution/Release of security";}
				else if(strTemp.equalsIgnoreCase("MODSEC")){strTemp="Modification of security type (Prime /Collateral) and value / Change of security owner";}
				else if(strTemp.equalsIgnoreCase("CHBRANCH")){strTemp="Change of facility availing branch";}
				else if(strTemp.equalsIgnoreCase("DLA")){strTemp="Decrease of Limit amount";}
				else if(strTemp.equalsIgnoreCase("DLP")){strTemp="Decrease of loan period";}
				else if(strTemp.equalsIgnoreCase("MIS")){strTemp="Change in MIS details including RBI industry codes";}
				else if(strTemp.equalsIgnoreCase("MRI")){strTemp="Modification in Rate of Interest";}
				else if(strTemp.equalsIgnoreCase("SLILA")){strTemp="Increase in the sanction limit of Staff Housing Loan";}
				else if(strTemp.equalsIgnoreCase("GUAR")){strTemp="Addition/Deletion of Guarantor";}
				else if(strTemp.equalsIgnoreCase("BRTOMCLR")){strTemp="Migration from Base Rate/PLR to Other Reference Rate";}
				else if(strTemp.equalsIgnoreCase("COEX")){strTemp="Extension of Course period (Only for Education Loans)";}
				else if(strTemp.equalsIgnoreCase("MOEX")){strTemp="Extension of Moratorium taking into account spells of unemployment/under-employment (Only for Education Loans)";}
				else if(strTemp.equalsIgnoreCase("MISMOD")){strTemp="Miscellaneous changes / Modifications";}
				else if(strTemp.equalsIgnoreCase("CHDPOWER")){strTemp="Modification in Drawing Power Indicator";}
				else if(strTemp.equalsIgnoreCase("CHSCHEMECODE")){strTemp="Modifications in GL Sub head code and scheme code in CBS details";}%>
				
				<tr>
					<td align="center"><%=z+1 %>&nbsp;</td>
					<td><%=strTemp %>&nbsp;</td>
				</tr>		
			
			<%}%>
			</table>
			</td>
			</tr>
			<%} %>
					<tr>
						<td>&nbsp;</td>
						<td><b>(c) Applicant Details</b></td>
						<td align="center">:</td>
						<td>&nbsp;</td>
					</tr>
					</table>
				</td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
			<tr>
				<td width="25%"><b>Name of the Applicant</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("cus_name"))%></td>
			</tr>
			<tr>
				<td width="25%"><b>Communication Address</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_address1"))%><br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_address2"))%>&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_address3"))%><br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_district"))%>,&nbsp;<br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_city"))%>,&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_zip"))%><br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_state"))%>,&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_country"))%><br></td>
			</tr>
			<tr>
				<td width="25%"><b>Constitution</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strConstitution"))%></td>
			</tr>
			<tr>
				<td width="25%"><b>Nature of Business/Activity</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("per_occupation"))%></td>
			</tr>
			<tr>
				<td width="25%"><b><%=Helper.correctNull((String)hshValues.get("constlabel"))%></b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("cus_dob"))%></td>
			</tr>
			<tr>
				<td width="25%"><b>Dealing With us since</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strBankingSince"))%></td>
			</tr>
			<tr>
				<td width="25%"><b>Networth [In <%=strAmountVal %>]</b></td>
				<td width="25%">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strNetworth")),strAmountForm) %></td>
			</tr>
			<tr>
				<td width="25%"><b>Income as on Financial Year [In <%=strAmountVal %>]</b></td>
				<%if(Employmentstatus.equalsIgnoreCase("1")||Employmentstatus.equalsIgnoreCase("9")){ %>
				<td width="25%">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("perinc_yearsalary")),strAmountForm) %></td>
				<%}else{ %>
				<td width="25%">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("perinc_year1_income")),strAmountForm) %>  -  <%=Helper.correctNull((String)hshValues.get("perinc_yearend1")) %></td>
				<%} %>
			</tr>
			</table>
			</div>
			</td></tr>
			<tr><td><b>Brief Background of the Applicant</b></td></tr>
			<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("brief_history"))%></td></tr>
			
			<!--  Management People Details Need to Add here-->
			<%if(!Helper.correctNull((String)hshValues.get("strConstCode")).equalsIgnoreCase("01")){ %>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;Management People Details</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr class="tblhead">
				<td width="20%" align="center"><b>Relationship with firm</b></td>
				<td width="20%" align="center"><b>Concern Name</b></td>
				<td width="20%" align="center"><b>Communication Address</b></td>
				<td width="20%" align="center"><b>Constitution</b></td>
				<td width="20%" align="center"><b>Nature of Business /<br>Activity</b></td>
				<td width="10%" align="center"><b>Date Of Establishment/<br>Date of Birth</b></td>
				<td width="10%" align="center" nowrap="nowrap"><b>Income </td>
				<td width="10%" align="center" nowrap="nowrap"><b>Networth </td>
			</tr>
			<%if(arrGroupInfo!=null && arrGroupInfo.size()>0){ 
			for(int j=0;j<arrGroupInfo.size();j++){
			arrCol=(ArrayList)arrGroupInfo.get(j);%>
			<tr>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(2)) %>,
				<br><%=Helper.correctNull((String)arrCol.get(6)) %>,<%=Helper.correctNull((String)arrCol.get(3)) %>,
				<br><%=Helper.correctNull((String)arrCol.get(4)) %> - <%=Helper.correctNull((String)arrCol.get(5)) %>.</td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(9)) %></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(8)) %></td>
				<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(11)) %></td>
				<%if(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("1") || Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("9")){ %>
				<td align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(7)) %></td>
				<%}else{ %>
				<td align="right">&nbsp;<%=Helper.correctNull((String)arrCol.get(12)) %></td>
				<%} %>
				<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(10)),strAmountForm) %></td>
			</tr>
			<%}}else{%>
			<tr>
				<td colspan="8" align="center">&nbsp; - No Record Found -</td>
			</tr>
			<%} %>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;(d) Joint Borrower Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="20%" align="center"><b>Name of the Borrower</b></td>
						<td width="20%" align="center"><b>Communication Address</b></td>
						<td width="20%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Nature of Business / Activity</b></td>
						<td width="20%" align="center"><b>Date of Establishment / Date of Birth</b></td>
						<td width="20%" align="center"><b>Relationship</td>
						<td width="20%" align="center"><b>Income</td>
						<td width="20%" align="center"><b>Networth</td>
					</tr>
					<%
					if(arrayRow!=null&&arrayRow.size()>0)
					{
						for(int j=0;j<arrayRow.size();j++)
						{
							arrayCol=(ArrayList)arrayRow.get(j);
					%>
					<tr>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(0))%></td>
						<td align="left"><%=Helper.correctNull((String)arrayCol.get(1))%>&nbsp;</td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(2))%>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String)arrayCol.get(3))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(4))%>&nbsp;</td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(5))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper.correctDouble((String)arrayCol.get(7))%>&nbsp;</td>					
						<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)arrayCol.get(6)),strAmountForm)%>&nbsp;</td>					
					</tr>
					<%
						}
					}else{
					%>
					<tr><td colspan="8" align="center">&nbsp;- No Record Found -</td></tr>
					<%} %>
				</table>
			</div>
			</td></tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;e) Guarantor/Co-Obligant Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="20%" align="center"><b>Name of the Guarantor/Co-Obligant</b></td>
						<td width="20%" align="center"><b>Communication Address</b></td>
						<td width="20%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Nature of Business / Activity</b></td>
						<td width="20%" align="center"><b><%=Helper.correctNull((String)hshValues.get("constlabel"))%></b></td>
						<td width="20%" align="center"><b>Relationship</td>
						<td width="20%" align="center"><b>Income</td>
						<td width="20%" align="center"><b>Networth</td>
					</tr>
					<%
					if(arrGurdetails!=null&&arrGurdetails.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrGurdetails.size();j++)
						{
							arrayCol=(ArrayList)arrGurdetails.get(j);
					%>
					<tr>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(0))%></td>
						<td align="left"><%=Helper.correctNull((String)arrayCol.get(1))%>&nbsp;</td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(2))%>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String)arrayCol.get(3))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(4))%>&nbsp;</td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(5))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper.correctDouble((String)arrayCol.get(7))%>&nbsp;</td>					
						<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)arrayCol.get(6)),strAmountForm)%>&nbsp;</td>					
					</tr>
					<%
						}
					}else{
						%>
						<tr><td colspan="8" align="center">&nbsp;- No Record Found -</td></tr>
						<%} 
					%>
				</table>
			</div>
			</td></tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;<b>(f) Sole Proprietor Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="20%" align="center"><b>Name of the Proprietor</b></td>
						<td width="20%" align="center"><b>Communication Address</b></td>
						<td width="20%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Nature of Business / Activity</b></td>
						<td width="20%" align="center"><b><%=Helper.correctNull((String)hshValues.get("constlabel"))%></b></td>
						<td width="20%" align="center"><b>Relationship</td>
						<td width="20%" align="center"><b>Income </td>
						<td width="20%" align="center"><b>Networth</td>
					</tr>
					<%
					if(arrProperitierdetailsRow!=null&&arrProperitierdetailsRow.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrProperitierdetailsRow.size();j++)
						{
							arrayCol=(ArrayList)arrProperitierdetailsRow.get(j);
					%>
					<tr>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(0))%></td>
						<td align="left"><%=Helper.correctNull((String)arrayCol.get(1))%>&nbsp;</td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(2))%>&nbsp;</td>
						<td>&nbsp;<%=Helper.correctNull((String)arrayCol.get(3))%></td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(4))%>&nbsp;</td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(5))%>&nbsp;</td>
						<td align="right">&nbsp;<%=Helper.correctDouble((String)arrayCol.get(7))%>&nbsp;</td>					
						<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)arrayCol.get(6)),strAmountForm)%>&nbsp;</td>					
					</tr>
					<%
						}
					}else{
					%>
					<tr>
					<td colspan="8" align="center"> - Nil -</td>
					</tr>
					<%} %>
				</table>
			</div>
			</td></tr>
			<tr>
				<td>&nbsp;&nbsp;<b>(g) Basic Details :</b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="20%" align="center">&nbsp;</td>
						<td width="20%" align="center"><b>IT PAN</b></td>
						<td width="20%" align="center"><b>E-Mail ID</b></td>
						<td width="20%" align="center"><b>Mobile</td>
						<td width="20%" align="center"><b>Aadhar No</td>
					</tr>
					<%
					if(arrAppBasicInfo!=null && arrAppBasicInfo.size()>0){
						for(int j=0;j<arrAppBasicInfo.size();j++){
						arrCol=(ArrayList)arrAppBasicInfo.get(j);
						if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("a"))
						{strTemp="Applicant";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("c"))
						{strTemp="Co - Applicant";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("g"))
						{strTemp="Guarantor";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("o"))
						{strTemp="Co - Obligant";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("p"))
						{strTemp="Sole Properitier";}%>
					<tr>
						<td align="left" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %> - <%=strTemp%></td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>					
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>					
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>					
					</tr>
					<%}} 
					if(arrGroupInfo!=null && arrGroupInfo.size()>0){
						for(int j=0;j<arrGroupInfo.size();j++){
						arrCol=(ArrayList)arrGroupInfo.get(j);%>
						<tr>
						<td align="left" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %> - <%=Helper.correctNull((String)arrCol.get(0)) %></td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(16)) %></td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(15)) %>&nbsp;</td>					
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(14)) %>&nbsp;</td>					
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(18)) %>&nbsp;</td>					
					</tr>
					
					<%}} %>
				</table>
			</div>
			</td></tr>
		<%if(!Helper.correctNull((String)hshValues.get("backcomments")).equalsIgnoreCase("")){ %>
			<tr>
				<td><b><%=i++ %>.BACKGROUND OF APPLICANT/S:</b></td>
			</tr>
			<tr>
				<td><p>
				
				<%=Helper.correctNull((String)hshValues.get("backcomments"))%>
					</p></td>
			</tr>
			<%} %>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				 <%
				 String strNaturearr[]=null;
				 String strNaturearr1[]=null;
						if(arrAppLiabRow!=null&&arrAppLiabRow.size()>0)
						{
							for(int j=0;j<arrAppLiabRow.size();j++)
							{
								arrAppLiabCol=(ArrayList)arrAppLiabRow.get(j);
								strNaturearr = Helper.correctNull((String)arrAppLiabCol.get(1)).split("~");
								if(strNaturearr.length==1)
								{
									strNaturearr1[0]=strNaturearr[0];
									strNaturearr1[1]="0.00";
								}else if(strNaturearr.length==2)
								{
									strNaturearr1=strNaturearr;
								}else{
									strNaturearr1[0]="";
									strNaturearr1[1]="0.00";
								}
								if(j==0){
							
					%>
				 <tr>
				<td colspan="10"><span style="float:left"><b><%=i++%>. A) Existing Facilities of the applicant :</b></span><span style="float:right">(Amount in <%=strAmountVal %>)</span></td>
				</tr>
					<tr class="tblhead">
						<td width="15%" align="center"><b>Facility</b></td>
						<td width="15%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
						<td width="15%" align="center"><b>Limit</b></td>
						<td width="15%" align="center"><b>Sanction Ref No.</b></td>
						<td width="10%" align="center"><b>Outstanding balance</b></td>
						<td width="15%" align="center"><b>Present Status</b></td>
						<td width="15%" align="center"><b>Rate Of Interest (%)</b></td>
						<td width="15%" align="center"><b>EMI / Installment Amount </b></td>
						<td width="15%" align="center"><b>Due Date</b></td>
						<td width="15%" align="center"><b>Arrears if any</b></td>
					</tr>
					<%} %>
					<tr>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(5))%></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(0))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble(strNaturearr1[1]),strAmountForm)%></td>
						<td align="center"><%=Helper.correctNull((String)arrAppLiabCol.get(2))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrAppLiabCol.get(3)),strAmountForm)%></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(4))%></td>
						<td align="right"><%=Helper.correctDouble((String)arrAppLiabCol.get(6))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrAppLiabCol.get(7)),strAmountForm)%></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(8))%></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(9))%></td>
					</tr>
					<%
					
						}
						}
						
					%>
					
					    	
				</table>
			</div>
			</td></tr>
			<%if(arrAppLiabRow!=null&&arrAppLiabRow.size()>0)
			{ %>
			<tr>
			<td><b>Comment on Existing Credit Facilities :</b>
			</td>
			</tr>
			<tr>
			<td><%=Helper.correctNull((String)hshSecdetail.get("com_remarksExis")).trim()%></td>
			</tr>
			<%} %>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    		
				    			<%intTemp=0;
						if(arrJAppLiabRow!=null&&arrJAppLiabRow.size()>0)
						{
							for(int j=0;j<arrJAppLiabRow.size();j++)
							{
								arrJAppLiabCol=(ArrayList)arrJAppLiabRow.get(j);
								
								if(j==0){
					%>
				    	<tr>
				<td colspan="10"><span style="float:left"> <b><%=i++%>. A) Existing Facilities of the Joint applicants :</b></span><span style="float:right">(Amount in <%=strAmountVal %>)</span></td>
			</tr>	
				    		
					<tr class="tblhead">
						<td width="15%" align="center"><b>Nature of Facility</b></td>
						<td width="15%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
						<td width="15%" align="center"><b>Limit</b></td>
						<td width="15%" align="center"><b>Sanction Ref No.</b></td>
						<td width="10%" align="center"><b>Outstanding balance</b></td>
						<td width="15%" align="center"><b>Present Status</b></td>
						<td width="15%" align="center"><b>Rate Of Interest (%)</b></td>
						<td width="15%" align="center"><b>EMI / Installment Amount </b></td>
						<td width="15%" align="center"><b>Due Date</b></td>
						<td width="15%" align="center"><b>Arrears if any</b></td>
					</tr>
					<%}%>
				<%if(Helper.correctNull((String)arrJAppLiabCol.get(10)).equalsIgnoreCase("c")){
					intTemp++;%>
					<tr>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(5))%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(0))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrJAppLiabCol.get(1)),strAmountForm)%></td>
						<td align="center"><%=Helper.correctNull((String)arrJAppLiabCol.get(2))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrJAppLiabCol.get(3)),strAmountForm)%></td>
						
						<td><%=Helper.correctDouble((String)arrJAppLiabCol.get(4))%></td>
						<td align="right"><%=Helper.correctDouble((String)arrJAppLiabCol.get(6))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrJAppLiabCol.get(7)),strAmountForm)%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(8))%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(9))%></td>
					</tr>
					
					<%
				}}%>
				<%if(intTemp==0){ %>
					<tr><td colspan="10" align="center">No data found</td></tr>
					<%} %>
				<%}%>
				</table>
			</div>
			</td></tr>
			<%if(arrJAppLiabRow!=null&&arrJAppLiabRow.size()>0)
			{ %>
			<tr>
			<td><b>Comment on Existing Credit Facilities of Joint applicant/s :</b>
			</td>
			</tr>
			<tr>
			<td><%=Helper.correctNull((String)hshSecdetail.get("com_GroupConfac")).trim()%></td>
			</tr>
			<%} %>
			<tr>
				<td><b><span style="float: left;"><%=i++%>A.Other Bank Facilities of Applicant (if any):</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span> </b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="10%" align="center"><b>Sl. No</b></td>
					<td width="25%" align="center"><b>Bank Name</b></td>
					<td width="35%" align="center"><b>Type of Facility</b></td>
					<td width="15%" align="center"><b>Limit</b></td> 
					<td width="15%" align="center"><b>Outstanding Balance</b></td> 
					<td width="15%" align="center"><b>Rate Of Interest (%)</b></td> 
					<td width="15%" align="center"><b>EMI / Installment </b></td> 
					<td width="15%" align="center"><b>Due Date</b></td> 
					<td width="15%" align="center"><b>Arrears if any</b></td> 
					</tr>
					<%if(arrOthrbnkRow!=null && arrOthrbnkRow.size()>0){
					for(int g=0;g<arrOthrbnkRow.size();g++){
						arrOthrbnkCol = (ArrayList)arrOthrbnkRow.get(g);
					%>
					<tr>
					<td align="center"><%=g+1%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(0))%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(1))%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctNull((String)arrOthrbnkCol.get(2)))),strAmountForm)%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctNull((String)arrOthrbnkCol.get(3)))),strAmountForm)%>&nbsp;</td>
							<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(4))))%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(5)))),strAmountForm)%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(6))%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(7))%>&nbsp;</td>
					</tr>
					<%}}%>				    	
				</table>
			</div>
			</td></tr>
			<tr>
				<td><b><%=i-1%>B.Other Bank Comments: </b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr>
					<td align="center"><%=Helper.correctNull((String)hshValues.get("otherbnkcomments"))%>&nbsp;</td>
					</tr>				    	
				</table>
			</div>
			</td></tr>			
			<tr>
				<td><b><span style="float: left;"><%=i++%>.Present Proposal:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="5%" align="center"><b>Sl. No</b></td>
					<td width="15%" align="center"><b>Facility</b></td>
					<td width="15%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
					<td width="15%" align="center"><b>Limit</b></td>
					<td width="15%" align="center"><b>Period Sought</b></td>
					</tr>
					<tr>
					<td align="center">1.</td>
					<td><%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("LoanPurpose"))%></td>
					<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("Limit")),strAmountForm)%></td>
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("loan_noofinstallment"))%> months</td>
					</tr>				    	
				</table>
			</div>
			</td></tr>
			
			
			<%if(!Helper.correctNull((String)hshValues.get("GuarComments")).equalsIgnoreCase("")){ %>
			<tr>
				<td><b><%=i++%>.BACKGROUND OF Guarantor/S:</b></td>
			</tr>
			<tr>
				<td><%=Helper.correctNull((String)hshValues.get("GuarComments"))%></td>
			</tr>
			<%} %>
			
			<tr><td>
			<div id="top">
			
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				     <%intTemp=0;
						if(arrJAppLiabRow!=null&&arrJAppLiabRow.size()>0)
						{
							for(int j=0;j<arrJAppLiabRow.size();j++)
							{
								arrJAppLiabCol=(ArrayList)arrJAppLiabRow.get(j);
								
								if(j==0){
					%>
				    	<tr>
				<td colspan="10"><span style="float:left"> <b><%=i++%>.Existing Facilities of the Guarantor/Co-Obligant's :</b></span><span style="float:right">(Amount in <%=strAmountVal %>)</span></td>
			</tr>	
				    		
					<tr class="tblhead">
						<td width="15%" align="center"><b>Nature of Facility</b></td>
						<td width="15%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
						<td width="15%" align="center"><b>Limit</b></td>
						<td width="15%" align="center"><b>Sanction Ref No.</b></td>
						<td width="10%" align="center"><b>Outstanding balance</b></td>
						<td width="15%" align="center"><b>Present Status</b></td>
						<td width="15%" align="center"><b>Rate Of Interest (%)</b></td>
						<td width="15%" align="center"><b>EMI / Installment Amount</b></td>
						<td width="15%" align="center"><b>Due Date</b></td>
						<td width="15%" align="center"><b>Arrears if any</b></td>
					</tr>
					<%}%>
				<%if(Helper.correctNull((String)arrJAppLiabCol.get(10)).equalsIgnoreCase("g")||Helper.correctNull((String)arrJAppLiabCol.get(10)).equalsIgnoreCase("o")){
					intTemp++;%>
					<tr>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(5))%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(0))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrJAppLiabCol.get(1)),strAmountForm)%></td>
						<td align="center"><%=Helper.correctNull((String)arrJAppLiabCol.get(2))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrJAppLiabCol.get(3)),strAmountForm)%></td>
						
						<td><%=Helper.correctDouble((String)arrJAppLiabCol.get(4))%></td>
						<td align="right"><%=Helper.correctDouble((String)arrJAppLiabCol.get(6))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrJAppLiabCol.get(7)),strAmountForm)%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(8))%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(9))%></td>
					</tr>
					
					<%
				}%>
				<%}if(intTemp==0){%>
				<tr><td colspan="10" align="center">No data found</td></tr>
				<%}}%>
					
				</table>
			</div>
			</td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			
			<% if(strPrdtype.equalsIgnoreCase("pE")){ %>
			<tr>
			<td><b><%=i++%>. Education details:</b></td>
			</tr>
			<tr>
			<td>
			<jsp:include page="../print/per_educationdetails.jsp" flush="true"/>
			</td>
			</tr>
			<%} %>
			
			<tr>
			<td><b><%=i++%>. Security Details</b></td>
			</tr>
			<%
			if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
			<tr><td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr class="tblhead"><td colspan="4"><span style="float: left;">Attached Securities : </span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></td></tr>
			<tr>
			<td  align="center" width="20%"><b>Facility</b></td>
			<td  align="center" width="40%"><b>Details of Security</b></td>
			<td  align="center" width="10%"><b>Value</b></td>
			<td  align="center" width="25%"><b>Date of Valuation</b></td></tr>
			<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
			<tr align="left">
			<td colspan="4"><b>Prime :</b></td>
			</tr>
			<% 

			arrpropsecurityCol=new ArrayList();
			arrpropsecurity=new ArrayList();
			secValue = "";
			if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
				for(int a=0;a<arrpropsecurityRow.size();a++)
				{
					arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(a);
						  if(a==0) {
					%>
					<tr>
					<%if(arrpropsecurityRow.size()>2){ %>
					<td rowspan="<%=(arrpropsecurityRow.size())%>"><%=Helper.correctNull((String)arrpropsecurityCol.get(0)).toUpperCase()%></td>
					<%}else{ %>
					<td rowspan="2"><%=Helper.correctNull((String)arrpropsecurityCol.get(0)).toUpperCase()%></td>
					<%} %>
					</tr>
					<%} else {
					secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.converAmount(Helper.correctDouble((String)arrpropsecurityCol.get(1)),strAmountForm)));
					if(secValue.equals("0.00")) secValue=" ";
					%>
					<tr>
					 <td> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrpropsecurityCol.get(0)))%></td>
					 <td align="right"><%=secValue%></td>
					 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
					</tr>		
					<%	}
				}
			} }
			if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
			<tr>
			<td colspan="4" align="left"><b>Collateral:</b></td>
			</tr>
			<% 
			arrpropsecurityCol=new ArrayList();
			arrpropsecurity=new ArrayList();
			secValue = "";
			if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
				for(int a=0;a<arrpropsecCollRow.size();a++)
				{
					arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(a);
						secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.converAmount(Helper.correctDouble((String)arrpropsecurityCol.get(1)),strAmountForm)));
						if(secValue.equals("0.00")) secValue=" ";
						%>
						<tr>
						 <td colspan="2"> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrpropsecurityCol.get(0)))%></td>
						 <td align="right"><%=secValue%></td>
						 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
						</tr>		
						<%	 } }}
			%>
			</TABLE>
			</div><br>
			</td>
			</tr>
			<% }else{%>
			<tr><td><b><br>Attached Securities:</b> Nil</td></tr>
			<%} %>
			<tr>
			<td><b><%=i++%>.Comments on Securities :</b>
			</td>
			</tr>
			
			 <% if(!(strPrimaryComments.equals(""))) { %>
			<tr>
				<td align="left"><b>Prime: </b></td>
			</tr>
			<tr>
				<td>&nbsp;<%=strPrimaryComments%></td>
			</tr>
			<% } if(!(strCollateralComments.equals(""))) { %>
			<tr>
				<td align="left"><b>Collateral: </b></td>
			</tr>
			<tr>
				<td>&nbsp;<%=strCollateralComments%></td>
			</tr>
			<%} 
			if((strPrimaryComments.equals("")) && (strCollateralComments.equals(""))){ %>
			<tr>
				<td> - Nil -</td>
			</tr>
			<%} %>
			
			<tr>
			<td>
			<jsp:include page="../print/per_securitydetails.jsp" flush="true"/>
			</td>
			</tr>
			<%if(!Helper.correctNull((String) hshValues.get("SECURITY_COMMENTS")).equalsIgnoreCase("")){ %>
			 <tr>
			<td><b>Comments on Security Coverage:</b></td>
			</tr>
			<tr>
				<td>
				<div id="top">
					<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
						<tr>
						<td><%=Helper.correctNull((String) hshValues.get("SECURITY_COMMENTS"))%></td>
						</tr>				    	
					</table>
				</div>
				</td>
			</tr>
			<%} %>
			<%if(arrSecLegal!=null && arrSecLegal.size()>0){ 
				for (i = 0; i < arrSecLegal.size(); i++) {
					arrCol = (ArrayList) arrSecLegal.get(i);
			
			if(i==0){%>
			<tr class="tblhead">
			<td>
			Legal Opinion
			</td>
			</tr>
			<%} %>
			<tr class="tblhead">
			<td><%=i+1 %>&nbsp;<%=Helper.correctNull((String)arrCol.get(10)) %>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol.get(11)) %></td>
			</tr>
			<tr>
				<td><div id="top">
					<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
						<tr>	
							<td width="25%">Name of the panel Advocate</td>
							<%if(("2062").equalsIgnoreCase(Helper.correctNull((String)arrCol.get(16)))) {%>
							  <td width="25%"><%=Helper.correctNull((String)arrCol.get(0)) %> - <%=Helper.correctNull((String)arrCol.get(17)) %></td>
							<%}else{ %>
							<td width="25%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
							<%} %><td width="25%">Date</td>
							<td width="25%"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
						</tr>
						<tr><%String flowofvalue=Helper.correctNull((String)arrCol.get(5)) ;
						String ec=Helper.correctNull((String)arrCol.get(6));
						String Mortgage=Helper.correctNull((String)arrCol.get(8)) ;
						if(flowofvalue.equalsIgnoreCase("y")){
							flowofvalue="Yes";
							
						}
						else if(flowofvalue.equalsIgnoreCase("n")){
							flowofvalue="No";
							
						}else{
							flowofvalue=" ";
						}
						if(ec.equalsIgnoreCase("y")){
							ec="Yes";
							
						}
						else if(ec.equalsIgnoreCase("n")){
							ec="No";
							
						}
						else{
							ec=" ";
						}
						if(Mortgage.equalsIgnoreCase("E")){
							Mortgage="Equitable";
							
						}
						else if(Mortgage.equalsIgnoreCase("R")){
							Mortgage="Registered";
							
						}else if(Mortgage.equalsIgnoreCase("O")){
							Mortgage="Others";
							
						}%>	
							<td>Flow of Title for 30 years</td>
							<td><%=flowofvalue %></td>
							<td>EC for 14 Years obtained</td>
							<td><%=ec %></td>
						</tr>
						<tr>	
							<td>Latest Tax paid receipt</td>
							<td><%=Helper.correctNull((String)arrCol.get(7)) %></td>
							<td>Type of Mortgage recommended</td>
							<td><%=Mortgage %></td>
						</tr>
						
						<tr>	
							<td ><b>Elite Panel Advocate</b></td>
						<%if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("Y")){ %>
							 <td colspan="3">Yes</td>
							<%}else{ %>
							  <td colspan="3">No</td>
							<%} %>
						</tr>
						
						
						<tr class="tblhead">	
							<td colspan="4"><b>Comments</b></td>
						</tr>
						<tr>	
							<td colspan="4"><%=Helper.correctNull((String)arrCol.get(9))%></td>
						</tr>
						
						
						</table>
						</div>
					</td>
				</tr></br>
				<%} }%>
				<tr><td>&nbsp;</td></tr>
				<tr><td>
				<%if(strPrdtype.equalsIgnoreCase("pH")||strPrdtype.equalsIgnoreCase("pM")||strPrdtype.equalsIgnoreCase("pA")){ 
				ArrayList g1 = new ArrayList();
			ArrayList v = (ArrayList) hshValues.get("vecRow");
			if (v != null && v.size()>0) {%>
				<tr class="tblhead">
			<td colspan="5">
			Valuation Entry
			</td>
			</tr>
			<tr><td>
			<div id="top"><table width="100%">
			<tr class="tblhead">
			<td >Date of valuation</td>
			<td >Panel valuer name</td>
			<td >Market value of land & building</td>
			<td >Estimated value</td>
			<td >Details entered in remarks Column</td>
			</tr>
				<%}
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
					 <tr>
					 <td><%=Helper.correctNull((String)g1.get(13))%></td>
					 <td><%=Helper.correctNull((String)g1.get(15))%></td>
					 <td><%=Helper.correctNull((String)g1.get(6))%></td>
					 <td><%=Helper.correctNull((String)g1.get(8))%></td>
					 <td><%=Helper.correctNull((String)g1.get(9))%></td>
					 </tr>
					 
					<%}
													
			}%>
			</table>
			</div>
			</td></tr>
			<%} %>
						<%if(strPrdtype.equalsIgnoreCase("pH")){%>
			<tr>
			<td>
			<%if(("1").equals(Helper.correctNull((String) hshValues.get("LOAN_GOVT")))&& (("081").equals(Helper.correctNull((String) hshValues.get("GOVT_SCHEME"))) || ("080").equals(Helper.correctNull((String) hshValues.get("GOVT_SCHEME"))))){ %>
		<table width="100%" border="0" cellpadding="3" cellspacing="0"  align="center" class="outertable">		
						<tr>	<td><b><%=i++%>. Affordable Housing in Partnership Details</b><span style="float: right;">(Amount in <%=strAmountVal %>)</span></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="40%" align="center"><b>Particulars</b></td>	
					<td width="60%" align="center"><b>Details</b></td>			
					</tr>
					<tr>
					<td width="5%"><b>Whether allotment letter obtained from
				Co-operative Housing Society/Housing Board/ULB/KSDB</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_ALLOTMENT_LETTER"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Whether Income Certificate from revenue
				authority obtained</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_INCOME_CERTIFICATE"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Bank Name of the Implementing Agency</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_BANKNAME"))%>&nbsp; </td>			
					</tr>
					
					<tr>
					<td width="5%"><b>Branch Name of the Implementing Agency</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_BRANCHNAME"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Account Number of the Implementing Agency</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_ACCNUMBER"))%>&nbsp;</td>				
					</tr>	
					
					<tr>
					<td width="5%"><b>IFSC CODE</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_IFSCCODE"))%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="5%"><b>Total Cost of the Project (Amount in <%=strAmountVal %>)</b></td>
					<td width="25%" ><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_COSTLOANPRD")))),strAmountForm)%></td>  
		
					</tr>
					<tr>
					<td width="5%"><b>GOI subsidy amount (Amount in <%=strAmountVal %>)</b></td>
					<td width="25%" ><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_GOI_AMT")))),strAmountForm)%></td>  
		
					</tr>
					
					<tr>
					<td width="5%"><b>GOK subsidy amount(Amount in <%=strAmountVal %>)</b></td>
					<td width="25%" ><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_GOK_AMT")))),strAmountForm)%></td>  
					</tr>
					<tr>
					<td width="5%"><b>Present Accommodation</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_RESIDENT_TYPE"))%></td>
					</tr>
					<tr>
					<td width="5%"><b>Initial deposit or savings from the borrower (Amount in <%=strAmountVal %>)</b></td>
					<td width="25%"><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_SAVINGS")))),strAmountForm)%></td>  
					
					</tr>			    	
				</table>
		</div>
			</td></tr>		
		</table>
			</td>
			</tr>	
			<%} }%>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<tr>
			
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
			<tr class="tblhead">
			<td><b><%=i++%>. CERSAI Details:</b></td></tr>
			<%if(!Helper.correctNull((String)hshValues.get("CER_CERSAIDETAILS")).equalsIgnoreCase("")){ %>
			<tr>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("CER_CERSAIDETAILS")) %></td>
			</tr>
			<%}else{ %>
			<tr>
			<td align="center"> - Nil -</td>
			</tr>
			<%} %>
			</table>
			</div>
			</td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="4"><%=i++%>. MIS Details</td>
				    </tr>
					<tr class="tblhead">
					<td width="25%" align="center"><b>Descriptions</b></td>	
					<td width="25%" align="center"><b>Facility</b></td>
					<td width="25%" align="center"><b>Descriptions</b> </td>	
					<td width="25%" align="center"><b>Facility</b></td>				
					</tr>
					<tr>
					<td width="25%">Name of Bank Schematic Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc")) %></td>
					<td width="25%">Guarantee covered BY</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_Guarantee Covered")) %></td>				
					</tr>
					<tr>
					<td width="25%">Sector of Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sctortloan"))%></td>
					<td width="25%">Sub Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subscetroloan"))%></td>				
					</tr>
					<tr>
					<td width="25%">Weaker Section</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_weaksection"))%></td>
					<td width="25%">Sensitive Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sensitivitysec"))%></td>				
					</tr>
					<tr>
					<td width="25%">Industry Category Type</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_indcattyepagr"))%></td>
					<td width="25%">Infrastructure</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_infrastructure"))%></td>					
					</tr>
					<tr>
					<td width="25%">Activity Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_activitycode")) %></td>
					<td width="25%">Main Activity</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_mainactivitydesc")) %></td>					
					</tr>
					<tr>
					<td width="25%">Sub Activity</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subactdesc")) %></td>
					<td width="25%">Purpose</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_purpose")) %></td>					
					</tr>	
					<tr>
					<td width="25%">BSR Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsrcodedesc")) %></td>
					<td width="25%">BSR1 Code</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsr1codedesc")) %></td>					
					</tr>
					<%if(Helper.correctNull((String)hshValues.get("strisGovtScheme")).equalsIgnoreCase("1")){ %>
					<tr>
					<td width="25%" >Name of the Govt Sponsored</td>
					<td width="25%" colspan="3"><%=Helper.correctNull((String)hshValues.get("mis_govnysponser"))%></td>
					</tr>
					<%} %>	
					<tr>
					<%if(!Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Government announced scheme</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")) %></td>
					<%} %>
					<%if(!Helper.correctNull((String)hshValues.get("mis_StandupDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Stand Up India</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_StandupDesc")) %></td>		
					<%} %>			
					</tr>			    	
				</table>
			</div>
			</td></tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%String strrec=Helper.correctNull((String)hshValues.get("Recommendation"));
			
			
			if(!strrec.equalsIgnoreCase("")){ %>
			<tr>
			<td>
			<div id="top">
			<table width="100%"  border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
			<tr class="tblhead">
			
			<td><b><%=i++%>.RECOMMENDATION:</b></td></tr>
			<tr>
			<td style="text-align: justify">&nbsp;<%=Helper.correctNull((String)hshValues.get("Recommendation")) %></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<%  String strfacnature=Helper.correctNull((String)hshValues.get("facnature"));
			
			if(!strfacnature.equalsIgnoreCase("")){
			%>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="8"><b><span style="float: left;"><%=i++%>. Facility Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td></tr>
					<tr class="tblhead">
						<td width="5%" align="center">Sl. No</td>
						<td width="15%" align="center">Facility</td>
						<td width="15%" align="center">Limit</td>
						<td width="15%" align="center">Rate Of Interest</td>
						<td width="15%" align="center">Margin %</td>
						<td width="5%" align="center">Period</td>
						<td width="15%" align="center">Mode of repayment</td>	
						<td width="15%" align="center">Due Date</td>
					</tr>
					<tr>
					<td align="center">1.</td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("SancAmount")),strAmountForm)%>&nbsp;</td>
					<td align="center">&nbsp;
					<%if(Staffproduct.equalsIgnoreCase("Y")){ 
						if(strPrdtype.equalsIgnoreCase("pH"))
						{
							if(arrROI!=null && arrROI.size()>0)
							{
								for(int s=0;s<arrROI.size();s++)
								{
								arrCol=(ArrayList)arrROI.get(s);%>
								<%=Helper.correctDouble((String)arrCol.get(0)) %> - <%=Helper.correctDouble((String)arrCol.get(1)) %> in <%=Helper.correctDouble((String)arrCol.get(2)) %> %
								<br>
								<%}
							}
							else
							{%>
								<%=Helper.correctDouble((String)hshValues.get("ROI"))%>&nbsp; %
							<%}
						}
						else
						{ %>
							<%=Helper.correctNull((String)hshValues.get("strIntType"))%>&nbsp; - &nbsp;<%=Helper.correctDouble((String)hshValues.get("ROI"))%>&nbsp;%		
						<%}
						}else{ %>
					
					<%=Helper.correctDouble((String)hshValues.get("ROI"))%>&nbsp;%
					<%} %></td>
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Margin"))%>&nbsp;</td>
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Terms"))%>&nbsp;</td>		
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("repaytype"))%>&nbsp;</td>
					<td align="center"><%=Helper.correctNull((String)hshValues.get("strDueDate"))%>&nbsp;</td>
					</tr>				    	
				</table>
			</div>
			</td></tr>
			<%} %>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%if(!strPrdtype.equalsIgnoreCase("pG") && !strPrdtype.equalsIgnoreCase("pR"))
			{
				if(!(strRepayType.equalsIgnoreCase("1")) && !strRepayType.equalsIgnoreCase(""))
				{
				if(!(strSchemeCode.equalsIgnoreCase("OD")&& strPrdtype.equalsIgnoreCase("pM")))
				{
				if(arrRepaySchedule!=null && arrRepaySchedule.size()>0)
				{%>
			<tr><td>
			<div id="top">
			<table width="100%" cellpadding="3" cellspacing="0" border="0" align="center">
			<tr><td colspan="5"><span style="float: left;"><b>Repayment Schedule</b></span><span style="float: right;">[Amount in Rs.]</span></td></tr>					
			<tr class="tblhead">
			<td align="center" width="4%"><b>S.No</b></td>
			<td align="center" width="32%"><b>Frequency</b></td>
			<td align="center" width="20%"><b>No of Installments</b></td>
			<td align="center" width="20%"><b>Installment Amount</b></td>
			<td align="center" width="20%"><b>Total</b></td>
			</tr>
			<%
			String strFreq = "",strDesc="";
			
				for(int count = 0;count<arrRepaySchedule.size();count++)
				{					
			    arrEligCol = new ArrayList();
			    arrEligCol = (ArrayList)arrRepaySchedule.get(count);
			    strFreq = Helper.correctInt((String)arrEligCol.get(0));
			    if(strFreq.equalsIgnoreCase("m"))
	    		{
			    	strDesc = "Monthly";
	    		}					    
			    else if(strFreq.equalsIgnoreCase("q"))
	    		{
			    	strDesc = "Quarterly";
	    		}
			    else if(strFreq.equalsIgnoreCase("h"))
	    		{
			    	strDesc = "Half-Yearly";
	    		}
			    else if(strFreq.equalsIgnoreCase("y"))
	    		{
			    	strDesc = "yearly";
	    		}
			    else if(strFreq.equalsIgnoreCase("n"))
	    		{
			    	strDesc = "Not Applicable";
	    		}
			    %>
			    <tr>
			    <td><%=count+1%></td>
			    <td><%=strDesc%></td>
			    <td align="right"><%=Helper.correctInt((String)arrEligCol.get(1))%></td>
			     <td align="right"><%=Helper.correctInt((String)arrEligCol.get(3))%></td>
			    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrEligCol.get(2)))%></td>
			    </tr>						    						    					
			<%}%>
			<tr>
			    <td colspan="4" align="right"><b>Total :</b>&nbsp;&nbsp;</td>					    
			    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("RepaySheduleTotal")))%></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%String StrRepayComments = Helper.correctNull((String)hshValues.get("repaycomments"));
			if(!StrRepayComments.equalsIgnoreCase(""))
			{%>
				<tr><td>&nbsp;</td></tr>
			<tr><td>
			<div id="top">
			<table width="100%" cellpadding="3" cellspacing="0" border="0" align="center">
			<tr><td><b>Terms of Repayment</b></td></tr>
			<tr><td><%=StrRepayComments%></td></tr>
			</table>
			</div>
			</td></tr>
			<%}%>
			
			<%}}}} %>
			<table width="100%" cellpadding="3" cellspacing="0" border="0" align="center">		
			<tr><td><b>Post Sanction Recommendation</b></td></tr>
			<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("recommendations"))%></td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr>
				<td><b>Terms and Conditions:</b></td>
			</tr>
			</table>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			
			<tr>
				<td style="border: none;"><b>Specific Conditions:</b></td>
			</tr>
			<% 
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					k=1;
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("P")){
			%>

			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}%> 
			</table>
			</div>
			</td>
			</tr>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>Instructions to the branch:</b></td>
			</tr>
			
			<% 
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					k=1;
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("B")){
			%> 
			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
			</table>
			</div>
			</td>
			</tr>
			
			<%if(lngDatediff>=0){ %>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;">
				<b>Product based Terms & Conditions:</b>
				</td>
			</tr>
			
			<% 
					k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("S")){
			%>
			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
			</table>
			</div>
			</td>
			</tr>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>Other Conditions:</b></td>
			</tr>
			<% 
				k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("O")){
			%>

			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
			</table>
			</div>
			<%} %>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			
			<tr><td>
				<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
				if (arrDeleRow != null && arrDeleRow.size() > 0) {
				for (i = 0; i < arrDeleRow.size(); i++) {
				arrCol = (ArrayList) arrDeleRow.get(i);
				%>
				<%
				if (i % 2 == 0) {
				%>
				<tr><td align="left"><br><%=Helper.correctNull((String) arrCol.get(1))%></td></tr>
				<tr><td align="left" class="title"><%=Helper.correctNull((String) arrCol.get(4))%></td></tr>
				<%
				} else {
				%>
				<tr><td align="right"><br><%=Helper.correctNull((String) arrCol.get(1))%></td></tr>
				<tr><td align="right" class="title"><%=Helper.correctNull((String) arrCol.get(4))%></td></tr>
				<%
				}
				%>
				<%
				}
				}
				%>
			</table>
			</td></tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<br>
</body>
</html>
