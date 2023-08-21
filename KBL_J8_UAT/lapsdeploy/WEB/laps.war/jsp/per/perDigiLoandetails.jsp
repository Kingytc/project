<%@include file="../share/directives.jsp"%>
<%	int employeeretirementage = 0;
	String strIntType = "";
	String applicantid = "";
	String applicationno = "";
	String appstatus = "";
	String appname = "";
	String inwardno = "";
	String applevel = "";
	String strAppholder = "";
	String readFlag = "";
	String strAppstatus = "";
	String loanType = "";
	String strValuesin = "";
	String strApporgname = "";
	String btnenable = "";
	String repaymenttype="";
	String sanctionrefno="";
	String strCbsaccno="";
	String strAppType="",strAccOpenDate="",strOpenFlag="",strapplicantNewid="";
	String strPrdLoanType = Helper.correctNull((String) hshValues.get("PRD_LOANTYPE"));
	applicantid = Helper.correctNull((String) hshValues.get("hidapplicantid"));
	if (hshValues.get("hshAppData") != null) {
		HashMap hshRecord = (HashMap) hshValues.get("hshAppData");
		applicationno = Helper.correctNull((String) hshRecord
				.get("appno"));
		if(applicantid.equalsIgnoreCase(""))
			applicantid = Helper.correctNull((String) hshRecord.get("applicantid"));
		
		strapplicantNewid = Helper.correctNull((String) hshRecord.get("applicantnewid"));

		strAppstatus = Helper.correctNull((String) hshRecord.get("app_status"));
		appstatus = Helper.correctNull((String) hshRecord.get("app_status"));
		appname = Helper.correctNull((String) hshRecord.get("app_name"));
		inwardno = Helper.correctNull((String) hshRecord.get("inwardno"));
		applevel = Helper.correctNull((String) hshRecord.get("applevel"));
		strAppholder = Helper.correctNull((String) hshRecord.get("applnholder"));
		strValuesin = Helper.correctNull((String) hshRecord.get("valuesin"));
		strApporgname = Helper.correctNull((String) hshRecord.get("apporgname"));
		loanType = Helper.correctNull((String) hshRecord.get("apploantype"));
		btnenable = Helper.correctNull((String) hshRecord.get("btnenable"));
		repaymenttype = Helper.correctNull((String) hshRecord.get("repaytype"));
		session.setAttribute("strappno", applicationno);
		session.setAttribute("strappstatus", strAppstatus);
		
		sanctionrefno= Helper.correctNull((String) hshRecord.get("sanctionrefno"));
		strCbsaccno = Helper.correctNull((String) hshRecord.get("CBSACCOUNTNO"));
		strAppType = Helper.correctNull((String) hshRecord.get("ApplicantType"));
		strAccOpenDate = Helper.correctNull((String) hshRecord.get("strAccopenDate"));
		strOpenFlag = Helper.correctNull((String) hshRecord.get("strAccopenFlag"));
		
		if(strAppType.equalsIgnoreCase("S"))
		{
			strAppType="Restructure";
		}else if(strAppType.equalsIgnoreCase("R"))
		{
			strAppType="Renew";
		}else if(strAppType.equalsIgnoreCase("P"))
		{
			strAppType="Post Sanction";
		}else{
			strAppType="Fresh";
		}
	}
	session.setAttribute("schemeCode", strPrdLoanType);
	if (applicationno.equalsIgnoreCase("")) {
		applicationno = Helper.correctNull((String) request.getParameter("appno"));
	}
	if (applicantid.equalsIgnoreCase("")) {
		applicantid = Helper.correctNull((String) request.getParameter("hidapplicantid"));
	}
	if (appstatus.equalsIgnoreCase("")) {
		appstatus = Helper.correctNull((String) request.getParameter("appstatus"));
	}
	if (appstatus.equalsIgnoreCase("op")) {
		appstatus = "Open/Pending";
	} else if (appstatus.equalsIgnoreCase("pa")) {
		appstatus = "Processed/Approved";
	} else if (appstatus.equalsIgnoreCase("pr")) {
		appstatus = "Processed/Rejected";
	} else if (appstatus.equalsIgnoreCase("ca")) {
		appstatus = "Closed/Approved";
	} else if (appstatus.equalsIgnoreCase("cr")) {
		appstatus = "Closed/Rejected";
	} else if (appstatus.equalsIgnoreCase("ol")) {
		appstatus = "Open/Lodged";
	}
	if (appname.equalsIgnoreCase("")) {
		appname = Helper.correctNull((String) request.getParameter("compname"));
	}
	String Salaryrouted = Helper.correctNull((String) hshValues.get("perapp_salaryrouted"));
	strIntType = Helper.correctNull((String) hshValues.get("loaninttype"));
	String perapp_employment = Helper.correctNull((String) hshValues.get("perapp_employment"));
	session.setAttribute("perapp_status", Helper.correctNull((String) hshValues.get("perapp_status")));
	String strappno1 = Helper.correctNull((String) hshValues.get("appno"));
	String strProductType = Helper.correctNull((String) hshValues.get("prd_type"));
	session.setAttribute("strProductType", strProductType);
	String prdcode = Helper.correctNull((String) hshValues.get("prdcode"));
	session.setAttribute("prdcode", prdcode);
	String InterestCharged = Helper.correctNull((String) hshValues.get("loan_interestcharged"));
	String page_type = Helper.correctNull((String) session.getAttribute("pgeLabel"));
	String maxterms = Helper.correctNull((String) hshValues.get("maxterms"));
	String Loanamt = Helper.correctDouble((String) hshValues.get("sancmount"));
	String strSinglePremium=Helper.correctDouble((String) hshValues.get("LOAN_INS_COMPANY_NAME"));
	
	if (Helper.correctNull((String) session.getAttribute("link"))
			.equalsIgnoreCase("")) {
		session.setAttribute("link", page_type);
	}
	readFlag = ""+ Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18);
	String catgeryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));
	String strapplicantid = Helper.correctNull((String) request.getParameter("hidapplicantid"));
	String strLoanPurpose=Helper.correctNull((String)hshValues.get("phpa_loan_purpose"));
	String strCBSid=Helper.correctNull((String)hshValues.get("inward_cbsid"));
	String strProjectFinance=Helper.correctNull((String)hshValues.get("phpa_project_finance"));
	String strUpfrontFee=Helper.correctDouble((String)hshValues.get("loan_upfrontfee"));
	String strPrepaymentCharge=Helper.correctDouble((String)hshValues.get("loan_prepaycharge"));
	String strPurposeID=Helper.correctNull((String)hshValues.get("prd_purpose"));
	String strOrgLevel1=Helper.correctNull((String) session.getAttribute("strOrgLevel"));
	String org_Code1=Helper.correctNull((String)hshValues.get("hshorgcode"));
	session.setAttribute("busid",Helper.correctNull((String)hshValues.get("bus_id")));
	String strFreeze=Helper.correctNull((String)hshValues.get("cre_freeze"));
	session.setAttribute("sessionModuleType","DIGI");
	String mortFlag="N";
	session.setAttribute("strPrdPurpose", strPurposeID);
	String prd_cgtmse=Helper.correctNull((String)hshValues.get("LOAN_CGTMSE_APPLICABLE"));
	String strLoanRenewRestr = Helper.correctNull((String)hshValues.get("APP_RENEW_FLAG"));
	String strTakeOverAvailFlag	=	Helper.correctNull((String)hshValues.get("TakeOverAvailFlag"));
	String strPageParam = Helper.correctNull((String) session.getAttribute("strModifyterms")).trim();
	session.setAttribute("strAppType",Helper.correctNull((String)hshValues.get("appProposalType")));	
	
	String strOption = "",strText="",strDescription="";
	String strMCLRtype = Helper.correctNull((String) hshValues.get("loan_mclrtype"));
	strDescription=Helper.correctNull((String) hshValues.get("strMCLRtypeDesc"));
	if(!strMCLRtype.equalsIgnoreCase(""))
	{
		strDescription = strDescription+"-"+strMCLRtype.split("@")[1];
		strOption = strMCLRtype;
		/*strOption = strMCLRtype;
		strText = strMCLRtype.split("@")[0];
		if(strText.equalsIgnoreCase("O"))
			strDescription = "One day MCLR";
		else if(strText.equalsIgnoreCase("M"))
			strDescription = "Monthly MCLR";
		else if(strText.equalsIgnoreCase("Q"))
			strDescription = "Quartely MCLR";
		else if(strText.equalsIgnoreCase("H"))
			strDescription = "Half yearly MCLR";
		else if(strText.equalsIgnoreCase("Y"))
			strDescription = "Yearly MCLR";
		
		strDescription = strDescription+"-"+strMCLRtype.split("@")[1];*/
	}
	
	String strProAvailableFor=Helper.correctNull((String) hshValues.get("prd_applicablefor"));
	String str_govt_scheme= Helper.correctNull((String) hshValues.get("govt_scheme"));
	
	session.setAttribute("digi_loantype", Helper.correctNull((String) hshValues.get("perapp_status")));
	String STRLOANUPDROIFLAG= Helper.correctNull((String) hshValues.get("STRLOANUPDROIFLAG"));
	String STRROIDATECHECK= Helper.correctNull((String) hshValues.get("ROIDATECHECK"));
	String strConcession=Helper.correctNull((String)hshValues.get("DIGI_DEVIATION_ROI_CONC"));
	String strCondesc=Helper.correctNull((String)hshValues.get("DIGI_DEVIATION_ROI_CONDESC"));
	String strPenalty=Helper.correctNull((String)hshValues.get("DIGI_DEVIATION_ROI_PENALTY"));
	String strStaffProduct=Helper.correctNull((String)hshValues.get("staffproduct"));
	String  strRoiArr="";
	String prdType=Helper.correctNull((String) hshValues.get("prd_type"));
	
	ArrayList arrCol = new ArrayList();
	ArrayList arrROI = new ArrayList();
	arrROI= (ArrayList)hshValues.get("arrROI");
	String strRoi="";

	if(!prdType.equalsIgnoreCase("pC")){
	if(strStaffProduct.equalsIgnoreCase("Y")){ 
		
								if(prdType.equalsIgnoreCase("pH"))
								{
									
									if(arrROI!=null && arrROI.size()>0)
									{
										
										for(int s=0;s<arrROI.size();s++)
										{		
											 arrCol=(ArrayList)arrROI.get(s);
											  strRoiArr= String.valueOf(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0)))+"-"+ Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))+ " in "+ String.valueOf(Helper.correctDouble((String)arrCol.get(2)))+"%"+"\n"; 
											 strRoi=strRoi+strRoiArr;
										}
										
									}
									else
									{
									strRoi=	 String.valueOf(Helper.correctDouble((String)hshValues.get("ROI")))+"%";
									}
								}
								else
								{ 
								strRoi= String.valueOf(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strIntType")))+"-"+Double.parseDouble(Helper.correctDouble((String)hshValues.get("ROI"))))+"%";
								}
								}else{ 
							
										strRoi=	String.valueOf(Helper.correctDouble((String)hshValues.get("ROI")))+"%";
										}	
	}
	session.setAttribute("DigiRating",Helper.correctNull((String)hshValues.get("DigiRating")));	
	session.setAttribute("APP_LOANSUBTYPE_DIGI",Helper.correctNull((String) hshValues.get("subLoanType")));
	String digiappno= Helper.correctNull((String) hshValues.get("digiappno"));
	session.setAttribute("digiappno",digiappno);
