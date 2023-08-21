 <%@include file="../share/directives.jsp"%>
<%
String strPgDist = Helper.correctNull(request.getParameter("hiPgDist"));
String loan_type=Helper.correctNull((String)hshValues.get("app_loantype"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String PRD_CGTMSE=Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).trim();

if(strCategoryType.equals(""))
{
	strCategoryType=strSessionModuleType;
}
	
String loantype="";
	if(loan_type.equalsIgnoreCase("P"))
	{
		loantype="Retail";
	}
	if(loan_type.equalsIgnoreCase("A"))
	{
		loantype="Agriculture";
	}

	if(loan_type.equalsIgnoreCase("c"))
	{
		loantype="Corporate";
	}
	if(loan_type.equalsIgnoreCase("T"))
	{
		loantype="Tertiary";
	}
	if(loan_type.equalsIgnoreCase("E"))
	{
		loantype="Short Review/Extension";
	}
	String strPrdtype = Helper.correctNull((String) session.getAttribute("strProductType"));
	
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var strPrdType="<%=strPrdtype%>";
var varloantype="<%=loan_type%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var Actiontype="<%=Helper.correctNull((String)hshValues.get("Actiontype"))%>";
var applstatus="<%=Helper.correctNull((String)hshValues.get("TXNDET_APPL_STATUS"))%>";
var app_status_val="<%=Helper.correctNull((String)hshValues.get("TXNDET_APPL_STATUS"))%>";
var usr_department="<%=Helper.correctNull((String)hshValues.get("usr_department"))%>";
var facilitySNO="<%=Helper.correctNull((String)hshValues.get("facilitySNO"))%>";
var strSessionModuleType="<%=strSessionModuleType%>";
var FACILITY_WHT_CGTMSEAPPLY="<%=Helper.correctNull((String)hshValues.get("FACILITY_WHT_CGTMSEAPPLY"))%>";
var facilityNature="<%=Helper.correctNull((String) hshValues.get("FacilityNature"))%>";
var marginmoney="<%=Helper.correctNull((String) hshValues.get("TXNDET_MARGINMONEY"))%>";
var varComfactype="<%=Helper.correctNull((String) hshValues.get("com_factype"))%>";
var strCatType="<%=strCategoryType%>";
var varPROCESSDATE="<%=Helper.correctNull((String) hshValues.get("APP_PROCESSDATE"))%>"

function callOtherTab(val)
{
	
	if(document.forms[0].cmdsave.disabled)
	{	
		<%if(strSessionModuleType.equalsIgnoreCase("DIGI")){%>
		if(val=="action")
		{
			document.forms[0].hidBeanGetMethod.value="getAction";
			document.forms[0].hidBeanId.value="perDeviation";
			document.forms[0].action=appURL+"action/permworkflowaction.jsp";
			document.forms[0].submit();
		}
		<%}else{%>
			if(val=="action")
			{	     
				document.forms[0].hidBeanGetMethod.value="getAction";
				document.forms[0].hidBeanId.value="commworkflow";
				document.forms[0].cattype.value=strCatType;
				document.forms[0].action=appURL+"action/appworkflowaction.jsp";
				document.forms[0].submit();
			}
		<%}%>
	if(val=="sanction")
	{
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].cattype.value=strCatType;
		document.forms[0].action=appURL+"action/com_termsofsanction.jsp";
		document.forms[0].submit();
	}
	if(val=="drawdownschedule")
	{
		if (varloantype == "C"||true)
		{
		 document.forms[0].hidBeanId.value="commworkflow";
		 document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
		 document.forms[0].action=appURL+"action/drawdownschedule.jsp";
		 document.forms[0].submit();
	 	}
		else
		{
                alert("Draw Down Schedule to be Entered only for Project Loans");
                return;
        }
	}
	if(val=="history")
	{
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
		 document.forms[0].submit();
	}
	if(val=="legcomp")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
		document.forms[0].action=appURL+"action/legalcompliance.jsp";
		document.forms[0].submit();
	}
	if(val=="restrfacdetails")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getRestrFacilityDetails";
		document.forms[0].action=appURL+"action/apprestructureaccountdetails.jsp";
		document.forms[0].submit();
	}
	if(val=="comments")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
		document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
		document.forms[0].submit();
	}
	if(val=="Queries")
	{
		document.forms[0].hidBeanGetMethod.value="getQueryData";
		 document.forms[0].hidBeanId.value="documentsupport";
		 document.forms[0].action=appURL+"action/appqueryhome.jsp";
		 document.forms[0].submit();
	}
	}
	else
	{
		ShowAlert('103');
	}
}

