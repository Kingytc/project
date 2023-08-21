<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    String strLoanType=Helper.correctNull((String)request.getParameter("apploantype"));
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol = new ArrayList();
		
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String loan_type = Helper.correctNull((String) hshValues.get("app_loantype"));
	String legalcomp = Helper.correctNull((String) hshValues.get("app_legalcomp"));


	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strSno= Helper.correctNull((String)hshValues.get("strSno"));
	String schemeCode= Helper.correctNull((String)hshValues.get("schemeCode"));
	
	if(strSessionModuleType.equalsIgnoreCase(""))
	{
	 strSessionModuleType=Helper.correctNull((String)request.getParameter("ModuleType")).trim();
	}
	if(strCategoryType.equalsIgnoreCase(""))
	{
		strCategoryType=strSessionModuleType;
	}
%>

<html>
<head>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varappstatus="";
var varloantype="<%=loan_type%>";
var strPrdType="<%=prd_type%>";
var strSno="<%=strSno%>";
var schemeCode="<%=schemeCode%>";
var varSize="<%=arrRow.size()%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callAppraisal()
{	
	var com_appno= document.forms[0].hidAppNo.value;
	if(appno.length!=0)
	{		
		window.open(appURL+"action/perappsanctionsanction.jsp?appno="+com_appno,"AppraisalSanction", "scrollbars=yes,toolbars=No,menubar=no,width=600,height=450,top=0,left=0");
	}
}

function callOnload()
{
	document.forms[0].cmdcomments.disabled=true;
	if(document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved")
	{
		if(strPrdType!="pG"  && strPrdType!="pR")
		{
			document.all.idloanaccount.style.visibility="visible";
			document.all.idloanaccount.style.position="relative";
			document.all.idrestr.style.visibility="visible";
			document.all.idrestr.style.position="relative";
			document.all.idCGTMSEtxn.style.visibility="visible";
			document.all.idCGTMSEtxn.style.position="relative";				
		}
		else
		{
			document.all.idloanaccount.style.visibility="hidden";
			document.all.idloanaccount.style.position="absolute";
			document.all.idrestr.style.visibility="hidden";
			document.all.idrestr.style.position="absolute";
			//document.all.idCGTMSEtxn.style.visibility="hidden";
			//document.all.idCGTMSEtxn.style.position="absolute";	
				
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
		//document.all.idCGTMSEtxn.style.visibility="hidden";
		//document.all.idCGTMSEtxn.style.position="absolute";	
		

		if(varloantype.toUpperCase()=="C" || varloantype.toUpperCase()=="A")
		{
			document.all.idfacdetail.style.visibility="hidden";
			document.all.idfacdetail.style.position="absolute";
		}
		if(strSno != "0")
		{
			document.forms[0].cmdcomments.disabled=false;
		}
	}	

	<%if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A")){ %>
		if(strSno == "0")
			document.forms[0].sel_facilitysno.value = "";
		else
			document.forms[0].sel_facilitysno.value = strSno;
	<%}%>
	
	disabledFields(true);	
	document.forms[0].sel_facilitysno.disabled = false;
	enableButtons(false,true,true,true,true,false);
	compare_Amt("L");
	if(schemeCode == "OD")
		document.forms[0].cmdnew.disabled = true;
	else
		document.forms[0].cmdnew.disabled = false;

	if(varGrpRights=='r')
	{
		document.forms[0].cmdnew.disabled = true;
	}
}

function AudBankReprt()
{	
		var appno = document.forms[0].appno.value;
		
		var appname=document.forms[0].appname.value;
		
		var url = "<%=ApplicationParams.getAppUrl()%>action/auditorbankrep.jsp?appno="+appno+"&appname="+appname;
		
		var title = "";
		
		var prop = "scrollbars=yes,width=1395,height=1420";
		
		var xpos = 5;
		
		var ypos = 5;
		
		prop = prop + ",left="+xpos+",top="+ypos;
		
		window.open(url,title,prop);
}

function callOtherTab(val)
{
	 if(val=="history")
	 {
		 document.forms[0].hidBeanGetMethod.value="getHistory";
		 
		 document.forms[0].hidBeanId.value="commworkflow";
		 
		 document.forms[0].action=appURL+"action/appworkflowhistory.jsp";
		 
		 document.forms[0].submit();
	 }
	 if(val=="actiondigi")
		{
			document.forms[0].hidBeanGetMethod.value="getAction";
			document.forms[0].hidBeanId.value="perDeviation";
			document.forms[0].action=appURL+"action/permworkflowaction.jsp";
			document.forms[0].submit();
		}
	 if(val=="comments")
	 {
		
		 document.forms[0].hidBeanId.value="commworkflow";
			
		 document.forms[0].hidBeanGetMethod.value="getWorkFlowComments";
			
		 document.forms[0].action=appURL+"action/appworkflowcomment.jsp";
			
		 document.forms[0].submit();
	}
	if(val=="sanction")
	{
		
		document.forms[0].hidBeanGetMethod.value="getTermsofSanctionFacilityData";
		
		document.forms[0].hidBeanId.value="commworkflow";
		
		document.forms[0].action=appURL+"action/com_termsofsanction.jsp";
		
		document.forms[0].submit();
	}
	if(val=="legcomp")
	{
		document.forms[0].app_loantype.value=varapptype;
		
		document.forms[0].app_legalcomp.value=varapptype;
		
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
	if(val=="action")
	{
		
		document.forms[0].hidBeanId.value="commworkflow";
		
		document.forms[0].hidBeanGetMethod.value="getAction";
		
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		
		document.forms[0].submit();
	}
	if(val=="CGTMSE_TXN")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getCGTMSE_txndet";
		document.forms[0].action=appURL+"action/app_CGTMSE_txnDet.jsp";
		document.forms[0].submit();
	}
	if(val=="legcomp")
	{
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getlegalComplianceData";
		document.forms[0].action=appURL+"action/legalcompliance.jsp";
		document.forms[0].submit();
	}
}
function callQueries()
{
		 document.forms[0].hidBeanGetMethod.value="getQueryData";
		 document.forms[0].hidBeanId.value="documentsupport";
		 document.forms[0].action=appURL+"action/appqueryhome.jsp";
		 document.forms[0].submit();
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled == false)
		showCal(appURL,val);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
		document.forms[0].action=appURL+"action/drawdownschedule.jsp";
		document.forms[0].submit();
	}	
}

