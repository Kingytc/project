<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
	request.setAttribute("_cache_refresh", "true");
%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	//out.println(hshValues);
	//cic check section added on 07-05-2021 section starts
	session.setAttribute("TabAmountRequest", Helper
			.correctNull((String) hshValues.get("sancmount")));
	session.setAttribute("cicScoreCount", Helper
			.correctNull((String) hshValues.get("cicScoreCount")));
	session.setAttribute("cicAmountCheck", Helper
			.correctNull((String) hshValues.get("cicAmountCheck")));
	session.setAttribute("cicLoanFor", Helper
			.correctNull((String) hshValues.get("cicLoanFor")));
	session.setAttribute("strLoanFor", Helper
			.correctNull((String) hshValues.get("strLoanFor")));
	//cic check section added on 07-05-2021 section ends

	session.setAttribute("prdType", Helper
			.correctNull((String) hshValues.get("selecttype")));
	session.setAttribute("productcode", Helper
			.correctNull((String) hshValues.get("prdcode")));
	String repaydate = Helper.correctNull((String) hshValues
			.get("repaydate"));
	String emi_till_date = Helper.correctNull((String) hshValues
			.get("emi_till_date"));
	session.setAttribute("moduletype", "R");
	String Status = Helper
			.correctNull((String) hshValues.get("status"));
	session.setAttribute("status", Status);
	String frominboxmail = Helper.correctNull((String) hshValues
			.get("frominboxmail"));
	String pagefromROInbox = Helper.correctNull((String) hshValues
			.get("strfromROInbox"));
	if (!pagefromROInbox.equals("")) {
		session.setAttribute("pagefromROInbox", pagefromROInbox);
		session.setAttribute("pageType", "retail");
	} else {
		session.setAttribute("pagefromROInbox", "");
		session.setAttribute("pageType", "retail");
	}
	String PageFrom = Helper.correctNull((String) hshValues
			.get("strPagetype"));
	if (PageFrom.equals("NSDL")) {
		session.setAttribute("bowname", Helper
				.correctNull((String) hshValues.get("NsdlAppName")));
		session.setAttribute("bowid", Helper
				.correctNull((String) hshValues.get("NsdlAppId")));
	}
	/**Application no. through Existing */
	if (Helper.correctNull((String) session.getAttribute("link"))
			.equals("NEW")
			&& Helper.correctNull((String) hshValues.get("appid"))
					.equals("")) {
		if (frominboxmail.trim().equalsIgnoreCase("")) {
			session.setAttribute("bowname", Helper.correctNull(request
					.getParameter("compname")));
			session.setAttribute("bowid", Helper.correctNull(request
					.getParameter("appid")));
		}
	}
	session.setAttribute("lreqterms", Helper
			.correctNull((String) hshValues.get("lreqterms")));

	String bowid = "", bowname;
	bowid = Helper.correctNull((String) session.getAttribute("bowid"));

	bowname = Helper.correctNull((String) session
			.getAttribute("bowname"));//bowname is fetched through existing
	String strappno1 = Helper.correctNull((String) hshValues
			.get("appno"));
	//out.println("aaaaaaaaaaaaaaaaaaaaa==="+hshValues);
	session.setAttribute("appno", Helper.correctNull((String) request
			.getParameter("appno")));
	//added by s.sathya moorthy for application number bug.
	pageContext.setAttribute("appno", strappno1, 2);

	/** End of existing */

	/** Application no. through Inbox mail*/
	if (frominboxmail.trim().equalsIgnoreCase("frominboxmail")) {
		bowname = Helper.correctNull((String) hshValues.get("aname"));//bowname is fetched through Mail box
		session.setAttribute("bowname", bowname);
	}
	if (bowname.equalsIgnoreCase("")) {
		bowname = Helper.correctNull((String) hshValues.get("aname"));
	}
	/** End of Inbox mail*/
	if (!strappno1.equals("")) {
		bowid = Helper.correctNull((String) hshValues.get("appid"));
		session.setAttribute("bowid", Helper.correctNull(request
				.getParameter("appid")));
	}
	bowid = Helper.correctNull((String) hshValues.get("appid"));
	String strappeditsameregbranch = Helper
			.correctNull((String) hshValues
					.get("strappeditsameregbranch"));
	session.setAttribute("HRBranchUserEdit", strappeditsameregbranch);
	String strOrgShortCode = Helper.correctNull((String) hshValues
			.get("strOrgShortCode"));
	session.setAttribute("strOrgShortCode", strOrgShortCode);

	//out.println("strorgcode"+strOrgShortCode);

	//To get create date and show according to them---------
	String System_date_App = Helper.correctNull((String) hshValues
			.get("System_date_App"));
	if (System_date_App.equals("")) {
		session.setAttribute("createdate", Helper
				.correctNull((String) hshValues.get("app_createdate")));
	} else {
		session
				.setAttribute("createdate", Helper
						.correctNull((String) hshValues
								.get("System_date_App")));
	}
	String newflag = "N";
	if (Helper.correctNull((String) session.getAttribute("link"))
			.equals("NEW")) {
		//document.forms[0].amort.value.disable=true;
		newflag = "Y";
	}

	session.setAttribute("selecttypeedu", Helper
			.correctNull((String) hshValues.get("selecttype")));//to hide education tab	
	session.setAttribute("selectpurposeedu", Helper
			.correctNull((String) hshValues.get("selectpurpose")));//to hide education tab

	String credate = (String) session.getAttribute("createdate");
	String strdate = (String) ApplicationParams.getAppcreatedate();
	long diff_intime = 0;
	diff_intime = Helper.dateDiff(credate, strdate);
	if (diff_intime > 0) {
		session.setAttribute("new_rating", "N");
	} else if (diff_intime <= 0) {
		session.setAttribute("new_rating", "Y");
	}

	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String loan_selecttype = Helper.correctNull((String) hshValues
			.get("selecttype"));
	String loan_pmayYES = Helper.correctNull((String) hshValues
			.get("loan_pmay"));
	session.setAttribute("PMAYValue", loan_pmayYES);
	String loanPrdType = Helper.correctNull((String) hshValues
			.get("prdcode"));
	String strbaserate = Helper.correctInt((String) hshValues
			.get("interestrate"));
	String strinterestrate = Helper.correctInt((String) hshValues
			.get("mintrate"));
	String strgurantorcount = Helper.correctInt((String) hshValues
			.get("count"));
	String strapprocesdate = Helper.correctNull((String) hshValues
			.get("app_processdate"));
	String strappstatus = Helper.correctNull((String) hshValues
			.get("app_status"));
	String currdate = Helper.getCurrentDateTime();
	String MCLRFLAG = "";

	if (loanPrdType.startsWith("7")) {
		MCLRFLAG = "Base Rate";
	}

	String strEligibleRev = Helper.correctNull((String) hshValues
			.get("strEligibleRev"));
	session.setAttribute("strEligibleRev", strEligibleRev);
	String strSetupValue = Helper.correctNull((String) hshValues
			.get("db1ParamValue"));

	String strBranchMigval = Helper.correctNull((String) session
			.getAttribute("BranchMigValue"));

	if (!Helper
			.correctNull((String) hshValues.get("CBSIDUpdatedValue"))
			.equalsIgnoreCase("")) {
		session.setAttribute("CBSIDMigValue", Helper
				.correctNull((String) hshValues
						.get("CBSIDUpdatedValue")));
	}
	String strCBSMigval = Helper.correctNull((String) session
			.getAttribute("CBSIDMigValue"));
	if (strCBSMigval.equals("")) {
		strCBSMigval = Helper.correctNull((String) hshValues
				.get("CBSIDUpdatedValue"));
	}
	//Schedletype and rate chart codes
	Vector v = new Vector();
	Vector g = new Vector();
	Vector vc = new Vector();
	Vector vc1 = new Vector();
	if (!loanPrdType.equalsIgnoreCase("")) {
		v = (Vector) hshValues.get("vecRow");
		vc = (Vector) hshValues.get("vecRowRate");
	}

	String strnewscheme = Helper.correctNull((String) hshValues
			.get("strnewscheme"));
	if (strnewscheme.equals("Y")) {
		session.setAttribute("strnewscheme", strnewscheme);
	} else {
		session.setAttribute("strnewscheme", "");
	}

	String strCanaraSyndBank = ApplicationParams
			.getStrCbsInterfaceflag();
	String strsentspcchk = Helper.correctNull((String) hshValues
			.get("sentspcchk"));
	//out.println(strCanaraSyndBank);
	Vector vecRowCourse = new Vector();
	Vector vecRowCourse1 = new Vector();
	vecRowCourse = (Vector) hshValues.get("vecRowCourse");
	
	//Added on 17-06-2021 to Validate Multiple Cic Check for Co-Borrower Section starts
	ArrayList EducationCoBorrowerCICDataListRows=new ArrayList();
	ArrayList EducationCoBorrowerCICDataListCols=new ArrayList();
	EducationCoBorrowerCICDataListRows=(ArrayList)hshValues.get("EducationCoBorrowerCICDataList");
	session.setAttribute("EducationCoBorrowerCICDataList", (ArrayList)hshValues.get("EducationCoBorrowerCICDataList"));
	//Added on 17-06-2021 to Validate Multiple Cic Check for Co-Borrower Section ends
	
	String CourseExpFlag=Helper.correctNull((String)hshValues.get("CourseExpFlag"));
	session.setAttribute("CourseExpFlag",CourseExpFlag);
	String CourseGrandTotal=Helper.correctNull((String)hshValues.get("CourseGrandTotal"));
	session.setAttribute("CourseGrandTotal",CourseGrandTotal);
//	out.print("CourseExpFlag"+CourseExpFlag+"---"+"CourseGrandTotal"+CourseGrandTotal);
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {
	font-family: "MS Sans Serif";
	font-size: 10px;
	color: #003399;
	border-style: groove
}
-->
</style>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}

select {
	font-family: "MS Sans Serif";
	font-size: 10px;
	color: #003399
}

a:hover {  color: #CC3300}  a{text-decoration: none;}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/nationalportal/NP_perloandetails.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/browservalidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varfrom="<%=Helper.correctNull((String) hshValues.get("rfrom"))%>";
var varto="<%=Helper.correctNull((String) hshValues.get("rangeto"))%>";
var prdrangeto="<%=Helper.correctNull((String) hshValues.get("prdrangeto"))%>";
var varstrclass="<%=Helper.correctNull((String) hshValues
							.get("shanshidclass"))%>";
var strUsrClass="<%=Helper.correctNull((String) session
							.getAttribute("strUserClass"))%>";
var varempstatus="<%=Helper.correctNull((String) hshValues.get("empstatus"))%>";
var varData="<%=Helper.correctNull((String) hshValues
									.get("noData"))%>";
var varIntType ="<%=Helper.correctNull((String) hshValues
									.get("loaninttype"))%>";
var arrinterestval = "<%=Helper.correctNull((String) hshValues
							.get("strstepintrate"))%>";
var arrtoamtval = "<%=Helper.correctNull((String) hshValues
									.get("strsteptoamt"))%>";
var amorticzationcount = "<%=Helper.correctNull((String) hshValues
							.get("amortizationcount"))%>";
var varRepayType ="<%=Helper.correctNull((String) hshValues
							.get("repaymenttype"))%>";
var emptype="<%=Helper.correctNull((String) hshValues
							.get("perapp_employment"))%>";
var selecttype ="<%=Helper.correctNull((String) hshValues.get("selecttype"))%>";
var selectpurpose ="<%=Helper.correctNull((String) hshValues
							.get("selectpurpose"))%>";
var strappeditsameregbranch="<%=Helper.correctNull((String) hshValues
							.get("strappeditsameregbranch"))%>";
var strOrgShortCode="<%=Helper.correctNull((String) hshValues
							.get("strOrgShortCode"))%>";
var srtTemp="<%=Helper.correctNull((String) hshValues
							.get("strTempchecklimit"))%>";

<%if (!strappno1.equals("") || !strappno1.equals("new")) {%>
var checkappnonew="<%=strappno1%>";
<%} else {%>
var checkappnonew="<%=Helper.correctNull((String) request
								.getParameter("appno"))%>";
<%}%>

var checkvehappentry="<%=Helper.correctNull((String) hshValues
							.get("auto_valuation"))%>";
var checkappentry1="<%=Helper.correctNull((String) hshValues
							.get("latest_income"))%>";
var applicantname="<%=bowname%>";
var TURN_OVER="<%=Helper.correctNull((String) hshValues.get("TURN_OVER"))%>";
var INCOME_PROOF="<%=Helper.correctNull((String) hshValues
									.get("INCOME_PROOF"))%>";
var loan_selecttype="<%=Helper.correctNull((String) hshValues.get("selecttype"))%>";
var loan_prdType="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>";
var HouseLoan = "<%=Helper.correctNull((String) hshValues.get("loan_house"))%>";
var varSetHouseVal="<%=Helper.correctNull((String) hshValues
							.get("SetUpHouseValue"))%>";

var baseRate="<%=strbaserate%>";
var interestRate="<%=strinterestrate%>"; 
var gurantorcount="<%=strgurantorcount%>"; 
var loanPrdType="<%=loanPrdType%>"; 
var varVidyaValue="<%=strSetupValue%>";
var chkNewInterestRate = "<%=Helper.correctNull((String) hshValues
							.get("chkNewInterestRate"))%>";
var varCibilLapsId="<%=Helper.correctNull((String) hshValues
									.get("cibilLapsId"))%>";
var varpmayValue="<%=Helper.correctNull((String) hshValues.get("loan_pmay"))%>";
var varPageFrom = "<%=Helper.correctNull((String) hshValues
									.get("strPagetype"))%>";

var vardatebasis="<%=Helper.correctNull((String) hshValues
							.get("loan_datebasis"))%>";
var varstrBranchMigval="<%=strBranchMigval%>";
var varCBSIDMigValue="<%=Helper.correctNull((String) hshValues
							.get("CBSIDUpdatedValue"))%>";
var varschedType="<%=Helper.correctNull((String) hshValues
							.get("loan_schedutype"))%>";
var varRateChat="<%=Helper.correctNull((String) hshValues
							.get("loan_ratechart"))%>";
var varstrCBSMigval="<%=strCBSMigval%>";
var varcheckPenalty="<%=Helper.correctNull((String) hshValues
							.get("APP_PENALTYINTEREST"))%>";
var varrelation="<%=Helper.correctNull((String) hshValues
							.get("perapp_relationship"))%>";
var varschedText="";
var varMORTFLAG="<%=Helper.correctNull((String) hshValues
							.get("LOAN_MORTFLAG"))%>";
var LOAN_PSB59="<%=Helper.correctNull((String) hshValues.get("LOAN_PSB59"))%>";
var LOAN_PSB59_REFNO="<%=Helper.correctNull((String) hshValues
							.get("LOAN_PSB59_REFNO"))%>";
var varstrnewscheme="<%=strnewscheme%>";
var LOAN_SANCTION_AUTHORITY="<%=Helper.correctNull((String) hshValues
							.get("LOAN_SANCTION_AUTHORITY"))%>";
var varCanaraSyndBank="<%=strCanaraSyndBank%>";
var CoapplicantRecord="<%=Helper.correctNull((String) hshValues
							.get("CoapplicantRecord"))%>";
var varAppHolder="<%=Helper.correctNull((String) hshValues.get("AppHolder"))%>";
var varAppSancPrintFlg="<%=Helper.correctNull((String) hshValues
							.get("APP_SANCTIONPRINTFLAG"))%>";
var EDU_STUDINGIN="<%=Helper.correctNull((String) hshValues
							.get("EDU_STUDINGIN"))%>";
var EDU_COURSETYPE="<%=Helper.correctNull((String) hshValues
							.get("EDU_COURSETYPE"))%>";
var LOAN_AVAILING_FOR_SEM="<%=Helper.correctNull((String) hshValues
							.get("LOAN_AVAILING_FOR_SEM"))%>";
var COURSE_DAY0="<%=Helper.correctNull((String) hshValues
									.get("COURSE_DAY0"))%>";
var LOAN_DRAWDOWN="<%=Helper.correctNull((String) hshValues
							.get("LOAN_DRAWDOWN"))%>";
var varCollFlag="<%=Helper.correctNull((String) hshValues
									.get("strCollFlag"))%>";
var NP_LOAN_REPAYINTEREST="<%=Helper.correctNull((String) hshValues.get("NP_LOAN_REPAYINTEREST"))%>";
var NP_LOAN_PRO_REPAYBY="<%=Helper.correctNull((String) hshValues.get("NP_LOAN_PRO_REPAYBY"))%>";
									
</script>
<script>

function calminmargin()
{
var txtloan_costloanprd=document.forms[0].txtloan_costloanprd.value;
var txtloan_sancamt=document.forms[0].txtloan_sancamt.value;
var txtRecLoanValRatio1=eval(txtloan_costloanprd)-eval(txtloan_sancamt);
var txtRecLoanValRatio2=eval(txtRecLoanValRatio1)/eval(txtloan_costloanprd);
var txtRecLoanValRatio3= 100* eval(txtRecLoanValRatio2);
document.forms[0].txtRecLoanValRatio.value=roundVal(txtRecLoanValRatio3);

var txtloan_recmdamt=roundVal(eval(txtloan_costloanprd)-eval(txtloan_sancamt));
document.forms[0].txtloan_recmdamt.value=txtloan_recmdamt;
var varSchemValue=document.forms[0].selectpurpose.value;

if(varSchemValue =="16" && eval(txtloan_sancamt)>400000 )
{
	alert("Please Check the scheme. The Proposed Loan amount should be less than equal to 4 Lacs.");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
if(varSchemValue =="18" && eval(txtloan_sancamt)>400000 )
{
	alert("Please Check the scheme. The Proposed Loan amount should be less than equal to 4 Lacs.");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="17" && eval(txtloan_sancamt)<=400000 )
{
	alert("Please Check the scheme. The Proposed Loan amount should be greater than 4 Lacs.");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="17" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="19" && eval(txtloan_sancamt)<=400000 )
{
	alert("Please Check the scheme. The Proposed Loan amount should be greater than 4 Lacs.");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="19" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}

var prdcode = document.forms[0].shanshidProductID.value; 
if(prdcode == "949")
{
if(varSchemValue =="20" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="21" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="22" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="23" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="24" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="25" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
else if(varSchemValue =="26" && eval(txtloan_sancamt) > eval(varVidyaValue))
{
	alert("The Proposed Loan amount should not be greater than "+varVidyaValue+".");
	document.forms[0].txtloan_sancamt.focus();
	return false;
}
}
}
function getView(varHtmlOpt)
{
	if(varHtmlOpt =="IDV" && document.forms[0].hidShowidv.value =="NO")
	{
		alert("IDV Report Not Available.");
		return;
	}
	//var	varQryString = appURL+"action/iframecreditreportView.jsp?hidBeanId=cibilInterface&hidBeanGetMethod=viewTUEFData&viewReport=yes&txtperapp_appid="+varCibilLapsId+"&fileno="+document.forms[0].hidcibilNumber.value+"&htmlNumbers=371";
	var	varQryString = appURL+"action/iframecreditreportView.jsp?hidBeanId=cibilInterface&hidBeanGetMethod=viewCIBILIDVData&UserOption="+varHtmlOpt+"&filename="+document.forms[0].hidcibilNumber.value+"&newApi="+document.forms[0].hidShowidv.value+"&txtperapp_appid="+varCibilLapsId;
	var prop = "scrollbars=yes,width=1200,height=550,menubar=yes,toolbar=yes";	
	var xpos = (screen.width - 1200) / 2;
	var ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,'title',prop);
}
function callmortgageLimitofLoan(page,getm)
{

var selectpurpose1 ="<%=Helper.correctNull((String) hshValues
							.get("selectpurpose"))%>";



if(srtTemp=="0")
{
	alert("Enter the Employment Status in Retail-->Customer Profile");
	return false;
}


 if(selectpurpose1=="25")
{
	if((emptype==4)||(emptype==6)||(emptype==7)||(emptype==8)||(emptype==9)||(emptype==10))
	{
		if(INCOME_PROOF=="0")
		{
			alert("Check for Employer Type -Proof of Income  Combination in Customer Pofile");
			return false;
		}
	}	
}

var selectloantype= "<%=Helper.correctNull((String) hshValues.get("selecttype"))%>";
var strprdid =document.forms[0].shanshidProductID.value //document.forms[0].hidProductID.value;
var appid= document.forms[0].hidDemoId.value;
 //var stramtreq = document.forms[0].txtloan_amtreqd.value; 
var stramtreq = document.forms[0].txtloan_sancamt.value; 
var margin = document.forms[0].txtRecLoanValRatio.value; 
var strorgappno= "<%=strappno1%>";
var nooftrms = document.forms[0].txtloan_reqterms.value;
var monthlyemi = eval(document.forms[0].txtmonPay.value);
var loan_filedon=document.forms[0].txtloan_filedon.value;


if(checktrim(document.forms[0].txtmonPay.value)=="")
{
	monthlyemi="0.00";
}
var costofloanprd= "<%=Helper.correctNull((String) hshValues
							.get("costPrdCharges"))%>";
var repaymenttype= document.forms[0].hidrepayment.value;
if(strprdid == "")
{
	alert("Select Product");
	return false;
}
if(appid == "")
{
	alert("Select Applicant Name");
	return false;
}
if(stramtreq == "")
{
	alert("Enter Requested Amount");
	return false;
}
if(nooftrms == "")
{
	alert("Enter Term");
	return false;
}
if(repaymenttype=="1")
{
	if(checktrim(document.forms[0].txtmonPay.value) == "")
	{
		alert("Calculate EMI");
		return false;
	}
}
if(selecttype=="C")
	{
		
		var selectpurpose=document.forms[0].selectpurpose.value;
		if(selectpurpose=="8")//laghuudyami
		{
			if(TURN_OVER=="1")
			{
			
				if(emptype == "4" || emptype == "6")
				{
						url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
						"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
						window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
				}else{
						alert("Check for Employer Type -Income/Turn Over Criteria Combination in Customer Pofile");
						return false;
					 }
			}else if((TURN_OVER=="2") || (TURN_OVER=="3"))
			{
				if(emptype=="8")
				{
						url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
						"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
						window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
				}else{
						alert("Check for Employer Type -Income/Turn Over Criteria Combination in Customer Pofile");
						return false;
					 }
			}else if(TURN_OVER=="4")
			{	
				if(emptype=="4" ||emptype=="6" || emptype=="8")
				{
						url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
						"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
						window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
				}else{
						alert("Check for Employer Type -Income/Turn Over Criteria Combination in Customer Pofile");
						return false;
					 }
			}else{
						alert("Check for Employer Type -Income/Turn Over Criteria Combination in Customer Pofile");
						return false;
			}
		
		}/*else if(selectpurpose=="11")//mortgage
		{
					getm="getsyndmortgageData";
					url="<%//=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
					"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
					window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
		}*/
	}


}

function callmahilaLimitofLoan(page,getm)
{


var selectpurpose1 ="<%=Helper.correctNull((String) hshValues
							.get("selectpurpose"))%>";

if(srtTemp=="0")
{
	alert("Enter the Employment Status in Retail-->Customer Profile");
	return false;
}



var selectloantype= "<%=Helper.correctNull((String) hshValues.get("selecttype"))%>";
var strprdid =document.forms[0].shanshidProductID.value //document.forms[0].hidProductID.value;
var appid= document.forms[0].hidDemoId.value;
 //var stramtreq = document.forms[0].txtloan_amtreqd.value; 
var stramtreq = document.forms[0].txtloan_sancamt.value; 
var margin = document.forms[0].txtRecLoanValRatio.value; 
var strorgappno= "<%=strappno1%>";
var nooftrms = document.forms[0].txtloan_reqterms.value;
var monthlyemi = eval(document.forms[0].txtmonPay.value);
var loan_filedon=document.forms[0].txtloan_filedon.value;