%>
<html>
<head>
<title>Personal - Applicant</title>
<SCRIPT LANGUAGE="JavaScript"	src="<%=ApplicationParams.getAppUrl()%>js/per/perDigiLoandetails.js"></script>
<script language="JavaScript1.2"	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var strOrgcode="<%=Helper.correctNull((String) session.getAttribute("strOrgCode"))%>";
var varApplicantId= "<%=strapplicantid%>";
var strOrgLevel="<%=strOrgLevel1%>";
var org_Code1="<%=org_Code1%>";
var varcbsid="<%=strCBSid%>";
var str_appno1 ="<%=strappno1%>";
var varfrom="<%=Helper.correctNull((String) hshValues.get("rfrom"))%>";
var varto="<%=Helper.correctNull((String) hshValues.get("rangeto"))%>";
var varstrclass="<%=Helper.correctNull((String) hshValues.get("hidClass"))%>";
var strRestrFrom="<%=Helper.correctNull((String) hshValues.get("strRestrFrom"))%>";
var varguafee="<%=Helper.correctNull((String) hshValues.get("LOAN_CG_PERCENT"))%>";
var varparamval="<%=Helper.correctNull((String) hshValues.get("loan_paramval"))%>";
var varparamvalsub="<%=Helper.correctInt((String) hshValues.get("loan_paramval_sub"))%>";
var strUsrClass="<%=Helper.correctNull((String) session
							.getAttribute("strUserClass"))%>";
var varData="<%=Helper.correctNull((String) hshValues
									.get("noData"))%>";
var varIntType ="<%=Helper.correctNull((String) hshValues
									.get("loaninttype"))%>";
var arrinterestval = "<%=Helper.correctNull((String) hshValues
							.get("strslabintrate"))%>";
var arrtoamtval = "<%=Helper.correctNull((String) hshValues
									.get("strslabtoamt"))%>";
var varRepayType ="<%=Helper.correctNull((String) hshValues
							.get("repaymenttype"))%>";
var interestcharged ="<%=Helper.correctNull((String) hshValues
							.get("loan_interestcharged"))%>";
var steptype="<%=Helper.correctNull((String) hshValues
							.get("loan_steptype"))%>";
var loan_repaycapacity ="<%=Helper.correctNull((String) hshValues
							.get("loan_repaycapacity"))%>";
var secured = '<%=Helper.correctNull((String) hshValues
									.get("loan_secure"))%>';						
var maxterms1="<%=maxterms%>";
var maxserviceleft="<%=employeeretirementage%>";
var subsidy="<%=Helper.correctNull((String) hshValues.get("loan_govt"))%>";
var scheme="<%=Helper.correctNull((String) hshValues
									.get("govt_scheme"))%>";
var agencyname="<%=Helper.correctNull((String) hshValues.get("LOAN_AGENCYNAME"))%>";
var measurement="<%=Helper.correctNull((String) hshValues
							.get("measurementtype"))%>";
var category="<%=Helper.correctNull((String) hshValues
							.get("perapp_category"))%>";
var age="<%=Helper.correctNull((String) hshValues.get("perapp_age"))%>";
var count=0;
var mortper="<%=Helper.correctNull((String) hshValues
							.get("loan_noofinstallment"))%>";
var varfrom1="<%=Helper.correctNull((String) hshValues
							.get("prd_rangefrom"))%>";
var varto="<%=Helper.correctNull((String) hshValues
									.get("prd_rangeto"))%>";
var offeredmargin="<%=Helper.correctNull((String) hshValues
							.get("offeredmargin"))%>";
var varsponseragency="<%=Helper.correctNull((String) hshValues
							.get("sponseragency"))%>";
var varsubsidytype="<%=Helper.correctNull((String) hshValues
									.get("subsidytype"))%>";
var varinwardnorequired="<%=Helper.correctNull((String) hshValues
							.get("inwardnorequired"))%>";
var varpageid="<%=Helper.correctNull((String) hshValues
									.get("PageId"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varIntCalcMode = "<%=Helper.correctNull((String) hshValues
							.get("loan_intcalcmode"))%>";
var varinternetappln = "<%=Helper.correctNull((String) hshValues
							.get("internetappln"))%>";
var varLoanPurpose="<%=Helper.correctNull((String)hshValues.get("phpa_loan_purpose"))%>";
var varProjectFinance="<%=Helper.correctNull((String)hshValues.get("phpa_project_finance"))%>";
var varUpfrontFee="<%=Helper.correctDouble((String)hshValues.get("loan_upfrontfee"))%>";
var varPrepaymentCharge="<%=Helper.correctDouble((String)hshValues.get("loan_prepaycharge"))%>";
var loan_cgtmse="<%=Helper.correctNull((String)hshValues.get("loan_cgtmse"))%>";
var varEmpStatus="<%=perapp_employment%>";
var varPrdType="<%=strProductType%>";
var varPurposeID="<%=strPurposeID%>";
var varDocReceivedNew="";
var varstrFreeze="<%=strFreeze%>";
var strvalue="loan_appretail_apploanproduct.htm";
var val="<%=Helper.correctNull((String) hshValues.get("loan_modeofpay"))%>";
var installment = "<%=Helper.correctNull((String) hshValues.get("loan_periodicity"))%>";
var servised = "<%=Helper.correctNull((String) hshValues.get("loan_servised"))%>";
var society="<%=Helper.correctNull((String) hshValues.get("loan_copsociety"))%>";
var varloanfac = "<%=Helper.correctNull((String) hshValues.get("loan_facility"))%>";
var varprdtype = "<%=Helper.correctNull((String) hshValues.get("prd_type"))%>";
var btnenable="<%=Helper.correctNull((String)request.getParameter("btnenable"))%>";
var appstatus="<%=appstatus%>";
var mortFlag="<%=mortFlag %>";
var vartakeover="<%=Helper.correctNull((String) hshValues.get("loan_takeover"))%>"
var takeover="<%=Helper.correctNull((String) hshValues.get("loan_takeover"))%>"
var varSecFlag="<%=Helper.correctNull((String) hshValues.get("strSecFreezeflag"))%>";
var varLoanRenewRestr="<%=strLoanRenewRestr%>";
var varTakeOverAvailFlag="<%=strTakeOverAvailFlag%>";
var varAppType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varMCLRType="<%=Helper.correctNull((String) hshValues.get("loan_mclrtype"))%>";
var varappraisalFlag="<%=Helper.correctNull((String) hshValues.get("appraisalFlag"))%>";
var varloandnwrevisions="<%=Helper.correctNull((String) hshValues.get("loan_dnw_revisions"))%>";
var varSHGcustomer="<%=Helper.correctNull((String) hshValues.get("SHGcustomer"))%>";
var varOtherDepFlag;
var varCFRverified="<%=Helper.correctNull((String) hshValues.get("LOAN_CFR_VERIFIED"))%>";
var varCFRnameCheck="<%=Helper.correctNull((String) hshValues.get("LOAN_CFR_BORNAME"))%>";
var varCGTMSE_APPLICABLE="<%=Helper.correctNull((String) hshValues.get("LOAN_CGTMSE_APPLICABLE"))%>";
var varEduDate="<%=Helper.correctNull((String)session.getAttribute("strEduDate"))%>";
var varRestrscheme="<%=Helper.correctNull((String) hshValues.get("loan_restr_scheme"))%>";
var varCersaiCheck="<%=Helper.correctNull((String) hshValues.get("LOAN_CERSAI_CHECK"))%>";
var strIntType="<%=strIntType%>";
var varIntCalcMode = "<%=Helper.correctNull((String) hshValues.get("loan_intcalcmode"))%>";
var appholder="<%=strAppholder%>";
var userid="<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>"; 
var selProc_Type="<%=Helper.correctNull((String) hshValues.get("LOAN_INS_COMPANY_NAME"))%>";
var selFunded_Cmp_name="<%=Helper.correctNull((String) hshValues.get("LOAN_INS_FUNDED_COMPANY_NAME"))%>";
var varLOAN_DIGI_MAXEMI="<%=Helper.correctNull((String) hshValues.get("strLOAN_DIGI_MAXEMI"))%>";
var varHouseFlag="<%=Helper.correctNull((String) hshValues.get("strHouseFlag"))%>";
var varInterestType="<%=Helper.correctNull((String)hshValues.get("strROIType"))%>";
var VARLOANUPDROIFLAG ="<%=Helper.correctNull((String)hshValues.get("STRLOANUPDROIFLAG"))%>";
var VARROIDATECHECK ="<%=STRROIDATECHECK%>";