function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		if(varOrgLevel=="A")
		{
			if(fname=="DtOutsAmnt" || fname=="DtFstInsDue" || fname=="DtFstDisbursment" || fname=="DtLstDisbursment" || fname=="OFBDt" || fname=="ONFBdT" || fname=="DtFstDisbursmentwc" || fname=="DtLstDisbursmentwc")
			{
				showCal(appURL,fname);
			}
			else
			{
				return false;
			}
		}
		if(usr_department=="008")
		{
			if(fname=="txt_txnDate" || fname=="txt_applDate" || fname=="txt_approvalDate" || fname=="txt_guanrantee_startDate" || fname=="txt_guanrantee_endDate")
			{
				showCal(appURL,fname);
			}
			else
			{
				return false;
			}
		}
	}
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,true);
	
	if(varOrgLevel=="A")
	{
		document.forms[0].txt_txnID.disabled=false;
		document.forms[0].txt_txnDate.disabled=false;
		document.forms[0].txt_txnAmount.disabled=false;
		document.all.id_txnDate.style.display="inline";
		document.forms[0].txt_CrdtAmt.disabled=false;
		document.forms[0].txt_AmtDisbursment.disabled=false;
		document.forms[0].txt_OutsAmount.disabled=false;
		document.forms[0].DtOutsAmnt.disabled=false;
		document.forms[0].DtFstInsDue.disabled=false;
		document.forms[0].DtFstDisbursment.disabled=false;
		document.forms[0].DtLstDisbursment.disabled=false;
		document.forms[0].txt_AmtDisbursmentwc.disabled=false;
		document.forms[0].DtFstDisbursmentwc.disabled=false;
		document.forms[0].DtLstDisbursmentwc.disabled=false;
		document.all.dt1_t.style.display="inline";
		document.all.dt2_t.style.display="inline";
		document.all.dt3_t.style.display="inline";
		document.all.dt4_t.style.display="inline";

		document.forms[0].txt_CrdtFundBased.disabled=false;
		document.forms[0].txt_CrdtNonFundBased.disabled=false;
		document.forms[0].OutsdFundBased.disabled=false;
		document.forms[0].OFBDt.disabled=false;
		document.forms[0].OutsdNonFundBased.disabled=false;
		document.forms[0].ONFBdT.disabled=false;
	}
	else
	{
		document.forms[0].txt_txnID.disabled=true;
		document.forms[0].txt_txnDate.disabled=true;
		document.forms[0].txt_txnAmount.disabled=true;
		document.all.id_txnDate.style.display="none";
		document.forms[0].txt_CrdtAmt.disabled=true;
		document.forms[0].txt_AmtDisbursment.disabled=true;
		document.forms[0].txt_OutsAmount.disabled=true;
		document.forms[0].DtOutsAmnt.disabled=true;
		document.forms[0].DtFstInsDue.disabled=true;
		document.forms[0].DtFstDisbursment.disabled=true;
		document.forms[0].DtLstDisbursment.disabled=true;
		document.forms[0].txt_AmtDisbursmentwc.disabled=true;
		document.forms[0].DtFstDisbursmentwc.disabled=true;
		document.forms[0].DtLstDisbursmentwc.disabled=true;
		document.forms[0].txt_CrdtFundBased.disabled=true;
		document.forms[0].txt_CrdtNonFundBased.disabled=true;
		document.forms[0].OutsdFundBased.disabled=true;
		document.forms[0].OutsdNonFundBased.disabled=true;
		document.all.dt1_t.style.display="none";
		document.all.dt2_t.style.display="none";
		document.all.dt3_t.style.display="none";
		document.all.dt4_t.style.display="none";
		document.all.dt1_o.style.display="none";
		document.all.dt2_o.style.display="none";
		document.forms[0].txt_CrdtFundBased.disabled=true;
		document.forms[0].txt_CrdtNonFundBased.disabled=true;
		document.forms[0].OutsdFundBased.disabled=true;
		document.forms[0].OFBDt.disabled=true;
		document.forms[0].OutsdNonFundBased.disabled=true;
		document.forms[0].ONFBdT.disabled=true;
	}
	if(varOrgLevel=="A" ||varOrgLevel=="C")
	{
	
	document.all.crdt.style.visibility="visible";
	document.all.crdt.style.position="relative";
	/*document.forms[0].txt_CrdtFundBased.disabled=false;
	document.forms[0].txt_CrdtNonFundBased.disabled=false;
	document.forms[0].OutsdFundBased.disabled=false;
	document.forms[0].OutsdNonFundBased.disabled=false;
	document.forms[0].ONFBdT.disabled=false;
	document.forms[0].OFBDt.disabled=false;*/
	document.all.dt1_o.style.display="inline";
	document.all.dt2_o.style.display="inline";
	}

	if(usr_department=="008")
	{
		document.forms[0].txt_applDate.readOnly=true;
		document.forms[0].txt_approvalDate.readOnly=true;
		document.forms[0].txt_guanrantee_startDate.readOnly=true;
		document.forms[0].txt_guanrantee_endDate.readOnly=true;

		
		document.all.id_applDate.style.display="none";
		document.all.id_approvalDate.style.display="none";
		document.all.id_guanrantee_startDate.style.display="none";
		document.all.id_guanrantee_endDate.style.display="none";

		document.forms[0].txt_txnID.disabled=false;
		document.forms[0].txt_txnDate.disabled=false;
		document.all.id_txnDate.style.display="inline";
		document.forms[0].txt_txnAmount.disabled=false;
		document.forms[0].sel_applStatus.disabled=false;
		document.forms[0].txt_appl_refno.disabled=false;
		document.forms[0].txt_applDate.disabled=false;
		document.forms[0].txt_CG_panno.disabled=false;
		document.forms[0].txt_approvalDate.disabled=false;
		document.forms[0].txt_rej_remarks.disabled=false;
		document.forms[0].txt_payment_ackwno.disabled=false;
		document.forms[0].txt_guanrantee_startDate.disabled=false;
		document.forms[0].txt_guanrantee_endDate.disabled=false;
		document.forms[0].txt_GF_Amount.disabled=false;
		document.forms[0].txt_TX_Amount.disabled=false;

		document.forms[0].txt_IGST_Rate.disabled=false;
		document.forms[0].txt_IGST_Amount.disabled=true;
		document.forms[0].txt_CGST_Rate.disabled=false;
		document.forms[0].txt_CGST_Amount.disabled=true;
		document.forms[0].txt_SGST_Rate.disabled=false;
		document.forms[0].txt_SGST_Amount.disabled=true;
		
		if(document.forms[0].sel_applStatus.value=="P")
		{
			document.forms[0].txt_appl_refno.disabled=false;
			document.all.id_applDate.style.display="inline";
		}
		else if(document.forms[0].sel_applStatus.value=="A")
		{
			document.forms[0].txt_CG_panno.disabled=false;
			document.all.id_approvalDate.style.display="inline";
		}
		else if(document.forms[0].sel_applStatus.value=="R")
		{
			document.forms[0].txt_rej_remarks.disabled=false;
		}
		else if(document.forms[0].sel_applStatus.value=="C")
		{
			document.forms[0].txt_payment_ackwno.disabled=false;
			document.all.id_applCovered1.style.display="inline";
			document.all.id_guanrantee_startDate.style.display="inline";
			document.all.id_guanrantee_endDate.style.display="inline";
			document.all.id_applDate.style.display="inline";
			document.all.id_approvalDate.style.display="inline";
			document.all.id_GF_TaxableAmt.style.display="inline";
			 document.all.id_IGST_Rate_Amount.style.display="inline";
			 document.all.id_CGST_Amount.style.display="inline";
			 document.all.id_SGST_Amount.style.display="inline";
		}
		else
		{
			document.forms[0].txt_appl_refno.disabled=false;
			document.forms[0].txt_applDate.disabled=false;
			document.forms[0].txt_CG_panno.disabled=false;
			document.forms[0].txt_approvalDate.disabled=false;
			document.forms[0].txt_rej_remarks.disabled=false;
			document.forms[0].txt_payment_ackwno.disabled=false;
			document.forms[0].txt_guanrantee_startDate.disabled=false;
			document.forms[0].txt_guanrantee_endDate.disabled=false;
			//document.froms[0].txt_GF_Amount.disabled=false;
			//document.forms[0].txt_TX_Amount.disabled=false;
		}
	}
	else
	{
		document.forms[0].txt_txnID.disabled=true;
		document.forms[0].txt_txnDate.disabled=true;
		document.forms[0].txt_txnAmount.disabled=true;
		document.forms[0].sel_applStatus.disabled=true;
		document.forms[0].txt_appl_refno.disabled=true;
		document.forms[0].txt_applDate.disabled=true;
		document.forms[0].txt_CG_panno.disabled=true;
		document.forms[0].txt_approvalDate.disabled=true;
		document.forms[0].txt_rej_remarks.disabled=true;
		document.forms[0].txt_payment_ackwno.disabled=true;
		document.forms[0].txt_guanrantee_startDate.disabled=true;
		document.forms[0].txt_guanrantee_endDate.disabled=true;
		document.forms[0].txt_GF_Amount.disabled=true;
		document.forms[0].txt_TX_Amount.disabled=true;
		document.forms[0].txt_IGST_Rate.disabled=true;
		document.forms[0].txt_IGST_Amount.disabled=true;
		document.forms[0].txt_CGST_Rate.disabled=true;
		document.forms[0].txt_CGST_Amount.disabled=true;
		document.forms[0].txt_SGST_Rate.disabled=true;
		document.forms[0].txt_SGST_Amount.disabled=true;

		document.forms[0].txt_CrdtFundBased.disabled=false;
		document.forms[0].txt_CrdtNonFundBased.disabled=false;
		document.forms[0].OutsdFundBased.disabled=false;
		document.forms[0].OFBDt.disabled=false;
		document.forms[0].OutsdNonFundBased.disabled=false;
		document.forms[0].ONFBdT.disabled=false;
	}

	document.all.dt1_t.style.display="inline";
	document.all.dt2_t.style.display="inline";
	document.all.dt3_t.style.display="inline";
	document.all.dt4_t.style.display="inline";
	document.all.dt1_o.style.display="inline";
	document.all.dt2_o.style.display="inline";

	if(facilityNature=="1")
	{
		document.all.crdt.style.display="table-row";
		document.all.WcClass.style.display="table-row";
		document.all.TermLoanDet.style.display="none";

		if(varComfactype=="F")
		{
			document.all.idFundAmt1.style.display="table-cell";
			document.all.idFund1.style.display="table-cell";
			document.all.idNFundAmt1.style.display="none";
			document.all.idNFund1.style.display="none";
		}
		else
		{
			document.all.idFundAmt1.style.display="none";
			document.all.idFund1.style.display="none";
			document.all.idNFundAmt1.style.display="table-cell";
			document.all.idNFund1.style.display="table-cell";
		}
	}
	else if(facilityNature=="2")
	{
		document.all.TermLoanDet.style.display="table-row";

		document.all.WcClass.style.visibility="hidden";
		document.all.WcClass.style.position="absolute";
		document.all.crdt.style.visibility="hidden";
		document.all.crdt.style.position="absolute";
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function enableButtons(bool1,bool2,bool3,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
		document.forms[0].action=appURL+"action/app_CGTMSE_txnDet.jsp";
		document.forms[0].submit();
	}	
}

