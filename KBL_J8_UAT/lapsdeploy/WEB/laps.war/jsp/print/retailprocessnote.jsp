<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*;"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<html>

<%
//out.print(hshValues);
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
	ArrayList arrRowTerms = new ArrayList();
	ArrayList arrayCol=new ArrayList();
	ArrayList arrAppLiabRow=new ArrayList();
	ArrayList arrAppLiabCol=new ArrayList();
	ArrayList arrJAppLiabRow=new ArrayList();
	ArrayList arrCoAppLiabRow=new ArrayList();
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
	ArrayList arrRowprop= new ArrayList();
	ArrayList arrColprop= new ArrayList();
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
	ArrayList arrRepaySchedule=new ArrayList(); 
	ArrayList arrProperitierdetailsRow=new ArrayList(); 
	int facTenor=0;
	ArrayList arrDeleRow=(ArrayList)hshValues.get("arrPropFlow");
	ArrayList arrSecLegal=(ArrayList)hshValues.get("arrSecLegal");
	ArrayList arrCHRow=(ArrayList)hshValues.get("arrCHRow");
	
     	ArrayList arrCol12 = new ArrayList();
	    ArrayList arrRow12 = new ArrayList();
	    if (hshValues != null)
		arrRow12 = (ArrayList) hshValues.get("arrRow");
	
	
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
	arrCoAppLiabRow = (ArrayList) hshValues.get("arrCoAppLiabRow");
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
	
		ArrayList arrEligRow=new ArrayList();
		ArrayList arrEligCol=new ArrayList();
		ArrayList arrApptypeRow=new ArrayList();
		ArrayList arrApptypeCol=new ArrayList();
		ArrayList arrdefRow=new ArrayList();
		ArrayList arrdefCol=new ArrayList();
		HashMap hshEligdet= new HashMap();
		if(hshValues!=null&&hshValues.size()>0)
		{
			hshEligdet = (HashMap)hshValues.get("hshCheckElig");
			arrEligRow=(ArrayList)hshEligdet.get("arrRow");
			arrApptypeRow = (ArrayList)hshValues.get("arrApptypeRow");
			arrRepaySchedule = (ArrayList)hshValues.get("arrRepaySchedule");
			arrdefRow = (ArrayList)hshValues.get("arrdefRow");
			arrRowprop= (ArrayList)hshValues.get("arrRowprop");
		}
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
		String strPrimaryComments = Helper.correctNull((String)hshValues.get("cmt_retailprimarycomments")).trim();
		String strCollateralComments = Helper.correctNull((String)hshValues.get("cmt_retailcollateralcomments")).trim();
		String strSchemeCode=Helper.correctNull((String) session.getAttribute("schemeCode"));
		HashMap hshSecdetail=new HashMap();
		hshSecdetail=(HashMap)hshValues.get("hshsecdet1");
		//HashMap hshFinValues=(HashMap)hshValues.get("DSCRhshFinValues");
		
		//HashMap hshDSS = new HashMap();
		//HashMap hshForCalc = new HashMap();
		//HashMap hshForExist = new HashMap();
		//HashMap hshForProposed = new HashMap();
		
		//if (hshValues != null) {
			//hshDSS = (HashMap) hshValues.get("hshDSSData");
		//}
		//ArrayList arrRowDSS = new ArrayList();
		//ArrayList arrColDSS = new ArrayList();
		//ArrayList arrBankRow = new ArrayList();
		//ArrayList arrBankCol = new ArrayList();
		//ArrayList arrBankPropRow = new ArrayList();
		//ArrayList arrBankPropCol = new ArrayList();
		//ArrayList arrBankExisEmiDataRow = new ArrayList();
		//ArrayList arrBankExisEmiDataCol = new ArrayList();
		//ArrayList arrBankPropEmiDataRow = new ArrayList();
		//ArrayList arrBankPropEmiDataCol = new ArrayList();
		//ArrayList arrTotalAmountExisting = new ArrayList();
		//ArrayList arrTotalAmountProposed = new ArrayList();
		//ArrayList arrOthBankRow = new ArrayList();
		//ArrayList arrOthBankCol = new ArrayList();
		//ArrayList arrOthBankDataRow = new ArrayList();
		//ArrayList arrOthBankDataCol = new ArrayList();
		
		//if (hshDSS != null) {
			//arrRowDSS = (ArrayList) hshDSS.get("arrRow");
			//arrBankRow = (ArrayList) hshDSS.get("arrBankRow");
			//arrBankPropRow = (ArrayList) hshDSS.get("arrBankPropRow");
			//arrOthBankRow = (ArrayList) hshDSS.get("arrOthBankRow");
		//}
		//int arraySizeDSS = arrRowDSS.size();
		//double dblAverageVal = 0.00;
		//double dblNetIncome = 0.00;
		//double dblOtherIncome = 0.00;
		//double dblTotIncome = 0.00;
		//double dblNetsurplus = 0.00;
		//double dblPerFarmSurplus = 0.00;
		//double dblPerSurplus = 0.00;
		
		ArrayList arrRBIGuidliness=new ArrayList();
		arrRBIGuidliness=(ArrayList)hshValues.get("arrRBIGuidliness");
		
		
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
		
		String StrverCFR=Helper.correctNull((String)hshValues.get("VerifyWithCFR"));
		String StrNameCFR=Helper.correctNull((String)hshValues.get("NamApprCFR"));
		
		String strStatus=Helper.correctNull((String)hshValues.get("STATUS_VERIFIED"));
		
		String str_birflag=Helper.correctNull((String)hshValues.get("bir_flag"));
		
		strSessionModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
		String sessionModuleType=strSessionModuleType;
		String strtyoe=Helper.correctNull((String)hshValues.get("com_interest_refno"));
		String strRoiConcession= Helper.correctNull((String)hshValues.get("DIGI_DEVIATION_ROI_CONC"));
		String strRoiPenalty= Helper.correctNull((String)hshValues.get("DIGI_DEVIATION_ROI_PENALTY"));
		String prd_purpose1=Helper.correctNull((String) session
				.getAttribute("prd_purpose"));
		String PRD_STAFFPRD=Helper.correctNull((String)  session
				.getAttribute("PRD_STAFFPRD"));
		String APP_LOANSUBTYPE_DIGI=Helper.correctNull((String)  session
				.getAttribute("APP_LOANSUBTYPE_DIGI"));
		String strperemp=Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff"));
		ArrayList arrRowBor=new ArrayList();
		ArrayList arrColBor=new ArrayList();
			if(hshValues!=null)
			{
				arrRowBor = (ArrayList)hshValues.get("arrRowBor");
			}
			String strNil= "- Nil -";

	%>
<!--<html xmlns="http://www.w3.org/1999/xhtml">-->
<head>
<meta http-equiv="Content-Type" content="text/html;" />
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
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>

<body>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
		<td>
		
      <table width="90%" border="0" cellpadding="3" cellspacing="0"  align="center">
	        <tr><td>
	            <table width="100%" border="0" align="center" cellpadding="3"
						cellspacing="0">
	              <tr> 
	                <td align="center" colspan="4"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	              </tr>
	              <tr align="center" > 
	                <td colspan="4"> 
				<%if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("008")){ %>
				Credit LCFD
				<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("010")){ 
				String strComSancbranchcode=Helper.correctNull((String)hshValues.get("com_sancbranchcode"));
				if(strComSancbranchcode.equalsIgnoreCase("MCFD"))
					strComSancbranchcode="Credit MCFD";
				else
					strComSancbranchcode="Credit RFD";
				%>
				<%=strComSancbranchcode%>
				<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("013")){ %>
				Credit RFD
				<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("014")){ %>
				Credit MCFD
				<%}
				else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("015")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("016")
						||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("017")){%>
				<%=Helper.correctNull((String)hshValues.get("strSanctiondept"))%>
				<%}
				else{ %>
				Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull((String) session.getAttribute("strOrgName")).toUpperCase()%>
				<%}  %>
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
				    		<td width="16%"><b>Borrower ID</b></td>
				    		<td width="16%">&nbsp;<%=Helper.correctNull((String) hshValues.get("cbsid"))%></td>
				    		<td width="16%"><b>Proposal Type</b></td>
				    		<td width="20%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strAppType"))%></td>
				    	</tr>
				    	
				    	<tr>
				    		<td><b>Branch:</b></td>
				    		<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("homebranch"))%></td>
				    		<td><b>Region:</b></td>
				    		<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strOrgRegionName"))%></td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><b>Date Of Credit Application</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("strAppReceivedDate"))%></td>
				    	</tr>
				    	<%if(!Helper.correctNull((String)hshValues.get("clpudate")).equalsIgnoreCase("")){ %>
				    	<tr>
				    		<td colspan="2"><b>Date of receipt of Physical Loan papers @ CLPU</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("clpudate"))%></td>
				    	</tr>
				    	<%} %>
				    	<%if(!Helper.correctNull((String)hshValues.get("app_clpudate")).equalsIgnoreCase("")){ %>
						<tr>
							<td colspan="2"><b>Date of receipt of complete information @ CLPU</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("app_clpudate"))%></td>
				    	</tr>
				    	<%} %>
				    	<%if(!Helper.correctNull((String)hshValues.get("app_cpcdate")).equalsIgnoreCase("")){ %>
				    	<tr>
				    		<td colspan="2"><b>Date of receipt of complete information @ CPC/RO/HO</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("app_cpcdate"))%></td>
				    	</tr>
				    	<%} %>
				    	<%if(!Helper.correctNull((String)hshValues.get("APP_ROHODATE")).equalsIgnoreCase("")){ %>
				    	<tr>
				    		<td colspan="2"><b>Date of receipt @ RO/HO with Branch recommendations</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("APP_ROHODATE"))%></td>
				    	</tr>
				    	<%} %>
					</table>
					</div>
			</td></tr>
<!--			<tr><td align="center"><b>(Amount in Rupees)</b></td></tr>-->
			
			<tr>
				<td>
					<table>
						<tr>
							<td width="3%"><b><%=i++%>.</b></td>
							<td width="37%"><b>(a) Sanctioning Authority</b></td>
							<td width="10%" align="center">:</td>
							<td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("sancauth"))%></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="4">As per the Loan Application, the applicant has sought <b><%=Helper.correctNull((String)hshValues.get("INWARD_SCHEMEDESC"))%></b> of <%if(strAmountForm.equalsIgnoreCase("R")){ %>(<%=strAmountVal %>)<%} %>&nbsp;<b><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("INWARD_TERMLOANAMT")),strAmountForm)%> <%if(!strAmountForm.equalsIgnoreCase("R")){ %>(<%=strAmountVal %>)<%} %></b></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><b>(b) Purpose of credit facilities sought</b></td>
							<td width="10%" align="center">:</td>
							<td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%></td>
						</tr>
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
				<td width="25%"><b>
			<%if(Helper.correctNull((String) hshValues.get("residentType")).equals("N")) { %>	
				Communication Address
			<% } else { %>
				Permanent Address
			<% } %>
				</b></td>
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
				<td width="25%">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strNetworth")),strAmountForm)%></td>
			</tr>
			<tr>
				<td width="25%"><b>Income as on Financial Year [In <%=strAmountVal %>]</b></td>
				<%if(Employmentstatus.equalsIgnoreCase("1")||Employmentstatus.equalsIgnoreCase("9")){ %>
				<td width="25%">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("perinc_yearsalary")),strAmountForm) %></td>
				<%}else{ %>
				<td width="25%">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("perinc_year1_income")),strAmountForm) %>  -  <%=Helper.correctNull((String)hshValues.get("perinc_yearend1")) %></td>
				<%} %>
			</tr>
				<%if(Helper.correctNull((String) hshValues.get("APP_RENEW_FLAG")).equalsIgnoreCase("S")){%>
			<tr>
				<td width="25%"><b>Date of Restructure Invocation</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PERAPP_INVOCDATE"))%></td>
			</tr>
			<tr>
				<td width="25%"><b>Restructure Settlement Scheme</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strrestscheme"))%></td>
			</tr>
			<%} %>
			<%if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y")){ %>
			<tr>
				<td width="25%"><b>GSTIN No.</b></td>
				<%String[] strArr=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN")).split("@");
			%>
			<td align="left"><%
			for(int a=0;a<strArr.length;a++)
			{
			out.println(strArr[a]);%>
			</br/>
			<%}
			%></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("PERAPP_MSE_REGNO")).equalsIgnoreCase("")){%>
			<tr>
				<td width="25%"><b>MSME Reg No</b></td>
				<td width="25%"><%=Helper.correctNull((String)hshValues.get("PERAPP_MSE_REGNO")) %></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR")).equalsIgnoreCase("")){%>
			<tr>
				<td width="25%"><b>Udyog Aadhaar Number (12 Digits)</b></td>
				<td width="25%"><%=Helper.correctNull((String)hshValues.get("PERAPP_UDYOG_AADHAR")) %></td>
			</tr>
			<%} %>
		   <%if(!Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO")).equalsIgnoreCase("")){ %>
			<tr>
			<td align="left" ><b>Udyam Registration Certificate Number<b></td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("PERAPP_UDYAM_REGNO"))%></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE")).equalsIgnoreCase("")){ %>
			<tr>
			<td align="left" ><b>Udyam Certification Date<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("PERAPP_CERTIFICATION_DATE"))%></td>
			</tr>
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION")).equalsIgnoreCase("")){ %>
			<tr>
			<td align="left" ><b>MSME Classification as per Udyam Registration Certificate<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("PERAPP_MSME_CLASSIFICATION"))%></td>
			</tr>
			<%} %>
			
			<tr>
			<td align="left" ><b>Borrower status<b></td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("perapp_status"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Any relation to Bank Staff/Executive/Director<b> </td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff"))%></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("005")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("006")){ %>
			<tr>
			<td align="left" ><b>Staff ID <b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relat_staffid"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Staff Name<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%} else{%>
			<tr>
			<td align="left" ><b>Name of Bank's Director<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%}%>
			<tr>
			<td align="left" ><b>Relation to the borrower<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_blood_relation"))%></td>
			</tr>
			</table>
			<div><b>Benificial Owner Details :</b>
</div>
			<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowBor!=null&&arrRowBor.size()>0)
{
for(int l=0;l<arrRowBor.size();l++) {
	arrColBor	= (ArrayList)arrRowBor.get(l);
%>
<%if(l==0){ %>
<tr>
<td align="center">Beneficial Owner Customer ID</td>
<td align="center">Name of the Beneficial Owner</td>
<td align="center">Identification Document</td>
<td align="center">Identification Document Number<br/></td>
<td align="center">Percentage of Shares held</td>
<td align="center">Relationship with the borrower</td>
<td align="center">No of shares held</td>
<td align="center">Guarantee available</td>
</tr>
<%} %>
<tr>
<td><%=Helper.correctNull((String)arrColBor.get(0))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(1))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(2))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(3))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(4))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(5))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(6))%></td>
<td><%=Helper.correctNull((String)arrColBor.get(7))%></td>
</tr>
<%}%>
<%}else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
			
			</div>
			</td></tr>
			<%if(Helper.correctNull((String)hshValues.get("indinfo_is_staff")).equalsIgnoreCase("02")){ %>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;Staff Details</span><span style="float: right;"></span></b></td>
			</tr>
			
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr>
			<td align="left" ><b>Staff ID<b> </td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("indinfo_staff_id"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Department Name<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("peremp_department"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Date of Joining<b> </td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("indinfo_dateof_joining"))%></td>
			</tr>
			<tr>
			<td align="left" > <b>Retirement Date<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("peremp_retdate"))%></td>
			</tr>
			</table>
			</div>
			</td></tr>
			<%} %>
					
   <%if(Helper.correctNull((String)hshValues.get("retrestructureval")).equalsIgnoreCase("Y")) {%>
   <tr>
			<td>
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
<tr>
			<td>
			<div id="top">
			<table width="90%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
<tr class="tblhead" align="center">
				<td colspan="4"><b>&nbsp;&nbsp; Eligibility under Restructure:</b></td>
			</tr>
<tr>
<td align="left" >a.</td>
<td align="left"><b>Type of Borrower</b></td>

<td align="left" colspan="2"><%=Helper.correctNull((String)hshValues.get("strborrower"))%></td>

</tr>
<tr>
<td align="left">b.</td>
<td align="left"><b>Purpose of the Loan</b></td>
<td align="left" colspan="1"><%=Helper.correctNull((String)hshValues.get("strpurposeloan"))%></td>
<%if(Helper.correctNull((String)hshValues.get("COM_PURPOSE_OF_LOAN")).equalsIgnoreCase("3")){ %>
<td><%=Helper.correctNull((String)hshValues.get("stragriallied"))%></td>
<%}else{ %>
<td colspan="1"></td>
<%} %>
</tr>
		
				<tr>
					<td align="center" colspan="4" class="tblhead" ><b>RBI Parameters</b></td>
				</tr>
			
				<tr class="tblhead">
					<td ><b>S.No<b></td>
					<td ><b>Parameters under<b></td>
					<td><b>Instant Case<b></td>
					<td ><b>Eligible<b></td>
				</tr>
				<tr>
					<td>1.</td>
					<td nowrap="nowrap"><b>Permitted activities under Resolution Frame work</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strpermact"))%>
					<%  if(Helper.correctNull((String)hshValues.get("COM_PERM_ACT")).equalsIgnoreCase("6")){%><%="-"+Helper.correctNull((String)hshValues.get("COM_OTHER_LOAN"))%><%} %></td>
					<td><%=Helper.correctNull((String)hshValues.get("strpermactelig"))%></td>
				</tr>
				<tr>
					<td>2.</td>
					<td nowrap="nowrap"><b>Aggregate exposure across all Member Lending Institutions (MLIs) as on March 31,2021</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_EXPOSUE"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strexposueelig"))%></td>
				</tr>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")){%>
				<tr>
					<td id="val1">3.</td>
					<td nowrap="nowrap"><b>whether borrower availed Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strborroweravailed"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strborroweravailedelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")&& Helper.correctNull((String)hshValues.get("COM_BRW_AVAILED")).equalsIgnoreCase("Y")){%>
				<tr>
					<td nowrap="nowrap" id="val1">3.a)</td>
					<td nowrap="nowrap"><b>Previous Moratorium Granted</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_PREVIOUS_MOROTORIUM"))%></td>
