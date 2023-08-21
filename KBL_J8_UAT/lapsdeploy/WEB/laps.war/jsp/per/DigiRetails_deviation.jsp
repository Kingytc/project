<%@include file="../share/CKEditor.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="PageId" class="java.lang.String" scope="request" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strIsSaral" class="java.lang.String" scope="session" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgCode" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgName" class="java.lang.String" scope="session" />
<jsp:useBean id="strUserClass" class="java.lang.String" scope="session" />
<%
response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");

	String appno = Helper.correctNull((String) request.getParameter("appno"));
	if (appno.equalsIgnoreCase("")) 
	{
		appno = Helper.correctNull((String) hshValues.get("strAppno"));
	}
	if(appno.equalsIgnoreCase("")) 
	{
		appno = Helper.correctNull((String) request.getParameter("Applicationno"));
	}
	String strappno = Helper.correctNull((String) hshValues.get("strAppno"));
	%>
<html>
<head>
<title>Deviation </title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var prdintminclass ="<%=Helper.correctNull((String)hshValues.get("productintclass"))%>";
var userclass ="<%=Helper.correctNull((String)hshValues.get("strUserClass"))%>";
var prd_type="<%=Helper.correctNull((String)session.getAttribute("strProductType"))%>";
var sel_loanamount="<%=Helper.correctNull((String)hshValues.get("sel_loanamount"))%>";
var sel_interestrate ="<%=Helper.correctNull((String)hshValues.get("sel_interestrate"))%>";
var sel_tenor="<%=Helper.correctNull((String)hshValues.get("sel_tenor"))%>";
var sel_margin="<%=Helper.correctNull((String)hshValues.get("sel_margin"))%>";
var sel_retirement="<%=Helper.correctNull((String)hshValues.get("sel_retirement"))%>";
var sel_repaymentcapacity="<%=Helper.correctNull((String)hshValues.get("repayreq"))%>";
var sel_processingfee="<%=Helper.correctNull((String)hshValues.get("procfeereq"))%>";
var sel_odreq="<%=Helper.correctNull((String)hshValues.get("sel_otherdev"))%>";
var vareditoption="<%=Helper.correctNull((String)hshValues.get("editoption"))%>";
var vardeviationapproved="<%=Helper.correctNull((String)hshValues.get("deviationapproved"))%>";
var varotherspecify1="<%=Helper.correctNull((String)hshValues.get("deviation_req1"))%>";
var varotherspecify2="<%=Helper.correctNull((String)hshValues.get("deviation_req2"))%>";
var varotherspecify3="<%=Helper.correctNull((String)hshValues.get("deviation_req3"))%>";
var varotherspecify4="<%=Helper.correctNull((String)hshValues.get("deviation_req4"))%>";
var varotherspecify5="<%=Helper.correctNull((String)hshValues.get("deviation_req5"))%>";
//Deviation Changes
var varselect_la="<%=Helper.correctNull((String)hshValues.get("select_la"))%>";
var varselect_intrate="<%=Helper.correctNull((String)hshValues.get("select_intrate"))%>";
var varselect_tenor="<%=Helper.correctNull((String)hshValues.get("select_tenor"))%>";
var varselect_margin="<%=Helper.correctNull((String)hshValues.get("select_margin"))%>";
var varselect_rage="<%=Helper.correctNull((String)hshValues.get("select_rage"))%>";
var varselect_repayment="<%=Helper.correctNull((String)hshValues.get("select_repayment"))%>";
var varselect_processfee="<%=Helper.correctNull((String)hshValues.get("select_processfee"))%>";
var varselect_odrequest="<%=Helper.correctNull((String)hshValues.get("select_od"))%>";
var varDeviatedUserClass="<%=Helper.correctNull((String)hshValues.get("strDeviatedUserClass"))%>"; 
var varApprovedUserId="<%=Helper.correctNull((String)hshValues.get("strApprovedUserid"))%>";
var varDeviatedUserId="<%=Helper.correctNull((String)hshValues.get("strDeviatedUserId"))%>";
var varapplnholder = "<%=Helper.correctNull((String)hshValues.get("applholder"))%>";
var strUserId='<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>';
var varstrapprej = "<%=Helper.correctNull((String)hshValues.get("strapprej"))%>";
var varMaxAmount = "<%=Helper.correctNull((String)hshValues.get("strMaxAmount"))%>";
var varLoanDetFlg = "<%=Helper.correctNull((String)hshValues.get("strLoanDetFlg"))%>";
var varOtherDevFLag="<%=Helper.correctNull((String)hshValues.get("strOtherDevFlag"))%>";
var varModfIntFlag="<%=Helper.correctNull((String)hshValues.get("strModIntFlag"))%>";
var varselect_la_intr="<%=Helper.correctNull((String)hshValues.get("select_la_intr"))%>";
var varselect_tenor_intr="<%=Helper.correctNull((String)hshValues.get("select_tenor_intr"))%>";
var varselect_margin_intr="<%=Helper.correctNull((String)hshValues.get("select_margin_intr"))%>";
var varselect_rage_intr="<%=Helper.correctNull((String)hshValues.get("select_rage_intr"))%>";
var varselect_repayment_intr="<%=Helper.correctNull((String)hshValues.get("select_repayment_intr"))%>";
var varselect_processfee_intr="<%=Helper.correctNull((String)hshValues.get("select_processfee_intr"))%>";
var varselect_odrequest_intr="<%=Helper.correctNull((String)hshValues.get("select_od_intr"))%>";
var varintrefno="<%=Helper.correctNull((String)hshValues.get("strIntRefNoFlag"))%>";
var APP_PERM_NO="<%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%>";
var varMclrCode="<%=Helper.correctNull((String)hshValues.get("mclr_type_code"))%>";

