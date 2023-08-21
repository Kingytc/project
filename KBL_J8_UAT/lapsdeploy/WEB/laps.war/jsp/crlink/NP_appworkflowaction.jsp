  <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />
<jsp:useBean id="strUserClass" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgName" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgCode" class="java.lang.String" scope="session" />
<laps:handleerror />
<%
   ArrayList arrFlowpoint=(ArrayList)hshValues.get("arrFlowpoint");
   ArrayList arrAction=(ArrayList)hshValues.get("arrAction");
   ArrayList arrMaxclass=(ArrayList)hshValues.get("arrMaxclass");
   ArrayList arrDone=(ArrayList)hshValues.get("arrDone");
   ArrayList arrFunction = (ArrayList)hshValues.get("arrFunction");
   ArrayList arrWorkFlowId = (ArrayList)hshValues.get("arrWorkFlowId");
   String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));  
   String strproductcode=Helper.correctNull((String)hshValues.get("productcode"));
   String strOrgLevel = Helper.correctNull((String)hshValues.get("strOrgLevel"));
   String strappno1=request.getParameter("appno");
   String strUserIdOrglevel=Helper.correctNull((String)hshValues.get("UserIdOrglevel"));
 
String strSSIType  =Helper.correctNull((String)session.getAttribute("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strApprovClass = Helper.correctDouble((String)hshValues.get("prd_approval"));
String strApprovedby = Helper.correctNull((String)hshValues.get("approvedby"));
String day=Helper.correctNull((String)hshValues.get("day"));
String appNum=Helper.correctNull((String)hshValues.get("strAppno"));
int date=Integer.parseInt(Helper.correctNull((String)hshValues.get("date")));
String Ro_Flag =Helper.correctNull((String)hshValues.get("Ro_Flag"));
String strEligibleRev= Helper.correctNull((String) session.getAttribute("strEligibleRev"));
String APP_SR_ELIG= Helper.correctNull((String) session.getAttribute("APP_SR_ELIG"));
String strAppSRDone= Helper.correctNull((String) session.getAttribute("APP_SR_DONE"));
int GroupNum=Integer.parseInt(Helper.correctNull((String)hshValues.get("GroupNum")));

if(strApprovClass.trim().equals(""))
{
	strApprovClass="0";
}
   
String strSkipClass = Helper.correctDouble((String)hshValues.get("prd_skip"));
if(strSkipClass.trim().equals(""))
{
	strSkipClass="0";
}

String strUsrClass = Helper.correctNull((String)strUserClass);
if(strUsrClass.trim().equals(""))
{
strUsrClass ="0";
}

String strCurFP = Helper.correctNull((String)hshValues.get("strCurrFlowPoint"));
if(strCurFP.trim().equals(""))
{
	strCurFP="0";
}
   //String strAssesValue =(String)hshValues.get("AssesValue");
   //String strAppAmt = (String)hshValues.get("AppAmt");
 String strWorkflow = Helper.correctNull((String)hshValues.get("workflow"));
 if(strWorkflow.trim().equals(""))
 {
	   strWorkflow = Helper.correctNull((String)session.getAttribute("workflow"));
 }
String strPrdtype = Helper.correctNull((String)hshValues.get("prdtype"));
String handoffstatus = Helper.correctNull((String)hshValues.get("handoffstatus"));
String strCbsNum=Helper.correctNull((String)hshValues.get("strCbsAcnum"));
String strCbsAcountNumber=Helper.correctNull((String)hshValues.get("strCBSNumber"));
String appsanc_sancofficer=Helper.correctNull((String)hshValues.get("appsanc_sancofficer"));
String appsanc_sancofficer1=Helper.correctNull((String)hshValues.get("appsanc_sancofficer1"));
String appsanc_sancofficer2=Helper.correctNull((String)hshValues.get("appsanc_sancofficer2"));



String appsanc_sancofficerCPC=Helper.correctNull((String)hshValues.get("appsanc_sancofficer3"));



String strRating=Helper.correctNull((String)hshValues.get("ratingStatus"));
String strRecommend=Helper.correctNull((String)hshValues.get("recommendStatus"));
String moduleType=Helper.correctNull((String)hshValues.get("moduletype"));
String strPageEnableFrom=Helper.correctNull((String)hshValues.get("strPageEnable"));		

String rsk_returncode="";//Applicable only for MSME Risk Rating
String rsk_returnmsg="";
boolean entr_pass=false;

/*if(moduleType.equalsIgnoreCase(""))
{
	moduleType=strCategoryType;
	
	if(moduleType.equalsIgnoreCase("SME"))
	{
		moduleType="M";
	}
	
}*/

if(moduleType.equalsIgnoreCase("M"))
{
	HashMap hshRsk =new HashMap();
	hshRsk=(HashMap)hshValues.get("hshRskCheck");
	rsk_returncode=Helper.correctNull((String)hshRsk.get("hshCode"));
	rsk_returnmsg=Helper.correctNull((String)hshRsk.get("hshMessage"));
	if(rsk_returncode.equals("2") || rsk_returncode.equals("3"))
	{
		entr_pass=true;
	}
}

String loanpage_ROI=Helper.correctNull((String)hshValues.get("strinterestrate"));
String setup_roi=Helper.correctNull((String)hshValues.get("stat_data_roi"));
String variance_ROI=Helper.correctNull((String)hshValues.get("strvariance"));
//String day=Helper.correctNull((String)hshValues.get("day"));
String term_roi=Helper.correctNull((String)hshValues.get("term_ir"));
String working_roi=Helper.correctNull((String)hshValues.get("working_ir"));
String term_br=Helper.correctNull((String)hshValues.get("term_br"));
String working_br=Helper.correctNull((String)hshValues.get("working_br"));
String nsdlloans=Helper.correctNull((String)hshValues.get("loan_appln_from_nsdl")); 

String RNEnable=Helper.correctNull((String)hshValues.get("RNEnable"));
String SRDoneFlag=Helper.correctNull((String)hshValues.get("SRDoneFlag"));
String lrf_house_done =Helper.correctNull((String)hshValues.get("lrf_house_done"));
String lrf_edu_done =Helper.correctNull((String)hshValues.get("lrf_edu_done"));
String lrf_per_done =Helper.correctNull((String)hshValues.get("lrf_per_done"));
String strUserId=Helper.correctNull((String)hshValues.get("strUserId"));
String strappusr_id=Helper.correctNull((String)hshValues.get("strappusr_id"));
String strDocAttached=Helper.correctNull((String)hshValues.get("DocAttached"));
String strApprovedDate=Helper.correctNull((String)hshValues.get("strApprovedDate"));
String strApprovedOrgcode=Helper.correctNull((String)hshValues.get("strApprovedOrgcode"));
String schemesantcode=Helper.correctNull((String)hshValues.get("schemesantcode"));
String BBschemesantcode=Helper.correctNull((String)hshValues.get("BBschemesantcode"));
String strCanaraSyndBank=ApplicationParams.getStrCbsInterfaceflag();
String strcollteralFlag=Helper.correctNull((String)hshValues.get("strcollteralFlag"));
String reloadflag=Helper.correctNull((String)hshValues.get("strreloadflag"));
String strLoanfor=Helper.correctNull((String)hshValues.get("strLoanfor"));
String cicAmountCheck=Helper.correctDouble((String)hshValues.get("cicAmountCheck"));
if(cicAmountCheck.equalsIgnoreCase(""))
{
	cicAmountCheck="0";
}
String strAppStatus=Helper.correctNull((String)hshValues.get("strAppStatus"));
session.setAttribute("strappstatus",strAppStatus);

//Added on 17-06-2021 to Validate Multiple Cic Check for Co-Borrower Section starts
ArrayList EducationCoBorrowerCICDataListRows=new ArrayList();
ArrayList EducationCoBorrowerCICDataListCols=new ArrayList();
EducationCoBorrowerCICDataListRows=(ArrayList)hshValues.get("EducationCoBorrowerCICDataList");
//Added on 17-06-2021 to Validate Multiple Cic Check for Co-Borrower Section ends
String strBam83count = Helper.correctNull((String) hshValues.get("Bam83count"));
//out.print("trtyrtyrtrytr"+intBam83count);
%>
<html>
<head>
<title>Work Flow</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<!--  <script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>-->
<script>
var undousrid ="<%=Helper.correctNull((String)hshValues.get("undousrid"))%>";
var brhead ="<%=Helper.correctNull((String)hshValues.get("brhead"))%>";
var orglevel ="<%=Helper.correctNull((String)hshValues.get("orglevel"))%>";
var Ro_Flag ="<%=Helper.correctNull((String)hshValues.get("Ro_Flag"))%>";
var varRatingStatus="<%=strRating%>";
var varRecommendStatus="<%=strRecommend%>";
var detailsfilled="<%=Helper.correctNull((String)hshValues.get("processnotedetfilled"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var usr_class="";
var usr_func = "";
var wrkflw_id = "";
var appclass=<%=strApprovClass%>;
var skipclass=<%=strSkipClass%>;
var userclass=<%=strUsrClass%>;
var currflowpoint=<%=strCurFP%>;
var auditorrights="<%=((String)session.getAttribute("strGroupRights")).substring(7,8)%>";
var strprdid="<%=Helper.correctNull((String)hshValues.get("prdtype"))%>";
var strRemarksFlag="0";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var strsanctionlimit ="<%=Helper.correctNull((String)hshValues.get("sanctionlimit"))%>";
var strrecamt = "<%=Helper.correctNull((String)hshValues.get("recamt"))%>";
var strprdsanctionlimit ="<%=Helper.correctNull((String)hshValues.get("prdsanctionlimit"))%>";
var varCibilPage="<%=Helper.correctNull((String)hshValues.get("GotoPage"))%>";
var workflow ="<%=strWorkflow.trim()%>";
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var handoffstatus="<%=Helper.correctNull((String)hshValues.get("handoffstatus"))%>";
var approvedby="<%=strApprovedby%>";
var appsanc_sancofficer="<%=appsanc_sancofficer%>";
var appsanc_sancofficer1="<%=appsanc_sancofficer1%>";
var appsanc_sancofficer2="<%=appsanc_sancofficer2%>";
var appsanc_sancofficercpc="<%=appsanc_sancofficerCPC%>";
var varCbsNum="<%=strCbsNum%>";

var varrecamt ="<%=Helper.correctNull((String)hshValues.get("recamt"))%>";
var varMargin ="<%=Helper.correctNull((String)hshValues.get("strMargin"))%>";
var varEmi ="<%=Helper.correctNull((String)hshValues.get("strEmi"))%>";
var varLoanFilled ="<%=Helper.correctNull((String)hshValues.get("strLoanFilled"))%>";
var varCostOfProj ="<%=Helper.correctNull((String)hshValues.get("strCostOfProj"))%>";
var varRepayType ="<%=Helper.correctNull((String)hshValues.get("strRepayType"))%>";
var varTerms ="<%=Helper.correctNull((String)hshValues.get("strTerms"))%>";
var checkvehappentry="<%=Helper.correctNull((String)hshValues.get("auto_valuation"))%>";
var emptype="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>";
var INCOME_PROOF="<%=Helper.correctNull((String)hshValues.get("INCOME_PROOF"))%>";
var TURN_OVER="<%=Helper.correctNull((String)hshValues.get("TURN_OVER"))%>";
var selecttype = "<%=session.getAttribute("selecttypeedu")%>";
var prdrangeto="<%=Helper.correctNull((String)hshValues.get("prd_rng_to"))%>";
var LimitType	= "<%=Helper.correctNull((String)session.getAttribute("hidSSIType"))%>";
var RecFlagVal="<%=Helper.correctNull((String)hshValues.get("RecFlag"))%>";
var msme="<%=Helper.correctNull((String)hshValues.get("hidCategoryType"))%>";
var prd_approval="<%=Helper.correctNull((String)hshValues.get("prd_approval"))%>";
var prd_maxclass="<%=Helper.correctNull((String)hshValues.get("prd_maxclass"))%>";
var varRatingStatus="<%=strRating%>";
var varRecommendStatus="<%=strRecommend%>";
var strproductcode="<%=strproductcode%>";
var moduleType="<%=moduleType%>";
var entr_pass="<%=entr_pass%>";
var rsk_returncode="<%=rsk_returncode%>";
var rsk_returnmsg="<%=rsk_returnmsg%>";
var varAppNum="<%=appNum%>";
var Flag_Grprights="<%=Helper.correctNull((String)hshValues.get("Flag_Grprights"))%>";
var varAccountNumCBS="<%=strCbsAcountNumber%>";
var loanpage_ROI="<%=loanpage_ROI%>";
var setup_roi="<%=setup_roi%>";
var variance_ROI="<%=variance_ROI%>";
var term_roi="<%=term_roi%>";
var working_roi="<%=working_roi%>";
var term_br="<%=term_br%>";
var working_br="<%=working_br%>";
var strPrdtype="<%=strPrdtype%>";
var day="<%=day%>";
var varnsdlloans="<%=nsdlloans%>";
var varFCRTerms ="<%=Helper.correctNull((String)hshValues.get("var_p_ctr_term_approved"))%>";
var varFCRMorat ="<%=Helper.correctNull((String)hshValues.get("var_mort_prd"))%>"; 
var varFCRIntserviced ="<%=Helper.correctNull((String)hshValues.get("strinterest"))%>"; 
var varFCRRepayperiod ="<%=Helper.correctNull((String)hshValues.get("facility_repayperiod"))%>"; 
var varFCRRepayholiday ="<%=Helper.correctNull((String)hshValues.get("facility_repayholiday"))%>"; 
var varFCRIntServised ="<%=Helper.correctNull((String)hshValues.get("facility_serviced"))%>"; 
var varFCREmiamnt ="<%=Helper.correctNull((String)hshValues.get("facility_emiamnt"))%>"; 
var varSRDoneFlag = "<%=SRDoneFlag%>";
var varSRConfFlag = "<%=Helper.correctNull((String)hshValues.get("SRConfFlag"))%>";
var APP_SR_ELIG = "<%=Helper.correctNull((String)hshValues.get("APP_SR_ELIG"))%>";
//TO Maintain Flag for RO user
var varROuser = "<%=Helper.correctNull((String)hshValues.get("ROuser"))%>";

//Eligible Review Yes or No
var SanctionReviewFlag ="<%=Helper.correctNull((String)hshValues.get("SanctionReviewFlag"))%>";

var chkNewInterestRate = "<%=Helper.correctNull((String)hshValues.get("chkNewInterestRate"))%>"; 

//Eligible review !="" & RO user =Y
var varRNEnable = "<%=RNEnable%>";    
//PMAY Entry EXIST OR NOT
var varPmayCheck="<%=Helper.correctNull((String)hshValues.get("PMAYOK"))%>";
var varselPmay="<%=Helper.correctNull((String)hshValues.get("selPmay"))%>";
var date="<%=Helper.correctNull((String)hshValues.get("date"))%>";
var day="<%=Helper.correctNull((String)hshValues.get("day"))%>";
var Holiday = day.charAt(date-1);
var flag = "<%=Helper.correctNull((String)hshValues.get("flag"))%>";
var varOrgLevel = "<%=strOrgLevel%>";
var varAppUserLevel="<%=strUserIdOrglevel%>"; 
var strEligibleRev="<%=strEligibleRev%>";

var lrf_house_done = "<%=Helper.correctNull((String)hshValues.get("lrf_house_done"))%>";
var lrf_edu_done = "<%=Helper.correctNull((String)hshValues.get("lrf_edu_done"))%>";
var lrf_per_done = "<%=Helper.correctNull((String)hshValues.get("lrf_per_done"))%>";
var APP_CLOSED = "<%=Helper.correctNull((String)hshValues.get("APP_CLOSED"))%>";
var strAppSRDone= "<%=Helper.correctNull((String)hshValues.get("APP_SR_DONE"))%>";
var varloginid="<%=strUserId%>";
var varuserid="<%=strappusr_id%>";
var varDocAttached="<%=strDocAttached%>";

var varCIBILCheckType = "<%=Helper.correctNull((String)hshValues.get("cibilDemotype"))%>";
var varCIBILStatus = "<%=Helper.correctNull((String)hshValues.get("cibilStatus"))%>";

//Provision TOD Check
var varProvisionCheck="<%=Helper.correctNull((String)hshValues.get("ProvisionCheck"))%>";
//Synd Udhyami Check
var varSyndudhyami="<%=Helper.correctNull((String)hshValues.get("UdhyamiCheck"))%>";
var varSyndBeml="<%=Helper.correctNull((String)hshValues.get("SyndBemlCheck"))%>";
var approvedDate="<%=strApprovedDate%>";
var approvedOrgcode="<%=strApprovedOrgcode%>";

var varschemesantcode="<%=schemesantcode%>";
var varBBschemesantcode="<%=BBschemesantcode%>";
var varRMLCflag="<%=Helper.correctNull((String)hshValues.get("strRMLCflag"))%>";
var vardblsetupmaxamtAmt =  "<%=Helper.correctNull((String)hshValues.get("Setupmaxlimit"))%>";
var vardblproposedLoanAmt =  "<%=Helper.correctNull((String)hshValues.get("proposedLoanAmt"))%>";
var varApplicantRelation="<%=Helper.correctNull((String)hshValues.get("applicantRelation"))%>";
var varstrCBSFeildsData="<%=Helper.correctNull((String)hshValues.get("rateChartCode"))%>";
var varBorrowerMigVal="<%=Helper.correctNull((String)hshValues.get("CBSIDUpdatedValue"))%>";
var varCoapplicantRelation="<%=Helper.correctNull((String)hshValues.get("CoapplicantRelation"))%>";
var varcibilPromotertype="<%=Helper.correctNull((String)hshValues.get("cibilPromotertype"))%>";
var varcibilMSMEtype="<%=Helper.correctNull((String)hshValues.get("cibilMSMEtype"))%>";
var varCanaraSyndBank="<%=strCanaraSyndBank%>";
var varcollatercode="<%=Helper.correctNull((String)hshValues.get("collatercode"))%>";
var varcollteralFlag="<%=strcollteralFlag%>";
var reloadflag = "<%=reloadflag%>";
var CourseExpFlag="<%=Helper.correctNull((String)hshValues.get("CourseExpFlag"))%>";
var SecurityFlag="<%=Helper.correctNull((String)hshValues.get("SecurityFlag"))%>";
var varAllowBranch="<%=Helper.correctNull((String)hshValues.get("strAllowBranch"))%>";
var coAppGuaFlag="<%=Helper.correctNull((String)hshValues.get("coAppGuaFlag"))%>";
var EduLoanDetail="<%=Helper.correctNull((String)hshValues.get("EduLoanDetail"))%>";
var varstrLoanfor="<%=strLoanfor%>";
var varcicScoreCount="<%=Helper.correctNull((String)hshValues.get("cicScoreCount"))%>";
var varCicAmountCheck="<%=cicAmountCheck%>";
var varRevAuth="<%=Helper.correctNull((String)hshValues.get("strRevAuth"))%>";
var varstrAppStatus="<%=strAppStatus%>";
var varMarginlimitcheck="<%=Helper.correctNull((String)hshValues.get("strMarginlimitcheck"))%>";
var varBam83count="<%=strBam83count%>";
var strCollDesc="<%=Helper.correctNull((String)hshValues.get("strCollDesc"))%>";
var strUniv="<%=Helper.correctNull((String)hshValues.get("strUniv"))%>";
var strCourse="<%=Helper.correctNull((String)hshValues.get("strCourse"))%>";
var CourseGrandTotal="<%=Helper.correctNull((String)hshValues.get("CourseGrandTotal"))%>";
var EDU_LOANPURPOSE="<%=Helper.correctNull((String)hshValues.get("EDU_LOANPURPOSE"))%>";

function doPrint() {
	if(detailsfilled=="N"){
		alert("ProcessNote -> Additional and Security Details  cannot be left Blank");
		return;
		}
	var appno        = "<%=request.getParameter("appno")%>";
	  var varQryString = appURL + 
	          "action/perriskrating.jsp?&hidBeanId=perrskana&hidBeanGetMethod=getRiskAnalysis&appno=" + appno + 
	          "&hidflag=print&hidapplicantid="+document.forms[0].hidDemoId.value;
	  var xpos         = (screen.width - 825) / 2;
	  var ypos         = (screen.height - 600) / 2;
	  var title        = "PaymentDetails";
	  var prop         = "scrollbars=yes,menubar=yes,width=825,height=600,top=" + xpos + ",left=" + ypos;

	  window.open(varQryString, title, prop);
	  document.forms[0].hidRisk.value="F";
	 
	
	  if(strEligibleRev =="Y" && APP_SR_ELIG !="y")
		{
		  if((prd_approval<=prd_maxclass) && (document.forms[0].appstatus.value=="Open/Pending"))
			{
				document.forms[0].cmdapprove.disabled=false;
			}
		}
	  else
	  {
		document.forms[0].cmdLRFCheck.disabled=false;
	  }
	
	  
	}
function ShowReport()
{
	if(detailsfilled=="N"){
		alert("Process note available in Appraisal tab  should be filled completely");             //Details I and Details II cannot be left Blank
		return;
		}
	var appno ="<%=request.getParameter("appno")%>" ;
	var url = "<%=ApplicationParams.getAppUrl()%>action/processnote.jsp?hidBeanId=appbeanJr&hidBeanGetMethod=getProcessNotes&appno="+appno;
	var title = "ProcessNotes";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
	checkViewAll(false,false,false,false,true);
}
function showReport1(page)
{
	if(detailsfilled=="N"){
		alert("Process note available in Appraisal tab  should be filled completely");
		return;
		}

	var appno ="<%=request.getParameter("appno")%>" ;
	var url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&hidBeanId=appbeanJr&hidBeanGetMethod=getProcessNotes";
	var title = "ProcessNotescontless20";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
	if(parseInt(strproductcode)==parseInt("975") || parseInt(strproductcode)==parseInt("935"))
	{
		checkViewAll(false,false,false,false,false);
	}
	else
	{
		checkViewAll(false,false,false,false,true);
	}
}

function eduprocessnote()
{
	
	var eduloantype = "<%=session.getAttribute("selecttypeedu")%>";
	var eduLOAN_SELECTPURPOSE ="<%=session.getAttribute("selectpurposeedu")%>";
	
	var contloanamt =varrecamt;

	 if(varCanaraSyndBank=="S"){
	if(eduloantype=="C")
	{
		if(eduLOAN_SELECTPURPOSE==6||eduLOAN_SELECTPURPOSE==7||eduLOAN_SELECTPURPOSE==12||eduLOAN_SELECTPURPOSE==13||eduLOAN_SELECTPURPOSE==14||eduLOAN_SELECTPURPOSE==15)
		{
			document.all.id_eduprocessnote.style.visibility="visible";
			document.all.id_eduprocessnote.style.position="relative";
			
			document.all.id_contless20processnote.style.visibility="hidden";
			document.all.id_processnote.style.visibility="hidden";
			document.all.id_processnote.style.position="absolute";
			document.all.id_contless20processnote.style.position="absolute";
		}
		else if(eduLOAN_SELECTPURPOSE==1||eduLOAN_SELECTPURPOSE==2||eduLOAN_SELECTPURPOSE==3||eduLOAN_SELECTPURPOSE==4||eduLOAN_SELECTPURPOSE==5||eduLOAN_SELECTPURPOSE==8||eduLOAN_SELECTPURPOSE==11)
		{
			if(contloanamt<2000000)
			{
			document.all.id_contless20processnote.style.visibility="visible";
			document.all.id_contless20processnote.style.position="relative";
			
			document.all.id_processnote.style.visibility="hidden";
			document.all.id_eduprocessnote.style.visibility="hidden";
			document.all.id_processnote.style.position="absolute";
			document.all.id_eduprocessnote.style.position="absolute";
			
			}
			else
			{
			document.all.id_processnote.style.visibility="visible";
			document.all.id_processnote.style.position="relative";
			
			document.all.id_contless20processnote.style.visibility="hidden";
		    document.all.id_eduprocessnote.style.visibility="hidden";
		    document.all.id_contless20processnote.style.position="absolute";
			document.all.id_eduprocessnote.style.position="absolute";
			}
		}
		else 
		{		
		document.all.id_processnote.style.visibility="visible";
		document.all.id_processnote.style.position="relative";
		
		document.all.id_eduprocessnote.style.visibility="hidden";
		document.all.id_contless20processnote.style.visibility="hidden";
		document.all.id_contless20processnote.style.position="absolute";
		document.all.id_eduprocessnote.style.position="absolute";
		}
	}
	
	else if(eduloantype=="V")
	{
		if(contloanamt<2000000)
			{
			document.all.id_contless20processnote.style.visibility="visible";
			document.all.id_contless20processnote.style.position="relative";
		
			document.all.id_processnote.style.visibility="hidden";
			document.all.id_eduprocessnote.style.visibility="hidden";
			document.all.id_processnote.style.position="absolute";
			document.all.id_eduprocessnote.style.position="absolute";
			}
			else
			{
			
	     	document.all.id_processnote.style.visibility="visible";
		    document.all.id_processnote.style.position="relative";
		    
		    document.all.id_contless20processnote.style.visibility="hidden";
		    document.all.id_eduprocessnote.style.visibility="hidden";
		    document.all.id_contless20processnote.style.position="absolute";
			document.all.id_eduprocessnote.style.position="absolute";
			}
	}
	else
	{
		// only for synd nivas this process format is applicable w p of suresh
		if(eduloantype=="H"  && eduLOAN_SELECTPURPOSE==7)
		{
			document.all.id_contless20processnote.style.visibility="visible";
			document.all.id_contless20processnote.style.position="relative";
			
			document.all.id_processnote.style.visibility="hidden";
			document.all.id_eduprocessnote.style.visibility="hidden";
			document.all.id_processnote.style.position="absolute";
			document.all.id_eduprocessnote.style.position="absolute";
		}
		else
		{
			document.all.id_processnote.style.visibility="visible";
			document.all.id_processnote.style.position="relative";
			
			document.all.id_eduprocessnote.style.visibility="hidden";
			document.all.id_contless20processnote.style.visibility="hidden";
			document.all.id_contless20processnote.style.position="absolute";
			document.all.id_eduprocessnote.style.position="absolute";
		}
	}
	 }
	 else
	 {
		    document.all.id_eduprocessnote.style.visibility="visible";
			document.all.id_eduprocessnote.style.position="relative";
	 }
	
}	


function callmahilaLimitofLoan(page,getm)
{
	var selectpurpose1 ="<%=session.getAttribute("selectpurposeedu")%>";
	
	var selectloantype= "<%=session.getAttribute("selecttypeedu")%>";
	var strprdid ="<%=session.getAttribute("productcode")%>";
	var appid= document.forms[0].hidDemoId.value;
	 //var stramtreq = document.forms[0].txtloan_amtreqd.value; 
	var stramtreq = varrecamt; 
	var margin =varMargin; 
	var strorgappno= "<%=strappno1%>";
	var nooftrms =varTerms;
	var monthlyemi = eval(varEmi);
	var loan_filedon=varLoanFilled;
	if(varEmi=="")
	{
		monthlyemi="0.00";
	}
	var costofloanprd= varCostOfProj;
	var repaymenttype= varRepayType;
	
	
	if(varRepayType=="1")
	{
		if(varEmi == "")
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
				var selectpurpose=selectpurpose1;
				url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
				"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
				window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
				checkViewAll(false,false,false,true,true);
				}
		}		
		else if(selectpurpose1=="5")
		{
			
				if(emptype!="5" && emptype!="14")
				{
					alert("Select the Employment Status in Customer Profile as Pensioner");
					return false;
				}
				else
				{
				var selectpurpose=selectpurpose1;
				url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
				"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
				window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
				checkViewAll(false,false,false,true,true);
				}
		
		}
		else
		{
		
		var selectpurpose=selectpurpose1;
		url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
		"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
		window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
		checkViewAll(false,false,false,true,true);
		}
		
	}

	else
	{
		var selectpurpose=selectpurpose1;
		url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
		"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
		window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
		checkViewAll(false,false,false,true,true);
	}
}