<td></td>
				</tr>
				<tr>
					<td nowrap="nowrap">3.b)</td>
					<td nowrap="nowrap"><b>Already extended Due date in CBS</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_EXTENDED_DATE"))%></td>
					<td></td>
				</tr>
				<tr id="id_borrower3">
					<td nowrap="nowrap">3.c)</td>
					<td nowrap="nowrap"><b>Present Moratorium Granted</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("COM_PRESENT_MOROTORIUM"))%></td>
<td></td>
				</tr>
<%} %>


				<tr>
								<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("1")){%>
				
					<td id="val2">4.</td>
					<%}else{ %>
						<td id="val2">3.</td>
					<%} %>
					<td nowrap="nowrap" ><b>Whether GSTIN Registered<b></td>
					<%
					String strwhethergstrn=Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG"));
					if(strwhethergstrn.equalsIgnoreCase("Y")){
						strwhethergstrn="Yes";
					}else if(strwhethergstrn.equalsIgnoreCase("N")){
						strwhethergstrn="No";
					}else if (strwhethergstrn.equalsIgnoreCase("NA")){
						strwhethergstrn="Not Applicable";
					}else{
						strwhethergstrn="";
					}
					 %>
					 <td><%=strwhethergstrn %></td>
					 <td>&nbsp;</td>
					 </tr>
					 <tr>
											
						<%if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y")){ %>
											<td >a)</td>
						
						<td nowrap="nowrap" ><b> GSTIN <b></td>	
						<td>			
						<%
						String[] strArr1=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN")).split("@");
						for(int a=0;a<strArr1.length;a++)
						{
							%>
							
						<%=strArr1[a] %><br/>
									 
						<%} }else if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("N")){%>
						<td >a)</td>
						<td nowrap="nowrap" ><b>Whether GSTIN Exempted <b></td>				
						<td>
						<%String strexempted=Helper.correctNull((String)hshValues.get("COMINFO_GST_EXEMPTED"));
						if(strexempted.equalsIgnoreCase("Y")){
							strexempted="Yes";
							
						}else if(strexempted.equalsIgnoreCase("N")){
							strexempted="No";
						}else{
							strexempted="";
						}
						%>
						<%=strexempted%><br/>
						
						<%} else{%>
			        		
						
						<%} %>
						</td>
						<td></td>
				</tr>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("3")){%>
				<tr>
					<td id="val3">4.</td>
					<td nowrap="nowrap"><b>Restructure under earlier MSME Restructuring Schemes</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strmsmerestscheme"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strmsmerestschemeelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("2")){%>
				<tr>
					<td id="val4">4.</td>
					<td nowrap="nowrap"><b>Restructured under earlier Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strframework"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strframeworkelig"))%></td>
				</tr>
				<%} %>
				<% if(Helper.correctNull((String)hshValues.get("COM_TYPE_OF_BORROWER")).equalsIgnoreCase("4")){%>
				<tr>
					<td id="val4">4.</td>
					<td nowrap="nowrap"><b>Restructured under earlier Resolution Framework 1.0</b></td>
					<td><%=Helper.correctNull((String)hshValues.get("strrestallied"))%></td>
					<td><%=Helper.correctNull((String)hshValues.get("strrestalliedelig"))%></td>
				</tr>
				<%} %>
				</table>
			</div>
			</td></tr>
			</table>
			</td></tr>