function SelectValues()
{
		document.forms[0].hidBeanId.value="commworkflow"
			
		document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
		
		document.forms[0].action=appURL+"action/drawdownschedule.jsp";
		
		document.forms[0].submit();
}

function doDelete()
{	
	if(ConfirmMsg(101))
	{
		disabledFields(false);
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="commworkflow"
		document.forms[0].hidBeanMethod.value="updateDrawDownSchedule";
		document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/drawdownschedule.jsp";
 		document.forms[0].submit();
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
		document.forms[0].cmdnew.disabled=bool1;
		document.forms[0].cmdedit.disabled=bool2;
		document.forms[0].cmdsave.disabled=bool3;
		document.forms[0].cmdcancel.disabled=bool4;
		document.forms[0].cmddelete.disabled=bool5;
		document.forms[0].cmdclose.disabled=bool6;
}

function doEdit()
{
	if(document.forms[0].sel_facilitysno.value == "")
	{
		alert("Please select a facility");
		document.forms[0].sel_facilitysno.focus();
	}
	
	else 
	{
		document.forms[0].hidAction.value = "update";
		enableButtons(true,true,false,false,true,true);
		disabledFields(false);	
		document.forms[0].sel_facilitysno.disabled = true;
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='radio')
			{
				document.forms[0].elements[i].disabled=true;
			}
		}
	}
	document.forms[0].cmdcomments.disabled=true;
}