if(checktrim(document.forms[0].txtmonPay.value)=="")
{
	monthlyemi="0.00";
}
var costofloanprd="<%=Helper.correctNull((String) hshValues
							.get("costPrdCharges"))%>";
var repaymenttype= document.forms[0].hidrepayment.value;
if(strprdid == "")
{
	alert("Select Product");
	return false;
}
if(appid == "")
{
	alert("Select Applicant Name");
	return false;
}
if(stramtreq == "")
{
	alert("Enter Requested Amount");
	return false;
}
if(nooftrms == "")
{
	alert("Enter Term");
	return false;
}
if(repaymenttype=="1")
{
	if(checktrim(document.forms[0].txtmonPay.value) == "")
	{
		alert("Calculate EMI");
		return false;
	}
}


	if(selecttype=="C")
	{
	
	
		
		if(selectpurpose1=="6"||selectpurpose1=="7"||selectpurpose1=="12"||selectpurpose1=="13"||selectpurpose1=="14"||selectpurpose1=="15")
		{
				if(emptype!="10")
				{
					alert("Select the Employment Status in Customer Profile as Student");
					return false;
				}
				else
				{
				var selectpurpose=document.forms[0].selectpurpose.value;
				url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
				"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
				window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
				}
		}		
		else if(selectpurpose1=="5")
		{
             
		     	if(emptype=="5" || emptype=="14"  )
		     	{
		     		var selectpurpose=document.forms[0].selectpurpose.value;
					url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
					"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
					window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");	
		     	}
		     	else
			     {
		     		alert("Select the Employment Status in Customer Profile as Pensioner");
					return false;
			     }
// commented to for pensioner the emplyment status 5 and 14			     
//				if(emptype!="5" )
//				{
//					alert("Select the Employment Status in Customer Profile as Pensioner");
//					return false;
//				}
//				
//				else
//				{
//				var selectpurpose=document.forms[0].selectpurpose.value;
//				url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
//				"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
//				window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
//				}
		
		}
		else
		{
		
		var selectpurpose=document.forms[0].selectpurpose.value;
		url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
		"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
		window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
		}
	 	
	}

	else
	{
		var selectpurpose=document.forms[0].selectpurpose.value;
		url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
		"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
		window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
	}
}

function checkage()
{

	var prop_age ="<%=Helper.correctNull((String) hshValues.get("prop_age"))%>";
	
	var txtRecLoanValRatio=document.forms[0].txtRecLoanValRatio.value;
	
	/*if(prop_age>5)//for eduction there is no restriction on margin it could be either > or < than 30%
	{
		if(txtRecLoanValRatio<30)
		{
		alert("Margin Should be atleast 30%,Since Age of the Propertyis greater than 5 yrs");
		document.forms[0].txtRecLoanValRatio.value="";
		document.forms[0].txtRecLoanValRatio.focus();
		
		}
	}*/
}

function showDelAppButton()
{
	var statusForDel ="<%=Helper.correctNull((String) hshValues
									.get("status"))%>";
	if (statusForDel=="pa" || statusForDel=="pr")
	{
			//document.forms[0].cmddelApp.disabled=true;
	}
}

function doDelete()
{	
		var appno="<%=Helper.correctNull((String) request
									.getParameter("appno"))%>" ;
		if(appno=="new")
		{
			alert("You cannot delete New Application");
			return;
		}
		var bname="<%=bowname%>";
		var flag = confirm("Do you really want to delete this application");
		if (flag)
		{		
				var id = document.forms[0].hidDemoId.value;
				document.forms[0].hidAction2.value ="deleteApp";
				//document.forms[0].hidAction.value ="deleteApp";
				document.forms[0].hidBeanGetMethod.value="updateLoanProducts";
				document.forms[0].hidBeanId.value="perapplicant";
				//document.forms[0].action=appURL+"action/ControllerServlet";	
				document.forms[0].action="action/persearch.jsp?id="+id+"&hidPageType=EXI&bowname="+bname;
				//document.forms[0].hidSourceUrl.value="action/persearch.jsp?id="+id;
				//document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comsearch.jsp?id="+id;
				document.forms[0].submit();
		}
		
}

function test(prob)
{
	var probdateget = prob.value;
	var probday = probdateget.substring(0,2);
	var probmon = probdateget.substring(3,5);
	var probyr = probdateget.substring(6,10);
	var probdate = probmon+"/"+probday+"/"+probyr;
	
	var today = currentDate;
	var todayday = today.substring(0,2);
	var todaysmon = today.substring(3,5);
	var todaysyr = today.substring(6,10);
	var tdate = todaysmon+"/"+todayday+"/"+todaysyr;
	
// This comment part can be activated after testing - T V SOMASUNDARAM
//	if (Date.parse(probdate) < Date.parse(tdate))
//	{
//		alert("Application Filed Date cannot be lesser than Current Date");
//		document.forms[0].txtloan_emidate.value="";
//		return;
//	}

}
function calculateEmiCommDate()
{
   
   
	if(document.forms[0].txtloan_emidate.value != "")
	{
		if(document.forms[0].txt_installments.value!="")
		{
	 		var probdate =document.forms[0].txtloan_emidate.value;
			var mor=parseInt(document.forms[0].txt_installments.value);
			document.all.ifrmdate.src=appURL+"action/ifrmdate.jsp?hidBeanGetMethod=getIfrmDate&hidBeanId=perapplicant&probdate="+probdate+"&mor="+mor;
		}
		else
		{
			alert("Enter Moratorium");
			return false;
		}
	}
}
function calculateMaturityDate()
{
	if(document.forms[0].txtloan_emidate.value != "")
	{
	var pdate =document.forms[0].txtloan_emidate.value;
	var mterms=parseInt(document.forms[0].txtloan_reqterms.value);
	var  nextmatmon =1; 
	var parr = pdate.split("/");
	var pdays = parseInt(parr[0]);
	var pmonths= parseInt(parr[1]);
	var pyears = parseInt(parr[2]);
	//pmonths =eval(pmonths)+eval(1);
	for (var pm=0;pm<mterms;pm++)
	{
		if (pmonths >12)
		{
			pmonths = eval(2);
			pyears = eval(pyears)+eval(1);
		}
		else
		{
		 pmonths = eval(pmonths)+eval(1);
		}
	}
	var matdate = pdays+"/"+pmonths+"/"+pyears;
	//document.forms[0].txtloan_maturitydate.value = matdate;
	}
}

function checkemiandprobdate()
{
	if(document.forms[0].txtloan_emidate.value == "")
	{
		alert("select Probable Date of Disbursement");
		document.forms[0].txtloan_emidate.focus();
		return false;
	}
	if(document.forms[0].txtloan_emicommdate.value == "")
	{
		alert("select EMI Commencement Date");
		document.forms[0].txtloan_emicommdate.focus();
		return false;
	}
}

function emicommdate()
{
	if(document.forms[0].txtloan_emicommdate.value == "")
	{
		alert("select EMI Commencement Date");
		document.forms[0].txtloan_emicommdate.focus();
	}
}

function callCalender4()
 {
	 showCal(appURL,'txtloan_emicommdate');
 }
 function callCalender()
 {
	 showCal(appURL,'txtloan_filedon');
 }
  function callCalender1()
 {
	 showCal(appURL,'txtloan_emidate');
 }

function callCalender5()
{
 	 showCal(appURL,'date_agreementsign');
}
function callCalender6()
{
	 showCal(appURL,'date_offerletter');
}
function callCalender7()
{
	 showCal(appURL,'txt_Course_CommDate');
}
  
function chkminmaxterms()
{
	var min = parseInt(document.forms[0].txtloan_minterms.value)
	var max = parseInt( document.forms[0].txtloan_maxterms.value)
	var terms = parseInt(document.forms[0].txtloan_reqterms.value)
	var varNoOfInst = document.forms[0].txt_noofinstallments.value;
	if(varNoOfInst != "" && varNoOfInst != "0"){
	if(isNaN(terms)|| terms=="0.0")
   {
    alert("Enter Term of the Loan ")
    document.forms[0].txtloan_reqterms.value=""
    //document.forms[0].txtloan_reqterms.focus();
   }
	if(terms < min)
	{
	alert("No of Terms less than MinTerms ! ! ! ")
//	document.forms[0].txtloan_reqterms.value=""
//  document.forms[0].txtloan_reqterms.focus();
	document.forms[0].txt_noofinstallments.value="";
	document.forms[0].txt_noofinstallments.focus();
	}
 if(terms>max)
	{
	 alert("No of Terms greater than MaxTerms ! ! ! ")
//	 document.forms[0].txtloan_reqterms.value=""
//	 document.forms[0].txtloan_reqterms.focus();
	 document.forms[0].txt_noofinstallments.value="";
     document.forms[0].txt_noofinstallments.focus();
   }
	}
   
}


function callintbrcheck()
{
	var baserate= document.forms[0].txtloan_intrate.value;
	var intrate= document.forms[0].txtloan_modintrate.value;
	
	
	if(parseFloat(intrate)<=parseFloat("30")){
	if(document.forms[0].selectinttype1.value=="1"){
	
			if(eval(baserate)>eval(intrate))
				{
				alert("Interest Rate cannot be less than MCLR/EBLPR");
				document.forms[0].txtloan_modintrate.value="";
				document.forms[0].txtloan_modintrate.focus();
				return false;
				}
	}
	if(document.forms[0].selectinttype1.value=="2"){
	
			if(eval(baserate)>eval(intrate))
				{
				alert("Interest Rate cannot be less than MCLR/EBLPR");
				}
	}
	}
	else{
		alert("Check the Interest Rate");
		document.forms[0].txtloan_modintrate.value="";
		document.forms[0].txtloan_modintrate.focus();
		return false;
		}
}
function getterms()
{
	if(document.forms[0].txtloan_costloanprd.value != "" &&  document.forms[0].txtloan_costloanprd.value != "0.00"
		&& document.forms[0].txtloan_costloanprd.value != "0")
	{
		var prdcode = document.forms[0].shanshidProductID.value; 
		
/*		if(document.forms[0].txtloan_reqterms.value == "" || document.forms[0].txtloan_reqterms.value =="0.00")
		{
			alert("Enter the Terms of loan");
			return false;
		}*/

		var varNoOfInst = document.forms[0].txt_noofinstallments.value;
		if(varNoOfInst != "" && varNoOfInst != "0" && document.forms[0].txtloan_reqterms.value != ""){
		if(prdcode!="")
		{
			
			var amtreq = document.forms[0].txtloan_costloanprd.value; 
	
			document.all.ifrmnewintrate.src=appURL+"action/iframeinterestrate.jsp?prd_code="+document.forms[0].shanshidProductID.value+"&amtreq="+amtreq+
			"&txtloan_reqterms="+document.forms[0].txtloan_reqterms.value+"&hidBeanGetMethod=getNewInterestRate&hidBeanId=perapplicant&cbsMigrationNum="+varstrCBSMigval+"&Scheduletype="+document.forms[0].txt_schedutype.value;
		}
		else
		{
			alert("Select Product");
		}
	}
	}
	if(varstrCBSMigval =="1" && document.forms[0].hidchkNewInterestRate.value =="N")
	 {
   		callRateChatChange();
	 }
}
function doDateCheck(from, to) 
{
	if (Date.parse(from.value) <= Date.parse(to.value)) {
	alert("The dates are valid.");
	}
}
function checkFileDate(obj)
{
	var pagedate = obj.value;
	var pgdt = pagedate.substring(0,2);
	var pgmon = pagedate.substring(3,5);
	var pgyr = pagedate.substring(6,10);
	var objdate = pgmon+"/"+pgdt+"/"+pgyr;
	
	var currdate = currentDate;
	var crdt = currdate.substring(0,2);
	var crmon = currdate.substring(3,5);
	var cryr = currdate.substring(6,10);
	var curdate = crmon+"/"+crdt+"/"+cryr;
	
	if (Date.parse(objdate) > Date.parse(curdate))
	{
		alert("Application Filed Date cannot be greater than Current Date");
		document.forms[0].txtloan_filedon.value="";
		return;
	}
}
function checkProDisbDate(obj)
{
	var pagedate = obj.value;
	var pgdt = pagedate.substring(0,2);
	var pgmon = pagedate.substring(3,5);
	var pgyr = pagedate.substring(6,10);
	var objdate = pgmon+"/"+pgdt+"/"+pgyr;
	
	var currdate = currentDate;
	var crdt = currdate.substring(0,2);
	var crmon = currdate.substring(3,5);
	var cryr = currdate.substring(6,10);
	var curdate = crmon+"/"+crdt+"/"+cryr;
	
	if (Date.parse(objdate) < Date.parse(curdate))
	{
		alert("Probable Date of Disbursement cannot be less than Current Date");
		document.forms[0].txtloan_emidate.value="";
		return;
	}
}
function callLimitofLoan()
{
if(srtTemp=="0")
{
	alert("Enter the Employment Status in Retail-->Customer Profile");
	return false;
}
var selectloantype= "<%=Helper.correctNull((String) hshValues.get("selecttype"))%>";

var hidAppStatus=document.forms[0].hidAppStatus.value;
var strprdid =document.forms[0].shanshidProductID.value //document.forms[0].hidProductID.value;
var appid= document.forms[0].hidDemoId.value;
 //var stramtreq = document.forms[0].txtloan_amtreqd.value; 
var stramtreq = document.forms[0].txtloan_sancamt.value; 
var margin = document.forms[0].txtRecLoanValRatio.value; 
var strorgappno= "<%=strappno1%>";
var nooftrms = document.forms[0].txtloan_reqterms.value;
var monthlyemi = eval(document.forms[0].txtmonPay.value);
var loan_filedon=document.forms[0].txtloan_filedon.value;
if(checktrim(document.forms[0].txtmonPay.value)=="")
{
	monthlyemi="0.00";
}
var costofloanprd="<%=Helper.correctNull((String) hshValues
							.get("costPrdCharges"))%>";
var repaymenttype= document.forms[0].hidrepayment.value;
if(strprdid == "")
{
	alert("Select Product");
	return false;
}
if(appid == "")
{
	alert("Select Applicant Name");
	return false;
}
if(stramtreq == "")
{
	alert("Enter Requested Amount");
	return false;
}
if(nooftrms == "")
{
	alert("Enter Term");
	return false;
}
if(repaymenttype=="1")
{
	if(checktrim(document.forms[0].txtmonPay.value) == "")
	{
		alert("Calculate EMI");
		return false;
	}
}
if(selecttype=="V")
{

if(checkvehappentry=="")
		{
			alert("Ensure to EDIT/APPLY in Borrower Assest ->Vehicle Page");
			return false;
		}
}

var selectpurpose=document.forms[0].selectpurpose.value;
window.open(appURL+"action/perlimitofloan.jsp?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
		    "&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&hidAppStatus="+hidAppStatus,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
		
}

function getmarginamount()
{
if(document.forms[0].txtRecLoanValRatio.value != "")
	{
  var amt =parseInt((parseFloat(document.forms[0].txtRecLoanValRatio.value)/100) * (parseFloat(document.forms[0].txtloan_costloanprd.value)))
	document.forms[0]. txtloan_recmdamt.value =amt
	}
  else
	{
		document.forms[0]. txtloan_recmdamt.value = 0
	}
}

function showinttype()
{
	var strinttype="<%=Helper.correctNull((String) hshValues
									.get("loaninttype"))%>";
	if(strinttype!="")
	{
		
			document.forms[0].selectinttype1.value=strinttype;
	}
}

function checkbutton()
{
        //document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
	
}

function checkvehiletype()
{
	var auto_price_type = '<%=Helper.correctNull((String) hshValues
							.get("auto_price_type"))%>';
	var lscheme=document.forms[0].selectpurpose.value;
	var ltype=document.forms[0].selecttype.value;

	if(ltype=="V")
	{
		if(auto_price_type==1)
			{
		alert("Select Loan scheme as Two Wheeler");
		}
		else if(auto_price_type==2)
		{
		alert("Select Loan scheme as Four Wheeler");
		}
    } 

}

function checkmahila()
{
   var mahila=document.forms[0].selectpurpose.value;
   var ltype=document.forms[0].selecttype.value;
   if(ltype=="C")
	{
		//if(mahila==10 || mahila==11)
		if(mahila==8)
		{
		
		document.all.hidecmdmortgage.style.visibility="visible";
		document.all.cmdmortgage.style.visibility="visible";
		document.all.hidecmdclick.style.visibility="hidden";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="visible";
		document.all.r1main.style.visibility="hidden";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
		document.all.cmdsyndsenior.style.visibility="hidden";
		
		}
		else if(mahila==2)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.hidecmdclick.style.visibility="hidden";
		document.all.hidecmdmahila.style.visibility="visible";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		document.all.r1main.style.visibility="hidden";
		document.all.r1mahila.style.visibility="visible";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
		
		/*document.all.r1main.style.visibility="hidden";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";*/
		
		}
		else if(mahila==5)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
	    document.all.hidecmdclick.style.visibility="hidden";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="visible";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		document.all.r1mortgage.style.visibility="hidden";
		document.all.r1main.style.visibility="hidden";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="visible";
	//	document.all.r1syndvidya.style.visibility="hidden";
		document.all.cmdsyndsenior.style.visibility="visible";
		
		
		}
		else if(mahila==6 || mahila==7 ||mahila==12 || mahila==13 ||mahila==14 || mahila==15 || mahila==16 || mahila==17 || mahila==18 || mahila==19 || mahila==20 || mahila==21 || mahila==22 || mahila==23 || mahila==24 || mahila==25 || mahila==26)
		{
				
			document.all.hidecmdmortgage.style.visibility="hidden";
			document.all.hidecmdclick.style.visibility="hidden";
			document.all.hidecmdmahila.style.visibility="hidden";
			document.all.hidecmdsyndsenior.style.visibility="hidden";
			document.all.hidecmdsyndvidya.style.visibility="visible";
			
			document.all.r1mortgage.style.visibility="hidden";
			document.all.r1main.style.visibility="hidden";
			document.all.r1mahila.style.visibility="hidden";
			document.all.r1syndsenior.style.visibility="hidden";
	//		document.all.r1syndvidya.style.visibility="visible";
			
						
			}
		else if(mahila==1 ||mahila==11)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
		}
		else if(mahila==3)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
		}
		else if(mahila==4)
		{
	
		document.all.hidecmdmortgage.style.visibility="hidden";
		//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
		}
		/*else if(mahila==5)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
		document.all.r1syndvidya.style.visibility="hidden";
		}	
		else if(mahila==6)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
		document.all.r1syndvidya.style.visibility="hidden";
		}	*/
	}
	else if(ltype=="H")
	{
		document.all.hidecmdmortgage.style.visibility="hidden";
    	//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
	}
	else if(ltype=="V")
	{
		document.all.hidecmdmortgage.style.visibility="hidden";
		//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		//document.all.cmdmortgage.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
	//	document.all.r1syndvidya.style.visibility="hidden";
	}	
	if(checkappnonew=="new")
	{//alert(checkappnonew);
		var hidecheck= "<%=strappno1%>";
		//alert(hidecheck);
		if(hidecheck=="")
		{
		document.all.r1main.style.visibility="hidden";
		document.all.cmdClick.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		
		document.all.r1mahila.style.visibility="hidden";
		document.all.cmdmahila.style.visibility="hidden";
		
		document.all.r1syndsenior.style.visibility="hidden";
		document.all.cmdsyndsenior.style.visibility="hidden";
		
	//	document.all.r1syndvidya.style.visibility="hidden";
		document.all.cmdsyndvidya.style.visibility="hidden";
		}
	}
	//Commented to enable the chekeligibility buttons after approved/rejected
	/*if(document.forms[0].cmdedit.disabled==true)
	{
		document.all.r1main.style.visibility="hidden";
		document.all.cmdClick.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		
		document.all.r1mahila.style.visibility="hidden";
		document.all.cmdmahila.style.visibility="hidden";
		
		document.all.r1syndsenior.style.visibility="hidden";
		document.all.cmdsyndsenior.style.visibility="hidden";
		
		document.all.r1syndvidya.style.visibility="hidden";
		document.all.cmdsyndvidya.style.visibility="hidden";
		
		document.all.amort1.style.visibility="hidden";
		document.all.amort.style.visibility="hidden";
	}*/
}
/*function checkdisable()
{
		document.all.r1main.style.visibility="hidden";
		document.all.cmdClick.style.visibility="hidden";
		
		document.all.r1mortgage.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		
		document.all.r1mahila.style.visibility="hidden";
		document.all.cmdmahila.style.visibility="hidden";
		
		document.all.r1syndsenior.style.visibility="hidden";
		document.all.cmdsyndsenior.style.visibility="hidden";
		
		document.all.r1syndvidya.style.visibility="hidden";
		document.all.cmdsyndvidya.style.visibility="hidden";
}*/

function callOnLoad()
{
	//added on 31-12-2020 to hide Pre-sanction Check List for Education Loan Section Ends
	document.forms[0].hidchkNewInterestRate.value = chkNewInterestRate;
	//var varfromROInbox =" ";
	var ltype=document.forms[0].selecttype.value;

	var lscheme=document.forms[0].selectpurpose.value;
	
	var newflag="<%=newflag%>";
	if (newflag=="Y")
	{
		document.all.amort2.style.visibility="hidden";
		//document.all.amort2.style.position="absolute";
	//	document.all.amort1.style.visibility="hidden";
		//document.all.amort1.style.position="absolute";
	}
	else{
	    document.all.amort2.style.visibility="visible";
	//	document.all.amort2.style.position="absolute";
	//	document.all.amort1.style.visibility="visible";
	//	document.all.amort1.style.position="absolute";
	}
	var prdcode = document.forms[0].shanshidProductID.value;
	if(checkappnonew=="new")
	{

	    	    //cmdClick
			document.all.hidecmdclick.style.visibility="hidden";
			//document.all.cmdClick.style.visibility="hidden";
			document.all.r1main.style.visibility="hidden";
		
		
			//cmdmahila	
			document.all.hidecmdmahila.style.visibility="hidden";
			//document.all.cmdmahila.style.visibility="hidden";
			document.all.r1mahila.style.visibility="hidden";
			//cmdsyndsenior
			document.all.cmdsyndsenior.style.visibility="hidden";
			//document.all.hidecmdsyndsenior.style.visibility="hidden";
			document.all.r1syndsenior.style.visibility="hidden";
			//cmdsyndvidya
			document.all.cmdsyndvidya.style.visibility="hidden";
			//document.all.hidecmdsyndvidya.style.visibility="hidden";
			//document.all.r1syndvidya.style.visibility="hidden";
			//cmdmortgage
			document.all.cmdmortgage.style.visibility="hidden";
			document.all.r1mortgage.style.visibility="hidden";

	    	 if(prdcode=="973" || prdcode=="974" || prdcode=="975" || prdcode=="935")
	    	 {
	    		document.all.id_1bank.style.visibility="hidden";
	 	    	document.all.id_1bank.style.position="absolute";
	 	    	document.all.id_2bank.style.visibility="hidden";
	 	    	document.all.id_2bank.style.position="absolute";
	 	    	document.all.id_3bank.style.visibility="hidden";
	 	    	document.all.id_3bank.style.position="absolute";
	    	  
	   	     }
	    	 else
	    	 {
	    		   document.all.id_1bank.style.visibility="visible";
		    	   document.all.id_1bank.style.position="relative";
		    	   document.all.id_2bank.style.visibility="visible";
		    	   document.all.id_2bank.style.position="relative";
		    	   document.all.id_3bank.style.visibility="visible";
		    	   document.all.id_3bank.style.position="relative";
	    	 }
			
	}
	else
	{
		//document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		//document.all.cmdClick.style.visibility="hidden";
		
		//document.all.r1main.style.visibility="visible";
		document.all.r1mahila.style.visibility="hidden";
		document.all.r1syndsenior.style.visibility="hidden";
   // 	document.all.r1syndvidya.style.visibility="hidden";
    	document.all.r1mortgage.style.visibility="hidden";


    	 if(prdcode=="973" || prdcode=="974" || prdcode=="975" ||  prdcode=="935")
    	 {
    	   document.all.id_1bank.style.visibility="visible";
    	   document.all.id_1bank.style.position="relative";
    	   document.all.id_2bank.style.visibility="visible";
    	   document.all.id_2bank.style.position="relative";
    	   document.all.id_3bank.style.visibility="visible";
    	   document.all.id_3bank.style.position="relative";
   	     }
    	 else
    	 {
    	   document.all.id_1bank.style.visibility="hidden";
    	   document.all.id_1bank.style.position="absolute";
    	   document.all.id_2bank.style.visibility="hidden";
    	   document.all.id_2bank.style.position="absolute";
    	   document.all.id_3bank.style.visibility="hidden";
    	   document.all.id_3bank.style.position="absolute";
    	 }
	}
	
	var appno="<%=Helper.correctNull((String) request
									.getParameter("appno"))%>";
	
		if(strappeditsameregbranch!="")
		{
			if(strappeditsameregbranch=="disablefalse")
			{
				callDisableControls(false,true,true,true,false);
			}
			else if(strappeditsameregbranch=="disabletrue")
			{
				callDisableControls(true,true,true,true,false);
			}	
		}
