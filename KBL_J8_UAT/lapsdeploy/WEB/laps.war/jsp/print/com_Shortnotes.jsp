<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
String strOrgLevel=(String)session.getAttribute("strOrgLevel");
String strFinancialrequired="";
String strLoanType="";
boolean finacial_flag=false;
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
ArrayList arrFacilityTerm0= new ArrayList();
ArrayList arrFacilityIdVal0 = new ArrayList();
ArrayList arrParentID0 = new ArrayList();
ArrayList arrFacilityTermApp0 = new ArrayList();
ArrayList arrRowprop= new ArrayList();
ArrayList arrColprop= new ArrayList();
ArrayList arrRowtemp= new ArrayList();
ArrayList arrColtemp= new ArrayList();
if(hshValues!=null&&hshValues.size()>0)
{
arrFacilityTerm0 = (ArrayList)hshValues.get("arrFacilityTerm0");
 arrFacilityIdVal0 = (ArrayList)hshValues.get("arrFacilityIdVal0");
 arrParentID0 = (ArrayList)hshValues.get("arrParentID0");
arrFacilityTermApp0 = (ArrayList)hshValues.get("arrFacilityTermApp0");
arrRowprop= (ArrayList)hshValues.get("arrRowprop");

}


ArrayList arrPresentTL=new ArrayList();
ArrayList arrCOPMjrRow=new ArrayList();
ArrayList arrMOFMjrRow=new ArrayList();
ArrayList arrCOPRow=new ArrayList();
ArrayList arrMOFRow=new ArrayList();
ArrayList arrCOPNewRow=new ArrayList();
ArrayList arrReleaseRow=new ArrayList();
ArrayList arrImplSchRow=new ArrayList();
ArrayList arrImplSchCol=new ArrayList();
ArrayList arrPresentWC=new ArrayList();
ArrayList arrTORow=new ArrayList();
ArrayList arrExpRow=new ArrayList();
ArrayList arrAssmntRow=new ArrayList();
ArrayList arryInland=new ArrayList();
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
ArrayList arrMCLRRow = new ArrayList();


String strTOLabel[]	= {"Particulars","Projected Sales","Accepted projected Sales","25% of accepted sales","Minimum Margin required (5% of accepted sales)",
"Eligible Finance as per Norms","Actual Margin available in the System","Eligible Bank Finance as per availability of actual Margin","Permissible Bank Finance","Limits sought","Limit proposed","Required Margin","Surplus/ Shortfall(-) in required Margin"};
String strExpLabel[]={"Particulars","Projected expenditure","Accepted projected expenditure","Operational cycle(45/ 60/ 75/ 90 days)",
"Eligible expenditure","Permisible finance","Limits sought","Limit proposed"};

double dblVal	= 0.00;
boolean booAssFlag=true;
int count=0;

HashMap	 hshFinmethod1	= new HashMap();
hshFinmethod1	= (HashMap)hshValues.get("method1"); 

HashMap	 hshFinmethod2	= new HashMap();
hshFinmethod2	= (HashMap)hshValues.get("method2"); 

HashMap	 hshFinmethod3	= new HashMap();
hshFinmethod3	= (HashMap)hshValues.get("method3"); 

HashMap	 hshFinDSCR	= new HashMap();
hshFinDSCR	= (HashMap)hshValues.get("DSCRhshFinValues"); 

HashMap	 hshFinSEN	= new HashMap();
hshFinSEN	= (HashMap)hshValues.get("SENSITIVITYhshFinValues"); 

String str_arry = Helper.correctNull((String)hshValues.get("str_arr")); 

if(hshValues!=null&&hshValues.size()>0)
{
	arrRow = (ArrayList)hshValues.get("arrRow");
	arrFacRow = (ArrayList)hshValues.get("arrFacRow");
	arrRecommRow = (ArrayList)hshValues.get("arrRecommRow");
	arrRowNonBr	= (ArrayList)hshValues.get("arrRowNonBr");
	arrDeleRow = (ArrayList)hshValues.get("arrDeleRow");
	arrBAOurRow	= (ArrayList)hshValues.get("arrBAOurRow");
	arrFACexistingRow = (ArrayList)hshValues.get("arrFACexistingRow");
	arrFAConlyRow = (ArrayList)hshValues.get("arrFAConlyRow");
	strLoanType=Helper.correctNull((String)hshValues.get("strLoanTypeNew"));
	strFinancialrequired=Helper.correctNull((String)hshValues.get("Financialrequired"));
	if(strLoanType.equalsIgnoreCase("a"))
	{
		if(strFinancialrequired.equalsIgnoreCase("Y"))
				{				
			finacial_flag=true;
					
				}
		
	}
	else
	{
		finacial_flag=true;	
	}
	
	arrPresentTL = (ArrayList) hshValues.get("arrPresentTL");
	arrCOPMjrRow	= (ArrayList)hshValues.get("arrCOPMjrRow");
	arrMOFMjrRow	= (ArrayList)hshValues.get("arrMOFMjrRow");
	arrCOPRow		= (ArrayList)hshValues.get("arrCOPRow");
	arrMOFRow		= (ArrayList)hshValues.get("arrMOFRow");
	arrCOPNewRow	= (ArrayList)hshValues.get("arrCOPNewRow");
	arrReleaseRow	= (ArrayList)hshValues.get("arrReleaseRow");
	arrImplSchRow = (ArrayList) hshValues.get("arrImplSchRow");
	arrPresentWC = (ArrayList) hshValues.get("arrPresentWC");
	arrTORow		= (ArrayList)hshValues.get("TurnOver");
	arrExpRow		= (ArrayList)hshValues.get("arrExpRow");
	arrAssmntRow    = (ArrayList)hshValues.get("arrAssmntRow");
	arryInland		= (ArrayList)hshValues.get("Inland");
	arrMCLRRow = (ArrayList) hshValues.get("arrMCLR");
	
}

String strOutstandingDate=Helper.correctNull((String)hshValues.get("strOutstandingDate"));
String strWhetherBRAvail = Helper.correctNull((String)hshValues.get("strWhetherBRAvail"));
String strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));
String strTLValIn="",strValuesIn="",strNil="Nil",strPreWC="",strExiWC="";
String strAmountValue=Helper.correctNull((String)hshValues.get("strAmountValue"));
String strAmtValueIn=Helper.correctNull((String)hshValues.get("strAmtValueIn"));
String strFinValuesIn=Helper.correctNull((String)hshValues.get("strFinvalues"));
String strprd_purpose=Helper.correctNull((String)hshValues.get("prd_purpose"));

if(strValIn.equalsIgnoreCase("Rs"))
{
	strValuesIn	= "(Amount in  "+strValIn+".)";
	strTLValIn="";
}
else
{
	strValuesIn	= "(Rs. in  "+strValIn+")";
	strTLValIn=strValIn;
}

if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
}
if(strFinValuesIn.equalsIgnoreCase("C")){
	strFinValuesIn="( Rs. in Crore )";
}else if(strFinValuesIn.equalsIgnoreCase("L")){
	strFinValuesIn="( Rs. in Lacs )";
}else{
	strFinValuesIn="( Amount in Rs. )";
}
java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

String strSancAuth = Helper.correctNull((String) hshValues
		.get("com_sancauthority"));
String strProposedSecurity="",strProposedSecurityComments="";
String strGroupSecFlag="",strSec_groupcomments="";
HashMap hshAN3=new HashMap();
ArrayList arrpropsecurityRow=new ArrayList();
ArrayList arrpropsecCollRow=new ArrayList();
ArrayList arrproposedFacility=new ArrayList();
ArrayList arrproposedCollateralSec=new ArrayList();
ArrayList arrproposedSecfacwise=new ArrayList();
ArrayList arrRowCollSec=new ArrayList();
String strFlag="";
String strAppSecFlag="";
String strAppSecManualFlag="",str_presanccommentsforannex="",str_postsanccommentsforannex="";
hshAN3=(HashMap)hshValues.get("AN3");
HashMap hshSecdata=new HashMap();
if(hshAN3!=null)
{
	arrpropsecurityRow=(ArrayList)hshAN3.get("arrExistingSecfacwise");
	arrpropsecCollRow=(ArrayList)hshAN3.get("arrcollateralforEF");
	strGroupSecFlag=Helper.correctNull((String)hshAN3.get("COMSEC_GROUPCOVERAGE"));
	strSec_groupcomments=Helper.correctNull((String)hshAN3.get("COMSEC_GROUPCOMMENTS"));
	arrproposedCollateralSec=(ArrayList)hshAN3.get("arrproposedCollateralSec");
	arrproposedFacility=(ArrayList)hshAN3.get("arrproposedFacility");
	strProposedSecurity=Helper.correctNull((String)hshAN3.get("strProposedSecurity"));
	strProposedSecurityComments=Helper.correctNull((String)hshAN3.get("strProposedSecurityComments"));
	strAppSecFlag=Helper.correctNull((String)hshAN3.get("COMSEC_APPCOVERAGE"));
	strAppSecManualFlag=Helper.correctNull((String)hshAN3.get("COMSEC_SECTYPE"));
	arrproposedSecfacwise=(ArrayList)hshAN3.get("arrproposedSecfacwise");
	arrRowCollSec=(ArrayList)hshAN3.get("arrRowCollSec");
	hshSecdata=(HashMap)hshAN3.get("hshsecdet");
	if(hshSecdata!=null)
	strFlag=Helper.correctNull((String)hshSecdata.get("strFlag"));

}
str_presanccommentsforannex=Helper.correctNull((String)hshValues.get("cmt_presanccomments"));
str_postsanccommentsforannex=Helper.correctNull((String)hshValues.get("cmt_postsanccomments"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
HashMap hshValuesPromotor = (HashMap)hshValues.get("PROPOSALLC");
ArrayList arrMISRow	= (ArrayList)hshValues.get("arrMISRow");
ArrayList arrColMIS	= new ArrayList();
ArrayList arrGroupconcerns=new ArrayList();
arrGroupconcerns=(ArrayList)hshValues.get("arrGroupConcerns");

String StrverCFR=Helper.correctNull((String)hshValues.get("COM_CFR_VERIFIED"));
String StrNameCFR=Helper.correctNull((String)hshValues.get("COM_CFR_BORNAME"));
String strStatus=Helper.correctNull((String)hshValues.get("STATUS_VERIFIED"));
String temp = "";
ArrayList arrCol12 = new ArrayList();
ArrayList arrRow12 = new ArrayList();
ArrayList arrRowcgssd= new ArrayList();
ArrayList arrColcgssd= new ArrayList();
if (hshValues != null){
	arrRow12 = (ArrayList) hshValues.get("arrRow2");
	arrRowcgssd= (ArrayList)hshValues.get("arrRowcgssd");

}
String strratingperc=Helper.correctNull((String)hshValues.get("COM_CGSSDPERC"));
String strDesc[] = { "Capital of the entity", "Promoters Stake",
		"Eligible Amount", "Amount Applied", "Liability of the entity",
		"Maximum loan under the scheme","Recommended (lower of 3,4,5,6)",
		"Entity Name","Parent entity  loan account number/operative account number (in case of OD)","Status of the entity","NPA Date","CBS Customer ID of parent MSME entity","Number of DPD of parent MSME entity","Whether  Parent entity is eligible  for restructure"};

String strmisDesc[] = { "Facility Desc", "Type of Facility and Facility Serail Number",
		"Activity Code", "Main Activity", "Sub Activity",
		"Agriculture/Industry/Service Category type","Sector",
		"Sub sector","Sensitive sector",
		"StandUp India","Government announced scheme","Guarantee Cover By",
		"Guarantee Covered Amount","Sales Turnover of the Applicant",
		"Sales Turnover As on Date",
		"Criteria for Sales Turnover","Investment in Plant & Machineries/Equipments","Industry Name",
		"Investment value as on Date","Criteria for Investment value","Weaker Section",
		"Whether Start up as per definition of Ministry of Commerce and Industry"
		};
%>

<html>
<head>
<title>Short Notes Proposal</title>
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

</head>
<body contentEditable="false" designMode="on">
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
else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("015")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("016")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("017")){
	%>
<tr><td align="center" width="50%"><%=Helper.correctNull((String)hshValues.get("strSanctiondept"))%></td></tr>
<%}
else{ %>
	<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("strOrgName")).toUpperCase()%></td></tr>
	<%} %>
