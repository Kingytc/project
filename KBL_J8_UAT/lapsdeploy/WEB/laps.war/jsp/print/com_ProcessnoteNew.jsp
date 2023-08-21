<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*;"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<%
java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

boolean booAssFlag = true;

HashMap hshAddeDetails=new HashMap();
HashMap hshAddeDetails1=new HashMap();
HashMap hshConsDetails=new HashMap();
double dblLimitTot=0.0,dblOutstandTot=0.0,dblExposureTot=0.0,dblPropLimitTot=0.0,dblTotalExp=0.0,dblLimitTot1=0.0,dblTLExposure=0.0,
dblMLimitTot=0.0,dblMOutstandTot=0.0,dblMExposureTot=0.0,dblMPropLimitTot=0.0,dblMTotalExp=0.0,dblMLimitTot1=0.0;

String strAd1="",strAd2="",strAd3="",strDis="",strCity="",strState="",strCountry="",app_constitution="",strAddress="";
String Address="",strZipcode="", strCommaddress="",strPerAddress="",strAdminAddress="";
String strResidentstatus="",strSancAuth = "",strHeaderFlag="true";
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

String strLoanType = Helper.correctNull((String) hshValues
		.get("strLoanTypeNew"));
StringBuilder strBanking=new StringBuilder();


ArrayList arrPromoterRow	= new ArrayList();
ArrayList arrFacRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrCol1 = new ArrayList();
ArrayList arrRowRatingRMD  = new ArrayList();
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
ArrayList arrImplSchRow  = new ArrayList();
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
ArrayList arrOutCol			= new ArrayList();
ArrayList arrGuaRow			= new ArrayList();
ArrayList arrRowRelation	= new ArrayList();
ArrayList arrColRelation	= new ArrayList();
ArrayList arrRowDefault		= new ArrayList();
ArrayList arrFactoryDetails		= new ArrayList();
ArrayList arrColDefault		= new ArrayList();
ArrayList arrPresentWC = new ArrayList();
ArrayList arrExistingWC = new ArrayList();
ArrayList arrAssmntRow = new ArrayList();
ArrayList arrRowTakeover = (ArrayList) hshValues.get("arrTakeoverVal");
ArrayList arrDrawDown  = (ArrayList) hshValues.get("arrDrawDown");
ArrayList arrBanking  = (ArrayList) hshValues.get("arrBanking");
ArrayList arrRating  = (ArrayList) hshValues.get("arrRating");
ArrayList arrLeaderBankTL  = new ArrayList();
ArrayList arrLeaderBankWC  = new ArrayList();
ArrayList arrOtherBankTL  = new ArrayList();
ArrayList arrOtherBankWC  = new ArrayList();
ArrayList arrGroupRow = new ArrayList();
arrGroupRow = (ArrayList) hshValues.get("arrGroupRow");
ArrayList arrSingleCons =  new ArrayList();
ArrayList arrMultipleCons = new ArrayList();
ArrayList arrMultiple 	= new ArrayList();
ArrayList arrConsortDet = new ArrayList();
ArrayList arrMultipleConsWC1 = new ArrayList();
ArrayList arrMechRow = new ArrayList();
ArrayList arrRowprop= new ArrayList();
ArrayList arrColprop= new ArrayList();
ArrayList arrYear = (ArrayList)hshValues.get("arrYear");
ArrayList arrGrowth = (ArrayList)hshValues.get("arrGrowth");
ArrayList arrAchievement = (ArrayList)hshValues.get("arrAchievement");
ArrayList arrSalesProj = (ArrayList)hshValues.get("arrSalesProj");
ArrayList arrSalesAct = (ArrayList)hshValues.get("arrSalesAct");
ArrayList arrRowcgssd= new ArrayList();
ArrayList arrColcgssd= new ArrayList();
ArrayList arrMISRow = (ArrayList) hshValues.get("arrMISRow");
ArrayList arrColMIS = new ArrayList();
if(arrBanking!=null && arrBanking.size()>0)
{
	for(int a=0;a<arrBanking.size();a++)
	{
		if(strBanking.length()==0)
			strBanking.append(Helper.correctNull((String)arrBanking.get(a)));
		else
			strBanking.append(" / ").append(Helper.correctNull((String)arrBanking.get(a)));
	}
}

if (hshValues != null) {
	
	strSancAuth = Helper.correctNull((String) hshValues
			.get("com_sancauthority"));
	hshAddeDetails1 = (HashMap)hshValues.get("PROPOSALLC");
	hshConsDetails = (HashMap)hshValues.get("PROPOSAL");
	if(hshAddeDetails1!=null){
		hshAddeDetails  = (HashMap)hshAddeDetails1.get("hshRespDetails");
		arrPromoterRow	= (ArrayList)hshAddeDetails1.get("arrPromoterRow");
		arrGuaRow		= (ArrayList)hshAddeDetails1.get("arrGuaRow");
		arrRowRelation = (ArrayList)hshAddeDetails1.get("Relationship");
		arrRowDefault = (ArrayList)hshAddeDetails1.get("arrRowDefault");
		arrFactoryDetails = (ArrayList)hshAddeDetails1.get("arrFactoryDetails");
	}
	if(hshConsDetails!=null){
		arrLeaderBankTL  = (ArrayList) hshConsDetails.get("arrLeaderBankTL");
		arrLeaderBankWC  = (ArrayList) hshConsDetails.get("arrLeaderBankWC");
		arrOtherBankTL  = (ArrayList) hshConsDetails.get("arrOtherBankTL");
		arrOtherBankWC  = (ArrayList) hshConsDetails.get("arrOtherBankWC");
		
		arrSingleCons = (ArrayList)hshConsDetails.get("arrSingleCons");
		arrMultipleCons = (ArrayList)hshConsDetails.get("arrMultipleCons");
		arrMultiple		= (ArrayList)hshConsDetails.get("arrMultiple");
		arrConsortDet = (ArrayList)hshConsDetails.get("arrConsortDet");
		arrMultipleConsWC1 = (ArrayList)hshConsDetails.get("arrMultipleConsWC1");
	}
}

int RowCount=0;
	if(hshAddeDetails!=null)
	{
		strResidentstatus=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("strResidentstatus")));
		strAd1=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_address1")));
		strAd2=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_address2")));
	 	strAd3=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_address3")));
	 	strCity=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_city")));
	 	strDis=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_district")));
	 	strState=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_state")));
	 	strZipcode=Helper.correctNull((String)hshAddeDetails.get("txtperapp_zip"));
	 	
	 	app_constitution=Helper.correctNull((String)hshAddeDetails.get("app_constitution"));
	 	if(!strAd1.equalsIgnoreCase(""))
	 	{ 
	 		Address=strAd1;
	 	}
	 	if(!strAd2.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strAd2;
	 	}
	 	if(!strAd3.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strAd3;	
	 	}
	 	if(!strCity.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strCity;
	 	}
	 	if(!strDis.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strDis;
	 	}
	 	if(!strState.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strState;
	 		if(!strZipcode.equalsIgnoreCase(""))
	 		{
	 			Address=Address+"-"+strZipcode;	
	 		}
	 	}
	 	if(!strAd1.equalsIgnoreCase(""))
	 	{
	 		strCommaddress=Address;
	 		RowCount++;
	 	}
	 	strAd1="";
	 	Address="";
	 	strAd1=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permadd1")));
		strAd2=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permadd2")));
	 	strAd3=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permadd3")));
	 	strCity=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permcity")));
	 	strDis=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permdistrict")));
	 	strState=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_permstate")));
	 	strZipcode=Helper.correctNull((String)hshAddeDetails.get("txtperapp_permzip"));
	 	
	 	if(!strAd1.equalsIgnoreCase(""))
	 	{ 
	 		Address=strAd1;
	 	}
	 	if(!strAd2.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strAd2;
	 	}
	 	if(!strAd3.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strAd3;	
	 	}
	 	if(!strCity.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strCity;
	 	}
	 	if(!strDis.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strDis;
	 	}
	 	if(!strState.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strState+".";
	 		if(!strZipcode.equalsIgnoreCase(""))
	 		{
	 			Address=Address+"-"+strZipcode+".";	
	 		}
	 	}
	 	if(!strAd1.equalsIgnoreCase(""))
	 	{
			strPerAddress=Address;
	 		RowCount++;
	 		
	 	}
	 	strAd1="";
	 	Address="";
	 	strAd1=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminadd1")));
	 	strAd2=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminadd2")));
	 	strAd3=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminadd3")));
	 	strCity=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_admincity")));
	 	strDis=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_admindistrict")));
	 	strState=Helper.changetoTitlecase(Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminstate")));
	 	strZipcode=Helper.correctNull((String)hshAddeDetails.get("txtperapp_adminzip"));
	 	if(!strAd1.equalsIgnoreCase(""))
	 	{ 
	 		Address=strAd1;
	 	}
	 	if(!strAd2.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strAd2;
	 	}
	 	if(!strAd3.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strAd3;	
	 	}
	 	if(!strCity.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strCity;
	 	}
	 	if(!strDis.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strDis;
	 	}
	 	if(!strState.equalsIgnoreCase(""))
	 	{
	 		Address=Address+","+strState+".";
	 		if(!strZipcode.equalsIgnoreCase(""))
	 		{
	 			Address=Address+"-"+strZipcode+".";	
	 		}
	 	}
	 	if(!strAd1.equalsIgnoreCase(""))
	 	{
			strAdminAddress=Address;
			if(!app_constitution.equalsIgnoreCase("01"))
	 			RowCount++;
	 	}
	}
