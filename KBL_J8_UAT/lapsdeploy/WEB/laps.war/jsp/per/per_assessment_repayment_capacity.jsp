<%@include file="../share/directives.jsp"%>
<% ArrayList arrRepayCapacityData = new ArrayList();
   ArrayList arrRepayCapacityDisp = new ArrayList();
if (hshValues.get("arrRepayCapacity") != null) 
{	arrRepayCapacityData = (ArrayList) hshValues.get("arrRepayCapacity");
}
String stremp_occ=Helper.correctNull((String)hshValues.get("stremp_occp"));
String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
if (prd_type.equalsIgnoreCase("")) {
	prd_type = Helper.correctNull((String)hshValues.get("strProductType"));
	}
String staff_product=Helper.correctNull((String)hshValues.get("staffproduct"));
if(staff_product.equalsIgnoreCase("")){
	staff_product="N";
}
String schemeCode = Helper.correctNull((String) session
		.getAttribute("schemeCode"));
String strRepayType=Helper.correctNull((String) request
		.getParameter("hidRepayType"));
%>
<html>
<head>
<title>Appraisal - Common Assessment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form name="appform" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true">
<jsp:param name="pageid" value="10" /></jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt;Assessment-R/C</td>
	</tr>
</table>
<lapschoice:application />
<jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="16" />
</jsp:include>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="110" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="16" />
		</jsp:include>
<%} %>

<br>
<%if(staff_product.equalsIgnoreCase("N")&&(prd_type.equalsIgnoreCase("pS")||prd_type.equalsIgnoreCase("pU")||prd_type.equalsIgnoreCase("pH")||prd_type.equalsIgnoreCase("pA")||prd_type.equalsIgnoreCase("pP")|| (prd_type.equalsIgnoreCase("pM")&& (schemeCode.equalsIgnoreCase("TL"))) || (prd_type.equalsIgnoreCase("pM")&& (schemeCode.equalsIgnoreCase("P"))) || (prd_type.equalsIgnoreCase("pM")&& (schemeCode.equalsIgnoreCase("DL"))) || (prd_type.equalsIgnoreCase("pI")&& strRepayType.equalsIgnoreCase("1")) || prd_type.equalsIgnoreCase("pC") || prd_type.equalsIgnoreCase("pN") || prd_type.equalsIgnoreCase("pJ") || prd_type.equalsIgnoreCase("pK"))){ %>
<table width="60%" border="0" cellpadding="3" cellspacing="1" class="outertable " align="center">
	<tr>
		<td>
			<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">

			<% if (hshValues.get("arrRepayCapacity") != null) { %>
			<tr class="dataheader">
				<td align="center" colspan="3"><b>ASSESSMENT BASED ON REPAYMENT CAPACITY</b></td>
			</tr>
			<%	if (arrRepayCapacityData != null && arrRepayCapacityData.size() > 0)
				{
					for (int i = 0; i < arrRepayCapacityData.size(); i++)
					{	
					arrRepayCapacityDisp=(ArrayList)arrRepayCapacityData.get(i);
					if(arrRepayCapacityDisp.get(0).toString().startsWith("Applicant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Joint-Applicant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Co-Obligant -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Sole properitier -") ||
							arrRepayCapacityDisp.get(0).toString().startsWith("Guarantor -")){
				%>
				<tr class="dataheader">
				<td colspan="3"><b><%=arrRepayCapacityDisp.get(0)%></b></td>
				</tr>
				<%} else {%>
					<tr  class="datagrid">
					<td width="80%"align="left"><%=arrRepayCapacityDisp.get(0)%></td>
					<td align="right"><%=arrRepayCapacityDisp.get(1)%></td>
					</tr>
					<%}
				}} } else {%>
				<tr class="dataheader">
					<td align="center" colspan="3"><font size="2" face="Arial" color="red"><b>No Assessment to Display</b></td>
				</tr>
				<%} %>
			</table>
<% if (hshValues.get("arrRepayCapacity") != null) { 
		if((prd_type.equalsIgnoreCase("pP"))&& !(stremp_occ.equalsIgnoreCase("1")||stremp_occ.equalsIgnoreCase("9")))
		{
	
	%>
	<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable " align="center">
	<tr class="dataheader">
	<td colspan="3">Assessment Based on Repayment Capacity</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Latest Gross Annual income</b></td>
	</td>
	<td align="right"><b><%=Helper.correctNull((String)hshValues.get("Gross_Income")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Maximum Permissible Deductions (%) </b></td>
	<td align="right"><b><%=Helper.correctNull((String)hshValues.get("Max_per_deduct")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Annual Loan Commitment of Existing loan/s</b></td>
	<td align="right"><b><%=Helper.correctNull((String)hshValues.get("Existingloan_commitment")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Annual Loan Commitment of Proposed loan</b></td>
	<td align="right"><b><%=Helper.correctNull((String)hshValues.get("Annual_loan_commitment_proposed")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Total Annual Loan Commitment is</b></td>
	<td align="right"><b><%=Helper.correctNull((String)hshValues.get("Total_annual_commitment")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Percentage of Annual Total loan Commitment to Total Annual Income</b></td>
	<td align="right"><b><%=Helper.correctNull((String)hshValues.get("dbl_perannualtot")) %></b>
	</td>
	</tr>
</table>
		<%}else if ((prd_type.equalsIgnoreCase("pP"))&& (stremp_occ.equalsIgnoreCase("1")||stremp_occ.equalsIgnoreCase("9")))
		{%>
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable " align="center">
	<tr class="dataheader">
	<td colspan="3">Assessment Based on Repayment Capacity</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Grand Total Income Eligible for Deductions</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("dbl_grant_tot")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"> <%=Helper.correctNull((String)hshValues.get("dbl_repay_capacity_defined")) %> % of which is </td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("dbl_whichis")) %>
	</td>
	</tr>
	
	<tr class="datagrid">
	<td width="80%">Annual Loan Commitment of Proposed loan</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("dbl_prop_loan_commitmenttot1")) %>
	</td>
	</tr>
	<tr class="datagrid">
	<td>Annual Loan Commitment of Existing loan/s</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("Totaldbl_exi_loan")) %>
	</td>
	</tr>
	<% if(stremp_occ.equalsIgnoreCase("4")){%>
	<tr class="datagrid">
	<td>Annual Interest of the Proposed Loan</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("dbl_perannualintr")) %>
	</td>
	</tr>
	<%} %>
	<tr class="datagrid">
	<td><b>Total Annual Loan Commitment is</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("Totalloan")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td><b>Percentage of Annual Total loan Commitment to Total Annual Income</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("dbl_perannualtot")) %>&nbsp;%</b>
	</td>
	</tr>
	</table>
	<%}else{%>
		<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable " align="center">
	<tr class="dataheader">
	<td colspan="3">Assessment Based on Repayment Capacity</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Grand Total Income Eligible for Deductions</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("dbl_grant_tot")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%"> <%=Helper.correctNull((String)hshValues.get("dbl_repay_capacity_defined")) %> % of which is </td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("dbl_whichis")) %>
	</td>
	</tr>
	
	<tr class="datagrid">
	<td width="80%">Annual Loan Commitment of Proposed loan</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("dbl_prop_loan_commitmenttot1")) %>
	</td>
	</tr>
	<tr class="datagrid">
	<td>Annual Loan Commitment of Existing loan/s</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("Totaldbl_exi_loan")) %>
	</td>
	</tr>
	<% if(stremp_occ.equalsIgnoreCase("4")){%>
	<tr class="datagrid">
	<td>Annual Interest of the Proposed Loan</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("dbl_perannualintr")) %>
	</td>
	</tr>
	<%} %>
	<tr class="datagrid">
	<td><b>Total Annual Loan Commitment is</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("Totalloan")) %></b>
	</td>
	</tr>
	<tr class="datagrid">
	<td><b>Percentage of Annual Total loan Commitment to Total Annual Income</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("dbl_perannualtot")) %>&nbsp;%</b>
	</td>
	</tr>
	</table>	