<%} %>
<tr><td>&nbsp;</td></tr>
<tr>
	<td class="title" align="center"><br>Short Note Proposal Format</td>
</tr>
<tr>
<td align="right" width="50%">Date&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues
							.get("com_processnotedate"))%></td>
</tr>
<tr>
<td align="right" width="50%"><b>Proposal No&nbsp;:&nbsp;</b><%=Helper.correctNull((String)request.getParameter("appno"))%></td>
</tr>
<tr>
<td width="50%">
<table width="95%" cellpadding="3" cellspacing="0" border="0">
<tr><td>
<table width="95%" cellpadding="3" cellspacing="0" border="0">

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
</tr>
<tr><td align="left">BRANCH&nbsp;:&nbsp;<%=Helper.changetoTitlecase(Helper
							.correctNull((String) hshValues.get("org_name"))).toUpperCase()%></td></tr>
<tr><td align="left">REGION&nbsp;:&nbsp;<%=Helper
							.changetoTitlecase(Helper
									.correctNull((String) hshValues
											.get("Reg_org_name"))).toUpperCase()%></td></tr>


</table>
</td>
<td width="50%">
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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

<tr>
<td>
	This is a proposal received from  <b><%=Helper.correctNull((String)hshValues.get("org_name"))%></b>  Branch for considering the following 
	credit facilities to 
	<b><%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%></b>
	<br><p align="justify"><%=Helper.correctNull((String)hshValues.get("GistOfProp"))%></p>
</td>
</tr>
<tr>
	<td>
	<table width="95%" cellpadding="3" cellspacing="0" border="0">
	<tr>
	<td colspan="2">As per the Loan Application, the applicant has sought the following facilities:</td>
	</tr>
	<tr><td align="right" width="100%" colspan="6">&nbsp;&nbsp;<%=strAmtValueIn%></td></tr>
	<tr><td colspan="2">1. Fund Based</td></tr>
	<tr><td>&nbsp;&nbsp;a. Working Capital</td><td width="80%"><%=Helper.formatDoubleValue(Double.parseDouble((String)hshValues.get("INWARD_WCLOANAMT")))%></td></tr> 
	<tr><td>&nbsp;&nbsp;b. Term Loan </td><td><%=Helper.formatDoubleValue(Double.parseDouble((String)hshValues.get("INWARD_TERMLOANAMT")))%></td></tr> 
	<tr><td>2. Non Fund Based</td><td><%=Helper.formatDoubleValue(Double.parseDouble((String)hshValues.get("INWARD_NONWCLOANAMT")))%></td></tr> 	
		</table>
	</td>		
</tr>
<tr>
<td>
<!-- APPLICANT'S PROFILE -->
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
	<jsp:include page="../print/com_AnnexureII.jsp" flush="true">
	<jsp:param name="pageVal" value="PROPOSALLC"/>
	</jsp:include>
</td>
</tr>
</table>
<!-- END -->
</td>
</tr>
<tr>
<td>
<!-- APPLICANT'S PROFILE -->
   <%if(Helper.correctNull((String)hshValues.get("corprestructureval")).equalsIgnoreCase("Y")) {%>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
	<jsp:include page="../print/com_resturctur_annexure.jsp" flush="true">
	<jsp:param name="pageVal" value="PROPOSALLC"/>
	</jsp:include>
</td>
</tr>
</table>
<%} %>
<!-- END -->
</td>
</tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="title">Group Concerns</td>
		</tr>
		</table>
	</td>
</tr>

<tr>
	<td>
	<div id="top">
		<table width="70%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr align="center"  class="title">
		<td width="5%">S.No</td>
		<td width="35%">Concern Name</td>
		<td width="25%">Type of Concern</td>
		</tr>
		<%if(arrGroupconcerns!=null && arrGroupconcerns.size()>0){
			for(int i=0;i<arrGroupconcerns.size();i++){
			arrCol=(ArrayList)arrGroupconcerns.get(i);%>
			<tr>
			<td align="center"><%=i+1 %></td>
			<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %></td>
			<td><%=Helper.correctNull((String)arrCol.get(2)) %></td>
			</tr>
		<%}}else {%>
		<tr>
			<td align="center" colspan="3">- Nil -</td>
		</tr>
		<%} %>
		</table>
		</div>
	</td>
</tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<!--<tr>
			<td width="50%" class="title">Brief background of the applicant:</td>
			<td width="50%" align="right">&nbsp;</td>
		</tr>
		--><tr>
			<td width="50%" class="title"><br>Details of the existing Credit facilities:</td>
			<td width="50%" align="right">&nbsp;</td>
		</tr>
		<% if(arrBAOurRow!=null&&arrBAOurRow.size()>0){ %>
		<tr>
			<td width="50%">&nbsp;</td>
			<td width="50%" align="right"><%=strAmtValueIn%></td>
		</tr>
		<%} %>
		<tr><td><%=Helper.correctNull((String)hshValues.get("strExistingFacAbove"))%></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
		if(arrBAOurRow!=null&&arrBAOurRow.size()>0){ %>
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
		double dbLimitTotal=0.00,dbbalanceTotal=0.00;
		for(int i=0;i<arrBAOurRow.size();i++){
			arrCol	= (ArrayList)arrBAOurRow.get(i);
			dbLimitTotal=dbLimitTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
			dbbalanceTotal=dbbalanceTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));	
		%>
		<tr>
			<td align="left"><%=i+1%></td>
			<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(0))).toUpperCase()%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
			<td align="right"><%=Helper.correctNull((String)arrCol.get(11))%>&nbsp;+&nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>% p.a presently at &nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%>% p.a</td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(8))%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
		</tr>
		<%} %>
		<tr>
			<td colspan="2" align="right"><b>Total</b></td>
			<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbLimitTotal)),strAmountValue)%></b></td>
			<td colspan="3">&nbsp;</td>
			<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbbalanceTotal)),strAmountValue)%></b></td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<%}else{%>
		<tr><td style="border: none;"> - <%=strNil%> - </td></tr>
		<%} %>
		</table>
		</div>
	</td>
</tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td><%=Helper.correctNull((String)hshValues.get("strExistingFacBelow"))%></td>
		</tr>
		</table>
	</td>
</tr>
<!--<tr><td>&nbsp;</td></tr>
<tr>
<td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%//if(arrBAOurRow!=null && arrBAOurRow.size()>0){ %>
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<td width="10%" align="center"><b>Remarks</b></td>
</tr>
<%
//for(int i=0;i<arrBAOurRow.size();i++){
	//arrCol	= (ArrayList)arrBAOurRow.get(i); %>
<tr>
<td align="left"><%//=i+1%></td>
<td align="left"><%//=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
<td align="left"><%//=Helper.correctNull((String)arrCol.get(14))%></td>
</tr>
<%//}} %>
</table>
</td>
</tr>
--><tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td><br><b>Asset classification :</b>&nbsp;<%=Helper.correctNull((String)hshValues.get("strAssetClassification"))%>
			&nbsp;as on &nbsp;<%=Helper.correctNull((String)hshValues.get("com_asscladate"))%>
			</td>
		</tr>
		</table>
	</td>
</tr>

