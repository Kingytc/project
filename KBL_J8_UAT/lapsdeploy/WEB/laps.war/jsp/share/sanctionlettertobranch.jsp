<%@include file="../share/directives.jsp"%>
<%
String strProcessDate=Helper.correctNull((String)hshValues.get("app_processdate"));
if(strProcessDate.equalsIgnoreCase(""))
	strProcessDate=Helper.getCurrentDateTime();
long lngDatediff=Helper.dateDiff(ApplicationParams.getStrRetailTCEffectDate(),strProcessDate);
	String strConstitution="";
	String strStaff="";
	ArrayList arrRow=new ArrayList();
	ArrayList arrayRow=new ArrayList();
	ArrayList arrayTermsRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrayCol=new ArrayList();
	ArrayList arrayTermsCol=new ArrayList();
	ArrayList arrSecRow = new ArrayList();
	ArrayList arrSecCol = new ArrayList();
	ArrayList arrRepaySchedule=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
		arrayRow=(ArrayList)hshValues.get("arrayRow");
		arrayTermsRow=(ArrayList)hshValues.get("arrayTermsRow");
		//arrSecRow = (ArrayList)hshValues.get("arrSecRow");
		arrRepaySchedule = (ArrayList)hshValues.get("arrRepaySchedule");
	}
	strStaff=Helper.correctNull((String)hshValues.get("strStaff"));
	
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strPrimaryComments = Helper.correctNull((String)hshValues.get("cmt_retailprimarycomments")).trim();
	String strCollateralComments = Helper.correctNull((String)hshValues.get("cmt_retailcollateralcomments")).trim();
	String strPrdtype = Helper.correctNull((String) session.getAttribute("strProductType"));
	ArrayList arrROI=new ArrayList();
	arrROI= (ArrayList) hshValues.get("arrROI");
	
	String secValue="";
	ArrayList arrpropsecurityRow=new ArrayList();
	ArrayList arrpropsecCollRow=new ArrayList();
	ArrayList arrpropsecurityCol=new ArrayList();
	ArrayList arrpropsecurity=new ArrayList();
	arrpropsecurityRow=(ArrayList)hshValues.get("arrRowPri");
	arrpropsecCollRow=(ArrayList)hshValues.get("arrRowColl");
	String strStaffPrd=Helper.correctNull((String)hshValues.get("strStaffPrd"));
	int strdaydiff=Integer.parseInt(Helper.correctInt((String)hshValues.get("daydiff")));
	String strProposalType = Helper.correctNull((String)session.getAttribute("strAppType"));
	String strRenewFlg=Helper.correctNull((String)hshValues.get("strRenewFlg"));
	
	String strSessionModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sanction Letter</title>
