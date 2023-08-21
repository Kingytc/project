<%
	/*
	 Module Name:	Proposal Links
	 Page Name:		proposallink.jsp
	 Project:		UBI
	 Modified By:	Muralidharan & Namrata & Sureshkumar
	 Modified For:	SME & AGRICULTURE
	 Last Modified By  : Venu
	 Modified For :      Tertiary Module
	 */
%>
<%@include file="../share/directives.jsp"%>
<%
	int pageid = Integer.parseInt(request.getParameter("pageid"));
	String cattype = Helper.correctNull((String) request.getParameter("cattype"));
	String ssitype = Helper.correctNull((String) request.getParameter("ssitype"));
	String strcattype = Helper.correctNull((String) request.getParameter("hidCategoryType"));
	String strMisFlag=Helper.correctNull((String)session.getAttribute("strSessionMisFlag"));
	if (cattype.equalsIgnoreCase("")) {
		cattype = strcattype;
	}
	String strPropformat=Helper.correctNull((String)session.getAttribute("Propformat"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strFinancialReq=Helper.correctNull((String)session.getAttribute("strFinancialReq")).trim();
	String strRatingTabHide=Helper.correctNull((String)session.getAttribute("strRatingTabHide")).trim();
	String strPRD_CGTMSE=Helper.correctNull((String) session.getAttribute("PRD_CGTMSE"));
	String strWHTDIGIPRDRAT=Helper.correctNull((String)hshValues.get("strWHTDIGIPRDRAT"));
	String strcgssdType=Helper.correctNull((String)session.getAttribute("strcgssdType")).trim();
	
	String strAPPLOANSUBTYPE_DIGI=Helper.correctNull((String)session.getAttribute("APP_LOANSUBTYPE_DIGI"));
%>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function gotoPage(page)
{
	if(document.forms[0].cmdsave)
	{
		if(document.forms[0].cmdsave.disabled==true)
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
			document.forms[0].submit();
		}
		else
		{
			ShowAlert('103');
		}
	}
	else
	{
		  if(pagename=="misdetails.jsp")
			{
					
				document.forms[0].hidBeanId.value="mis";	
				document.forms[0].hidBeanGetMethod.value="getMISDetails";
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/misdetails.jsp";
				document.forms[0].target="mainFrame";
				document.forms[0].submit();
			}
		  else
		  {
			  document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+page;
			   document.forms[0].submit(); 
		  }
		
	}
}

function showpage(url,method)
{

	if((document.forms[0].cmdsave && document.forms[0].cmdsave.disabled==true) || (document.forms[0].cmdsavRe && document.forms[0].cmdsave.disabled==true))
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].method="post";
	
		if(url=="finratio.jsp")
		{
				var type="RA1";
				document.forms[0].hidBeanId.value="financial";
				document.forms[0].hidBeanGetMethod.value="getDataRatio";
				document.forms[0].action = appUrl+"action/finratio.jsp?&pageFrom=RA1";
				document.forms[0].submit();
		///	alert("In 2");
			
		///	document.forms[0].hidBeanId.value="financial";
			/////document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		else if(url=="finmiddle.jsp")
		{
			
			document.forms[0].hidBeanId.value="comproposal" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		else if (url=="com_finprop.jsp")
		{
			document.forms[0].hidBeanId.value="financial";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		else if(url == "com_priworkcapital.jsp")
		{
			document.forms[0].hidBeanId.value="bankgetdata" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		
		else if(url == "com_workassesscomment.jsp")
		{
			document.forms[0].hidBeanId.value="comproposal" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		else if(url == "exec_page3.jsp" || url == "com_collateral.jsp" || url=="exec_page1.jsp")
		{
			document.forms[0].hidBeanId.value="executive" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		else if(url == "com_gridcomments.jsp")
		{
			document.forms[0].hidBeanId.value="executive" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		else if(url=="rocdetails.jsp")
		{
			document.forms[0].hidBeanId.value="commappmaster" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		
		else if(url=="adv_borrowingpower.jsp")
		{
			document.forms[0].hidBeanId.value="ADV1151" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		else if(url=="adv_financials.jsp")
		{
			document.forms[0].hidBeanId.value="ADV1151" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?pageval=FI";
		}
		else if(url=="adv_meanscapital.jsp")
		{
			document.forms[0].hidBeanId.value="ADV1151" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url=="com_projectedsales.jsp")
		{
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=2";
		}
		else if(url=="ops_checklist.jsp")
		{
			document.forms[0].hidBeanId.value="govtsponschklist";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url=="com_others.jsp")
		{
			//document.forms[0].hidPage.value="term";
			document.forms[0].hidBeanId.value="inwardRegister" ;
			document.forms[0].hidBeanGetMethod.value="getOthersDetails";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?hidPage=term";
		}
		else if(url=="com_securities.jsp") 
		{
			document.forms[0].hidBeanId.value="comsecurities" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}

		else if(url=="com_assessmentselection.jsp")
		{
			
			document.forms[0].hidBeanId.value="executive" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}

		else if(url == "com_implnschedule.jsp")
		{
			document.forms[0].hidBeanId.value="executive" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url == "com_recommendation.jsp")
		{
			document.forms[0].hidBeanId.value="executive" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url=="com_Rbiloanpolicyguide.jsp")
		{
			document.forms[0].hidBeanId.value="compro" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url == "com_delegation.jsp")
		{
			document.forms[0].hidBeanId.value="executive" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url== "comrating.jsp")
		{		
			document.forms[0].hidBeanId.value="perapplicant" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?strFromN=T";
		
		}
		else if(url== "msmeScoreCard.jsp")
		{		
			document.forms[0].hidBeanId.value="MsmeDigitalAppInterface" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;		
		}
		else if(url == "com_Exposuretoindustry.jsp")
		{
			document.forms[0].hidBeanId.value="comproposal" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url == "com_ratification.jsp")
		{
			document.forms[0].hidBeanId.value="executive" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url == "comtermsandcond.jsp")
		{
			document.forms[0].hidBeanId.value="apptermscond" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url == "facility_mclr.jsp")
		{
			document.forms[0].hidBeanId.value="facilities" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else if(url == "comratingotherdetails.jsp")
		{
			document.forms[0].hidBeanId.value="perapplicant" ;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		}
		else
		{
			document.forms[0].hidBeanId.value="comproposal";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
		}
		
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function call_comments(url,method,type)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
}

function callFunction(pagename,methodname,param,tabname)
{

	if(methodname=="getGeneralDetails")
	{
		document.forms[0].hidparam.value =param;
	}
	document.forms[0].method="post";
	document.forms[0].hidBeanId.value="comssiaboveten"
	document.forms[0].hidTabName.value=tabname;	
	document.forms[0].hidMethod.value=methodname;
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function call_page_diff(url,bean,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}

function doClose()
{

 var cattype=document.forms[0].hidCategoryType.value;

 	if(cattype=="OPS")
        {
	        if(ConfirmMsg(100))
		 	{
			 document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
			 document.forms[0].submit();
		 	}
		}
	else
	  {		
		if( ConfirmMsg(100) )
		{
			 document.forms[0].action=appUrl+"action/corppge.jsp";
			 document.forms[0].submit();
		}
	 }
}

function doclose()
{
	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function onclose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function onClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callLink(url,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
	document.forms[0].submit();
}
 
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
	if (!cattype.equals("OPS")) {
		if (!cattype.equals("ASSI")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="1"
	class="outertable">
	<tr>
		<td align="center" id="idvalues"><b>&nbsp;&nbsp;<span class="red">(Rs. in <%=Helper.correctNull(
									(String) request.getParameter("valuesin"))
									.equalsIgnoreCase("L") ? "Lacs" : Helper
							.correctNull(
									(String) request.getParameter("valuesin"))
							.equalsIgnoreCase("C") ? "Crores" :Helper.correctNull((String)request.getParameter("valuesin")).equalsIgnoreCase("R")?"Rupees":""%>)&nbsp;</span></b></td>
		<td width="5%"><lapschoice:appltolbar strModule="2" /></td>
	</tr>
</table>
<%
	}
	} else {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="1"
	class="outertable">
	<tr>
		<td width="95%"><b>&nbsp;&nbsp;<FONT color="red" size="3">(All Values
		are in Rs.)</FONT></b></td>
		<td width="5%"><lapschoice:appltolbar strModule="3" /></td>
	</tr>
</table>
<%
	}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<% if (cattype.equals("CORP") || cattype.equals("SME") || cattype.equals("AGR")) {
			/*if (cattype.equals("CORP") || (cattype.equals("SME")))  {*/
		%>
		<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="1"
			class="outertable" align='center'>
			<tr align="center">
				<%
					if (pageid == 1) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Basic Information
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:gotoPage('com_companydet.jsp')"> Basic Information </a></b></td>
				<%
					}
				%>
			<!-- 	<%
					if (pageid == 2) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Evaluation </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('exec_page3.jsp','getData3')">
				Evaluation</a></b></td>
				<%
					}
				%>
				 -->
				<%
					if (pageid == 3) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap" style="display:none"><b>Audit
				Observations </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap" style="display:none"><b> <a
					href="javascript:gotoTab(appURL,'comproposal','getDataComment','com_auditobserv.jsp')">Audit
				Observations</a></b></td>
				<%
					}
				%>
				<!-- 
				<%
					if (pageid == 17) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Take Over Norms
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b><a
					href="javascript:showpage('com_istakeover.jsp','gettakeover')">Take
				Over Norms </a></b></td>
				<%
					}
				%>
				<%
					if (pageid == 6) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap"><b>ROC Details </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><b> <a
					href="javascript:showpage('rocdetails.jsp','getrocdetails')">ROC
				Details</a> </b></td>
				<%
					}
				%>
				
				 -->
				<%
					if (pageid == 20) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap" ><b>Audit
				Observations </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_Rbiloanpolicyguide.jsp','getcom_Rbiloanpolicyguidedata')">Audit
				Observations</a> </b></td>
				<%
					}
				%>
				
				
				<%
					if (pageid == 15) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Business Turn
				Over </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_others.jsp','getOthersDetails')">Business
				Turn Over </a> </b></td>
				<%
					}
				%>
				
				<%
					if (pageid == 22) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Exp to Industry / Other Info.</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_Exposuretoindustry.jsp','getExposureIndustry')">Exp to Industry / Other Info.</a> </b></td>
				<%
					}
				%>
				<%if(strSessionModuleType.trim().equalsIgnoreCase("AGR")){ 
					if(strFinancialReq.equalsIgnoreCase("Y")) { 
						if (pageid == 8) {
							
							%>
							<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Financial
							Analysis </b></td>
							<%
								} else {
							%>
							<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b><a
								href="javascript:showpage('finratio.jsp','getDataRatio')">Financial
							Analysis </a></b></td>
							<%
								}
					%>
					<% } } 
				else {
					if(!strcgssdType.equalsIgnoreCase("Y")){
						if (pageid == 8) {
					
					%>
					<td colspan="2" class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Financial
					Analysis </b></td>
					<%
						} else {
					%>
					<td colspan="2" class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b><a
						href="javascript:showpage('finratio.jsp','getDataRatio')">Financial
					Analysis </a></b></td>
					<%
						}} }
					%>


			
							<%

					if (pageid == 41) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Assessment</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b><a
					href="javascript:showpage('com_assessmentselection.jsp','getAssessmentSelection')">Assessment </a></b></td>
				<%
					}
				%>
				<%if(strcgssdType.equalsIgnoreCase("Y")){
					if (pageid == 99) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap" colspan="3"><b>Implementation Schedule
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"  colspan="3"><b> <a
					href="javascript:showpage('com_implnschedule.jsp','getImplnScheduleData')">Implementation Schedule</a> </b></td>
				<%
					}}else{
				%>
				<%
					if (pageid == 99) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap" colspan="2"><b>Implementation Schedule
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"  colspan="2"><b> <a
					href="javascript:showpage('com_implnschedule.jsp','getImplnScheduleData')">Implementation Schedule</a> </b></td>
				<%
					}}
				%>
			
			</tr>
				<tr align="center">
			
			<% if (pageid == 28) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Repayment Schedule
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_fac_repayment.jsp','getTermFinanceFac')">Repayment Schedule</a> </b></td>
				<%
					}
				%>
				
			
				<%
					if (pageid == 9) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Terms&amp;Conditions</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('comtermsandcond.jsp','getComFacilityTermData')">Terms&amp;Conditions</a> </b></td>
				<%
					}
				%>
				
				<%
				    if(strRatingTabHide.equalsIgnoreCase("N")){
				    	
				    	if(strAPPLOANSUBTYPE_DIGI.equalsIgnoreCase("PC")){
				%>
					<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('comratingotherdetails.jsp','getotherratingParameters')">Rating</a> </b></td>
				<%}else{ %>
					<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('comrating.jsp','getRetailrating')">Rating</a> </b></td>
				<%}}%>
				
				<%
				if (pageid == 14) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Credit /
				Inspection Report </b></td>
				<%
					} else {
				%>
				<!-- Credit/Inspection Report is removed from corp application because
				these details are gtting from Customer profile by Venkat on 11/12/13-->
				<!--<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a

					href="javascript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getComInspectionReport','com_pre_SanctionInspectionReport.jsp')">Credit
				/ Inspection Report </a> </b></td>-->
				<%
					}
				%>
								
				<%

					if (pageid == 26) {
				%>
				<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>MIS/CBS Details</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap">
	<a href="javascript:gotoPage('misdetails.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>MIS/CBS Details</b></a></td>
				<%
					}
				%>
				
				
					<%
					if (pageid == 35) {
				%>
				<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>Due Diligence Report / BIR</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap">
	<a href="javascript:gotoTab(appURL,'documentsupport','getdueReport','due_report.jsp')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>Due Diligence Report / BIR</b></a></td>
				<%
					}
				%>
				
				
				
				
				<%

					if (pageid == 29) {
				%>
				<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>Reference Rate</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap">
	<a href="javascript:showpage('facility_mclr.jsp','getFacilityMCLRDetails')" onMouseOut="window.status='';return true;" 
			onMouseOver="window.status='Workflow';return true;"><b>Reference Rate</b></a></td>
				<%
					}
				%>
				<%