function callmortgageLimitofLoan(page,getm)
{

var selectpurpose1 ="<%=session.getAttribute("selectpurposeedu")%>";

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
 var selectloantype= "<%=session.getAttribute("selecttypeedu")%>";
	var strprdid ="<%=session.getAttribute("productcode")%>";
	var appid= document.forms[0].hidDemoId.value;
	var stramtreq = varrecamt; 
	var margin =varMargin; 
	var strorgappno= "<%=strappno1%>";
	var nooftrms =varTerms;
	var monthlyemi = eval(varEmi);
	var loan_filedon=varLoanFilled;


	if(varEmi=="")
	{
		monthlyemi="0.00";
	}
	var costofloanprd= varCostOfProj;
	var repaymenttype= varRepayType;
	
	
	if(varRepayType=="1")
	{
		if(varEmi == "")
		{
			alert("Calculate EMI");
			return false;
		}
	}

if(selectloantype=="C")
	{
		
		var selectpurpose="<%=session.getAttribute("selectpurposeedu")%>";
		if(selectpurpose=="8")//laghuudyami
		{
			if(TURN_OVER=="1")
			{
			
				if(emptype == "4" || emptype == "6")
				{
						url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype+"&selectloantype="+selectloantype+
						"&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon+"&prdrangeto="+prdrangeto+"&hidBeanId=perlimitofloan&hidBeanGetMethod="+getm; //getmahilaData";
						window.open(url,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
						checkViewAll(false,false,false,true,true);
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
						checkViewAll(false,false,false,true,true);
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
						checkViewAll(false,false,false,true,true);
				}else{
						alert("Check for Employer Type -Income/Turn Over Criteria Combination in Customer Pofile");
						return false;
					 }
			}else{
						alert("Check for Employer Type -Income/Turn Over Criteria Combination in Customer Pofile");
						return false;
			}
		
		}
	}
}
function callLimitofLoan()
{
	var selectloantype= "<%=session.getAttribute("selecttypeedu")%>";
	var strprdid ="<%=session.getAttribute("productcode")%>";
	var appid= document.forms[0].hidDemoId.value;
	 //var stramtreq = document.forms[0].txtloan_amtreqd.value; 
	var stramtreq = varrecamt; 
	var margin =varMargin; 
	var strorgappno= "<%=strappno1%>";
	var nooftrms =varTerms;
	var monthlyemi = eval(varEmi);
	var loan_filedon=varLoanFilled;
	if(varEmi=="")
	{
		monthlyemi="0.00";
	}
	var costofloanprd= varCostOfProj;
	var repaymenttype= varRepayType;
	
	
	if(varRepayType=="1")
	{
		if(varEmi == "")
		{
			alert("Calculate EMI");
			return false;
		}
	}
	if(selectloantype=="V")
	{
	
			if(checkvehappentry=="")
			{
				alert("Ensure to EDIT/APPLY in Borrower Assest ->Vehicle Page");
				return false;
			}
	}
	checkViewAll(false,false,false,true,true);
	if(parseInt(strproductcode)==parseInt("975") || parseInt(strproductcode)==parseInt("935"))
	{
		document.forms[0].cmdapprove.disabled=true;
	}
	var selectpurpose="<%=session.getAttribute("selectpurposeedu")%>";
	window.open(appUrl+"action/perlimitofloan.jsp?orgappno="+strorgappno+"&appno="+appid+"&appid="+appid+"&prdid="+strprdid+"&amtreq="+stramtreq
			+"&margin="+margin+"&nooftrms="+nooftrms+"&monthlyemi="+monthlyemi+"&costofloanprd="+costofloanprd+"&repaymenttype="+repaymenttype
			+"&selectloantype="+selectloantype+
		  "&selectpurpose="+selectpurpose+"&loan_filedon="+loan_filedon,"LifeStyle","scrollbars=yes,menubar=yes,width=550,height=600,top=30,left=30");
	
}
function checkmahila()
{
	//Function to enable check eligibility based on loan type
   var mahila="<%=session.getAttribute("selectpurposeedu")%>";
   var ltype="<%=session.getAttribute("selecttypeedu")%>";
   if(varCanaraSyndBank=="S"){
   if(ltype=="C")
	{
		if(mahila==8)
		{
		
		document.all.hidecmdmortgage.style.visibility="visible";
		document.all.cmdmortgage.style.visibility="visible";
		document.all.hidecmdclick.style.visibility="hidden";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		document.all.cmdsyndsenior.style.visibility="hidden";

		document.all.hidecmdmortgage.style.position="relative";
		document.all.cmdmortgage.style.position="relative";
		document.all.hidecmdclick.style.position="absolute";
		document.all.hidecmdmahila.style.position="absolute";
		document.all.hidecmdsyndsenior.style.position="absolute";
		document.all.hidecmdsyndvidya.style.position="absolute";
		document.all.cmdsyndsenior.style.position="absolute";
		
		}
		else if(mahila==2)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.hidecmdclick.style.visibility="hidden";
		document.all.hidecmdmahila.style.visibility="visible";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";

		document.all.hidecmdmortgage.style.position="absolute";
		document.all.hidecmdclick.style.position="absolute";
		document.all.hidecmdmahila.style.position="relative";
		document.all.hidecmdsyndsenior.style.position="absolute";
		document.all.hidecmdsyndvidya.style.position="absolute";
		
		}
		else if(mahila==5)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
	    document.all.hidecmdclick.style.visibility="hidden";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="visible";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		document.all.cmdsyndsenior.style.visibility="visible";
		
		document.all.hidecmdmortgage.style.position="absolute";
	    document.all.hidecmdclick.style.position="absolute";
		document.all.hidecmdmahila.style.position="absolute";
		document.all.hidecmdsyndsenior.style.position="relative";
		document.all.hidecmdsyndvidya.style.position="absolute";
		document.all.cmdsyndsenior.style.position="relative";
		}
		else if(mahila==6 || mahila==7 ||mahila==12 || mahila==13 ||mahila==14 || mahila==15 || mahila==16 || mahila==17 || mahila==18 || mahila==19 || mahila==20 || mahila==21 || mahila==22 || mahila==23 || mahila==24 || mahila==25 || mahila==26)
		{
				
			document.all.hidecmdmortgage.style.visibility="hidden";
			document.all.hidecmdclick.style.visibility="hidden";
			document.all.hidecmdmahila.style.visibility="hidden";
			document.all.hidecmdsyndsenior.style.visibility="hidden";
			document.all.hidecmdsyndvidya.style.visibility="visible";

			document.all.hidecmdmortgage.style.position="absolute";
			document.all.hidecmdclick.style.position="absolute";
			document.all.hidecmdmahila.style.position="absolute";
			document.all.hidecmdsyndsenior.style.position="absolute";
			document.all.hidecmdsyndvidya.style.position="relative";
			
			}
		else if(mahila==1 ||mahila==11)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";
		document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";

		document.all.hidecmdmortgage.style.position="absolute";
		document.all.cmdmortgage.style.position="absolute";
		document.all.hidecmdclick.style.position="relative";
		document.all.hidecmdmahila.style.position="absolute";
		document.all.hidecmdsyndsenior.style.position="absolute";
		document.all.hidecmdsyndvidya.style.position="absolute";
		
		}
		else if(mahila==3)
		{
		
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";

		document.all.hidecmdmortgage.style.position="absolute";
		document.all.hidecmdclick.style.position="relative";
		document.all.hidecmdmahila.style.position="absolute";
		document.all.hidecmdsyndsenior.style.position="absolute";
		document.all.hidecmdsyndvidya.style.position="absolute";
		
		}
		else if(mahila==4)
		{
	
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";

		document.all.hidecmdmortgage.style.position="absolute";
		document.all.hidecmdclick.style.position="relative";
		document.all.hidecmdmahila.style.position="absolute";
		document.all.hidecmdsyndsenior.style.position="absolute";
		document.all.hidecmdsyndvidya.style.position="absolute";
		
		}
	}
	else if(ltype=="H")
	{
		document.all.hidecmdmortgage.style.visibility="hidden";
    	document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		document.all.cmdmortgage.style.visibility="hidden";

		document.all.hidecmdmortgage.style.position="absolute";
    	document.all.hidecmdclick.style.position="relative";
		document.all.hidecmdmahila.style.position="absolute";
		document.all.hidecmdsyndsenior.style.position="absolute";
		document.all.hidecmdsyndvidya.style.position="absolute";
		document.all.cmdmortgage.style.position="absolute";
		
	}
	else if(ltype=="V")
	{
		document.all.hidecmdmortgage.style.visibility="hidden";
		document.all.hidecmdclick.style.visibility="visible";
		document.all.hidecmdmahila.style.visibility="hidden";
		document.all.hidecmdsyndsenior.style.visibility="hidden";
		document.all.hidecmdsyndvidya.style.visibility="hidden";
		//document.all.cmdmortgage.style.visibility="hidden";

		document.all.hidecmdmortgage.style.position="absolute";
		document.all.hidecmdclick.style.position="relative";
		document.all.hidecmdmahila.style.position="absolute";
		document.all.hidecmdsyndsenior.style.position="absolute";
		document.all.hidecmdsyndvidya.style.position="absolute";
		
	}	
   }
   else
   {
	   document.all.hidecmdsyndvidya.style.visibility="visible";
	   document.all.hidecmdsyndvidya.style.position="relative";
   }
   eduprocessnote();
}
function callhelp()
{
	    var varQryString = appUrl+"/jsp/perhlp/hlp_appworkflowaction.jsp"
	    var title = "ApplicantDemographics";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=200,top=150";
		window.open(varQryString,title,prop);
}
function enablesave()
{
    	if(document.forms[0].appstatus.value=="Processed/Approved")		
	     {
	     document.forms[0].cmdactclose.disabled=false;  
	     }
	     else
	     {
	     document.forms[0].cmdactclose.disabled=true;     
	     }
    	if(moduleType=='m' || moduleType=='M')
    	{
    	if(handoffstatus=="Y")
    	{
    		document.forms[0].cmdactclose.disabled=false;     
    	}
    	else
    	{
    		document.forms[0].cmdactclose.disabled=true;     
    	}
    	}
    	   
}
function enablesave1()
{
	//alert("Helloooo"+moduleType);
	for(i=0;i<document.forms[0].txtmail_toflowpoint.length;i++)
	 {
	 if(document.forms[0].txtmail_toflowpoint[i].value >= 10)
	 {
			document.forms[0].cmdactclose.disabled = true;
			 break;
	 }
	 }  
	 if(moduleType =="M" || moduleType=="m")
	 {
		document.forms[0].cmdactclose.disabled = true; 
	 }
}