function doSave()
{	
	if(document.forms[0].txt_quaterstartdate.value=="")
	{
		alert("Enter Quarter Start date");
		document.forms[0].txt_quaterstartdate.focus();
		return;
	}
	if(document.forms[0].txt_quaterenddate.value=="")
	{
		alert("Enter Quarter End date");
		document.forms[0].txt_quaterenddate.focus();
		return;
	}
	if(document.forms[0].txt_totquater.value=="")
	{
		alert("Enter Total outstanding at the end of the quarter");
		document.forms[0].txt_totquater.focus();
		return;
	}
	if(document.forms[0].txt_amtquater.value=="")
	{
		alert("Enter Amount to be disbursed during the Quarter");
		document.forms[0].txt_amtquater.focus();
		return;
	}
	if(document.all.id_high.style.display=="block")
	{
		alert("Disbursement loan amount cannot be higher than the Sanction amount");
		return;
	}
	disabledFields(false);
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanMethod.value="updateDrawDownSchedule";
	document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/drawdownschedule.jsp";
	document.forms[0].submit();
}

function doClose()
{
	if(varloantype.toUpperCase()=="P" || varloantype.toUpperCase()=="A")
	{
		if(ConfirmMsg(100))
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/retailpge.jsp";
			
			document.forms[0].submit();
		}
	}
	var cattype=document.forms[0].cattype.value;
    if(cattype=="OPS")
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/agrpage.jsp";
			
		 	document.forms[0].submit();
	 	}
	}
	if((cattype=="CORP")||(cattype=="SME")||(cattype=="SRE")||(cattype=="STL") ||(cattype=="ADC"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/corppge.jsp";
			
		 	document.forms[0].submit();
	 	}
	}	
}

function callIFrame()
{
	    document.forms[0].hidBeanId.value="commworkflow";	
	    
		document.forms[0].hidBeanGetMethod.value="getDrawDownSchedule";
		
		document.forms[0].action=appURL+"/action/drawdownschedule.jsp";
	
		document.forms[0].submit();
}

function callAnnexure()
{
	if(document.forms[0].sel_facilitysno.value == "")
	{
		alert("Please select a facility");
		document.forms[0].sel_facilitysno.focus();
		return;
	}
	var com_appno = document.forms[0].hidAppNo.value;
	var varsno = document.forms[0].sel_facilitysno.value;
	var purl	= "";var title	= "";
	purl	= "<%=ApplicationParams.getAppUrl()%>action/drawdown_Annexure.jsp?hidBeanGetMethod=getDrawDownSchedule&hidBeanId=commworkflow&appno="+com_appno+"&sel_facilitysno="+varsno;
	title	= "drawdown_Annexure";
	var prop 	= "scrollbars=yes,width=900,height=350,menubar=yes";
	var xpos 	= 5;
	var ypos 	= 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function PlaceValues(val1,val2,val3,val4,val5)
{
	document.forms[0].txt_quaterstartdate.value = val1;
	document.forms[0].txt_quaterenddate.value = val2;
	document.forms[0].txt_totquater.value = val3;
	document.forms[0].txt_amtquater.value = val4;
	document.forms[0].txt_amtquater_temp.value = val4;
	document.forms[0].hidSno.value = val5;
	enableButtons(true,false,true,true,false,false);
}

function doNew()
{
	if(document.forms[0].sel_facilitysno.value == "")
	{
		alert("Please select a facility");
		document.forms[0].sel_facilitysno.focus();
		return;
	}
	document.forms[0].hidAction.value = "insert";
	enableButtons(true,true,false,false,true,true);
	disabledFields(false);
	document.forms[0].sel_facilitysno.disabled = true;
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=true;
		}
	}
	document.forms[0].cmdcomments.disabled=true;
}

