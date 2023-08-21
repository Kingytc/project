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

int intRatiCount=0;
double dblVal	= 0.00;
boolean booAssFlag=true;

String strRatiCount="",strLoanType="",strKccFlagValue="",strExiWC="",strPreWC="";
String strFinancialrequired="",APP_LOANSUBTYPE_DIGI="";
boolean finacial_flag=false;

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

ArrayList arrCol = new ArrayList();
ArrayList arrFacRow = new ArrayList();
ArrayList arrRecommRow = new ArrayList();
ArrayList arrRowNonBr = new ArrayList();
ArrayList arrColNonBr = new ArrayList();
ArrayList arrDeleRow = new ArrayList();
ArrayList arrCOPMjrRow = new ArrayList();
ArrayList arrCOPRow = new ArrayList();
ArrayList arrMOFRow = new ArrayList();
ArrayList arrMOFMjrRow = new ArrayList();
ArrayList arrCOPNewRow = new ArrayList();
ArrayList arrReleaseRow = new ArrayList();
ArrayList arrFAConlyRow = new ArrayList();
ArrayList arrFACexistingRow = new ArrayList();
ArrayList arrTORow = new ArrayList();
ArrayList arrExpRow = new ArrayList();
ArrayList arrRowLimit = new ArrayList();
ArrayList arrRowInland = new ArrayList();
ArrayList arrRowInlandYr = new ArrayList();
ArrayList arrAssmntRow = new ArrayList();
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
ArrayList arrTakeOver = new ArrayList();
ArrayList arrFacilityTerm0 = new ArrayList();
ArrayList arrFacilityIdVal0 = new ArrayList();
ArrayList arrParentID0 = new ArrayList();
ArrayList arrFacilityTermApp0 = new ArrayList();
ArrayList arrMISRow = new ArrayList();
ArrayList arrColMIS=new ArrayList();
ArrayList arrFinCommRow=new ArrayList();
ArrayList arrImplSchRow=new ArrayList();
ArrayList arrImplSchCol=new ArrayList();
ArrayList arrPresentWC = new ArrayList();
ArrayList arrPresentTL = new ArrayList();
ArrayList arrMCLRRow = new ArrayList();
ArrayList arrRowprop= new ArrayList();
ArrayList arrColprop= new ArrayList();
ArrayList arrRowcgssd= new ArrayList();
ArrayList arrColcgssd= new ArrayList();
ArrayList arrRowtemp= new ArrayList();
ArrayList arrColtemp= new ArrayList();
if(hshValues!=null)
{
	arrFacRow		= (ArrayList)hshValues.get("arrFacRow");
	arrRecommRow	= (ArrayList)hshValues.get("arrRecommRow");
	arrRowNonBr		= (ArrayList)hshValues.get("arrRowNonBr");
	arrDeleRow		= (ArrayList)hshValues.get("arrDeleRow");
	arrCOPMjrRow	= (ArrayList)hshValues.get("arrCOPMjrRow");
	arrCOPRow		= (ArrayList)hshValues.get("arrCOPRow");
	arrMOFRow		= (ArrayList)hshValues.get("arrMOFRow");
	arrMOFMjrRow	= (ArrayList)hshValues.get("arrMOFMjrRow");
	arrCOPNewRow	= (ArrayList)hshValues.get("arrCOPNewRow");
	arrReleaseRow	= (ArrayList)hshValues.get("arrReleaseRow");
	arrFAConlyRow	= (ArrayList)hshValues.get("arrFAConlyRow");
	arrFACexistingRow = (ArrayList)hshValues.get("arrFACexistingRow");
	arrTORow		= (ArrayList)hshValues.get("TurnOver");
	arrExpRow		= (ArrayList)hshValues.get("arrExpRow");
	arrRowLimit     = (ArrayList)hshValues.get("arrRowLimit");
	arrRowInland    = (ArrayList)hshValues.get("arrRowInland");
	arrRowInlandYr  = (ArrayList)hshValues.get("arrRowInlandYr");
	arrAssmntRow    = (ArrayList)hshValues.get("arrAssmntRow");
	arryInland		= (ArrayList)hshValues.get("Inland");
	arrTakeOver		= (ArrayList)hshValues.get("arrTakeOver");	
	arrFacilityTerm0 = (ArrayList)hshValues.get("arrFacilityTerm0");
	arrFacilityIdVal0 = (ArrayList)hshValues.get("arrFacilityIdVal0");
	arrParentID0 	= (ArrayList)hshValues.get("arrParentID0");
	arrFacilityTermApp0 = (ArrayList)hshValues.get("arrFacilityTermApp0");
	arrRowprop= (ArrayList)hshValues.get("arrRowprop");
	strRatiCount=Helper.correctInt((String)hshValues.get("rati_Count"));
	intRatiCount=Integer.parseInt(strRatiCount);
	strLoanType=Helper.correctNull((String)hshValues.get("strLoanTypeNew"));
	strKccFlagValue=Helper.correctNull((String)hshValues.get("strKccFlag"));
	arrMISRow	= (ArrayList)hshValues.get("arrMISRow");
	arrFinCommRow		= (ArrayList)hshValues.get("arrfinComments");
	arrImplSchRow = (ArrayList) hshValues.get("arrImplSchRow");
	strFinancialrequired=Helper.correctNull((String)hshValues.get("Financialrequired"));
	APP_LOANSUBTYPE_DIGI=Helper.correctNull((String)hshValues.get("APP_LOANSUBTYPE_DIGI"));
	arrRowcgssd= (ArrayList)hshValues.get("arrRowcgssd");
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
	
	arrPresentWC = (ArrayList) hshValues.get("arrPresentWC");
	arrPresentTL = (ArrayList) hshValues.get("arrPresentTL");
	arrMCLRRow = (ArrayList) hshValues.get("arrMCLR");
}

ArrayList arrGrpExp=(ArrayList)hshValues.get("arrGrpExpDet");
ArrayList arrColExp = new ArrayList();

double dblgrpexptot=0;
dblgrpexptot=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblGrpExpVal")));

int count=0;
String strTLValIn="",strValuesIn="",strNil="Nil",strWhetherBRAvail="",strOutstandingDate="",strSanctioningAuthority="",strValIn="",str_arry="";

strWhetherBRAvail=Helper.correctNull((String)hshValues.get("strWhetherBRAvail"));
strOutstandingDate=Helper.correctNull((String)hshValues.get("strOutstandingDate"));
strSanctioningAuthority=Helper.correctNull((String)hshValues.get("com_sancauthorityVal"));
str_arry = Helper.correctNull((String)hshValues.get("str_arr")); 

String strSno[]		= {"I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","XII"};
String strTOLabel[]	= {"Particulars","Projected Sales","Accepted projected Sales","25% of accepted sales","Minimum Margin required (5% of accepted sales)",
"Eligible Finance as per Norms","Actual Margin available in the System","Eligible Bank Finance as per availability of actual Margin","Permissible Bank Finance","Limits sought","Limit proposed","Required Margin","Surplus/ Shortfall(-) in required Margin"};
String strExpLabel[]={"Particulars","Projected expenditure","Accepted projected expenditure","Operational cycle(45/ 60/ 75/ 90 days)",
"Eligible expenditure","Permisible finance","Limits sought","Limit proposed"};


strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));



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
String strFinvaluesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
if(strFinvaluesIn.equalsIgnoreCase("Rs"))
{
	strFinvaluesIn	= "(Amount in  "+strFinvaluesIn+".)";
}
else
{
	strFinvaluesIn	= "(Rs. in  "+strFinvaluesIn+")";
}

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