function doClose()
{
	window.opener.document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	window.opener.document.forms[0].hidBeanId.value="perapplicant";
	window.opener.document.forms[0].action=appURL+"action/perloandetails.jsp";	
	window.opener.document.forms[0].submit();
	window.close();
}
function callApprovedUser()
{
	// For Approved User
	if(parseInt(userclass) >= parseInt(varDeviatedUserClass))
	{
		if(varselect_la!="A" && varselect_la!="R"){
			document.forms[0].select_la.disabled=false;
			document.forms[0].select_la_intr.disabled=false;}
		else{
			document.forms[0].select_la.disabled=true;
			document.forms[0].select_la_intr.disabled=true;}	
		if(varselect_intrate!="A" && varselect_intrate!="R"){
			document.forms[0].select_intrate.disabled=false;
			}
		else{
			document.forms[0].select_intrate.disabled=true;
			}
		if(varselect_tenor!="A" && varselect_tenor!="R"){
			document.forms[0].select_tenor.disabled=false;
			document.forms[0].select_tenor_intr.disabled=false;}
		else{
			document.forms[0].select_tenor.disabled=true;
			document.forms[0].select_tenor_intr.disabled=true;}	
		if(varselect_margin!="A" && varselect_margin!="R"){
			document.forms[0].select_margin.disabled=false;
			document.forms[0].select_margin_intr.disabled=false;}
		else{
			document.forms[0].select_margin.disabled=true;
			document.forms[0].select_margin_intr.disabled=true;}	
		if(varselect_rage!="A" && varselect_rage!="R"){
			document.forms[0].select_rage.disabled=false;
			document.forms[0].select_rage_intr.disabled=false;}
		else{
			document.forms[0].select_rage.disabled=true;
			document.forms[0].select_rage_intr.disabled=true;}	
		if(varselect_repayment!="A" && varselect_repayment!="R"){
			document.forms[0].select_repayment.disabled=false;
			document.forms[0].select_repayment_intr.disabled=false;}	
		else{
			document.forms[0].select_repayment.disabled=true;
			document.forms[0].select_repayment_intr.disabled=true;}	
		if(varselect_processfee!="A" && varselect_processfee!="R"){
			document.forms[0].select_processfee.disabled=false;
			document.forms[0].select_processfee_intr.disabled=false;}
		else{
			document.forms[0].select_processfee.disabled=true;
			document.forms[0].select_processfee_intr.disabled=true;}	
		if(varselect_odrequest!="A" && varselect_odrequest!="R"){
			document.forms[0].select_od.disabled=false;
			document.forms[0].select_od_intr.disabled=false;}
		else{
			document.forms[0].select_od.disabled=true;
			document.forms[0].select_od_intr.disabled=true;}	
	
		document.forms[0].hidAction.value="approve";
	}
	else
	{
		document.forms[0].select_la.disabled=true;
		document.forms[0].select_intrate.disabled=true;
		document.forms[0].select_tenor.disabled=true;
		document.forms[0].select_margin.disabled=true;
		document.forms[0].select_rage.disabled=true;
		document.forms[0].select_repayment.disabled=true;
		document.forms[0].select_processfee.disabled=true;
		document.forms[0].select_la_intr.disabled=true;
	    document.forms[0].select_tenor_intr.disabled=true;
	    document.forms[0].select_margin_intr.disabled=true;
	    document.forms[0].select_rage_intr.disabled=true;
	    document.forms[0].select_repayment_intr.disabled=true;
	    document.forms[0].select_processfee_intr.disabled=true;
	    document.forms[0].select_od_intr.disabled=true; 
	}
}
function callDeviatedUser()
{
	// For Deviated User
	if(varDeviatedUserId=='Y')
	{
		document.forms[0].sel_loanamount.disabled=false;
		document.forms[0].sel_interestrate.disabled=false;
		document.forms[0].sel_tenor.disabled=false;
		document.forms[0].sel_margin.disabled=false;
		document.forms[0].sel_retirement.disabled=false;
		document.forms[0].sel_repaycapacity.disabled=false;
		document.forms[0].sel_procfee.disabled=false;
		
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].readOnly=false;
			}
			if(document.forms[0].elements[i].type=='textarea')
			{
				document.forms[0].elements[i].readOnly=false;
			}
		}
		document.forms[0].txt_otherdevremarks.readOnly=true;	
	}
	else if(parseInt(userclass) < parseInt(varDeviatedUserClass))
	{
		document.forms[0].sel_loanamount.disabled=true;
		document.forms[0].sel_interestrate.disabled=true;
		document.forms[0].sel_tenor.disabled=true;
		document.forms[0].sel_margin.disabled=true;
		document.forms[0].sel_retirement.disabled=true;
		document.forms[0].sel_repaycapacity.disabled=true;
		document.forms[0].sel_procfee.disabled=true;
	
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].disabled=true;
			}
		}
	}else if(parseInt(userclass) > parseInt(varDeviatedUserClass)){

		if(document.forms[0].txt_loanamountnew.value != ""){
			document.forms[0].sel_loanamount.disabled=true;
		}
		if(document.forms[0].txt_interestratenew.value != ""){
			document.forms[0].sel_interestrate.disabled=true;
		}
		if(document.forms[0].txt_tenornew.value != ""){
			document.forms[0].sel_tenor.disabled=true;
		}
		if(document.forms[0].txt_marginnew.value != ""){
			document.forms[0].sel_margin.disabled=true;
		}
		if(document.forms[0].txt_retirementnew.value != ""){
			document.forms[0].sel_retirement.disabled=true;
		}
		if(document.forms[0].txt_repaynew.value != ""){
			document.forms[0].sel_repaycapacity.disabled=true;
		}
		if(document.forms[0].txt_procfeenew.value != ""){
			document.forms[0].sel_procfee.disabled=true;
		}

		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='text')
			{
				document.forms[0].elements[i].readOnly=false;
			}
			if(document.forms[0].elements[i].type=='textarea')
			{
				document.forms[0].elements[i].readOnly=false;
			}
		}
	}
}
function disablefields()
{
	if(document.forms[0].sel_loanamount.value=="N")
	{
		document.forms[0].txt_loanamountnew.value="";
		document.forms[0].txt_loanremarks.value="";
		document.forms[0].txt_loanamountnew.readOnly=true;
		document.forms[0].txt_loanremarks.readOnly=true;
		document.forms[0].select_la.disabled=true;
		document.forms[0].select_la_intr.disabled=true;
	}
	else
	{
		if(document.forms[0].select_la.value == "A" || document.forms[0].select_la.value == "R" ){
			
			document.forms[0].txt_loanamountnew.readOnly=true;
			document.forms[0].txt_loanremarks.readOnly=true;
			document.forms[0].sel_loanamount.disabled=true;
		}else{
			
			document.forms[0].txt_loanamountnew.readOnly=false;
			document.forms[0].txt_loanremarks.readOnly=false;
		}
	}
	if(document.forms[0].sel_interestrate.value=="N")
	{
		document.forms[0].txt_interestratenew.value="";
		document.forms[0].txt_interestrateremarks.value="";
		document.forms[0].txt_interestratenew.readOnly=true;
		document.forms[0].txt_interestrateremarks.readOnly=true;
		document.forms[0].select_intrate.disabled=true;
	}
	else
	{
		if(document.forms[0].select_intrate.value == "A" || document.forms[0].select_intrate.value == "R" ){
			document.forms[0].txt_interestratenew.readOnly=true;
			document.forms[0].txt_interestrateremarks.readOnly=true;
			document.forms[0].sel_interestrate.disabled=true;
		}else{
			document.forms[0].txt_interestratenew.readOnly=false;
			document.forms[0].txt_interestrateremarks.readOnly=false;
		}
	}
	if(document.forms[0].sel_tenor.value=="N")
	{
		document.forms[0].txt_tenornew.value="";
		document.forms[0].txt_tenorremarks.value="";
		document.forms[0].txt_tenornew.readOnly=true;
		document.forms[0].txt_tenorremarks.readOnly=true;
		document.forms[0].select_tenor.disabled=true;
		document.forms[0].select_tenor_intr.disabled=true;
	}
	else
	{
		if(document.forms[0].select_tenor.value == "A" || document.forms[0].select_tenor.value == "R" ){
			document.forms[0].txt_tenornew.readOnly=true;
			document.forms[0].txt_tenorremarks.readOnly=true;
			document.forms[0].sel_tenor.disabled=true;
			document.forms[0].select_tenor_intr.disabled=true;
		}else{
			
			document.forms[0].txt_tenornew.readOnly=false;
			document.forms[0].txt_tenorremarks.readOnly=false;
		}
	}
	if(document.forms[0].sel_margin.value=="N")
	{
		document.forms[0].txt_marginnew.value="";
		document.forms[0].txt_marginremarks.value="";
		document.forms[0].txt_marginnew.readOnly=true;
		document.forms[0].txt_marginremarks.readOnly=true;
		document.forms[0].select_margin.disabled=true;
		document.forms[0].select_margin_intr.disabled=true;
	}
	else
	{
		if(document.forms[0].select_margin.value == "A" || document.forms[0].select_margin.value == "R" ){
			
			document.forms[0].txt_marginnew.readOnly=true;
			document.forms[0].txt_marginremarks.readOnly=true;
			document.forms[0].sel_margin.disabled=true;
		}else{
			
			document.forms[0].txt_marginnew.readOnly=false;
			document.forms[0].txt_marginremarks.readOnly=false;
		}
	}
	
	if(document.forms[0].sel_retirement.value=="N")
	{
		document.forms[0].txt_retirementnew.value="";
		document.forms[0].txt_retirementremarks.value="";
		document.forms[0].txt_retirementnew.readOnly=true;
		document.forms[0].txt_retirementremarks.readOnly=true;
		document.forms[0].select_rage.disabled=true;
		document.forms[0].select_rage_intr.disabled=true;
	}
	else
	{
		if(document.forms[0].select_rage.value == "A" || document.forms[0].select_rage.value == "R" ){
			
			document.forms[0].txt_retirementnew.readOnly=true;
			document.forms[0].txt_retirementremarks.readOnly=true;
			document.forms[0].sel_retirement.disabled=true;
		}else{
			
			document.forms[0].txt_retirementnew.readOnly=false;
			document.forms[0].txt_retirementremarks.readOnly=false;
		}
	}
	if(document.forms[0].sel_repaycapacity.value=="N")
	{
		document.forms[0].txt_repaynew.value="";
		document.forms[0].txt_repayremarks.value="";
		document.forms[0].txt_repaynew.readOnly=true;
		document.forms[0].txt_repayremarks.readOnly=true;
		document.forms[0].select_repayment.disabled=true;
		document.forms[0].select_repayment_intr.disabled=true;
	}
	else
	{
		if(document.forms[0].select_repayment.value == "A" || document.forms[0].select_repayment.value == "R" ){
			document.forms[0].txt_repaynew.readOnly=true;
			document.forms[0].txt_repayremarks.readOnly=true;
			document.forms[0].sel_repaycapacity.disabled=true;
		}else{
			
			document.forms[0].txt_repaynew.readOnly=false;
			document.forms[0].txt_repayremarks.readOnly=false;
		}
	}

	if(document.forms[0].sel_procfee.value=="N")
	{
		document.forms[0].txt_procfeenew.value="";
		document.forms[0].txt_procfeerem.value="";
		document.forms[0].txt_procfeenew.readOnly=true;
		document.forms[0].txt_procfeerem.readOnly=true;
		document.forms[0].select_processfee.disabled=true;
		document.forms[0].select_processfee_intr.disabled=true;
	}
	else
	{
		if(document.forms[0].select_processfee.value == "A" || document.forms[0].select_processfee.value == "R" ){
			document.forms[0].txt_procfeenew.readOnly=true;
			document.forms[0].txt_procfeerem.readOnly=true;
			document.forms[0].sel_procfee.disabled=true;
	    }else{
			
	    	document.forms[0].txt_procfeenew.readOnly=false;
			document.forms[0].txt_procfeerem.readOnly=false;
		}
	}
	if(document.forms[0].sel_otherdev.value=="N")
	{
		document.forms[0].select_od.disabled=true;
		document.forms[0].select_od_intr.disabled=true;
		document.forms[0].txt_odrem.readOnly=false;
	}
	else
	{
		if(document.forms[0].select_od.value == "A" || document.forms[0].select_od.value == "R" ){
			
			document.forms[0].sel_otherdev.disabled=true;
		}else{
			document.forms[0].txt_odrem.readOnly=false;
		}
	}

	document.forms[0].txt_loanamountold.readOnly=true;
	document.forms[0].txt_interestrateold.readOnly=true;
	document.forms[0].txt_tenorold.readOnly=true;
	document.forms[0].txt_marginold.readOnly=true;
	document.forms[0].txt_retirementold.readOnly=true;
	document.forms[0].txt_repaymentold.readOnly=true;
	document.forms[0].txt_procfeeold.readOnly=true;
}