<%} %>
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
				<td width="10%" align="center"><b>Concern Name</b></td>
				<td width="20%" align="center"><b>Communication Address</b></td>
				<td width="10%" align="center"><b>Constitution</b></td>
				<td width="10%" align="center"><b>Nature of Business /<br>Activity</b></td>
				<td width="10%" align="center"><b>Date Of Establishment/<br>Date of Birth</b></td>
				<td width="10%" align="center" nowrap="nowrap"><b>Income </td>
				<td width="10%" align="center" nowrap="nowrap"><b>Networth</td>
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
						<td width="10%" align="center"><b>Name of the Borrower</b></td>
						<td width="10%" align="center"><b>Communication Address</b></td>
						<td width="10%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Nature of Business / Activity</b></td>
						<td width="20%" align="center"><b>Date of Establishment / Date of Birth</b></td>
						<td width="10%" align="center"><b>Relationship</td>
						<td width="10%" align="center" nowrap="nowrap"><b>Income </td>
						<td width="10%" align="center" nowrap="nowrap"><b>Networth</td>
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
					<tr>
					<td colspan="8" align="center"> - Nil -</td>
					</tr>
					<%} %>
				</table>
			</div>
			</td></tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;(e) Guarantor/Co-Obligant Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="10%" align="center"><b>Name of the Guarantor/Co-Obligant</b></td>
						<td width="10%" align="center"><b>Communication Address</b></td>
						<td width="10%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Nature of Business / Activity</b></td>
						<td width="20%" align="center"><b>Date of Establishment / Date of Birth</b></td>
						<td width="10%" align="center"><b>Relationship</td>
						<td width="10%" align="center" nowrap="nowrap"><b>Income</td>
						<td width="10%" align="center" nowrap="nowrap"><b>Networth</td>
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
					<tr>
					<td colspan="8" align="center"> - Nil -</td>
					</tr>
					<%} %>
				</table>
			</div>
			</td></tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;(f) Sole Proprietor Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="10%" align="center"><b>Name of the Proprietor</b></td>
						<td width="10%" align="center"><b>Communication Address</b></td>
						<td width="10%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Nature of Business / Activity</b></td>
						<td width="20%" align="center"><b>Date of Establishment / Date of Birth</b></td>
						<td width="10%" align="center"><b>Relationship</td>
						<td width="10%" align="center" nowrap="nowrap"><b>Income</td>
						<td width="10%" align="center" nowrap="nowrap"><b>Networth</td>
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
						<td>&nbsp;<%=Helper.correctDouble((String)arrayCol.get(7))%>&nbsp;</td>					
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
						{strTemp="Co-Obligant";}
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
			<tr >
			<td><b>(h) CIBIL Details:</b></td></tr>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td width="5%" align="center">S.No</td>
			<td width="15%" align="center">Name</td>
			<td width="30%" align="center">Applicant Type</td>
			<td width="15%" align="center">Score</td>
			<td width="35%" align="center">Comments</td>
			</tr>
			<%
			if (arrApptypeRow != null && arrApptypeRow.size() > 0) 
			{
			for (int l=0; l < arrApptypeRow.size(); l++) 
			{
				arrApptypeCol = (ArrayList) arrApptypeRow.get(l);
			%>
			<tr>
			<td style="text-align:center"><%=l+1%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(0))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(1))%></td>
			<td align="right"><%=Helper.correctDouble((String)arrApptypeCol.get(2))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(3))%></td>
			</tr>
			<%}} %>
			</table>
			</div>
			</td>
			</tr>
			<tr>
			<td ><b>(i) CRILC Details :</b></td>
			</tr>
			<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
					<tr class="tblhead">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="15%">Applicant Type</td>
						<td align="center" width="20%">Whether Reported to CRILC?</td>
						<td align="center" width="15%">Reported Date</td>
						<td align="center" width="25%">Comments</td>
					</tr>
					
					<%	boolean bflag=true;
						int n=0;
						
						if (arrApptypeRow != null && arrApptypeRow.size() > 0) 
						{
						for (int l=0; l < arrApptypeRow.size(); l++) 
						{
							arrApptypeCol = (ArrayList) arrApptypeRow.get(l);
							bflag=false;
							n=n+1;
							%>
					
					<tr>
						<td width="5%" style="text-align:center"><%=n%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(0))%></td>
						<td width="15%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(1))%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(4))%></td>
						<td width="25%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(6))%></td>
						<td width="15%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(5))%></td>
					</tr>
					<%}}
						if(bflag)
						{%>			
					
					<tr>
						<td align="center" colspan="6">- No Record Found -</td>
					</tr>
					<%} %>
				</table>
			</div>
			</td>
			</tr>
			<tr>
			<td><b>(j) CRIF Details:</b></td>
			</tr>
			<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
					<tr class="tblhead">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="15%">Applicant Type</td>
						<td align="center" width="20%">Whether referred to CRIF ?</td>
						<td align="center" width="14%">CRIF Score</td>
						<td align="center" width="13%">Comments</td>
						<td align="center" width="13%">Report date</td>
					</tr>	
					
					
					<%	boolean bflag1=true;
						int r=0;
						
						if (arrApptypeRow != null && arrApptypeRow.size() > 0) 
						{
						for (int l=0; l < arrApptypeRow.size(); l++) 
						{
							arrApptypeCol = (ArrayList) arrApptypeRow.get(l);
							bflag1=false;
							r=r+1;
						%>
					
					<tr>
						<td width="5%" style="text-align:center"><%=r%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(0))%></td>
						<td width="15%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(1))%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(7))%></td>
						<td width="14%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(8))%></td>
						<td width="13%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(9))%></td>
						<td width="13%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(10))%></td>
					</tr>
								
					<%}}
						if(bflag1)
						{%>			
					
					<tr>
						<td align="center" colspan="7">- No Record Found -</td>
					</tr>
					<%} %>
					
				</table>
			</div>
			</td>
			</tr>
			
			<!--  added from hunter score  -->
			
				<tr>
			<td><b> Hunter Details:</b></td>
			</tr>
			<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
					<tr class="tblhead">
						<td align="center" width="5%">S.No</td>
						<td align="center" width="25%">Name</td>
						<td align="center" width="25%">Hunter Score</td>
					</tr>	
					
					
												<%
										 if(arrRow12!=null && arrRow12.size()>0){ 
											for(int m=0;m<arrRow12.size();m++){
											arrCol12=(ArrayList)arrRow12.get(m);
											%>
												<tr align="center" style="border-left:1px;" >
												
												<td><%=m+1 %></td>	
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
			<tr >
			<td><b>(k)&nbsp;Whether the name of the Applicant/Joint applicant/Coobligant/
						Guarantors/Proprietor/Partners/Directors is in the Defaulters list of RBI :</b></td></tr>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			
			<tr class="tblhead">
			<td width="5%" align="center">S.No</td>
			<td width="10%" align="center">Type of Applicant</td>
			<td width="30%" align="center">Name </td>
			<td width="10%" align="center">Defaulters list of RBI</td>
			<td width="10%" align="center">As On Date</td>
			<td width="35%" align="center">Comments</td>
			</tr>
			<%
			if (arrdefRow != null && arrdefRow.size() > 0) 
			{
			for (int i1=0; i1 < arrdefRow.size(); i1++) 
			{
				arrdefCol = (ArrayList) arrdefRow.get(i1);
			%>
			<tr>
			<td style="text-align:center"><%=i1+1%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(1))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(0))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(2))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(3))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(4))%></td>
			</tr>
			<%}} %>
			</table>
			</div>
			</td>
			</tr>
			<tr >
			<td ><b>(l)&nbsp;Whether in ECGCI specific approval list:</b></td></tr>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td width="5%" align="center">S.No</td>
			<td width="10%" align="center">Type of Applicant</td>
			<td width="30%" align="center">Name </td>
			<td width="10%" align="center">ECGCI Approval</td>
			<td width="10%" align="center">As On Date</td>
			<td width="35%" align="center">Comments</td>
			</tr>
			<%
			if (arrdefRow != null && arrdefRow.size() > 0) 
			{
			for (int i1=0; i1 < arrdefRow.size(); i1++) 
			{
				arrdefCol = (ArrayList) arrdefRow.get(i1);
			%>
			<tr>
			<td style="text-align:center"><%=i1+1%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(1))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(0))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(5))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(6))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(7))%></td>
			</tr>
			<%}} %>
			</table>
			</div>
			</td>
			</tr>
			<tr >
			<td ><b>(m)&nbsp;Whether suit filed , whether action initiated by other bank/financial institutions still pending:</b></td></tr>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			
			<tr class="tblhead">
			<td width="5%" align="center">S.No</td>
			<td width="10%" align="center">Type of Applicant</td>
			<td width="30%" align="center">Name </td>
			<td width="10%" align="center">Suit filed</td>
			<td width="35%" align="center">Comments</td>
			</tr>
			<%
			if (arrdefRow != null && arrdefRow.size() > 0) 
			{
			for (int i1=0; i1 < arrdefRow.size(); i1++) 
			{
				arrdefCol = (ArrayList) arrdefRow.get(i1);
			%>
			<tr>
			<td style="text-align:center"><%=i1+1%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(1))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(0))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(8))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrdefCol.get(9))%></td>
			</tr>
			<%}} %>
			</table>
			</div>
			</td>
			</tr>
			
			<tr>
			<td >&nbsp;</td>
			</tr>
		
			
		<%if(!Helper.correctNull((String)hshValues.get("backcomments")).equalsIgnoreCase("")){ %>
			<tr>
				<td><b><%=i++ %>.BACKGROUND OF APPLICANT/S:</b></td>
			</tr>
			<tr>
				<td><p>
				
				<%=Helper.correctNull((String)hshValues.get("backcomments"))%>
					</p> </td>
			</tr>
		<%} %>
		<%if(!Helper.correctNull((String)hshValues.get("backintercomments")).equalsIgnoreCase("") && strSessionModuleType.equals("DIGI")){ %>
			<tr>
				<td><b><%=i++ %>.Additional Information/Comments if any for Process Note:</b></td>
			</tr>
			<tr>
			<td><p>
				<%=Helper.correctNull((String)hshValues.get("backintercomments"))%>
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
				<td colspan="10"><b><span style="float:left"><%=i++%>. A) Existing Facilities of the applicant :</span><span style="float:right">(Amount in <%=strAmountVal %>)</span></b></td>
				</tr>
					<tr class="tblhead">
						<td width="10%" align="center"><b>Facility</b></td>
						<td width="10%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Limit </b></td>
						<td width="10%" align="center"><b>Sanction Ref No.</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Outstanding <br/> balance</b></td>
						<td width="10%" align="center"><b>Present Status</b></td>
						<td width="10%" align="center"><b>Rate Of Interest (%)</b></td>
						<td width="10%" align="center"><b>EMI / Installment Amount </b></td>
						<td width="10%" align="center"><b>Due Date</b></td>
						<td width="10%" align="center"><b>Arrears if any</b></td>
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
						<td align="right"><%if(Helper.correctDouble((String)arrAppLiabCol.get(7)).equalsIgnoreCase("0.00")){%>&nbsp;<%}else{%><%=Helper.converAmount(Helper.correctDouble((String)arrAppLiabCol.get(7)),strAmountForm)%><%} %></td>
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
			<td><b> B) Comment on Existing Credit Facilities :</b>
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
				<td colspan="10"><b><span style="float:left"> <%=i++%>. A) Existing Facilities of the Joint applicants :</span><span style="float:right">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>	
				    		
					<tr class="tblhead">
						<td width="10%" align="center"><b>Nature of Facility</b></td>
						<td width="10%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Limit </b></td>
						<td width="10%" align="center"><b>Sanction Ref No.</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Outstanding<br/>balance </b></td>
						<td width="10%" align="center"><b>Present Status</b></td>
						<td width="10%" align="center"><b>Rate Of Interest (%)</b></td>
						<td width="10%" align="center"><b>EMI / Installment Amount </b></td>
						<td width="10%" align="center"><b>Due Date</b></td>
						<td width="10%" align="center"><b>Arrears if any</b></td>
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
						
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(4))%></td>
						<td align="right"><%=Helper.correctDouble((String)arrJAppLiabCol.get(6))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrJAppLiabCol.get(7)),strAmountForm)%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(8))%></td>
						<td><%=Helper.correctNull((String)arrJAppLiabCol.get(9))%></td>
					</tr>
					
					<%
				}}}
						if((arrJAppLiabRow!=null&&arrJAppLiabRow.size()>0)&&(intTemp==0))
						{%>
							<tr><td colspan="10" align="center">No data found</td></tr>
						<%}
					%>
				</table>
			</div>
			</td></tr>
			<%if(!Helper.correctNull((String)hshSecdetail.get("com_GroupConfac")).equalsIgnoreCase(""))
			{ %>
			<tr>
			<td><b>B) Comment on Existing Credit Facilities of the Joint applicants :</b>
			</td>
			</tr>
			<tr>
			<td><%=Helper.correctNull((String)hshSecdetail.get("com_GroupConfac")).trim()%></td>
			</tr>
			<%} %>
			<tr>
				<td><b><span style="float: left;"><%=i++%>. A) Other Bank Facilities (if any) of Main Applicant: </span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="10%" align="center"><b>Sl. No</b></td>
					<td width="10%" align="center"><b>Bank Name</b></td>
					<td width="20%" align="center"><b>Type of Facility</b></td>
					<td width="10%" align="center"><b>Limit</b></td> 
					<td width="10%" align="center"><b>Outstanding <br/> Balance</b></td> 
					<td width="10%" align="center"><b>Rate Of Interest (%)</b></td> 
					<td width="10%" align="center"><b>EMI / Installment </b></td> 
					<td width="10%" align="center"><b>Due Date</b></td> 
					<td width="10%" align="center"><b>Arrears if any</b></td> 
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
							Helper.correctDouble((String)arrOthrbnkCol.get(2)))),strAmountForm)%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(3)))),strAmountForm)%>&nbsp;</td>
					<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(4))))%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(5)))),strAmountForm)%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(6))%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(7))%>&nbsp;</td>
					</tr>
					<%}}else{ %>
					<tr><td colspan="9" align="center">No data found</td></tr>
					<%} %>				    	
				</table>
			</div>
			</td></tr>
			<tr>
				<td><b>B) Other Bank Comments: </b></td>
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
				<td><b><span style="float: left;"><%=i++%>. A) Other Bank Facilities (if any) of Joint Applicant/s</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="10%" align="center"><b>Sl. No</b></td>
					<td width="10%" align="center"><b>Bank Name</b></td>
					<td width="20%" align="center"><b>Type of Facility</b></td>
					<td width="10%" align="center"><b>Limit</b></td> 
					<td width="10%" align="center"><b>Outstanding<br/> Balance</b></td> 
					<td width="10%" align="center"><b>Rate Of Interest (%)</b></td> 
					<td width="10%" align="center"><b>EMI / Installment </b></td> 
					<td width="10%" align="center"><b>Due Date</b></td> 
					<td width="10%" align="center"><b>Arrears if any</b></td> 
					</tr>
					<%if(arrCoAppLiabRow!=null && arrCoAppLiabRow.size()>0){
					for(int g=0;g<arrCoAppLiabRow.size();g++){
						arrOthrbnkCol = (ArrayList)arrCoAppLiabRow.get(g);
					%>
					<tr>
					<td align="center"><%=g+1%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(0))%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(1))%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(2)))),strAmountForm)%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(3)))),strAmountForm)%>&nbsp;</td>
					<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(4))))%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(5)))),strAmountForm)%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(6))%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(7))%>&nbsp;</td>
					</tr>
					<%}}else{ %>
					<tr><td colspan="9" align="center">No data found</td></tr>
					<%} %>				    	
				</table>
			</div>
			</td>
			</tr>			
			<tr>
				<td><b><span style="float: left;"><%=i++%>.Present Proposal:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="10%" align="center"><b>Sl. No</b></td>
					<td width="20%" align="center"><b>Facility</b></td>
					<td width="20%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
					<td width="20%" align="center"><b>Limit </b></td>
					<td width="20%" align="center"><b>Period Sought</b></td>
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
				<td><b><%=i++%>.BACKGROUND OF Guarantor/s:</b></td>
			</tr>
			<tr>
				<td><%=Helper.correctNull((String)hshValues.get("GuarComments"))%></td>
			</tr>
			<%} %>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    		
				    			<%
				    			intTemp=0;
						if(arrJAppLiabRow!=null&&arrJAppLiabRow.size()>0)
						{
							for(int j=0;j<arrJAppLiabRow.size();j++)
							{
								arrJAppLiabCol=(ArrayList)arrJAppLiabRow.get(j);
								
								if(j==0){
					%>
				    	<tr>
				<td colspan="10"><b><span style="float:left"> <%=i++%>.Existing Facilities of the Guarantor/Co-Obligant's :</span><span style="float:right">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>	
				    		
					<tr class="tblhead">
						<td width="10%" align="center"><b>Nature of Facility</b></td>
						<td width="10%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Limit</b></td>
						<td width="10%" align="center"><b>Sanction Ref No.</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Outstanding<br/> balance </b></td>
						<td width="10%" align="center"><b>Present Status</b></td>
						<td width="10%" align="center"><b>Rate Of Interest (%)</b></td>
						<td width="10%" align="center"><b>EMI / Installment Amount </b></td>
						<td width="10%" align="center"><b>Due Date</b></td>
						<td width="10%" align="center"><b>Arrears if any</b></td>
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
				}}}
						if((arrJAppLiabRow!=null&&arrJAppLiabRow.size()>0)&&(intTemp==0))
						{%>
							<tr><td colspan="10" align="center">No data found</td></tr>
						<%}
					%>
				</table>
			</div>
			</td></tr>
			<%if(!Helper.correctNull((String)hshSecdetail.get("com_GroupConfac")).equalsIgnoreCase(""))
			{ %>
			<tr>
			<td><b>Comment on Existing Credit Facilities of the Guarantor/s :</b>
			</td>
			</tr>
			<tr>
			<td><%=Helper.correctNull((String)hshSecdetail.get("com_GroupConfac1")).trim()%></td>
			</tr>
			<%} %>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<% if(hshResult!=null&&hshResult.size()>0)
			{%>
			<tr>
				<td>
					<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				<%if(!strPrdtype.equalsIgnoreCase("pP")){ %><tr>
				<td  colspan="2"><b><span style="float: left;"><%=i++%>.ASSESSMENT</span><span  style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr class="tblhead">
				<td align="center" colspan="2"><b>ASSESSMENT BASED ON COST</b></td>
			</tr><%}else if(strPrdtype.equalsIgnoreCase("pP")&& (Employmentstatus.equalsIgnoreCase("1")|| Employmentstatus.equalsIgnoreCase("9"))){ %>
			<tr>
				<td  colspan="2"><b><span style="float: left;"><%=i++%>.ASSESSMENT</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr class="tblhead">
				<td align="center" colspan="2"><b>ASSESSMENT BASED ON COST</b></td>
			</tr>
			<%} %>
			<% if (hshResult.get("arrAssessment") != null) {%>
			<%	if (arrAssessmentData != null && arrAssessmentData.size() > 0)
				{
					for (int j = 0; j < arrAssessmentData.size(); j++)
					{	
					arrAssessmentDisp=(ArrayList)arrAssessmentData.get(j);
					%>
					<%if(Helper.correctNull((String)arrAssessmentDisp.get(0)).equalsIgnoreCase("Margin Required")){%>
					<tr>
						<td align="left"><%=arrAssessmentDisp.get(0)%></td>
<!--						<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
						<td align="right"><%=Helper.removeHTMLTags((String)arrAssessmentDisp.get(1))%></td>
					</tr>
					<%}else{ %>
					<tr>
						<td align="left"><%=arrAssessmentDisp.get(0)%></td>
<!--						<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
						<td align="right"><%=Helper.converAmount(Helper.correctDouble(Helper.removeHTMLTags((String)arrAssessmentDisp.get(1)).toString()),strAmountForm)%></td>
					</tr>
					<%}}
				}}if ((hshIncAssessmentValues.get("arrIncAssessment") != null) && (!strPrdtype.equalsIgnoreCase("pA"))){
					%>
					<%if(!((strPrdtype.equalsIgnoreCase("pH") && Helper.correctNull((String)hshResult.get("strStaffPrd")).equalsIgnoreCase("Y"))|| prd_purpose.equalsIgnoreCase("G")) && !strSessionModuleType.equals("DIGI") ||strPrdtype.equalsIgnoreCase("pM")|| strPrdtype.equalsIgnoreCase("pV") ){ %>
					<tr class="tblhead">
					<td align="center" colspan="2"><b>ASSESSMENT BASED ON INCOME</b></td>
				</tr><%} %>
				<%if (arrIncAssessmentData != null && arrIncAssessmentData.size() > 0)
				{
					for (int j = 0; j < arrIncAssessmentData.size(); j++)
					{	
						arrIncAssessmentDisp=(ArrayList)arrIncAssessmentData.get(j);
						if(arrIncAssessmentDisp.get(0).toString().startsWith("Applicant -") ||
								arrIncAssessmentDisp.get(0).toString().startsWith("Joint-Applicant -") ||
								arrIncAssessmentDisp.get(0).toString().startsWith("Co-Obligant -") ||
								arrIncAssessmentDisp.get(0).toString().startsWith("Guarantor -")){
					%>
					<%if((strPrdtype.equalsIgnoreCase("pH")&& (!prd_purpose.equalsIgnoreCase("G")))||strPrdtype.equalsIgnoreCase("pM")||strPrdtype.equalsIgnoreCase("pV") ){ %>
					<tr class="tblhead">
					<td colspan="2"><b><%=arrIncAssessmentDisp.get(0)%></b></td>
					</tr>
					<% }}else if(arrIncAssessmentDisp.get(0).toString().startsWith("MAXIMUM AMOUNT BASED ON SCHEME")||
							arrIncAssessmentDisp.get(0).toString().startsWith("OVERALL")){%>
					<tr class="tblhead">
					<td colspan="2" align="center"><b><%=arrIncAssessmentDisp.get(0)%></b></td>
					</tr>
					<%} else {
					%>
					<%if(((strPrdtype.equalsIgnoreCase("pH")&& (!prd_purpose.equalsIgnoreCase("G")))||(strPrdtype.equalsIgnoreCase("pV"))) && (i!=0)&& (!strPrdtype.equalsIgnoreCase("pP"))){ 
					%>
					<tr>
					<td align="left"><%=arrIncAssessmentDisp.get(0)%></td>
<!--					<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(Helper.removeHTMLTags((String)arrIncAssessmentDisp.get(1)).toString()),strAmountForm)%></td>
					</tr>
					<%}else if(strPrdtype.equalsIgnoreCase("pP")&&
							(Employmentstatus.equalsIgnoreCase("1")||Employmentstatus.equalsIgnoreCase("9"))){%>
					<tr>
					<td align="left"><%=arrIncAssessmentDisp.get(0)%></td>
<!--					<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(Helper.removeHTMLTags((String)arrIncAssessmentDisp.get(1)).toString()),strAmountForm)%></td>
					</tr>
					<%}else if(strPrdtype.equalsIgnoreCase("pM")){%>
							<tr>
							<td align="left"><%=arrIncAssessmentDisp.get(0)%></td>
<!--							<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
							<td align="right"><%=Helper.converAmount(Helper.correctDouble(Helper.removeHTMLTags((String)arrIncAssessmentDisp.get(1)).toString()),strAmountForm)%></td>
							</tr>
							<%}}
					}
				}}if(hshResult.get("arrAssessment") == null && hshIncAssessmentValues.get("arrIncAssessment") == null && Staffproduct.equalsIgnoreCase("")){%>
				<tr class="tblhead">
					<td align="center" colspan="2"><font color="red"><b>No Assessment to Display</b></font></td>
				</tr>
				<%} %>
			</table>
			</div>
				</td>
			</tr>
			
			<%} %>
			
		<% if(!strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
			
			
			
			<%  if (Staffproduct.equalsIgnoreCase("Y")){%>
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" cellpadding="0" cellspacing="1" class="outertable">
			<tr class="tblhead">
			<td align="center" colspan="2"><b><span  style="float: left;">ASSESSMENT BASED ON REPAYMENT CAPACITY</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr>
			<td width="80%"><b> Latest Monthly  Salary</b></td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("MonthlyIncome")),strAmountForm) %>&nbsp;</b>
			</td>
			</tr>
			<tr>
			<td width="80%">50 % of montly Salary </td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("HalfMonthlyIncome")),strAmountForm) %>&nbsp;
			</td>
			</tr>

			<tr>
			<td width="80%">Monthly Loan Commitment of Existing loan/s</td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Monthlydeduction")),strAmountForm) %>&nbsp;
			</td>
			</tr>
			<tr>
			<td>Percentage of Deduction to Latest Monthly Salary</td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Percentagemonthlydeduction")),strAmountForm) %>&nbsp;
			</td>
			</tr>
			<tr>
			<td>Monthly Loan Commitment of Proposed loan</td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("ProposedLoancommitment")),strAmountForm) %>&nbsp;
			</td>
			</tr>
			<tr>
			<td><b>Percentage of Deduction to Latest Monthly Salary</b></td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("LatestDeductions")),strAmountForm) %>&nbsp;</b>
			</td>
			</tr>
			<tr>
			<td><b>Total monthly Loan Commitment is</b></td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Totalloancommitment")),strAmountForm) %>&nbsp;</b>
			</td>
			</tr>
			<tr>
			<td><b>Percentage of Total monthly  loan Commitment to Total monthly salary</b></td>