var varPenalty="<%=strPenalty%>";
var varCondesc="<%=strCondesc%>";
var varConcession="<%=strConcession%>";
var varRoi="<%=strRoi%>";
var varSecValue= "<%=Helper.correctNull((String)hshValues.get("loan_secvalue"))%>";
var ecsaccntnum="<%=Helper.correctNull((String) hshValues.get("LOAN_ECSACCOUNTTYPE"))%>";
var ecsathunum="<%=Helper.correctNull((String) hshValues.get("LOAN_ECSATHUNMODE"))%>";
var ecsbankname="<%=Helper.correctNull((String) hshValues.get("LOAN_ECSBANKNAME"))%>";
var renewflag ="<%=Helper.correctNull((String)hshValues.get("appRenewprop"))%>";
var varSecValuemort= "<%=Helper.correctNull((String)hshValues.get("LOAN_DIGI_RESIDUAL"))%>";


function checkminndate(obj,mindate)
{
	alert("asd");
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) < Date.parse(mindt))
		{
			alert("Date cannot be less than " +mindate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}

function callDeviation(action)
{
	
	var appid=document.forms[0].hidapplicantid.value;
	appno=document.forms[0].appno.value;
	var purl ="<%=ApplicationParams.getAppUrl()%>action/perlimitofloan.jsp?Applicationno="+appno+"&btnenable="+btnenable+"&hidapplicantid="+appid;
	var xpos = (screen.width - 900) / 2;
	var ypos = (screen.height - 700) / 2;
	var prop = 'scrollbars=yes,menubar=YES,width=900,height=550,status=yes';
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Deviation',prop);
}

function callIfsccode()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(document.forms[0].selmodepayment.value=="C" )
		{
			var varECSifsccode=document.forms[0].txt_ECSifsccode.value;
			 if(varECSifsccode.length!=11){
	
				alert("Please Enter Valid IFSC Code");
				document.forms[0].txt_ECSifsccode.value="";
				return;
			}
			if(varECSifsccode.length==11)
				{
					document.all.ifrmifsc.src=appURL+"action/enachifsccode.jsp?hidBeanId=DigitalAppInterface&hidBeanGetMethod=IFSCcodeCheck&ifsccode="+varECSifsccode;
				}
		}
	}
}
function calltakeover()
{	
	var appid=document.forms[0].hidapplicantid.value;
	appno=document.forms[0].appno.value;
    var varQryString = appURL+"action/per_takeover.jsp?hidBeanId=pertakeover&hidBeanGetMethod=getData&appno="+ appno+"&btnenable="+document.forms[0].btnenable.value;
	var title = "Cost and Source";
	var prop = "scrollbars=yes,width=800,height=550";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);	
}
function takeover()

{ 
	
if(document.forms[0].sel_take_over.value == "Y" )
{

	document.all.id_takeover.style.visibility="visible";
    document.all.id_takeover.style.position="relative";
}
else
{
	document.all.id_takeover.style.visibility="hidden";
    document.all.id_takeover.style.position="absolute";
}
}
function callLink(url,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
 
function cggstcal()
{
	var varguafee = document.forms[0].txt_cg_gua_fee.value;
	var varcgper = parseFloat(document.forms[0].sel_cg_fee.value);
	var varmodintrate = parseFloat(document.forms[0].txtloan_modintrate.value);
	document.forms[0].txt_cg_gst.value=(varguafee*varparamval)/100;
	document.forms[0].txt_cg_int_rate.value=(varcgper+varmodintrate).toFixed(2);
	if(document.forms[0].txt_cg_gua_fee.value=="" && document.forms[0].sel_cg_fee.value=="0")
	{
		document.forms[0].txt_cg_gst.value = ""; 
		document.forms[0].txt_cg_int_rate.value = ""; 
	}

	/*var varcgsub = parseFloat(document.forms[0].txt_cg_int_rate.value);
	
	if(varcgsub > parseFloat(varparamvalsub))
	{
		alert("Total CGTMSE Interest rate should not exceed "+varparamvalsub+"%");
		document.forms[0].sel_cg_fee.focus();
		document.forms[0].sel_cg_fee.value="0";
		document.forms[0].txt_cg_int_rate.value=varmodintrate;
		return false;
	}*/
}

function openCGTMSE()
{		appno=document.forms[0].appno.value;
		var app_id=document.forms[0].inwardno.value;
		var varQryString = appURL+"action/CorpCgtmseCoverage.jsp?hidBeanId=supuser&hidBeanGetMethod=getCropCgtmse&appno="+ appno+"&btnenable="+btnenable+"&sel_facilitysno=1";
		var prop = "scrollbars=yes,width=1000,height=500, menubar=no";	
		prop = prop + ",left=100,top=50";
		window.open(varQryString,"",prop);
} 
function chkInsTenor(valflag)
{
	if(valflag=="T")
	{
		if(eval(document.forms[0].txt_premium_tenor.value)>eval(document.forms[0].txtloan_reqterms.value))
		{
			alert("Premium Tenor should not be more than Loan Tenor");
			document.forms[0].txt_premium_tenor.value="";
			document.forms[0].txt_premium_tenor.focus();
			return;
		}
	}
	else
	{
		if(eval(document.forms[0].txt_premium_loan_amt.value)>eval(document.forms[0].txtloan_amtreqd.value))
		{
			alert("Loan amount covered under the scheme should not more than Loan Amount Requested");
			document.forms[0].txt_premium_loan_amt.value="";
			document.forms[0].txt_premium_loan_amt.focus();
			return;
		}
	}
}

function callDigiEMI()
{

	var peridicity = trim(document.forms[0].sel_peridicity.value);
	var servised = trim(document.forms[0].interestservised.value);
	var varIntCalcMode = document.forms[0].sel_intcalcmode.value;
	var varterm = trim(document.forms[0].txtloan_reqterms.value);
	var moritorium = trim(document.forms[0].txt_installments.value);
	if (moritorium=="")
	{
		moritorium="0";
	}
	var interestcharged=document.forms[0].sel_interestcharge.value;
	
	var varrate=0;
	var  var_terms=trim(document.forms[0].txtloan_reqterms.value);
	var_terms=parseFloat(var_terms)-parseFloat(document.forms[0].txt_installments.value);
	varrate=parseFloat(document.forms[0].txtloan_modintrate.value)/(12*100);
	var denominator=Math.pow(varrate+1,var_terms)-1;
	var varnumerator=varrate*Math.pow(varrate+1,var_terms);
	var varamtreqst =parseFloat(document.forms[0].txtloan_amtreqd.value);

	if(servised == "y" && moritorium > 0 && interestcharged=="2")
	{
		if(varIntCalcMode == "C")
		{
			var tmp =  (1+(parseFloat(document.forms[0].txtloan_modintrate.value) / 1200));		
			sancAmt  = 	roundVal(varamtreqst *(Math.pow(tmp,moritorium)));
		}
		else if(varIntCalcMode == "S")
		{
			sancAmt = roundVal(varamtreqst + ((varamtreqst*moritorium*parseFloat(document.forms[0].txtloan_modintrate.value)))/1200);
		}
	}
	else if(servised == "n" && moritorium > 0 && interestcharged=="2")
	{
		if(varIntCalcMode == "C")
		{
			var tmp =  (1+(parseFloat(document.forms[0].txtloan_modintrate.value) / 1200));		
			sancAmt  = 	roundVal(varamtreqst *(Math.pow(tmp,moritorium)));
		}
		else if(varIntCalcMode == "S")
		{
			sancAmt = roundVal(varamtreqst + ((varamtreqst*moritorium*parseFloat(document.forms[0].txtloan_modintrate.value)))/1200);
		}
	}
	else
	{
		sancAmt  = 	roundVal(varamtreqst);
	}
	
	var varemi=0.00;
	if(denominator=="" || eval(denominator)==0)
	{
		varemi=0.0;
	}
	else
	{
		varemi=(varnumerator/denominator)*sancAmt;
	}
 	varemi=Math.round(varemi)
 	
 	if(isNaN(varemi))
	{
		varemi=0.00;
	}

 	varLOAN_DIGI_MAXEMI=Math.round(varLOAN_DIGI_MAXEMI);

	if((varemi) > roundVal(varLOAN_DIGI_MAXEMI))
	{
		alert("EMI (Rs."+varemi+") is greater than Maximum EMI (Rs."+varLOAN_DIGI_MAXEMI+") defined by BRE");
		document.forms[0].txtmonPay.value="0.00";
	}
	else
	{
		document.forms[0].txtmonPay.value=Math.round(varemi);
	}
			
	
}

function callBreUpdate()
{	
	if(varHouseFlag!="" && varHouseFlag=="N")
	{
		alert("Please Fill all fields in Proposed Assets-->House Tab ");
		return false;
	}
	document.forms[0].hidBeanId.value="DigitalAppInterface";
	document.forms[0].hidBeanGetMethod.value="breCallFourService";
	document.forms[0].action=appURL+"action/perDigiLoandetails.jsp";
	document.forms[0].submit()
}

function callRoiUpdate()
{
	if(varPrdType == "pB" && (varSecValue == "" || varSecValue == "0.00"))
	{
		alert("Please Fill Security Value ");
		document.forms[0].txtloan_SecValue.focus();
		return false;
	}

	document.forms[0].hidtxtduedate.value = document.forms[0].txt_duedate.value;
	if( renewflag=="R" && document.forms[0].hidtxtduedate.value == "")
	{
		ShowAlert('111',"Due date");
	 	document.forms[0].txt_duedate.focus();
	 	return;
	}
	
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanMethod.value="roiUpdateServices";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].hidSourceUrl.value="/action/perDigiLoandetails.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
	doSave();
}