function doSave()
{
	if(document.forms[0].sel_loanamount.value=="Y")
	{
		if(trim(document.forms[0].txt_loanamountnew.value)=="")
			{
			document.forms[0].txt_loanamountnew.focus();
			ShowAlert('121','Deviated Loan Amount');
			return;
			}
	}
	if(document.forms[0].sel_interestrate.value=="Y")
	{
		if(trim(document.forms[0].txt_interestratenew.value)=="")
			{
			document.forms[0].txt_interestratenew.focus();
			ShowAlert('121','Deviated Interest Rate');
			return;
			}
	}
	if(document.forms[0].sel_tenor.value=="Y")
	{
		if(trim(document.forms[0].txt_tenornew.value)=="")
			{
			document.forms[0].txt_tenornew.focus();
			ShowAlert('121','Deviated Tenor (Months)');
			return;
			}
	}
	if(document.forms[0].sel_margin.value=="Y")
	{
		if(trim(document.forms[0].txt_marginnew.value)=="")
			{
			document.forms[0].txt_marginnew.focus();
			ShowAlert('121','Deviated Margin');
			return;
			}
	}
	if(document.forms[0].sel_retirement.value=="Y")
	{
		if(trim(document.forms[0].txt_retirementnew.value)=="")
			{
			document.forms[0].txt_retirementnew.focus();
			ShowAlert('121','Deviated Retirement Age');
			return;
			}
	}
	if(document.forms[0].sel_repaycapacity.value=="Y")
	{
		if(trim(document.forms[0].txt_repaynew.value)=="")
			{
			document.forms[0].txt_repaynew.focus();
			ShowAlert('121','Deviated Repayment Capacity');
			return;
			}
	}
	if(document.forms[0].sel_procfee.value=="Y")
	{
		if(trim(document.forms[0].txt_procfeenew.value)=="")
			{
			document.forms[0].txt_procfeenew.focus();
			ShowAlert('121','Deviated Processing Fee');
			return;
			}
	}
	if(document.forms[0].sel_otherdev.value=="Y")
	{
		if(trim(document.forms[0].txt_odrem.value)=="")
			{
			document.forms[0].txt_odrem.focus();
			ShowAlert('121','Other Deviation Remarks');
			return;
			}
	}
	
	if(varOtherDevFLag!="Y")
	{
	if(parseInt(userclass) > parseInt(varDeviatedUserClass)) {
		
		if(document.forms[0].sel_loanamount.value == "Y") {

			if(document.forms[0].select_la.value == "S") {
				alert("Please Approve/Reject Deviated Loan Amount");
				document.forms[0].select_la.focus();
				return;
			}
			if(document.forms[0].select_la_intr.value == "S") {
				alert("Please select Addition of interest for Deviated Loan Amount");
				document.forms[0].select_la_intr.focus();
				return;
			}
		}
		if(document.forms[0].sel_interestrate.value == "Y") {

			if(document.forms[0].select_intrate.value == "S") {
				alert("Please Approve/Reject Deviated Interest Rate %");
				document.forms[0].select_intrate.focus();
				return;
			}
		}
		if(document.forms[0].sel_tenor.value == "Y") {

			if(document.forms[0].select_tenor.value == "S") {
				alert("Please Approve/Reject Deviated Tenor (Months)");
				document.forms[0].select_tenor.focus();
				return;
			}
			if(document.forms[0].select_tenor_intr.value == "S") {
				alert("Please select Addition of interest for Deviated Tenor");
				document.forms[0].select_tenor_intr.focus();
				return;
			}
		}
		if(document.forms[0].sel_margin.value == "Y") {

			if(document.forms[0].select_margin.value == "S") {
				alert("Please Approve/Reject Deviated Margin (%) ");
				document.forms[0].select_margin.focus();
				return;
			}
			if(document.forms[0].select_margin_intr.value == "S") {
				alert("Please select Addition of interest for Deviated Margin");
				document.forms[0].select_margin_intr.focus();
				return;
			}
		}
		if(document.forms[0].sel_retirement.value == "Y") {

			if(document.forms[0].select_rage.value == "S") {
				alert("Please Approve/Reject Deviated Retirement Age (Years)");
				document.forms[0].select_rage.focus();
				return;
			}
			if(document.forms[0].select_rage_intr.value == "S") {
				alert("Please select Addition of interest for Deviated Retirement Age");
				document.forms[0].select_rage_intr.focus();
				return;
			}
		}
		if(document.forms[0].sel_repaycapacity.value == "Y") {

			if(document.forms[0].select_repayment.value == "S") {
				alert("Please Approve/Reject Deviated Repayment Capacity (%)");
				document.forms[0].select_repayment.focus();
				return;
			}
			if(document.forms[0].select_repayment_intr.value == "S") {
				alert("Please select Addition of interest for Deviated Repayment Capacity ");
				document.forms[0].select_repayment_intr.focus();
				return;
			}
		}
		if(document.forms[0].sel_procfee.value == "Y") {

			if(document.forms[0].select_processfee.value == "S") {
				alert("Please Approve/Reject Deviated Processing Fee");
				document.forms[0].select_processfee.focus();
				return;
			}
			if(document.forms[0].select_processfee_intr.value == "S") {
				alert("Please select Addition of interest for Deviated Processing Fee");
				document.forms[0].select_processfee_intr.focus();
				return;
			}
		}
		if(document.forms[0].txt_otherdevremarks.value == "") {
			alert("Please Enter the Comments of Deviation Approving Authority");
			return;
		}
	}
	}
	if(document.forms[0].sel_loanamount.value=="Y"&&document.forms[0].select_la.value=="A")
	{
		if(varLoanDetFlg!="Y")
		{
			alert("Please Enter values in Appraisal -> Loan Details");
			return;
		}
	}
	if(document.forms[0].select_la.value!="S" && document.forms[0].select_la.value!="")
	{
		window.opener.disablefields(false);
		if(document.forms[0].select_la.value=="A")
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountnew.value;
		}
		else{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountold.value;
		}
		if(document.forms[0].select_intrate.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestratenew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestrateold.value;
		}
		if(document.forms[0].select_tenor.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenornew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenorold.value;
		}
		window.opener.calculateLoanAmount();
		window.opener.callSanc();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		window.opener.disablefields(true);
	}
	if(document.forms[0].select_intrate.value!="S" && document.forms[0].select_intrate.value!="")
	{
		window.opener.disablefields(false);
		if(document.forms[0].select_intrate.value=="A")
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestratenew.value;

			if(window.opener.document.forms[0].selectinttype.value=="2")
			{
				if(document.forms[0].txt_intrefno.value=="")
				{
					alert("Please Enter Interest Reference Number for this deviation");
					document.forms[0].txt_intrefno.focus();
					return;
				}
			}
		}
		else{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestrateold.value;
		}
		if(document.forms[0].select_tenor.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenornew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenorold.value;
		}
		if(document.forms[0].select_la.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountnew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountold.value;
		}
		window.opener.callSanc();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		window.opener.disablefields(true);
	}
	if(document.forms[0].select_tenor.value!="S" && document.forms[0].select_tenor.value!="")
	{
		window.opener.disablefields(false);
		if(document.forms[0].select_tenor.value=="A")
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenornew.value;
		}else{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenorold.value;
		}
		if(document.forms[0].select_intrate.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestratenew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestrateold.value;
		}
		if(document.forms[0].select_la.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountnew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountold.value;
		}
		window.opener.callSanc();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		window.opener.disablefields(true);
	}
	if(document.forms[0].select_margin.value!="S" && document.forms[0].select_margin.value!="")
		
	{
		window.opener.disablefields(false);
		if(document.forms[0].select_margin.value=="A")
		{
			window.opener.document.forms[0].txtMarginpercent.value=document.forms[0].txt_marginnew.value;
		}else{
			window.opener.document.forms[0].txtMarginpercent.value=document.forms[0].txt_marginold.value;
		}
		window.opener.document.forms[0].txtloan_sancamt.value="";
		window.opener.document.forms[0].txtloan_recmdamt.value=roundVal(parseFloat(window.opener.document.forms[0].txtloan_costloanprd.value)-(parseFloat(window.opener.document.forms[0].txtloan_costloanprd.value)*(parseFloat(window.opener.document.forms[0].txtMarginpercent.value)/100)));
		window.opener.calculateLoanAmount();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		document.forms[0].hidEligibleAmount.value=window.opener.document.forms[0].txtloan_sancamt.value;
		document.forms[0].hidMarinEligibleAmt.value=window.opener.document.forms[0].txtloan_recmdamt.value;
		window.opener.disablefields(true);
	}
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=false;
		}
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=false;
		}
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].disabled=false;
		}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="perlimitofloan";
	document.forms[0].hidBeanMethod.value="updateDeviationData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value="/action/DigiRetails_deviation.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}	