<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
<b><u>SECURITIES : </u></b></td></tr>
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
ArrayList arrpropsecurity=new ArrayList();
ArrayList arrpropsecurityCol=new ArrayList();
if((arrproposedFacility!=null && arrproposedFacility.size()>0)||(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>B. Additional / Fresh securities offered for the proposed facilities/Security released :</b><div align="right"><%=strAmtValueIn%></div></td></tr>
<tr><td><b>Additional / Fresh Securities Offered :</b></td></tr>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">


<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if(arrproposedFacility!=null && arrproposedFacility.size()>0){ %>
<tr align="left">
<td colspan="4"><b>Prime :</b></td>
</tr>
<%for(int i=0;i<arrproposedFacility.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrproposedFacility.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
					secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		<td  rowspan="<%=(arrpropsecurityCol.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		 <td align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>
		<%} else {
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		</tr>		
		<%	}}
	}
}

arrpropsecurity=new ArrayList();
arrpropsecurityCol=new ArrayList();
secValue = "";
%>
<%if(arrproposedCollateralSec!=null && arrproposedCollateralSec.size()>0){%>
<tr align="left">
<td colspan="4"><b>Collateral :</b></td>
</tr>
	<%for(int i=0;i<arrproposedCollateralSec.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrproposedCollateralSec.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	}
}
%>
</table>
</div>
</td>
</tr>
</table>
</td>
</tr>
<%} else { %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>B. Additional / Fresh securities  offered for the proposed facilities/Security released :</b> Nil</td></tr>
</table>
</td>
</tr>
<%}  %>


<%
if(!strProposedSecurity.equalsIgnoreCase("M")){
if((arrproposedSecfacwise!=null && arrproposedSecfacwise.size()>0) || (arrRowCollSec!=null && arrRowCollSec.size()>0)){ %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>C. Securities for the proposed / renewed facilities : </b><div align="right"><%=strAmtValueIn%></div></td></tr>
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
</div><br>
</td>
</tr>
</table>
</td></tr>
<% }else{%>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>C. Securities for the proposed / renewed facilities :</b> Nil</td></tr>
</table>
</td>
</tr>
<%}}else if(strProposedSecurity.equalsIgnoreCase("M")){%>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><b><br>C. Securities for the proposed / renewed facilities :</b> </td></tr>
<tr>
<td><%=strProposedSecurityComments%></td>
</tr>
</table>
</td>
</tr>
<%} %>
<!-- Starts here.. -->
<tr>
			<td>
			<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% 
			ArrayList arrpropsecurityCersaiQues=new ArrayList();
			arrpropsecurityCersaiQues=(ArrayList)hshValues.get("arrOutCersaiQues");
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
												<%=strArr1[r1]%><br/>
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
if(!strAppSecFlag.equalsIgnoreCase("M")){
	//if(strFlag.equalsIgnoreCase("E")){%>
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
<%//}else{%>
<!--<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td><b>D.Security coverage for Bank's exposure to the applicant:</b><%=strNil%></td>
</tr>
</table>
</td>
</tr>
--><%//}
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



<%  String year1 = Helper.correctNull((String)hshValues.get("txt_year1"));
	String year2 = Helper.correctNull((String)hshValues.get("txt_year2"));
	String year3 = Helper.correctNull((String)hshValues.get("txt_year3"));
	String year4 = Helper.correctNull((String)hshValues.get("txt_year4"));
	String year5 = Helper.correctNull((String)hshValues.get("txt_year5"));
	
%>

<%if(!year1.equalsIgnoreCase("")||!year2.equalsIgnoreCase("")||!year3.equalsIgnoreCase("")||!year4.equalsIgnoreCase("")||!year5.equalsIgnoreCase("")) { %>

<tr>
	<td>
		<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="title" valign="top"><br>Brief Financials:</td></tr>
			<tr><td align="right"><%=strFinValuesIn%></td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("strGroupFinancialAbovecmts"))%></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">
				<tr> 
                	<td width="25%">&nbsp;Particulars</td>
                	<%if(!year1.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year1"))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year2.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year2"))%>&nbsp;</td>
					<%} %>                  
                    <%if(!year3.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year3"))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year4.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year4"))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year5.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year5"))%>&nbsp;</td>
                  	<%} %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type1"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type2"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type3"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type4"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type5"))%>&nbsp;</td>
                  <%} %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Sales</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
              
               <%
               
               if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT41")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT42")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT43")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT44")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT45")))==0) ) )
               		{%>
               			
               			
               	<tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("COM_FREETEXT4"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT41"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT42"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT43"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT44"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT45"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
             <%}%>
              
               <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit5")))==0) ) )
          		{%>
               		
               	<tr> 
                  <td width="25%">&nbsp;Net Profit</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               		
               		  <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet5")))==0) ) )
          		{%>
          		
          		   <tr> 
                  <td width="25%">&nbsp;Net Worth</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
          		
          		<%} %>	 
              
            
            	
               		  <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw5")))==0) ) )
          		{%>
          		
          		 <tr> 
                  <td width="25%">&nbsp;Debt-Equity Ratio</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
          		<%} %>
          		
          		
          		  <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio5")))==0) ) )
          		{%>
               <tr> 
                  <td width="25%">&nbsp;TOL/TNW</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               
               
                <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn5")))==0) ) )
          		{%>
          		
          		<tr> 
                  <td width="25%">&nbsp;Current Ratio</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
          		<%} %>
               
               
                  <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext5")))==0) ) )
          		{%>
          		
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt1"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               
               
                 <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext11")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext12")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext13")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext14")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext15")))==0) ) )
          		{%>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt2"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext11"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext12"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext13"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext14"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext15"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               
                <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext21")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext22")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext23")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext24")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext25")))==0) ) )
          		{%>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt3"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext21"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext22"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext23"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext24"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext25"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               <%} %>
			</table>
		</div>
	</td>
</tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
			<tr><td><%=Helper.correctNull((String)hshValues.get("strGroupFinancialbelowcmts"))%></td></tr>
		</table>
	</td>
</tr>
<%} %>

<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<jsp:include page="../print/com_AnnexureV.jsp" flush="true">  
   <jsp:param name="pageVal" value="shortnote" /> 
   <jsp:param name="pagevalue" value="ANN5" />      
   </jsp:include>
</table>
</td>
</tr>
<tr>
	<td>
		<table width="90%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="title"><br>Present proposal:</td>
		</tr>
		<tr>
			<td><%=Helper.correctNull((String)hshValues.get("presentproposal_comment"))%></td>
		</tr>
		<tr>
			<td align="right" width="50%"><%=strAmtValueIn%></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="90%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			if(arrFACexistingRow!=null&&arrFACexistingRow.size()>0) { 
			
				strExiWC = Helper.correctNull((String)hshValues.get("strExiWClimit")).replace("@","<br>");
			%>
			<tr>
				<td width="30%">Details of existing fund based limits&nbsp;:&nbsp;</td>
				<td align="left" width="">
				<%=strExiWC%>
				</td>
			</tr>
			<%} %>
			<%
			if(arrFAConlyRow!=null&&arrFAConlyRow.size()>0) { 
			
				strPreWC = Helper.correctNull((String)hshValues.get("strPreWClimit")).replace("@","<br>");
			%>
			<tr>
				<td ><br>Details of proposed facilities:</td>
				<td align="left" width="">
				<%=strPreWC%>
				</td>
			</tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<!-- Term Loan Assessment -->
<% if(str_arry.contains("EXPORTCF@")) { %>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title"><br>Assessment of TL</td></tr>
</table>
</td>
</tr>
<%} %>
<%if(arrPresentTL!=null && arrPresentTL.size()>0){ %>
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title">Details of proposed facilities:</td></tr>
<tr>
	<td align="right" width="50%"><%=strAmtValueIn%></td>
			</tr>
<tr><td>&nbsp;</td></tr>
</table>
</td>
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
				<td align="right"><%=Helper.converAmount(Helper.correctNull((String) arrCol.get(1)),strAmountValue) %></td>
				</tr>
				<%} %>
			</table>
		</div>
		</td>
</tr>
<% }%>
<!-- COP -->
<%
String strFACSno	= "";
double dblTotalCOP=0.00,dblTotalMOF=0.00;
ArrayList arrColMOF=new ArrayList();
int intValofZ=Integer.parseInt(Helper.correctInt((String)hshValues.get("ValofM")));
	