//	}

if (selecttype != "")
	{
		document.forms[0].selecttype.value = selecttype;
	}
if (selectpurpose != "")
	{
		if (selecttype=="H")
		{	
			document.forms[0].selectpurpose.length =8;
			document.forms[0].selectpurpose.options[0].text= '---- Select ----';
			document.forms[0].selectpurpose.options[0].value= '0';
			document.forms[0].selectpurpose.options[1].text= 'Purchase of plot and Construction of house';
			document.forms[0].selectpurpose.options[1].value= "1";
			document.forms[0].selectpurpose.options[2].text= 'Construction of house on the plot already owned';
			document.forms[0].selectpurpose.options[2].value= '2';
			document.forms[0].selectpurpose.options[3].text= 'Outright purchase of ready built house';
			document.forms[0].selectpurpose.options[3].value= '3';
			document.forms[0].selectpurpose.options[4].text= 'Purchase of flat to be constructed by Society/Builder';
			document.forms[0].selectpurpose.options[4].value= '4';
			document.forms[0].selectpurpose.options[5].text= 'For making additions to the existing house';
			document.forms[0].selectpurpose.options[5].value= '5';
			document.forms[0].selectpurpose.options[6].text= 'For repairs/renovation to existing house';
			document.forms[0].selectpurpose.options[6].value= '6';
			document.forms[0].selectpurpose.options[7].text= 'SyndNivas Plus';
			document.forms[0].selectpurpose.options[7].value= '7';
			//document.forms[0].selectpurpose.options[8].text= 'Others (specify)';
			//document.forms[0].selectpurpose.options[8].value= '8';
		
			document.forms[0].selectpurpose.value= selectpurpose;
		}
		else if(selecttype=="V")
		{
		document.forms[0].selectpurpose.length =4;
		document.forms[0].selectpurpose.options[0].text= '---- Select ----';
		document.forms[0].selectpurpose.options[0].value= '0';
		document.forms[0].selectpurpose.options[1].text= 'Four Wheeler-New';
		document.forms[0].selectpurpose.options[1].value= '1';
		document.forms[0].selectpurpose.options[2].text= 'Two Wheeler-New';
		document.forms[0].selectpurpose.options[2].value= '2';
		document.forms[0].selectpurpose.options[3].text= 'Four Wheeler-Used';
		document.forms[0].selectpurpose.options[3].value= '3';
		document.forms[0].selectpurpose.value= selectpurpose;
		}
		else if(selecttype=="C")
	{	
		if(varstrnewscheme == "Y")
		{
	    	 if(prdcode=="947")	{
				document.forms[0].selectpurpose.length =2;
				document.forms[0].selectpurpose.options[0].text= '---- Select ----';
				document.forms[0].selectpurpose.options[0].value= '0';
				document.forms[0].selectpurpose.options[1].text= 'OSL-EDU LOAN VIDYA SAGAR-DOMESTIC';
				document.forms[0].selectpurpose.options[1].value= '20';		
			 }else if(prdcode=="651"){
	    		 document.forms[0].selectpurpose.length =8;
	    	     document.forms[0].selectpurpose.options[0].text= '---- Select ----';
	    		 document.forms[0].selectpurpose.options[0].value= '0';
	    		 document.forms[0].selectpurpose.options[1].text= 'EDUCATION LOAN - VIDYA SAGAR - DOMESTIC';
	    		 document.forms[0].selectpurpose.options[1].value= '20';
	    		 document.forms[0].selectpurpose.options[2].text= 'EDUCATION LOAN - VIDYA TURANT - ISB';
	    		 document.forms[0].selectpurpose.options[2].value= '21';
	    		 document.forms[0].selectpurpose.options[3].text= 'EDUCATION LOAN - VIDYA TURANT - IIM';
	    		 document.forms[0].selectpurpose.options[3].value= '22';
	    		 document.forms[0].selectpurpose.options[4].text= 'EDUCATION LOAN - VIDYA TURANT - OTHERS';
	    		 document.forms[0].selectpurpose.options[4].value= '23';
	    		 document.forms[0].selectpurpose.options[5].text= 'EDUCATION LOAN - VIDYA SHAKTHI';
	    		 document.forms[0].selectpurpose.options[5].value= '24';
	    		 document.forms[0].selectpurpose.options[6].text= 'EDUCATION LOAN - VIDYA SAHAY';
	    		 document.forms[0].selectpurpose.options[6].value= '25';
	    		 document.forms[0].selectpurpose.options[7].text= 'EDUCATION LOAN - VIDYA SAGAR - ABROAD';
	    		 document.forms[0].selectpurpose.options[7].value= '26';		    			
	    	 }else if(prdcode=="654"){
	    		 document.forms[0].selectpurpose.length =2;
	    	     document.forms[0].selectpurpose.options[0].text= '---- Select ----';
	    		 document.forms[0].selectpurpose.options[0].value= '0';
	    		 document.forms[0].selectpurpose.options[1].text= 'EL - DRI  LOAN SCHEME';
	    		 document.forms[0].selectpurpose.options[1].value= '20';			    			
	    	 }else if(prdcode=="655"){
	    		 document.forms[0].selectpurpose.length =2;
	    	     document.forms[0].selectpurpose.options[0].text= '---- Select ----';
	    		 document.forms[0].selectpurpose.options[0].value= '0';
	    		 document.forms[0].selectpurpose.options[1].text= 'VOCATIONAL EDUCATION LOAN - MODEL SCHEME';
	    		 document.forms[0].selectpurpose.options[1].value= '20';			    			
	    	 }else if(prdcode=="948"){
	    		 document.forms[0].selectpurpose.length =2;
	    	     document.forms[0].selectpurpose.options[0].text= '---- Select ----';
	    		 document.forms[0].selectpurpose.options[0].value= '0';
	    		 document.forms[0].selectpurpose.options[1].text= 'OSL-EDU LOAN VIDYA SAGAR-ABROAD';
	    		 document.forms[0].selectpurpose.options[1].value= '20';			    			
	    	 }
	    	 else if(prdcode=="949"){
	    		 document.forms[0].selectpurpose.length =8;
	    	     document.forms[0].selectpurpose.options[0].text= '---- Select ----';
	    		 document.forms[0].selectpurpose.options[0].value= '0';
	    		 document.forms[0].selectpurpose.options[1].text= 'DL-EDU LOAN VIDYA SAGAR-DOMESTIC';
    			 document.forms[0].selectpurpose.options[1].value= '20';
    			 document.forms[0].selectpurpose.options[2].text= 'DL-EDU LOAN VIDYA TURANT-ISB';
    			 document.forms[0].selectpurpose.options[2].value= '21';
    			 document.forms[0].selectpurpose.options[3].text= 'DL-EDU LOAN VIDYA TURANT-IIM';
    			 document.forms[0].selectpurpose.options[3].value= '22';		
    			 document.forms[0].selectpurpose.options[4].text= 'DL-EDU LOAN VIDYA TURANT-OTHERS';
    			 document.forms[0].selectpurpose.options[4].value= '23';				
    			 document.forms[0].selectpurpose.options[5].text= 'DL-EDU LOAN VIDYA SHAKTHI';
    			 document.forms[0].selectpurpose.options[5].value= '24';				
    			 document.forms[0].selectpurpose.options[6].text= 'DL-EDU LOAN VIDYA SAHAY';
    			 document.forms[0].selectpurpose.options[6].value= '25';	
    			 document.forms[0].selectpurpose.options[7].text= 'DL-EDU LOAN VIDYA SAGAR-DOM-IBA SKILL LOAN';
    			 document.forms[0].selectpurpose.options[7].value= '26';
    				
	    	 }
	    	 else if(prdcode=="950"){
	    		 document.forms[0].selectpurpose.length =2;
	    		 document.forms[0].selectpurpose.options[0].text= '---- Select ----';
	    		 document.forms[0].selectpurpose.options[0].value= '0';
	    		 document.forms[0].selectpurpose.options[1].text= 'DL-EDU LOAN VIDYA SAGAR-ABROAD';
	 		     document.forms[0].selectpurpose.options[1].value= '20';		
	    	 }
		}
		else
		{
			document.forms[0].selectpurpose.length =20;
			document.forms[0].selectpurpose.options[0].text= '---- Select ----';
			document.forms[0].selectpurpose.options[0].value= '0';
			document.forms[0].selectpurpose.options[1].text= 'SYND SARAL-DL-SALARIED';
			document.forms[0].selectpurpose.options[1].value= '1';
			
			document.forms[0].selectpurpose.options[11].text= 'SYND SARAL-DL-NON-SALARIED';
			document.forms[0].selectpurpose.options[11].value= '11';
			
			document.forms[0].selectpurpose.options[2].text= 'SYND MAHILA';
			document.forms[0].selectpurpose.options[2].value= '2';
			document.forms[0].selectpurpose.options[3].text= 'SYND SARAL-OSL';
			document.forms[0].selectpurpose.options[3].value= '3';
			document.forms[0].selectpurpose.options[4].text= 'SYND SUVIDHA';
			document.forms[0].selectpurpose.options[4].value= '4';
			//document.forms[0].selectpurpose.options[5].text= 'SYND KISAN-DL';
			//document.forms[0].selectpurpose.options[5].value= '5';
			
			//document.forms[0].selectpurpose.options[6].text= 'SYND KISAN-OSL';
			//document.forms[0].selectpurpose.options[6].value= '6';
			
			document.forms[0].selectpurpose.options[5].text= 'SYND SENIOR';
			document.forms[0].selectpurpose.options[5].value= '5';
			
			document.forms[0].selectpurpose.options[6].text= 'SYND VIDYA-DL-DOMESTIC-no Guarantor';
			document.forms[0].selectpurpose.options[6].value= '6';
			
			
			document.forms[0].selectpurpose.options[12].text= 'SYND VIDYA-DL-ABROAD-no Guarantor';
			document.forms[0].selectpurpose.options[12].value= '12';
			
			document.forms[0].selectpurpose.options[14].text= 'SYND VIDYA-DL-DOMESTIC-Guarantor';
			document.forms[0].selectpurpose.options[14].value= '14';
			
			
			document.forms[0].selectpurpose.options[15].text= 'SYND VIDYA-DL-ABROAD-Guarantor';
			document.forms[0].selectpurpose.options[15].value= '15';
			
			document.forms[0].selectpurpose.options[7].text= 'SYND VIDYA-OSL-DOMESTIC';
			document.forms[0].selectpurpose.options[7].value= '7';
			
			
			
			document.forms[0].selectpurpose.options[13].text= 'SYND VIDYA-OSL-ABROAD';
			document.forms[0].selectpurpose.options[13].value= '13';
			
			document.forms[0].selectpurpose.options[8].text= 'SYND LAGHUUDYAMI';
			document.forms[0].selectpurpose.options[8].value= '8';
			
			//document.forms[0].selectpurpose.options[11].text= 'SYND MORTGAGE';
			//document.forms[0].selectpurpose.options[11].value= '11';
			
			document.forms[0].selectpurpose.options[9].text= 'SYND VYAPAR';
			document.forms[0].selectpurpose.options[9].value= '9';
			
			document.forms[0].selectpurpose.options[10].text= 'SYND PIGMY';
			document.forms[0].selectpurpose.options[10].value= '10';
			
			document.forms[0].selectpurpose.options[16].text= 'SYND SUPER VIDYA-DL-DOMESTIC < 4 LACS';
			document.forms[0].selectpurpose.options[16].value= '16';

			document.forms[0].selectpurpose.options[17].text= 'SYND SUPER VIDYA-DL-DOMESTIC > 4 LACS';
			document.forms[0].selectpurpose.options[17].value= '17';
			
			document.forms[0].selectpurpose.options[18].text= 'SYND SUPER VIDYA-DL-ABROAD < 4 LACS';
			document.forms[0].selectpurpose.options[18].value= '18';

			document.forms[0].selectpurpose.options[19].text= 'SYND SUPER VIDYA-DL-ABROAD > 4 LACS';
			document.forms[0].selectpurpose.options[19].value= '19';
								
		}	
		document.forms[0].selectpurpose.value= selectpurpose;
		//document.all.sel1.style.visibility="hidden";
		//document.all.sel2.style.visibility="hidden";
	}
		


	}

//	if (document.forms[0].appstatus.value != "Open/Pending" || document.forms[0].appstatus.value != "")
//	{
//		if(
//		 callDisableControls(true);
//	}
	if( varstrCBSMigval !="1"){
	document.forms[0].interestservised.selectedindex=3;
	}
	document.forms[0].txtRecLoanValRatio.readOnly=false;
		//document.forms[0].txtaltermonpay.readOnly=false;
		document.forms[0].txtmonPay.readOnly=false;
	var installment = '<%=Helper.correctNull((String) hshValues
							.get("loan_periodicity"))%>';
	if (installment != "")
	{
		document.forms[0].sel_peridicity.value = installment;
	}
	else 
	{
		document.forms[0].sel_peridicity.value = "m";
	}
	
	var servised = '<%=Helper.correctNull((String) hshValues
							.get("loan_servised"))%>';

	if(document.forms[0].txt_installments.value!=1)
	{
	if (servised != "")
	{
		document.forms[0].interestservised.value = servised;
	}
	else 
	{
		document.forms[0].interestservised.value = "s";
		document.forms[0].txtmonPay.value="0.00";
	}
	}
	else
	{
		if( varstrCBSMigval !="1"){
			document.forms[0].interestservised.value = "n";	
			document.forms[0].interestservised.disabled=true;
			}
			else
			{
				if (servised != "")
				{
					document.forms[0].interestservised.value = servised;
				}
				else 
				{
					document.forms[0].interestservised.value = "s";
				}
			}
	}
	
    if(HouseLoan != "")
    {
    	document.forms[0].sel_house.value = HouseLoan;  
    }
    else
    {
    	document.forms[0].sel_house.value = "s";
    }

    if(EDU_STUDINGIN != "")
    {
    	document.forms[0].sel_StudyRegion.value = EDU_STUDINGIN;  
    }
    else
    {
    	document.forms[0].sel_StudyRegion.value = "S";
    }
    if(EDU_COURSETYPE != "")
    {
    	document.forms[0].sel_CourType.value = EDU_COURSETYPE;  
    }
    else
    {
    	document.forms[0].sel_CourType.value = "S";
    }
    if(LOAN_AVAILING_FOR_SEM != "")
    {
    	document.forms[0].sel_LoanAvail_ForSem.value = LOAN_AVAILING_FOR_SEM;  
    }
    else
    {
    	document.forms[0].sel_LoanAvail_ForSem.value = "S";
    }
	document.forms[0].txt_CourDuration.readOnly = false;
	if(EDU_STUDINGIN == "A"){
		document.all.id_course.style.display="none";
		document.all.id_course1.style.display="";
		document.forms[0].txt_Course.readOnly = false;
    }else{
    	document.all.id_course.style.display="";
    	document.all.id_course1.style.display="none";
    }
	if(EDU_STUDINGIN == "D"){
	<%int s = 0;%>
		document.forms[0].sel_Course.options[<%=s%>].value="S";
		document.forms[0].sel_Course.options[<%=s%>].text="---Select---";
		<%if (vecRowCourse != null) {
				int vecsizeindex = vecRowCourse.size();
				int length = vecsizeindex + 1;
				s++;%>
			document.forms[0].sel_Course.length=<%=length%>;
		<%for (int l = 0; l < vecsizeindex; l++) {
					vecRowCourse1 = (Vector) vecRowCourse.elementAt(l);%>
				document.forms[0].sel_Course.options[<%=s%>].value="<%=Helper.correctNull((String) vecRowCourse1
									.elementAt(0))%>";
				document.forms[0].sel_Course.options[<%=s%>].text="<%=Helper.correctNull((String) vecRowCourse1
									.elementAt(1))%>";

				if(COURSE_DAY0 == document.forms[0].sel_Course.options[<%=s%>].value)
				{
					document.forms[0].sel_Course.options[<%=s%>].selected=true;
				}
				
		<%s++;
				}
			}%>	
	}
	if(LOAN_DRAWDOWN!="")
	{
		document.forms[0].sel_drawdown.value=LOAN_DRAWDOWN;
	}else{
		document.forms[0].sel_drawdown.value="s";
	}
	drawdown();
	if(document.forms[0].appno.value=="new" || document.forms[0].appno.value=="")
	{
	
	document.forms[0].cmdClick.disabled=true;
	}
	else
	{
	document.forms[0].cmdClick.disabled=false;
	}
	var page=document.forms[0].page.value;
	var varedit=document.forms[0].hidEditMode.value;
	if(varedit=="D")
	{	document.forms[0].action=appURL+"action/perexisting.jsp";	
		document.forms[0].submit();
	}
	
	if(page.toUpperCase()=="NR" &&  varedit.toUpperCase()!="E")
	{	
		document.forms[0].hidEditMode.value="E";
		document.forms[0].trapEdit.value=="TE";
		if(document.forms[0].cmdedit.disabled)
		{	
			callDisableControls(true,true,true,true,false);
		}
		else
		{
			callDisableControls(true,false,true,true,false);
			//document.forms[0].cmdaudit.disabled = true; //mck
			
		}
		callEnableFields(true);

		document.forms[0].txtloan_emidate.readOnly=false;
		document.forms[0].txtloan_sancno.readOnly=false;
		document.forms[0].txtloan_lapsprocfee.readOnly=false;

		document.forms[0].txtloan_amtreqd.readOnly=false;
		document.forms[0].txtloan_purposeofloan.readOnly=false;
		document.forms[0].txtloan_filedon.readOnly=false;
		document.forms[0].txtloan_costloanprd.readOnly=false;
		document.forms[0].txtloan_tradein.readOnly=false;
		document.forms[0].txtloan_loantrade.readOnly=false;
//		document.forms[0].txtloan_reqterms.readOnly=false; //populate based on txt_noofinstallments
		document.forms[0].txt_agnt_perloan.readOnly=false;
		document.forms[0].txtloan_sancamt.readOnly=false;
		document.forms[0].txtloan_modintrate.readOnly=false;
		//document.forms[0].sel_secured.disabled=true;
	//	document.forms[0].txtloan_docfee.readOnly=false;
//		document.forms[0].txtloan_recmdamt.readOnly=false;
	document.forms[0].txtRecLoanValRatio.readOnly=false;
	//document.forms[0].txtaltermonpay.readOnly=false;
	 document.forms[0].txtmonPay.readOnly=false;
//////////////////
		//document.forms[0].txt_installments.readOnly=false;//populate based on txt_noofinstallments
		document.forms[0].txt_secured.readOnly=false;
				
		if(document.forms[0].txtprd_desc.value=="---")
		{
		document.forms[0].txtprd_desc.value="";
		}
		
		document.forms[0].txt_firstbank.readOnly=false;
		document.forms[0].txt_secondbank.readOnly=false;
		document.forms[0].txt_noofinstallments.readOnly = false;
	}
	
	else
	{
			if(varedit.toUpperCase()=="E")
			{
			if(document.forms[0].cmdedit.disabled)
			{
				callDisableControls(true,true,true,true,false);
			}
			else
			{ callDisableControls(true,false,false,false,true);
			}
			callEnableFields(true);
			var lock="<%=Helper.correctNull((String) hshValues
									.get("hidEditLock"))%>";

			document.forms[0].txtloan_emidate.readOnly=false;
			document.forms[0].txtloan_sancno.readOnly=false;
			document.forms[0].txtloan_lapsprocfee.readOnly=false;

			document.forms[0].txtloan_amtreqd.readOnly=false;
			document.forms[0].txtloan_purposeofloan.readOnly=false;	
			document.forms[0].txtloan_filedon.readOnly=false;
			document.forms[0].txtloan_costloanprd.readOnly=false;
			document.forms[0].txtloan_tradein.readOnly=false;
			document.forms[0].txtloan_loantrade.readOnly=false;
		//	document.forms[0].selectinttype.readOnly=false;
			document.forms[0].int_type.readOnly=false;
			//document.forms[0].selrepaymenttype.readOnly=false;
			document.forms[0].txtloan_sancamt.readOnly=false;
		//	document.forms[0].txtloan_reqterms.readOnly=false;//populate based on txt_noofinstallments
			document.forms[0].txt_agnt_perloan.readOnly=false;
////////////////////////////
		//	document.forms[0].txt_installments.readOnly=false;//populate based on txt_noofinstallments
			document.forms[0].txt_secured.readOnly=false;
			document.forms[0].txt_noofinstallments.readOnly = false;
			
			if(lock.toUpperCase()=="N")//
			{
				ShowAlert("140");
				callDisableControls(false,true,true,true,false);
				callEnableFields(true);
			}
//			if(parseInt(strUsrClass) != parseInt(varstrclass)){
			document.forms[0].txtloan_modintrate.readOnly=false;
//			document.forms[0].	txtloan_docfee.readOnly=false;
//			document.forms[0].txtloan_recmdamt.readOnly=false;
			document.forms[0].txtRecLoanValRatio.readOnly=false;
			//document.forms[0].txtaltermonpay.readOnly=false;
			document.forms[0].txtmonPay.readOnly=false;
	

//			}
//			else
//			{document.forms[0].txtloan_modintrate.readOnly=true;
//			}
			document.forms[0].txtloan_amtreqd.focus();	
			document.forms[0].txt_firstbank.readOnly=false;
			document.forms[0].txt_secondbank.readOnly=false;	

			if(varMORTFLAG == "Y")
			{
           	   	document.forms[0].interestservised.value="n";
          		document.forms[0].interestservised.disabled=true;
          		document.forms[0].txt_schedutype.disabled=true;
          		document.forms[0].txt_ratechatcode.disabled=true;
			}
			if(EDU_STUDINGIN == "A"){
				document.forms[0].txt_Course.readOnly = false;
				document.forms[0].txt_CourDuration.readOnly = false;
		    }else{
		    	document.forms[0].sel_Course.readOnly = false;
		    }	
		}
		else
		{	
			if(document.forms[0].cmdedit.disabled)
			{callDisableControls(true,true,true,true,false);
			}
			else
			{	callDisableControls(false,true,true,true,false);				
			}
			//
			callEnableFields(true);

			document.forms[0].txtloan_emidate.readOnly=true;
			document.forms[0].txtloan_sancno.readOnly=true;
			document.forms[0].txtloan_lapsprocfee.readOnly=true;

			document.forms[0].txtloan_amtreqd.readOnly=true;
			document.forms[0].txtloan_costloanprd.readOnly=true;
			document.forms[0].txtloan_tradein.readOnly=true;
			document.forms[0].txtloan_loantrade.readOnly=true;
		//	document.forms[0].txtloan_modintrate.readOnly=true;
			document.forms[0].txtloan_reqterms.readOnly=true;
			document.forms[0].txt_agnt_perloan.readOnly=true;
	//		document.forms[0].selectinttype.disabled = true;
			document.forms[0].int_type.disabled = false;
			document.forms[0].selrepaymenttype.disabled = true;
			document.forms[0].txtloan_sancamt.readOnly=true;
/////////////////////////////////////////////////////
			document.forms[0].sel_peridicity.disabled = true;
			document.forms[0].selecttype.disabled = true;
			if(varstrCBSMigval =="1"){
			document.forms[0].txt_custrelation.disabled=false;
			document.forms[0].txt_schedutype.disabled=true;
			document.forms[0].txt_ratechatcode.disabled=true;
			document.forms[0].sel_datebasis.disabled=true;
			}
			
			document.forms[0].selectpurpose.disabled = true;
			
			document.forms[0].interestservised.disabled = true;
			document.forms[0].selectinttype1.disabled=true;

			document.forms[0].sel_house.disabled=true;

			document.forms[0].sel_pmayscheme.disabled=true; 
		}
	}
		if(varstrCBSMigval =="1"){
			if(varrelation !="")
			{
				document.forms[0].txt_custrelation.value=varrelation;
			}
			else
			{
				document.forms[0].txt_custrelation.value="s";
			}
			//Schedule AND Ratechart
		 	<%int k = 0, j = 0;%>
			document.forms[0].txt_schedutype.options[<%=k%>].value="s";
			document.forms[0].txt_schedutype.options[<%=k%>].text="---Select---";
			document.forms[0].txt_ratechatcode.options[<%=k%>].value="s";
			document.forms[0].txt_ratechatcode.options[<%=k%>].text="---Select---";
		 	<%if (v != null) {
				int vecsize = v.size();
				int length = vecsize + 1;
				k++;%>
				document.forms[0].txt_schedutype.length=<%=length%>;
			<%for (int l = 0; l < vecsize; l++) {
					g = (Vector) v.elementAt(l);%>
					document.forms[0].txt_schedutype.options[<%=k%>].value="<%=Helper.correctNull((String) g.elementAt(0))%>";
					document.forms[0].txt_schedutype.options[<%=k%>].text="<%=Helper.correctNull((String) g.elementAt(0))%>--<%=Helper.correctNull((String) g.elementAt(1))%>-<%=Helper.correctNull((String) g.elementAt(2))%>";

					if(varschedType == document.forms[0].txt_schedutype.options[<%=k%>].value)
					{
						document.forms[0].txt_schedutype.options[<%=k%>].selected=true;
						varschedText=document.forms[0].txt_schedutype.options[<%=k%>].text;
					}
					
			<%k++;
				}
			}%>
			<%if (vc != null) {
				int vecsize = vc.size();
				int length = vecsize + 1;
				j++;%>
				document.forms[0].txt_ratechatcode.length=<%=length%>;
			<%for (int l = 0; l < vecsize; l++) {
					vc1 = (Vector) vc.elementAt(l);%>
					document.forms[0].txt_ratechatcode.options[<%=j%>].value="<%=Helper.correctNull((String) vc1.elementAt(1))%>";
					document.forms[0].txt_ratechatcode.options[<%=j%>].text="<%=Helper.correctNull((String) vc1.elementAt(0))%>";
					
					if(varRateChat == document.forms[0].txt_ratechatcode.options[<%=j%>].value)
					{
						document.forms[0].txt_ratechatcode.options[<%=j%>].selected=true;
					}
					
			<%j++;
				}
			}%>
		    
			if(vardatebasis !="")
			{
				document.forms[0].sel_datebasis.value=vardatebasis;
			}
			else
			{
				document.forms[0].sel_datebasis.value="2";
			}
			
			}
	if(varrelation !="")
	{
		document.forms[0].txt_custrelation.value=varrelation;
	}
	else
	{
		document.forms[0].txt_custrelation.value="s";
	}
	document.forms[0].appno.value="<%=Helper.correctNull((String) hshValues.get("appno"))%>";
	//document.forms[0].txtloan_aname.readOnly=true;
	
	document.forms[0].txtprd_desc.readOnly=true;
	document.forms[0].txtnetTradeIn.readOnly=true;

	if(document.forms[0].cmdedit.disabled && varedit.toUpperCase()!="E" && page.toUpperCase()!="NR" ) 
	{
		document.forms[0].txtloan_emidate.readOnly=true;
		document.forms[0].txtloan_sancno.readOnly=true;
		document.forms[0].txtloan_lapsprocfee.readOnly=true;

		document.forms[0].txtloan_amtreqd.readOnly=true;
		document.forms[0].txtloan_costloanprd.readOnly=true;
		document.forms[0].txtloan_tradein.readOnly=true;
		document.forms[0].txtloan_loantrade.readOnly=true;
		document.forms[0].txtloan_reqterms.readOnly=true;
		document.forms[0].txt_agnt_perloan.readOnly=true;
		document.forms[0].txtloan_sancamt.readOnly=true;
	}
	
	if(varempstatus!="")
	{
		if(varempstatus.toUpperCase()=="Y")
		{
			document.all.employertdbtn1.style.visibility="hidden";
		}
		else
		{
			document.all.employertdbtn1.style.visibility="visible";
		}			
	}
	
	//if(document.forms[0].appno.value != "")
	if(appno !="")
	{	if(varIntType != "Stepup")
		{
		callCalculate();
		}
		else
		{
		callStepUpCalculate()
		}
	}

	//if(document.forms[0].appno.value !="")
	if(appno !="")
	{	
		showRepayment();
	}
	if(document.forms[0].cmdapply.disabled == false)
	{	
		//document.forms[0].cmdaudit.disabled = true;
	}

	
	