String strAmountvalue=Helper.correctNull((String) hshValues.get("com_amountvalue"));
String strNil = "Nil",str_arry="";
String strOutstandingDate = "";
String TakeOvercheck=Helper.correctNull((String)hshValues.get("strTakeOvercheck"));

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
int a=0;
double dblgrpexptot = Double.parseDouble(Helper
		.correctDouble((String) hshValues.get("dblGrpExpVal")));
String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
	
	
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

if (hshValues != null) {
	
	arrFacRow = (ArrayList) hshValues.get("arrFacRow");
	arrRowRatingRMD=(ArrayList)hshValues.get("arrRowRatingRMD");
	arrCOPNewRow = (ArrayList) hshValues.get("arrCOPNewRow");
	arrReleaseRow = (ArrayList) hshValues.get("arrReleaseRow");
	arrPresentTL = (ArrayList) hshValues.get("arrPresentTL");
	arrCOPRow = (ArrayList) hshValues.get("arrCOPRow");
	arrMOFRow = (ArrayList) hshValues.get("arrMOFRow");
	arrMOFMjrRow = (ArrayList) hshValues.get("arrMOFMjrRow");
	arrCOPMjrRow = (ArrayList) hshValues.get("arrCOPMjrRow");
	arrRelPatrnRow = (ArrayList) hshValues.get("arrRelPatrnRow");
	arrRelPatrnMjrRow = (ArrayList) hshValues.get("arrRelPatrnMjrRow");
	str_arry = Helper.correctNull((String) hshValues.get("str_arr"));
	arrImplSchRow = (ArrayList) hshValues.get("arrImplSchRow");
	arrPresentWC = (ArrayList) hshValues.get("arrPresentWC");
	arrExistingWC = (ArrayList) hshValues.get("arrExistingWC");
	arrTORow = (ArrayList) hshValues.get("TurnOver");
	arrExpRow = (ArrayList) hshValues.get("arrExpRow");
	arrAssmntRow = (ArrayList) hshValues.get("arrAssmntRow");
	arryInland = (ArrayList) hshValues.get("Inland");
	arrSwotAnalysis = (ArrayList) hshValues.get("arrSwotAnalysis");
	arrRowprop= (ArrayList)hshValues.get("arrRowprop");
	arrRowcgssd= (ArrayList)hshValues.get("arrRowcgssd");

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
.line {
  margin:5px 0;
  height:2px;
  background:
    repeating-linear-gradient(to right,back 0,red 5px,transparent 5px,transparent 7px)
    /*5px red then 2px transparent -> repeat this!*/
}
</style>

<script>
var strratingperc="<%=strratingperc%>";

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

<body contentEditable="false" designMode="on" onKeyDown="callKeyDown();">

<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">

<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>

<%
	if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("015")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("016")||Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("017")){%>
<tr><td align="center" width="50%"><%=Helper.correctNull((String)hshValues.get("strSanctiondept"))%></td></tr>
<%}
else{ %>
<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("username")).toUpperCase()%></td></tr>
<%} %>
<tr>
<td align="right">
<table width="100%" cellpadding="3" cellspacing="0" border="0">

<tr>
<td align="left" width="20%">OFFICE NOTE:</td>
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

<tr><td align="left">SL No&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues
							.get("COM_CSLMSNO"))%></td></tr>
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
<tr>
<td align="left">Date of Query Raised</td>
<td align="center"><%=Helper.correctNull((String) hshValues
							.get("strQRaisedOn"))%></td>
</tr>

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
<!-- Introduction -->
<tr><td class="title"><br><%=strSno[a]%><%a++; %>&nbsp;Introduction :</td></tr>


<tr>
<td>
This is a  <%=Helper.correctNull((String)hshValues.get("strProposalType")) %> proposal received from <b><%=Helper.correctNull((String) hshValues.get("org_name"))%></b> Branch for considering the following 
credit facilities to <b><%=Helper.correctNull((String) hshValues
									.get("perapp_title"))%>.&nbsp;<%=Helper.correctNull((String) hshValues
									.get("perapp_name"))%></b>&nbsp; under <b><%=strBanking %> </b>banking arrangement:
</td>
</tr>
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
				<td align="center" width="10%">ROI Commission</td>
				<td align="center" width="10%">Arrears If any</td>
				<td align="center" width="10%">Existing exposure</td>
				<td align="center" width="10%">Additional / Fresh Limit Proposed</td>
				<td align="center" width="10%">Total Exposure</td>
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
				<td align="right" ><%=Helper.correctNull((String)arrCol.get(11))%></td>
				<td align="right" ><%=Helper.correctNull((String)arrCol.get(10))%></td> 
				<%
					if (Helper.correctNull((String) arrCol.get(9))
										.equalsIgnoreCase("Main-Limit")) {
				%>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))),strAmountvalue)%></td>
				<%
					} else {
				%>
				<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))),strAmountvalue)%>)</td>
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
				dblPropLimitTot=dblPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
				dblTotalExp=dblTotalExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
				}

				if (Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("y") && Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")) {
				dblMLimitTot=dblMLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				dblMOutstandTot=dblMOutstandTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
				dblMExposureTot=dblMExposureTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
				dblMPropLimitTot=dblMPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
				dblMTotalExp=dblMTotalExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
				}
				
				if (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")||Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit"))
					dblLimitTot1=dblLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
				
				if (Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("y") && (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")
						||Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit")))
					dblMLimitTot1=dblMLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
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
					<td align="right" ><%=Helper.correctNull((String)arrCol.get(11))%></td>
				<td align="right" ><%=Helper.correctNull((String)arrCol.get(10))%></td> 
					<%
						if (Helper.correctNull((String) arrCol.get(9))
											.equalsIgnoreCase("Main-Limit")) {
					%>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))),strAmountvalue)%></td>
					<%
						} else {
					%>
					<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(4))))),strAmountvalue)%>)</td>
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
					dblPropLimitTot=dblPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
					dblTotalExp=dblTotalExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
					}
					if (Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("y") && Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")) {
						dblMLimitTot=dblMLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
						dblMOutstandTot=dblMOutstandTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
						dblMExposureTot=dblMExposureTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
						dblMPropLimitTot=dblMPropLimitTot+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
						dblMTotalExp=dblMTotalExp+Double.parseDouble(Helper.correctDouble((String)arrCol.get(7)));
						}
					
					if (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")||Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit"))
						dblLimitTot1=dblLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
					
					if (Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("y") && (Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Main-Limit")
							||Helper.correctNull((String) arrCol.get(9)).equalsIgnoreCase("Adhoc-Limit")))
						dblMLimitTot1=dblMLimitTot1+Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
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
				<td align="right"></td>
				<td align="right"></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblExposureTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblPropLimitTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblTotalExp)),strAmountvalue)%></td>
			</tr>
			<tr>
				<td align="center" colspan="2">LESS: Schematic Loans</td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblMLimitTot1)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblMOutstandTot)),strAmountvalue)%></td>
				<td align="right"></td>
				<td align="right"></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblMExposureTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblMPropLimitTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblMTotalExp)),strAmountvalue)%></td>
			</tr>
			<tr>
				<td align="center" colspan="2">Grand Total</td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblLimitTot1-dblMLimitTot1)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblOutstandTot-dblMOutstandTot)),strAmountvalue)%></td>
				<td align="right"></td>
				<td align="right"></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblExposureTot-dblMExposureTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblPropLimitTot-dblMPropLimitTot)),strAmountvalue)%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblTotalExp-dblMTotalExp)),strAmountvalue)%></td>
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
		
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td width="50%" align="center">
					<div id="top">
						<table width="100%" cellpadding="3" cellspacing="0" border="0">
						<tr><td align="left"> Individual Rating Grade : &nbsp;&nbsp;&nbsp;</td></tr>
							
							<%boolean flag=true;
							if(arrRowRatingRMD!=null && arrRowRatingRMD.size()>0){
								flag=false;
								for(int i=0;i<arrRowRatingRMD.size();i++) {
									arrColExp	= (ArrayList)arrRowRatingRMD.get(i);%>
								<tr>
								<td align="left"><%=Helper.correctNull((String)arrColExp.get(2))%> as on <%=Helper.correctNull((String)arrColExp.get(0))%> (<%=Helper.correctNull((String)arrColExp.get(1))%>)</td>
								</tr>
								<%}
							}
							if(!Helper.correctNull((String)hshValues.get("cre_weight")).equalsIgnoreCase("")){ 
							flag=false;%>
							<tr>
								<td><%=Helper.correctNull((String)hshValues.get("cre_weight")) %> as on <%=Helper.correctNull((String)hshValues.get("crermd_rating_year")) %> &nbsp; ( <%=Helper.correctNull((String)hshValues.get("crermd_rating_yeartype")) %> )</td>
							</tr>
							<%}
							if(flag){ %>
							<tr>
							<td align="center" colspan="2">- Nil -</td>
							</tr>
							<%} %>
						</table>
						</div>
						</td>
						<td width="40%" align="center">
						<div id="top">
						<table width="100%" cellpadding="3" cellspacing="0" border="0">
						<tr>
							<td align="left" width="30%">Permitted</td>
							<td align="left" width="30%">Existing</td>
							<td align="left" width="30%">Proposed</td>
						</tr>
						<tr>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(Helper.correctDouble((String) hshValues
									.get("dblIndVal"))),strAmountvalue)%>&nbsp;</td>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblExposureTot)),strAmountvalue)%>&nbsp;</td>
							<td align="right" width="50%"><%=Helper.converAmount(Helper.correctNull(jtn.format(dblTotalExp)),strAmountvalue)%>&nbsp;</td>
						</tr>
						</table>
						</div>
					</td>
							
						</tr>
						</table>
					</td>
					
				</tr>