if (arrRowInland != null && arrRowInland.size() > 0) 
{
	arrColIL1 = (ArrayList) arrRowInland.get(0);
	arrColIL2 = (ArrayList) arrRowInland.get(1);
	arrColIL3 = (ArrayList) arrRowInland.get(2);
	arrColIL4 = (ArrayList) arrRowInland.get(3);
	arrColIL5 = (ArrayList) arrRowInland.get(4);
}
String TakeOvercheck=Helper.correctNull((String)hshValues.get("strTakeOvercheck"));
HashMap hshValuesPromotor = (HashMap)hshValues.get("PROPOSALLC");
HashMap hshValuesAN3 = (HashMap)hshValues.get("AN3");
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

ArrayList vec = new ArrayList();
ArrayList g2 = new ArrayList();
int vecsize = 0;
HashMap hshBenchmark=new HashMap();
hshBenchmark=(HashMap)hshValues.get("hshBenchValues");
if (hshBenchmark != null) {
	vec = (ArrayList) hshBenchmark.get("vecData");
}
if (vec != null) {
	vecsize = vec.size();
}
String strWhetherEMI=Helper.correctNull((String)hshValues.get("strWhetherEMIFlag"));
String strAmountValue=Helper.correctNull((String)hshValues.get("com_amountvalue"));

String strAmtValueIn=Helper.correctNull((String)hshValues.get("strAmtValueIn"));
String stramtValIn=Helper.correctNull((String)hshValues.get("strAmtValueIn"));

if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
}
double dblLimitTot=0.0,dblOutstandTot=0.0,dblExposureTot=0.0,dblFreshLimit=0.0,dblPropLimitTot=0.0,dblTotExp=0.0,dblLimitTot1=0.0;
ArrayList arrRBIGuidliness=new ArrayList();
arrRBIGuidliness=(ArrayList)hshValues.get("arrRBIGuidliness");
int a=0;
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

String strmisDesc[] = { "Facility Desc", "Type of Facility and Facility Serial Number",
		"Activity Code", "Main Activity", "Sub Activity",
		"Agriculture/Industry/Service Category type","Sector",
		"Sub sector","Sensitive sector",
		"StandUp India","Government announced scheme","Guarantee Cover By",
		"Guarantee Covered Amount","Sales Turnover of the Applicant",
		"Sales Turnover As on Date",
		"Criteria for Sales Turnover","Investment in Plant & Machineries/Equipments","Industry Name",
		"Investment value as on Date","Criteria for Investment value","Weaker Section","Whether Start up as per definition of Ministry of Commerce and Industry"
		};
%>

<html>
<head>
<title>MCFD Format</title>
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
var TakeOvercheck="<%=Helper.correctNull((String)hshValues.get("strTakeOvercheck"))%>";
var strratingperc="<%=strratingperc%>";
var totalvalue="";
var margin_amt="";
var eligibleloanvalue="";
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
<body contentEditable="false" designMode="on" onKeyDown="callKeyDown();" onload="callLoad();">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>
<%{%>
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
	<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("015")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("016")
				||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("017")){
		%>
	<tr><td align="center" width="50%"><%=Helper.correctNull((String)hshValues.get("strSanctiondept"))%></td></tr>
	<%}else{ %>
	<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("username")).toUpperCase()%></td></tr>
	<%} %>
<%} %>
<tr>
	<td ><br>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td align="left" ><br>OFFICE NOTE:</td>
				<td align="right" width="50%">Date&nbsp;:&nbsp;<%=Helper.correctNull((String)hshValues.get("com_processnotedate"))%></td>
			</tr>
			<tr>
			<td align="right" colspan="2"><b>Proposal No&nbsp;:&nbsp;</b><%=Helper.correctNull((String)request.getParameter("appno"))%></td>
			</tr>
		</table>
	</td>
</tr>


<tr>
<td>
<table width="95%" align="right" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="50%">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td align="left" width="30%">PF No&nbsp;:&nbsp;
<% if(strOrgLevel.equalsIgnoreCase("A")){ %>
						<%=Helper.correctNull((String)hshValues.get("com_partyfileno"))%>
						<%}else{  %>
						<%=Helper.correctNull((String)hshValues.get("com_roho"))%>
						<%} %>
</td>
</tr>
<tr>
<td align="left">Branch&nbsp;:&nbsp;<%=Helper.correctNull(Helper.correctNull((String)hshValues.get("org_name"))).toUpperCase()%></td>
</tr>
<tr>
<td align="left" width="50%">Region&nbsp;:&nbsp;<%=Helper.correctNull(Helper.correctNull((String)hshValues.get("Reg_org_name"))).toUpperCase()%></td>
</tr>
</table>
</td>
<td width="50%">
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr><td colspan="2" class="title">PROPOSAL FLOW CHART</td></tr>
			<tr>
				<td align="left" width="40%">Date of Credit Application</td>
				<td align="center" width="10%"><%=Helper.correctNull((String)hshValues.get("inward_appliedon"))%></td>
			</tr>
			<tr>
				<td align="left">Date of receipt at HO/RO with Branch  Recommendations</td>
				<td align="center"><%=Helper.correctNull((String)hshValues.get("com_branchrcvddate"))%></td>
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
				<td align="left">Date of receipt of additional information/ papers at HO/RO</td>
				<td align="center"><%=Helper.correctNull((String)hshValues.get("com_branchcompletedate"))%></td>
			</tr>
			</table>
</div>
</td>
</tr>
</table>
</td>
</tr>


<tr>
	<td align="center"><br><b> SUBMITTED TO THE <%=Helper.correctNull((String)hshValues.get("com_submittedto")).toUpperCase()%>
		<br>-------------------------------------------------------------------------------------------</b>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr><td class="title"><br><%=strSno[a] %><%a=a+3; %>.&nbsp;Introduction :</td></tr>
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
					<tr><td>&nbsp;&nbsp;a. Working Capital</td><td> <%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble((String)hshValues.get("INWARD_WCLOANAMT"))),strAmountValue)%></td></tr> 
					<tr><td>&nbsp;&nbsp;b. Term Loan </td><td> <%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble((String)hshValues.get("INWARD_TERMLOANAMT"))),strAmountValue)%></td></tr> 
					<tr><td>2. Non Fund Based</td><td> <%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble((String)hshValues.get("INWARD_NONWCLOANAMT"))),strAmountValue)%></td></tr> 	
					</table>
				</td>		
			</tr>
		</table>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" align="left">Details of facilities and proposed exposure:</td>
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
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			
			<%
			if(arrFacRow!=null&&arrFacRow.size()>0)
			{
				
			%>
			<tr>
				<td align="center" width="3%">Sl.No.</td>
				<td align="center" width="37%">Nature of facility</td>
				<td align="center" width="10%">Existing Limit</td>
				<td align="center" width="10%">Outstanding as on <%=strOutstandingDate%></td>
				<td align="center" width="10%">Existing exposure</td>
				<td align="center" width="10%">Additional / Fresh Limit sought by Borrower</td>
				<td align="center" width="10%">Additional / Fresh Limit Proposed</td>
				<td align="center" width="10%">Proposed Exposure</td>
			</tr>
			<%for(int i=0;i<arrFacRow.size();i++){
				arrCol	= (ArrayList)arrFacRow.get(i);
				if(Helper.correctNull((String)arrCol.get(8)).equalsIgnoreCase("F"))
				{
					
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<% if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit"))
				{%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<%}
				else
				{%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%>)</td>
				<%}%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>
<!--				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>-->
	 			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%></td>   
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
				<% if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit"))
				{%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%></td>
				<%}
				else
				{%>
				<td align="right">(<%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)))),strAmountValue)%>)</td>
				<%}
				if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit")){
				dblLimitTot=dblLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				dblOutstandTot=dblOutstandTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
				dblExposureTot=dblExposureTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
				dblFreshLimit=dblFreshLimit+Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
				dblPropLimitTot=dblPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
				dblTotExp=dblTotExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
				}
				
				if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit")||Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit"))
					dblLimitTot1=dblLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				%>
				
			</tr>
			<%} 
				
				else { %>
				<tr>
					<td align="center"><%=i+1%>.</td>
					<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(0)))%></td>
					<% if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit"))
					{%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
					<%}
					else
					{%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%>)</td>
					<%}%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>