if(arrCOPNewRow!=null&&arrCOPNewRow.size()>0)
{ %>
<%
	for(int i=0;i<arrCOPNewRow.size();i++)
	{
		arrCol	= (ArrayList)arrCOPNewRow.get(i);
		strFACSno	= Helper.correctInt((String)arrCol.get(0));
		dblTotalCOP=Double.parseDouble( Helper.correctDouble((String)arrCol.get(3)));
		/*if(arrMOFMjrRow!=null && arrMOFMjrRow.size()>0)
		{
			arrColMOF=(ArrayList)arrMOFMjrRow.get(i);
			dblTotalMOF=Double.parseDouble(Helper.correctDouble((String)arrColMOF.get(2)));
		}*/
%>
<% if(arrCOPNewRow.size() >0 ) 
{%>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title"><br>
<%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;-
<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;<%=strAmtValueIn%>
</td></tr>
</table>
</td>
</tr>
<%} %>
<% if(!Helper.correctNull((String)hshValues.get("COM_COMMENTS_COP"+strFACSno)).equalsIgnoreCase("") ) 
{ %>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<td><br><b>Brief Details of the project: </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_COP"+strFACSno))%></td>
	</tr>
	</table>
	</td>
	</tr>
<%} %>
<% if(!Helper.correctNull((String)hshValues.get("COM_COMMENTS_COProj"+strFACSno)).equalsIgnoreCase("") ) 
{ %>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<td><br><b>Comments on Project: </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_COProj"+strFACSno))%></td>
	</tr>
	</table>
	</td>
	</tr>
<%} %>

<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			double dblCOPtot=0.00,dblintMOFtot=0.00,dblMOFinttot=0.00;
			String strCOPFlag="true",strTotalCOPFlag="False";
			if(arrCOPRow!=null&&arrCOPRow.size()>0){ %>
				
				<%int k=1;
				for(int j=0;j<arrCOPRow.size();j++)
				{ 
					
				arrCol	= (ArrayList)arrCOPRow.get(j);
				if(strFACSno.equals( Helper.correctInt((String)arrCol.get(2))))
				{
				dblVal	= Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				if(dblTotalCOP!=0.00)
				dblMOFinttot= Double.parseDouble(String
						.valueOf((dblVal * 100)
								/ dblTotalCOP));
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
				<td align="right" width="50%"  colspan="4" style="border:none"><%=strFinValuesIn%></td>
				</tr>
						 
				<tr>
					<td align="center" width="3%">SI.No</td>
					<td align="center" width="57%">Particulars</td>
					<td align="center" width="20%">Amount</td>
					<td align="center" width="20%">% to total cost</td>
				</tr>
				
				<%} %>
				<tr>
					<td align="left"><%=k%></td>
					<td align="left"><%=Helper.correctNull((String)arrCol.get(0))%></td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
					<td align="right"><%=jtn.format(dblMOFinttot)%></td>
				</tr>
				<%k++;
				}}
				if(strTotalCOPFlag.equalsIgnoreCase("true")){
				%>
				<tr>
					<td colspan="2" align="center">TOTAL</td>
					<td align="right"><%=jtn.format(dblCOPtot)%></td>
					<td align="right"><%=jtn.format(dblintMOFtot)%></td>
				</tr>
				<%}}
				//else{ %>
				<%-- <tr><td style="border: none;"><%=strNil%></td></tr>--%>
				<%//} %>
			</table>
		</div>
	</td>
</tr>

<!-- MOF -->

<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%double dblMOFtot=0.00,dblintMOFtot1=0.00,dblMOFinttot1=0.00;
			String strMOFFlag="true",strTotalMOFFlag="False";
			if(arrMOFRow!=null&&arrMOFRow.size()>0){ 
			for(int j=0;j<arrMOFRow.size();j++){
				arrCol	= (ArrayList)arrMOFRow.get(j);
				if(strFACSno.equals( Helper.correctInt((String)arrCol.get(2))))
				{
				dblTotalMOF+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
			
			}}
				
				int k=1;
				for(int j=0;j<arrMOFRow.size();j++){ 
				arrCol	= (ArrayList)arrMOFRow.get(j);
				if(strFACSno.equals( Helper.correctInt((String)arrCol.get(2))))
				{
				dblVal	= Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				if(dblTotalMOF!=0.00)
				dblMOFinttot1= Double.parseDouble(String.valueOf((dblVal * 100)	/dblTotalMOF));
				dblintMOFtot1=dblintMOFtot1+dblMOFinttot1;
				dblMOFtot=dblMOFtot+dblVal;
				if(strFACSno.equals(Helper.correctInt((String) arrCol.get(2))) && strMOFFlag.equalsIgnoreCase("true"))
				{
					strMOFFlag="false";
					strTotalMOFFlag="true";
				%>
						<tr>
							<td align="left" width="50%" colspan="4" style="border:none"><b>Means of Finance:</b></td>
						</tr>
						<tr>
							<td align="right" width="50%"   colspan="4" style="border:none"><%=strFinValuesIn%></td>
						</tr>
					 
				 <tr>
					<td align="center" width="3%">SI.No</td>
					<td align="center" width="57%">Particulars</td>
					<td align="center" width="20%">Amount</td>
					<td align="center" width="20%">% to total finance</td>
				</tr>
				<%} %>
				<tr>
					<td align="left"><%=k%></td>
					<td align="left"><%=Helper.correctNull((String)arrCol.get(0))%></td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
					<td align="right"><%=jtn.format(dblMOFinttot1)%></td>
				</tr>
				<% k++;
				}}
				if(strTotalMOFFlag.equalsIgnoreCase("true"))
				{
				%>
				<tr>
					<td align="center">&nbsp;</td>
					<td align="center">TOTAL</td>
					<td align="right"><%=jtn.format(dblMOFtot)%></td>
					<td align="right"><%=jtn.format(dblintMOFtot1)%></td>
				</tr>
				<%}}
			//else{
				%>
				<%-- <tr><td style="border: none;"><%=strNil%></td></tr>--%>
				<%//} %>
			</table>
		</div>
	</td>
</tr>
<%if(strMOFFlag.equalsIgnoreCase("false")){ %>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
	<td><br><b>Debt : Equity : </b>&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("dbl_Debit"+strFACSno))%></td>
</tr>
</table>
</td>
</tr>
<%} %>

<% if(!Helper.correctNull((String)hshValues.get("COM_COMMENTS_SOM"+strFACSno)).equalsIgnoreCase("") ) {%>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<td><br><b>Source of margin money: </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_SOM"+strFACSno))%></td>
	</tr>
	</table>
	</td>
	</tr>
<%} %>

<%}

} 
else if(intValofZ==0 || intValofZ>0)
{
	
%>
	<%
		
			for(int j=0;j<=intValofZ;j++)
			{
				
				 if(!Helper.correctNull((String)hshValues.get("COM_COMMENTS_COP"+j)).equalsIgnoreCase("") ) 
				 {
				 	
					 if(arrCOPNewRow!=null&&arrCOPNewRow.size()>0)
						{
							ArrayList arrCOPNewCol	= new ArrayList();
						
						for(int x=0;x<arrCOPNewRow.size();x++)
						{
							arrCOPNewCol=(ArrayList)arrCOPNewRow.get(x);
							if(x==j)
								{
								booAssFlag=false;
				 
				 %>
				 <tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr><td class="title"><br> <%=Helper.correctNull((String)arrCOPNewCol.get(1))%></td></tr>
				 
				 	<tr>
				 		<td><br><b>Details of Present Proposal: </b></td>
				 	</tr>
				 	<tr>
				 		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_COP"+j))%></td>
				 	</tr>
				 	</table>
				 	</td>
				 	</tr>
				 <%} }
								
							}
					 }
				
			}
	
	%>
<%
} else 
{
	if(booAssFlag)
	{%>
	<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr><td style="border: none;"><%=strNil%></td></tr>
		</table>
		</td>
		</tr>
	<%}
	
}
%>
<!-- DSCR -->
<%if(hshFinDSCR!=null && hshFinDSCR.size()>0) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>DSCR</td>
			</tr>
		</table>
	</td>
</tr>
<tr><td>
<%=Helper.correctNull((String)hshValues.get("fin_comments_dscr"))%>
</td></tr>
<tr>
<td align="right" width=""><%=strFinValuesIn%></td>
</tr>
<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
		<div align="left" id="top">
			<jsp:include page="../print/DSCR_Print.jsp" flush="true">
			<jsp:param name="pageVal" value="DSCR"/>
			</jsp:include>
		</div>
		</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td><%=Helper.correctNull((String)hshValues.get("fin_comments1_dscr"))%></td>
</tr>
<%} %>

<!-- Sensitivity Ananlysis -->

<%if(hshFinSEN!=null && hshFinSEN.size()>0) { %>


<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Sensitivity Analysis:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments_sensitive")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments_sensitive"))%></td></tr>
<%} %>
<tr>
<td align="right"><%=strFinValuesIn%></td>
</tr>
<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
		<div align="left" id="top">
			<jsp:include page="../print/sensitivity_print.jsp" flush="true">
			<jsp:param name="pageVal" value="SENSITIVITY"/>
			</jsp:include>
		</div>
		</td>
		</tr>
		</table>
	</td>
</tr>

<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_sensitive")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_sensitive"))%></td></tr>
<%} %>
<%} %>
<tr>
<td>
<% 
String str_array[]={"<b>Particulars</b>","SOURCES OF FINANCE","Opening Balance"
		,"Promoters Equity","Bank Finance","Unsecured Loan","Sale proceeds/Advances","Others","TOTAL","APPLICATION OF FINANCE",
		"Cost of Land","Premium FSI & Approval Cost","Construction Cost","Marketing Expenses","Administrative Expenses","Interest","Repayment","Provision of tax","Others","TOTAL","Closing Balance"};

 count=Integer.parseInt(Helper.correctInt((String)hshValues.get("CashCount")));
