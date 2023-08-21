<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%



	int pageid = Integer.parseInt(request.getParameter("pageid"));
	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	String productcode = "";
	String grpRights = Helper.correctNull((String) session.getAttribute("strGroupRights"));
	String strTakeOverFlag	=	Helper.correctNull((String)request.getParameter("hidTakeOverFlag"));
	String strcategorytype=Helper.correctNull((String)request.getParameter("hidCategoryType"));
	String strBuiId=Helper.correctNull((String) session.getAttribute("busid"));
	String strCgstme=Helper.correctNull((String) session.getAttribute("cgstme"));
	String strMisFlag=Helper.correctNull((String)session.getAttribute("strSessionMisFlag"));
	String strRepaymenttype =Helper.correctNull((String) hshValues.get("repaymenttype"));
	String strEmploymentstatus=Helper.correctNull((String)request.getParameter("employmentstatus"));
	String strSchemeCode=Helper.correctNull((String) session.getAttribute("schemeCode"));	
	String strPRD_CGTMSE=Helper.correctNull((String) session.getAttribute("PRD_CGTMSE"));	
	String digiGoldFlag = Helper.correctNull((String) session.getAttribute("digiGoldFlag"));

	if(!strcategorytype.equalsIgnoreCase("LAD") && digiGoldFlag.equalsIgnoreCase("PJ")){ 
		strcategorytype="LAD";
	}
	if (objValues instanceof java.util.HashMap) 
	{
		hshValues = (java.util.HashMap) objValues;
	}
	if(hshValues!=null)
	{
		if(strRepaymenttype.equals(""))
		{
			 strRepaymenttype=Helper.correctNull((String)request.getParameter("hidRepayType"));
		}
	
	}
	
	if(hshValues!=null)
	{
		if(strEmploymentstatus.equals(""))
		{
			strEmploymentstatus =Helper.correctNull((String) hshValues.get("perapp_employment"));
		}
	
	}
	String strTakeOverAvailFlag=Helper.correctNull((String) request.getParameter("hidtakeoveravail"));
	if(strTakeOverAvailFlag.equals(""))
	{
		strTakeOverAvailFlag =Helper.correctNull((String) hshValues.get("TakeOverAvailFlag"));
	}
	String strValuationFlag="";//Helper.correctNull((String) request.getParameter("hidValuationFlag"));	
	String strHouseEdit_Flag="";//Helper.correctNull((String) request.getParameter("hidHouseEdit_Flag"));
	String strVehicleEdit_Flag="";//Helper.correctNull((String) request.getParameter("hidVehicleEdit_Flag"));
	
	//if(strHouseEdit_Flag.equals(""))
		strHouseEdit_Flag = Helper.correctNull((String) session.getAttribute("HouseEdit_Flag"));
	//if(strValuationFlag.equals(""))
		strValuationFlag = Helper.correctNull((String) session.getAttribute("valuationFlag"));
	//if(strVehicleEdit_Flag.equals(""))
		strVehicleEdit_Flag = Helper.correctNull((String) session.getAttribute("VehicleEdit_Flag"));
	
		if(strcategorytype.equals(""))
			strcategorytype=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