<!--				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>-->
	  				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%></td>	 
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
					<% if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit"))
					{%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%></td>
					<%}
					else
					{%>
					<td align="right">(<%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)))),strAmountValue)%>)</td>
					<%}
					if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit")){
					dblLimitTot=dblLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
					dblOutstandTot=dblOutstandTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
					dblExposureTot=dblExposureTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
					dblFreshLimit=dblFreshLimit+Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
					dblPropLimitTot=dblPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
					dblTotExp=dblTotExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
				}
					
					if(Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Main-Limit")||Helper.correctNull((String)arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit"))
						dblLimitTot1=dblLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
					%>
					
				</tr>
			<%} }%>
			<tr>
				<td align="center" colspan="2">TOTAL</td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblLimitTot1)),strAmountValue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblOutstandTot)),strAmountValue)%></td>
<!--				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblLimitTot)),strAmountValue)%></td>-->
	  			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblExposureTot)),strAmountValue)%></td>	 
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblFreshLimit)),strAmountValue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblPropLimitTot)),strAmountValue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblTotExp)),strAmountValue)%></td>
			</tr>
			<%} else{ %>
			<tr>
				<td align="left" style="border: none;"><%=strNil%></td>
			</tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>


<!-- Permissible Exposure -->

<tr>
	<td><br>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td width="50%" align="center">
						<table width="95%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="left" colspan="3"> Individual Rating Grade : &nbsp;</td>
							
						</tr>
						<%if(!Helper.correctNull((String)hshValues.get("creweight_recent")).equalsIgnoreCase("")){ %>
				<tr>
				<td align="center" width="25%">Year</td>
				<td align="center" width="25%">Type</td>
				<td align="center" width="50%">Rating</td>
			</tr>
			<tr>
				<td align="center" width="25%"><%=Helper.correctNull((String)hshValues.get("creratyear_recent")) %></td>
				<td align="center" width="25%"><%=Helper.correctNull((String)hshValues.get("crerattype_recent"))%></td>
				<td align="center" width="50%"><%=Helper.correctNull((String)hshValues.get("creweight_recent"))%></td>
			</tr>
<%} %>
						</table>

					</td>
					<td width="40%" align="center">
						<table width="95%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="left" width="50%">Permitted</td>
							<td align="left" width="50%">Actual</td>
						</tr>
						<tr>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(Helper.correctDouble((String)hshValues.get("dblIndVal"))),strAmountValue) %></td>
							<td align="right" width="50%">&nbsp;<%=Helper.converAmount(Helper.correctNull(jtn.format(dblTotExp)),strAmountValue)%>&nbsp;</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td width="50%" align="center">
						<table width="95%" cellpadding="0" cellspacing="0" border="0">
						<% if (arrGrpExp!=null && arrGrpExp.size()>0)
							{%> 
						<tr>
						
							<td align="left" colspan="4"> Group : </td>
						</tr>
						
						<tr>
							<td align="left" width="25%">Name</td>
							<td align="left" width="25%">Rating Grade</td>
							<td align="left" width="25%">Rating as on</td>
							<td align="left" width="25%">Exposure</td>
						</tr>
						<% for(int i=0;i<arrGrpExp.size();i++)
							{
							arrColExp=(ArrayList)arrGrpExp.get(i);
							%>
						<tr>
							<td align="left" width="25%"><%=Helper.correctNull((String) arrColExp.get(0))%></td>
							<td align="left" width="25%"><%=Helper.correctNull((String) arrColExp.get(1))%></td>
							<td align="left" width="25%"><%=Helper.correctNull((String) arrColExp.get(2))%></td>
							<td align="left" width="25%"><%=Helper.converAmount(Helper.correctNull(jtn.format( Double.parseDouble(Helper.correctDouble((String) arrColExp.get(3))))),strAmountValue)%></td>
						</tr>
						<%} %>
						<tr>
							<td align="left" width="75%" colspan="3">Total</td>
							<td align="left" width="25%"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblgrpexptot)),strAmountValue)%></td>
						</tr>
						<%}
						else
						{
						%>
						<tr>
						
							<td align="left" colspan="4"> Group : Nil </td>
						</tr>
						<%} %>
						</table>

					</td>
					<td width="50%" align="center" valign="top">
						<table width="95%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td align="left" width="50%">Permitted</td>
							<td align="left" width="50%">Actual</td>
						</tr>
						<tr>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("dblGrpVal")),strAmountValue) %></td>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(jtn.format( dblgrpexptot+dblTotExp)),strAmountValue)%></td>
						</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<!-- APPLICANT'S PROFILE -->
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<jsp:include page="../print/com_AnnexureII.jsp" flush="true">
		<jsp:param name="pageVal" value="MCFD"/>
		</jsp:include>
	</td>
</tr>

<!-- END -->

<!-- DETAILS OF CREDIT FACILITIES -->
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
		<jsp:include page="../print/com_AnnexureIII.jsp" flush="true">
		<jsp:param name="pageVal" value="AN3"/>
		<jsp:param name="proposalFormat" value="MCFD"/>
		</jsp:include>
	</td>
</tr>

<!-- END -->
<%if(finacial_flag){%>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td class="title"><br><%=strSno[a] %><%a=a+2; %>. Financial & Business Performance:  </td>
		</tr>
	</table>

	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
		<tr>
			<td valign="top"><br><b>1. ANALYSIS OF BALANCE SHEET</b><br></td>
		</tr>
	</table>
	
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
	<tr>
		<td align="left"><br><b> LIABILITIES :</b></td>                     
	</tr>
	<tr>
 		<td align="right"><%=strFinvaluesIn %></td>                     
 	</tr>
	</table>
	
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
		<tr valign="top">
			<td><div id="top">
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues" />
				</jsp:include>
			</div></td>
		</tr>
	</table>
	
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
	<tr>
		<td align="left"><br><b>ASSETS : </b></td>                     
	</tr>
	<tr>
 		<td align="right"><%=strFinvaluesIn %></td>                     
 	</tr>
	</table>
	
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">	
		<tr valign="top">
			<td><div id="top">
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues1" />
				</jsp:include>
			</div></td>
		</tr>
	</table>
<br>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
		<tr>
			<td align="left"><b> PROFIT AND LOSS ACCOUNT:</b></td>                     
  		</tr>
  		<tr>
  			<td align="right"><%=strFinvaluesIn %></td>                     
	 	</tr>
	 </table>
 	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
		<tr valign="top">
			<td>
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues2" />
				</jsp:include>
			</td>
		</tr>
	</table>
<br>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3">
		<tr>
			<td valign="top"><b>RATIO ANALYSIS:</b></td>
		</tr>
	</table>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3">
		<tr>
			<td align="left"><br><b>CAPITALISATION/COVERAGE/LIQUIDITY RATIOS :</b></td>                     
		</tr>
		<tr>
  			<td align="right"><%=strFinvaluesIn %></td>                     
	 	</tr>
		<tr valign="top">
			<td><div id="top">
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues3" />
				</jsp:include>
			</div></td>
		</tr>
		<tr>
			<td align="left"><br><b>PROFITABILITY/TURN OVER/ OPERATING : </b></td>                     
	  	</tr>
	  	<tr>
 			<td align="right"><%=strFinvaluesIn %></td>                     
 	</tr>
		<tr valign="top">
			<td><div id="top">
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues4" />
				</jsp:include>
			</div></td>
		</tr>
	</table>
	</td>
</tr>

<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td class="title"><br>Financial Comments:</td></tr>
</table>
<br>
<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				
<% if(Helper.correctNull((String)hshValues.get("fincommcheck")).equalsIgnoreCase("Y")) { %>
	<%if(arrFinCommRow!=null&&arrFinCommRow.size()>0){ 
	
	for(int j=0;j<arrFinCommRow.size();j++)
	{ 
		arrCol	= (ArrayList)arrFinCommRow.get(j);%>
		<tr>
		<td align="left"><%=Helper.correctNull((String)arrCol.get(0))%></td>
		<td align="left"><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		
<%}}}
else
{%>
	<tr><td style="border: none;"><%=strNil%></td></tr>
<% }
%>
			</table>
		</div>
	</td>
</tr>
<%} %>
<br>
<!-- TRANSACTIONS IN THE EXISTING ACCOUNTS-->
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<jsp:include page="../print/com_AnnexureV.jsp" flush="true">
		<jsp:param name="pageVal" value="ANN5"/>
		</jsp:include>
	</td>