if(count>0)
{
	%>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td>
				<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title"><br>Cash Flow Method</td>
						<td align="right" width="">&nbsp;</td>
					</tr>
					<% if (!Helper.correctNull((String)hshValues.get("fin_comments_cashflow")).equalsIgnoreCase("")) { %>
<tr><td colspan="2"><%=Helper.correctNull((String)hshValues.get("fin_comments_cashflow"))%></td></tr>
<%} %>
				</table>
			</td>
		</tr>
	</table>
	<%
	for(int h=0;h<count;h++)
	{
		ArrayList arrRows=(ArrayList)hshValues.get("CashFlow"+(h+1));
		ArrayList arrRows6=(ArrayList)hshValues.get("CashFlowTOT");
		int val=Integer.parseInt(Helper.correctInt((String)hshValues.get("rowcount"+(h+1))));
		%>
		<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td>
			<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
				<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title">Financial Year : <%=Helper.correctNull((String)hshValues.get("finyear"+(h+1))) %></td>
					</tr>
					<tr>
						<td align="right" width=""><%=strFinValuesIn%></td>
					</tr>
				</table>
			</td>
		</tr>
		</table>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
			int c=0,b=0;
			ArrayList arrCols=(ArrayList)arrRows.get(c++);
			ArrayList arrCols1=(ArrayList)arrRows.get(c++);
			ArrayList arrCols2=(ArrayList)arrRows.get(c++);
			ArrayList arrCols3=(ArrayList)arrRows.get(c++);
			ArrayList arrCols4=(ArrayList)arrRows.get(c++);
			ArrayList arrCols5=(ArrayList)arrRows.get(c++);
			ArrayList arrCols6=(ArrayList)arrRows6.get(0);
			
	 		for(int g=0;g<21;g++)
			{
			%>
			<tr>
				<%if(g==1 || g==9) { %>
				
					<td  colspan="<%=val%>"><b><%=str_array[g] %></b></td>
				<%}else { %>	
					<td width ="25%"><%=str_array[g] %></td>
					
					<%if(b==0) { %>
					<%if(!Helper.correctNull((String)arrCols6.get(0)).equalsIgnoreCase("")){ %>
					<td align="center" width ="15%"><%=Helper.correctNull((String)arrCols6.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols1.get(0)).equalsIgnoreCase("")){ %>
					<td align="center" width ="15%"><%=Helper.correctNull((String)arrCols1.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols2.get(0)).equalsIgnoreCase("")){ %>
					<td align="center" ><%=Helper.correctNull((String)arrCols2.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols3.get(0)).equalsIgnoreCase("")){ %>
					<td align="center" ><%=Helper.correctNull((String)arrCols3.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols4.get(0)).equalsIgnoreCase("")){ %>
					<td align="center" ><%=Helper.correctNull((String)arrCols4.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols5.get(0)).equalsIgnoreCase("")){ %>
					<td align="center" ><%=Helper.correctNull((String)arrCols5.get(b))%>&nbsp;</td>
					
					<%}}else { %>
					<%if(!Helper.correctNull((String)arrCols6.get(0)).equalsIgnoreCase("")){ %>
					<td align="right" width ="15%"><%=Helper.correctNull((String)arrCols6.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols1.get(0)).equalsIgnoreCase("")){ %>
					<td align="right" width ="15%"><%=Helper.correctNull((String)arrCols1.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols2.get(0)).equalsIgnoreCase("")){ %>
					<td align="right" ><%=Helper.correctNull((String)arrCols2.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols3.get(0)).equalsIgnoreCase("")){ %>
					<td align="right" ><%=Helper.correctNull((String)arrCols3.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols4.get(0)).equalsIgnoreCase("")){ %>
					<td align="right" ><%=Helper.correctNull((String)arrCols4.get(b))%>&nbsp;</td>
					<%} if(!Helper.correctNull((String)arrCols5.get(0)).equalsIgnoreCase("")){ %>
					<td align="right" ><%=Helper.correctNull((String)arrCols5.get(b))%>&nbsp;</td>
					
					<%}}
					b++;
					}
		 }%>
			</tr>
			</table><br>
		</div>
		<%} %>
<%} %>
</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_cashflow")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_cashflow"))%></td></tr>
<%} %>
<%if(strLoanType.equalsIgnoreCase("a")){ %>

		<tr>
	<td>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
		<div align="left" id="top">
			<jsp:include page="../print/com_agrassessment_process.jsp" flush="true">
			<jsp:param name="pageVal" value="PROCESS"/>
			</jsp:include>
		</div>
		</td>
		</tr>
		</table>
	</td>
</tr>
<%} %>	
<%if(!Helper.correctNull((String)hshValues.get("com_assessment_comments")).equalsIgnoreCase("")){ %>	
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title">Other Term Loan Assessment : </td></tr>
<tr><td ><%=Helper.correctNull((String)hshValues.get("com_assessment_comments"))%></td></tr>
</table>
</td>
</tr>
<%} %>

<%if(!Helper.correctNull((String)hshValues.get("com_tlassessment_comments")).equalsIgnoreCase("")){%>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title">Other Assessment for Term Loan: </td></tr>
<tr>
<td>
<%=Helper.correctNull((String)hshValues.get("com_tlassessment_comments"))%>
</td>
</tr>
</table>
</td>
</tr>
<%} %>

<tr><td>&nbsp;</td></tr>
<!-- Release Pattern Started -->
<%
	if (arrReleaseRow != null && arrReleaseRow.size() > 0) {
		ArrayList arrReleaseCol = new ArrayList();%>
		<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr><td class="title" valign="top"><br>Release pattern/ margin requirement:</td></tr>
		<tr><td align="right" ><%=strFinValuesIn%></td>
								</tr>
								</table>
								</td>
								</tr>
		
		<%
		for (int i = 0; i < arrReleaseRow.size(); i++) {
			arrReleaseCol = (ArrayList) arrReleaseRow.get(i);
			String strRel = Helper.correctNull((String) arrReleaseCol.get(2));
			String strEstimate="";
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
							<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
							<tr><td valign="top" colspan="7"><b>
				  <%=Helper.correctNull((String) arrReleaseCol.get(1))%>&nbsp;of Rs. - <%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrReleaseCol.get(5)))),strAmountValue)%> &nbsp;<%=strAmtValueIn%></b>
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
	<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr><td class="title"><br>Schedule of Implementation:</td></tr> 
	<tr><td align="right" ><%=strAmtValueIn%></td></tr>
	</table>
	</td>
	</tr>
		   <tr>
		  <td>
		  <div id="top">
		  <table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	
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
					<tr> <td colspan="5"><b><%=Helper.correctNull((String) arrImplSchCol.get(1)) %>  of Rs.  - <%=Helper.converAmount(Helper.correctNull((String) arrImplSchCol.get(3)),strAmountValue) %> <%=strAmtValueIn%></b></td> </tr>
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
	
	<!-- Mode of Repayment 
  
 	<%
		ArrayList arrOutCol1	= new ArrayList();
		ArrayList arrOutRow1	= (ArrayList) hshValues.get("arrOutRow2");
	%>
	<tr>
		<td>&nbsp;
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr><td class="title"><br>MODE OF REPAYMENT:</td></tr> 
				<tr><td>&nbsp;<br></td></tr>
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
  -->
<tr><td>&nbsp;<br></td></tr>
<%if(arrPresentWC!=null && arrPresentWC.size()>0){ %>



<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr><td class="title" >Assessment of fund based working capital limits :</td></tr>
			<tr>
			<td align="right" width="50%"><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<%} %>
<%if(arrPresentWC!=null && arrPresentWC.size()>0){ %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title">Details of proposed facilities:</td></tr>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
		<td align="left" width="">
		<div id="top">
			<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr><td align="center">Facility</td><td align="center">Limit</td></tr>
			<%for(int j=0;j<arrPresentWC.size();j++){ 
					arrCol=(ArrayList)arrPresentWC.get(j);%>
				<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0)) %></td>
				<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(1)),strAmountValue) %></td>
				</tr>
				<%} %>
			</table>
		</div>
		</td>
</tr>
<% }%>

<!-- Estimates of sales -->
<%if(!Helper.correctNull((String)hshValues.get("strLastYrEst")).equalsIgnoreCase("")){ %>
<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Estimates and actual for last three years:</td>
				</tr>
				<tr>
				<td align="left"><%=Helper.correctNull((String)hshValues.get("strLastYrEst"))%></td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<%} %>

<%if(!Helper.correctNull((String)hshValues.get("strCurrYrEst")).equalsIgnoreCase("")){ %>
<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Estimates of sales for the current year & for the next year:</td>
				</tr>
				<tr>
				<td align="left"><%=Helper.correctNull((String)hshValues.get("strCurrYrEst"))%></td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<%} %>

<!-- Justification for sales -->
 
<%if(!Helper.correctNull((String)hshValues.get("strJustification")).equalsIgnoreCase("")){ %>
<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left"><br>Justification for sales:</td>
				</tr>
				<tr>
				<td align="left"><%=Helper.correctNull((String)hshValues.get("strJustification"))%></td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<%} %>
<%if(arrTORow!=null&&arrTORow.size()>0){ %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Turnover Method:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<% if (!Helper.correctNull((String)hshValues.get("fin_commentsturnover")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_commentsturnover"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr>
</table>
</td>
</tr>
<%} %>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td>&nbsp;</td>
			
				<td align="right" width=""><%=strFinValuesIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrTORow!=null&&arrTORow.size()>0){ %>
				<%for(int i=0;i<13;i++){  %>
				<tr>
					<td width="3%" align="center"><%if(i>0){%><%=i%>.<%}else{ %>&nbsp;<%} %></td>
					<td width="47%"><%=strTOLabel[i]%></td>
					<%
					for(int j=0;j<arrTORow.size();j++){
						arrCol	= (ArrayList)arrTORow.get(j);
						if(!Helper.correctNull((String)arrCol.get(0)).equals("")){
					%>
						<%if(i==0){ %><td align="center" width="10%"><%=Helper.correctNull((String)arrCol.get(0))%></td><%} %>
						<%if(i==1){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td><%} %>
						<%if(i==2){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td><%} %>
						<%if(i==3){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td><%} %>
						<%if(i==4){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td><%} %>
						<%if(i==5){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td><%} %>
						<%if(i==6){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td><%} %>
						<%if(i==7){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td><%} %>
						<%if(i==8){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td><%} %>
						<%if(i==9){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(9))))%></td><%} %>
						<%if(i==10){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))%></td><%} %>
						<%if(i==11){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(11))))%></td><%} %>
						<%if(i==12){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%></td><%} %>
						<%}}} %>
				</tr>
				<% }else{ %>
				<tr style="visibility: hidden;position: absolute;"><td style="border: none;"><%=strNil%></td></tr>
				<%} %>
			</table>
		</div>
	</td>
</tr>

<% if (!Helper.correctNull((String)hshValues.get("fin_comments1turnover")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1turnover"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr>
</table>
</td>
</tr>
<%} } %>


<!-- Expenditure Method -->