function changeApplStatus(flag)
{
	var applstatus=document.forms[0].sel_applStatus.value;

	if(flag=="Y")
	{
		app_status_val=applstatus;
	}

	document.all.id_applDate.style.display="none";
	document.all.id_approvalDate.style.display="none";
	document.all.id_guanrantee_startDate.style.display="none";
	document.all.id_guanrantee_endDate.style.display="none";
	document.all.id_GF_TaxableAmt.style.display="none";
	 document.all.id_IGST_Rate_Amount.style.display="none";
	 document.all.id_CGST_Amount.style.display="none";
	 document.all.id_SGST_Amount.style.display="none";
	if(app_status_val=='P')
	{	
		if(applstatus=="C"){
		 alert("you cannot Covered before Approve/Rejection");
			document.forms[0].sel_applStatus.value=app_status_val;
			changeApplStatus("Y");
			return;
		 }
		 if(applstatus=="P"){
		 document.all.id_applApplied.style.display="table-row";
		 document.all.id_applapproval.style.display="none";
		 document.all.id_applRejected.style.display="none";
		 document.all.id_applCovered1.style.display="none";
		 document.all.id_applCovered2.style.display="none";
		 document.all.id_applDate.style.display="inline";
		 document.all.id_GF_TaxableAmt.style.display="none";
		 document.all.id_IGST_Rate_Amount.style.display="none";
		 document.all.id_CGST_Amount.style.display="none";
		 document.all.id_SGST_Amount.style.display="none";
		 if(flag=="Y")
		 {
			 document.forms[0].txt_CG_panno.value="";
			 document.forms[0].txt_approvalDate.value="";
			 document.forms[0].txt_rej_remarks.value="";
			 document.forms[0].txt_payment_ackwno.value="";
			 document.forms[0].txt_guanrantee_startDate.value="";
			 document.forms[0].txt_guanrantee_endDate.value="";
		 	}
		}
			if(applstatus=='A'){
				 document.all.id_applApplied.style.display="table-row";
				 document.all.id_applapproval.style.display="table-row";
				 document.all.id_applRejected.style.display="none";
				 document.all.id_applCovered1.style.display="none";
				 document.all.id_applCovered2.style.display="none";
				 document.all.id_applDate.style.display="inline";
				 document.all.id_approvalDate.style.display="inline";
				 document.all.id_GF_TaxableAmt.style.display="none";
				 document.all.id_IGST_Rate_Amount.style.display="none";
				 document.all.id_CGST_Amount.style.display="none";
				 document.all.id_SGST_Amount.style.display="none";
				 if(flag=="Y")
				 {
					 document.forms[0].txt_rej_remarks.value="";
					 document.forms[0].txt_payment_ackwno.value="";
					 document.forms[0].txt_guanrantee_startDate.value="";
					 document.forms[0].txt_guanrantee_endDate.value="";
				 }
			}
		if(applstatus=='R'){
			
			document.all.id_applApplied.style.display="table-row";
			 document.all.id_applRejected.style.display="table-row";
			 document.all.id_applapproval.style.display="none";
			 document.all.id_applCovered1.style.display="none";
			 document.all.id_applCovered2.style.display="none";
			 document.all.id_applDate.style.display="inline";
			 document.all.id_GF_TaxableAmt.style.display="none";
			 document.all.id_IGST_Rate_Amount.style.display="none";
			 document.all.id_CGST_Amount.style.display="none";
			 document.all.id_SGST_Amount.style.display="none";
			 if(flag=="Y")
			 {
				 document.forms[0].txt_CG_panno.value="";
				 document.forms[0].txt_approvalDate.value="";
				 document.forms[0].txt_payment_ackwno.value="";
				 document.forms[0].txt_guanrantee_startDate.value="";
				 document.forms[0].txt_guanrantee_endDate.value="";
			 }
			}
		if(applstatus=='S')
		{
			 document.all.id_applApplied.style.display="none";
			 document.all.id_applapproval.style.display="none";
			 document.all.id_applRejected.style.display="none";
			 document.all.id_applCovered1.style.display="none";
			 document.all.id_applCovered2.style.display="none";
			 document.all.id_GF_TaxableAmt.style.display="none";
			 document.all.id_IGST_Rate_Amount.style.display="none";
			 document.all.id_CGST_Amount.style.display="none";
			 document.all.id_SGST_Amount.style.display="none";
			 if(flag=="Y")
			 {
				 document.forms[0].txt_applDate.value="";
				 document.forms[0].txt_appl_refno.value="";
				 document.forms[0].txt_CG_panno.value="";
				 document.forms[0].txt_approvalDate.value="";
				 document.forms[0].txt_rej_remarks.value="";
				 document.forms[0].txt_payment_ackwno.value="";
				 document.forms[0].txt_guanrantee_startDate.value="";
				 document.forms[0].txt_guanrantee_endDate.value="";
			 }
		}
	}
	else if(app_status_val=='A')
	{	
		if(applstatus=="R"||applstatus=="P"){
			 alert("you cannot Apply/Reject after Approval");
				document.forms[0].sel_applStatus.value=app_status_val;
				changeApplStatus("Y");
				return;
			 }
		 if(applstatus=="A"){
			 
		 document.all.id_applApplied.style.display="table-row";
		 document.all.id_applapproval.style.display="table-row";
		 document.all.id_applRejected.style.display="none";
		 document.all.id_applCovered1.style.display="none";
		 document.all.id_applCovered2.style.display="none";
		 document.all.id_applDate.style.display="inline";
		 document.all.id_approvalDate.style.display="inline";
		 if(flag=="Y")
		 {
			 document.forms[0].txt_rej_remarks.value="";
			 document.forms[0].txt_payment_ackwno.value="";
			 document.forms[0].txt_guanrantee_startDate.value="";
			 document.forms[0].txt_guanrantee_endDate.value="";
		 }
		 }
		 if(applstatus=='C'){
			 document.all.id_applApplied.style.display="table-row";
			 document.all.id_applapproval.style.display="table-row";
			 document.all.id_applCovered1.style.display="table-row";
			 document.all.id_applCovered2.style.display="table-row";
			 document.all.id_applRejected.style.display="none";
			 document.all.id_guanrantee_startDate.style.display="inline";
			 document.all.id_guanrantee_endDate.style.display="inline";
			 document.all.id_applDate.style.display="inline";
			 document.all.id_approvalDate.style.display="inline";
			 document.all.id_GF_TaxableAmt.style.display="table-row";
			 document.all.id_IGST_Rate_Amount.style.display="table-row";
			 document.all.id_CGST_Amount.style.display="table-row";
			 document.all.id_SGST_Amount.style.display="table-row";
			 if(flag=="Y")
			 {
				 document.forms[0].txt_rej_remarks.value="";
			 }
		 }
		 if(applstatus=='S')
			{
				 document.all.id_applApplied.style.display="none";
				 document.all.id_applapproval.style.display="none";
				 document.all.id_applRejected.style.display="none";
				 document.all.id_applCovered1.style.display="none";
				 document.all.id_applCovered2.style.display="none";
				 document.all.id_GF_TaxableAmt.style.display="none";
				 document.all.id_IGST_Rate_Amount.style.display="none";
				 document.all.id_CGST_Amount.style.display="none";
				 document.all.id_SGST_Amount.style.display="none";
				 if(flag=="Y")
				 {
					 document.forms[0].txt_applDate.value="";
					 document.forms[0].txt_appl_refno.value="";
					 document.forms[0].txt_CG_panno.value="";
					 document.forms[0].txt_approvalDate.value="";
					 document.forms[0].txt_rej_remarks.value="";
					 document.forms[0].txt_payment_ackwno.value="";
					 document.forms[0].txt_guanrantee_startDate.value="";
					 document.forms[0].txt_guanrantee_endDate.value="";
				 }
			}
	}
	else if(app_status_val=='R')
	{	
		if(applstatus=="A"||applstatus=="P"){
		 alert("you cannot Apply/Approve after Rejection");
			document.forms[0].sel_applStatus.value=app_status_val;
			changeApplStatus("Y");
			return;
		 }
		if(applstatus=="R"){
		 document.all.id_applApplied.style.display="table-row";
		 document.all.id_applRejected.style.display="table-row";
		 document.all.id_applapproval.style.display="none";
		 document.all.id_applCovered1.style.display="none";
		 document.all.id_applCovered2.style.display="none";
		 document.all.id_applDate.style.display="inline";
		 document.all.id_GF_TaxableAmt.style.display="none";
		 document.all.id_IGST_Rate_Amount.style.display="none";
		 document.all.id_CGST_Amount.style.display="none";
		 document.all.id_SGST_Amount.style.display="none";
		 
		 if(flag=="Y")
		 {
			 document.forms[0].txt_CG_panno.value="";
			 document.forms[0].txt_approvalDate.value="";
			 document.forms[0].txt_payment_ackwno.value="";
			 document.forms[0].txt_guanrantee_startDate.value="";
			 document.forms[0].txt_guanrantee_endDate.value="";
		 }
		}
		if(applstatus=="C"){
			 document.all.id_applApplied.style.display="table-row";
			 document.all.id_applapproval.style.display="table-row";
			 document.all.id_applCovered1.style.display="table-row";
			 document.all.id_applCovered2.style.display="table-row";
			 document.all.id_applRejected.style.display="none";
			 document.all.id_guanrantee_startDate.style.display="inline";
			 document.all.id_guanrantee_endDate.style.display="inline";
			 document.all.id_applDate.style.display="inline";
			 document.all.id_approvalDate.style.display="inline";
			 document.all.id_GF_TaxableAmt.style.display="table-row";
			 document.all.id_IGST_Rate_Amount.style.display="table-row";
			 document.all.id_CGST_Amount.style.display="table-row";
			 document.all.id_SGST_Amount.style.display="table-row";
			 if(flag=="Y")
			 {
				 document.forms[0].txt_rej_remarks.value="";
			 }
		}
		if(applstatus=='S')
		{
			 document.all.id_applApplied.style.display="none";
			 document.all.id_applapproval.style.display="none";
			 document.all.id_applRejected.style.display="none";
			 document.all.id_applCovered1.style.display="none";
			 document.all.id_applCovered2.style.display="none";
			 document.all.id_GF_TaxableAmt.style.display="none";
			 document.all.id_IGST_Rate_Amount.style.display="none";
			 document.all.id_CGST_Amount.style.display="none";
			 documnet.all.id_SGST_Amount.style.display="none";
			 if(flag=="Y")
			 {
				 document.forms[0].txt_applDate.value="";
				 document.forms[0].txt_appl_refno.value="";
				 document.forms[0].txt_CG_panno.value="";
				 document.forms[0].txt_approvalDate.value="";
				 document.forms[0].txt_rej_remarks.value="";
				 document.forms[0].txt_payment_ackwno.value="";
				 document.forms[0].txt_guanrantee_startDate.value="";
				 document.forms[0].txt_guanrantee_endDate.value="";
			 }
		}
	}
	else if(app_status_val=='C')
	{	
		if(applstatus=="P"||applstatus=="A"||applstatus=="R"){
			 alert("you cannot Approve/Rejection/Apply");
				document.forms[0].sel_applStatus.value=app_status_val;
				changeApplStatus("Y");
				return;
		 }
		if(applstatus=='S')
		{
			 document.all.id_applApplied.style.display="none";
			 document.all.id_applapproval.style.display="none";
			 document.all.id_applRejected.style.display="none";
			 document.all.id_applCovered1.style.display="none";
			 document.all.id_applCovered2.style.display="none";
			 document.all.id_GF_TaxableAmt.style.display="none";
			 document.all.id_IGST_Rate_Amount.style.display="none";
			 document.all.id_CGST_Amount.style.display="none";
			 document.all.id_SGST_Amount.style.display="none";
			 if(flag=="Y")
			 {
				 document.forms[0].txt_applDate.value="";
				 document.forms[0].txt_appl_refno.value="";
				 document.forms[0].txt_CG_panno.value="";
				 document.forms[0].txt_approvalDate.value="";
				 document.forms[0].txt_rej_remarks.value="";
				 document.forms[0].txt_payment_ackwno.value="";
				 document.forms[0].txt_guanrantee_startDate.value="";
				 document.forms[0].txt_guanrantee_endDate.value="";
			 }
		}
		 document.all.id_applApplied.style.display="table-row";
		 document.all.id_applapproval.style.display="table-row";
		 document.all.id_applCovered1.style.display="table-row";
		 document.all.id_applCovered2.style.display="table-row";
		 document.all.id_applRejected.style.display="none";
		 document.all.id_guanrantee_startDate.style.display="inline";
		 document.all.id_guanrantee_endDate.style.display="inline";
		 document.all.id_applDate.style.display="inline";
		 document.all.id_approvalDate.style.display="inline";
		 document.all.id_GF_TaxableAmt.style.display="table-row";
		 document.all.id_IGST_Rate_Amount.style.display="table-row";
		 document.all.id_CGST_Amount.style.display="table-row";
		 document.all.id_SGST_Amount.style.display="table-row";
		 if(flag=="Y")
		 {
			 document.forms[0].txt_rej_remarks.value="";
		 }
	}
	/*if(applstatus=="C"){
		document.forms[0].txt_GF_Amount.readOnly=true;
		
		document.forms[0].txt_GF_Amount.disabled=true;
		
	}*/
}