</tr>

<!-- END -->

<!-- Present Proposal -->

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
	
<tr><td class="title"><br><%=strSno[a] %><%a++; %>.&nbsp;Present Proposal:</td></tr>
<tr><td>
<%=Helper.correctNull((String)hshValues.get("presentproposal_comment"))%>
</td></tr>

<!-- Term Loan Assessment -->
<% if(str_arry.contains("EXPORTCF@")) { %>
<tr><td class="title"><br>Assessment of TL</td></tr>
<%} %>
<%if(arrPresentTL!=null && arrPresentTL.size()>0){ %>
<tr><td>&nbsp;</td></tr>
<tr><td class="title">Details of proposed facilities:</td></tr>
<tr>
	<td align="right" width="50%"><%=strAmtValueIn%></td>
			</tr>
<tr><td>&nbsp;</td></tr>
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
<br>
<tr><td>&nbsp;</td></tr>
<%
if (str_arry.contains("CGSSD@")) {
%>
	<tr>
		<td style="border: none;"  class="title" align="left">&nbsp;&nbsp;&nbsp;&nbsp;Assessment for KBL CGSSD Scheme :</td>
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
<!-- vindhya begin -->
<% if(str_arry.contains("ENWR@")) { %>
<tr><td class="title"><br>Assessment for e- Krishik Bhandar</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
		<td align="left" width="">
		<div id="top">
			<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">			
				<tr>
					<td  width="25%" align="left"><br>Name of the Crop/Commodity</td>
					<td align="left" width="70%"><%=Helper.correctNull((String)hshValues.get("croporcommodity"))%></td>
				</tr>
				<tr>
					<td  align="left"><br>Number of Packages/Bags</td>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("noofpackages"))%></td>
				</tr>
				<tr>
					<td align="left"><br>Net Quantity in Quintal (A) </td>
					<td align="left"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("netquantity"))))%></td>
				</tr>
				<tr>
					<td align="left"><br>Estimated Value per Quintal (B) </td>
					<td align="left"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("estimatedvalue"))))%></td>
				</tr>
				<tr>
					<td align="left"><br>Total Value (A X B)(C)  </td>
					<td align="left"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalvalue"))))%></td>
				</tr>
				<tr>
					<td align="left"><br>Margin (25% of C )(D)</td>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("totalvalue"))%></td>
				</tr>
				<tr>
					<td align="left"><br>Eligible Loan amount (75% of C) (E)</td>
					<td align="left"><%=Helper.correctNull((String)hshValues.get("facproposed"))%></td>
				</tr>
				<tr>
					<td align="left"><br>Loan Applied</td>
					<td align="left"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("facproposed"))))%></td>
				</tr>
				<tr>
					<td align="left"><br>Loan Sanctioned Amount</td>
					<td align="left"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loansanctionamt"))))%></td>
				</tr>
			</table>
		</div>
		</td>
</tr>
<% } %>
<!-- vindhya end -->
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
<tr><td class="title"><br><u> 
<%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;-
<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;<%=stramtValIn%>
</u></td></tr>
<%} %>
<% if(!Helper.correctNull((String)hshValues.get("COM_COMMENTS_COP"+strFACSno)).equalsIgnoreCase("") ) 
{ %>
	<tr>
		<td><br><b>Brief Details of the project: </b></td>
	</tr>
	<%if(Helper.correctNull((String)hshValues.get("COM_PROJECTLOAN"+strFACSno)).equalsIgnoreCase("Y")){ %>
	<tr>
		<td><b>Project Loan : Yes </b></td>
	</tr>
	<tr>
		<td>Estimated Date of commencement of commercial operation (DCCO / COD)  : <%=Helper.correctNull((String)hshValues.get("COM_DATE_COP"+strFACSno)) %></td>
	</tr>
	<%} %>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_COP"+strFACSno))%></td>
	</tr>
<%} %>
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
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
				<td align="right" width="50%"  colspan="4" style="border:none"><%=strFinvaluesIn%></td>
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
				<!-- <tr><td style="border: none;"><%//=strNil%></td></tr> -->
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
							<td align="right" width="50%"   colspan="4" style="border:none"><%=strFinvaluesIn%></td>
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
				<!-- <tr><td style="border: none;"><%//=strNil%></td></tr> -->
				<%//} %>
			</table>
		</div>
	</td>
</tr>
<%if(strMOFFlag.equalsIgnoreCase("false")){ %>
<tr>
	<td><br><b>Debt : Equity : </b>&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("dbl_Debit"+strFACSno))%></td>
</tr>
<%} %>

<% if(!Helper.correctNull((String)hshValues.get("COM_COMMENTS_SOM"+strFACSno)).equalsIgnoreCase("") ) {%>
	<tr>
		<td><br><b>Source of margin money: </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_SOM"+strFACSno))%></td>
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
					<tr><td class="title"><br> <%=Helper.correctNull((String)arrCOPNewCol.get(1))%></td></tr>
				 
				 	<tr>
				 		<td><br><b>Details of Present Proposal: </b></td>
				 	</tr>
				 	<tr>
				 		<td><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS_COP"+j))%></td>
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
		<tr><td style="border: none;"><%=strNil%></td></tr>
	<%}
	
}
%>
<!-- DSCR -->
<%if(hshFinDSCR!=null && hshFinDSCR.size()>0) { %>
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
<%=Helper.correctNull((String)hshValues.get("fin_comments_dscr"))%>
</td></tr>
<tr>
<td align="right" width=""><%=strFinvaluesIn%></td>
</tr>
<tr>
	<td>
		<div align="left" id="top">
			<jsp:include page="../print/DSCR_Print.jsp" flush="true">
			<jsp:param name="pageVal" value="DSCR"/>
			</jsp:include>
		</div>
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
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
<td align="right"><%=strFinvaluesIn%></td>
</tr>
<tr>
	<td>
		<div align="left" id="top">
			<jsp:include page="../print/sensitivity_print.jsp" flush="true">
			<jsp:param name="pageVal" value="SENSITIVITY"/>
			</jsp:include>
		</div>
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
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td>
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td>
			<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title">Financial Year : <%=Helper.correctNull((String)hshValues.get("finyear"+(h+1))) %></td>
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
		<div align="left" id="top">
			<jsp:include page="../print/com_agrassessment_process.jsp" flush="true">
			<jsp:param name="pageVal" value="PROCESS"/>
			</jsp:include>
		</div>
	</td>
</tr>
<%} %>
	
<%if(!Helper.correctNull((String)hshValues.get("com_assessment_comments")).equalsIgnoreCase("")){ %>	
<tr><td class="title">Other Term Loan Assessment : </td></tr>
<tr><td ><%=Helper.correctNull((String)hshValues.get("com_assessment_comments"))%></td></tr>
<%} %>

<%if(!Helper.correctNull((String)hshValues.get("com_tlassessment_comments")).equalsIgnoreCase("")){%>
<tr><td class="title">Other Assessment for Term Loan: </td></tr>
<tr>
<td>
<%=Helper.correctNull((String)hshValues.get("com_tlassessment_comments"))%>
</td>
</tr>
<%} %>