function compare_Amt(val)
{
	if(document.forms[0].sel_facilitysno.value == "")
	{
		document.all.id_less.style.display = "none";	
		document.all.id_equal.style.display = "none";	
		document.all.id_high.style.display = "none";
		return;		
	}
	
	var varSancAmt = eval(document.forms[0].txt_loanamt.value);
	var DisbAmt = eval(document.forms[0].txt_disb_amt.value);
	if(val=="E")
	{
		DisbAmt = DisbAmt - eval(document.forms[0].txt_amtquater_temp.value) + eval(document.forms[0].txt_amtquater.value);
	}
	if(DisbAmt < varSancAmt)
	{
		document.all.id_less.style.display = "table-row";	
		document.all.id_equal.style.display = "none";	
		document.all.id_high.style.display = "none";	
	}
	else if(DisbAmt > varSancAmt)
	{
		document.all.id_less.style.display = "none";	
		document.all.id_equal.style.display = "none";	
		document.all.id_high.style.display = "table-row";	
	}
	else if(DisbAmt == varSancAmt)
	{
		document.all.id_less.style.display = "none";	
		document.all.id_equal.style.display = "table-row";	
		document.all.id_high.style.display = "none";	
	}
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
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var appno=document.forms[0].appno.value;
	var facility=document.forms[0].sel_facilitysno.value;
	var url=appURL+"action/com_copmofcomments.jsp?hidBeanId=bankapp&hidBeanGetMethod=getCopMofComments&hidAppNo="+appno+"&facilitysno="+facility+"&PageType=DRAWDOWN"+"&appstatus="+appstatus+"&btnenable="+btnenable;
	var prop = "scrollbars=no,menubar=no,width=750,height=550,top=25,left=180";
	window.open(url,'title',prop);	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</STYLE>
</head>
<body onload="callOnload();">
<form name="remarks" method="post" class="normal" >
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){
	if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="137" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
			<jsp:param name="subpageid" value="119" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
	<tr><td id="idloanaccount"></td></tr>
	<tr><td id="idfacdetail"></td></tr>
	<tr><td id="idrestr"></td></tr>
</table>
<%}}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<%
			if (loan_type.equalsIgnoreCase("P")
					) {
		%> <jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
		</jsp:include> <%
 	} else if (loan_type.equalsIgnoreCase("E")
 			|| loan_type.equalsIgnoreCase("U")
 			|| loan_type.equalsIgnoreCase("H")
 			|| loan_type.equalsIgnoreCase("T")) {
 %> <jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span> <%
 	} else if (loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {
 %> <jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <span style="display: none;"><lapschoice:borrowertype /></span> <%
 	}
 %>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	 <%if(strSessionModuleType.equals("AGR")){%>
	 <tr>
		<td class="page_flow">Home -&gt; Agriculture-&gt; Proposal -&gt; WorkFlow -&gt;Draw Down Schedule</td>
	</tr>
	<%}else if (strCategoryType.equalsIgnoreCase("SRE")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;  Application -&gt; WorkFlow -&gt;Draw Down Schedule</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Short	Term Loan -&gt; WorkFlow -&gt; Draw Down Schedule</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Ad-hoc Limit -&gt; WorkFlow -&gt; Draw Down Schedule</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("LAD")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Loan Against Gold Ornaments &amp;Deposits -&gt; WorkFlow -&gt; Draw Down Schedule</td>
	</tr>
		<%} else if (strCategoryType.equalsIgnoreCase("OPS")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Tertiary -&gt; Application -&gt; WorkFlow -&gt; Draw Down Schedule</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("AGR")) {%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; WorkFlow -&gt; Draw Down Schedule</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("RET")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic)  -&gt;Application -&gt; WorkFlow -&gt;Draw Down Schedule</td>
	</tr>
	<%} else if (strCategoryType.equalsIgnoreCase("DIGI")) {%>
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt;Application -&gt; WorkFlow -&gt;
		Draw Down Schedule</td>
	</tr>
	<%} else {%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; WorkFlow -&gt;Draw Down Schedule</td>
	</tr>
	<%}%>
	</table>