<script>
function disableStaffNoDesignation()
{
	var varStaff="<%=strStaff%>";
	if(varStaff=="02")
	{
		document.all.id_isStaff.style.visibility="visible";
		document.all.id_isStaff.style.position="relative";
	}
	else
	{
		document.all.id_isStaff.style.visibility="hidden";
		document.all.id_isStaff.style.position="absolute";
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body onload="disableStaffNoDesignation();">
<form name="dopost();">
<table width="98%" style="border: solid 1px #000000" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td>
		<table width="90%" border="0" cellpadding="3" cellspacing="0"  align="center" class="outertable">
		<tr>
			<td>
				<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">
				<tr> 
					<td align="center"><br>
						<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
					</td>
				</tr>
				<tr align="center"> 
					<td> <b>Branch&nbsp;/&nbsp;Office:&nbsp;<%=Helper.correctNull((String) session.getAttribute("strOrgName"))%> </b></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">
		<tr>
			<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<tr> 
					<td colspan="2" width="35%">Branch&nbsp;:&nbsp;<b><%=Helper.correctNull((String)hshValues.get("homebranch"))%></b></td>
					<td colspan="2">Branch Code&nbsp;:&nbsp;<b><%=Helper.correctNull((String)hshValues.get("branchcode"))%></b></td>
					<td colspan="2" width="35%">Region&nbsp;:&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strOrgRegionName"))%></b></td>
				</tr>
				<tr>
				<td <%if(!Helper.correctNull((String)hshValues.get("APP_REFERENCENO")).equalsIgnoreCase("")){ %> rowspan="2"<%} %> width="10%"><b><%if(strProposalType.equalsIgnoreCase("P")){ %>Permission<%}else{ %>Sanction<%} %>Ref No.& Date:&nbsp;</b></td>
					<td colspan="3"><b><%=Helper.correctNull((String)hshValues.get("strSanctRefNum"))%></b></td>
					<td colspan="2" <%if(!Helper.correctNull((String)hshValues.get("APP_REFERENCENO")).equalsIgnoreCase("")){ %> rowspan="2"<%} %>>Sanction Dept:&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strSancAppraisalDept"))%></b></td>
				</tr>
				<%if(!Helper.correctNull((String)hshValues.get("APP_REFERENCENO")).equalsIgnoreCase("")){ %>
				<tr>
				<td colspan="3" ><%=Helper.correctNull((String)hshValues.get("APP_REFERENCENO"))%></td>
				</tr>
				<%} %>
				<tr>
					<td colspan="2">Party file No:</td>
					<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("strPartyFileNo"))%></td>
				</tr>
				<tr id="id_isStaff">
					<td colspan="2">Staff No:</td>
					<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("strStaffID"))%></td>
				</tr>
				<tr>
					<td colspan="2">Applicant/s Name & address</td>
					<td colspan="4">
					<%if(arrRow!=null&&arrRow.size()>0) {
						for(int i=0;i<arrRow.size();i++){
							arrCol=(ArrayList)arrRow.get(i);%>
						&nbsp;<u><%=Helper.correctNull((String) arrCol.get(0))%></u><br>
						<%if(!Helper.correctNull((String) arrCol.get(1)).equalsIgnoreCase("")){ %>
						&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%>,<br>
						<%} %>
						<%if(!Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("")){ %>
						&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%>,
						<%} %>
						<%if(!Helper.correctNull((String) arrCol.get(3)).equalsIgnoreCase("")){ %>
						&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%>,
						<%} %>
						<%if(!Helper.correctNull((String) arrCol.get(4)).equalsIgnoreCase("")){ %>
						&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%>,
						<%} %>
						<%if(!Helper.correctNull((String) arrCol.get(5)).equalsIgnoreCase("")){ %>
						&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%>,<br>
						<%} %>
						&nbsp;<%=Helper.correctNull((String) arrCol.get(6))%> - <%=Helper.correctNull((String) arrCol.get(7))%>,<br>
						&nbsp;<%=Helper.correctNull((String) arrCol.get(8))%>,&nbsp;<%=Helper.correctNull((String) arrCol.get(9))%>.<br>
					<%}}%>
					</td>
				</tr>
				<tr>
					<%if(arrayRow!=null&&arrayRow.size()>0) { %>
					<td colspan="2">Guarantors/Co-obligants Name & Address</td>
					<td colspan="4">
					<%for(int i=0;i<arrayRow.size();i++){
							arrayCol=(ArrayList)arrayRow.get(i);%>
						&nbsp;<u><%=Helper.correctNull((String) arrayCol.get(0))%></u><br>
						<%if(!Helper.correctNull((String) arrayCol.get(1)).equalsIgnoreCase("")) {%>
						&nbsp;<%=Helper.correctNull((String) arrayCol.get(1))%>,<br>
						<%} %>
						<%if(!Helper.correctNull((String) arrayCol.get(2)).equalsIgnoreCase("")) {%>
						&nbsp;<%=Helper.correctNull((String) arrayCol.get(2))%>,
						<%} %>
						<%if(!Helper.correctNull((String) arrayCol.get(3)).equalsIgnoreCase("")) {%>
						&nbsp;<%=Helper.correctNull((String) arrayCol.get(3))%>,
						<%} %>
						<%if(!Helper.correctNull((String) arrayCol.get(4)).equalsIgnoreCase("")) {%>
						&nbsp;<%=Helper.correctNull((String) arrayCol.get(4))%>,
						<%} %>
						<%if(!Helper.correctNull((String) arrayCol.get(5)).equalsIgnoreCase("")) {%>
						&nbsp;<%=Helper.correctNull((String) arrayCol.get(5))%>,<br>
						<%} %>
						&nbsp;<%=Helper.correctNull((String) arrayCol.get(6))%> - <%=Helper.correctNull((String) arrayCol.get(7))%>,<br>
						&nbsp;<%=Helper.correctNull((String) arrayCol.get(8))%>,&nbsp;<%=Helper.correctNull((String) arrayCol.get(9))%>.<br>
					<%}}%>
					</td>
				</tr>
				<%if(strConstitution.equalsIgnoreCase("01")){ %>
				<tr>
					<td colspan="2"><b>Management People Details:</b></td>
					<td colspan="4">&nbsp;</td>
				</tr>
				<%}%>
				</table>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="90%" border="0" align="center" cellpadding="3" cellspacing="3" class="outertable">
		<tr>
			<td align="left"><b>FACILITY DETAILS</b></td>
			<td align="right"><b>Amount in Rs</b></td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
					<tr class="tblhead">
						<td width="25%" align="center"><b>Descriptions</b></td>
						<td width="25%" align="center"><b>Facility</b></td>
						<td width="25%" align="center"><b>Descriptions</b></td>
						<td width="25%" align="center"><b>Facility</b></td>
					</tr>
					<tr>
						<td align="left">Product</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
						<td align="left">Activity of the Borrower</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("custoccupdesc"))%></td>
					</tr>
					<tr>
						<td align="left">Sector</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strMISClassification"))%></td>
						<td align="left">Constitution</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strConstitutionDesc"))%></td>
					</tr>
					<tr>
						<td align="left" rowspan="2">Purpose of Advance</td>
						<td rowspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strAdvancePurpose"))%></td>
						<td align="left" rowspan="2">MIS Classification</td>
								<td align="left">&nbsp;<%=Helper.correctNull((String)hshValues.get("strSector"))%></td>
							
					</tr>
					
					<tr>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strSubSector"))%></td>
					</tr>
				
					<tr>
						<td align="left">MSME Category & Industry name</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("mis_indcattyepagr"))%></td>
					<%if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>	
						<td align="left">Bank Scheme <br><br> Bank Sub Scheme</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc"))%> <br><br>&nbsp;<%=Helper.correctNull((String)hshValues.get("prd_subcatscheme"))%> </td>
					<%} else { %>
						<td align="left">Bank Scheme</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc"))%></td>
					<% } %>
					</tr>
					
						
						<%if(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_metlifepremiumamt")))!=0){ 
						double dblSancAmt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("strSancAmount")))
						-Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_metlifepremiumamt")));
						if(Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF"))
							dblSancAmt=Double.parseDouble(Helper.correctDouble((String)hshValues.get("strSancAmount")));%>
						
						<tr>
							<td align="left" rowspan="3">Govt. Sponsored Scheme</td>
							<td rowspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("strGovt"))%>
							<%if(Helper.correctNull((String)hshValues.get("strGovt")).equalsIgnoreCase("Yes")){ %>
							- <%=Helper.correctNull((String)hshValues.get("strGovtSchDesc"))%>
							<%if(Helper.correctNull((String)hshValues.get("strGovtScheme")).equalsIgnoreCase("078")||Helper.correctNull((String)hshValues.get("strGovtScheme")).equalsIgnoreCase("079")){ %>
							( <%=Helper.correctNull((String)hshValues.get("strGovtCategory"))%>) 
							<%} %>
							<%} %></td>
							<td align="left">Loan Sanction Amount</td>
							<td>&nbsp;<%=nf.format(dblSancAmt)%></td>
						</tr>
						<tr>
						<%if(!Helper.correctNull((String)hshValues.get("strInsCompanyName")).equalsIgnoreCase("")){ %>
							<td align="left"><%=Helper.correctNull((String)hshValues.get("strInsCompanyName")) %></td>
						
						<%}else{%>
							<td align="left">Premium for Met Loan & Life Suraksha</td>
							<%} %>
							<td>&nbsp;<%=Helper.correctDouble((String)hshValues.get("loan_metlifepremiumamt"))%></td>
						</tr>
						<tr>
							<td align="left">Total Loan Sanction Limit</td>
							<td>&nbsp;<%=Helper.correctDouble((String)hshValues.get("strSancAmount"))%></td>
						</tr>
						
						<%}else{ %>
						<tr>
							<td align="left">Govt. Sponsored Scheme</td>
							<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strGovt"))%>
							<%if(Helper.correctNull((String)hshValues.get("strGovt")).equalsIgnoreCase("Yes")){ %>
							- <%=Helper.correctNull((String)hshValues.get("strGovtSchDesc"))%>
							<%if(Helper.correctNull((String)hshValues.get("strGovtScheme")).equalsIgnoreCase("078")||Helper.correctNull((String)hshValues.get("strGovtScheme")).equalsIgnoreCase("079")){ %>
							( <%=Helper.correctNull((String)hshValues.get("strGovtCategory"))%>) 
							<%} %>
							<%} %>
							</td>
							<td align="left">Limit</td>
							<td>&nbsp;<%=Helper.correctDouble((String)hshValues.get("strSancAmount"))%><br/>Without any insurance coverage.</td>
						</tr>
						<%} %>
					
					<tr>
						<td align="left">Period</td>
						<td>&nbsp;<%=Helper.correctInt((String)hshValues.get("strRepayPeriod"))%>&nbsp;Months</td>
						<td align="left">Holiday Period</td>
						<td>&nbsp;<%=Helper.correctInt((String)hshValues.get("strHoliday"))%>&nbsp;Months</td>
					</tr>
					<tr>
						<td align="left">No. of Installments excluding Holiday Period</td>
						<td>&nbsp;<%if(Helper.correctNull((String)hshValues.get("strWhetherEMI")).equalsIgnoreCase("Yes")){%>
						<%=Helper.correctInt((String)hshValues.get("strExcHol"))%>
						<%}else{ %>
						<%=Helper.correctInt((String)hshValues.get("strInstallment"))%>
						<% }%></td>
						<td align="left">Whether EMI</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strWhetherEMI"))%></td>
					</tr>
					<tr>
						<td align="left">Installment Frequency</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPeriodicity"))%></td>
						<td align="left">Interest Debit Frequency</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strIntDemandFreq"))%></td>
					</tr>
					<tr>
						<td align="left">Collect Interest Debit during Holiday period</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strServiced"))%></td>
						<td align="left">Rate of Interest</td>
						<td>&nbsp;
						<%if(strStaffPrd.equalsIgnoreCase("Y"))
						{ 
							if(strPrdtype.equalsIgnoreCase("pH"))
							{
								if(arrROI!=null && arrROI.size()>0)
								{
									for(int s=0;s<arrROI.size();s++)
									{
									arrCol=(ArrayList)arrROI.get(s);%>
									<%=Helper.correctDouble((String)arrCol.get(0)) %> - <%=Helper.correctDouble((String)arrCol.get(1)) %> in <%=Helper.correctDouble((String)arrCol.get(2)) %> %
									<br>
									<%}
								}
								else
								{%>
									<%=Helper.correctDouble((String)hshValues.get("strIntRate"))%>&nbsp; %
								<%}
							}
							else
							{ %>
								<%=Helper.correctNull((String)hshValues.get("strIntType"))%>&nbsp; - &nbsp;<%=Helper.correctDouble((String)hshValues.get("strIntRate"))%>&nbsp;	%	
							<%}
						}else{ %>
						<%if(Helper.correctNull((String)hshValues.get("strIntType")).equalsIgnoreCase("Floating")){
							if(Helper.correctNull((String)hshValues.get("strMCLRFlag")).equalsIgnoreCase("Y")){ %>
							<%=Helper.correctNull((String)hshValues.get("mclr_type")) %>  
							<%}else{ %> Base Rate <%} %>
							&nbsp;<%=Helper.correctNull((String)hshValues.get("strSymbol"))%>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("LOAN_CREDITRSKVAL"))))%>%(Credit Risk Premium)&nbsp;
							&nbsp;<%=Helper.correctNull((String)hshValues.get("strSymbol"))%>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_busstatval"))))%>
							<%if(Helper.correctNull((String)hshValues.get("mclr_passCode")).equalsIgnoreCase("O")){ %>%(Bussiness strategic Premium)&nbsp;
							<%}else{ %>(Fixed Spread)<%} %>
							<br>
						&nbsp;i.e&nbsp;<%} %><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strIntRate"))))%></b>% pa.
						<%
						if((!Helper.correctNull((String)hshValues.get("DEVIATION_PENALITY")).equalsIgnoreCase("") && !Helper.correctNull((String)hshValues.get("DEVIATION_PENALITY")).equalsIgnoreCase("0")) && strPrdtype.equalsIgnoreCase("pH") && Helper.correctNull((String)hshValues.get("APP_LOANSUBTYPE_DIGI")).equalsIgnoreCase("PR")){ %>
						<table>
							<tr>
								<td>
								<b><span class="mantatory"> Note : *&nbsp;  </span>Includes Penal Interest 
									<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("DEVIATION_PENALITY"))))%>% </b>&nbsp;								</td>
							</tr>
						</table>
						<%}} %>
						</td></tr>
					<tr>
						<td align="left">Mode of operation in case of OD</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strModeOfOper"))%></td>
						<%if(!strPrdtype.equalsIgnoreCase("pE")){ %>
						<td align="left">EMI Amount</td>
						<%if(Helper.correctNull((String)hshValues.get("strWhetherEMI")).equalsIgnoreCase("Yes")){%>
						<td>&nbsp;<%=ApplicationParams.getCurrency()%>&nbsp;<%=Helper.correctNull((String) hshValues.get("emi"))%></td>
						<%} else {%>
						<td>&nbsp;Not Applicable</td>
						<%}}else{
						int intTerms = Integer.parseInt(Helper.correctInt((String)hshValues.get("strExcHol")));
						int intHoliday = Integer.parseInt(Helper.correctInt((String)hshValues.get("strHoliday")));
						%>					
						<td>EMI/ Installment Amount</td>
						<td>&nbsp;In <u><%=Helper.correctInt((String)Integer.toString(intTerms))%></u> EMI [EMI will be fixed after Moratorium period of <u><%=Helper.correctInt((String)Integer.toString(intHoliday))%></u> Months]</td>
						<%}%>
						</tr>
						<tr>
						<% if(Helper.correctNull((String)hshValues.get("strProFeeFlag")).equals("W")) { %>
						  <td colspan="2">Processing Charges :  Waived &nbsp;</td>
						<%} else { %>
							<td colspan="2">Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("strProcessingFee")) %></b> 
						
						<% if(strSessionModuleType.equals("DIGI")){ %>
							(Inclusive of all Taxes)
						<% } else { %>		
							+ Applicable Taxes
						<% } %>
							</td>
						<%} %>	
							<% if(strRenewFlg.equals("renewal")) {%>
							<td>Due Date</td>
							<td> <%=Helper.correctNull((String)hshValues.get("LOAN_DUEDATE")) %></td>
							<%} else { %>
							 	<td colspan="2"> &nbsp; </td>
							<% } %>
						</tr>
				</table>
				</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<%if(!Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("NC")&&!Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("")){ %>
					<tr>
						<td width="25%" colspan="4"><b>Insurance Details : </b></td>
					</tr>
					<tr>
						<td width="25%">Premium Tenor<br>(in Months) </td>
						<td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_PREMIUM_TENOR"))%></td>
						<td width="25%">Loan amount covered under the scheme </td>
						<td width="25%">&nbsp;<%=Helper.correctInt((String)hshValues.get("LOAN_PREMIUM_LOAN_AMOUNT"))%>&nbsp;</td>
					</tr>
					<%} %>
			<%if(Helper.correctNull((String)hshValues.get("LOAN_INS_COMPANY_NAME")).equalsIgnoreCase("SF")){ %>
					<tr>
						<td width="25%">Premium Amount </td>
						<td width="25%" colspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("loan_metlifepremiumamt"))%></td>
					</tr>
					<tr>
						<td width="25%">Operative account number from which<br> premium account will be debited </td>
						<td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("LOAN_INS_ACCOUNT_NO"))%></td>
						<td width="25%">Insurance Funded Company Name </td>
						<td width="25%" >&nbsp;<%=Helper.correctInt((String)hshValues.get("strInsFundedCompanyName"))%>&nbsp;</td>
					</tr>
					<%} %>
			</table>
			</td>
			</tr>
		<%if((!Helper.correctNull((String)hshValues.get("strRepayTypeCode")).equalsIgnoreCase("") && !Helper.correctNull((String)hshValues.get("strRepayTypeCode")).equalsIgnoreCase("1")) && arrRepaySchedule!=null && arrRepaySchedule.size()>0)
		{%>
		<tr><td colspan="2"><b>Repayment Schedule</b></td></tr>
		<tr><td colspan="2">
		<div id="top">
		<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">					
		<tr>
		<td align="center" width="4%"><b>S.No</b></td>
		<td align="center" width="32%"><b>Frequency</b></td>
		<td align="center" width="20%"><b>No of Installments</b></td>
		<td align="center" width="20%"><b>Installment Amount</b></td>
		<td align="center" width="20%"><b>Total</b></td>
		</tr>
		<%
		String strFreq = "",strDesc="";
		
			for(int count = 0;count<arrRepaySchedule.size();count++)
			{					
				arrayCol = new ArrayList();
				arrayCol = (ArrayList)arrRepaySchedule.get(count);
		    strFreq = Helper.correctInt((String)arrayCol.get(0));
		    if(strFreq.equalsIgnoreCase("m"))
    		{
		    	strDesc = "Monthly";
    		}					    
		    else if(strFreq.equalsIgnoreCase("q"))
    		{
		    	strDesc = "Quarterly";
    		}
		    else if(strFreq.equalsIgnoreCase("h"))
    		{
		    	strDesc = "Half-Yearly";
    		}
		    else if(strFreq.equalsIgnoreCase("y"))
    		{
		    	strDesc = "yearly";
    		}
		    else if(strFreq.equalsIgnoreCase("n"))
    		{
		    	strDesc = "Not Applicable";
    		}
		    %>
		    <tr>
		    <td><%=count+1%></td>
		    <td><%=strDesc%></td>
		    <td align="right"><%=Helper.correctInt((String)arrayCol.get(1))%></td>
		     <td align="right"><%=Helper.correctInt((String)arrayCol.get(3))%></td>
		    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrayCol.get(2)))%></td>
		    </tr>						    						    					
		<%}%>
		<tr>
		    <td colspan="4" align="right"><b>Total :</b>&nbsp;&nbsp;</td>					    
		    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("RepaySheduleTotal")))%></td>
		</tr>
		</table>
		</div>
		</td>
		</tr>
	<%String StrRepayComments = Helper.correctNull((String)hshValues.get("repaycomments"));
	if(StrRepayComments.equalsIgnoreCase(""))
	{
		StrRepayComments = "NA";
	}%>
	<tr><td colspan="2"><b>Terms of Repayment</b></td></tr>
	<tr><td colspan="2"><%=StrRepayComments%></td></tr>		
		<%} %>
		</table>
	</td>