<tr><td>&nbsp;</td></tr>
<!-- Release Pattern Started -->
<%
	if (arrReleaseRow != null && arrReleaseRow.size() > 0) {
		ArrayList arrReleaseCol = new ArrayList();%>
		
		<tr><td class="title" valign="top"><br>Release pattern/ margin requirement:</td></tr>
		<tr><td align="right" ><%=strFinvaluesIn%></td>
								</tr>
		
		<%
		for (int i = 0; i < arrReleaseRow.size(); i++) {
			arrReleaseCol = (ArrayList) arrReleaseRow.get(i);
			String strRel = Helper.correctNull((String) arrReleaseCol.get(2));
			//String strImpl = Helper.correctNull((String) arrReleaseCol.get(7));
			//String strEstimate = Helper.correctNull((String) arrReleaseCol.get(9));
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
							<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
							<tr><td valign="top" colspan="7"><b>
				  <%=Helper.correctNull((String) arrReleaseCol.get(1))%>&nbsp;of Rs. - <%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String) arrReleaseCol.get(5)))),strAmountValue)%> &nbsp;<%=stramtValIn%></b>
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
ArrayList arrRow = new ArrayList();
arrCol = new ArrayList();
boolean titleFlag=true;
if (arrImplSchRow != null && arrImplSchRow.size() > 0) {
	%>
	<tr><td class="title"><br>Schedule of Implementation:</td></tr> 
	<tr><td align="right" ><%=strAmtValueIn%></td></tr>
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
					<tr> <td colspan="5"><b><%=Helper.correctNull((String) arrImplSchCol.get(1)) %>  of Rs.  - <%=Helper.converAmount(Helper.correctNull((String) arrImplSchCol.get(3)),strAmountValue) %> <%=stramtValIn%></b></td> </tr>
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
<tr><td>&nbsp;</td></tr>
<%
		ArrayList arrOutCol1	= new ArrayList();
		ArrayList arrOutRow1	= (ArrayList) hshValues.get("arrOutRow1");
	%>
	<tr>
		<td>&nbsp;
			<table width="95%" align="left" cellpadding="3" cellspacing="0" border="0">
				<tr ><td align="left">&nbsp;<b>MODE OF REPAYMENT:</b></td></tr>
				<tr><td>&nbsp;</td></tr>
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
<tr><td class="title" >Assessment of fund based working capital limits :</td></tr>

<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			
			<tr>
			<td align="right" width="50%"><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<%} %>
<%if(arrPresentWC!=null && arrPresentWC.size()>0){ %>
<tr><td class="title">Details of proposed facilities:</td></tr>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Turnover Method:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<% if (!Helper.correctNull((String)hshValues.get("fin_commentsturnover")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_commentsturnover"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%} %>

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
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1turnover"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%} } %>


<!-- Expenditure Method -->

<%if(arrExpRow!=null&&arrExpRow.size()>0){ %>
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

<% if (!Helper.correctNull((String)hshValues.get("fin_commentsexpenditure")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_commentsexpenditure"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%} %>

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
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1expenditure"))%></td></tr>
<tr><td align="left"><b>&nbsp;</b></td></tr><%} }%>

<tr><td>
<%
String str_arr[]={"Particulars","<b>Cash Inflows</b>","Net contract receipts","Sub contrcat Receipts","Other Receipts"
		,"Total Receipts","<b>Cash Outflows</b>","Materials","Salaries & Wages","Salaries & Wages","Hire Charges"
		,"Labour Charges","Diesel & Petrol Charges ","Repair & Maintenance","Travelling Expenses","Other Operating Expenses"
		,"Bank Interest & Charges","Tax payable ","Administrative expenses ","Other expenses ","Total Outflows "
		,"Surplus / Deficit"};
HashMap hshRecord=new HashMap();
count=Integer.parseInt(Helper.correctInt((String)hshValues.get("count")));

if (!Helper.correctNull((String)hshValues.get("fin_commentscashbudget")).equalsIgnoreCase("")) { %>
<table>
<tr><td>Comments on Cash Budget Method:</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_commentscashbudget"))%></td></tr>
</table>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td>
					<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr><td> <b>Financial Year : <%=Helper.correctNull((String)hshValues.get("cb_finyear"+(h+1))) %></b></td></tr>
			</table>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
<tr ><td class="title">Cash Budget Method : </td></tr>
<tr style="visibility: hidden;position: absolute;"><td style="border: none;"><%=strNil%></td></tr>
<%} } %>

<% if (!Helper.correctNull((String)hshValues.get("fin_comments1cashbudget")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1cashbudget"))%></td></tr>
<%} %>

<!-- Assessment of Method 1/Method 2/Working Capital -->
<%if(hshFinmethod1!=null && hshFinmethod1.size()>0) { %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">Method I of lending other than export limits:</td>
			</tr>
		</table>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments_method1")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments_method1"))%></td></tr>
<%} %>
<tr><td align="right"><%=strFinvaluesIn%></td></tr>
<tr><td>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method1"/>
</jsp:include></td></tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_method1")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_method1"))%></td></tr>
<%} %>
<%} %>

<%if(hshFinmethod2!=null && hshFinmethod2.size()>0) { %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">Method II of lending other than export limits:</td>
			</tr>
		</table>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments_method2")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments_method2"))%></td></tr>
<%} %>
<tr><td align="right"><%=strFinvaluesIn%></td></tr>
<tr><td>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method2"/>
</jsp:include></td></tr>

<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_method2")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_method2"))%></td></tr>
<%} %>
<%} %>

<%if(hshFinmethod3!=null && hshFinmethod3.size()>0) { %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" valign="top"><br>Working Capital gap method for export limits:</td>
			</tr>
		</table>
	</td>
</tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments_wcg")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments_wcg"))%></td></tr>
<%} %>
<tr><td align="right"><%=strFinvaluesIn%></td></tr>
<tr><td>
<jsp:include page="../print/com_assessmentprint.jsp" flush="true">
<jsp:param name="pagevalue" value="method3"/>
</jsp:include></td></tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments1_wcg")).equalsIgnoreCase("")) { %>
<tr><td><%=Helper.correctNull((String)hshValues.get("fin_comments1_wcg"))%></td></tr>
<%} %>
<%} %>

<!-- Financial Comments 