<!-- External Rating Agency -->	
<%if(arrRating!=null && arrRating.size()>0)
{
String strWeight="";%>
<tr>
<td>

	<%for(int c=0;c<arrRating.size();c++)
	{ 
		arrCol=(ArrayList)arrRating.get(c);
		if(arrCol!=null && arrCol.size()>0){
			arrOutCol=(ArrayList)arrCol.get(1);%>
			<div id="top">
		<table width="100%" cellpadding="3" cellspacing="0" border="0">
		<%for(int b=0;b<arrOutCol.size();b++)
		{
			arrCol1=(ArrayList)arrOutCol.get(b);
			if(b==0)
			{
			strWeight=Helper.correctNull((String)arrCol1.get(4));%>
			<tr><td class="title" colspan="4">External Rating :<%=Helper.correctNull((String)arrCol.get(0)) %> ratings dated <%=Helper.correctNull((String)arrCol1.get(2)) %>
			<tr class="title">
			<td width="20%">Facilities</td>
			<td width="15%">Amount</td>
			<td width="20%">Rating</td>
			<td width="30%">Definition</td>
			</tr>
			<%} %>
			
			<%
			ArrayList arrRow13=(ArrayList)arrCol1.get(7);
			int intsize=0;
			if(arrRow13!=null && arrRow13.size()>0)
				intsize=arrRow13.size();
				%>
			<tr>
			<td rowspan="<%=intsize+1 %>"><%=Helper.correctNull((String)arrCol1.get(5))%><br/><%=Helper.correctNull((String)arrCol1.get(1))%>&nbsp;</td>
			<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol1.get(3)),strAmountvalue) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol1.get(8)) %>&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol1.get(6)) %>&nbsp;</td>
			</tr>
			
			<%if(arrRow13!=null && arrRow13.size()>0){ 
				for(int d=0;d<arrRow13.size();d++){
				ArrayList arrCol13=(ArrayList)arrRow13.get(d);
				if(arrCol13!=null && arrCol13.size()>1){%>
				<tr>
			<td align="right">(<%=Helper.converAmount(Helper.correctDouble((String)arrCol13.get(0)),strAmountvalue) %>)&nbsp;</td>
			<td>(<%=Helper.correctNull((String)arrCol13.get(1)) %>)&nbsp;</td>
			<td><%=Helper.correctNull((String)arrCol13.get(2)) %>&nbsp;</td>
			</tr>
			
			<%}}} %>
			
		<%if(b==arrOutCol.size()-1){ %>
		<tr>
		<td colspan="4" class="title">Risk Weight : <%=strWeight %></td>
		</tr>
		<%} %>
	
	<%	}%>
	</table>
	</div>
	<br/>
	
		<%}}%>
</td>
</tr>
<%}
else
{ %>
	<tr><td class="title">External Rating : - Nil -</td></tr>
<%} %>	
<tr><td class="title">External Rating rationale</td></tr>	
<tr><td><%=Helper.correctNull((String)hshValues.get("ExternalRatingComments")) %></td></tr>
<tr><td class="title">Reason for Downgradation/Migration in rating if any/Non Investment Grade category of Risk rating and reasons for recommending the proposal (Both Internal & External rating as the case may be): </td></tr>	
<tr><td><%=Helper.correctNull((String)hshValues.get("ExternalRatingComments1")) %> </td></tr>	
<!-- Group Concern Exposure -->
<%
	//if (arrGroupRow != null && arrGroupRow.size() > 0) 
	{
%>

<tr>
	<td class="title"><br>Group Exposure</td>
</tr>
<tr>
	<td>
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
	<td width="50%" valign="top">
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			double dblTemp=0.00;
				
			%>
				<tr>
					<td width="3%" align="center">SI.No.</td>
					<td width="40%" align="center">Name</td>
					<td width="15%" align="center">Existing Exposure</td>
					<td width="15%" align="center">Proposed Exposure</td>
				</tr>
				<tr>
					<td align="center">1.</td>
					<td align="left">Borrower</td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblExposureTot)),strAmountvalue)%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblTotalExp)),strAmountvalue)%></td>
				</tr>
			<%
			int iVal=1;
			if (arrGroupRow != null && arrGroupRow.size() > 0) {
				for (int i = 0; i < arrGroupRow.size(); i++) {
							arrCol = (ArrayList) arrGroupRow.get(i);

			%>
				<tr>
					<td align="left"><%=++iVal%></td>
					<td align="left"><%=Helper.correctNull((String) arrCol.get(1))%></td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper
										.correctInt((String) arrCol.get(2))))%></td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper
					.correctInt((String) arrCol.get(2))))%></td>
										
					<%dblTemp=dblTemp+Double.parseDouble(Helper
							.correctInt((String) arrCol.get(2))) ;%>
				</tr>
			<%
				}
				} 
			%>
			
			<tr>
					<td align="right" colspan="2">Total</td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblExposureTot+dblTemp)),strAmountvalue)%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblTotalExp+dblTemp)),strAmountvalue)%></td>
				</tr>
			</table>
		</div>
		</td>
		<td width="50%" valign="top">
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td width="30%">Permitted</td>
			<td width="30%">Existing</td>
			<td width="30%">Proposed</td>
			</tr>
			<tr>
			<td><%=Helper.converAmount(Helper.correctDouble(jtn.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("dblGrpVal"))))),strAmountvalue)%></td>
			<td><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblExposureTot+dblTemp)),strAmountvalue)%></td>
			<td><%=Helper.converAmount(Helper.correctDouble(jtn.format(dblTotalExp+dblTemp)),strAmountvalue)%></td>
			</tr>
			</table>
			</div>
		</td>
		</tr>
		</table>
	</td>
</tr>
<%
	}
%>
				
				
<tr><td>
<div id="top">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<td>&nbsp;</td>
	<td align="right"><%=strAmtValueIn%></td>
	<tr>
	<td rowspan="2">Present Banking Arrangement</td>		
	<td>Working Capital : <%=Helper.correctNull((String)hshConsDetails.get("com_wc_bnkarg")) %>&nbsp;</td>
	</tr>
	<tr>
	<td>Term Loan : <%=Helper.correctNull((String)hshConsDetails.get("com_tl_bnkarg")) %></td>
	</tr>
	<tr>
	<td>Proposed Banking Arrangement</td>
	<td><%=strBanking %>&nbsp;</td>
	</tr>
	<tr>
	<td>If consortium - Leader of the Consortium</td>
	<td>
	<%if(arrLeaderBankTL!=null && arrLeaderBankTL.size()>0){ %>
	<b>Term Loan :</b><br/> <%for(int c=0;c<arrLeaderBankTL.size();c++){ %>
	<%=Helper.correctNull((String)arrLeaderBankTL.get(c)) %><br/>
	<%} %>
	<%}
	if(arrLeaderBankWC!=null && arrLeaderBankWC.size()>0){ %>
	<b>Working Capital :</b><br/> <%for(int c=0;c<arrLeaderBankWC.size();c++){ %>
	<%=Helper.correctNull((String)arrLeaderBankWC.get(c)) %><br/>
	<%} %>
	<%} %>
	&nbsp;</td>
	</tr>
	<tr>
	<td>Names of other member banks </td>
	<td><%if(arrOtherBankTL!=null && arrOtherBankTL.size()>0){ %>
	<b>Term Loan :</b><br/> <%for(int c=0;c<arrOtherBankTL.size();c++){ %>
	<%=Helper.correctNull((String)arrOtherBankTL.get(c)) %><br/>
	<%} %>
	<%}
	if(arrOtherBankWC!=null && arrOtherBankWC.size()>0){ %>
	<b>Working Capital :</b><br/> <%for(int c=0;c<arrOtherBankWC.size();c++){ %>
	<%=Helper.correctNull((String)arrOtherBankWC.get(c)) %><br/>
	<%} %>
	<%} %></td>
	</tr>
	<tr>
		<td width="50%"><b>Dealing with us since&nbsp;</b></td>
	<td>
		<%if(Helper.correctNull((String) hshValues.get("perapp_bank")).equalsIgnoreCase("1")){ %>
		<%=Helper.correctNull((String) hshValues.get("perapp_banksince"))%>
		<%}else{ %>
		 New Borrowal Account
		<%} %>
	</td>
	</tr>
	</table>
	</div>
	</td>