<%if(arrExpRow!=null&&arrExpRow.size()>0){ %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Expenditure Method:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<% if (!Helper.correctNull((String)hshValues.get("fin_commentsexpenditure")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_commentsexpenditure"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr>
</table>
</td>
</tr>
<%} %>

<tr>
	<td>
	
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td>&nbsp;</td>
				<td align="right" width=""><%=strFinValuesIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrExpRow!=null&&arrExpRow.size()>0){ %>
				<%for(int i=0;i<8;i++){  %>
				<tr>
					<td width="3%" align="center"><%if(i>0){%><%=i%>.<%}else{ %>&nbsp;<%} %></td>
					<td width="47%"><%=strExpLabel[i]%></td>
				<%
					for(int j=0;j<arrExpRow.size();j++){
					arrCol	= (ArrayList)arrExpRow.get(j);
					if(!Helper.correctNull((String)arrCol.get(0)).equals("")){
				%>
				<%if(i==7){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td><%} %>
				<%if(i==0){ %><td align="center" width="10%"><%=Helper.correctNull((String)arrCol.get(0))%></td><%} %>
				<%if(i==1){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td><%} %>
				<%if(i==2){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td><%} %>
				<%if(i==3){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td><%} %>
				<%if(i==4){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td><%} %>
				<%if(i==5){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td><%} %>
				<%if(i==6){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td><%} %>
				<%}}} %>
				</tr>
				
			<% }else{ %>
				<tr style="visibility: hidden;position: absolute;"><td style="border: none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments1expenditure")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1expenditure"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr>
</table>
</td>
</tr>
<%} }%>

<%
String str_arr[]={"Particulars","<b>Cash Inflows</b>","Net contract receipts","Sub contrcat Receipts","Other Receipts"
		,"Total Receipts","<b>Cash Outflows</b>","Materials","Salaries & Wages","Salaries & Wages","Hire Charges"
		,"Labour Charges","Diesel & Petrol Charges ","Repair & Maintenance","Travelling Expenses","Other Operating Expenses"
		,"Bank Interest & Charges","Tax payable ","Administrative expenses ","Other expenses ","Total Outflows "
		,"Surplus / Deficit"};
HashMap hshRecord=new HashMap();
count=Integer.parseInt(Helper.correctInt((String)hshValues.get("count")));

if (!Helper.correctNull((String)hshValues.get("fin_commentscashbudget")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td>Comments on Cash Budget Method:</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_commentscashbudget"))%></td></tr>
</table>
</td>
</tr>
<%}

if(count>0)
{
	%>
	
	<%
	for(int h=0;h<count;h++)
	{
		
		ArrayList arrRows=(ArrayList)hshValues.get("y"+(h+1));
		if(arrRows!=null && arrRows.size()>0)
		{
			%>
			<tr>
			<td>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td>
					<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
						<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
							<tr>
								<td class="title"><br>Cash Budget Method:</td>
							</tr>
							<tr>
								<td align="right" width=""><%=strFinValuesIn%></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		
			<%

			int rowcount=Integer.parseInt(Helper.correctInt((String)hshValues.get("rowtype"+(h+1))));
		int val=Integer.parseInt(Helper.correctInt((String)hshValues.get("rowcount"+(h+1))));
		if(rowcount==12)
		{
			int c=0,f=0,b=0;
			ArrayList arrCols=(ArrayList)arrRows.get(c++);
			ArrayList arrCols1=(ArrayList)arrRows.get(c++);
			ArrayList arrCols2=(ArrayList)arrRows.get(c++);
			ArrayList arrCols3=(ArrayList)arrRows.get(c++);
			ArrayList arrCols4=(ArrayList)arrRows.get(c++);
			ArrayList arrCols5=(ArrayList)arrRows.get(c++);
			ArrayList arrCols6=(ArrayList)arrRows.get(c++);
			ArrayList arrCols7=(ArrayList)arrRows.get(c++);
			ArrayList arrCols8=(ArrayList)arrRows.get(c++);
			ArrayList arrCols9=(ArrayList)arrRows.get(c++);
			ArrayList arrCols10=(ArrayList)arrRows.get(c++);
			ArrayList arrCols11=(ArrayList)arrRows.get(c++);
			ArrayList arrCols12=(ArrayList)arrRows.get(c++);
			ArrayList arrCols13=(ArrayList)arrRows.get(c++);
			
			%>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr><td> <b>Financial Year : <%=Helper.correctNull((String)hshValues.get("cb_finyear"+(h+1))) %></b></td></tr>
			</table>
			<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			for(;f<22;f++)
			{
			%>
				<tr><td width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
			<%if(f==1 || f==6)
				{
				%>
				<td colspan="<%=val %>">&nbsp;</td>
				<%
				}else
				{ %>
				
					<%if(b==0){ %>
						<%if(!Helper.correctNull((String)arrCols.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols1.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols1.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols2.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols2.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols3.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols3.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols4.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols4.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols5.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols5.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols6.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols6.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols7.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols7.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols8.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols8.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols9.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols9.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols10.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols10.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols11.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols11.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols12.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols12.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols13.get(0)).equalsIgnoreCase("")){ %>
						<td align="center" ><%=Helper.correctNull((String)arrCols13.get(b))%></td>
					
					<%}}else{ %>
						<%if(!Helper.correctNull((String)arrCols.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols1.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols1.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols2.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols2.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols3.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols3.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols4.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols4.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols5.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols5.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols6.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols6.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols7.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols7.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols8.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols8.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols9.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols9.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols10.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols10.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols11.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols11.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols12.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols12.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols13.get(0)).equalsIgnoreCase("")){ %>
						<td align="right" ><%=Helper.correctNull((String)arrCols13.get(b))%></td>
					<%}} 
					b++;
					}
			%>
			</tr>
		<%	} %>
		</table>
	</div>
	<br>
	<%
		}
		else if(rowcount==4)
		{
				int c=0,f=0,b=0;
				ArrayList arrCols=(ArrayList)arrRows.get(c++);
				ArrayList arrCols1=(ArrayList)arrRows.get(c++);
				ArrayList arrCols2=(ArrayList)arrRows.get(c++);
				ArrayList arrCols3=(ArrayList)arrRows.get(c++);
				ArrayList arrCols4=(ArrayList)arrRows.get(c++);
				ArrayList arrCols5=(ArrayList)arrRows.get(c++);
			%>
			<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			for(;f<22;f++)
			{
			%>
				<tr><td width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
			<%if(f==1 || f==6) { %>
				<td colspan="<%=val %>">&nbsp;</td>
				<%
				}else
				{ %>
					<%if(!Helper.correctNull((String)arrCols.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols.get(b))%></td>
					<%} if(!Helper.correctNull((String)arrCols1.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols1.get(b))%></td>
					<%} if(!Helper.correctNull((String)arrCols2.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols2.get(b))%></td>
					<%} if(!Helper.correctNull((String)arrCols3.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols3.get(b))%></td>
					<%} if(!Helper.correctNull((String)arrCols4.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols4.get(b))%></td>
					<%} if(!Helper.correctNull((String)arrCols5.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols5.get(b))%></td>
					<%}  b++;%>
					<%}
			}
			%>
			</tr>
		</table>
	</div>
	<br>
	<%	} 
			else if(rowcount==2)
			{
					int c=0,f=0,b=0;
					ArrayList arrCols=(ArrayList)arrRows.get(c++);
					ArrayList arrCols1=(ArrayList)arrRows.get(c++);
					ArrayList arrCols2=(ArrayList)arrRows.get(c++);
					ArrayList arrCols3=(ArrayList)arrRows.get(c++);
				%>
				<div id="top">
				<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
				for(;f<22;f++)
				{
				%>
					<tr><td  width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
				<%if(f==1 || f==6) { %>
					<td colspan="<%=val %>">&nbsp;</td>
					<% }else { %>
						<%if(!Helper.correctNull((String)arrCols.get(0)).equalsIgnoreCase("")){ %>
						<td align="right"><%=Helper.correctNull((String)arrCols.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols1.get(0)).equalsIgnoreCase("")){ %>
						<td align="right"><%=Helper.correctNull((String)arrCols1.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols2.get(0)).equalsIgnoreCase("")){ %>
						<td align="right"><%=Helper.correctNull((String)arrCols2.get(b))%></td>
						<%} if(!Helper.correctNull((String)arrCols3.get(0)).equalsIgnoreCase("")){ %>
						<td align="right"><%=Helper.correctNull((String)arrCols3.get(b))%></td>
						<% } b++;%>
						<%}
				}
				%>
				</tr>
			</table>
		</div>
		<br>
		<%	}
			else if(rowcount==1)
			{
				int c=0,f=0,b=0;
				ArrayList arrCols=(ArrayList)arrRows.get(c++);
				ArrayList arrCols1=(ArrayList)arrRows.get(c++);
				ArrayList arrCols2=(ArrayList)arrRows.get(c++);
				%>
				<div id="top">
				<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
				for(;f<22;f++)
				{
				%>
					<tr><td width="25%"> <%=Helper.correctNull(str_arr[f])%></td>
						
				
				<%if(f==1 || f==6) { %>
					<td colspan="<%=val %>">&nbsp;</td>
					<%
					}else
					{ %>
					<%if(!Helper.correctNull((String)arrCols.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols.get(b))%></td>
					<%} if(!Helper.correctNull((String)arrCols1.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols1.get(b))%></td>
					<%} if(!Helper.correctNull((String)arrCols2.get(0)).equalsIgnoreCase("")){ %>
					<td align="right"><%=Helper.correctNull((String)arrCols2.get(b))%></td>
					<% } b++;%>
					<%}
				}
				%>
				</tr>
			</table>
		</div>
		</td>
		</tr>
		<%	}
}
}
} else{ %>
<% if (!Helper.correctNull((String)hshValues.get("fin_commentscashbudget")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr ><td class="title">Cash Budget Method : </td></tr>
<tr style="visibility: hidden;position: absolute;"><td style="border: none;"><%=strNil%></td></tr>
</table>
</td>
</tr>
<%} } %>

<% if (!Helper.correctNull((String)hshValues.get("fin_comments1cashbudget")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1cashbudget"))%></td></tr>
</table>
</td>
</tr>
<%} %>

<!-- Assessment of Method 1/Method 2/Working Capital -->
<%if(hshFinmethod1!=null && hshFinmethod1.size()>0) { %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">Method I of lending other than export limits:</td>
			</tr>
		</table>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments_method1")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments_method1"))%></td></tr>
		
		</table>
</td>
</tr>
<%} %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="right"><%=strFinValuesIn%></td></tr>
<tr>
<td>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method1"/>
</jsp:include></td></tr>
</table>
</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_method1")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_method1"))%></td></tr>
<%} %>
<%} %>