function callOnload()
{
	var var_appstatus=document.forms[0].appstatus.value;
	document.forms[0].nsdlloan.value = varnsdlloans;
	//document.forms[0].handoff.disabled=true;
	if(reloadflag =="send")
	{ 
		parent.docalReload();	
	}
	if(var_appstatus=="Closed/Approved")
	{
	var input=document.getElementById("frmworkflow");
	for(var i=0;i<input.length;i++)
	{
		if(input[i].type=='button')
		{
			if(input[i].name!='cmdsend')
			{
			input[i].disabled=true;
			}
			}
		}
	document.forms[0].cmdNotReview.disabled=false;
	}
	if(appsanc_sancofficer==strUserId)
	{
		document.forms[0].cmdreject.disabled=false;
	}
	else{
		document.forms[0].cmdreject.disabled=true;
	}

	if(moduleType=='p' || moduleType=='P')
	{
//	var var_appstatus=document.forms[0].appstatus.value;
	if(var_appstatus=="Open/Pending")
	{
		if(varnsdlloans=='Y')
		{
			//document.forms[0].nsdl_disburse.disabled=false;
		}
	document.forms[0].cmdreject.disabled=false;
	}
	}
	document.forms[0].cmdapprove.disabled=true;
	if(msme=="SME"&&var_appstatus!="Closed/Approved")
	{
	document.forms[0].cmdupload.disabled=false;
	}
	if(handoffstatus=="Y")
	{
		//callDisableControls(true,true,true,true,true,true);
		document.forms[0].cmdclose2.disabled=false;     
	}
	else{
	
	if(parseInt(auditorrights)==1)
	{
		document.forms[0].adreport2.disabled=false;
	}
	else
	{

		document.forms[0].adreport2.disabled=true;
	}
	
	if(document.forms[0].appstatus.value=="Open/Pending")
		{
			if(strappeditsameregbranch!="")
			{
				if(strappeditsameregbranch=="disablefalse")
				{
					 <%
					  if(strPgDist.equalsIgnoreCase("P")){ %>
					checkmahila();
					<%}%>
					callDisableControls(false,false,false,false,false,true);
				}
				else if(strappeditsameregbranch=="disabletrue")
				{
					callDisableControls(true,true,true,false,true,true);
				}
			}
		}
	if(document.forms[0].appstatus.value=="Open/Pending" || document.forms[0].appstatus.value=="Processed/Rejected"||document.forms[0].appstatus.value=="Closed/Approved")
	{
		document.forms[0].cmdupload.disabled=true;
	}
	else
	{document.forms[0].cmdupload.disabled=false;
	}
		
	
		document.forms[0].cmdclose2.disabled=false;     
	}	
	 <%
	 if(strPgDist.equalsIgnoreCase("P")){ %>
	 checkmahila();
	checkViewAll(true,true,true,true,true);
	<%}%>

	if(appsanc_sancofficer == "0"){
		appsanc_sancofficer = "";
	}
	if(appsanc_sancofficer1 == "0"){
		appsanc_sancofficer1 = "";
	}
	if(appsanc_sancofficer2 == "0"){
		appsanc_sancofficer2 = "";
	}

	if(document.forms[0].appstatus.value=="Processed/Rejected"||document.forms[0].appstatus.value=="Closed/Approved"){
		document.forms[0].cmdupload.disabled=true;
		}
	if(document.forms[0].appstatus.value=="Open/Pending"){
		if(strprdid=="C")
		{
			//document.all.handoff.style.visibility="hidden";
			//document.all.handoff.style.position="absolute";
		
		}
		else
			document.all.handoff.style.visibility="visible";
			document.all.handoff.style.position="relative";	
		}
	var varcbsno=document.forms[0].cbsaccno.value;
	if(varcbsno=="Not Generated")
	{
		document.forms[0].cmdupload.disabled=true;
	}
	if((var_appstatus == "Processed/Approved" || var_appstatus=="Closed/Approved") && (varRevAuth=="Y"))
	{
		document.forms[0].cmdTakeNote.disabled=false;
	}else{
		 document.forms[0].cmdTakeNote.disabled=true;
	}
	if(varROuser=="R")
	{
		document.forms[0].cmdupload.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}
	if(varRNEnable == "Y")
	{
		
			document.forms[0].cmdReview.disabled=true;
			//document.forms[0].cmdTakeNote.disabled=false; 
	}	
else
	{
	if(varSRDoneFlag == "Y")
	{
		if(varROuser=="R")
		{
		document.forms[0].cmdReview.disabled=true;
		}
		//document.forms[0].cmdTakeNote.disabled=false; 
	}
	else{
		
			//document.forms[0].cmdTakeNote.disabled=true; 
			}
		}  

	if(varROuser=="R")
	{
		if(varSRDoneFlag == "Y")
		{
			document.forms[0].cmdReview.disabled=true;
			//document.forms[0].cmdTakeNote.disabled=false; 
		}
		else if(varRNEnable == "Y")
		{
			document.forms[0].cmdReview.disabled=false;
			//document.forms[0].cmdTakeNote.disabled=false; 
		}
	}
	else if(varOrgLevel == "A")
	{
		if(varSRDoneFlag == "Y")
		{ 
			//document.forms[0].cmdTakeNote.disabled=false; 
		}
		else if(varRNEnable == "Y")
		{ 
			//document.forms[0].cmdTakeNote.disabled=false; 
		}
		else
		{
			//document.forms[0].cmdTakeNote.disabled=true;
		}
	}
	else
	{ 
		//document.forms[0].cmdTakeNote.disabled=true; 
	}

	if(moduleType =="P")
	{
		if(strEligibleRev =="N" || APP_SR_ELIG == "y")
	{
		
		document.all.id_cmdLRFCheck.style.visibility="visible";
		document.all.id_cmdLRFCheck.style.position="relative";
	}
	else
	{
		document.all.id_cmdLRFCheck.style.visibility="hidden";
		document.all.id_cmdLRFCheck.style.position="absolute";
	}
	}

	if(strAppSRDone =="Y")
	{
		document.forms[0].cmdundo.disabled=true; 
	}
	if(var_appstatus=="Closed/Approved" && strAppSRDone =="Y" && APP_CLOSED =="Y")
	{
		callDisableControls(true,true,true,true,true,true);
		<%
		if(arrFlowpoint.size()!=0)
		{%>
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			
			if(document.forms[0].txtmail_toflowpoint[i].value<34)
			{
				document.forms[0].optflowpnt[i].disabled=true;//as per bank requirement. flow point disabling after approved/handoff and review note done
			}
		}
		<%
		}%>
		
	}
	if(var_appstatus=="Processed/Approved" && strAppSRDone =="Y" && APP_CLOSED =="Y")
	{
		callDisableControls(false,true,true,true,true,true);
		<%
		if(arrFlowpoint.size()!=0)
		{%>
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			
			if(document.forms[0].txtmail_toflowpoint[i].value<34)
			{
				document.forms[0].optflowpnt[i].disabled=true;//as per bank requirement. flow point disabling after approved/handoff and review note done
			}
		}
		<%
		}%>
		
	}
	if(varROuser=="R")
	{
		document.forms[0].cmdNotReview.disabled=false;
	}
	else
	{
		document.forms[0].cmdNotReview.disabled=true;
	}
		if(var_appstatus=="Closed/Approved")
		{
			document.forms[0].cmdupload.disabled=true;
		}
	}
function callDisableControls(cmdupload,cmdApprove,cmdReject,cmdUndo,cmdSend,cmdSave)
{
	document.forms[0].cmdupload.disabled=cmdupload;
	document.forms[0].cmdapprove.disabled=cmdApprove;
	document.forms[0].cmdreject.disabled=cmdReject;
	document.forms[0].cmdundo.disabled=cmdUndo;
	if(document.forms[0].hid_appholder.value=="Y")
	{
		document.forms[0].cmdsend.disabled=false;
	}
	else
	{
		document.forms[0].cmdsend.disabled=true;
	}
	//document.forms[0].cmdactclose.disabled=cmdSave;
}
function callRemarks()
{
		document.forms[0].hidBeanId.value="mailboxcomments";
		document.forms[0].hidBeanGetMethod.value="getData";
		appno = document.forms[0].hidapno.value;
		var strPgDist =document.forms[0].strPgDist.value;
		var prop = "scrollbars=no,width=550,height=550,top=25,left=180";
		var url=appUrl+"action/workflowcomm.jsp?hidappno="+appno+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+"&editoption="+document.forms[0].hideditoption.value+
		"&strPgDist="+strPgDist;
		window.open(url,"remarks",prop);
}


function callOrgHelp()
{
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appUrl+"action/orgnamelist.jsp?hidBeanId=mailaddress&hidBeanGetMethod=getDataHelp";
	window.open(url,"",prop);
}

function callUsersHelp()
{
	//alert(usr_class);
	//if (document.forms[0].appstatus.value=="Open/Pending")
	//{
		if(usr_class=="")
		{
	        ShowAlert(111,"Flowpoint");
			return;
		}
	//} 
	if(varROuser=="R")
	{
		if(usr_class=="")
		{
	        ShowAlert(111,"Flowpoint");
			return;
		}
	} 
	
	userid='<%=(String)session.getAttribute("strUserId")%>';
	var prop="scrollbars=no,width=600,height=350,top=100,left=350";
	var url=appUrl+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value+
	"&usr_func="+usr_func+"&struser_id="+userid+"&varROuser="+document.forms[0].org_name.value+"&varSRConfFlag="+varSRConfFlag+"&ROflowpoint="+document.forms[0].mail_toflowID.value+"&AgriPage=N";  
	window.open(url,"hai",prop);
}

function setValues(idx,userclass)
{
	//alert(userclass);
	usr_class=userclass;
	usr_func = document.forms[0].wrkfuncname[idx].value;
	wrkflw_id = document.forms[0].wrkflwID[idx].value;
	document.forms[0].mail_toflowID.value = wrkflw_id;  
	document.forms[0].mail_tousrid.value="";
	document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint[idx].value;
	//alert("Workflow-->"+wrkflw_id+"flowpint"+document.forms[0].mail_toflowpoint.value);

}