<%}} }
    else if(staff_product.equalsIgnoreCase("Y")&&(prd_type.equalsIgnoreCase("pH")||prd_type.equalsIgnoreCase("pA")||prd_type.equalsIgnoreCase("pP")||prd_type.equalsIgnoreCase("pC")||prd_type.equalsIgnoreCase("pN")||prd_type.equalsIgnoreCase("pJ")||prd_type.equalsIgnoreCase("pU") ||(prd_type.equalsIgnoreCase("pI")&& strRepayType.equalsIgnoreCase("1")))){ %>
	<table width="80%" border="0" cellpadding="3" cellspacing="1" class="outertable " align="center">
	<tr class="dataheader">
	<td align="center" colspan="3"><b>ASSESSMENT BASED ON REPAYMENT CAPACITY</b></td>
	</tr>
	<tr class="datagrid">
	<td width="80%"><b> Latest Monthly  Salary</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("MonthlyIncome")) %>&nbsp;</b>
	</td>
	</tr>
	<tr class="datagrid">
	<td width="80%">50 % of montly Salary </td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("HalfMonthlyIncome")) %>&nbsp;
	</td>
	</tr>
	
	<tr class="datagrid">
	<td width="80%">Monthly Loan Commitment of Existing loan/s</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("Monthlydeduction")) %>&nbsp;
	</td>
	</tr>
	<tr class="datagrid">
	<td>Percentage of Deduction to Latest Monthly Salary</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("Percentagemonthlydeduction")) %>&nbsp;
	</td>
	</tr>
	<tr class="datagrid">
	<td>Monthly Loan Commitment of Proposed loan</td>
	<td  align="right"><%=Helper.correctNull((String)hshValues.get("ProposedLoancommitment")) %>&nbsp;
	</td>
	</tr>
	<tr class="datagrid">
	<td><b>Percentage of Deduction to Latest Monthly Salary</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("LatestDeductions")) %>&nbsp;</b>
	</td>
	</tr>
	<tr class="datagrid">
	<td><b>Total monthly Loan Commitment is</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("Totalloancommitment")) %>&nbsp;</b>
	</td>
	</tr>
	<tr class="datagrid">
	<td><b>Percentage of Total monthly  loan Commitment to Total monthly salary</b></td>
	<td  align="right"><b><%=Helper.correctNull((String)hshValues.get("Percentageofloancommitment")) %>&nbsp;%</b>
	</td>
	</tr>
	</table>
	<%}else{ %>
	<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable " align="center">
	<tr class="dataheader">
			<td align="center" colspan="3"><font size="2" face="Arial" color="red"><b>No Assessment to Display</b></td>
	</tr>
	</table>
	<%} %>
		</td>
	</tr>
</table>
<br>
<input type="button" name="cmdsave" disabled style="display:none">
<lapschoice:combuttonnew btnnames='' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<br>
</form>
</body>
</html>