function callRecalculateEligibility()
{
 	alert("Rate Of Interest: "+varRoi+"\n\n"+"Concession Interest: "+varConcession+"\n\n"+"Concession Description:"+varCondesc+"\n\n"+"Penalty Interest: "+varPenalty);
 		return;
}


</SCRIPT>
</head>
<body
onload="callOnLoad();disabledvalues();selsub('N');">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:9999999; left: 800px; top: 700px" >
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<div class="overlay" id="form_blur" style="position:absolute; visibility:hidden; height:950px"></div>
<form name="appform" method="post" class="normal">
	<%{ %>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr> 
	<tr>
		<td class="page_flow">  
			Home -&gt;Digi Retail -&gt; Loan Particulars-&gt; Loan Product
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	 class='outertable linebor'>
	<tr class="applicationheader">
		<td nowrap="nowrap" width="12%">&nbsp;<b>Proposal No :</b></td>
		<td nowrap="nowrap">&nbsp;<%=applicationno%></td>
		<td width="10%">&nbsp;<b>Applicant Name:</b></td>
		<td nowrap="nowrap">&nbsp;<%=appname%></td>
		<td nowrap="nowrap" width="7%">&nbsp;<b>Status:</b></td>
		<td nowrap="nowrap">&nbsp;<%=appstatus%></td>
		<td nowrap="nowrap" width="7%">&nbsp;<b>Digi Appno:</b></td>
		<td nowrap="nowrap">&nbsp;<%=digiappno%></td>
	</tr>
	<tr class="applicationheader">
		<td nowrap="nowrap">&nbsp;<b>Application Holder:</b></td>
		<td nowrap="nowrap">&nbsp;<%=strAppholder%></td>
		<td nowrap="nowrap">&nbsp;<b>App. Recd. from:</b></td>
		<td nowrap="nowrap">&nbsp;<%=strApporgname%></td>
		<td nowrap="nowrap">&nbsp;<b>Application No :</b></td>
		<td nowrap="nowrap">&nbsp;<%=inwardno%> <input type="hidden" name="appname"	value="<%=appname%>">
		 <input type="hidden" name="appno"
			value="<%=applicationno%>"> <input type="hidden" size="3" name="hidapplicantid" value="<%=applicantid%>"> <input
			type="hidden" name="inwardno" value="<%=inwardno%>"> <input	type="hidden" name="readFlag" value="<%=readFlag%>"> <input
			type="hidden" size="3" name="appholder" value="<%=strAppholder%>">
		<input type="hidden" name="applevel" value="<%=applevel%>">
		<input	type="hidden" name="apploantype" value="<%=loanType%>">
		<input type="hidden" name="valuesin" value="<%=strValuesin%>"> <input type="hidden" name="strappstatus" value="<%=strAppstatus%>">
		<input type="hidden" name="apporgname" value="<%=strApporgname%>">
		<input type="hidden" name="btnenable" value="<%=btnenable%>">
		<input type="hidden" name="hidApplicableFor" value="<%=strProAvailableFor%>">
		<input type="hidden" name="hidRepayType" value="<%=Helper.correctNull((String) hshValues
			.get("repaymenttype"))%>">
	<input type="hidden" name="hidTakeOverFlag" value="<%=Helper.correctNull((String) hshValues
			.get("loan_takeover"))%>">
			
		</td>
		<%if(appstatus.equalsIgnoreCase("Processed/Approved")){ %>
		<td nowrap="nowrap" width="7%">&nbsp;<b>Whether Send to CBS Done : &nbsp;</b></td>
		<td nowrap="nowrap">&nbsp;<%=strOpenFlag%></td>
		<%}else{ %>
		<td nowrap="nowrap" width="7%">&nbsp;<b></b></td>
		<td nowrap="nowrap"></td>
		<%} %>
		
	</tr>
	<tr class="applicationheader">
	<td nowrap="nowrap">&nbsp;<b>Sanction / Rejected Reference No:</b></td>
	<td>&nbsp;<%=sanctionrefno%></td>
		<td nowrap="nowrap">&nbsp;<b>CBS Account No:</b>&nbsp;</td>
		<td>&nbsp;<%=strCbsaccno%></td>
		<td nowrap="nowrap">&nbsp;<b>Proposal Type :</b>&nbsp;</td>
		<td>&nbsp;<%=strAppType%><input type="hidden" size="12" name="hidapplicationType" value="<%=strAppType%>"></td>
		<%if(appstatus.equalsIgnoreCase("Processed/Approved")){ %>
		<td nowrap="nowrap" width="7%">&nbsp;<b>Date of Account Opening:</b></td>
		<td nowrap="nowrap">&nbsp;<%=strAccOpenDate %></td>
		<%} else{ %>
		<td nowrap="nowrap" width="7%">&nbsp;<b></b></td>
		<td nowrap="nowrap"></td>
		<%} %>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left">
			<tr align="center">
				<td><jsp:include page="../per/applicantTabDigi.jsp" flush="true">
					<jsp:param name="linkid" value="1" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td>
								<table width="97%" border="0" cellspacing="0" cellpadding="4"
									align="center" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2"
											class="outertable">
											<%if(Helper.correctNull((String)hshValues.get("appProposalType")).equalsIgnoreCase("R")||Helper.correctNull((String)hshValues.get("appProposalType")).equalsIgnoreCase("P")){ %>
											<tr>
											<td colspan="2"><span class="mantatory">Existing Proposal No : <%=Helper.correctNull((String)hshValues.get("strParentAppno")) %> [Rs : <%=Helper.correctDouble((String)hshValues.get("strParentSancamt")) %>]</span></td>
											<td colspan="2"><span class="mantatory">Existing CBS Account No : <%=Helper.correctNull((String)hshValues.get("exstrCBSAccNo")) %></span></td>
											</tr>
											<%} %>
											<tr>
												<td>Application No:<span class="mantatory">*&nbsp;</span></td>
												<td nowrap="nowrap">&nbsp;</td>
												<td colspan="2">
												<table border="0" width="100%">
												<tr><td width="40%">
													<input type="text"
													name="txt_appinwardno" size="20" maxlength="15" tabindex=""
													onKeyPress="allowInteger(this)"
													value="<%=Helper.correctNull((String) hshValues.get("appinwardno"))%>"
													readOnly="readonly"><input type="hidden" name="hidinwardAmt" value="<%=Helper.correctDouble((String)hshValues.get("strInwardReqAmt")) %>"></td>
													<td width="60%" id="applsearch"><b><span
													onClick="showAckSearch()" style="cursor: hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													id="inwrd_srch" border="0" tabindex=""></span></b>
												</td></tr></table>
												</td>
												<td nowrap="nowrap">&nbsp;</td>
												<td colspan="2">
												<table class="outertable">
													<tr>
														<td nowrap="nowrap">Party File No.<span
													class="mantatory">*&nbsp;</span></td>
														<td><input type="text" name="txt_fileNo"
															maxlength="10" tabindex="1" size="10"
															value="<%=Helper.correctNull((String) hshValues
									.get("loan_fileno"))%>" onkeypress="allowNumber(this);">
														</td>
														<td nowrap="nowrap">Scheme Code</td>
														<td><input type="text" name="txt_schemecode"
															size="10"
															value="<%=Helper.correctNull((String) hshValues.get("schemecode"))%>">
															&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
															<span id="restr_acc">&nbsp;</span>
															</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td valign="top">Loan Product<b><span
													class="mantatory">*&nbsp;</span></b></td>
												<td valign="top">&nbsp;</td>
												<td colspan="5" valign="top"><input type="text"
													name="txtprd_desc" size="120" maxlength="100"
													value="<%=Helper.correctNull((String) hshValues.get("category"))%>-<%=Helper.correctNull((String) hshValues.get("subcategory"))%>-<%=Helper.correctNull((String) hshValues.get("PRD_DESC"))%>-<%=Helper.correctNull((String) hshValues.get("rfrom"))%>-<%=Helper.correctNull((String) hshValues.get("rangeto"))%>-<%=Helper.correctNull((String) hshValues.get("schemecode"))%>"
													onblur="changlabelCop();">
												<span onClick="callDescHelp();" style="cursor: hand" id="idprdsel"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="2"></span>&nbsp; 
													<a href="#" onClick="JavaScript:callAppStatusPopUp()" id="idnsdl1" style="visibility: hidden;position: absolute;"><b>NSDL Details</b></a>
													<a href="#" onClick="JavaScript:callDocument()"  id="idnsdl2" style="visibility: hidden;position: absolute;"><b>Documents</b></a>
												</td>
											</tr>
											 
											<tr>
												<td>Amount Requested <b><span class="mantatory">*&nbsp;</span></b></td>
												<td><%=ApplicationParams.getCurrency()%></td>
												<%if(!Helper.correctNull((String) hshValues.get("strModifyterms")).contains("SLILA")){ %>
												<td colspan="2" align="left"><lapschoice:CurrencyTag
													name="txtloan_amtreqd" maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("amtreqd"))%>'
													tabindex="3" size="15" 
													onChange="callDigiEMI();"
													onBlur="callDigiEMI();callOnAmtReqstdDigi();" /></td>
													<%}else{ %>
												<td colspan="2" align="left"><lapschoice:CurrencyTag
													name="txtloan_amtreqd" maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("amtreqd"))%>'
													tabindex="3" size="15" 
													onChange="callDigiEMI()"
													onBlur="callDigiEMI();callOnAmtReqstdDigi();" /></td>
													<%} %>
												<td>&nbsp;</td>
												<td align="left">Interest Type<span class="mantatory">*&nbsp;</span></td>
												<td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td width="18%"><select name="selectinttype"
															onChange="loadInterestType();getInterestValue();callIntcalcmode();disabledvalues();"
															tabindex="4">
															<%
																if (strIntType.trim().equalsIgnoreCase("Select")) {
															%>
															<option value="0" selected="selected">----Select----</option>
															<%
																} else {
															%>
															<option value="0">----Select----</option>
															<%
																}
																if (strIntType.trim().equalsIgnoreCase("Fixed"))
																{
															%>
															<option value="1" selected="selected">Fixed</option>
															<%
																} else {
															%>
															<option value="1">Fixed</option>
															<%
																}
																if(!(strPurposeID.equalsIgnoreCase("HC")))
																{
																if (strIntType.trim().equalsIgnoreCase("Floating")) {
															%>
															<option value="2" selected="selected">Floating</option>
															<%
																} else {
															%>
															<option value="2">Floating</option>
															<%
																}}
															%>
														</select></td>
														<td id="sel1" style="visibility: hidden"><select
															name="sel_steptype" tabindex="5"
															onchange="disabledvalues()">
															<option value="1" selected="selected">Regular</option>
															<option value="2">StepUp</option>
															<option value="3">StepDown</option>
														</select></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
											 <td>Insurance Covered Under&nbsp;
											 <select name="sel_Processed_Type"  onChange="processedType('Y')" style="width:150px">
											<option value=""><---select---></option>
											<lapschoice:StaticDataTag apptype="223"  tagType="<%=strAppstatus%>"/>
										</select>
											 <span class="mantatory">*</span></td>
											 <td>Rs.</td>
									          <td>
									          <input type="text" name="txt_metloanpremium" maxlength="15" size="15"
														onKeyPress="allowNumber(this)" onblur="roundtxt(this)";
														value="<%=Helper.correctNull((String) hshValues.get("loan_metlifepremiumamt"))%>" style="text-align:right">
									          </td>
									          </tr>
											 <tr id="id_premium_tenor" >
									          <td colspan="2">Premium Tenor (in Months)  <span class="mantatory">*</span></td>
									          <td>
									            <input type="text" name="txt_premium_tenor" maxlength="15" size="15" onKeyPress="allowNumber(this)"
														value="<%=Helper.correctNull((String) hshValues.get("LOAN_PREMIUM_TENOR"))%>" style="text-align:right" onblur="chkInsTenor('T')">
									          </td>
									          <td colspan="2">&nbsp;</td>
									            <td>Loan amount covered under the scheme <span class="mantatory">*</span></td>
									          <td >
									            <input type="text" name="txt_premium_loan_amt" maxlength="15" size="15" onKeyPress="allowNumber(this)" onblur="roundtxt(this);chkInsTenor('A');"
														value="<%=Helper.correctNull((String) hshValues.get("LOAN_PREMIUM_LOAN_AMOUNT"))%>" style="text-align:right">
									          </td>
									        
									          </tr>
											  <tr id="id_premium_Account_no1">
									          <td colspan="2">Operative account number from which<br> premium account will be debited <span class="mantatory">*</span></td>
									          <td>
									            <input type="text" name="txt_premium_Account_no" maxlength="16" size="15" onKeyPress="allowNumber(this)"
														value="<%=Helper.correctNull((String) hshValues.get("LOAN_INS_ACCOUNT_NO"))%>" style="text-align:right">
									          </td>
									          <td colspan="2">&nbsp;</td>
									           <td>Insurance Funded Company Name <span class="mantatory">*</span></td>
									          <td>
									            <select name="sel_Funded_Comp_Name"  style="width:150px"  >
											<option value="">---select---</option>
											<lapschoice:StaticDataTag apptype="223"  tagType="child"/>
										</select>
										
									          </td>
									          
									          
											</tr>
											<tr>
											<td id="idmclr1" nowrap="nowrap" colspan="2"> Reference Type</td>
														<td id="idmclr2" style="visibility: visible" ><select
															name="sel_mclrtype" onchange="calroitype();getInterestValue();callIntcalcmode();disabledvalues();">
															<option value=""><--select--></option>
															<%if(appstatus.equalsIgnoreCase("Open/Pending") || appstatus.equalsIgnoreCase("")){ %>
															<lapschoice:MCLRTag/>
															<%}else{ %>
															<option value="<%=strOption%>"><%=strDescription%></option>
															<%} %>
														</select></td>
											<td colspan="2">&nbsp;</td>			
											<td id="idint3" nowrap="nowrap"> ROI Type</td>
												<td id="idint4"><select name="sel_interesttype" onchange="getInterestValue();callIntcalcmode();disabledvalues();">
											<option value="">--------------Select--------------</option>
											<lapschoice:interesttype appmodule="P"  appvalue='<%=Helper.correctNull((String) hshValues.get("prdcode"))%>'/>
												</select></td>
											
											
											</tr>
											<tr id="leas">
											</tr>
											<tr>
												<% if(strPurposeID.equalsIgnoreCase("HC")||strPurposeID.equalsIgnoreCase("T")|| prdType.equalsIgnoreCase("pM")){ %>
												<td>Market value of Property<b><span class="mantatory">*&nbsp;</span></b></td>
												<%}else if(prdType.equalsIgnoreCase("pB")){%>
												<td>Total 2 Years of GST Return<b><span class="mantatory">*&nbsp;</span></b></td>
												<%}else{%>
												<td id="costproject1"><span id="cpl">Cost of the Project</span><b><span class="mantatory">*&nbsp;</span></b></td>
												<%} %>
												<td id="costproject2"><%=ApplicationParams.getCurrency()%></td>
												<td colspan="2" id="costproject3"><lapschoice:CurrencyTag
													name="txtloan_costloanprd" size="15" maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("cloanprd"))%>'
													 onBlur="callOnAmtReqstdDigi()"
													tabindex="6" />
													</td>
												<td>&nbsp;</td>
												
												<% if((prdType.equalsIgnoreCase("pB"))){%>
												
													<td>Net Security Value</td>
													
													<% if(prdType.equalsIgnoreCase("pB")){%>
													<td><%=ApplicationParams.getCurrency()%>
													<lapschoice:CurrencyTag
													name="txtloan_SecValue" size="15" maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("loan_secvalue"))%>'
													tabindex="6" />
													</td>
													<%}%>
												<%}%>
												</tr>
												<tr>												
												<td align="left" nowrap="nowrap">Interest Rate Defined p.a. %</td>
												<td>&nbsp; </td>
												<td valign="top">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td width="15%"><lapschoice:CurrencyTag name="txtloan_intrate"
															size="8"
															value='<%=Helper.correctNull((String)hshValues.get("loan_intrate"))%>' /></td>
														<td width="28%"> &nbsp;Modified&nbsp;</td>
														<td width="15%" nowrap="nowrap"><lapschoice:CurrencyTag
															name="txtloan_modintrate" size="8" maxlength="5"
															other="readOnly"
															value='<%=Helper.correctNull((String)hshValues.get("mintrate"))%>' /> p.a %
														</td>
														<td>&nbsp;</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td nowrap="nowrap">Initial Holiday/Gestation/ Moratorium Period <br/> (in
												Months)</td>
												<td>&nbsp;</td>
												<td colspan="2" valign="top"><input type="text"
													name="txt_installments" size="5"
													onBlur="moratperiod();callIntcalcmode();checkHoliday(this);callInterestCharged();showIntChargman();callCalculate()" maxlength="3"
													value="<%=Helper.correctNull((String) hshValues.get("loan_noofinstallment"))%>"
													onKeyPress="allowInteger();"
													tabindex="9"></td>
												<td>&nbsp;</td>
												<td>Loan Period (in months)<b><span
													class="mantatory">*&nbsp;</span></b></td>
												<td align="left"><input type="text"
													name="txtloan_reqterms" size="10" style="text-align: right" 
													value="<%=Helper.correctNull((String) hshValues.get("lreqterms"))%>"
													onKeyPress="allowNumber(document.forms[0].txtloan_reqterms)"
													onChange="" onBlur=""
													maxlength="3" tabindex="10"> <input type="hidden"
													size="5" maxlength="3" style="text-align: right"
													name="periods"
													value="<%=Helper.correctNull((String) hshValues.get("maxterms"))%>" />
													<input type="hidden" name="hidloan_reqterms" value="<%=Helper.correctNull((String) hshValues.get("loan_reqterms_ex"))%>" />
												</td>
											</tr>
											
											<tr>
												
												<td id="idhous" style="visibility:hidden;position:absolute" colspan="2">Age of the Premises&nbsp;<b><span class="mantatory">*</span></td>
												<td id="idage" style="visibility:hidden;position:absolute"><input type="text" name="txt_vehage" value="<%=Helper.correctNull((String) hshValues.get("loan_ageofveh"))%>" size="5" maxlength="2" 
													onKeypress="allowNumber(document.forms[0].txt_vehage)" onBlur="getMargincalc();calcAgeofVehicle();"> Years</td>
											</tr>
											<tr>
												<td nowrap="nowrap">Interest to be collected during Holiday&nbsp;<b><span class="mantatory" id="mnt1">*</span></b></td>
												<td>&nbsp;</td>
												<td colspan="2" valign="top"><select
													name="interestservised"
													onChange="interestselect();clearmonpay();enableinterestcharge();callIntcalcmode();callInterestCharged();callCalculate()"
													tabindex="12">
													<option value="s" selected="selected">Not
													Applicable</option>
													<option value="n">------No------</option>
													<option value="y">------Yes------</option>
												</select></td>
												<td>&nbsp;</td>
												<td id="lbl_periodicity" nowrap="nowrap">Periodicity of Installments <b><span
													class="mantatory">*&nbsp;</span></b></td>
												<td id="txt_periodicity"><select name="sel_peridicity"
													onChange="interestselect();checkPeriInstallments();selperiodicty();" tabindex="14">
													<option value="s" >Select</option>
													<option value="m" >Monthly</option>
													<option value="q">Quarterly</option>
													<option value="h">Half-Yearly</option>
													<option value="y">Yearly</option>
													<option value="n">Not Applicable</option>
												</select></td>
											</tr>
											<tr>
												<td>Interest charged</td>
												<td>&nbsp;</td>
												<td colspan="5"><select name="sel_interestcharge"
													tabindex="13" onChange="">
													<option value="1">To be paid as and when debited</option>
													<option value="2">To be accumulated and added to the principal to calculate EMI</option>
													<option value="3">Quarterly</option>
													<option value="4">Monthly</option>
													</select> &nbsp;&nbsp;&nbsp;</td>
											</tr>
											<tr>
												<td id="idintcalcmode1" nowrap="nowrap">Interest
												Calculation Mode</td>
												<td>&nbsp;</td>
												<td id="idintcalcmode2" COLSPAN="2"><SELECT NAME="sel_intcalcmode"
													TABINDEX="14">
													<OPTION VALUE="C">Compound Interest</OPTION>
													<OPTION VALUE="S">Simple Interest</OPTION>
												</SELECT></td>
												<td>&nbsp;</td>
												<td id="id_renewal_duedate1" style="visibility: hidden"> Due Date <span class="mantatory">*</span></td>
												<td id="id_renewal_duedate2" style="visibility: hidden">
												   <input type="text" name="txt_duedate" size="11" 
													value="<%=Helper.correctNull((String)hshValues.get("LOAN_DUEDATE"))%>"
													onBlur="checkDate(this);checkmaxdate(this,currentDate)"
													 maxlength="10" tabindex="15">
								    				<a alt="Select date from calender" href="#"
													onClick="callCalender('txt_duedate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
													alt="Select date from calender" tabindex="29"></a> </td>	
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
							<tr>
								<td>
								<table width="97%" border="1" cellspacing="0" cellpadding="4"
									class="outertable" align="center">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2"
											class="outertable">
											<tr>
												<td nowrap="nowrap">Purpose of Loan <b><span
													class="mantatory">*&nbsp;</span></b></td>
												<td>&nbsp;</td>
												<td colspan="5"><textarea name="txtloan_purposeofloan"
													cols="90" rows="5" tabindex="21"><%=Helper.correctNull((String) hshValues
																			.get("loanpurposeofloan"))%></textarea></td>
											</tr>
											 
											<tr>
												<td>Eligible loan Amount</td>
												<td><%=ApplicationParams.getCurrency()%></td>
												<td><b> <lapschoice:CurrencyTag
													name="txtloan_sancamt" size="15" value='<%=Loanamt%>'
													other="readOnly" /> </b></td>
													<td>&nbsp;</td>
												<td nowrap="nowrap" id="idemi1" style="" >Installment Amount
												</td>
												<td id="idemi2" style=""><%=ApplicationParams.getCurrency()%>
												<b> <lapschoice:CurrencyTag name="txtmonPay"
													size="15"
													value='<%=Helper.correctNull((String)hshValues.get("monthpay"))%>' />
												</b></td>												<td>&nbsp;</td>
												
												
											</tr>
											 
											<tr>
												<td nowrap="nowrap" id="lbl_repaytype">Repayment Type <b><span
													class="mantatory">*&nbsp;</span></b>&nbsp;</td>
												<td>&nbsp;</td>
												<td colspan="2" align="left" id="txt_repaytype"><select
													name="selrepaymenttype"
													onChange="showRepayment();showRepayButton()" tabindex="22">
													<option value="0">-------- Select --------</option>
													<option value="1">Equated Monthly Installment </option>
													<option value="2">Non-EMI</option>
													<option value="12">On Demand </option>
												</select>&nbsp;</td>
												
												<td>Minimum Margin</td>
												<td><lapschoice:CurrencyTag name="txtMarginpercent"
													size="7"
													value='<%=Helper.correctNull((String)hshValues.get("margin_perct"))%>'
													other="readonly" /> (% )</td>
											</tr>
											<tr>
												<td>Upfront Fee</td>
												<%if(!((strUpfrontFee.equalsIgnoreCase("0.00"))||
														(strUpfrontFee.equalsIgnoreCase("0")))){%>
												<td><%=ApplicationParams.getCurrency()%></td>
												<td><b> <lapschoice:CurrencyTag
													name="txtloan_upfrontfee" size="15"
													value='<%=Helper.correctNull((String)hshValues.get("loan_upfrontfee"))%>' />
												</b></td>
												<%} else { %>
												<td>&nbsp;<input type="hidden" name="txtloan_upfrontfee" value=""></td>
												<td><b><span class="mantatory">Not Applicable</span></b></td>
												<%} %>
												<td>&nbsp;</td>
												<td>Processing Fee (Including Taxes)&nbsp;</td>
												<% if(Helper.correctNull((String)hshValues.get("procfeeDevFlag")).equals("A")) { %>
													<td><%=ApplicationParams.getCurrency()%><b> <lapschoice:CurrencyTag
													name="txtloan_procfee" size="15" other="readOnly"
													value='<%=Helper.correctNull((String)hshValues.get("procfeenew"))%>' /></b></td>
												<%} else if(!(strLoanPurpose.equalsIgnoreCase("H")&&strProjectFinance.equalsIgnoreCase("Y"))){%>
												<td><%=ApplicationParams.getCurrency()%><b> <lapschoice:CurrencyTag
													name="txtloan_procfee" size="15" other="readOnly"
													value='<%=Helper.correctNull((String)hshValues.get("procfee"))%>' /></b></td>
												<%} else { %>
												<td>&nbsp;<input type="hidden" name="txtloan_procfee" value=""></td>
												<td><b><span class="mantatory">&nbsp;Waived&nbsp;</span></b></td>
												<%} %>
												
											</tr>
											<tr>
												<td>Whether Secured</td>
												<td>&nbsp;</td>
												<td><select name="sel_secured" onChange="entersecure()"
													tabindex="23">
													<option value="s">Secured</option>
													<option value="u">Unsecured</option>
													<option value="p">Partially Secured</option>
												</select></td>												<td>&nbsp;</td>
												
												<td>Mode of Payment<b><span class="mantatory">*&nbsp;</span></b></td>
												<td colspan="2"><select name="selmodepayment"
													tabindex="24" onChange="selOperative(this);"
													onBlur="validateAccno()">
													<option value="0" >&lt;----Select----&gt;</option>
													<!--<option value="0" selected="selected">&lt;----Select----&gt;</option>
													<option value="S">Recover From Salary</option>
													<option value="P">Post Dated Cheque</option>
													<option value="E">Transfer from Saving/Current a/c</option>
													<option value="D">Electronic Cheque Clearing(ECS)</option>
													<option value="N">Cash Recovery</option> -->
													<lapschoice:StaticDataNewTag apptype="217" />
												</select></td>
											</tr>
												<tr>
											<td colspan="4">&nbsp;</td>
											<td id="opnolabel">Operative Account Number</td>
												<td id="opnovalue" colspan="2"><input type="text"
													name="txt_operativeaccno" id="opaccno" onKeyPress="allowInteger()" onBlur="ValidateOpearativeAcc()"
													value="<%=Helper.correctNull((String) hshValues
													.get("loan_operativeaccno"))%>"
													 maxlength="16"></td>
											</tr>
											<tr>
											<td colspan="4">&nbsp;</td>
											<td id="ECSopnolabel1">Bank Name<b><span class="mantatory">*&nbsp;</span></b></td>
												<td id="ECSopnovalue1"><select name="sel_ECSBankName"
													tabindex="24" >
													<option value="0">---SELECT---</option>
													<lapschoice:StaticDataNewTag apptype="255" />
												</select>
												<!-- <input type="text"	name="txt_ECSBankName"
													value="<%=Helper.correctNull((String) hshValues
													.get("LOAN_ECSBANKNAME"))%>"> --></td>
											    <td id="ECSopnolabel5">Account Type<b><span class="mantatory">*&nbsp;</span></b></td>
												<td id="ECSopnovalue5"><select name ="sel_ECSaccnttype" >
													<option value="0">---SELECT---</option>
													<option value="1">SB</option>
													<option value="2">CA</option>
													<option value="3">OD</option></td>
											</tr>
											<tr>
											<td colspan="4">&nbsp;</td>
											<td id="ECSopnolabel2">Oper Account Number<b><span class="mantatory">*&nbsp;</span></b></td>
												<td id="ECSopnovalue2"><input type="text" 
													name="txt_ECSoperaccno" 
													value="<%=Helper.correctNull((String) hshValues
													.get("LOAN_ECSOPERACCNUM"))%>" maxlength="30"></td>
												<td id="ECSopnolabel3">Authentication Mode<b><span class="mantatory">*&nbsp;</span></b></td>
												<td id="ECSopnovalue3"><select name ="sel_ECSauthmode" >
													<option value="0">---SELECT---</option>
													<option value="1">IB</option>
													<option value="2">Debit Card</option>
													<option value="3">Manual ECS</option></td>
											</tr>
											<tr>
											<td colspan="4">&nbsp;</td>
											<td id="ECSopnolabel4">IFSC CODE<b><span class="mantatory">*&nbsp;</span></b></td>
												<td id="ECSopnovalue4"><input type="text" 
													name="txt_ECSifsccode" onChange="callIfsccode()"
													value="<%=Helper.correctNull((String) hshValues
													.get("LOAN_ECSIFSCCODE"))%>"
													 maxlength="11">
													
											</td>
											</tr>
											<tr>
												<td nowrap="nowrap">Govt. Sponsor Scheme</td>
												<td>&nbsp;</td>
												<td width="5%"><select name="selectgovt"
													onChange="selsub('Y')" tabindex="16">
													<option value="1">Yes</option>
													<option value="2" selected="selected">No</option>
												</select></td>
												<td colspan="2"></td>
												<td id="s1">Subsidy Amount&nbsp;</td>
												<td id="s2"><lapschoice:CurrencyTag name="sub"
													size="20" maxlength="10" onBlur="checkamt()"
													value='<%=Helper.correctNull((String)hshValues.get("loan_sub"))%>'
													tabindex="18" /> &nbsp;</td>
											</tr>
											<tr>
												<td id="s5">Scheme Type</td>
												<td>&nbsp;</td>
												<td id="s6"><select name="schemetype" tabindex="17">
													<option value="0">---select---</option>
													<lapschoice:StaticDataTag apptype="11"  tagType="<%=strAppstatus%>"/>
												</select> &nbsp;&nbsp;&nbsp;</td>
												<td colspan="4">&nbsp;&nbsp;&nbsp;</td>
											</tr>
											<tr id="s3">
												<td colspan="2" nowrap="nowrap">Sponsor Agency</td>
												<td colspan="2"><select name="sel_sponser_agency"
													tabindex="19" onchange="showAgency();">
													<option value="0">Select</option>
													<%
														String apptype = "3";
													%>
													<lapschoice:StaticDataTag apptype='<%=apptype%>' />
												</select></td>
												<td>&nbsp;</td>
												<td>Subsidy type</td>
												<td><select name="sel_subsidytype" tabindex="20">
													<option value="0">Select</option>
													<%		apptype = "5";
													%>
													<lapschoice:StaticDataTag apptype='<%=apptype%>' />
												</select></td>
											</tr>
											<tr id="s4">
												<td colspan="2" nowrap="nowrap">Name of the agency</td>
												<td><input type="text" name="txt_agency"
													size="20" maxlength="10"
													value='<%=Helper.correctNull((String)hshValues.get("AGENCYNAME"))%>'
													tabindex="27" /></td>
												
											</tr>
											<tr>
												<td>Whether Take-Over <span class="mantatory">*</span></td>
												<td>&nbsp;</td>
												<td><select name="sel_take_over" onChange="takeover()">
													<option value="0" ><--Select--></option>
													<option value="Y">Yes</option>
													<option value="N">No</option>
												</select></td>
												<td>&nbsp;</td><td>&nbsp;</td>
											</tr>
											<tr>
												<td nowrap="nowrap">Margin Offered by Borrower</td>
												<td><%=ApplicationParams.getCurrency()%></td>
												<td><b> <lapschoice:CurrencyTag
													name="txtmarginoffered" size="15" maxlength="12"
													other="readOnly"
													value='<%=Helper.correctNull((String)hshValues.get("offeredmargin"))%>' />
												</b></td>
												<td>&nbsp;</td>
												<td>&nbsp;</td>
												<td colspan="2" align="left"><input type="hidden"
													name="txtloan_recmdamt" size="15"
													value='<%=Helper.correctNull((String) hshValues.get("ramount"))%>' />
												</td>
											</tr>
											<tr>
												<td colspan="7">
												<table width="100%" border="0" scellspacing="0"
													cellpadding="2" class="outertable">
													<tr>
														<td id="calc1" width="36%"></td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
													</tr>
													<% if(Helper.correctNull((String) hshValues.get("repaymenttype")).equalsIgnoreCase("1")) {%>
													<tr>
														<td id="Amortlabel"><font color="#CC0000"><span id="amort1">Click
														here to view the Amortization Table</span></font>&nbsp;</td>
														<td id="amort2"><input type="button" name="amort"
															value="Amortization" class="buttonStyle"
															onClick="callAmortization()" tabindex="28"></td>
		<!--												<td colspan="2">&nbsp;</td>
														<% if (loanType.equalsIgnoreCase("p") && !(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))) { %>
														<td><input type="button" name="cmdClick" value="Deviations" class="buttonStyle"
															title="Check Deviations"
															onClick="callDeviation('normal')"></td>
														<% } %>-->
													</tr>
													<% } %>
													<tr>
														<td><font color="#CC0000">Application Received
														on * </font>(dd/mm/yyyy)</td>
														<td>
														<table border="0" cellspacing="0" cellpadding="3"
															class="outertable">
															<tr>
																<td><input type="text" name="txt_receivedRH"
																	size="11"
																	value="<%=Helper.correctNull((String) hshValues.get("loan_receivedate"))%>"
																	onBlur="checkDate(this);checkmaxdate(this,currentDate)"
																	maxlength="12"></td>
															</tr>
														</table>
														</td>
														<td><font color="#CC0000">Processed On </font><b><span
															class="mantatory">*&nbsp;</span></b> (dd/mm/yyyy)</td>
														<td>
														<table border="0" cellspacing="0" cellpadding="3"
															class="outertable">
															<tr>
																<td>
																<%
																	String strDateprocessed = "";
																	if (Helper.correctNull((String) hshValues.get("loanfiledon"))
																			.equalsIgnoreCase("")) {
																		strDateprocessed = Helper.getCurrentDateTime();
																	} else
																		strDateprocessed = Helper.correctNull((String) hshValues
																				.get("loanfiledon"));
																%> <input type="text" name="txtloan_filedon" size="11"
																	value="<%=strDateprocessed%>"
																	onBlur="checkDate(this);checkval(document.forms[0].txtloan_filedon.value)"
																	maxlength="12"></td>
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
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>		
			 <%if((Helper.correctNull((String) hshValues.get("prd_type")).equalsIgnoreCase("pH")) && (str_govt_scheme.equalsIgnoreCase("078") || str_govt_scheme.equalsIgnoreCase("079"))  ) {%>
			  <br>
			  <table border="0" cellspacing="0" cellpadding="3" align="center"  class="outertable linebor buttonbgcolor">
			    <tr> 
			       <td align="center">
			        <input type="button" name="pretakeover" value="PMAY Details" 
			       	 class="buttonStyle" style="width: 150" onClick="openPMAY()">
			      </td>
				</tr>				
			 </table>		
			<%} %>		
		</td>
	  <%if(Helper.correctNull((String) hshValues.get("prd_type")).equalsIgnoreCase("pH") || Helper.correctNull((String) hshValues.get("prd_type")).equalsIgnoreCase("pA") 
			  || Helper.correctNull((String) hshValues.get("prd_type")).equalsIgnoreCase("pB") || Helper.correctNull((String) hshValues.get("prd_type")).equalsIgnoreCase("pM")) {%>
		 <td>
			 <br>
		  <table border="0" cellspacing="0" cellpadding="3" align="center"  class="outertable linebor buttonbgcolor">
			    <tr>
		 			<td align="center">
					        <input type="button" name="updateBRE" value="BRE Update" 
				       	 class="buttonStyle" style="width: 150" onClick="callBreUpdate()">
		 			</td>
		 			<td align="center">
		 					<input type="button" value="ROI Update" class="buttonStyle" 
		 					style="width: 150" name="cmdroiupdate" onClick="callRoiUpdate()">
		 			</td>
		 			
		 			
				 </tr>				
		</table>
		</td> 
		<%} %>
		<td>
			 <br>
		  <table border="0" cellspacing="0" cellpadding="3" align="center"  class="outertable linebor buttonbgcolor">
			    <tr>
		 			<td align="center">
					<% if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("DIGI")){ %>
						<td align="center"><input type="button" class="buttonStyle" name="recalceligibility" value="ROI Details" onClick="callRecalculateEligibility()" class="buttonOthers"></td>
						<%} %>
		 			</td>
		 			
		 			
				 </tr>				
		</table>
		</td> 
		
		<td>		
			 <%if(Helper.correctNull((String) hshValues.get("loan_takeover")).equalsIgnoreCase("Y")) {%>
			 <br>
			  <table border="0" cellspacing="0" cellpadding="3" align="center" id="id_takeover" class="outertable linebor buttonbgcolor">
			    <tr> 
			      <td align="center">
			        <input type="button" name="pretakeover"
						class="buttonStyle" style="width: 150" value="Take Over details"
						onClick="calltakeover()">
			      </td>
				</tr>
			</table>
		<%}else{ %>
		<table id="id_takeover"><tr><td></td></tr></table><%}%>
		</td>
	</tr>
	<tr>
		<td>
		 <%if((Helper.correctNull((String) hshValues.get("LOAN_CGTMSE_APPLICABLE")).equalsIgnoreCase("Y") )) {%>
			  <br>
			  <table border="0" cellspacing="0" cellpadding="3" align="center"  class="outertable linebor buttonbgcolor">
			    <tr> 
			       <td align="center">
			        <input type="button" name="CGTMSE_coverage" value="CGTMSE coverage" 
			       	 class="buttonStyle" style="width: 150" onClick="openCGTMSE()">
			      </td>
				</tr>
			 </table>		
			<%} %>	
		</td>
	</tr>