function placeValues()
{
	var arrsize="<%=arrFlowpoint.size()%>";

	var maxclass="<%=Helper.correctNull((String)hshValues.get("strMaxClass"))%>";
	
	if(userclass<maxclass)
	{
		document.forms[0].cmdsend.disabled=true;
	}
	if(userclass>=skipclass && document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].cmdapprove.disabled=false;
		 <%
		 if(strPgDist.equalsIgnoreCase("P")){ %>
		checkmahila();
		<%}%>
		document.forms[0].cmdreject.disabled=false;
		//document.forms[0].cmdundo.disabled=false;
	}
	if(userclass>=appclass && document.forms[0].appstatus.value=="Open/Pending" && currflowpoint==arrsize)
	{
		document.forms[0].cmdapprove.disabled=false;
		 <%
		 if(strPgDist.equalsIgnoreCase("P")){ %>
		checkmahila();
		<%}%>
		document.forms[0].cmdreject.disabled=false;
		//document.forms[0].cmdundo.disabled=false;
	}
	if(document.forms[0].appstatus.value!="Open/Pending")
	{
		if(userclass>=appclass && (currflowpoint==10 || currflowpoint==18))
		{
			document.forms[0].cmdundo.disabled=false;
		}
		<%
		if(arrFlowpoint.size()!=0)
		{					%>
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			
			if(document.forms[0].txtmail_toflowpoint[i].value<10)
			{
				document.forms[0].optflowpnt[i].disabled=true;//as per bank requirement. flow point enabling after approved/handoff
			}
		}
		<%
		}%>
	}

	if(document.forms[0].appstatus.value!="Open/Pending")
	{
		var cmdsave = 0;
		<%
		if(arrFlowpoint.size()!=0)
		{
			%>
		for(i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].optflowpnt[i].checked == true)
			{
				//document.forms[0].cmdactclose.disabled=false;
				cmdsave = 1;
				break;
			}
		}
		if(cmdsave == 0)
		{
			//document.forms[0].cmdactclose.disabled=true;
		}
	<%	}%>
	}
	else
	{
		//document.forms[0].cmdactclose.disabled=true;
	}
/*	if(workflow!="Y")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		document.forms[0].cmdsend.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}
*/

/*	if(varSRDoneFlag == 'Y')
	{
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].txtmail_toflowpoint[i].value<30)
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
	}
*/

	if(handoffstatus=="Y")
	{
		document.forms[0].cmdundo.disabled=true;
	}
}
function openWindow(pagename)
{
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	window.open(url,"report","scrollbars=no,toolbars=no,menubar=no,width=450,height=300,left=60,top=40");
}


function doSend()
{
	var var_appstatus=document.forms[0].appstatus.value;
	if(usr_class=="")
	{
		ShowAlert(111,"Flowpoint");
		return;
	}
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}

	//if(parseInt(userclass)<parseInt(skipclass))
	//{
		///if(parseInt(currflowpoint)+1<parseInt(document.forms[0].mail_toflowpoint.value))
		//{
		//ShowAlert(132);
		//return;
		//}
	//}
		if(var_appstatus=="Closed/Approved")
		{
		<%
		if(arrWorkFlowId.size()!=0)
		{%>
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			
			if(document.forms[0].wrkflwID[i].value == "31")
			{
				<%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
				if(chkNewInterestRate  == "Y")
				{
					alert("Interest Rate is not same as in MCLR/EBLPR. Surf to please Check Loan particulars.");
					return;
				}
				<%}%>
			}
		}
		<%}%>
	}
	
	/*if(strRemarksFlag!="1")
	{
		if(confirm("Do you want to enter any remarks"))
		{strRemarksFlag="1";
			document.forms[0].hideditoption.value="Y";
			callRemarks();
			return;
		}
	}*/	
		
	document.forms[0].sandButtonValue.value="send";
	document.forms[0].hidSourceUrl.value="/action/NP_appworkflowaction.jsp" ;
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidAction.value="send";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	//document.forms[0].action=appUrl+"action/navigation.jsp";
	//document.forms[0].submit();
	if(ConfirmMsg(100))
		{
			
			if("<%=strPgDist%>"=="P")
			{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perexisting.jsp";
			}else
			{
			document.forms[0].action ="<%=ApplicationParams.getAppUrl()%>action/comborrowersearch.jsp?hidPageType=EXI";
			}
			
			document.forms[0].submit();
		}

}

function doProcess(action)
{

	if(Holiday =="1" || flag=="Y") //1 - Working DaY (Design Based on CBS Table..)
	{
	<%if(!strPrdtype.equalsIgnoreCase("C")){
	%>
	if(appsanc_sancofficer2=="")
		{
			if(appsanc_sancofficer1=="")
			{
				if(appsanc_sancofficercpc=="")
				{
					if(appsanc_sancofficer=="")
					{
						alert("select Sanctioning Authority in Appraisal Screen");
						return false;
					}
					else
					{
						if(appsanc_sancofficer==strUserId)
						{
							actionchk(action);
						}else {
							alert("Refer to Sanctioning Authority. Surf to Appraisal -> Appraisal -> Sanctioning Id .click edit,change sanction Id to Current sanction Id and click apply");
						}
					}					
				}	
				else
				{
					if(appsanc_sancofficercpc==strUserId)
					{
						actionchk(action);
					}else {
						alert("Refer to Sanctioning Authority. Surf to Appraisal -> Appraisal -> Sanctioning Id .click edit,change sanction Id to Current sanction Id and click apply");
					}				
				}	
			}
			else
			{
				if(appsanc_sancofficer1==strUserId)
				{
					
					actionchk(action);
				}
				else 
				{
					alert("Refer to Sanctioning Authority. Surf to Appraisal -> Appraisal -> Sanctioning Id .click edit,change sanction Id to Current sanction Id and click apply");
				}	
			}
			
		}
		else
		{
			if(appsanc_sancofficer2==strUserId)
			{
				actionchk(action);
			}
			else 
			{
				alert("Refer to Sanctioning Authority. Surf to Appraisal -> Appraisal -> Sanctioning Id .click edit,change sanction Id to Current sanction Id and click apply");
			}	
		}
	<%}
	
	else{ %>
	     actionchk(action);
	<%}%>
	}
	
	else{
		alert("You Cannot Process this screen in Holiday!!!");
		return;
	}
	
}

function actionchk(action)
{ 
	if(action=="approve")
		{
		//section added on 06-05-2021
			if(varstrAppStatus!="pa" && varstrAppStatus!="ca")
			{
				if(varstrLoanfor=="EDU")
				{
					if(varBam83count != "0")
				    {
				        alert("Kindly fill MisBam-83 before approve.");
				        return;
				    }
					//added on 17-06-2021 for co-borrower Multiple CIC Check Section Starts
					<%
						if (EducationCoBorrowerCICDataListRows != null && EducationCoBorrowerCICDataListRows.size() > 0) {
							if (EducationCoBorrowerCICDataListRows.size() > 0) {
								for (int i = 0; i < EducationCoBorrowerCICDataListRows.size(); i++) {
									EducationCoBorrowerCICDataListCols = (ArrayList) EducationCoBorrowerCICDataListRows.get(i);
					%>
									var cicScoreCountForCoborrowerID="<%=Helper.correctNull((String) EducationCoBorrowerCICDataListCols.get(0))%>";
									var cicScoreCountForCoborrower="<%=Helper.correctNull((String) EducationCoBorrowerCICDataListCols.get(1))%>";
									if(parseInt(varstrAmountReq)<=parseInt(varcicAmountCheck))
									{
										if(cicScoreCountForCoborrower<1){
											alert("Kindly obtain CIC score for at least one CIC as per circular 165/2020 in CIC Check available in LAPS Home Page and Link it in Education Loan-> Applicant-> Co-Applicant/Guarantor page for ID "+cicScoreCountForCoborrowerID);
											return;
										}
									}
									if(parseInt(varstrAmountReq)>parseInt(varcicAmountCheck))
									{
										if(cicScoreCountForCoborrower<2){
											alert("Kindly obtain CIC score for at least two CICs as per circular 165/2020 in CIC Check available in LAPS Home Page and Link it in Education Loan-> Applicant-> Co-Applicant/Guarantor page for ID "+cicScoreCountForCoborrowerID);
											return;
										}
									}
					<%}}}%>
					//added on 17-06-2021 for co-borrower Multiple CIC Check Section ends
					
					if(parseInt(strrecamt)<=parseInt(varCicAmountCheck))
					{
						if(varcicScoreCount<1){
							alert("Kindly obtain score for at least One CICs as per Cir 165/2020 in Borrower Details Page ");
							return;
						}
					}
					if(parseInt(strrecamt)>parseInt(varCicAmountCheck))
					{
						if(varcicScoreCount<2){
							alert("Kindly obtain score for at least Two CICs as per Cir 165/2020 in Borrower Details Page ");
							return;
						}
					}
					if(strCollDesc == "Y")
				    {
				        alert("Property Description in Security Details should be less than 40 Char");
				        return;
				    }
					if(strUniv.length > 40)
				    {
						alert("Name of University/Institution in Course Details should be less than 40 Char");
				        return;
				    }
				    if(strCourse.length > 40)
				    {
						alert("Name of course in Course Details should be less than 40 Char");
				        return;
				    }
				    var regex = /^[A-Za-z0-9 ]+$/;
				    var isValidUniv = regex.test(strUniv);
				    if (!isValidUniv){
				    	alert("Please remove special characters in Name of University/Institution");
						return;
				    }
				    var isValidCoures = regex.test(strCourse);
				    if (!isValidCoures){
				    	alert("Please remove special characters in Name of Course");
						return;
				    }
					if(varApplicantRelation =="NO")
					{
						alert("Please Enter Customer Relation in Borrower Page");
						return;
					}
					if(varCoapplicantRelation =="NO")
					{
						alert("Please Enter Customer Relation for Co-Borrower/Guarantor");
						return;
					}
					if(EDU_LOANPURPOSE == "" || EDU_LOANPURPOSE== "s"){
						alert("select Purpose of Loan In Edu Loan-->Course Details");
						return false;
					}
				}
			}
		//section added on 06-05-2021
		if((parseInt(strproductcode)==parseInt("975"))||(parseInt(strproductcode)==parseInt("985"))  ||(parseInt(strproductcode)==parseInt("965"))  ||(parseInt(strproductcode)==parseInt("966"))
				 ||(parseInt(strproductcode)==parseInt("977"))  ||(parseInt(strproductcode)==parseInt("978")))
		{
			alert("Old Product is blocked. Please click on eligibility calculation tab and click on appropriate product code . Click on tab button and proceed till the interest rate changes. Check all the other parameters, if in order then click on save and proceed.");
			return;
		}
		if(varBorrowerMigVal =="1"){
			if(moduleType=='p' || moduleType=='P'){
		/*	if(varApplicantRelation =="NO")
			{
				alert("Please Enter Customer Relation in Borrower Page");
				return;
			}
			if(varstrCBSFeildsData =="")
			{
				alert("Please Surf the Eligibile Page.");
				return;
			}
			if(varCoapplicantRelation =="NO")
			{
				alert("Please Enter Customer Relation for Co-Borrower/Guarantor");
				return;
			} */
			}
		}
		   /* if( varRMLCflag == "Y" && eval(vardblproposedLoanAmt) > eval(vardblsetupmaxamtAmt))
			{
				alert("Sanction Amount cannot be more than Defined Maximum loan limit  in Setup Value.");
				return false;
			}*/
			if(varProvisionCheck =="yes")
			{
				alert("Please Fill the Provisional Extension value in Facilities Page");
				return;	
			}
			if(varSyndudhyami =="ONE")
			{
				alert("Please Select Per Assessment Calculation in case of Syn-udhyami in Facilities Page.");
				return;
			}
			else if(varSyndudhyami =="TWO") 
			{
				alert("Please Select Schemes-Activity Code in Brief Background");
				return;
			}
			else if(varSyndudhyami =="THREE") 
			{
				alert("In case of Synd Udhyami, Synd Rating Should be below Synd 6");
				return;
			}
			else if(varSyndudhyami =="FOUR") 
			{
				alert("In case of Synd Udhyami please enter the Collateral Details in Security/Asset & Liablities page");
				return;
			}
			else if(varSyndudhyami =="FIVE") 
			{
				alert("Kindly Fill Term Loan of the loans in Facilities Page. Its Invalidated ");
				return;
			}
			if(varSyndBeml =="ONE")
			{
				alert("Kindly Fill Term Loan of the loans in Facilities Page. Its Invalidated ");
				return;
			}
			if(varSyndBeml =="TWO")
			{
				alert("In case of Synd BEML, Synd Rating Should be below Synd 6");
				return;
			}




			if((parseInt(strproductcode)!=parseInt("947"))&&(parseInt(strproductcode)!=parseInt("948"))  &&(parseInt(strproductcode)!=parseInt("949"))  &&(parseInt(strproductcode)!=parseInt("950"))&&(parseInt(strproductcode)!=parseInt("651"))&&(parseInt(strproductcode)!=parseInt("654"))&&(parseInt(strproductcode)!=parseInt("655")))
			{			
			if(varCIBILCheckType !="" && varCIBILStatus !="")
			{
				alert("Kindly Fill and Fetch The CIBIL Details of"+ varCIBILCheckType);
				return;
			}
			}
			if(varcibilMSMEtype !="")
			{
				alert("Kindly Fill and Fetch The CIBIL Details of Borrower/Applicant");
				return;
			}
			if(varcibilPromotertype !="")
			{
				alert("Kindly Fill and Fetch The CIBIL Details of Customer ID  "+varcibilPromotertype);
				return;
			}
				if(varDocAttached == "Y")
				{
					//alert("Kindly upload the data");
					//return;
				}
		
				if(varloginid == varuserid)
				{
					alert("The Application Creator cannot approve the application");
					return;
				}
				<%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
				if(chkNewInterestRate  == "Y")
				{
					alert("Interest Rate is not same as in MCLR/EBLPR. Surf to please Check Loan particulars.");
					return false;
				}
				<%}%>
				if(varPmayCheck  == "PMAYNOTOK")
				{
					alert("Please Fill the PMAY House Details (Applicant-->PMAY House Details).");
					return false;
				}
				if((parseInt(strproductcode)==parseInt("974"))||(parseInt(strproductcode)==parseInt("973"))){
				if(varselPmay  == "")
				{
					alert("Whether the Proposal comes under PMAY Scheme?,Go to Eligibility Caluclation page, Do EDIT&APPLY.");
					return false;
				}
				}
		if("<%=strCategoryType%>"=="SME")
		{
			if(varRatingStatus=="N")
			{
				alert("Please fill the data in (Home -> MSME -> Proposal -> Rating -> Internal Rating)");
				return;
			}
			if(varRecommendStatus=="N")
			{
				alert("Please fill the data in (Home ->MSME-> Proposal -> Others -> Recommendations)");
				return;
			}
		}
		
			if(Flag_Grprights=="Y")
			{
				alert("You have no rights to Approve the Application!!!");
				return;
			}	
			if(varMarginlimitcheck == "N")
			{
				if(varOrgLevel == "A" || varOrgLevel == "R")
				{
				alert("Loan amount exceeds limit as per Margin criteria");
				return;
				}
			}	
		
				var sanlimit=0;
				var prdsanlimit=0;
				var recamount =0;
				if(strsanctionlimit!="")
				{
					sanlimit=parseFloat(strsanctionlimit);
				}
				if(strrecamt!="")
				{
					recamount=parseFloat(strrecamt);
				}
				if(strprdsanctionlimit!="")
				{
					prdsanlimit=parseFloat(strprdsanctionlimit);
				}


				if("<%=strCategoryType%>"!="SME")
				{
				setup_roi=parseFloat(setup_roi);
				loanpage_ROI=parseFloat(loanpage_ROI);
				variance_ROI=parseFloat(variance_ROI);
				var baserate=loanpage_ROI-variance_ROI;
				
				/*if(setup_roi<baserate)
				{
					alert("MCLR is not correct, please attach the New product in Loan Product Page");
					return;
					
				}
				else
				{
					
				}
				
				if(setup_roi>loanpage_ROI)
				{
					alert("Rate of Interest is not correct, please check Loan Product Page");
					return;
					
				}
				else
				{
					
				}*/

				if(eval(varFCRMorat)<1)
				{
					alert("Moratorium is not correct, please check Loan Product Page");
					return;
				}
				else
				{
					
				}

				if(varFCRIntserviced=='Yes' && eval(varFCRMorat)<2)
				{
					alert("Interest Serviced During Moratorium is not correct,please check Loan Product Page");
					return;
				}
				else
				{
					
				}
				
				var varFCRNoofinst = eval(varFCRTerms)-eval(varFCRMorat);
				if(eval(varFCRNoofinst)<1)
				{
					alert("No. of Installment is not correct, please check Loan Product Page");
					return;
				}
				else
				{
					
				} 
				
				}
				
				if("<%=strCategoryType%>"=="SME")
				{
				setup_roi=parseFloat(setup_roi);
				term_roi=parseFloat(term_roi);
				working_roi=parseFloat(working_roi);
				term_br=parseFloat(term_br);
				working_br=parseFloat(working_br);

				/*
				if(setup_roi<term_br)
				{
					alert("MCLR is not correct, please attach the New Term Loan in Facilities Page");
					return;	
				}
				else
				{
					
				}

				
				if(setup_roi<working_br)
				{
					alert("MCLR is not correct, please attach the New Working Capital in Facilities Page");
					return;	
				}
				else
				{
					
				}
				
				if(setup_roi>term_roi)
				{
					alert("Rate of Interest is not correct, please check Facilities Page Term Loan");
					return;
					
				}
				else
				{
					
				}
				if(setup_roi>working_roi)
				{
					alert("Rate of Interest is not correct, please check Facilities Page Working Capital");
					return;
					
				}
				else
				{
					
				}*/

				if(eval(varFCRRepayholiday)<1)
				{
					alert("Moratorium is not correct,please check Facilities Page Term Loan");
					return;
				}
				else
				{
					
				}
				
				var varFCRNoofinst_MSME = eval(varFCRRepayperiod)-eval(varFCRRepayholiday);
				if(eval(varFCRNoofinst_MSME)<1)
				{
					alert("No. of Installment is not correct,please check Facilities Page Term Loan");
					return;
				}
				else
				{
					
				}  

				if(varFCRIntServised=='y' && eval(varFCRRepayholiday)<2)
				{
					alert("Interest Serviced During Moratorium is not correct,please check Facilities Page Term Loan");
					return;
				}
				else
				{
					
				}
				
				if(eval(varFCREmiamnt)<1)
				{
					alert("Emi Amount is not correct,please check Facilities Page Term Loan");
					return;
				}
				else
				{
					
				}
				
				}
		/*		if(sanlimit<recamount)
				{
					alert("You should not sanction above "+sanlimit +" your limit");
					return;
				}
				else
		*/		
				if(prdsanlimit<recamount)
				{
		//			alert("You should not sanction above "+prdsanlimit +" for this product");
		//			return;
				}
				if(varschemesantcode == "Select")
				{
					alert("Kindly Select the Scheme Activity code in Facility ");
					return;
				}
				if(varBBschemesantcode ==  "Select")
				{
					alert("Kindly Select the Scheme Activity code in Brief Backgroud page");
					return;
				}
				if(varschemesantcode != varBBschemesantcode)
				{
					alert("Scheme Activity code in Facility and Brief Backgroud page must be equal");
					return;
				}
				if(CourseExpFlag == "Y")
				{
					alert("Proposed Loan Amount in LoanProduct page should be equal to Sum of Eligible Loan Amount in Course Expenses page");
					return;
				}
				if(CourseGrandTotal == "Y")
				{
					alert("Cost of Project in LoanProduct page should be equal to Sum of Grand Total(INR) in Course Expenses page");
					return;
				}
				if(SecurityFlag == "N")
				{
					alert("Kindly fill Security details in Appraisal-->ProcessNote");
					return;
				}
				if(varAllowBranch == "N")
				{
					alert("RAH Linked Branch Can't Approve Loan At Branch Level");
					return;
				}
				if(EduLoanDetail =="N")
				{
					alert("Kindly fill Particulars of Student,Educational Details,Course Details and Course Expenses in Edu Loan");
					return false;
				}
				if(coAppGuaFlag =="N")
				{
					alert("Please Add Co-Borrower/Guarantor or change Customer Relation to 'SOW' in Borrower Page");
					return false;
				}
				/*if(varCanaraSyndBank=="C"){
					if(varcollteralFlag == "Y")
					{
					if (varcollatercode!="Y")
					{	
					alert("Please update collateral code in Detailed Application -> Property Details tab");
					return;
					}
					}
				}*/
				
				if(varnsdlloans=='Y')
				{
					document.getElementById("nsdlremark").style.visibility="visible";
					document.getElementById("nsdlremark").style.position="relative";
					document.forms[0].nsdlremarkdata.style.visibility="visible";
					document.forms[0].nsdlremarkdata.style.position="relative";
					if(document.forms[0].nsdlremarkdata.value==0)
					{
						alert("Please Fill Remarks for NSDL Application.");
						document.forms[0].nsdlremarkdata.focus();
						return;
					}
				}
			}
			if(action=="undo")
			{
				if(strUserId!=approvedby)
				{
					alert("You cannot Undo this application");
					return false;
				}
				/*else if(SanctionReviewFlag =="RE")
				{
					alert("Undo Option Not Possible for these Account");
					return false;
				}*/
					
			}
			else if(action=="reject")
			{
				if("<%=strCategoryType%>"=="SME")
				{

					
					if(varRatingStatus=="N")
					{
						alert("Please fill the data in (Home -> MSME -> Proposal -> Rating -> Internal Rating)");
						return;
					}
					if(varRecommendStatus=="N")
					{
						alert("Please fill the data in (Home ->MSME-> Proposal -> Others -> Recommendations)");
						return;
					}
				}
			}
			var moduleType="<%=moduleType%>";
			var entr_pass="<%=entr_pass%>";
			var rsk_returncode="<%=rsk_returncode%>";
			var rsk_returnmsg="<%=rsk_returnmsg%>";


			
		/*
		     Comment by Saravanan for Internal Rating Definition 
		
			if(trim(moduleType)=="M")
			{
				if(parseInt(rsk_returncode)!=3)
				{
					if(entr_pass)
					{
						alert(rsk_returnmsg);
						return;
					}
				}
			}*/
		if(action=="approve")
		{
			if(varCibilPage=="Y")
			{
				/*var con=ConfirmMsg('173');
				if(con)
				{
					//var txt_perappid=document.forms[0].txt_perappid.value;
					document.forms[0].hidBeanId.value="cibilInterface";
					document.forms[0].hidBeanGetMethod.value="getCibilPageDetails";
					document.forms[0].action=appUrl+"action/cibilReports.jsp";
					document.forms[0].submit();
				}
				else
				{*/
					document.forms[0].hidAction.value=action;
					document.forms[0].hidBeanId.value="NationalPortal";
					document.forms[0].hidBeanMethod.value="updateAction";
					document.forms[0].hidBeanGetMethod.value="getHistory";
					document.forms[0].action=appUrl+"controllerservlet";
					document.forms[0].submit();
				/*}*/
			}
			else
			{
				document.forms[0].hidAction.value=action;
				document.forms[0].hidBeanId.value="NationalPortal";
				document.forms[0].hidBeanMethod.value="updateAction";
				document.forms[0].hidBeanGetMethod.value="getHistory";
				document.forms[0].action=appUrl+"controllerservlet";
				document.forms[0].submit();
			}
		}
		if(action !="approve")
		{
			document.forms[0].hidAction.value=action;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanMethod.value="updateAction";
			document.forms[0].hidBeanGetMethod.value="getHistory";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
}
function doSave()
{
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		alert("Save Processed/Approved Application");
		return false;
	}


	
	//if(handoffstatus=="Y")
	//{
		
	
	document.forms[0].hidSourceUrl.value="/action/NP_appworkflowhistory.jsp"; 
	document.forms[0].hidBeanId.value="NationalPortal";
	document.forms[0].hidBeanMethod.value="getSave";
	document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	//}
	//else{
	//alert("Before save Hand-off the Application");
	//	return false;
	//}
}