function callonLoad()
{
	//alert("facilityNature"+facilityNature);
	disableFields(true);
	/*if(usr_department=="008"){
	enableButtons(false,true,true,false);
	}
	else*/
	{
		enableButtons(false,true,true,false);
	}
	if(document.forms[0].sel_facility.value=="0")
	{
		document.getElementById("TermLoanDet").style.display="none";
		document.getElementById("TermLoanDet1").style.display="none";
		document.getElementById("crdt").style.display="none";
		document.getElementById("WcClass").style.display="none";
	}
	if(strCatType=="RET")
	{
		document.getElementById("TermLoanDet").style.display="table-row";
	}


	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
		if(strPrdType!="pG"  && strPrdType!="pR")
		{
			document.all.idloanaccount.style.visibility="visible";
			document.all.idloanaccount.style.position="relative";
			document.all.idrestr.style.visibility="visible";
			document.all.idrestr.style.position="relative";
		}
		else
		{
			document.all.idloanaccount.style.visibility="hidden";
			document.all.idloanaccount.style.position="absolute";
			document.all.idrestr.style.visibility="hidden";
			document.all.idrestr.style.position="absolute";
				
		}
		if(varloantype.toUpperCase()=="C" || varloantype.toUpperCase()=="A")
		{	
			document.all.idfacdetail.style.visibility="visible";
			document.all.idfacdetail.style.position="relative";
		}
	}
	else
	{
		document.all.idloanaccount.style.visibility="hidden";
		document.all.idloanaccount.style.position="absolute";
		document.all.idrestr.style.visibility="hidden";
		document.all.idrestr.style.position="absolute";
		

		if(varloantype.toUpperCase()=="C" || varloantype.toUpperCase()=="A")
		{
			document.all.idfacdetail.style.visibility="hidden";
			document.all.idfacdetail.style.position="absolute";
		}
	}
	
	document.all.id_applApplied.style.display="none";
	document.all.id_applapproval.style.display="none";
	document.all.id_applRejected.style.display="none";
	document.all.id_applCovered1.style.display="none";
	document.all.id_applCovered2.style.display="none";
	 document.all.id_GF_TaxableAmt.style.display="none";
	 document.all.id_IGST_Rate_Amount.style.display="none";
	 document.all.id_CGST_Amount.style.display="none";
	 document.all.id_SGST_Amount.style.display="none";

	
	if(applstatus!="")
	{
		document.forms[0].sel_applStatus.value=applstatus;
	}
	else
	{
		document.forms[0].sel_applStatus.value="S";
	}
	changeApplStatus('N');

	if(strSessionModuleType=="CORP" || strSessionModuleType=="AGR")
	{
		document.forms[0].sel_facility.disabled=false;
		
		if(facilitySNO!="" && facilitySNO!="0" )
		{
			
			document.forms[0].sel_facility.value=facilitySNO;
			if(usr_department=="008"){
			document.forms[0].cmdedit.disabled=false;
		}
		}
		else
		{
			document.forms[0].sel_facility.value="0";
			document.forms[0].cmdedit.disabled=true;
		}
		if(document.forms[0].sel_facility.value!="0")
		{
			if(FACILITY_WHT_CGTMSEAPPLY!="Y")
			{
				alert("The selected Facility is not a CGTMSE Facility");
				document.forms[0].sel_facility.value="0";
			}
		}
	}
	
	if(facilityNature=="1")
	{
		document.all.TermLoanDet1.style.display="table-row";
		document.all.crdt.style.display="table-row";
		document.all.WcClass.style.display="table-row";
		document.all.TermLoanDet.style.display="none";

		if(varComfactype=="F")
		{
			document.all.idFundAmt1.style.display="table-cell";
			document.all.idFund1.style.display="table-cell";
			document.all.idNFundAmt1.style.display="none";
			document.all.idNFund1.style.display="none";
		}
		else
		{
			document.all.idFundAmt1.style.display="none";
			document.all.idFund1.style.display="none";
			document.all.idNFundAmt1.style.display="table-cell";
			document.all.idNFund1.style.display="table-cell";
		}
	}
	if(facilityNature=="2")
	{
		document.all.TermLoanDet.style.display="table-row";

		document.all.WcClass.style.visibility="hidden";
		document.all.WcClass.style.position="absolute";
		document.all.crdt.style.visibility="hidden";
		document.all.crdt.style.position="absolute";
	}


	
	
}

