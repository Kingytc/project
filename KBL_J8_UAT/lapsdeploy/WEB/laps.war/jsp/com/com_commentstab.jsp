<%@include file="../share/directives.jsp"%>
<%int tabid =Integer.parseInt(request.getParameter("tabid"));

%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	
	String strSessionModule="",strAssessment="";
	strSessionModule=Helper.correctNull((String)request.getParameter("sessionModuleType"));
    String StrSchemeType=Helper.correctNull((String)request.getParameter("strschemeType"));
    if(StrSchemeType.equalsIgnoreCase(""))
    {
    	StrSchemeType=Helper.correctNull((String) hshValues.get("strschemeType"));
    }
	
	if(tabid==8)
	{
		 strAssessment = Helper.correctNull((String) hshValues.get("COM_ASSESSMENTTYPE"));
	}
	else
	{	
		 strAssessment = Helper.correctNull(request.getParameter("strAssessment"));
	}

	String strDesc[] = { "Turn Over", "Expenditure",
			"Cash Flow Statement", "Method 1 of lending other than export limits", "Method 2 of lending other than export limits",
			"Working Capital Gap method for export limits","Other Assessment for WCDPN/WCTL","Term loan assessment",
			"DSCR","Cash Budget Method","Other Assessment for TL","Other than LC/BG","Agriculture Assessment","Assessment Comments","Assessment for Restructuring","Assessment for Adhoc Facilities"};
	
	String strValue[] = { "TO", "Exp", "CFS", "MED1" ,"MED2","WCGMED","AOW","EXPORTCF","DSCR","CASHBUD","AOA","NFA","FB","ACOM","AOR","AAF"};
	String strapptype=Helper.correctNull((String) session.getAttribute("strAppType"));

	
	