///////////////////////////
	var secured = '<%=Helper.correctNull((String) hshValues
									.get("loan_secure"))%>';
//	if (secured!="0")
//	{
//	document.forms[0].sel_secured.value = "Unsecured";
//	}
//	else 
//	{
//	document.forms[0].sel_secured.value = "Secured";
//	}

	 if (secured == "p")
	{
			document.all.secure.style.visibility="visible";
			document.all.secure1.style.visibility="visible";
	}
	else
	{
			document.all.secure.style.visibility="hidden";
			document.all.secure1.style.visibility="hidden";
				document.forms[0].txt_secured.value = "";
	}
	 
//////////////////////	
	var varprdrenew = '<%=Helper.correctNull((String) hshValues.get("prd_renew"))%>';
	if(varprdrenew=='y' && document.forms[0].appstatus.value=='Open/Pending')
	{
		alert("The Product is Renewed, Please Change the Product");
	}
	//Script added by rajesh  to disable edit button if the status is not open / pending
	
	if (document.forms[0].hidstatus.value!="")
	{
		 if (document.forms[0].hidstatus.value!="op")
		{	
			 document.forms[0].cmdedit.disabled = true;
		}
	}
	document.forms[0].txtloan_modintrate.readOnly=true;
document.forms[0].txtRecLoanValRatio.readOnly=true;//user should not enter mannually
document.all.docfee.style.visibility="hidden";//this field to be hided
document.all.docfee.style.position="absolute";
	//alert(document.forms[0].selectpurpose.value);
	if(document.forms[0].selectpurpose.value=="16" || document.forms[0].selectpurpose.value=="17" || document.forms[0].selectpurpose.value=="18"
		|| document.forms[0].selectpurpose.value=="19")
	{
		var amnt_req = document.forms[0].txtloan_sancamt.value;
		//alert(amnt_req);
		if(amnt_req>400000 && gurantorcount=="0")
			{
				alert("You Must Give the Guarantor Details in Co-applicant/Guarantor tab...");
				return;
			}
	}

	//if(varstrBranchMigval =="1")
		if(varstrCBSMigval =="1")	
		{
			document.all.schedtype.style.visibility="visible";
	        document.all.schedtype.style.position="relative";
	        document.all.cbsmigfeild.style.visibility="visible";
	        document.all.cbsmigfeild.style.position="relative";
	        document.all.cbsmigfeild1.style.visibility="visible";
	        document.all.cbsmigfeild1.style.position="relative";
	        document.all.cbsmigfeild2.style.visibility="visible";
	        document.all.cbsmigfeild2.style.position="relative";
	        document.all.cbsmigfeild3.style.visibility="visible";
	        document.all.cbsmigfeild3.style.position="relative";
		 	//document.forms[0].txt_fixedterm.readOnly=false;
		 	//document.forms[0].txt_ltvratio.readOnly=false;
		 	document.forms[0].sel_prdid.readOnly=false;
		 	document.forms[0].txtloan_purposeofloan.readOnly=false;
			document.forms[0].date_offerletter.readOnly=false;
			document.forms[0].date_agreementsign.readOnly=false;
		}
		else
		{
			document.all.schedtype.style.visibility="hidden";
	        document.all.schedtype.style.position="absolute";
	        document.all.cbsmigfeild.style.visibility="hidden";
	        document.all.cbsmigfeild.style.position="absolute";
	        document.all.cbsmigfeild1.style.visibility="hidden";
	        document.all.cbsmigfeild1.style.position="absolute";
	        document.all.cbsmigfeild2.style.visibility="hidden";
	        document.all.cbsmigfeild2.style.position="absolute";
	        document.all.cbsmigfeild3.style.visibility="hidden";
	        document.all.cbsmigfeild3.style.position="absolute";
		}

	if(varstrCBSMigval =="1")
	{
	   document.all.cbs_relation.style.visibility="visible";
	   document.all.cbs_relation.style.position="relative";
	   document.all.cbs_relation1.style.visibility="visible";
	   document.all.cbs_relation1.style.position="relative";
	}

	if(prdcode =="975" || prdcode =="935" || prdcode =="985" || prdcode =="940" || prdcode =="651" || prdcode =="654" || prdcode =="655")
	{
		document.all.cbs_relation.style.visibility="visible";
		document.all.cbs_relation.style.position="relative";
		document.all.cbs_relation1.style.visibility="visible";
		document.all.cbs_relation1.style.position="relative";
	}
	else
	{
		document.all.cbs_relation.style.visibility="hidden";
		document.all.cbs_relation.style.position="absolute";
		document.all.cbs_relation1.style.visibility="hidden";
		document.all.cbs_relation1.style.position="absolute";
	}
	document.forms[0].sel_PSB59.disabled=false;
	document.forms[0].txt_PSB59refno.disabled = false;
	if(LOAN_PSB59 !="")
	{
	document.forms[0].sel_PSB59.value=LOAN_PSB59;
    }
	else
	{
    document.forms[0].sel_PSB59.value="2";
    }
	if(LOAN_PSB59_REFNO !="")
	{
	document.forms[0].txt_PSB59refno.value=LOAN_PSB59_REFNO;
    }
	else
	{
    document.forms[0].txt_PSB59refno.value="s";
    }
	callPSB59();
	
	document.forms[0].txt_agnt_perloan.readonly=true;
	if(varCanaraSyndBank == "C")
	{
	if(secured !="")
	{
	document.forms[0].sel_secured.value=secured;
    }
	else
	{
    document.forms[0].sel_secured.value="y";
    }
    if(LOAN_SANCTION_AUTHORITY!=""){
    	document.forms[0].sel_sancauth.value=LOAN_SANCTION_AUTHORITY;
    }
    else
    {
    	document.forms[0].sel_sancauth.value="S";
    }
	}
	//disableFields(true);
	<%if (!Helper.correctNull((String) hshValues.get("prdcode"))
					.equalsIgnoreCase("")) {%>
<%if ((Status.equalsIgnoreCase("op"))
						&& (Helper.correctNull((String) session
								.getAttribute("strOrgLevel"))
								.equalsIgnoreCase("A"))
						&& (!Helper.correctNull(
								(String) hshValues.get("spcbranchk"))
								.equalsIgnoreCase("Y"))
						&& (!strsentspcchk.equalsIgnoreCase("y"))) {%>

		document.all.sendspc.style.visibility="visible"; 
		document.all.sendspc.style.position="relative";
		document.forms[0].cmdSendcpc.disabled=false;
		<%}%>
<%if ((Status.equalsIgnoreCase("op"))
						&& (Helper.correctNull((String) session
								.getAttribute("strOrgLevel"))
								.equalsIgnoreCase("A"))
						&& (!Helper.correctNull(
								(String) hshValues.get("spcbranchk"))
								.equalsIgnoreCase("Y"))
						&& (strsentspcchk.equalsIgnoreCase("y"))) {%>
		document.all.sendspc.style.visibility="visible"; 
		document.all.sendspc.style.position="relative";
		document.forms[0].cmdSendcpc.disabled=true;
        <%}%>
<%}%>
document.forms[0].cmdMisbam83.disabled=true;
hiddencibilscore();

if(NP_LOAN_REPAYINTEREST!=""){
	document.forms[0].sel_repay_interest.value=NP_LOAN_REPAYINTEREST;
}
else
{
	document.forms[0].sel_repay_interest.value="s";
}
if(NP_LOAN_PRO_REPAYBY!=""){
	document.forms[0].sel_Pro_repay_by.value=NP_LOAN_PRO_REPAYBY;
}
else
{
	document.forms[0].sel_Pro_repay_by.value="s";
}
document.forms[0].txt_pro_repay_tenure.readOnly=false;
document.forms[0].txt_pro_repay_amount.readOnly=false;
document.forms[0].txt_subsidy_amount.readOnly=false;

}

function callCalculateInterest()
{
	var varIntType=document.forms[0].int_type.value; //document.forms[0].selectinttype.value ;
	
	if(varIntType <3 && varIntType!="")
	{	
		callCalculate();
	}
	else if(varIntType == 3 && varIntType!="")
	{	
		callStepUpCalculate()
	}

}
var strvalue="/jsp/perhlp/hlp_applicantdetails.jsp";
function callPropDtls()
{
	var strappno= "<%=Helper.correctNull((String) request
									.getParameter("appno"))%>";
	document.forms[0].hidBeanGetMethod.value="";
	document.forms[0].action = appURL+"action/perpropertydetails.jsp";//?appno="+strappno;
	document.forms[0].submit();
}

function showRepayButton()
{
	//var index = document.forms[0].selrepaymenttype.selectedIndex;
	//var index1 = document.forms[0].selrepaymenttype.value;
	
	//if(index1 == "3" || index1 == "4")
	//{
	//document.all.amort1.style.visibility="visible";
	//document.all.amort2.style.visibility="visible";
	//document.all.amort1.innerText="Click here to view the OverDraft Table";
	//document.forms[0].amort.value = "OverDraft";
	//}
	//else if(index1 == "2")
	//{
	//document.all.amort2.style.visibility="visible";
	//document.all.amort1.innerText="Click here to view the Restructed RePayment Schedule";
	//document.forms[0].amort.value = "Repayment Schedule";
	//}
	//else
	//{
	//document.all.amort1.innerText="Click here to view the Amortization Table";
	//document.forms[0].amort.value = "Amortization";
	//}

	// modified bt kk


	var index = document.forms[0].selrepaymenttype.selectedIndex;
	var index1 = document.forms[0].selrepaymenttype.value;
	
	if(index1 == "3" || index1 == "4")
	{
//	document.all.amort1.style.visibility="visible";
	document.all.amort2.style.visibility="visible";
//	document.all.amort1.innerText="Click here to view the OverDraft Table";
	document.forms[0].amort.value = "OverDraft";
	}
	else if(index1 == "2")
	{
	document.all.amort2.style.visibility="visible";
//	document.all.amort1.innerText="Click here to view the Restructed RePayment Schedule";
	document.forms[0].amort.value = "Repayment Schedule";
	}
	else if(index1 == "1" && index == "1")
	{
	document.all.amort2.style.visibility="visible";
//	document.all.amort1.innerText="Click here to view the Restructed RePayment Schedule";
	document.forms[0].amort.value = "Repayment Schedule";
//	document.all.amort1.innerText="Click here to view the Amortization Table";
	document.forms[0].amort.value = "Amortization";
	}
	else
	{
//	document.all.amort1.innerText="Click here to view the Amortization Table";
	document.forms[0].amort.value = "Amortization";
	}

	// end of mod by kk
	
}

function entersecure()
{
	 if (document.forms[0].sel_secured.value == "p")
	{
			document.all.secure.style.visibility="visible";
			document.all.secure1.style.visibility="visible";
	}
	else
	{
			document.all.secure.style.visibility="hidden";
			document.all.secure1.style.visibility="hidden";
			document.forms[0].txt_secured.value = "";
	}
}

function moratorium()
{
	 if (document.forms[0].txt_installments.value != "")
	{
		alert("Enter the periodicity");
		document.forms[0].sel_peridicity.focus();
	}

}

function getrepayment()
{
	if(document.forms[0].sel_peridicity.value =="m" && (document.forms[0].interestservised.value =="s" || document.forms[0].interestservised.value =="y") )
	{
		
		document.forms[0].selrepaymenttype.length=5;
		document.forms[0].selrepaymenttype.options[0].value="0";
		document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
		document.forms[0].selrepaymenttype.options[1].value="1";
		document.forms[0].selrepaymenttype.options[1].text="Equated Monthly Installment";
		document.forms[0].selrepaymenttype.options[2].value="2";
		document.forms[0].selrepaymenttype.options[2].text="Structured Repayment Schedule";
		document.forms[0].selrepaymenttype.options[3].value="3";
		document.forms[0].selrepaymenttype.options[3].text="OverDraft";
		document.forms[0].selrepaymenttype.options[4].value="4";
		document.forms[0].selrepaymenttype.options[4].text="OverDraft-Reducing Limit";
	}
	else if  (document.forms[0].sel_peridicity.value =="m" &&  document.forms[0].interestservised.value =="n" )
	{
		
		document.forms[0].selrepaymenttype.length=4;
		document.forms[0].selrepaymenttype.options[0].value="0";
		document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
		document.forms[0].selrepaymenttype.options[1].value="2";
		document.forms[0].selrepaymenttype.options[1].text="Structured Repayment Schedule";
		document.forms[0].selrepaymenttype.options[2].value="3";
		document.forms[0].selrepaymenttype.options[2].text="OverDraft";
		document.forms[0].selrepaymenttype.options[3].value="4";
		document.forms[0].selrepaymenttype.options[3].text="OverDraft-Reducing Limit";
	}

	else if(document.forms[0].sel_peridicity.value !="m")
	{
		
		document.forms[0].selrepaymenttype.length=4;
		document.forms[0].selrepaymenttype.options[0].value="0";
		document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
		document.forms[0].selrepaymenttype.options[1].value="2";
		document.forms[0].selrepaymenttype.options[1].text="Structured Repayment Schedule";
		document.forms[0].selrepaymenttype.options[2].value="3";
		document.forms[0].selrepaymenttype.options[2].text="OverDraft";
		document.forms[0].selrepaymenttype.options[3].value="4";
		document.forms[0].selrepaymenttype.options[3].text="OverDraft-Reducing Limit";
	}

}

function interestselect()
{
	document.forms[0].selrepaymenttype.value="0";
}

function clearmonpay()
{
	if (document.forms[0].interestservised.value == "n")
	{
		document.forms[0].txtmonPay.value = "0.00";
	}
}
function morvalue(morvalue)
{
	var productmorvalue = document.forms[0].hidmor.value;

	if (eval(morvalue) > eval(productmorvalue))
	{
		alert("Moratorium exceeds Defined Moratorium "+productmorvalue+ " months");
		document.forms[0].txt_installments.value = "";
	  	document.forms[0].txt_installments.focus();
	}

	//if (morvalue=="0")
	//{
	//   alert("Moratorium should not be zero");
	//   document.forms[0].txt_installments.value = "";
	//   document.forms[0].txt_installments.focus();
	//}
}
function dopresanctionlist()
{
			//var app_no = document.forms[0].hidapno.value;
			var app_no = "<%=request.getParameter("appno")%>"; 
			var varQryString = "<%=ApplicationParams.getAppUrl()%>action/presanctionchecklist.jsp?hidBeanId=checklistHomeLoan&hidBeanGetMethod=getPreSanctionData&appno="+app_no;
			var prop = "scrollbars=yes,width=650,height=600";	
			var title = "Upload";
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);	
		
}