<%if(hshFinmethod2!=null && hshFinmethod2.size()>0) { %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">Method II of lending other than export limits:</td>
			</tr>
			<tr><td align="right"><%=strFinValuesIn%></td></tr>
		</table>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments_method2")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments_method2"))%></td></tr>
</table>
</td>
</tr>
<%} %>
	<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method2"/>
</jsp:include></td></tr>
</table>
</td>
</tr>

<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_method2")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_method2"))%></td></tr>
<%} %>
<%} %>

<%if(hshFinmethod3!=null && hshFinmethod3.size()>0) { %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" valign="top"><br>Working Capital gap method for export limits:</td>
				<tr><td align="right"><%=strFinValuesIn%></td></tr>
			</tr>
		</table>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments_wcg")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments_wcg"))%></td></tr>
<%} %>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method3"/>
</jsp:include></td></tr>
</table>
</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_wcg")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_wcg"))%></td></tr>
<%} %>
<%} %>


<%if(!Helper.correctNull((String)hshValues.get("strInv")).equalsIgnoreCase("") ||
		!Helper.correctNull((String)hshValues.get("strReceiv")).equalsIgnoreCase("") ||
			!Helper.correctNull((String)hshValues.get("strCreditors")).equalsIgnoreCase("") ||
			!Helper.correctNull((String)hshValues.get("strOtherAssets")).equalsIgnoreCase("")){ %>
<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
				<td class="title" align="left">Comments:</td>
				</tr>
				<%if(!Helper.correctNull((String)hshValues.get("strInv")).equalsIgnoreCase("")){ %>
				<tr>
					<td class="title" align="left">Inventory:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("strInv"))%></td>
				</tr>
				<% }%>
				<%if(!Helper.correctNull((String)hshValues.get("strReceiv")).equalsIgnoreCase("")){ %>
				<tr>
					<td class="title" align="left">Receivables:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("strReceiv"))%></td>
				</tr>
				<% }%>
				<%if(!Helper.correctNull((String)hshValues.get("strCreditors")).equalsIgnoreCase("")){ %>
				<tr>
					<td class="title" align="left">Creditors:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("strCreditors"))%></td>
				</tr>
				<% }%>
				<%if(!Helper.correctNull((String)hshValues.get("strOtherAssets")).equalsIgnoreCase("")){ %>
				<tr>
					<td class="title" align="left">Other current Assets and liabilities:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("strOtherAssets"))%></td>
				</tr>
				<% }%>
			</table>
		</div>
	</td>
</tr>
<%} %>
<!-- Other Assessment Comments -->
<tr>
	<td>
		<div >
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				
				<% if (!Helper.correctNull((String)hshValues.get("com_assessment_comments20")).equalsIgnoreCase("")) { %>
				<tr><td class="title" align="left"><b>Other Working Capital Assessment : </b></td></tr>
				
				
				<tr><td><%=Helper.correctNull((String)hshValues.get("com_assessment_comments20"))%></td></tr>
				
				<tr><td class="title" align="left"><b>&nbsp;</b></td></tr><%}  %>

			</table>
		</div>
	</td>
</tr>
<!-- Assessment Holding level comments -->
<%if(arrAssmntRow !=null && arrAssmntRow.size()>0 ){ %>
<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%if(!Helper.correctNull((String)hshValues.get("strBreakup")).equalsIgnoreCase("")){ %>
				<tr>
					<td class="title" align="left">Break up of limits:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("strBreakup"))%></td>
				</tr>
				<% }%>
			</table>
		</div>
	</td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("com_wcassessment_comments")).equalsIgnoreCase("")){%>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td class="title">Other Assessment for WCDPN/WCTL : </td></tr>
<tr>
<td>
<%=Helper.correctNull((String)hshValues.get("com_wcassessment_comments"))%>
</td>
</tr>
</table>
</td>
</tr>
<%} %>
<tr><td>&nbsp;</td></tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_commentsinlandComments")).equalsIgnoreCase("")) { %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
		<td class="title" align="left"><b>Assessment of non fund based working capital limits : </b></td>
</tr>
</table>
</td>
</tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			
			<tr>
			<td align="right" width="50%"><%=strFinValuesIn%></td>
			</tr>
		</table>
	</td>
</tr>
<%} %>
<!-- Assessment of Inland / Import LC -->
<tr>
<td>
<% 
String str_aray[]={"<b>Accepted for the year ending</b>","Sales"
		,"Purchases","Projected purchases under LC","Avg. monthly purchases under LC","Normal credit period (in months)","Transit Period (in months)","LC requirement",
		"Applied limit","Recommended limit"};

 count=Integer.parseInt(Helper.correctInt((String)hshValues.get("InlandCount")));
if(count>0)
{
	%>
	
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td><span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
				<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title"><br>Assessment of Inland / Import LC:</td>
						<td align="right" width="">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right" ><%=strFinValuesIn%></td>
					</tr>
					<% if (!Helper.correctNull((String)hshValues.get("fin_commentsinlandComments")).equalsIgnoreCase("")) { %>
				<tr><td colspan="2"><%=Helper.correctNull((String)hshValues.get("fin_commentsinlandComments"))%></td></tr>
				<%} %>
				</table>
			</td>
		</tr>
	</table>
	
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
			if(arryInland!=null && arryInland.size()>0)
			{
				for(int m=0;m<count;m++)
				{
					if(m==0) {
						arrColIL1 = new ArrayList();
						arrColIL1 = (ArrayList)arryInland.get(0);
					    arrRowIL1 = (ArrayList)arrColIL1.get(0);
					}
					if(m==1) {
						arrColIL2 = new ArrayList();
						arrColIL2 = (ArrayList)arryInland.get(1);
						arrRowIL2 = (ArrayList)arrColIL2.get(0);
					}
					if(m==2) {
						arrColIL3 = new ArrayList();
						arrColIL3 = (ArrayList)arryInland.get(2);
						arrRowIL3 = (ArrayList)arrColIL3.get(0);
					}
					if(m==3) {
						arrColIL4 = new ArrayList();
						arrColIL4 = (ArrayList)arryInland.get(3);
						arrRowIL4 = (ArrayList)arrColIL4.get(0);
					}
					if(m==4) {
						arrColIL5 = new ArrayList();
						arrColIL5 = (ArrayList)arryInland.get(4);
						arrRowIL5 = (ArrayList)arrColIL5.get(0);
					}
				}
		 		for(int g=0;g<10;g++)
				{
		%>
			<tr>
					<% if(g==0){ %>
					<td width ="3%">&nbsp;</td>
					<%} else { %>
					<td width ="3%" align="center"><%=g%>.</td>
					<%} %>
					<td width ="40%"><%=str_aray[g] %></td>
					
					<% if(g==0){ %>
					<% if(arrRowIL1!=null && arrRowIL1.size()>0){ %>
					<td align="center" ><%=Helper.correctNull((String)arrRowIL1.get(g))%>&nbsp;</td>
					<%} if(arrRowIL2!=null && arrRowIL2.size()>0){ %>
					<td align="center" ><%=Helper.correctNull((String)arrRowIL2.get(g))%>&nbsp;</td>
					<%} if(arrRowIL3!=null && arrRowIL3.size()>0){ %>
					<td align="center" ><%=Helper.correctNull((String)arrRowIL3.get(g))%>&nbsp;</td>
					<%} if(arrRowIL4!=null && arrRowIL4.size()>0){ %>
					<td align="center" ><%=Helper.correctNull((String)arrRowIL4.get(g))%>&nbsp;</td>
					<%} if(arrRowIL5!=null && arrRowIL5.size()>0){ %>
					<td align="center" ><%=Helper.correctNull((String)arrRowIL5.get(g))%>&nbsp;</td>
					
					<%} } else{ %>
					<% if(arrRowIL1!=null && arrRowIL1.size()>0){ %>
					<td align="right" ><%=Helper.correctNull((String)arrRowIL1.get(g))%>&nbsp;</td>
					<%} if(arrRowIL2!=null && arrRowIL2.size()>0){ %>
					<td align="right" ><%=Helper.correctNull((String)arrRowIL2.get(g))%>&nbsp;</td>
					<%} if(arrRowIL3!=null && arrRowIL3.size()>0){ %>
					<td align="right" ><%=Helper.correctNull((String)arrRowIL3.get(g))%>&nbsp;</td>
					<%} if(arrRowIL4!=null && arrRowIL4.size()>0){ %>
					<td align="right" ><%=Helper.correctNull((String)arrRowIL4.get(g))%>&nbsp;</td>
					<%} if(arrRowIL5!=null && arrRowIL5.size()>0){ %>
					<td align="right" ><%=Helper.correctNull((String)arrRowIL5.get(g))%>&nbsp;</td>
					
					<%} } } }  %>
			</tr>
			</table><br>
		</div>
<%}%>
</td>
</tr>
<tr>
	<td>
		<div >
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<% if (!Helper.correctNull((String)hshValues.get("fin_comments1inlandComments")).equalsIgnoreCase("")) { %>
				<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1inlandComments"))%></td></tr>
				<tr><td class="title" align="left"><b>&nbsp;</b></td></tr><%} %>
			</table>
		</div>
	</td>
</tr>
<% if(str_arry.contains("BGA@")) { %>

<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<% if (!Helper.correctNull((String)hshValues.get("com_assessment_comments35")).equalsIgnoreCase("")) { %>
				<tr>
					<td class="title" align="left"><br>Bank Guarantee:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("com_assessment_comments35"))%></td>
				</tr>
				<% }%>
			</table>
		</div>
	</td>
</tr>
<%}%>

