<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
String strCreatedDate=Helper.correctNull((String)hshValues.get("strCreatedDate"));
if(strCreatedDate.equalsIgnoreCase(""))
	strCreatedDate=Helper.getCurrentDateTime();
long lngDatediff=Helper.dateDiff("06/06/2020",strCreatedDate);
if(lngDatediff>=0){
	session.setAttribute("strECFlag", "Y");
}
String strncgtcflag=Helper.correctNull((String)hshValues.get("strncgtcflag")) ;
String strncgtcbankscheme=Helper.correctNull((String)hshValues.get("strBankscheme")) ;
String v_strenwr_check=Helper.correctNull((String)hshValues.get("strenwr_check"));
if(v_strenwr_check=="")	
	v_strenwr_check="N";	

session.setAttribute("strncgtcflag", strncgtcflag);
session.setAttribute("strncgtcbankscheme", strncgtcbankscheme);
	String strAppno = "",strFacCategory = "";
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
//out.println("hshValues===="+hshValues);	
	java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	
	String applicantid = "",applicantnewid="";
	String appstatus = "";
	String appname = "";
	String inwardno = "";
	String applevel = "";
	String valuesin = "";
	String strcatory = "";
	String strApporgname = "";
	String strAppholder = "";
	String btnenable = "";
	String strAppstatus = "",strIntDefAccDetails="";
	String loanType = "";
	String strModule = "";
	String strAppType ="";
	String strPropPSterms ="";
	String strapp_freeze_flag = "";
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strFinancialReq=Helper.correctNull((String) hshValues.get("app_financialrequired"));
	String strSHGcustomer=Helper.correctNull((String) hshValues.get("SHGcustomer"));
	String strFacilityAgr=Helper.correctNull((String) hshValues
			.get("strFacilityAgr"));
	session.setAttribute("strFacilityAgr", strFacilityAgr);
	session.setAttribute("strFinancialReq", strFinancialReq);
	session.setAttribute("strPageID_PS", Helper.correctNull((String) hshValues.get("Page_Id_PS")));
	String ProposalType = Helper.correctNull((String) hshValues
			.get("app_proptype"));
	String sanctionrefno="";
	if(applicantid.equalsIgnoreCase(""))
	{
		applicantid = Helper.correctNull((String) hshValues.get("comapp_id"));
	}
	String strBorrowerType = Helper.correctNull((String) hshValues.get("hidBorrowerType"));
	String strCbsaccno="",strRevalFlag="";
	if (hshValues.get("hshAppData") != null) {
		HashMap hshRecord = (HashMap) hshValues.get("hshAppData");
		strAppno = Helper.correctNull((String) hshRecord.get("appno"));
		if(applicantid.equalsIgnoreCase("")){
		applicantid = Helper.correctNull((String) hshRecord
				.get("applicantid"));	}
		appstatus = Helper.correctNull((String) hshRecord
				.get("app_status"));
		appname = Helper
				.correctNull((String) hshRecord.get("app_name"));
		inwardno = Helper.correctNull((String) hshRecord
				.get("inwardno"));
		applevel = Helper.correctNull((String) hshRecord
				.get("applevel"));
		valuesin = Helper.correctNull((String) hshRecord
				.get("valuesin"));
		ProposalType = Helper.correctNull((String) hshRecord
				.get("app_proptype"));
		strAppholder = Helper.correctNull((String) hshRecord
				.get("applnholder"));
		strApporgname = Helper.correctNull((String) hshRecord
				.get("apporgname"));
		loanType = Helper.correctNull((String) hshRecord
				.get("apploantype"));
		strAppstatus = Helper.correctNull((String) hshRecord
				.get("app_status"));
		sanctionrefno= Helper.correctNull((String) hshRecord
				.get("sanctionrefno"));
		strCbsaccno = Helper.correctNull((String) hshRecord.get("CBSACCOUNTNO"));
		btnenable = ("" + Helper.correctNull(
				(String) session.getAttribute("strGroupRights"))
				.charAt(18)).equals("r") ? "N" : (appstatus
				.equalsIgnoreCase("OP") && strAppholder
				.equals(Helper.correctNull((String) session
						.getAttribute("strUserId")))) ? "Y" : "N";
		applicantnewid = Helper.correctNull((String) hshRecord
				.get("applicantnewid"));
		strAppType = Helper.correctNull((String) hshRecord.get("ApplicantType"));
		
		if(strAppType.equalsIgnoreCase("S"))
		{
			strAppType="Restructure";
		}else if(strAppType.equalsIgnoreCase("R"))
		{
			strAppType="Renew";
		}else{
			strAppType="Fresh";
		}
		strRevalFlag = Helper.correctNull((String) hshRecord.get("strRevalidationFlag"));
	}
	if (strAppno.equalsIgnoreCase("")) {
		strAppno = Helper.correctNull((String) request.getParameter("appno"));
	}
	session.setAttribute("strAppno",strAppno);
	if (appstatus.equalsIgnoreCase("")) {
		appstatus = Helper.correctNull((String) request.getParameter("appstatus"));
	}
	if (strAppstatus.equalsIgnoreCase("op") || strAppno.equalsIgnoreCase("new")){
		appstatus = "Open/Pending";
	}else if(strAppstatus.equalsIgnoreCase("pa")){
		appstatus = "Processed/Approved";
	}else if(strAppstatus.equalsIgnoreCase("pr")){
		appstatus = "Processed/Rejected";
	}else if(strAppstatus.equalsIgnoreCase("ca")){
		appstatus = "Closed/Approved";
	}else if(strAppstatus.equalsIgnoreCase("cr")){
		appstatus = "Closed/Rejected";
	}
	else if(strAppstatus.equalsIgnoreCase("ol")){
		appstatus = "Open/Lodged";
	}
	if(appname.equalsIgnoreCase(""))
	{
		appname = Helper.correctNull((String)request.getParameter("compname"));
	}
	strcatory = Helper.correctNull((String)request.getParameter("hidcatory"));
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	ArrayList vecHead = new ArrayList();
	ArrayList vecFac = new ArrayList();
	String strHeaddesc = "";
	String strHeadId = "";
	String strFacId = "";
	String strFacdesc = "";
	String strExist = "";
	String strProposed = "";
	String strDiff = "";
	String strMargin = "", strAction = "", strFacType = "facility";
	String strInterest = "";
	String strInt = "";
	String strbplr = "";
	String strDP = "";
	String strSecurity = "";
	String strCbsaccountno = "";
	String strintremarks = "",strTUF="";
	String strOutstanding = "";
	String strIntadjust = "";
	String strOsAsOn = "";
	String strexistbanktype = "";
	String strpropbanktype = "";
	int vecsize = 0;

	String strLC = Helper.correctDouble((String) hshValues.get("lc"));
	String strTotExist = Helper.correctDouble((String) hshValues.get("totexist"));
	String strTotDiff = Helper.correctDouble((String) hshValues.get("totdiff"));
	strAppno = Helper.correctNull((String) hshValues.get("appno"));
	String strselsno = Helper.correctNull((String) hshValues.get("selsno"));
	String strsubselsno = Helper.correctNull((String) hshValues.get("selsubsno"));
	strAction = Helper.correctNull((String) hshValues.get("hidAction"));
	strFacType = Helper.correctNull((String) hshValues.get("factype"));
	strFacCategory = Helper.correctNull((String) hshValues.get("faccategory"));
	strInterest = Helper.correctNull((String) hshValues.get("facility_interest"));
	strPropPSterms = Helper.correctNull((String) hshValues.get("PSterms_Proposal"));
	strapp_freeze_flag = Helper.correctNull((String) hshValues.get("app_freeze_flag"));
	
	if(strFacCategory.trim().equals(""))
	{
		strFacCategory = "R";
	}
	if(strFacType.trim().equals(""))
	{
		strFacType = "facility";
	}
	if(hshValues != null)
	{
		vecData = (ArrayList) hshValues.get("vecData");
	}

	if (vecData != null) {
		vecsize = vecData.size();
	}
	
	// end
	
	if(strBorrowerId.trim().equals(""))
	{
		strBorrowerId = Helper.correctNull((String) request.getParameter("comapp_id"));
	}
	String appval = Helper.correctNull((String) request.getParameter("val"));
	String appflag = Helper.correctNull((String) request.getParameter("valf"));
	String appMangflag = Helper.correctNull((String) request.getParameter("valm"));
	String appGroupflag = Helper.correctNull((String) request.getParameter("valg"));
	ArrayList arrSubGrpList = new ArrayList();
	
	if(!strCategoryType.equalsIgnoreCase(""))
	{
		session.removeAttribute("cattype");
		session.setAttribute("cattype",strCategoryType);
	}
	//out.println(hshValues);
	String strCheckFlag=Helper.correctNull((String)hshValues.get("strFlag"));
	String strFreeze=Helper.correctNull((String)hshValues.get("cre_freeze"));
	String strCBSid=Helper.correctNull((String)hshValues.get("inward_cbsid"));
	String strType=Helper.correctNull((String)request.getParameter("hidType"));
	if(strType.equalsIgnoreCase(""))
	{
		strType=Helper.correctNull((String)request.getParameter("hidstrType"));
	}
	if(strType.equalsIgnoreCase(""))
	{
		strType=Helper.correctNull((String)hshValues.get("hidstrType"));
	}
	String facility_type=Helper.correctNull((String)request.getParameter("type"));
	if(facility_type.equalsIgnoreCase(""))
	{
		facility_type=Helper.correctNull((String)hshValues.get("app_renew_flag"));
	}
	session.setAttribute("strRatingTabHide",Helper.correctNull((String)hshValues.get("strRatingTabHide")));
	session.setAttribute("strAppType",Helper.correctNull((String)hshValues.get("app_renew_flag")));
	
	
	if(Helper.correctNull((String)hshValues.get("strCashMargin")).equalsIgnoreCase("Y"))
		session.setAttribute("strCashMargin",Helper.correctNull((String)hshValues.get("strCashMargin")));
	else
		session.setAttribute("strCashMargin","");
	
	session.setAttribute("strappstatus",strAppstatus);
	
	String FACILITY_WHT_CGTMSEAPPLY=Helper.correctNull((String)hshValues.get("FACILITY_WHT_CGTMSEAPPLY"));
	session.setAttribute("PRD_CGTMSE",FACILITY_WHT_CGTMSEAPPLY);
	String FACILITY_SNO=Helper.correctNull((String)hshValues.get("COM_CGTMSE"));
	String Cgtmse_app_corp=Helper.correctNull((String)hshValues.get("strCGTMSE_CORP"));
	
	String StrDigiLoanType=Helper.correctNull((String)hshValues.get("StrDigiLoanType"));	
	session.setAttribute("StrDigiLoanType",StrDigiLoanType);
	session.setAttribute("strcgssdType",Helper.correctNull((String)hshValues.get("strcgssdavailable")));
	String strappreason="";
	String stractiveflag=Helper.correctNull((String)hshValues.get("stractiveflag"));
	if(stractiveflag.equalsIgnoreCase("N")){
	 strappreason=Helper.correctNull((String)hshValues.get("APP_REASON"));
	}

	String perapp_invocdate =  Helper.correctNull((String)hshValues.get("strRestructureInvoDate"));
	session.setAttribute("Str_ApplicantId",applicantid); 
	String ngctccount=Helper.correctNull((String)hshValues.get("NCGTCCOUNT"));
	//out.println("ngctccount==="+strCategoryType);
		String digiappno= Helper.correctNull((String) hshValues.get("digiappno"));
	session.setAttribute("digiappno",digiappno);
	if(digiappno.equalsIgnoreCase(""))
	{
		digiappno="NA";
	}
	String  FACILITY_PROPOSEDValue= Helper.correctNull((String)hshValues.get("FACILITY_PROPOSEDValue"));
	double d=0.0;
	String asShgcheck="";
	String sumoffacilitiesas="";
	if(!FACILITY_PROPOSEDValue.equalsIgnoreCase(""))
	{
	 d=Double.parseDouble(FACILITY_PROPOSEDValue);
	 if(2000000>=d)
	 {
	 asShgcheck="Y";
	 }
	 else
	 {
		 asShgcheck="N";	 
	 }
	 sumoffacilitiesas = Helper.correctNull((String)hshValues.get("FACILITY_PROPOSEDValue"));
	}
	else
	{
		asShgcheck="N";
	}
%>
<html>
<head>
<title>Facilities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script src="<%=ApplicationParams.getAppUrl()%>js/com/facilities.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>	
<script>

var editflag=1;
var varhidAction ="<%=strAction%>";
  var editlockflag="<%=hshValues.get("editlock")%>";
var varhidpge="";
var varhidRen="";
var varcbsid="<%=strCBSid%>";
var varapp_freeze_flag="<%=strapp_freeze_flag%>";
var var_rating_pending="<%=Helper.correctNull((String)hshValues.get("app_rating_pending"))%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var headid = "<%=Helper.correctNull((String) hshValues
									.get("headid"))%>";
var facid = "<%=Helper.correctNull((String) hshValues
									.get("facdid"))%>";
var subheadid = "<%=Helper.correctNull((String) hshValues.get("subheadid"))%>";
var subfacid = "<%=Helper.correctNull((String) hshValues.get("subfacdid"))%>";
var varinwardnorequired="<%=Helper.correctNull((String) hshValues
							.get("inwardnorequired"))%>";
var varProposalValue="<%=Helper.correctNull((String) hshValues
							.get("proposalvaluesin"))%>";
var varFacilityReq="<%=Helper.correctNull((String) hshValues
							.get("app_financialrequired"))%>";
var varproposaltype="<%=ProposalType%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";
var strBorrowerType="<%=strBorrowerType%>";
var varstrFreeze="<%=strFreeze%>";
var strAppid="";

var strSecFreezeflag="<%=Helper.correctNull((String) hshValues.get("strSecFreezeflag"))%>";
var varAppType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var boolflag=true;
var varEditFlag=false;
var varEditSubFlag=false;
var vardatediff="<%=Helper.correctInt((String)hshValues.get("daydiff"))%>";
var varsize="<%=vecsize%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var varperappcons="<%=Helper.correctNull((String)hshValues.get("AS_PERAPP_CONSTITUTION_CGTMSE"))%>";
var varparamval="<%=Helper.correctNull((String)hshValues.get("loan_paramval_cgtmse"))%>";
var varQueryStatus="<%=Helper.correctNull((String)hshValues.get("Query_Status"))%>";
var strFreezeFlag="<%=Helper.correctNull((String)hshValues.get("strFreeze"))%>";
var strtenorval="<%=Helper.correctNull((String)hshValues.get("FACILITY_MONTHS"))%>";
var ecsaccntnum="<%=Helper.correctNull((String) hshValues.get("LOAN_ECSACCOUNTTYPE"))%>";
var ecsathunum="<%=Helper.correctNull((String) hshValues.get("LOAN_ECSATHUNMODE"))%>";
var ecsbankname="<%=Helper.correctNull((String) hshValues.get("LOAN_ECSBANKNAME"))%>";
var varncgtccount="<%=Helper.correctNull((String)hshValues.get("NCGTCCOUNT"))%>";
var strncgtcflag="<%=strncgtcflag%>";
var strncgtcbankscheme="<%=strncgtcbankscheme%>";
var sumoffacilitiesas="<%=sumoffacilitiesas%>";
var miborchk="<%=Helper.correctNull((String)hshValues.get("miborchk"))%>";



function selectValues(sno,subsno,grpSize,grpList,CGPAN)
{
	
	document.forms[0].hidCGPANExpired.value=CGPAN;
	var varbankschemecode="";
	document.forms[0].hid_jusflag.value="";
	document.forms[0].checkbox.disabled=false;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		if(subsno!=0)
		{
			document.forms[0].cmdnew.disabled=true;
		}
		else
		{
			document.forms[0].cmdnew.disabled=true;
		}
	}	
	
	document.forms[0].hidGrpSize.value=grpSize;
	document.forms[0].hidGrpList.value=grpList;
	var group=0;
	var strheadid=0,strfacid=0,strsubheadid=0,strsubfacid=0;
 	document.forms[0].hidAction.value = "update";
	document.forms[0].appno.value = "<%=Helper.correctNull((String) hshValues.get("appno"))%>";
	len = document.forms[0].facility_head.length;
	document.forms[0].selsno.value="";
	document.forms[0].selsubsno.value="0";
	if(sno)
	{
		
		//if(document.forms[0].elements["txtcategory"+sno].value=="R")
		//{
			//document.forms[0].category[0].checked=true;
		//}
		//else if(document.forms[0].elements["txtcategory"+sno].value=="A")
		//{
			//document.forms[0].category[1].checked=true;
		//}		
	}
 	if(document.forms[0].elements["txtsublimit"+sno].value=="Y")
	{
		group = document.forms[0].elements["txtgroup"+sno].value;
		if(group>0)
		{		
 			strheadid = document.facility.elements["txtheadid"+group].value;
			strfacid = document.facility.elements["txtfacid"+group].value;
			strsubheadid = document.facility.elements["txtsubheadid"+sno].value;
			strsubfacid = document.facility.elements["txtsubfacid"+sno].value;
			//added by bhaskar
			document.forms[0].facilitysub_head_id_code.value=strsubheadid;
			document.forms[0].facilitysub_id_code.value=strsubfacid;
			document.forms[0].facilitydescsubnew.value=document.forms[0].elements["strfacDescNewSub"+sno+subsno].value;
			document.forms[0].facilitydescsubnew.title=document.forms[0].elements["strfacDescNewSub"+sno+subsno].value;
			document.forms[0].facility_head_id_code.value=strheadid;
			document.forms[0].facility_id_code.value=strfacid;
			document.forms[0].facility_OldCode.value=strfacid;
			document.forms[0].facilitydescnew.value=document.forms[0].elements["strfacDescNew"+subsno+"0"].value;	
			document.forms[0].facilitydescnew.title=document.forms[0].elements["strfacDescNew"+subsno+"0"].value;		
			document.forms[0].selsno.value = document.forms[0].elements["txtsno"+sno].value;
			varbankschemecode= document.forms[0].elements["hidBankschemecode"+sno].value;
			//alert(varbankschemecode);
			document.forms[0].selsubsno.value = subsno;
			document.forms[0].factype.value = "sublimit";
			document.forms[0].checkbox.checked=true;
			document.forms[0].txt_desc.value=document.forms[0].elements["txtdesc"+subsno+"0"].value;	
			document.forms[0].txt_renewaljustif.value=document.forms[0].elements["hidRenewalJustif"+subsno+"0"].value;	
			document.forms[0].txt_exist_limit.value=document.forms[0].elements["txtexist"+subsno+"0"].value;	
			document.forms[0].txt_proposed_limit.value=document.forms[0].elements["txtproposed"+subsno+"0"].value;
			document.forms[0].txt_proposed_limit_old.value=document.forms[0].elements["txtproposed"+subsno+"0"].value;
			document.forms[0].hidproposed.value=document.forms[0].elements["txtproposed"+subsno+"0"].value;						
			document.forms[0].txt_subdesc.value=document.forms[0].elements["txtsubdesc"+sno+subsno].value;
			document.forms[0].txt_renewaljustif_sub.value=document.forms[0].elements["hidRenewalJustifSub"+sno+subsno].value;
			document.forms[0].txt_subexist_limit.value=document.forms[0].elements["txtsubexist"+sno+subsno].value;
			document.forms[0].txt_subproposed_limit.value=document.forms[0].elements["txtsubproposed"+sno+subsno].value;
			document.forms[0].txt_subproposed_limit_old.value=document.forms[0].elements["txtsubproposed"+sno+subsno].value;
			document.forms[0].facility_nature.value=document.forms[0].elements["txtfacnature"+subsno+"0"].value;
			document.forms[0].facilitysub_nature.value=document.forms[0].elements["txtsubfacnature"+sno+subsno].value;
			//document.forms[0].txt_submargin.value=document.forms[0].elements["txtsubmargin"+sno+subsno].value;
			//document.forms[0].txt_subinterest.value=document.forms[0].elements["txt_subinterest"+sno+subsno].value;
			document.forms[0].prd_subintrate.value=document.forms[0].elements["txtsubbplr"+sno+subsno].value;
			document.forms[0].prd_intrate.value=document.forms[0].elements["txtbplr"+subsno+"0"].value;
			//document.forms[0].txt_intremarks.value=document.forms[0].elements["txtintremarks"+subsno+"0"].value;	
			//document.forms[0].txt_subintremarks.value=document.forms[0].elements["txtsubintremarks"+sno+subsno].value;
			document.forms[0].txt_facmonths.value=document.forms[0].elements["txtmonths"+subsno+"0"].value;	
			document.forms[0].hid_facmonths.value=document.forms[0].elements["txtmonths"+subsno+"0"].value;	
			document.forms[0].txt_subfacmonths.value=document.forms[0].elements["txtsubmonths"+sno+subsno].value;
			document.forms[0].hid_subfacmonths.value=document.forms[0].elements["txtsubmonths"+sno+subsno].value;
			document.forms[0].txt_purpose.value=document.forms[0].elements["txtpurpose"+subsno+"0"].value;
			document.forms[0].txt_subpurpose.value=document.forms[0].elements["txtsubpurpose"+sno+subsno].value;
			document.forms[0].sel_propbanktype.value=document.forms[0].elements["selpropbanktype"+subsno+"0"].value;	
			document.forms[0].sel_sub_propbanktype.value=document.forms[0].elements["selsubpropbanktype"+sno+subsno].value;
			//added by bhaskar
			
			document.forms[0].sel_peridicityfac.value=document.forms[0].elements["selperinstalfac"+subsno+"0"].value;	
			document.forms[0].sel_peridicityfacsub.value=document.forms[0].elements["selperinstalfacsub"+sno+subsno].value;

			document.forms[0].sel_inttype.value=document.forms[0].elements["selinttype"+subsno+"0"].value;	
			document.forms[0].sel_sub_inttype.value=document.forms[0].elements["selsubinttype"+sno+subsno].value;

			if(document.forms[0].sel_sub_inttype.value=="Flo" && varAppType!="P")
			{
				document.all.iddescsub.style.display="inline";
			}
			else
			{
				document.all.iddescsub.style.display="none";
			}
			if(document.forms[0].sel_inttype.value=="Flo" && varAppType!="P")
			{
				document.all.iddesc.style.display="inline";
			}
			else
			{
				document.all.iddesc.style.display="none";
			}
			document.forms[0].sel_intsutype.value=document.forms[0].elements["selintsubtypefac"+subsno+"0"].value;	
			document.forms[0].sel_intsufacsubtype.value=document.forms[0].elements["selintsubtypeSubfac"+sno+subsno].value;
			
			/*if(document.forms[0].sel_intsufacsubtype.value=="FTBR")
				{
				document.all.idsubmibordate.style.visibility="visible";
				document.all.idsubmibordate.style.position="relative";
				document.all.idsubmibordate1.style.visibility="visible";
				document.all.idsubmibordate1.style.position="relative";
				document.all.idsubmibortenor.style.visibility="visible";
				document.all.idsubmibortenor.style.position="relative";
				document.all.idsubmibortenor1.style.visibility="visible";
				document.all.idsubmibortenor1.style.position="relative";
				document.forms[0].txtsubDate.value= document.forms[0].elements["fbildatesub"+sno+subsno].value;
				
				document.forms[0].Tenormiborsub.value= document.forms[0].elements["fbiltenorsub"+sno+subsno].value;
			
				}
			else
				{
				alert("sub2");
				document.all.idsubmibordate.style.visibility="hidden";
				document.all.idsubmibordate.style.position="absolute";
				document.all.idsubmibordate1.style.visibility="hidden";
				document.all.idsubmibordate1.style.position="absolute";
				document.all.idsubmibortenor.style.visibility="hidden";
				document.all.idsubmibortenor.style.position="absolute";
				document.all.idsubmibortenor1.style.visibility="hidden";
				document.all.idsubmibortenor1.style.position="absolute";
				document.forms[0].txtsubDate.value= document.forms[0].elements["fbildatesub"+sno+subsno].value;
				document.forms[0].Tenormiborsub.value= document.forms[0].elements["fbiltenorsub"+sno+subsno].value;
				
				}
			if(document.forms[0].sel_intsutype.value=="FTBR")
			{
				document.all.idmainmibordate.style.visibility="visible";
				document.all.idmainmibordate.style.position="relative";
				document.all.idmainmibordate1.style.visibility="visible";
				document.all.idmainmibordate1.style.position="relative";
				document.all.idmainmibortenor.style.visibility="visible";
				document.all.idmainmibortenor.style.position="relative";
				document.all.idmainmibortenor1.style.visibility="visible";
				document.all.idmainmibortenor1.style.position="relative";
			
			document.forms[0].txtmianDate.value= document.forms[0].elements["fbildate"+subsno+"0"].value;
			document.forms[0].Tenormibormain.value= document.forms[0].elements["fbiltenor"+subsno+"0"].value;
			
			}
		else
			{
			
			document.all.idmainmibordate.style.visibility="hidden";
			document.all.idmainmibordate.style.position="absolute";
			document.all.idmainmibordate1.style.visibility="hidden";
			document.all.idmainmibordate1.style.position="absolute";
			document.all.idmainmibortenor.style.visibility="hidden";
			document.all.idmainmibortenor.style.position="absolute";
			document.all.idmainmibortenor1.style.visibility="hidden";
			document.all.idmainmibortenor1.style.position="absolute";
			document.forms[0].txtmianDate.value= document.forms[0].elements["fbildate"+subsno+"0"].value;
			document.forms[0].Tenormibormain.value= document.forms[0].elements["fbiltenor"+subsno+"0"].value;
			}*/

			document.forms[0].hidIntIdFac.value=document.forms[0].elements["selIntIdFac"+subsno+"0"].value;	
			document.forms[0].hidIntIdFacSub.value=document.forms[0].elements["selIntIdFacSub"+sno+subsno].value;

			document.forms[0].hidBaseRateFac.value=document.forms[0].elements["selFacBaseRate"+subsno+"0"].value;	
			document.forms[0].hidBaseRateFacSub.value=document.forms[0].elements["selFacBaseRateSub"+sno+subsno].value;

			document.forms[0].sel_subfac_desc.value=document.forms[0].elements["hid_sel_subfac_desc"+sno+subsno].value;
			

			//document.forms[0].txt_remarks.value=document.forms[0].elements["selremarks"+subsno+"0"].value;	
			//document.forms[0].txt_remarks_sub.value=document.forms[0].elements["selremarkssub"+sno+subsno].value;

			document.forms[0].sel_repaytype.value=document.forms[0].elements["selrepaytype"+subsno+"0"].value;	
			document.forms[0].sel_sub_repaytype.value=document.forms[0].elements["selsubrepaytype"+sno+subsno].value;

			document.forms[0].selectgovtmain.value=document.forms[0].elements["selgovtscheme"+subsno+"0"].value;	
			document.forms[0].selectgovt.value=document.forms[0].elements["selsubgovtscheme"+sno+subsno].value;

			document.forms[0].txt_freshlimitmain.value=document.forms[0].elements["hidFreshLimitmain"+subsno+"0"].value;	
			document.forms[0].txt_freshlimitsub.value=document.forms[0].elements["hidFreshLimitsub"+sno+subsno].value;
			
			document.forms[0].txt_installments.value=document.forms[0].elements["selhoidayperiod"+subsno+"0"].value;		
			document.forms[0].hid_installments.value=document.forms[0].elements["selhoidayperiod"+subsno+"0"].value;		
			moratperiod('N');	
			document.forms[0].txt_installments_sub.value=document.forms[0].elements["selhoidayperiodsub"+sno+subsno].value;
			document.forms[0].hid_installments_sub.value=document.forms[0].elements["selhoidayperiodsub"+sno+subsno].value;
			moratperiod1('N');
            if(document.forms[0].elements["selhoidayperiod"+subsno+"0"].value!="0")
            {
				document.forms[0].interestservised.value=document.forms[0].elements["selintereceived"+subsno+"0"].value;
				document.forms[0].sel_interestcharge.value=document.forms[0].elements["selinterestcharged"+subsno+"0"].value;
            }
            if(document.forms[0].elements["selhoidayperiodsub"+sno+subsno].value!="0")
            {
				document.forms[0].interestservised_sub.value=document.forms[0].elements["selintereceivedsub"+sno+subsno].value;
				document.forms[0].sel_interestcharge_sub.value=document.forms[0].elements["selinterestchargedsub"+sno+subsno].value;
            }

            document.forms[0].sel_fac_desc.value=document.forms[0].elements["hid_sel_fac_desc"+subsno+"0"].value;

            if(document.forms[0].sel_fac_desc.value=="2")
            {
                document.all.idex.style.display="table-row";

                var varPropNo=document.forms[0].elements["hidExPropSno"+subsno+"0"].value;
                var varPropSNo=document.forms[0].elements["hidExPropno"+subsno+"0"].value;
                var varPropAmt=document.forms[0].elements["hidExPropSancAmt"+subsno+"0"].value;
                if(varPropNo!="")
                {
                    var varDesc="";
                    var varArr1=varPropNo.split("~");
                    var varArr2=varPropSNo.split("~");
                    var varArr3=varPropAmt.split("~");

                    for(var i=0;i<varArr1.length;i++)
                    {
                    	varDesc=varDesc+varArr1[i]+" - "+varArr2[i]+" [Rs:"+varArr3[i]+"] \n";
                    }

                    document.all.idsubex1.innerText=varDesc;
                }
                else
                {
                	document.all.idex1.innerText=document.forms[0].elements["hidExPropSno"+subsno+"0"].value+" - "+document.forms[0].elements["hidExPropno"+subsno+"0"].value+"[Rs:"+document.forms[0].elements["hidExPropSancAmt"+subsno+"0"].value+"]";  
                }
                
                document.all.idex2.innerText=document.forms[0].elements["hidExPropAccno"+subsno+"0"].value;
                document.all.idex3.innerText=document.forms[0].elements["hidExLimitType"+subsno+"0"].value;

				if(document.forms[0].txt_exist_limit.value!=document.forms[0].txt_proposed_limit.value)
				{
					document.all.renewal_justif.style.display="table-row"; 
				}
                
            }
            else
            {
            	document.all.idex.style.display="none"; 
            	document.all.idex1.innerText="";
                document.all.idex2.innerText="";
                document.all.renewal_justif.style.display="none"; 
            }
            if(document.forms[0].sel_subfac_desc.value=="2")
            {
                document.all.idsubex.style.display="table-row";

                var varPropNo=document.forms[0].elements["hidsubExPropSno"+sno+subsno].value;
                var varPropSNo=document.forms[0].elements["hidsubExPropno"+sno+subsno].value;
                var varPropAmt=document.forms[0].elements["hidsubExPropSancAmt"+sno+subsno].value;

                if(varPropNo!="")
                {
                    var varDesc="";
                    var varArr1=varPropNo.split("~");
                    var varArr2=varPropSNo.split("~");
                    var varArr3=varPropAmt.split("~");

                    for(var i=0;i<varArr1.length;i++)
                    {
                    	varDesc=varDesc+varArr1[i]+" - "+varArr2[i]+" [Rs:"+varArr3[i]+"] \n";
                    }

                    document.all.idsubex1.innerText=varDesc;
                }
                else
                {
                	document.all.idsubex1.innerText=document.forms[0].elements["hidsubExPropSno"+sno+subsno].value+" - "+document.forms[0].elements["hidsubExPropno"+sno+subsno].value+" [Rs:"+document.forms[0].elements["hidsubExPropSancAmt"+sno+subsno].value+"]";  
                }
                document.all.idsubex2.innerText=document.forms[0].elements["hidsubExPropAccno"+sno+subsno].value;
                document.all.idsubex3.innerText=document.forms[0].elements["hidSubExLimitType"+sno+subsno].value;

                if(document.forms[0].txt_subexist_limit.value!=document.forms[0].txt_subproposed_limit.value)
				{
					document.all.renewal_justif_sub.style.display="table-row"; 
				}
            }
            else
            {
            	document.all.idsubex.style.display="none"; 
            	document.all.idsubex1.innerText="";
                document.all.idsubex2.innerText="";
                document.all.renewal_justif_sub.style.display="none"; 
            }

           /// alert(document.forms[0].sel_fac_desc.value);

           document.forms[0].selmodepayment.value=document.forms[0].elements["selmodepay"+subsno+"0"].value;
		   //selOperative('facility');
           if(document.forms[0].elements["selmodepay"+subsno+"0"].value=="E")
           {
            	document.forms[0].txt_operativeaccno.value=document.forms[0].elements["seloperaccno"+subsno+"0"].value;
           }	
			document.forms[0].selmodepayment_sub.value=document.forms[0].elements["selmodepaysub"+sno+subsno].value;
			//selOperative('sub');
			if(document.forms[0].elements["selmodepaysub"+sno+subsno].value=="E")
	          {
	            document.forms[0].txt_operativeaccno_sub.value=document.forms[0].elements["seloperaccnosub"+sno+subsno].value;
	           }

			   document.forms[0].txt_margin.value=document.forms[0].elements["selmargin"+subsno+"0"].value;	
				document.forms[0].txt_margin_sub.value=document.forms[0].elements["selmarginsub"+sno+subsno].value;
				
				//document.forms[0].txt_agency.value=document.forms[0].elements["strFacAgency"+sno+subsno].value;

	           	//Added for Agri Scheme type 
	        if(varstrSessionModuleType=="AGR")
			{
				if(document.forms[0].elements["hid_strAgrSchemeType"+subsno+"0"].value!="")
				{
					
					document.forms[0].sel_schemetype.value=document.forms[0].elements["hid_strAgrSchemeType"+subsno+"0"].value;
				}
				else
				{
					document.forms[0].sel_schemetype.value="0";
				}
				if(document.forms[0].elements["hid_strAgrsubSchemeType"+sno+subsno].value!="")
				{
					
					document.forms[0].sel_subschemetype.value=document.forms[0].elements["hid_strAgrsubSchemeType"+sno+subsno].value;
				}
				else
				{
					document.forms[0].sel_subschemetype.value="0";
				}
			}
			//End of Agri Scheme type
			         //added by bhaskar
			         <%if(strSessionModuleType.equalsIgnoreCase("AGR"))
			     		strModule="a";
			     	else if(strSessionModuleType.equalsIgnoreCase("CORP"))
			     		strModule="c";%>
			     	var varModtype="<%=strModule%>";       
			      
			     	 var varStrfacCode=document.forms[0].elements["selfaccode"+subsno+"0"].value;			     	
			     	 var varstrfacsubcode=document.forms[0].elements["selfacsubcode"+sno+subsno].value;
			     	 document.forms[0].facilitydesc.value=varStrfacCode;
			     	 document.forms[0].facilitydescsub.value=varstrfacsubcode;

			     	 if(document.forms[0].facilitydescsub.value!="")
				      {
					      var varFac=document.forms[0].facilitydescsub.value.split("-");
					      var varTemp="";
					      for(var i=0;i<varFac.length;i++)
					      {
						      if(i<6)
						      {
						    	  if(varTemp=="")
						    		  varTemp=varFac[i];
						    	  else
						    		  varTemp=varTemp+"-"+varFac[i];
						      }
					      }

					      document.forms[0].facilitydescsub.value=varTemp;
					      
				      }			     	 
			
			if(document.forms[0].elements["selsubgovtscheme"+sno+subsno].value=="1")
			{

				    document.all.s5.style.visibility="visible";
				    document.all.s5.style.position="relative";	
				    	
				    document.all.s6.style.visibility="visible";
				    document.all.s6.style.position="relative";
				    
			    	document.all.s1.style.visibility="visible";
			    	document.all.s1.style.position="relative";
			    		
			    	document.all.s2.style.visibility="visible";
			    	document.all.s2.style.position="relative";	
			    	
			    	document.all.s3.style.visibility="visible";
			    	document.all.s3.style.position="relative";

			    	document.forms[0].schemetype.value=document.forms[0].elements["selsubschemetype"+sno+subsno].value;
			     	document.forms[0].sel_sponser_agency.value=document.forms[0].elements["selsubsponsagency"+sno+subsno].value;
			     	document.forms[0].sel_subsidytype.value=document.forms[0].elements["selsubsubsidytype"+sno+subsno].value;
			     	document.forms[0].subamt.value=document.forms[0].elements["txtsubsubsidyamunt"+sno+subsno].value;
			     	document.forms[0].txt_subagency.value=document.forms[0].elements["strFacAgencysub"+sno+subsno].value;
		    	

			}
			else
			{

				document.all.s5.style.visibility="hidden";
		    	document.all.s5.style.position="absolute";
		    	
		    	document.all.s6.style.visibility="hidden";
		    	document.all.s6.style.position="absolute";
		    		
		    	document.all.s1.style.visibility="hidden";
		    	document.all.s1.style.position="absolute";
		    		
		    	document.all.s2.style.visibility="hidden";
		    	document.all.s2.style.position="absolute";
		    		
		    	document.all.s3.style.visibility="hidden";	
		    	document.all.s3.style.position="absolute";


			}

			 if(document.forms[0].elements["selgovtscheme"+subsno+"0"].value=="1")
		     {
		    	document.all.s5m.style.visibility="visible";
		 	    document.all.s5m.style.position="relative";	
		 	    	
		 	    document.all.s6m.style.visibility="visible";
		 	    document.all.s6m.style.position="relative";
		 	    
		     	document.all.s1m.style.visibility="visible";
		     	document.all.s1m.style.position="relative";
		     		
		     	document.all.s2m.style.visibility="visible";
		     	document.all.s2m.style.position="relative";	
		     	
		     	document.all.s3m.style.visibility="visible";
		     	document.all.s3m.style.position="relative";

		     	document.forms[0].schemetypemain.value=document.forms[0].elements["selschemetype"+subsno+"0"].value;
		     	document.forms[0].sel_sponser_agencymain.value=document.forms[0].elements["selsponsagency"+subsno+"0"].value;
		     	document.forms[0].sel_subsidytypemain.value=document.forms[0].elements["selsubsidytype"+subsno+"0"].value;
		     	document.forms[0].submainamnt.value=document.forms[0].elements["txtsubsidyamunt"+subsno+"0"].value;
		     } 
		     else
		     {

		        document.all.s5m.style.visibility="hidden";
		     	document.all.s5m.style.position="absolute";
		     	
		     	document.all.s6m.style.visibility="hidden";
		     	document.all.s6m.style.position="absolute";
		     		
		     	document.all.s1m.style.visibility="hidden";
		     	document.all.s1m.style.position="absolute";
		     		
		     	document.all.s2m.style.visibility="hidden";
		     	document.all.s2m.style.position="absolute";
		     		
		     	document.all.s3m.style.visibility="hidden";	
		     	document.all.s3m.style.position="absolute";

		     }	

			 document.forms[0].txtcbsaccno.value=document.forms[0].elements["hidcbsaccno"+subsno+"0"].value;
			 document.forms[0].txtsubcbsaccno.value=document.forms[0].elements["hidsubcbsaccno"+sno+subsno].value;	
				
		}
		 if((trim(document.forms[0].selectgovt.value)=="1") && (trim(document.forms[0].sel_sponser_agency.value)=="OTHERS"))
	     {
	    	 document.all.s4s.style.visibility="visible";
	    	 document.all.s4s.style.position="relative";
	     }
	     else
	     {
	    	 document.all.s4s.style.visibility="hidden";
	    	 document.all.s4s.style.position="absolute";
	    }

		 //document.forms[0].txt_remarks.value=document.forms[0].elements["selremarks"+subsno+"0"].value;	
		// document.forms[0].txt_remarks_sub.value=document.forms[0].elements["selremarkssub"+sno+subsno].value;
			    
		 document.forms[0].sel_displaydesc.value=document.forms[0].elements["strdisplaydesc"+subsno+"0"].value;	
		 document.forms[0].sel_subdisplaydesc.value=document.forms[0].elements["strsubdisplaydesc"+sno+subsno].value;

		 getFacDescription(document.forms[0].elements["strdisplaydesc"+subsno+"0"].value,document.forms[0].elements["hid_facility_code"+subsno+"0"].value);
		 getSubFacDescription(document.forms[0].elements["strsubdisplaydesc"+sno+subsno].value,document.forms[0].elements["hid_sub_facility_code"+sno+subsno].value);

		 document.forms[0].txt_duedate.value=document.forms[0].elements["strduedate"+subsno+"0"].value;	
		 document.forms[0].txt_subduedate.value=document.forms[0].elements["strsubduedate"+sno+subsno].value;
		 document.forms[0].txt_subfac_type.value=document.forms[0].elements["hid_sel_subfac_type"+sno+subsno].value;

		 document.forms[0].selfac_restr_acc.value=document.forms[0].elements["hid_sel_fac_restracc"+subsno+"0"].value;
		 document.forms[0].selfac_fitl_acc.value=document.forms[0].elements["hid_sel_fac_fitlacc"+subsno+"0"].value;
		 document.forms[0].hid_str_rsAcc.value=document.forms[0].elements["hid_sel_fac_RestrFrom"+subsno+"0"].value;
		 document.forms[0].hidfacilityCode.value=document.forms[0].elements["hid_facility_code"+subsno+"0"].value;
		 document.forms[0].hidfacilityCode1.value=document.forms[0].elements["hid_facility_code"+subsno+"0"].value;
		 document.forms[0].sel_restr_conversionfac.value=document.forms[0].elements["hid_selconversionfac"+subsno+"0"].value;
		 document.forms[0].sel_restr_addfunding.value=document.forms[0].elements["hid_seladdfunding"+subsno+"0"].value;
		 <%if(facility_type.equalsIgnoreCase("S")) {%>
		 		 funenablefitl();
		 		changeCEFAF();
		 		funacctsel();
		 		//checkdateval();
		 <%}%>

		 document.forms[0].selsubfac_restr_acc.value=document.forms[0].elements["hid_sel_subfac_restracc"+sno+subsno].value;
		 document.forms[0].selsubfac_fitl_acc.value=document.forms[0].elements["hid_sel_subfac_fitlacc"+sno+subsno].value;
		 document.forms[0].hid_str_rsAcc_sub.value=document.forms[0].elements["hid_sel_subfac_RestrFrom"+sno+subsno].value;
		 document.forms[0].hidsubfacilityCode.value=document.forms[0].elements["hid_sub_facility_code"+sno+subsno].value;
		 document.forms[0].hidsubfacilityCode1.value=document.forms[0].elements["hid_sub_facility_code"+sno+subsno].value;
		 document.forms[0].sel_restr_conversionfac_sub.value=document.forms[0].elements["hid_selconversionfac_sub"+sno+subsno].value;
		 document.forms[0].sel_restr_addfunding_sub.value=document.forms[0].elements["hid_seladdfunding_sub"+sno+subsno].value;
		 document.forms[0].txt_sub_LeadBank.value=document.forms[0].elements["hid_leadbankname_sub"+sno+subsno].value;
		 document.forms[0].hid_sub_Bankcode.value=document.forms[0].elements["hid_leadbankcode_sub"+sno+subsno].value;
		 document.forms[0].txt_LeadBank.value=document.forms[0].elements["hid_leadbankname"+subsno+"0"].value;
		 document.forms[0].hid_Bankcode.value=document.forms[0].elements["hid_leadbankcode"+subsno+"0"].value;
		 document.forms[0].hidSubPStermsSelected.value=document.forms[0].elements["hid_psterms_sub"+sno+subsno].value;
		 document.forms[0].hidPStermsSelected.value=document.forms[0].elements["hid_psterms"+subsno+"0"].value;
		 varbankschemecode= document.forms[0].elements["hidBankschemecode"+sno].value;
		 document.all.idreview.style.display="none";
		 document.all.idreviewsub.style.display="none";
		var varPSterms1 =document.forms[0].hidPStermsSelected.value.split("@");
		var varPStermssub =document.forms[0].hidSubPStermsSelected.value.split("@");
		for(var i=0;i<varPSterms1.length;i++)
		{
			if(varPSterms1[i] == "REODWC")
			{
				document.all.idreview.style.display="table-row";
			}
		}
		for(var i=0;i<varPStermssub.length;i++)
		{
			if(varPStermssub[i] == "REODWC")
			{
				document.all.idreviewsub.style.display="table-row";
			}
		}
		 
		 document.forms[0].hidSubComFactype.value=document.forms[0].elements["hid_subcomfacloantype"+sno+subsno].value;
		 document.forms[0].hidsubComFactypeOld.value=document.forms[0].elements["hid_subcomfacloantype"+sno+subsno].value;
		 document.forms[0].hidComFactype.value=document.forms[0].elements["hid_comfacloantype"+subsno+"0"].value;
		 document.forms[0].hidComFactypeOld.value=document.forms[0].elements["hid_comfacloantype"+subsno+"0"].value;
		 
		 document.forms[0].hidSubFacExLimit.value=document.forms[0].elements["hid_subfacexloanamt"+sno+subsno].value;
		 document.forms[0].hidFacExLimit.value=document.forms[0].elements["hid_facexloanamt"+subsno+"0"].value;
		 
		 document.forms[0].hidSubFacExTenor.value=document.forms[0].elements["hid_subfacexloanperiod"+sno+subsno].value;
		 document.forms[0].hidFacExTenor.value=document.forms[0].elements["hid_facexloanperiod"+subsno+"0"].value;

		 document.forms[0].sel_restr_scheme_sub.value=document.forms[0].elements["hid_subfacrestrscheme"+sno+subsno].value;
		 document.forms[0].sel_restr_scheme.value=document.forms[0].elements["hid_facrestrscheme"+subsno+"0"].value;

		 document.forms[0].hidfacreattachsub.value=document.forms[0].elements["hid_subreattachflag"+sno+subsno].value;
		 document.forms[0].hidfacreattach.value=document.forms[0].elements["hid_reattachflag"+subsno+"0"].value;
		 
		 document.forms[0].txt_submetlifeinsurance.value=document.forms[0].elements["hid_submetlifeinsurance"+sno+subsno].value;
		 document.forms[0].txt_metlifeinsurance.value=document.forms[0].elements["hid_metlifeinsurance"+subsno+"0"].value;

		 document.forms[0].txt_cgtmse.value=document.forms[0].elements["hid_cgtmse"+subsno+"0"].value;
		 document.forms[0].txt_cgtmsesub.value=document.forms[0].elements["hid_cgtmsesub"+sno+subsno].value;
		 document.forms[0].cgtmse_app.value=document.forms[0].elements["hid_fac_wht_cgtmse"+subsno+"0"].value;
		 document.forms[0].cgtmse_appsub.value=document.forms[0].elements["hid_fac_wht_cgtmsesub"+sno+subsno].value;
		// document.forms[0].sel_cg_fee.value=document.forms[0].elements["hid_fac_cg_split_intrate"+subsno+"0"].value;
		// document.forms[0].sel_cg_feesub.value=document.forms[0].elements["hid_fac_cg_split_intratesub"+sno+subsno].value;
		// document.forms[0].txt_cg_int_rate.value=document.forms[0].elements["hid_fac_cg_tot_intrate"+subsno+"0"].value;
		 //document.forms[0].txt_cg_int_ratesub.value=document.forms[0].elements["hid_fac_cg_tot_intratesub"+sno+subsno].value;
		 
		 document.forms[0].txt_coverenddate.value=document.forms[0].elements["hid_fac_coverenddate"+subsno+"0"].value;
		 document.forms[0].txt_coverenddatesub.value=document.forms[0].elements["hid_fac_coverenddatesub"+sno+subsno].value;
		 
		 <%if(facility_type.equalsIgnoreCase("S")) {%>
		 funenablesubfitl();
		 changeCEFAFsub();
		funacctselsub();
		 <%}%>
		 callLeaderBank();
		 
		 var varFacExiLimit=document.forms[0].txt_subexist_limit.value;
	     callsubduedate(document.forms[0].hidSubComFactype.value); 

	     document.forms[0].selsubadhoclimit.value=document.forms[0].elements["txtsubcategory"+sno+subsno].value;
		 document.forms[0].seladhoclimit.value=document.forms[0].elements["txtcategory"+subsno+"0"].value;

		 //document.forms[0].selsubadhocof.value=document.forms[0].elements["hid_subadhocfacfor"+sno+subsno].value;
		 //document.forms[0].seladhocof.value=document.forms[0].elements["hid_adhocfacfor"+subsno+"0"].value;

		 
	     calladhoc('N');
	     callsubadhoc('N'); 

	     document.forms[0].selsubadhocof.value=document.forms[0].elements["hid_subadhocfacfor"+sno+subsno].value;
		 document.forms[0].seladhocof.value=document.forms[0].elements["hid_adhocfacfor"+subsno+"0"].value;
		 document.forms[0].hidAdhocchk.value=document.forms[0].elements["hid_subadhocchk"+sno+subsno].value;
	     document.forms[0].hidadhocDesc.value=document.forms[0].elements["hid_subadhocdesc"+sno+subsno].value;
	     document.forms[0].hidAdhocsno.value=document.forms[0].elements["hid_subadhocsno"+sno+subsno].value;
	    // document.forms[0].txt_Limit.value=parseFloat(document.forms[0].txt_totalLimit.value)-parseFloat(document.forms[0].txt_subproposed_limit.value);

		     //sub-limits
	var FacsubACCOUNTOPEN=document.forms[0].elements["hidsubFacACCOUNTOPEN"+sno+subsno].value;
	document.forms[0].txt_accountopenflagsub.value=FacsubACCOUNTOPEN;
	var ComsubFactype=document.forms[0].hidSubComFactype.value;
	if(FacsubACCOUNTOPEN=="Y" && (ComsubFactype=="TL"))
	{
		document.all.idsubschemecode.style.visibility="visible";
    	document.all.idsubschemecode.style.position="relative";
    	document.forms[0].txt_subschemecode.value=document.forms[0].elements["hidsubFACILITY_EMISCHEME"+sno+subsno].value;
	}
	else
	{
		document.all.idsubschemecode.style.visibility="hidden";
    	document.all.idsubschemecode.style.position="absolute";
    	//document.forms[0].txt_schemecode.value=documenst.forms[0].elements["hidFACILITY_EMISCHEME"+sno+subsno].value;
	}

	document.forms[0].txtsharetype.value=document.forms[0].elements["hid_sharetype"+subsno+"0"].value;
	document.forms[0].txtsharetypesub.value=document.forms[0].elements["hid_sharetypesub"+sno+subsno].value;
	document.forms[0].txtMISFlag.value=document.forms[0].elements["hidMISFlag"+subsno+"0"].value;
	document.forms[0].txtMISFlagsub.value=document.forms[0].elements["hidMISFlagsub"+sno+subsno].value;
	
	document.forms[0].hidROI.value=document.forms[0].elements["hidROIType"+subsno+"0"].value;
	document.forms[0].hidROISub.value=document.forms[0].elements["hidROITypesub"+sno+subsno].value;


	document.forms[0].sel_Processed_Type.value=document.forms[0].elements["hidCompanyName"+subsno+"0"].value;
	processedType('facility','N');
	document.forms[0].sel_Processed_Type_sub.value=document.forms[0].elements["hidCompanyNameSub"+sno+subsno].value;
	processedType('sub','N')

	document.forms[0].txt_premium_tenor.value=document.forms[0].elements["hidPremiumTenor"+subsno+"0"].value;
	document.forms[0].txt_premium_tenor_sub.value=document.forms[0].elements["hidPremiumTenorSub"+sno+subsno].value;

	document.forms[0].txt_premium_loan_amt.value=document.forms[0].elements["hidPremiumLoanAmount"+subsno+"0"].value;
	document.forms[0].txt_premium_loan_amt_sub.value=document.forms[0].elements["hidPremiumLoanAmountSub"+sno+subsno].value;

	document.forms[0].txt_premium_Account_no.value=document.forms[0].elements["hidPremiumInsAccountNo"+subsno+"0"].value;
	document.forms[0].txt_premium_Account_no_sub.value=document.forms[0].elements["hidPremiumInsAccountNoSub"+sno+subsno].value;


	document.forms[0].sel_Funded_Comp_Name.value=document.forms[0].elements["hidPremiumConpanyName"+subsno+"0"].value;
	document.forms[0].sel_Funded_Sub_Comp_Name.value=document.forms[0].elements["hidPremiumConpanyNameSub"+sno+subsno].value;

	document.forms[0].sel_margin.value=document.forms[0].elements["hidMarginRelaxReq"+subsno+"0"].value;
	document.forms[0].sel_marginsub.value=document.forms[0].elements["hidMarginRelaxReqSub"+sno+subsno].value;

	enablemargin('M');
	enablemargin('S');

	document.forms[0].sel_definedmargin.value=document.forms[0].elements["hidActualMargin"+subsno+"0"].value;
	document.forms[0].sel_definedmarginsub.value=document.forms[0].elements["hidActualMarginSub"+sno+subsno].value;

	document.forms[0].sel_relaxedmargin.value=document.forms[0].elements["hidRelaxedMargin"+subsno+"0"].value;
	document.forms[0].sel_relaxedmarginsub.value=document.forms[0].elements["hidRelaxedMarginSub"+sno+subsno].value;

	document.forms[0].hidintdefer_acc.value=document.forms[0].elements["hidintDeferment"+subsno+"0"].value;
	document.forms[0].hidintdefer_accsub.value=document.forms[0].elements["hidintDefermentSub"+sno+subsno].value;

	document.forms[0].txt_reviewdate.value=document.forms[0].elements["hidReviewDate"+subsno+"0"].value;
	document.forms[0].txt_subreviewdate.value=document.forms[0].elements["hidReviewDateSub"+sno+subsno].value;
	
	//enableintDerferment();
	
	if(document.forms[0].txtsharetypesub.value=="D")
	{
		document.forms[0].hidDematLimitAvailed1.value=document.forms[0].hidDematLimitAvailed.value;
		document.forms[0].hidDematLimitAvailed1.value=eval(document.forms[0].hidDematLimitAvailed1.value)-eval(document.forms[0].txt_subproposed_limit.value);
	}
	else if(document.forms[0].txtsharetypesub.value=="P")
	{
		document.forms[0].hidPhysicalLimitAvailed1.value=document.forms[0].hidPhysicalLimitAvailed.value;
		document.forms[0].hidPhysicalLimitAvailed1.value=eval(document.forms[0].hidPhysicalLimitAvailed1.value)-eval(document.forms[0].txt_subproposed_limit.value);
	}
	varbankschemecode= document.forms[0].elements["hidBankschemecode"+sno].value;
	//alert(varbankschemecode);
	if(varbankschemecode=="069" || varbankschemecode=="69")
	{
		 document.getElementById("ncgtc_button").style.visibility="visible";
		 document.getElementById("ncgtc_button").style.position="relative";
		 document.getElementById("chkliskdoc").style.visibility="hidden";
		 document.getElementById("chkliskdoc").style.position="absolute";
	}
	else
	{
		 document.getElementById("ncgtc_button").style.visibility="hidden";
		 document.getElementById("ncgtc_button").style.position="absolute";
		 document.getElementById("chkliskdoc").style.visibility="Visible";
		 document.getElementById("chkliskdoc").style.position="relative";
	} //vindhya
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
	if(varbankschemecode=="074")		
		{
		document.getElementById("eNWR_button").style.visibility="visible";
		 document.getElementById("eNWR_button").style.position="relative";
		}
	else
		{
		document.getElementById("eNWR_button").style.visibility="hidden";
		 document.getElementById("eNWR_button").style.position="absolute";
		}
	<%}%>
	
	}
	else
	{	
		
			var varExiLimit=document.forms[0].elements["txtexist"+sno+subsno].value;
			//callcbsaccountno();
		  	strheadid = document.facility.elements["txtheadid"+sno].value;
		  	strfacid = document.facility.elements["txtfacid"+sno].value;
		  	//added by bhaskar for new facility head
		  	document.forms[0].facility_head_id_code.value=strheadid;
		  	document.forms[0].facility_id_code.value=strfacid;
		  	document.forms[0].facility_OldCode.value=strfacid;
		  	document.forms[0].facilitydescnew.value=document.forms[0].elements["strfacDescNew"+sno+subsno].value;
		  	document.forms[0].facilitydescnew.title=document.forms[0].elements["strfacDescNew"+sno+subsno].value;		  	
		  	//end
		  	 var varbankschemecode= document.forms[0].elements["hidBankschemecode"+sno].value;
		  	//alert(varbankschemecode); 		  	
			if(varbankschemecode=="069" || varbankschemecode=="69")
			{
				 document.getElementById("ncgtc_button").style.visibility="visible";
				 document.getElementById("ncgtc_button").style.position="relative";
				 document.getElementById("chkliskdoc").style.visibility="hidden";
				 document.getElementById("chkliskdoc").style.position="absolute";
			}
			else
			{
				 document.getElementById("ncgtc_button").style.visibility="hidden";
				 document.getElementById("ncgtc_button").style.position="absolute";
				 document.getElementById("chkliskdoc").style.visibility="Visible";
				 document.getElementById("chkliskdoc").style.position="relative";
			}
			<%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
		  	if(varbankschemecode=="074")		  	
			{
			document.getElementById("eNWR_button").style.visibility="visible";
			 document.getElementById("eNWR_button").style.position="relative";
			}
		else
			{
			document.getElementById("eNWR_button").style.visibility="hidden";
			 document.getElementById("eNWR_button").style.position="absolute";
			}
		  	<%}%>
		
		  	document.forms[0].subfacility_head.selectedIndex=0;
		  	document.forms[0].subfacility.length=1;
		  	document.forms[0].subfacility.selectedIndex=1;
		  	document.forms[0].selsno.value = document.forms[0].elements["txtsno"+sno].value;
		  	document.forms[0].txt_desc.value=document.forms[0].elements["txtdesc"+sno+subsno].value; 
		  	document.forms[0].txt_renewaljustif.value=document.forms[0].elements["hidRenewalJustif"+sno+subsno].value; 
		  document.forms[0].sel_ECSBankName.value=document.forms[0].elements["hidecsbankname"+sno+subsno].value; 
		  	document.forms[0].sel_ECSaccnttype.value=document.forms[0].elements["hidecsaccounttype"+sno+subsno].value; 
		  	document.forms[0].txt_ECSifsccode.value=document.forms[0].elements["hidecsifsccode"+sno+subsno].value; 
		  	document.forms[0].txt_ECSoperaccno.value=document.forms[0].elements["hidecsoperaccnum"+sno+subsno].value; 
		  	document.forms[0].sel_ECSauthmode.value=document.forms[0].elements["hidecsauthmode"+sno+subsno].value; 
		  	document.forms[0].txt_exist_limit.value=document.forms[0].elements["txtexist"+sno+subsno].value; 
		  	document.forms[0].txt_proposed_limit.value=document.forms[0].elements["txtproposed"+sno+subsno].value;
		  	document.forms[0].txt_proposed_limit_old.value=document.forms[0].elements["txtproposed"+sno+subsno].value;
		  	document.forms[0].facility_nature.value=document.forms[0].elements["txtfacnature"+sno+subsno].value;
		  	
		  	document.forms[0].hidproposed.value=document.forms[0].elements["txtproposed"+sno+subsno].value;	              
		    document.forms[0].prd_intrate.value=document.forms[0].elements["txtbplr"+sno+subsno].value;		    
		   // document.forms[0].txt_intremarks.value=document.forms[0].elements["txtintremarks"+sno+subsno].value;	
		    document.forms[0].txt_facmonths.value=document.forms[0].elements["txtmonths"+sno+subsno].value;	
		    document.forms[0].hid_facmonths.value=document.forms[0].elements["txtmonths"+sno+subsno].value;	
		    document.forms[0].txt_purpose.value=document.forms[0].elements["txtpurpose"+sno+subsno].value;		   
		    document.forms[0].sel_propbanktype.value=document.forms[0].elements["selpropbanktype"+sno+subsno].value;
		    //added by bhaskar
		     document.forms[0].sel_inttype.value=document.forms[0].elements["selinttype"+sno+subsno].value;
		     if(document.forms[0].sel_inttype.value=="Flo" && varAppType!="P")
				{
					document.all.iddesc.style.display="inline";
				}
				else
				{
					document.all.iddesc.style.display="none";
				}
		     document.forms[0].sel_intsutype.value=document.forms[0].elements["selintsubtypefac"+sno+subsno].value;
		     
		    /* if(document.forms[0].sel_intsutype.value=="FTBR")
				{
					document.all.idmainmibordate.style.visibility="visible";
					document.all.idmainmibordate.style.position="relative";
					document.all.idmainmibordate1.style.visibility="visible";
					document.all.idmainmibordate1.style.position="relative";
					document.all.idmainmibortenor.style.visibility="visible";
					document.all.idmainmibortenor.style.position="relative";
					document.all.idmainmibortenor1.style.visibility="visible";
					document.all.idmainmibortenor1.style.position="relative";
				
				document.forms[0].txtmianDate.value= document.forms[0].elements["fbildate"+sno+subsno].value;
				document.forms[0].Tenormibormain.value= document.forms[0].elements["fbiltenor"+sno+subsno].value;
				
				}
			else
				{
				
				document.all.idmainmibordate.style.visibility="hidden";
				document.all.idmainmibordate.style.position="absolute";
				document.all.idmainmibordate1.style.visibility="hidden";
				document.all.idmainmibordate1.style.position="absolute";
				document.all.idmainmibortenor.style.visibility="hidden";
				document.all.idmainmibortenor.style.position="absolute";
				document.all.idmainmibortenor1.style.visibility="hidden";
				document.all.idmainmibortenor1.style.position="absolute";
				document.forms[0].txtmianDate.value= document.forms[0].elements["fbildate"+sno+subsno].value;
				document.forms[0].Tenormibormain.value= document.forms[0].elements["fbiltenor"+sno+subsno].value;
				}*/
		     document.forms[0].sel_repaytype.value=document.forms[0].elements["selrepaytype"+sno+subsno].value;
		     document.forms[0].selectgovtmain.value=document.forms[0].elements["selgovtscheme"+sno+subsno].value;
		     document.forms[0].txt_freshlimitmain.value=document.forms[0].elements["hidFreshLimitmain"+sno+subsno].value;
		     document.forms[0].sel_peridicityfac.value=document.forms[0].elements["selperinstalfac"+sno+subsno].value;
		     
		     document.forms[0].hidIntIdFac.value=document.forms[0].elements["selIntIdFac"+sno+subsno].value;
		     document.forms[0].hidBaseRateFac.value=document.forms[0].elements["selFacBaseRate"+sno+subsno].value;

		     //document.forms[0].txt_remarks.value=document.forms[0].elements["selremarks"+sno+subsno].value;

		     document.forms[0].txt_installments.value=document.forms[0].elements["selhoidayperiod"+sno+subsno].value;
		     document.forms[0].hid_installments.value=document.forms[0].elements["selhoidayperiod"+sno+subsno].value;
		     moratperiod('N');
		     if(document.forms[0].elements["selhoidayperiod"+sno+subsno].value!="0")
		     {
		    	 document.forms[0].interestservised.value=document.forms[0].elements["selintereceived"+sno+subsno].value;
		    	 document.forms[0].sel_interestcharge.value=document.forms[0].elements["selinterestcharged"+sno+subsno].value;

		     }		     
		     document.forms[0].txt_margin.value=document.forms[0].elements["selmargin"+sno+subsno].value;
		     document.forms[0].txtcbsaccno.value=document.forms[0].elements["hidcbsaccno"+sno+subsno].value;
		    // for OAN 
		    document.forms[0].selmodepayment.value=document.forms[0].elements["selmodepay"+sno+subsno].value;
		     selOperative('facility');
		    if(document.forms[0].elements["selmodepay"+sno+subsno].value=="E")
		     {
		    	 document.forms[0].txt_operativeaccno.value=document.forms[0].elements["seloperaccno"+sno+subsno].value;  

		     }
		     document.forms[0].sel_fac_desc.value=document.forms[0].elements["hid_sel_fac_desc"+sno+subsno].value;
		     if(document.forms[0].sel_fac_desc.value=="2")
	         {
	                document.all.idex.style.display="table-row";

	                var varPropNo=document.forms[0].elements["hidExPropSno"+sno+subsno].value;
	                var varPropSNo=document.forms[0].elements["hidExPropno"+sno+subsno].value;
	                var varPropAmt=document.forms[0].elements["hidExPropSancAmt"+sno+subsno].value;
	                if(varPropNo!="")
	                {
	                    var varDesc="";
	                    var varArr1=varPropNo.split("~");
	                    var varArr2=varPropSNo.split("~");
	                    var varArr3=varPropAmt.split("~");

	                    for(var i=0;i<varArr1.length-1;i++)
	                    {
	                    	varDesc=varDesc+varArr1[i]+" - "+varArr2[i]+" [Rs:"+varArr3[i]+"] \n";
	                    }
	                    document.all.idex1.innerText=varDesc;
	                }
	                else
	                {
	                	document.all.idex1.innerText=document.forms[0].elements["hidExPropSno"+sno+subsno].value+" - "+document.forms[0].elements["hidExPropno"+sno+subsno].value+"[Rs:"+document.forms[0].elements["hidExPropSancAmt"+sno+subsno].value+"]";  
	                }
	                
	                document.all.idex2.innerText=document.forms[0].elements["hidExPropAccno"+sno+subsno].value;
	                document.all.idex3.innerText=document.forms[0].elements["hidExLimitType"+sno+subsno].value;


	                if(document.forms[0].txt_exist_limit.value!=document.forms[0].txt_proposed_limit.value)
					{
						document.all.renewal_justif.style.display="table-row"; 
					}
	         }
             else
             {
            	document.all.idex.style.display="none"; 
            	document.all.idex1.innerTextL="";
                document.all.idex2.innerText="";
				document.all.renewal_justif.style.display="none"; 
             }
		     document.forms[0].txt_agency.value=document.forms[0].elements["strFacAgency"+sno+subsno].value;
		     document.forms[0].txt_duedate.value=document.forms[0].elements["strduedate"+sno+subsno].value;	     
		     document.forms[0].sel_displaydesc.value=document.forms[0].elements["strdisplaydesc"+sno+subsno].value;
		     getFacDescription(document.forms[0].elements["strdisplaydesc"+sno+subsno].value,document.forms[0].elements["hid_facility_code"+sno+subsno].value);
		     document.forms[0].txt_fac_type.value=document.forms[0].elements["hid_sel_fac_type"+sno+subsno].value;	
		     if(document.forms[0].facility_nature.value=="2")
		     {
			     if(document.forms[0].sel_Tuf) {
			     document.forms[0].sel_Tuf.value=document.forms[0].elements["txtTUF"+sno+subsno].value;
			     }
		     }
		     if(varstrSessionModuleType=="AGR")
				{
					if(document.forms[0].elements["hid_strAgrSchemeType"+sno+subsno].value!="")
					{
						
						document.forms[0].sel_schemetype.value=document.forms[0].elements["hid_strAgrSchemeType"+sno+subsno].value;
					}
					else
					{
						document.forms[0].sel_schemetype.value="0";
					}
				}

		     var varSelFacCode=document.forms[0].elements["selfaccode"+sno+subsno].value;
		     

		   
		     
		      document.forms[0].facilitydesc.value=document.forms[0].elements["selfaccode"+sno+subsno].value;
		      if(document.forms[0].facilitydesc.value!="")
		      {
			      var varFac=document.forms[0].facilitydesc.value.split("-");
			      var varTemp="";
			      for(var i=0;i<varFac.length;i++)
			      {
				      if(i<6)
				      {
				    	  if(varTemp=="")
				    		  varTemp=varFac[i];
				    	  else
				    		  varTemp=varTemp+"-"+varFac[i];
				      }
			      }

			      document.forms[0].facilitydesc.value=varTemp;
			      
		      }
		      

		    

		   
		     if(document.forms[0].elements["selgovtscheme"+sno+subsno].value=="1")
		     {
		    	document.all.s5m.style.visibility="visible";
		 	    document.all.s5m.style.position="relative";	
		 	    	
		 	    document.all.s6m.style.visibility="visible";
		 	    document.all.s6m.style.position="relative";
		 	    
		     	document.all.s1m.style.visibility="visible";
		     	document.all.s1m.style.position="relative";
		     		
		     	document.all.s2m.style.visibility="visible";
		     	document.all.s2m.style.position="relative";	
		     	
		     	document.all.s3m.style.visibility="visible";
		     	document.all.s3m.style.position="relative";

		     	document.forms[0].schemetypemain.value=document.forms[0].elements["selschemetype"+sno+subsno].value;
		     	document.forms[0].sel_sponser_agencymain.value=document.forms[0].elements["selsponsagency"+sno+subsno].value;
		     	document.forms[0].sel_subsidytypemain.value=document.forms[0].elements["selsubsidytype"+sno+subsno].value;
		     	document.forms[0].submainamnt.value=document.forms[0].elements["txtsubsidyamunt"+sno+subsno].value;		     	
		     } 
		     else
		     {

		        document.all.s5m.style.visibility="hidden";
		     	document.all.s5m.style.position="absolute";
		     	
		     	document.all.s6m.style.visibility="hidden";
		     	document.all.s6m.style.position="absolute";
		     		
		     	document.all.s1m.style.visibility="hidden";
		     	document.all.s1m.style.position="absolute";
		     		
		     	document.all.s2m.style.visibility="hidden";
		     	document.all.s2m.style.position="absolute";
		     		
		     	document.all.s3m.style.visibility="hidden";	
		     	document.all.s3m.style.position="absolute";

		     }
		     
		     //Mahesh for showing or hiding the Name of the Agency
		      if((trim(document.forms[0].selectgovtmain.value)=="1") && (trim(document.forms[0].sel_sponser_agencymain.value)=="OTHERS"))
			     {
			    	 document.all.s4m.style.display="table-row";
			     }
			     else
			     {
			    	 document.all.s4m.style.display="none";
			    }

		      		document.forms[0].selfac_restr_acc.value=document.forms[0].elements["hid_sel_fac_restracc"+sno+subsno].value;
				 	document.forms[0].selfac_fitl_acc.value=document.forms[0].elements["hid_sel_fac_fitlacc"+sno+subsno].value;
				 	document.forms[0].hid_str_rsAcc.value=document.forms[0].elements["hid_sel_fac_RestrFrom"+sno+subsno].value;
				 	document.forms[0].hidfacilityCode.value=document.forms[0].elements["hid_facility_code"+sno+subsno].value;
				 	document.forms[0].hidfacilityCode1.value=document.forms[0].elements["hid_facility_code"+sno+subsno].value;
				 	document.forms[0].sel_restr_conversionfac.value=document.forms[0].elements["hid_selconversionfac"+sno+subsno].value;
				 	document.forms[0].sel_restr_addfunding.value=document.forms[0].elements["hid_seladdfunding"+sno+subsno].value;
				 	document.forms[0].hid_Bankcode.value=document.forms[0].elements["hid_leadbankcode"+sno+subsno].value;
				 	document.forms[0].txt_LeadBank.value=document.forms[0].elements["hid_leadbankname"+sno+subsno].value;
				 	document.forms[0].hidPStermsSelected.value=document.forms[0].elements["hid_psterms"+sno+subsno].value;
				 	document.forms[0].hidComFactype.value=document.forms[0].elements["hid_comfacloantype"+sno+subsno].value;
				 	document.forms[0].hidComFactypeOld.value=document.forms[0].elements["hid_comfacloantype"+sno+subsno].value;

				 	document.all.idreview.style.display="none";
					var varPSterms1 =document.forms[0].hidPStermsSelected.value.split("@");
					for(var i=0;i<varPSterms1.length;i++)
					{
						if(varPSterms1[i] == "REODWC")
						{
							document.all.idreview.style.display="table-row";
						}
					}

					 document.forms[0].hidFacExLimit.value=document.forms[0].elements["hid_facexloanamt"+sno+subsno].value;
					 document.forms[0].hidFacExTenor.value=document.forms[0].elements["hid_facexloanperiod"+sno+subsno].value;
					 document.forms[0].sel_restr_scheme.value=document.forms[0].elements["hid_facrestrscheme"+sno+subsno].value;
					 document.forms[0].hidfacreattach.value=document.forms[0].elements["hid_reattachflag"+sno+subsno].value;
					 document.forms[0].txt_metlifeinsurance.value=document.forms[0].elements["hid_metlifeinsurance"+sno+subsno].value;

					 document.forms[0].txt_cgtmse.value=document.forms[0].elements["hid_cgtmse"+sno+subsno].value;
					 document.forms[0].cgtmse_app.value=document.forms[0].elements["hid_fac_wht_cgtmse"+sno+subsno].value;
					// document.forms[0].sel_cg_fee.value=document.forms[0].elements["hid_fac_cg_split_intrate"+sno+subsno].value;
					// document.forms[0].txt_cg_int_rate.value=document.forms[0].elements["hid_fac_cg_tot_intrate"+sno+subsno].value;
					 document.forms[0].txt_coverenddate.value=document.forms[0].elements["hid_fac_coverenddate"+sno+subsno].value;
					 
					strname= document.forms[0].cgtmse_app.value;
					 	 
				 	<%if(facility_type.equalsIgnoreCase("S")) {%>
				 	funenablefitl();
				 	changeCEFAF();
				 	funacctsel();
				 	<%}%>
				 	callLeaderBank();
		  	//End   
		    //ended	
			document.forms[0].txt_subdesc.value="";
			document.forms[0].txt_subexist_limit.value="";
			document.forms[0].txt_subproposed_limit.value="";
			//document.forms[0].txt_submargin.value="";
			//document.forms[0].txt_subinterest.value="";
			document.forms[0].prd_subintrate.value="";		
			//document.forms[0].txt_subintremarks.value="";
			document.forms[0].txt_subfacmonths.value="";
			document.forms[0].txt_subpurpose.value="";
			document.forms[0].factype.value = "facility";
			document.forms[0].checkbox.checked=false;			
			document.forms[0].sel_sub_propbanktype.value="";	
			document.forms[0].sel_sub_inttype.value="0";
			document.forms[0].sel_sub_repaytype.value="0";
			document.forms[0].facilitydescsub.value="";	
			document.forms[0].sel_peridicityfacsub.value="s";
			document.forms[0].sel_intsufacsubtype.value="0";
			document.forms[0].selsubfac_restr_acc.value="";
			document.forms[0].selsubfac_fitl_acc.value="";
			var varFacExiLimit=document.forms[0].txt_exist_limit.value;
			callduedate(document.forms[0].hidComFactype.value);  
			document.forms[0].seladhoclimit.value=document.forms[0].elements["txtcategory"+sno+subsno].value;
			calladhoc('N');

			document.forms[0].hidAdhocchk.value=document.forms[0].elements["hid_adhocchk"+sno+subsno].value;
		    document.forms[0].hidadhocDesc.value=document.forms[0].elements["hid_adhocdesc"+sno+subsno].value;
		    document.forms[0].hidAdhocsno.value=document.forms[0].elements["hid_adhocsno"+sno+subsno].value;

		    document.forms[0].txt_Limit.value=parseFloat(document.forms[0].txt_totalLimit.value)-parseFloat(document.forms[0].txt_proposed_limit.value);

		  //main facility
			var FacACCOUNTOPEN=document.forms[0].elements["hidFacACCOUNTOPEN"+sno+subsno].value;
			document.forms[0].txt_accountopenflag.value=FacACCOUNTOPEN;
			var ComFactype=document.forms[0].hidComFactype.value;
			if(FacACCOUNTOPEN=="Y" && (ComFactype=="TL"))
			{
				document.all.idschemecode.style.visibility="visible";
		    	document.all.idschemecode.style.position="relative";
		    	document.forms[0].txt_schemecode.value=document.forms[0].elements["hidFACILITY_EMISCHEME"+sno+subsno].value;
			}
			else
			{
				document.all.idschemecode.style.visibility="hidden";
		    	document.all.idschemecode.style.position="absolute";
		    	//document.forms[0].txt_schemecode.value=document.forms[0].elements["hidFACILITY_EMISCHEME"+sno+subsno].value;
			}

			document.forms[0].txtsharetype.value=document.forms[0].elements["hid_sharetype"+sno+subsno].value;
			document.forms[0].txtMISFlag.value=document.forms[0].elements["hidMISFlag"+sno+subsno].value;
			document.forms[0].hidROI.value=document.forms[0].elements["hidROIType"+sno+subsno].value;
			document.forms[0].sel_Processed_Type.value=document.forms[0].elements["hidCompanyName"+sno+subsno].value;
			processedType('facility','N');
			document.forms[0].txt_premium_tenor.value=document.forms[0].elements["hidPremiumTenor"+sno+subsno].value;
			document.forms[0].txt_premium_loan_amt.value=document.forms[0].elements["hidPremiumLoanAmount"+sno+subsno].value;
			document.forms[0].txt_premium_Account_no.value=document.forms[0].elements["hidPremiumInsAccountNo"+sno+subsno].value;
			document.forms[0].sel_Funded_Comp_Name.value=document.forms[0].elements["hidPremiumConpanyName"+sno+subsno].value;

			document.forms[0].sel_margin.value=document.forms[0].elements["hidMarginRelaxReq"+sno+subsno].value;
			enablemargin('M');
			document.forms[0].sel_definedmargin.value=document.forms[0].elements["hidActualMargin"+sno+subsno].value;
			document.forms[0].sel_relaxedmargin.value=document.forms[0].elements["hidRelaxedMargin"+sno+subsno].value;
			
			document.forms[0].hidintdefer_acc.value=document.forms[0].elements["hidintDeferment"+sno+subsno].value;
			document.forms[0].txt_reviewdate.value=document.forms[0].elements["hidReviewDate"+sno+subsno].value;
			

			if(document.forms[0].txtsharetype.value=="D")
			{
				document.forms[0].hidDematLimitAvailed1.value=document.forms[0].hidDematLimitAvailed.value;
				document.forms[0].hidDematLimitAvailed1.value=eval(document.forms[0].hidDematLimitAvailed1.value)-eval(document.forms[0].txt_proposed_limit.value);
			}
			else if(document.forms[0].txtsharetype.value=="P")
			{
				document.forms[0].hidPhysicalLimitAvailed1.value=document.forms[0].hidPhysicalLimitAvailed.value;
				document.forms[0].hidPhysicalLimitAvailed1.value=eval(document.forms[0].hidPhysicalLimitAvailed1.value)-eval(document.forms[0].txt_proposed_limit.value);
			}
			//enableintDerferment();
			
			
	}
	for(k=0;k<len;k++)
	{
		arr = document.facility.facility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strheadid)
			{
				document.facility.elements["facility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strheadid!="")
	{
		document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strheadid+"&value=subsel&hidMethod=getFacility&factid="+strfacid+"&strtype=facility";
	}
 	for(k=0;k<len;k++)
	{
		arr = document.facility.subfacility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strsubheadid)
			{
				document.facility.elements["subfacility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strsubheadid!="")
	{

		if(!isNaN(strsubheadid))
		{
			document.forms[0].checkbox.checked=true;
		}
		else
		{
			document.forms[0].checkbox.checked=false;
		}
		document.all.ifrm2.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strsubheadid+"&value=subsel&hidMethod=getFacility&factid="+strsubfacid+"&strtype=sublimit";
	}
	else
	{
			document.forms[0].checkbox.checked=false;
	}
	optionsenable();
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		disableCommandButtons("load");
		disableFields(true);
		document.forms[0].hideditflag.value="Y";
	}
	hideCBSaccountno();

	var varfacType="";
	var varfacid="";
	var varrepay="";
	if(document.forms[0].factype.value=="facility")
	{
		varfacType=document.forms[0].factype.value;
		varfacid=document.forms[0].hidfacilityCode.value;
		varrepay=document.forms[0].sel_repaytype.value;
		callrepayfunction(varstrSessionModuleType,varfacType,varfacid,varrepay);

		loadInterestType('facility',document.forms[0].hidROI.value,document.forms[0].hidfacilityCode.value);
	}
	else{
		varfacType="facility";
		varfacid=document.forms[0].hidfacilityCode.value;
		varrepay=document.forms[0].sel_repaytype.value;
		callrepayfunction(varstrSessionModuleType,varfacType,varfacid,varrepay);

		varfacType=document.forms[0].factype.value;
		varfacid=document.forms[0].hidsubfacilityCode.value;
		varrepay=document.forms[0].sel_sub_repaytype.value;
		callrepayfunction(varstrSessionModuleType,varfacType,varfacid,varrepay);

		loadInterestType('facility',document.forms[0].hidROI.value,document.forms[0].hidfacilityCode.value);

		loadInterestType('subfacility',document.forms[0].hidROISub.value,document.forms[0].hidsubfacilityCode.value);
	}
	

	if( document.forms[0].txt_cgtmse.value=="Y")
	{	
			document.getElementById("cgtmse_button").style.visibility="visible";
			document.getElementById("cgtmse_button").style.position="relative";
	}
	if( document.forms[0].txt_cgtmsesub.value=="Y")
	{
		 document.getElementById("cgtmse_button").style.visibility="visible";
		 document.getElementById("cgtmse_button").style.position="relative";
	}
	if((document.forms[0].hidNonPoolFlag.value=="Y")|| (strSecFreezeflag=="Y"))
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}
}

function calleNWR()
{
	var title = "agreNWR";
	var prop = "scrollbars=yes,width=1050,height=600,top=25,left=180";
	var url=appURL+"action/agr_eNWR.jsp?hidBeanId=facilities&hidBeanGetMethod=getagr_eNWR&appno="+document.forms[0].appno.value+"&inwardno="+document.forms[0].txt_appinwardno.value;	
	window.open(url,title,prop);

}

function doSave()
{ 	

	if((document.forms[0].hidnongeclfacchk.value=="Y" && strncgtcbankscheme=="061"))
	{
		alert("If one facility is under KBL GECL type then all other facilities of the proposal should also be in KBL GECL type scheme only ");
		return;	
	}
//alert("document.forms[0].hidGECLType.value"+document.forms[0].hidGECLType.value);
//alert("document.forms[0].hidgecltype.value"+document.forms[0].hidgecltype.value);
//alert("document.forms[0].txt_installments.value"+document.forms[0].txt_installments.value);
//alert("document.forms[0].txt_installments_sub.value"+document.forms[0].txt_installments_sub.value);

	if(document.forms[0].hidGECLType.value=="GECL -3 extension" || document.forms[0].hidgecltype.value=="GECL -3 extension" || 
			 document.forms[0].hidGECLType.value=="GECL -3 extension"||document.forms[0].hidgecltype.value=="GECL -1 Extension" ||
			  document.forms[0].hidgecltype.value=="GECL -2 Extension" ||  document.forms[0].hidgecltype.value=="GECL -3 Extension"
				  ||document.forms[0].hidgecltype.value=="GECL -1 extension" ||
				  document.forms[0].hidgecltype.value=="GECL -2 extension" ||  document.forms[0].hidgecltype.value=="GECL -3 extension"
					  ||document.forms[0].hidGECLType.value=="GECL -1 extension" || document.forms[0].hidGECLType.value=="GECL -2 extension")
	{
		//alert("1");
		//facilitydesc
		if(document.forms[0].txt_installments.value=="0"  ||  document.forms[0].txt_installments.value=="")
		{
			//alert("2");
			alert("Minimum holiday  period  should be 1 for GECL -1 Extension,GECL -2 Extension, and GECL -3 Extension Proposals");
			document.forms[0].txt_installments.focus();
		return;	
		}
	
	}
	
	var prop =0,sno=0,subsno=0;
	var sublimit=0;
	var exis=0;
	var exssublimit=0;
	var factype=document.forms[0].factype.value;
	checktenor();
	if(!isNaN(document.forms[0].selsno.value))
	{
		sno = parseInt(document.forms[0].selsno.value);
	}
	if(!isNaN(document.forms[0].selsubsno.value))
	{
		subsno = parseFloat(document.forms[0].selsubsno.value);
	}
	if(!sno)
	{
		sno=0;
	}
	if(!subsno)
	{
		subsno=0;
	}
	if(!isNaN(document.forms[0].txt_proposed_limit.value))
	{
		prop = parseFloat(document.forms[0].txt_proposed_limit.value);
	}
	if(!prop)
	{
		prop=0.00;
	}
	if(!isNaN(document.forms[0].txt_subproposed_limit.value))
	{
		sublimit = parseFloat(document.forms[0].txt_subproposed_limit.value);
	}
	if(!sublimit)
	{
		sublimit=0.00;
	}
	if(document.forms[0].sel_fac_desc.value=="2") 
	{
		if(!isNaN(document.forms[0].txt_exist_limit.value))
		{
			exis = parseFloat(document.forms[0].txt_exist_limit.value);
		}
	}
	if(!prop)
	{
		exis=0.00;
	}
	if(document.forms[0].sel_subfac_desc.value=="2")  
	{
		if(!isNaN(document.forms[0].txt_subexist_limit.value))
		{
			exssublimit = parseFloat(document.forms[0].txt_subexist_limit.value);
		}
	}
	if(!sublimit)
	{
		exssublimit=0.00;
	}

	//OD Facility Check for Renewal Proposal
	if(document.forms[0].sel_fac_desc.value=="2")
	{
		if((document.forms[0].hidComFactypeOld.value)!=(document.forms[0].hidComFactype.value))
		{
			if(document.forms[0].hidComFactype.value=="DL")
			{
				alert("Demand Loan facilities only allowed for Renewal. Kindly select Overdraft facility.");
			}
			else if(document.forms[0].hidComFactype.value=="OD")
			{
				alert("Over Draft facilities only allowed for Renewal. Kindly select Overdraft facility.");
			}
			else if(document.forms[0].hidComFactype.value=="TL")
			{
				alert("Term Loan facilities only allowed for Renewal. Kindly select Overdraft facility.");
			}
			return;
		}
	}
	if(document.forms[0].sel_subfac_desc.value=="2")
	{
		if((document.forms[0].hidsubComFactypeOld.value)!=(document.forms[0].hidSubComFactype.value))
		{
			if(document.forms[0].hidSubComFactype.value=="DL")
			{
				alert("Demand Loan facilities only allowed for Renewal. Kindly select Overdraft facility.");
			}
			else if(document.forms[0].hidSubComFactype.value=="OD")
			{
				alert("Over Draft facilities only allowed for Renewal. Kindly select Overdraft facility.");
			}
			else if(document.forms[0].hidSubComFactype.value=="TL")
			{
				alert("Term Loan facilities only allowed for Renewal. Kindly select Overdraft facility.");
			}
			return;
		}
	}
	/*if((document.forms[0].sel_fac_desc.value=="2")&&(factype=="facility") && (document.forms[0].hidComFactype.value!="OD"))
	{
		  alert("Over Draft facilities only allowed for Renewal. Kindly select Overdraft facility.");
		  return;		  
		  	
	}
	if((document.forms[0].sel_subfac_desc.value=="2")&& (factype=="sublimit") && (document.forms[0].hidSubComFactype.value!="OD"))
	{
		alert("Over Draft facilities only allowed for Renewal. Kindly select Overdraft facility.");
		return;
	}*/

	

	if( (factype=="facility") && (document.forms[0].hidfacreattach.value=="Y"))
	{
		  alert("Facility is not Available, Please Reselect any other facility");
		  return;		  
		  	
	}
	if( (factype=="sublimit") && (document.forms[0].hidfacreattachsub.value=="Y"))
	{
		alert("Facility is not Available, Please Reselect any other facility");
		return;
	}

	if(factype=="facility" && document.forms[0].sel_fac_desc.value=="2") 
	{
		if((document.forms[0].txt_exist_limit.value!=document.forms[0].txt_proposed_limit.value) && document.forms[0].txt_renewaljustif.value=="")
		{
			alert("Enter Justification for Enhancement/Reduction");
			document.forms[0].txt_renewaljustif.focus();
			return;
		}
	}
	else if(factype=="sublimit" && document.forms[0].sel_subfac_desc.value=="2") 
	{
		if((document.forms[0].txt_subexist_limit.value!=document.forms[0].txt_subproposed_limit.value) && document.forms[0].txt_renewaljustif_sub.value=="")
		{
			alert("Enter Justification for Enhancement/Reduction");
			document.forms[0].txt_renewaljustif_sub.focus();
			return;
		}
	}
	//==============
	if( (factype=="facility"))
	{
				if(document.forms[0].sel_intsutype.value=="BR" ||document.forms[0].sel_intsutype.value=="BRLEC" )
				{
					alert("Option not applicable");
					document.forms[0].sel_intsutype.value="0";
					return;
				}
	}
	if( (factype=="sublimit"))
	{
		if(document.forms[0].facility_head_id_code.value=="1" && document.forms[0].facility_id_code.value=="44")	
		{
			alert("Sub-limit facility not allowed for Forward Contract Facilities");
			return;
		}
		if(document.forms[0].sel_intsufacsubtype.value=="BR" ||document.forms[0].sel_intsufacsubtype.value=="BRLEC" )
		{
			alert("Option not applicable");
			document.forms[0].sel_intsufacsubtype.value="0";
			return;
		}
	}
	//by gokul.C for the 'sub-limit' proposed limit value
	/***************************************************************
	*Commented by G.Sureshkumar as per the bank's new Cr 
	*the total of sublimit can exceed but only the sublimit amount 
	*should not exceed the main limit 
	*and the logic is added
	*****************************************************************/
	if(exssublimit>exis)
	{
		alert("The Sublimit 'Exisiting limit' exceeds the Parent facility 'Exisiting limit'");
		return;
	}
	if(factype=="sublimit" && document.forms[0].selsubadhoclimit.value=="R")
	{
		if(sublimit>prop)
		{
			alert("The Sublimit 'proposed limit' exceeds the Parent facility 'proposed limit'");
			return;
		}
	}
	if(factype=="sublimit" && document.forms[0].selsubadhoclimit.value=="O")
	{
		if(sublimit>prop)
		{
			alert("The Sublimit 'proposed limit' should not exceeds the Parent facility 'proposed limit'");
			document.forms[0].txt_subproposed_limit.focus();
			return;
		}
	}
	//if(sublimit>prop)
	//{
		//alert("The Sublimit 'proposed limit' exceeds the Parent facility 'proposed limit'");
		//return;
	//}

	
	if(document.forms[0].checkbox.checked==true)
	{
		if(document.forms[0].facilitysub_head_id_code.value=="3" ||
				document.forms[0].facilitysub_head_id_code.value=="4"||document.forms[0].facilitysub_head_id_code.value=="5")
		{
			if(document.forms[0].selsubadhoclimit.value=="A")
			{
				alert("Adhoc Limit is not applicable for this facility category");
				document.forms[0].selsubadhoclimit.disabled=false;
				document.forms[0].selsubadhoclimit.focus();
				return;
			}
		}

		if(document.forms[0].sel_subfac_desc.value!="4" && (document.forms[0].facilitysub_head_id_code.value=="5" && document.forms[0].facilitysub_id_code.value=="97"))
		{
			if(document.forms[0].sel_marginsub.value=="")
			{
				alert("Select Relaxation in margin as per RBI COVID relief Package Policy");
				document.forms[0].sel_marginsub.focus();
				return;
			}
			else if(document.forms[0].sel_definedmarginsub.value=="")
			{
				alert("Select Actual Margin");
				document.forms[0].sel_definedmarginsub.focus();
				return;
			}
			if(document.forms[0].sel_marginsub.value=="Y" && document.forms[0].sel_relaxedmarginsub.value=="")
			{
				alert("Select Relaxed Margin");
				document.forms[0].sel_relaxedmarginsub.focus();
				return;
			}
			if(eval(document.forms[0].sel_relaxedmarginsub.value) > eval(document.forms[0].sel_definedmarginsub.value))
			{
				alert("Relaxed Margin should not be greater than Actual Margin");
				document.forms[0].sel_relaxedmarginsub.value="";
				return;
			}
			
		}	
	}
	else
	{
		if(document.forms[0].facility_head_id_code.value=="3" ||
				document.forms[0].facility_head_id_code.value=="4"||document.forms[0].facility_head_id_code.value=="5")
		{

			if(document.forms[0].seladhoclimit.value=="A")
			{
				alert("Adhoc Limit is not applicable for this facility category");
				document.forms[0].seladhoclimit.disabled=false;
				document.forms[0].seladhoclimit.focus();
				return;
			}
		}

		if(document.forms[0].sel_fac_desc.value!="4" && (document.forms[0].facility_head_id_code.value=="5" && document.forms[0].facility_id_code.value=="97"))
		{
			if(document.forms[0].sel_margin.value=="")
			{
				alert("Select Relaxation in margin as per RBI COVID relief Package Policy");
				document.forms[0].sel_margin.focus();
				return;
			}
			else if(document.forms[0].sel_definedmargin.value=="")
			{
				alert("Select Actual Margin");
				document.forms[0].sel_definedmargin.focus();
				return;
			}
			if(document.forms[0].sel_margin.value=="Y" && document.forms[0].sel_relaxedmargin.value=="")
			{
				alert("Select Relaxed Margin");
				document.forms[0].sel_relaxedmargin.focus();
				return;
			}
			if(eval(document.forms[0].sel_relaxedmargin.value) > eval(document.forms[0].sel_definedmargin.value))
			{
				alert("Relaxed Margin should not be greater than Actual Margin");
				document.forms[0].sel_relaxedmargin.value="";
				return;
			}
		}
	}
	
	var Tenor=0,SubTenor=0;
	if(!isNaN(document.forms[0].txt_facmonths.value))
	{
		Tenor = parseInt(document.forms[0].txt_facmonths.value);
	}
	if(!isNaN(document.forms[0].txt_subfacmonths.value))
	{
		SubTenor = parseFloat(document.forms[0].txt_subfacmonths.value);
	}
	if(!Tenor)
	{
		Tenor=0;
	}
	if(!SubTenor)
	{
		SubTenor=0;
	}

	/*if(factype=="sublimit")
	{
		if(SubTenor>Tenor)
		{
			alert("The Sublimit Repayment Period exceeds the Parent facility Repayment Period");
			return;
		}
	}*/
	var str_rsAcc ="";
	var str_rsAcc_sub ="";
	<%if(facility_type.equalsIgnoreCase("S")) {%>
	for(var i=0;i<document.forms[0].sel_restr_acc.options.length;i++)
	{
		if(document.forms[0].sel_restr_acc.options[i].selected)
		{			
			str_rsAcc=str_rsAcc+document.forms[0].sel_restr_acc.options[i].value+"@";
		}		
	}

	for(var i=0;i<document.forms[0].sel_restr_acc_sub.options.length;i++)
	{
		if(document.forms[0].sel_restr_acc_sub.options[i].selected)
		{			
			str_rsAcc_sub=str_rsAcc_sub+document.forms[0].sel_restr_acc_sub.options[i].value+"@";
		}		
	}
	<%}%>
	document.forms[0].hid_str_rsAcc.value=str_rsAcc;
	document.forms[0].hid_str_rsAcc_sub.value=str_rsAcc_sub;


	
	if(varinwardnorequired=="" && document.forms[0].txt_appinwardno.value=="")
	{
		  ShowAlert(121,'Application No');
		  document.forms[0].txt_appinwardno.focus();
		  return;
	}
	if(document.forms[0].sel_proposalvaluesin.value=="S")
	{
		  ShowAlert(111,'All Values are in');
		  document.forms[0].sel_proposalvaluesin.focus();
		  return;
	}
	/*if(varstrSessionModuleType=="AGR") {
		if(document.forms[0].sel_facilityrequired.value=="S")
		{
			  ShowAlert(111,'Whether Financial Required');
			  document.forms[0].sel_facilityrequired.focus();
			  return;
		}
	}*/
	if(document.forms[0].txt_osdate.value=="")
	{
		  ShowAlert(121,'Details as on');
		  document.forms[0].txt_osdate.focus();
		  return;
	}
   	/*if(document.forms[0].comapp_id.value=="")
	{
		  ShowAlert(111,'Borrower');
	}*/	
	 if( (factype=="facility") && (document.forms[0].facilitydescnew.value==""))
	{
		  ShowAlert(111,'Facility Description');
		  return;		  
		  //document.forms[0].facilitydesc.focus();
		  	
	}
if(varAppType!="P")
{
	if(document.forms[0].selectgovtmain.value=="S")
	{
		ShowAlert(111,'Govt. Sponsor Scheme');
		document.forms[0].selectgovtmain.focus();
		return;
	}

	if(document.forms[0].selectgovtmain.value=="1")
	{
		 
           if(document.forms[0].schemetypemain.value=="0")
			{
				  ShowAlert(111,'Scheme Type');
				  document.forms[0].schemetypemain.focus();
				  return;
			}
			if(document.forms[0].submainamnt.value=="")
			{
				  ShowAlert(121,'Subsidy Amount');
				  document.forms[0].submainamnt.focus();
				  return;
			}
			if(document.forms[0].sel_sponser_agencymain.value=="0")
			{
				  ShowAlert(111,'Sponsor Agency');
				  document.forms[0].sel_sponser_agencymain.focus();
				  return;
			}
			if(document.forms[0].sel_subsidytypemain.value=="0")
			{
				  ShowAlert(111,'Subsidy type');
				  document.forms[0].sel_subsidytypemain.focus();
				  return;
			}
	}
}
	
	
	//Added by Arsath on 01/04/2014 as per the new requirements
	 if( (factype=="facility") && (document.forms[0].sel_fac_desc.value==""))
	{
		  ShowAlert(111,'Type');
		  document.forms[0].sel_fac_desc.focus();
		  return;		  
	}
	//End of Arsath
		
	 if((factype=="facility") && (document.forms[0].txt_proposed_limit.value==""))
	{
		  ShowAlert(121,'Proposed Limit');		  
		  document.forms[0].txt_proposed_limit.focus();
		  return;
	}
	//pan check
	<%if((strSessionModuleType.equalsIgnoreCase("AGR"))||(strSessionModuleType.equalsIgnoreCase("CORP"))){%>
	if((factype=="facility")  && (document.forms[0].txt_proposed_limit.value!=""))
	{
		var pancheck="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>";
		var sanctionlimit="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>";		
		var Pancount="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>";
		var proposedlimit=document.forms[0].txt_proposed_limit.value;	
		var totallimit="0.00";
		
	if(sanctionlimit==""|| sanctionlimit=="NaN")
	{
		sanctionlimit="0.00";
	}
	if(proposedlimit==""|| proposedlimit=="NaN")
	{
		sanctionlimit="0.00";
	}
		if(pancheck=="Y")
		{
			if(eval(proposedlimit)>=sanctionlimit)
			{
				if(Pancount=="N")
				{
					alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+sanctionlimit+"/- and above ");
					
					document.forms[0].txt_proposed_limit.value="";
					document.forms[0].txt_proposed_limit.focus();
					return;
				}
			}
		}
	}
	<%}%>
	//pan check
	 if(varAppType!="P")
	 {
		 if( (factype=="facility") && document.forms[0].txtsharetype.value=="P" && ((eval(document.forms[0].hidPhysicalLimitAvailed1.value)+eval(document.forms[0].txt_proposed_limit.value))>eval(document.forms[0].hidPhysicalLimit.value)))
		{
			 alert("Physical form of loan against share limit exceeds for this borrower.\n You can avail only Rs."+roundVal(eval(document.forms[0].hidPhysicalLimit.value)-eval(document.forms[0].hidPhysicalLimitAvailed1.value)));
			 return;
		}
		 else if( (factype=="facility") && document.forms[0].txtsharetype.value=="D" && ((eval(document.forms[0].hidDematLimitAvailed1.value)+eval(document.forms[0].txt_proposed_limit.value))>eval(document.forms[0].hidDematLimit.value)))
		{
			 alert("Physical form of loan against share limit exceeds for this borrower.\n You can avail only Rs."+roundVal(eval(document.forms[0].hidDematLimit.value)-eval(document.forms[0].hidDematLimitAvailed1.value)));
			 return;
		}
	 }
	 <%if(!facility_type.equalsIgnoreCase("P")) {%>
	 if((factype=="facility") && (eval(document.forms[0].hidinwardAmt.value)<(eval(document.forms[0].txt_proposed_limit.value)+eval(document.forms[0].txt_Limit.value))))
	{
		  alert("Sum of the Proposed Loan Amount should not greater than Loan Requested Limit of LAR");
		  return;
	}
	 /*if((factype=="sublimit") && (eval(document.forms[0].hidinwardAmt.value)<(eval(document.forms[0].txt_subproposed_limit.value)+eval(document.forms[0].txt_Limit.value))))
		{
			  alert("Sum of the Proposed Loan Amount should not greater than Loan Requested Limit of LAR");
			  return;
		}*/
		<%}%>
	 if((factype=="facility") && (document.forms[0].sel_inttype.value=="0"||document.forms[0].sel_inttype.value==""))
	{
		  ShowAlert(111,'Interest Type');		  
		  document.forms[0].sel_inttype.focus();
		  return;
		  	
	}
	 if( (factype=="facility") && (document.forms[0].sel_intsutype.value=="0"||document.forms[0].sel_intsutype.value==""))
	{
		  ShowAlert(111,'Interest Sub Type');		  
		  document.forms[0].sel_intsutype.focus();
		  return;
		  	
	}	
	 if( (factype=="facility") && (document.forms[0].txt_facmonths.value==""))
	{
		  ShowAlert(121,'Tenor (in Months)');		  
		  document.forms[0].txt_facmonths.focus();
		  return;
	}
	 if( (factype=="facility") && (document.forms[0].sel_propbanktype.value==""))
	{
		  ShowAlert(111,'Proposed Banking Arrangement');		  
		  document.forms[0].sel_propbanktype.focus();
		  return;
	} 
	 if( (factype=="facility") && (document.forms[0].sel_propbanktype.value=="C") && (document.forms[0].txt_LeadBank.value==""))
		{
			  ShowAlert(111,'Name of the Leader bank');		  
			  document.forms[0].txt_LeadBank.focus();
			  return;
		}
	 
	 if(varAppType!="P")
	 {	
		 
		 if( (factype=="facility") && (document.forms[0].sel_repaytype.value=="0"||document.forms[0].sel_repaytype.value==""))
		{
			  ShowAlert(111,'Repayment Type');		  
			  document.forms[0].sel_repaytype.focus();
			  return;
		}
	 }

	 <%if(!facility_type.equalsIgnoreCase("P")){%>
	 if(factype=="facility")
		{
			 if(document.forms[0].selmodepayment.value=="0" || document.forms[0].selmodepayment.value==""){
			  ShowAlert(111,'Mode of Payment');
			  document.forms[0].selmodepayment.focus();
			  return;
			 }
			 if(document.forms[0].selmodepayment.value=="E" && document.forms[0].txt_operativeaccno.value==""){
				 ShowAlert(121,'Operative Account Number');
				  document.forms[0].txt_operativeaccno.focus();
				  return;
			 }
			 if(document.forms[0].selmodepayment.value=="E" && document.forms[0].txt_operativeaccno.value!=""){
				 var varOperAcc=document.forms[0].txt_operativeaccno.value;
					if(varOperAcc.length!=16)
					{
						alert("Please Enter Valid 16 digit Operative Account Number");
						document.forms[0].txt_operativeaccno.focus();
						return;
					}
			}
		}
		if(factype=="sublimit")
		{
			
			 if(document.forms[0].selmodepayment_sub.value=="0" ||document.forms[0].selmodepayment_sub.value==""){
			  ShowAlert(111,'Mode of Payment');
			  document.forms[0].selmodepayment_sub.focus();
			  return;
			 }
			 if(document.forms[0].selmodepayment_sub.value=="E" && document.forms[0].txt_operativeaccno_sub.value==""){
				 ShowAlert(121,'Operative Account Number');
				  document.forms[0].txt_operativeaccno_sub.focus();
				  return;
			 }
			 if(document.forms[0].selmodepayment_sub.value=="E" && document.forms[0].txt_operativeaccno_sub.value!=""){
				 var varOperAcc=document.forms[0].txt_operativeaccno_sub.value;
					if(varOperAcc.length!=16)
					{
						alert("Please Enter Valid 16 digit Operative Account Number");
						document.forms[0].txt_operativeaccno_sub.focus();
						return;
					}
			 }

		}
		<%}%> 

 if(varAppType!="P")
 {
	 if( (factype=="facility") && (document.forms[0].sel_peridicityfac.value=="" || document.forms[0].sel_peridicityfac.value=="s" ))
	{
		  ShowAlert(111,'Periodicity of Installments');		  
		  document.forms[0].sel_peridicityfac.focus();
		  return;
	}
 }

		
	 <%if(!facility_type.equalsIgnoreCase("P")) {%>
	 if((factype=="facility") && (document.forms[0].txt_installments.value!="") && (document.forms[0].txt_installments.value!="0") && document.forms[0].interestservised.value=="s")
	{
		  ShowAlert(111,'Interest to be collected during Holiday');
		  document.forms[0].interestservised.focus();
		  return false;
	}
	 /*if((factype=="facility") && (document.forms[0].txt_metlifeinsurance.value==""))
		{
			  ShowAlert(121,'One time Single Premium for Met Loan & Life Suraksha');
			  document.forms[0].txt_metlifeinsurance.focus();
			  return false;
		}  */
		<%}%>
	/*else if( (factype=="sublimit") && (document.forms[0].subfacility_head.value=="-"))
	{
		  ShowAlert(111,'Sub facility head');
		  document.forms[0].subfacility_head.focus();
	}
	else if( (factype=="sublimit") && (document.forms[0].subfacility.value=="-"))
	{
		  ShowAlert(111,'Sub facility type');
		  document.forms[0].subfacility.focus();	
	}*/
	 if( (factype=="sublimit") && (document.forms[0].facilitydescsubnew.value==""))
	{
		  ShowAlert(111,'Sub Facility Description');
		  return;
		 // document.forms[0].facilitydescsub.focus();	
	}
	if( (factype=="sublimit") && (document.forms[0].sel_subfac_desc.value==""))
	{
		  ShowAlert(111,'Type');
		  document.forms[0].sel_subfac_desc.focus();
		  return;
		 // document.forms[0].facilitydescsub.focus();	
	}
	if(varAppType!="P")
	 {	
			if( (factype=="sublimit") && (document.forms[0].selectgovt.value=="1"))
			{
		
		        if(document.forms[0].schemetype.value=="0")
					{
						  ShowAlert(111,'Scheme Type');
						  document.forms[0].schemetype.focus();
						  return;
					}
					if(document.forms[0].subamt.value=="")
					{
						  ShowAlert(121,'Subsidy Amount');
						  document.forms[0].subamt.focus();
						  return;
					}
					if(document.forms[0].sel_sponser_agency.value=="0")
					{
						  ShowAlert(111,'Sponsor Agency');
						  document.forms[0].sel_sponser_agency.focus();
						  return;
					}
					if(document.forms[0].sel_subsidytype.value=="0")
					{
						  ShowAlert(111,'Subsidy type');
						  document.forms[0].sel_subsidytype.focus();
						  return;
					}
				 
			}
	 }

	 if((factype=="facility") && ((document.forms[0].prd_intrate.value=="0.00" || document.forms[0].prd_intrate.value=="0.0")&& (document.forms[0].sel_inttype.value=="Fix")))
		{		
				alert("Interest rate cannot be 0%");
				return;
		}
	 if((factype=="sublimit") && ((document.forms[0].prd_subintrate.value=="0.00" || document.forms[0].prd_subintrate.value=="0.0") && (document.forms[0].sel_sub_inttype.value=="Fix"))) 
		{
		 		alert("Interest rate cannot be 0%");
				return;
		}
		
	 if(factype=="facility" && document.forms[0].sel_inttype.value=="Flo")
	 {		
		 if(parseInt(document.forms[0].sel_interesttype.length)>2 && document.forms[0].sel_interesttype.value=="")
		 {
				alert("select ROI Type");
				document.forms[0].sel_interesttype.focus();
				return;
		 }
	 }
	 if(factype=="sublimit" && document.forms[0].sel_sub_inttype.value=="Flo") 
	 {
		 if(parseInt(document.forms[0].sel_sub_interesttype.length)>2 && document.forms[0].sel_sub_interesttype.value=="")
		 {
		 		alert("Select ROI Type");
		 		document.forms[0].sel_sub_interesttype.focus();
				return;
		 }
	 }

		
	
	
	 if((factype=="facility") && ((document.forms[0].txt_exist_limit.value=="" && document.forms[0].txt_proposed_limit.value=="")||(document.forms[0].txt_exist_limit.value=="0.00" && document.forms[0].txt_proposed_limit.value=="0.00")))
	{		
			alert("Please Define the Values for Existing/Proposed Limit");
			return;
	}
	 if((factype=="sublimit")) 
	{
		if((document.forms[0].facilitysub_nature.value=="1") || (document.forms[0].facilitysub_nature.value==""))
		{
			if(((document.forms[0].txt_subexist_limit.value=="" && document.forms[0].txt_subproposed_limit.value=="") || (document.forms[0].txt_subexist_limit.value=="0.00" && document.forms[0].txt_subproposed_limit.value=="0.00")))
			{
					alert("Please Define the Values for Existing/Proposed Limit");
					return;		
			}
		}
	}

	 if(varAppType!="P")
	 {
		 if( (factype=="sublimit") && document.forms[0].txtsharetypesub.value=="P" && ((eval(document.forms[0].hidPhysicalLimitAvailed1.value)+eval(document.forms[0].txt_subproposed_limit.value))>eval(document.forms[0].hidPhysicalLimit.value)))
		{
			 alert("Physical form of loan against share limit exceeds for this borrower.\n You can avail only Rs."+roundVal(eval(document.forms[0].hidPhysicalLimit.value)-eval(document.forms[0].hidPhysicalLimitAvailed1.value)));
			 return;
		}
		 else if( (factype=="sublimit") && document.forms[0].txtsharetypesub.value=="D" && ((eval(document.forms[0].hidDematLimitAvailed1.value)+eval(document.forms[0].txt_subproposed_limit.value))>eval(document.forms[0].hidDematLimit.value)))
		{
			 alert("Physical form of loan against share limit exceeds for this borrower.\n You can avail only Rs."+roundVal(eval(document.forms[0].hidDematLimit.value)-eval(document.forms[0].hidDematLimitAvailed1.value)));
			 return;
		}
	 }
	if((factype=="sublimit") && (document.forms[0].sel_sub_inttype.value=="0"))
	{
		  ShowAlert(111,'Interest Type');
		  document.forms[0].sel_sub_inttype.focus();
		  return;
	}
	if((factype=="sublimit") && (document.forms[0].sel_intsufacsubtype.value=="0"))
	{
		  ShowAlert(111,'Interest Sub Type');
		  document.forms[0].sel_intsufacsubtype.focus();
		  return;
	}	
	if((factype=="sublimit") && (document.forms[0].txt_subfacmonths.value==""))
	{
		  ShowAlert(121,'Tenor (in Months)');
		  document.forms[0].txt_subfacmonths.focus();
		  return;
	}
	if((factype=="sublimit") && (document.forms[0].sel_sub_propbanktype.value==""))
	{
		  ShowAlert(111,'Proposed Banking Arrangement');
		  document.forms[0].sel_sub_propbanktype.focus();
		  return;
	}
	 if( (factype=="sublimit") && (document.forms[0].sel_sub_propbanktype.value=="C") && (document.forms[0].txt_sub_LeadBank.value==""))
		{
			  ShowAlert(111,'Name of the Leader bank');		  
			  //document.forms[0].txt_sub_LeadBank.focus();
			  return;
		} 
	if((factype=="sublimit") && (document.forms[0].sel_peridicityfacsub.value=="" || document.forms[0].sel_peridicityfacsub.value=="s" ))
	{
		  ShowAlert(111,'Periodicity of Installments');		  
		  document.forms[0].sel_peridicityfacsub.focus();
		  return;
	}
	<%if(!facility_type.equalsIgnoreCase("P")) {%>
	if((factype=="sublimit") && (document.forms[0].txt_installments_sub.value!="") && (document.forms[0].txt_installments_sub.value!="0") && document.forms[0].interestservised_sub.value=="s")
	{
		  ShowAlert(111,'Interest to be collected during Holiday');
		  document.forms[0].interestservised_sub.focus();
		  return false;
	} 
	/* if((factype=="sublimit") && (document.forms[0].txt_submetlifeinsurance.value==""))
		{
			  ShowAlert(121,'One time Single Premium for Met Loan & Life Suraksha');
			  document.forms[0].txt_submetlifeinsurance.focus();
			  return false;
		}  */
	<%}%>
	//else
	 {	
		var lc=0,prop=0,hidprop=0;
		
		if(document.forms[0].hidproposed.value!="")
		 {
				hidprop = parseFloat(document.forms[0].hidproposed.value);
		 }
		 if(!hidprop)
		 {
			hidprop =0;
		 }
		if(document.forms[0].txt_proposed_limit.value!="")
		 {
				prop = parseFloat(document.forms[0].txt_proposed_limit.value);
		 }
		 if(!prop)
		 {
			prop =0;
		 }
		if(document.forms[0].hid_line_credit.value!="")
		 {
			lc = parseFloat(document.forms[0].hid_line_credit.value);
		 }
		 if(!lc)
		 {
			lc =0;
		 }

	//if(document.forms[0].category[0].checked==true)
	//{
		//document.forms[0].faccategory.value="R";
	//}
	//else if(document.forms[0].category[1].checked==true)
	//{
		//document.forms[0].faccategory.value="A";
	//}
	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].factype.value="sublimit";
	}
	else
	{
		document.forms[0].factype.value="facility"
	}
	if(varAppType!="P")
	{
	/*	if(factype=="facility" && document.forms[0].hidComFactype.value == "OD" && document.forms[0].sel_fac_desc.value=="1")
		{
			if(document.forms[0].txt_duedate.value=="")
			{
				ShowAlert(121,'Due Date');
				document.forms[0].txt_duedate.focus();
				return;
			}
		}*/
		
		if(factype=="facility" && document.forms[0].txt_duedate.value=="" && document.forms[0].facility_head_id_code.value=="5" && document.forms[0].facility_id_code.value=="98")
		{
			if(document.forms[0].txt_duedate.value=="")
			{
				ShowAlert(121,'Due Date');
				document.forms[0].txt_duedate.focus();
				return;
			}
		}
		if(factype=="facility" && document.forms[0].hidComFactype.value == "OD" && document.forms[0].sel_fac_desc.value!="1")
		{
			if(document.forms[0].txt_duedate.value=="")
			{
				ShowAlert(121,'Due Date');
				document.forms[0].txt_duedate.focus();
				return;
			}
		}
		
		
		if(factype=="facility" && document.forms[0].txt_duedate.value != "")
		{
			var varFlag=checkduedate('Y',document.forms[0].txt_duedate);
			if(varFlag==false)
			{
				return;
			}
		}
		if(factype=="sublimit" && document.forms[0].hidSubComFactype.value == "OD" && document.forms[0].txt_subduedate.value=="" && (document.forms[0].selsubadhoclimit.value=="A"||document.forms[0].selsubadhoclimit.value=="D") && document.forms[0].sel_subfac_desc.value=="1")
		{
			  ShowAlert(121,'Due Date');
			  document.forms[0].txt_subduedate.focus();
			  return;
		}
		if(factype=="sublimit" && document.forms[0].hidSubComFactype.value == "OD" && document.forms[0].txt_subduedate.value=="" && document.forms[0].sel_subfac_desc.value!="1")
		{
			  ShowAlert(121,'Due Date');
			  document.forms[0].txt_subduedate.focus();
			  return;
		}
		if(factype=="sublimit" && document.forms[0].txt_subduedate.value=="" && document.forms[0].facilitysub_head_id_code.value=="5" && document.forms[0].facilitysub_id_code.value=="98")
		{
			  ShowAlert(121,'Due Date');
			  document.forms[0].txt_subduedate.focus();
			  return;
		}
		
		if(factype=="sublimit" && document.forms[0].txt_subduedate.value != "")
		{
			var varFlag=checkduedate('N',document.forms[0].txt_subduedate);
			
			if(varFlag==false)
			{
				return;
			}
		}

		if(factype=="facility" && document.forms[0].hidintdefer_acc.value=="" && document.forms[0].facility_head_id_code.value=="5" && document.forms[0].facility_id_code.value=="98")
		{
			ShowAlert(121,'Interest Deferment Account');
			return;
		}
		if(factype=="sublimit" && document.forms[0].hidintdefer_accsub.value=="" && document.forms[0].facilitysub_head_id_code.value=="5" && document.forms[0].facilitysub_id_code.value=="98")
		{
			 ShowAlert(121,'Interest Deferment Account');
			 return;
		}
		
	}
	else
	{
		if(factype=="facility" && document.forms[0].hidComFactype.value == "OD" && document.forms[0].sel_fac_desc.value!="1")
		{

			var varPSterms10 =document.forms[0].hidPStermsSelected.value.split("@");

			for(var i=0;i<varPSterms10.length;i++)
			{
				if(varPSterms10[i] == "DATEEX")
				{
					if(document.forms[0].txt_duedate.value=="")
					{
						ShowAlert(121,'Due Date');
						document.forms[0].txt_duedate.focus();
						return;
					}
				}
				if(varPSterms10[i] == "REODWC")
				{
					if(document.forms[0].txt_reviewdate.value=="")
					{
						ShowAlert(121,'Reviewed Due Date');
						document.forms[0].txt_reviewdate.focus();
						return;
					}
				}
			}
			
		}
		if(factype=="sublimit" && document.forms[0].hidSubComFactype.value == "OD" && document.forms[0].sel_subfac_desc.value!="1")
		{
			var varPSterms11 =document.forms[0].hidSubPStermsSelected.value.split("@");
			for(var i=0;i<varPSterms11.length;i++)
			{
				if(varPSterms11[i] == "DATEEX")
				{
					if(document.forms[0].txt_subduedate.value=="")
					{
					  ShowAlert(121,'Due Date');
					  document.forms[0].txt_subduedate.focus();
					  return;
					}
				}
				if(varPSterms11[i] == "REODWC")
				{
					if(document.forms[0].txt_subreviewdate.value=="")
					{
					  ShowAlert(121,'Reviewed Due Date');
					  document.forms[0].txt_subreviewdate.focus();
					  return;
					}
				}
			}
		}
	}
	if(document.forms[0].sel_displaydesc.value=="0")
	{
		ShowAlert(121,'Process note Description');
		document.forms[0].sel_displaydesc.disabled=false;
		document.forms[0].sel_displaydesc.focus();
		//document.forms[0].sel_displaydesc.readOnly = false;
		  return;
	}
	if( (factype=="sublimit") && (document.forms[0].sel_subdisplaydesc.value=="0"))
	{
		  ShowAlert(121,'Process note Description');
		  document.forms[0].sel_subdisplaydesc.disabled=false;
		  document.forms[0].sel_subdisplaydesc.focus();
		  //document.forms[0].sel_subdisplaydesc.readOnly = false;
		  return;
		 // document.forms[0].facilitydescsub.focus();	
	}
	<%if(facility_type.equalsIgnoreCase("S")) {%>
	if(document.forms[0].selfac_restr_acc.value=="")
	{
		ShowAlert(111,'Whether to be Restructure');
		document.forms[0].selfac_restr_acc.focus();
		  return;
	}
	if( (factype=="sublimit") && (document.forms[0].selsubfac_restr_acc.value==""))
	{
		  ShowAlert(111,'Whether to be Restructure');
		  document.forms[0].selsubfac_restr_acc.focus();
		  return;
	}
	if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].selfac_fitl_acc.value=="")
	{
		ShowAlert(111,'Whether FITL/Renew Account');
		document.forms[0].selfac_fitl_acc.focus();
		  return;
	}
	if( (factype=="sublimit") && (document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value==""))
	{
		  ShowAlert(111,'Whether FITL/Renew Account');
		  document.forms[0].selsubfac_fitl_acc.focus();
		  return;
	}
	if(document.all.id_restracc.style.display=="table-cell" && str_rsAcc=="")
	{
		ShowAlert(111,'Existing CBS Account no.');
		return false;
	}
	else if(document.all.id_restracc.style.display=="none")
	{
		document.forms[0].hid_str_rsAcc.value="";
	}
	if((factype=="sublimit") && (document.all.id_restracc_sub.style.display=="table-cell" && str_rsAcc_sub==""))
	{
		ShowAlert(111,'Existing CBS Account no.');
		return false;	
	}
	else if(document.all.id_restracc_sub.style.display == "none")
	{
		document.forms[0].hid_str_rsAcc_sub.value="";
	}
/*	if(document.forms[0].selfac_restr_acc.value=="N" || document.forms[0].selfac_fitl_acc.value=="Y")
	{
		document.forms[0].hid_str_rsAcc.value="";
	}
	if((factype=="sublimit") && (document.forms[0].selsubfac_restr_acc.value=="N" || document.forms[0].selsubfac_fitl_acc.value=="Y"))
	{
		document.forms[0].hid_str_rsAcc_sub.value="";
	}
*/
	if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].sel_restr_conversionfac.value=="")
	{
		ShowAlert(111,'Conversion of Existing Facility');
		document.forms[0].sel_restr_conversionfac.focus();
		  return;
	}
	if( (factype=="sublimit") && (document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].sel_restr_conversionfac_sub.value==""))
	{
		  ShowAlert(111,'Conversion of Existing Facility');
		  document.forms[0].sel_restr_conversionfac_sub.focus();
		  return;
	}
	if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].sel_restr_addfunding.value=="")
	{
		ShowAlert(111,'Additional funding/finance');
		document.forms[0].sel_restr_addfunding.focus();
		  return;
	}
	if( (factype=="sublimit") && (document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].sel_restr_addfunding_sub.value==""))
	{
		  ShowAlert(111,'Additional funding/finance');
		  document.forms[0].sel_restr_addfunding_sub.focus();
		  return;
	}
	//changetypevalue();
	
	if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].sel_restr_scheme.value=="")
	{
		ShowAlert(111,'Restructure Settlement Scheme');
		document.forms[0].sel_restr_scheme.focus();
		  return;
	}

	if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].txt_restructdate.value=="")
	{
		alert("Please Enter the Date of Restructure Invocation in Customer Profile");
	}
	
	if( (factype=="sublimit") && (document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].sel_restr_scheme_sub.value==""))
	{
		  ShowAlert(111,'Restructure Settlement Scheme');
		  document.forms[0].sel_restr_scheme_sub.focus();
		  return;
	}
	<%}%>

	if((factype=="facility") && document.forms[0].seladhoclimit.value=="" )
	{
		ShowAlert(111,'Nature of limit');
		document.forms[0].seladhoclimit.focus();
		  return;
	}
	if((factype=="facility") && (document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D") && document.forms[0].seladhocof.value=="")
	{
		ShowAlert(111,'Base facility');
		document.forms[0].seladhocof.focus();
		  return;
	}
	if( (factype=="sublimit") && document.forms[0].selsubadhoclimit.value=="")
	{
		  ShowAlert(111,'Nature of limit');
		  document.forms[0].selsubadhoclimit.focus();
		  return;
	}
	if( (factype=="sublimit") && ((document.forms[0].selsubadhoclimit.value=="A"||document.forms[0].selsubadhoclimit.value=="D") && document.forms[0].selsubadhocof.value==""))
	{
		  ShowAlert(111,'Base facility');
		  document.forms[0].selsubadhocof.focus();
		  return;
	}
	if((factype=="facility") && (document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D") && document.forms[0].seladhocof.value!="")
	{
		var varamt=document.forms[0].seladhocof.value.split("~");
		//if(parseFloat(varamt[2])<parseFloat(document.forms[0].txt_proposed_limit.value))
		//{
			//alert("Adhoc Limit should not greater than "+varamt[2]);
			//return;
		//}
		if(parseFloat(varamt[3])<parseFloat(document.forms[0].txt_facmonths.value))
		{
			alert("Facility Tenor should not greater than "+varamt[3]+" months");
			return;
		}
		if(varamt[4]=="Y" && document.forms[0].hidAction.value =="insert")
		{
			alert("Base Facility Already Expired");
			return;
		}
	}
	if( (factype=="sublimit") && ((document.forms[0].selsubadhoclimit.value=="A"||document.forms[0].selsubadhoclimit.value=="D") && document.forms[0].selsubadhocof.value!=""))
	{
		var varamt1=document.forms[0].selsubadhocof.value.split("~");
		//if(parseFloat(varamt1[2])<parseFloat(document.forms[0].txt_subproposed_limit.value))
		//{
			//alert("Adhoc Limit should not greater than "+varamt1[2]);
			//return;
		//}
		if(parseFloat(varamt1[3])<parseFloat(document.forms[0].txt_subfacmonths.value))
		{
			alert("Facility Tenor should not greater than "+varamt1[3]+" months");
			return;
		}
		if(varamt1[4]=="Y" && document.forms[0].hidAction.value =="insert")
		{
			alert("Base Facility Already Expired");
			return;
		}
	}
	
	if(varAppType=="P")
	{
		var varpsmodifiedTerms; 
		if(factype=="facility")
	    {
			varpsmodifiedTerms = document.forms[0].hidPStermsSelected.value.split("@");
	    }
		else if(factype=="sublimit")
		{
			varpsmodifiedTerms = document.forms[0].hidSubPStermsSelected.value.split("@");
		}
		for(var i=0;i<varpsmodifiedTerms.length;i++)
		{
		  	if(varpsmodifiedTerms[i]=="BRTOMCLR")
		  	{
		  		if(factype=="facility")
			    {
					if(document.forms[0].sel_intsutype.value!="MCLR" && document.forms[0].sel_intsutype.value!="MCLEC"
						&& document.forms[0].sel_intsutype.value!="SMTB"&& document.forms[0].sel_intsutype.value!="TYGS")
					{
						alert("Interest Sub type should be MCLR / MCLR Linked Export Limit/Six Month Treasury Bill/Ten Years Govt Security");
						document.forms[0].sel_intsutype.value="0";
						document.forms[0].sel_intsutype.focus();
						return;
					}
			    }
				else if(factype=="sublimit")
				{
					if(document.forms[0].sel_intsufacsubtype.value!="MCLR" && document.forms[0].sel_intsufacsubtype.value!="MCLEC"
						 && document.forms[0].sel_intsufacsubtype.value!="SMTB" && document.forms[0].sel_intsufacsubtype.value!="TYGS")
					{
						alert("Interest Sub type should be MCLR / MCLR Linked Export Limit/Six Month Treasury Bill/Ten Years Govt Security");
						document.forms[0].sel_intsufacsubtype.value="0";
						document.forms[0].sel_intsufacsubtype.focus();
						return;
					}
				}
	  		}
		}
	}

	//if(document.forms[0].txt_cgtmse.value=="Y" || document.forms[0].txt_cgtmse.value=="N")
	if(factype=="facility" && varAppType!="P")
	{
		if(document.forms[0].cgtmse_app.value=="")
		{
			ShowAlert('111',"Whether CGTMSE applicable");
		 	document.forms[0].cgtmse_app.focus();
		 	return;
		}
		else if(document.forms[0].cgtmse_app.value=="Y" && document.forms[0].txt_coverenddate.value!="")
		{
			if(!confirm("CGTMSE Guarantee going to expires on "+document.forms[0].txt_coverenddate.value+". Please select Appropriate Terms  in Terms & Conditions tab"))
			{
				return;
			}
		}
	}
	if(document.forms[0].cgtmse_app.value=="Y")
	{
		
		
		/*if(document.forms[0].sel_cg_fee.value=="" || document.forms[0].sel_cg_fee.value=="0")
		{
			ShowAlert('111',"Split interest rate ");
			document.forms[0].sel_cg_fee.focus();
			return false;
		}*/			
	}

	if(document.forms[0].cgtmse_app.value=="Y")
	{
		cggstcal();
	}

	//if(document.forms[0].txt_cgtmsesub.value=="Y" || document.forms[0].txt_cgtmsesub.value=="N")
	if(factype=="sublimit" && varAppType!="P")
	{
		if(document.forms[0].cgtmse_appsub.value=="")
		{
			ShowAlert('111',"Whether CGTMSE applicable");
		 	document.forms[0].cgtmse_appsub.focus();
		 	return;
		}
		else if(document.forms[0].cgtmse_appsub.value=="Y" && document.forms[0].txt_coverenddatesub.value!="")
		{
			if(!confirm("CGTMSE Guarantee going to expires on "+document.forms[0].txt_coverenddate.value+". Please select Appropriate Terms  in Terms & Conditions tab"))
			{
				return;
			}
		}
	}
	if(document.forms[0].cgtmse_appsub.value=="Y")
	{
		/*if(document.forms[0].sel_cg_feesub.value=="" || document.forms[0].sel_cg_feesub.value=="0")
		{
			ShowAlert('111',"Split interest rate ");
			document.forms[0].sel_cg_feesub.focus();
			return false;
		}		*/	
	}
	if(document.forms[0].cgtmse_appsub.value=="Y")
	{
		cggstcalsub();
	}

	if(factype=="facility")
	{
		if(document.forms[0].txtMISFlag.value=="Y")
		{
			if(parseFloat(document.forms[0].txt_proposed_limit.value)!= parseFloat(document.forms[0].txt_proposed_limit_old.value))
			{
				if(confirm("If Sanction limit is modified user needs to reselect the activity code in MIS details tab for recalculation. Do you want to proceed?"))
					 document.forms[0].hidparam1.value ="MISDEL";
				 else
				 {
					  document.forms[0].txt_proposed_limit.value=document.forms[0].txt_proposed_limit_old.value;
					  return false;
				 }
			}
			
		}

		if(varAppType!="P")
		{
		if(document.forms[0].sel_Processed_Type.value=="")
		{
			ShowAlert('111',"Insurance Covered Under");
			document.forms[0].sel_Processed_Type.focus();
			return false;
		}
		if(document.forms[0].sel_Processed_Type.value!="NC" && (document.forms[0].txt_metlifeinsurance.value=="0" || document.forms[0].txt_metlifeinsurance.value=="" || document.forms[0].txt_metlifeinsurance.value=="0.00"))
		{
			ShowAlert('121',"Premium amount for "+document.forms[0].sel_Processed_Type.options[document.forms[0].sel_Processed_Type.selectedIndex].text+" should not be 0");
			document.forms[0].txt_metlifeinsurance.focus();
			return false;
		}
	
		if(document.forms[0].sel_Processed_Type.value!="NC")
		{
			if(document.forms[0].txt_premium_tenor.value==""||document.forms[0].txt_premium_tenor.value=="0"||document.forms[0].txt_premium_tenor.value=="0.00")
			{
				ShowAlert('121',"Premium Tenor");
				document.forms[0].txt_premium_tenor.focus();
				return false;
			}
			
			if(document.forms[0].txt_premium_loan_amt.value==""||document.forms[0].txt_premium_loan_amt.value=="0"||document.forms[0].txt_premium_loan_amt.value=="0.00")
			{
				ShowAlert('121',"Loan amount covered under the scheme");
				document.forms[0].txt_premium_loan_amt.focus();
				return false;
			}
		}
		if(document.forms[0].sel_Processed_Type.value=="SF")
		{
			if(document.forms[0].txt_premium_Account_no.value=="")
			{
				ShowAlert('121',"Operative account number from which premium account will be debited ");
				document.forms[0].txt_premium_Account_no.focus();
				return false;
			}
			if(document.forms[0].sel_Funded_Comp_Name.value=="")
			{
				ShowAlert('111',"Insurance Funded Company Name");
				document.forms[0].sel_Funded_Comp_Name.focus();
				return false;
			}
		}
		}
	}
	else if(factype=="sublimit")
	{
		if(document.forms[0].txtMISFlagsub.value=="Y")
		{
			if(parseFloat(document.forms[0].txt_subproposed_limit_old.value)!= parseFloat(document.forms[0].txt_subproposed_limit.value))
			{
				if(confirm("If Sanction limit is modified user needs to reselect the activity code in MIS details tab for recalculation. Do you want to proceed?"))
					 document.forms[0].hidparam1.value ="MISDEL";
				 else
				 {
					  document.forms[0].txt_subproposed_limit.value=document.forms[0].txt_subproposed_limit_old.value;
					  return false;
				 }
			}
		}

		if(varAppType!="P")
		{
		if(document.forms[0].sel_Processed_Type_sub.value=="")
		{
			ShowAlert('111',"Insurance Covered Under");
			document.forms[0].sel_Processed_Type_sub.focus();
			return false;
		}
		if(document.forms[0].sel_Processed_Type_sub.value!="NC" && (document.forms[0].txt_metlifeinsurance.value==""||document.forms[0].txt_submetlifeinsurance.value=="0.00"))
		{
			ShowAlert('121',"Premium amount for "+document.forms[0].sel_Processed_Type_sub.options[document.forms[0].sel_Processed_Type_sub.selectedIndex].text+" should not be 0");
			document.forms[0].txt_submetlifeinsurance.focus();
			return false;
		}
		if(document.forms[0].sel_Processed_Type_sub.value!="NC")
		{
			if(document.forms[0].txt_premium_tenor_sub.value==""||document.forms[0].txt_premium_tenor_sub.value=="0"||document.forms[0].txt_premium_tenor_sub.value=="0.00")
			{
				ShowAlert('121',"Premium Tenor");
				document.forms[0].txt_premium_tenor_sub.focus();
				return false;
			}
			
			if(document.forms[0].txt_premium_loan_amt_sub.value==""||document.forms[0].txt_premium_loan_amt_sub.value=="0"||document.forms[0].txt_premium_loan_amt_sub.value=="0.00")
			{
				ShowAlert('121',"Loan amount covered under the scheme");
				document.forms[0].txt_premium_loan_amt_sub.focus();
				return false;
			}
		}
		if(document.forms[0].sel_Processed_Type_sub.value=="SF")
		{
			if(document.forms[0].txt_premium_Account_no_sub.value=="")
			{
				ShowAlert('121',"Operative account number from which premium account will be debited ");
				document.forms[0].txt_premium_Account_no_sub.focus();
				return false;
			}
			if(document.forms[0].sel_Funded_Sub_Comp_Name.value=="")
			{
				ShowAlert('111',"Insurance Funded Company Name");
				document.forms[0].sel_Funded_Sub_Comp_Name.focus();
				return false;
			}
		}
		}
	}
	document.forms[0].selmodepayment.disabled=false;
	disableFields(false);
	document.forms[0].sel_proposalvaluesin.disabled=false;
	document.forms[0].sel_interestcharge.disabled=false;
	document.forms[0].sel_interestcharge_sub.disabled=false;
	document.forms[0].sel_fac_desc.disabled=false;
	document.forms[0].sel_subfac_desc.disabled=false;

	document.forms[0].selectgovtmain.disabled=false;
	document.forms[0].selectgovt.disabled=false;

	document.forms[0].cgtmse_app.disabled=false;
	//document.forms[0].sel_cg_fee.disabled=false;
	
	if(document.forms[0].selmodepayment.value=="C")
	{
		if(document.forms[0].sel_ECSBankName.value=="0")
		{
		ShowAlert('111',"the Bank Name");
		document.forms[0].sel_ECSBankName.focus();
		return;	
		}
		
		if(document.forms[0].sel_ECSaccnttype.value=="0")
		{
		alert("Select the Account Type");
		document.forms[0].sel_ECSaccnttype.focus();
		return false;	
		}
		
		if(document.forms[0].txt_ECSoperaccno.value=="")
		{
		alert("Enter the Oper Account Number");
		document.forms[0].txt_ECSoperaccno.focus();
		return false;	
		}
		
		if(document.forms[0].sel_ECSauthmode.value=="0")
		{
		alert("Select the Athunenticate Mode");
		document.forms[0].sel_ECSauthmode.focus();
		return false;	
		}
		
		if(document.forms[0].txt_ECSifsccode.value=="")
		{
		alert("Enter the IFSC CODE");
		document.forms[0].txt_ECSifsccode.focus();
		return false;	
		}
	}
		assignData();
		document.forms[0].txt_line_credit.value = lc-hidprop+prop;
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action=appUrl+"action/facilities.jsp";
		document.forms[0].hidBeanGetMethod.value="updateData";		
		document.forms[0].submit();
	}		
 }
function doAfterEdit()
{
	 if(document.forms[0].btnenable.value =='N')
	  {
		    disableFields(true);
			document.forms[0].cmdnew.disabled=true;
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			return;
	  }
	  if(varhidAction=="insert")
	  {
		 if(document.forms[0].factype.value=="facility")
		 {
			  document.forms[0].facility_head.selectedIndex=0;
			  document.forms[0].facility.length=1;
			  document.forms[0].facility.selectedIndex=0;
			  document.forms[0].selsno.value ="";
			  document.forms[0].selsubsno.value ="";
			  document.forms[0].txt_desc.value="";
			  document.forms[0].txt_exist_limit.value="";
			  document.forms[0].txt_proposed_limit.value="";			
			  document.forms[0].hidproposed.value="";
			  document.forms[0].prd_intrate.value="";
			  document.forms[0].subfacility_head.selectedIndex=0;
			  document.forms[0].subfacility.length=1;
			  document.forms[0].subfacility.selectedIndex=0;
			  document.forms[0].txt_subdesc.value="";
			  document.forms[0].txt_subexist_limit.value="";
			  document.forms[0].txt_subproposed_limit.value="";
			  //document.forms[0].txt_submargin.value="";
		  	  //document.forms[0].txt_subinterest.value="";	
			  document.forms[0].selmodepayment.value="E";
			  selOperative('facility');		  	
		  }
		  else if(document.forms[0].factype.value=="sublimit")
		  {
			  document.forms[0].selsubsno.value ="";
			  document.forms[0].subfacility_head.selectedIndex=-1;
			  document.forms[0].subfacility.length=0;
			  document.forms[0].subfacility.selectedIndex=-1;		 
			  document.forms[0].txt_subdesc.value="";
			  document.forms[0].txt_subexist_limit.value="";
			  document.forms[0].txt_subproposed_limit.value="";
			 // document.forms[0].txt_submargin.value="";
		  	  //document.forms[0].txt_subinterest.value="";			  
		  }
		   disableCommandButtons("edit");
	  }
	  else if(varhidAction=="delete")
	  {
		 if(document.forms[0].factype.value=="facility")
		 {
			  document.forms[0].facility_head.selectedIndex=0;
			  document.forms[0].facility.length=1;
			  document.forms[0].facility.selectedIndex=1;
			  document.forms[0].selsno.value ="";
			  document.forms[0].selsubsno.value ="";
			  document.forms[0].txt_desc.value="";
			  document.forms[0].txt_exist_limit.value="";
			  document.forms[0].txt_proposed_limit.value="";		
			  document.forms[0].hidproposed.value="";

			  document.forms[0].subfacility_head.selectedIndex=0;
			  document.forms[0].subfacility.length=1;
			  document.forms[0].subfacility.selectedIndex=0;
			  document.forms[0].txt_subdesc.value="";
			  document.forms[0].txt_subexist_limit.value="";
			  document.forms[0].txt_subproposed_limit.value="";
			  //document.forms[0].txt_submargin.value="";
		  	  //document.forms[0].txt_subinterest.value="";	
		  	 		  
		  }
		  else if(document.forms[0].factype.value=="sublimit")
		  {
			  document.forms[0].selsubsno.value ="";
			  document.forms[0].subfacility_head.selectedIndex=0;
			  document.forms[0].subfacility.length=1;
			  document.forms[0].subfacility.selectedIndex=0;
			  document.forms[0].txt_subdesc.value="";
			  document.forms[0].txt_subexist_limit.value="";
			  document.forms[0].txt_subproposed_limit.value="";
			  //document.forms[0].txt_submargin.value="";
		  	  //document.forms[0].txt_subinterest.value="";
		  	 		
		  }
		  clearRadioButton();
		  disableCommandButtons("load");
	  }
	 if(document.forms[0].appno.value != "new")
	 {
	      var editcheck="<%=request.getParameter("hideditflag")%>";
		  if(editcheck=="yes")
		  {
			  if(editlockflag=="y")
			  {
				  disableCommandButtons("edit");
			  }
			  else
			  {
				  disableFields(true);
				  ShowAlert(128);
				  disableCommandButtons("load");
			  }
		  }
		  else
		  {
			  disableFields(true);
			  disableCommandButtons("load");
		  }
	  }
	  else
	  {
			disableCommandButtons("edit");
	  }  
}

function doEdit()
{
	
	if(document.forms[0].hidCGPANExpired.value=="Y")
		{
		alert("CGPAN validity is expired for the said facility. If facility needs  to be continued in CGTMSE then condition should be incorporated for fresh coverage to be made forgoing the already  paid guarantee fee up to CGPAN due date");
		
		}
	if(strFreezeFlag=="Y"){
		alert("Kindly Un-Freeze the coapplicant/Guarantor and proceed further");
		return;
	}
/*
    if(document.forms[0].txt_installments.value=="0"||document.forms[0].txt_installments.value=="")
	{
		alert("Initial Holiday/Gestation/ Moratorium Period cannot be 0 ");
		document.forms[0].txt_installments.value="";
		document.forms[0].txt_installments.focus();
		return false;
	}*/


	if((document.forms[0].hidnongeclfacchk.value=="Y" && strncgtcbankscheme=="061"))
	{
		alert("If one facility is under KBL GECL type then all other facilities of the proposal should also be in KBL GECL type scheme only ");
		return;	
	}
	
	varEditFlag=false;
	varEditSubFlag=false;
	{
		var subno=0;
		var hidAction = document.forms[0].hidAction.value;
		if(!isNaN(document.forms[0].selsubsno.value))
		{
			subno = parseInt(document.forms[0].selsubsno.value);
		}
		if(document.forms[0].checkbox.checked==true)
		{
			document.all.prod_sel_icon.style.display="none";
			document.all.duedate.style.display="none";
			document.forms[0].factype.value="sublimit"
			document.forms[0].facility_head.readOnly=true;	
			<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>

			changeCEFAFsub();
			<%}%>
		}
		else
		{
			document.forms[0].factype.value="facility";
			<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
			changeCEFAF();
			<%}%>

			if(document.forms[0].sel_repaytype.value=="E")
			{
				document.forms[0].sel_peridicityfac.disabled=true;

			}
		}
		if((!subno) && (document.forms[0].factype.value=="sublimit") && (hidAction=="update"))
		{
			alert("Sub-limit was not selected to modify");
			return;
		}
		if(document.forms[0].appno.value!="")
		{
			if(document.forms[0].selsno.value!="")
			{
				document.forms[0].hidAction.value ="update";
				disableFields(false);
				document.forms[0].cmdnew.disabled=true;
				document.forms[0].cmdedit.disabled=true;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdsave.disabled=false;
				document.forms[0].cmdcancel.disabled=false;
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				ShowAlert(111,'facility');
				return;
			}
		}
		else
		{
			ShowAlert(111,'Application');
			return;
		}
		
		<%if(facility_type.equalsIgnoreCase("P")){%>
		document.getElementById("Renewed_Facility").style.display = "none";
		var varboolflag=false;
		var varPSterms1 = "";
		var varFacType="";
		if(document.forms[0].checkbox.checked==true)
		{
			 varPSterms1 =document.forms[0].hidSubPStermsSelected.value.split("@");
			 varFacType=document.forms[0].sel_subfac_desc.value;
		}
		else
		{
			varPSterms1 =document.forms[0].hidPStermsSelected.value.split("@");
			varFacType=document.forms[0].sel_fac_desc.value;
		}
		if(varFacType!="4" && varPSterms1=="")
		{
			varboolflag=true;
		}
			for(var i=0;i<varPSterms1.length;i++)
			{
				if(varPSterms1[i] == "DLA" || varPSterms1[i] == "DATEEX" || varPSterms1[i] == "REODWC" || varPSterms1[i] == "DLP" || varPSterms1[i] == "INLIM"|| varPSterms1[i] == "CHDCCO" || varPSterms1[i] == "BRTOMCLR"|| varPSterms1[i] == "MODGSS"|| varPSterms1[i] == "MODBA"|| varPSterms1[i] == "MRS")
				{
					varboolflag=true;
				}
			}
			if(varboolflag)
			{
				//Allow to modify
			}
			else
			{
				alert("Your current Post sanction request is not for any of the fields in this page");
				document.forms[0].cmdnew.disabled=false;
				document.forms[0].cmdedit.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdsave.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
				document.forms[0].cmdclose.disabled=false;
				disableFields(true);
				return;
			}
		<%}%>
		
		
	}
	document.forms[0].CGTMSE_coverage.disabled=true;//for cgtmse button
	if('<%=strCheckFlag%>'=="Y")
	{
      document.forms[0].sel_proposalvaluesin.disabled=true;
      //if(varstrSessionModuleType=="AGR")
      	//document.forms[0].sel_facilityrequired.disabled=true;
	}
	document.forms[0].txtcbsaccno.readOnly=true;
	document.forms[0].txtsubcbsaccno.readOnly=true;

	<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
		CallPostSancRestriction();	
	<%}%>
	<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
		if(document.forms[0].checkbox.checked==true)
		{
			changeCEFAFsub();
		}
		else
		{
			changeCEFAF();
		}
	<%}%>

	/*if(document.forms[0].checkbox.checked==true)
	{
		if(document.forms[0].facilitysub_head_id_code.value=="3" ||
				document.forms[0].facilitysub_head_id_code.value=="4"||document.forms[0].facilitysub_head_id_code.value=="5")
		{
			document.forms[0].selsubadhoclimit.disabled=true;
		}	
	}
	else
	{
		if(document.forms[0].facility_head_id_code.value=="3" ||
				document.forms[0].facility_head_id_code.value=="4"||document.forms[0].facility_head_id_code.value=="5")
		{
			document.forms[0].seladhoclimit.disabled=true;
		}
	}*/

	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
	document.forms[0].selectgovtmain.disabled=true;
	document.forms[0].selectgovt.disabled=true;
	<%}%>

	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].facility_head.disabled=true;	
		document.forms[0].facility.disabled=true;	
		document.forms[0].txt_exist_limit.readOnly=true;
		document.forms[0].txt_proposed_limit.readOnly=true;			
		document.forms[0].sel_propbanktype.disabled=true;
		document.forms[0].sel_inttype.disabled=true;
		document.forms[0].sel_peridicityfac.disabled=true;
		document.forms[0].sel_repaytype.disabled=true;
		document.forms[0].selectgovtmain.disabled=true;	
		document.forms[0].facilitydesc.disabled=true;	
		document.forms[0].sel_intsutype.disabled=true;					

		document.forms[0].txt_desc.readOnly=true;			
		document.forms[0].txt_purpose.readOnly=true;		
		document.forms[0].txt_facmonths.readOnly=true;

		if(document.forms[0].selectgovtmain.value=="1")
		{
			document.forms[0].schemetypemain.disabled=true;
			document.forms[0].sel_sponser_agencymain.disabled=true;
			document.forms[0].sel_subsidytypemain.disabled=true;
			document.forms[0].submainamnt.readOnly=true;

		}	

		document.forms[0].txt_installments.readOnly=true;
		if(document.forms[0].txt_installments.value!="0" && document.forms[0].txt_installments.value!="")
		{
			document.forms[0].interestservised.disabled=true;
			document.forms[0].sel_interestcharge.disabled=true;
		}
		document.forms[0].txt_margin.readOnly=true;
		
		document.forms[0].selfac_restr_acc.disabled=true;	
		document.forms[0].selfac_fitl_acc.disabled=true;	
		document.forms[0].sel_restr_conversionfac.disabled=true;	
		document.forms[0].sel_restr_addfunding.disabled=true;
		document.forms[0].seladhoclimit.disabled=true;	
		document.forms[0].seladhocof.disabled=true;

		document.forms[0].interestservised.disabled=true;
		document.forms[0].sel_interestcharge.disabled=true;
		document.forms[0].sel_displaydesc.disabled=true;

		document.forms[0].txt_metlifeinsurance.readOnly=true;
		document.forms[0].txt_duedate.readOnly=true;
		document.forms[0].txtcbsaccno.readOnly=true;
		document.forms[0].txt_freshlimitmain.readOnly=true;

		if(document.forms[0].sel_sub_repaytype.value=="E")
		{
			document.forms[0].sel_peridicityfacsub.disabled=true;

		}

		document.forms[0].selmodepayment.disabled=true;
		if(document.forms[0].selmodepayment.value=="E")
		{

			document.forms[0].txt_operativeaccno.readOnly=true;
		} 
		document.forms[0].cgtmse_app.disabled=true;
	//	document.forms[0].sel_cg_fee.disabled=true;
		//document.forms[0].txt_cg_int_rate.readOnly=true;
		// For new fields
		document.forms[0].sel_Processed_Type.disabled=true;
		document.forms[0].sel_Funded_Comp_Name.disabled=true;
		document.forms[0].txt_metlifeinsurance.readOnly=true;
		document.forms[0].txt_premium_tenor.readOnly=true;
		document.forms[0].txt_premium_loan_amt.readOnly=true;
		document.forms[0].txt_premium_Account_no.readOnly=true;
		document.forms[0].txt_subproposed_limit.focus();
		document.forms[0].txtmianDate.readOnly=true;
		document.forms[0].Tenormibormain.disabled=true;
		
	}
	else
	{
		if(document.forms[0].sel_repaytype.value=="E")
		{
			document.forms[0].sel_peridicityfac.disabled=true;

		}
		document.forms[0].txt_proposed_limit.focus();
	}

	if(document.forms[0].txt_accountopenflag.value=="Y" || document.forms[0].hidCashMarginPrd.value=="Y")
	{
		document.forms[0].seladhoclimit.disabled=true;
	}
	if(document.forms[0].txt_accountopenflagsub.value=="Y"|| document.forms[0].hidCashMarginPrd.value=="Y")
	{
		document.forms[0].selsubadhoclimit.disabled=true;
	}
}



function doNew()
{
	if(strFreezeFlag=="Y"){
		alert("Kindly Un-Freeze the coapplicant/Guarantor and proceed further");
		return;
	}
	document.forms[0].hidDematLimitAvailed1.value=document.forms[0].hidDematLimitAvailed.value;
	document.forms[0].hidPhysicalLimitAvailed1.value=document.forms[0].hidPhysicalLimitAvailed.value
	if(document.forms[0].checkbox.checked==true)
	{
			document.forms[0].factype.value="sublimit"
			/*if(document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D")
			{
				alert("You cannot add any sub-limit facility for Adhoc Limit/Additional Limit");
				return;
			}*/
			if(document.forms[0].facility_head_id_code.value=="1" && document.forms[0].facility_id_code.value=="44")	
			{
				alert("You cannot add any sub-limit facility for Forward Contract");
				return;
			}
			
	}
	else
	{
		document.forms[0].factype.value="facility";
	}
	<%if(facility_type.equalsIgnoreCase("P")){%>

	if(document.forms[0].factype.value=="facility")
	{
		if(confirm("Do you want to include new facility in this Post sanction Proposal"))
		{
			document.all.prod_sel_icon.style.display="none";
			document.forms[0].cmdnew.disabled=true;
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			callRenewFacility();
		}
		return;
	}
	else
	{
		var varboolflag=false;
		var varPSterms1 = document.forms[0].hidPStermsSelected.value.split("@");
		for(var i=0;i<varPSterms1.length;i++)
		{
			if(varPSterms1[i] == "LAD" || varPSterms1[i] == "SUBLIMIT")
			{
				varboolflag=true;
			}
		}
		if(varboolflag==false)
		{
			alert("You cannot add any new sub-limit facility in this Post Sanction Proposal");
			return;
		}
	}
		
	<%}%>
	//document.forms[0].txt_subinterest.value="";
	//document.forms[0].txt_interest.disabled=false;
	//document.forms[0].txt_subinterest.disabled=false;
	clearRadioButton();
	disableFields(false);
	if(document.forms[0].factype.value=="facility")
	{
		document.forms[0].facility_head.selectedIndex=0;
		document.forms[0].facility.length=1;
		document.forms[0].facility.selectedIndex=0;
		document.forms[0].selsno.value ="";
  		document.forms[0].selsubsno.value ="";
		document.forms[0].txt_desc.value="";
		document.forms[0].txt_exist_limit.value="";
		document.forms[0].txt_proposed_limit.value="";		
	  	//document.forms[0].txt_interest.value="";			
		document.forms[0].hidproposed.value="";		
		document.forms[0].prd_intrate.value="";
		document.forms[0].subfacility_head.selectedIndex=0;
		document.forms[0].subfacility.length=1;
		document.forms[0].subfacility.selectedIndex=0;
		document.forms[0].txt_subdesc.value="";
		document.forms[0].txt_subexist_limit.value="";
		document.forms[0].txt_subproposed_limit.value="";
		//document.forms[0].txt_submargin.value="";
	  	//document.forms[0].txt_subinterest.value="";	  			
	  	document.forms[0].txt_facmonths.value="";	  
	  	document.forms[0].txt_subfacmonths.value="";
	  	//document.forms[0].txt_intremarks.value="";
	  	//document.forms[0].txt_subintremarks.value="";	  		
	  	document.forms[0].sel_propbanktype.value="";
	  	document.forms[0].sel_inttype.value="0";
	  	document.forms[0].sel_peridicityfac.value="s";
	  	document.forms[0].sel_repaytype.value="0";	  		
		document.forms[0].sel_sub_propbanktype.value="";
		document.forms[0].sel_sub_inttype.value="0";
		document.forms[0].sel_sub_repaytype.value="0";
		document.forms[0].sel_peridicityfacsub.value="s";
		document.forms[0].sel_intsutype.value="0";
		document.forms[0].sel_intsufacsubtype.value="0";
		document.forms[0].txt_fac_type.value="";
		document.forms[0].sel_fac_desc.value="1";
		document.forms[0].facility_OldCode.value="";
		document.forms[0].seladhoclimit.value="R";
		document.forms[0].seladhocof.value="";
		document.forms[0].hidfacreattach.value="";
		document.forms[0].selmodepayment.value="E";
		selOperative('facility');
		document.forms[0].hidAdhocchk.value="";
		document.forms[0].hidAdhocsno.value="";
		document.forms[0].hidadhocDesc.value="";
	}
	else if(document.forms[0].factype.value=="sublimit")
	{
   		document.forms[0].selsubsno.value ="";
		document.forms[0].subfacility_head.selectedIndex=0;
		document.forms[0].subfacility.length=1;
		document.forms[0].subfacility.selectedIndex=0;
		document.forms[0].txt_subdesc.value="";
		document.forms[0].txt_subexist_limit.value="";
		document.forms[0].txt_subproposed_limit.value="";
		//document.forms[0].txt_submargin.value="";
	  	//document.forms[0].txt_subinterest.value="";	
	  	document.forms[0].txt_subfacmonths.value="";
	  	//document.forms[0].txt_subintremarks.value="";	    	
	  	document.forms[0].sel_sub_propbanktype.value="";
	  	document.forms[0].sel_sub_inttype.value="0";
	  	document.forms[0].sel_sub_repaytype.value="0"
		document.forms[0].sel_peridicityfacsub.value="s";
		document.forms[0].sel_intsufacsubtype.value="0";
		document.forms[0].sel_subfac_desc.value="1";
		document.forms[0].selsubadhoclimit.value="R";
		document.forms[0].selsubadhocof.value="";
		document.forms[0].hidfacreattachsub.value="";
		document.forms[0].facilitydescsubnew.value="";
		document.all.prod_sel_icon.style.display="none";
		document.all.duedate.style.display="none";
		document.forms[0].selmodepayment_sub.value="E";
		selOperative('sub');
		document.forms[0].sel_Processed_Type_sub.value="";
		document.forms[0].txt_premium_tenor_sub.value="";
		document.forms[0].txt_premium_loan_amt_sub.value="";
		document.forms[0].txt_premium_Account_no_sub.value="";
		document.forms[0].sel_Funded_Sub_Comp_Name.value="";
		document.forms[0].txt_submetlifeinsurance.value="0";
		document.forms[0].hidAdhocchk.value="";
		document.forms[0].hidAdhocsno.value="";
		document.forms[0].hidadhocDesc.value="";
	}
	document.forms[0].hidAction.value ="insert";
	document.forms[0].cmdnew.disabled=true;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;

	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].facility_head.disabled=true;	
		document.forms[0].facility.disabled=true;	
		document.forms[0].txt_exist_limit.readOnly=true;
		document.forms[0].txt_proposed_limit.readOnly=true;		
		document.forms[0].sel_propbanktype.disabled=true;	
		document.forms[0].sel_inttype.disabled=true;
		document.forms[0].sel_intsutype.disabled=true;
		document.forms[0].sel_peridicityfac.disabled=true;
		document.forms[0].sel_repaytype.disabled=true;	
		document.forms[0].selectgovtmain.disabled=true;
		document.forms[0].facilitydesc.disabled=true;
		//document.forms[0].txt_intremarks.readOnly=true;
		document.forms[0].txt_desc.readOnly=true;		
		document.forms[0].txt_purpose.readOnly=true;		
		document.forms[0].txt_facmonths.readOnly=true;
		document.forms[0].selfac_restr_acc.disabled=true;
		document.forms[0].selfac_fitl_acc.disabled=true;
		if(document.forms[0].selectgovtmain.value=="1")
		{
			document.forms[0].schemetypemain.disabled=true;
			document.forms[0].sel_sponser_agencymain.disabled=true;
			document.forms[0].sel_subsidytypemain.disabled=true;
			document.forms[0].submainamnt.readOnly=true;

		}	
		document.forms[0].txt_installments.readOnly=true;
		if(document.forms[0].txt_installments.value!="0" && document.forms[0].txt_installments.value!="")
		{
			document.forms[0].interestservised.disabled=true;
			document.forms[0].sel_interestcharge.disabled=true;
		}
		document.forms[0].txt_margin.readOnly=true;
		document.forms[0].selmodepayment.disabled=true;
		if(document.forms[0].selmodepayment.value=="E")
		{

			document.forms[0].txt_operativeaccno.readOnly=true;
		} 

		//document.forms[0].txt_remarks.readOnly=true;
		document.forms[0].txtsubcbsaccno.readOnly=true;
		document.forms[0].seladhoclimit.disabled=true;	
		document.forms[0].seladhocof.disabled=true;
		
		document.forms[0].interestservised.disabled=true;
		document.forms[0].sel_interestcharge.disabled=true;
		document.forms[0].sel_displaydesc.disabled=true;

		document.forms[0].txt_metlifeinsurance.readOnly=true;
		document.forms[0].txt_duedate.readOnly=true;
		document.forms[0].txtcbsaccno.readOnly=true;
		document.forms[0].txt_freshlimitmain.readOnly=true;
		document.forms[0].sel_Processed_Type.disabled=true;
		document.forms[0].sel_Funded_Comp_Name.disabled=true;
		document.forms[0].sel_interesttype.disabled=true;
		document.forms[0].txt_premium_tenor.readOnly=true;
		document.forms[0].txt_premium_loan_amt.readOnly=true;
		document.forms[0].txt_premium_Account_no.readOnly=true;
		document.forms[0].txtmianDate.readOnly=true;
		document.forms[0].Tenormibormain.disabled=true;
		
	}

	if('<%=strCheckFlag%>'=="Y")
	{
      document.forms[0].sel_proposalvaluesin.disabled=true;
      //if(varstrSessionModuleType=="AGR")
      	//document.forms[0].sel_facilityrequired.disabled=true;
	}

	document.forms[0].txt_Limit.value=document.forms[0].txt_totalLimit.value;

	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>

	if(document.forms[0].factype.value=="facility")
	{
	  	document.forms[0].selectgovtmain.value="2";
		document.forms[0].schemetypemain.value="0";
		document.forms[0].sel_sponser_agencymain.value="0";
		document.forms[0].sel_subsidytypemain.value="0";
		document.forms[0].submainamnt.value="";
		document.forms[0].txt_agency.value="";
		document.forms[0].selectgovtmain.disabled=true;

	}
	else
	{
		document.forms[0].selectgovt.value="2";
		document.forms[0].schemetype.value="0";
		document.forms[0].sel_sponser_agency.value="0";
		document.forms[0].sel_subsidytype.value="0";
		document.forms[0].subamt.value="";
		document.forms[0].txt_subagency.value="";
		document.forms[0].selectgovt.disabled=true;
	}

<%}%>

	document.all.idreview.style.display="none";
	document.all.idreviewsub.style.display="none";
}

  function doDelete()
	{
	  <%if((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))){ %>
	  if(varapp_freeze_flag == "Y")
		{
			alert("Coapplicant/guarantor is freezed undo the same and then try");
			return;
		}
		<%}%>
		var factype="";
		if((document.forms[0].selfacilitytype.value == "R" || document.forms[0].selfacilitytype.value == "S") && document.forms[0].txt_subfac_type.value == "Y")
		{
			if(document.forms[0].checkbox.checked==true)
			{
				ShowAlert(187);
				return;
			}
		}
		if(ConfirmMsg(101))
		{
			if(document.forms[0].checkbox.checked==true)
			{
				document.forms[0].factype.value ="sublimit";
				factype="sublimit"
			}
			else
			{
				document.forms[0].factype.value ="facility";
				factype="facility"
			}
		  if(document.forms[0].appno.value!="")
		  {
			  if((factype=="facility") && (document.forms[0].selsno.value==""))
			  {
				  ShowAlert(111,'facility');	
				  return;
			  }
			  else if((factype=="sublimit") && (document.forms[0].selsubsno.value==""))
			  {
				  ShowAlert(111,'Sub-limit');	
				  return;
			  }
			  else
			  {
				  if((document.forms[0].selfacilitytype.value == "R" || document.forms[0].selfacilitytype.value == "S") && document.forms[0].txt_fac_type.value == "Y")
				  {
					  ShowAlert(188);
				  }
			   	assignData();
				document.forms[0].hidAction.value ="delete";
				document.forms[0].hidBeanId.value="facilities";
				document.forms[0].hidBeanMethod.value="updateData";
				document.forms[0].hidBeanGetMethod.value="getFacilityData";
				document.forms[0].hidSourceUrl.value="action/facilities.jsp";	
				document.forms[0].method="post";
				document.forms[0].action=appUrl+"action/controllerservlet";	
				document.forms[0].submit();
			 }
		  }
		  else
		  {
			  ShowAlert(111,'Application');
		  }
		}
		
	
		else
		{
			ShowAlert(158);
		}
	}

function onloading()
{
	if(varncgtccount=="1")
	{
		document.getElementById("ncgtc_button").style.Visibility="Visible";
		document.getElementById("ncgtc_button").style.position="relative";
	}
	else
	{
		document.getElementById("ncgtc_button").style.visibility="hidden";
		document.getElementById("ncgtc_button").style.position="absolute";
	}	
	if(document.forms[0].hid_cgtmse_applicable.value=="Y")
	{
		 document.getElementById("cgtmse_button").style.visibility="visible";
		 document.getElementById("cgtmse_button").style.position="relative";
		 document.forms[0].CGTMSE_coverage.disabled=false;//for cgtmse button
	}
	else
	{
		 document.forms[0].CGTMSE_coverage.disabled=true;
		 document.getElementById("cgtmse_button").style.visibility="hidden";
		 document.getElementById("cgtmse_button").style.position="absolute";
	}
	if(document.forms[0].strappstatus.value!="op")
	{
		//document.forms[0].CGTMSE_coverage.disabled=true;
	} 
	if(document.forms[0].strappstatus.value!="op" || varAppType=="P")
	{
		document.forms[0].hidChecklist.value="Y";
	}
		document.getElementById("cgtmse_financial").style.visibility="hidden";
		document.getElementById("cgtmse_financial").style.position="absolute";
	
	//document.forms[0].CGTMSE_coverage.disabled=false;//for cgtmse button
	//document.getElementById("cgtmse_button").style.visibility="hidden";
	//document.getElementById("cgtmse_button").style.position="absolute";
	//vindhya
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
	if(document.forms[0].hidenwrbankschemecode.value=="074")
	{	
	document.getElementById("eNWR_button").style.visibility="visible";
	document.getElementById("eNWR_button").style.position="relative";
	}
	else
	{
	document.getElementById("eNWR_button").style.visibility="hidden";
	document.getElementById("eNWR_button").style.position="absolute";
	}
	<%}%>
		
<%if((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("R")))
{
%>
		 document.getElementById("cgtmse_fac_button").style.visibility="visible";
		 document.getElementById("cgtmse_fac_button").style.position="relative";
		 document.forms[0].fac_arrangement.disabled=false;
<%	}
	else
	{%>
		 document.getElementById("cgtmse_fac_button").style.visibility="hidden";
		 document.getElementById("cgtmse_fac_button").style.position="absolute";
	<%}%>
	
	var Check="<%=Helper.correctNull((String) hshValues
							.get("strCountcheck"))%>";
	if(Check == "Yes")
	{
    	alert("InValid Application Number Please Enter Valid Application Number");

        document.forms[0].hidBeanId.value="borrowersearch";
        document.forms[0].hidBeanGetMethod.value="getData";

        if(ConfirmMsg(100))
	 	{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comborrowersearch.jsp";
		 	document.forms[0].target="mainFrame";
		 	document.forms[0].submit();
	 	}
	}
	document.all.s4m.style.display="none";
	document.all.s4s.style.visibility="hidden";
	document.all.s4s.style.position="absolute";

	document.all.idschemecode.style.visibility="hidden";
	document.all.idschemecode.style.position="absolute";
	document.forms[0].appno.value = "<%=Helper.correctNull((String) hshValues.get("appno"))%>";
	/*len = document.forms[0].facility_head.length;
	for(k=0;k<len;k++)
	{
		arr = document.facility.facility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==headid)
			{
				document.facility.elements["facility_head"].options[k].selected=true;
				break;
			}
		}
	}*/
/*if(headid!="" && varhidAction!="insert")
	{
document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+headid+"&value=subsel&hidMethod=getFacility&factid="+facid+"&strtype=facility";

	}
	for(k=0;k<len;k++)
	{
		arr = document.facility.subfacility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==subheadid)
			{
				document.facility.elements["subfacility_head"].options[k].selected=true;
				break;
			}
		}
	}*/
if(subheadid!="" && varhidAction!="insert")
	{
		if(!isNaN(subheadid))
		{
			document.forms[0].checkbox.checked=true;
		}
		else
		{
			document.forms[0].checkbox.checked=false;
		}
//document.all.ifrm2.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+subheadid+"&value=subsel&hidMethod=getFacility&factid="+subfacid+"&strtype=sublimit";
	}
	else
	{
		document.forms[0].checkbox.checked=false;
	}


	<%if (strAppno.equals("new")) {%>
		document.forms[0].cmdnew.disabled=true;

		<%}%>
		
	  if(document.forms[0].cmdedit.disabled)
		  editflag=0;
	//if("<%//=strFacCategory.trim()%>"=="R")
	//{
		//document.forms[0].category[0].checked=true;
	//}
	//else if("<%//=strFacCategory.trim()%>"=="A")
	//{
		//document.forms[0].category[1].checked=true;
	//}	
	if(varProposalValue!="")
	{
			document.forms[0].sel_proposalvaluesin.value=varProposalValue;
	}
	else
	{
		document.forms[0].sel_proposalvaluesin.value="S";
	}
	if(varstrSessionModuleType=="AGR") {
		if(varFacilityReq!="")
		{
			document.forms[0].sel_facilityrequired.value=varFacilityReq;
		}
		else
		{
			document.forms[0].sel_facilityrequired.value="N";
		}
	}
	doAfterEdit();
	if(document.forms[0].readFlag.value.toUpperCase()=="R" || document.forms[0].btnenable.value=="N")
	{
		document.forms[0].cmddeleteproposal.disabled=true;
	}
/********* for CC mail********** */
	if("<%=strAppholder%>"=="N")
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddeleteproposal.disabled=true;
	}
	/*************************** */
	if(isNaN(document.forms[0].appno.value))
	{
	document.forms[0].cmddeleteproposal.disabled=true;
	}
	document.forms[0].checkbox.disabled=true;
	
	if(varstrSessionModuleType=="AGR")
	{
	  document.all.lbl_facreq.style.display="table-cell";
	  document.all.txt_facreq.style.display="table-cell";
	}
	else
	{
		 document.all.lbl_facreq.style.display="none";
		  document.all.txt_facreq.style.display="none";
	}
	if('<%=strCheckFlag%>'=="Y")
	{
	  document.forms[0].sel_proposalvaluesin.disabled=true;
	  if(varstrSessionModuleType=="AGR")
	  	document.forms[0].sel_facilityrequired.disabled=true;
	}
	else
	{
	  if(varstrSessionModuleType=="AGR" || varstrSessionModuleType=="CORP")
	  {
	    document.forms[0].sel_proposalvaluesin.value="R";
	    document.forms[0].sel_proposalvaluesin.disabled=true;
	
	  }
		
	}
	if('<%=Helper.correctNull((String)hshValues.get("strLflag"))%>'=="Y")
	{
	  alert("Main Limit Can't be less than Sub Limit");
	  return;
	}
	//if(varstrFreeze=='Y')
	//{
		//document.forms[0].cmdnew.disabled=true;
		//document.forms[0].cmdedit.disabled=true;
		//document.forms[0].cmdsave.disabled=true;
		//document.forms[0].cmddelete.disabled=true;
		//document.forms[0].cmdcancel.disabled=true;
	
	//}
	if(document.forms[0].hidNonPoolFlag.value=="Y" || strSecFreezeflag=="Y")
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}
	if(document.forms[0].selmodepayment.value=="E")
	{
		document.all.opnolabel.style.visibility="visible";
		document.all.opnolabel.style.position="relative";
		document.all.opnovalue.style.visibility="visible";
		document.all.opnovalue.style.position="relative";
	}
	else
	{
		document.forms[0].selmodepayment.value="0";
		document.all.opnolabel.style.visibility="hidden";
    	document.all.opnolabel.style.position="absolute";
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
	}
	if(document.forms[0].selmodepayment_sub.value=="E")
	{
		document.all.opnolabel_sub.style.visibility="visible";
		document.all.opnolabel_sub.style.position="relative";
		document.all.opnovalue_sub.style.visibility="visible";
		document.all.opnovalue_sub.style.position="relative";
	}
	else
	{
		document.forms[0].selmodepayment_sub.value="0";
		document.all.opnolabel_sub.style.visibility="hidden";
    	document.all.opnolabel_sub.style.position="absolute";
		document.all.opnovalue_sub.style.visibility="hidden";
		document.all.opnovalue_sub.style.position="absolute";
	}
	if(document.forms[0].selmodepayment.value=="C")
	{
		document.forms[0].sel_ECSBankName.disabled=false;
		document.forms[0].sel_ECSaccnttype.disabled=false;
		document.forms[0].txt_ECSoperaccno.disabled=false;
		document.forms[0].sel_ECSauthmode.disabled=false;
		document.forms[0].txt_ECSifsccode.disabled=false;
		
		document.all.ECSopnolabel1.style.visibility="visible";
		document.all.ECSopnolabel1.style.position="relative";
		
		document.all.ECSopnovalue1.style.visibility="visible";
		document.all.ECSopnovalue1.style.position="relative";
		
		document.all.ECSopnolabel2.style.visibility="visible";
		document.all.ECSopnolabel2.style.position="relative";
		
		document.all.ECSopnovalue2.style.visibility="visible";
		document.all.ECSopnovalue2.style.position="relative";
		
		document.all.ECSopnolabel3.style.visibility="visible";
		document.all.ECSopnolabel3.style.position="relative";
		
		document.all.ECSopnovalue3.style.visibility="visible";
		document.all.ECSopnovalue3.style.position="relative";
		
		document.all.ECSopnolabel4.style.visibility="visible";
		document.all.ECSopnolabel4.style.position="relative";
		
		document.all.ECSopnovalue4.style.visibility="visible";
		document.all.ECSopnovalue4.style.position="relative";
		
		document.all.ECSopnolabel5.style.visibility="visible";
		document.all.ECSopnolabel5.style.position="relative";
		
		document.all.ECSopnovalue5.style.visibility="visible";
		document.all.ECSopnovalue5.style.position="relative";
		
		document.forms[0].txt_operativeaccno.disabled=true;
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnolabel.style.position="absolute";
		
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
	}
	else
	{
	document.forms[0].txt_operativeaccno.disabled=true;
	//document.forms[0].txt_operativeaccno.value="";
	document.all.opnolabel.style.visibility="hidden";
	document.all.opnolabel.style.position="absolute";
	
	document.all.opnovalue.style.visibility="hidden";
	document.all.opnovalue.style.position="absolute";
	
	document.forms[0].sel_ECSBankName.disabled=true;
	document.forms[0].sel_ECSaccnttype.disabled=true;
	document.forms[0].txt_ECSoperaccno.disabled=true;
	document.forms[0].sel_ECSauthmode.disabled=true;
	document.forms[0].txt_ECSifsccode.disabled=true;
	
	document.all.ECSopnolabel1.style.visibility="hidden";
	document.all.ECSopnolabel1.style.position="absolute";
	
	document.all.ECSopnovalue1.style.visibility="hidden";
	document.all.ECSopnovalue1.style.position="absolute";
	
	document.all.ECSopnolabel2.style.visibility="hidden";
	document.all.ECSopnolabel2.style.position="absolute";
	
	document.all.ECSopnovalue2.style.visibility="hidden";
	document.all.ECSopnovalue2.style.position="absolute";
	
	document.all.ECSopnolabel3.style.visibility="hidden";
	document.all.ECSopnolabel3.style.position="absolute";
	
	document.all.ECSopnovalue3.style.visibility="hidden";
	document.all.ECSopnovalue3.style.position="absolute";
	
	document.all.ECSopnolabel4.style.visibility="hidden";
	document.all.ECSopnolabel4.style.position="absolute";
	
	document.all.ECSopnovalue4.style.visibility="hidden";
	document.all.ECSopnovalue4.style.position="absolute";
	
	document.all.ECSopnolabel5.style.visibility="hidden";
	document.all.ECSopnolabel5.style.position="absolute";
	
	document.all.ECSopnovalue5.style.visibility="hidden";
	document.all.ECSopnovalue5.style.position="absolute";
	}
	<%if(facility_type.equalsIgnoreCase("R")){%>
	document.forms[0].sel_fac_desc.value="2";
	document.forms[0].sel_subfac_desc.value="2";
	<%}else if(facility_type.equalsIgnoreCase("F") || facility_type.equalsIgnoreCase("C")){%>
	document.forms[0].sel_fac_desc.value="1";
	document.forms[0].sel_subfac_desc.value="1";
	<%}else{%>
	document.forms[0].sel_fac_desc.value="2";
	document.forms[0].sel_subfac_desc.value="2";
	<%}%>
	if(document.forms[0].selfacilitytype.value == "R" || document.forms[0].selfacilitytype.value == "S"|| document.forms[0].selfacilitytype.value == "P")
	{
		document.all.Renewed_Facility.style.visibility="visible";
	}else{
		document.all.Renewed_Facility.style.visibility="hidden";
	}
	hideCBSaccountno();
	
	<%if(!strAppno.equals("new") || facility_type.equalsIgnoreCase("R") || facility_type.equalsIgnoreCase("S")||Helper.correctNull((String)hshValues.get("app_onlineupload")).equalsIgnoreCase("Y")){%>
		document.forms[0].inwrd_srch.style.display="none";
	<%}else{%>
		document.forms[0].inwrd_srch.style.display="table-cell";
	<%}%>
	callLeaderBank();
	<%if (strAppno.equals("new") && strSessionModuleType.equalsIgnoreCase("AGR")) {%>
	document.forms[0].selectgovtmain.value="2";
	document.forms[0].selectgovtmain.disabled=true;

	<%}%>

	if(varGrpRights=='r')
	{
		<%if(facility_type.equalsIgnoreCase("S")) {%>
		document.forms[0].cmdremoveaccounts.disabled=true;
		<%}%>
	}
	checktenor();

	if(ecsathunum!="")
	{
		document.forms[0].sel_ECSauthmode.value=ecsathunum;
	}
	else
	{
		document.forms[0].sel_ECSauthmode.value=0;
	}
	
	if(ecsaccntnum!="")
	{
		document.forms[0].sel_ECSaccnttype.value=ecsaccntnum;
	}
	else
	{
		document.forms[0].sel_ECSaccnttype.value=0;
	}
	if(ecsbankname!="")
	{
		document.forms[0].sel_ECSBankName.value=ecsbankname;
	}
	else
	{
		document.forms[0].sel_ECSBankName.value=0;
	}
	if(strFreezeFlag=="Y")	
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}
}

function checktenor(){
	
	/*var varstrTenor=NanNumber(document.forms[0].txt_facmonths.value);
	if(document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D"){
		if(strtenorval<varstrTenor){
			alert("Adhoc/Additional limit tenor value cannot be greater than the Regular limit Tenor");
			document.forms[0].txt_facmonths.value="";
			return;
		}
	}*/
}


function selsub(varFlag1)
{
     if(document.forms[0].selectgovt.value == "1")
	 {
	    document.all.s5.style.visibility="visible";
	    document.all.s5.style.position="relative";	
	    	
	    document.all.s6.style.visibility="visible";
	    document.all.s6.style.position="relative";
	    
    	document.all.s1.style.visibility="visible";
    	document.all.s1.style.position="relative";
    		
    	document.all.s2.style.visibility="visible";
    	document.all.s2.style.position="relative";	
    	
    	document.all.s3.style.visibility="visible";
    	document.all.s3.style.position="relative";	

    	if(trim(document.forms[0].sel_sponser_agency.value)=="OTHERS")
    	{
        	document.all.s4s.style.visibility="visible";
        	document.all.s4s.style.position="relative";	
    	}
    	else
    	{
    		document.all.s4s.style.visibility="hidden";	
        	document.all.s4s.style.position="absolute";
    	}

    	<%if(facility_type.equalsIgnoreCase("P")){%>
		   	 if(varFlag1=="Y")
		        {
		       		document.forms[0].schemetype.disabled=false;
		        	document.forms[0].subamt.readOnly=false;
		        	document.forms[0].sel_sponser_agency.disabled=false;
		        	document.forms[0].sel_subsidytype.disabled=false;
		        	document.forms[0].txt_subagency.readOnly=false; 
		        }
        <%}%>
    	
    }
    else
  	{
    	document.all.s5.style.visibility="hidden";
    	document.all.s5.style.position="absolute";
    	
    	document.all.s6.style.visibility="hidden";
    	document.all.s6.style.position="absolute";
    		
    	document.all.s1.style.visibility="hidden";
    	document.all.s1.style.position="absolute";
    		
    	document.all.s2.style.visibility="hidden";
    	document.all.s2.style.position="absolute";
    		
    	document.all.s3.style.visibility="hidden";	
    	document.all.s3.style.position="absolute";

    	document.all.s4s.style.visibility="hidden";	
    	document.all.s4s.style.position="absolute";

    	document.forms[0].schemetype.value="0";
    	document.forms[0].subamt.value="";
    	document.forms[0].sel_sponser_agency.value="0";
    	document.forms[0].sel_subsidytype.value="0";
    	document.forms[0].txt_subagency.value="";
   	}
}
function selsubmain(varFlag)
{
     if(document.forms[0].selectgovtmain.value == "1")
	 {
	    document.all.s5m.style.visibility="visible";
	    document.all.s5m.style.position="relative";	
	    	
	    document.all.s6m.style.visibility="visible";
	    document.all.s6m.style.position="relative";
	    
    	document.all.s1m.style.visibility="visible";
    	document.all.s1m.style.position="relative";
    		
    	document.all.s2m.style.visibility="visible";
    	document.all.s2m.style.position="relative";	
    	
    	document.all.s3m.style.visibility="visible";
    	document.all.s3m.style.position="relative";	

    	if(trim(document.forms[0].sel_sponser_agencymain.value)=="OTHERS")
    	{
    		document.all.s4m.style.display="table-row";
    	}
    	else
    	{
    		document.all.s4m.style.display="none";	
    	}
    	<%if(facility_type.equalsIgnoreCase("P")){%>
    	 if(varFlag=="Y")
         {
        	document.forms[0].schemetypemain.disabled=false;
         	document.forms[0].submainamnt.readOnly=false;
         	document.forms[0].sel_sponser_agencymain.disabled=false;
         	document.forms[0].sel_subsidytypemain.disabled=false;
         	document.forms[0].txt_agency.readOnly=false; 
         }
         <%}%>
    	
    }
    else
  	{
    	document.all.s5m.style.visibility="hidden";
    	document.all.s5m.style.position="absolute";
    	
    	document.all.s6m.style.visibility="hidden";
    	document.all.s6m.style.position="absolute";
    		
    	document.all.s1m.style.visibility="hidden";
    	document.all.s1m.style.position="absolute";
    		
    	document.all.s2m.style.visibility="hidden";
    	document.all.s2m.style.position="absolute";
    		
    	document.all.s3m.style.visibility="hidden";	
    	document.all.s3m.style.position="absolute";

    	document.all.s4m.style.display="none";

    	document.forms[0].schemetypemain.value="0";
    	document.forms[0].submainamnt.value="";
    	document.forms[0].sel_sponser_agencymain.value="0";
    	document.forms[0].sel_subsidytypemain.value="0";
    	document.forms[0].txt_agency.value="";
   }
}


function getFacilityDesc()
{
	<%if(strSessionModuleType.equalsIgnoreCase("AGR"))
		strModule="a";
	else if(strSessionModuleType.equalsIgnoreCase("CORP"))
		strModule="c";%>
	var varModtype="<%=strModule%>";
	var varFacParent=document.forms[0].facility_head.value;
	var varFacSub=document.forms[0].facility.value;
	var varvaluesIn=document.forms[0].sel_proposalvaluesin.value;
	document.all.ifrmdesc.src=appUrl+"action/iframefacdesc.jsp?hidBeanId=facilities&hidBeanGetMethod=getSetupFacility&strFacParent="+varFacParent+"&strFacSub="+varFacSub+"&subFacFlag=N&strValuesIn="+varvaluesIn+"&moduletype="+varModtype;
 
	
}
function getFacilityDescsub()
{
	<%if(strSessionModuleType.equalsIgnoreCase("AGR"))
		strModule="a";
	else if(strSessionModuleType.equalsIgnoreCase("CORP"))
		strModule="c";%>
	var varModtype="<%=strModule%>";
	var varFacParent=document.forms[0].subfacility_head.value;
	var varFacSub=document.forms[0].subfacility.value;
	var varvaluesIn=document.forms[0].sel_proposalvaluesin.value;
	document.all.ifrmdesc.src=appUrl+"action/iframefacdesc.jsp?hidBeanId=facilities&hidBeanGetMethod=getSetupFacility&strFacParent="+varFacParent+"&strFacSub="+varFacSub+"&subFacFlag=Y&strValuesIn="+varvaluesIn+"&moduletype="+varModtype;

	
}
function checkRange(flag)
{
	var varProposed;
	var index;
	var varFacDesc;
	var s1;
	var varFacMinAmount;
	var varFacMaxAmount;
	
  if(flag=="N")
  {
	  varProposed=document.forms[0].txt_proposed_limit.value;	
      varFacDesc=document.forms[0].facilitydesc.value;
  }
  else if(flag=="Y")
  {

	  varProposed=document.forms[0].txt_subproposed_limit.value;	 
      varFacDesc=document.forms[0].facilitydescsub.value;
  }
      
    
      s1=varFacDesc.split("-");
      varFacMinAmount=s1[1];
      varFacMaxAmount=s1[2];
    
      if(varProposed!="")
      {

     if((parseFloat(varProposed)<parseFloat(varFacMinAmount)) || (parseFloat(varProposed)>parseFloat(varFacMaxAmount)))
     {
//alert("varProposed"+varProposed);
//alert("varFacMinAmount"+varFacMinAmount);
//alert("varFacMaxAmount"+varFacMaxAmount);
	  alert("Proposed limit should be with in the facility range");
	  if(flag=="N")
	  {
		 document.forms[0].txt_proposed_limit.value="";
	     document.forms[0].txt_proposed_limit.focus();
	  }
	  else if(flag=="Y")
	  {
		  document.forms[0].txt_subproposed_limit.value="";
		  document.forms[0].txt_subproposed_limit.focus();
	  }	
	  return;
	 
     }
     else
     {
    	 if(flag=="N")
    	 {
    		 if((document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D")&&false)
        	 {
            	 if(document.forms[0].seladhocof.value!="")
            	 {
            		 var varMainLimit=document.forms[0].seladhocof.value.split("~");
           			 if(parseFloat(varMainLimit[2])<parseFloat(document.forms[0].txt_proposed_limit.value))
           			 {
           				alert("Limit value should not be greater than "+roundVal(varMainLimit[2]));
           				document.forms[0].txt_proposed_limit.value="";
           				return;
           			 } 
            	 }
        	 }
	       	getInterestSetup('N');
    	 }
    	 else if(flag=="Y")
    	 {
        	 if((document.forms[0].selsubadhoclimit.value=="A"||document.forms[0].selsubadhoclimit.value=="D")&&false)
        	 {
            	 if(document.forms[0].selsubadhocof.value!="")
            	 {
            		 var varamt1=document.forms[0].selsubadhocof.value.split("~");
            		 var varSubTotal=parseFloat(varamt1[2])+parseFloat(document.forms[0].txt_subproposed_limit.value);
            		 var varMainLimit=document.forms[0].seladhocof.value.split("~");
            		 var varMainTotal=parseFloat(NanNumber(parseFloat(varMainLimit[2])))+parseFloat(document.forms[0].txt_proposed_limit.value);
           			 if(parseFloat(varSubTotal)>parseFloat(varMainTotal))
           			 {
           				alert("Limit value should not be greater than "+roundVal(parseFloat(varMainTotal)-parseFloat(varamt1[2])));
           				document.forms[0].txt_subproposed_limit.value="";
           				return;
           			 } 
            	 }
        	 }
    		 getInterestSetupSub('N');
    	 }

     } 
      } 

      <%if((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))){ %>
      if(flag=="N")
      {
    	  varProposed=document.forms[0].txt_proposed_limit.value;	
    	  if((parseFloat(varProposed)>parseFloat(document.forms[0].hidFacExLimit.value)))
          {
     	 	 alert("Proposed limit should not be greater than "+roundtxt(document.forms[0].hidFacExLimit));
     		 document.forms[0].txt_proposed_limit.value=document.forms[0].hidFacExLimit.value;
          }
      }
      else if(flag=="Y")
      {

    	  varProposed=document.forms[0].txt_subproposed_limit.value;
    	  var varPSterms1 = document.forms[0].hidSubPStermsSelected.value.split("@");
  		for(var i=0;i<varPSterms1.length;i++)
  		{
  			/*if(varPSterms1[i] == "DLA")
  			{
  				 if((parseFloat(varProposed)>parseFloat(document.forms[0].hidSubFacExLimit.value)))
  		          {
  		     	 	 alert("Proposed limit should not be greater than "+roundtxt(document.forms[0].hidSubFacExLimit));
  		     		 document.forms[0].txt_subproposed_limit.value=document.forms[0].hidSubFacExLimit.value;
  		          }
  			}*/
  			if(varPSterms1[i] == "INLIM")
  			{
  				 if((parseFloat(varProposed)<parseFloat(document.forms[0].hidSubFacExLimit.value)))
  		          {
  		     	 	 alert("Proposed limit should not be lesser than "+roundtxt(document.forms[0].hidSubFacExLimit));
  		     		 document.forms[0].txt_subproposed_limit.value=document.forms[0].hidSubFacExLimit.value;
  		          }
  			}
  		}
    	 	 
      }

      
      <%}%>
  
	
}

function checkRangeTenor(flag,bflag)
{
	var varProposed;
	var index;
	var varFacDesc;
	var s1;
	var varFacMinAmount;
	var varFacMaxAmount;
	var varmoratorium;
	
  if(flag=="N")
  {
	  varProposed=document.forms[0].txt_facmonths.value;	 
      varFacDesc=document.forms[0].facilitydesc.value;
      varmoratorium=eval(document.forms[0].txt_installments.value);
  }
  else if(flag=="Y")
  {

	  varProposed=document.forms[0].txt_subfacmonths.value;	 
      varFacDesc=document.forms[0].facilitydescsub.value;
      varmoratorium=eval(document.forms[0].txt_installments_sub.value);
  }

  if(varmoratorium=="")
  {
	  varmoratorium=0;
  }
      s1=varFacDesc.split("-");
      varFacMinAmount=s1[3];
      varFacMaxAmount=s1[4];

      if(varProposed!="")
      {
     if((parseFloat(varProposed)<parseFloat(varFacMinAmount)) || (parseFloat(varProposed)>parseFloat(varFacMaxAmount)))
     {

	  alert("Tenor should be with in the facility range");
	  if(flag=="N")
	  {
	     document.forms[0].txt_facmonths.focus();
	     document.forms[0].txt_facmonths.value="";
	  }
	  else if(flag=="Y")
	  {
		  document.forms[0].txt_subfacmonths.focus();
		  document.forms[0].txt_subfacmonths.value="";
	  }	
	  if(bflag=="N")
	  {
	 	 return false;
	  }
	  else
	  {
		  if(flag=="N")
		  {
		  	  document.forms[0].txt_facmonths.value=document.forms[0].hidFacExTenor.value;
		  }
		  else if(flag=="Y")
		  {
			  document.forms[0].txt_subfacmonths.value=document.forms[0].hidSubFacExTenor.value;
		  }
	  }
		 	 
     }
     else
     {
    	 if(parseInt(varmoratorium)>parseInt(varProposed))
         {
       	  alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than Repayment Period");
		  if(flag=="N")
		  {
			  document.forms[0].txt_facmonths.value=document.forms[0].hid_facmonths.value;
		  }
		  else
		  {
			  document.forms[0].txt_subfacmonths.value=document.forms[0].hid_subfacmonths.value;
		  }
         }
		  
    	 if(flag=="N")
    	 {
	       getInterestSetup('N');
    	 }
    	 else if(flag=="Y")
    	 {
    		 getInterestSetupSub('N');
    	 }

     } 
      } 


      <%if((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))){ %>
      if(bflag=="Y")
      {
		var varPSterms3="";
		if(flag=="N")
	    {
    	  varPSterms3 = document.forms[0].hidPStermsSelected.value.split("@");
	    }
		else
		{
			varPSterms3 = document.forms[0].hidSubPStermsSelected.value.split("@");
		}
	  		for(var i=0;i<varPSterms3.length;i++)
	  		{
		  		if(varPSterms3[i]=="DLP")
		  		{
				      if(flag=="N")
				      {
				    	  varProposed=document.forms[0].txt_facmonths.value;	
				    	  if((parseFloat(varProposed)>parseFloat(document.forms[0].hidFacExTenor.value)))
				          {
				     	 	 alert("Tenor should not be greater than "+document.forms[0].hidFacExTenor.value);
				     		 document.forms[0].txt_facmonths.value=document.forms[0].hidFacExTenor.value;
				          }
				      }
				      else if(flag=="Y")
				      {
				
				    	  varProposed=document.forms[0].txt_subfacmonths.value;
				    	  if((parseFloat(varProposed)>parseFloat(document.forms[0].hidSubFacExTenor.value)))
				          {
				     	 	 alert("Tenor should not be greater than "+document.forms[0].hidSubFacExTenor.value);
				     		 document.forms[0].txt_subfacmonths.value=document.forms[0].hidSubFacExTenor.value;
				          }	 
				      }
		  		}
	  		}

      }
      <%}%>

    if((flag=="N") && (document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D") && document.forms[0].seladhocof.value!="")
  	{
  		var varamt=document.forms[0].seladhocof.value.split("~");

  		if(varamt[5]=="" && varamt[0]==document.forms[0].appno.value)
   		{
  	  	
  	  		alert("Enter facility due date in Base facility");
  	  		document.forms[0].txt_facmonths.value="";
  	  		return;
  		}
  		else if(document.forms[0].txt_duedate.value=="")
  		{
  			document.forms[0].txt_duedate.value=varamt[5];
  	  			
  		}
  		if(parseFloat(varamt[3])<parseFloat(document.forms[0].txt_facmonths.value))
  		{
  			alert("Facility Tenor should not greater than "+varamt[3]+" months");
  			document.forms[0].txt_facmonths.value="";
  			document.forms[0].txt_facmonths.focus();
  			return;
  		}
  	}
  	if( (flag=="Y") && ((document.forms[0].selsubadhoclimit.value=="A"||document.forms[0].selsubadhoclimit.value=="D") && document.forms[0].selsubadhocof.value!=""))
  	{
  		var varamt1=document.forms[0].selsubadhocof.value.split("~");
  	if(varamt[5]=="" && varamt[0]==document.forms[0].appno.value)
  		{	alert("Enter facility due date in Base facility");
  	  		document.forms[0].txt_subfacmonths.value="";
  	  		return;
  		}
  		else if(document.forms[0].txt_subduedate.value=="")
  		{
  			document.forms[0].txt_subduedate.value=varamt1[5];
  	  			
  		}
  		if(parseFloat(varamt1[3])<parseFloat(document.forms[0].txt_subfacmonths.value))
  		{
  			alert("Facility Tenor should not greater than "+varamt1[3]+" months");
  			document.forms[0].txt_subfacmonths.value="";
  			document.forms[0].txt_subfacmonths.focus();
  			return;
  		}
  	}

      return true;

	
}


function moratperiod(Aflag)
{
   //alert("1"+document.forms[0].facilitydesc.value);
	var varFacDesc=document.forms[0].facilitydesc.value;
	
	var s1=varFacDesc.split("-");
	var varmort1=s1[5];
    if(eval(varmort1)<eval(document.forms[0].txt_installments.value))
	{
		alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than "+varmort1);
		document.forms[0].txt_installments.value="";
		document.forms[0].txt_installments.focus();
		return false;
	}

      
	 <%if(!((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")))){ %>

	if(document.forms[0].txt_installments.value=='0' || document.forms[0].txt_installments.value=='')
	{
		document.forms[0].interestservised.value="s"; 
	    document.forms[0].interestservised.disabled=true;
		document.forms[0].sel_interestcharge.value="3"; 
	    document.forms[0].sel_interestcharge.disabled=true;		
	    document.all.newid.style.visibility="hidden";
	    document.all.newid.style.position="absolute";
	}
	else
	{
		var varrepayperiod="";
		var varmoratorium="";
		varrepayperiod=document.forms[0].txt_facmonths.value;
		varmoratorium=document.forms[0].txt_installments.value;
		document.all.newid.style.visibility="visible";
	    document.all.newid.style.position="relative";
		if(eval(varrepayperiod)<=eval(varmoratorium))
		{
			alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than Repayment Period");
			document.forms[0].txt_installments.value="";
			document.forms[0].txt_installments.focus();
			return false;
		}
		else
		{
			document.forms[0].interestservised.disabled=false;	
		}
	}
	
	<%}else{%>
	if(document.forms[0].txt_installments.value!='')
	{
		var varrepayperiod="";
		var varmoratorium="";
		if(varEditFlag==false)
		{
			varrepayperiod=document.forms[0].txt_facmonths.value;
		}
		else
		{
			varrepayperiod=document.forms[0].hid_facmonths.value;
		}
		varmoratorium=document.forms[0].txt_installments.value;
		var varhidmoratorium=document.forms[0].hid_installments.value;
		if(varhidmoratorium=="")
		{
			varhidmoratorium=0;
		}
		

			varrepayperiod=eval(varrepayperiod)+eval(varmoratorium)-eval(varhidmoratorium);
		
		 var varPSterms2 = document.forms[0].hidPStermsSelected.value.split("@");
	  		for(var i=0;i<varPSterms2.length;i++)
	  		{
		  		if(varPSterms2[i]=="CHDCCO")
		  		{
		  			document.forms[0].txt_facmonths.value=varrepayperiod;

		  			boolflag=true;
		  			boolflag=checkRangeTenor('N','N');
		  			if(boolflag==false)
		  			{
		  				 document.forms[0].txt_facmonths.value=eval(document.forms[0].hidFacExTenor.value)+eval(varhidmoratorium);
		  	     		 document.forms[0].txt_installments.value=varhidmoratorium;
		  			}
		  		}
		  		if(varPSterms2[i]=="DLP")
		  		{
			  		if(eval(document.forms[0].hidFacExTenor.value)<eval(varrepayperiod))
			  		{
			  			 alert("Tenor should not be greater than "+document.forms[0].hidFacExTenor.value);
			     		 document.forms[0].txt_facmonths.value=document.forms[0].hid_facmonths.value;
			     		 document.forms[0].txt_installments.value=varhidmoratorium;
			     		 return;
			  		}
		  		}
	  		}

	  		if(eval(document.forms[0].txt_facmonths.value)<=eval(varmoratorium))
			{
				alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than Repayment Period");
				document.forms[0].txt_installments.value="";
				document.forms[0].txt_facmonths.value=document.forms[0].hid_facmonths.value;
				document.forms[0].txt_installments.focus();
				return false;
			}

	}
	if(Aflag=="Y")
	{
		varEditFlag=true;
	}
	<%}%>
}

function moratperiod1(CFlag)
{
	//alert("2"+document.forms[0].facilitydescsub.value);
	var varFacDesc=document.forms[0].facilitydescsub.value;
	var s1=varFacDesc.split("-");
	var varmort1=s1[5];

    if(eval(varmort1)<eval(document.forms[0].txt_installments_sub.value))
	{
		alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than "+varmort1);
		document.forms[0].txt_installments_sub.value="";
		document.forms[0].txt_installments_sub.focus();
		return false;
	}

	 <%if(!((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")))){ %>
	if(document.forms[0].txt_installments_sub.value=='0' || document.forms[0].txt_installments_sub.value=='')
	{
		document.forms[0].interestservised_sub.value="s"; 
	    document.forms[0].interestservised_sub.disabled=true;
	    document.forms[0].sel_interestcharge_sub.value="3"; 
	    document.forms[0].sel_interestcharge_sub.disabled=true;	
	    document.all.newid1.style.visibility="hidden";
	    document.all.newid1.style.position="absolute";
	}
	else
	{
		var varrepayperiod="";
		var varmoratorium="";
		varrepayperiod=document.forms[0].txt_subfacmonths.value;
		varmoratorium=document.forms[0].txt_installments_sub.value;
		document.all.newid1.style.visibility="visible";
	    document.all.newid1.style.position="relative";
		if(eval(varrepayperiod)<=eval(varmoratorium))
		{
			alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than Repayment Period");
			document.forms[0].txt_installments_sub.value="";
			document.forms[0].txt_installments_sub.focus();
			return false;
		}
		else
		{
			document.forms[0].interestservised_sub.disabled=false;	
		}
	}
	<%}else{%>
	if(document.forms[0].txt_installments_sub.value!='')
	{
		var varrepayperiod="";
		var varmoratorium="";
		if(varEditSubFlag==false)
		{
			varrepayperiod=document.forms[0].txt_subfacmonths.value;
		}
		else
		{
			varrepayperiod=document.forms[0].hid_subfacmonths.value;
		}
		varmoratorium=document.forms[0].txt_installments_sub.value;
		var varhidmoratorium=document.forms[0].hid_installments_sub.value;
		if(varhidmoratorium=="")
		{
			varhidmoratorium=0;
		}
		

		varrepayperiod=eval(varrepayperiod)+eval(varmoratorium)-eval(varhidmoratorium);
		document.forms[0].txt_subfacmonths.value=varrepayperiod;
		 var varPSterms2 = document.forms[0].hidSubPStermsSelected.value.split("@");
	  		for(var i=0;i<varPSterms2.length;i++)
	  		{
		  		if(varPSterms2[i]=="CHDCCO")
		  		{
		  			document.forms[0].txt_subfacmonths.value=varrepayperiod;

		  			boolflag=true;
		  			boolflag=checkRangeTenor('Y','N');

		  			if(boolflag==false)
		  			{
		  				 document.forms[0].txt_subfacmonths.value=eval(document.forms[0].hidSubFacExTenor.value)+eval(varhidmoratorium);
		  	     		 document.forms[0].txt_installments_sub.value=varhidmoratorium;
		  			}
		  		}
		  		if(varPSterms2[i]=="DLP")
		  		{
			  		if(eval(document.forms[0].hidSubFacExTenor.value)<eval(varrepayperiod))
			  		{
			  			 alert("Tenor should not be greater than "+document.forms[0].hidSubFacExTenor.value);
			     		 document.forms[0].txt_subfacmonths.value=document.forms[0].hid_subfacmonths.value;
			     		 document.forms[0].txt_installments_sub.value=varhidmoratorium;
			     		 return;
			  		}
		  		}
	  		}

	  		if(eval(document.forms[0].txt_subfacmonths.value)<=eval(varmoratorium))
			{
				alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than Repayment Period");
				document.forms[0].txt_installments_sub.value="";
				document.forms[0].txt_subfacmonths.value=document.forms[0].hid_subfacmonths.value;
				document.forms[0].txt_installments_sub.focus();
				return false;
			}
	}
	if(CFlag=="Y")
	{
		varEditSubFlag=true;
	}
	<%}%>
}
function callInterestCharged(val)
{

	<%if(!((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")))){ %>
	if(document.forms[0].txt_installments.value>'0')
	{
	if(document.forms[0].interestservised.value=="n")
	{
		document.forms[0].sel_interestcharge.options[1].selected=true;
		document.forms[0].sel_interestcharge.disabled=true;
	}
	else
	{
		document.forms[0].sel_interestcharge.options[0].selected=true;
		document.forms[0].sel_interestcharge.disabled=true;
	}
	}
	<%}%>
}

function callInterestCharged1()
{
	 <%if(!((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")))){ %>
	if(document.forms[0].txt_installments_sub.value>'0')
	{
	if(document.forms[0].interestservised_sub.value=="n")
	{
		document.forms[0].sel_interestcharge_sub.options[1].selected=true;
		document.forms[0].sel_interestcharge_sub.disabled=true;
	}
	else
	{
		document.forms[0].sel_interestcharge_sub.options[0].selected=true;
		document.forms[0].sel_interestcharge_sub.disabled=true;
	}
	}
	<%}%>
}

function funenablefitl()
{
	<%if(facility_type.equalsIgnoreCase("S")) {%>
		if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].facility_nature.value == "2")
		{
			document.all.idrestr1.style.visibility="visible";
			document.all.idrestr1.style.position="relative";
			document.all.idrestr2.style.visibility="visible";
			document.all.idrestr2.style.position="relative";
			document.all.idrestr3.style.visibility="visible";
			document.all.idrestr3.style.position="relative";
			document.all.id_restr_scheme.style.visibility="visible";
			document.all.id_restr_scheme.style.position="relative";
			document.all.id_restr_scheme1.style.visibility="visible";
			document.all.id_restr_scheme1.style.position="relative";
			if(document.forms[0].sel_restr_scheme.value=="27"||document.forms[0].sel_restr_scheme.value=="28" ||document.forms[0].sel_restr_scheme.value=="29"){

			document.all.idrestrinvoc.style.display="table-row";
			}
			document.all.res_label.innerHTML = "Whether FITL Account";
		}
		else if(document.forms[0].selfac_restr_acc.value=="Y" && document.forms[0].facility_nature.value == "1")
		{
			document.all.idrestr1.style.visibility="visible";
			document.all.idrestr1.style.position="relative";
			document.all.idrestr2.style.visibility="visible";
			document.all.idrestr2.style.position="relative";
			document.all.idrestr3.style.visibility="visible";
			document.all.idrestr3.style.position="relative";
	
			document.all.res_label.innerHTML = "Whether Renewal of existing OD account";

			document.all.id_restr_scheme.style.visibility="visible";
			document.all.id_restr_scheme.style.position="relative";
			document.all.id_restr_scheme1.style.visibility="visible";
			document.all.id_restr_scheme1.style.position="relative";
			if(document.forms[0].sel_restr_scheme.value=="27"||document.forms[0].sel_restr_scheme.value=="28" ||document.forms[0].sel_restr_scheme.value=="29"){
				document.all.idrestrinvoc.style.display="table-row";
				}
		}
		else if(document.forms[0].selfac_restr_acc.value=="N" && document.forms[0].facility_nature.value == "1")
		{
			document.all.idrestr1.style.visibility="visible";
			document.all.idrestr1.style.position="relative";
			document.all.idrestr2.style.visibility="visible";
			document.all.idrestr2.style.position="relative";
			document.all.idrestr3.style.visibility="hidden";
			document.all.idrestr3.style.position="absolute";
	
			document.all.res_label.innerHTML = "Whether Renewal of existing OD account";

			document.all.id_restr_scheme.style.visibility="hidden";
			document.all.id_restr_scheme.style.position="absolute";
			document.all.id_restr_scheme1.style.visibility="hidden";
			document.all.id_restr_scheme1.style.position="absolute";

			document.all.idrestrinvoc.style.display="none";

		}
		else
		{
			document.all.idrestr1.style.visibility="hidden";
			document.all.idrestr1.style.position="absolute";
			document.all.idrestr2.style.visibility="hidden";
			document.all.idrestr2.style.position="absolute";
			document.all.idrestr3.style.visibility="hidden";
			document.all.idrestr3.style.position="absolute";
			document.forms[0].selfac_fitl_acc.value="";
			document.forms[0].sel_restr_conversionfac.value="";
			document.forms[0].sel_restr_addfunding.value="";
			document.all.id_restr_scheme.style.visibility="hidden";
			document.all.id_restr_scheme.style.position="absolute";
			document.all.id_restr_scheme1.style.visibility="hidden";
			document.all.id_restr_scheme1.style.position="absolute";
			document.all.idrestrinvoc.style.display="none";
		}

		for(var i=0;i<document.forms[0].sel_restr_acc.options.length;i++)
		{
			document.forms[0].sel_restr_acc.options[i].selected = false;
		}
		document.all.id_restracc.style.display="none";
		document.all.id_restracc1.style.display="none";
	<%}%>
}


function funenablesubfitl()
{
	<%if(facility_type.equalsIgnoreCase("S")) {%>
	if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "2")
	{
		document.all.idsubfacrestr1.style.visibility="visible";
		document.all.idsubfacrestr1.style.position="relative";
		document.all.idsubfacrestr2.style.visibility="visible";
		document.all.idsubfacrestr2.style.position="relative";
		document.all.idsubfacrestr3.style.visibility="visible";
		document.all.idsubfacrestr3.style.position="relative";
		document.all.id_restr_scheme_sub.style.visibility="visible";
		document.all.id_restr_scheme_sub.style.position="relative";
		document.all.id_restr_scheme_sub1.style.visibility="visible";
		document.all.id_restr_scheme_sub1.style.position="relative";

		document.all.res_label_sub.innerHTML = "Whether FITL Account";
	}
	else if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "1")
	{
		document.all.idsubfacrestr1.style.visibility="visible";
		document.all.idsubfacrestr1.style.position="relative";
		document.all.idsubfacrestr2.style.visibility="visible";
		document.all.idsubfacrestr2.style.position="relative";
		document.all.idsubfacrestr3.style.visibility="visible";
		document.all.idsubfacrestr3.style.position="relative";

		document.all.res_label_sub.innerHTML = "Whether Renewal of existing OD account";

		document.all.id_restr_scheme_sub.style.visibility="visible";
		document.all.id_restr_scheme_sub.style.position="relative";
		document.all.id_restr_scheme_sub1.style.visibility="visible";
		document.all.id_restr_scheme_sub1.style.position="relative";
	}
	else if(document.forms[0].selsubfac_restr_acc.value=="N" && document.forms[0].facilitysub_nature.value == "1")
	{
		document.all.idsubfacrestr1.style.visibility="visible";
		document.all.idsubfacrestr1.style.position="relative";
		document.all.idsubfacrestr2.style.visibility="visible";
		document.all.idsubfacrestr2.style.position="relative";
		document.all.idsubfacrestr3.style.visibility="hidden";
		document.all.idsubfacrestr3.style.position="absolute";

		document.all.res_label_sub.innerHTML = "Whether Renewal of existing OD account";

		document.all.id_restr_scheme_sub.style.visibility="hidden";
		document.all.id_restr_scheme_sub.style.position="absolute";
		document.all.id_restr_scheme_sub1.style.visibility="hidden";
		document.all.id_restr_scheme_sub1.style.position="absolute";
	}
	else
	{
		document.all.idsubfacrestr1.style.visibility="hidden";
		document.all.idsubfacrestr1.style.position="absolute";
		document.all.idsubfacrestr2.style.visibility="hidden";
		document.all.idsubfacrestr2.style.position="absolute";
		document.all.idsubfacrestr3.style.visibility="hidden";
		document.all.idsubfacrestr3.style.position="absolute";
		document.forms[0].selsubfac_fitl_acc.value="";
		document.forms[0].sel_restr_conversionfac_sub.value="";
		document.forms[0].sel_restr_addfunding_sub.value="";
		document.all.id_restr_scheme_sub.style.visibility="hidden";
		document.all.id_restr_scheme_sub.style.position="absolute";
		document.all.id_restr_scheme_sub1.style.visibility="hidden";
		document.all.id_restr_scheme_sub1.style.position="absolute";
	}

	for(var i=0;i<document.forms[0].sel_restr_acc_sub.options.length;i++)
	{
		document.forms[0].sel_restr_acc_sub.options[i].selected = false;
	}
	document.all.id_restracc_sub.style.display="none";
	document.all.id_restracc_sub1.style.display="none";
	<%}%>
}

function changeCEFAFsub()
{
	if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "1")
	{
		document.forms[0].sel_restr_conversionfac_sub.value="N";
		document.forms[0].sel_restr_addfunding_sub.value="N";
		document.forms[0].sel_restr_conversionfac_sub.disabled=true;
		document.forms[0].sel_restr_addfunding_sub.disabled=true;
		document.all.id_restracc_sub.style.display="table-cell";
		document.all.id_restracc_sub1.style.display="table-cell";
		document.forms[0].sel_subfac_desc.value="2";
	}
	else if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "2")
	{
		document.forms[0].sel_restr_conversionfac_sub.value="N";
		document.forms[0].sel_restr_addfunding_sub.value="Y";
		document.forms[0].sel_restr_conversionfac_sub.disabled=true;
		document.forms[0].sel_restr_addfunding_sub.disabled=true;
		document.all.id_restracc_sub.style.display="table-cell";
		document.all.id_restracc_sub1.style.display="table-cell";
		document.forms[0].sel_subfac_desc.value="1";
	}
	else if(document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
	{
		document.forms[0].sel_restr_conversionfac_sub.disabled=false;
		document.forms[0].sel_restr_addfunding_sub.disabled=false;
		document.all.id_restracc_sub.style.display="none";
		document.all.id_restracc_sub1.style.display="none";
	}
	else if(document.forms[0].selsubfac_restr_acc.value=="N" && document.forms[0].selsubfac_fitl_acc.value=="Y" && document.forms[0].facilitysub_nature.value == "1")
	{
		document.all.id_restracc_sub.style.display="table-cell";
		document.all.id_restracc_sub1.style.display="table-cell";
		document.forms[0].sel_subfac_desc.value="2";
	}
	else
	{
		document.all.id_restracc_sub.style.display="none";
		document.all.id_restracc_sub1.style.display="none";
		document.forms[0].sel_subfac_desc.value="1";
	}

	if(document.forms[0].sel_restr_conversionfac_sub.value=="NA" && document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
	{
		document.forms[0].sel_restr_addfunding_sub.value="NA";
		document.forms[0].sel_subfac_desc.value="3";
		document.all.id_restracc_sub.style.display="table-cell";
		document.all.id_restracc_sub1.style.display="table-cell";
		document.forms[0].sel_restr_addfunding_sub.disabled=true;
	}
	else if(document.forms[0].sel_restr_conversionfac_sub.value=="Y" && document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
	{
		document.forms[0].sel_restr_addfunding_sub.value="N";
		document.forms[0].sel_restr_addfunding_sub.disabled=true;
		document.all.id_restracc_sub.style.display="table-cell";
		document.all.id_restracc_sub1.style.display="table-cell";
		document.forms[0].sel_subfac_desc.value="1";
	}
	else if(document.forms[0].sel_restr_conversionfac_sub.value=="N" && document.forms[0].selsubfac_restr_acc.value=="Y" && document.forms[0].selsubfac_fitl_acc.value=="N")
	{
		document.forms[0].sel_restr_addfunding_sub.value="Y";
		document.forms[0].sel_restr_addfunding_sub.disabled=true;
		document.forms[0].sel_subfac_desc.value="1";
	}
}

function callrepayfunction(varstrSessionModuleType,varfacType,varfacid,varrepay)
{
	document.all.ifrmrepayment.src=appURL+"action/iframerepaymenttype.jsp?hidBeanGetMethod=getRepaymentTypeData&hidBeanId=setproducts&strPrdcode="+varfacid+"&strRepayType="+varrepay+"&strModType="+varstrSessionModuleType+"&strFacType="+varfacType;
}
function selsubperiodicity()
{
	if((document.forms[0].facilitysub_nature.value=="2"))
	{
		if(document.forms[0].sel_peridicityfacsub.value=="n")
		{
			alert("Periodicity of installment value should not be Not Applicable");
			document.forms[0].sel_peridicityfacsub.value="s";
			return;
		}
	}
}

function calladhoc(varchk)
{
	var varsno=document.forms[0].selsno.value;
	var varsubsno=document.forms[0].selsubsno.value;
	var varheadid=document.forms[0].facility_head_id_code.value;
	var varsubheadid=document.forms[0].facility_id_code.value;
	if(document.forms[0].seladhoclimit.value=="A"||document.forms[0].seladhoclimit.value=="D")
	{
		if(varchk=="Y" && document.forms[0].txt_accountopenflag.value=="N" &&(document.forms[0].facility_head_id_code.value=="3"||document.forms[0].facility_head_id_code.value=="4"||document.forms[0].facility_head_id_code.value=="5"))
		{
			alert("Adhoc/Additional limit cannot be added for Overdraft/Term Loan/DPN Facilities");
			return;
		}
		if(varchk=="Y" && document.forms[0].hidAdhocchk.value=="Y")
		{
			alert("This Limit  is already a base for the following Limit ("+document.forms[0].hidAdhocsno.value+"-"+document.forms[0].hidadhocDesc.value+")");
			document.forms[0].seladhoclimit.value="R";
			return;
		}
		//if(varchk=="Y" && document.forms[0].hidGrpSize.value!="" && document.forms[0].hidGrpSize.value!="0")
		{
			//alert("This Limit contains sub limit,so you cannot change this to Adhoc Limit");
			//document.forms[0].seladhoclimit.value="R";
			//return;
		}
		if(varchk=="N" && document.forms[0].checkbox.checked==true)
		{
			varsno=document.forms[0].selsubsno.value;
			varsubsno="0";
		}

		document.all.idadhoc.style.display="table-cell";
		document.all.idadhoc1.style.display="table-cell";
		document.all.ifrmadhoclimit.src=appURL+"action/ifrmadhoclimit.jsp?hidBeanGetMethod=getLoadAdhocFacilities&hidBeanId=facilities&appid="+document.forms[0].comapp_id.value+"&apptype="+varstrSessionModuleType+"&facGroup=M&sno="+varsno+"&subsno="+varsubsno+"&appno="+document.forms[0].appno.value+"&strHeadId="+varheadid+"&strSubHeadId="+varsubheadid+"&strLimitType="+document.forms[0].seladhoclimit.value;
	}
	else if(document.forms[0].seladhoclimit.value=="R" && varchk=="Y")
	{
		document.all.ifrmadhoclimit.src=appURL+"action/ifrmadhoclimit.jsp?hidBeanGetMethod=getLoadAdhocFacilities&hidBeanId=facilities&appid="+document.forms[0].comapp_id.value+"&apptype="+varstrSessionModuleType+"&facGroup=M&sno="+varsno+"&subsno="+varsubsno+"&appno="+document.forms[0].appno.value+"&strHeadId="+varheadid+"&strSubHeadId="+varsubheadid+"&strLimitType="+document.forms[0].seladhoclimit.value;
	}
	else
	{
		document.forms[0].seladhocof.value="";
		document.all.idadhoc.style.display="none";
		document.all.idadhoc1.style.display="none";
	}
}


function chkfacilityMCLR(type)
{
	
	if(type=="0")
	{
		if(parseInt(vardatediff)>=0)
		{
			if(document.forms[0].sel_inttype.value=="Flo"){
				if(document.forms[0].sel_intsutype.value=="BR" ||document.forms[0].sel_intsutype.value=="BRLEC"){
					alert("Option not applicable");
					document.forms[0].sel_intsutype.value="0";
					return;
				}
		    }
		}
	}
	else if(type=="1")
	{
		if(parseInt(vardatediff)>=0)
		{
			   if(document.forms[0].sel_inttype.value=="Flo"){
				if(document.forms[0].sel_intsutype.value=="BR" ||document.forms[0].sel_intsutype.value=="BRLEC" ){
					alert("Option not applicable");
					document.forms[0].sel_intsutype.value="0";
					return;
				}
		       }
	    }
	}

	if(varAppType=="P")
	{
		var varpsmodifiedTerms; 
		if(type=="0")
	    {
			varpsmodifiedTerms = document.forms[0].hidPStermsSelected.value.split("@");
	    }
		else if(type=="1")
		{
			varpsmodifiedTerms = document.forms[0].hidSubPStermsSelected.value.split("@");
		}
		for(var i=0;i<varpsmodifiedTerms.length;i++)
		{
		  	if(varpsmodifiedTerms[i]=="BRTOMCLR")
		  	{
		  		if(type=="0")
			    {
		  			if((document.forms[0].facility_head_id_code.value=="2") || (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="31")|| (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="93"))
		  			{
		  				if(document.forms[0].sel_intsutype.value!="MCLEC" && document.forms[0].sel_intsutype.value!="EBLEC")
		  				{
		  					alert("Option not applicable");
		  					document.forms[0].sel_intsutype.value="0";
		  					return;
		  				}
		  			}
		  			else
		  			{
					if(document.forms[0].sel_intsutype.value!="MCLR" && document.forms[0].sel_intsutype.value!="MCLEC"&& document.forms[0].sel_intsutype.value!="SMTB"&& document.forms[0].sel_intsutype.value!="TYGS")
					{
						alert("Interest Sub type should be MCLR / MCLR Linked Export Limit/6 MONTHS TREASURY BILL/10 Years Govt Security");
						document.forms[0].sel_intsutype.value="0";
						document.forms[0].sel_intsutype.focus();
						return;
					}
			    }
			    }
				else if(type=="1")
				{
					if((document.forms[0].facilitysub_head_id_code.value=="2") || (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="31")|| (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="93"))
					{
						if(document.forms[0].sel_intsufacsubtype.value!="MCLEC" && document.forms[0].sel_intsufacsubtype.value!="EBLEC")
						{
							alert("Option not applicable");
							document.forms[0].sel_intsufacsubtype.value="0";
							return;
						}
					}
					else
					{
					if(document.forms[0].sel_intsufacsubtype.value!="MCLR" && document.forms[0].sel_intsufacsubtype.value!="MCLEC"&& document.forms[0].sel_intsufacsubtype.value!="SMTB"&& document.forms[0].sel_intsufacsubtype.value!="TYGS")
					{
						alert("Interest Sub type should be MCLR / MCLR Linked Export Limit");
						document.forms[0].sel_intsufacsubtype.value="0";
						document.forms[0].sel_intsufacsubtype.focus();
						return;
					}
				}
	  		}
		}
	}
	}
}
function checkExportCredit(type)
{
	if(type=="0")
	{
		if((document.forms[0].facility_head_id_code.value=="2") || (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="31")|| (document.forms[0].facility_head_id_code.value=="7" && document.forms[0].facility_id_code.value=="93"))
		{
			if(document.forms[0].sel_intsutype.value!="MCLEC" && document.forms[0].sel_intsutype.value!="EBLEC")
			{
				alert("Option not applicable");
				document.forms[0].sel_intsutype.value="0";
				return;
			}
		}
		else
		{
			if(document.forms[0].sel_intsutype.value=="MCLEC" || document.forms[0].sel_intsutype.value=="EBLEC" )
			{
				alert("Option not applicable");
				document.forms[0].sel_intsutype.value="0";
				return;
			}
		}

		if(document.forms[0].sel_inttype.value=="Fix")
		{
			if(document.forms[0].sel_intsutype.value=="BR" || document.forms[0].sel_intsutype.value=="MCLR"|| document.forms[0].sel_intsutype.value=="BRLEC"
				|| document.forms[0].sel_intsutype.value=="MCLEC"|| document.forms[0].sel_intsutype.value=="EBLEC"|| document.forms[0].sel_intsutype.value=="SMTB"
					|| document.forms[0].sel_intsutype.value=="TYGS" )
			{
				alert("Option not applicable");
				document.forms[0].sel_intsutype.value="0";
				return;
			}
		}
	}
	else if(type=="1")
	{
		if((document.forms[0].facilitysub_head_id_code.value=="2") || (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="31")|| (document.forms[0].facilitysub_head_id_code.value=="7" && document.forms[0].facilitysub_id_code.value=="93"))
		{
			if(document.forms[0].sel_intsufacsubtype.value!="MCLEC" && document.forms[0].sel_intsufacsubtype.value!="EBLEC")
			{
				alert("Option not applicable");
				document.forms[0].sel_intsufacsubtype.value="0";
				return;
			}
		}
		else
		{
			if(document.forms[0].sel_intsufacsubtype.value=="MCLEC" || document.forms[0].sel_intsufacsubtype.value=="EBLEC")
			{
				alert("Option not applicable");
				document.forms[0].sel_intsufacsubtype.value="0";
				return;
			}
		}

		if(document.forms[0].sel_sub_inttype.value=="Fix")
		{
			if(document.forms[0].sel_intsufacsubtype.value=="BR" || document.forms[0].sel_intsufacsubtype.value=="MCLR"|| document.forms[0].sel_intsufacsubtype.value=="BRLEC"
				|| document.forms[0].sel_intsufacsubtype.value=="MCLEC"|| document.forms[0].sel_intsufacsubtype.value=="EBLEC"|| document.forms[0].sel_intsufacsubtype.value=="SMTB"
					|| document.forms[0].sel_intsufacsubtype.value=="TYGS" )
			{
				alert("Option not applicable");
				document.forms[0].sel_intsufacsubtype.value="0";
				return;
			}
		}
	}
}



	function openCGTMSE()
	{
		var cominfo_total_employees="<%=Helper.correctNull((String) hshValues.get("cominfo_total_employees"))%>";
		if(cominfo_total_employees=="")
		{
			alert("Please fill Total Employees in Demographics Tab");
			return false;
		}
		
		appno=document.forms[0].appno.value;
		var varQryString = appURL+"action/CorpCgtmseCoverage.jsp?hidBeanId=supuser&hidBeanGetMethod=getCropCgtmse&appno="+ appno;
		var prop = "scrollbars=yes,width=1000,height=500, menubar=no";	
		prop = prop + ",left=100,top=50";
		window.open(varQryString,"cgtmse",prop);
	}





function checkforshg()
{

	if(document.forms[0].sel_schemetype.value=="aS")
	{
		<% if(FACILITY_PROPOSEDValue.equalsIgnoreCase("")){%>
		var vardiff=roundVal(parseFloat(NanNumber(document.forms[0].txt_proposed_limit.value)))
		if(2000000>=vardiff)
		 {

			document.forms[0].selmodepayment.value="N";  
                         document.forms[0].selmodepayment.disabled=true;                              		 }
		else
		{
document.forms[0].selmodepayment.disabled=false; 
document.forms[0].selmodepayment.value=""; 

					}
		<%}%>
	}
}
/*function chkformibor()
{
	if(document.forms[0].sel_intsutype.value=="FTBR" || document.forms[0].sel_intsufacsubtype.value=="FTBR")
		{
		if(miborchk!="Y")
			{
			alert("FBIL-T-Bill Rate Option Only for selected branchs only");
			document.forms[0].sel_intsutype.value="0";
			return;
			}
		else
			{
			if(document.forms[0].sel_intsutype.value=="FTBR")
				{
				document.all.idmainmibordate.style.visibility="visible";
				document.all.idmainmibordate.style.position="relative";
				document.all.idmainmibordate1.style.visibility="visible";
				document.all.idmainmibordate1.style.position="relative";
				}
			else
				{
				document.all.idmainmibordate.style.visibility="hidden";
				document.all.idmainmibordate.style.position="absolute";
				document.all.idmainmibordate1.style.visibility="hidden";
				document.all.idmainmibordate1.style.position="absolute";
				document.all.idmainmibortenor.style.visibility="hidden";
				document.all.idmainmibortenor.style.position="absolute";
				document.all.idmainmibortenor1.style.visibility="hidden";
				document.all.idmainmibortenor1.style.position="absolute";
				document.forms[0].txtmianDate.value=""; 
				document.forms[0].Tenormibormain.value="";
				}
			if(document.forms[0].sel_intsufacsubtype.value=="FTBR")
				{
				document.all.idsubmibordate.style.visibility="visible";
				document.all.idsubmibordate.style.position="relative";
				document.all.idsubmibordate1.style.visibility="visible";
				document.all.idsubmibordate1.style.position="relative";
				}
			else
				{
				document.all.idsubmibordate.style.visibility="hidden";
				document.all.idsubmibordate.style.position="absolute";
				document.all.idsubmibordate1.style.visibility="hidden";
				document.all.idsubmibordate1.style.position="absolute";
				document.all.idsubmibortenor.style.visibility="hidden";
				document.all.idsubmibortenor.style.position="absolute";
				document.all.idsubmibortenor1.style.visibility="hidden";
				document.all.idsubmibortenor1.style.position="absolute";
				
				document.forms[0].txtsubDate.value=""; 
				document.forms[0].Tenormiborsub.value="0";
				}
			}
		
		}
	else
		{
		document.all.idmainmibordate.style.visibility="hidden";
		document.all.idmainmibordate.style.position="absolute";
		document.all.idsubmibordate.style.visibility="hidden";
		document.all.idsubmibordate.style.position="absolute";
		document.all.idmainmibordate1.style.visibility="hidden";
		document.all.idmainmibordate1.style.position="absolute";
		document.all.idsubmibordate1.style.visibility="hidden";
		document.all.idsubmibordate1.style.position="absolute";
		document.all.idsubmibortenor.style.visibility="hidden";
		document.all.idsubmibortenor.style.position="absolute";
		document.all.idsubmibortenor1.style.visibility="hidden";
		document.all.idsubmibortenor1.style.position="absolute";
		document.all.idmainmibortenor.style.visibility="hidden";
		document.all.idmainmibortenor.style.position="absolute";
		document.all.idmainmibortenor1.style.visibility="hidden";
		document.all.idmainmibortenor1.style.position="absolute";
		document.forms[0].txtsubDate.value=""; 
		document.forms[0].Tenormiborsub.value="";
		document.forms[0].txtmianDate.value=""; 
		document.forms[0].Tenormibormain.value="";
		}
	
	
}
function allowalwysOldDate(obj,mindate,chkdate)
{
	if(chkdate=="")
		{
		chkdate=document.forms[0].hidinwarcreateddate.value
		if(chkdate=="")
			{
		alert("Please select the Application Number");
		obj.value="";
		return false;
			}
		}
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	var chk=changeDateformat(chkdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(mindt))
		{
			
			
			alert("Referred Date can not be greater than Today date " + mindate );
			obj.value="";
			obj.focus();
			return false;
		}
		else if(Date.parse(pgdt) < Date.parse(chk))
		{
			alert("Referred Date should not be earlier than the LAR Creation Date  " +chkdate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}
function mibormaintenor(obj)
{
	if(obj.value!="")
	{
		
		document.all.idmainmibortenor.style.visibility="visible";
		document.all.idmainmibortenor.style.position="relative";
		document.all.idmainmibortenor1.style.visibility="visible";
		document.all.idmainmibortenor1.style.position="relative";
	}
	else
	{
		document.all.idmainmibortenor.style.visibility="hidden";
		document.all.idmainmibortenor.style.position="absolute";
		document.all.idmainmibortenor1.style.visibility="hidden";
		document.all.idmainmibortenor1.style.position="absolute";
		document.forms[0].Tenormibormain.value="";
	}
}
function miborsubtenor(obj)
{
	if(obj.value!="")
	{
		document.all.idsubmibortenor.style.visibility="visible";
		document.all.idsubmibortenor.style.position="relative";
		document.all.idsubmibortenor1.style.visibility="visible";
		document.all.idsubmibortenor1.style.position="relative";
	}
	else
	{
		document.all.idsubmibortenor.style.visibility="hidden";
		document.all.idsubmibortenor.style.position="absolute";
		document.all.idsubmibortenor1.style.visibility="hidden";
		document.all.idsubmibortenor1.style.position="absolute";
		document.forms[0].Tenormiborsub.value="";
	}
}
function ftbilldatechk(tenor,fbilldata,facilitytype)
{
	alert(fbilldata);
	var tenorval=tenor.value;
	document.all.ifrm3.src=appURL+"action/iframeftbilldatechk.jsp?hidBeanGetMethod=chkMCLRTable&hidBeanId=facilities&tenorval="+tenorval+"&fbilldatavalue="+fbilldata+"&facilitytype="+facilitytype;
	
}*/


//pan check 
function checkpanlimit()
{
	var pancheck="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>";
	var sanctionlimit="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>";
	var Pancount="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>";	
	var proposedlimit=document.forms[0].txt_proposed_limit.value;	
	var totallimit="0.00";
	//alert(Pancount)
	//alert(sanctionlimit)
	//alert(proposedlimit)
	if(sanctionlimit==""|| sanctionlimit=="NaN")
	{
		sanctionlimit="0.00";
	}
	if(proposedlimit==""|| proposedlimit=="NaN")
	{
		sanctionlimit="0.00";
	}
		if(pancheck=="Y")
		{
			if(eval(proposedlimit)>=sanctionlimit)
			{
				if(Pancount=="N")
				{
					alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+sanctionlimit+"/- and above ");
					document.forms[0].txt_proposed_limit.value="";
					document.forms[0].txt_proposed_limit.focus();
					return;
				}	
			}
		}	
}
//pan check
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading(); checkdateval();showval();optionsdisable();selsubmain('N');selsub('N');moratperiod('N');moratperiod1('N');loadcallduedate();loadsubcallduedate();cgtmsefld();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form method="post" name="facility" class="normal">
<%if((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="101" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			<jsp:param name="applevel" value="<%=applevel%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			<jsp:param name="applevel" value="<%=applevel%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%
	if (strCategoryType.equalsIgnoreCase("SRE")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short
		Review/Extension -&gt; Applicant-&gt; Facilities</td>
	</tr>
</table>
<%
	} else if (strCategoryType.equalsIgnoreCase("STL")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short
		Term Loan -&gt; Applicant-&gt; Facilities</td>
	</tr>
</table>
<%
	} else if (strCategoryType.equalsIgnoreCase("ADC")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Ad hoc
		Limit -&gt; Applicant -&gt; Facilities</td>
	</tr>
</table>
<%
	} else if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt;
		 Application -&gt; Applicant -&gt; Facilities</td>
	</tr>
</table>
<%
	}else{
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
				 Application -&gt; Applicant -&gt; Facilities</td>
			</tr>
		</table>
		<%
			}
		%>
<span style="display: none;"><lapschoice:borrowertype /></span>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable linebor">
	<tr class="applicationheader">
		<td><b>Proposal No :</b></td>
		<td><%=strAppno%>&nbsp;</td>
		<td><b>Applicant Name:</b></td>
		<td><%=appname%>&nbsp;</td>
		<td><b>Status:</b></td>
		<td><%=appstatus%>&nbsp;</td>
		<td nowrap="nowrap">&nbsp;<b>Digi Appno:</b></td>
		<td nowrap="nowrap"><%=digiappno%></td>
	</tr>
	<tr class="applicationheader">
		<td><b>Application Holder:</b></td>
		<td><%=strAppholder%>&nbsp;</td>
		<td><b>App. Recd. from:</b></td>
		<td><%=strApporgname%>&nbsp;</td>
		<td><b>Application No :</b></td>
		<td><%=inwardno%>&nbsp; <input type="hidden" name="appname"
			value="<%=appname%>"> <input type="hidden" name="appno"
			value="<%=strAppno%>"> <input type="hidden" size="3"
			name="hidapplicantid" value="<%=applicantid%>"> <input
			type="hidden" name="inwardno" value="<%=inwardno%>"> <input
			type="hidden" name="readFlag"
			value="<%=Helper.correctNull(
							(String) session.getAttribute("strGroupRights"))
							.charAt(18)%>">
		<input type="hidden" size="3" name="appholder"
			value="<%=strAppholder%>"> <input type="hidden"
			name="applevel" value="<%=applevel%>"> <input type="hidden"
			name="apploantype" value="<%=loanType%>"> <input
			type="hidden" name="valuesin" value="<%=valuesin%>"> <input
			type="hidden" name="strappstatus" value="<%=strAppstatus%>">
		<input type="hidden" name="apporgname" value="<%=strApporgname%>">
		<input type="hidden" name="btnenable" value="<%=btnenable%>">
		<input type="hidden" size="3"
			name="hidapplicantnewid" value="<%=applicantnewid%>"></td>
	</tr>
	<tr class="applicationheader">
		<td nowrap="nowrap">&nbsp;<b>Sanction / Rejected Reference No:</b>&nbsp;</td>
		<td>&nbsp;<%=sanctionrefno%></td>
		<td nowrap="nowrap">&nbsp;<b>CBS Account No:</b>&nbsp;</td>
		<td>&nbsp;<%=strCbsaccno%></td>
		<td nowrap="nowrap">&nbsp;<b>Proposal Type :</b>&nbsp;</td>
		<td>&nbsp;<%=strAppType%></td>
		<%
	if(!strRevalFlag.equalsIgnoreCase("")){ %>
	<td nowrap="nowrap">&nbsp;<b>Revalidation Intiated</b></td>
	<td nowrap="nowrap">Yes</td>
	<%}else{%>
	<td nowrap="nowrap" colspan="2">&nbsp;</td>
	<%} %>
	</tr>
	
</table>
<lapstab:ComfacilityTab tabid="1" />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td width="3%" style="display: none;"><input type="radio" name="category"
									style="border-style: none" checked="checked"></td>
									
								<!--<td width="7%">Main Limit</td>
								 --><td width="3%" style="display: none;"><input type="radio" name="category"
									style="border-style: none"></td>
								<!-- <td width="6%">Adhoc</td>  -->
								<td width="3%" colspan="2">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="3%">&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="15%"><b>All Values are in <span
									class="mantatory">*</span></b></td>
								<td width="15%"><select name="sel_proposalvaluesin"
									onchange="doShowmessage()">
									<option value="S">&lt;---Select---&gt;</option>
									<option value="R">Rs</option>
								</select></td>
								<td width="20%" id="lbl_facreq"><b>Whether Financial Required</b></td>
								<td width="15%" id="txt_facreq"><select name="sel_facilityrequired">
									<option value="S">&lt;---Select---&gt;</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr>
										<td width="30%" nowrap="nowrap">Application No:<b><span
											class="mantatory">*</span></b></td>
										<td width="10%"><input type="text"
											name="txt_appinwardno" tabindex=""
											onkeypress="allowInteger(this)" readOnly="readonly"
											value="<%=inwardno%>">
											<input type="hidden" name="hidinwarcreateddate" value="">
											<input type="hidden" name="hidinwardAmt" value="<%=Helper.correctDouble((String)hshValues.get("strInwardReqAmt")) %>">
										<td width="10%"><img onClick="showAckSearch()" style="cursor: hand"
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											id="inwrd_srch" border="0" tabindex="36"></td>
										<td width="30%">Details as on <b><span
											class="mantatory">*</span></b></td>
										<td width="20%">
										<table width="100%" border="0">
											<tr>
												<td width="21%"><input type="text" name="txt_osdate"
													size="16"
													onBlur="checkDate(this);checkmaxdate(this,currentDate)"
													value="<%=Helper.correctNull((String) hshValues.get("asondate"))%>">
												</td>
												<td width="79%"><a alt="Select date from calender"
													href="#" onClick="callCalender('txt_osdate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr style="visibility:hidden;position:absolute">
										<td width="30%">Facility Head<span
											class="mantatory">*</span></td>
										<td width="20%">
										<%HashMap hp1 = new HashMap();%> 
										<select name="facility_head"
											onChange="javascript:getFacility('facility')" style="width:150px">
											<option selected="selected" value="-">----Select----</option>
											<%
												HashMap h = new HashMap();
												h.put("value", "parent");
												h.put("parent", "0");
												h.put("hidMethod", "getFacility");

												hp1 = new HashMap();
												hp1.put("BeanId", "facilitymaster");
												hp1.put("MethodName", "getData");
												hp1.put("BeanParam", h);
											%>
											<lapschoice:selecttag value='<%=hp1%>' />
										</select> <input type="hidden" name="hid_facility_head"></td>
										<td width="30%">Facility<span
											class="mantatory">*</span></td>
										<td width="20%"><select name="facility" onchange="getFacilityDesc()"  style="width:150px">
											<option selected="selected" value="-">----Select----</option>
										</select> <input type="hidden" name="hid_facility"></td>
									</tr>
									<!-- 
										<tr>
										<td nowrap="nowrap">Facility Description<span class="mantatory">*</span></td>
											<td height="25"><input type="text" name="facilitydescnew" size="50" maxlength="50">
											<input type="hidden" name="facility_head_id_code">
											<input type="hidden" name="facility_id_code">
											<input type="hidden" name="facilitydesc">
											<input type="hidden" name="facility_nature"></td>
											<td><span onClick="callDescHelp('N')" style="cursor: hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="2"></span>
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type&nbsp;&nbsp;&nbsp;&nbsp;<select name="sel_fac_desc">
        						<option value="s">--Select--</option>
        							<lapschoice:staticfacdescTag/>
        						</select>
										
													</td>								
										<td><input type="hidden" name="sel_schemetype">
										
										
										
										
										</td>
									</tr>
									 -->
									 <tr id="idex" style="display: none;">
									 	<td colspan="4"> 
										<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">					
										<tr>
											 <td class="mantatory" width="10%">Existing Proposal No :</td>
											 <td id="idex1" class="mantatory" width="20%"></td>
											 <td class="mantatory" width="10%">Existing CBS Account No :</td>
											 <td id="idex2" class="mantatory" width="20%"></td>
											 <td class="mantatory" width="10%">Existing Limit Type :</td>
											 <td id="idex3" class="mantatory" width="20%"></td>
											</tr>
										</table>
										</td>
									 </tr>
									<tr>
										<td nowrap="nowrap">Facility Description<span
											class="mantatory">*</span></td>
										<td nowrap="nowrap"><input type="text" name="facilitydescnew" size="28" maxlength="50">&nbsp;<span onClick="callDescHelp('N')" style="cursor: hand"><img
													id="prod_sel_icon" src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="2"></span></td>
										<td>Type<span
											class="mantatory">*</span></td>
										<td>
										<select name="sel_fac_desc">
        									<option value="">--Select--</option>
        									<lapschoice:staticfacdescTag/>
        									</select>&nbsp;
        									<span onClick="callRenewFacility()" style="cursor: hand" id="Renewed_Facility"><img
												src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												border="0" tabindex="2"></span>
        									</td>
        							<input type="hidden" name="sel_schemetype">
									</tr>
									<tr id="idschemecode">
									<td nowrap="nowrap"><span
											class="mantatory">Scheme Code</span></td>
									<td nowrap="nowrap"><input type="text" name="txt_schemecode" readonly="readonly">   </td>
									</tr>
									<tr>
										<td nowrap="nowrap">Nature of Limit</td>
										<td nowrap="nowrap">
											<select name="seladhoclimit"  onchange="calladhoc('Y');">
											<option value="" selected="selected"><--select--></option>
											<option value="A">Adhoc Limit</option>
											<option value="R">Regular Limit</option>
											<option value="D">Additional Limit</option>
											<option value="O">One Time Limit</option>
											</select>	
										</td>
										<td id="idadhoc" style="display: none;">Base facility of </td>
										<td id="idadhoc1" style="display: none;">
										<select name="seladhocof">
        									<option value="">--Select--</option>
        									</td>
									</tr>
									<%if(facility_type.equalsIgnoreCase("S")) {%>
									<tr>
										<td nowrap="nowrap">Whether to be Restructure <span
											class="mantatory">*</span></td>
										<td><select name="selfac_restr_acc" onchange="funenablefitl();changeCEFAF();hideCBSaccountno();">
        									<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									</select></td>
										<td id="idrestr1" style="visibility: hidden;position: absolute;"><span id="res_label">Whether FITL Account</span>
										<span class="mantatory">*</span></td>
										<td id="idrestr2" style="visibility: hidden;position: absolute;">
										<select name="selfac_fitl_acc" onchange="funenablefitl();changeCEFAF();hideCBSaccountno();">
        									<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									</select>&nbsp;
        									
        									</td>
									</tr>
									
        								<tr id="idrestr3">
										<td nowrap="nowrap">Conversion of Existing facility<span
											class="mantatory">*</span></td>
										<td><select name="sel_restr_conversionfac" onchange="changeCEFAF();hideCBSaccountno();">
										<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									<option value="NA">Not Applicable</option>
        									</select>
        									</td>
        								<td nowrap="nowrap">Additional funding/finance<span
											class="mantatory">*</span></td>
										<td><select name="sel_restr_addfunding">
										<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									<option value="NA">Not Applicable</option>
        									</select>
        									</td>
									</tr>
									
									<tr >
									<td nowrap="nowrap" id="id_restr_scheme">Restructure Settlement Scheme<span class="mantatory">*</span></td>
        								<td  id="id_restr_scheme1"><select name="sel_restr_scheme" onchange="checkdateval();">
        								<option value="">Select</option>
        									<lapschoice:StaticDataTag apptype="154" tagType="<%=strAppstatus%>"/>
        									</select></td>
        									
										<td nowrap="nowrap" id="id_restracc"><span id="resAcc_label">Existing CBS Account no.</span>
										<span class="mantatory">*</span></td>
										<td id="id_restracc1"><select name="sel_restr_acc" onChange="AccSelect()" multiple>
        								<lapschoice:restraccSelect appno="<%=strAppno%>"/>
        									</select>
        									<input type="hidden" name="hid_str_rsAcc" value=""></td>
        							</tr>
        							<tr id="idrestrinvoc">
										<td nowrap="nowrap" colspan="">Date of Restructure Invocation<span class="mantatory">*</span></td>
										 <td><input type="text" name="txt_restructdate" onBlur="checkDate(this);checkmaxdate(this,currentDate);"
										  value="<%=perapp_invocdate%>" size="16">
														</td> 
														
									</tr>
        								
									<%}else{ %>
									<input type="hidden" name="selfac_restr_acc" id="idrestr1">
									<input type="hidden" name="selfac_fitl_acc" id="idrestr2">
									<input type="hidden" name="hid_str_rsAcc" value="" id="id_restracc">
									<input type="hidden" name="sel_restr_conversionfac" value="" id="idrestr3">
									<input type="hidden" name="sel_restr_addfunding" value=""  id="id_restracc1">
									<input type="hidden" name="sel_restr_scheme" value="">
									<input type="hidden" name="txt_restructdate" value="" id="idrestrinvoc"></td>
									<%} %>
									<tr id="idfacdeferment">
									<td>Interest Deferment Accounts</td>
									<td><select name="hidintdefer_acc" onchange="chkaccount(this);">
										<option value=""><--select--></option>
        								<lapschoice:defermentAcc appid="<%=strBorrowerId%>"/>
        									</select>
									</tr>
									<tr>
									
										<td id="Existing_limit">Existing Limit<span
											class="mantatory">*</span></td>
										<td id="Existing_limit1"><input type="text" name="txt_exist_limit"
											size="16" onBlur="javascript:roundtxt(this);"
											value="<%=Helper.correctNull((String) hshValues.get("facexist"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"  style="width:150px"></td>
										<td>Proposed Limit<span
											class="mantatory">*</span></td>
										<td><input type="text"
											name="txt_proposed_limit" size="16"
											onBlur="checkRange('N');chkInsTenor('M','A');getInterestSetup('Y');justification('N');checkforshg();checkpanlimit();"
											value="<%=Helper.correctNull((String) hshValues.get("facproposed"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"  style="width:150px"> <input type="hidden"
											name="hidproposed"
											value="<%=Helper.correctNull((String) hshValues.get("facproposed"))%>">
										</td>
									</tr>
									<tr id="renewal_justif" style="display: none;">
										<td>Justification for Enhancement/Reduction </td>
										<td><textarea name="txt_renewaljustif" cols="26" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>  </td>
									</tr>
									<tr>
									<td>Insurance Covered Under &nbsp;
									<select name="sel_Processed_Type"  onChange="processedType('facility','Y')"  style="width:150px">
											<option value="">---select---</option>
											<lapschoice:StaticDataTag apptype="223" tagType="<%=strAppstatus%>" />
										</select><span class="mantatory">*</span>

									</td>
									<td><input type="text"
											name="txt_metlifeinsurance" size="16"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"
											value=""  style="width:150px"></td>
									</tr>
									
									<tr id="id_premium_tenor" >
									          <td>Premium Tenor (in Months)<span class="mantatory">*</span></td>
									          <td>
									            <input type="text" name="txt_premium_tenor" maxlength="15" size="15"
														value="<%=Helper.correctNull((String) hshValues.get("FAC_PREMIUM_TENOR"))%>" style="text-align:right" onblur="chkInsTenor('M','T');">
									          </td>
									            <td>Loan amount covered under the scheme <span class="mantatory">*</span></td>
									          <td >
									            <input type="text" name="txt_premium_loan_amt" maxlength="15" size="15" onKeyPress="allowNumber(this)"
														value="<%=Helper.correctNull((String) hshValues.get("FAC_PREMIUM_LOAN_AMOUNT"))%>" style="text-align:right" onblur="chkInsTenor('M','A');">
									          </td>
									          </tr>
									          <tr id="id_premium_Account_no1">
									          <td>Operative account number from which<br> premium account will be debited  <span class="mantatory">*</span></td>
									          <td>
									            <input type="text" name="txt_premium_Account_no" maxlength="16" size="15" onKeyPress="allowNumber(this)"
														value="<%=Helper.correctNull((String) hshValues.get("FAC_INS_ACCOUNT_NO"))%>" style="text-align:right">
									          </td>
									           <td>Company Name <span class="mantatory">*</span></td>
									          <td>
									            <select name="sel_Funded_Comp_Name"   style="width:150px">
											<option value="0">---select---</option>
											<lapschoice:StaticDataTag apptype="223" tagType="child"/>
										</select>
									          </td>
									          
									          
											</tr>
									
									<tr>										
										<td nowrap="nowrap">Interest Type&nbsp;<b><span class="mantatory">*</span></b></td>
										<td><select name="sel_inttype" onchange="getInterestSetup('Y');callintrate();" style="width:150px">
											<option value="0" selected="selected">----Select----</option>
											<option value="Fix">Fixed</option>
											<option value="Flo">Floating</option>										
										</select>
										<br/> <span id="iddesc"  style="display: none;"><font color="red">Interest Rate will be define in reference rate tab </font></span></td>
										<td nowrap="nowrap">Interest Sub Type&nbsp;<b><span class="mantatory">*</span></b></td>
										<td><select name="sel_intsutype" style="width:160px" onchange="chkfacilityMCLR('0');checkExportCredit('0');">
											<option value="0" selected="selected">----Select----</option>
											<option value="BR">Base Rate</option>
											<option value="MCLR">MCLR</option>
											<option value="BRLEC">BR linked Export Credit</option>
											<option value="MCLEC">MCLR linked Export Credit</option>
											<option value="EBLEC">EBLR linked export credit</option>
											<option value="BPLR">BPLR</option>	
											<option value="LIBOR">LIBOR</option>
											<option value="EURIBOR">EURIBOR</option>
											<option value="EUROLIBOR">EUROLIBOR</option> 
											<option value="SMTB">6 MONTHS TREASURY BILL</option>
											<option value="TYGS">10 YEAR GOVT SECURITY</option> 
											<option value="COMMI">Commission</option>
											<option value="FTBR">FBIL-TERM MIBOR</option>
											<option value="NOTAP">Not Applicable</option>									
										</select></td>	
																			
										
									</tr>
									<tr id="idint1" style="display: none;">
									<td nowrap="nowrap"> ROI Type</td>
									<td><select name="sel_interesttype" onchange="">
												</select></td>
									</tr>
									<tr>
									<td nowrap="nowrap">Tenor (in Months)<span
											class="mantatory">*</span></td>
										<td><input type="text" name="txt_facmonths"
											size="5" maxlength="3" onKeyPress="allowInteger(this)" onblur="checkRangeTenor('N','Y');chkInsTenor('M','T');"  style="width:150px">
										<input type="hidden" name="hid_facmonths"></td>
										<td nowrap="nowrap">Initial Holiday/Gestation/Moratorium Period <br> (in Months)</td>											
												<td><input type="text"
													name="txt_installments" size="5"
													onBlur="moratperiod('Y');callInterestCharged()" maxlength="3"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_noofinstallment"))%>"
													onKeyPress="allowInteger();"
													tabindex="9"  style="width:150px"><input type="hidden"
													name="hid_installments"></td>	
									
									</tr>
									<tr>										
										<td  nowrap="nowrap">Proposed Banking Arrangement<span
											class="mantatory">*</span></td>
										<td><select name="sel_propbanktype" onChange="callLeaderBank();" style="width:150px">
											<option value="" selected="selected">----Select----</option>
											<option value="S">Sole</option>
											<option value="C">Consortium</option>
											<option value="M">Multiple Banking</option>
										</select></td>	
											<td nowrap="nowrap">Repayment Type<span
											class="mantatory">*</span></td>
										<td>
										<select name="sel_repaytype" onchange="repaymentsel()" 
											style="width: 150px;">
											<option value="0" selected="selected" title="--Select--">----Select----</option>
											<option value="E" title="EMI">EMI</option>
											<option value="NE" title="Non-EMI">Non-EMI</option>	
											<option value="OD" title="On Demand">On Demand</option>
								     		<option value="LC" title="As Per LC Terms">As Per LC Terms</option>
								     		<option value="CO" title="As Per Contract Terms">As Per Contract Terms</option>
								     		<option value="BG" title="As Per BG Rules">As Per BG Rules</option>										
								          	<option value="DD" title="On Due Date">On Due Date</option>
								          	<option value="PC" title="From the proceeds of PSC / by realization of bill">From the proceeds of PSC \ by realization of bill</option>
								          	<option value="PS" title="By Realization of Export Bills">By Realization of Export Bills</option>
								          	<option value="PR" title="By Realization of Respective Bills">By Realization of Respective Bills</option>
								          	<option value="TG" title="As per TCBG Rules">As per TCBG Rules</option>
										</select></td>									
																		
									</tr>
									
									<tr id="consort">
									<td>Name of the Leader Bank <span class="mantatory">*</span></td>
									<td>
											<input type="text" name="txt_LeadBank"  size="40" readOnly="readonly"  
												maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
												 tabindex="10">
												 <input type="hidden" name="hid_Bankcode" value="">
										<a href="#" onClick="callBankmasterNew('147')" style="cursor: hand">
										<img id="leaderbank" src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a>
									</td>
									<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
									<td>Mode of Payment<b><span class="mantatory">*&nbsp;</span></b></td>
												<td colspan=""><select name="selmodepayment"
													tabindex="24" onChange="selOperative('facility')"
													onBlur="" style="width: 150px;">
													<option value="0" selected="selected">&lt;----Select----&gt;</option>
													<!-- <option value="S">Recover From Salary</option>
													<option value="P">Post Dated Cheque</option>
													<option value="E">Transfer from Saving/Current a/c</option>
													<option value="D">Electronic Cheque Clearing(ECS)</option>-->
													<% if(!FACILITY_PROPOSEDValue.equalsIgnoreCase("")){
													if(2000000>=d){%>
													<option value="N">Cash Recovery</option> 
														<%}else{ %>	
														<lapschoice:StaticDataNewTag apptype="217" />
													<%} %>
														
													<%}else{ %>	
														<lapschoice:StaticDataNewTag apptype="217" />
															<%} %>
													
													
											
													
												</select></td>
									<td id="opnolabel">Operative Account Number:<b><span class="mantatory">*&nbsp;</span></b></td>
											<td id="opnovalue"><input type="text"
													name="txt_operativeaccno" id="opaccno" onKeyPress="allowInteger()"  onBlur="ValidateOpearativeAcc(this,'txt_operativeaccno')"
													value="<%=Helper.correctNull((String) hshValues	.get("facility_operationaccno"))%>"
													disabled="disabled" maxlength="16">
											</td></tr>
									<tr>
											<td>&nbsp;</td>
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
											<td>&nbsp;</td>
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
											<td>&nbsp;</td>
											<td id="ECSopnolabel4">IFSC CODE<b><span class="mantatory">*&nbsp;</span></b></td>
												<td id="ECSopnovalue4"><input type="text" 
													name="txt_ECSifsccode"
													value="<%=Helper.correctNull((String) hshValues
													.get("LOAN_ECSIFSCCODE"))%>"
													 maxlength="15"></td>
											</tr>
									<tr>
									<td>Periodicity of Installments<span
											class="mantatory">*</span></td>
												<td><select name="sel_peridicityfac"
													 tabindex="14" style="width:150px"  onchange="selperiodicity();">
													<option value="s" selected="selected">--Select--</option>
													<option value="m" selected="selected">Monthly</option>
													<option value="q">Quarterly</option>
													<option value="h">Half-Yearly</option>
													<option value="y">Yearly</option>
													<option value="n">Not Applicable</option>
												</select></td>	
												<td nowrap="nowrap">Interest/ Discount/ Commission (%) <span
											class="mantatory">*</span></td>
										<td>
										<%
											strInt = Helper.correctNull((String) hshValues.get("facinterest"));
										%>
										<input type="text" name="prd_intrate" size="10"
											onKeyPress="allowNumber(this)" maxlength="13" onBlur="roundtxt(this)"
											style="text-align: right" readonly="readonly"  style="width:150px">
											<input type="hidden" name="hidIntIdFac"/>
											<input type="hidden" name="hidBaseRateFac"/>
										</td>								
									
									</tr>
									
									       <tr id="newid">
												<td nowrap="nowrap">Interest to be collected during Holiday<b><span class="mantatory">*</span></b></td>												
												<td><select
													name="interestservised" onChange="callInterestCharged();"   style="width:150px">
													<option value="s" selected="selected">Not
													Applicable</option>
													<option value="n">------No------</option>
													<option value="y">------Yes------</option>
												</select></td>
													<td>Interest charged</td>												
												<td><select name="sel_interestcharge"
													onChange=""  style="width:150px">													
													<option value="1" title="To be paid as and when debited">To be paid as and when debited</option>
													<option value="2" title="To be accumulated and added to the principal to calculate EMI">To be accumulated and added to the principal to calculate EMI</option>
													<option value="3" selected="selected">--Select--</option>
													</select> &nbsp;&nbsp;&nbsp;</td>																								
												</tr>
																								
									<tr>
									
									    			  <td>Margin</td>
												  <td><textarea
											name="txt_margin" cols="26" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ></textarea></td>
											
											<td nowrap="nowrap">Purpose</td>										
											<td><textarea
											name="txt_purpose" cols="26" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>											
										
										
									</tr>
									
									<tr id="idmargin">
									
							    	<td>Relaxation in margin as per RBI COVID relief Package Policy</td>
									<td><select name="sel_margin" onchange="enablemargin('M');">
									<option value=""><--select--></option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									</select></td>
									<td nowrap="nowrap">Predefined Margin(%) &nbsp;	</td><td>								
									<select name="sel_definedmargin"  style="width:150px">
													<option value="0">---select---</option>
													<lapschoice:StaticDataTag apptype="235" />
												</select>
									</td>											
										
										
									</tr>
									<tr  id="idmargin1">
									<td colspan="2">&nbsp;</td>
									<td>Relaxed Margin(%) &nbsp;</td>									
									<td><select name="sel_relaxedmargin"  style="width:150px" onchange="chkactualMargin('Y')">
													<option value="0">---select---</option>
													<lapschoice:StaticDataTag apptype="236" />
												</select>
												</td>
									</tr>
									
									<tr>
							
								         <!-- <td nowrap="nowrap" id="idremarks">Remarks</td>										
											<td id="idremarkstxt"><textarea
											name="txt_remarks" cols="26" rows="2"></textarea></td> -->
											
						              
						              <td id="idduedate" width="20%">Due Date<span class="mantatory">*</span></td>
										<td width="21%" id="idduedatetxt"><input type="text" name="txt_duedate"
													size="16"
													onBlur="checkDate(this);checkduedate('Y',this);"
													value="">
												<a alt="Select date from calender" id="duedate"
													href="#" onClick="callCalender('txt_duedate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
									
									  <td>
										<%
											if (!strCategoryType.equalsIgnoreCase("ADC")
													&& !strCategoryType.equalsIgnoreCase("STL")) {
										%> Irregularities, if
										any <%
											} else {
										%>Overdues, if any<%
											}
										%>
										</td>
										<td>
										<%
											if (!strCategoryType.equalsIgnoreCase("ADC")
													&& !strCategoryType.equalsIgnoreCase("STL")) {
										%> <textarea
											name="txt_desc" cols="26" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
										.get("facdesc"))%></textarea> <%} else {%>
 	 									<input type="text" name="txt_desc" size="16" onBlur="javascript:roundtxt(this)" value="<%=Helper.correctNull((String) hshValues.get("facdesc"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"> <%}%>
										</td>
												
									</tr>
									<tr id="idreview" style="display: none;">
									<td>Reviewed Due Date <span class="mantatory">*</span></td>
									<td><input type="text" name="txt_reviewdate"
													size="16"
													onBlur="checkDate(this);checkmindate(this,currentDate);checkmindate(this,document.forms[0].txt_duedate.value);checkReviewDate(this,'Y');"
													value="">
												<a alt="Select date from calender" 
													href="#" onClick="callCalender('txt_reviewdate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
									</tr>
									<% if(strSessionModuleType.equalsIgnoreCase("CORP")){%>
									<tr>
										<td nowrap="nowrap" id="id_Tuflab" style="visibility: hidden;position:absolute;">Whether under TUF scheme </td>
									    <td id="id_Tufval" style="visibility: hidden;position:absolute;"> 
									    <select name="sel_Tuf">
									     <option value="N" selected="selected">No</option>
									    <option value="Y">Yes</option>
									   
									    </select>
									    </td>
									    <td colspan="2">&nbsp;</td>
									    </tr>
											<%} %>
									<tr>			
										<td nowrap="nowrap" id="idexisaccnolab"><span id="efl">Existing Facility CBS Account No. </span></td>
									    <td id="idexisaccnoval"> <input type="text" name="txtcbsaccno" maxlength="16" style="width:150px"></td>
																				
									
									     <td nowrap="nowrap">Additional / Fresh Limit sought by Borrower </td>
									    <td>
									    	<input type="text"
											name="txt_freshlimitmain" size="16"
											onKeyPress="allowNumber(this)" maxlength="13" onBlur="roundtxt(this)"
											style="text-align: right"
											value=""  style="width:150px">
										</td>
									</tr>
									
									<tr>
										
														
							
									     <td nowrap="nowrap">Govt. Sponsor Scheme<span
											class="mantatory">*</span></td>
									    <td><select name="selectgovtmain"
													onChange="selsubmain('Y')"  style="width:150px">
													<option value="S" selected="selected">--Select--</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
												
												
										 <td nowrap="nowrap">Process note Description<span
											class="mantatory">*</span></td>
									    <td>
									    <select name="sel_displaydesc"  style="width:150px">
													<option value="0">---select---</option>
												</select> &nbsp;
											 <input type="hidden" name="txt_fac_type">
										</td>
									 </tr>   
									 <tr>														
												
												<td id="s5m">Scheme Type<span
											class="mantatory">*</span></td>
												<td id="s6m"><select name="schemetypemain"  style="width:150px">
													<option value="0">---select---</option>
													<lapschoice:StaticDataTag apptype="11" tagType="<%=strAppstatus%>"/>
												</select> &nbsp;</td>	
												         	<td id="s1m">Subsidy Amount&nbsp;<span
											class="mantatory">*</span></td>
												<td id="s2m"><lapschoice:CurrencyTag name="submainamnt"
													size="20" maxlength="10" onBlur="checkamt('N')"
													value='<%=Helper.correctNull((String)hshValues.get("loan_sub"))%>'
													tabindex="18"  style="width:150px"/> &nbsp;</td>										
											</tr>
																					
											<tr id="s3m">
												<td nowrap="nowrap">Sponsor Agency<span
											class="mantatory">*</span></td>
												<td><select name="sel_sponser_agencymain"
													tabindex="19"  style="width:150px" onchange="showAgency()">
													<option value="0">Select</option>
													<%
														String apptype = "3";
													%>
													<lapschoice:StaticDataTag apptype="<%=apptype%>" />
												</select></td>									
												<td>Subsidy type<span
											class="mantatory">*</span></td>
												<td><select name="sel_subsidytypemain" tabindex="20">
													<option value="0"  style="width:150px">Select</option>
													<%
														apptype = "5";
													%>
													<lapschoice:StaticDataTag apptype="<%=apptype%>" />
												</select></td>
											</tr>									
										<tr id="s4m">
											<td nowrap="nowrap">Name of the Agency</td>
											<td><input type="text" name="txt_agency" maxlength='50' size='50'/></td>
											<td colspan='2'></td>
										</tr>	
								<tr id="cg1">
								<td> Whether CGTMSE is applicable<span class="mantatory">*</span></td>
								<td><select name="cgtmse_app"  onchange="cgtmse()" />
        									<option value="" selected="selected">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									</select></td>
        									</tr>	
        									<!--<tr>
        									
        									  <td nowrap="nowrap" id="idmainmibordate" style="visibility: hidden; position: absolute;" > FBIL-T-Bill referred date <span
											class="mantatory">*</span>
											</td>
											<td  nowrap="nowrap" id="idmainmibordate1" style="visibility: hidden; position: absolute;">
										<input
													type="text" name="txtmianDate" maxlength="21" readonly
													size="20" onBlur="allowalwysOldDate(this,currentDate,'');
													mibormaintenor(this);"
													value="" >&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtmianDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src=""img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a>
										</td>	
										<td nowrap="nowrap"  id="idmainmibortenor" style="visibility: hidden; position: absolute;"> Tenor <span
											class="mantatory">*</span>
								</td>
								<td nowrap="nowrap" id="idmainmibortenor1" style="visibility: hidden; position: absolute;">
								<select name="Tenormibormain" onchange="ftbilldatechk(this,document.forms[0].txtmianDate.value,'main');" >
        									<option value="" selected="selected">--Select--</option>
        									<option value="1">7-days</option>
        									<option value="2">14- days</option>
        									<option value="3">1-Month</option>
        									<option value="4">2-Months</option>
        									<option value="5">3-Months</option>
        									<option value="6">4-Months</option>
        									<option value="7">5-Months</option>
        									<option value="8">6-Months</option>
        									<option value="9">7-Months</option>
        									<option value="10">8-Months</option>
        									<option value="11">9-Months</option>
        									<option value="12">10-Months</option>
        									<option value="13">11-Months</option>
        									<option value="14">12-Months</option>
        									</select>
								</td>														
								</tr>-->
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="1"
									class="outertable">
									<tr valign="middle">
										<td colspan="4">Sub - Limits
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
											type="checkbox" name="checkbox" value="checkbox"
											style="border-style: none" onClick="javascript:findtype();optionsenable()" onchange="">
										</td>
									</tr></table>
									</td></tr>
									<tr><td>
									<table id="hidesublimit" width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									<tr style="visibility:hidden;position:absolute">
										<td width="30%">Sub-Limit Head</td>
										<td width="20%"><select name="subfacility_head"
											onChange="javascript:getFacility('sublimit');selectSublimit()"  style="width:150px">
											<option selected="selected" value="-">----Select----</option>
											<%
												h = new HashMap();
												h.put("value", "parent");
												h.put("parent", "0");
												h.put("hidMethod", "getFacility");
												hp1 = new HashMap();
												hp1.put("BeanId", "facilitymaster");
												hp1.put("MethodName", "getData");
												hp1.put("BeanParam", h);
											%>
											<lapschoice:selecttag value='<%=hp1%>' />
										</select> <input type="hidden" name="hid_subfacility_head"></td>
										<td width="30%">Sub-Limit</td>
										<td width="20%"><select name="subfacility"  onchange="getFacilityDescsub()"  style="width:150px">
											<option selected="selected">----Select----</option>
										</select> <input type="hidden" name="hid_subfacility"></td>
									</tr>
									
									<!-- 
											<tr>										
										<td nowrap="nowrap">Facility Description<span class="mantatory">*</span></td>
											<td height="25"><input type="text" name="facilitydescsubnew" size="50" maxlength="50">
											<input type="hidden" name="facilitysub_head_id_code">
											<input type="hidden" name="facilitysub_id_code">
											<input type="hidden" name="facilitydescsub">
											<input type="hidden" name="facilitysub_nature">
											</td>
											<td><span onClick="callDescHelp('Y')" style="cursor: hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="2"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Type&nbsp;&nbsp;&nbsp;&nbsp;<select name="sel_subfac_desc">
        						<option value="s">--Select--</option>
        							<lapschoice:staticfacdescTag/>
        						</select></td>								
										<td><input type="hidden" name="sel_subschemetype"></td>
										
								
									</tr>
									 -->
									<!-- Added by Arsath as per the new changes -->
									<tr id="idsubex" style="display: none;">
									 <td colspan="4"> 
										<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">					
										<tr>
											 <td class="mantatory">Existing Proposal No :</td>
											 <td id="idsubex1" class="mantatory"></td>
											 <td class="mantatory">Existing CBS Account No :</td>
									 		 <td id="idsubex2" class="mantatory"></td>
											 <td class="mantatory" width="10%">Existing Limit Type :</td>
											 <td id="idsubex3" class="mantatory" width="20%"></td>
											</tr>
										</table>
										</td>
									 </tr>
									<tr><td nowrap="nowrap">Facility Description<span class="mantatory">*</span></td>
										<td nowrap="nowrap"><input type="text" name="facilitydescsubnew" size="28" maxlength="50">&nbsp;<span onClick="callDescHelp('Y')" style="cursor: hand"><img
													id="prod_sel_icon_sub" src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="2"></span>
											<input type="hidden" name="facilitysub_head_id_code">
											<input type="hidden" name="facilitysub_id_code">
											<input type="hidden" name="facilitydescsub">
											<input type="hidden" name="facilitysub_nature"></td>
										<td>Type<span class="mantatory">*</span></td>
										<td><select name="sel_subfac_desc">
        						<option value="">--Select--</option>
        							<lapschoice:staticfacdescTag/>
        						</select>
        						<input type="hidden" name="sel_subschemetype">
								</td>
								</tr>
								
								<tr id="idsubschemecode">
									<td nowrap="nowrap"><span
											class="mantatory">Scheme Code</span></td>
									<td nowrap="nowrap"><input type="text" name="txt_subschemecode" readonly="readonly">   </td>
								</tr>
								
								<tr>
										<td nowrap="nowrap">Nature Of Limit</td>
										<td nowrap="nowrap">
											<select name="selsubadhoclimit" onchange="callsubadhoc('Y');">
											<option value=""  selected="selected"><--select--></option>
											<option value="A">Adhoc Limit</option>
											<option value="R">Regular Limit</option>
											<option value="D">Additional Limit</option>
											<option value="O">One Time Limit</option>
											</select>	
										</td>
										<td id="idsubadhoc"  style="display: none;">Base facility of </td>
										<td id="idsubadhoc1"  style="display: none;">
										<select name="selsubadhocof">
        									<option value="">--Select--</option>
        									</td>
									</tr>
								<!-- End of Arsath -->
									<%if(facility_type.equalsIgnoreCase("S")) {%>
									<tr>
										<td nowrap="nowrap">Whether to be Restructure<span
											class="mantatory">*</span></td>
										<td><select name="selsubfac_restr_acc" onchange="funenablesubfitl();changeCEFAFsub();hideCBSaccountno();">
        									<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									</select></td>
										<td id="idsubfacrestr1" style="visibility: hidden;position: absolute;"><span id="res_label_sub">Whether FITL Account</span>
										<span class="mantatory">*</span></td>
										<td id="idsubfacrestr2" style="visibility: hidden;position: absolute;">
										<select name="selsubfac_fitl_acc" onchange="funenablesubfitl();changeCEFAFsub();hideCBSaccountno();">
        									<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									</select>&nbsp;
        									</td>
									</tr>
									
									<tr id="idsubfacrestr3">
										<td nowrap="nowrap">Conversion of Existing facility<span
											class="mantatory">*</span></td>
										<td><select name="sel_restr_conversionfac_sub" onchange="changeCEFAFsub();hideCBSaccountno();">
										<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									<option value="NA">Not Applicable</option>
        									</select>
        									</td>
        								<td nowrap="nowrap">Additional funding/finance<span
											class="mantatory">*</span></td>
										<td><select name="sel_restr_addfunding_sub">
										<option value="">--Select--</option>
        									<option value="Y">Yes</option>
        									<option value="N">No</option>
        									<option value="NA">Not Applicable</option>
        									</select>
        									</td>
									</tr>
									
									<tr>
									<td nowrap="nowrap" id="id_restr_scheme_sub">Restructure Settlement Scheme<span
											class="mantatory">*</span></td>
        								<td  id="id_restr_scheme_sub1"><select name="sel_restr_scheme_sub">
        								<option value="">Select</option>
        								<lapschoice:StaticDataTag apptype="154"  tagType="<%=strAppstatus%>"/>
        									</select></td>
        									
										<td nowrap="nowrap"  id="id_restracc_sub"><span id="resAcc_label_sub">Existing CBS Account no.</span>
										<span class="mantatory">*</span></td>
										<td  id="id_restracc_sub1"><select name="sel_restr_acc_sub" onChange="AccSelect_Sub()" multiple>
        								<lapschoice:restraccSelect appno="<%=strAppno%>"/>
        									</select>
        									<input type="hidden" name="hid_str_rsAcc_sub" value=""></td>
									</tr>
									
									<%}else{ %>
									<input type="hidden" name="selsubfac_restr_acc" id="idsubfacrestr1">
									<input type="hidden" name="selsubfac_fitl_acc" id="idsubfacrestr2">
									<input type="hidden" name="hid_str_rsAcc_sub" value="" id="id_restracc_sub">
									<input type="hidden" name="sel_restr_conversionfac_sub" value=""  id="idsubfacrestr3">
									<input type="hidden" name="sel_restr_addfunding_sub" value="" id="id_restracc_sub1">
									<input type="hidden" name="sel_restr_scheme_sub" value=""></td>
									<%}  %>
									<tr id="idfacdefermentsub">
									<td>Interest Deferment Accounts</td>
									<td><select name="hidintdefer_accsub"  onchange="chkaccount(this);">
									<option value=""><--select--></option>
        								<lapschoice:defermentAcc appid="<%=applicantid%>"/>
        									</select>
									</tr>
									
									<tr><td id="sublimitexisting">Existing Limit</td>
										<td id="sublimitexisting1"><input type="text"
											name="txt_subexist_limit" size="16"
											onBlur="javascript:roundtxt(this);"
											value="<%=Helper.correctNull((String) hshValues.get("subexist"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"  style="width:150px"></td>
										<td>Proposed Limit <b><span class="mantatory">*</span></b></td>
										<td><input type="text"
											name="txt_subproposed_limit" size="16"
											onBlur="checkRange('Y');chkInsTenor('S','A');getInterestSetupSub('Y');justification('Y');"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"
											value="<%=Helper.correctNull((String) hshValues.get("subproposed"))%>"  style="width:150px">
										</td>
									</tr>
									<tr id="renewal_justif_sub" style="display: none;">
										<td>Justification for Enhancement/Reduction </td>
										<td><textarea name="txt_renewaljustif_sub" cols="26" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>  </td>
									</tr>
									<tr>
									<td colspan="2">&nbsp;</td>
									<td>Insurance Covered Under &nbsp;
									<select name="sel_Processed_Type_sub" onChange="processedType('sub','Y')" style="width:150px" >
											<option value="">---select---</option>
											<lapschoice:StaticDataTag apptype="223" tagType="<%=strAppstatus%>"/>
										</select><span class="mantatory">*</span>

									</td>
									<td><input type="text"
											name="txt_submetlifeinsurance" size="16"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"
											value=""  style="width:150px"></td>
									</tr>
									
									<tr id="id_premium_tenor_sub" >
									          <td>Premium Tenor (in Months) <span class="mantatory">*</span></td>
									          <td>
									            <input type="text" name="txt_premium_tenor_sub" maxlength="15" size="15"
														value="<%=Helper.correctNull((String) hshValues.get("FAC_PREMIUM_TENOR"))%>" style="text-align:right" onblur="chkInsTenor('S','T');">
									          </td>
									            <td>Loan amount covered under the scheme <span class="mantatory">*</span></td>
									          <td >
									            <input type="text" name="txt_premium_loan_amt_sub" maxlength="15" size="15" onKeyPress="allowNumber(this)"
														value="<%=Helper.correctNull((String) hshValues.get("FAC_PREMIUM_LOAN_AMOUNT"))%>" style="text-align:right" onblur="chkInsTenor('S','A');">
									          </td>
									           
									            
									         
									          </tr>
									          <tr id="id_premium_Account_no1_sub">
									          <td>Operative account number from which<br> premium account will be debited  <span class="mantatory">*</span></td>
									          <td>
									            <input type="text" name="txt_premium_Account_no_sub" maxlength="16" size="15" onKeyPress="allowNumber(this)"
														value="<%=Helper.correctNull((String) hshValues.get("FAC_INS_ACCOUNT_NO"))%>" style="text-align:right">
									          </td>
									           <td>Company Name <span class="mantatory">*</span></td>
									          <td>
									            <select name="sel_Funded_Sub_Comp_Name" style="width:150px">
											<option value="0">---select---</option>
											<lapschoice:StaticDataTag apptype="223" tagType="child"/>
										</select>
									          </td>
									          
									          
											</tr>
									
									<tr>										
										<td nowrap="nowrap">Interest Type&nbsp;<b><span class="mantatory">*</span></b></td>
										<td><select name="sel_sub_inttype" onchange="getInterestSetupSub('Y');callintrate1();"  style="width:150px">
											<option value="0" selected="selected">----Select----</option>
											<option value="Fix">Fixed</option>
											<option value="Flo">Floating</option>
										</select>
										<br/> <span id="iddescsub" style="display: none;"><font color="red">Interest Rate will be define in reference rate tab </font></span></td>
											<td nowrap="nowrap">Interest Sub Type&nbsp;<b><span class="mantatory">*</span></td>
										<td><select name="sel_intsufacsubtype" style="width:160px" onchange="chkfacilityMCLR('1');checkExportCredit('1');">
											<option value="0" selected="selected">----Select----</option>
											<option value="BR">Base Rate</option>
											<option value="MCLR">MCLR</option>
											<option value="BRLEC">BR linked Export Credit</option>
											<option value="MCLEC">MCLR linked Export Credit</option>
											<option value="EBLEC">EBLR linked export credit</option>
											<option value="BPLR">BPLR</option>	
											<option value="LIBOR">LIBOR</option>
											<option value="EURIBOR">EURIBOR</option>
											<option value="EUROLIBOR">EUROLIBOR</option> 
											<option value="COMMI">Commission</option>
											<option value="SMTB">6 MONTHS TREASURY BILL</option>
											<option value="TYGS">10 YEAR GOVT SECURITY</option> 
											<option value="FTBR">FBIL-TERM MIBOR</option>
											<option value="NOTAP">Not Applicable</option>									
										</select></td>
									</tr>
									<tr id="idint2"  style="display: none;">
									<td nowrap="nowrap"> ROI Type</td>
									<td><select name="sel_sub_interesttype" onchange="">
												</select></td>
									</tr>
									<tr>
									   		<td nowrap="nowrap">Tenor (in Months)<span
											class="mantatory">*</span></td>
										<td><input type="text"
											name="txt_subfacmonths" size="5" maxlength="3"
											onKeyPress="allowInteger(this)" onblur="checkRangeTenor('Y','Y');chkInsTenor('S','T');"  style="width:150px">
											<input type="hidden" name="hid_subfacmonths">
											</td>
											<td nowrap="nowrap">Initial Holiday/Gestation/Moratorium Period(in Months)</td>											
												<td><input type="text"
													name="txt_installments_sub" size="5"
													onBlur="moratperiod1('Y');callInterestCharged1()" maxlength="3"
													value="<%=Helper.correctNull((String) hshValues
							.get("loan_noofinstallment"))%>"
													onKeyPress="allowInteger();"
													tabindex="9"  style="width:150px"><input type="hidden" name="hid_installments_sub"></td>	
									</tr>
									<tr>										
										<td>Proposed Banking Arrangement<span
											class="mantatory">*</span></td>
										<td><select name="sel_sub_propbanktype" onChange="callLeaderBank();" style="width:150px">
											<option value="" selected="selected">----Select----</option>
											<option value="S">Sole</option>
											<option value="C">Consortium</option>
											<option value="M">Multiple Banking</option>
										</select></td>
										  <td nowrap="nowrap">Repayment Type</td>
								             <td><select name="sel_sub_repaytype"  style="width:150px" onchange="repaymentselsub();">
									          	<option value="0" selected="selected" title="--Select--">----Select----</option>
									          	<option value="E"  title="EMI">EMI</option>
									          	<option value="NE" title="Non-EMI">Non-EMI</option>
									     		<option value="OD" title="On Demand">On Demand</option>
									     		<option value="LC" title="As Per LC Terms">As Per LC Terms</option>
									     		<option value="CO" title="As Per Contract Terms">As Per Contract Terms</option>
									     		<option value="BG" title="As Per BG Rules">As Per BG Rules</option>										
									          	<option value="DD" title="On Due Date">On Due Date</option>
									          	<option value="PC" title="PC: From the proceeds of PSC / by realization of bill">PC: From the proceeds of PSC / by realization of bill</option>
						          				<option value="PS" title="PSC by Realization of Export Bills">PSC by Realization of Export Bills</option>
								             </select></td>
									</tr>
									<tr>
									<td>Mode of Payment<b><span class="mantatory">*&nbsp;</span></b></td>
												<td colspan=""><select name="selmodepayment_sub"
													tabindex="24" onChange="selOperative('sub')"
													onBlur="" style="width: 150px;">
													<option value="0" selected="selected">&lt;----Select----&gt;</option>
													<!-- <option value="S">Recover From Salary</option>
													<option value="P">Post Dated Cheque</option>
													<option value="E">Transfer from Saving/Current a/c</option>
													<option value="D">Electronic Cheque Clearing(ECS)</option>
													<option value="N">Cash Recovery</option> -->
													<lapschoice:StaticDataNewTag apptype="217" />
												</select></td>
									<td id="opnolabel_sub">Operative Account Number:<b><span class="mantatory">*&nbsp;</span></b></td>
											<td id="opnovalue_sub"><input type="text"
													name="txt_operativeaccno_sub" id="opaccno" onKeyPress="allowInteger()" onBlur="ValidateOpearativeAcc(this,'txt_operativeaccno_sub')"
													value="<%=Helper.correctNull((String) hshValues	.get("facility_operationaccno"))%>"
													disabled="disabled" maxlength="16">
											</td></tr>
								<tr id="consort_sub">
									<td>Name of the Leader Bank <span class="mantatory">*</span></td>
									<td>
											<input type="text" name="txt_sub_LeadBank"  size="40" readOnly="readonly"  
												maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
												 tabindex="10">
												 <input type="hidden" name="hid_sub_Bankcode" value="">
										<a href="#" onClick="callBankmasterNew1('147')" style="cursor: hand">
										<img id="leaderbankSub" src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
										</a>
									</td>
									<td colspan="2">&nbsp;</td>
									</tr>
																					
										
									<tr>
									
									<td>Periodicity of Installments </td>
												<td><select name="sel_peridicityfacsub"
													 tabindex="14" style="width:150px" onchange="selsubperiodicity();">
													<option value="s" selected="selected">Select</option>
													<option value="m" selected="selected">Monthly</option>
													<option value="q">Quarterly</option>
													<option value="h">Half-Yearly</option>
													<option value="y">Yearly</option>
													<option value="n">Not Applicable</option>
												</select></td>
												
										             <td nowrap="nowrap">Interest/ Discount/ Commission (%) <span
											class="mantatory">*</span></td>
										<td>
										<%
											strInt = Helper.correctNull((String) hshValues
													.get("subfacinterest"));
										%> <input type="text" name="prd_subintrate" size="10"
											onKeyPress="allowNumber(this)" maxlength="13" onBlur="roundtxt(this)"
											style="text-align: right" readonly="readonly"  style="width:150px">
											<input type="hidden" name="hidIntIdFacSub"/>
											<input type="hidden" name="hidBaseRateFacSub"/>											
											
											</td>																					
									
									
									</tr>
									
									          <tr id="newid1">
												<td nowrap="nowrap">Interest to be collected during Holiday<b><span class="mantatory">*</span></b></td>												
												<td><select
													name="interestservised_sub" onChange="callInterestCharged1();"   style="width:150px">
													<option value="s" selected="selected">Not
													Applicable</option>
													<option value="n">------No------</option>
													<option value="y">------Yes------</option>
												</select></td>
													<td>Interest charged</td>												
												<td><select name="sel_interestcharge_sub"
													onChange=""  style="width:150px">
													<option value="1" title="To be paid as and when debited">To be paid as and when debited</option>
													<option value="2" title="To be accumulated and added to the principal to calculate EMI">To be accumulated and added to the principal to calculate EMI</option>
													<option value="3">--Select--</option></select> &nbsp;&nbsp;&nbsp;</td>																								
												</tr>
												
												
												<tr>
												
												 			  <td>Margin</td>
												  <td><textarea
											name="txt_margin_sub" cols="26" rows="2"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
											<td nowrap="nowrap">Purpose</td>
										<td><textarea name="txt_subpurpose" cols="26" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea></td>
										</tr>
									<tr>
									<tr id="idsubmargin">
									
							    	<td>Relaxation in margin as per RBI COVID relief Package Policy</td>
									<td><select name="sel_marginsub" onchange="enablemargin('S');">
									<option value=""><--select--></option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									</select></td>
									<td nowrap="nowrap">Predefined Margin(%) &nbsp;	</td><td>								
									<select name="sel_definedmarginsub"  style="width:150px">
													<option value="">---select---</option>
													<lapschoice:StaticDataTag apptype="235" />
												</select>
									</td>											
										
										
									</tr>
									<tr  id="idsubmargin1">
									<td colspan="2">&nbsp;</td>
									<td>Relaxed Margin(%) &nbsp;</td>									
									<td><select name="sel_relaxedmarginsub"  style="width:150px" onchange="chkactualMargin('N')">
													<option value="">---select---</option>
													<lapschoice:StaticDataTag apptype="236" />
												</select>
												</td>
									</tr>

									     <!--<td id="idsubremarks">Remarks</td>
									     <td id="idsubremarkstxt"><textarea
										name="txt_remarks_sub" cols="26" rows="2" ></textarea></td>	-->
				 							
									
										<td nowrap="nowrap">
										<%
											if (!strCategoryType.equalsIgnoreCase("ADC")
													&& !strCategoryType.equalsIgnoreCase("STL")) {
										%>Irregularities, if
										any<%
											} else {
										%>Overdues, if any<%
											}
										%>
										</td>
										
										<td>
										<%
											if (!strCategoryType.equalsIgnoreCase("ADC")
													&& !strCategoryType.equalsIgnoreCase("STL")) {
										%><textarea
											name="txt_subdesc" cols="26" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
										.get("subdesc"))%></textarea> <%
 	} else {
 %> <input type="text"
											name="txt_subdesc" size="16"
											onBlur="javascript:roundtxt(this)"
											value="<%=Helper.correctNull((String) hshValues
										.get("subdesc"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align: right"> <%
 	}
 %>
										</td>
										<td  id="idexissubfacaccnolab">Existing CBS Account No.&nbsp;</td>
										<td  id="idexissubfacaccnoval"><input type="text" name="txtsubcbsaccno">&nbsp;</td>
															
								</tr>
								<tr>
								
									    <td nowrap="nowrap">Govt. Sponsor Scheme<span
											class="mantatory">*</span></td>									
												<td><select name="selectgovt"
													onChange="selsub('Y')"  style="width:150px">
													<option value="1">Yes</option>
													<option value="2" selected="selected">No</option>
												</select></td>
												
										<td nowrap="nowrap">Process note Description<span
											class="mantatory">*</span></td>
									    <td>
									  <select name="sel_subdisplaydesc"  style="width:150px">
													<option value="0">---select---</option>
												</select> &nbsp;
											 <input type="hidden" name="txt_subfac_type">
										</td>						
									</tr>
									<tr>												
												<td id="s5">&nbsp;Scheme Type<span
											class="mantatory">*</span></td>
												<td id="s6"><select name="schemetype"  style="width:150px">
													<option value="0">---select---</option>
													<lapschoice:StaticDataTag apptype="11" tagType="<%=strAppstatus%>" />
												</select> &nbsp;</td>												
                                               	<td id="s1">Subsidy Amount<span
											class="mantatory">*</span></td>
												<td id="s2">&nbsp;<lapschoice:CurrencyTag name="subamt"
													size="20" maxlength="10" onBlur="checkamt('Y')"
													value='<%=Helper.correctNull((String)hshValues.get("loan_sub"))%>'
													tabindex="18"  style="width:150px"/> &nbsp;</td>											
											</tr>
																					
											<tr id="s3">
												<td nowrap="nowrap">Sponsor Agency<span
											class="mantatory">*</span></td>
												<td><select name="sel_sponser_agency"
													tabindex="19"  style="width:150px" onchange="showsubAgency()">
													<option value="0">Select</option>
													<%
														 apptype = "3";
													%>
													<lapschoice:StaticDataTag apptype="<%=apptype%>" />
												</select></td>									
												<td>Subsidy type<span
											class="mantatory">*</span></td>
												<td><select name="sel_subsidytype" tabindex="20"  style="width:150px">
													<option value="0">Select</option>
													<%
														apptype = "5";
													%>
													<lapschoice:StaticDataTag apptype="<%=apptype%>" />
												</select></td>
											</tr>
											<tr id="s4s">
											<td nowrap="nowrap">Name of the Agency</td>
											<td><input type="text" name="txt_subagency" maxlength='50' size='50'/></td>
											<td colspan='2'></td>
										</tr>
									
									<tr id="subcg1">
										<td> Whether CGTMSE is applicable<span class="mantatory">*</span></td>
										<td><select name="cgtmse_appsub"  onchange="cgtmsesub()" />
		        									<option value="" selected="selected">--Select--</option>
		        									<option value="Y">Yes</option>
		        									<option value="N">No</option>
		        									</select></td>																
									</tr>
									<tr>
									     <td nowrap="nowrap">Additional / Fresh Limit sought by Borrower </td>
									    <td>
									    	<input type="text"
											name="txt_freshlimitsub" size="16"
											onKeyPress="allowNumber(this)" maxlength="13" onBlur="roundtxt(this)"
											style="text-align: right"
											value="<%=Helper.correctNull((String) hshValues.get(""))%>"  style="width:150px">
									</td>
									<td id="idsubduedate" width="20%">Due Date<span class="mantatory">*</span></td>
											<td width="21%" id="idsubduedatetxt"><input type="text" name="txt_subduedate"
													size="16"
													onBlur="checkDate(this);checkduedate('N',this);"
													value="">
												<a alt="Select date from calender" id="subduedate"
													href="#" onClick="callCalender('txt_subduedate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
									</tr>
									<tr id="idreviewsub" style="display: none;">
									<td>Reviewed Due Date <span class="mantatory">*</span></td>
									<td><input type="text" name="txt_subreviewdate"
													size="16"
													onBlur="checkDate(this);checkmindate(this,currentDate);checkmindate(this,document.forms[0].txt_subduedate.value);checkReviewDate(this,'N');"
													value="">
												<a alt="Select date from calender" 
													href="#" onClick="callCalender('txt_subreviewdate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
												
									</tr>	
									
									<!-- <tr >
										<td nowrap="nowrap" id="idsubmibordate" style="visibility: hidden; position: absolute;" > FBIL-T-Bill referred date <span
											class="mantatory">*</span> </td>
											<td nowrap="nowrap" id="idsubmibordate1" style="visibility: hidden; position: absolute;">
										<input
													type="text" name="txtsubDate" maxlength="21" readonly
													size="20" onBlur="allowalwysOldDate(this,currentDate,'');
													miborsubtenor(this);"
													value="" >&nbsp;
													<a alt="Select date from calender" href="#"
																	onClick="callCalender('txtsubDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src=""img/calen.gif"
																	border="0" alt="Select date from calender"
																	tabindex="29"></a>
															
										</td>	
										<td nowrap="nowrap" id="idsubmibortenor" style="visibility: hidden; position: absolute;"> Tenor <span
											class="mantatory">*</span>
								</td>
								<td  nowrap="nowrap" id="idsubmibortenor1" style="visibility: hidden; position: absolute;">
								<select name="Tenormiborsub" onchange="ftbilldatechk(this,document.forms[0].txtsubDate.value,'sub');" >
        									<option value="" selected="selected">--Select--</option>
        									<option value="1">7-days</option>
        									<option value="2">14- days</option>
        									<option value="3">1-Month</option>
        									<option value="4">2-Months</option>
        									<option value="5">3-Months</option>
        									<option value="6">4-Months</option>
        									<option value="7">5-Months</option>
        									<option value="8">6-Months</option>
        									<option value="9">7-Months</option>
        									<option value="10">8-Months</option>
        									<option value="11">9-Months</option>
        									<option value="12">10-Months</option>
        									<option value="13">11-Months</option>
        									<option value="14">12-Months</option>
        									</select>
								</td>
				
								
								
								</tr>-->
												
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
<br>
<%if(strSHGcustomer.equalsIgnoreCase("Y")){ %> 
<table width="10%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable linebor">
<tr align="center"><td>
<input type="button" value="SHG Member Wise Loan Share" onClick="LoadSharePage()" class="buttonOthers">
</td></tr>
</table>
<br>
<%} %>
<table width="10%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">

	<tr>
	<!-- vindhya -->
	<% if(strSessionModuleType.equalsIgnoreCase("AGR")){
	%> 
	<td  id="eNWR_button"><input type="button" name="eNWRagri" value="eNWR" class="buttonStyle" onClick="calleNWR()"></td>
	<%
	}%>
	<!-- vindhya -->
	<td><input type="button" name="deviagri" value="Deviations" class="buttonStyle"
									
															onClick="callDeviation()"></td>
		<td id="ncgtc_button" align="center"><input type="button" name="NCGTC_coverage" value="KBL Aarogya"	class="buttonStyle"  onClick="openNCGTC()"></td>
		<td id="cgtmse_button" align="center"><input type="button" name="CGTMSE_coverage" value="CGTMSE coverage"	class="buttonStyle"  onClick="openCGTMSE()"></td>
		<td id="chkliskdoc" align="center"><input type="button" name="chk_list_doc" value="Check List Document"	class="buttonStyle" onClick="checkListDOC()" ></td>
		<td id="cgtmse_financial" align="center"><input type="button" name="finanical_data" value="Finanical Data"	class="buttonStyle"  onClick="doFinancialData()"></td>
		<td id ="cgtmse_fac_button" align="center"><input type="button" name="fac_arrangement" value="Facility Arrangement" class="buttonStyle" onClick="facilityArrangement()"></td>
	</tr>
	</table>
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")) { %>
<lapschoice:combuttonnew
	btnnames='New_Edit_Save_Cancel_Delete_Delete Proposal_Remove Accounts_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<% } else { %>
<lapschoice:combuttonnew
	btnnames='New_Edit_Save_Cancel_Delete_Delete Proposal_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<% } %>
							
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="3"
	class="outertable linebor">
	<tr class="dataheader">
		<td width="3%">&nbsp;</td>
		<td width="3%" align="center">S.No</td>
		<td width="15%" align="center">Facility Head</td>
		<td align="center" width="15%">Facility</td>
		<td align="center" width="8%">
		<%
			if (!strCategoryType.equalsIgnoreCase("ADC")
					&& !strCategoryType.equalsIgnoreCase("STL")) {
		%> Irregularities, if
		any <%
			} else {
		%> Overdues, if any <%
			}
		%>
		</td>
		<td width="7%" align="center">Existing<br>
		</td>
		<td width="8%" align="center">Proposed</td>
		<td width="7%" align="center">Difference<br>
		</td>
		<td align="center" width="6%">Interest (%)</td>
		<td align="center" width="6%">Limit Type</td>
		<td align="center" width="6%">Nature of Limit</td>	
		<td align="center" width="6%">Facility Type</td>			
	</tr>
	<%
		//
		String strCGPANExpired="";
		String strSno = "", strSubLimit = "",strKCCFlag="", strBankSchemecode="";
		int j = 0, intsno = 0, intGroup = 0;
		int subGrpSize = 0;
		String strPreCategory = "", strCategory = "", strMonths = "", strbranch = "";
		String fac_type="",strRestrAcc="",strFITLAcc="",strFacRestrFrom="",strFacilityCode="";
		for (int i = 1; i <= vecsize; i++) {
			strHeaddesc = "";
			strCategory = "";
			strMonths = "";
			strFacdesc = "";
			strExist = "";
			strProposed = "";
			strDiff = "";
			strMargin = "";
			strInterest = "";
			strbranch = "";
			strbplr = "";
			strDP = "";
			strSecurity = "";
			strOutstanding = "";
			arrSubGrpList = new ArrayList();
			String strGrpList = "";
			strIntadjust = "";
			String strPurpose = "";
			String strGroup = "", strDesc = "", strCurCat = "";
			String strIntType="",strRepaytype="",strGovtsponsschem="",strSchemeType="",strSponsAgency="";
			String strSubsidyType="",strsubsidyAmunt="",strFacCode="",strSubFacCode="",strAgrSchemeType="",strAgrSubSchemeType="";
			String strHolidayPeriod="",strInterestrec="",strInterestCharged="",strModerepay="",strOperationAcno="";			
			String strRemarks="",strPerInstal="",strfacdesctype="";
			String strFacSubIntType="",strFacIntId="",strFacBaseRate="";
			String strfacDescNew="";
			String strfacnature="";
			String strAgency="";
			String strFreshLimit="";
			String strduedate="",strdisplaydesc="",fac_type_desc="",strFacConversionfac="",strFacAdditionFunding="",strLeadBankName="",strLeadBankCode="",strPSterms="",strComfacLoanType="";
			String strExistingAmt="",strExistingTenor="",strRestrScheme="",strAdhocFacfor="",strAdhocchk="",stradhocsno="",stradhocfacdesc="";
			String strFacReattachFlag="",strMetlifeInsurance="",strFacACCOUNTOPEN="",strFACILITY_EMISCHEME="",strExiProposalno="",strExiProposalSno="",strExiProposalAccno="",strExiProposalSanAmt="",strCOM_CGTMSE="",strPERAPP_CONS="";
			String strFACILITY_WHT_CGTMSEAPPLY="",strFACILITY_CG_SPLIT_INT_RATE="",strFACILITY_CG_TOT_INT_RATE="",strCGTMSECoverEDate="";
			String strFACILITY_SHARETYPE="",strMISFlag="",strROIType="",strCompanyName="",
			 strPremiumAmount="",strPremiumTenor="",strPremiumLoanAmount="",
			 strInsAccountNo="",strInsFundedCompanyName="",strMarginRelaxtion="",strActualMargin="",strRelaxedMargin="",strIntDeferment="",strReviewDate="",strExLimitType="",
			 strRenewalJustif="",strRenewalJustifSub="",strrestructurescheme="";
			String strecsbankname="",strecsaccounttype="",strecsifsccode="",strecsoperaccnum="",strecsauthmode="";
			//String fbildatesub="",fbiltenorsub="";
			
			vecRow = (ArrayList) vecData.get(i - 1);
			if (vecRow != null) {

				strHeadId = Helper
						.correctNull((String) vecRow.get(0));
				
				vecHead.add(strHeadId);
				strFacId = Helper.correctNull((String) vecRow.get(2));
				if(strHeadId.equalsIgnoreCase("3")&&strFacId.equalsIgnoreCase("84"))
					strKCCFlag="N";
				else if(strHeadId.equalsIgnoreCase("3")&&strFacId.equalsIgnoreCase("94"))
					strKCCFlag="Y";
				
				vecFac.add(strHeadId);
				strHeaddesc = Helper.correctNull((String) vecRow
						.get(1));
				strFacdesc = Helper.correctNull((String) vecRow
						.get(51));
				strMargin = Helper.correctNull((String) vecRow
						.get(17));
				strProposed = Helper.correctNull((String) vecRow
						.get(7));
				strDiff = Helper.correctNull((String) vecRow.get(8));
				strIntadjust = Helper.correctNull((String) vecRow
						.get(9));
				strSno = Helper.correctNull((String) vecRow.get(10));
				strGroup = Helper
						.correctNull((String) vecRow.get(11));
				strDesc = Helper.correctNull((String) vecRow.get(12));
				strCategory = Helper.correctNull((String) vecRow
						.get(13));
				strMonths = Helper.correctNull((String) vecRow
						.get(14));
				strInterest = Helper.correctNull((String) vecRow
						.get(16));
				strbranch = Helper.correctNull((String) vecRow
						.get(15));
				strExist = jtn.format(Double.parseDouble(Helper.correctDouble((String) vecRow.get(6))));
				strbplr = jtn.format(Double.parseDouble(Helper.correctDouble(Helper.correctNull((String) vecRow.get(18)))));
				strDP =Helper.correctNull((String)vecRow.get(19));
				strOutstanding =Helper.correctNull((String) vecRow
						.get(20));
				strSecurity = Helper.correctNull((String) vecRow
						.get(21));
				strCbsaccountno = Helper.correctNull((String) vecRow
						.get(22));
				strintremarks = Helper.correctNull((String) vecRow
						.get(25));
				strOsAsOn = Helper.correctNull((String) vecRow
						.get(26));
				strexistbanktype = Helper.correctNull((String) vecRow
						.get(27));
				strpropbanktype = Helper.correctNull((String) vecRow
						.get(28));
				strPurpose = Helper.correctNull((String) vecRow
						.get(29));
				strIntType = Helper.correctNull((String) vecRow
						.get(30));
				strRepaytype = Helper.correctNull((String) vecRow
						.get(31));
				strGovtsponsschem = Helper.correctNull((String) vecRow
						.get(32));
				strSchemeType = Helper.correctNull((String) vecRow
						.get(33));
				strSponsAgency = Helper.correctNull((String) vecRow
						.get(34));
				strSubsidyType = Helper.correctNull((String) vecRow
						.get(35));
				strsubsidyAmunt = Helper.correctNull((String) vecRow
						.get(36));
				strFacCode=Helper.correctNull((String) vecRow
						.get(38));
				strAgrSchemeType=Helper.correctNull((String) vecRow
						.get(39));
				strHolidayPeriod=Helper.correctNull((String) vecRow
						.get(40));
				strInterestrec=Helper.correctNull((String) vecRow
						.get(41));
				strInterestCharged=Helper.correctNull((String) vecRow
						.get(42));
				strModerepay=Helper.correctNull((String) vecRow
						.get(43));
				strOperationAcno=Helper.correctNull((String) vecRow
						.get(44));
				strRemarks=Helper.correctNull((String) vecRow
						.get(45));
				strPerInstal=Helper.correctNull((String) vecRow
						.get(46));
				strFacSubIntType=Helper.correctNull((String) vecRow
						.get(47));
				strFacIntId=Helper.correctNull((String) vecRow
						.get(48));
				strFacBaseRate=Helper.correctNull((String) vecRow
						.get(49));
				strfacDescNew=Helper.correctNull((String) vecRow
						.get(37));
				strfacnature=Helper.correctNull((String) vecRow
						.get(50));
				strTUF=Helper.correctNull((String) vecRow
						.get(52));
				strAgency=Helper.correctNull((String)vecRow.get(53));
				
				
				strfacdesctype=Helper.correctNull((String) vecRow
						.get(54));
				
				strFreshLimit=Helper.correctNull((String) vecRow.get(55));
				strduedate=Helper.correctNull((String) vecRow.get(56));
				strdisplaydesc=Helper.correctNull((String) vecRow.get(57));
				//by gokul
				subGrpSize = Integer.parseInt(Helper
						.correctNull((String) vecRow.get(23)));
				arrSubGrpList = (ArrayList) vecRow.get(24);
				if(arrSubGrpList != null && arrSubGrpList.size() > 0)
				{
					for (int g = 0; g < arrSubGrpList.size(); g++) 
					{
						if (strGrpList.trim().equalsIgnoreCase(""))
							strGrpList = Helper.correctNull((String) arrSubGrpList.get(g));
						else
							strGrpList = ((strGrpList) + "&" + (Helper.correctNull((String) arrSubGrpList.get(g))));
					}
				}
				//by gokul-end
				strCurCat = strCategory;
				intsno = Integer.parseInt(strSno);
				if (!strGroup.trim().equals("")) 
				{
					intGroup = Integer.parseInt(strGroup);
				}
				fac_type=Helper.correctNull((String) vecRow.get(54));
				if(fac_type.equalsIgnoreCase("2"))
				{
					fac_type_desc="Renew";
				}
				else if(fac_type.equalsIgnoreCase("3"))
				{
					fac_type_desc="Restructured";
				}
				else if(fac_type.equalsIgnoreCase("4"))
				{
					fac_type_desc="Post Sanction";
				}
				else
				{
					fac_type_desc="Fresh";
				}
				strRestrAcc=Helper.correctNull((String) vecRow.get(59));
				strFITLAcc=Helper.correctNull((String) vecRow.get(60));
				strFacRestrFrom=Helper.correctNull((String) vecRow.get(61));
				strFacilityCode=Helper.correctNull((String) vecRow.get(62));
				strFacConversionfac=Helper.correctNull((String) vecRow.get(63));
				strFacAdditionFunding=Helper.correctNull((String) vecRow.get(64));
				strLeadBankCode=Helper.correctNull((String) vecRow.get(65));
				strLeadBankName=Helper.correctNull((String) vecRow.get(66));
				strPSterms=Helper.correctNull((String) vecRow.get(67));
				strComfacLoanType=Helper.correctNull((String) vecRow.get(70));
				strExistingAmt=Helper.correctNull((String) vecRow.get(68));
				strExistingTenor=Helper.correctNull((String) vecRow.get(69));
				strRestrScheme=Helper.correctNull((String) vecRow.get(71));
				strAdhocFacfor=Helper.correctNull((String) vecRow.get(72));
				strAdhocchk=Helper.correctNull((String) vecRow.get(73));
				stradhocfacdesc=Helper.correctNull((String) vecRow.get(74));
				stradhocsno=Helper.correctNull((String) vecRow.get(75));
				strFacReattachFlag=Helper.correctNull((String) vecRow.get(76));
				strMetlifeInsurance=Helper.correctNull((String) vecRow.get(77));
				strFacACCOUNTOPEN=Helper.correctNull((String) vecRow.get(78));
				strFACILITY_EMISCHEME=Helper.correctNull((String) vecRow.get(79));
				strExiProposalno=Helper.correctNull((String) vecRow.get(80));
				strExiProposalSno=Helper.correctNull((String) vecRow.get(81));
				strExiProposalAccno=Helper.correctNull((String) vecRow.get(82));
				strExiProposalSanAmt=Helper.correctNull((String) vecRow.get(83));
				strCOM_CGTMSE=Helper.correctNull((String) vecRow.get(84));
				//strPERAPP_CONS=Helper.correctNull((String) vecRow.get(85));
				strFACILITY_WHT_CGTMSEAPPLY=Helper.correctNull((String) vecRow.get(85));
				strCGTMSECoverEDate=Helper.correctNull((String) vecRow.get(86));
				strFACILITY_CG_SPLIT_INT_RATE=Helper.correctNull((String) vecRow.get(87));
				strFACILITY_CG_TOT_INT_RATE=Helper.correctNull((String) vecRow.get(89));
				strFACILITY_SHARETYPE=Helper.correctNull((String) vecRow.get(90));
				strMISFlag=Helper.correctNull((String) vecRow.get(91));
				strROIType=Helper.correctNull((String) vecRow.get(92));
				strCompanyName=Helper.correctNull((String) vecRow.get(93)); 
				 strPremiumTenor=Helper.correctNull((String) vecRow.get(94));
				 strPremiumLoanAmount=Helper.correctNull((String) vecRow.get(95));
				 strInsAccountNo=Helper.correctNull((String) vecRow.get(96));
				 strPremiumAmount=Helper.correctNull((String) vecRow.get(97));
				 strInsFundedCompanyName=Helper.correctNull((String) vecRow.get(98));
				 strMarginRelaxtion=Helper.correctNull((String) vecRow.get(99));
				 strActualMargin=Helper.correctNull((String) vecRow.get(100));
				 strRelaxedMargin=Helper.correctNull((String) vecRow.get(101));
				 strIntDeferment=Helper.correctNull((String) vecRow.get(102));
				 if(!strIntDeferment.equalsIgnoreCase(""))
				 {
					 if(strIntDefAccDetails.equalsIgnoreCase(""))
					 {
						 strIntDefAccDetails=strSno+"~"+strIntDeferment;
					 }
					 else
					 {
						 strIntDefAccDetails=strIntDefAccDetails+"@"+strSno+"~"+strIntDeferment; 
					 }
				 }
				 strReviewDate=Helper.correctNull((String) vecRow.get(103));
				 strExLimitType=Helper.correctNull((String) vecRow.get(104));
				 strRenewalJustif=Helper.correctNull((String) vecRow.get(105));
				 strecsbankname = Helper.correctNull((String) vecRow.get(106));
				 strecsaccounttype = Helper.correctNull((String) vecRow.get(107));
				 strecsifsccode = Helper.correctNull((String) vecRow.get(108));
				 strecsoperaccnum = Helper.correctNull((String) vecRow.get(109));
				 strecsauthmode = Helper.correctNull((String) vecRow.get(110));
				 strBankSchemecode= Helper.correctNull((String) vecRow.get(112));
				 strCGPANExpired= Helper.correctNull((String) vecRow.get(113));
				 //fbildatesub= Helper.correctNull((String) vecRow.get(114));
				// fbiltenorsub= Helper.correctNull((String) vecRow.get(115));
				 
			}
			//if((!strPreCategory.trim().equals(strCurCat.trim())) && (strCategory.trim().equals("R"))) {
				//strPreCategory = strCurCat;
	%><!--
	
	--><%
		//} else if ((!strPreCategory.trim().equals(strCurCat.trim()))
					//&& (strCategory.trim().equals("A"))) {
				//strPreCategory = strCurCat;
	%>
	<!--<tr class="dataheader">
		<td colspan="9"><b>Adhoc facilities :</b></td>
	</tr>
	--><%
		//} else if ((!strPreCategory.trim().equals(strCurCat.trim()))
					//&& (strCategory.trim().equals("I"))) {
				//strPreCategory = strCurCat;
	%>
	<!--<tr class="dataheader">
		<td colspan="9"><b>Inner Limit facilities :</b></td>
	</tr>
	--><%
	//	} else if ((!strPreCategory.trim().equals(strCurCat.trim()))
					//&& (strCategory.trim().equals("O"))) {
				//strPreCategory = strCurCat;
	%>
	<!--<tr class="dataheader">
		<td colspan="8"><b>Outer Limit facilities :</b></td>
	</tr>
	-->
	<%
		//} else if ((!strPreCategory.trim().equals(strCurCat.trim()))
					//&& (strCategory.trim().equals("C"))) {
				//strPreCategory = strCurCat;
	%>
	<!--<tr class="dataheader">
		<td colspan="8"><b>Inter Changeable Limit facilities :</b></td>
	</tr>
	--><%
		//} else if ((!strPreCategory.trim().equals(strCurCat.trim()))
					//&& (strCategory.trim().equals("P"))) {
				//strPreCategory = strCurCat;
	%>
	<!--<tr class="dataheader">
		<td colspan="8"><b>Apportion Limit facilities :</b></td>
	</tr>
	--><%
		//}
	%>
	<%
		if (strGroup.trim().equals("0")) {
				j = 0;
	%>
	<%-- <tr class="datagrid">
		<td colspan="11"><b>&gt;&gt;Main Limit </b></td>
	</tr>--%>
	<tr class="datagrid">
		<td align="center">
		<%
			if (strSno.trim().equals(strselsno.trim())) {
		%> <input type="radio"
			name="sno" style="border-style: none"
			onClick="selectValues(<%=intsno%>,<%=intGroup%>,<%=subGrpSize%>,'<%=strGrpList%>','<%=strCGPANExpired%>');selectvalues1();checkcgtmse();cgtmse();cgtmsesub();">
		<%
			} else {
		%> <input type="radio" name="sno" style="border-style: none"
			onClick="selectValues(<%=intsno%>,<%=intGroup%>,<%=subGrpSize%>,'<%=strGrpList%>','<%=strCGPANExpired%>');selectvalues1();checkcgtmse();cgtmse();cgtmsesub();">
		<%
			}
		%>
		</td>
		
		 
		<td align="center"><%=intsno %></td>
		<td><input type="hidden"
			name="txtheadid<%=intsno%>" value="<%=strHeadId%>"
			style="border: 0; text-align: right"> <%=strHeaddesc%></td>
		<td><input type="hidden"
			name="txtfacid<%=intsno%>" value="<%=strFacId%>"
			style="border: 0; text-align: right"> <%=strFacdesc%></td>
		<td><input type="hidden"
			name="txtdesc<%=intsno%><%=intGroup%>" value="<%=strDesc%>">
		<%=strDesc%></td>
		<td align="right"><%=strExist%> <input type="hidden"
			name="txtexist<%=intsno%><%=intGroup%>" value="<%=strExist%>"></td>
		<td align="right"><%=strProposed%> <input
			type="hidden" name="txtproposed<%=intsno%><%=intGroup%>"
			value="<%=strProposed%>">
			<input type="hidden" name="txtfacnature<%=intsno%><%=intGroup%>"
			value="<%=strfacnature%>">
			
			</td>
		<td align="right"><%=strDiff%></td>
		<td><%=strbplr%> <input type="hidden"
			name="txtmargin<%=intsno%><%=intGroup%>" value="<%=strIntadjust%>">
		<input type="hidden" name="txtsno<%=intsno%>" value="<%=strSno%>">
		<input type="hidden" name="txtgroup<%=intsno%>" value="<%=strGroup%>">
		<input type="hidden" name="txtsublimit<%=intsno%>"> <input
			type="hidden" name="txtcategory<%=intsno%><%=intGroup%>" value="<%=strCategory%>">
		<input type="hidden" name="txtmonths<%=intsno%><%=intGroup%>"
			value="<%=strMonths%>"> <input type="hidden"
			name="txtbranchname<%=intsno%>" value="<%=strbranch%>"> <input
			type="hidden" name="txt_interest<%=intsno%><%=intGroup%>"
			value="<%=strInterest%>"> <input type="hidden"
			name="txtbplr<%=intsno%><%=intGroup%>" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble(strbplr)))%>">
		<input type="hidden" name="txtdp<%=intsno%><%=intGroup%>"
			value="<%=strDP%>"> <input type="hidden"
			name="txtoutstanding<%=intsno%><%=intGroup%>"
			value="<%=strOutstanding%>"> <input type="hidden"
			name="txtsecurity<%=intsno%><%=intGroup%>" value="<%=strSecurity%>">
		<input type="hidden" name="hidcbsaccno<%=intsno%><%=intGroup%>"
			value="<%=strCbsaccountno%>"> <input type="hidden"
			name="txtintremarks<%=intsno%><%=intGroup%>"
			value="<%=strintremarks%>"> 
			<input type="hidden"
			name="txtTUF<%=intsno%><%=intGroup%>"
			value="<%=strTUF%>"> 
			<input type="hidden"
			name="txtosdate<%=intsno%><%=intGroup%>" value="<%=strOsAsOn%>">
		<input type="hidden" name="selexistbanktype<%=intsno%><%=intGroup%>"
			value="<%=strexistbanktype%>"> <input type="hidden"
			name="selpropbanktype<%=intsno%><%=intGroup%>"
			value="<%=strpropbanktype%>"> <input type="hidden"
			name="txtpurpose<%=intsno%><%=intGroup%>" value="<%=strPurpose%>">
			
			
			
			<input type="hidden" name="selinttype<%=intsno%><%=intGroup%>"
			value="<%=strIntType%>"> 
			
			
			<input type="hidden" name="selrepaytype<%=intsno%><%=intGroup%>"
			value="<%=strRepaytype%>"> 
			<input type="hidden" name="selgovtscheme<%=intsno%><%=intGroup%>"
			value="<%=strGovtsponsschem%>"> 
			
			<input type="hidden" name="hidFreshLimitmain<%=intsno%><%=intGroup%>"
			value="<%=strFreshLimit%>"> 
			
			<input type="hidden" name="selschemetype<%=intsno%><%=intGroup%>"
			value="<%=strSchemeType%>"> 
			<input type="hidden" name="selsponsagency<%=intsno%><%=intGroup%>"
			value="<%=strSponsAgency%>"> 
			<input type="hidden" name="selsubsidytype<%=intsno%><%=intGroup%>"
			value="<%=strSubsidyType%>"> 
			<input type="hidden" name="txtsubsidyamunt<%=intsno%><%=intGroup%>"
			value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(strsubsidyAmunt)))%>"> 
				<input type="hidden" name="selfaccode<%=intsno%><%=intGroup%>"
			value="<%=strFacCode%>"> <input type="hidden" name="hid_strAgrSchemeType<%=intsno%><%=intGroup%>" value="<%=strAgrSchemeType%>">
				<input type="hidden" name="selhoidayperiod<%=intsno%><%=intGroup%>"
			value="<%=strHolidayPeriod%>"> 
				<input type="hidden" name="selintereceived<%=intsno%><%=intGroup%>"
			value="<%=strInterestrec%>"> 
				<input type="hidden" name="selinterestcharged<%=intsno%><%=intGroup%>"
			value="<%=strInterestCharged%>"> 
				<input type="hidden" name="selmodepay<%=intsno%><%=intGroup%>"
			value="<%=strModerepay%>"> 
				<input type="hidden" name="seloperaccno<%=intsno%><%=intGroup%>"
			value="<%=strOperationAcno%>">
					<input type="hidden" name="selmargin<%=intsno%><%=intGroup%>"
			value="<%=strMargin%>">
			<input type="hidden" name="selremarks<%=intsno%><%=intGroup%>" value="<%=strRemarks%>">
			<input type="hidden" name="selperinstalfac<%=intsno%><%=intGroup%>" value="<%=strPerInstal%>">
			<input type="hidden" name="selintsubtypefac<%=intsno%><%=intGroup%>" value="<%=strFacSubIntType%>">
			<input type="hidden" name="selIntIdFac<%=intsno%><%=intGroup%>" value="<%=strFacIntId%>">
			<input type="hidden" name="selFacBaseRate<%=intsno%><%=intGroup%>" value="<%=strFacBaseRate%>">
			<input type="hidden" name="strfacDescNew<%=intsno%><%=intGroup%>" value="<%=strfacDescNew%>">

			<input type="hidden" name="strFacAgency<%=intsno%><%=intGroup%>" value="<%=strAgency%>">

			<input type="hidden" name="strduedate<%=intsno%><%=intGroup%>" value="<%=strduedate%>">
			<input type="hidden" name="strdisplaydesc<%=intsno%><%=intGroup%>" value="<%=strdisplaydesc%>">
			<input type="hidden" name="hid_sel_fac_desc<%=intsno%><%=intGroup%>" value="<%=strfacdesctype%>"> 
			<input type="hidden" name="hid_sel_fac_type<%=intsno%><%=intGroup%>" value="<%=fac_type%>"> 
			<input type="hidden" name="hid_sel_fac_restracc<%=intsno%><%=intGroup%>" value="<%=strRestrAcc%>"> 
			<input type="hidden" name="hid_sel_fac_fitlacc<%=intsno%><%=intGroup%>" value="<%=strFITLAcc%>"> 
			<input type="hidden" name="hid_sel_fac_RestrFrom<%=intsno%><%=intGroup%>" value="<%=strFacRestrFrom%>"> 
			<input type="hidden" name="hid_facility_code<%=intsno%><%=intGroup%>" value="<%=strFacilityCode%>">
			<input type="hidden" name="hid_selconversionfac<%=intsno%><%=intGroup%>" value="<%=strFacConversionfac%>">
			<input type="hidden" name="hid_seladdfunding<%=intsno%><%=intGroup%>" value="<%=strFacAdditionFunding%>">
			<input type="hidden" name="hid_leadbankname<%=intsno%><%=intGroup%>" value="<%=strLeadBankName%>">
			<input type="hidden" name="hid_leadbankcode<%=intsno%><%=intGroup%>" value="<%=strLeadBankCode%>">
			<input type="hidden" name="hid_psterms<%=intsno%><%=intGroup%>" value="<%=strPSterms%>">
			<input type="hidden" name="hid_comfacloantype<%=intsno%><%=intGroup%>" value="<%=strComfacLoanType%>">
			<input type="hidden" name="hid_facexloanamt<%=intsno%><%=intGroup%>" value="<%=strExistingAmt%>">
			<input type="hidden" name="hid_facexloanperiod<%=intsno%><%=intGroup%>" value="<%=strExistingTenor%>">
			<input type="hidden" name="hid_facrestrscheme<%=intsno%><%=intGroup%>" value="<%=strRestrScheme%>">
			<input type="hidden" name="hid_adhocfacfor<%=intsno%><%=intGroup%>" value="<%=strAdhocFacfor%>">
			<input type="hidden" name="hid_adhocchk<%=intsno%><%=intGroup%>" value="<%=strAdhocchk%>">
			<input type="hidden" name="hid_adhocdesc<%=intsno%><%=intGroup%>" value="<%=stradhocfacdesc%>">
			<input type="hidden" name="hid_adhocsno<%=intsno%><%=intGroup%>" value="<%=stradhocsno%>">
			<input type="hidden" name="hid_reattachflag<%=intsno%><%=intGroup%>" value="<%=strFacReattachFlag%>">
			<input type="hidden" name="hid_metlifeinsurance<%=intsno%><%=intGroup%>" value="<%=strMetlifeInsurance%>">
						
			<input type="hidden" name="hid_cgtmse<%=intsno%><%=intGroup%>" value="<%=strFACILITY_WHT_CGTMSEAPPLY%>">
			<input type="hidden" name="hid_perapp_cons<%=intsno%><%=intGroup%>" value="<%=strPERAPP_CONS%>">			
			<input type="hidden" name="hid_fac_wht_cgtmse<%=intsno%><%=intGroup%>" value="<%=strFACILITY_WHT_CGTMSEAPPLY%>">
			<input type="hidden" name="hid_fac_cg_split_intrate<%=intsno%><%=intGroup%>" value="<%=strFACILITY_CG_SPLIT_INT_RATE%>">
			<input type="hidden" name="hid_fac_cg_tot_intrate<%=intsno%><%=intGroup%>" value="<%=strFACILITY_CG_TOT_INT_RATE%>">
			<input type="hidden" name="hid_fac_coverenddate<%=intsno%><%=intGroup%>" value="<%=strCGTMSECoverEDate%>">
			<input type="hidden" name="hid_sharetype<%=intsno%><%=intGroup%>" value="<%=strFACILITY_SHARETYPE%>">
			<input type="hidden" name="hidMISFlag<%=intsno%><%=intGroup%>" value="<%=strMISFlag%>">
			<input type="hidden" name="hidROIType<%=intsno%><%=intGroup%>" value="<%=strROIType%>">
			<input type="hidden" name="hidCompanyName<%=intsno%><%=intGroup%>" value="<%=strCompanyName%>">
			<input type="hidden" name="hidPremiumTenor<%=intsno%><%=intGroup%>" value="<%=strPremiumTenor%>">
			<input type="hidden" name="hidPremiumLoanAmount<%=intsno%><%=intGroup%>" value="<%=strPremiumLoanAmount%>">
			<input type="hidden" name="hidPremiumInsAccountNo<%=intsno%><%=intGroup%>" value="<%=strInsAccountNo%>">
			<input type="hidden" name="hidPremiumAmount<%=intsno%><%=intGroup%>" value="<%=strPremiumAmount%>">
			<input type="hidden" name="hidPremiumConpanyName<%=intsno%><%=intGroup%>" value="<%=strInsFundedCompanyName%>">
			<input type="hidden" name="hidMarginRelaxReq<%=intsno%><%=intGroup%>" value="<%=strMarginRelaxtion%>">
			<input type="hidden" name="hidActualMargin<%=intsno%><%=intGroup%>" value="<%=strActualMargin%>">
			<input type="hidden" name="hidRelaxedMargin<%=intsno%><%=intGroup%>" value="<%=strRelaxedMargin%>">
			<input type="hidden" name="hidintDeferment<%=intsno%><%=intGroup%>" value="<%=strIntDeferment%>">
			<input type="hidden" name="hidReviewDate<%=intsno%><%=intGroup%>" value="<%=strReviewDate%>">
			<input type="hidden" name="hidRenewalJustif<%=intsno%><%=intGroup%>" value="<%=strRenewalJustif%>">

			<input type="hidden" name="hidFacACCOUNTOPEN<%=intsno%><%=intGroup%>" value="<%=strFacACCOUNTOPEN%>">
			<input type="hidden" name="hidFACILITY_EMISCHEME<%=intsno%><%=intGroup%>" value="<%=strFACILITY_EMISCHEME%>">
			<input type="hidden" name="hidExPropno<%=intsno%><%=intGroup%>" value="<%=strExiProposalno%>">
			<input type="hidden" name="hidExPropSno<%=intsno%><%=intGroup%>" value="<%=strExiProposalSno%>">
			<input type="hidden" name="hidExPropAccno<%=intsno%><%=intGroup%>" value="<%=strExiProposalAccno%>">
			<input type="hidden" name="hidExPropSancAmt<%=intsno%><%=intGroup%>" value="<%=strExiProposalSanAmt%>">
			<input type="hidden" name="hidSSS" value="<%=strCOM_CGTMSE%>">		
			<input type="hidden" name="hidExLimitType<%=intsno%><%=intGroup%>" value="<%=strExLimitType%>">
			<input type="hidden" name="hidecsbankname<%=intsno%><%=intGroup%>" value="<%=strecsbankname%>">
			<input type="hidden" name="hidecsaccounttype<%=intsno%><%=intGroup%>" value="<%=strecsaccounttype%>">
			<input type="hidden" name="hidecsifsccode<%=intsno%><%=intGroup%>" value="<%=strecsifsccode%>">
			<input type="hidden" name="hidecsoperaccnum<%=intsno%><%=intGroup%>" value="<%=strecsoperaccnum%>">
			<input type="hidden" name="hidecsauthmode<%=intsno%><%=intGroup%>" value="<%=strecsauthmode%>">
			<input type="hidden" name="hidBankschemecode<%=intsno%>" value="<%=strBankSchemecode%>">
			<!-- <input type="hidden" name="fbildate">
			<input type="hidden" name="fbiltenor"> -->
			
		</td>
		<td>Main-Limit</td>
		<td>
		<%if (strGroup.trim().equals("0")) { 
		   if(strCategory.trim().equals("R")) {%>
		   Regular Limit
		<%} else if(strCategory.trim().equals("A")) {%>
		Adhoc Limit
		<%}else if(strCategory.trim().equals("D")) {%>
		Additional Limit
		<%}else if(strCategory.trim().equals("O")) {%>
		One time Limit
		<%} }%>
		</td>
		<td>
		<%=fac_type_desc %>
		</td>
	</tr>
	<%
		} else {
	
				if ((!strGroup.equals(strSubLimit))
						&& (!strGroup.trim().equals("0"))) {
					strSubLimit = strGroup;
					j++;
	%>
	<%-- <tr class="datagrid">
		<td width="6%">&nbsp;</td>
		<td colspan="10"><b>&gt;&gt;</b> <b>Sub-Limit</b></td>
	</tr>--%>
	<%
		}
	%>
	<tr class="datagrid">
		<td width="6%" align="center">
		<font color="#3f3f40">
		 <%
			if (strSno.trim().equals(strselsno.trim())) {
						strsubselsno = strGroup;
						
		%> <input type="radio" name="sno" style="border-style: none"
			onClick="selectValues(<%=intsno%>,<%=intGroup%>,<%=subGrpSize%>,'<%=strGrpList%>');selectvalues1();checkcgtmse();cgtmse();cgtmsesub();">
		<%
			} else {
		%> <input type="radio" name="sno" style="border-style: none"
			onClick="selectValues(<%=intsno%>,<%=intGroup%>,<%=subGrpSize%>,'<%=strGrpList%>');checkcgtmse();cgtmse();cgtmsesub();">
		<%
			}
		%></font>
		</td>
		<td align="center"><%=intsno %></td>
		<td  align="left"> 
		<font color="#3f3f40">
		<input type="hidden"
			name="txtsubheadid<%=intsno%>" value="<%=strHeadId%>"
			style="border: 0; text-align: right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=strHeaddesc%></font></td>
		<td align="left"> <font color="#3f3f40"><input type="hidden"
			name="txtsubfacid<%=intsno%>" value="<%=strFacId%>"
			style="border: 0; text-align: right"> <%=strFacdesc%></font></td>
		<td align="left" width="15%"> <font color="#3f3f40"><input type="hidden"
			name="txtsubdesc<%=intsno%><%=intGroup%>" value="<%=strDesc%>">
		<%=strDesc%></font></td>
		<td align="right"> <font color="#3f3f40">(<%=strExist%>) <input type="hidden"
			name="txtsubexist<%=intsno%><%=intGroup%>" value="<%=strExist%>"></font>
			</td>
		<td  align="right"> <font color="#3f3f40"><input type="hidden"
			name="txtsubproposed<%=intsno%><%=intGroup%>"
			value="<%=strProposed%>"> (<%=strProposed%>)
			<input type="hidden" name="txtsubfacnature<%=intsno%><%=intGroup%>"
			value="<%=strfacnature%>"></font>
			</td>
		<td align="right"> <font color="#3f3f40"><%=strDiff%></font></td>
		<td> <font color="#3f3f40"><%=strbplr%> <input type="hidden"
			name="txtsubmargin<%=intsno%><%=intGroup%>" value="<%=strIntadjust%>">
		<input type="hidden" name="txtsno<%=intsno%>" value="<%=strSno%>">
		<input type="hidden" name="txtgroup<%=intsno%>" value="<%=strGroup%>">
		<input type="hidden" name="txtsublimit<%=intsno%>" value="Y">
		<input type="hidden" name="txtsubcategory<%=intsno%><%=intGroup%>"
			value="<%=strCategory%>"> <input type="hidden"
			name="txtsubmonths<%=intsno%><%=intGroup%>" value="<%=strMonths%>">
		<input type="hidden" name="txtbranchname<%=intsno%>"
			value="<%=strbranch%>"> <input type="hidden"
			name="txt_subinterest<%=intsno%><%=intGroup%>"
			value="<%=strInterest%>"> <input type="hidden"
			name="txtsubbplr<%=intsno%><%=intGroup%>" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble(strbplr)))%>">
		<input type="hidden" name="txtsubdp<%=intsno%><%=intGroup%>"
			value="<%=strDP%>"> <input type="hidden"
			name="txtsuboutstanding<%=intsno%><%=intGroup%>"
			value="<%=strOutstanding%>"> <input type="hidden"
			name="txtsubsecurity<%=intsno%><%=intGroup%>"
			value="<%=strSecurity%>"> <input type="hidden"
			name="hidsubcbsaccno<%=intsno%><%=intGroup%>"
			value="<%=strCbsaccountno%>"> <input type="hidden"
			name="txtsubintremarks<%=intsno%><%=intGroup%>"
			value="<%=strintremarks%>"> <input type="hidden"
			name="txtsubosdate<%=intsno%><%=intGroup%>" value="<%=strOsAsOn%>">
		   <input type="hidden"
			name="selsubexistbanktype<%=intsno%><%=intGroup%>"
			value="<%=strexistbanktype%>"> <input type="hidden"
			name="selsubpropbanktype<%=intsno%><%=intGroup%>"
			value="<%=strpropbanktype%>"> <input type="hidden"
			name="txtsubpurpose<%=intsno%><%=intGroup%>" value="<%=strPurpose%>">
			<input type="hidden" name="selsubinttype<%=intsno%><%=intGroup%>"
			value="<%=strIntType%>"> 
			<input type="hidden" name="hidcbsaccno<%=intsno%><%=intGroup%>"
			value="<%=strCbsaccountno%>">
			
			
			
			
			
			<input type="hidden" name="selsubrepaytype<%=intsno%><%=intGroup%>"
			value="<%=strRepaytype%>"> 
			
			
			
			
			<input type="hidden" name="selsubgovtscheme<%=intsno%><%=intGroup%>"
			value="<%=strGovtsponsschem%>"> 
			
			<input type="hidden" name="hidFreshLimitsub<%=intsno%><%=intGroup%>"
			value="<%=strFreshLimit%>"> 
			
			<input type="hidden" name="selsubschemetype<%=intsno%><%=intGroup%>"
			value="<%=strSchemeType%>"> 
			<input type="hidden" name="selsubsponsagency<%=intsno%><%=intGroup%>"
			value="<%=strSponsAgency%>"> 
			<input type="hidden" name="selsubsubsidytype<%=intsno%><%=intGroup%>"
			value="<%=strSubsidyType%>"> 
			<input type="hidden" name="txtsubsubsidyamunt<%=intsno%><%=intGroup%>"
			value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble(strsubsidyAmunt)))%>"> 
				<input type="hidden" name="selfacsubcode<%=intsno%><%=intGroup%>"
			value="<%=strFacCode%>"><input type="hidden" name="hid_strAgrsubSchemeType<%=intsno%><%=intGroup%>" value="<%=strAgrSchemeType%>">
				<input type="hidden" name="selhoidayperiodsub<%=intsno%><%=intGroup%>"
			value="<%=strHolidayPeriod%>"> 
				<input type="hidden" name="selintereceivedsub<%=intsno%><%=intGroup%>"
			value="<%=strInterestrec%>"> 
				<input type="hidden" name="selinterestchargedsub<%=intsno%><%=intGroup%>"
			value="<%=strInterestCharged%>"> 
				<input type="hidden" name="selmodepaysub<%=intsno%><%=intGroup%>"
			value="<%=strModerepay%>"> 
				<input type="hidden" name="seloperaccnosub<%=intsno%><%=intGroup%>"
			value="<%=strOperationAcno%>"> 
					<input type="hidden" name="selmarginsub<%=intsno%><%=intGroup%>"
			value="<%=strMargin%>">
			<input type="hidden" name="selremarkssub<%=intsno%><%=intGroup%>" value="<%=strRemarks%>">
			<input type="hidden" name="selperinstalfacsub<%=intsno%><%=intGroup%>" value="<%=strPerInstal%>">
			<input type="hidden" name="selintsubtypeSubfac<%=intsno%><%=intGroup%>" value="<%=strFacSubIntType%>">
			<input type="hidden" name="selIntIdFacSub<%=intsno%><%=intGroup%>" value="<%=strFacIntId%>">
			<input type="hidden" name="selFacBaseRateSub<%=intsno%><%=intGroup%>" value="<%=strFacBaseRate%>">
			<input type="hidden" name="strfacDescNewSub<%=intsno%><%=intGroup%>" value="<%=strfacDescNew%>">
			<input type="hidden" name="strFacAgencysub<%=intsno%><%=intGroup%>" value="<%=strAgency%>">
			<input type="hidden" name="strsubduedate<%=intsno%><%=intGroup%>" value="<%=strduedate%>">
			<input type="hidden" name="strsubdisplaydesc<%=intsno%><%=intGroup%>" value="<%=strdisplaydesc%>">
			
			
			<input type="hidden" name="hid_sel_subfac_desc<%=intsno%><%=intGroup%>"
			value="<%=strfacdesctype%>"> 
			<input type="hidden" name="hid_sel_subfac_type<%=intsno%><%=intGroup%>" value="<%=fac_type%>">
			<input type="hidden" name="hid_sel_subfac_restracc<%=intsno%><%=intGroup%>" value="<%=strRestrAcc%>"> 
			<input type="hidden" name="hid_sel_subfac_fitlacc<%=intsno%><%=intGroup%>" value="<%=strFITLAcc%>">  
			<input type="hidden" name="hid_sel_subfac_RestrFrom<%=intsno%><%=intGroup%>" value="<%=strFacRestrFrom%>">
			<input type="hidden" name="hid_sub_facility_code<%=intsno%><%=intGroup%>" value="<%=strFacilityCode%>">
			<input type="hidden" name="hid_selconversionfac_sub<%=intsno%><%=intGroup%>" value="<%=strFacConversionfac%>">
			<input type="hidden" name="hid_seladdfunding_sub<%=intsno%><%=intGroup%>" value="<%=strFacAdditionFunding%>">
			<input type="hidden" name="hid_leadbankname_sub<%=intsno%><%=intGroup%>" value="<%=strLeadBankName%>">
			<input type="hidden" name="hid_leadbankcode_sub<%=intsno%><%=intGroup%>" value="<%=strLeadBankCode%>">
			<input type="hidden" name="hid_psterms_sub<%=intsno%><%=intGroup%>" value="<%=strPSterms%>">
			<input type="hidden" name="hid_subcomfacloantype<%=intsno%><%=intGroup%>" value="<%=strComfacLoanType%>">
			<input type="hidden" name="hid_subfacexloanamt<%=intsno%><%=intGroup%>" value="<%=strExistingAmt%>">
			<input type="hidden" name="hid_subfacexloanperiod<%=intsno%><%=intGroup%>" value="<%=strExistingTenor%>">
			<input type="hidden" name="hid_subfacrestrscheme<%=intsno%><%=intGroup%>" value="<%=strRestrScheme%>">
			<input type="hidden" name="hid_subadhocfacfor<%=intsno%><%=intGroup%>" value="<%=strAdhocFacfor%>">
			<input type="hidden" name="hid_subadhocchk<%=intsno%><%=intGroup%>" value="<%=strAdhocchk%>">
			<input type="hidden" name="hid_subadhocdesc<%=intsno%><%=intGroup%>" value="<%=stradhocfacdesc%>">
			<input type="hidden" name="hid_subadhocsno<%=intsno%><%=intGroup%>" value="<%=stradhocsno%>">
			<input type="hidden" name="hid_subreattachflag<%=intsno%><%=intGroup%>" value="<%=strFacReattachFlag%>">
			<input type="hidden" name="hid_submetlifeinsurance<%=intsno%><%=intGroup%>" value="<%=strMetlifeInsurance%>">
			<input type="hidden" name="hidsubFacACCOUNTOPEN<%=intsno%><%=intGroup%>" value="<%=strFacACCOUNTOPEN%>">
			<input type="hidden" name="hidsubFACILITY_EMISCHEME<%=intsno%><%=intGroup%>" value="<%=strFACILITY_EMISCHEME%>">
			<input type="hidden" name="hidsubExPropno<%=intsno%><%=intGroup%>" value="<%=strExiProposalno%>">
			<input type="hidden" name="hidsubExPropSno<%=intsno%><%=intGroup%>" value="<%=strExiProposalSno%>">
			<input type="hidden" name="hidsubExPropAccno<%=intsno%><%=intGroup%>" value="<%=strExiProposalAccno%>">
			<input type="hidden" name="hidsubExPropSancAmt<%=intsno%><%=intGroup%>" value="<%=strExiProposalSanAmt%>">
			<input type="hidden" name="hidSubExLimitType<%=intsno%><%=intGroup%>" value="<%=strExLimitType%>">
			
			<input type="hidden" name="hid_cgtmsesub<%=intsno%><%=intGroup%>" value="<%=strFACILITY_WHT_CGTMSEAPPLY%>">
			<input type="hidden" name="hid_perapp_conssub<%=intsno%><%=intGroup%>" value="<%=strPERAPP_CONS%>">			
			<input type="hidden" name="hid_fac_wht_cgtmsesub<%=intsno%><%=intGroup%>" value="<%=strFACILITY_WHT_CGTMSEAPPLY%>">
			<input type="hidden" name="hid_fac_cg_split_intratesub<%=intsno%><%=intGroup%>" value="<%=strFACILITY_CG_SPLIT_INT_RATE%>">
			<input type="hidden" name="hid_fac_cg_tot_intratesub<%=intsno%><%=intGroup%>" value="<%=strFACILITY_CG_TOT_INT_RATE%>">
			<input type="hidden" name="hid_fac_coverenddatesub<%=intsno%><%=intGroup%>" value="<%=strCGTMSECoverEDate%>">
			<input type="hidden" name="hid_sharetypesub<%=intsno%><%=intGroup%>" value="<%=strFACILITY_SHARETYPE%>">
			<input type="hidden" name="hidMISFlagsub<%=intsno%><%=intGroup%>" value="<%=strMISFlag%>">
			<input type="hidden" name="hidROITypesub<%=intsno%><%=intGroup%>" value="<%=strROIType%>">
			<input type="hidden" name="hidCompanyNameSub<%=intsno%><%=intGroup%>" value="<%=strCompanyName%>">
			<input type="hidden" name="hidPremiumTenorSub<%=intsno%><%=intGroup%>" value="<%=strPremiumTenor%>">
			<input type="hidden" name="hidPremiumLoanAmountSub<%=intsno%><%=intGroup%>" value="<%=strPremiumLoanAmount%>">
			<input type="hidden" name="hidPremiumInsAccountNoSub<%=intsno%><%=intGroup%>" value="<%=strInsAccountNo%>">
			<input type="hidden" name="hidPremiumAmountSub<%=intsno%><%=intGroup%>" value="<%=strPremiumAmount%>">
			<input type="hidden" name="hidPremiumConpanyNameSub<%=intsno%><%=intGroup%>" value="<%=strInsFundedCompanyName%>">
			<input type="hidden" name="hidMarginRelaxReqSub<%=intsno%><%=intGroup%>" value="<%=strMarginRelaxtion%>">
			<input type="hidden" name="hidActualMarginSub<%=intsno%><%=intGroup%>" value="<%=strActualMargin%>">
			<input type="hidden" name="hidRelaxedMarginSub<%=intsno%><%=intGroup%>" value="<%=strRelaxedMargin%>">
			<input type="hidden" name="hidintDefermentSub<%=intsno%><%=intGroup%>" value="<%=strIntDeferment%>">
			<input type="hidden" name="hidReviewDateSub<%=intsno%><%=intGroup%>" value="<%=strReviewDate%>">
			<input type="hidden" name="hidRenewalJustifSub<%=intsno%><%=intGroup%>" value="<%=strRenewalJustif%>">
			<input type="hidden" name="hidBankschemecode<%=intsno%>" value="<%=strBankSchemecode%>">
			<!-- <input type="hidden" name="fbildatesub">
			<input type="hidden" name="fbiltenorsub"> -->
			
			
		<!--raman--></font></td>
		<td>Sub-Limit</td>
		<td width="6%"> <font color="#3f3f40">
		<%if(strCategory.trim().equals("R")) {%>
		   Regular limit
			<%} else if(strCategory.trim().equals("A")) {%>
			Adhoc Limit
			<%} else if(strCategory.trim().equals("D")) {%>
			Additional Limit
			<%}else if(strCategory.trim().equals("O")) {%>
			One time Limit
			<%}%>
		</font>
		</td>
		<td>
		<%=fac_type_desc %>
		</td>
		
	</tr>
	<%
		}
		}
	%>
	<tr class="datagrid">
		<td colspan="5" align="center"><b>Total</b></td>
		<td align="right"><%=jtn.format(Double.parseDouble(strTotExist))%></td>
		<td  align="right"><%=jtn.format(Double.parseDouble(strLC))%></td>
		<td align="right"><%=jtn.format(Double.parseDouble(strTotDiff))%></td>		
		<td><input type="hidden" name="txt_line_credit"
			value="<%=strLC%>"> <input type="hidden"
			name="hid_line_credit" value="<%=strLC%>"> &nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidGrpSize"> <input type="hidden" name="hidGrpList">
<input type="hidden" name="appval" value="<%=appval%>"> <input
	type="hidden" name="appflag" value="<%=appflag%>"> <input
	type="hidden" name="appMangflag" value="<%=appMangflag%>"> <input
	type="hidden" name="appGroupflag" value="<%=appGroupflag%>"> <input
	type="hidden" name="addflag"> <input type="hidden"
	name="selsno" value="<%=strselsno%>"> <input type="hidden"
	name="selsubsno" value="<%=strsubselsno%>"> <input
	type="hidden" name="factype" value="<%=strFacType%>"> <input
	type="hidden" name="faccategory" value="<%=strFacCategory%>"> <INPUT
	TYPE="hidden" NAME="hidTabName" VALUE=""> <input type="hidden"
	name="prd_inttype" value=""> <input type="hidden"
	name="prd_subinttype" value=""> <INPUT TYPE="hidden"
	NAME="hidMethod" VALUE=""> <INPUT TYPE="hidden" NAME="hidparam"
	VALUE=""> <input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="hidOtherMethod" value=""> <input
	type="hidden" name="cattype" value="<%=strCategoryType%>"> <input
	type="hidden" name="ssitype" value="<%=strSSIType%>">
	<input type="hidden" name="comapp_compname" value="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>">	
	<input type="hidden" name="hidminAmountRange">
	<input type="hidden" name="hidMaxAmountRange">
	<input type="hidden" name="hidMinPeriod">
	<input type="hidden" name="hidMaxPeriod">
	<input type="hidden" name="hidPage">
	<input type="hidden" name="hidHoliday">
	<input type="hidden" name="appstatus" value="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>">
	<input type="hidden" name="hidFreeze" value="<%=Helper.correctNull((String) hshValues.get("cre_freeze"))%>">
	<input type="hidden" name="hidcomappidnew" value="<%=Helper.correctNull((String)request.getParameter("varComId"))%>">
	<input type="hidden" name="hidparam1">
		
			
				<input type="hidden" name="comapp_newid" value="<%=Helper.correctNull((String)hshValues.get("app_newid"))%>">
					<input type="hidden" name="comapp_new_id" value="<%=Helper.correctNull((String)request.getParameter("var_Com_Newid"))%>">		
	<input type="hidden" name="facility_head_id_code">
	<input type="hidden" name="hidstrType" value="<%=strType%>">
	
					<input type="hidden" name="facility_id_code">
					<input type="hidden" name="facility_OldCode">
					<input type="hidden" name="facilitydesc">
					<input type="hidden" name="facility_nature">
					<input type="hidden" name="selfacilitytype" value="<%=facility_type%>">
<input type="hidden" name="hidType1" value=""> 
<input type="hidden" name="hidFacSno" value="">
<input type="hidden" name="hidCashMarginPrd" value="<%=Helper.correctNull((String)hshValues.get("strCashMargin"))%>">
<input type="hidden" name="hidfaccount" value="<%=vecsize %>">
<input type="hidden" name="hidfacilityCode">
<input type="hidden" name="hidsubfacilityCode">
<input type="hidden" name="hidfacilityCode1">
<input type="hidden" name="hidsubfacilityCode1">

<input type="hidden" name="hidPStermsSelected">
<input type="hidden" name="hidSubPStermsSelected">

<input type="hidden" name="hidComFactype">
<input type="hidden" name="hidComFactypeOld">

<input type="hidden" name="hidSubComFactype">
<input type="hidden" name="hidsubComFactypeOld">

<input type="hidden" name="hidFacExLimit">
<input type="hidden" name="hidSubFacExLimit">
<input type="hidden" name="hidFacExTenor">
<input type="hidden" name="hidSubFacExTenor">
<input type="hidden" name="hidAdhocchk">
<input type="hidden" name="hidadhocDesc">
<input type="hidden" name="hidAdhocsno">
<input type="hidden" name="txt_proposed_limit_old">
<input type="hidden" name="txt_subproposed_limit_old">
<input type="hidden" name="txt_totalLimit" value="<%=Helper.correctDouble((String)hshValues.get("lc")) %>">
<input type="hidden" name="txt_Limit">
<input type="hidden" name="hidfacreattach">
<input type="hidden" name="hidfacreattachsub">
<input type="hidden" name="hidconst" value="<%=Helper.correctDouble((String)hshValues.get("strConst")) %>">
<input type="hidden" name="txt_cgtmse">
<input type="hidden" name="hid_cgtmse_applicable" value="<%=Helper.correctNull((String)hshValues.get("FACILITY_WHT_CGTMSEAPPLY")) %>">
<input type="hidden" name="txt_cgtmsesub">
<input type="hidden" name="hidCGTMSE" value="<%=Helper.correctNull((String)hshValues.get("strCGTMSE_CORP")) %>">
<input type="hidden" name="hidncgtcflag" value="<%=Helper.correctNull((String)hshValues.get("strncgtcflag")) %>">
<input type="hidden" name="hidbankscheme" value="<%=Helper.correctNull((String)hshValues.get("strBankscheme")) %>">
<input type="hidden" name="hidAppCGStatus" value="<%=Helper.correctNull((String) hshValues.get("AS_PERAPP_CONSTITUTION_CGTMSE"))%>">
<input type="hidden" name="txtsharetype" value="">
<input type="hidden" name="txtsharetypesub" value="">
<input type="hidden" name="txtMISFlag" value="">
<input type="hidden" name="txtMISFlagsub" value="">
<input type="hidden" name="hidPhysicalLimitAvailed" value="<%=Helper.correctDouble((String) hshValues.get("strPhyLimitAvailed"))%>">
<input type="hidden" name="hidDematLimitAvailed" value="<%=Helper.correctDouble((String) hshValues.get("strDematLimitAvailed"))%>">
<input type="hidden" name="hidPhysicalLimitAvailed1" value="<%=Helper.correctDouble((String) hshValues.get("strPhyLimitAvailed"))%>">
<input type="hidden" name="hidDematLimitAvailed1" value="<%=Helper.correctDouble((String) hshValues.get("strDematLimitAvailed"))%>">
<input type="hidden" name="hidPhysicalLimit" value="<%=Helper.correctDouble((String) hshValues.get("strPhyLimit"))%>">
<input type="hidden" name="hidDematLimit" value="<%=Helper.correctDouble((String) hshValues.get("strDematLimit"))%>">
<input type="hidden" name="hidPhysicalFlag" value="<%=Helper.correctNull((String) hshValues.get("strPhyLimitExceeds"))%>">
<input type="hidden" name="hidDematFlag" value="<%=Helper.correctNull((String) hshValues.get("strDematLimitExceeds"))%>">
<input type="hidden" name="hidChecklist" value="<%=Helper.correctNull((String)hshValues.get("strCheckList_Check")) %>">
<input type="hidden" name="hidROI">
<input type="hidden" name="hidROISub">
<input type="hidden" name="txt_coverenddate">
<input type="hidden" name="txt_coverenddatesub">
<input type="hidden" name="txt_accountopenflag">
<input type="hidden" name="txt_accountopenflagsub">
<input type="hidden" name="txt_KCCFlag" value="<%=strKCCFlag %>">
<input type="hidden" name="hid_cgtmse_fac_arrangement" value="<%=Helper.correctNull((String)hshValues.get("")) %>">
<input type="hidden" name="hidfinancialtype" value="<%=Helper.correctNull((String)hshValues.get("app_financialrequired")) %>">
<input type="hidden" name="hidGECLAvail" value="<%=Helper.correctNull((String)hshValues.get("strgeclavailable")) %>">
<input type="hidden" name="hidGECLType" value="<%=Helper.correctNull((String)hshValues.get("strgecltype")) %>">
<input type="hidden" name="hidDPNFac" value="<%=Helper.correctNull((String)hshValues.get("strDPN2020")) %>">
<input type="hidden" name="hidCGSSD" value="<%=Helper.correctNull((String)hshValues.get("strCGSSD")) %>">
<input type="hidden" name="hidDefermentDetails" value="<%=strIntDefAccDetails %>">
<input type="hidden" name="hidMobileNo" value="<%=Helper.correctNull((String)hshValues.get("strMobileNo")) %>">
<input type="hidden" name="hid_propflag">
<input type="hidden" name="hid_jusflag">
<input type="hidden" name="hid_subjusflag">
<input type="hidden" name="hidCGSSD" value="<%=Helper.correctNull((String)hshValues.get("strCGSSD")) %>">
<input type="hidden" name="hidduedate">
<input type="hidden" name="hidgeclborrowchk" value="<%=Helper.correctNull((String)hshValues.get("strgeclavailable1")) %>">
<input type="hidden" name="hidgecl1check" value="<%=Helper.correctNull((String)hshValues.get("strgecl1flag")) %>">

<input type="hidden" name="hidgecl1count" value="<%=Helper.correctNull((String)hshValues.get("intcountgecl1")) %>">
<input type="hidden" name="hidgecl2count" value="<%=Helper.correctNull((String)hshValues.get("intcountgecl2")) %>">
<input type="hidden" name="hidfacgecl2count" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgecl2")) %>">
<input type="hidden" name="hidfacgecl3count" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgecl3")) %>">
<input type="hidden" name="hidgecl3count" value="<%=Helper.correctNull((String)hshValues.get("intcountgecl3")) %>">
<input type="hidden" name="hidnongeclfacchk" value="<%=Helper.correctNull((String)hshValues.get("strnongeclfacchk")) %>">
<input type="hidden" name="hidstrAppType" value="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>">
<input type="hidden" name="intcountgecl1ext" value="<%=Helper.correctNull((String)hshValues.get("intcountgecl1ext")) %>">
<input type="hidden" name="intfaccountgeclext1" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgeclext1")) %>">
<input type="hidden" name="hidCGPANExpired">


<input type="hidden" name="hidgecl2countext" value="<%=Helper.correctNull((String)hshValues.get("intcountgecl2ext")) %>">
<input type="hidden" name="hidfacgecl2countext" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgeclext2")) %>">

<input type="hidden" name="hidgecl3countext" value="<%=Helper.correctNull((String)hshValues.get("intcountgecl3ext")) %>">
<input type="hidden" name="hidfacgecl3countext" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgeclext3")) %>">

<input type="hidden" name="parayatanFlag" value="<%=Helper.correctNull((String)hshValues.get("parayatanFlag")) %>">


<input type="hidden" name="intcountgeclgp1" value="<%=Helper.correctNull((String)hshValues.get("intcountgeclgp1")) %>">
<input type="hidden" name="intcountgeclgp3" value="<%=Helper.correctNull((String)hshValues.get("intcountgeclgp3")) %>">
<input type="hidden" name="intcountgeclgp1ext" value="<%=Helper.correctNull((String)hshValues.get("intcountgeclgp1ext")) %>">
<input type="hidden" name="intcountgeclgp3ext" value="<%=Helper.correctNull((String)hshValues.get("intcountgeclgp3ext")) %>">
<input type="hidden" name="intfaccountgeclgp2" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgeclgp2")) %>">
<input type="hidden" name="intfaccountgeclgp3" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgeclgp3")) %>">
<input type="hidden" name="intfaccountgeclgpext1" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgeclgpext1")) %>">
<input type="hidden" name="intfaccountgeclgpext3" value="<%=Helper.correctNull((String)hshValues.get("intfaccountgeclgpext3")) %>">



<input type="hidden" name="intcountparayatan" value="<%=Helper.correctNull((String)hshValues.get("intcountparayatan")) %>">
<input type="hidden" name="intfaccountparayatan" value="<%=Helper.correctNull((String)hshValues.get("intfaccountparayatan")) %>">
<input type="hidden" name="perapp_facility_othbankP" value="<%=Helper.correctNull((String)hshValues.get("perapp_facility_othbankP")) %>">
<input type="hidden" name="perapp_facility_othbankG" value="<%=Helper.correctNull((String)hshValues.get("perapp_facility_othbankG")) %>">

<input type="hidden" name="hidgecltype">
<input type="hidden" name="hidenwrbankschemecode" value="<%=strBankSchemecode %>">
<input type="hidden" name="hidsysdate" value="<%=Helper.getCurrentDateTime()%>">
<input type="hidden" name="hidinwardcreatedate" value="<%=Helper.correctNull((String) hshValues.get("inwardcreatedate"))%>">
<input type="hidden" name="hidafterthreemonthdate" value="<%=Helper.correctNull((String) hshValues.get("afterthreemonthdate"))%>">
<input type="hidden" name="hidcheckenwr" value="<%=v_strenwr_check%>">
<iframe
	height="0" width="0" id="ifrm1" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm2" frameborder="0"
	style="border: 0"></iframe>
	
<!-- <iframe height="0" width="0" id="ifrm3" frameborder="0"	style="border: 0"></iframe>	 -->
	
	<iframe height="0" width="0" id="ifrmint" frameborder="0" style="border:0"></iframe>
	<iframe height="0" width="0" id="ifrmdesc" frameborder="0" style="border:0"></iframe>
	<iframe height="0" width="0" id="ifrmdesc1" frameborder="0" style="border:0"></iframe>
	<iframe height="0" width="0" id="ifrmrepayment" frameborder="0" style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmexistinglimit" frameborder="0" style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmadhoclimit" frameborder="0" style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmadhoclimitsub" frameborder="0" style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrminterest" frameborder="0" style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmcheckduplicate" frameborder="0"	style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmdispdesc" frameborder="0" style="border: 0"></iframe>
	<iframe height="0" width="0" id="ifrmsubdispdesc" frameborder="0" style="border: 0"></iframe>
	 <!-- end by mck for new and close --> <script>
						     var msg ="<%= Helper.correctNull((String) hshValues.get("msg"))%>";
						     if(msg!="")
						     {
						   	  alert(msg);
						     }
	</script></form>
</body>
</html>