function doSave()
{	
	var varIGSTAmount=0.0;
	var varCGSTAmount=0.0;
	var varSGSTAmount=0.0;
	var totalval=0.0;
	if(usr_department=="008")
	{
		if(document.forms[0].txt_txnID.value=="")
		{
		  ShowAlert('121',"Transaction ID");
		  document.forms[0].txt_txnID.focus();
		  return false;
		}
		if(document.forms[0].txt_txnDate.value=="")
		{
		  ShowAlert('121',"Transaction Date");
		  document.forms[0].txt_txnDate.focus();
		  return false;
		}
		if(document.forms[0].txt_txnAmount.value=="")
		{
		  ShowAlert('121',"Transaction Amount");
		  document.forms[0].txt_txnAmount.focus();
		  return false;
		}
	}

	
	if(document.forms[0].sel_applStatus.value=="P")
	{
		if(document.forms[0].txt_appl_refno.value=="")
		{
		  ShowAlert('121',"Application Ref No");
		  document.forms[0].txt_appl_refno.focus();
		  return false;
		}
		if(document.forms[0].txt_applDate.value=="")
		{
		  ShowAlert('121',"Application Date");
		  document.forms[0].txt_applDate.focus();
		  return false;
		}
	}
	else if(document.forms[0].sel_applStatus.value=="A")
	{
		if(document.forms[0].txt_appl_refno.value=="")
		{
		  ShowAlert('121',"Application Ref No");
		  document.forms[0].txt_appl_refno.focus();
		  return false;
		}
		if(document.forms[0].txt_applDate.value=="")
		{
		  ShowAlert('121',"Application Date");
		  document.forms[0].txt_applDate.focus();
		  return false;
		}
		if(document.forms[0].txt_CG_panno.value=="")
		{
		  ShowAlert('121',"CG PAN No");
		  document.forms[0].txt_CG_panno.focus();
		  return false;
		}
		if(document.forms[0].txt_approvalDate.value=="")
		{
		  ShowAlert('121',"Approval Date");
		  document.forms[0].txt_approvalDate.focus();
		  return false;
		}
	}
	else if(document.forms[0].sel_applStatus.value=="R")
	{
		if(document.forms[0].txt_appl_refno.value=="")
		{
		  ShowAlert('121',"Application Ref No");
		  document.forms[0].txt_appl_refno.focus();
		  return false;
		}
		if(document.forms[0].txt_applDate.value=="")
		{
		  ShowAlert('121',"Application Date");
		  document.forms[0].txt_applDate.focus();
		  return false;
		}
		if(document.forms[0].txt_rej_remarks.value=="")
		{
		  ShowAlert('121',"Rejection Remarks");
		  document.forms[0].txt_rej_remarks.focus();
		  return false;
		}
	}
	else if(document.forms[0].sel_applStatus.value=="R")
	{
		if(document.forms[0].txt_appl_refno.value=="")
		{
		  ShowAlert('121',"Application Ref No");
		  document.forms[0].txt_appl_refno.focus();
		  return false;
		}
		if(document.forms[0].txt_applDate.value=="")
		{
		  ShowAlert('121',"Application Date");
		  document.forms[0].txt_applDate.focus();
		  return false;
		}
		if(document.forms[0].txt_rej_remarks.value=="")
		{
		  ShowAlert('121',"Rejection Remarks");
		  document.forms[0].txt_rej_remarks.focus();
		  return false;
		}
	}
	else if(document.forms[0].sel_applStatus.value=="C")
	{
		if(document.forms[0].txt_appl_refno.value=="")
		{
		  ShowAlert('121',"Application Ref No");
		  document.forms[0].txt_appl_refno.focus();
		  return false;
		}
		if(document.forms[0].txt_applDate.value=="")
		{
		  ShowAlert('121',"Application Date");
		  document.forms[0].txt_applDate.focus();
		  return false;
		}
		if(document.forms[0].txt_payment_ackwno.value=="")
		{
		  ShowAlert('121',"Payment ackw no");
		  document.forms[0].txt_payment_ackwno.focus();
		  return false;
		}
		if(document.forms[0].txt_guanrantee_startDate.value=="")
		{
		  ShowAlert('121',"Guarantee Start Date");
		  document.forms[0].txt_guanrantee_startDate.focus();
		  return false;
		}
		if(document.forms[0].txt_guanrantee_endDate.value=="")
		{
		  ShowAlert('121',"Guarantee End Date");
		  document.forms[0].txt_guanrantee_endDate.focus();
		  return false;
		}

		if(document.forms[0].txt_GF_Amount.value=="" || document.forms[0].txt_GF_Amount.value=="0.00")
		{
			ShowAlert('121',"Guarantee Fee Amount");
			document.forms[0].txt_GF_Amount.focus();
			return false;
		}
		if(document.forms[0].txt_TX_Amount.value=="" || document.forms[0].txt_TX_Amount.value=="0.00")
		{
			ShowAlert('121',"Taxable Amount");
			document.forms[0].txt_TX_Amount.focus();
			return false;
		}
		
		if (document.forms[0].txt_IGST_Amount.value!="")
		{
			varIGSTAmount =parseFloat(NanNumber(document.forms[0].txt_IGST_Amount.value));
		}
		else
		 {
			varIGSTAmount = 0.0;
		 }
		if (document.forms[0].txt_CGST_Amount.value!="")
		{
			varCGSTAmount = parseFloat(NanNumber(document.forms[0].txt_CGST_Amount.value));
		}
		else
		 {
			varCGSTAmount = 0.0;
		 }
		if (document.forms[0].txt_SGST_Amount.value!="")
		{
			varSGSTAmount = parseFloat(NanNumber(document.forms[0].txt_SGST_Amount.value));
		}
		else
		 {
			varSGSTAmount = 0.0;
		 }
		totalval=eval(varIGSTAmount)+ eval(varCGSTAmount)+eval(varSGSTAmount);
	    var taxbleAmount=eval(document.forms[0].txt_TX_Amount.value);
	    totalval=eval(totalval);
	    //alert(taxbleAmount+"taxbleAmount");
	    //alert(totalval+"totalval");
	    
		if(taxbleAmount!=totalval){
			alert("Taxble amount shouble be tally with CGST, IGST, SGST amount");
			//document.forms[0].txt_IGST_Amount.value="0.00";
			//document.forms[0].txt_CGST_Amount.value="0.00";
			//document.forms[0].txt_SGST_Amount.value="0.00";
			return false;
		}
	}
	
	disableFields(false);
	document.forms[0].txt_txnID.disabled = false;
	document.forms[0].txt_txnDate.disabled = false;
	document.forms[0].txt_txnAmount.disabled = false;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value=Actiontype;
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateCGTMSE_txndet";
	document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/app_CGTMSE_txnDet.jsp";
	document.forms[0].submit();

	
}