<!--			<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
			<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Percentageofloancommitment")),strAmountForm) %>&nbsp;%</b>
			</td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%}
			if(!Staffproduct.equalsIgnoreCase("Y")){
            if(!(strPrdtype.equalsIgnoreCase("pL")||(schemeCode.equalsIgnoreCase("OD") && strPrdtype.equalsIgnoreCase("pM"))||strPrdtype.equalsIgnoreCase("pE")||strPrdtype.equalsIgnoreCase("pV")||strPrdtype.equalsIgnoreCase("pU")||strPrdtype.equalsIgnoreCase("pB")||(strPrdtype.equalsIgnoreCase("pI")&& !(strRepayType.equalsIgnoreCase("1")))))
            { 
            if (hshRepayment.get("arrRepayCapacity") != null) { %>
            <tr>
            <td>
		<div id="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="outertable">
			<tr class="tblhead">
				<td align="center" colspan="3"><b><span  style="float: left;">ASSESSMENT BASED ON REPAYMENT CAPACITY</span><span  style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<%	if (arrRepayCapacityData != null && arrRepayCapacityData.size() > 0)
				{
					for (int m = 0; m < arrRepayCapacityData.size(); m++)
					{	
					arrRepayCapacityDisp=(ArrayList)arrRepayCapacityData.get(m);
					if(arrRepayCapacityDisp.get(0).toString().startsWith("Applicant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Joint-Applicant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Co-Obligant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Guarantor -")){
				%>
				<tr>
				<td colspan="2"><b><%=arrRepayCapacityDisp.get(0)%></b></td>
				</tr>
				<%} else {%>
					<tr >
					<td width="80%"align="left"><%=arrRepayCapacityDisp.get(0)%></td>
					<!--  <td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td>  -->
					<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrRepayCapacityDisp.get(1)),strAmountForm)%></td>
					</tr>
					<%}
				}} %>
				</table>
				</div>
				</td>
				</tr>
			<%} else { %>
				<tr>
					<td align="center" colspan="3"><font color="red"><b>No Assessment to Display</b></font></td>
				</tr>
				<%}} else if(strPrdtype.equalsIgnoreCase("pM") && (!schemeCode.equalsIgnoreCase("OD"))) { 
				 
            if (hshRepayment.get("arrRepayCapacity") != null) { %>
            <tr>
            <td>
			<div id="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="1" class="outertable">
			<tr class="tblhead">
				<td align="center" colspan="3"><b>ASSESSMENT BASED ON REPAYMENT CAPACITY</b></td>
			</tr>
			<%	if (arrRepayCapacityData != null && arrRepayCapacityData.size() > 0)
				{
					for (int m = 0; m < arrRepayCapacityData.size(); m++)
					{	
					arrRepayCapacityDisp=(ArrayList)arrRepayCapacityData.get(m);
					if(arrRepayCapacityDisp.get(0).toString().startsWith("Applicant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Joint-Applicant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Co-Obligant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Guarantor -")){
				%>
				<tr>
				<td colspan="2"><b><%=arrRepayCapacityDisp.get(0)%></b></td>
				</tr>
				<%} else {%>
					<tr >
					<td width="80%"align="left"><%=arrRepayCapacityDisp.get(0)%></td>
					<!--  <td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td>  -->
					<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrRepayCapacityDisp.get(1)),strAmountForm)%></td>
					</tr>
					<%}
				}}%>
				</table>
				</div>
				</td>
				</tr>
			<%} else { %>
				<tr>
					<td align="center" colspan="3"><font color="red"><b>No Assessment to Display</b></font></td>
				</tr>
				<%}
				 } %>
			
			
			
			
			<% if (hshRepayment.get("arrRepayCapacity") != null && (!((strPrdtype.equalsIgnoreCase("pL"))||strPrdtype.equalsIgnoreCase("pB")||(strPrdtype.equalsIgnoreCase("pU") && schemeCode.equalsIgnoreCase("OD"))||
					(strPrdtype.equalsIgnoreCase("pM") && schemeCode.equalsIgnoreCase("OD"))||strPrdtype.equalsIgnoreCase("pE")||(strPrdtype.equalsIgnoreCase("pJ") && schemeCode.equalsIgnoreCase("OD"))||
					(strPrdtype.equalsIgnoreCase("pV") && schemeCode.equalsIgnoreCase("OD"))||(strPrdtype.equalsIgnoreCase("pI") && schemeCode.equalsIgnoreCase("OD"))
							&& !(strRepayType.equalsIgnoreCase("1"))))) { 
			if((strPrdtype.equalsIgnoreCase("pP"))&& (Employmentstatus.equalsIgnoreCase("1")||Employmentstatus.equalsIgnoreCase("9")))
			{
			%>
<tr>
<td>
<div id="top">
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="outertable" align="center" class="tblhead">
	<tr class="tblhead">
	<td colspan="2">Assessment Based on Repayment Capacity</td>
	</tr>
	<tr >
	<td width="80%"><b> Grand Total Income Eligible for Deductions</b></td>
	<!-- <td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td> -->
	<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("dbl_grant_tot")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td width="80%"> <%=Helper.correctNull((String)hshValues.get("dbl_repay_capacity_defined")) %> % of which is </td>
	<!-- <td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("dbl_whichis")),strAmountForm) %>
	</td>
	</tr>
	
	<tr>
	<td width="80%">Annual Loan Commitment of Proposed loan</td>
	<!--<td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("dbl_prop_loan_commitmenttot1")),strAmountForm) %>
	</td>
	</tr>
	<tr>
	<td>Annual Loan Commitment of Existing loan/s</td>
	<!--<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Totaldbl_exi_loan")),strAmountForm) %>
	</td>
	</tr>
	<tr>
	<td><b>Total Annual Loan Commitment is</b></td>
	<!-- <td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Totalloan")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td><b>Percentage of Annual Total loan Commitment to Total Annual Income</b></td>
	<!-- <td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><b><%=Helper.correctDouble((String)hshRepayment.get("dbl_perannualtot")) %>&nbsp;%</b>
	</td>
	</tr>
	
	</table>