function callOtherTab(val)
 {
	 if(val=="history")
	 {
		 document.forms[0].hidBeanId.value="NationalPortal";
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].action=appUrl+"action/NP_appworkflowhistory.jsp";
		 document.forms[0].submit();
	 }
	 if(val=="sanc")
	 {
		 document.forms[0].hidBeanId.value="comproposal";
		 document.forms[0].hidBeanGetMethod.value="getSancLetterdata";
		 document.forms[0].action=appUrl+"action/com_msme_sanctionletter.jsp";
		 document.forms[0].submit();
	 }
	 if(val=="review")
	 {
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].hidBeanGetMethod.value="getReviewDocumentData";
		 document.forms[0].action=appUrl+"action/reviewDocumentsMSME.jsp";
		 document.forms[0].submit();	  
	 }	
 }

 function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}


function doCheck_cbsdata(loan_type,Module)
{
	if((parseInt(strproductcode)==parseInt("975"))||(parseInt(strproductcode)==parseInt("985")) ||(parseInt(strproductcode)==parseInt("965")) || (parseInt(strproductcode)==parseInt("966"))
			||(parseInt(strproductcode)==parseInt("977"))  ||(parseInt(strproductcode)==parseInt("978")))
	{
		alert("Old Product is blocked. Please click on eligibility calculation tab and click on appropriate product code . Click on tab button and proceed till the interest rate changes. Check all the other parameters, if in order then click on save and proceed.");
		return;
	}
	if(document.forms[0].hidHandOff_EDU_Check.value=="Y")
	{
		alert("Handoff Already done for this Application!");
		return;
	}
	var_appstatus=document.forms[0].appstatus.value;
	if(approvedby == "")
	{
	  alert("Approved By user should not be empty");
	  return;
	}
  
  if(approvedDate == "")
	{
	  alert("Approved Date should not be empty");
	  return;
	}
  if(approvedOrgcode == "")
	{
	  alert("Approved Org code should not be empty");
	  return;
	}
	if(Holiday =="1" || flag=="Y")
	{
		if((chkNewInterestRate == "Y") &&(var_appstatus =="Processed/Approved") &&(SanctionReviewFlag =="RE")&& (strAppSRDone =="Y"))
		{
			var message1="Application Number "+varAppNum+"  Interest Rate is not same as in MCLR/EBLPR. Do you want Undo Option ?";
			var status = confirm(message1);
			if(status==true)
			{
				document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" ;
				document.forms[0].hidBeanId.value="commworkflow";
				document.forms[0].hidBeanMethod.value="updateAction";
				document.forms[0].hidBeanGetMethod.value="getAction"; 
				document.forms[0].hidAction.value="ReviewNote";
				document.forms[0].action=appUrl+"controllerservlet";
				document.forms[0].submit();
			}
			else
			{
				return;
			}
		}
		else if((chkNewInterestRate == "Y")&& (var_appstatus !="Open/Pending") )
		{
			<%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
			alert("Interest Rate is not same as in MCLR/EBLPR. please Check Loan particulars.");
			return false;
			<%}%>
			
		}
	if(Module=="RETAIL")
	{
		document.forms[0].cmdupload.disabled=true;
		setup_roi=parseFloat(setup_roi);
		loanpage_ROI=parseFloat(loanpage_ROI);
		variance_ROI=parseFloat(variance_ROI);
		var baserate=loanpage_ROI-variance_ROI;
		/*if(setup_roi<baserate)
		{
			alert("MCLR is not correct, please attach the New product in Loan Product Page");
			return;
			
		}
		else
		{
			
		}*/

		if(eval(varFCRMorat)<1)
		{
			alert("Moratorium is not correct, please check Loan Product Page");
			return;
		}
		else
		{
			
		}

		if(varFCRIntserviced=='Yes' && eval(varFCRMorat)<2)
		{
			alert("Interest Serviced During Moratorium is not correct,please check Loan Product Page");
			return;
		}
		else
		{
			
		}
		
		var varFCRNoofinst = eval(varFCRTerms)-eval(varFCRMorat);
		if(eval(varFCRNoofinst)<1)
		{
			alert("No. of Installment is not correct, please check Loan Product Page");
			return;
		}
		else
		{
			
		}
	}

	if(Module=="MSME")
	{
		setup_roi=parseFloat(setup_roi);
		term_br=parseFloat(term_br);
		working_br=parseFloat(working_br);

		/*if(setup_roi<term_br)
		{
			alert("MCLR is not correct, please attach the New Term Loan in Facilities Page");
			return;	
		}
		else
		{
			
		}*/

		/*
		if(setup_roi<working_br)
		{
			alert("MCLR is not correct, please attach the New Working Capital in Facilities Page");
			return;	
		}
		else
		{
			
		}*/

		if(eval(varFCRRepayholiday)<1)
		{
			alert("Moratorium is not correct,please check Facilities Page Term Loan");
			return;
		}
		else
		{
			
		}
		
		var varFCRNoofinst_MSME = eval(varFCRRepayperiod)-eval(varFCRRepayholiday);
		if(eval(varFCRNoofinst_MSME)<1)
		{
			alert("No. of Installment is not correct, please check Facilities Page Term Loan");
			return;
		}
		else
		{
			
		}

		if(varFCRIntServised=='y' && eval(varFCRRepayholiday)<2)
		{
			alert("Interest Serviced During Moratorium is not correct,please check Facilities Page Term Loan");
			return;
		}
		else
		{
			
		}
		
		if(eval(varFCREmiamnt)<1)
		{
			alert("Emi Amount is not correct,please check Facilities Page Term Loan");
			return;
		}
		else
		{
			
		}
	}
	
	if (document.forms[0].appstatus.value=="Open/Pending")
	{	
	alert("You cannot Handoff to CBS before approval of the loan contract");
	return;
	}
	var app_no = document.forms[0].hidapno.value;
	if((Module=="RETAIL" )&& (chkNewInterestRate != "Y"))
	//if((Module=="RETAIL" ))
	{
	var varQryString = appURL+"action/per_CBSDatacheck.jsp?hidBeanId=commworkflow&hidBeanGetMethod=getAction&hidmodule=eduLoan";
	var prop = "scrollbars=yes,width=750,height=500";	
	var title = "Upload";
	prop = prop + ",left=70,top=100";
	window.open(varQryString,title,prop);	
	}
	
	else if((Module=="MSME") && (chkNewInterestRate != "Y"))
	{
		var varQryString = appURL+"action/com_msmehandoff.jsp?hidBeanId=comproposal&hidBeanGetMethod=getComcbshandoff&appno="+app_no+"&loan_type="+loan_type;
		var prop = "scrollbars=yes,width=950,height=600";	
		var title = "Upload";
		prop = prop + ",left=100,top=300";
		window.open(varQryString,title,prop);	
	}
	else
	{
		return;
	}
	}
	else{
		alert("You Cannot Process this screen in Holiday!!!");
		return;
	}
}

function ShowDocuments(page)
{
	var demoid = document.forms[0].hidDemoId.value;
	var url = appURL+"action/"+page;
	var title = "Documents";
	var prop = "scrollbars=no,width=475,height=450,menubar=no";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}

function checkViewAll(bool1,bool2,bool3,bool4,bool5)
{
	var_appstatus=document.forms[0].appstatus.value;
	if(varCanaraSyndBank=="S")
	{
	document.forms[0].processnote.disabled=bool1;
	document.forms[0].contless20processnote.disabled=bool2;
	}
	document.forms[0].eduprocessnote.disabled=bool3;
	if(parseInt(strproductcode)==parseInt("975") || parseInt(strproductcode)==parseInt("935"))
	{
		if(detailsfilled=="N"){
			alert("Process Note can not be left blank");                  // Details I and Details II cannot be left Blank in Process Note
			<%if(!strproductcode.equals("947") && !strproductcode.equals("948") && !strproductcode.equals("949") && !strproductcode.equals("950")&& !strproductcode.equals("651")&& !strproductcode.equals("654")&& !strproductcode.equals("655") ){ %>			
			document.forms[0].cmdRiskcheck.disabled=true;
			<%}%>
			document.forms[0].cmdapprove.disabled=false;
			return;
			}
		if(var_appstatus=="Open/Pending")
		{
			<%if(!strproductcode.equals("947") && !strproductcode.equals("948") && !strproductcode.equals("949") && !strproductcode.equals("950")&& !strproductcode.equals("651")&& !strproductcode.equals("654")&& !strproductcode.equals("655") ){ %>		
			document.forms[0].cmdRiskcheck.disabled=true;
			<%}%>
			if(strEligibleRev =="N" || APP_SR_ELIG == "y")
			{
				document.forms[0].cmdapprove.disabled=true;
			}
			else
			{
				document.forms[0].cmdapprove.disabled=false;
			}
			
		}
		
		document.forms[0].cmdLRFCheck.disabled=bool5;
	}
	else
	{
		<%if(!strproductcode.equals("947") && !strproductcode.equals("948") && !strproductcode.equals("949") && !strproductcode.equals("950") && !strproductcode.equals("651") && !strproductcode.equals("654") && !strproductcode.equals("655") ){ %>				
		document.forms[0].cmdRiskcheck.disabled=bool4;
		<%}%>
		<%if(strproductcode.equals("947") || strproductcode.equals("948") || strproductcode.equals("949") || strproductcode.equals("950")|| strproductcode.equals("651")|| strproductcode.equals("654")|| strproductcode.equals("655") ){ %>				
		document.forms[0].cmdapprove.disabled=false;
		<%}%>
		
		document.forms[0].cmdLRFCheck.disabled=bool5;
	}
	
}