</tr>
<tr>
	<td>
	<table width="90%" border="0" align="center" cellpadding="3" cellspacing="3" class="outertable">
	<tr>
			<td><b> Security Details</b></td>
			</tr>
			<%
			if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
			<tr><td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr class="tblhead"><td colspan="4"><b>Attached Securities : </b></td></tr>
			<tr>
			<td  align="center" width="20%"><b>Facility</b></td>
			<td  align="center" width="40%"><b>Details of Security</b></td>
			<td  align="center" width="10%"><b>Value</b></td>
			<td  align="center" width="25%"><b>Date of Valuation</b></td></tr>
			<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
			<tr align="left">
			<td colspan="4"><b>Prime :</b></td>
			</tr>
			<% 

			arrpropsecurityCol=new ArrayList();
			arrpropsecurity=new ArrayList();
			secValue = "";
			if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
				for(int a=0;a<arrpropsecurityRow.size();a++)
				{
					arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(a);
						  if(a==0) {
					%>
					<tr>
					<%if(arrpropsecurityRow.size()>2){ %>
					<td rowspan="<%=(arrpropsecurityRow.size())%>"><%=Helper.correctNull((String)arrpropsecurityCol.get(0)).toUpperCase()%></td>
					<%}else{ %>
					<td rowspan="2"><%=Helper.correctNull((String)arrpropsecurityCol.get(0)).toUpperCase()%></td>
					<%} %>
					</tr>
					<%} else {
					secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1))));
					if(secValue.equals("0.00")) secValue=" ";
					%>
					<tr>
					 <td> <%=(Helper.correctNull((String)arrpropsecurityCol.get(0)))%></td>
					 <td align="right"><%=Helper.correctNull(secValue)%></td>
					 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
					</tr>		
					<%	}
				}
			} }
			if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
			<tr>
			<td colspan="4" align="left"><b>Collateral:</b></td>
			</tr>
			<% 
			arrpropsecurityCol=new ArrayList();
			arrpropsecurity=new ArrayList();
			secValue = "";
			if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
				for(int a=0;a<arrpropsecCollRow.size();a++)
				{
					arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(a);
						secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1))));
						if(secValue.equals("0.00")) secValue=" ";
						%>
						<tr>
						 <td colspan="2"> <%=(Helper.correctNull((String)arrpropsecurityCol.get(0)))%></td>
						 <td align="right"><%=Helper.correctNull(secValue)%></td>
						 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
						</tr>		
						<%	 } }}
			%>
			</TABLE>
			</div><br>
			</td>
			</tr>
			<% }else{%>
			<tr><td><b><br>Attached Securities:</b> Nil</td></tr>
			<%} %>
			
			<%if(!Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")).equalsIgnoreCase("")){ %>
			<tr>
			<td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
			<td>
			<%=Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")) %>
			</td>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
	</table>
	</td>
</tr>
<!-- 
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">
		<tr >
			<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
					<tr class="tblhead">
						<td width="7%"  align="center"><b>S.No</b></td>
						<td width="45%" align="center"><b>Description of Security</b></td>
						<td width="45%" align="center"><b>Security Value</b></td>
					</tr>
					<%
					if (arrSecRow != null && arrSecRow.size() > 0) 
					{
					for (int i = 0; i < arrSecRow.size(); i++) 
					{
						arrSecCol = (ArrayList) arrSecRow.get(i);
					%>
					<tr>
						<td  align="center"><%=i+1%></td>
						<td><%=Helper.correctNull((String)arrSecCol.get(0))%></td>
						<td style="text-align: right;"><%=Helper.checkDecimal((String)arrSecCol.get(1))%></td>
					</tr>
					<%}} %>
				</table>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
 -->

<tr>
	<td>
	<div id="top">
		<table width="90%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable">
		<tr>
			<td colspan="2">Rate of Interest is subject to change as per changes made by RBI/our Bank from time to time without any intimation
			and is compounded Monthly/Quarterly/Yearly. Any arrears in installment / interest, etc. will attract penalty, presently
			being <%if(strdaydiff>=0){%>5<%}else{%>3<%}%>% p.a.</td>
		</tr>
		<%if(Helper.correctNull((String)hshValues.get("strIntType")).equalsIgnoreCase("Floating")){ %>
		<tr>
			<td colspan="2" style="border: none;">Rate of interest is subject to change from time to time.Present applicable <%if(Helper.correctNull((String)hshValues.get("strMCLRFlag")).equalsIgnoreCase("Y")){ %><%=Helper.correctNull((String)hshValues.get("mclr_type")) %>  <%}else{ %> BR <%} %> is &nbsp;<b><%=Helper.correctDouble((String)hshValues.get("dblBaseRate"))%> &nbsp;%</b>&nbsp;p.a.</td>
		</tr>
		<%} %>
		</table>
		</div>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="90%" border="0" align="center" cellpadding="3" cellspacing="3" class="outertable">
		<tr>
			<td align="left"><b>Terms & Conditions:</b></td>
		</tr>
		<%int j=1;
		if(lngDatediff>=0){ %>
		<tr>
			<td align="left"><b>General Conditions:</b></td>
		</tr>
		<tr>
			<td align="center"><b>Pre Disbursement Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("G")&&Helper.correctNull((String)arrayTermsCol.get(2)).equalsIgnoreCase("pre")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<tr>
			<td align="center"><b>Post Disbursement Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%j=1;
				if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("G")&&Helper.correctNull((String)arrayTermsCol.get(2)).equalsIgnoreCase("post")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<%} %>
		<tr>
			<td align="center"><b>Specific Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%j=1;
				if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("P")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<%if(!strProposalType.equalsIgnoreCase("P")){ %>
		<tr>
			<td align="center">
			<%if(lngDatediff<0){ %>
				<b>General Conditions:</b>
				<%}else{ %>
				<b>Product based Terms & Conditions:</b>
				<%} %>
			</td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
					<%j=1;
					if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("S")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<%} if(lngDatediff>=0){%>
		<tr>
			<td align="center"><b>Other Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%j=1;
				if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("O")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<%} %>
		<tr>
			<td align="center"><b>Instructions to the Branch:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
					<%j=1;
					if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("B")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="90%" border="0" align="center" cellpadding="3" cellspacing="3" class="outertable">
		<tr>
			<td align="left">Date:&nbsp;<b><%=Helper.getCurrentDateTime()%></b></td>
		<%if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>	
			<td align="right">Authorised Signatory</td>
		<% } else { %>
			<td align="right">Sanctioning Authority</td>
		<% } %>
		</tr>
		<tr>
			<td align="left">&nbsp;</td>
			<td align="right">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strSancAuthDesc"))%></b></td>
		</tr>
		</table>
	</td>
</tr>
</table>
</td>
</tr>
</table>
<br>
<br>
<br>
</form>
</body>
</html>