function doBPHelp()
{
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url="<%=ApplicationParams.getAppUrl()%>action/bestpractice.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getbestpractice";
	var title = "BestPracticeCode";
	var prop = "scrollbars=yes,width=750,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function dochecklistHL()
{
	var appno ="<%=request.getParameter("appno")%>"; //document.forms[0].appno.value;
	var hidstatus =document.forms[0].hidstatus.value;

	var url = "<%=ApplicationParams.getAppUrl()%>action/checklistHomeLoan.jsp?hidBeanId=checklistHomeLoan&hidBeanGetMethod=getCheckListData&appno="+appno+"&hidstatus="+hidstatus;
	var title = "checklistHomeLoan";
	var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
	var xpos = 80;
	var ypos = 65;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function emialert()
{
	if(document.forms[0].txtmonPay.value=="")
	{
		alert("Enter the Required EMI");	
		document.forms[0].txtmonPay.focus();
	}
}

function chkfrmonetotwenty()
{
	var loanmodintrate=document.forms[0].txtloan_modintrate.value;
	var zro ="1";
	var twenty="20";
	if(loanmodintrate=="")
	{
		alert("Interest rate should be > than zero");
		document.forms[0].txtloan_modintrate.focus();
		return false;
	}
	if(eval(loanmodintrate) < eval(zro))
	{
		alert("Interest rate should be > than zero");
		document.forms[0].txtloan_modintrate.value="";
		document.forms[0].txtloan_modintrate.focus();
		return false;
	}
	if(eval(loanmodintrate) > eval(twenty))
	{
		alert("Interest rate should not > than twenty");
		document.forms[0].txtloan_modintrate.value="";
		document.forms[0].txtloan_modintrate.focus();
		return false;
	}
}
function callInwardNoSearch()
{
	var varInwardVal	= document.forms[0].txt_InwardNo.value;


	//if(varInwardVal=="")
	{
		var varcategory="";
		if(document.forms[0].cmdapply.disabled==false)
		{
			/*if(document.forms[0].hidCategoryType.value=="RET")
			{
				varcategory="p";
			} 
			else if(document.forms[0].hidCategoryType.value=="AGR")
			{
				varcategory="a";
			}
			else if(document.forms[0].hidCategoryType.value=="LAD")
			{
				varcategory="LAD";
			}*/
			var varLoanType=document.forms[0].hidApploanType.value;
			var varQryString = appURL+"action/searchAppinwradno.jsp?hidBeanId=notefinmaster&hidBeanGetMethod=getInwardnoSearchByName&varLoanType="+varLoanType+"&custid="+document.forms[0].hidCustId.value;
			var title = "InwardAppNoSearch";
			var prop = "scrollbars=yes,width=650,height=400";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
	}
}
function callDescHelp1()
{	
	if(document.forms[0].cmdedit.disabled==true &&  ((document.forms[0].appstatus.value !="Processed/Rejected" ) || (document.forms[0].appstatus.value !="Processed/Approved")) && (document.forms[0].hid_appholder.value =="Y")  )
	{
		var appno = document.forms[0].appno.value;
				var varQryString = appURL+"action/setshowproduct.jsp?hidBeanGetMethod=getProductData&hidBeanId=showproduct&bowid="+
				appno+"&cust_id="+document.forms[0].hidCustId.value+"&Page_From="+varPageFrom+"strnewscheme"+varstrnewscheme;
				var title = "ProductSearch";
				var prop = "scrollbars=yes,width=855,height=420";	
				prop = prop + ",left=70,top=150";
				window.open(varQryString,title,prop);	
	}
}
function invoketitle()
{
	document.forms[0].txtloan_intrate.title="MCLR/EBLPR will be automatically picked from CBS";
}


function showappholder()
{
	if((document.forms[0].hid_appholder.value=="N") || (document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
	{
		callDisableControls(true,true,true,true,false,false);
	}	
}


function checkbasediff()
{

	/*var baserate= document.forms[0].txtloan_intrate.value;
	var vardiff=document.forms[0].txt_var.value;

	if(vardiff >  baserate)
	{

		alert("Variance should be less than MCLR");
		document.forms[0].txt_var.focus();
		document.forms[0].txt_var.value="0.00";
		return;
	}*/	
}


function chkintrate()
{
	var baserate=0,variance=0;
	if(document.forms[0].txtloan_intrate.value!="")
	{
		 baserate =document.forms[0].txtloan_intrate.value;
	}
	if(document.forms[0].txt_var.value!="")
	{
	variance = document.forms[0].txt_var.value;
	}
    var total=eval(baserate)+eval(variance);
	document.forms[0].txtloan_modintrate.value=roundVal(total);
	if(varCanaraSyndBank == "C")
    {
    	if(document.forms[0].txt_prodlevelvar.value!="")
    	{
    	prdlevelvar = NanNumber(document.forms[0].txt_prodlevelvar.value);
    	}
    	var totalVal=NanNumber(eval(baserate))+NanNumber(eval(variance))+NanNumber(eval(prdlevelvar));
    	document.forms[0].txtloan_modintrate.value=roundVal(NanNumber(totalVal));
    }

	/*if(baseRate<interestRate)
	{
		alert("Interest Rate should be greater or equalto MCLR");
		document.forms[0].txtloan_modintrate.focus();
		return;
	}*/
}

function maxloan()
{
	if(document.forms[0].selectpurpose.value=="16")
	{
	var amnt_req = document.forms[0].txtloan_amtreqd.value;
	if(amnt_req>2000000)
	{
		alert("Maximum Loan Amount For this Scheme is 20 lakhs!!!");
		document.forms[0].txtloan_amtreqd.value="";
		document.forms[0].txtloan_amtreqd.focus();
		return;
	}
	}
}

function getHouseLoan()
{
	if(document.forms[0].sel_house.value=="2")
	{
		document.all.id_bank1.style.visibility="visible";
		document.all.id_bank1.style.position="relative";
		document.all.id_bank2.style.visibility="visible";
		document.all.id_bank2.style.position="relative";
		document.all.id_bank3.style.visibility="visible";
		document.all.id_bank3.style.position="relative";
		document.all.id_bank4.style.visibility="hidden";
		document.all.id_bank4.style.position="absolute";
		document.all.id_bank5.style.visibility="hidden";
		document.all.id_bank5.style.position="absolute";
		document.all.id_bank6.style.visibility="hidden";
		document.all.id_bank6.style.position="absolute";
	}
	else if(document.forms[0].sel_house.value=="3")
	{
		document.all.id_bank1.style.visibility="visible";
		document.all.id_bank1.style.position="relative";
		document.all.id_bank2.style.visibility="visible";
		document.all.id_bank2.style.position="relative";
		document.all.id_bank3.style.visibility="visible";
		document.all.id_bank3.style.position="relative";
		document.all.id_bank4.style.visibility="visible";
		document.all.id_bank4.style.position="relative";
		document.all.id_bank5.style.visibility="visible";
		document.all.id_bank5.style.position="relative";
		document.all.id_bank6.style.visibility="visible";
		document.all.id_bank6.style.position="relative";
	}
	else if(document.forms[0].sel_house.value=="s" || document.forms[0].sel_house.value=="1")
	{
		document.all.id_bank1.style.visibility="hidden";
		document.all.id_bank1.style.position="absolute";
		document.all.id_bank2.style.visibility="hidden";
		document.all.id_bank2.style.position="absolute";
		document.all.id_bank3.style.visibility="hidden";
		document.all.id_bank3.style.position="absolute";
		document.all.id_bank4.style.visibility="hidden";
		document.all.id_bank4.style.position="absolute";
		document.all.id_bank5.style.visibility="hidden";
		document.all.id_bank5.style.position="absolute";
		document.all.id_bank6.style.visibility="hidden";
		document.all.id_bank6.style.position="absolute";
	}
	if(loanPrdType =="973" || loanPrdType =="974")
	{
		if(varpmayValue !="")
		{
			document.forms[0].sel_pmayscheme.value=varpmayValue
		}
		else
		{
			document.forms[0].sel_pmayscheme.value="0";
		}
		document.forms[0].sel_pmayscheme.readOnly = true;
	}
	else
	{
		document.all.id_pmayscheme.style.visibility="hidden";
		document.all.id_pmayscheme.style.position="absolute";
	}
	<%if (!strappno1.equalsIgnoreCase("")
					&& (Helper
							.correctNull((String) hshValues.get("cibilScore"))
							.equalsIgnoreCase(""))) {%>
		document.all.cibilView.style.visibility="hidden";
		document.all.cibilView.style.position="absolute";
		document.all.cibilView1.style.visibility="hidden";
		document.all.cibilView1.style.position="absolute";
		
	<%}%>
	if(document.forms[0].cmdapply.disabled == false)
	{	
		document.forms[0].txtloan_costloanprd.focus();
	}
	document.getElementById("img_loadder").style.display="none";
}

function calcnoofinstall()
{
	var varTermloan = document.forms[0].txtloan_reqterms.value;
	var varMoratorium = document.forms[0].txt_installments.value;
	var varNoofinstall2 = document.forms[0].txt_noofinstallments.value;
	if(varstrCBSMigval !="1"){
	if(varMoratorium!=1)
	{
		document.forms[0].interestservised.disabled=false;
	}
	else if(varMoratorium==1)
	{
		document.forms[0].interestservised.value = "n";
		document.forms[0].interestservised.disabled=true;
	}
	}
//	var varNoofinstall = eval(varTermloan)-eval(varMoratorium);
//	document.forms[0].txt_noofinstallments.value = varNoofinstall;
    if(varNoofinstall2 == ""){
    	varNoofinstall2 = "0";
    }
    if(varMoratorium == ""){
    	varMoratorium = "0";
    }
    if(varNoofinstall2 != "" && varMoratorium != ""){
	var varTermloan2 = eval(varNoofinstall2)+eval(varMoratorium);
	document.forms[0].txtloan_reqterms.value = varTermloan2;
    }
}



function costCheck(varCostValue){
	
	var varmclrvalue=document.forms[0].txtloan_modintrate.value
	if(document.forms[0].txtloan_modintrate.value !="")
	{
		document.forms[0].txtloan_modintrate.value=roundVal(varmclrvalue);
	}
	var vartxtloan_costloanprd=varCostValue;


	var prdcode = document.forms[0].shanshidProductID.value;
	
	if((prdcode=="974" || prdcode=="973"))
		{
	    document.all.id_charges1.style.visibility="visible";
	    document.all.id_charges1.style.position="relative";
//	    document.all.id_charges2.style.visibility="visible";
//	    document.all.id_charges2.style.position="relative";
	    document.all.id_charges3.style.visibility="visible";
	    document.all.id_charges3.style.position="relative";
	    document.all.id_charges4.style.visibility="visible";
	    document.all.id_charges4.style.position="relative";
	    document.all.id_charges5.style.visibility="visible";
	    document.all.id_charges5.style.position="relative";
	    document.all.id_charges6.style.visibility="visible";
	    document.all.id_charges6.style.position="relative";
	    document.all.id_charges7.style.visibility="visible";
	    document.all.id_charges7.style.position="relative";
	    document.all.id_charges8.style.visibility="visible";
	    document.all.id_charges8.style.position="relative";
	    document.all.id_charges9.style.visibility="visible";
	    document.all.id_charges9.style.position="relative";

	    document.forms[0].txt_Stampduty.readOnly = false;
	    document.forms[0].txt_Documentationcharges.readOnly = false;
	    document.forms[0].txt_Registrationcharges.readOnly = false;
		}
	else{
		 document.all.id_charges1.style.visibility="hidden";
		 document.all.id_charges1.style.position="absolute";
//		 document.all.id_charges2.style.visibility="hidden";
//		 document.all.id_charges2.style.position="absolute";
		 document.all.id_charges3.style.visibility="hidden";
		 document.all.id_charges3.style.position="absolute";
		 document.all.id_charges4.style.visibility="hidden";
		 document.all.id_charges4.style.position="absolute";
		 document.all.id_charges5.style.visibility="hidden";
		 document.all.id_charges5.style.position="absolute";
		 document.all.id_charges6.style.visibility="hidden";
		 document.all.id_charges6.style.position="absolute";
		 document.all.id_charges7.style.visibility="hidden";
		 document.all.id_charges7.style.position="absolute";
		 document.all.id_charges8.style.visibility="hidden";
		 document.all.id_charges8.style.position="absolute";
		 document.all.id_charges9.style.visibility="hidden";
		 document.all.id_charges9.style.position="absolute";

		 document.forms[0].txt_Stampduty.readOnly = true;
		 document.forms[0].txt_Documentationcharges.readOnly = true;
		 document.forms[0].txt_Registrationcharges.readOnly = true;
		}	
}

function disableFields(val)
{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				 document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="radio")
			{
			 // document.forms[0].elements[i].disabled=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
			
		}

}

function toggleStateCheck(obj) {
	if (obj.checked) {
		obj.value = "Y";
	} else {
		obj.value = "N";
	}
}
function callRateChatChange()
{
	if(document.forms[0].txt_schedutype.value !="s")
	{ 
		var amtreq = document.forms[0].txtloan_costloanprd.value;
		document.all.ifrmnewintrate.src=appURL+"action/iframeinterestrate.jsp?prd_code="+document.forms[0].shanshidProductID.value+"&amtreq="+amtreq+
		"&txtloan_reqterms="+document.forms[0].txtloan_reqterms.value+"&hidBeanGetMethod=getNewInterestRate&hidBeanId=perapplicant&cbsMigrationNum="+varstrCBSMigval+"&Scheduletype="+document.forms[0].txt_schedutype.value;	
	}
	if(document.forms[0].txt_ratechatcode.value !="s")
	{ 
	document.all.iframerate.src=appURL+"action/hevpiframeratechat.jsp?strPrdCode="+document.forms[0].shanshidProductID.value+"&TermLoanmnths="+document.forms[0].txtloan_reqterms.value+"&strRateCode="+document.forms[0].txt_ratechatcode.value+"&strSchedtype="+document.forms[0].txt_schedutype.value+"&strPage=Edu"+"&strSancamount="+document.forms[0].txtloan_amtreqd.value+"&hidBeanGetMethod=getRateChartCode&hidBeanId=HEVPPerLoanDetails";
	}	
}
function callAgreementDate()
{
	var pagedate=document.forms[0].date_offerletter.value;//offerletter date
	var maxdate=document.forms[0].date_agreementsign.value;//agreement sign date
	var pgdt=changeDateformat(pagedate);
	var maxdt=changeDateformat(maxdate);
	if(pagedate !="" && maxdate !="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Agreement Sign Date Can not be less than the Letter of Offer Date ");
			document.forms[0].date_agreementsign.value="";
			//document.forms[0].date_agreementsign..focus();
		}
	}
}
function checkMorator()
{
	var varSchedtype=document.getElementById("cbs_schedule");
	var varSchedtypeText="";
	
	if(document.forms[0].txt_schedutype.value !="s")
	{
		if(document.forms[0].txt_schedutype.length !="0")
		{
			varSchedtypeText=varSchedtype.options[varSchedtype.selectedIndex].text;
			
			if(varSchedtypeText.match(/-MOR/))
			{
				document.forms[0].interestservised.value="n";	
				document.forms[0].interestservised.disabled=true;
			}
			else if(varSchedtypeText.match(/-IOI/))
			{
				document.forms[0].interestservised.value="y";
				document.forms[0].interestservised.disabled=true;
			}
			
		}
		
	}
	
}
function callCheckIOI()
{
	if(varschedText!="")
	{
		if(varschedText.match(/-IOI/))
		{
			document.forms[0].interestservised.value="y";
			document.forms[0].interestservised.disabled=true;
		}
	}
}
function checkVariance()
{
	   // var prdcode = document.forms[0].shanshidProductID.value;
		//if(document.forms[0].txt_var.value !="")
		//{
	//		document.all.ifrmperloanhevp.src=appURL+"action/ifrmperloanhevp.jsp?hidBeanGetMethod=getPersonalvariance&hidBeanId=agriapplicant&prd_code="+prdcode+"&varval="+document.forms[0].txt_var.value;
	//	}
}
function callDICVariance()
{
	  var prdcode = document.forms[0].shanshidProductID.value;
	  var selectpurpose = document.forms[0].selectpurpose.value;
	  var Tenor = document.forms[0].txtloan_reqterms.value;
	  var loanamount = document.forms[0].txtloan_sancamt.value;
		if(document.forms[0].shanshidProductID.value !="" && document.forms[0].selectpurpose.value !="" )
		{
			document.all.ifrmSetupDICvariance.src=appURL+"action/ifrmSetupDICvariance.jsp?hidBeanGetMethod=getSetupDICvariance&hidBeanId=HEVPPerLoanDetails&prd_code="+prdcode+"&selectpurpose="+selectpurpose+"&Tenor="+Tenor+"&loanamount="+loanamount;
		}
}
function callPSB59()
{
	if(document.forms[0].sel_PSB59.value == "1")
	{
		document.all.PSB59refno.style.visibility="visible";
		document.all.PSB59refno.style.position="relative";
		document.all.PSB59refno1.style.visibility="visible";
		document.all.PSB59refno1.style.position="relative";
		document.all.PSB59refno2.style.visibility="visible";
		document.all.PSB59refno2.style.position="relative";
	}
	else
	{
		document.all.PSB59refno.style.visibility="hidden";
		document.all.PSB59refno.style.position="absolute";
		document.all.PSB59refno1.style.visibility="hidden";
		document.all.PSB59refno1.style.position="absolute";
		document.all.PSB59refno2.style.visibility="hidden";
		document.all.PSB59refno2.style.position="absolute";
	}		
}
function callPSB59RefNo()
{
	 var varPSB59Refno=document.forms[0].txt_PSB59refno.value;
	 if(document.forms[0].txt_PSB59refno.value !="")
		{
			document.all.ifrmPSB59Refno.src=appURL+"action/ifrmPSB59Refno.jsp?hidBeanGetMethod=getPSB59Refno&hidBeanId=HEVPPerLoanDetails&varPSB59Refno="+varPSB59Refno;
		}		 
}
function callChekcRelationShip()
{
	if(document.forms[0].hidNSDLPage.value =="NSDL")
	{
		if(trim(document.forms[0].txt_custrelation.value)!="SOW")
		{
		//	alert("Kindly Select SOW-Sole Owner Relation Only.");
		//	document.forms[0].txt_custrelation.value="SOW";
		//	return;
		}
	}
}

function allowNumeric(evt)
{
	var key=(evt.which) ? evt.which : event.keyCode; 
	if(!( (key>47 && key<58))){
		return  false;
	}
	return true;
}
function DisableCopyPaste(e) 
{
 // Message to display
 var message = "Cntrl key/ Right Click Option disabled";
 // check mouse right click or Ctrl key press
var kCode = e.keyCode; 
//FF and Safari use e.charCode, while IE use e.keyCode
 if (kCode == 17 || kCode == 0)
 {
 alert(message);
 return false;
 }
 else{
	 allowNumeric(kCode)
 }
}
function getCicScoreEdu()
{
	var appnumber="<%=strappno1%>";
	//alert(appnumber);
	var	varQryString = appURL+"action/cicScoreEducaLoanApp.jsp?hidBeanId=perapplicant&hidBeanGetMethod=getallRecordsCicScoreEdu&txtperapp_appid="+varCibilLapsId+"&appnumber="+appnumber;
	var prop = "scrollbars=yes,width=1200,height=550,menubar=yes,toolbar=yes";	
	var xpos = (screen.width - 1200) / 2;
	var ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,'title',prop);	
}
function callCustomerrelation()
{
	if(CoapplicantRecord  == "YES")
	{
		if(document.forms[0].txt_custrelation.value == "SOW")
		{
			alert("Invalid customer relation");
			document.forms[0].txt_custrelation.value="s";
			document.forms[0].txt_custrelation.focus();
			return;
		}
	}
}
function callSendRAH()
{
		if(varAppHolder =="yes")
		{
		//	if(confirm("Do you want to send this application to RAH ?"))
		//	{
		//	    document.all.ifrmsendcpc.src=appURL+"action/iframesendRAH_agri.jsp?hidBeanGetMethod=getSendcpc&hidBeanId=HEVPPerLoanDetails&strpage=Edu";//Productcode
				
				var appno ="<%=strappno1%>";
			    var url = "<%=ApplicationParams.getAppUrl()%>action/send_to_rah.jsp?hidBeanId=perapplicant&hidBeanGetMethod=getLoanProducts&appno="+appno+"&strpage=Edu";
			    var title = "Send To RAH";
			    var prop = "scrollbars=yes,width=900,height=550,menubar=yes";
			    var xpos = 80;
			    var ypos = 65;
			    prop = prop + ",left="+xpos+",top="+ypos;
			    window.open(url,title,prop);
		//	}
		}
		else
		{
			alert("Sorry....!,you are not Application Holder for this application");
		}
}
function doSanctionLetter()
{
	 if(varAppSancPrintFlg =="Y")
	 {
		document.forms[0].cmdMisbam83.disabled = false;
	 }
	var varSmsSent="";
	var vara = document.getElementById("sendspc");
	if( vara.style.visibility == "visible")
	{
		document.forms[0].cmdSendcpc.disabled=true;
	}
	
	var santionamnt="<%=Helper.correctDouble((String) hshValues
									.get("sancmount"))%>";
	var tenorval="<%=Helper.correctNull((String) hshValues.get("lreqterms"))%>";
	var emi="<%=Helper.correctDouble((String) hshValues.get("loan_emi"))%>";
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url=appURL+"action/hevp_sanctionletter.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getSanctionLetter&eligsantionamnt="+santionamnt+
	"&tenorval="+tenorval+"&emi="+emi+"&smssent="+varSmsSent+"&Module=Edu";
	var title = "SantionLetter";
	var prop = "scrollbars=yes,width=750,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function callMisCollateral()
{	
	var vara = document.getElementById("sendspc");
	if( vara.style.visibility == "visible" && varCollFlag =="Y")
	{
		document.forms[0].cmdSendcpc.disabled=false;
	}
		var appnumber="<%=strappno1%>";
		var url=appURL+"action/goldmisbam83.jsp?hidBeanGetMethod=gethevpmisbam83&hidBeanId=HEVPCommWorkflow&appno="+appnumber+"&strpage=Edu";		
		var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
		var title = "MIS BAM-83";
		window.open(url,title,prop);			
}

function callCourse()
{
	if(document.forms[0].sel_StudyRegion.value =="A"){
		document.all.id_course.style.display="none";
		document.all.id_course1.style.display="";
		document.forms[0].txt_CourDuration.readOnly = false;
		document.forms[0].txt_Course.readOnly = false;
    }else{
    	document.all.id_course.style.display="";
		document.all.id_course1.style.display="none";
    }
	if(document.forms[0].sel_StudyRegion.value =="D" && document.forms[0].sel_CourType.value != "S")
	{ 
		var sel_StudyRegion = document.forms[0].sel_StudyRegion.value;
		var sel_CourType = document.forms[0].sel_CourType.value;
		var sel_Course = document.forms[0].sel_Course.value;
		document.all.iframeCourseDet_Edu.src=appURL+"action/iframeCourseDet_Edu.jsp?hidBeanGetMethod=getEduCourseDetails&hidBeanId=perapplicant&StudyRegion="+sel_StudyRegion+"&CourseType="+sel_CourType+"&Course="+sel_Course;
	}
}

function calCourCompletion(){
	if(document.forms[0].txt_Course_CommDate.value != ""){
    //  var varCourDuration = document.forms[0].txt_RemDuration.value;
        var varCourDuration = document.forms[0].txt_RemDuration.value;
        var txt_Course_CommDate = document.forms[0].txt_Course_CommDate.value;
        if(varCourDuration == ""){
        	return;
        }
        var temp1 = txt_Course_CommDate.split("/");
		var d1 =new Date(temp1[2]+"/"+temp1[1]+"/"+temp1[0]);
		d1.setMonth(d1.getMonth() +eval(varCourDuration));
		var day = d1.getDate();
		var month = d1.getMonth()+1;
		var year = d1.getFullYear();
		var len1 = day.length;
		var len2 = month.length;
		if(eval(len1) < 2){
			day = "0"+day;
		}
		if(eval(len2) < 2){
			month = "0"+month;
		}
		document.forms[0].txt_CourCompDate.value = day+"/"+month+"/"+year;
		
		var txt_CourCompDate = document.forms[0].txt_CourCompDate.value;
		var temp2 = txt_CourCompDate.split("/");
		var d2 =new Date(temp2[2]+"/"+temp2[1]+"/"+temp2[0]);
		d2.setMonth(d2.getMonth() +12);
		var day1 = d2.getDate();
		var month1 = d2.getMonth()+1;
		var year1 = d2.getFullYear();
		if(day1.length < 2){
			day1 = "0"+day1;
		}
		if(month1.length < 2){
			month1 = "0"+month1;
		}
		document.forms[0].txtloan_emicommdate.value = day1+"/"+month1+"/"+year1;
	}		
}

function calRemDuration(){
	 var varRemDuration = "0";
	 var varCourDuration = document.forms[0].txt_CourDuration.value;
     var sel_LoanAvail_ForSem = document.forms[0].sel_LoanAvail_ForSem.value;
     if(varCourDuration == ""){
     	varCourDuration = "0";
     }
     if(document.forms[0].sel_LoanAvail_ForSem.value != "S"){
       varRemDuration = eval(varCourDuration)-(eval(sel_LoanAvail_ForSem)-1)*6;
       document.forms[0].txt_RemDuration.value = varRemDuration;
     }
     document.forms[0].txt_installments.value = eval(varRemDuration)+12;
     calcnoofinstall();
     document.forms[0].txt_installments.readOnly = true;
}
function negValueAler(){
	var varTermloan = document.forms[0].txtloan_reqterms.value;
	var varMoratorium = document.forms[0].txt_installments.value;
	var varNoofinstall2 = document.forms[0].txt_noofinstallments.value;
	if(varNoofinstall2==""){
        alert("Enter No.of Installment");
        document.forms[0].txt_noofinstallments.focus();
		return false;
	}else{
       if(eval(varNoofinstall2) <= 0){
    	   alert("No.of Installment Should be Greater than Zero");
    	   document.forms[0].txt_noofinstallments.value ="";
           document.forms[0].txt_noofinstallments.focus();
   		   return false;
       }
       if(document.forms[0].sel_LoanAvail_ForSem.value != "S" && document.forms[0].txt_CourDuration.value != ""){
       if(eval(varTermloan) <= 0){
    	   alert("Term of the Loan(Inclusive of Moratorium) Should be Greater than Zero");
    	   document.forms[0].txtloan_reqterms.value ="";
           document.forms[0].txtloan_reqterms.focus();
   		   return false;
       }
       if(eval(varMoratorium) <= 0){
    	   alert(" Moratorium Period in months(Repayment Holiday) Should be Greater than Zero");
    	   document.forms[0].txt_installments.value ="";
           document.forms[0].txt_installments.focus();
   		   return false;
       }
       }
	}
}
function valForLettOfferDate(){
	var date_offerletter = document.forms[0].date_offerletter.value;
	if(date_offerletter!=""){
	var temp = date_offerletter.split("/");
	var d =new Date(temp[2]+"/"+temp[1]+"/"+temp[0]);
	var d1 = new Date();
	d1.setMonth(d1.getMonth() -6);
	if(d<d1){
    alert("As per credit policy Letter of offer date should not be older than 6 months.");
    document.forms[0].date_offerletter.value="";
    return false;
	}
	}
}

function doSearchAccount_Drawdown()
{
	if(varCanaraSyndBank=="C")
	{
		var varcbsidCanara = document.forms[0].hidCustId.value;	
		var varQryString = appURL+"action/gold_RemmitterAccount_Canara.jsp?hidBeanGetMethod=getCanaraTODAccountInfo&hidBeanId=MSMESimplification&txt_cbsid_msmeVal="+varcbsidCanara;
		var title = "AccountDetails";
		var prop = "scrollbars=yes,width=850,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varQryString,title,prop);
	}
	
}

function drawdown(){
	if(document.forms[0].sel_drawdown.value=="Y"){
		document.all.id_drawdown1.style.visibility="visible";
		document.all.id_drawdown1.style.position="relative";
		document.all.id_drawdown2.style.visibility="visible";
		document.all.id_drawdown2.style.position="relative";
		document.all.id_drawdown3.style.visibility="visible";
		document.all.id_drawdown3.style.position="relative";
		document.all.id_drawdown4.style.visibility="visible";
		document.all.id_drawdown4.style.position="relative";
		document.all.id_drawdown5.style.visibility="visible";
		document.all.id_drawdown5.style.position="relative";
		document.all.id_drawdown6.style.visibility="visible";
		document.all.id_drawdown6.style.position="relative";	
		
	}else{
		document.all.id_drawdown1.style.visibility="hidden";
		document.all.id_drawdown1.style.position="absolute";
		document.all.id_drawdown2.style.visibility="hidden";
		document.all.id_drawdown2.style.position="absolute";
		document.all.id_drawdown3.style.visibility="hidden";
		document.all.id_drawdown3.style.position="absolute";
		document.all.id_drawdown4.style.visibility="hidden";
		document.all.id_drawdown4.style.position="absolute";
		document.all.id_drawdown5.style.visibility="hidden";
		document.all.id_drawdown5.style.position="absolute";
		document.all.id_drawdown6.style.visibility="hidden";
		document.all.id_drawdown6.style.position="absolute";
	}
		
}

function hiddencibilscore()
{
	document.all.cibil_score.style.visibility="hidden";
	document.all.cibil_score.style.position="absolute";
	document.all.cibil_reports.style.visibility="hidden";
	document.all.cibil_reports.style.position="absolute";
}

function callsemInfo(){
	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/EduLoan_SemInfo.jsp";
	var title = "Info";
	var prop = "scrollbars=no,width=260,height=200";	
	var prop = "scrollbars=yes,width=600,height=300,menubar=no";	
	window.open(varQryString,title,prop);
}

function callAvailingSeminfo(){
	var newline = "\r\n";
	var alertmsg  ="* Choose 1, if student is availing loan from commencement of course."; 
	alertmsg += newline;     
	alertmsg += "* Choose n, if student is avaling loan from n(th) semester for the remining course duration. e.g.Choose 3, if student is availing loan from 3rd semester for the remining course duration and likewise.";
	alertmsg += newline; 
	alertmsg += "* Please verify Remaining Course Duration, Course Completion Date, EMI Commencement Date and Moratorium after choosing semester.";
	alert(alertmsg);
}

function docalReload11(){
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action=appURL+"action/perloandetails.jsp";
	document.forms[0].submit();
}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body
	onLoad="costCheck(document.forms[0].txtloan_costloanprd.value);callOnLoad();showRepayButton();showDelAppButton();showinttype();checkmahila();showappholder();chkintrate();getHouseLoan();callMoratoriumPeroid();callDICVariance();"
	text="#000000" vlink="#330000" alink="#330000" leftmargin="0"
	topmargin="0" marginwidth="0" marginheight="0" class="bgcolor">

<jsp:include page="../share/help.jsp" flush="true">
</jsp:include>
<form name="appform" method="post" action=""><iframe height="0"
	width="0" id="ifrm" frameborder=0 style="border: 0"></iframe> <iframe
	height="0" width="0" id="ifrm1" frameborder=0 style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrmnewintrate" frameborder=0
	style="border: 0"></iframe> <iframe height="0" width="0" id="ifrmdate"
	frameborder=0 style="border: 0"></iframe> <iframe height="0" width="0"
	id="ifrmsendcpc" frameborder="0" style="border: 0"></iframe>
<table width="100%" border="1" cellpadding="0" cellspacing="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">


	<tr>
		<td><jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>



</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="bredcrumb">Home <span class="bredcrumbArw">
		&gt; </span> &nbsp; National Portal <span class="bredcrumbArw"> &gt; </span> &nbsp; <%
 	
 %> <span class="bredcrumbArw"> &gt; </span> &nbsp; Applicant</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertablecolor">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr align="center">
				<td width="15%" height="16" class="tabactive"><b><font
					size="1" face="ms sans serif" color="#FFFFFF">LoanProduct</font></b></td>
				<%
					if (loan_selecttype.equalsIgnoreCase("H")
							|| loan_selecttype.equalsIgnoreCase("V")) {
				%>
				<td width="15%" height="16" class="tabinactive"><b><font
					size="1" face="ms sans serif"><a
					href="javascript:callProposedAsset()" class="blackfont">Proposed
				Asset</a></font></b></td>
				<%
					}
				%>
				<td width="15%" height="16" class="tabinactive"><font
					face="MS Sans Serif" size="1"><b><font color="#CCCCCC"><a
					href="JavaScript:callCoAppGuarantor()" class="blackfont">Co-Applicant
				/ Guarantor</a></font></b></font></td>

				<%
					if (strCanaraSyndBank.equalsIgnoreCase("C")) {
				%>
				<td width="15%" height="16" class="tabinactive"><font
					face="MS Sans Serif" size="1"><b><font color="#CCCCCC"><a
					href="JavaScript:call_Canara_EligibleReview()" class="blackfont">
				Eligible for Review </a></font></b></font></td>

				<%
					} else {
				%>
				<td width="15%" height="16" class="tabinactive"><font
					face="MS Sans Serif" size="1"><b><font color="#CCCCCC"><a
					href="JavaScript:callEligibleReview()" class="blackfont">
				Eligible for Review </a></font></b></font></td>

				<%
					}
				%>
				<%
					if (loan_selecttype.equalsIgnoreCase("H")
							&& (loan_pmayYES.equalsIgnoreCase("1"))) {
				%>
				<td width="15%" height="16" class="tabinactive"><b><font
					size="1" face="ms sans serif"><a
					href="javascript:callPMAYFunction()" class="blackfont">PMAY
				House Details</a></font></b></td>
				<%
					}
				%>

			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><img id="img_loadder"
			src="<%=ApplicationParams.getAppUrl()%>/img/loading.gif"
			/ style="height: 50px;"></td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="3"
	height="380" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	class="outertablecolor">
	<tr>
		<td valign="top">

		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td valign="top">
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>
								<table width="97%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2">



											<tr>
												<td width="8%"><font size="1" face="MS Sans Serif">Applicant
												Name <b></b></font></td>

												<td width="15%"><font size="1" face="MS Sans Serif"
													color="Blue"> <%=Helper.correctNull((String) bowname)%>
												</font></td>
												<td width="20%"><font size="1" face="MS Sans Serif">Selected
												Product Code <b></b></font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"
													color="Blue"> <%=Helper.correctNull((String) hshValues.get("prdcode"))%>
												</font>&nbsp;</td>
												<%
													if (strCanaraSyndBank.equalsIgnoreCase("S")) {
												%>
												<td width="20%"><font size="1" face="MS Sans Serif">&nbsp;
												<%
													String strOnOff = Helper.correctNull((String) hshValues
																.get("Module"));

														if (strOnOff.equalsIgnoreCase("ONLINE")) {
												%> Online Reference No. <%
													} else {
												%> Inward No. <%
													}
												%> <font color="red">*</font></font></td>
												<td><input type="text" name="txt_InwardNo" readOnly
													value="<%=Helper.correctNull((String) hshValues
								.get("loan_inwardno"))%>" />
												<b><span onClick="callInwardNoSearch()"
													style="cursor: hand">?</span></b></td>
												<%
													}
												%>
											</tr>

											<tr>
												<td id="cbs_relation"
													style="visibility: hidden; position: absolute;" width=""
													align="left"><font size="1" face="MS Sans Serif">Customer
												Relation<font size="1" face="MS Sans Serif" color="#FF0000">*</font>
												</font></td>
												<td id="cbs_relation1"
													style="visibility: hidden; position: absolute;" width=""
													align="left"><font size="1" face="MS Sans Serif">
												<select name="txt_custrelation"
													onchange="callChekcRelationShip();callCustomerrelation();">
													<option value="s" selected>---Select---</option>
													<option value="SOW">SOW-Sole Owner</option>
													<option value="JOF">JOF-Joint Or First</option>
													<option value="JAF">JAF-Joint And First</option>
												</select> </font></td>

											</tr>


											<tr>
												<td colspan="3"><font size="1" face="MS Sans Serif"><b>Define
												Loan Product</b></font></td>
												<td width="25%">&nbsp;</td>
												<td colspan="2"><font size="1" face="MS Sans Serif">
												</font></td>
											</tr>
											<tr>
												<td width="">
												<div align="left"><font size="1" face="MS Sans Serif">Product<b><font
													size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font></div>
												</td>

												<td colspan="4"><font size="1" face="MS Sans Serif">
												<input type="text" name="txtprd_desc" size="80"
													class="cbsstyle" maxlength="100"
													value="<%=Helper.correctNull((String) hshValues.get("prddesc"))%>">
												<font size="1"><b><span onClick="callDescHelp1()"
													style="cursor: hand"><img
													src="<%=ApplicationParams.getAppUrl()%>img/Search.png"
													style="border: none" align="middle" height="25px"></span></b></font></font></td>
											</tr>
											<tr>
												<td width="">
												<div align="left"><font size="1" face="MS Sans Serif">Amount
												Requested <b><font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></b></font></div>
												</td>
												<td width="">
												<div align="left"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%>
												<input type="text" name="txtloan_amtreqd" size="15"
													align="right" style="text-align: right" maxlength="12"
													VALUE="<%=Helper.correctNull((String) hshValues.get("amtreqd"))%>"
													onBlur="callOnAmtReqstd();getInterestValue();CheckIntegerVal(document.forms[0].txtloan_amtreqd)"
													onKeyPress="return allowIntegerOne(event);allowInteger(document.forms[0].txtloan_amtreqd)">
												&nbsp; <%=Helper.correctNull((String) hshValues
									.get("NsdlAmtReqd"))%></font></div>
												</td>

												<td width="25%" nowrap="nowrap"><font
													face="MS Sans Serif" size="1">No.of Installment</font></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="25%"><font face="MS Sans Serif" size="1">
												<input type="text" name="txt_noofinstallments" size="15"
													maxlength="15"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_noofinstall"))%>"
													style="text-align: right"
													onblur="calcnoofinstall();negValueAler();chkminmaxterms();getterms();">
												</font></td>
												<!--	<td width="25%"><font size="1" face="MS Sans Serif">Term
												of the Loan(Inclusive of Moratorium)</font><b><font size="1"
													face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%">&nbsp;</td>
												<td width="15%">
												<div align="left"><b><font size="1" face="MS Sans Serif">
												<input type="text" name="txtloan_reqterms" size="15"
													style="text-align: right" class="cbsstyle"
													value="<%=Helper.correctNull((String) hshValues.get("lreqterms"))%>"
													onKeyPress="return allowIntegerOne(event);allowInteger();"
													onBlur="chkminmaxterms();calcnoofinstall();getterms();" maxlength="3" >&nbsp; <%=Helper.correctNull((String) hshValues.get("NsdlTerm"))%></font></b></div>
													
												</td> -->
											</tr>
											<tr>
												<td width=""><font size="1" face="MS Sans Serif">Cost
												of Project<b><font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></b></font></td>
												<td width="5%">
												<div align="left"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%>
												<font size="1" face="MS Sans Serif"> <b> <font
													size="1" face="MS Sans Serif"> <input type="text"
													name="txtloan_costloanprd" size="15"
													style="text-align: right" maxlength="12"
													value="<%=Helper.correctNull((String) hshValues.get("cloanprd"))%>"
													onKeyPress="return allowIntegerOne(event);allowInteger(document.forms[0].txtloan_costloanprd);"
													onBlur="callOnCostLoan();getterms();InterestRate();CheckIntegerVal(document.forms[0].txtloan_costloanprd);costCheck(document.forms[0].txtloan_costloanprd.value);">&nbsp;
												<%=Helper.correctNull((String) hshValues
							.get("NsdlCostOfProject"))%>
												</font></b> </font></font></div>
												</td>
												<td width="25%"><font size="1" face="MS Sans Serif">MinTerm
												(in months)</font></td>
												<td width="5%">&nbsp;</td>
												<td width="5%">
												<div align="left"><font size="1" face="MS Sans Serif">
												<input type="text" name="txtloan_minterms" size="5"
													class="cbsstyle" style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues
							.get("prd_min_terms"))%>"
													onKeyPress="allowNumber(document.forms[0].txtloan_minterms)"
													maxlength="3">&nbsp; </font></div>
												</td>

												<!--   <td width="25%"><font size="1" face="MS Sans Serif">Terms </font></td>
                 <td width="5%">&nbsp;</td>
                 <td width="15%"> 
                 <div align="left"><font size="1" face="MS Sans Serif"> &nbsp; 
                 <input type="hidden" name="txtloan_terms" size="15"  style="text-align:right" value="<%=Helper.correctNull((String) hshValues
									.get("lterms"))%>" 
				onKeyPress="allowNumber(document.forms[0].txtloan_terms)" >
                <font size="1" face="MS Sans Serif">           
			   <input type="text" name="txtloan_termrange" size="15"  style="text-align:right" value="<%=Helper.correctNull((String) hshValues
							.get("loantermrange"))%>" 
			   onKeyPress="allowNumber(document.forms[0].txtloan_terms)" >
               </font><font size="2"><b><a href="#" onClick="JavaScript:callInterestHelp()" class="blackfont">?</a></b></font></font></div>
                                    </td> -->
											</tr>
											<tr>
												<td width="25%"><font size="1" face="MS Sans Serif">Interest
												Type</font><font size="1" face="MS Sans Serif" color="#FF0000">*
												</font></td>

												<td width="24%"><input type="hidden" name="int_type"
													size="15"
													value="<%//=Helper.correctNull((String)hshValues.get("loaninttype"))%>">
												<select name="selectinttype1" onChange="callintbrcheck()">
													<option value="1" selected>Floating</option>
													<option value="2">Fixed</option>
												</select></td>
												<td width="25%"><font size="1" face="MS Sans Serif">MaxTerm
												(in months)</font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><!--  <div align="left"><font size="1" face="MS Sans Serif">  -->
												<input type="text" name="txtloan_maxterms" size="5"
													class="cbsstyle" style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues
							.get("prd_max_terms"))%>"
													onKeyPress="allowNumber(document.forms[0].txtloan_maxterms)"
													maxlength="3">&nbsp;</td>

											</tr>

											<tr id="schedtype"
												style="visibility: hidden; position: absolute;">
												<td width="25%"><font size="1" face="MS Sans Serif">Schedule
												Code </font> <font size="1" face="MS Sans Serif" color="#FF0000">*
												</font></td>

												<td width="24%"><font size="1" face="MS Sans Serif">
												<select name="txt_schedutype" id="cbs_schedule"
													onchange="checkMorator();callRateChatChange();">
													<option value="s">---Select---</option>

												</select> </font></td>
												<td width="25%"><font size="1" face="MS Sans Serif">Rate
												Chart Code </font><font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><select name="txt_ratechatcode"
													onchange="callRateChatChange();">
													<option value="s">---select---</option>
												</select></td>
											</tr>


											<tr>

												<%
													if (strappstatus.equalsIgnoreCase("ca")
															&& !MCLRFLAG.equalsIgnoreCase("")) {
												%>
												<td width="25%"><font size="1" face="MS Sans Serif">Base
												Rate</font></td>
												<%
													} else {
												%>
												<td width="25%"><font size="1" face="MS Sans Serif">MCLR/RLLR
												</font></td>
												<%
													}
												%>

												<td width="25%"><font size="1" face="MS Sans Serif">
												<input type="text" class="cbsstyle" name="txtloan_intrate"
													size="15" align="right" style="text-align: right"
													value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("interestrate"))))%>"
													onfocus="invoketitle()"
													onKeyPress="allowNumber(document.forms[0].txtloan_intrate)"
													onBlur="roundtxt(document.forms[0].txtloan_intrate);InterestRate()">
												</font></td>
												<td width="25%"><font size="1" face="MS Sans Serif">Variance
												</font></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="15%"><font size="1" face="MS Sans Serif">
												<input type="text" name="txt_var" size="15" align="right"
													style="text-align: right"
													onKeyPress="allowNegtiveNumber(document.forms[0].txt_var);"
													maxlength="12"
													value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("loanvariance"))))%>"
													onBlur="checkbasediff();roundtxt(document.forms[0].txt_var);checkVariance();InterestRate();">
												</font></td>
											</tr>
											<%
												if (strCanaraSyndBank.equalsIgnoreCase("C")) {
											%>
											<tr>
												<td width="25%"><font size="1" face="MS Sans Serif">Product
												Level Variance </font></td>
												<td width="15%"><font size="1" face="MS Sans Serif">
												<input type="text" name="txt_prodlevelvar" size="15"
													align="right" style="text-align: right"
													onKeyPress="allowNumber(document.forms[0].txt_prodlevelvar)"
													maxlength="12"
													value="<%=nf.format(Double.parseDouble(Helper
								.correctDouble((String) hshValues
										.get("LOAN_PRD_VARIANCE"))))%>"
													onBlur="roundtxt(document.forms[0].txt_prodlevelvar);InterestRate();">
												</font></td>
											</tr>
											<%
												}
											%>
											<tr>

												<td width="25%"><font size="1" face="MS Sans Serif">Floating/Fixed
												Interest Rate p.a. %</font><b><font size="1"
													face="MS Sans Serif" color="#FF0000">* </font></b></td>

												<td width="25%"><font size="1" face="MS Sans Serif">
												<input type="text" name="txtloan_modintrate" size="15"
													style="text-align: right" maxlength="5"
													onKeyPress="allowNumber(document.forms[0].txtloan_modintrate)"
													value="<%=Helper.correctNull((String) hshValues.get("mintrate"))%>"
													onBlur="InterestRate();"> </font></td>
												<td width="25%"><font face="MS Sans Serif" size="1">
												Moratorium Period in months(Repayment Holiday) </font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="15%"><font face="MS Sans Serif" size="1">
												<!-- kannan --> <input type="text" name="txt_installments"
													size="15" maxlength="3" class="cbsstyle"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_noofinstallment"))%>"
													onKeyPress="return allowIntegerOne(event);allowInteger();"
													style="text-align: right" onBlur="callMoratoriumPeroid();">
												</font></td>
											</tr>

											<tr>
												<td width="25%"><font face="MS Sans Serif" size="1">Periodicity
												of Installments <b><font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></b></font></td>

												<td width="25%"><font face="MS Sans Serif" size="1">
												<select name="sel_peridicity"
													onChange="getrepayment();interestselect()">
													<option value="m" selected>Monthly</option>
												</select> </font></td>

												<td width="25%"><font size="1" face="MS Sans Serif">Term
												of the Loan(Inclusive of Moratorium)</font><b><font size="1"
													face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%">&nbsp;</td>
												<td width="15%">
												<div align="left"><b><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtloan_reqterms" size="15" style="text-align: right"
													class="cbsstyle"
													value="<%=Helper.correctNull((String) hshValues.get("lreqterms"))%>"
													onKeyPress="return allowIntegerOne(event);allowInteger();"
													onBlur="chkminmaxterms();calcnoofinstall();getterms();"
													maxlength="3">&nbsp; <%=Helper.correctNull((String) hshValues.get("NsdlTerm"))%></font></b></div>

												</td>
												<!-- 	<td width="25%" nowrap="nowrap"><font face="MS Sans Serif" size="1">No.of Installment</font></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="25%"><font face="MS Sans Serif" size="1">
												 <input type="text" name="txt_noofinstallments" size="15" maxlength="15"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_noofinstall"))%>" 
													style="text-align: right" onblur="calcnoofinstall();">
												</font></td> -->
											</tr>
											<tr id="id_pmayscheme">
												<td width="25%" id="id_pmayscheme1"><font
													face="MS Sans Serif" size="1">Whether the Proposal
												comes under PMAY Scheme ?</font> <b><font size="1"
													face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="10%" id="id_pmayscheme2"><font
													face="MS Sans Serif" size="1"> <select
													name="sel_pmayscheme">
													<option value="0">--Select--</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></font></td>
											</tr>
											<tr>
												<td width="35%"><font face="MS Sans Serif" size="1">Remarks</font></td>
												<td width="35%" colspan="4"><textarea rows="5"
													cols="50" name="txt_remrks"
													onkeyup="textlimitcorp(this,500);notAllowSingleAndDoubleQuote()"
													onkeypress="textlimitcorp(this,500);notAllowSingleAndDoubleQuote()"><%=Helper.correctNull((String) hshValues
									.get("loanremarks"))%></textarea></td>
											</tr>
											<tr>
												<!--  <td width="25%"><font face="MS Sans Serif" size="1"> 
                                      Interest serviced during Moratorium</font></td>
                                    <td width="5%"><font face="MS Sans Serif" size="1"></font></td>
                                    <td width="24%"> <font face="MS Sans Serif" size="1"> 
                                      <select name="interestservised" onchange ="interestselect();clearmonpay();getrepayment()">
                                        <option value="s" selected>Select</option>
                                        <option value="n">No</option>
                                        <option value="y">Yes</option>
                                      </select>
                                      </font></td> -->
												<td width="25%"><font face="MS Sans Serif" size="1">
												Whether as per Sanction terms, moratorium period monthly
												interest will be paid by the borrower every month ?</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="24%"><font face="MS Sans Serif" size="1">
												<select name="interestservised" onchange="callCheckIOI();">
													<option value="s" selected>------Select------</option>
													<option value="y" selected>------Yes------</option>
													<option value="n" selected>------No------</option>
												</select> </font></td>

												<td width="25%" id="id_1bank"><font
													face="MS Sans Serif" size="1">Whether the Loan is
												for</font></td>
												<td width="5%" id="id_2bank"><font face="MS Sans Serif"
													size="1"></font></td>
												<td width="15%" id="id_3bank"><font
													face="MS Sans Serif" size="1"> <select
													name="sel_house" onchange="getHouseLoan();">
													<option value="s" selected>----Select----</option>
													<option value="1" selected>1st House</option>
													<option value="2" selected>2nd House</option>
													<option value="3" selected>3rd House</option>
												</select> </font></td>
											</tr>

											<tr>
												<td width="25%" id="id_bank1"><font
													face="MS Sans Serif" size="1">Loan for First house
												availed with</font></td>
												<td width="5%" id="id_bank2"><font face="MS Sans Serif"
													size="1"></font></td>
												<td width="24%" id="id_bank3"><font
													face="MS Sans Serif" size="1"><input type="text"
													name="txt_firstbank" onkeypress="allowAlphabets();"
													size="15" maxlength="30"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_firstbank"))%>"></font></td>
												<td width="25%" id="id_bank4"><font
													face="MS Sans Serif" size="1">Loan for Second house
												availed with</font></td>
												<td width="5%" id="id_bank5"><font face="MS Sans Serif"
													size="1"></font></td>
												<td width="15%" id="id_bank6"><font
													face="MS Sans Serif" size="1"><input type="text"
													name="txt_secondbank" onkeypress="allowAlphabets();"
													size="15" maxlength="30"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_secondbank"))%>"></font></td>
											</tr>



											<tr>
												<td width="25%" id="id_charges1"><font
													face="MS Sans Serif" size="1">Stamp duty</font></td>
												<td width="24%" id="id_charges3"><font
													face="MS Sans Serif" size="1"> <input type="text"
													name="txt_Stampduty" size="15" maxlength="15"
													value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("loan_Stampduty"))))%>"
													onKeyPress="allowInteger(document.forms[0].txt_Stampduty);"
													style="text-align: right"></font></td>

												<td width="25%" id="id_charges4"><font
													face="MS Sans Serif" size="1">Documentation charges</font></td>
												<td width="5%" id="id_charges5"><font
													face="MS Sans Serif" size="1"></font></td>
												<td width="24%" id="id_charges6"><font
													face="MS Sans Serif" size="1"> <input type="text"
													name="txt_Documentationcharges" size="15" maxlength="15"
													value="<%=Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("loan_Documentationcharges")))%>"
													onKeyPress="allowInteger(document.forms[0].txt_Documentationcharges);"
													style="text-align: right"></font></td>

												<td width="25%" id="id_charges7"><font
													face="MS Sans Serif" size="1">Registration charges</font></td>
												<td width="5%" id="id_charges8"><font
													face="MS Sans Serif" size="1"></font></td>
												<td width="24%" id="id_charges9"><font
													face="MS Sans Serif" size="1"> <input type="text"
													name="txt_Registrationcharges" size="15" maxlength="15"
													value="<%=Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("loan_Registrationcharges")))%>"
													onKeyPress="allowInteger(document.forms[0].txt_Registrationcharges);"
													style="text-align: right"> </font></td>
											</tr>
											<tr>
												<td></td>
											</tr>

										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="97%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2">
											<tr>
												<td width="22%"><font size="1" face="MS Sans Serif">Study
												Region </font>&nbsp;<font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></td>
												<td width="5%">&nbsp;</td>
												<td width="23%"><font size="1" face="MS Sans Serif"><select
													name="sel_StudyRegion" style="width: 40%"
													onchange="callCourse()">
													<option value="S" selected="selected">--Select--</option>
													<lapschoice:StaticDataTag apptype="151" />
												</select></td>

												<td width="24%"><font size="1" face="MS Sans Serif">Course
												Type </font>&nbsp;<font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></td>
												<td width="6%">&nbsp;</td>
												<td width="24%"><font size="1" face="MS Sans Serif">
												<select name="sel_CourType" onchange="callCourse()"
													style="width: 45%">
													<option value="S" selected="selected">--Select--</option>
													<lapschoice:StaticDataTag apptype="153" />
												</select></td>
											</tr>
											<tr>
												<td width="22%"><font size="1" face="MS Sans Serif">Course
												</font>&nbsp;<font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
												<td width="5%">&nbsp;</td>
												<td width="23%" id="id_course"><font
													face="MS Sans Serif" size="1"> <select
													name="sel_Course" onchange="callCourse();">
													<option value="S">---Select---</option>
												</select></font></td>
												<td width="23%" id="id_course1"><font
													face="MS Sans Serif" size="1"> <input type="text"
													name="txt_Course" size="20" maxlength="15"
													value="<%=Helper.correctNull((String) hshValues
									.get("COURSE_DAY0"))%>"
													onKeyPress="return allowAlphaNumericOne(event);"
													style="text-align: right;" onblur=""></font></td>

												<td width="24%"><font size="1" face="MS Sans Serif">Course
												Duration (in months) </font>&nbsp;<font size="1"
													face="MS Sans Serif" color="#FF0000">*</font></td>
												<td width="6%">&nbsp;</td>
												<td width="23%"><font face="MS Sans Serif" size="1">
												<input type="text" name="txt_CourDuration" size="20"
													maxlength="2"
													value="<%=Helper.correctNull((String) hshValues
									.get("edu_duration"))%>"
													onKeyPress="return allowIntegerOne(event);allowInteger();"
													style="text-align: left;"
													onblur="calRemDuration();negValueAler();chkminmaxterms();"></font></td>
											</tr>
											<tr>
												<td width="22%"><font size="1" face="MS Sans Serif">Course/Semester
												Commencement Date </font>&nbsp;<font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></td>
												<td width="5%">&nbsp;</td>
												<td width="23%"><font size="1" face="MS Sans Serif">
												</font><font size="1" face="MS Sans Serif"> <input
													type="text" name="txt_Course_CommDate" size="20"
													value="<%=Helper.correctNull((String) hshValues
							.get("COURSE_SEM_COMMENCE_DATE"))%>"
													onBlur="checkDate(this);calCourCompletion();"
													maxlength="10"> </font> <a alt="Select date from calender"
													href="#" onClick="callCalender7()"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender"></a></td>

												<td width="24%"><font size="1" face="MS Sans Serif">Loan
												availing from Semester </font>&nbsp;<font size="1"
													face="MS Sans Serif" color="#FF0000">*</font></td>
												<td width="6%">&nbsp;</td>
												<td width="23%"><font size="1" face="MS Sans Serif"><select
													name="sel_LoanAvail_ForSem"
													onchange="calRemDuration();negValueAler();chkminmaxterms();calCourCompletion();callAvailingSeminfo();"
													style="width: 45%">
													<option value="S" selected="selected">--Select--</option>
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
												<a href="javascript:callsemInfo();" style="text-decoration: underline">Know More</a>
                                              </td>
											</tr>
											<tr>
												<td width="22%"><font size="1" face="MS Sans Serif">Remaining
												Course Duration (in months) </font>&nbsp;<font size="1"
													face="MS Sans Serif" color="#FF0000">*</font></td>
												<td width="5%">&nbsp;</td>
												<td width="23%"><font size="1" face="MS Sans Serif">
												<input type="text" name="txt_RemDuration" size="20"
													maxlength="25"
													value="<%=Helper.correctNull((String) hshValues
							.get("COURSE_REMAINING_DURATION"))%>"
													onKeyPress="" style="text-align: left;"></font></td>

												<td width="24%"><font size="1" face="MS Sans Serif">Course
												Completion Date </font>&nbsp;<font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></td>
												<td width="6%">&nbsp;</td>
												<td width="24%"><font size="1" face="MS Sans Serif">
												</font><font size="1" face="MS Sans Serif"> <input
													type="text" name="txt_CourCompDate" size="20"
													value="<%=Helper.correctNull((String) hshValues
							.get("EDU_COURCOMPLETION_DATE"))%>"
													onBlur="checkDate(this);" maxlength="10"> </font></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="97%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
									align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2">
											<tr>
												<td width="30%"><font size="1" face="MS Sans Serif">Probable
												Date of Disbursement<b><font size="1"
													face="MS Sans Serif" color="#FF0000">*</font></b></font></td>
												<td width="5%">&nbsp;</td>
												<td width="1%"><font size="1" face="MS Sans Serif">
												</font><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtloan_emidate" size="14"
													value="<%=Helper.correctNull((String) hshValues.get("emidate"))%>"
													onBlur="checkDate(this);checkProDisbDate(this);calculateMaturityDate()"
													maxlength="10"> </font><a alt="Select date from calender"
													href="#" onClick="callCalender1()"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender"></a></td>
												<td width="5%">&nbsp;</td>
												<td width="50%"><font size="1" face="MS Sans Serif">EMI
												Commencement Date <b><font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></b></font></td>
												<td width="%"></td>
												<td width="1%"><input type="text"
													name="txtloan_emicommdate" size="15"
													value="<%=Helper.correctNull((String) hshValues
									.get("emicommdate"))%>"
													onBlur="checkDate(this)" maxlength="10"> <!-- <a alt="Select date from calender"  href="#" onClick="callCalender4()" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border=0 alt="Select date from calender"></a> </td>-->
												</td>
											</tr>
											<tr>
												<td width="30%"><font face="MS Sans Serif" size="1">
												Loan Type</font><font size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font>&nbsp;</td>
												<td width="1%"><font face="MS Sans Serif" size="1">
												<select name="selecttype" onBlur="CallLoanType()"
													onChange="ListPurpose()">
													<%
														if (strCanaraSyndBank.equalsIgnoreCase("C")) {
													%>
													<option value="S">Select</option>
													<option value="C" selected>Education Loan</option>
													<%
														} else {
													%>
													<option value="S" selected>Select</option>
													<option value="H">Housing Loan</option>
													<option value="V">Vehicle Loan</option>
													<option value="C">Contingent Loan</option>
													<%
														}
													%>
												</select> </font></td>
												<td width="1%"><font face="MS Sans Serif" size="1">&nbsp;</font></td>
												<td width="50%" id="sel1" style="visibility: visible"><font
													face="MS Sans Serif" size="1">Select Scheme</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												<td width="%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="1%" id="sel2" style="visibility: visible"><font
													face="MS Sans Serif" size="1"> <select
													name="selectpurpose"
													onChange="fixpurpose();checkmahila();callDICVariance();"
													onblur="maxloan();">
												</select> </font></td>
												<td width="25%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="15%"><font face="MS Sans Serif" size="1"></font></td>
											</tr>
											<tr>
												<td width="30%"><font size="1" face="MS Sans Serif">Purpose
												of Loan <b><font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></b></font></td>
												<td width="5%">&nbsp;</td>
												<td colspan="2"><font size="1" face="MS Sans Serif">
												</font><b><font size="1" face="MS Sans Serif"><font
													size="1" face="MS Sans Serif"> <input type="text"
													name="txtloan_purposeofloan" maxlength="40" size="40"
													onKeyPress="return allowAlphaNumericOne(event);"
													onKeyDown="return DisableCopyPaste(event)"
													value="<%=Helper.correctNull((String) hshValues
							.get("loanpurposeofloan"))%>"
													maxlength="100" onBlur="CallPurpose()"
													onfocus="emicommdate()"> </font> </font></b></td>
												<td width="50%"><font size="1" face="MS Sans Serif">Proposed
												Loan Amount <b><font size="1" face="MS Sans Serif"
													color="#FF0000">*</font></b></font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<!-- chksyndnvzpluz() -->
												<td width="10%">
												<div align="left"><font size="1" face="MS Sans Serif">
												<input type="text" name="txtloan_sancamt" size="15"
													maxlenght="9" style="text-align: right"
													onKeyPress="allowInteger(document.forms[0].txtloan_sancamt)"
													onBlur="callProp();callSanc();calminmargin();"
													onFocus="checkemiandprobdate()"
													value="<%=nf.format(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("sancmount"))))%>"
													readOnly> </font></div>
												</td>
											</tr>
											<tr>
												<td width="30%" style="visibility: hidden"><font
													size="1" face="MS Sans Serif"> <!-- Trade 
                                      in Value --> Down Payment on Loan</font></td>
												<td width="5%" style="visibility: hidden"><font
													size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td colspan="2" style="visibility: hidden"><input
													type="hidden" name="txtloan_tradein" size="15"
													style="text-align: right" maxlength="12"
													value="<%=Helper.correctNull((String) hshValues.get("tradein"))%>"
													onKeyPress="allowNumber(document.forms[0].txtloan_tradein)"
													onBlur="roundtxt(document.forms[0].txtloan_tradein)">
												<b><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtloan_downpay" size="15"
													style="text-align: right" maxlength="12" readOnly
													value="<%=Helper.correctNull((String) hshValues.get("downpay"))%>"
													onKeyPress="allowNumber(document.forms[0].txtloan_downpay)">
												</font></b></td>
												<td width="50%"><font size="1" face="MS Sans Serif">
												Margin (% )</font></td>
												<td width="5%">&nbsp;</td>
												<td width="10%">
												<div align="left"><font size="1" face="MS Sans Serif">
												<input type="text" name="txtRecLoanValRatio" size="15"
													style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues
									.get("lvalueratio"))%>"
													onKeyPress="allowNumber(document.forms[0].txtRecLoanValRatio)"
													onBlur="checkage();" readOnly><!-- getmarginamount(); this calculation is not required for that we have included this calculation calminmargin() as per Mr.Katti 20072009-->
												</font></div>
												</td>
											</tr>
											<tr>
												<td width="30%"><font size="1" face="MS Sans Serif">
												<!-- Loan 
                                      on Trade In --> Monthly Payment </font><font
													size="1" face="MS Sans Serif" color="#FF0000">*</font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td colspan="2"><b><font size="1"
													face="MS Sans Serif"> <input type="hidden"
													name="txtloan_loantrade" size="15"
													style="text-align: right" maxlength="12"
													value="<%=Helper.correctNull((String) hshValues.get("loantrade"))%>"
													onKeyPress="allowNumber(document.forms[0].txtloan_loantrade)"
													onBlur="roundtxt(document.forms[0].txtloan_loantrade)">
												<input type="text" name="txtmonPay" size="15"
													style="text-align: right"
													value="<%=nf
							.format(Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("loan_emi"))))%>"
													onKeyPress="allowNumber(document.forms[0].txtmonPay)"
													onBlur="emialert()"> </font></b> <%
 	if (strCanaraSyndBank.equalsIgnoreCase("S")) {
 %>
												<input type="text" name="txtaltermonpay" maxlenght="9"
													size="15" style="text-align: right" maxlength="12"
													value="<%=Helper.correctNull((String) hshValues
										.get("monthpay"))%>"
													onKeyPress="allowNumber(document.forms[0].txtaltermonpay)">
												<%
													}
												%>
												</td>
												<td width="50%"><font size="1" face="MS Sans Serif">
												<!-- Actual 
                                      Loan to Value Ratio (%) --> Margin
												Amount</font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="10%">
												<div align="left"><font size="1" face="MS Sans Serif">
												<input type="hidden" name="actLoanValRatio" size="15"
													style="text-align: right"
													value="<%//=Helper.correctNull((String)hshValues.get("actuallvalratio"))%>"
													onKeyPress="allowNumber(document.forms[0].actLoanValRatio)">
												<input type="text" name="txtloan_recmdamt" size="15"
													style="text-align: right"
													value=<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("actuallvalratio"))))%>
													readOnly> </font></div>
												</td>
											</tr>
											<tr id="docfee">
												<td width="30%"><font size="1" face="MS Sans Serif">
												<!-- Loan 
                                      on Trade In --> Documentation Fee
												</font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td colspan="2"><b><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtloan_docfee" size="15" style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues
									.get("docfee"))%>">
												</font></b></td>
												<td width="50%" style="visibility: hidden"><font
													size="1" face="MS Sans Serif">Total Payment Through
												End of Loan Term&nbsp;</font></td>
												<td width="5%" style="visibility: hidden"><font
													size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td width="10%" style="visibility: hidden">
												<div align="left"><font size="1" face="MS Sans Serif">
												<input type="text" name="txttotPayment" size="15"
													style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues.get("totalpay"))%>"
													onKeyPress="allowNumber(document.forms[0].txttotPayment)">
												</font></div>
												</td>
											</tr>
											<tr>
												<td width="30%"><font size="1" face="MS Sans Serif">Actual
												Processing Fee&nbsp;</font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td colspan="2"><b><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtloan_procfee" size="15" style="text-align: right"
													class="cbsstyle"
													value="<%=Helper.correctNull((String) hshValues.get("procfee"))%>">
												<input type="hidden" name="txtnetTradeIn" size="15"
													style="text-align: right" maxlength="12"
													value="<%=Helper.correctNull((String) hshValues.get("netTradein"))%>"
													onBlur="callnetTrade();roundtxt(document.forms[0].txtnetTradeIn)"
													onKeyPress="allowNumber(document.forms[0].txtnetTradeIn)">
												</font></b></td>
												<td width="50%"><font size="1" face="MS Sans Serif">Repayment
												Type <b><font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></b></font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"></font></td>
												<td width="10%"><font size="1" face="MS Sans Serif">
												<select name="selrepaymenttype"
													onChange="showRepayment();showRepayButton()">
													<option value="1" selected><b><font size="1"
														face="MS Sans Serif">Equated Monthly Installment</font></b></option>
													<!--                     <%//							String strRepayType =  Helper.correctNull((String)hshValues.get("repaymenttype"));
			//					 	 	if(strRepayType.trim().equals("0"))	  
			//						 	{%>
                                        <option value="0" selected><b><font size="1" face="MS Sans Serif">----Select----</font></b></option>
                                        <%// }
			//								 else
			//							 {%>
                                        <option value="0"><b><font size="1" face="MS Sans Serif">----Select----</font></b></option>
                                        <%//}									
			//							if(strRepayType.trim().equals("1"))	  
			//							{%>
                                        <option value="1" selected><b><font size="1" face="MS Sans Serif">Equated 
                                        Monthly Installment</font></b></option>
                                        <%//}else
			//							{%>
                                        <option value="1" ><b><font size="1" face="MS Sans Serif">Equated 
                                        Monthly Installment</font></b></option>
                                        <%//}

			//							if(strRepayType.trim().equals("2"))	  
			//							{%>
                                        <option value="2" selected><b><font size="1" face="MS Sans Serif">Structured 
                                        Repayment Schedule</font></b></option>
                                        <%//}else
			//							{%>
                                        <option value="2" ><b><font size="1" face="MS Sans Serif">Structured 
                                        Repayment Schedule</font></b></option>
                                        <%//							}
			//							if(strRepayType.trim().equals("3"))	  
			//							{%>
                                        <option value="3" selected><b><font size="1" face="MS Sans Serif">OverDraft</font></b></option>
                                        <%//}else
			//							{%>
                                        <option value="3" ><b><font size="1" face="MS Sans Serif">OverDraft</font></b></option>
                                        <%//								}
			//								if(strRepayType.trim().equals("4"))	  
			//							{%>
                                        <option value="4" selected><b><font size="1" face="MS Sans Serif">OverDraft 
                                        - Reducing Limit</font></b></option>
                                        <%//}else
			//							{%>
                                        <option value="4"><b><font size="1" face="MS Sans Serif">OverDraft 
                                        - Reducing Limit</font></b></option>
                                        <%//								}%> -->
												</select> </font></td>
											</tr>

											<tr>
												<td width="30%"><font size="1" face="MS Sans Serif">Processing
												Fee to be charged&nbsp;</font><font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></td>
												<td width="5%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getCurrency()%></font></td>
												<td colspan="2"><b><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtloan_lapsprocfee"
													onKeyPress="allowNumber(document.forms[0].txtloan_lapsprocfee.value)"
													size="15" style="text-align: right"
													value="<%=Helper.correctNull((String) hshValues
									.get("lapsprocfee"))%>">
												</font></b></td>
												<td width="50%"></td>
												<td width="5%"></td>
												<td width="10%"></td>
											</tr>

											<tr>
												<td width="30%"><font face="MS Sans Serif" size="1">Whether
												Secured</font><font size="1" face="MS Sans Serif" color="#FF0000">*
												</font></td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td colspan="2"><font face="MS Sans Serif" size="1">
												<%
													if (strCanaraSyndBank.equalsIgnoreCase("S")) {
												%> <input
													type="text" name="sel_secured" size="15" maxlength="15"
													value="<%=Helper.correctNull((String) hshValues
								.get("loan_secure"))%>">
												<%
													} else {
												%> <select name="sel_secured">
													<option value="s">---Select---</option>
													<option value="y">Yes</option>
													<option value="n">No</option>
												</select> <%
 	}
 %> </font></td>
												<!-- <td width="50%"><font size="1" face="MS Sans Serif">Maturity Date </font></td>
                                    <td width="%"></td>
                                    <td width="1%"> <font size="1" face="MS Sans Serif"> 
                                      <input type="text" name="txtloan_maturitydate" size="15" value="" maxlength="10">
                                       <a alt="Select date from calender"  href="#" onClick="callCalender4()" onMouseOver="window.status='Date Picker';return true;" onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  border=0 alt="Select date from calender"></a> -->

												<td width="50%"><span id="secure"><font
													face="MS Sans Serif" size="1">Amount Secured</font></span>&nbsp;</td>
												<td width="5%"><font face="MS Sans Serif" size="1"></font></td>
												<td width="10%"><font face="MS Sans Serif" size="1">
												<span id="secure1"> <input type="text"
													name="txt_secured" size="15" maxlength="15"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_secureamount"))%>"></span>&nbsp;</font></td>
											</tr>
											<!-- date of -->
											<tr id="cbsmigfeild">
												<td width="25%"><font size="1" face="MS Sans Serif">Date
												basis for Account Rate</font> <font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font size="1" face="MS Sans Serif">
												<select name="sel_datebasis">
													<option value="s">---Select---</option>
													<option value="2" selected="selected">First_disbursement_date</option>
													<!--  <option value="1">Account_opening_date </option>
											<option value="3">Letter_of_offer_date</option>-->

												</select> </font></td>
												<td width="5%">&nbsp;</td>
												<td width="25%"><font size="1" face="MS Sans Serif">Letter
												of offer date </font><font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><input type="text"
													name="date_offerletter"
													value="<%=Helper.correctNull((String) hshValues
							.get("laonofferdate"))%>"
													onBlur="checkDate(this);checkmaxdate1(this,currentDate);callAgreementDate();valForLettOfferDate();">
												<a alt="Select date from calender" href="#"
													onClick="callCalender6()"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender"></a></td>
											</tr>
											<tr id="cbsmigfeild1">
												<td width="25%"><font size="1" face="MS Sans Serif">Agreement
												sign date</font> <font size="1" face="MS Sans Serif"
													color="#FF0000">* </font></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font size="1" face="MS Sans Serif">
												<input type="text" name="date_agreementsign"
													value="<%=Helper.correctNull((String) hshValues
							.get("loanagreedate"))%>"
													onBlur="checkDate(this);checkmaxdate1(this,currentDate);callAgreementDate();">
												</font> <a alt="Select date from calender" href="#"
													onClick="callCalender5()"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border=0 alt="Select date from calender"></a></td>
												<%
													if (!Helper.correctNull((String) hshValues.get("APP_AGREEMENTNUM"))
															.equalsIgnoreCase("")) {
												%>
												<td width="5%">&nbsp;</td>
												<td width="25%"><font size="1" face="MS Sans Serif">Agreement
												Number </font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><input type="text"
													name="txt_agreementnumber"
													value="<%=Helper.correctNull((String) hshValues
								.get("APP_AGREEMENTNUM"))%>"
													readonly="readonly"></td>
												<%
													}
												%>
											</tr>
											<tr id="cbsmigfeild2">
												<td width="25%"><font size="1" face="MS Sans Serif">Producer
												ID</font></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font size="1" face="MS Sans Serif">
												<input type="text" name="sel_prdid"
													value="<%=Helper.correctNull((String) hshValues.get("APP_PROID"))%>">
												</font></td>
												<td width="5%">&nbsp;</td>
												<td width="25%"><font size="1" face="MS Sans Serif">Fixed
												Term </font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><input type="text" name="txt_fixedterm"
													readonly="readonly" value="0" onKeyPress="allowInteger()">Months</td>
											</tr>
											<tr id="cbsmigfeild3">
												<td width="25%"><font size="1" face="MS Sans Serif">LTV
												Ratio </font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><input type="text" name="txt_ltvratio"
													value="100" readonly="readonly" onKeyPress="allowInteger()"></td>
												<!-- <td width="5%">&nbsp;</td>
											<td width="25%"><font size="1" face="MS Sans Serif"><input type="checkbox" name="check_penalty" value="N" 
											onclick="toggleStateCheck(this)" />Apply Compounding Penalty Interest</font></td>
											<td width="5%">&nbsp;</td>
											<td width="24%"><font size="1" face="MS Sans Serif">
											</font></td>
											 -->
											</tr>
											<%
												if (!Helper
														.correctNull((String) hshValues.get("APP_APPLICATIONID"))
														.equalsIgnoreCase("")) {
											%>
											<tr>
												<td width="25%"><font size="1" face="MS Sans Serif">
												Application ID</font></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font size="1" face="MS Sans Serif">
												<input type="text" name="txt_appId"
													value="<%=Helper.correctNull((String) hshValues
								.get("APP_APPLICATIONID"))%>"
													readonly="readonly"></font></td>
												<td width="25%"><font size="1" face="MS Sans Serif">
												</font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%">&nbsp;</td>
											</tr>
											<%
												}
											%>
											<tr>

												<td width="25%"><font face="MS Sans Serif" size="1">Whether
												the proposal comes under PSB59<font size="1"
													face="MS Sans Serif" color="#FF0000">*</font> </font></td>
												<td width="5%">&nbsp;</td>
												<td width="24%" align="left"><font size="1"
													face="MS Sans Serif"> <select name="sel_PSB59"
													disabled="disabled" onchange="callPSB59();">
													<option value="s" selected="selected">--Select--</option>
													<lapschoice:StaticDataTag apptype="22" />
												</select> </font></td>
												<td width="5%">&nbsp;</td>
												<td width="24%" id="PSB59refno"><font
													face="MS Sans Serif" size="1">PSB59 Reference No<font
													size="1" face="MS Sans Serif" color="#FF0000">*</font> </font></td>
												<td id="PSB59refno1">&nbsp;</td>
												<!--
											    <td  id="PSB59refno2"><input type="text" name="txt_PSB59refno" MAXLENGTH="10" value="<%=Helper.correctNull((String) hshValues
							.get("LOAN_PSB59_REFNO"))%>" onblur="callPSB59RefNo();" onKeyPress="allowNumber(this);""></td>
											    -->
												<td id="PSB59refno2" width="15%" align="left"><font
													size="1" face="MS Sans Serif"> <select
													name="txt_PSB59refno" disabled="disabled">
													<option value="s" selected="selected">--Select--</option>
													<lapschoice:PSB59ReferrenceNo appno="<%=strappno1%>" />
												</select> </font></td>
											</tr>
											<tr>
												<td width="25%"><font size="1" face="MS Sans Serif">Agent
												Source Code</font><font size="1" face="MS Sans Serif"
													color="#FF0000"> </font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%">
												<div align="left"><b><font size="1"
													face="MS Sans Serif"> <input type="text" size="15"
													maxlength="10" name="txt_agnt_perloan"
													value="<%=Helper.correctNull((String) hshValues
							.get("AGENT_SRC_CODE"))%>"
													onkeypress="return allowNumeric(event);"
													onKeyDown="return DisableCopyPaste(event)"
													onMouseDown="return DisableCopyPaste(event)"> </font></div>
												</td>
											</tr>
											<%
												if (strCanaraSyndBank.equalsIgnoreCase("C")) {
											%>
											<tr>
												<td width="25%"><font size="1" face="MS Sans Serif">Sanction
												Authority </font>&nbsp;<span class="mantatory">*</span></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font size="1" face="MS Sans Serif"><select
													name="sel_sancauth">
													<option value="S">--Select--</option>
													<lapschoice:StaticDataTag apptype="66" />
												</select></td>
											</tr>
											<%
												}
											%>
											<tr>
												<td width="25%"><font face="MS Sans Serif" size="1">Drawdown</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font face="MS Sans Serif" size="1">
												<select name="sel_drawdown" onchange="drawdown();">
													<option value="s" selected>------Select------</option>
													<option value="Y" selected>Yes</option>
													<option value="N" selected>No</option>
												</select> </font></td>

												<td width="5%">&nbsp;</td>
												<td width="25%" id="id_drawdown1"><font
													face="MS Sans Serif" size="1">Remitter Account No</font><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></td>
												<td width="5%" id="id_drawdown2"><font
													face="MS Sans Serif" size="1"></font></td>
												<td width="15%" id="id_drawdown3"><font
													face="MS Sans Serif" size="1"> <input type="text"
													name="txt_drawremmaccno" onkeypress="allowAlphabets();"
													size="15" maxlength="30"
													value="<%=Helper.correctNull((String) hshValues
							.get("LOAN_DRAWDOWN_ACCNO"))%>"></font>
												<span id="search_icon1"><a
													href="javascript:doSearchAccount_Drawdown()"
													title="Click to View Account Number" id="search_icon1"
													class="blackfont"> <img
													src="<%=ApplicationParams.getAppUrl()%>img/Search.png"
													style="border: none" align="middle"></img> </a></span></td>
											</tr>
											<tr>
												<td width="25%" id="id_drawdown4"><font
													face="MS Sans Serif" size="1">Customer Name</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%" id="id_drawdown5">&nbsp;</td>
												<td width="24%" id="id_drawdown6"><font
													face="MS Sans Serif" size="1"> <input type="text"
													name="txt_drawcustname" size="15" maxlength="15"
													value="<%=Helper.correctNull((String) hshValues
							.get("LOAN_DRAWDOWN_CUSTNAME"))%>"
													onKeyPress="allowInteger(document.forms[0].txt_drawcustname);"
													style="text-align: right"></font></td>
											</tr>
                                            <tr>
												<td width="25%"><font face="MS Sans Serif" size="1">Repay Interest</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font face="MS Sans Serif" size="1">
												<select name="sel_repay_interest">
													<option value="s" selected>------Select------</option>
													<option value="Y" selected>Yes</option>
													<option value="N" selected>No</option>
												</select> </font></td>
												<td width="5%">&nbsp;</td>
                                                 <td width="25%"><font face="MS Sans Serif" size="1">Proposed Repayment By</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%">&nbsp;</td>
												<td width="24%"><font face="MS Sans Serif" size="1">
												<select name="sel_Pro_repay_by">
													<option value="s" selected>------Select------</option>
													<option value="student" >Student</option>
													<option value="parent" >Parent</option>
													<option value="guaran" >Guaran</option>
												</select> </font></td>
											</tr>
                                             <tr>
												<td width="25%"><font size="1" face="MS Sans Serif">Proposed Repayment Tenure</font></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><input type="text" name="txt_pro_repay_tenure"
													value="<%=Helper.correctNull((String)hshValues.get("NP_LOAN_REPAY_TENURE"))%>" onKeyPress="return allowIntegerOne(event);allowInteger();">Months</td>
                                                 <td width="5%">&nbsp;</td>
                                                 <td width="25%"><font face="MS Sans Serif" size="1">Proposed Repayment Amount</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><input type="text" name="txt_pro_repay_amount"
													value="<%=Helper.correctNull((String)hshValues.get("NP_LOAN_REPAY_AMOUNT"))%>" onKeyPress="return allowIntegerOne(event);allowInteger();"></td>
											</tr>
											<tr>
												 <td width="25%"><font face="MS Sans Serif" size="1">Subsidy Amount</font><b><font
													size="1" face="MS Sans Serif" color="#FF0000">* </font></b></td>
												<td width="5%">&nbsp;</td>
												<td width="15%"><input type="text" name="txt_subsidy_amount"
													value="<%=Helper.correctNull((String)hshValues.get("NP_LOAN_Subsidy_AMOUNT"))%>" onKeyPress="return allowIntegerOne(event);allowInteger();"></td>
											</tr>
											<tr>
												<td colspan="7"><font size="1" face="MS Sans Serif">
												</font> <b><font size="1" face="MS Sans Serif"> </font></b>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="2">
													<tr style="visibility: hidden;position: absolute;">
														<td id="calc1" width="36%"><font size="1"
															face="MS Sans Serif" color="#CC0000">EMI
														Calculation</font><font size="1" face="MS Sans Serif"> -
														Enter The Fields Marked with <font color="#FF0000">*
														</font><!-- and --> </font></td>
														<td id="calc2" width="19%"><font size="1"
															face="MS Sans Serif"> <input type="hidden"
															name="clickHere" value="Calculate" style="width: 130"
															class="buttoncolor" onClick="callCalculateInterest()">
														</font></td>
														<td width="27%" id="r1main"><font size="1"
															face="MS Sans Serif" color="#CC0000">Click here to
														view the Limit &amp; Eligibility</font></td>
														<td width="18%" id="hidecmdclick"><font size="1"
															face="MS Sans Serif"> <input type="button"
															name="cmdClick" value="Check Eligibility"
															style="width: 100" class="buttoncolor"
															onClick="callLimitofLoan()"> </font></td>
													</tr>

													<tr>
														<td width="36%"></td>
														<td width="19%"></td>
														<td width="27%" id="r1mortgage"><font size="1"
															face="MS Sans Serif" color="#CC0000">Click here to
														view the Limit &amp; Eligibility </font></td>
														<!-- synd Mortgage scheme -->
														<td width="18%" id="hidecmdmortgage"><font size="1"
															face="MS Sans Serif"> <input type="button"
															name="cmdmortgage" value="Check Eligibility"
															style="width: 100" class="buttoncolor"
															onClick="callmortgageLimitofLoan('perlimitmortgage.jsp','getsyndlaghuudyamiData');"><!-- getsyndmortgageData -->
														</font></td>
														<!-- synd Mortgage scheme -->
													</tr>
													<tr>
														<td width="36%"></td>
														<td width="19%"></td>
														<td width="27%" id="r1mahila"><font size="1"
															face="MS Sans Serif" color="#CC0000">Click here to
														view the Limit &amp; Eligibility </font></td>
														<!-- mahila scheme -->
														<td width="18%" id="hidecmdmahila"><font size="1"
															face="MS Sans Serif"> <input type="button"
															name="cmdmahila" value="Check Eligibility"
															style="width: 100" class="buttoncolor"
															onClick="callmahilaLimitofLoan('perlimitmahila.jsp','getmahilaData')">
														</font></td>
														<!-- mahila scheme -->
													</tr>
													<tr>
														<td width="36%"></td>
														<td width="19%"></td>
														<td width="27%" id="r1syndsenior"><font size="1"
															face="MS Sans Serif" color="#CC0000">Click here to
														view the Limit &amp; Eligibility </font></td>
														<!-- synd senior scheme -->
														<td width="18%" id="hidecmdsyndsenior"><font size="1"
															face="MS Sans Serif"> <input type="button"
															name="cmdsyndsenior" value="Check Eligibility"
															style="width: 100" class="buttoncolor"
															onClick="callmahilaLimitofLoan('perlimitsenior.jsp','getseniorData')">
														</font></td>
														<!-- synd senior scheme -->
													</tr>

													<!--<tr>
														<td width="36%"></td>
														<td width="19%"></td>
														<td width="27%" id="r1syndvidya"><font size="1"
															face="MS Sans Serif" color="#CC0000">Click here to
														view the Limit &amp; Eligibility </font></td>
														 synd vidya dl/osl scheme 
														<td width="18%" id="hidecmdsyndvidya"><font size="1"
															face="MS Sans Serif"> <input type="button"
															name="cmdsyndvidya" value="Check Eligibility"
															style="width: 100" class="buttoncolor"
															onClick="callmahilaLimitofLoan('perlimitvidya.jsp','geteduData');">
														</font></td>
														 synd vidya dl/osl scheme 
													</tr>-->

													<tr>
														<!--
														<td width="36%"><font size="1" face="MS Sans Serif"
															color="#CC0000"><span id="amort1">Click
														here to view the Amortization Table</span></font><font size="1"
															face="MS Sans Serif"> </font></td>
														<td id="amort2" width="19%"><input type="button"
															name="amort" value="Amortization" style="width: 130"
															class="buttoncolor"
															onClick="callAmortization(document.forms[0].txtloan_emidate.value,document.forms[0].txt_installments.value)">
														</td>
														-->
														<td width="27%"><font size="1" face="MS Sans Serif"
															color="#CC0000">Application Filed On </font><font
															size="1" face="MS Sans Serif"><b><font
															size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font><font
															size="1" face="MS Sans Serif"> (dd/mm/yyyy) </font></td>
														<td width="18%"><font size="1" face="MS Sans Serif"><font
															size="1" face="MS Sans Serif"> <input type="text"
															name="txtloan_filedon" size="15"
															value="<%=Helper.correctNull((String) hshValues
									.get("loanfiledon"))%>"
															onBlur="checkDate(this);checkFileDate(this)"
															maxlength="12"> </font></font> <a
															alt="Select date from calender" href="#"
															onClick="callCalender()"
															onMouseOver="window.status='Date Picker';return true;"
															onMouseOut="window.status='';return true;"><img
															src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
															border=0 alt="Select date from calender"></a></td>
													</tr>
													<tr>
														<td width="10%"><font size="1" face="MS Sans Serif"
															color="#000000">Sanction Refrence Number&nbsp;<b><font
															size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font></td>
														<td width="10%">&nbsp;<input type="text"
															name="txtloan_sancno"
															onKeyPress="return allowAlphaNumericOne(event);"
															onKeyDown="return DisableCopyPaste(event)" size="19"
															value="<%=Helper.correctNull((String) hshValues
							.get("sanctionrefno"))%>"
															maxlength="10"></td>
														<td id="cibil_score" width="27%"><font size="1"
															face="MS Sans Serif" color="#000000">&nbsp;CIBIL
														Score&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font><input
															type="text" name="CibilScore"
															value="<%=Helper.correctNull((String) hshValues.get("cibilScore"))%>"
															readonly="readonly"> <font size="1"
															face="MS Sans Serif"> </font></td>
														<td id="cibil_reports" width="18%">&nbsp; <input
															type="button" name="cibilView" value="CIR Reports"
															class="buttoncolor" onclick="getView('CIR')"> <input
															type="button" name="cibilView1" value="IDV Reports"
															class="buttoncolor" onclick="getView('IDV')"></td>
													</tr>
												</table>

												</td>
											</tr>
											<!-- Date of -->



										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<%
	String strappno = Helper.correctNull((String) request
			.getParameter("appno"));

	if (strappno.equalsIgnoreCase("new")) {
		strappno = "";
	}