function callProcessNote()
{
	if(LimitType=="1")
	{
		var page = "com_processnoteupto1lacs.jsp";
		var appno	= document.forms[0].hidapno.value;
		var appid	= document.forms[0].hidDemoId.value;
		url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&hidBeanId=applicantreport&hidBeanGetMethod=getProcessNoteupto10lacs"+"&hidDemoId="+appid;
		var title = "ProcessNoteupto10Lacs";
		var prop = "scrollbars=yes,width=900,height=600,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);
	}
	else if(LimitType=="2")
	{
		var page = "com_processnote10lacsto2croreWC.jsp";
		var appno	= document.forms[0].hidapno.value;
		var appid	= document.forms[0].hidDemoId.value;
		url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&hidBeanId=applicantreport&hidBeanGetMethod=getProcessNote10lacsto2CroreWC"+"&hidDemoId="+appid;
		var title = "ProcessNote10Lacsto2Crore";
		var prop = "scrollbars=yes,width=900,height=600,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);
	}
	//checkViewAll(false,false,false,false);
}
function callProcessNote1()
{
	var page = "com_processnote10lacsto2croreWC.jsp";
	var appno	= document.forms[0].hidapno.value;
	var appid	= document.forms[0].hidDemoId.value;
	url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+appno+"&hidBeanId=applicantreport&hidBeanGetMethod=getProcessNote10lacsto2CroreWC"+"&hidDemoId="+appid;
	var title = "ProcessNote10Lacsto2Crore";
	var prop = "scrollbars=yes,width=900,height=600,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
	//checkViewAll(false,false,false,false);
}
function approve_btncontrol()
{
	if(moduleType=='p' || moduleType=='P')
	{
		document.forms[0].cmdapprove.disabled=true;
	}
	
}

function hideallbutn()
{
		var var_appstatus=document.forms[0].appstatus.value;
		var varcbsno=document.forms[0].cbsaccno.value;
		if(varcbsno!="Not Generated")
		{	
			document.forms[0].cmdapprove.disabled=true;
			if(document.forms[0].hid_appholder.value=="Y")
			{
			document.forms[0].cmdundo.disabled=false;
			document.forms[0].cmdsend.disabled=false;
			}
			else
			{
				document.forms[0].cmdsend.disabled=true;
			}
				
		}
		else
		{
			if(moduleType=='M' || moduleType=='m')
			{
				if(var_appstatus=="Processed/Approved"  ||  var_appstatus=="Processed/Rejected")
				{	
							document.forms[0].cmdapprove.disabled=true;
							document.forms[0].cmdreject.disabled=true;
							//document.forms[0].cmdundo.disabled=true;	
							//document.forms[0].cmdactclose.disabled=false;
				}
				
			}
		}		
}



function CallApprvButtn()
{
	if(moduleType=='M' || moduleType=='m')
	{
		var var_appstatus=document.forms[0].appstatus.value;

	if(var_appstatus=="Processed/Approved"  ||  var_appstatus=="Processed/Rejected")
	{		
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
		//document.forms[0].cmdundo.disabled=true;	
		//document.forms[0].cmdactclose.disabled=false;
	}
	else if(var_appstatus=="Open/Pending")
	{
		document.forms[0].cmdapprove.disabled=false;
		document.forms[0].cmdreject.disabled=false;
		document.forms[0].cmdundo.disabled=true;
		if(document.forms[0].hid_appholder.value=="Y")
		{
			document.forms[0].cmdsend.disabled=false;
		}
		else
		{
			document.forms[0].cmdsend.disabled=true;
		}
		document.forms[0].cmdupload.disabled=true;	
	}	
	if(var_appstatus == "Processed/Approved")
	{
		if(varCbsNum !=""||var_appstatus == "Closed/Approved")
		{
			document.forms[0].cmdupload.disabled=true;
			document.forms[0].cmdreject.disabled=true;
			document.forms[0].cmdundo.disabled=false;
			document.forms[0].cmdactclose.disabled=false;
		}
		else
		{
			document.forms[0].cmdupload.disabled=false;
			//document.forms[0].cmdundo.disabled=false;
		}
	}
	 <% if(RNEnable.equals("Y")){  %>
	 {
	document.forms[0].observe.style.visibility="hidden";
	document.forms[0].observe.style.position="absolute";
	 }
	<%}%>
	document.forms[0].cmdactclose.disabled=true;
}
}
function doNSDLDisburse()
{
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
    appno=document.forms[0].appno.value;
	var prdtype =  document.forms[0].prdtype.value;
	var url=appUrl+"action/com_NSDLDisburse.jsp?hidBeanGetMethod=getDataNSDLDisburse&hidBeanId=commworkflow&appno="+appno+"&hidDemoId="+document.forms[0].hidDemoId.value+"&prdtype="+prdtype;
	var prop = 'scrollbars=yes,menubar=yes,width=1000,height=520,status=yes';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,'title',prop);
}
function doNotReviewOption()
{
	appno=document.forms[0].appno.value;
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url="<%=ApplicationParams.getAppUrl()%>action/msmenew_NotReview.jsp?hidBeanId=MSMESimprocessing&hidBeanGetMethod=getMsmeNotReview&hidAppno="+appno;
	var title = "BestPracticeCode";
	var prop = "scrollbars=yes,width=1250,height=900,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function doReview()
{
	var var_appstatus=document.forms[0].appstatus.value;
	//var varcbsno=document.forms[0].cbsaccno.value;

	if(moduleType =="p" || moduleType =="P")
	{	
		if(var_appstatus !="Closed/Approved")
		{	
			<%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
			if(chkNewInterestRate  == "Y")
			{
				alert("Interest Rate is not same as in MCLR/EBLPR. Surf to please Check Loan particulars.");
				return false;
			}
			<%}%>
		}
	}
	else if(moduleType =="m" || moduleType =="M")
	{	
	if(var_appstatus =="Processed/Approved" && varCbsNum=="" )
	{
		<%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
		if(chkNewInterestRate  == "Y")
		{
			alert("Interest Rate is not same as in MCLR/EBLPR. Surf to please Check Loan particulars.");
			return false;
		}
		<%}%>
	}
	
	}

	var msg='You Wish The Following Application '+varAppNum+' to be Taken note';
	var status = confirm(msg);

	if(status==true)
	{
		document.getElementById("observes").style.visibility="visible";
		document.getElementById("observes").style.position="relative";
		document.forms[0].observe.style.visibility="visible";
		document.forms[0].observe.style.position="relative";
		if(document.forms[0].observe.value==0)
		{
			alert("Please Fill Observations of the Reviewing Authority.");
			document.forms[0].observe.focus();
			return;
		}
		else
		{
			alert("Application number "+varAppNum+" take note is Done");
			
			document.forms[0].hidSourceUrl.value="/action/appworkflowaction.jsp" ;
			document.forms[0].hidBeanId.value="commworkflow";
			document.forms[0].hidBeanMethod.value="updateAction";
			document.forms[0].hidBeanGetMethod.value="getAction"; 
			document.forms[0].hidAction.value="Review";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}else{
		return;
	}
	
}
function doTakenote()
{
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var url="<%=ApplicationParams.getAppUrl()%>action/bestpractice.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getwrktakenote";
	var title = "BestPracticeCode";
	var prop = "scrollbars=yes,width=750,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function doLRF()
{
	if(lrf_house_done != "Y" && lrf_edu_done != "Y" && lrf_per_done != "Y")
	{
		alert("Please Do LRF Kept in location Appraisal-->Appraisal-->LOAN REVIEW DETAILS to Approve The Loan");
		return;
	}
	
	var eduloantype = "<%=session.getAttribute("selecttypeedu")%>";
	var eduLOAN_SELECTPURPOSE ="<%=session.getAttribute("selectpurposeedu")%>";
	if(eduloantype =="C")
	{

		if(eduLOAN_SELECTPURPOSE==6||eduLOAN_SELECTPURPOSE==7||eduLOAN_SELECTPURPOSE==12||eduLOAN_SELECTPURPOSE==13||eduLOAN_SELECTPURPOSE==14||eduLOAN_SELECTPURPOSE==15||eduLOAN_SELECTPURPOSE==16)
		{
			
		var page ="per_LRF_Edu.jsp";
		url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+<%=request.getParameter("appno")%>+"&hidBeanId=appraisalsanc&hidBeanGetMethod=getEduLoanReviewFormat";
		}
		else
		{
			var page ="per_LRF_Anneure10.jsp";
			url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+<%=request.getParameter("appno")%>+"&hidBeanId=appraisalsanc&hidBeanGetMethod=getLRFAnnexure10";
			
		}
	//	var page="per_LRF_Edu.jsp";
		var title = "LRF";
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;+
		window.open(url,title,prop);
		if((prd_approval<=prd_maxclass) && (document.forms[0].appstatus.value=="Open/Pending"))
		{
			document.forms[0].cmdapprove.disabled=false;
		}
	}

	if(eduloantype =="V")
	{
		var page = "per_LRF_Anneure10.jsp";
	 	url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+<%=request.getParameter("appno")%>+"&hidBeanId=appraisalsanc&hidBeanGetMethod=getLRFAnnexure10";
		var title = "LRF";
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);
		if((prd_approval<=prd_maxclass) && (document.forms[0].appstatus.value=="Open/Pending"))
		{
			document.forms[0].cmdapprove.disabled=false;
		}
	}

	if(eduloantype =="H")
	{
		var page = "per_LRF_Home.jsp";
	 	url="<%=ApplicationParams.getAppUrl()%>action/"+page+"?appno="+<%=request.getParameter("appno")%>+"&hidBeanId=appraisalsanc&hidBeanGetMethod=getHousingLoanReviewFormat";
		var title = "LRF";
		var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
		var xpos = 5;
		var ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title,prop);
		if((prd_approval<=prd_maxclass) && (document.forms[0].appstatus.value=="Open/Pending"))
		{
			document.forms[0].cmdapprove.disabled=false;
		}
	}
}
function flowpoint()
{
	if(moduleType =="p" || moduleType =="P")
	{	
	/*if(strAppSRDone =="Y")
	{
		document.forms[0].cmdundo.disabled=true;
		
	}*/
	var var_appstatus=document.forms[0].appstatus.value;
/*	if(var_appstatus=="Open/Pending")
	{
		//document.forms[0].cmdTakeNote.disabled=true;
	}*/
	if((var_appstatus=="Closed/Approved" || var_appstatus =="Processed/Approved" ) && (varOrgLevel == "A"))//for freeze the some  flowpoints in branch level.
	{
		<%
		if(arrWorkFlowId.size()!=0)
		{%>
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			
			if(document.forms[0].wrkflwID[i].value == "32" ||document.forms[0].wrkflwID[i].value =="33" ||document.forms[0].wrkflwID[i].value =="35"||//closedapproved
					 document.forms[0].wrkflwID[i].value == "28" || document.forms[0].wrkflwID[i].value == "29" || document.forms[0].wrkflwID[i].value == "31"//processapproved
						|| document.forms[0].wrkflwID[i].value == "25" ||document.forms[0].wrkflwID[i].value == "40" ||document.forms[0].wrkflwID[i].value == "41")
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
			if((document.forms[0].wrkflwID[i].value == "36" ||document.forms[0].wrkflwID[i].value == "37" ||document.forms[0].wrkflwID[i].value == "38" ||document.forms[0].wrkflwID[i].value == "39") &&(SanctionReviewFlag =="RE"))
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
		<%}%>
	}
	if((var_appstatus=="Closed/Approved" || var_appstatus =="Processed/Approved") && (varOrgLevel == "R")) //for freeze the some  flowpoints in RO level.
	{
		<%
		if(arrFlowpoint.size()!=0)
		{%>
		for(var i=0;i<document.forms[0].optflowpnt.length;i++)
		{
			if(document.forms[0].wrkflwID[i].value == "30" ||document.forms[0].wrkflwID[i].value =="36" ||document.forms[0].wrkflwID[i].value =="37" ||//closedapproved
				 document.forms[0].wrkflwID[i].value == "34" || document.forms[0].wrkflwID[i].value == "38" || document.forms[0].wrkflwID[i].value == "39") //processapproved
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
			if((document.forms[0].wrkflwID[i].value == "40" ||document.forms[0].wrkflwID[i].value == "41") &&(SanctionReviewFlag =="RE"))
			{
				document.forms[0].optflowpnt[i].disabled=true;
			}
		}
		<%}%>
	}
	
	
	document.forms[0].cmdactclose.disabled = true
	if(var_appstatus=="Closed/Approved" || strAppSRDone =="Y")
	{
	document.forms[0].cmdreject.disabled=true;
	}
		
	if((appsanc_sancofficer==strUserId) && varOrgLevel == "A" && var_appstatus =="Processed/Approved" && strAppSRDone !="Y")
	{
		document.forms[0].cmdundo.disabled=false;
	}
	if((appsanc_sancofficer==strUserId ||appsanc_sancofficer1==strUserId || appsanc_sancofficer2==strUserId ||
		appsanc_sancofficercpc==strUserId) && var_appstatus =="Processed/Approved" && strAppSRDone !="Y")
	{
		document.forms[0].cmdundo.disabled=false;
	}
/*	else
	{
		document.forms[0].cmdundo.disabled=true; // to enable undo button for process/rejecdted.
	}*/
	if((appsanc_sancofficer==strUserId ||appsanc_sancofficer1==strUserId || appsanc_sancofficer2==strUserId ||
			appsanc_sancofficercpc==strUserId) && var_appstatus =="Processed/Approved" && strAppSRDone =="Y")
	{
		callDisableControls(false,true,true,true,true,true);
	}
	
	if((appsanc_sancofficer==strUserId ||appsanc_sancofficer1==strUserId || appsanc_sancofficer2==strUserId ||
			appsanc_sancofficercpc==strUserId) && var_appstatus=="Closed/Approved" && strAppSRDone =="Y")
	{
		callDisableControls(true,true,true,true,true,true);
	}
	
	
	if(document.forms[0].hid_appholder.value!="Y")
	{
		if(var_appstatus =="Processed/Approved"){
		callDisableControls(false,true,true,true,true,true);
		}else if(var_appstatus =="Closed/Approved"){
		callDisableControls(true,true,true,true,true,true);	
	}
	}
	if((appsanc_sancofficer==strUserId ||appsanc_sancofficer1==strUserId || appsanc_sancofficer2==strUserId ||
			appsanc_sancofficercpc==strUserId) && var_appstatus =="Processed/Approved" && SanctionReviewFlag =="RE" && strAppSRDone =="Y")
	{
		document.forms[0].cmdundo.disabled=false;
	}
}
}
function flowpointMsme()
{
	if(moduleType =="m" || moduleType =="M")
	{
		var var_appstatus=document.forms[0].appstatus.value;
		var varGroupNum="<%=GroupNum%>";
/*		if(var_appstatus=="Open/Pending")
		{
			//document.forms[0].cmdTakeNote.disabled=true;
		}*/
		if((var_appstatus=="Closed/Approved" || var_appstatus =="Processed/Approved" ) && (varOrgLevel == "A"))//for freeze the some  flowpoints in branch level.
		{
			<%
			if(arrWorkFlowId.size()!=0)
			{%>
			for(var i=0;i<document.forms[0].optflowpnt.length;i++)
			{
				
				if(document.forms[0].wrkflwID[i].value == "32" ||document.forms[0].wrkflwID[i].value =="33" ||document.forms[0].wrkflwID[i].value =="35"||//closedapproved
						document.forms[0].wrkflwID[i].value == "25" ||document.forms[0].wrkflwID[i].value == "28" || document.forms[0].wrkflwID[i].value == "29" || document.forms[0].wrkflwID[i].value == "31"//processapproved
							||document.forms[0].wrkflwID[i].value == "40" ||document.forms[0].wrkflwID[i].value == "41")
				{
					document.forms[0].optflowpnt[i].disabled=true;
				}
			}
			<%}%>
		}
		if((var_appstatus=="Closed/Approved" || var_appstatus =="Processed/Approved") && (varOrgLevel == "R")) //for freeze the some  flowpoints in RO level.
		{
			<%
			if(arrFlowpoint.size()!=0)
			{%>
			for(var i=0;i<document.forms[0].optflowpnt.length;i++)
			{
				if(document.forms[0].wrkflwID[i].value == "30" ||document.forms[0].wrkflwID[i].value =="36" ||document.forms[0].wrkflwID[i].value =="37" ||//closedapproved
					 document.forms[0].wrkflwID[i].value == "34" || document.forms[0].wrkflwID[i].value == "38" || document.forms[0].wrkflwID[i].value == "39") //processapproved
				{
					document.forms[0].optflowpnt[i].disabled=true;
				}
			}
			<%}%>
		}
		if(varGroupNum ==2||var_appstatus == "Closed/Approved")
		{
			document.forms[0].cmdupload.disabled=false;
		}
		else if(varGroupNum ==1)
		{
			if(varCbsNum !="" )
			{
				document.forms[0].cmdupload.disabled=true;
			}
			else
			{
				document.forms[0].cmdupload.disabled=false;
			}
		}
		if(varOrgLevel =="R")
		{
			document.forms[0].cmdupload.disabled=true;
		}
			document.forms[0].cmdactclose.disabled=true;
			
	}
	if((varAccountNumCBS !="") && (SanctionReviewFlag =="RE"))
	{
		//document.forms[0].cmdTakeNote.disabled=false;
	}
	else
	{
		//document.forms[0].cmdTakeNote.disabled=true;
	}
}
function getCicScoreEdu()
{
	var appnumber="<%=strappno1%>";
	//alert(appnumber);
	var varCibilLapsId="demo";
	var	varQryString = appURL+"action/cicScoreEducaLoanApp.jsp?hidBeanId=perapplicant&hidBeanGetMethod=getallRecordsCicScoreEdu&txtperapp_appid="+varCibilLapsId+"&appnumber="+appnumber;
	var prop = "scrollbars=yes,width=1200,height=550,menubar=yes,toolbar=yes";	
	var xpos = (screen.width - 1200) / 2;
	var ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,'title',prop);	
}