function enablefields(val)
	{
	for(var i=0;i<document.forms[0].length;i++)
		{
		if(document.forms[0].elements[i].type=='select-one')
			{
			document.forms[0].elements[i].disabled=val;
			}
		if(document.forms[0].elements[i].type=='text')
			{
			document.forms[0].elements[i].readOnly=val;
			}
		if(document.forms[0].elements[i].type=='textarea')
			{
			document.forms[0].elements[i].readOnly=val;
			}
		}
	}	
function CallOnload()
{
	if(document.forms[0].appholder.value!=strUserId)
	{
		document.forms[0].cmdedit.disabled=true;
	}
	if(sel_loanamount!=""){
		document.forms[0].sel_loanamount.value=sel_loanamount;}
	if(sel_interestrate!=""){
		document.forms[0].sel_interestrate.value=sel_interestrate;}
	if(sel_tenor!=""){
		document.forms[0].sel_tenor.value=sel_tenor;}
	if(sel_margin!=""){
		document.forms[0].sel_margin.value=sel_margin;}
	if(sel_retirement!=""){
		document.forms[0].sel_retirement.value=sel_retirement;}
	if(sel_repaymentcapacity!=""){
		document.forms[0].sel_repaycapacity.value=sel_repaymentcapacity;}
	if(sel_processingfee!=""){
		document.forms[0].sel_procfee.value=sel_processingfee;}
	if(sel_odreq!=""){
		document.forms[0].sel_otherdev.value=sel_odreq;}
	
	enablefields(true);
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		document.forms[0].cmdsave.disabled=true;
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdedit.disabled=true;
	}
	//Deviation changes by Ani
	if(varselect_la!=""){
		document.forms[0].select_la.value=varselect_la;}
	else{
		document.forms[0].select_la.value='S';}
	if(varselect_intrate!=""){
		document.forms[0].select_intrate.value=varselect_intrate;}
	else{
		document.forms[0].select_intrate.value='S';}
	if(varselect_tenor!=""){
		document.forms[0].select_tenor.value=varselect_tenor;}
	else{
		document.forms[0].select_tenor.value='S';}
	if(varselect_margin!=""){
		document.forms[0].select_margin.value=varselect_margin;}
	else{
		document.forms[0].select_margin.value='S';}
	if(varselect_rage!=""){
		document.forms[0].select_rage.value=varselect_rage;}
	else{
		document.forms[0].select_rage.value='S';}
	if(varselect_repayment!=""){
		document.forms[0].select_repayment.value=varselect_repayment;}
	else{
		document.forms[0].select_repayment.value='S';}
	if(varselect_processfee!=""){
		document.forms[0].select_processfee.value=varselect_processfee;}
	else{
		document.forms[0].select_processfee.value='S';}
	if(varselect_odrequest!=""){
		document.forms[0].select_od.value=varselect_odrequest;}
	else{
		document.forms[0].select_od.value='S';}

	if(varselect_la_intr!=""){
		document.forms[0].select_la_intr.value=varselect_la_intr;}
	else{
		document.forms[0].select_la_intr.value='S';}
	if(varselect_tenor_intr!=""){
		document.forms[0].select_tenor_intr.value=varselect_tenor_intr;}
	else{
		document.forms[0].select_tenor_intr.value='S';}
	if(varselect_margin_intr!=""){
		document.forms[0].select_margin_intr.value=varselect_margin_intr;}
	else{
		document.forms[0].select_margin_intr.value='S';}
	if(varselect_rage_intr!=""){
		document.forms[0].select_rage_intr.value=varselect_rage_intr;}
	else{
		document.forms[0].select_rage_intr.value='S';}
	if(varselect_repayment_intr!=""){
		document.forms[0].select_repayment_intr.value=varselect_repayment_intr;}
	else{
		document.forms[0].select_repayment_intr.value='S';}
	if(varselect_processfee_intr!=""){
		document.forms[0].select_processfee_intr.value=varselect_processfee_intr;}
	else{
		document.forms[0].select_processfee_intr.value='S';}
	if(varselect_odrequest_intr!=""){
		document.forms[0].select_od_intr.value=varselect_odrequest_intr;}
	else{
		document.forms[0].select_od_intr.value='S';}

	//For undo button
	if(varselect_la!="S" && varselect_la!="" && strUserId==document.forms[0].hid_lauserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_la.disabled=false;}
	else{
		document.forms[0].btn_la.disabled=true;}
	if(varselect_intrate!="S" && varselect_intrate!="" && strUserId==document.forms[0].hid_intrateuserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_intrate.disabled=false;}
	else{
		document.forms[0].btn_intrate.disabled=true;}
	if(varselect_tenor!="S" && varselect_tenor!="" && strUserId==document.forms[0].hid_tenoruserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_tenor.disabled=false;}
	else{
		document.forms[0].btn_tenor.disabled=true;}
	if(varselect_margin!="S" && varselect_margin!="" && strUserId==document.forms[0].hid_marginuserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_margin.disabled=false;}
	else{
		document.forms[0].btn_margin.disabled=true;}
	if(varselect_rage!="S" && varselect_rage!="" && strUserId==document.forms[0].hid_rageuserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_rage.disabled=false;}
	else{
		document.forms[0].btn_rage.disabled=true;}
	if(varselect_repayment!="S" && varselect_repayment!="" && strUserId==document.forms[0].hid_repaymentuserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_repayment.disabled=false;}
	else{
		document.forms[0].btn_repayment.disabled=true;}
	if(varselect_processfee!="S" && varselect_processfee!="" && strUserId==document.forms[0].hid_processfeeuserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_processfee.disabled=false;}
	else{
		document.forms[0].btn_processfee.disabled=true;}
	if(varselect_odrequest!="S" && varselect_odrequest!="" && strUserId==document.forms[0].hid_oduserid.value && varapplnholder == 'Y'){
		document.forms[0].btn_od.disabled=false;}
	else{
		document.forms[0].btn_od.disabled=true;}

	if(varOtherDevFLag=="Y")
	{
      document.forms[0].select_la.disabled=true;
      document.forms[0].select_tenor.disabled=true;
      document.forms[0].select_margin.disabled=true;
      document.forms[0].select_rage.disabled=true;
      document.forms[0].select_repayment.disabled=true;
      document.forms[0].select_processfee.disabled=true;
      document.forms[0].select_od.disabled=true;  
      document.forms[0].select_la_intr.disabled=true;
      document.forms[0].select_tenor_intr.disabled=true;
      document.forms[0].select_margin_intr.disabled=true;
      document.forms[0].select_rage_intr.disabled=true;
      document.forms[0].select_repayment_intr.disabled=true;
      document.forms[0].select_processfee_intr.disabled=true;
      document.forms[0].select_od_intr.disabled=true;     
	}
	if(varModfIntFlag=="Y")
	{
		 document.forms[0].select_intrate.disabled=true;
	}

	if(varOtherDevFLag=="Y")
	{
      document.forms[0].btn_la.disabled=true;
      document.forms[0].btn_tenor.disabled=true;
      document.forms[0].btn_margin.disabled=true;
      document.forms[0].btn_rage.disabled=true;
      document.forms[0].btn_repayment.disabled=true;
      document.forms[0].btn_processfee.disabled=true;
      document.forms[0].btn_od.disabled=true;      
	}
	if(varModfIntFlag=="Y")
	{
		 document.forms[0].btn_intrate.disabled=true;
	}
	
	if(parseInt(userclass) > parseInt(varDeviatedUserClass))
	{
      document.all.s1.style.visibility="visible";
      document.all.s1.style.position="relative";
	}
	else
	{
	     document.all.s1.style.visibility="hidden";
	     document.all.s1.style.position="absolute";
	}
	hideRows();

	if(APP_PERM_NO!="")
	{
		
		document.all.id_permLetter.style.visibility="visible";
	    document.all.id_permLetter.style.position="relative";
	    document.all.deattach.style.visibility="visible";
	    document.all.deattach.style.position="relative";
		//document.forms[0].cmdpermissionletter.disabled=false;
	}
	else
	{
		document.all.id_permLetter.style.visibility="hidden";
	    document.all.id_permLetter.style.position="absolute";
	    document.all.deattach.style.visibility="hidden";
	    document.all.deattach.style.position="absolute";
		//document.forms[0].cmdpermissionletter.disabled=true;
	}
}
function doEdit()
{
	document.forms[0].hidAction.value="update";
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	enablefields(false);
	callApprovedUser();
	callDeviatedUser();
	disablefields();
	//addede by bhaskar
	
	if(varOtherDevFLag=="Y")
	{
      document.forms[0].select_la.disabled=true;
      document.forms[0].select_tenor.disabled=true;
      document.forms[0].select_margin.disabled=true;
      document.forms[0].select_rage.disabled=true;
      document.forms[0].select_repayment.disabled=true;
      document.forms[0].select_processfee.disabled=true;
      document.forms[0].select_od.disabled=true; 
      document.forms[0].select_la_intr.disabled=true;
      document.forms[0].select_tenor_intr.disabled=true;
      document.forms[0].select_margin_intr.disabled=true;
      document.forms[0].select_rage_intr.disabled=true;
      document.forms[0].select_repayment_intr.disabled=true;
      document.forms[0].select_processfee_intr.disabled=true;
      document.forms[0].select_od_intr.disabled=true;      
	}
	if(varModfIntFlag=="Y")
	{
		 document.forms[0].select_intrate.disabled=true;
	}
	if(varOtherDevFLag=="Y")
	{
      document.forms[0].btn_la.disabled=true;
      document.forms[0].btn_tenor.disabled=true;
      document.forms[0].btn_margin.disabled=true;
      document.forms[0].btn_rage.disabled=true;
      document.forms[0].btn_repayment.disabled=true;
      document.forms[0].btn_processfee.disabled=true;
      document.forms[0].btn_od.disabled=true;      
	}
	if(varModfIntFlag=="Y")
	{
		 document.forms[0].btn_intrate.disabled=true;
	}
	document.forms[0].dev_prop_no.readOnly=true;

	//ended

	//if(window.opener.document.forms[0].selectinttype.value=="2")
	//{
		//if(varintrefno!="Y")
		//{
			//document.forms[0].select_intrate.disabled=true;
		//}
	//}
}
function doUndo(val)
{
	if(val=="loan")
	{
		window.opener.disablefields(false);
		window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountold.value;
		if(document.forms[0].select_intrate.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestratenew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestrateold.value;
		}
		if(document.forms[0].select_tenor.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenornew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenorold.value;
		}
		window.opener.calculateLoanAmount();
		window.opener.callSanc();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		window.opener.disablefields(true);
	}
	else if(val=="int")
	{
		window.opener.disablefields(false);
		window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestrateold.value;

		if(document.forms[0].select_la.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountnew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountold.value;
		}
		if(document.forms[0].select_tenor.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenornew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenorold.value;
		}
		
		window.opener.callSanc();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		window.opener.disablefields(true);

		
		if(varMclrCode=="O")
		{
			var VarAjustSpread=roundVal(parseFloat(NanNumber(document.forms[0].txt_interestrateold.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidBaserate.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidcreditrskpremium.value)));
			document.forms[0].hidbusstrategicpremium.value=VarAjustSpread;
			document.forms[0].hidcreditrskpremium.value=window.opener.document.forms[0].hidcreditrskpremium.value;
		}
		else
		{
			var VarAjustSpread=roundVal(parseFloat(NanNumber(document.forms[0].txt_interestrateold.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidBaserate.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidbusstrategicpremium.value)));
			document.forms[0].hidcreditrskpremium.value=VarAjustSpread;
			document.forms[0].hidbusstrategicpremium.value=window.opener.document.forms[0].hidbusstrategicpremium.value;
		}
	}
	else if(val=="tenor")
	{
		window.opener.disablefields(false);
		if(document.forms[0].select_la.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountnew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_sancamt.value=document.forms[0].txt_loanamountold.value;
		}
		if(document.forms[0].select_intrate.valuw=="A")
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestratenew.value;
		}
		else
		{
			window.opener.document.forms[0].txtloan_modintrate.value=document.forms[0].txt_interestrateold.value;
		}
		window.opener.document.forms[0].txtloan_reqterms.value=document.forms[0].txt_tenorold.value;
		window.opener.callSanc();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		window.opener.disablefields(true);	
	}
	else if(val=="margin")
	{
		window.opener.disablefields(false);
		window.opener.document.forms[0].txtloan_sancamt.value="";
		window.opener.document.forms[0].txtMarginpercent.value=document.forms[0].txt_marginold.value;
		window.opener.document.forms[0].txtloan_recmdamt.value=roundVal(parseFloat(window.opener.document.forms[0].txtloan_costloanprd.value)-(parseFloat(window.opener.document.forms[0].txtloan_costloanprd.value)*(parseFloat(window.opener.document.forms[0].txtMarginpercent.value)/100)));
		window.opener.calculateLoanAmount();
		document.forms[0].hidEMIAmount.value=window.opener.document.forms[0].txtmonPay.value;
		document.forms[0].hidEligibleAmount.value=window.opener.document.forms[0].txtloan_sancamt.value;
		document.forms[0].hidMarinEligibleAmt.value=window.opener.document.forms[0].txtloan_recmdamt.value;
		window.opener.disablefields(true);
	}
	document.forms[0].hidundoval.value=val;
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=false;
		}
	}
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanId.value="perlimitofloan";
	document.forms[0].hidBeanMethod.value="updateDeviationData";
	document.forms[0].hidSourceUrl.value="/action/DigiRetails_deviation.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	document.forms[0].hidBeanId.value="perlimitofloan";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"action/DigiRetails_deviation.jsp";
	document.forms[0].submit();
}
function hideRows()
{
	if(prd_type=="pG" || prd_type=='pR')
	{
		document.all.id_IntRate.style.display="none";
		document.all.id_Tenor.style.display="none";
		document.all.id_RetireAge.style.display="none";
		document.all.id_RepayCap.style.display="none";
		document.all.id_ProcessFee.style.display="none";
	}
	else
	{
		document.all.id_IntRate.style.display="table-row";
		document.all.id_Tenor.style.display="table-row";
		document.all.id_RetireAge.style.display="table-row";
		document.all.id_RepayCap.style.display="table-row";
		document.all.id_ProcessFee.style.display="table-row";
	}
}
function checkMaxAmount()
{
	var varDevAmount=document.forms[0].txt_loanamountnew.value;
	if(eval(varDevAmount)>eval(varMaxAmount))
	{
		alert("Maximum amount defined for this product is "+varMaxAmount);
		document.forms[0].txt_loanamountnew.value="";
		document.forms[0].txt_loanamountnew.focus();
		return;
	}
}
function callLoad()
{
	try
	{
		if(document.forms[0].hidException.value!="")
		{
			window.close();
		}
	}
	catch(rr)
	{
	}
}
function chkintvalue()
{
	if(document.forms[0].txt_interestratenew.value!="" && window.opener.document.forms[0].selectinttype.value=="2")
	{
		if(varMclrCode=="O")
			var vardeviationAmt=roundVal(parseFloat(NanNumber(document.forms[0].txt_interestrateold.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidBaserate.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidcreditrskpremium.value)));
		else
			var vardeviationAmt=roundVal(parseFloat(NanNumber(document.forms[0].txt_interestrateold.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidBaserate.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidbusstrategicpremium.value)));

		if(vardeviationAmt=="")
			vardeviationAmt=0.0;

		if(parseFloat(vardeviationAmt)>parseInt(document.forms[0].hidIntDevLimit.value))
		{
			vardeviationAmt=parseFloat(document.forms[0].hidIntDevLimit.value);
		}
		var vardiff=roundVal(parseFloat(NanNumber(document.forms[0].txt_interestrateold.value))-parseFloat(vardeviationAmt));
		
		
		
		
		if(parseFloat(document.forms[0].txt_interestratenew.value) < parseFloat(vardiff))
		{
			alert("Interest Rate should not less than "+vardiff);
			document.forms[0].txt_interestratenew.value="";
			document.forms[0].txt_interestratenew.focus()
			return;
		}
		else
		{
			
			if(varMclrCode=="O")
			{
				document.forms[0].hidbusstrategicpremium.value=roundVal(parseFloat(NanNumber(document.forms[0].txt_interestratenew.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidBaserate.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidcreditrskpremium.value)));
				document.forms[0].hidcreditrskpremium.value=window.opener.document.forms[0].hidcreditrskpremium.value;
			}
			else
			{
				document.forms[0].hidcreditrskpremium.value=roundVal(parseFloat(NanNumber(document.forms[0].txt_interestratenew.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidBaserate.value))-parseFloat(NanNumber(window.opener.document.forms[0].hidbusstrategicpremium.value)));
				document.forms[0].hidbusstrategicpremium.value=window.opener.document.forms[0].hidbusstrategicpremium.value;
			}
		}

	}
}