</tr>

<%if(arrConsortDet!=null && arrConsortDet.size()>0)
{
	%>
	<tr>
		<td class="title"><br>Working Capital:<%if(Helper.correctNull((String)hshConsDetails.get("strBnkargWC")).equalsIgnoreCase("C")) {%><b>&nbsp;Leader of the Consortium -</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshConsDetails.get("com_cons_bank_name_WC"))) %><%} %>&nbsp;</td>
	</tr>
	<%
	if(arrConsortDet!=null && arrConsortDet.size()>0)
	{ 
	%>
		<tr>
			<td align="right" width=""><%=strAmtValueIn%></td>
		</tr>
		<tr>
			<td>
				<div id="top">
					<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
						<tr>
							<td width="20%" align="center">Name of the Bank</td>
							<td width="20%" align="center">Fund Based</td>
							<td width="12%" align="center">ROI (%)</td>
							<td width="10%" align="center">Non Fund Based</td>
							<td width="10%" align="center">Commission</td>
							<td width="10%" align="center">Total</td>
							<td width="10%" align="center">Share in %</td>
							<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
							<td width="10%" align="center">Asset Classification</td>
						</tr>
						<%
						double dblCTotal=0.0;
						
						for(int i=0;i<arrConsortDet.size();i++)
						{
							arrCol	= (ArrayList)arrConsortDet.get(i);
							
							arrOutCol=(ArrayList)arrCol.get(0);
							for(int d=0;d<arrOutCol.size();d++)
							{
								ArrayList arrOutCol1=(ArrayList)arrOutCol.get(d);
								if(d==0)
								dblCTotal+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
							}
						}
						
						
						for(int i=0;i<arrConsortDet.size();i++)
						{
							arrCol	= (ArrayList)arrConsortDet.get(i);
							
							arrOutCol=(ArrayList)arrCol.get(0);
							for(int d=0;d<arrOutCol.size();d++)
							{
								ArrayList arrOutCol1=(ArrayList)arrOutCol.get(d);
						%>
						<tr>
						<%if(d==0){ %>
							<td align="left" rowspan="<%=arrOutCol.size() %>"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(0)))%></td>
							<td align="right" rowspan="<%=arrOutCol.size() %>"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(1)),strAmountvalue)%></td>
							<%} %>
							<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(2))).equalsIgnoreCase("F")){ %>
							<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(1)))%></td>
							<%}else{ %>
							<td align="left">&nbsp;</td>
							<%} %>
							<%if(d==0){ %>
							<td align="right" rowspan="<%=arrOutCol.size() %>"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(2)),strAmountvalue)%></td>
							<%} %>
							<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(2))).equalsIgnoreCase("NF")){ %>
							<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(1)))%></td>
							<%}else{ %>
							<td align="left">&nbsp;</td>
							<%} %>
							<%if(d==0){ %>
							<td align="left"  rowspan="<%=arrOutCol.size() %>"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)))),strAmountvalue)%></td>
							<%if(dblCTotal!=0){ %>
							<td rowspan="<%=arrOutCol.size() %>" align="right"><%=jtn.format(((Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))/dblCTotal)*100)%></td>
							<%}else{ %>
							<td rowspan="<%=arrOutCol.size() %>" align="right">&nbsp;</td>
							<%} %>
							<%} %>
							
							<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(6)))%></td>
							<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(5)))%></td>
							<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol1.get(3)))%></td>
						</tr>
								<%}
						}%>
					</table>
				</div>
			</td>
		</tr>
	<%} } %>
	<%
	if(arrMultipleConsWC1!=null && arrMultipleConsWC1.size()>0){ 
		for(int c=0;c<arrMultipleConsWC1.size();c++){
			ArrayList arrCol2=(ArrayList)arrMultipleConsWC1.get(c);
			if(arrCol2!=null && arrCol2.size()>0){
	%>
	
	<tr>
		<td class="title"><br>Working Capital:<b>&nbsp;Leader of the Consortium -</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshConsDetails.get("com_cons_bank_name_WC"+(c+1)))) %>&nbsp;</td>
	</tr>
	
	<tr>
			<td align="right" width=""><%=strAmtValueIn%></td>
		</tr>
		<tr>
			<td>
				<div id="top">
					<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
						<tr>
							<td width="20%" align="center">Name of the Bank</td>
							<td width="20%" align="center">Fund Based</td>
							<td width="12%" align="center">ROI (%)</td>
							<td width="10%" align="center">Non Fund Based</td>
							<td width="10%" align="center">Commission</td>
							<td width="10%" align="center">Total</td>
							<td width="10%" align="center">Share in %</td>
							<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
							<td width="10%" align="center">Asset Classification</td>
						</tr>
						<%
						double dblCTotal=0.0;
						
						for(int i=0;i<arrCol2.size();i++)
						{
							arrCol	= (ArrayList)arrCol2.get(i);
							for(int d=0;d<arrCol.size();d++)
							{
								arrOutCol=(ArrayList)arrCol.get(d);
								dblCTotal+=Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2)));
							}
						}
						for(int i=0;i<arrCol2.size();i++)
						{
							arrCol	= (ArrayList)arrCol2.get(i);
							for(int d=0;d<arrCol.size();d++)
							{
								arrOutCol=(ArrayList)arrCol.get(d);
								ArrayList arrOutCol1=(ArrayList)arrOutCol.get(0);
								for(int e=0;e<arrOutCol1.size();e++)
								{
									ArrayList arrOutCol12=(ArrayList)arrOutCol1.get(e);
									if(arrOutCol1.size()==1)
									{
						%>
						 <tr>
							<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(0)))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrOutCol.get(1)),strAmountvalue)%></td>
							<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(2))).equalsIgnoreCase("F")){ %>
							<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(1)))%></td>
							<%}else{ %>
							<td align="left">&nbsp;</td>
							<%} %>
							<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrOutCol.get(2)),strAmountvalue)%></td>
							<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(2))).equalsIgnoreCase("NF")){ %>
							<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(1)))%></td>
							<%}else{ %>
							<td align="left">&nbsp;</td>
							<%} %>
							<td align="left"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2)))),strAmountvalue)%></td>
							<%if(dblCTotal!=0){ %>
							<td align="right"><%=jtn.format(((Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2))))/dblCTotal)*100)%></td>
							<%}else{ %>
							<td>&nbsp;</td>
							<%} %>
							<td align="left"><%=Helper.correctNull((String)arrOutCol12.get(6))%></td>
						<td align="left"><%=Helper.correctNull((String)arrOutCol12.get(5))%></td>
														<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(3)))%></td>
							
							
						</tr>
							<%}else{
								if(e==0){%>
								 <tr>
									<td align="left" rowspan="<%=arrOutCol1.size() %>"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(0)))%></td>
									<td align="right" rowspan="<%=arrOutCol1.size() %>"><%=Helper.converAmount(Helper.correctDouble((String)arrOutCol.get(1)),strAmountvalue)%></td>
									<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(2))).equalsIgnoreCase("F")){ %>
									<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(1)))%></td>
									<%}else{ %>
									<td align="left">&nbsp;</td>
									<%} %>
									<td align="right" rowspan="<%=arrOutCol1.size() %>"><%=Helper.converAmount(Helper.correctDouble((String)arrOutCol.get(2)),strAmountvalue)%></td>
									<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(2))).equalsIgnoreCase("NF")){ %>
									<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(1)))%></td>
									<%}else{ %>
									<td align="left">&nbsp;</td>
									<%} %>
									<td align="left" rowspan="<%=arrOutCol1.size() %>"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2)))),strAmountvalue)%></td>
									<%if(dblCTotal!=0){ %>
									<td align="right" rowspan="<%=arrOutCol1.size() %>"><%=jtn.format(((Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrOutCol.get(2))))/dblCTotal)*100)%></td>
									<%}else{ %>
									<td rowspan="<%=arrOutCol1.size() %>">&nbsp;</td>
									<%} %>
									<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(3)))%></td>
											<td align="left"><%=Helper.correctNull((String)arrOutCol12.get(6))%></td>
						<td align="left"><%=Helper.correctNull((String)arrOutCol12.get(5))%></td>
								</tr>
							<%}else{ %>
							
								<tr>
									<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(2))).equalsIgnoreCase("F")){ %>
									<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(1)))%></td>
									<%}else{ %>
									<td align="left">&nbsp;</td>
									<%} %>
									<%if(Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(2))).equalsIgnoreCase("NF")){ %>
									<td align="right"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(1)))%></td>
									<%}else{ %>
									<td align="left">&nbsp;</td>
									<%} %>
									<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrOutCol12.get(3)))%></td>
									<td align="left"><%=Helper.correctNull((String)arrOutCol12.get(6))%></td>
						<td align="left"><%=Helper.correctNull((String)arrOutCol12.get(5))%></td>
								</tr>
							
								<%}}}}
						}%>
					</table>
				</div>
			</td>
		</tr>
	
	
	<%}} }%>