</table>		
<br>
<%
	String strappno = Helper.correctNull((String) request
			.getParameter("appno"));
	if (strappno.equalsIgnoreCase("new")) {
		strappno = "";
	}
%> <lapschoice:combuttonnew
	btnnames='Edit_Save_Cancel_Delete_Audit Trail_Customer Background'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <INPUT TYPE="hidden"
	name="hidProductID"
	value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
	
<INPUT TYPE="hidden" name="hidpurpose" value="<%=strPurposeID %>">
<INPUT TYPE="hidden" name="hidDemoId"
	value="<%=Helper.correctNull((String) request
							.getParameter("hidapplicantid"))%>">
<INPUT TYPE="hidden" name="hidEditMode"
	value="<%=Helper.correctNull((String) hshValues
									.get("hidEditMode"))%>">
<INPUT TYPE="hidden" name="hidApploanType" value=""> <INPUT
	TYPE="hidden" name="page1"
	value="<%=Helper.correctNull((String) hshValues.get("page"))%>">
<INPUT TYPE="hidden" name="hidAppType"> <INPUT TYPE="hidden"
	name="strApp"
	value="<%=Helper.correctNull((String) hshValues
									.get("strApp"))%>">
<INPUT TYPE="hidden" name="radLoan"> <input type="hidden"
	name="hidinterest"
	value="<%=Helper.correctNull((String) hshValues
									.get("loaninttype"))%>">