function docheckIntRate()
{
	if(document.forms[0].sel_interestrate.value == "Y" && parseFloat(document.forms[0].txt_interestratenew.value)>0)
	{
		document.all.intrefno1.style.display = "table-cell";
		document.all.intrefno2.style.display = "table-cell";
	}
	else
	{
		document.forms[0].txt_intrefno.value = "";
		document.all.intrefno1.style.display = "none";
		document.all.intrefno2.style.display = "none";
	}
}
function doSearch()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/devproposal_search.jsp?hidBeanId=perlimitofloan&hidBeanGetMethod=getPermissionPropSearch";   
		var title = "Permission No";
		var prop = "scrollbars=yes,width=650,height=450,menubar=no";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,"PermissionNo",prop);

	}
}
function doPermissionLetter()
{
	var permappno=document.forms[0].dev_prop_no.value;
	var prop = "scrollbars=yes,width=650,height=500,top=25,left=180";
	var url=appURL+"action/permissionletter.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPermissionLetterData&appno="+permappno;
	window.open(url,"",prop);
}

function doRemove()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		document.all.id_permLetter.style.visibility="hidden";
	    document.all.id_permLetter.style.position="absolute";
	    document.all.deattach.style.visibility="hidden";
	    document.all.deattach.style.position="absolute";
    	document.forms[0].dev_prop_no.value="";
	}
}