function changeFacility()
{


		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
		document.forms[0].action=appURL+"action/app_CGTMSE_txnDet.jsp";
		document.forms[0].submit();

		
}

function callCalender1(name)
{	
		showCal(appURL,name);
}
function callLoanAccount()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getLoanAccountData";
	document.forms[0].action=appURL+"action/apploanaccount.jsp";
	document.forms[0].submit();
}
function callFacDetail()
{
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="getFacilityDetailsData";
	document.forms[0].action=appURL+"action/appfacilitydetails.jsp";
	document.forms[0].submit();
}
function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("application date should not be lesser than sanction date.");
			document.forms[0].txt_approvalDate.value="";
			document.forms[0].txt_approvalDate.focus();								
		}			
	}
}
function checkAmount()
{   
var varSanAmount="<%=Helper.correctDouble((String) hshValues.get("strloan_recmdamt"))%>";
var varSanBorrowerAmt="<%=Helper.correctDouble((String) hshValues.get("strparamAmount"))%>";
var varCreditAmount="";
if(facilityNature=="1")
{
	if(varComfactype=="F")
	{
		varCreditAmount = document.forms[0].txt_CrdtFundBased.value;
	}
	else
	{
		varCreditAmount = document.forms[0].txt_CrdtNonFundBased.value;
	}
}
 if(facilityNature=="2")
{
	 varCreditAmount = document.forms[0].txt_CrdtAmt.value;

}
if(eval(varSanBorrowerAmt)< eval(varCreditAmount))
{
	if(facilityNature=="1")
	{
		if(varComfactype=="F")
		{
		alert("Amount should not be greater than the Maximum Borrower CGTMSE limit: Rs."+varSanBorrowerAmt);
		document.forms[0].txt_CrdtFundBased.value="";
		document.forms[0].txt_CrdtFundBased.focus();
		return;
		}
		else
		{
			alert("Amount should not be greater than Maximum Borrower CGTMSE limit: Rs."+varSanBorrowerAmt);
			document.forms[0].txt_CrdtNonFundBased.value="";
			document.forms[0].txt_CrdtNonFundBased.focus();
			return;
		}
	}
	if(facilityNature=="2")
	{
		alert("Amount should not be greater than Maximum Borrower CGTMSE limit: Rs."+varSanBorrowerAmt);
		document.forms[0].txt_CrdtAmt.value="";
		document.forms[0].txt_CrdtAmt.focus();
		return;
	}

}

}
function checkAmount1()
{   
var varSanAmount="<%=Helper.correctDouble((String) hshValues.get("strloan_recmdamt"))%>";
if(facilityNature=="2")
{
	if(eval(varSanAmount)< eval(document.forms[0].txt_AmtDisbursment.value))
	{
			alert("Amount should not be greater than the Sanction limit: Rs."+varSanAmount);
			document.forms[0].txt_AmtDisbursment.value="";
			document.forms[0].txt_AmtDisbursment.focus();
			return;
	}
}
else
	{
	if(eval(varSanAmount)< eval(document.forms[0].txt_AmtDisbursmentwc.value))
	{
			alert("Amount should not be greater than the Sanction limit: Rs."+varSanAmount);
			document.forms[0].txt_AmtDisbursmentwc.value="";
			document.forms[0].txt_AmtDisbursmentwc.focus();
			return;
	}
	}
}

function gstCalc(fieldvar)
{
	var fieldName=fieldvar.name;
	var guaranteeFeeAmount=document.forms[0].txt_GF_Amount.value;
	if(guaranteeFeeAmount=="" || guaranteeFeeAmount=="0.00")
	{
		ShowAlert('121',"Guarantee Fee Amount");
		document.forms[0].txt_GF_Amount.focus();
		return false;
	}

	if(fieldName=="txt_GF_Amount")
	{

		document.forms[0].txt_IGST_Amount.value="0";
		document.forms[0].txt_CGST_Amount.value="0";
		document.forms[0].txt_SGST_Amount.value="0";
		document.forms[0].txt_IGST_Rate.value="0";
		document.forms[0].txt_CGST_Rate.value="0";
		document.forms[0].txt_SGST_Rate.value="0";
	}
	
	if(fieldName=="txt_IGST_Rate")
	{
		var igstrate=fieldvar.value;
		document.forms[0].txt_IGST_Amount.value=eval(guaranteeFeeAmount)*eval(igstrate)/100;
		roundtxt(document.forms[0].txt_IGST_Amount);
	}
	else if(fieldName=="txt_CGST_Rate")
	{
		var cgstrate=fieldvar.value;
		document.forms[0].txt_CGST_Amount.value=eval(guaranteeFeeAmount)*eval(cgstrate)/100;
		roundtxt(document.forms[0].txt_CGST_Amount);
	}
	else if(fieldName=="txt_SGST_Rate")
	{
		var sgstrate=fieldvar.value;
		document.forms[0].txt_SGST_Amount.value=eval(guaranteeFeeAmount)*eval(sgstrate)/100;
		roundtxt(document.forms[0].txt_SGST_Amount);
	}
	
}
function checkfirstdate()
{   
	
	if(eval(varPROCESSDATE)<eval(document.forms[0].DtFstDisbursment.value))
		
	{
			
			document.forms[0].DtFstDisbursment.value="";
			document.forms[0].DtFstDisbursment.focus();
			return;
	}

}

</script>
</head>
<body onload="callonLoad();">					
<form name="frmworkflow" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
  <tr> 
    <td> 
    <%if(loan_type.equalsIgnoreCase("P")){ %>
      	<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
      	<jsp:param name="pageid" value="7" />
      	</jsp:include>
    <%}else if(loan_type.equalsIgnoreCase("E") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("H")  || loan_type.equalsIgnoreCase("T")){%>
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="15" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		<span style="display:none;"><lapschoice:borrowertype /></span>
			<%}else if(loan_type.equalsIgnoreCase("C")  || loan_type.equalsIgnoreCase("A")){%>
      	<jsp:include page="../com/proposallinks.jsp" flush="true"> 
      	<jsp:param name="pageid" value="7" />
      	<jsp:param name="cattype" value="<%=strCategoryType%>" />
      	<jsp:param name="ssitype" value="<%=strSSIType%>" />
      	</jsp:include>
      	<span style="display:none;"><lapschoice:borrowertype /></span> 
	<%}%>
      </td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		 <td class="page_flow"> Home -&gt; Agriculture -&gt; Proposal -&gt; WorkFlow -&gt; CGTMSE Transaction Details</td>
	</tr>
	<%}else if(strCategoryType.equalsIgnoreCase("SRE")){%>
	<tr>
		
      <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension 
        -&gt; WorkFlow -&gt; CGTMSE Transaction Details</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("STL")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Term Loan 
        -&gt; WorkFlow -&gt; CGTMSE Transaction Details</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("ADC")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad hoc Limit -&gt; WorkFlow 
        -&gt; CGTMSE Transaction Details</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("OPS")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; WorkFlow 
        -&gt; CGTMSE Transaction Details</td>
	</tr>
	<%}
	else if(strCategoryType.equals("LAD"))
    {
    %> 
    <tr>
    <td class="page_flow"> Home -&gt; Loan Against Gold Ornaments &amp; Deposits -&gt; WorkFlow -&gt; CGTMSE Transaction Details</td></tr>
    <%}else if (strCategoryType.equalsIgnoreCase("AGR")){ %>
	<tr>
		
      <td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; WorkFlow 
        -&gt; CGTMSE Transaction Details</td>
	</tr>   
	<%} else if (strCategoryType.equalsIgnoreCase("RET")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Retail  -&gt;Application -&gt; WorkFlow -&gt;
		CGTMSE Transaction Details</td>
	</tr> 
    <%}else{%>
 	<tr>
      <td class="page_flow"> Home -&gt; Corporate &amp;SME -&gt; Proposal -&gt; WorkFlow -&gt; CGTMSE Transaction Details</td>
    </tr>
 	<%}%> 
