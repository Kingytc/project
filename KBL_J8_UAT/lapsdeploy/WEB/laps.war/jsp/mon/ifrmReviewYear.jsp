<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	

%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

var selInstallment="<%=Helper.correctNull((String)hshValues.get("installment"))%>";
var selInterest="<%=Helper.correctNull((String)hshValues.get("interest"))%>";
var selDocuments="<%=Helper.correctNull((String)hshValues.get("documents"))%>";
var strReviewYear="<%=Helper.correctNull((String)hshValues.get("strReviewYear"))%>";
var strreview_status="<%=Helper.correctNull((String)hshValues.get("review_status"))%>";

function loadValues()
{
	/*if(strreview_status=="pa")
	{
	parent.document.forms[0].cmdsend.disabled=true;
	parent.document.forms[0].cmdapprove.disabled=true;
	}*/
	if(selInstallment!="")
	parent.frames.document.forms[0].selInstallment.value = selInstallment;
	
	if(selInterest!="")
	parent.frames.document.forms[0].selInterest.value = selInterest;
	
	if(selDocuments!="")
	parent.frames.document.forms[0].selDocuments.value = selDocuments;
	
	if(strReviewYear!="")
	parent.frames.document.forms[0].reviewYear.value = strReviewYear;
	
	parent.frames.document.forms[0].txtNatureValSecurity.value = "<%=Helper.correctNull((String)hshValues.get("natureValSecurity"))%>";
	parent.frames.document.forms[0].txtPresentStatusPrj.value = "<%=Helper.correctNull((String)hshValues.get("presentStatusPrj"))%>";
	parent.frames.document.forms[0].txtOperationCDAcc.value = "<%=Helper.correctNull((String)hshValues.get("operationCDAcc"))%>";
	parent.frames.document.forms[0].txtMaxDebit.value = "<%=Helper.correctNull((String)hshValues.get("maxDebit"))%>";
	parent.frames.document.forms[0].txtMaxCredit.value = "<%=Helper.correctNull((String)hshValues.get("maxCredit"))%>";
	parent.frames.document.forms[0].txtMinDebit.value = "<%=Helper.correctNull((String)hshValues.get("minDebit"))%>";
	parent.frames.document.forms[0].txtMinCredit.value = "<%=Helper.correctNull((String)hshValues.get("minCredit"))%>";
	parent.frames.document.forms[0].txtDaysDebit.value = "<%=Helper.correctNull((String)hshValues.get("daysDebit"))%>";
	parent.frames.document.forms[0].txtOperTermLoanACC.value = "<%=Helper.correctNull((String)hshValues.get("operTermLoanACC"))%>";
	parent.frames.document.forms[0].txtRepaySchedule.value = "<%=Helper.correctNull((String)hshValues.get("repaySchedule"))%>";
	parent.frames.document.forms[0].txtCompliance.value = "<%=Helper.correctNull((String)hshValues.get("compliance"))%>";
	parent.frames.document.forms[0].txtCompletionMort.value = "<%=Helper.correctNull((String)hshValues.get("completionMort"))%>";
	parent.frames.document.forms[0].txtRegistCharge.value = "<%=Helper.correctNull((String)hshValues.get("registCharge"))%>";
	parent.frames.document.forms[0].txtCollSecurityDet.value = "<%=Helper.correctNull((String)hshValues.get("collSecurityDet"))%>";
	parent.frames.document.forms[0].txtInspectionDate.value = "<%=Helper.correctNull((String)hshValues.get("inspectionDate"))%>";
	parent.frames.document.forms[0].txtSecAdequtely.value = "<%=Helper.correctNull((String)hshValues.get("secAdequtely"))%>";
	parent.frames.document.forms[0].txtInspectingOfficial.value = "<%=Helper.correctNull((String)hshValues.get("inspectingOfficial"))%>";
	parent.frames.document.forms[0].txtAuditObserv.value = "<%=Helper.correctNull((String)hshValues.get("auditObserv"))%>";
	parent.frames.document.forms[0].txtRecommendation.value = "<%=Helper.correctNull((String)hshValues.get("recommendation"))%>";
	
	parent.frames.document.all.idActivity.innerText ="<%=Helper.correctNull((String)hshValues.get("personal_natofactivity"))%>";
	parent.frames.document.forms[0].hidActivity.value="<%=Helper.correctNull((String)hshValues.get("personal_natofactivity"))%>";
	
	parent.frames.document.all.idBankSince.innerText="<%=Helper.correctNull((String)hshValues.get("personal_bankingsince"))%>";
	parent.frames.document.forms[0].hidBankSince.value="<%=Helper.correctNull((String)hshValues.get("personal_bankingsince"))%>";
	
	parent.frames.document.all.idReviewDate.innerText="<%=Helper.correctNull((String)hshValues.get("LIMIT_REVIEWDATE"))%>";
	parent.frames.document.forms[0].hidReviewDate.value="<%=Helper.correctNull((String)hshValues.get("LIMIT_REVIEWDATE"))%>";
	
	parent.frames.document.all.idOSAmt.innerText="<%=Helper.correctNull((String)hshValues.get("FUND_OSAMT"))%>";
	parent.frames.document.forms[0].hidOSAmt.value="<%=Helper.correctNull((String)hshValues.get("FUND_OSAMT"))%>";
	
	parent.frames.document.all.idOverDue.innerText="<%=Helper.correctNull((String)hshValues.get("FUND_OVERDUEAMT"))%>";
	parent.frames.document.forms[0].hidOverDue.value="<%=Helper.correctNull((String)hshValues.get("FUND_OVERDUEAMT"))%>";
	
	parent.frames.document.all.idDBCDate.innerText="<%=Helper.correctNull((String)hshValues.get("dbc_date"))%>";
	parent.frames.document.forms[0].hidDBCDate.value="<%=Helper.correctNull((String)hshValues.get("dbc_date"))%>";
	//parent.frames.document.forms[0].txt_sanctioncomments.value="<%//=Helper.correctNull((String)hshValues.get("review_comments"))%>";
}


</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>