<input type="hidden" name="hidinteresttype" value="Select"> <input
	type="hidden" name="hidifrminteresttype"><input type="hidden"
	name="hidifrminterestrates"
	value="<%=Helper.correctNull((String) hshValues
							.get("strslabintrate"))%>">
<input type="hidden" name="hidifrmtoamt"
	value="<%=Helper.correctNull((String) hshValues
									.get("strslabtoamt"))%>">
<input type="hidden" name="hidisedit" value="true"> 
<input	type="hidden" name="hidrepaymenttype" value=""> 
<input	type="hidden" name="hidstartterms" value="1"> 
<input	type="hidden" name="hidrepayment"	value="<%=Helper.correctNull((String) hshValues.get("repaymenttype"))%>">
<input type="hidden" name="comappid"	value="<%=Helper.correctNull((String) hshValues.get("hidapplicantid"))%>">
<input	type="hidden" name="loan_steptype"	value="<%=Helper.correctNull((String) hshValues.get("loan_steptype"))%>">
<input type="hidden" name="perapp_employment"	value="<%=perapp_employment%>"> 
<input type="hidden"	name="perapp_dob" value="<%=session.getAttribute("perapp_dob")%>">
<input type="hidden" name="perapp_status"
	value="<%=hshValues.get("perapp_status")%>"> <input	type="hidden" name="borrowername"	value="<%=session.getAttribute("bowname")%>"> 
	<input	type="hidden" name="hidappno1" value=""> <input type="hidden"	name="radLoan1" value=""> 