<!-- Single - Consortium -->
<%
if(arrSingleCons!=null && arrSingleCons.size()>0){ 
%>
<tr>
	<td class="title"><br>Term Loans:<b>&nbsp;Leader of the Consortium</b>-&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshConsDetails.get("com_cons_bank_name"))) %>&nbsp;</td>
</tr>
			
<%
if(arrSingleCons!=null && arrSingleCons.size()>0)
{ 
%>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="20%" align="center">Name of the Bank</td>
						<td width="10%" align="center">Limit</td>
						<td width="10%" align="center">Interest (%)</td>
						<td width="10%" align="center">Outstanding</td>
						<td width="10%" align="center">Outstanding as on</td>
						<td width="10%" align="center">Present Exposure</td>
						<td width="10%" align="center">% Exposure</td>
						<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
					</tr>
			<%	for(int i=0;i<arrSingleCons.size();i++)
				{
					arrCol	= (ArrayList)arrSingleCons.get(i);
					double dblTempVal=Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)))+Double.parseDouble(Helper.correctDouble((String)arrCol.get(12)));
					if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Main-Limit"))
					dblTLExposure+=dblTempVal;
				%>
					<tr>
						
						<%if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Main-Limit")){ %>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(5)),strAmountvalue)%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(6)),strAmountvalue)%></td>
						<td><%=Helper.correctNull((String)arrCol.get(11)) %></td>
						<td align="right"><%=Helper.converAmount(jtn.format(dblTempVal),strAmountvalue)%></td>
						<td align="right"><%=jtn.format(((dblTempVal)/Double.parseDouble(Helper.correctDouble((String)hshConsDetails.get("dblSglExposure"))))*100)%></td>
						<td><%=Helper.correctNull((String)arrCol.get(15)) %></td>
						<td><%=Helper.correctNull((String)arrCol.get(14)) %></td>
						<%}else{%>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="right">(<%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(5)),strAmountvalue)%>)</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="right">(<%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(6)),strAmountvalue)%>)</td>
						<td><%=Helper.correctNull((String)arrCol.get(11)) %></td>
						<td align="right">(<%=Helper.converAmount(jtn.format(dblTempVal),strAmountvalue)%>)</td>
						<td>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol.get(15)) %></td>
						<td><%=Helper.correctNull((String)arrCol.get(14)) %></td>
						<%} %>
						
						
					</tr>
			<%} %>
				<% if(arrSingleCons.size()>0) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshConsDetails.get("dblSglLimit")),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshConsDetails.get("dblSglOutstand")),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(jtn.format(dblTLExposure),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
					</tr>
				<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>


<%
if(arrMultipleCons!=null && arrMultipleCons.size()>0){ %>
<tr>
	<td class="title"><br>Term Loans:</td>
</tr>

<!-- Multiple - Consortium -->			
<%
if(arrMultipleCons!=null && arrMultipleCons.size()>0)
{
	for(int i=0;i<arrMultipleCons.size();i++)
	{
			arrCol	= (ArrayList)arrMultipleCons.get(i);
			
%>
	<tr>
		<td class="title"><br>Consortium<% if(arrMultipleCons.size()>1) out.println(" "+(i+1));%>:<b>Leader:</b>&nbsp;<%=Helper.changetoTitlecase(Helper.correctNull((String)hshConsDetails.get("com_cons_bank_name"+(i+1)))) %>
	&nbsp;</td>
	</tr>	
	
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="20%" align="center">Name of the Bank</td>
						<td width="10%" align="center">Limit</td>
						<td width="10%" align="center">ROI (%)</td>
						<td width="10%" align="center">Outstanding</td>
						<td width="10%" align="center">Outstanding as on</td>
						<td width="10%" align="center">Present Exposure</td>
						<td width="10%" align="center">% Exposure</td>
						<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email ID</td>
					</tr>
		<%dblTLExposure=0.0;		
		for(int j=0;j<arrCol.size();j++)
				{
					ArrayList arrColCons	= (ArrayList)arrCol.get(j);
					double dblTempVal=Double.parseDouble(Helper.correctDouble((String)arrColCons.get(6)))+Double.parseDouble(Helper.correctDouble((String)arrColCons.get(12)));
					if(Helper.correctNull((String)arrColCons.get(3)).equalsIgnoreCase("Main-Limit"))
						dblTLExposure+=dblTempVal;
		%>	
				<%if(Helper.correctNull((String)arrColCons.get(3)).equalsIgnoreCase("Main-Limit")){ %>
					<tr>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrColCons.get(9))).toUpperCase()%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrColCons.get(5)),strAmountvalue)%></td>
						<td align="right">
						<%=Helper.checkDecimal(Helper.correctDouble((String)arrColCons.get(7)))%>
						</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrColCons.get(6)),strAmountvalue)%></td>
						<td><%=Helper.correctNull((String)arrColCons.get(11)) %></td>
						<td align="right"><%=Helper.converAmount(jtn.format(dblTempVal),strAmountvalue)%></td>
						<td align="right"><%=jtn.format(((dblTempVal)/Double.parseDouble(Helper.correctDouble((String)hshConsDetails.get("dblMultipleExp"))))*100)%></td>
					<td><%=Helper.correctNull((String)arrColCons.get(15)) %></td>
					<td><%=Helper.correctNull((String)arrColCons.get(14)) %></td>
					<%}else{%>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrColCons.get(9))).toUpperCase()%></td>
						<td align="right">(<%=Helper.converAmount(Helper.correctDouble((String)arrColCons.get(5)),strAmountvalue)%>)</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrColCons.get(7)))%></td>
						<td align="right">(<%=Helper.converAmount(Helper.correctDouble((String)arrColCons.get(6)),strAmountvalue)%>)</td>
						<td><%=Helper.correctNull((String)arrColCons.get(11)) %></td>
						<td align="right">(<%=Helper.converAmount(jtn.format(dblTempVal),strAmountvalue)%>)</td>
						<td>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrColCons.get(15)) %></td>
					<td><%=Helper.correctNull((String)arrColCons.get(14)) %></td>
						<%}%>
						
					</tr>
			<%} %>	
			<% if(arrMultipleCons.size()>0) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshConsDetails.get("dblMtplConsLimit"+(i+1))),strAmountvalue)%></td>
						<td>&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshConsDetails.get("dblMtplConsOutstand"+(i+1))),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(jtn.format(dblTLExposure),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td>&nbsp;</td>
					<td>&nbsp;</td>
					</tr>
				<%} %>	
				</table>
			</div>
		</td>
	</tr>
<% } } } %>

<!-- TL : Multiple -->
<%
if(arrMultiple!=null && arrMultiple.size()>0){ %>
<tr>
	<td class="title"><br>Term Loans:</td>
</tr>
<%
if(arrMultiple!=null && arrMultiple.size()>0)
{ 
%>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="20%" align="center">Name of the Bank</td>
						<td width="10%" align="center">Limit</td>
						<td width="10%" align="center">Interest (%)</td>
						<td width="10%" align="center">Outstanding</td>
						<td width="10%" align="center">Outstanding as on</td>
						<td width="10%" align="center">Present Exposure</td>
						<td width="10%" align="center">% Exposure</td>
						<td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email ID</td>
					</tr>
			<%	for(int i=0;i<arrMultiple.size();i++)
				{
					arrCol	= (ArrayList)arrMultiple.get(i);
					double dblTempVal=Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)))+Double.parseDouble(Helper.correctDouble((String)arrCol.get(12)));
					if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Main-Limit"))
						dblTLExposure+=dblTempVal;
				%>
					<tr>
					<%if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Main-Limit")){ %>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(5)),strAmountvalue)%></td>
						<td align="right">
						<%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%>
						</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(6)),strAmountvalue)%></td>
						<td><%=Helper.correctNull((String)arrCol.get(11)) %></td>
						<td align="right"><%=Helper.converAmount(jtn.format(dblTempVal),strAmountvalue)%></td>
						<td align="right"><%=jtn.format(((dblTempVal)/Double.parseDouble(Helper.correctDouble((String)hshConsDetails.get("dblMultiExp"))))*100)%></td>
											<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(15))).toUpperCase()%></td>
											<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(14))).toUpperCase()%></td>
					
					</tr>
					
					<%}else{%>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="right">(<%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(5)),strAmountvalue)%>)</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrCol.get(7)))%></td>
						<td align="right">(<%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(6)),strAmountvalue)%>)</td>
						<td><%=Helper.correctNull((String)arrCol.get(11)) %></td>
						<td align="right">(<%=Helper.converAmount(jtn.format(dblTempVal),strAmountvalue)%>)</td>
						<td>&nbsp;</td>
												<td><%=Helper.correctNull((String)arrCol.get(15)) %></td>
						
												<td><%=Helper.correctNull((String)arrCol.get(14)) %></td>
						
						<%}%>
			<%} %>
			<% if(arrMultiple.size()>0) {  %>
					<tr>
						<td align="left">TOTAL</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshConsDetails.get("dblMtplLimit")),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshConsDetails.get("dblMtplOutstand")),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(jtn.format(dblTLExposure),strAmountvalue)%></td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
					</tr>
				<%} %>
				</table>
			</div>
		</td>
	</tr>