<% if (!Helper.correctNull((String)hshValues.get("FIComments1")).equalsIgnoreCase("")) { %>
<tr><td class="title"><br><span  class="title">Inventory :</span></td></tr>
<tr><td><%//=Helper.correctNull((String)hshValues.get("FIComments1"))%></td></tr><%} %>

<% if (!Helper.correctNull((String)hshValues.get("FIComments3")).equalsIgnoreCase("")) { %>
<tr><td class="title"><br><span  class="title">Receivables :</span></td></tr>
<tr><td><%//=Helper.correctNull((String)hshValues.get("FIComments3"))%></td></tr><%} %>

<% if (!Helper.correctNull((String)hshValues.get("FIComments5")).equalsIgnoreCase("")) { %>
<tr><td class="title"><br><span  class="title">Creditors :</span></td></tr>
<tr><td><%//=Helper.correctNull((String)hshValues.get("FIComments5"))%></td></tr><%} %>

<% if (!Helper.correctNull((String)hshValues.get("FIComments6")).equalsIgnoreCase("")) { %>
<tr><td class="title"><br><span  class="title">Other Current Assets and Liabilities :</span></td></tr>
<tr><td><%//=Helper.correctNull((String)hshValues.get("FIComments6"))%></td></tr><%} %>
-->

<%if(!Helper.correctNull((String)hshValues.get("strInv")).equalsIgnoreCase("") ||
		!Helper.correctNull((String)hshValues.get("strReceiv")).equalsIgnoreCase("") ||
			!Helper.correctNull((String)hshValues.get("strCreditors")).equalsIgnoreCase("") ||
			!Helper.correctNull((String)hshValues.get("strOtherAssets")).equalsIgnoreCase("")){ %>
<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				
				<% if (!Helper.correctNull((String)hshValues.get("com_assessment_comments20")).equalsIgnoreCase("")) { %>
				<tr><td class="title" align="left"><b>Other Working Capital Assessment : </b></td></tr>
				
				
				<tr><td><%=Helper.correctNull((String)hshValues.get("com_assessment_comments20"))%></td></tr>
				
				<tr><td class="title" align="left"><b>&nbsp;</b></td></tr><%}  %>

			</table>
		</div>
	</td>
</tr>
<!-- Assessment Holding level comments -->
<%if(arrAssmntRow.size()>0 && arrAssmntRow !=null){ %>
<tr>
	<td>	
		<div>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
<tr><td class="title">Other Assessment for WCDPN/WCTL : </td></tr>
<tr>
<td>
<%=Helper.correctNull((String)hshValues.get("com_wcassessment_comments"))%>
</td>
</tr>
<%} %>
<tr><td>&nbsp;</td></tr>
<% if (!Helper.correctNull((String)hshValues.get("fin_commentsinlandComments")).equalsIgnoreCase("")) { %>
<tr>
		<td class="title" align="left"><b>Assessment of non fund based working capital limits : </b></td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			
			<tr>
			<td align="right" width="50%"><%=strFinvaluesIn%></td>
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
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td class="title"><br>Assessment of Inland / Import LC:</td>
						<td align="right" width="">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td align="right" ><%=strFinvaluesIn%></td>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
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
	<td style="border: none;"  class="title" align="left">Assessment of Restructuring :</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>	
	<div id="top">
	<table width="100%" cellpadding="3" cellspacing="0" border="0">
	
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
<%boolean boolflag=true; 
int y=0;%>
<%if(arrRBIGuidliness!=null && arrRBIGuidliness.size()>0){
%>
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><%=strSno[a] %> .<%a++; %>RBI Guidelines /Compliances for Restructuring</td>
			</tr>
		</table>
</td>
</tr>
<tr>
	<td>
<div id="top">
<table width="95%" cellpadding="3" cellspacing="0" border="0"  align="center">
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
<td align="center"><%=++y %></td>
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
boolflag=true;%>
<tr>
	<td>
<div id="top">
<table width="95%" cellpadding="3" cellspacing="0" border="0"  align="center">
<%y=0;
for(int i=0;i<arrRBIGuidliness.size();i++){ 
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
<td align="center"><%=++y %></td>
<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
<td><%=Helper.correctNull((String)arrCol.get(3)) %></td>
</tr>
<%}}%>
</table>
</div>
</td>
</tr>
<%} if(Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("S")){%>

<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><%=strSno[a] %>. <%a++; %>PROVISION FOR DIMUNATION IN THE FAIR VALUE OF RESTRUCTURED ADVANCES: </td>
			</tr>
			<%if(!Helper.correctNull((String)hshValues.get("strFVCComments")).equalsIgnoreCase("")){%>
			<tr>
				<td><%=Helper.correctNull((String)hshValues.get("strFVCComments"))%> </td>
			</tr>
			<%}else{ %>
			<tr>
				<td align="center"><b>- NIL - </b></td>
			</tr>
			<%} %>
		</table>
</td>
</tr>

<%}if(TakeOvercheck.equalsIgnoreCase("y")){ %>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>E ) Take Over Norms</td>
			</tr>
		</table>
	</td>
</tr>
<tr> 
   <td> 
   <div id="top">
     <table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">
       <tr> 
         <td align="center" width="65%"><b>Stipulated Parameter</b></td>
         <td align="center" width="35%"><b>Compliance</b></td>
       </tr>
       <%
		 if(arrTakeOver!=null && arrTakeOver.size()>0)
		 {
		 	for(int i=0;i<arrTakeOver.size();i++)	
			{	
		 		arrCol=(ArrayList)arrTakeOver.get(i);
			if(arrCol!=null && arrCol.size()>0)
			{
		 %>
       <tr> 
         	<td width="65%" align="left">&nbsp; <%=Helper.correctNull((String)arrCol.get(1))%></td>
         	<td width="35%" align="left">&nbsp; <%=Helper.correctNull((String)arrCol.get(3))%></td>
       </tr>
		<%} } }%>
     </table>
     </div>
   </td>
 </tr>
 <%if(!Helper.correctNull((String)hshValues.get("strTakeoverComments")).equalsIgnoreCase("")){ %>
 <tr> 
   <td> 
     <table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">
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
<%}%>

<%
if(strSessionModuleType.equalsIgnoreCase("CORP")|| (strSessionModuleType.equalsIgnoreCase("AGR") && strFinancialrequired.equalsIgnoreCase("Y"))){
 	if (vecsize != 0 && vec != null) {
 %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br><%=strSno[a] %><%a++; %>&nbsp;Deviation if any in loan policy:</td>
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
			<table width="95%" border="0" cellspacing="0" cellpadding="2" align="center">
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
                       <%if(Helper.correctNull((String) g2.get(5)).equalsIgnoreCase("M")){ %>
                       	<td align="right" nowrap width="20%"><%=Helper.correctNull((String) g2.get(7))%></td>
						<%}else{ %>
						<td align="right" nowrap width="20%"><%=Helper.correctNull((String) g2.get(5))%></td>
						<%} %>
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
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr><td class="title">Comments:</td></tr>
			<tr><td><%=Helper.correctNull((String) hshValues.get("fin_benchmarkcmts")) %></td></tr>
		</table>
	</td>
</tr>
 <%
} %>
 <%
 	}}
 %>
<!-- Other Relevant Information -->
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%int m=1; %>
			
			<% count=Integer.parseInt(Helper.correctInt((String)hshValues.get("OtherRelevantInfo")));
			if (count==1||intRatiCount>0){%>
			<tr><td class="title"><br>VII.&nbsp;Other relevant information:</td></tr>
			<% if (!Helper.correctNull((String)hshValues.get("MgmtComments8")).equalsIgnoreCase("")) { %>
			<tr><td class="title"><br><%=m++%>) In principle clearance details:</td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments8"))%></td></tr><%} %>
			
			<% if (!Helper.correctNull((String)hshValues.get("MgmtComments9")).equalsIgnoreCase("")) { %>
			<tr><td class="title"><br><%=m++%>) Account clearance:</td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments9"))%></td></tr><%} %>
			
			<% if (!Helper.correctNull((String)hshValues.get("MgmtComments10")).equalsIgnoreCase("")) { %>
			<tr><td class="title"><br><%=m++%>) Others:</td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments10"))%></td></tr><%} %>
			
			<% if (!Helper.correctNull((String)hshValues.get("MgmtComments11")).equalsIgnoreCase("")) { %>
			<tr><td class="title"><br><%=m++%>) ALCO clearance:</td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments11"))%></td></tr><%} %>
			
			<% if (!Helper.correctNull((String)hshValues.get("MgmtComments12")).equalsIgnoreCase("")) { %>
			<tr><td class="title"><br><%=m++%>) Period of renewal:</td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments12"))%></td></tr><%} %>
			
			<% if (!Helper.correctNull((String)hshValues.get("MgmtComments13")).equalsIgnoreCase("")) { %>
			<tr><td class="title"><br><%=m++%>) Interest rate and commission:</td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments13"))%></td></tr><%} %>
			
			<% if (!Helper.correctNull((String)hshValues.get("MgmtComments16")).equalsIgnoreCase("")) { %>
			<tr><td class="title"><br><%=m++%>) Others information:</td></tr>
			<tr><td><%=Helper.correctNull((String)hshValues.get("MgmtComments16"))%></td></tr><%} %>
			<%if(intRatiCount>0){ %>
			<tr><td class="title"><b>Recommendation/Ratification : </b></td></tr>
			
			 <%	for(int i=0;i<intRatiCount;i++){ %>
				<tr><td class="title"><%=Helper.correctNull((String)hshValues.get("rati_desc"+i))%></td></tr>
				<tr><td><%=Helper.correctNull((String)hshValues.get("rati_comments"+i))%></td></tr>
			<%} } 
			else{%>
			<tr><td class="title"><b>Recommendation/Ratification : &nbsp; Nill</b></td></tr>
				<%} 
			}%>
			
			<tr><td class="title" valign="top"><br>Sanctioning Authority :</td></tr>
			<tr> <td><%=Helper.correctNull((String)hshValues.get("com_sancauthorityVal"))%></td></tr>
		</table>
	</td>
</tr>

<!-- Recommendations -->
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr><td class="title"><br><%=strSno[a] %><%a++; %>&nbsp;Recommendations:</td></tr>
		<%if(Helper.correctNull((String)hshValues.get("com_sancauthority")).equals("15")||Helper.correctNull((String)hshValues.get("com_sancauthority")).equals("16")){ %>
		<tr>
			<td>In the light of the above, we recommend for considering the proposal and the following resolution may be passed with or without modifications.<br><br>
			"Resolved that <b><%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%></b> be sanctioned the following facilities on the terms and conditions, mentioned here under:
			</td>
		</tr>
		<%}else{ %>
		<tr>
			<td>In the light of the above, <b><%=Helper.correctNull((String)hshValues.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%></b> be sanctioned the following facilities on the terms and conditions, mentioned here under :
			</td>
		</tr>
		<%} %>
		</table>
	</td>
</tr>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
			<%if(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17)))!=0){ %>
				<td align="center" rowspan="3"><%=i + 1%>.</td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(26))%></td>
				<td>Loan Sanction Amount</td>
				<%if(!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF")){ %>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))-Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17)))),strAmountValue)%></td>
					<%}else{ %>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)))),strAmountValue)%></td>
					<%} %>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(18))%></td>
				</tr>
				<tr>
					<td><%=Helper.correctNull((String) arrCol.get(19))%></td>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17)))),strAmountValue)%></td>
				</tr>
				<tr class="title">
					<td>Total Loan Sanction Limit</td>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)))),strAmountValue)%></td>
				<%}else{ %>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(5))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(26))%></td>
				<td align="right"  colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%><br/>Without any insurance coverage.</td>
				<td align="left" rowspan=""><%=Helper.correctNull((String) arrCol.get(18))%></td>
			<%}%>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>