</table>
<lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="bottom">
			<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="80%">
				<tr align="center">
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('history')">History</a></td>					
					<!-- <td class="sub_tab_inactive"><a href="javascript:callOtherTab('comments')">Comments</a></td> -->
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('Queries')">Queries</a></td>
					 <%if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A") || loan_type.equalsIgnoreCase("T") || loan_type.equalsIgnoreCase("H") || loan_type.equalsIgnoreCase("U") || loan_type.equalsIgnoreCase("E"))
			        { %>
					  <td id="action" class="sub_tab_inactive" nowrap="nowrap"><a href="#" onclick="javascript:callOtherTab('sanction')">Proposed facility Approve/Reject</a></td>
					  <%}%>
					<td id="action" class="sub_tab_inactive"><a href="#" onclick="javascript:callOtherTab('action')">Action</a></td>
					<td class="sub_tab_active">CGTMSE Transaction Details</td>
					<%if(!Helper.correctNull((String)hshValues.get("strLoanType")).equalsIgnoreCase("OD")){ %>
						<td class="sub_tab_inactive"><a href="javascript:callOtherTab('drawdownschedule')">Draw Down Schedule</a></td>
					<%} else { %>
					<td  id="idCGTMSEtxn"><input type="hidden"></td>
					<% }  %>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
					<%if (Helper.correctNull((String) hshValues.get("app_legalcomp")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive" nowrap="nowrap"><a href="#" onClick="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
					<%} %>	
					<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
					<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
					<%}else{ %>
					<td  style="display: none;"><input type="hidden" id="idrestr"></td>
					<%} %>
					<% if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {%>
					<td class="sub_tab_inactive" id="idfacdetail"  nowrap="nowrap"><a href="#" onClick="javascript:callFacDetail()">Facility Details</a></td> 			
					<% } %>	
				</tr>
			</table>
		</td>
	</tr>
</table>
<br> 

	<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable border1" align="center" >
						<%if(strSessionModuleType.equals("AGR")||strSessionModuleType.equals("CORP")){ %>
										<tr class="datagrid">
											<td align="center"> Select Facility &nbsp;&nbsp;
												<select name="sel_facility" onchange="changeFacility()">
													<option value="0" selected="selected">--Select--</option>
                									<lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>'  page='CGTMSE'/>
												</select>
											</td>
										</tr>
									<%} else {%>
									
										<input type="hidden" name="sel_facility" value="1">
									<% } %>
	</table>
	


<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable border1" align="center" >
  	
	<tr class="dataheader" align="center">
		<td colspan="2" >Transaction Details </td>
	</tr>
  	 <tr>
  		<td>
  			<table width="95%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center" >
			 	 <tr>  
			  		<td width="25%">Transaction ID </td>
			  		<td width="25%"><input type="text" name="txt_txnID" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_TXNID"))%>" maxlength="20" onkeypress="allowAlphaNumeric();"></td>
			  		<td> &nbsp; </td><td> &nbsp; </td>
			  		
			 	 </tr>
			  	<tr> 
			  		<td>Date  </td>
			  		<td><input type="text" name="txt_txnDate" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("TXNDET_TXNDATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('txt_txnDate')" id="id_txnDate"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> 
					</td>
					<td> &nbsp; </td><td> &nbsp; </td>
					
			  	</tr>
			  	<tr> 
			  		<td>Amount  </td>
			  		<td><input type="text" name="txt_txnAmount"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_TXNAMOUNT"))%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);" size="15" style="text-align:right" >   </td>
			  		<td> &nbsp; </td><td> &nbsp; </td>
			  		
			  	</tr>
			 	<tr>
			 	<td> &nbsp; </td><td> &nbsp; </td>
			 	<td> &nbsp; </td><td> &nbsp; </td>
			 	</tr>
			 	<tr> 
			  		<td><b>Application Status </b> </td>
			  		<td>
			  			<select name="sel_applStatus" onchange="changeApplStatus('Y')">
			  				<option value="S"> -- Select -- </option>
			  				<option value="P">Applied </option>
			  				<option value="A">Approved </option>
			  				<option value="R">Rejected </option>
			  				<option value="C">Covered </option>
			  			</select>
			  		</td>
			  		<td> &nbsp; </td><td> &nbsp; </td>
			  	</tr>
				 <tr id="id_applApplied"> 
			  		<td>Application Ref No  </td>
			  		<td><input type="text" name="txt_appl_refno" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_APPL_REFNO"))%>"  >   </td>
			  		<td>Application Date</td>
			  		<td><input type="text" name="txt_applDate" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("TXNDET_APPL_DATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('txt_applDate')" id="id_applDate"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> 
					</td>
			  	</tr>
			  	<tr id="id_applapproval">
			 	<td> CG PAN No </td><td><input type="text" name="txt_CG_panno"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_CGPAN_NO"))%>" onkeypress="allowAlphaNumeric();"></td>
			 	<td> Approval Date</td>
			 	<td><input type="text" name="txt_approvalDate" size="11" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_APPROVAL_DATE"))%>"
			onBlur="checkDate(this);comparedate(document.forms[0].txt_applDate.value,document.forms[0].txt_approvalDate.value)" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('txt_approvalDate')" id="id_approvalDate"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> 
							</td>
			 	</tr>
			  	
			  	<tr id="id_applRejected">
			 		<td>Rejection Remarks</td><td> <textarea rows="3" cols="30" name="txt_rej_remarks"  onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String)hshValues.get("TXNDET_REJECTION_REMARKS"))%> </textarea> </td>
			 		<td> &nbsp; </td><td> &nbsp; </td>
			 	</tr>
			  	
			  	<tr id="id_applCovered1">
			 		<td>Payment ackw no </td><td><input type="text" name="txt_payment_ackwno"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_PAYMENT_ACKNO"))%>" ></td>
			 		<td> &nbsp; </td><td> &nbsp; </td>
			 	</tr>
			 
			 	<tr id="id_applCovered2">
				 	<td>Guarantee Start Date</td>
				 	<td><input type="text" name="txt_guanrantee_startDate" size="11"
								value="<%=Helper.correctNull((String)hshValues.get("TXNDET_GUA_STARTDATE"))%>"
								onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
			    				<a alt="Select date from calender" 	onClick="callCalender('txt_guanrantee_startDate')"
								onMouseOver="window.status='Date Picker';return true;"  id="id_guanrantee_startDate"
								onMouseOut="window.status='';return true;"><img
								src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
								alt="Select date from calender" tabindex="29"></a> 
					</td>
				 	<td>Guarantee End Date</td>
				 	<td><input type="text" name="txt_guanrantee_endDate" size="11"
								value="<%=Helper.correctNull((String)hshValues.get("TXNDET_GUA_ENDDATE"))%>"
								onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_guanrantee_startDate.value);" maxlength="10" tabindex="15">
			    				<a alt="Select date from calender" 	onClick="callCalender('txt_guanrantee_endDate')"
								onMouseOver="window.status='Date Picker';return true;"  id="id_guanrantee_endDate"
								onMouseOut="window.status='';return true;"><img
								src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
								alt="Select date from calender" tabindex="29"></a> 
					</td>
			 	</tr>
			 	
			 	