function ShowVerifyhandoff(strtype)
{ 
	//alert("hi");
	var appnumber="<%=strappno1%>";
	var varQryString = appUrl+"action/agricul_interfaceCBS.jsp?hidBeanId=cbsMigration&hidBeanGetMethod=getLosCreateLoanAccount&appno="+appnumber;
	var prop = "scrollbars=yes,width=450,height=300";	
	var title = "Upload";
	prop = prop + ",left=50,top=150";
	window.open(varQryString,title,prop);	
}
function callMisCollateral(val)
{
	var varMisCollateral=val;
	if(varMisCollateral == "BAM78")
	{
		var appnumber="<%=strappno1%>";
		var url=appURL+"action/retailmisbam78.jsp?hidBeanGetMethod=gethevpmisbam78&hidBeanId=HEVPCommWorkflow&appno="+appnumber;		
		var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
		var title = "MIS BAM-78";
		window.open(url,title,prop);	
	}
	else if(varMisCollateral == "BAM79")
	{
		var appnumber="<%=strappno1%>";
		var url=appURL+"action/retailmisbam79.jsp?hidBeanGetMethod=gethevpmisbam79&hidBeanId=HEVPCommWorkflow&appno="+appnumber;		
		var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
		var title = "MIS BAM-79";appnumber
		window.open(url,title,prop);		
	}
	else if(varMisCollateral == "Collateral")
	{
		var appnumber="<%=strappno1%>";
		var url=appURL+"action/collateralmain.jsp?hidBeanGetMethod=getCollateralData&hidBeanId=collateral&appno="+appnumber;		
		var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
		var title = "Collateral";
		window.open(url,title,prop);			
	}
	else if(varMisCollateral == "BAM83")
	{
		var appnumber="<%=strappno1%>";
		var url=appURL+"action/goldmisbam83.jsp?hidBeanGetMethod=gethevpmisbam83&hidBeanId=HEVPCommWorkflow&appno="+appnumber+"&hidpage=Edu";		
		var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
		var title = "MIS BAM-83";
		window.open(url,title,prop);		
	}
	
	else if(varMisCollateral == "Collateral_Canara")
	{
		var appnumber="<%=strappno1%>";
		var url=appURL+"action/collateralmaker_canara.jsp?hidBeanGetMethod=getCollateralData_Canara&hidBeanId=collateral&appno="+appnumber+"&hidpage=retail";		
		var prop="scrollbars=yes,menubar=yes,width=1200,height=600,top=30,left=30";
		var title = "Collateral";
		window.open(url,title,prop);			
	}
}
function getUserSanctionPower()
{
	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/sanctionpowerpage.jsp?hidBeanGetMethod=getUserSanctionPower&hidBeanId=MSMESimplification";
	var title = "sanctionpowerpage";
	var prop = "scrollbars=yes,width=800,height=900,menubar=no";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=20,top=20,right=20";
	window.open(varQryString,title,prop);
} 


function getDocForReview()
{
	var appnumber="<%=strappno1%>";
	//var varQryString = appURL+"action/hevpeligibleDocsperreview.jsp?hidBeanGetMethod=getEligibleRevForDocument&hidBeanId=HEVPPerLoanDetails&appstatus="+varAppStatus;
	var	varQryString = appURL+"action/hevpDocReviewEligApp.jsp?hidBeanId=HEVPPerLoanDetails&hidBeanGetMethod=getAllGridForDocREviewElig&appnumber="+appnumber;
	var prop = "scrollbars=yes,width=1200,height=550,menubar=yes,toolbar=yes";	
	var xpos = (screen.width - 1200) / 2;
	var ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,'title',prop);
}

function docalReload1(){
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].action=appUrl+"action/NP_appworkflowaction.jsp";
	document.forms[0].submit();
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 160;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="placeValues();callOnload();enablesave();approve_btncontrol();hideallbutn();CallApprvButtn();flowpoint();flowpointMsme()" class="bgcolor">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5();"> 
  <div class="menuitems" url="">
    <script language="JavaScript1.2">
/*if (document.all && window.print)
{
ie5menu.className = menuskin;
document.oncontextmenu = showmenuie5;
document.body.onclick = hidemenuie5;
}*/
</script>
  </div>