<%if(!Helper.correctNull((String)hshValues.get("com_nonfund_comments")).equalsIgnoreCase("")){ %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td class="title"><br>Any other Non fund based limits:</td>
		</tr>
		<tr>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("com_nonfund_comments"))%></td>
		</tr>
		</table>
	</td>
</tr>
<%} %>

<% if(str_arry.contains("ACOM@")) { %>
<tr>
	<td>	
		<div>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%if(!Helper.correctNull((String)hshValues.get("strCashmargin")).equalsIgnoreCase("")){ %>
				<tr>
					<td class="title" align="left"><br>Cash Margin:</td>
				</tr>
				<tr>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("strCashmargin"))%></td>
				</tr>
				<% }%>
			</table>
		</div>
	</td>
</tr>
<%}
if (str_arry.contains("AOR@")) {
%>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
	<td style="border: none;"  class="title" align="left">Assessment of Restructuring :</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>	
	<div id="top">
	<table width="95%" cellpadding="3" cellspacing="0" border="0" align="center">
	
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
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
					<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(1)),strAmountValue) %>&nbsp;</td>
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
</table>
</td>
</tr>
<br>

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
				String strstatus="",strrestruc="";
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
			 <tr>
				<td><b>12.<%=strDesc[11] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(11))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>13.<%=strDesc[12] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(12))%></td>
			   <%} %>
			 </tr>
                        <tr>
				<td><b>14.<%=strDesc[13] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
				 strrestruc= Helper.correctNull((String)arrColcgssd.get(13));
					if(strrestruc.equalsIgnoreCase("S")){
						strrestruc="Yes";
					}else if(strrestruc.equalsIgnoreCase("N")){
						strrestruc="No";
					}else{
						strrestruc="";
					}
			   %>
			   <td align="right"><%=strrestruc%></td>
			   <%} %>
			 </tr>
	</table>
	</div>
	</td>
	</tr>
<%}%>
<br>
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
<tr>
<td align="center">
<table width="90%" align="center" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
	<td class="title"><br>Recommendations</td>
</tr>
<tr>
	<td style="text-align: justify;"><br>In light of the above,<b> M/s.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%>.,</b> be sanctioned the following facilities on the terms and conditions, 
	mentioned hereunder under sole/ consortium / multiple banking arrangement :
	</td>
</tr>
</table>
</td>
</tr>
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

<tr>
	<td>
		<div id="top">
		<br></br>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% int w=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0){ 
			boolean bflag=false;
			
			for(int i=0;i<arrRecommRow.size();i++)
			{
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					if(Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("SF"))
						bflag=true;
				}
			}%>
			 <%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
					if(!Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("NC")&&!Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("")){
					w++;
			%>
			<%if(w==1) {%>
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
				
				<td align="left"><%=Helper.correctNull((String) arrCol.get(15))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(17))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(18))))),strAmountValue)%></td>
				<%if(Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(19))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(21))%></td>
				<%}else if(bflag){ %>
				<td align="right" colspan="3">&nbsp;</td>
				<%} %>
				
		   	</tr>
			<%}} %>
			
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
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0 && strWhetherBRAvail.equalsIgnoreCase("Y")){ 
				int j=0; %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")
						||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("FTBR")){
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
			</tr>
			<%} }} else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<%if(arrRowNonBr!=null &&(!Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("FTBR"))){
	if(arrRowNonBr.size()>0)
	{
		for(int k=0;k<arrRowNonBr.size();k++)
		{
			arrColNonBr=(ArrayList)arrRowNonBr.get(k);
			if(arrColNonBr.size()>0)
			{
			%>
			 <tr>
				<td>
					<div id="top">
						<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
							<tr><td><b><%=Helper.correctNull((String)arrColNonBr.get(0))%></b></td></tr>
							<tr><td><%=Helper.correctNull((String)arrColNonBr.get(1))%></td></tr>
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
<%if(arrMCLRRow!=null && arrMCLRRow.size()>0){ %>
				<tr>
				<td>
				<div id="top">
						<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
						<tr>
						<td>
				<%for(int k=0;k<arrMCLRRow.size();k++)
				{ %>
				<%=Helper.correctNull((String)arrMCLRRow.get(k))%><br/>
				<%} %>
				</td>
				</tr>
				</table>
				</div>
				</td>
				</tr>
				<%} %>

<tr>
	<td>
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
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="30%" align="center">Margin</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%><br/>
				<%if(!Helper.correctNull((String) arrCol.get(25)).equalsIgnoreCase("")){ %>Relaxation in margin as per RBI COVID relief Package Policy : <%=Helper.correctNull((String) arrCol.get(25))%><%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(23)).equalsIgnoreCase("")){ %>Actual Margin (%):<%=Helper.correctNull((String) arrCol.get(23)) %> <%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(24)).equalsIgnoreCase("")){ %>Relaxed Margin(%):<%=Helper.correctNull((String) arrCol.get(24)) %> <%} %></td>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
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
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="15%" align="center">Tenor <br>(in Months)</td>
				<td width="15%" align="center">Initial Holiday/ Gestation/ Moratorium Period <br>(in Months)</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="right"><%=Helper.correctInt((String)arrCol.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(11))%></td>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
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
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="30%" align="center">Mode of Repayment</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<tr><td>&nbsp;</td></tr>
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
			}else{		
	%>
	<tr><td align="center">&nbsp;Nil</td></tr>
	<%} %>
			</table>
		</td>
	</tr>

<tr><td>&nbsp;</td></tr>
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
<%} %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MIS Classification</td>
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

<tr><td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<%if(strprd_purpose.equals("PC")){ %>
	<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> (Inclusive of all Taxes)</td>
<%}else{%>
	<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> + Applicable Taxes</td>
<%} %>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>

<tr>
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
</table>
</td></tr>
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
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<%ArrayList vecNcgtcRow=new ArrayList();
	ArrayList vecNcgtcCol=new ArrayList();
	vecNcgtcRow=(ArrayList)hshValues.get("vecNcgtcRow");
	if(vecNcgtcRow!=null){	vecNcgtcCol=new ArrayList();
				int intncgtcSize = 0;
				intncgtcSize = vecNcgtcRow.size();;%>
				<tr><td colspan="3"><b>KBL Aarogya NCGTC Details</b></td></tr>
				<%for(int s=0;s<intncgtcSize ;s++){
					vecNcgtcCol = (ArrayList) vecNcgtcRow.get(s);%>
	<tr><td colspan="3"><b><%=Helper.correctNull((String)vecNcgtcCol.get(13))%> - <%=Helper.correctNull((String)vecNcgtcCol.get(14))%></b></td></tr>
	<tr class=""><td width="40%" style="text-align: center"><b>Details of the Project</b></td><td width="30%" style="text-align: center"><b>Project description</b></td><td width="30%" style="text-align: center"><b>Eligibility</b></td></tr>
	<%if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("1")){ %>
	<tr><td width="40%">Type of the Project</td><td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td><td width="30%">&nbsp;</td></tr>
	<tr id="t1"><td>New employment likely to be generated in case of greenfield projects&nbsp;</td>	<td><%=Helper.correctNull((String)vecNcgtcCol.get(4))%>&nbsp;</td><td>&nbsp;</td></tr>
	<%}else if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("2")){ %>
	<tr><td width="40%">Type of the Project</td><td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td><td width="30%">&nbsp;</td></tr>
	<tr id="t2"><td>Additional employment likely to be generated in case of brownfield&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(5))%>&nbsp;</td><td>&nbsp;</td></tr>
	<%}%>
	<tr><td>Whether the project is in any of the metropolitan cities  Ahmedabad, Bengaluru, Hyderabad, Chennai, Kolkata, Mumbai, New Delhi and Pune&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(6))%>&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(7))%>&nbsp;</td></tr>
	<tr><td>Industry Sector&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(8))%>&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(9))%>&nbsp;</td></tr>	<tr>
		<td>Udyog Aadhaar Number(12 Digits)&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(10))%>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td width="60%">Project unit pin code</td><td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(11))%></td><td>&nbsp;</td></tr>
	<tr><td width="60%">Nature of the Project</td><td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(12))%></td><td>&nbsp;</td></tr>
	<tr><td colspan="3"><b>&nbsp;</b></td></tr>
	<%}} %>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<!-- Terms and Conditon - General -->
   <jsp:include page="../print/com_AnnexureVII.jsp" flush="true">  
   <jsp:param name="pagetype" value="sancborrower" />       
   </jsp:include>
<!-- End -->
</td>
</tr>

</table>
</td>
</tr>
</table>

		<table width="90%" align="center" cellpadding="0" cellspacing="0" border="0">
		<%if(arrDeleRow!=null&&arrDeleRow.size()>0)
		{ 
			for(int i=0;i<arrDeleRow.size();i++)
			{
				arrCol	=  (ArrayList)arrDeleRow.get(i);
				boolean bflag=false;
				if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("021") && !Helper.correctNull((String)hshValues.get("com_griddate")).equalsIgnoreCase(""))
				{
					bflag=true;
				}
		%>
			<%if(i%2==0){ %>
			<tr><td><br> <%=Helper.correctNull((String)arrCol.get(0))%> </td></tr>
			<tr><td><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
			<%if(bflag){ %>
			<tr><td align="left"> Discussed and cleared in the Credit approval GRID on <%=Helper.correctNull((String)hshValues.get("com_griddate"))%> </td></tr>
			<%
			}}else{ %>
			<tr><td align="right"><br> <%=Helper.correctNull((String)arrCol.get(0))%> </td></tr>
			<tr><td align="right"> <%=Helper.correctNull((String)arrCol.get(1))%> </td></tr>
			<%if(bflag){ %>
			<tr><td align="right"> Discussed and cleared in the Credit approval GRID on <%=Helper.correctNull((String)hshValues.get("com_griddate"))%> </td></tr>
			<%
			}} %>
		<%} } %>
<tr>
<td>&nbsp;
</td>
</tr>
		</table>
		
		
</body>
</html>