<%} } %>

<tr>
	<td class="title"><br><%=strSno[a]%>.<%a++; %>&nbsp;</td>
</tr>
<!-- APPLICANT'S PROFILE -->

	<jsp:include page="../print/com_AnnexureII.jsp" flush="true">
	<jsp:param name="pageVal" value="PROPOSALLC"/>
	</jsp:include>
<!-- END -->
<tr>
		<td>
			<div id="top">
				<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td align="left" width="3%"valign="top">&nbsp;</td><td class="title" align="left" width="50%">Nature of Activity</td>
<td><%=Helper.correctNull((String)hshAddeDetails1.get("NatureofActivity"))%></td>
</tr>
<tr>
<td align="left" width="3%"valign="top">&nbsp;</td><td class="title" align="left" width="50%">sector</td>
<td><%=Helper.correctNull((String)hshAddeDetails1.get("Sector"))%></td>
</tr>
<tr>
<td class="title" align="left" colspan="3"><div>Reason for Classification: 
</div></td></tr>
<tr>
<td align="left" width="3%"valign="top">&nbsp;</td><td class="title" align="left" width="50%">Asset Classification Code : </b>&nbsp;</td>
<td><%=Helper.correctNull((String)hshValues.get("strAssetClassification"))%>
&nbsp;<%if(!Helper.correctNull((String)hshValues.get("com_asscladate")).equals("")) { %>as on <%=Helper.correctNull((String)hshValues.get("com_asscladate"))%><%} %>&nbsp;</td>
</tr>
<tr>
<td align="left" width="3%"valign="top">&nbsp;</td><td class="title" align="left" width="50%">Whether suit filed, whether action initiated by other bank/ financial institutions still pending? </td>
<td><%=Helper.correctNull((String)hshValues.get("strSuitFiled"))%>
&nbsp;<%if(Helper.correctNull((String)hshValues.get("strSuitFiled")).equals("Yes")) { %><br/> <%=Helper.correctNull((String)hshValues.get("strSuitFiledCmts"))%><%} %>&nbsp;</td>
</tr>
<tr>
<td align="left" width="3%"valign="top">&nbsp;</td><td class="title" align="left" width="50%">Whether referred to Probe 42</td>
<td><%=Helper.correctNull((String)hshValues.get("strProbe"))%>
&nbsp;<%if(Helper.correctNull((String)hshValues.get("strProbe")).equals("Yes")) { %><br/><%=Helper.correctNull((String)hshValues.get("strProbeCmts"))%><%} %>&nbsp;</td>
</tr>
</table>

<%a=a+3; %>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<div align="left" id="top">
			<jsp:include page="../print/com_ProcessnoteNewcond.jsp" flush="true">
			<jsp:param name="pagevalue" value="PROPOSALLC"/>
			<jsp:param name="pagevalueAmt" value="<%=strAmtValueIn %>"/>
			</jsp:include>
		</div>
	</td>
</tr>



<tr><td class="title"><br><%=strSno[a]%>.Present Proposal:</td></tr>
<tr><td>
<%=Helper.correctNull((String) hshValues
							.get("presentproposal_comment"))%>
</td></tr>
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
		(String) hshValues.get("COM_COMMENTS_ETL" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>EXISTING TERM LOAN (Review) : </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_ETL" + strFACSno))%></td>
</tr>
<%
}
	if (!Helper.correctNull(
					(String) hshValues.get("COM_COMMENTS_COP" + strFACSno))
					.equalsIgnoreCase("")) {
%>
	<tr>
		<td><br><b>FRESH TERM LOAN : </b></td>
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
		<td><%=Helper.correctNull((String) hshValues
										.get("COM_COMMENTS_COP" + strFACSno))%></td>
	</tr>
<%
	}
%>

<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			double dblCOPtot=0.00,dblVal=0.00,dblMOFinttot=0.00;
			double dblintMOFtot=0.00;
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
			<%double dblMOFtot=0.00,dblintMOFtot1=0.00,dblMOFinttot1=0.00;
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
				%>
			</table>
		</div>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<!-- Release Pattern Started -->
<%boolean bflag=true;
	if (arrReleaseRow != null && arrReleaseRow.size() > 0) {
		ArrayList arrReleaseCol = new ArrayList();%>
		 <tr><td class="title" valign="top"><br>Release pattern/ margin requirement:</td></tr>
				  <tr><td align="right" ><%=strFinvaluesIn%></td></tr>
		<%for (int z = 0; z < arrReleaseRow.size(); z++) {
			arrReleaseCol = (ArrayList) arrReleaseRow.get(z);
			if(strFACSno.equalsIgnoreCase(Helper.correctNull((String) arrReleaseCol.get(0)))){
			String strRel = Helper.correctNull((String) arrReleaseCol.get(2));
			//String strImpl = Helper.correctNull((String) arrReleaseCol.get(7));
			//String strEstimate = Helper.correctNull((String) arrReleaseCol.get(9));
			String strImpl="",strEstimate="";
			String fachead =Helper.correctNull((String) arrReleaseCol.get(1));
	 		if (arrReleaseCol != null && arrReleaseCol.size() > 0) { 
				ArrayList arrRowPattern = new ArrayList();
				ArrayList arrColPattern = new ArrayList();
				arrRowPattern = (ArrayList) hshValues.get("arrRowPattern" + z);
				if (arrRowPattern != null && arrRowPattern.size() > 0) {
					bflag=false;
					%>
					
				 <% if (strRel.equalsIgnoreCase("ReleasePattern")) { %>
					<tr>
					<td>
						<div id="top">
							<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
 												<%
 												for (int k = 0; k < arrRowPattern.size(); k++) {
 													arrColPattern = (ArrayList) arrRowPattern
 															.get(k);
					 						%>
									 
				  <% if(k==0) { %>
												<tr>
												<td align="center" width="3%">SI.No</td>
												<td align="center" width="37%">Particulars</td>
												<td align="center" width="12%">Bank Loan</td>
												<td align="center" width="12%">% to cost</td>
												<td align="center" width="12%">Margin brought by the Company</td>
												<td align="center" width="12%">% to cost</td>
												
												<td align="center" width="12%">Total cost</td>
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
																					.get(4))))%></td>
												<td align="right" width="12%"><%=jtn
															.format(Double
																	.parseDouble(Helper
																			.correctDouble((String) arrColPattern
																					.get(5))))%></td>
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
																					.get(1))))%></td>
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
																						.get("dblRPTotLoan"
																								+ z))))%></td>
												<td align="right"></td>
												
												<td align="right"><%=jtn
																.format(Double
																		.parseDouble(Helper
																				.correctDouble((String) hshValues
																						.get("dblRPTotMargin"
																								+ z))))%></td> 
												<td align="right"></td>
												
												<td align="right"><%=jtn
																.format(Double
																		.parseDouble(Helper
																				.correctDouble((String) hshValues
																						.get("dblRPTotCost"
																								+ z))))%></td>
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
				  <%  }}
				  if(bflag){%>
				  <tr>
				  <td><%=strNil %></td>
				  </tr>
		<%}}
				 %>
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
		<td><br><b>Promoters Contribution: </b></td>
	</tr>
	<tr>
		<td><%=Helper.correctNull((String) hshValues
										.get("COM_COMMENTS_SOM" + strFACSno))%></td>
	</tr>
<%
	}

if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_1_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Land: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_1_COProj" + strFACSno))%></td>
</tr>
<%
}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_2_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Building: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_2_COProj" + strFACSno))%></td>
</tr>
<%
}
arrMechRow = (ArrayList)hshValues.get("arrMechRow"+strFACSno);
if ((!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_3_COProj" + strFACSno))
		.equalsIgnoreCase("")) || (arrMechRow!=null && arrMechRow.size()>0)) {
%>
<tr>
<td><br><b>Machineries/ Other fixed Assets: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_3_COProj" + strFACSno))%></td>
</tr>
<%
}
if(arrMechRow!=null && arrMechRow.size()>0)
{
double dbltotal=0.0;
int intQuantity=0;%>
<tr>			
	<td align="right" width=""><%=strAmtValueIn%></td>
</tr>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="5%">Sl.No</td>
<td width="20%" align="center"> Machinery Particulars</td>
<td  width="25%" align="center">Name of Supplier</td>
<td  width="10%" align="center"> Quantity</td>
<td  width="15%" align="center"> Cost per Unit</td>
<td  width="15%" align="center"> Total Amount</td>
</tr>
	<%for(int c=0;c<arrMechRow.size();c++)
	{
	arrCol=(ArrayList)arrMechRow.get(c);
	dbltotal+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
	intQuantity+=Integer.parseInt(Helper.correctInt((String)arrCol.get(2)));
	%>
	<tr>
	<td><%=c+1 %>&nbsp;</td>
	<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
	<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
	<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
	<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)))),strAmountvalue) %>&nbsp;</td>
	<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)))),strAmountvalue) %>&nbsp;</td>
	</tr>
		
	<%}%>
	<tr>
	<td colspan="3" align="right">Total</td>
	<td><%=intQuantity %>&nbsp;</td>
	<td>&nbsp;</td>
	<td align="right"><%=Helper.converAmount(jtn.format(dbltotal),strAmountvalue) %>&nbsp;</td>
	</tr>
	</table>
	</div>