<tr id="id_GF_TaxableAmt">
			 	<td>Guarantee Fee Amount</td>
			 	
			 	<td><input type="text" name="txt_GF_Amount"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_GUARANTEE_FEE_AMOUNT"))%>" onkeypress="allowAlphaNumeric();" onchange="gstCalc(this);" onBlur="roundtxt(this);"></td>
			 	<td>Taxable Amount</td>
			 	<td><input type="text" name="txt_TX_Amount"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_TAXABLE_AMOUNT"))%>" onkeypress="allowAlphaNumeric()" onBlur="roundtxt(this);"></td>
                </tr>
                 <tr id="id_IGST_Rate_Amount">	
                 <td>IGST Rate</td>
                 <td><input type="text" name="txt_IGST_Rate"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_IGST_RATE"))%>" onkeypress="allowDecimals(this)" onBlur="checkPercentage(this);gstCalc(this);"></td>
                 <td>IGST Amount</td>
                 <td><input type="text" name="txt_IGST_Amount"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_IGST_AMOUNT"))%>" disabled="disabled" ></td>
                 </tr>
                 <tr id="id_CGST_Amount">
                 <td>CGST Rate</td>
                 <td><input type="text" name="txt_CGST_Rate"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_CGST_RATE"))%>" onkeypress="allowDecimals(this)" onBlur="checkPercentage(this);gstCalc(this);"></td>
               <td>CGST Amount</td>
               <td><input type="text" name="txt_CGST_Amount"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_CGST_AMOUNT"))%>" disabled="disabled" ></td>
                 </tr>
                 <tr id="id_SGST_Amount">
                 <td>SGST Rate</td>
                 <td><input type="text" name="txt_SGST_Rate"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_SGST_RATE"))%>" onkeypress="allowDecimals(this);" onBlur="checkPercentage(this);gstCalc(this);"></td>
               <td>SGST Amount</td>
               <td><input type="text" name="txt_SGST_Amount"  value="<%=Helper.correctNull((String)hshValues.get("TXNDET_SGST_AMOUNT"))%>" disabled="disabled" ></td>
                 </tr>
			 	
			 	
			 	
			 	<tr id="TermLoanDet">
<td colspan="8">
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center;" >Term Loan Details</td>
		<td></td>
	</tr>

	<tr>
		<td width="60%">Credit amount to be Guaranteed</td>
		<td width="40%"><input type="text" name="txt_CrdtAmt" style="text-align: right;"  onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);checkAmount()" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_CRDT_AMT"))%>"></td>
	</tr>
	<tr>
		<td width="60%">Amount Disbursed</td>
		<td width="40%"><input type="text" style="text-align: right;"  name="txt_AmtDisbursment" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);checkAmount1();" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_AMT_DISBURSED"))%>"></td>
	</tr>
	<tr>
		<td width="60%">Outstanding Amount</td>
		<td width="40%"><input type="text" style="text-align: right;"  name="txt_OutsAmount" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTS_BAL_AMT"))%>"></td>
	</tr>
		<tr>
		<td width="60%">Date of Outstanding Amount</td>
		<td width="40%"><input type="text" name="DtOutsAmnt" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTS_BAL_DT"))%>"
			onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,varPROCESSDATE);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('DtOutsAmnt')" id="dt1_t"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
	</tr>
	<tr>
		<td width="60%">Date of First Installment Due</td>
		<td width="40%"><input type="text" name="DtFstInsDue" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_FST_INS_DUE_DT"))%>"
			onBlur="checkDate(this);checkmindate(this,document.forms[0].DtFstDisbursment.value);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('DtFstInsDue')" id="dt2_t"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
	</tr>
		
	
	<tr>
		<td width="60%">Date of first Disbursement if already made</td>
		<td width="40%"><input type="text" name="DtFstDisbursment" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_FST_DISB"))%>"
			onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,varPROCESSDATE);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('DtFstDisbursment')" id="dt3_t"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
	</tr>
	<tr>
		<td width="60%">Date of Last and Final Disbursement if already made</td>
		<td width="40%"><input type="text" name="DtLstDisbursment" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_LST_DISB"))%>"
			onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,document.forms[0].DtFstDisbursment.value);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('DtLstDisbursment')" id="dt4_t"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
	</tr>

</table>
</td>
</tr>

 <tr id="TermLoanDet1">
<td colspan="8">
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center;" >Working Capital Details</td>
		<td></td>
	</tr>

	
	<tr>
		<td width="60%"> Amount Disbursed</td>
		<td width="40%"><input type="text" style="text-align: right;"  name="txt_AmtDisbursmentwc" onKeyPress="allowDecimals(this);" onBlur="roundtxt(this);checkAmount1();" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_AMT_DISBURSEDWC"))%>"></td>
	</tr>

	<tr>
		<td width="60%">  Date of first Disbursement if already made</td>
		<td width="40%"><input type="text" name="DtFstDisbursmentwc" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_FST_DISBWC"))%>"
			onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,varPROCESSDATE);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('DtFstDisbursment')" id="dt3_t"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
	</tr>
	<tr>
		<td width="60%">  Date of Last and Final Disbursement if already made</td>
		<td width="40%"><input type="text" name="DtLstDisbursmentwc" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_DT_LST_DISBWC"))%>"
			onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,document.forms[0].DtFstDisbursment.value);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('DtLstDisbursment')" id="dt4_t"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
	</tr>

</table>
</td>
</tr> 
<!-- Table of Credit to be Guaranteed-->
<tr id="crdt">
<td colspan="8">
<table  width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center;" >Credits to be Guaranteed</td>
		<td></td>
	</tr>

	<tr id="idFundAmt1">
		<td width="60%">Fund Based</td>
		<td width="40%"><input type="text" name="txt_CrdtFundBased" style="text-align: right;" onBlur="roundtxt(this);checkAmount()" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_CRDT_FUNDBASED"))%>"></td>
	</tr>
	<tr id="idNFundAmt1">
		<td width="60%">Non-Fund Based</td>
		<td width="40%"><input type="text" name="txt_CrdtNonFundBased" style="text-align: right;" onBlur="roundtxt(this);checkAmount()" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_CRDT_NONFUNDBASED"))%>"></td>
	</tr>
</table>
</td>
</tr>
<!-- Outstanding Facility Table  -->
<tr id="WcClass">
<td colspan="8">
<table  width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center;">Outstanding Facilities</td>
		<td></td>
	</tr>

	<tr id="idFund1">
		<td width="60%">Outstanding Fund Based Facility</td>
		<td width="40%"><input type="text" name="OutsdFundBased" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTSTD_FUND"))%>">
		<label style="margin-left: 10px;">As On: </label><input type="text" name="OFBDt" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTFB_DT"))%>"
			onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('OFBDt')" id="dt1_o"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> 
		
		
		</td>
	</tr>
	<tr id="idNFund1">
		<td width="60%">Outstanding Non-Fund Based Facility</td>
		<td width="40%"><input type="text" name="OutsdNonFundBased" style="text-align: right;" onBlur="roundtxt(this);" onKeyPress="allowDecimals(this);" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTSTD_NONFUND"))%>">
		<label style="margin-left: 10px;">As On: </label><input type="text" name="ONFBdT" value="<%=Helper.correctNull((String)hshValues.get("TXNDET_OUTNFB_DT"))%>"
			onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender" 	onClick="callCalender('ONFBdT')" id="dt2_o"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> 
		
		
		
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



<lapschoice:combuttonnew btnnames="Edit_Save_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<INPUT TYPE="hidden" name="hidAppNo" VALUE="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
<INPUT TYPE="hidden" name="radLoan" value="Y">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="FACILITY_WHT_CGTMSEAPPLY" value="<%=Helper.correctNull((String)hshValues.get("FACILITY_WHT_CGTMSEAPPLY"))%>">

</form>
</body>
</html>