<input type="hidden" name="orgscode" value="<%=Helper.correctNull((String) session.getAttribute("strOrgShortCode"))%>">
<input type="hidden" name="orgcode" value="<%=Helper.correctNull((String) session.getAttribute("strOrgCode"))%>">
<input type="hidden" name="orglevel" value="<%=Helper.correctNull((String) session.getAttribute("strOrgLevel"))%>">
<input type="hidden" name="grouprights" value="<%=Helper.correctNull((String) session.getAttribute("strGroupRights"))%>">
<input type="hidden" name="prdid1" value=""> 
<input type="hidden" name="repayperiod" value="<%=Helper.correctNull((String) hshValues.get("maxterms"))%>">
<input type="hidden" name="hid_comappid2" value="<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>">
<input type="hidden" name="prd_type" value="<%=strProductType%>">
<input type="hidden" name="checkappno" value="<%=applicationno%>">
<input type="hidden" name="hidStaffFlag" value="<%=Helper.correctNull((String) hshValues.get("staff_flag"))%>">
<input type="hidden" name="hidPrincipalRatio" value="<%=Helper.correctNull((String) hshValues.get("PrincipalRatio"))%>">
<input type="hidden" name="hidInterestRatio" value="<%=Helper.correctNull((String) hshValues.get("InterestRatio"))%>">
<input type="hidden" name="hidPrincipalRepay" value="<%=Helper.correctNull((String) hshValues.get("PRD_STAFF_MAXTERM_PRIN"))%>">
<input type="hidden" name="hidInterestRepay" value="<%=Helper.correctNull((String) hshValues.get("PRD_STAFF_MAXTERM_INTR"))%>">
<input type="hidden" name="hidselexservice" value="<%=Helper.correctNull((String) hshValues.get("perapp_selexservice"))%>">
<input type="hidden" name="hidexserviceyear" value="<%=Helper.correctNull((String) hshValues.get("perapp_exserviceyear"))%>">
<input type="hidden" name="hidyearsinbuss" value="<%=Helper.correctNull((String) hshValues.get("peremp_yearsinbuss"))%>">
<input type="hidden" name="hidServiceLeft" value="<%=employeeretirementage%>"> 
<input type="hidden" name="hidStaffProduct" value="<%=Helper.correctNull((String) hshValues.get("staffproduct"))%>">
<input type="hidden" name="hidrangeto" value=""> 
<input type="hidden" name="hidrangefrom"> 
<input type="hidden" name="hidminservice"> 
<input type="hidden" name="hidmaxservice"> 
<input type="hidden" name="hidtotalyear"> 
<input type="hidden" name="hidserviceamount"> 
<input type="hidden" name="hidappminage" value="<%=Helper.correctNull((String) hshValues.get("prd_appminage"))%>">
<input type="hidden" name="hidCategory"> 
<input type="hidden" name="minterm" value="<%=Helper.correctNull((String)hshValues.get("strprdminterm")) %>">
<input type="hidden" name="hidvehAge" value="<%=Helper.correctNull((String) hshValues.get("prd_maxageofvehicle"))%>">
<input type="hidden" name="hidCommentPage" value="LoanProd">
<input type="hidden" name="hidHoliday" value="<%=Helper.correctInt((String)hshValues.get("prd_holiday"))%>">
<INPUT TYPE="hidden" name="hidDeleteDeviationFlag">
<INPUT TYPE="hidden" name="hidOldProductCode" value="<%=Helper.correctNull((String) hshValues.get("prdcode"))%>">
<input type="hidden" name="hidInterestIndexId" value="<%=Helper.correctNull((String) hshValues.get("loan_interestid"))%>">
<input type="hidden" name="hidBaserate" value="<%=Helper.correctNull((String) hshValues.get("loan_baserate"))%>">
<input type="hidden" name="hidFreeze" value="<%=Helper.correctNull((String) hshValues.get("cre_freeze"))%>">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<input type="hidden" name="appstatus" value="<%=appstatus%>">
<%}%>
<input type="hidden" name="hidmortflag" value="<%=mortFlag %>">
<input type="hidden" name="hidstaff_under" value="<%=Helper.correctNull((String) hshValues.get("staff_under"))%>" >
<input type="hidden" name="hidtakeover" value="<%=Helper.correctNull((String) hshValues.get("loan_takeover"))%>">
<input type="hidden" name="hidODFlag" value="<%=strPrdLoanType %>">
<input type="hidden" name="hidPrdFlag" value="<%=Helper.correctNull((String)hshValues.get("strPrdFlag"))%>">
<input type="hidden" name=hidPrdReselectFlag value="<%=Helper.correctNull((String)hshValues.get("strReselectprd"))%>">
<input type="hidden" name="hidLoanRenewRestr" value="<%=Helper.correctNull((String) hshValues.get("APP_RENEW_FLAG"))%>">
<input type="hidden" name="hidPSterms" value="<%=Helper.correctNull((String) hshValues.get("strModifyterms"))%>">
<input type="hidden" name="hidtakeoveravail" value="<%=Helper.correctNull((String) hshValues.get("TakeOverAvailFlag"))%>">
<input type="hidden" name="hidcreditrskpremium" value="<%=Helper.correctNull((String) hshValues.get("loan_creditrskval"))%>">
<input type="hidden" name="hidbusstrategicpremium" value="<%=Helper.correctNull((String) hshValues.get("loan_busstatval"))%>">
<input type="hidden" name="hidMCLRTableCode" value="<%=Helper.correctNull((String) hshValues.get("loan_mclrtabcode"))%>">
<input type="hidden" name="hidprdbankscheme" value="<%=Helper.correctNull((String) hshValues.get("strprdbankscheme"))%>">
<input type="hidden" name="hidLARbankscheme" value="<%=Helper.correctNull((String) hshValues.get("strLARbankscheme"))%>">
<input type="hidden" name="hidNSDLFlag" value="<%=Helper.correctNull((String) hshValues.get("strNSDLFlag"))%>">
<input type="hidden" name="hidNSDLRefNo" value="<%=Helper.correctNull((String) hshValues.get("strNSDLRefNo"))%>">
<input type="hidden" name="hidconstitution" value="<%=Helper.correctNull((String) hshValues.get("perapp_constitutionnew"))%>">
<input type="hidden" name="hidvehicletype" value="<%=Helper.correctNull((String) hshValues.get("prd_vehitype"))%>">
<input type="hidden" name="hidAppCGStatus" value="<%=Helper.correctNull((String) hshValues.get("AS_PERAPP_CONSTITUTION_CGTMSE"))%>">
<input type="hidden" name="hidPMAYDet" value="<%=Helper.correctNull((String) hshValues.get("strPMAYDet"))%>">
<input type="hidden" name="hidprocessnote" value="<%=Helper.correctNull((String) hshValues.get("app_processdate"))%>">
<input type="hidden" name="hidCGTMSE" value="<%=Helper.correctNull((String) hshValues.get("ApplicationExist"))%>">
<input type="hidden" name="hid_cgtmse_applicable" value="<%=prd_cgtmse %>">
<input type="hidden" name="hidPhysicalLimitAvailed" value="<%=Helper.correctDouble((String) hshValues.get("strPhyLimitAvailed"))%>">
<input type="hidden" name="hidDematLimitAvailed" value="<%=Helper.correctDouble((String) hshValues.get("strDematLimitAvailed"))%>">
<input type="hidden" name="hidPhysicalLimit" value="<%=Helper.correctDouble((String) hshValues.get("strPhyLimit"))%>">
<input type="hidden" name="hidDematLimit" value="<%=Helper.correctDouble((String) hshValues.get("strDematLimit"))%>">
<input type="hidden" name="hidPhysicalFlag" value="<%=Helper.correctNull((String) hshValues.get("strPhyLimitExceeds"))%>">
<input type="hidden" name="hidDematFlag" value="<%=Helper.correctNull((String) hshValues.get("strDematLimitExceeds"))%>">
<input type="hidden" name="hidSharetype" value="<%=Helper.correctNull((String) hshValues.get("PRD_SHARETYPE"))%>">
<iframe height="0" width="0" id="ifrmrepayment" frameborder="0" style="border: 0"></iframe>
<iframe	height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm1" frameborder="0"	style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrminterest" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrmifsc" frameborder="0"	style="border: 0"></iframe>
<input type="hidden" name="hidtxtduedate"> 
<input type="hidden" name="hidapplicantnewid"	value="<%=strapplicantNewid%>">
<input type="hidden" name="hidCRP" value="<%=Helper.correctNull((String) hshValues.get("loan_crp"))%>">
<input type="hidden" name="hidBSP" value="<%=Helper.correctNull((String) hshValues.get("loan_bsp"))%>">
</form>
</body>
</html>