</div>
	</td>
	</tr>
	
	<%}else if ((strPrdtype.equalsIgnoreCase("pP"))&& !(Employmentstatus.equalsIgnoreCase("1")||Employmentstatus.equalsIgnoreCase("9"))){%>
	<tr><td>
	<div id="top">
	<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable " align="center">
	<tr  class="tblhead">
	<td colspan="2">Assessment Based on Repayment Capacity</td>
	</tr>
	<tr >
	<td width="80%"><b> Latest Gross Annual income</b></td>
	<td align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Gross_Income")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td width="80%"><b> Maximum Permissible Deductions (%) </b></td>
	<td align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Max_per_deduct")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td width="80%"><b> Annual Loan Commitment of Existing loan/s</b></td>
	<td align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Existingloan_commitment")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td width="80%"><b> Annual Loan Commitment of Proposed loan</b></td>
	<td align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Annual_loan_commitment_proposed")),strAmountForm) %></b>
	</td>
	</tr>
	<tr >
	<td width="80%"><b> Total Annual Loan Commitment is</b></td>
	<td align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Total_annual_commitment")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td width="80%"><b> Percentage of Annual Total loan Commitment to Total Annual Income</b></td>
	<td align="right"><b><%=Helper.correctDouble((String)hshRepayment.get("dbl_perannualtot")) %></b>
	</td>
	</tr>
</table>
</div>
</td>
</tr>
	<%}else if(!strPrdtype.equalsIgnoreCase("pU"))
	{%>
	<tr><td>
	<div id="top">
	<table width="100%" border="0" cellpadding="0" cellspacing="1" class="outertable" align="center" class="tblhead">
	<tr class="tblhead">
	<td colspan="2">Assessment Based on Repayment Capacity</td>
	</tr>
	<tr >
	<td width="80%"><b> Grand Total Income Eligible for Deductions</b></td>
	<!-- <td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td> -->
	<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("dbl_grant_tot")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td width="80%"> <%=Helper.correctNull((String)hshRepayment.get("dbl_repay_capacity_defined")) %> % of which is </td>
	<!-- <td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("dbl_whichis")),strAmountForm) %>
	</td>
	</tr>
	
	<tr>
	<td width="80%">Annual Loan Commitment of Proposed loan</td>
	<!--<td width="5%"align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("dbl_prop_loan_commitmenttot1")),strAmountForm) %>
	</td>
	</tr>
	<tr>
	<td>Annual Loan Commitment of Existing loan/s</td>
	<!--<td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Totaldbl_exi_loan")),strAmountForm) %>
	</td>
	</tr>
	<tr>
	<td><b>Total Annual Loan Commitment is</b></td>
	<!-- <td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><b><%=Helper.converAmount(Helper.correctDouble((String)hshRepayment.get("Totalloan")),strAmountForm) %></b>
	</td>
	</tr>
	<tr>
	<td><b>Percentage of Annual Total loan Commitment to Total Annual Income</b></td>
	<!-- <td align="center"><%//=ApplicationParams.getCurrency()%></td>-->
	<td  align="right"><b><%=Helper.correctDouble((String)hshRepayment.get("dbl_perannualtot"))%>&nbsp;%</b>
	</td>
	</tr>
	
	</table>
	</div>
	</td></tr>
		
	<%}}} %>
			<%if(!Helper.correctNull((String)hshValues.get("assesscomments")).equalsIgnoreCase("")){ %>
			<tr>
			<td><b>Comments on Assessment :</b></td>
			</tr>
			<%} %>
			<tr>
			<td><%=Helper.correctNull((String)hshValues.get("assesscomments")) %></td>
			</tr>
		
		<%} %>	
		<!-- Source of Margin - only for Housing & Vehicle Loan by DINESH on 7/4/2014-->
			
		<% if((strPrdtype.equalsIgnoreCase("pH")&& !(prd_purpose.equalsIgnoreCase("G")||prd_purpose.equalsIgnoreCase("T")||prd_purpose.equalsIgnoreCase("HC"))) || strPrdtype.equalsIgnoreCase("pA")){ %>	
			<tr><td><br>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				<td colspan="2"><b><span style="float: left;"><%=i++%>. Cost of Project & Means of Finance:</span><span style="float: right;">(Rs. in <%=strAmountVal %>)</span></b></td>
				</tr>
					<tr>
					<td width="25%">Loans requested from the Bank</td>
					<td width="25%" align="right"><%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("PER_MARGIN_REQAMT")),strAmountForm)%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="25%">Cost already incurred</td>
					<td width="25%" align="right"><%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("PER_MARGIN_COSTINCURED")),strAmountForm)%>&nbsp;</td>				
					</tr>
					<tr>
						<td>Own Savings and Disposal of Investments(FD's,Shares,NSC,LICP,Provident Fund)</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("PER_MARGIN_OWNSAVINGS")),strAmountForm)%></td>
					</tr>
					<%if(!Helper.correctNull((String) hshValues.get("PER_MARGIN_OTHERS_DESC1")).equals("")) {%>
					<tr>
						<td><%=Helper.correctNull((String) hshValues.get("PER_MARGIN_OTHERS_DESC1"))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("PER_MARGIN_OTHERS_VALUE1")),strAmountForm)%></td>
					</tr>
					<%}if(!Helper.correctNull((String) hshValues.get("PER_MARGIN_OTHERS_DESC2")).equals("")){ %>
					<tr>
						<td><%=Helper.correctNull((String) hshValues.get("PER_MARGIN_OTHERS_DESC2"))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("PER_MARGIN_OTHERS_VALUE3")),strAmountForm)%></td>
					</tr>
					<%}if(!Helper.correctNull((String) hshValues.get("PER_MARGIN_OTHERS_DESC3")).equals("")){ %>
					<tr>
						<td><%=Helper.correctNull((String) hshValues.get("PER_MARGIN_OTHERS_DESC3"))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("PER_MARGIN_OTHERS_VALUE3")),strAmountForm)%></td>
					</tr>	
					<%} %>
					<tr>
						<td>Total Fund</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) hshValues.get("PER_MARGIN_TOTAL_FUND")),strAmountForm)%></td>
					</tr>	    	
				</table>
			</div>
			</td></tr>
			
			<%} %>
			
			<% 
			if (strTakeover.equalsIgnoreCase("Y")){ 
			%>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr class="tblhead">
				<td colspan="2"><b><%=i++%>.DETAILS FOR TAKE OVER LOANS:</b></td>
				</tr>
					<tr>
					<td width="25%">Reasons for shifting the account to our Bank</td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("shifting_reason"))%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="25%">Sanction/Release Date</td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("avail_date"))%>&nbsp;</td>				
					</tr>
					<tr>
						<td>Period of Loan</td>
						<td><%=Helper.correctNull((String) hshValues.get("repay_period"))%>&nbsp;</td>
					</tr>
					<tr>
						<td>Holiday Period in the existing loan account proposed to be Taken Over</td>
						<td><%=Helper.correctNull((String) hshValues.get("holiday_period"))%>&nbsp;</td>
					</tr>
					<tr>
					<td width="25%">Rate of interest charged by the previous Bank</td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("rate_of_interest"))%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="25%">Details of opinion/report obtained from the previous Bank 
									and observations there on</td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("prev_bank_opinion"))%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="25%">Statement of account from previous Banker is obtained and verified 
							for period covering from <b><%=Helper.correctNull((String) hshValues.get("stmt_from_date"))%></b>
							to <b><%=Helper.correctNull((String) hshValues.get("stmt_to_date"))%></b> and comments there on</td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("stmt_comments"))%>&nbsp;</td>				
					</tr>				    	
				</table>
			</div>
			</td></tr>
			<%} %>
			
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
				<td><b><%=i++%>.Conduct of operations in the Existing Facilities of Applicant:</b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr>
					<td width="5%">1</td>	
					<td width="45%">Compliance of the earlier Sanction Terms</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else{ %>
					<td width="45%"><%=Helper.correctNull((String) hshValues.get("CON_COMPLIANCE"))%>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="5%" rowspan="5">2</td>
					<td colspan="2"><b>Compliance of Inspection observations:</b></td>
					</tr>
					<tr>
					<td width="45%">Internal Inspection:</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else{ %>
					<td width="45%"><%=Helper.correctNull((String) hshValues.get("con_internalinspection"))%>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="45%">RBI Inspection:</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%">NA</td>
					<%}else{ %>
					<td width="45%"><%=Helper.correctNull((String) hshValues.get("con_rbiinspection"))%>&nbsp;</td>		
					<%} %>		
					</tr>
					<tr>
					<td width="45%">Audits Observation:</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else{ %>
					<td width="45%"><%=Helper.correctNull((String) hshValues.get("con_auditsobser"))%>&nbsp;</td>				
					
					<%} %></tr>
					<tr>
					<td width="45%">Offsite Observation:</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else{ %>
					<td width="45%"><%=Helper.correctNull((String) hshValues.get("con_offsiteobserv"))%>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="5%">3</td>
					<td width="45%">Registration of charge with ROC and latest Search Report obtained ?</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else {%>
					<td width="45%">
									<% if(Helper.correctNull((String) hshValues.get("CON_ROCLREPORT")).equalsIgnoreCase("Y")){%>
									Yes<br/>
									<%=Helper.correctNull((String) hshValues.get("CON_PERIODCOVERED"))%>	
									<%}else{ %>
									No<br/>
									<%=Helper.correctNull((String) hshValues.get("CON_ROCREASON"))%>	
								<%} %>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="5%">4</td>
					<td width="45%">(a)Registration of EM details with Central Registry<br/><br/>
									(b)Whether charge noted in favour of our Bank on the property/ies has been verified </td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					
					<%}else {%>
					<td width="45%"><%if(Helper.correctNull((String) hshValues.get("CON_EMREG")).equalsIgnoreCase("N")){ %>
									No
									<br/>
									<%=Helper.correctNull((String) hshValues.get("CON_EMREASON"))%><br/>
									<%}else{%>
									Yes<br/><br/>
									<%} %>
									<%if(Helper.correctNull((String) hshValues.get("CON_CHARGESNOTED")).equalsIgnoreCase("N")){ %>
									No<br/>
									<%=Helper.correctNull((String) hshValues.get("CON_CHARGESREASON"))%>
									<%}else{%>
									Yes<br/><br/>
									<%} %>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="5%">5</td>
					<td width="45%">Conduct Of TL/DPN</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else {%>
					<td width="45%"><%=Helper.correctNull((String) hshValues.get("CON_CONDUCTTLDPN"))%>&nbsp;</td>				
					<%} %>
					</tr>				    	
				</table>
			</div>
			</td></tr>
			
			
		
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
    		<tr class="tblhead">
    		<td><%=i++%>.RBI Guidelines, If any, Regarding the  Credit Proposal:</td>
    		</tr>
    			
			<tr >
			<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="35%"> NA</td>
					<%}else {%>
			<td width="35%" style="text-align: justify">&nbsp;<b><p><%=Helper.correctNull((String) hshValues.get("creditproposal"))%></p></b></td>
			<%} %>
			</tr>
			</table>
			</div>
			</td>
			</tr>
								
			<%if (!(Staffproduct.equalsIgnoreCase("Y"))){ %>	
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr >
			<td colspan="4"><b><%=i++%>.Eligibility under KBL Scheme:</b></td>
			</tr>	
				    		
			<tr class="tblhead">
			<td width="35%" align="center"><b>Eligibility Conditions</b></td>
			<td width="20%" align="center"><b>Required</b></td>
			<td width="20%" align="center"><b>Available</b></td>
			<td width="25%" align="center"><b>Status</b></td>
            </tr>
		                <%
		                if(arrEligRow!=null&&arrEligRow.size()>0)
		                {
		                	for(int j=0;j<arrEligRow.size();j++)
		                	{
		                		arrEligCol=new ArrayList();
		                		arrEligCol=(ArrayList)arrEligRow.get(j);
			                	if(arrEligCol!=null&&arrEligCol.size()>0)
			                	{
			            %>
			            <tr>
				            <td><%=Helper.correctNull((String)arrEligCol.get(0))%></td>
				            <td><%=Helper.correctNull((String)arrEligCol.get(1))%></td>
				            <td><%=Helper.correctNull((String)arrEligCol.get(2))%></td>
				            <td align="center">
				            
				 
				            <%
				          
				            
				            if(Helper.correctNull((String)arrEligCol.get(3)).equalsIgnoreCase("Not Eligible")){
								eligible="Not eligible";
							%>
							<%=Helper.correctNull((String)arrEligCol.get(3))%>
							<%}
				            else if(Helper.correctNull((String)arrEligCol.get(3)).equalsIgnoreCase("Eligible")){%>
							<%=Helper.correctNull((String)arrEligCol.get(3))%>
							<%}
							else if(Helper.correctNull((String)arrEligCol.get(3)).equalsIgnoreCase("Deviated")){%>
							<%=Helper.correctNull((String)arrEligCol.get(3))%>
							<%}
							else if(Helper.correctNull((String)arrEligCol.get(3)).equalsIgnoreCase("Relaxed")){%>
							<%=Helper.correctNull((String)arrEligCol.get(3))%>
							<%}%>
							</td>
			            </tr>
			            <%
			                	}
		                	}
		                }
		                if(eligible.equalsIgnoreCase("Not Eligible")){%>
						<tr>
							<td colspan="4" align="center"><b>Applicant is not Eligible</b></td>
						</tr>
						<%} else { %>
						<tr> 
							<td colspan="4" align="center"><b>Applicant is Eligible</b></td>
						</tr>
						<%}%>
						</table>
						</div>
						</td>
						</tr>
						<%} %>
						
			
			
			<tr>
				<td>
				<jsp:include page="../print/per_deviationforprint.jsp" flush="true">
				<jsp:param value='<%=i++%>'name='pno'/>
			</jsp:include>
				</td>
			</tr>
			
		
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				  	<tr class="tblhead">
					<td colspan="2"><b><%=i++%>.Percentage of NPA under the scheme:</b></td>
					</tr>		
					<tr>
					<td width="25%">Account wise</td>	
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else {%>
					<td width="25%" style="text-align: right"><%=Helper.correctDouble((String)hshValues.get("npa_accwise")) %> %</td>		
					<%} %>
					</tr>
					<tr>
					<td width="25%" >Amount wise</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="45%"> NA</td>
					<%}else {%>
					<td width="25%" style="text-align: right"><%=Helper.correctDouble((String)hshValues.get("npa_amtwise")) %> %</td>			
					
					<%} %></tr>
				    	
				</table>
			</div>
			</td></tr>
			
			<tr>
				<td><b><%=i++%>.Inspection Comments ( Internal/ RBI) and rectification thereof: </b></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="5%" align="center">Sl.No</td>	
					<td width="30%" align="center">Particulars</td>
					<td width="30%" align="center">Comments</td>	
					<td width="30%" align="center">Compliance/ Action taken/ time frame for rectification</td>				
					</tr>
					<tr>
					<td width="5%">A</td>
					<td width="30%">Internal (as on  <%=Helper.correctNull((String) hshValues.get("INS_INTERNALDATE"))%>)</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
					<td width="30%"> NA</td>
					<%}else{ %>
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_INTERNALCOMMENT"))%>&nbsp;</td>	
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_INTERNALACTION"))%>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="5%">B</td>
					<td width="30%">RBI : (as on <%=Helper.correctNull((String) hshValues.get("INS_RBIASONDATE"))%> )</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
					<td width="30%"> NA</td>
					<%}else{ %>
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_RBICOMMENT"))%>&nbsp;</td>	
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_RBIACTION"))%>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="5%">C</td>
					<td width="30%">Unit Inspection Reports</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
					<td width="30%"> NA</td>
					<%}else{ %>
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_UNITCOMMENT"))%>&nbsp;</td>	
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_UNITACTION"))%>&nbsp;</td>				
					<%} %>
					</tr>
					<tr>
					<td width="5%">D</td>
					<td width="30%">RMD observations</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
					<td width="30%"> NA</td>
					<%}else{ %>
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_RMDCOMMENT"))%>&nbsp;</td>	
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_RMDACTION"))%>&nbsp;</td>					
					<%} %>
					</tr>
					<tr>
					<td width="5%">E</td>
					<td width="30%">Concurrent Audit Report</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
					<td width="30%"> NA</td>
					<%}else{ %>
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_AUDITCOMMENT"))%>&nbsp;</td>	
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_AUDITACTION"))%>&nbsp;</td>					
					
					<%} %></tr>
					<tr>
					<td width="5%">F</td>
					<td width="30%">Off Site Observations</td>
					<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
					<td width="30%"> NA</td>
					<%}else{ %>
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_OFFSITECOMMENT"))%>&nbsp;</td>	
					<td width="30%"><%=Helper.correctNull((String) hshValues.get("INS_OFFSITEACTION"))%>&nbsp;</td>					
					<%} %>
					</tr>				    	
				</table>
			</div>
			</td></tr>
			
			<% if(strPrdtype.equalsIgnoreCase("pA")){ %>
			<tr>
			<td><b><%=i++%>.Vehicle Property Details</b></td>
			</tr>
			<tr>
			<td>
			<jsp:include page="../print/per_vehiclepropdetails.jsp" flush="true"/>
			
			</td>
			</tr>
			<%} %>
			
			
			
			<% if(strPrdtype.equalsIgnoreCase("pH")){ %>
			<tr>
			<td>
			<jsp:include page="../print/retailprocessnotepropertydet.jsp" flush="true"/>
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
					 <td> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
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
						 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
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
			<td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% 
			ArrayList arrpropsecurityCersaiQues=new ArrayList();
			arrpropsecurityCersaiQues=(ArrayList)hshValues.get("arrOutCersaiQues");
			//out.println("arrpropsecurityCersaiQues==>>"+arrpropsecurityCersaiQues);
			if(arrpropsecurityCersaiQues!=null && arrpropsecurityCersaiQues.size()>0)
					{
			%>
			<tr class="tblhead"><td colspan="11"><span style="float: left;">CERSAI Search details : </span></td></tr>
			
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
			<%if(!Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")).equalsIgnoreCase("")){ %>
			<tr>
			<td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td>
			<%=Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")) %>
			</td>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
			
			 <% if((!strPrimaryComments.equals(""))||(!strCollateralComments.equals(""))) { %>
			<tr>
				<td align="left"><b>Comments on Securities: </b></td>
			</tr>
			<tr>
				<td align="left"><b>Prime: </b></td>
			</tr>
			<tr>
				<td>&nbsp;<%=strPrimaryComments%></td>
			</tr>
			<tr>
				<td align="left"><b>Collateral: </b></td>
			</tr>
			<tr>
				<td>&nbsp;<%=strCollateralComments%></td>
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
					<table width="100%">
						<tr class="">	
							<td colspan="4"><b>Security ID:&nbsp;<%=Helper.correctNull((String)arrCol.get(13)) %></b></td>
						</tr>
						<tr>	
							<td width="25%">Name of the panel Advocate</td>
							<%if(("2062").equalsIgnoreCase(Helper.correctNull((String)arrCol.get(16)))) {%>
							  <td width="25%"><%=Helper.correctNull((String)arrCol.get(0)) %> - <%=Helper.correctNull((String)arrCol.get(17)) %></td>
							<%}else{ %>
							<td width="25%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
							<%} %>
							<td width="25%">Date</td>
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
						<tr>	
							<td colspan="2" valign="top"><b>Period of flow of title</b></td>
							<td colspan="2">
									<table width="100%">
									
							
								<%String strFlow=Helper.correctNull((String)arrCol.get(14)) ;
								if(!strFlow.equalsIgnoreCase("")){
								String[] strFlow_1=strFlow.split("@");
								for(int a=0;a<strFlow_1.length;a++){
									String[] strFlow_res=strFlow_1[a].split("~");
									if(strFlow_res.length>1){
										%>
										<tr class="">
											<td><%= strFlow_res[0]%></td>
											<td><%=strFlow_res[1] %></td>
										</tr>
								<%}}} %>
								</table>
							</td>
						</tr>
						
						<tr>	
							<td colspan="2" valign="top"><b>Period of EC</b></td>
							<td colspan="2">
									<table width="100%">
									
								<%
								String strEC=Helper.correctNull((String)arrCol.get(15)) ;
								if(!strEC.equalsIgnoreCase("")){
									String[] strEC_1=strEC.split("@");
									for(int b=0;b<strEC_1.length;b++){
										String[] strEC_res=strEC_1[b].split("~");
										if(strEC_res.length>1){
										%>
										<tr class="">
										<td><%= strEC_res[0]%></td>
										<td><%=strEC_res[1] %></td>
										</tr>
								<%}}} %>
								</table>
							</td>
						</tr>
						
						<tr class="tblhead">	
							<td colspan="4"><b>Comments</b></td>
						</tr>
						<tr>	
							<td colspan="4"><%=Helper.correctNull((String)arrCol.get(9))%></td>
						</tr>
						
						<BR>
						
						</table>
						</div>
					</td>
				</tr>
				<%} }%>
				<tr><td>&nbsp;</td></tr>
			
				<%if(strPrdtype.equalsIgnoreCase("pH")||strPrdtype.equalsIgnoreCase("pM")||strPrdtype.equalsIgnoreCase("pA")){ 
				ArrayList g1 = new ArrayList();
			ArrayList v = (ArrayList) hshValues.get("vecRow");
			if (v != null && v.size()>0) {%>
			<tr class="tblhead">
			<td>
			<span style="float: left;">Valuation Entry</span><span style="float: right;">[Amount in <%=strAmountVal %>]</span>
			</td>
			</tr>
			<tr><td>
			<div id="top"><table width="100%">
			<tr class="tblhead">
			<td >Security ID</td>
			<td >Date of valuation</td>
			<td >Panel valuer name</td>
			<td >Category Code</td>
			<td >Market value of land </td>
			<td >Market value of building </td>
			<td >Estimated value </td>
			<td >Details entered in remarks Column</td>
			
			</tr>
				<%
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
					 <tr>
					 <td><%=Helper.correctNull((String)g1.get(18))%></td>
					 <td><%=Helper.correctNull((String)g1.get(13))%></td>
					 <%if(("2122").equalsIgnoreCase(Helper.correctNull((String)g1.get(24)))) {%>
					  <td><%=Helper.correctNull((String)g1.get(15))%>-<%=Helper.correctNull((String)g1.get(25))%></td>
					 <%}else{ %>
					 <td><%=Helper.correctNull((String)g1.get(15))%></td>
					 <%} %>
					 <td><%=Helper.correctNull((String)g1.get(17))%></td>
					 <td align="right"><%=Helper.converAmount(Helper.correctDouble((String)g1.get(6)),strAmountForm)%></td>
					  <td align="right"><%=Helper.converAmount(Helper.correctDouble((String)g1.get(7)),strAmountForm)%></td>
					 <td align="right"><%=Helper.converAmount(Helper.correctDouble((String)g1.get(8)),strAmountForm)%></td>
					 <td><%=Helper.correctNull((String)g1.get(9))%></td>
					 </tr>
					 
					<%}
													
			}%>
			</table>
			</div>
			</td></tr>
			<!-- for sec -->
			<%if(strPrdtype.equalsIgnoreCase("pH")){ %>
			<tr><td>
			<div id="top"><table width="100%">
			<tr class="tblhead">
			<td >Security ID</td>
			<td >Nature of property</td>
			<td >Area of land</td>
			<td >Built up area</td>
			<td >Forced Sale Value</td>
			
			
			</tr>
				<%
			if (v != null) {
				int vecsize1 = v.size();
				for (int l = 0; l < vecsize1; l++) {
					g1 = (ArrayList) v.get(l);

					%>
					 <tr>
					 <td><%=Helper.correctNull((String)g1.get(18))%></td>
					 <td><%=Helper.correctNull((String)g1.get(19))%>-<%=Helper.correctNull((String)g1.get(20))%></td>
					 <td><%=Helper.correctNull((String)g1.get(21))%></td>
					 <td><%=Helper.correctNull((String)g1.get(22))%></td>
					 <td align="right"><%=Helper.converAmount(Helper.correctDouble((String)g1.get(23)),strAmountForm)%></td>
					 </tr>
					 
					<%}
													
			}%>
			</table>
			</div>
			</td></tr>
			<%} %>
			<!-- end -->
			<%}} %>
			
			<%--<tr>
			<td>&nbsp;</td>
			</tr>
			<% String strnpacon=Helper.correctNull((String)hshValues.get("npa_concession"));
			
			if(!strnpacon.equalsIgnoreCase("")){
			%>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td><b><%=i++%>. Any other concession sought:</b></td>
			</tr>
			<tr>
			<td style="text-align: justify">&nbsp;<%=Helper.correctNull((String)hshValues.get("npa_concession")) %></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
			<tr>
			<td>&nbsp;</td>
			</tr> --%>
			
			
			
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td><b><%=i++%>. CERSAI Details:</b></td></tr>
			<tr>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("CER_CERSAIDETAILS")) %></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%-- 
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td><b><%=i++%>. Rating Details:</b></td></tr>
			<tr>
			<td style="text-align: left"> a. Rating Score&nbsp;&nbsp;:<%=Helper.correctNull((String)hshValues.get("strcre_rating")) %></td>
			</tr>
			<tr>
			<td style="text-align: left"> b. Rating label&nbsp;&nbsp;&nbsp;: <%=Helper.correctNull((String)hshValues.get("strcre_weight")) %></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>--%>
			<tr>
			<td>
			<div id="top">
			<table width="100%" >
			<tr class="tblhead">
			<td><b><%=i++%>. Concession sought in rate of interest if any with comments:</b></td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<tr>
			<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
	    	<%}else{ %>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("npa_concession")) %></td>
			<%} %>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td><b><%=i++%>. Ratification if any:</b></td></tr>
			<tr>
			<%if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
				<td width="30%"> NA</td>
	    	<%}else{%>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("npa_ratification")) %></td>
			<%} %>
			</tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<tr width="95%">
			<td>
			<table width="100%">
			<tr class="tblhead">
			<td><b><%=i++%>. Any other relevant Information:</b></td></tr>
			<tr>
			<% if(sessionModuleType.equalsIgnoreCase("DIGI")){%>
					<td width="30%"> NA</td>
	    	<%}else{ %>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("CER_OTHERINFORMATION")) %></td>
			<%} %>
			</tr>
			<tr>
			<td>
			&nbsp;
			</td>
			</tr>
			</table>
			</td>
			</tr>
			<br>
			  <% if(!APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("pR")) {%>
			<%if((strPrdtype.equalsIgnoreCase("pH"))|| (strPrdtype.equalsIgnoreCase("pA")&& (prd_purpose.equalsIgnoreCase("N")||prd_purpose.equalsIgnoreCase("U")))){
			
			%>
			<tr>
				<tr>
			<td>
			<div id="top">
			<table width="100%" >
			<tr class="tblhead">
			<tr>
			<td colspan="2" class="tblhead"><b><%=i++%>. Reason For Manual Processing</b></td></tr>
			<tr>
			<td>DIGI Application Number</td>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("APP_DIGIAPPNO")) %></td>
			</tr>
			<tr>
			<td>Eligible Under DIGI</td>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("streligdigi")) %></td>
			<tr>
			<td>Reason</td>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("STAT_DATA_DESC")) %></td>
			</tr>
			<%if((Helper.correctNull((String)hshValues.get("otherreason")).equalsIgnoreCase("007"))||(Helper.correctNull((String)hshValues.get("otherreason")).equalsIgnoreCase("015"))){ %>
			<tr>
			<td>Other Reason</td>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("APP_OTHERREASON")) %></td>
			</tr>
			<%} %>
			<%if((Helper.correctNull((String)hshValues.get("commentreason")).equalsIgnoreCase("006"))){ %>
			<tr>
			<td>Comments</td>
			<td style="text-align: justify"><%=Helper.correctNull((String)hshValues.get("APP_COMMENTS")) %></td>
			</tr>
			<%} %>
			</table>
			</div>
			</td>
			</tr>
			<%}} %>
			<br>
			
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="4"><b><%=i++%>. MIS Details</b></td>
				    </tr>
					<tr class="tblhead">
					<td width="25%" align="center"><b>Descriptions</b></td>	
					<td width="25%" align="center"><b>Facility</b></td>
					<td width="25%" align="center"><b>Descriptions</b> </td>	
					<td width="25%" align="center"><b>Facility</b></td>				
					</tr>
					<tr>
				<%if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>	
					<td align="left">Name of Bank Schematic Loan<br><br> Bank Sub Scheme</td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc"))%> <br><br><br>&nbsp;<%=Helper.correctNull((String)hshValues.get("prd_subcatscheme"))%> </td>
				<% } else { %>
					<td width="25%">Name of Bank Schematic Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc")) %></td>
				<% } %>	
					<td width="25%">Guarantee covered BY</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_Guarantee Covered")) %></td>				
					</tr>
					<tr>
					<td width="25%">Activity Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_activitycode")) %></td>
					<td width="25%">Guarantee Covered Amount</td>	
					<td width="25%"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("app_guaranteeamt")),strAmountForm) %></td>		
									
					</tr>
					<tr>
					
					<td width="25%">Main Activity</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_mainactivitydesc")) %></td>	
					<%if(Helper.correctNull((String)hshValues.get("strisGovtScheme")).equalsIgnoreCase("1")){ %>
					<td width="25%" >Name of the Govt Sponsored Scheme</td>
					<td width="25%" colspan="3"><%=Helper.correctNull((String)hshValues.get("mis_govnysponser"))%>
					<%if(!Helper.correctNull((String)hshValues.get("strGovtCategory")).equalsIgnoreCase("")){ %>
					- ( <%=Helper.correctNull((String)hshValues.get("strGovtCategory")) %> )
					<%} %>
					</td>
					<%}else{ %>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<%} %>					
					</tr>
					<tr>
					<td width="25%">Sub Activity</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subactdesc")) %></td>
					<td width="25%">Industry Category Type</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_indcattyepagr"))%></td>
									
					</tr>
					<tr>
					<td width="25%">Purpose</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_purpose")) %></td>	
					<td width="25%">Sector of Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sctortloan"))%></td>
										
					</tr>
					
					<tr>
					<td width="25%">BSR Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsrcodedesc")) %></td>
					<td width="25%">Sub Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subscetroloan"))%></td>
					</tr>	
					<tr>
					
					<td width="25%">BSR1 Code</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsr1codedesc")) %></td>	
					<td width="25%">Sensitive Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sensitivitysec"))%></td>
									
					</tr>
					
					<tr>
					<td width="25%">Investment in Plant & Machineries/Equipments</td>
					<td width="25%"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("app_plantval")),strAmountForm) %></td>
					<td width="25%">Weaker Section</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_weaksection"))%></td>
							
					</tr>		    	
					<tr>
					<td width="25%">Industry Name </td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_indname")) %></td>
					<td width="25%">Infrastructure</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_infrastructure"))%></td>
					</tr>
					<tr>
					<td width="25%">Investment value as on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("APP_INVESTMENT_DATE")) %></td>
					<%if(!Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Government announced scheme</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")) %></td>
					<%} %>					
					</tr>
					<tr>
					<td width="25%">Criteria for Investment value</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("APP_CRITERIA_INVESTMENT")) %></td>
					<%if(!Helper.correctNull((String)hshValues.get("mis_StandupDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Stand Up India</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_StandupDesc")) %></td>		
					<%} %>	
					
					</tr>
					<tr>
						<td width="25%">Sales Turnover of the Applicant </td>	
					<td width="25%"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("PERAPP_SALES_TURNOVER")),strAmountForm)%></td>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					</tr>
					<tr>	
					<td width="25%">Sales Turnover As on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER_DATE")) %></td>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					</tr>		
					<tr>
					<td width="25%">Criteria for Sales Turnover </td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strcrtsales")) %></td>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
										
					</tr>
					<tr>
					<%if(Helper.correctNull((String)hshValues.get("minoritychk")).equalsIgnoreCase("Y")){ %>
					<td width="25%">Whether Start up as per definition of Ministry of Commerce and Industry</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strministry")) %></td>
					<%}else{ %>
				     <td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<%} %>
					</tr>
					
								    	
				</table>
			</div>
			</td></tr>
			<tr><td>&nbsp;</td></tr>
			<tr><td>
				<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="4"><b><%=i++%>. CBS Details</b></td>
				    </tr>
				    <tr >
					<td width="50%" align="center" colspan="2" ><b>Facility Availing Branch</b></td>	
					<td width="50%" colspan="2" ><%=Helper.correctNull((String)hshValues.get("strOrg_Name")) %></td>	
					</tr>
			</table></div></td></tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<tr>
				<td>
					<div id="top">
						<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
						<tr>
							<td align="left" colspan="8" ><b><%=i++%>.Whether Background Information search conducted</b></td>
						<tr>
						<%if(str_birflag.equalsIgnoreCase("Y")){ %>
						<tr class="tblhead">
							<td align="center" width="10%">BIR Required</td>
							<td align="center" width="10%">Date of submission </td>
							<td align="center" width="10%">Date of receipt </td>
							<td align="center" width="10%">BIR Process Date</td>
							<td align="center" width="10%">BIR charges</td>
							<td align="center" width="10%">BIR Service Name </td>
							<td align="center" width="10%">Quality of report</td>
							<td align="center" width="10%">Over all opinion of prospective borrower</td>
						</tr>
						<tr>
							<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_flag1"))%></td>
							<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_submitteddate"))%></td>
							<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_receiptdate"))%></td>
							<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_processdate"))%></td>
							<td width="10%" align="center"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("bir_charges")),strAmountForm)%></td>
						
						<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_service_name"))%></td>
							<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_quality_report"))%></td>
							<td width="10%" align="center"><%=Helper.correctNull((String)hshValues.get("bir_opinion_all"))%></td>
						
						</tr>
						<tr>	
							<td colspan=8"><%=Helper.correctNull((String)hshValues.get("bir_comments"))%></td>
						
						</tr>
						<%}else{ %>
						<tr>	
							<td align="left" width="25%"  class="tblhead">BIR Required</td>
							<td align="left" width="25%"  class="tblhead">Reason for Not obtaining BIR</td>
							</tr>
							<tr>
							<td align="left" width="25%"><%=Helper.correctNull((String)hshValues.get("bir_flag1"))%></td>
						   <td align="left" width="25%"><%=Helper.correctNull((String)hshValues.get("bir_comments"))%></td>
						</tr>
						<%} %>
						
						</table>
				</div>
			</td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%String strcpccmt=Helper.correctNull((String)hshValues.get("cpccomments"));
			
			if(!strcpccmt.equalsIgnoreCase("")){
			%>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td><b><%=i++%>.CPC OBSERVATIONS:</b></td></tr>
			<tr>
			<td style="text-align: justify">&nbsp;<%=Helper.correctNull((String)hshValues.get("cpccomments")) %></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%if(arrCHRow!=null && arrCHRow.size()>0){ %>
			
			<tr><td><b><%=i++%>.Check List</b></td></tr>
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr class="tblhead" align="center">
			<td width="5%">S.No</td>
			<td width="35%">Appraisal</td>
			<td width="10%">Value</td>
			<td width="25%">Remarks</td>
			</tr>
			
			<%for(int a=0;a<arrCHRow.size();a++){ 
			arrCol=(ArrayList)arrCHRow.get(a);%>
			
			<tr>
			<td align="center"><%=a+1 %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol.get(0))%></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
			<td><%=Helper.correctNull((String)arrCol.get(2))%></td>
			</tr>
			<%} %>
			<tr>
			</table>
			</div>
			</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<%} %>
			<%String strrec=Helper.correctNull((String)hshValues.get("Recommendation"));
			if(!strrec.equalsIgnoreCase("")){ %>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
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
			
			
			<%  String strfacnature=Helper.correctNull((String)hshValues.get("facnature"));
			
			if(!strfacnature.equalsIgnoreCase("")){
			%>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="9"><b><span style="float: left;">A. Sanction Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td></tr>
					<tr class="tblhead">
						<td width="5%" align="center">Sl. No</td>
						<td width="15%" align="center">Facility</td>
						<td align="center" colspan="2">Limit</td>
						<td width="10%" align="center">Rate Of Interest (%)</td>
						<td width="15%" align="center">Margin (%)</td>
						<td width="5%" align="center">Period (in Months)</td>
						<td width="15%" align="center">Mode of repayment</td>	
						<td width="15%" align="center">Due Date</td>	
					</tr>
					<%if(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strInsurancePremium")))!=0){%>
					<tr>
					<td align="center" rowspan="3">1.</td>
					<td rowspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					<td>Loan Sanction Amount</td>
					
					<%if(!Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF")){ %>
						<td align="right">&nbsp;<%=Helper.converAmount(String.valueOf(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SancAmount")))-Double.parseDouble(Helper.correctDouble((String)hshValues.get("strInsurancePremium")))),strAmountForm)%>&nbsp;</td>
						<%}else{ %>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("SancAmount")),strAmountForm)%></td>
						<%} %>
						
					<td align="center" rowspan="3">&nbsp;
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
					
					<%=Helper.correctDouble((String)hshValues.get("ROI"))%>&nbsp; %
					<%} %></td>
					<td align="center" rowspan="3">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Margin"))%>&nbsp;</td>
					<td align="center" rowspan="3">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Terms"))%>&nbsp;</td>		
					<td align="center" rowspan="3">&nbsp;<%=Helper.correctDouble((String)hshValues.get("repaytype"))%>&nbsp;</td>
					<td align="center" rowspan="3"><%=Helper.correctNull((String)hshValues.get("strDueDate"))%>&nbsp;</td>	
					</tr>
					<tr>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strInsCompname"))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strInsurancePremium")),strAmountForm)%></td>
					</tr>
					<tr>
					<td>Total Loan Sanction Limit</td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("SancAmount")),strAmountForm)%></td>
					</tr>
					<%}else{ %>
					<tr>
					<td align="center">1.</td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					<td align="right" colspan="2">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("SancAmount")),strAmountForm)%>&nbsp;<br/>Without any insurance coverage.</td>
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
					<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("strDueDate"))%>&nbsp;</td>	
					</tr>
					<%}%>	
					
					<tr>
					<% if(strSessionModuleType.equals("DIGI")){ %>
					<% if(!strRoiConcession.equalsIgnoreCase(""))
					{%>
					<td colspan="9">Concession Interest: <%=strRoiConcession%>%</td> </tr>
					
					<% }if(!strRoiPenalty.equalsIgnoreCase(""))
					{%>
					<tr>
					<td colspan="9">Penalty Interest:  <%=strRoiPenalty%>%</td> 
					<%} }%>						
					</tr>
									
					
					<tr>
					
					<% if(strSessionModuleType.equals("DIGI")){ %>
					
					
					<td colspan="9">Processing/Upfront Fee : Rs. <b><%=Helper.correctNull((String)hshValues.get("strProcessingFee")) %></b> Inclusive of all Taxes </td> 
						
						<% } else { %>
						
					<% if(Helper.correctNull((String)hshValues.get("phpa_loan_purpose")).equals("H") &&
							Helper.correctNull((String)hshValues.get("phpa_project_finance")).equals("Y")){%>
							<td colspan="9">Processing Charges : Waived </td>	
					<%}else if(Helper.correctNull((String)hshValues.get("strProcessingFee")).equals("W")) {%>
						<td colspan="9">Processing Charges : Waived </td>	
					<% }else { %>
						<td colspan="9">Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("strProcessingFee")) %></b> 
						+ Applicable Taxes
						<%} %>
						
						</tr>	
					<% } %>
				</table>
			</div>
			</td></tr>
			<%} %>
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<%if(!Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("NC")&&!Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("")){ %>
					<tr>
						<td width="25%" colspan="4"><b>Insurance Details : </b></td>
					</tr>
					<tr>
						<td width="25%">Premium Tenor<br>(in Months) </td>
						<td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_PREMIUM_TENOR"))%></td>
						<td width="25%">Loan amount covered under the scheme </td>
						<td width="25%">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("LOAN_PREMIUM_LOAN_AMOUNT")),strAmountForm)%>&nbsp;</td>
					</tr>
					<%} %>
			<%if(Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF")){ %>
					<tr>
						<td width="25%">Premium Amount </td>
						<td width="25%" colspan="3">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strInsurancePremium")),strAmountForm)%></td>
					</tr>
					<tr>
						<td width="25%">Operative account number from which<br> premium account will be debited </td>
						<td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_INS_ACCOUNT_NO"))%></td>
						<td width="25%">Insurance Funded Company Name </td>
						<td width="25%" >&nbsp;<%=Helper.correctInt((String)hshValues.get("strInsFundedCompname"))%>&nbsp;</td>
					</tr>
					<%} %>
			</table>
			</td>
			</tr>
			
		<tr>
		<td>
		<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
				<%if(StrverCFR.equalsIgnoreCase("Y")) {%>
				<tr>
					<td width="40%">Whether verfied with Central Fraud Registry ?</td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strVerifyWithCFR"))%></b></td>
				</tr>
				
							
				<tr>
					<td width="40%">Whether Applicant/Co-applicant/Guarantor/<br>Proprietor/Partner name appears in CFR ?</td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strNamApprCFR"))%></b></td>
				</tr>
				<%
				}if(StrNameCFR.equalsIgnoreCase("Y")) {%>	
				<tr>
					<td width="40%">CFR Deviation Reference number</td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("RefNoCFR"))%></b></td>
				</tr>
				<%}if(strStatus.equalsIgnoreCase("A")||strStatus.equalsIgnoreCase("R")) { %>	
				<tr>
					<td width="40%">Status</td>
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
			<td>&nbsp;</td>
		</tr>
		
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
						<td colspan="4"><b>B. Repayment Details:</b></td>
					</tr>		
				    		
					<tr>
						<td width="25%"><b>Whether EMI</b></td>
						<td width="25%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("WhetherEMI"))%></b></td>
						<td width="25%"><b>Holiday Period</b></td>
						<td width="25%" >&nbsp;<%=Helper.correctInt((String)hshValues.get("strHolidayPeriod"))%>&nbsp;</td>
					</tr>
					<tr>
						<td><b>Installment Frequency</b></td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPeriodicity"))%></td>
						<td><b>Interest Frequency</b></td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strIntFreq"))%></td>		
					</tr>	
					<tr>
						<td><b>Collect Interest During Holiday Period</b></td>
						<td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("loan_servised"))%></b></td>
						<td><b>No. of installments excluding holiday period</b></td>
						<%int strPeriodicityVal = 1;
						if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Monthly"))
							strPeriodicityVal = 1;
						else if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Quarterly"))
							strPeriodicityVal = 3;
						else if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Half-Yearly"))
							strPeriodicityVal = 6;
						else if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Yearly"))
							strPeriodicityVal = 12;
						if(strSchemeCode.equalsIgnoreCase("OD"))
						{ %>
						<td>&nbsp;On Demand&nbsp;</td>
						<%}else{ %>
						<td>&nbsp;<%=Integer.parseInt(Helper.correctInt((String)hshValues.get("loan_noofinstallment")))/strPeriodicityVal%>&nbsp;</td>
						<%} %>									
					</tr>											
					<%if(strPrdtype.equalsIgnoreCase("pE")){
					int intTerms = Integer.parseInt(Helper.correctInt((String)hshValues.get("Terms")));
					int intHoliday = Integer.parseInt(Helper.correctInt((String)hshValues.get("strHolidayPeriod")));
					intTerms = intTerms - intHoliday;
					%>					
					<tr>
					<td><b>EMI/ Installment Amount</b></td>
					<td colspan="3">&nbsp;In <u><%=Helper.correctInt((String)Integer.toString(intTerms))%></u> EMI [EMI will be fixed after Moratorium period of <u><%=Helper.correctInt((String)Integer.toString(intHoliday))%></u> Months]</td>
					</tr>						
					<%}else if(!strPrdtype.equalsIgnoreCase("pG") && !strPrdtype.equalsIgnoreCase("pR"))
					{
						if(!(strRepayType.equalsIgnoreCase("1")) && !strRepayType.equalsIgnoreCase(""))
						{
						if(!(strSchemeCode.equalsIgnoreCase("OD")&& strPrdtype.equalsIgnoreCase("pM")))
						{
						if(arrRepaySchedule!=null && arrRepaySchedule.size()>0)
						{%>
					<tr><td colspan="4"><b>Repayment Schedule</b></td></tr>
					<tr><td colspan="4">
					<table width="100%" cellpadding="3" cellspacing="0" border="0">					
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
					</td>
					</tr>
					<%String StrRepayComments = Helper.correctNull((String)hshValues.get("repaycomments"));
					String StrStageWiseRelease=Helper.correctNull((String)hshValues.get("stagewiserealse"));
					if(StrStageWiseRelease.equalsIgnoreCase("Y")){
						StrStageWiseRelease="Yes";
					}else if(StrStageWiseRelease.equalsIgnoreCase("N")){
						StrStageWiseRelease="No";
					}else{
						StrStageWiseRelease="";
					}
					if(!StrRepayComments.equalsIgnoreCase(""))
					{%>
						<tr><td colspan="4"><b>Terms of Repayment</b></td></tr>
					<tr><td colspan="4"><%=StrRepayComments%></td></tr>
					<%}if(!StrStageWiseRelease.equalsIgnoreCase("")){%>
					<tr><td colspan="2"><b>Stage Wise Release Of Loan </b></td>
				    <td colspan="2"><%=StrStageWiseRelease%></td></tr>
					<%} %>
					<%}}}else{%>	
					<tr>				
					<td><b>EMI/ Installment Amount</b></td>
					<td style="text-align: right;">&nbsp;<b><%=Helper.correctDouble((String)hshValues.get("loan_emi"))%></b></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					</tr>	
					<%}}%>														    	
				</table>
			</div>
			</td></tr>
			
			<tr>
			<td><b><span style="float: left;">C. Details of Offered Securities</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<%
			if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
			
			<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
			<tr align="left">
			<td><b>Prime :</b></td>
			</tr>
			<tr><td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td  align="center" width="20%"><b>Security ID</b></td>
			<td  align="center" width="40%"><b>Details of Security</b></td>
			<td  align="center" width="10%"><b>Value</b></td>
			<td  align="center" width="25%"><b>Date of Valuation</b></td></tr>
			<% 

			arrpropsecurityCol=new ArrayList();
			arrpropsecurity=new ArrayList();
			secValue = "";
			if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
				for(int a=0;a<arrpropsecurityRow.size();a++)
				{
					arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(a);
						  if(a!=0) {
					%>
					<tr>
					<td><%=Helper.correctNull((String)arrpropsecurityCol.get(3))%></td>
					<%secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.converAmount(Helper.correctDouble((String)arrpropsecurityCol.get(1)),strAmountForm)));
					if(secValue.equals("0.00")) secValue=" ";
					%>
					 <td> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
					 <td align="right"><%=secValue%></td>
					 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
					</tr>		
					<%	}
				}
			} %>
			</TABLE>
			</div><br>
			</td>
			</tr>
			<%}
			if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
			<tr>
			<td align="left"><b>Collateral:</b></td>
			</tr>
			<tr><td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td  align="center" width="20%"><b>Security ID</b></td>
			<td  align="center" width="40%"><b>Details of Security</b></td>
			<td  align="center" width="10%"><b>Value</b></td>
			<td  align="center" width="25%"><b>Date of Valuation</b></td></tr>
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
						 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(3))%></td>
						 <td> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
						 <td align="right"><%=secValue%></td>
						 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
						</tr>		
						<%	 } }%>
						</TABLE>
			</div><br>
			</td>
			</tr>
			<%}
			%>
			
			<% }else{%>
			<tr><td><b>-- Nil --</td></tr>
			<%} %>
			
			<%if(!Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")).equalsIgnoreCase("")){ %>
			<tr>
			<td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td>
			<%=Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")) %>
			</td>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
			
		<%boolean boolflag=true;
			int z=0;
			if(arrRBIGuidliness!=null && arrRBIGuidliness.size()>0){ %>
			<tr>
			<td class="title" valign="top">
			<b><%=i++ %> .RBI Guidelines /Compliances for Restructuring</b>
			</td>
			</tr>
			<tr>
				<td>
			<div id="top">
			<table width="100%" cellpadding="3" cellspacing="0" border="0"  align="center">
			<%for(int a=0;a<arrRBIGuidliness.size();a++){ 
			arrCol=(ArrayList)arrRBIGuidliness.get(a);
			
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
			<%for(int a=0;a<arrRBIGuidliness.size();a++){ 
			arrCol=(ArrayList)arrRBIGuidliness.get(a);
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
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%
			//Added by Kishan
			//if(strEmpStatus.equals("4")) { 
			//int j=0;%>
			<%--<tr>
				<td>
					<div id="top">
						<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
						    		class="outertable">
						    <tr>
								<td colspan="6"><b><%=i++%>. Farm Budget:</b></td>
							</tr>		
						    <tr class="tblhead">
	  				  	<td><b>Financial Year</b></td>
	  				  	<% for(j=0;j<5;j++){ %>
	  				  	<td align="center">YEAR <%=j+1 %></td>
	  				  	<%}%>
	  				  </tr>
	  				  <tr>
	  				  	<td><b>Net Income from Existing Crops </b></td>
	  				  	<% for(j=0;j<5;j++)
	  				  	{ 
	  				  		if (arrRow1 != null && arrRow1.size() > 0) {
	  				  			
	  				  			arrCol1 = (ArrayList)arrRow1.get(j);
	  				  	%>
	  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrCol1.get(0)))%></td>
	  				  	<%}else{%>
	  				  	<td align="center">&nbsp;</td>
	  				  	
	  				  	<%} }%>
	  				  </tr>
	  				   
	  				  <tr>
	  				  	<td><b>Net Income from Proposed Crops </b></td>
	  				  	<%
	  				  	for(j=0;j<5;j++)
	  				  	{ 
	  				  		if (arrRowP != null && arrRowP.size() > 0) {
	  				  			
	  				  			arrColP = (ArrayList)arrRowP.get(j);
	  				  	%>
	  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColP.get(0)))%></td>
	  				  	<%}else{%>
	  				  	<td align="center">&nbsp;</td>
	  				  	
	  				  	<%} }%>
	  				  </tr>
	  				 
	  				  <tr>
	  				  	<td><b>Other Agriculture Net Income</b></td>
	  				  	<%
	  				  	for(j=0;j<5;j++)
	  				  	{ 
	  				  		if (arrRowInc != null && arrRowInc.size() > 0) {
					  			
					  			arrColInc = (ArrayList)arrRowInc.get(j);
	  				  	%>
	  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColInc.get(0)))%></td>
	  				  	<%}else{%>
	  				  	<td align="center">&nbsp;</td>
	  				  	
	  				  	<%} }%>
	  				  </tr>
	  				  
	  				  <tr>
	  				  	<td><b>Total Net Income </b></td>
	  				  	<%
	  				  	for(j=0;j<5;j++)
	  				  	{ 
	  				  		if (arrRowTotPer != null && arrRowTotPer.size() > 0) {
					  			
					  			arrColTot = (ArrayList)arrRowTotPer.get(j);
	  				  	%>
	  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColTot.get(0)))%></td>
	  				  	<%}else{%>
	  				  	<td align="center">&nbsp;</td>
	  				  	
	  				  	<%} }%>
  				  		</tr>		
						</table>
					</div>
				</td>
			</tr>
			<% if (arraySizeDSS != 0){
					int width=arraySizeDSS*15;
					width=width+25;
					if(width>100)
					{
						width=100;
					}
					%>	
					

						<tr>
 		<td>
 		<table width="100%" border="0" cellspacing="0" cellpadding="3">
	 		<tr>
	 		<td class="title"><br><b><%=i++%>.&nbsp;Debt Servicing Statement :</b></td>
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
		 int t=0,p=0;
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
					<table border="0" cellspacing="0" cellpadding="2" width="100%">
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
					for (k = p; k < t; k++) {
							arrColDSS = new ArrayList();
							arrColDSS = (ArrayList) arrRowDSS.get(k);
							double totalValue = 0.00;
							double totalValue1 = 0.00;
				%>
				<td valign="top"  width="15%">
				<div id="top">
				<table border="0" cellspacing="0" cellpadding="2" width="100%" >
					<tr height="25">
						<td align="center" nowrap="nowrap">&nbsp;<b>Year&nbsp; <%=k+1%></b>&nbsp;</td></tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(6))))%></td>
						<%hshForCalc.put("Netincome"+k,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(6)))));%>
					</tr>
						<tr height="25">
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(5))))%></td>
						<%hshForCalc.put("OtherIncome"+k,Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrColDSS.get(5))))); %>
					</tr>
					
					<%
					if(arrBankRow!=null && arrBankRow.size()>0){%>
					
					<tr height="25">
						<td align="right">&nbsp;</td>
					</tr>
						<% 
						for(int b=0;b<arrBankRow.size();b++){
							arrBankExisEmiDataRow = (ArrayList)hshDSS.get("arrBankExisEmiDataRow"+k+b);
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
						for(int b=0;b<arrOthBankRow.size();b++){
							arrOthBankDataRow = (ArrayList)hshDSS.get("arrOthBankExisDataRow"+k+b);
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
						<td align="right" nowrap="nowrap">Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrOthBankDataCol.get(0))))</td>
					</tr>
					<tr height="25">
						<td align="right" nowrap="nowrap"><%=arrOthBankDataCol.get(1)%>
							</td>
					</tr>
					<%}else if((Helper.correctNull((String)arrOthBankDataCol.get(2)).equalsIgnoreCase("OD"))){%>
						<%}%>
						<tr height="25" >
						<td align="right">&nbsp;</td>
					</tr>
						<tr height="25">
						<td align="right" nowrap="nowrap"><%=arrOthBankDataCol.get(1)%>
							</td>
					</tr>
						<% }
					}%>
					<%
					if(arrBankPropRow!=null && arrBankPropRow.size()>0){%>
					<tr height="25" >
						<td align="right">&nbsp;</td>
					</tr>
						<% 
						for(int b=0;b<arrBankPropRow.size();b++){
							arrBankPropEmiDataRow = (ArrayList)hshDSS.get("arrBankPropEmiDataRow"+k+b);
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
					hshForProposed.put("Total"+k,Double.toString(totalValue1));
					%>
	                 
					<tr height="25">
					    <%
					    if(hshForProposed.size()>0 && hshForProposed!=null)
					    {					    	
					    %>					  
						<td align="right" nowrap="nowrap"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshForProposed.get("Total"+k))))%></td>
						<%}%>											  
					</tr>
					    <%
					    dblNetIncome = Double.parseDouble(Helper.correctDouble((String)hshForCalc.get("Netincome"+k)));
					    dblOtherIncome = Double.parseDouble(Helper.correctDouble((String)hshForCalc.get("OtherIncome"+k)));
					    dblTotIncome = Double.parseDouble(Helper.correctDouble((String)hshForProposed.get("Total"+k)));
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
			<tr>
				<td align="left">&nbsp;<b>Average % of Net Surplus :</b></td>
				<td align="right" colspan='<%=t%>'><%=Helper.formatDoubleValue((dblAverageVal/arraySizeDSS))%></td>
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
			}}%>
			<%if(hshFinValues!=null && hshFinValues.size()>0){ %>
			<tr>
			<td><b><%=i++%>.&nbsp;DSCR</b></td>
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
			</tr>--%>
			<%//} } %>
			
			
			<tr>
	<td>
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="1">
	<tbody>
	<tr>
			
			<td>Interest Deviation Ref No</td>
			<td><%=Helper.correctNull((String)hshValues.get("com_interest_refno"))%></td>
		</tr>
		<tr>
			<td>Permission Proposal No</td>
			<td><%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%></td>
		</tr>
		</table>
		</td>
		</tr>
			
			<tr>
				<td><b>Terms and Conditions:</b></td>
			</tr>
			<%if(lngDatediff>=0){ %>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>General Conditions:</b></td>
			</tr>
			<tr>
				<td style="border: none;"><b>Pre Disbursement Conditions:</b></td>
			</tr>
			<% 
				k=1;
			arrRow = (ArrayList) hshValues.get("arrRowTerms");

					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("G") &&(Helper.correctNull((String)arrCol.get(2))).equalsIgnoreCase("pre")){
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
			<%} %> 
			<tr>
				<td style="border: none;"><br/><b>Post Disbursement Conditions:</b></td>
			</tr>
			<% 
				k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("G") &&(Helper.correctNull((String)arrCol.get(2))).equalsIgnoreCase("post")){
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
			<%} %> 
			</table>
			</div>
			</td>
			</tr>
			
			
			<%} %>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>Specific Conditions:</b></td>
			</tr>
			<% 
					k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("P")){
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
				<td style="border: none;">
				<%if(lngDatediff<0){ %>
				<b>General Conditions:</b>
				<%}else{ %>
				<b>Product based Terms & Conditions:</b>
				<%} %>
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
				<td style="border: none;"><b>Instructions to the branch:</b></td>
			</tr>
			
			<% 
					k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
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
			<%}} %> 
			</table>
			</div>
			</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			