</script>
</head>
<body onload="callLoad();CallOnload();docheckIntRate();">
<form method="post" class="normal">
<lapschoice:handleerror />
<lapschoice:application />
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td valign="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td width="20%">Deviation</td>
            <td width="10%">Defined Value</td>
            <td width="10%" nowrap="nowrap">Deviation</td>
            <td width="10%">New Value</td>
            <td width="30%">Remarks / Comments</td>
            <td width="10%" align="center">Approval</td>
             <td width="10%" align="center">Addition of Interest</td>
            <td width="10%" align="center">Undo</td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%">Loan Amount 
              <input type="hidden" size="10" name="txt_loandivtype" style="text-align:right" value="LA">
            </td>
            <td width="10%"> 
              <input type="hidden" name="hidloanamt" value="<%=Helper.correctNull((String)hshValues.get("sel_loanamount"))%>">
              <input type="text" size='15' name="txt_loanamountold" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("amtreq"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="sel_loanamount" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='15' maxlength="18" name="txt_loanamountnew" style="text-align:right" onBlur="checkMaxAmount();" value="<%=Helper.correctNull((String)hshValues.get("txt_loanamountnew"))%>" onKeyPress="allowNumber(document.forms[0].txt_loanamountnew)">
            </td>
            <td width="30%"> 
              <textarea name="txt_loanremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("txt_loanremarks"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_la">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='A'>Approve</option>
			  <option value='R'>Reject</option>
              </select>
			  <input type="hidden" name="hid_lauserid" value="<%=Helper.correctNull((String)hshValues.get("hid_lauserid"))%>">
			  <input type="hidden" name="hid_laflag" value="<%=Helper.correctNull((String)hshValues.get("select_la"))%>">
            </td>
            <td width="10%" align="center"> 
              <select name="select_la_intr">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='1'>Yes</option>
			  <option value='0'>No</option>
              </select>
            </td>
            <td width="10%" align="center"> 
              <input type="button" name="btn_la" value="Undo" class="buttonStyle" onClick="doUndo('loan')">
            </td>
          </tr>
          <tr class="datagrid" id="id_IntRate"> 
            <td width="20%">Interest Rate (%) 
              <input type="hidden" size='10' name="txt_interestdivtype" style="text-align:right" value="IR">
            </td>
            <td width="10%"> 
              <input type="hidden" name="hidintrate" value="<%=Helper.correctNull((String)hshValues.get("sel_interestrate"))%>"/>
              <input type="text" size='5' name="txt_interestrateold" style="text-align:right" 
              value="<%=Helper.correctNull((String)hshValues.get("loan_intrate"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="sel_interestrate" onClick="disablefields()" onChange="docheckIntRate();">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="txt_interestratenew" style="text-align:right" 
              value="<%=Helper.correctNull((String)hshValues.get("txt_interestratenew"))%>"  
              onKeyPress="allowNumber(document.forms[0].txt_interestratenew)" onblur="chkintvalue();docheckIntRate();">
            </td>
            <td width="30%"> 
              <textarea name="txt_interestrateremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("txt_interestrateremarks"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_intrate" onchange="chkintvalue();">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              <input type="hidden" name="hid_intrateuserid" value="<%=Helper.correctNull((String)hshValues.get("hid_intrateuserid"))%>">
              <input type="hidden" name="hid_intflag" value="<%=Helper.correctNull((String)hshValues.get("select_intrate"))%>">
            </td>
            <td width="10%" align="center"> 
              &nbsp;
            </td>
            <td width="10%" align="center">
              <input type="button" name="btn_intrate" value="Undo" class="buttonStyle" onClick="doUndo('int')">
            </td>
          </tr>
          <tr class="datagrid" id="id_Tenor"> 
            <td width="20%">Tenor (Months) 
              <input type="hidden" size='10' name="txt_tenordivtype" style="text-align:right" value="TR">
            </td>
            <td width="10%"> 
              <input type="hidden" name="hidtenor" value="<%=Helper.correctNull((String)hshValues.get("sel_tenor"))%>"/>
              <input type="text" size='5' name="txt_tenorold" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("loan_reqterms"))%>" onKeyPress="allowNumber(document.forms[0].txtloan_terms)">
            </td>
            <td align="center" width="10%"> 
              <select name="sel_tenor" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="txt_tenornew" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("txt_tenornew"))%>" onKeypress="allowInteger()">
            </td>
            <td width="30%"> 
              <textarea name="txt_tenorremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("txt_tenorremarks"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_tenor">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              <input type="hidden" name="hid_tenoruserid" value="<%=Helper.correctNull((String)hshValues.get("hid_tenoruserid"))%>">
              <input type="hidden" name="hid_tenorflag" value="<%=Helper.correctNull((String)hshValues.get("select_tenor"))%>">
            </td>
            <td width="10%" align="center"> 
              <select name="select_tenor_intr">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='1'>Yes</option>
			  <option value='0'>No</option>
              </select>
            </td>
            <td width="10%" align="center">
              <input type="button" name="btn_tenor" value="Undo" class="buttonStyle" onClick="doUndo('tenor')">
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%"> Margin (%) 
              <input type="hidden" size='10' name="txt_margindivtype" style="text-align:right" value="MN">
            </td>
            <td width="10%"> 
              <input type="hidden" name="hidmargin" value="<%=Helper.correctNull((String)hshValues.get("sel_margin"))%>"/>
              <input type="text" size='5' name="txt_marginold" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("margin"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="sel_margin" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="txt_marginnew" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("txt_marginnew"))%>" onKeyPress="allowNumber(document.forms[0].txt_marginnew);" onblur="checkPercentage(document.forms[0].txt_marginnew);">
            </td>
            <td width="30%"> 
              <textarea name="txt_marginremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("txt_marginremarks"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_margin">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              <input type="hidden" name="hid_marginuserid" value="<%=Helper.correctNull((String)hshValues.get("hid_marginuserid"))%>">
              <input type="hidden" name="hid_marginflag" value="<%=Helper.correctNull((String)hshValues.get("select_margin"))%>">
            </td>
            <td width="10%" align="center"> 
              <select name="select_margin_intr">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='1'>Yes</option>
			  <option value='0'>No</option>
              </select>
            </td>
            <td width="10%" align="center">
              <input type="button" name="btn_margin" value="Undo" class="buttonStyle"  onClick="doUndo('margin')">
            </td>
          </tr>
          <tr class="datagrid" id="id_RetireAge"> 
            <td width="20%">Retirement Age (Years) 
              <input type="hidden" size='10' name="txt_retirementdivtype" style="text-align:right" value="RA">
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="txt_retirementold" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("txt_retirementold"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="sel_retirement" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="txt_retirementnew" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("txt_retirementnew"))%>" onKeyPress="allowNumber(document.forms[0].txt_retirementnew)">
            </td>
            <td width="30%"> 
              <textarea name="txt_retirementremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("txt_retirementremarks"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_rage">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              <input type="hidden" name="hid_rageuserid" value="<%=Helper.correctNull((String)hshValues.get("hid_rageuserid"))%>">
              <input type="hidden" name="hid_rageflag" value="<%=Helper.correctNull((String)hshValues.get("select_rage"))%>">
            </td>
            <td width="10%" align="center"> 
              <select name="select_rage_intr">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='1'>Yes</option>
			  <option value='0'>No</option>
              </select>
            </td>
            <td width="10%" align="center">
              <input type="button" name="btn_rage" value="Undo" class="buttonStyle" onClick="doUndo('age')">
            </td>
          </tr>
          <tr class="datagrid" id="id_RepayCap"> 
            <td nowrap="nowrap" width="20%">Repayment Capacity (%) 
              <input type="hidden" size='10' name="txt_repaydivtype" style="text-align:right" value="RC">
            </td>
            <td width="10%"> 
              <input type="hidden" name="hidrepaycapacity" value="<%=Helper.correctNull((String)hshValues.get("repayreq"))%>">
              <input type="text" size='5' name="txt_repaymentold" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("repayold"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="sel_repaycapacity" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="txt_repaynew" onKeypress="allowInteger()" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("repaynew"))%>">
            </td>
            <td width="30%"> 
              <textarea name="txt_repayremarks" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("repayremarks"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_repayment">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              <input type="hidden" name="hid_repaymentuserid" value="<%=Helper.correctNull((String)hshValues.get("hid_repaymentuserid"))%>">
              <input type="hidden" name="hid_repayflag" value="<%=Helper.correctNull((String)hshValues.get("select_repayment"))%>">
            </td>
            <td width="10%" align="center"> 
              <select name="select_repayment_intr">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='1'>Yes</option>
			  <option value='0'>No</option>
              </select>
            </td>
            <td width="10%" align="center">
              <input type="button" name="btn_repayment" value="Undo" class="buttonStyle" onClick="doUndo('repay')"> 
            </td>
          </tr>          
           <tr class="datagrid" id="id_ProcessFee"> 
            <td width="20%">Processing Fee 
              <input type="hidden" size='10' name="txt_procfeedivtype" style="text-align:right" value="PF">
            </td>
            <td width="10%"> 
              <input type="text" size='5' name="txt_procfeeold" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("procfeeold"))%>">
            </td>
            <td align="center" width="10%"> 
              <select name="sel_procfee" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>
            <td width="10%"> 
              <input type="text" size='12' maxlength="9" name="txt_procfeenew" style="text-align:right" value="<%=Helper.correctNull((String)hshValues.get("procfeenew"))%>" onKeyPress="allowNumber(document.forms[0].txt_procfeenew)">
            </td>
            <td width="30%"> 
              <textarea name="txt_procfeerem" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("procfeeremarks"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_processfee">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              <input type="hidden" name="hid_processfeeuserid" value="<%=Helper.correctNull((String)hshValues.get("hid_processfeeuserid"))%>">
              <input type="hidden" name="hid_PFflag" value="<%=Helper.correctNull((String)hshValues.get("select_processfee"))%>">
            </td>
            <td width="10%" align="center"> 
              <select name="select_processfee_intr">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='1'>Yes</option>
			  <option value='0'>No</option>
              </select>
            </td>
            <td width="10%" align="center">
              <input type="button" name="btn_processfee" value="Undo" class="buttonStyle" onClick="doUndo('profee')">
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="20%">Other Deviation 
              <input type="hidden" size='10' name="txt_otherdevtype" style="text-align:right" value="OD">
            </td>
            <td>&nbsp;&nbsp;</td>
           
            <td align="center" width="10%"> 
              <select name="sel_otherdev" onClick="disablefields()">
                <option value="N" selected="selected">No</option>
                <option value="Y">Yes</option>
              </select>
            </td>  
            <td>&nbsp;&nbsp;</td>        
            <td width="30%"> 
              <textarea name="txt_odrem" cols="46" rows="2"><%=Helper.correctNull((String) hshValues.get("txt_odrem"))%></textarea>
            </td>
            <td width="10%" align="center"> 
              <select name="select_od">
                <option value='S' selected="selected">-- Select --</option>
                <option value='A'>Approve</option>
                <option value='R'>Reject</option>
              </select>
              <input type="hidden" name="hid_oduserid" value="<%=Helper.correctNull((String)hshValues.get("otherdevuserid"))%>">
              <input type="hidden" name="hid_ODflag" value="<%=Helper.correctNull((String)hshValues.get("select_od"))%>">
            </td>
            <td width="10%" align="center"> 
              <select name="select_od_intr">
			  <option value='S' selected="selected">-- Select --</option>
			  <option value='1'>Yes</option>
			  <option value='0'>No</option>
              </select>
            </td>
            <td width="10%" align="center">
              <input type="button" name="btn_od" value="Undo" class="buttonStyle" onClick="doUndo('other')">
            </td>
          </tr>
        
          <tr class="datagrid"> 
            <td width="20%">Comments of Deviation Approving Authority <span class="mantatory" id="s1">*</span>
              <input type="hidden" size='10' name="txt_otherdivtype" style="text-align:right" value="OD">
            </td>
            <td colspan="7"> 
              <textarea name="txt_otherdevremarks" cols="90" rows="4"><%=Helper.correctNull((String) hshValues.get("txt_otherdevremarks"))%></textarea>
            </td>
          </tr>
          <tr class="datagrid"> 
      			<td width="20%">Permission Proposal No</td>&nbsp;
      			<td width="10%" colspan="8"><input type="text" name="dev_prop_no" size="12" readOnly="readonly" value="<%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%>"> 
      				<b><a> <span onClick="doSearch()" style="cursor: hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0" tabindex=""></span></a></b>
				&nbsp;&nbsp;&nbsp;&nbsp; <a id="id_permLetter"><span onClick="doPermissionLetter()" style="cursor: hand"> Permission Letter</span></a>
				&nbsp;&nbsp;<img id="deattach" alt="De-attach" src="<%=ApplicationParams.getAppUrl()%>img/delete.png" onclick="doRemove()" style="cursor:hand"/>&nbsp;
				 </td>
          </tr>
          <tr class="datagrid"> 
            <td id="intrefno1"> Interest Deviation Reference No.</td>
            <input type="hidden" size='10' name="txt_intraterefnotype" style="text-align:right" value="IRRN">
			<td id="intrefno2" colspan="7"> <input type="text" name="txt_intrefno" onKeyPress="docheckIntRate();" maxlength="30" size="40" value="<%=Helper.correctNull((String) hshValues.get("txt_intraterefnumber"))%>">&nbsp;</td>
          </tr>
        </table>
				</td>
			</tr>
		</table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidappno" value="<%=request.getParameter("appno")%>"> 
<input type="hidden" name="strappno" value="<%=strappno%>">
<input type="hidden" name="editoption" value="<%=Helper.correctNull((String)hshValues.get("editoption"))%>"/>
<input type="hidden" name="moratorium" value="<%=Helper.correctNull((String)hshValues.get("moratorium"))%>"/>
<input type="hidden" name="interestcharged" value="<%=Helper.correctNull((String)hshValues.get("interestcharged"))%>"/>
<input type="hidden" name="servised" value="<%=Helper.correctNull((String)hshValues.get("servised"))%>"/>
<input type="hidden" name="hidundoval"/>
<input type="hidden" name="hidEMIAmount"/>
<input type="hidden" name="hidEligibleAmount"/>
<input type="hidden" name="hidbusstrategicpremium"/>
<input type="hidden" name="hidcreditrskpremium"/>
<input type="hidden" name="hidMclrCode" value="<%=Helper.correctNull((String)hshValues.get("mclr_type_code"))%>"/>



<input type="hidden" name="hidMarinEligibleAmt"/>
<input type="hidden" name="hidIntDevLimit" value="<%=Helper.correctDouble((String)hshValues.get("strIntDevLimit"))%>" />
</form>
</body>
</html>