<br></br>
<tr>
	<td>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
					if(!Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("NC") && !Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("")){
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
				<td align="center"><%=w %>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(19))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(21))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(22))))),strAmountValue)%></td>
				<%if(Helper.correctNull((String) arrCol.get(20)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(23))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(25))%></td>
				<%}else if(bflag){ %>
				<td align="right" colspan="3">&nbsp;</td>
				<%}  %>
				
				
		   	</tr>
			<%}} }%>
			
	 <%} %>
	 </table>
	 </div>
	 </td>


</tr>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>RATE OF INTEREST/ COMMISSION:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<%if(strSessionModuleType.equalsIgnoreCase("CORP")){
	int j=0;%>
<tr>
	<td>
		<div id="top">
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="10%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0 && strWhetherBRAvail.equalsIgnoreCase("Y")){ 
				 %>

			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")||
						Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS") || Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC") || Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("FTBR")){
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
			</tr>
			<%} }}%>
<%if((arrRowNonBr!=null && arrRowNonBr.size()>0)&& (!Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("FTBR")))
	{
		for(int k=0;k<arrRowNonBr.size();k++)
		{
			arrColNonBr=(ArrayList)arrRowNonBr.get(k);
			if(arrColNonBr.size()>0)
			{
			%>
			 <tr>
			 <td align="center"><%=j+1%>.</td>
					<td><%=Helper.correctNull((String)arrColNonBr.get(0))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrColNonBr.get(2))))),strAmountValue)%></td>
					<td><%=Helper.correctNull((String)arrColNonBr.get(1))%></td>
			</tr>	 
			<%	
			}
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
<%}else{%>
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
				<td width="10%" align="center">Amount</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<%if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")||
						Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS")){ %>
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
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="10%" align="center">Amount</td>
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
				<%if(!Helper.correctNull((String) arrCol.get(29)).equalsIgnoreCase("")){ %>Relaxation in margin as per RBI COVID relief Package Policy : <%=Helper.correctNull((String) arrCol.get(29))%><%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(27)).equalsIgnoreCase("")){ %>Actual Margin (%):<%=Helper.correctNull((String) arrCol.get(27)) %> <%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(28)).equalsIgnoreCase("")){ %>Relaxed Margin (%):<%=Helper.correctNull((String) arrCol.get(28)) %> <%} %></td>
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
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="40%" align="center">Type of Facility</td>
				<td width="10%" align="center">Amount</td>
				<td width="10%" align="center">Tenor <br>(in Months)</td>
				<td width="30%" align="center">Initial Holiday/ Gestation/ Moratorium Period <br>(in Months)</td>
				<td width="17%" align="center">Due Date</td>
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
				<%if(!Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("")){ %>
				<td align="center"><%=Helper.correctNull((String)arrCol.get(13))%></td>
				<%}else{ %>
				<td align="center">-</td>
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
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="30%" align="center">Mode of Repayment</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
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
	<tr>
		<td>&nbsp;
				<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr><td>&nbsp;<b>REPAYMENT SCHEDULE COMMENTS:</b></td></tr>
				<tr><td>&nbsp;</td></tr>
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



<%
ArrayList arrpropsecurityRow=new ArrayList();
ArrayList arrpropsecCollRow=new ArrayList();
arrpropsecurityRow=(ArrayList)hshValuesAN3.get("arrproposedSecfacwise");
arrpropsecCollRow=(ArrayList)hshValuesAN3.get("arrRowCollSec");
String strProposedSecurity=Helper.correctNull((String)hshValuesAN3.get("strProposedSecurity"));
if(!strProposedSecurity.equalsIgnoreCase("M")){
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td><table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Securities&nbsp;:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table></td></tr>
<tr><td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
<tr align="left">
<td colspan="4"><b>Prime :</b></td>
</tr>
<% 

ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
String secValue = "";
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
if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
<td colspan="4" align="left"><b>Collateral:</b></td>
</tr>
<% 
ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
String secValue = "";
if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
	for(int i=0;i<arrpropsecCollRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
		 secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
			if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
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
<% }}else if(strProposedSecurity.equalsIgnoreCase("M")){%>
<tr><td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>Securities&nbsp;:</td>
			</tr>
			<tr>
				<td><%=Helper.correctNull((String)hshValuesAN3.get("strProposedSecurityComments"))%></td>
			</tr>
		</table>
</td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValuesAN3.get("companyinfo_typeofliability")).equalsIgnoreCase("")){ %>
<tr>
<td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
<%=Helper.correctNull((String)hshValuesAN3.get("companyinfo_typeofliability")) %>
</td>
</table>
</div>
</td>
</tr>
<%} %>
<%ArrayList arrPromoterRow	= (ArrayList)hshValuesPromotor.get("arrGuaRow");
if(arrPromoterRow!=null&&arrPromoterRow.size()>0) {%>
<tr>
<td>
    <table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td class="title"><br><b>Co-Obligants/ Guarantors:</br></b></td>
		</tr>
	</table>
	</td>
</tr>
<br>
<tr>
	<td>
	<div id="top">
	<table width="60%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
	<td width="5%" align="center" class="title">S.No</td>
	<td width="65%" align="center" class="title">Name</td>
	<td width="20%" align="center" class="title">Type</td>
	</tr>
<%
ArrayList arrOutCol=new ArrayList();
String strAppltype="";
int x=0;String strPrevCusID = "",strPrevType="";
if(arrPromoterRow!=null&&arrPromoterRow.size()>0){
	for(int i=0;i<arrPromoterRow.size();i++) {
		arrOutCol	= (ArrayList)arrPromoterRow.get(i);
		
		if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrOutCol.get(0))) && strPrevType.equalsIgnoreCase(Helper.correctNull((String)arrOutCol.get(6))))
		{
			continue;
		}
		else
		{
			strPrevCusID = Helper.correctNull((String)arrOutCol.get(0));		
			strPrevType = Helper.correctNull((String)arrOutCol.get(6));		
		}
		
		if(arrOutCol!=null&&arrOutCol.size()>0){
		if(Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("G") || Helper.correctNull((String)arrOutCol.get(6)).equalsIgnoreCase("CO")){
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
	
	if(x==0)
	{%>
		<tr>
				<td align="center" colspan="3"> - Nil -&nbsp;</td>
			</tr>
	<%}
}
%>
</table>
</div>
		</td>
</tr>
<%} %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
								<table width="95%" align="center" cellpadding="3"
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
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<%if(APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("PC")){ %>
			
				<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b>  (Inclusive of all Taxes)</td>
			<%}else{ %>
				<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> + Applicable Taxes</td>
			<%} %>
			</tr>
		</table>
	</td>
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
	<table class="Table" style="width:95.0%; border-collapse:collapse; border:solid black 1.0pt" width="95%">
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
		<tr><td>&nbsp;</td></tr>
		<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<%ArrayList vecNcgtcRow=new ArrayList();
	ArrayList vecNcgtcCol=new ArrayList();
	vecNcgtcRow=(ArrayList)hshValues.get("vecNcgtcRow");
	if(vecNcgtcRow!=null){
				vecNcgtcCol=new ArrayList();
				int intncgtcSize = 0;
				intncgtcSize = vecNcgtcRow.size();;%>
				<tr>
				<td colspan="3"><b>KBL Aarogya NCGTC Details</b></td>
				</tr>
				<%
				for(int s=0;s<intncgtcSize ;s++)
				{
					vecNcgtcCol = (ArrayList) vecNcgtcRow.get(s);%>
	<tr> 
	<td colspan="3"><b><%=Helper.correctNull((String)vecNcgtcCol.get(13))%> - <%=Helper.correctNull((String)vecNcgtcCol.get(14))%></b></td>
	</tr>
	<tr class="">
		<td width="40%" style="text-align: center"><b>Details of the Project</b></td>
		<td width="30%" style="text-align: center"><b>Project description</b></td>
		<td width="30%" style="text-align: center"><b>Eligibility</b></td>
	</tr>
	<%if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("1")){ %>
	<tr>
		<td width="40%">Type of the Project</td> 
		<td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td>
		<td width="30%">&nbsp;</td>
	</tr>
	<tr id="t1">
		<td>New employment likely to be generated in case of greenfield projects&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(4))%>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%}else if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("2")){ %>
	<tr>
		<td width="40%">Type of the Project</td> 
		<td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td>
		<td width="30%">&nbsp;</td>
	</tr>
	<tr id="t2">
		<td>Additional employment likely to be generated in case of brownfield&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(5))%>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<%}%>
	<tr>
		<td>Whether the project is in any of the metropolitan cities  Ahmedabad, Bengaluru, Hyderabad, Chennai, Kolkata, Mumbai, New Delhi and Pune&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(6))%>&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(7))%>&nbsp;</td>
	</tr>
	<tr>
		<td>Industry Sector&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(8))%>&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(9))%>&nbsp;</td>
	</tr>
		<tr>
		<td>Udyog Aadhaar Number(12 Digits)&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(10))%>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="60%">Project unit pin code</td>
		<td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(11))%></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td width="60%">Nature of the Project</td>
		<td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(12))%></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
	<td colspan="3"><b>&nbsp;</b></td>
	</tr>
	<%}} %>