<%
		int intDelegation=0;
		ArrayList arrPropFlow=(ArrayList)hshValues.get("arrPropFlow");
		if(arrPropFlow!=null && arrPropFlow.size()>0)
	{
			if(arrPropFlow.size()>5)
				intDelegation=5;
			else
				intDelegation=arrPropFlow.size();

			if(arrPropFlow!=null && arrPropFlow.size()>0){
			%>

		<tr>
			<td>
			<table width="95%" align="center" cellpadding="0" cellspacing="0">
			<tr>
			<td>
			<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center" class="title">
					<td>Details</td></tr><tr>
					<td>Name</td></tr><tr>
					<td>Designation</td></tr>
					<tr>
					<td>Signature</td></tr><tr>
					<td>Date</td>
				</tr>
			</table>
			</div>
			</td>
			<%
			
			for(int j=0;j<intDelegation;j++)
			{
				arrCol=(ArrayList)arrPropFlow.get(j);
			%>
				<td>
				<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center" class="title">
					<td nowrap="nowrap"><%if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("S")){ %>Sanctioned By<%}else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("A")){ %>Appraised By<%}
					else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("V")){ %>Vetted By<%}else{%>&nbsp;<%} %></td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td></tr>
					<tr>
					<td nowrap="nowrap">&nbsp;</td></tr><tr>
					<td nowrap="nowrap"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
			<%}
			}
			else
			{%><td>
			<div id="top">
			<table align="center" cellpadding="3" cellspacing="0" width="100%">
				<tr align="center">
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td></tr><tr>
					<td>&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
				
			
			</tr>
			</table>
			</td>
		</tr>
		<%}}%>
		
			
			<tr>
				<td><b>Sanction Date: </b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<br>
</body>
</html>