</div>
<form id="frmworkflow" method="post" >
<table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertablecolor" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"><tr><td>
           <%
           
           
           
		   if(!session.getAttribute("link").equals("PROP"))
		{
			   
			  
			if(strPgDist.equalsIgnoreCase("P"))
			{
				
				
				
				
		%>
        <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
			 <jsp:param name="pageid" value="7" />
            </jsp:include></td></tr>
			<%
			}
			else
			{
			%>
			
			<%
			}
		}
		else
		{
			%>
			<tr> 
      <td valign="top" colSpan="5"> 
        <jsp:include page="../share/menus.jsp" flush="true"> </jsp:include>
        <jsp:include page="../com/proposallinks.jsp" flush="true"> 
        <jsp:param name="pageid" value="7" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
	  <span style="visibility:hidden"><laps:borrowertype /></span> 
    </tr>
	<%
		}
	%>
         </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
       <%if(strPgDist.equalsIgnoreCase("P")){ %>
      <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
         </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        Retail </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; Existing </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Workflow -> Action</i></b></font>
         <%}else { %>
        <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
         </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        MSME </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font face="Times New Roman" size="3"><b><i>-&gt; Existing </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font face="Times New Roman" size="3"><b><i>Workflow -> Action</i></b></font>
         <%} %>
        </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F" height="20">
            <laps:application/> 
          </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertablecolor">
    <tr> 
      <td width="29%" valign="bottom"> 
        <table width="40%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="33%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="javascript:callOtherTab('history')" class="blackfont">History</a></font></b></td>
            <td width="33%" class="tabactive"><b><font size="1" face="MS Sans Serif" color="#FFFFFF">Action</font></b></td>
             <% if (session.getAttribute("link").equals("PROP"))
            		{
            		if(strPageEnableFrom.equals("frominboxmail")&& strOrgLevel.equalsIgnoreCase("R"))
                	{
            		%>
            <td width="33%" class="tabinactive" id="reviewdoc"><b><a href="javascript:callOtherTab('review')" class="blackfont"><font size="1" face="MS Sans Serif">Review Document</font></a></b></td>
           	<%} 
           	}
           	%>
            <td width="33%" class="tabinactive"><b><font size="1" face="MS Sans Serif"><a href="#" onClick="javascript:callRemarks()"  class="blackfont">Remarks</a></font></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="8" height="370" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor" >
    <tr> 
      <td valign="top"> 
        <div align="left"></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="8" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                      <tr> 
                        <td width="47%" valign="top"> <font size="1" face="MS Sans Serif" color="#CC0000">&nbsp;</font><font size="1" face="MS Sans Serif">&nbsp; 
                          </font><font size="1" face="MS Sans Serif">
                          </font> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="4" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="285">
                            <tr> 
                              <td height="161" valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr> 
                                    <td width="18%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif">Current 
                                        Flowpoint</font></div>
                                    </td>
                                    <td width="13%"> 
                                      <table width="46%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="center"><font face="MS Sans Serif" size="1" color="#003399"><b><%=Helper.correctNull((String)hshValues.get("strCurrFlowPoint"))%>&nbsp;</b></font></td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td width="16%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif">Received 
                                        On</font></div>
                                    </td>
                                    <td width="20%"> 
                                      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="center"><font face="MS Sans Serif" size="1" color="#003399"><b><%=Helper.correctNull((String)hshValues.get("strDate"))%>&nbsp;</b></font></td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td width="12%"> 
                                      <div align="center"><font size="1" face="MS Sans Serif">Due 
                                        On</font></div>
                                    </td>
                                    <td width="21%"> 
                                      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                                        <tr bgcolor="#FFFFFF"> 
                                          <td align="center"><font face="MS Sans Serif" size="1" color="#FF0000"><b><%=Helper.correctNull((String)hshValues.get("strDueDate"))%>&nbsp;</b></font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                      
                                <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="0">
                                  <tr> 
                                    <td height="81" valign="top"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                        <tr> 
                                          <td width="4%" align="left" class="tabactive"> 
                                            <div align="left"><font size="1" face="MS Sans Serif" color="#FFFFFF">Select</font></div>
                                          </td>
                                          <td width="8%" align="left" class="tabactive"> 
                                            <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Flowpoints</font></div>
                                          </td>
                                          <td width="6%" class="tabactive"> <font size="1" face="MS Sans Serif" color="#FFFFFF">Done</font></td>
                                          <td width="8%" class="tabactive"> <font size="1" face="MS Sans Serif" color="#FFFFFF">Class</font></td>
                                          <td width="17%" class="tabactive"> 
                                            <div align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Function</font></div>
                                          </td>
                                          <td width="59%" class="tabactive" align="center"><font size="1" face="MS Sans Serif" color="#FFFFFF">Actions</font></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="6" valign="top"> 
                                            <DIV CLASS="cellContainer"> 
                                              <table width="100%" border="1" cellspacing="0" cellpadding="1" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="left" bgcolor="#FFFFFF">
                                                <%
												if(arrFlowpoint.size()>0)
												{
												for(int i=0;i<arrFlowpoint.size();i++) { %>

												<tr> 
                                                  <td width="5%" bgcolor="#FFFFFF"> 
                                                    <input type="radio" name="optflowpnt" value="12" onClick="setValues(<%=i%>,<%=Helper.correctNull((String)arrMaxclass.get(i))%>),enablesave1()" style="border-style:none">
                                                  </td>
                                                  <td width="8%" bgcolor="#FFFFFF" align="center"> 
                                                    <div align="center"> 
                                                      <input type="text" name="txtmail_toflowpoint" size="5" class="fldnoborderwhite" readOnly="readonly" maxlength="4" value="<%=arrFlowpoint.get(i)%>">
                                                    </div>
                                                  </td>
                                                  <td width="2%" bgcolor="" align="center"> 
                                                    <div align="center"> 
                                                      <input type="text" name="txtdone" size="5" class="fldnoborderwhite" readOnly="readonly" value="<%=arrDone.get(i)%>">
                                                    </div>
                                                  </td>
                                                  <td width="9%" bgcolor="" align="center"> 
                                                    <div align="center"> 
                                                      <input type="text" name="prd_maxclass" size="10" class="fldnoborderwhite" readOnly="readonly" value="<%=Helper.correctNull((String)arrMaxclass.get(i))%>">
                                                    </div>
                                                  </td>
                                                  <td width="17%" bgcolor="" align="left"> 
                                                    <div align="left"> 
                                                      <input type="text" name="wrkfuncname" size="20" class="fldnoborderwhite" readOnly="readonly" value="<%=arrFunction.get(i)%>">
                                                      <input type="hidden" name="wrkflwID" size="20" class="fldnoborderwhite" readOnly="readonly" value="<%=arrWorkFlowId.get(i)%>">
                                                    </div>
                                                  </td>
                                                  <td width="59%" bgcolor="" align="left"> 
                                                    <input type="text" name="wrk_flowname" size="100" class="fldnobordernocenterwhite" readOnly="readonly" value="<%=arrAction.get(i)%>">
                                                  </td>
                                                </tr>
                                                <%
														}
												}
												else
												{
													%>
														<tr> 
	                                                  <td align="Center"> <font size="1" face="MS Sans Serif">
														<%out.println("No Data Found");%></font>
														</td></tr>
													<%
												}
												
												%>
                                              </table>
                                            </div>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table>
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                  
                                  <tr> 
                                    <td width="52%" valign="top"> 
                                      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="100%">
                                        <tr> 
                                          <td valign="top"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                              <tr> 
                                                <td width="30%"> <font size="1" face="MS Sans Serif">Select 
                                                  Organisation</font></td>
                                                <td width="70%"> 
                                                  <input type="text" name="org_name" size="50" readonly="readonly" value="<%=strOrgName%>">
                                                  <a href="#" onClick="javascript:callOrgHelp()"><b class="blackfont">? 
                                                  </b></a> </td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                    <td align="right" valign="top"> 
                                      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="100%">
                                        <tr> 
                                          <td valign="top"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                              <tr> 
                                                <td width="32%"> 
                                                  <div align="center"><font size="1" face="MS Sans Serif">Select 
                                                    Recipient</font></div>
                                                </td>
                                                <td width="45%"> 
                                                  <input type="text" name="mail_tousrid" size="20" readonly="readonly">
                                                  <a href="#" onClick="javascript:callUsersHelp()"><b class="blackfont">? 
                                                  </b></a></td>
                                               
                                                 <%if(strCanaraSyndBank.equalsIgnoreCase("C")){%>		
												 <td width="75%" align="left" class="redfont"><font size="1" face="MS Sans Serif">&nbsp; <input type="button" name="cmdsend" value="Send" style="width:60; background-color: #00aedf" class="buttoncolor" onClick="doSend()"> </font></td>
												<%} %>  
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr align="center"> 
                                    <td colspan="2" style="visibility:hidden" id="childid">&nbsp; 
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td width="47%" valign="top"> 
                          <div align="center"></div>
                          <div align="left"><font size="1" face="MS Sans Serif" color="#CC0000"> 
                            </font></div>
                        </td>
                      </tr>
                      <% if(RNEnable.equals("Y")){  %>
                      <tr align="center" >
                       <td width="100%" style="visibility:hidden"  id="observes" align="center" >Observations of the Reviewing Authority
                                  <font color="red">*</font>
                                  		<textarea name ="observe" rows="4" cols="40"></textarea>
                       </td>
                      </tr>
                      <%} %>
                       <% if(nsdlloans.equals("Y")){  %>
                      <tr align="center" >
                       <td width="100%"  style="visibility:hidden" id="nsdlremark" align="center" >NSDL Remarks (Only doing Approve)
                                  <font color="red">*</font>
                                  		<textarea name ="nsdlremarkdata" rows="4" cols="40" onKeyUp="textlimit(this,200)" onkeypress="allowAlphabetsSpaceInteger()"></textarea>
                       </td>
                      </tr>
                      <%} %>
                      <table border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
			          <tr valign="top">
   					
					  <%if(strCanaraSyndBank.equalsIgnoreCase("C")){%>
					  <td>
					  <input type="button" name="cmdsancpower" value="Check Sanction Power"   class="buttoncolor" style="background-color: #00aedf" onClick="getUserSanctionPower();">
					  </td>
					  <%} %>
					  </tr>
					  </table>
                      <tr>
					  <td align="center">
					   <table border="0" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
			          <tr valign="top">
   					<%if(moduleType.equalsIgnoreCase("P")) {%>
   					<%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>  
					  <td id="handoff">
					  <input type="button" name="cmdupload" value="Hand-off to CBS"  style="width:100; background-color: #00aedf" class="buttoncolor"  onClick="doCheck_cbsdata('TERM','RETAIL')">
					  </td>
					  <%}else{ %>
					  <td id="handoff">
					  <input type="button" name="cmdupload" value="Hand-off to CBS"   class="buttoncolor"  onClick="doCheck_cbsdata('TERM','RETAIL')">
					  </td>
					  <%} %>
					  <%} else if(moduleType.equalsIgnoreCase("M")) {%>
					  <td id="handoff">
					  <input type="button" name="cmdupload" value="Hand-off to CBS"   class="buttoncolor"  onClick="doCheck_cbsdata('TERM','MSME')">
					  </td>
					  <%} %>
					  <!--
					    <td id="handoff_casaod">
					  <input type="button" name="cmdupload_casaod" value="CASA OD Hand-off to CBS"   class="buttoncolor"  onClick="doUpload('CASAOD')">
					  </td>
					  
					  --><!--<td>
					  <input type="button" name="cmdupload" value="Process Note" style="width:100"  class="buttoncolor"  onClick="callProcessNote()">
					  </td>
							   <td><input type="button" name="document" value="DOCUMENTS"
													onClick="ShowDocuments('listofdocuments.jsp')" style="width:100"
													class="buttoncolor"></td>
													-->
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
  <table  border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
    <tr> 
      <td> 
        <table align="center" border="0" cellspacing="0" cellpadding="3">
          <tr valign="top">  
           <%if(!strCanaraSyndBank.equalsIgnoreCase("C")){ %>    
           <td> 
              <input type="button" name="cmdMisbam78" value="MIS BAM-78"   class="buttoncolor"  onClick="callMisCollateral('BAM78')">
            </td>     
			 <td> 
              <input type="button" name="cmdMisbam79" value="MIS BAM-79"   class="buttoncolor"  onClick="callMisCollateral('BAM79')">
            </td> 
            <%if(!strproductcode.equals("949") && !strproductcode.equals("950") ){ %>    
             <td> 
              <input type="button" name="cmdCollateral" value="Collateral"   class="buttoncolor"  onClick="callMisCollateral('Collateral')">
            </td>  
            <%} %>      
             <%}else{ %>
             <td> 
              <input type="button" name="cmdMisbam83" value="MIS BAM-83"  style="width:100; background-color: #00aedf" class="buttoncolor"  onClick="callMisCollateral('BAM83')">
            </td>
           <%if(!strproductcode.equals("949") && !strproductcode.equals("950") ){ %>  
           <%if(strcollteralFlag.equalsIgnoreCase("Y")){ %>  
            <td> 
              <input type="button" name="cmdCollateral" value="Collateral"  style="width:100; background-color: #00aedf" class="buttoncolor"  onClick="callMisCollateral('Collateral_Canara')">
            </td> 
            <%}} %>
            <%} %> 
            
          
            <td> 
              
              <input type="button" name="cmdDocUploadREview" value="Upload Document For Review" onClick="getDocForReview()" style="width: 200; background-color: #00aedf" class="buttoncolor">
            </td>
            
            
          </tr>         
        </table>
      </td>
    </tr>
  </table> 
  <%
  if(strPgDist.equalsIgnoreCase("P")){ %>
 <table width="38%" border="1" cellspacing="0" cellpadding="0" align="center" id="id_elig">
 <tr>
 <td width="33%">
	<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
	<%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
                              <tr id="hidecmdclick" align="center"> 
                               
                                <td width="100%"><font size="1" face="MS Sans Serif"> 
                                  <input type="button" name="cmdClick" value="Check Eligibility" style="width:100" class="buttoncolor" onClick="callLimitofLoan()">
                                  </font></td>                                        
                              </tr>
                            
                            <tr id="hidecmdmortgage" align="center" width="100%">
                                
                               <!-- synd Mortgage scheme -->
                                  <td width="18%"><font size="1" face="MS Sans Serif"> 
                                  <input type="button" name="cmdmortgage" value="Check Eligibility" style="width:100" class="buttoncolor" onClick="callmortgageLimitofLoan('perlimitmortgage.jsp','getsyndlaghuudyamiData');"><!-- getsyndmortgageData -->
                                  </font></td> 
                                 <!-- synd Mortgage scheme -->
                              </tr>                                      
                              <tr id="hidecmdmahila" align="center" width="100%">
                                  
                               <!-- mahila scheme -->
                                   <td width="18%"><font size="1" face="MS Sans Serif"> 
                                  <input type="button" name="cmdmahila" value="Check Eligibility" style="width:100" class="buttoncolor" onClick="callmahilaLimitofLoan('perlimitmahila.jsp','getmahilaData')">
                                  </font></td>       
								 <!-- mahila scheme -->
                              </tr>
                               <tr id="hidecmdsyndsenior" align="center" width="100%">
                                    <!-- synd senior scheme -->
                                  <td width="18%"><font size="1" face="MS Sans Serif"> 
                                  <input type="button" name="cmdsyndsenior" value="Check Eligibility" style="width:100" class="buttoncolor" onClick="callmahilaLimitofLoan('perlimitsenior.jsp','getseniorData')">
                                  </font></td> 
                                 <!-- synd senior scheme -->
                              </tr>
                              
                                <tr id="hidecmdsyndvidya" align="center" width="100%">
                               <!-- synd vidya dl/osl scheme -->
                                  <td width="18%" ><font size="1" face="MS Sans Serif"> 
                                  <input type="button" name="cmdsyndvidya" value="Check Eligibility" style="width:100" class="buttoncolor" onClick="callmahilaLimitofLoan('perlimitvidya.jsp','geteduData');">
                                  </font></td> 
                                 <!-- synd vidya dl/osl scheme -->
                                        </tr>
                   <%}else{ %>                                
                                <tr id="hidecmdsyndvidya" align="center" width="100%">
                               <!-- synd vidya dl/osl scheme -->
                                  <td width="18%" ><font size="1" face="MS Sans Serif"> 
                                  <input type="button" name="cmdsyndvidya" value="Check Eligibility" style="width:100; background-color: #00aedf" class="buttoncolor" onClick="callmahilaLimitofLoan('perlimitvidya.jsp','geteduData');">
                                  </font></td> 
                                 <!-- synd vidya dl/osl scheme -->
                                        </tr>
                   <%} %>        
             </table>
             </td>
             <%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
             <td align="center" width="33%">
								<table width="99%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr align="center"> 
										    <td width="33%" id="id_processnote"><font size="1" face="MS Sans Serif"> 
										      <input type="button" name="processnote" value="Print Process Note" style="width:250" class="buttoncolor" onClick="ShowReport()">
										      </font></td>
										    <td  width="33%" id="id_contless20processnote"><font size="1" face="MS Sans Serif"> 
										      <input type="button" name="contless20processnote" value="Print Process Note" style="width:250" class="buttoncolor" onClick="showReport1('percontless20.jsp')">
										      </font></td>
										    <td  width="33%" id="id_eduprocessnote"><font size="1" face="MS Sans Serif"> 
										      <input type="button" name="eduprocessnote" value="Print Process Note" style="width:250" class="buttoncolor" onClick="showReport1('pereduprocessnote.jsp')">
										      </font></td>
									 </tr>
								</table>  
			</td>
			<%if(!strproductcode.equals("947") && !strproductcode.equals("948") && !strproductcode.equals("949") && !strproductcode.equals("950") && !strproductcode.equals("651")&& !strproductcode.equals("654")&& !strproductcode.equals("655") ){ %>
			 <td align="center" width="33%">
								<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr align="center"> 
										     <td width="100%"> 
									              <input type="button" name="cmdRiskcheck" value="Risk Analysis" style="width:100"  class="buttoncolor" onClick="doPrint()">
									         </td>
									 </tr>
								</table>  
			</td>
			<%} %>
			<td align="center" width="33%">
								<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr align="center"> 
										     <td width="100%" id="id_cmdLRFCheck"> 
									              <input type="button" name="cmdLRFCheck" value="LRF" style="width:100"  class="buttoncolor" onClick="doLRF()">
									         </td>
									 </tr>
								</table>  
			</td>
			<td>
				
				 <%if(nsdlloans.equalsIgnoreCase("Y")) {%>
            <td> <div align="center"> <input type="hidden" disabled name="nsdl_disburse" value="Disbursement Info"
					class="buttoncolor" onClick="doNSDLDisburse()"></div></td>
			<%} %>	
			<%}else{ %>
			<td align="center" width="33%">
								<table width="99%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr align="center"> 
										    <td  width="33%" id="id_eduprocessnote"><font size="1" face="MS Sans Serif"> 
										      <input type="button" name="eduprocessnote" value="Print Process Note" style="width:250; background-color: #00aedf" class="buttoncolor" onClick="showReport1('pereduprocessnote.jsp')">
										      </font></td>
									 </tr>
								</table>  
			</td>
			<%if(!strproductcode.equals("947") && !strproductcode.equals("948") && !strproductcode.equals("949") && !strproductcode.equals("950") && !strproductcode.equals("651")&& !strproductcode.equals("654")&& !strproductcode.equals("655") ){ %>
			 <td align="center" width="33%">
								<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr align="center"> 
										     <td width="100%"> 
									              <input type="button" name="cmdRiskcheck" value="Risk Analysis" style="width:100; background-color: #00aedf" class="buttoncolor" onClick="doPrint()">
									         </td>
									 </tr>
								</table>  
			</td>
			<%} %>
			<td align="center" width="33%">
								<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr align="center"> 
										     <td width="100%" id="id_cmdLRFCheck"> 
									              <input type="button" name="cmdLRFCheck" value="LRF" style="width:100; background-color: #00aedf"    class="buttoncolor" onClick="doLRF()">
									         </td>
									 </tr>
								</table>  
			</td>
			<td>
				
				 <%if(nsdlloans.equalsIgnoreCase("Y")) {%>
            <td> <div align="center"> <input type="hidden" disabled name="nsdl_disburse" value="Disbursement Info"
					class="buttoncolor" onClick="doNSDLDisburse()"></div></td>
			<%} %>	
		
			<%} %>
			</td>
			</tr>
			</table>     
			<%} %>                               
  <table  border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center" class="outertablecolor">
    <tr> 
      <td> 
        <table align="center" border="0" cellspacing="0" cellpadding="3">
        <%if(strCanaraSyndBank.equalsIgnoreCase("S")){%>
          <tr valign="top"> 
           <td> 
              <input type="button" name="cmdNotReview" value="Not Reviewed" style="width:90"  class="buttoncolor"  onClick="doNotReviewOption()">
            </td>
          <% if(RNEnable.equals("Y")){  %>
          	<td> 
              <input type="button" name="cmdReview" value="Review Note" style="width:80"  class="buttoncolor"  onClick="doReview()">
            </td>
          <%} %>
			 <td> 
              <input type="button" name="cmdapprove" value="Approve" style="width:60"  class="buttoncolor"  onClick="doProcess('approve')">
            </td>
            <td> 
              <input type="button" name="cmdreject" value="Reject" style="width:60" class="buttoncolor" disabled="disabled" onClick="doProcess('reject')">
            </td>
            <td> 
              <input type="button" name="cmdundo" value="Undo" style="width:60" class="buttoncolor" disabled="disabled" onClick="doProcess('undo')">
            </td>
 
            <td> 
              <input type="button" name="cmdsend" value="Send" style="width:60" class="buttoncolor" onClick="doSend()">
            </td>
          <td> 
              <input type="button" name="cmdactclose" value="Save" style="width:60" class="buttoncolor" onClick="doSave()" >
            </td> 
            <!--<td height="2"> -->
              <input type="hidden" name="adreport2" value="Auditor's Report" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:110;font-weight:bold" onClick="doAudit()">
           <!-- </td>-->
            <td> 
              <input type="button" name="cmdclose32" value="Help" style="background-color:#009966;cursor:help;;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="callhelp()">
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdclose2" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onclick = "doClose()">
              </div>
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdTakeNote" value="Take Note" style="width:80"  class="buttoncolor"  onClick="doTakenote()">
         
              </div>
            </td> <td> 
              <div align="center"> 
               <!--  <input type="button" name="cmdCicScore" value="Fetch CIC Score" style="width:100"  class="buttoncolor"  onClick="getCicScoreEdu()"> -->
         
              </div>
            </td>
              <td> 
              <div align="center"> 
               <!-- <input type="button" name="cmdtestinterface" value="TEST CBS INTERFACE" style="width:80"  class="buttoncolor"  onClick="ShowVerifyhandoff()"> --> 
         </div>
         </td>
            </tr> 
            <%}else{ %>
                      <tr valign="top"> 
			 <td> 
              <input type="button" name="cmdapprove" value="Approve" style="width:60; background-color: #00aedf"  class="buttoncolor"  onClick="doProcess('approve')">
            </td>
            <td> 
              <input type="button" name="cmdreject" value="Reject" style="width:60; background-color: #00aedf" class="buttoncolor" disabled="disabled" onClick="doProcess('reject')">
            </td>
            <td> 
              <input type="button" name="cmdundo" value="Undo" style="width:60; background-color: #00aedf" class="buttoncolor" disabled="disabled" onClick="doProcess('undo')">
            </td>
          <td> 
              <input type="button" name="cmdactclose" value="Save" style="width:60; background-color: #00aedf" class="buttoncolor" onClick="doSave()" >
            </td>
             <!--<td height="2"> -->
              <input type="hidden" name="adreport2" value="Auditor's Report" style="background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:110;font-weight:bold" onClick="doAudit()">
           <!-- </td>-->
            <td> 
              <input type="button" name="cmdNotReview" value="Not Reviewed" style="width:60; background-color: #00aedf"  class="buttoncolor"  onClick="doNotReviewOption()">
            </td>
          <% if(RNEnable.equals("Y")){  %>
          	<td> 
              <input type="button" name="cmdReview" value="Review Note" style="width:60; background-color: #00aedf"  class="buttoncolor"  onClick="doReview()">
            </td>
          <%} %> 
            <td> 
              <input type="button" name="cmdclose32" value="Help" style="background-color:#009966;cursor:help;;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onClick="callhelp()">
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdclose2" value="Close" style="background-color:#CC3300;color:white;font-size=10;font-family:mssansserif;width:50;font-weight:bold" onclick = "doClose()">
              </div>
            </td>
            <td> 
              <div align="center"> 
                <input type="button" name="cmdTakeNote" value="Take Note" style="width:60; background-color: #00aedf"  class="buttoncolor"  onClick="doTakenote()">
         
              </div>
            </td> <td> 
              <div align="center"> 
                <input type="button" name="cmdCicScore" value="Fetch CIC Score" style="width:60; background-color: #00aedf"  class="buttoncolor"  onClick="getCicScoreEdu()">
         
              </div>
            </td>
              <td> 
              <div align="center"> 
                <input type="button" name="cmdtestinterface" value="TEST CBS INTERFACE" style="width:60; background-color: #00aedf" class="buttoncolor"  onClick="ShowVerifyhandoff()">
         </div>
         </td>
            </tr> 
            <%} %>
        </table>
      </td>
    </tr>
  </table>
  <INPUT TYPE="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>">
  <input type="hidden" name="hidBeanGetMethod" value="">
   <input type="hidden" name="hidBeanId" >
   <input type="hidden" name="hidBeanMethod" value="updateAction">
   <input type="hidden" name="hidSourceUrl" value="/action/NP_appworkflowhistory.jsp" >
   <input type="hidden" name="org_code" value="<%=strOrgCode%>">
   <input type="hidden" name="mail_fromflowpoint" value="<%=hshValues.get("strCurrFlowPoint")%>" >
   <input type="hidden" name="mail_toflowpoint">
   <input type="hidden" name="mail_toflowID">
   <input type="hidden" name="hidcurrflowpoint" value="<%=hshValues.get("strCurrFlowPoint")%>" >
   <input type="hidden" name="hidAction">
   <input type="hidden" name="cmdapply" style="visibility:hidden" disabled="disabled">
<INPUT TYPE="hidden" name="hidAppType">
<input type="hidden" name="radLoan" value="Y">
<input type="hidden" name="hideditoption" value="N">
<input type="hidden" name="userclass" value="<%=strUserClass%>">
<input type="hidden" name="prdtype" value="<%=strPrdtype%>">
<input type="hidden" name="hidstatus" value="<%=strPrdtype%>">
<input type="hidden" name="hidapno" value="<%=request.getParameter("appno")%>">
<input type="hidden" name="appno" value="<%=request.getParameter("appno")%>">
<!-- dummy fields but  don't delete (Link with popup window)-->
<input type="hidden" name="org_alphacode" value="">
<input type="hidden" name="userid" value="<%=(String)session.getAttribute("strUserId")%>">  
<input type="hidden" name="strPgDist" value="<%=strPgDist%>">  
<input type="hidden" name="hidRisk" value="T">
<input type="hidden" name="hidPageEnableFrom" value="<%=Helper.correctNull((String)hshValues.get("strPageEnable"))%>">
   <input type="hidden" name="nsdlloan" value="<%=nsdlloans%>">
<input type="hidden" name="txt_perappid" value="<%=Helper.correctNull((String)hshValues.get("LapsCibilId"))%>">
<input type="hidden" name="hidAppNum">
<input type="hidden" name="hidmodule" value="Retail">
<input type="hidden" name="sandButtonValue">
<input type="hidden" name="hidHandOff_EDU_Check" value="<%=Helper.correctNull((String)hshValues.get("strHandoff_EDU_Status"))%>">
</form>
</body>
</html>
