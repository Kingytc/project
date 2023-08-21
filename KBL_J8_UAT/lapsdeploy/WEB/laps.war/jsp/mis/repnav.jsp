<%@include file="../share/directives.jsp"%>
<%String grpRights = (String) session.getAttribute("strGroupRights");
			session.setAttribute("pageType", "New");
			String DigiOrgCode = Helper.correctNull((String) session.getAttribute("strOrgCode"));
		String orglevel= Helper.correctNull((String) session.getAttribute("strOrgLevel"));
//out.println(DigiOrgCode);
//out.println(test);
%>
<HTML>
<HEAD>
<TITLE>Laps Retail Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename,param)
{
	document.forms[0].hidreportmis.value=param;
  	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename+"?report="+param;
  	document.forms[0].submit();
}
function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</HEAD>
<BODY>
<form name="navigation" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" height="150">
		<tr>
		<td>&nbsp;</td>
	</tr>
			<tr>
				<td width="33%" valign="middle">
				<TABLE WIDTH="20%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
					<TR>
						<%if (grpRights.charAt(17) == '1') {%> 
						<TD class="menubackflow"><b><A HREF="javascript:callFunction('apprepnav.jsp')">Retail Reports</A></b></TD> 
						<%} else {%><td class="disabledmenu"> Retail Reports</td><%}%>
					</TR>
					<tr>						
						<%if (grpRights.charAt(17) == '1') {%> 
						<TD class="menubackflow"><b><a href="javascript:callFunction('comrepappnav.jsp','REP')">Corporate & Agriculture Reports </a></b></td> 
						<%} else {%><td class="disabledmenu">Corporate Reports</TD><%}%>
					</TR>
					<tr>						
						<%if (grpRights.charAt(17) == '1') {%> 
						<TD class="menubackflow"><b><a href="javascript:callFunction('ratingreportnav.jsp')">Rating Reports </a></b></td> 
						<%} else {%><td class="disabledmenu">Rating Reports </TD><%}%>
					</TR>
					<!--<TR>
						<%if (grpRights.charAt(17) == '1') {%> 
						<TD class="menubackflow"><b><A HREF="javascript:callFunction('tertiary_report.jsp')">Tertiary Reports</A></b></TD>
						<%} else {%><td class="disabledmenu">Tertiary Reports</TD> <%}%>
					</TR>
					<tr>
					<%if (grpRights.charAt(17) == '1') {%> 
					<TD class="menubackflow"><b><A HREF="javascript:callFunction('npareplist.jsp')"> NPA Reports</A></b></TD>
					<%} else {%><td class="disabledmenu">NPA Reports</td><%}%>
					</tr>
					<tr>
					<%if (grpRights.charAt(17) == '1') {%>
					<TD class="menubackflow"><b><a href="javascript:callFunction('mon_front_selectreport.jsp')">Monitoring Report</a></b></TD>
					<%} else {%><td class="disabledmenu">Monitoring Reports</td><%}%>
					</tr>-->
					<tr>
					<%if (grpRights.charAt(17) == '1') {%>
					<TD class="menubackflow"><b><a href="javascript:callFunction('generalreportnav.jsp')">General Report</a></b></TD>
					<%} else {%><td class="disabledmenu">General Reports</td><%}%>
					</tr>
					<tr>
					<%if (grpRights.charAt(17) == '1') {%>
					<TD class="menubackflow"><b><a href="javascript:callFunction('OnlineReport.jsp')">Online Report</a></b></TD>
					<%} else {%><td class="disabledmenu">Online Report</td><%}%>
					<!--<tr>
					<TD class="menubackflow"><b><a href="javascript:callFunction('per_onlinestatusreport.jsp')">Online Status Report</a></b></TD>
					
					</tr>
					--><tr>
					<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('per_securityvaluationreport.jsp')">Security Valuation Report</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('per_lsrrreport.jsp')">Limit Sanction Resolution Register</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('perrepSecVerPend.jsp')"> Security Verification pending Report </a></b></TD>
					</tr>
					 <tr>
                       <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('custdet.jsp','C')">
                      	Customer Proposals</a></b></TD>
           	          </tr>
                     <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('custdet.jsp','U')">
                         	Proposals with User</a></b></TD>
                      </tr>
                       <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('per_lsrrreport.jsp','ADHOC')">
                         	Adhoc Report</a></b></TD>
                      </tr>
                       <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('comrepappnav.jsp','CGTMSE')">
                         	CGTMSE Reports</a></b></TD>
                      </tr>
                      <%if(Helper.correctNull((String)session.getAttribute("strUserGrpId")).equalsIgnoreCase("1")){ %>
                      <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('interestReport.jsp','interestReport')">
                         	Spread Updation Reports</a></b></TD>
                      </tr>
                       
                      
                      <tr>
					<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('app_spreadsheet.jsp','SPSH')">Spread Updation Reports I</a></b></TD>
					</tr>
                      <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('interestReport2.jsp','interestReport')">
                         	Spread Updation Reports II</a></b></TD>
                      </tr>
                      <%} %>
                        <tr>
                      
                        <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('com_datavalreport.jsp','DataValuation')">
                         	Data on Valuation Reports</a></b></TD>
                      </tr>
                      <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('msmereport.jsp','MSME')">
                         	MSME Reports</a></b></TD>
                      </tr>
                       <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('app_creditsalereport.jsp','CREDIT')">
                         	Credit Sale Report</a></b></TD>
                      </tr>
                      <tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('per_solvencyreport.jsp','BANKER')">Banker's Certificate Report</a></b></TD>
					</tr>
					<%if (orglevel.equalsIgnoreCase("A")) {%>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('goldreappraisalrep.jsp','BANKER')">Gold Loan Reappraisal Pending for Verification</a></b></TD>
					</tr>
					<tr>
						<TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('goldornaments.jsp','BANKER')">Reappraisal of Gold Ornaments</a></b></TD>
					</tr>
					<%}%>
                      <%if (DigiOrgCode.equalsIgnoreCase("001007001131000")) {%>
                      <tr>
                         <TD class="menubackflow" nowrap="nowrap"><b><a href="javascript:callFunction('dcoe_report.jsp','DCOE')">
                         	DCOE Report</a></b></TD>
                      </tr>
					<%}%>
					<tr>
		<td>&nbsp;</td>
	</tr>
				</TABLE>
				</td>				
			</tr>
		</table>
		</td>
	</tr>	
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
</table><br>
<input type="hidden" name="hidreportmis"/>
<lapschoice:combuttonnew btnenable=''/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</BODY>
</HTML>