<lapschoice:application />

		<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="80%">
			<tr align="center">
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('history')">History</a></td>
				<!-- <td class="sub_tab_inactive"><a href="javascript:callOtherTab('comments')">Comments</a></td> -->
				<td class="sub_tab_inactive"><a  href="#" onClick="javascript:callQueries()">Queries</a></td>
				<%if (loan_type.equalsIgnoreCase("C")
							|| loan_type.equalsIgnoreCase("T")
							|| loan_type.equalsIgnoreCase("H")
							|| loan_type.equalsIgnoreCase("U")
							|| loan_type.equalsIgnoreCase("E")
							|| loan_type.equalsIgnoreCase("A")) { %>
				<td class="sub_tab_inactive" nowrap><a href="javascript:callOtherTab('sanction')" > Proposed facility Approve/Reject</a></td>
				<%}%>
				<% if (strSessionModuleType.equalsIgnoreCase("DIGI") && !(prd_type.equalsIgnoreCase("pB")|| prd_type.equalsIgnoreCase("pM"))) { %>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('actiondigi')">Action</a></td>
				<%} else{%>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('action')">Action</a></td>
				<%} %>				<%
				if((Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("pa")) || (Helper.correctNull((String)session.getAttribute("appstatus")).equalsIgnoreCase("ca")))
				{
				if (Helper.correctNull((String)session.getAttribute("PRD_CGTMSE")).equalsIgnoreCase("Y")){ %>
					<td class="sub_tab_inactive"><a href="javascript:callOtherTab('CGTMSE_TXN')">CGTMSE Transaction Details</a></td>
				<%} else { %>
					<td id="idCGTMSEtxn" style="display: none;"><input type="hidden"></td>
				<% }  } %>
				<td class="sub_tab_active">Draw Down Schedule</td>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
				<%if (legalcomp.equalsIgnoreCase("Y")){ %>
				<td class="sub_tab_inactive" nowrap><a href="javascript:callOtherTab('legcomp')">Legal Compliance Certificate</a></td>
				<%} %>
				<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
				<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("S")){ %>
				<td id="idrestr" class="sub_tab_inactive" nowrap="nowrap"><a
					href="#" onclick="javascript:callOtherTab('restrfacdetails')">Restructure Effective Date</a></td>
				<%}else{ %>
				<td  style="display: none;"><input type="hidden" id="idrestr"></td>
				<%} 
				if(loan_type.equalsIgnoreCase("C") || loan_type.equalsIgnoreCase("A")) {%>
				<td class="sub_tab_inactive" id="idfacdetail"  nowrap="nowrap"><a href="#" onClick="javascript:callFacDetail()">Facility Details</a></td> 
				<% } %>
			</tr>
		</table>
		<%} %>
&nbsp;
<table class="outertable" align="center">
<%if(strLoanType.equalsIgnoreCase("C") || strLoanType.equalsIgnoreCase("A"))
{ %>
	<tr>
	<td>
	Facility &nbsp; &nbsp;
	<select name="sel_facilitysno" tabindex="1" onChange="SelectValues()">
	<option value="" selected="selected">--Select--</option>
             <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='dds'/>
	</select>
	</td>
	</tr>
<%}else{ %>
	<tr><td><input type="hidden" name="sel_facilitysno" value="1"></td></tr>
<%} %>
</table>
<table class="outertable" width="70%" align="center" border="0">
<tr>
<td width="15%" align="center" class="dataheader">Quarter Start Date</td>
<td width="15%" align="center" class="dataheader">Quarter end date</td>
<td width="20%" align="center" class="dataheader">Total outstanding at the end of the quarter</td>
<td width="20%" align="center" class="dataheader">Amount to be disbursed during the Quarter</td>
</tr>

<tr>
	<td class="datagrid" align="center">
		<table>
		<tr>
		<td align="center"><input type="text" value="" name="txt_quaterstartdate"	size="13" maxlength="10" 
			onBlur="checkDate(this);checkmindate(this,document.forms[0].hidMaxdate.value);">
		</td>
		<td id="quaterstartdate"><a alt="Select date from calender"	href="javascript:callCalender('txt_quaterstartdate')"> 
		<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a>
		</td>
		</tr>
		</table>
	</td>
	<td class="datagrid" align="center">
		<table>
		<tr>
		<td align="center"><input type="text"  value="" name="txt_quaterenddate" size="13" maxlength="10" 
			onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_quaterstartdate.value);">
		</td>
		<td id="quaterenddate" align="center"><a alt="Select date from calender" href="javascript:callCalender('txt_quaterenddate')"> 
		<img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a></td>
		</tr>
		</table>
	</td>
	<td class="datagrid" align="center"><input type="text" style="text-align:right" name="txt_totquater"  value=""></td>
	<td class="datagrid" align="center"><input type="text" style="text-align:right" name="txt_amtquater" value="" onBlur="compare_Amt('E');">
	<input type="hidden" style="text-align:right" name="txt_amtquater_temp" value="0"></td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Comments'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table class="outertable" width="10%" align="center" border="0">