</td>
</tr>
<%}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_4_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Any other Project Components: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_4_COProj" + strFACSno))%></td>
</tr>
<%
}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_5_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Availability of Infrastructure to House the above components in case of existing borrowers and Creation of Infrastructure in case of new projects: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_5_COProj" + strFACSno))%></td>
</tr>
<%
}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_6_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Approvals & Clearances: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_6_COProj" + strFACSno))%></td>
</tr>
<%
}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_7_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Technical Aspect/TEV Study: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_7_COProj" + strFACSno))%></td>
</tr>
<%
}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_8_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Details of Government Support & Subsidy available (If any): </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_8_COProj" + strFACSno))%></td>
</tr>
<%
}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_9_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Expected life (Asset/Production life) of the Asset Financed out of the Term Loan: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_9_COProj" + strFACSno))%></td>
</tr>
<%
}
if (!Helper.correctNull(
		(String) hshValues.get("COM_COMMENTS_COProj" + strFACSno))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><br><b>Others: </b></td>
</tr>
<tr>
<td><%=Helper.correctNull((String) hshValues
							.get("COM_COMMENTS_COProj" + strFACSno))%></td>
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
				<td class="title"><br>Profitability Estimates :</td>
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
<%if(!Helper.correctNull((String) hshValues
		.get("fin_comments1_dscr")).equalsIgnoreCase("")){ %>
		
		<tr>
				<td class="title"><br>Comment on DSCR:</td>
			</tr>
		<tr>
			<td><%=Helper.correctNull((String) hshValues
										.get("fin_comments1_dscr"))%></td>
		</tr>
<%
	}
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
	if (!Helper.correctNull((String) hshValues.get("fin_comments_sensitive")).equalsIgnoreCase("")) {
%>
<tr><td><%=Helper.correctNull((String) hshValues.get("fin_comments_sensitive"))%></td></tr>
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
	}}
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
						titleFlag=false;
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
		  <%if(titleFlag){ %>
		  <tr><td>- <%=strNil %> -</td></tr> 
		  <%} %>
		  
		  
		  <%
		  
		  for (int i = 0; i < arrImplSchRow.size(); i++) {
				arrImplSchCol = (ArrayList) arrImplSchRow.get(i);
		  if (!Helper.correctNull(
					(String) hshValues.get("COM_COMMENTS_10_COProj" + Helper.correctNull((String)arrImplSchCol.get(0))))
					.equalsIgnoreCase("")) {
			%>
			<tr>
			<td><br><b>Period and Repayment Schedule: </b></td>
			</tr>
			<tr>
			<td><%=Helper.correctNull(
					(String) hshValues.get("COM_COMMENTS_10_COProj" + Helper.correctNull((String)arrImplSchCol.get(0))))%></td>
			</tr>
			<%
			}
			if (!Helper.correctNull(
					(String) hshValues.get("COM_COMMENTS_11_COProj" + Helper.correctNull((String)arrImplSchCol.get(0))))
					.equalsIgnoreCase("")) {
			%>
			<tr>
			<td><br><b>Project Implementation Plan & Present Status and implication of DCCO with reference to IRAC: </b></td>
			</tr>
			<tr>
			<td><%=Helper.correctNull(
					(String) hshValues.get("COM_COMMENTS_11_COProj" + Helper.correctNull((String)arrImplSchCol.get(0))))%></td>
			</tr>
			<%
			}
			}
		  %>
<% } %>

<!-- Draw Down Schedule -->
<%
arrRow = new ArrayList();
arrCol = new ArrayList();
titleFlag=true;
if (arrDrawDown != null && arrDrawDown.size() > 0) {
	%>
	<tr><td class="title"><br>DrawDown Schedule:</td></tr> 
		   
	
	<%
	
	String facName = "";
	for (int i = 0; i < arrDrawDown.size(); i++) {
		arrRow = (ArrayList) arrDrawDown.get(i);
		if (arrRow != null && arrRow.size() > 0) {%>
		<tr>
		  <td>
		  <div id="top">
		  <table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%arrCol = (ArrayList) arrRow.get(3);
			for (int j = 0; j < arrCol.size(); j++) {
				arrOutCol=(ArrayList)arrCol.get(j);
				if(j==0) {
					titleFlag=false;
			%>
				<tr> <td colspan="5"><%=Helper.correctNull((String) arrRow.get(0)) %> - <%=Helper.correctNull((String) arrRow.get(1)) %> of Rs.   <%=Helper.converAmount(Helper.correctNull((String) arrRow.get(2)),strAmountvalue) %> <%=strAmtValueIn%></td> </tr>
				<tr>
				  <td width="3%" align="center">S.No</td>
				  <td width="15%" align="center">Quarter Start Date</td>
				  <td width="15%" align="center">Quarter end date</td>
				  <td width="30%" align="center">Total outstanding at the end of the quarter</td>
				  <td width="30%" align="center">Amount to be disbursed during the Quarter</td>
				  </tr>
				  <% } %>
				  <tr>
				  <td align="left"><%=j + 1%></td>
				  <td align="center"><%=Helper.correctNull((String) arrOutCol.get(0))%></td>
				  <td align="center"><%=Helper.correctNull((String) arrOutCol.get(1))%></td>
				  <td align="right"><%=Helper.converAmount(Helper.correctNull((String) arrOutCol.get(2)),strAmountvalue)%></td>
				  <td align="right"><%=Helper.converAmount(Helper.correctNull((String) arrOutCol.get(3)),strAmountvalue)%></td>
				  </tr>
		
	<% } 
			%>
			</table>
		  </div>
			</td>
		  </tr>
		  <tr><td><%=Helper.correctNull((String)hshValues.get("strDrawDownCmts"+Helper.correctNull((String)arrRow.get(0)))) %></td></tr>	
				
			<%}  } %>
		
		  <%if(titleFlag){ %>
		  <tr><td>- <%=strNil %> -</td></tr> 
		  <%} %>
<% } %>

<%if(arrPresentWC!=null && arrPresentWC.size()>0){ %>
<tr><td class="title" valign="top"><br/><b>ASSESSMENT OF WORKING CAPITAL LIMITS :</b></td></tr>
<tr><td class="title" valign="top"><br/>Assessment of fund based working capital limits :</td></tr>

<%double dblExistingFund=0.0,dblPropFund=0.0;%>
<%for(int j=0;j<arrExistingWC.size();j++){ 
					arrCol=(ArrayList)arrExistingWC.get(j);
					dblExistingFund+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));	
}
dblExistingFund+=Double.parseDouble(Helper.correctDouble((String)hshValues.get("FbSum1")));

for(int j=0;j<arrPresentWC.size();j++){ 
	arrCol=(ArrayList)arrPresentWC.get(j);
	dblPropFund+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)));
}
dblPropFund+=Double.parseDouble(Helper.correctDouble((String)hshValues.get("ProFbSum1")));

if(dblExistingFund>0 || dblPropFund>0)
{
%>
<tr><td width="30%" class="title">Fund Based limits from Banking System&nbsp;:&nbsp;</td></tr>
<tr>			
				<td align="right" width=""><%=strAmtValueIn%></td>
</tr>
<tr>
<td>
<div id="top">
		<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
		<td align="center">Details of existing fund based limits</td>
		<td align="center"><%=Helper.converAmount(jtn.format(dblExistingFund),strAmountvalue) %>&nbsp;</td>
		</tr>
		<tr>
		<td align="center">Details of proposed facilities</td>
		<td align="center"><%=Helper.converAmount(jtn.format(dblPropFund),strAmountvalue) %></td>
		</tr>
		</table>
	</div>
</td>
</tr>
<%} %>

<tr>
	<td>
	<span title="pagebreak" onKeyDown="callKeyDown()"></span>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td align="left" width="50%" class="title">i) Fund Based limits from our bank :</td>
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
				<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(1)),strAmountvalue)  %></td>
				</tr>
				<%} %>
			</table>
		</div>
		</td>
</tr>
<% }%>