if(strPropformat.equalsIgnoreCase("4"))
{
					if (pageid == 27) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Ratification / Permission		
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_ratification.jsp','getRatificationComments')">Ratification / Permission</a> </b></td>
				<%
					}}
else
{
	  if (pageid == 27) {%>
				
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Recommendation/Ratification	
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_recommendation.jsp','getRecommendationData')">Recommendation/Ratification</a> </b></td>
				<%
					}}%>
				
				<%

					if (pageid == 10) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Prop Flow/Exec Summary</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_delegation.jsp','getDelegationData')">Prop Flow/Exec Summary
				</a></b></td>
				<%
					}
				%>
				<!-- <%
					if (pageid == 25) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Grid Observation
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('com_gridcomments.jsp','getGridObservationData')">Grid
				Observation</a> </b></td>
				<%
					}
				%>

				 -->
				<%
					if (pageid == 7) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>WorkFlow </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b> <a
					href="javascript:showpage('appworkflowhistory.jsp','getHistory')">WorkFlow</a>
				</b></td>
				<%
					}
				%>
			</tr>
		</table>
		</td>
		<%
			} else if (cattype.equals("OPS")) {
		%>
		<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="1"
			align='center'>
			<tr align="center">
				<%
					if (pageid == 18) {
				%>
				<td class="main_tab_active" WIDTH="12%"><b>Means &amp;
				Capital</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:showpage('adv_meanscapital.jsp','getMeansCapital')">Means
				&amp; Capital </a></b></td>
				<%
					}
				%>
				<%
					if (pageid == 3) {
				%>
				<td class="main_tab_active" WIDTH="12%"><b>Audit
				Observations </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:gotoTab(appURL,'comproposal','getDataComment','com_auditobserv.jsp')">Audit
				Observations</a></b></td>
				<%
					}
				%>
				<%
					if (pageid == 17) {
				%>
				<td class="main_tab_active" WIDTH="12%"><b>Take Over Norms
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:showpage('com_istakeover.jsp','gettakeover')">Take
				Over Norms </a> </b></td>
				<%
					}
				%>
				<%
					if (pageid == 13) {
				%><td class="main_tab_active" WIDTH="12%"><b>Financial
				Analysis </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:gotoPage('ops_generatefinanalysis.jsp')">Financial
				Analysis </a> </b></td>
				<%
					}
				%>
				
				<%
					if (pageid == 9) {
				%>
				<td class="main_tab_active" WIDTH="12%"><b>Terms&amp;Conditions</b></td>
				<%
					} else {
				%><td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:gotoPage('comtermsandcond.jsp','')">Terms&amp;Conditions</a> </b></td>
				<%
					}
				%>
				<%
					if (pageid == 31) {
				%><td class="main_tab_active" WIDTH="12%"><b>Check
				List </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:showpage('ops_checklist.jsp','getgovtQuestParameters')">Check
				List </a></b></td>
				<%
					}
				%>
				<%
					if (ssitype.equalsIgnoreCase("WADV")) {
				%>
				<%
					if (pageid == 19) {
				%><td class="main_tab_active" WIDTH="12%"><b>ADV1151</b></td>
				<%
					} else {
				%><td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:showpage('adv_borrowingpower.jsp','getadvBorrowingPower')">ADV1151</a></b></td>
				<%
					}
				%>
				<%
					}
				%>
				<%
					if (pageid == 7) {
				%><td class="main_tab_active" WIDTH="12%"><b>WorkFlow
				</b></td>
				<%
					} else {
				%><td class="main_tab_inactive" WIDTH="12%"><b> <a
					href="javascript:showpage('appworkflowhistory.jsp','getHistory')">WorkFlow</a>
				</b></td>
				<%
					}
				%>
			</tr>
		</table>
		</td>
		<%
			}
		%>
	</tr>
</table>
</body>