%>
<HTML>
<HEAD>
<TITLE>Application Form Navigation</TITLE>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script language="JavaScript">
var pageid=parseInt("<%=pageid%>");
var varTakeOverAvailFlag="<%=strTakeOverAvailFlag%>";
var varTakeOverFlag="<%=strTakeOverFlag%>";
var varprd_type="<%=prd_type%>";
var varValuationFlag="<%=strValuationFlag%>";
var varHouseEdit_Flag="<%=strHouseEdit_Flag%>";
var varVehicleEdit_Flag="<%=strVehicleEdit_Flag%>";
var varPrdPurpose="<%=Helper.correctNull((String) session.getAttribute("strPrdPurpose"))%>";
function gotoPage(pagename)
{	
	//vindhya begin

	<%if(Helper.correctNull((String) session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %> 
	//{
		if(document.forms[0].freezeflag)
		{
		if(document.forms[0].freezeflag.value=="Y")
		{ 
			if(document.forms[0].varPanCheck.value=="Y")
			{ 			
						 if(document.forms[0].Explimitchk.value=="F")
							 {
								 if (document.forms[0].varPancount.value=="N")
								{
								 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
									return;
								}	 
							}
				 
				}		
				
			}
		}	
		<%}%>
	//vindhya end
	if(document.forms[0].cmdsave)
		{
			if(document.forms[0].cmdsave.disabled == false)
			{
				ShowAlert(103);
				return;
			}
	
		}
	if(document.forms[0].appstatus.value=="Open/Pending")
	{
		if(varprd_type=="pH" && !(varPrdPurpose=="F"||varPrdPurpose=="T"||varPrdPurpose=="HC"))
		{
			if(varHouseEdit_Flag!="" && varHouseEdit_Flag=="N")
			{
					alert("Please Fill all fields in Proposed Assets-->House Tab ");
					return;
			}
			if(varValuationFlag!="" && varValuationFlag=="N")
			{
					alert("Please Fill all fields in Proposed Assets-->ValuationEntry Tab ");
					return;
			}
		}
		if(varprd_type=="pA")
		{
			if(varVehicleEdit_Flag!="" && varVehicleEdit_Flag=="N")
			{
				alert("Please Fill all fields in Proposed Assets-->Vehicle Tab ");
				return;
			}
			if(varValuationFlag!="" && varValuationFlag=="N")
			{
					alert("Please Fill all fields in Proposed Assets-->ValuationEntry Tab ");
					return;
			}
		}
	}
	if(document.forms[0].sel_take_over &&  document.forms[0].hidtakeoveravail)
	{
		var varTakeOver =  document.forms[0].sel_take_over.value;
		var varTakeoverpageFilled =  document.forms[0].hidtakeoveravail.value;
		if(varTakeOver=="Y" && varTakeoverpageFilled=="N")
		{
			ShowAlert(192);
			return;
		}
	}	
	if(document.forms[0].schemetype &&  document.forms[0].hidPMAYDet && document.forms[0].appstatus.value=="Open/Pending")
	{
		if((document.forms[0].schemetype.value=="079" || document.forms[0].schemetype.value=="078") && document.forms[0].hidPMAYDet.value=="N")
	{
			alert("Please Enter the PMAY Details");
			return;
		}
	}
	if(document.forms[0].schemetype &&  document.forms[0].hidAHPDet && document.forms[0].appstatus.value=="Open/Pending")
	{
		if((document.forms[0].schemetype.value=="080" || document.forms[0].schemetype.value=="081") && document.forms[0].hidAHPDet.value=="N")
	{
			alert("Please Enter the Affordable Housing in Partnership Details");
			return;
		}
	}

	if(document.forms[0].hidCGTMSE)
	{	
		if(document.forms[0].hid_cgtmse_applicable.value=="Y")
		{
			if(document.forms[0].hidCGTMSE.value=="N")
			{
				alert("Please Fill the CGTMSE Coverage Page");
				return;
			}
		}
	}
	if(pagename=="perapplicantdispco.jsp")
	{	
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getDemographics";	
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perapplicantdispco.jsp?applnt=C&pageid=2&corp=R";
		document.forms[0].method="post";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	if(pagename=="perapplicantdispgua.jsp")
	{	
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getDemographics";		
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perapplicantdispco.jsp?applnt=G&pageid=9";
		document.forms[0].method="post";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="perloandetails.jsp" || pagename=="ladloandetails.jsp")
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
				
	}
	else if(pagename=="perfinancialinvst.jsp")
	{					
		document.forms[0].hidBeanGetMethod.value="getInvestMent";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="percollateralhome.jsp")
	{				
		document.forms[0].hidBeanId.value="";	
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	/*else if(pagename=="perriskanalysis.jsp")
	{
		document.forms[0].action="<%//=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();			
	}*/
	else if(pagename=="per_common_assessment.jsp")
	{				

		




					
		document.forms[0].hidBeanId.value="retailassessment";
		document.forms[0].hidBeanGetMethod.value="getCommonAssessment";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	else if(pagename=="per_assessment_repayment_capacity.jsp")
	{							
		document.forms[0].hidBeanId.value="retailassessment";
		document.forms[0].hidBeanGetMethod.value="getRepaymentCapacity";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit()
	}
	else if(pagename=="frame2.jsp")
	{						
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/frame2.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}		
	else if(pagename=="comdocuments.jsp")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsappl.jsp?hidBeanGetMethod=getData&hidAppDoc=A";
		document.forms[0].method="post";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="appworkflowhistory.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getHistory";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="comnotes.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appnotes.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();		
	}
	else if(pagename=="edustudent.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="edustudent";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/edustudent.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();			
	}
	else if(pagename=="agrlandholdings.jsp")
	{
			
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/frame1.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="proposalterms.jsp")
	{
			
		document.forms[0].hidBeanId.value="proposalterms";	
		document.forms[0].hidBeanGetMethod.value="getConduct";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pagename=="misdetails.jsp")
	{
			
		document.forms[0].hidBeanId.value="mis";	
		document.forms[0].hidBeanGetMethod.value="getMISDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/misdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	if(pagename=="combankingfi.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/combankingfi.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
    if(pagename=="perrating.jsp")
	{    	
		document.forms[0].hidBeanId.value="perapplicant";	
		document.forms[0].hidBeanGetMethod.value="getRetailrating";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perrating.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
		
	}
    if(pagename=="cgtmsecoverage.jsp")
    		{  

    	document.forms[0].hidBeanId.value = "supuser";
    	document.forms[0].hidBeanGetMethod.value = "getCgtmse";
    	 document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/cgtmsecoverage.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
		
	}
    if(pagename=="securitymaster_retail.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getSecurityRetailDetails";
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/securitymaster_retail.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	

    if(pagename=="per_RepaymentSchedulenonemi.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getFacNonEMIRepayment";
		document.forms[0].hidBeanId.value="comrepayschedule";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/per_RepaymentSchedulenonemi.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
    if(pagename=="com_repaycomment.jsp")
	{
		document.forms[0].pagetype1.value="repaycomment";
		document.forms[0].hidBeanGetMethod.value="getDataComments";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_repaycomment.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	if(pagename=="agr_croppingpattern.jsp")
	{
		document.forms[0].hidBeanGetMethod.value="getCroppingPatterns";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_croppingpattern.jsp?employmentstatus=<%=strEmploymentstatus%>";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	if(pagename=="appqueryhome.jsp")
	{
		document.forms[0].hidBeanId.value="documentsupport";
		document.forms[0].hidBeanGetMethod.value="getQueryData";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appqueryhome.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	
}

function menuOptionDivMouseDown (url) 
{
	if(document.forms[0].cmdsave.disabled == true)
	{
		document.currentMenu.style.display='none';
		document.currentMBarOpt.style.border='1px solid lightgrey';
		document.menuIsActive = false;
		document.forms[0].action=url;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function onclose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		appname=document.forms[0].appname.value;
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</HEAD>
<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width=100% border=0 cellpadding=3 cellspacing=1 class="outertable"> 

<tr align="center"> 

<%if (pageid == 1) {%> 
	<td class="main_tab_active" WIDTH="12%" NOWRAP> <b>Loan Particulars</b> </td>
	
<%} else {%> 

<%if(strcategorytype.equalsIgnoreCase("LAD")){ %> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a
					href="javascript:gotoPage('ladloandetails.jsp')" 
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Applicant';return true;"> <b>Loan Particulars </b></a> </td>
<%}else{ %> <td class="main_tab_inactive" WIDTH="12%" NOWRAP> 
<a
					href="javascript:gotoPage('perloandetails.jsp')" 
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Applicant';return true;"
					> <b>Loan Particulars </b></a> </td><%} %> 
<%}%> 

<%if (pageid == 2) {%> 

<td class="main_tab_active" WIDTH="12%" NOWRAP> <b>Applicant/Guarantor</b></td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a
					href="javascript:gotoPage('perapplicantdispco.jsp')"
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='CoApplicant';return true;"
					><b>Applicant/Guarantor</b></a> </td>
<%}%>	

<%if(!strcategorytype.equalsIgnoreCase("LAD")){ %> 
<%if (pageid == 12) {%> 
<td class="main_tab_active" WIDTH="12%" NOWRAP> <b>KBL Credit Facilities</b></td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a
					href="javascript:gotoPage('combankingfi.jsp')"
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='KBL Credit Facilities';return true;"
					><b>KBL Credit Facilities</b></a> </td>
<%}}%>
<%if(!strcategorytype.equalsIgnoreCase("LAD")){ %> 
<%if (pageid == 22) {%> 
<td class="main_tab_active" WIDTH="12%" NOWRAP> <b>Security Master</b></td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a
					href="javascript:gotoPage('securitymaster_retail.jsp')"
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Security Master';return true;"
					><b>Security Master</b></a> </td>
<%}}%>
<!--<%//if(strEmploymentstatus.equalsIgnoreCase("4")&& !(prd_type.equalsIgnoreCase("pG")||prd_type.equalsIgnoreCase("pR"))){
	//if (pageid == 8) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP><b>Agriculture</b></td><%//} else {%> 
	<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <b><a href="javascript:gotoPage('agr_croppingpattern.jsp')" 
							onMouseOut="window.status='';return true;" 
							onMouseOver="window.status='Agriculture';return true;">Agriculture</a></b></td><%//}} %>
--><%if (pageid == 5) {%> 
<TD CLASS="MAIN_TAB_ACTIVE" WIDTH="12%" NOWRAP><B>Documents</B></TD>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a href="javascript:gotoPage('comdocuments.jsp')" 
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Documents';return true;"
				> <b>Documents</b></a></td>
<%}%> 
					
<%if(strcategorytype.equalsIgnoreCase("RET")){  					
if (pageid == 51) {%> 

<td class="main_tab_active" WIDTH="12%" NOWRAP> <b>Proposal Terms</b></td>
<%} else {%> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a
					href="javascript:gotoPage('proposalterms.jsp')"
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='ProposalTerms';return true;"
					><b>Proposal Terms</b></a> </td>
<%} 
}%>					
					
					
	<%
		if (!prd_type.equalsIgnoreCase("")) 
		{
			productcode = prd_type.substring(0, 1);
			if (productcode.equalsIgnoreCase("a")) 
			{
		%> 
<%if (pageid == 8) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP><b>Agriculture</b></td><%} else {%> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <b><a href="javascript:gotoPage('agrlandholdings.jsp')" 
						onMouseOut="window.status='';return true;" 
						onMouseOver="window.status='Agriculture';return true;">Agriculture</a></b></td><%}%> 
						
<%if ((grpRights.charAt(21) == '1')) {%> 

<%if (pageid == 10) { %> <td class="main_tab_active" WIDTH="12%" NOWRAP><b>Appraisal</b></td><%}else{ %> 
<td class="main_tab_inactive" WIDTH="12%" NOWRAP> <a

						href="javascript:gotoPage('frame2.jsp')" 
						onMouseOut="window.status='';return true;" 
						onMouseOver="window.status='Appraisal';return true;"
						> <b>Appraisal </b></a></td><%} %> 
<%}%> <%} else {%> 
<%
if(prd_type.equalsIgnoreCase("pG")||prd_type.equalsIgnoreCase("pR"))
{
if ((grpRights.charAt(25) == '1')) {
	
	if(prd_type.equalsIgnoreCase("pG") && strRepaymenttype.equalsIgnoreCase("14"))
	{
		if(pageid==10)
		{
		%>
		<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Appraisal</b></td>
		<%
		}
		else
		{
		%>
		<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
		<a href="javascript:gotoPage('per_RepaymentSchedulenonemi.jsp')" onMouseOut="window.status='';return true;" 
				onMouseOver="window.status='Workflow';return true;"><b>Appraisal</b></a></td>
		<%
		}	
	}else{
					if (pageid == 10) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP> 
<b>Appraisal</b></td><%} else {%> <td class="main_tab_inactive" WIDTH="12%" NOWRAP><a

						href="javascript:gotoPage('per_common_assessment.jsp')" 
						onMouseOut="window.status='';return true;" 
						onMouseOver="window.status='Appraisal';return true;"
						> <b>Appraisal</b></a></td>
<%}}
		}
}else if(prd_type.equalsIgnoreCase("pP")){
		if(strEmploymentstatus.equalsIgnoreCase("1")||strEmploymentstatus.equalsIgnoreCase("9")){
			if (pageid == 10) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP> 
			<b>Appraisal</b></td><%} else {%> <td class="main_tab_inactive" WIDTH="12%" NOWRAP><a

									href="javascript:gotoPage('per_common_assessment.jsp')" 
									onMouseOut="window.status='';return true;" 
									onMouseOver="window.status='Appraisal';return true;"
									> <b>Appraisal</b></a></td>
			<%}
		}else{
			if (pageid == 10) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP> 
		<b>Appraisal</b></td><%} else {%> <td class="main_tab_inactive" WIDTH="12%" NOWRAP><a

			href="javascript:gotoPage('per_assessment_repayment_capacity.jsp')" 
			onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Appraisal';return true;"
			> <b>Appraisal</b></a></td>
<%}}%>
	
<%}
else if(prd_type.equalsIgnoreCase("pC") || prd_type.equalsIgnoreCase("pN")|| prd_type.equalsIgnoreCase("pJ"))
{
	if ((grpRights.charAt(6) == '1')) {
		
		if(!(strRepaymenttype.equalsIgnoreCase("1")) && !strRepaymenttype.equalsIgnoreCase(""))
		{
			if(pageid==10)
			{
			%>
			<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Appraisal</b></td>
			<%
			}
			else
			{
			%>
			<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
			<a href="javascript:gotoPage('per_RepaymentSchedulenonemi.jsp')" onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Workflow';return true;"><b>Appraisal</b></a></td>
			<%
			}
		}
		else
		{
			if (pageid == 10) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP> 
			<b>Appraisal</b></td><%} else {%> <td class="main_tab_inactive" WIDTH="12%" NOWRAP><a
	
					href="javascript:gotoPage('per_assessment_repayment_capacity.jsp')" 
					onMouseOut="window.status='';return true;" 
					onMouseOver="window.status='Appraisal';return true;"
					> <b>Appraisal</b></a></td>
			<%}
		}
	}
}
else
{
if ((grpRights.charAt(6) == '1')) {

	if (pageid == 10) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP> 
<b>Appraisal</b></td><%} else {%> <td class="main_tab_inactive" WIDTH="12%" NOWRAP><a

		href="javascript:gotoPage('per_common_assessment.jsp')" 
		onMouseOut="window.status='';return true;" 
		onMouseOver="window.status='Appraisal';return true;"
		> <b>Appraisal</b></a></td>
<%}
}
}
	}

}%> 

<!--<%
//if(!prd_type.equalsIgnoreCase("pR") && !((prd_type.equalsIgnoreCase("pM")||prd_type.equalsIgnoreCase("pI")) && strSchemeCode.equalsIgnoreCase("OD")))
//{
//if((!(strRepaymenttype.equalsIgnoreCase("1")) && !strRepaymenttype.equalsIgnoreCase("") && !prd_type.equalsIgnoreCase("pG")) || (prd_type.equalsIgnoreCase("pG") &&strRepaymenttype.equalsIgnoreCase("14") ))
//{
	//if(pageid==50)
	//{
	%>
	<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Repayment Schedule</b></td>
	<%
	//}
	//else
	//{
	%>
	<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoPage('per_RepaymentSchedulenonemi.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>RepaymentSchedule</b></a></td>
	<%
	//}	
	
	//if(pageid==52)
	//{
	%>
	<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Terms of Repayment</b></td>
	<%
	//}
	//else
	//{
	%>
	<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoPage('com_repaycomment.jsp')"><b>Terms of Repayment</b></a></td>
	<%
	//}%>
	
	
<%//}}%>
--><%


	if(pageid==11)
	{
	%>
	<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>MIS/CBS Details</b></td>
	<%
	}
	else
	{
	%>
	<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoPage('misdetails.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>MIS/CBS Details</b></a></td>
	<%
	}%>
	<%
 if(!strBuiId.equalsIgnoreCase("") && !strBuiId.equalsIgnoreCase("NR"))
 {

if(pageid==18)
{
%>
<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Rating</b></td>
<%
}
else
{
%>
<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
<a href="javascript:gotoPage('perrating.jsp')" onMouseOut="window.status='';return true;" 
		onMouseOver="window.status='Workflow';return true;"><b>Rating</b></a></td>
<%} } %>



 
<!--  <%

	if((!prd_type.equalsIgnoreCase("pR")&&!prd_type.equalsIgnoreCase("pG")))
	{
	if(pageid==13)
	{
	%>
	<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Queries</b></td>
	<%
	}
	else
	{
	%>
	<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
	<a href="javascript:gotoPage('appqueryhome.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>Queries</b></a></td>
	<%
	}}%> -->
<%if (pageid == 7) {%> <td class="main_tab_active" WIDTH="12%" NOWRAP><b>Workflow</b></td><%} else {%><td class="main_tab_inactive" WIDTH="12%" NOWRAP>	
<a
			href="javascript:gotoPage('appworkflowhistory.jsp')"
			onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"
			><b>Workflow</b></a></td><%}%> </tr> </table><%
	if (!prd_type.equalsIgnoreCase("")) 
	{
		productcode = prd_type.substring(0, 1);
		if (productcode.equalsIgnoreCase("a") && (pageid == 8 || pageid==10)) 
		{
      %> <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"> 
<tr> <td class="page_flow">Home <% 
					if(strcategorytype.equals("AGR") && (pageid==8 || pageid==10))
					{%> -&gt; Agriculture <%  }
					else if(strcategorytype.equals("LAD") && pageid==8)
					{%> Loan Against Gold Ornaments &amp; 
Deposits <%  }
					
					 if(pageid==10){ %> -&gt; Appraisal<%} %> 
-&gt; <span id="agripath"></span> </td></tr> </table><lapschoice:application /> 
<%}
			}

			%> 
			
			<input type="hidden" name="hiPgDist" value="P"> <input type="hidden" name="pageid" value="<%=pageid%>"> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<input type="hidden" name="pagetype1" value=""> 
<input type="hidden" name="hidProposalNum" value="<%=Helper.correctNull(request.getParameter("appno"))%>"> 
<input type="hidden" name="hidApplicationNum" value="<%=Helper.correctNull(request.getParameter("inwardno"))%>">

</BODY>
</HTML>