%>
<script>
	function gototab(beanid,methodname,pagename,flowtype)
	{
				 
			document.forms[0].hidBeanId.value=beanid;
			document.forms[0].hidBeanGetMethod.value=methodname;
			if(document.forms[0].flowtype1)
			{
				document.forms[0].flowtype1.value="";
			}
			document.forms[0].action=appURL+"action/"+pagename+"?flowtype="+flowtype;
			document.forms[0].submit();
		
	}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td>
			<table  border="0" cellspacing="1" cellpadding="3" class="outertable" width="30%"> 
				<tr align="center">	
					<% if(tabid==8){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Assessment Type</td>
					<%}else { %>				
				        <td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('executive','getAssessmentSelection','com_assessmentselection.jsp',8)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT TYPE';return true;"> 
				        Assessment Type</a> </td>															
					<%} %>
					
					<% if(StrSchemeType.equalsIgnoreCase("")){
					if(tabid==33){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Sales Justification</td>
					<%}else { %>				
				        <td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('compro','getFinancialComments','com_salesjustification.jsp',33)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='SALES JUSTIFICATION';return true;">Sales Justification</a> </td>															
					<%} }%>
					
					<!--
					
					<% if(tabid==33){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Sensitivity Analysis</td>
					<%}else { %>				
				        <td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('financial','getSensitiveData','com_dynamicstresscashflow.jsp',33)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='SENSITIVITY ANALYSIS';return true;"> 
				        Sensitivity Analysis</a> </td>															
					<%} %>				
					
					--><% if(strAssessment.contains("TO"))
					{
						if(tabid==9){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Turn Over Method</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('comproposal','getturnoverMethod','com_turnovermethod.jsp',9)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='TURNOVER METHOD';return true;"> 
		            		Turn Over Method</a> 
		            	</td>
		            <%}}%>	
		            
					<% if(strAssessment.contains("Exp"))
					{
						if(tabid==10){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Expenditure Method</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('comproposal','getexpenditureMethod','com_expendituremethod.jsp',10)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='EXPENDITURE METHOD';return true;"> 
		            		Expenditure Method</a> 
		            	</td>																	
																					
					<%}}%>
					
					<% if(strAssessment.contains("CFS"))
					{
						if(tabid==11){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Cash Flow</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('comproposal','getCashFlow','com_cashflow.jsp',11)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='CASH FLOW';return true;"> 
		            		Cash Flow</a> 
		            	</td>																	
																					
					<%}}%>
					
					<% if(strAssessment.contains("PRO"))
					{
						if(tabid==2){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Projected Level of Sales</td>
						<%}else { %>
						<td class="sub_tab_inactive" nowrap style="text-align: center">
							<a href="#" onclick="gototab('comproposal','getDataComment','com_projectedsales.jsp',2)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='PROJECTED LEVEL OF SALES';return true;">
							Projected Level of Sales
							</a>
						</td>
					<%}}%>	
					
					<% if(strAssessment.contains("HOLD"))
					{
						if(tabid==5){ %>
	         			<td class="sub_tab_active" nowrap style="text-align: center"> Holding Levels</td>
						<%}else { %>
	          			<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('comproposal','getDataComment','com_holdinglevels.jsp',5)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT';return true;"> 
	            			Holding Levels </a> 
	            		</td>
					<%}}%>
					
					<% if(strAssessment.contains("CASHBUD"))
					{
						if(tabid==18){ %>
								<td class="sub_tab_active"  nowrap style="text-align: center">Cash Budget Method</td>
								<%}else { %>				
				          <td class="sub_tab_inactive"  nowrap  style="text-align: center"> <a href="#" onclick="gototab('repappcredit','getCashFlowBudget','com_CashBudgetMethod.jsp',18)"
								onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT';return true;"> 
				          Cash Budget Method</a> </td>															
					<%}}%>
					
					
					</tr>
            		<tr>
					<% if(strAssessment.contains("MED1"))
					{
						if(tabid == 77) { %>
          				<td class="sub_tab_active" nowrap style="text-align: center">Method 1 of lending other than export limits</td>
						<%} else {%>					
          				<td class="sub_tab_inactive" nowrap style="text-align: center"><a href="#" onclick="callFlowtype1('M1','MU')"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT - MPBF Upto 25 Crores';return true;"> 
           	 				Method 1 of lending other than export limits</a>
           	 			</td>
            		<%}}%>
            		
            		<% if(strAssessment.contains("MED2"))
					{
						if(tabid == 78) { %>
          				<td class="sub_tab_active" nowrap style="text-align: center">Method 2 of lending other than export limits</td>
						<%} else {%>					
          				<td class="sub_tab_inactive" nowrap style="text-align: center"><a href="#" onclick="callFlowtype1('M2','MU')"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT - MPBF Above 25 Crores';return true;"> 
           	 				Method 2 of lending other than export limits</a>
           	 			</td>
            		<%}}%>
					
					<% if(strAssessment.contains("WCGMED"))
					{
						if(tabid == 1) { %>
          				<td class="sub_tab_active" nowrap style="text-align: center"> Working Capital gap method for export limits </td>
						<%} else {%>					
          				<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="callFlowtype1('AFL','FL')"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT OF WC LIMITS';return true;"> 
           	 				Working Capital gap method for export limits</a>
           	 			</td>
            		<%}}%>
					
					<% if(strAssessment.contains("EXPORTCF"))
					{
						if(tabid==3){ %>					
          				<td class="sub_tab_active" nowrap style="text-align: center"> Term loan assessment</td>
						<%}else { %>					
          				<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('bankapp','getSourceOfMargin','com_existingtermloan.jsp','ExistingTerm')"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='TERM LOAN ASSESSMENT';return true;"> 
            				Term loan assessment</a> 
            			</td>
            		<%}}%>	            		
            		<% if(strAssessment.contains("DSCR"))
					{
						if(tabid==7){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">DSCR</td>
						<%}else { %>				
			          	<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('dscr','getDataForDSCR','DSCR.jsp',7)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT';return true;"> 
			            	DSCR</a> 
			            </td>															
					<%}}%>
					</tr>
            		<tr>
					
            		
					<% if(strAssessment.contains("NFA"))
					{
						if(tabid==4){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Other Non Funded Assessment</td>
						<%}else { %>					
          				<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('comproposal','getDataComment','com_workassesscomment.jsp','4')"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSEMENT OF NON-FUND LIMITS';return true;"> 
            				Other Non Funded Assessment</a> 
            			</td>
            		<%}}%>	
            		
					<% if(strAssessment.contains("AOA"))
					{
						if(tabid==6){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Other Assessment for TL</td>
						<%}else { %>				
          				<td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('comproposal','getDataComment','com_assessment.jsp',6)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='OTHER ASSESSMENT FOR TL';return true;"> 
            				Other Assessment for TL</a> 
            			</td>
            		<%}}%>
            		
            		<% if(strAssessment.contains("AOW"))
					{
						if(tabid==20){ %>
						<td class="sub_tab_active" nowrap style="text-align: center">Other Assessment for WCDPN/WCTL</td>
						<%}else { %>				
          				<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getDataComment','com_assessmentWC.jsp','20')"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='OTHER ASSESSMENT FOR WC';return true;"> 
            				Other Assessment for WCDPN/WCTL</a> 
            			</td>
            		<%}}%>
		
					<% if(strAssessment.contains("ASR"))
					{
						if(tabid==17){ %>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment-Ratio</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('dscr','getDataAssessment','com_mpbfassessment.jsp',17)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT';return true;"> 
		          		 Assessment-Ratio</a> </td>	
		          	<%}}%>	
		          	
		          		
		          			
		          	 <% if(strAssessment.contains("ACOM"))
					{
						if(tabid==34){%>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment Comments</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('compro','getFinancialComments','com_assessment_comments.jsp',34)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT COMMENTS';return true;"> 
		          		Assessment Comments</a> </td>	
		          	<%}}%>		
		          	
		          	 <% if(strAssessment.contains("BGA"))
					{
						if(tabid==35){%>
						<td class="sub_tab_active"  nowrap  style="text-align: center">BG Assessment</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getBGassessment','com_bgassessment.jsp',35)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='BG ASSESSMENT';return true;">BG Assessment</a> </td>	
		          	<%}}%>			          	
		          	</tr>
		          	<tr>
		          	<% if(strAssessment.contains("AOI"))
					{
						if(tabid==32){ %>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment of Inland / Import LC</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getInlandAssessment','com_inlandassessment.jsp',32)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT';return true;"> 
		          		Assessment of Inland / Import LC</a> </td>	
		          	<%}}%>	
		          	
		          	<% if(strAssessment.contains("FB"))
					{
		          		if(tabid==90){ %>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Physical and Financial Programme</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('lapsReport','getFinProgrammePrint','agr_Physicalfinancialproass.jsp',90)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='123';return true;"> 
		          		Physical and Financial Programme</a> </td>	
		          	<%}if(StrSchemeType.equals("aQ"))
					{
						if(tabid==12){ %>
							<td class="sub_tab_active" nowrap style="text-align: center">Assessment of Limit</td>
						<%}else { %>				
					        <td class="sub_tab_inactive" nowrap style="text-align: center"> <a href="#" onclick="gototab('comproposal','getCropLoan','com_croploan.jsp',12)"
							onMouseOut="window.status='';return true;" onMouseOver="window.status='ASSESSMENT TYPE';return true;"> 
					         Assessment of Limit</a></td>															
						<%}%>					
					  <%}
		          		if(tabid==19){ %>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Farm Budget</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getFarmBudget','com_farmbudget.jsp',19)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='FARM BUDGET';return true;"> 
		          		 Farm Budget</a> </td>	
		          	<%}%>											
				    <%if(tabid==31){ %>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Debt Servicing statement</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getDSS','com_dssassessment.jsp',31)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='DSS';return true;"> 
		          		 Debt Servicing statement</a> </td>	
		          	<%}%>	
		          	<% 
					}if(strAssessment.contains("AOR"))
					{ %>
					<%if(tabid==36){ %>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for Restructuring</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getRestructuringAss','com_restructureassessment.jsp',31)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment of Restructuring';return true;"> 
		          		 Assessment for Restructuring</a> </td>	
		          	<%}%>
					<%}if(strAssessment.contains("AAF"))
					{ %>
					<%if(tabid==37){ %>
						<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for Adhoc Facilities</td>
						<%}else { %>				
		          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getDataComment','com_AdhocFacilityassessment.jsp',37)"
						onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for Adhoc Facilities';return true;"> 
		          		 Assessment for Adhoc Facilities</a> </td>	
		          	<%}%>
					<%}
					if(!strapptype.equalsIgnoreCase("S")){
						if(strAssessment.contains("KSAE"))
					
					{ %>
					<%if(tabid==38){ %>
					<td class="sub_tab_active"  nowrap  style="text-align: center">Eligiblity for KBL GECL Scheme</td>
					<%}else { %>				
	          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getBGassessment','com_bgassessment.jsp','KSAE')"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for Adhoc Facilities';return true;"> 
	          		 Eligiblity for KBL GECL Scheme</a> </td>	
	          	<%}}}else if(strapptype.equalsIgnoreCase("S")){
					 if(strAssessment.contains("KSAE-Restructure")){%>
	          		<%if(tabid==38){ %>
					<td class="sub_tab_active"  nowrap  style="text-align: center">Eligiblity for KBL GECL Scheme</td>
					<%}else { %>				
	          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getBGassessment','com_bgassessment.jsp','KSAE-Restructure')"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for Adhoc Facilities';return true;"> 
	          		 Eligiblity for KBL GECL Scheme</a> </td>
	          	<% }}}%>
					<% if(strAssessment.contains("FIDPN"))
					{ %>
					<%if(tabid==39){ %>
					<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for Interest Deferment DPN 2020</td>
					<%}else { %>				
	          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getBGassessment','com_bgassessment.jsp','FIDPN')"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for Adhoc Facilities';return true;"> 
	          		 Assessment for Interest Deferment DPN 2020</a> </td>	
	          	<%}}
					if(strAssessment.contains("MMithra"))
					{ %>
					<%if(tabid==40){ %>
					<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for KBL MICRO MITRA upto Rs.2 Lakhs</td>
					<%}else { %>				
	          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getBGassessment','com_bgassessment.jsp','MMithra')"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for Adhoc Facilities';return true;"> 
	          		Assessment for KBL MICRO MITRA upto Rs.2 Lakhs</a> </td>	
	          	<%}}if(!strapptype.equalsIgnoreCase("S")){
					if(strAssessment.contains("AMithra"))
					{ %>
					<%if(tabid==41){ %>
					<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for KBL GECL Scheme</td>
					<%}else { %>				
	          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getBGassessment','com_bgassessment.jsp','GECL')"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for Adhoc Facilities';return true;"> 
	          		Assessment for KBL GECL Scheme</a> </td>	
					<%}}}else if(strapptype.equalsIgnoreCase("S")){
	          	 if(strAssessment.contains("GECL-Restructure")){%>
					<%if(tabid==41){ %>
					<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for KBL GECL Scheme</td>
					<%}else { %>				
	          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getBGassessment','com_bgassessment.jsp','GECL-Restructure')"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for Adhoc Facilities';return true;"> 
	          		Assessment for KBL GECL Scheme</a> </td>
					<%}}} %>
	          	<%if(strAssessment.contains("CGSSD"))
					{ %>
					<%if(tabid==42){ 
					%>
					<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for KBL CGSSD Scheme</td>
					<%}else { %>				
	          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('comproposal','getCgssdAssessment','com_cgssdAssessment.jsp','CGSSD')"
					onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for KBL CGSSD Scheme';return true;"> 
	          		Assesment for KBL CGSSD</a> </td>	
	          	<%}}
	          	
	          	if(strAssessment.contains("Restructure"))
				{ %>
				<%if(tabid==43){ 
				%>
				<td class="sub_tab_active"  nowrap  style="text-align: center">Eligibility under Restructure</td>
				<%}else { %>				
          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('appraisal','getRestruceAssessment','app_restructure_assessment.jsp','Restructure')"
				onMouseOut="window.status='';return true;" onMouseOver="window.status='Eligibility under resolution framework';return true;"> 
          		Eligibility under Restructure</a> </td>	
          	<%}}
	          	%>
	          	
	          	
	          	<% if(strAssessment.contains("PMS3"))
				{ %>
				<%if(tabid==45){ 
				%>
				<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for PM Svanidhi 3.0</td>
				<%}else { %>				
          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('compro','getSvanidhiAssess','PMSvanidhi_assessment3.jsp','PMS3')"
				onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for PM Svanidhi 3.0';return true;"> 
          		Assessment for PM Svanidhi 3.0</a> </td>	
          	<%}}
	          	%>
	          	<% if(strAssessment.contains("ENWR"))
				{ %>
				<%if(tabid==44){ 
				%>
				<td class="sub_tab_active"  nowrap  style="text-align: center">Assessment for e- Krishik Bhandar</td>
				<%}else { %>				
          		<td class="sub_tab_inactive" nowrap  style="text-align: center"> <a href="#" onclick="gototab('executive','geteNWRassessment','agreNWR_assessment.jsp','ENWR')"
				onMouseOut="window.status='';return true;" onMouseOver="window.status='Assessment for e- Krishik Bhandar';return true;"> 
          		Assessment for e- Krishik Bhandar</a> </td>	
          	<%}}
	          	%>
	          	
				<% %>
				 
			
		</table>
	</td>
  </tr>

          
</table>
			</body>