<tr><td align="center"><input type="button" name="btn_drawdown" value="Annexure" onclick="callAnnexure();" class="buttonStyle" style="width: 120px"></td></tr>
</table>
<br>
<table class="outertable" width="60%" align="center" border="0">
<tr id="id_equal"><td align="center"><font color="green">Disbursement loan amount is equal to the Sanction amount</font></td></tr>
<tr id="id_high"><td align="center"><font color="red">Disbursement loan amount is higher than the Sanction amount</font></td></tr>
<tr id="id_less"><td align="center"><font color="blue">Disbursement loan amount is less than the Sanction amount</font></td></tr>
</table>
<br>
<table class="outertable" width="60%" align="center" border="0">
<tr>
<td align="center" class="dataheader">&nbsp;</td>
<td width="15%" align="center" class="dataheader">Quarter Start Date</td>
<td width="15%" align="center" class="dataheader">Quarter end date</td>
<td align="center" class="dataheader">Total outstanding at the end of the quarter</td>
<td align="center" class="dataheader">Amount to be disbursed during the Quarter</td>
</tr>
<% int addrow1 = 0;
double dbl_total = 0;
if(arrRow!=null)
{
	addrow1 = arrRow.size();
}
if (addrow1 > 0) 
{
	for (int j = 0; j < addrow1; j++)
	{
		arrCol = (ArrayList) arrRow.get(j);
		%> 	
		<tr class="datagrid">
			<td align="center"><input type="radio" name="rd_sno" style="border: none;" onclick="PlaceValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
																						'<%=Helper.correctNull((String)arrCol.get(1))%>',
																						'<%=Helper.correctNull((String)arrCol.get(2))%>',
																						'<%=Helper.correctNull((String)arrCol.get(3))%>',
																						'<%=Helper.correctNull((String)arrCol.get(4))%>')">
			</td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
			<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
			<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
		</tr>
	<%
	dbl_total = dbl_total + Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
	}%>
<tr><td colspan="5">
<table class="outertable" cellspacing="0" cellpadding="1" width="50%" align="left" border="0">
<tr><td class="dataheader">Sanction Loan Amount <input type="text" name="txt_loanamt" style="text-align:right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("Sanc_amt"))))%>"></td></tr>
</table>
<table class="outertable" cellspacing="0" cellpadding="1" width="50%" align="right" border="0">
<tr><td align="right" class="dataheader">Total disbursed amount <input type="text" style="text-align:right" name="txt_disb_amt" value="<%=Helper.formatDoubleValue(dbl_total)%>"></td></tr>
</table>
</td></tr>
<%}else{ %>
<tr><td class="datagrid" colspan="5" align="center">No Records</td></tr>
<tr><td colspan="5">
<table class="outertable" cellspacing="0" cellpadding="1" width="50%" align="left" border="0">
<tr><td class="dataheader">Sanction Loan Amount <input type="text" name="txt_loanamt" style="text-align:right" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("Sanc_amt"))))%>"></td></tr>
</table>
<table class="outertable" cellspacing="0" cellpadding="1" width="50%" align="right" border="0">
<tr><td align="right" class="dataheader">Total disbursed amount <input type="text" style="text-align:right" name="txt_disb_amt" value="<%=Helper.formatDoubleValue(dbl_total)%>"></td></tr>
</table>
</td></tr>
<%} %>	
</table>

<lapschoice:hiddentag pageid='<%=PageId%>'/>

<input type="hidden" name="hidDemoId" value=""<%=Helper.correctNull((String) hshValues.get("hidapplicantid"))%>">
<INPUT TYPE="hidden" name="hidAppNo" VALUE="<%=Helper.correctNull((String) request.getParameter("appno"))%>">
<INPUT TYPE="hidden" name="hidMaxdate" VALUE="<%=Helper.correctNull((String) hshValues.get("maxdate"))%>">
<INPUT TYPE="hidden" name="radLoan" value=""> 
<input type="hidden" name="cattype" value="">
<input type="hidden" name="hidSno" value="">
</form>
</body>
</html>