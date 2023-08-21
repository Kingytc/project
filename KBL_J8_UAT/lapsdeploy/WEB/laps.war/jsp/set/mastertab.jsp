<%@ include file="../share/directives.jsp"%>
<%
	int tabid = Integer.parseInt(request.getParameter("tabid"));
%>
<script>
function gotoTab(beanid,method,pagename)
{	
	if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert(103);
		return;
	}
	else
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=method;		
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+ pagename;
		document.forms[0].submit();
	}
}

function callFunction(pagename)
{
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr>
				<%
					if (tabid == 1) {
				%>
				<td align="center" nowrap class="main_tab_active" WIDTH="12%">
				<b> Lawyer Master</b></td>
				<%
					} else {
				%>
				<td align="center" nowrap class="main_tab_inactive" WIDTH="12%">
				<b> <a
					href="JavaScript:gotoTab('staticdata','getLawyerMasterList','lawyermaster.jsp')"
					class="blackfont"> Lawyer Master</a> </b></td>
				<%
					}
					if (tabid == 2) {
				%>
				<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Builder Master </b></td>
				<%
					} else {
				%>
				<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a
					href="JavaScript:gotoTab('staticdata','getBuilderMasterList','buildermaster.jsp')"
					class="blackfont"> Builder Master </a> </b></td>
				<%
					}
					if (tabid == 3) {
				%>
				<td align="center" class="main_tab_active" nowrap WIDTH="14%">
				<b> Appraiser/Valuer's Master </b></td>
				<%
					} else {
				%>
				<td align="center" class="main_tab_inactive" nowrap WIDTH="14%">
				<b> <a
					href="JavaScript:gotoTab('staticdata','getValuerMasterList','valuersmaster.jsp')"
					class="blackfont"> Appraiser/Valuer's Master </a> </b></td>
				<%
					}
					if (tabid == 4) {
				%>
			<!-- 	<td align="center" class="main_tab_active" nowrap WIDTH="14%">
				<b> Co-Op Housing Societies Master </b></td> -->
				<%
					} else {
				%>
			<!--	<td align="center" class="main_tab_inactive" nowrap WIDTH="14%">
				<b> <a
					href="JavaScript:gotoTab('staticdata','getCoopSocietyMasterList','co_opsocietymaster.jsp')"
					class="blackfont"> Co-Op Housing Societies Master </a> </b></td> -->
				<%
					}
					if (tabid == 5) {
				%>
				<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Company Master </b></td>
				<%
					} else {
				%>
				<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a
					href="JavaScript:gotoTab('staticdata','getCompanyMasterList','companymaster.jsp')"
					class="blackfont"> Company Master </a> </b></td>
				<%
					}
				%>
				<%
					if (tabid == 9) {
				%>
				<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Scale Finance Master </b></td>
				<%
					} else {
				%>
				<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a
					href="JavaScript:callFunction('scalefinancemaster.jsp')"
					class="blackfont"> Scale Finance Master </a> </b></td>
				<%
					}
				%>
				<%
					if (tabid == 20) {
				%>
				<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Unit cost / Activity Master </b></td>
				<%
					} else {
				%>
				<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a
					href="JavaScript:gotoTab('staticdata','getActivityMasterData','activitymaster.jsp')"
					class="blackfont"> Unit cost / Activity Master </a> </b></td>
				<%
					}
				%>
			<%
					if (tabid == 10) {
				%>
				<!-- <td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Target Master </b></td>-->
				<%
					} else {
				%>
			<!--	<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('','','targetmasterbranch.jsp')"
					class="blackfont"> Target Master </a> </b></td>-->
				<%
					}
				%>
				<%
					if (tabid == 11) {
				%>
				<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Gold Rate Master </b></td>
				<%
					} else {
				%>
				<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getGoldRateData','goldratemaster.jsp')"
					class="blackfont"> Gold Rate Master </a> </b></td>
				<%
					}
				%>
				</tr>
			<tr>
				<%
					if (tabid == 12) {
				%>
				<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Unit Cost Horti / Plantation </b></td>
				<%
					} else {
				%>
				<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getHorticultureFinanceMasterData','agrscaleoffinancehoriculture.jsp')"
					class="blackfont"> Unit Cost Horti / Plantation </a> </b></td>
				<%
					}
				%>
				<%
					if(tabid==13)
					{%>
						<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b> Crop / Poultry / Fisheries Loan Master </b></td>
					<%}
					else
					{%>
						<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getCorpMasterList','corpLoan_Master.jsp')"
					class="blackfont"> Crop / Poultry / Fisheries Loan Master </a> </b></td>
					<%}
				%>
				<%
					if(tabid==15)
					{%>
						<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b>  Type of Poultry</b></td>
					<%}
					else
					{%>
						<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getTypepoultrymastersdata','Typepoultrymasters.jsp')"
					class="blackfont">  Type of Poultry </a> </b></td>
					<%}
				%>
				<%
					if(tabid==21)
					{%>
						<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b>  FVC Master</b></td>
					<%}
					else
					{%>
						<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getFVCMaster','fvcmasters.jsp')"
					class="blackfont">  FVC Master</a> </b></td>
					<%}
				%>
				<%
					if(tabid==14)
					{%>
						<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b>  Share Value Master</b></td>
					<%}
					else
					{%>
						<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getShareValueMasterData','sharevaluemaster.jsp')"
					class="blackfont">  Share Value Master</a> </b></td>
					<%} 	%>
			
			<%
				if(tabid==16)
					{%>
						<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b>  Business Sourcing Agents/Direct Selling Agents Master</b></td>
					<%}
					else
					{%>
						<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getBSADSAList','BSADSAmaster.jsp')"
					class="blackfont"> Business Sourcing Agents/Direct Selling Agents Master</a> </b></td>
					<%} 	%>
					<%
				if(tabid==215)
					{%>
						<td align="center" class="main_tab_active" nowrap WIDTH="12%">
				<b>  BIR Service provider</b></td>
					<%}
					else
					{%>
						<td align="center" class="main_tab_inactive" nowrap WIDTH="12%">
				<b> <a href="JavaScript:gotoTab('staticdata','getBIRList','BIRmaster.jsp')"
					class="blackfont"> BIR Service Provider</a> </b></td>
					<%} 	%>
					
			</tr>
		</table>
		</td>
	</tr>
</table>

<input type="hidden" name="hidActiveFlag" value="Y">