%>
<table width="0%" border="0" cellspacing="0" cellpadding="0"
	bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"
	class="outertablecolor" align="center">
	<tr>
		<td id="amort2"><input type="button" name="amort"
			value="Amortization" style="width: 130" class="buttoncolor"
			onClick="callAmortization(document.forms[0].txtloan_emidate.value,document.forms[0].txt_installments.value)">
		</td>
		<td><lapschoice:combuttons apporgcode="<%=strappno%>"
			strSource="" /></td>
	</tr>

	<table width="100%" border="0" cellspacing="0" cellpadding="2">
		<tr valign="top">
			<td align="center"><!-- 	<input type="button" name="cmddelApp" value="Delete Application"  style="width:120" class="buttoncolor" onClick="doDeleteApp()">
--> <%
 	if (strCanaraSyndBank.equalsIgnoreCase("S")) {
 %> <input type="button"
				name="cmdHL" value="Check List-HL" style="width: 100"
				class="buttoncolor" onClick="dochecklistHL()"> <%
 	}
 %> <%
 	if (Helper.correctNull((String) hshValues.get("prdcode"))
 			.equalsIgnoreCase("651")) {
 %>
			<input type="button" name="cmdlist"
				style="visibility: hidden; position: absolute;"
				value="Pre-Sanction CHECK LIST" style="width: 175"
				class="buttoncolor" onClick="dopresanctionlist()"> <%
 	} else {
 %>
			<input type="button" name="cmdlist"
				style="visibility: hidden; position: absolute;"
				value="Pre-Sanction CHECK LIST" style="width: 175"
				class="buttoncolor" onClick="dopresanctionlist()"> <%
 	}
 %>
			</td>
		</tr>
	</table>
	<br>
	<table width="0%" border="0" cellspacing="0" cellpadding="0"
		bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"
		class="outertablecolor" align="center">
		<tr>
			<td id="hidecmdsyndvidya"><input type="button"
				name="cmdsyndvidya" value="Check Eligibility" style="width: 100"
				class="buttoncolor"
				onClick="callmahilaLimitofLoan('perlimitvidya.jsp','geteduData');">
			</td>
			<td style="visibility: hidden; position: absolute"><input
				type="button" name="cmdCicScore" value="CIC Score"
				style="width: 175" class="buttoncolor"
				onClick="javascript:getCicScoreEdu()"></td>
			<td><input type="button" name="cmdSanclet"
				value="In Principle Sanction Letter"
				style="width: 175; background-color: #00aedf" class="buttoncolor"
				onClick="javascript:doSanctionLetter()"></td>
			<td><input type="button" name="cmdMisbam83" value="MIS BAM-83"
				style="width: 100; background-color: #00aedf" class="buttoncolor"
				onClick="callMisCollateral()"></td>
			<td id="sendspc" style="visibility: hidden; position: absolute"><input
				type="button" name="cmdSendcpc" value="Send to RAH"
				style="width: 100" class="buttoncolor" onClick="callSendRAH()">
			</td>
		</tr>
	</table>

	<iframe height="0" width="0" id="iframerate" frameborder="0"
		style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmperloanhevp" frameborder="0"
		style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmSetupDICvariance" frameborder="0"
		style="border: 0"></iframe>
	<iframe height="0" width="0" id="iframeCourseDet_Edu" frameborder="0"
		style="border: 0"></iframe>
	<INPUT TYPE="hidden" name="hidProductID"
		value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
	<INPUT TYPE="hidden" name="hidClass">
	<INPUT TYPE="hidden" name="hidDemoId" value="<%=bowid%>">
	<!-- <INPUT TYPE="hidden" name="appnoo" value="<%=Helper.correctNull((String) hshValues.get("appno"))%>"> -->
	<INPUT TYPE="hidden" name="hidEditMode"
		value="<%=Helper.correctNull((String) hshValues
									.get("hidEditMode"))%>">
	<INPUT TYPE="hidden" name="hidBeanGetMethod">
	<INPUT TYPE="hidden" name="hidBeanId">
	<INPUT TYPE="hidden" name="hidApploanType" value="P">
	<INPUT TYPE="hidden" name="hidAppStatus"
		value="<%=Helper.correctNull((String) hshValues
									.get("status"))%>">
	<INPUT TYPE="hidden" name="page"
		value="<%=Helper.correctNull((String) hshValues.get("page"))%>">
	<INPUT TYPE="hidden" name="hidAppType">
	<INPUT TYPE="hidden" name="trapEdit"
		value="<%=Helper.correctNull((String) hshValues.get("trapEdit"))%>">
	<INPUT TYPE="hidden" name="strApp"
		value="<%=Helper.correctNull((String) hshValues
									.get("strApp"))%>">
	<INPUT TYPE="hidden" name="strCoApp"
		value="<%=Helper.correctNull((String) hshValues.get("strCoApp"))%>">
	<INPUT TYPE="hidden" name="strFin"
		value="<%=Helper.correctNull((String) hshValues
									.get("strFin"))%>">
	<INPUT TYPE="hidden" name="strColl"
		value="<%=Helper.correctNull((String) hshValues.get("strColl"))%>">
	<INPUT TYPE="hidden" name="radLoan" value="Y">
	<INPUT TYPE="hidden" name="hiPgDist" value="P">
	<input type="hidden" name="hideditflag">
	<input type="hidden" name="hidAction">
	<input type="hidden" name="hidBeanMethod">
	<input type="hidden" name="hidSourceUrl"
		value="/action/perloandetails.jsp">
	<input type="hidden" name="hidinterest"
		value="<%=Helper.correctNull((String) hshValues
									.get("loaninttype"))%>">
	<input type="hidden" name="hidinteresttype" value="Select">
	<input type="hidden" name="hidifrminteresttype">
	<input type="hidden" name="hidifrminterestrates"
		value="<%=Helper.correctNull((String) hshValues
							.get("strstepintrate"))%>">
	<input type="hidden" name="hidifrmtoamt"
		value="<%=Helper.correctNull((String) hshValues
									.get("strsteptoamt"))%>">
	<input type="hidden" name="hidisedit" value="true">
	<input type="hidden" name="hidrepaymenttype" value="">
	<input type="hidden" name="hidstartterms" value="1">
	<input type="hidden" name="hidrepayment"
		value="<%=Helper.correctNull((String) hshValues
							.get("repaymenttype"))%>">
	<input type="hidden" name="appno"
		value="<%=Helper.correctNull((String) request
									.getParameter("appno"))%>">
	<input type="hidden" name="shanshidProductID"
		value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
	<input type="hidden" name="hidstatus"
		value="<%=Helper.correctNull((String) Status)%>">
	<input type="hidden" name="comapp_compname"
		value="<%=Helper.correctNull((String) hshValues.get("aname"))%>">
	<input type="hidden" name="moratoriumvalue">
	<input type="hidden" name="hidAction2">
	<input type="hidden" name="hidmor">
	<input type="hidden" name="strOrgShortCode"
		value="<%=Helper.correctNull((String) hshValues
							.get("strOrgShortCode"))%>">
	<input type="hidden" name="HRBranchUserEdit"
		value="<%=session.getAttribute("HRBranchUserEdit")%>">
	<INPUT TYPE="hidden" name="appid"
		value="<%=session.getAttribute("bowid")%>">

	<INPUT TYPE="hidden" name="hidCustId"
		value="<%=Helper.correctNull((String) hshValues.get("cbsid"))%>">

	<INPUT TYPE="hidden" name="duedate"
		value="<%=session.getAttribute("duedate")%>">
	<INPUT TYPE="hidden" name="diff"
		value="<%=Helper.correctNull((String) hshValues.get("diff"))%>">

	<INPUT TYPE="hidden" name="type"
		value="<%=Helper.correctNull((String) hshValues.get("intTemp"))%>">
	<INPUT TYPE="hidden" name="loantype"
		value="<%=Helper.correctNull((String) hshValues.get("selecttype"))%>">
	<INPUT TYPE="hidden" name="repaydate"
		value="<%=Helper.correctNull((String) hshValues.get("repaydate"))%>">
	<INPUT TYPE="hidden" name="hidrto"
		value="<%=Helper.correctNull((String) hshValues.get("prdrangeto"))%>">
	<input type="hidden" name="txt_installments1" size="15" maxlength="15"
		value="<%=Helper.correctNull((String) hshValues
							.get("prd_min_terms"))%>"
		style="text-align: right">
	<input type="hidden" name="oldprdid"
		value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
	<input type="hidden" name="oldschemeid"
		value="<%=Helper.correctNull((String) hshValues
							.get("selectpurpose"))%>">
	<input type="hidden" name="hidNSDLPage"
		value="<%=Helper.correctNull((String) hshValues
									.get("strPagetype"))%>">
	<input type="hidden" name="hidnsdlrefno"
		value="<%=Helper.correctNull((String) hshValues
									.get("strNSDLRefID"))%>">
	<input type="hidden" name="hidcibilNumber"
		value="<%=Helper.correctNull((String) hshValues
							.get("cibilFilename"))%>">
	<INPUT TYPE="hidden" name="hidauto_type" value="C">
	<INPUT TYPE="hidden" name="hidchkNewInterestRate">
	<INPUT TYPE="hidden" name="pagefromROInbox">
	<input type="hidden" name="hidMinVariance">
	<input type="hidden" name="hidMaxVariance">
	<input type="hidden" name="hidEnableVaraince">
	<input type="hidden" name="product_code">
	<input TYPE="hidden" name="strMessage">
	<input type="hidden" name="prdcodetype">
	<input type="hidden" name="hidShowidv"
		value="<%=Helper.correctNull((String) hshValues
									.get("showIDVAlert"))%>">
	<input type="hidden" name="hidMortflag"
		value="<%=Helper.correctNull((String) hshValues
							.get("LOAN_MORTFLAG"))%>">
	<iframe height="0" width="0" id="ifrmPSB59Refno" frameborder="0"
		style="border: 0"></iframe>
	<input type="hidden" name="prodvarianceamount">
	<input type="hidden" name="prodcodevalue">
	<input type="hidden" name="hidCalenderAnniv"
		value="<%=Helper.correctNull((String) hshValues
							.get("cod_year_base"))%>">
	<input type="hidden" name="hidsimpleinterest"
		value="<%=Helper.correctNull((String) hshValues
									.get("FRQ_INT_COMP"))%>">
	<input type="hidden" name="compname"
		value="<%=Helper.correctNull((String) hshValues.get("compname"))%>">
	<input type="hidden" name="hidFrqinstall">
	<input type="hidden" name="hidCourseDuration">
	</form>
</body>
</html>