<tr><td>&nbsp;</td></tr>
<tr><td class="title">Estimates and actual for the last 3 years</td></tr>
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
<tr>
		<td class="title">Estimates of sales for the current year</td>
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
	int count1 = Integer.parseInt(Helper.correctInt((String) hshValues
			.get("count")));
	if (count1 > 0) {
%>
	
	<%
			for (int h = 0; h < count1; h++) {

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
					if (!Helper.correctNull((String) hshValues.get("strStockAss"))
							.equalsIgnoreCase("")) {
			%>
			<tr>
				<td class="title" align="left">Comment on Stock of Work in Process/Progress:</td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strStockAss"))%></td>
			</tr>
			<%
				}
					if (!Helper.correctNull((String) hshValues.get("strDebitorAnalysis"))
							.equalsIgnoreCase("")) {
			%>
			<tr>
				<td class="title" align="left">Age wise Debtor Analysis:</td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strDebitorAnalysis"))%></td>
			</tr>
			<%
				}
					if (!Helper.correctNull((String) hshValues.get("strPeerconcerns"))
							.equalsIgnoreCase("")) {
			%>
			<tr>
				<td class="title" align="left">Comment on Comparison with Peer Concerns in the Industry with particular reference to Working Capital Cycle as well as comments on bank's exposure to the Sector (Industry Exposure) and experience.</td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strPeerconcerns"))%></td>
			</tr>
			<%
				}
					if (!Helper.correctNull((String) hshValues.get("strOtherAssets"))
							.equalsIgnoreCase("")) {
			%>
			<tr>
				<td class="title" align="left">Details of Other Current Assets & Liabilities:</td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String) hshValues
								.get("strOtherAssets"))%></td>
			</tr>
			<%
				}
					if (!Helper.correctNull((String) hshValues.get("strAssCmtsPIA"))
							.equalsIgnoreCase("")) {
			%>
			<tr>
				<td class="title" align="left">Availability of drawing power/ calculation of DP for the assessment period:</td>
			</tr>
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
if (!Helper.correctNull((String) hshValues.get("strRetireCapacity"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td class="title" align="left">Capacity to retire the obligations under LC/BG/Buyers' Credit</td>
</tr>
<tr>
<td align="left"><%=Helper.correctNull((String) hshValues
			.get("strRetireCapacity"))%></td>
</tr>
<%
}
if (!Helper.correctNull((String) hshValues.get("strPerformCapacity"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td class="title" align="left">Capacity to Perform under Bank Guarantee</td>
</tr>
<tr>
<td align="left"><%=Helper.correctNull((String) hshValues
			.get("strPerformCapacity"))%></td>
</tr>
<%
}
if (!Helper.correctNull((String) hshValues.get("strOfferCashMargin"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td class="title" align="left">Offer comments about Cash margin</td>
</tr>
<tr>
<td align="left"><%=Helper.correctNull((String) hshValues
			.get("strOfferCashMargin"))%></td>
</tr>
<%
}
if (!Helper.correctNull((String) hshValues.get("strExpiredBG"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td class="title" align="left">Comments on Expired BG's</td>
</tr>
<tr>
<td align="left"><%=Helper.correctNull((String) hshValues
			.get("strExpiredBG"))%></td>
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
			<td class="title"><br>ASSESSMENT OF CREDIT LINE FOR FORWARD CONTRACT LIMIT:</td>
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
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	
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
<%if(!Helper.correctNull((String)hshValues.get("strIndustryAnalysis")).equalsIgnoreCase("")){ %>
			<tr>
				<td class="title" align="left"><br>Industry Outlook/Scenario :</td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String)hshValues.get("strIndustryAnalysis"))%></td>
			</tr>
<% }%>
<%if(!Helper.correctNull((String)hshValues.get("strGovtPolicy")).equalsIgnoreCase("")){ %>
			<tr>
				<td class="title" align="left"><br>Impact of Government Policy on the Industry and Applicant/Borrower Company :</td>
			</tr>
			<tr>
				<td align="left"><%=Helper.correctNull((String)hshValues.get("strGovtPolicy"))%></td>
			</tr>
<% }%>

<tr>		
<td align="left" class="title">Swot Analysis</td>
</tr>
<tr>
<%
if(arrSwotAnalysis!=null&&arrSwotAnalysis.size()>0)
{ %>
<%for(int i=0;i<arrSwotAnalysis.size();i++)
	{
		arrCol=(ArrayList)arrSwotAnalysis.get(i);
	%>
	
	<td align="left" class="title"><%=Helper.correctNull((String)arrCol.get(0))%></td>
	</tr>
	<tr>
	<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
	</tr>
	
<%
}%>	

<%}else{ %>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>
<%
if (!Helper.correctNull(
		(String) hshValues.get("MgmtComments23"))
		.equalsIgnoreCase("")) {
%>
<tr><td><br><span class="title">Request for Gold Card Status </td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
							.get("MgmtComments23"))%></td></tr><%
}
	int m = 1;
%>

<tr><td class="title"><br><%=strSno[7]%> Other relevant information:</td></tr>
<tr><td><br><%=m++%>) <b>Sanctioning Authority: </b>&nbsp; <%=Helper.correctNull((String) hshValues.get("com_sancauthorityVal"))%></td></tr>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments13"))
				.equalsIgnoreCase("")) {
%>
<tr><td><br><span class="title"><%=m++%>)Comment on Pricing of the facilities:</span> (The pricing of limits including Fund Based and Non Fund Based limits shall be discussed here along 
with Justification for according market competition rebate if any while calculating effective rate of interest under MCLR) </td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments13"))%></td></tr><%
	}
if (!Helper.correctNull(
		(String) hshValues.get("MgmtComments12"))
		.equalsIgnoreCase("")) {
%>
<tr><td><br><span class="title"><%=m++%>)Periodicity of Working Capital limits</span></td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
							.get("MgmtComments12"))%></td></tr><%
}
if (!Helper.correctNull(
		(String) hshValues.get("MgmtComments18"))
		.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>)Other Service Charges and Processing Charges:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
							.get("MgmtComments18"))%></td></tr><%
}
%>
<%
	if (!Helper
				.correctNull((String) hshValues.get("MgmtComments8"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) CMC Clearance:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments8"))%></td></tr><%
	}
if (!Helper.correctNull(
		(String) hshValues.get("MgmtComments11"))
		.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) ALCO clearance:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
							.get("MgmtComments11"))%></td></tr><%
}
if (!Helper.correctNull(
		(String) hshValues.get("MgmtComments19"))
		.equalsIgnoreCase("")) {
%>
<tr><td><br><span class="title"><%=m++%>)Un - hedged Foreign Currency Exposure Position </span>(In respect of constituents having total exposure of Rs.25.00 Crore & above from our bank):</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
							.get("MgmtComments19"))%></td></tr><%
}
if (!Helper.correctNull(
		(String) hshValues.get("MgmtComments20"))
		.equalsIgnoreCase("")) {
%>
<tr><td><br><span class="title"><%=m++%>) Comments on whether Account marked under Exit Policy: </span>If Yes, detailed discussion in this regard shall be recorded in the note.</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
							.get("MgmtComments20"))%></td></tr><%
}
if (!Helper.correctNull(
		(String) hshValues.get("MgmtComments21"))
		.equalsIgnoreCase("")) {
%>
<tr><td><br><span class="title"><%=m++%>) Comments on availability of Personal Guarantee of Promoters/Directors:</span> In case of non-availability, the reasons for recommending the proposal without the guarantee of promoters shall be discussed in detail. </td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
							.get("MgmtComments21"))%></td></tr><%
}
%>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments16"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) Others information:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments16"))%></td></tr><%}
%>
<%
	if (!Helper.correctNull(
				(String) hshValues.get("MgmtComments24"))
				.equalsIgnoreCase("")) {
%>
<tr><td class="title"><br><%=m++%>) Comment on Rating:</td></tr>
<tr><td><%=Helper.correctNull((String) hshValues
									.get("MgmtComments24"))%></td></tr><%
	}
%>

<%if(!Helper.correctNull((String)hshValues.get("com_griddate")).equalsIgnoreCase("")){ %>

<tr><td class="title">Clearance by Credit Approval Grid :</td></tr>
<tr><td>The said proposal is placed before Credit Approval grid meeting dated <%=Helper.correctNull((String)hshValues.get("com_griddate")) %> and the observations received vide e-mail dated <%if(Helper.correctNull((String)hshValues.get("strEmailDate")).equalsIgnoreCase("")){%>________________<%}else{%><%=Helper.correctNull((String)hshValues.get("strEmailDate")) %><%} %> and compliance are enclosed as Annexure II.</td></tr>

<%} %>
<tr><td class="title"><br><%=strSno[a]%>.<%a++; %>&nbsp;Recommendations:</td></tr>
<tr>
	<td>
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
	<div align="left" id="top">
			<jsp:include page="../print/com_ProcessnoteNewcond1.jsp" flush="true">
			<jsp:param name="pagevalue" value="PROPOSALLC"/>
			</jsp:include>
		</div>
	</td>
</tr>

</table>

</table>
<br/><br/>
</div>
</body>
</html>