</table>
</td>
</tr>
<tr>
<td> &nbsp;</td>
</tr>
<tr>
	<td><br>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr><td class="title"><br>TERMS AND CONDITIONS:</td></tr>
		</table>
	</td>
</tr>

<% if((arrFacilityTerm0!=null && arrFacilityTerm0.size()>0) || arrFacilityTermApp0!=null)
{ %>
<tr>
	<td><br>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr><td><b>Specific:</b></td></tr>
		</table>
	</td>
</tr>
	
<%} %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">

<%
	int j=0;
	int sub=0;
	int main=0;
	String prevSno="";
	String currParentId="";
	String termsno = "";
	boolean booflag=true;
	boolean subflag=true;

	if(arrFacilityTerm0!=null && arrFacilityTerm0.size()>0)
	{ %>
	<%	j=arrFacilityTerm0.size();
		for(int i=0;i<arrFacilityTerm0.size();i++)
		{
			termsno = Helper.correctNull((String) arrFacilityIdVal0.get(i));
			currParentId=Helper.correctNull((String) arrParentID0.get(i));
			if(currParentId.equalsIgnoreCase("0") && subflag==true )
			{
				booflag=true;
				sub=0;
			}
			if(booflag)
			{
				main = main+1;
				prevSno=Helper.correctNull((String) arrFacilityIdVal0.get(i));
				booflag=false;
			}
		%>
		<%if(currParentId.equalsIgnoreCase("0"))
		{
			subflag=true;
		%>
		<tr> 
		  	<td nowrap="nowrap"><br>
		      	<table cellpadding="3" cellspacing="0" width="95%" align="center">
			      	<tr>
			      		<td width="2%" valign="top"><%=main%>.</td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
		</tr>
		<%}
		if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
		{
		%>
		<tr> 
	      	<td nowrap="nowrap"><br>
		      	<table cellpadding="0" cellspacing="0" width="95%" align="right">
			      	<tr>
			      		<td width="2%" valign="top">&nbsp;<%=main%>.<%=++sub%></td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
	    </tr>
		
		<%}
		}
	} %>
	<%
	if(arrFacilityTermApp0!=null)
	{
		for(int i=0;i<arrFacilityTermApp0.size();i++)
		{  main = main+1;
		%>
		<tr> 
	      	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="0" cellspacing="0" width="95%" align="center">
				<tr > 
				  <td align="center"> 
				    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
				  </td>
				</tr>
				</table>
			</td>
		</tr>
		<%
		}
	} %>
		</table>
	</td>
<tr>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td ><b>General:</b> &nbsp;Indicated in Annexure III</td>
		</tr>
		</table>
	</td>
</tr>
<tr><td>&nbsp;<br></td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<%	if(arrDeleRow!=null&&arrDeleRow.size()>0)
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
			<tr>
				<td align="left"><br> <%=Helper.correctNull((String)arrCol.get(0))%> </td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(1))%></td>
			</tr>
			<%if(bflag){ %>
			<tr><td align="left"> Discussed and cleared in the Credit approval GRID on <%=Helper.correctNull((String)hshValues.get("com_griddate"))%> </td></tr>
			<%
			}}else{ %>
			<tr>
				<td align="right"><br><%=Helper.correctNull((String)arrCol.get(0))%> </td>
			</tr>
			<tr>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(1))%></td>
			</tr>
			<%if(bflag){ %>
			<tr><td align="left"> Discussed and cleared in the Credit approval GRID on <%=Helper.correctNull((String)hshValues.get("com_griddate"))%> </td></tr>
			<%
			}} %>
		<%} } %>
		</table>
	</td>
</tr>

<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="title"><br>Enclosures:</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td><div id="top">
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="80%" align="center" cellpadding="3" cellspacing="0" border="0" style="page-break-before:always">
		<tr>
			<td align="center" width="30%">&nbsp;</td>
			<td align="center" width="65%" class="title">Particulars</td>
		</tr>
		<tr>
			<td width="30%"> &nbsp;Annexure I</td>
			<td width="70%"> &nbsp;Branch Indices</td>
		</tr>
		<tr>
			<td width="30%"> &nbsp;Annexure II</td>
			<td width="70%"> &nbsp;SWOT Analysis</td>
		</tr>
		<tr>
			<td width="30%"> &nbsp;Annexure III</td>
			<td width="70%"> &nbsp;General Conditions</td>
		</tr>
		<tr>
			<td width="30%"> &nbsp;Annexure IV</td>
			<td width="70%"> &nbsp;Projected Profitability statement and balance sheet</td>
		</tr>
		
		</table>
	</div></td>
</tr>	
</table>
</body>
</html>