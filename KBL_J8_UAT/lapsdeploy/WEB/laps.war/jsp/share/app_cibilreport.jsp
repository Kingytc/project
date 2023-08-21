<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	request.setAttribute("_cache_refresh", "true");
%>
<laps:handleerror />
<html>
<head>
<title>CIBIL INTERFACE</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script>
var status="<%=Helper.correctNull((String) hshValues
									.get("Status"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<form method="post">

<table width="95%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	
		<td>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><img
					src="<%=ApplicationParams.getAppUrl()%>img/CIBIL_Logo.png"></td>
				<td align="center" class="heading" nowrap>CIBIL CONSUMER CREDIT INFORMATION REPORT</td>
			<td><img
					src="<%=ApplicationParams.getAppUrl()%>img/UBI_logo.jpeg"></td>
			</tr>
		</table>
		<br>
		<%
		HashMap hshGeneralData = new HashMap();
		hshGeneralData = (HashMap)hshValues.get("hshGeneralData");
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="15%"><b>For </b></td>
				<td><b>:</b>&nbsp;<%=Helper.correctNull((String)hshGeneralData.get("mem_shortcode")) %></td>
				<td width="5%"><b>Date</b></td>
				<td width="15%"><b>:</b>&nbsp;<%=Helper.correctNull((String)hshGeneralData.get("mem_date")) %></td>
			</tr>
			<tr>
				<td nowrap><b>Member REf No</b></td>
				<td><b>:</b>&nbsp;<%=Helper.correctNull((String)hshGeneralData.get("mem_refno")) %></td>
				<td><b>Time</b></td>
				<td><b>:</b>&nbsp;<%=Helper.correctNull((String)hshGeneralData.get("mem_time")) %></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td nowrap><b>Control No</b></td>
				<td><b>:</b>&nbsp;<%=Helper.correctNull((String)hshGeneralData.get("mem_control_no")) %></td>
			</tr>
		</table>
		<Hr>
		<%
			HashMap hshBorrowerData = new HashMap();
			hshBorrowerData = (HashMap) hshValues.get("hshBorrowerData");
			
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="4" class="subheading">CONSUMER / BORROWER INFORMATION</td>
			</tr>
			<tr>
				<td width="15%"><b>Name </b></td>
				<td width="35%"><b>:</b>  <%=Helper.correctNull((String)hshBorrowerData.get("app_name")) %></td>
				<td width="15%">&nbsp;</td>
				<td width="35%">&nbsp;</td>
			</tr>
			<tr>
				<td width="15%"><b>Date of Birth</b></td>
				<td width="35%"><b>:</b>   <%=Helper.correctNull((String)hshBorrowerData.get("app_dob"))%></td>
				<td width="15%" ><b>Gender</b></td>
				<%if(Helper.correctNull((String)hshBorrowerData.get("app_gender")).equalsIgnoreCase("1")){%>
				<td width="35%"><b>:</b>   Male</td>
				<%}else if(Helper.correctNull((String)hshBorrowerData.get("app_gender")).equalsIgnoreCase("2")){ %>
				<td width="35%"><b>:</b>   Female</td>
				<%}else{ %>
				<td width="35%"><b>:</b>   Not Applicable</td>
				<%} %>
			</tr>
			<tr>
				<td width="15%"><b>Income Tax ID</b></td>
				<td width="35%"><b>:</b>   <%=Helper.correctNull((String)hshBorrowerData.get("app_additionalid")) %></td>
				<td width="15%"><b>Passport No.</b></td>
				<td width="35%""><b>:</b>   <%=Helper.correctNull((String)hshBorrowerData.get("app_passportno")) %></td>
			</tr>
			<tr>
				<td width="15%"><b>Voter Id </b></td>
				<td width="35%"><b>:</b>   <%=Helper.correctNull((String)hshBorrowerData.get("app_voterid")) %></td>
				<td width="15%"><b>Telephone No</b></td>
				<td width="35%"><b>:</b>   <%=Helper.correctNull((String)hshBorrowerData.get("app_telephoneno")) %></td>
			</tr>
		</table>
		<Hr>
		<%
		HashMap hshAddressData = new HashMap();
		ArrayList arrCustAddCol = new ArrayList();
		ArrayList arrCustAddRow = new ArrayList();
		hshAddressData = (HashMap) hshValues.get("hshAddressData");
		arrCustAddRow = (ArrayList)hshAddressData.get("arrCustAddRow");
		int intarrCustAddRowSize = arrCustAddRow.size();
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<%
			if(intarrCustAddRowSize>0)
			{
				for(int i=0;i<intarrCustAddRowSize;i++)
				{
					arrCustAddCol = (ArrayList) arrCustAddRow.get(i);
					if(i==0)
					{
					%>
					<tr>
						<td><b>ADDRESSESS OF THE APPLICANT:</b></td>
					</tr>
				<%} %>
					<tr>
						<td ><B>Address <%=i+1%></B></td>
					</tr>
					<%if(!Helper.correctNull((String)arrCustAddCol.get(0)).equalsIgnoreCase("")){ %>
					<tr>
						<td ><%=Helper.correctNull((String)arrCustAddCol.get(0)) %> </td>
					</tr>
					<%} %>
					<tr>
						<td><%=Helper.correctNull((String)arrCustAddCol.get(1)) %>  -  
						<%=Helper.correctNull((String)arrCustAddCol.get(2)) %> </td>
						
					</tr>
					<tr>
						<td ><b>Reported date    :</b>  <%=Helper.correctNull((String)arrCustAddCol.get(3)) %></td>
					</tr>
					<%
				}
			}
		%>
		</table>
		<Hr>
			<%
		HashMap hshEnquiryData = new HashMap();
		arrCustAddCol = new ArrayList();
		arrCustAddRow = new ArrayList();
		hshEnquiryData = (HashMap) hshValues.get("hshEnquirydata");
		arrCustAddRow = (ArrayList)hshEnquiryData.get("arrEnquiryRow");
		intarrCustAddRowSize = arrCustAddRow.size();
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="5" class="subheading">ENQUIRIES</td>
			</tr>
			<tr>
				<td align="center" width="10%"><b>S.No.</b></td>
				<td align="center" width="20%"><b>Member</b></td>
				<td align="center" width="14%"><b>Date</b></td>
				<td align="center" width="40%"><b>Enquiry Purpose</b></td>
				<td align="center" width="15%"><b>Amount</b></td>
			</tr>
			<%
			if(intarrCustAddRowSize>0)
			{
				for(int i=0;i<intarrCustAddRowSize;i++)
				{
					arrCustAddCol = (ArrayList) arrCustAddRow.get(i);
					%>
					<tr>
						<td align="center" width="10%"><%=i+1 %></td>
						<td align="left" width="20%"><%=Helper.correctNull((String)arrCustAddCol.get(0)) %></td>
						<td align="left" width="14%"><%=Helper.correctNull((String)arrCustAddCol.get(1)) %></td>
						<td align="left" width="40%"><%=Helper.correctNull((String)arrCustAddCol.get(2)) %></td>
						<td align="right" width="15%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCustAddCol.get(3)))) %></td>
					</tr>
				<%
				}
			}%>
		</table>
		<Hr>
		<%
		HashMap hshScoreData = new HashMap();
		hshScoreData = (HashMap) hshValues.get("hshScoreData");
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td colspan="4"><b>SCORES</b></td>
			</tr>
			<tr>
				<td width="15%"><b>Score Date  </b></td>
				<td width="35%"><b>:</b>&nbsp;<%=Helper.correctNull((String)hshScoreData.get("score_date")) %></td>
				<td width="15%" nowrap><b>Score Obtained  </b></td>
				<td width="35%"><b>:</b>&nbsp;<%=Helper.correctNull((String)hshScoreData.get("score_obtained")) %></td>
			</tr>
			<tr>
				<td colspan="4"><b> Exclusions :</b>
				<%
				ArrayList arrScoreExclusionData = new ArrayList();
				arrScoreExclusionData = (ArrayList) hshScoreData.get("arrScoreExclusionData");
				int intarrScoreExclusionData_count = arrScoreExclusionData.size();
				%>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<%
						if(intarrScoreExclusionData_count>0){
						for(int j=0;j<intarrScoreExclusionData_count;j++){ 
						if(!Helper.correctNull((String)arrScoreExclusionData.get(j)).equalsIgnoreCase("")){
						%>
						<tr>
							<td width="10%">&nbsp;&nbsp;Code <%=j+1 %></td>
<!--							<td><b>:</b>&nbsp;&nbsp;<%=Helper.correctNull((String)arrScoreExclusionData.get(j))%></td>-->
						</tr>
						<%}
						} 
						}%>
					</table>
					</td>
			</tr>
			<tr>
				<td colspan="4"><b> Reasons : </b>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<%int a=1; %>
						<%if(!Helper.correctNull((String)hshScoreData.get("score_reason_1")).equalsIgnoreCase("")){ %>
						<tr><td>&nbsp;&nbsp;(<%=a%>) <%=Helper.correctNull((String)hshScoreData.get("score_reason_1")) %></td></tr>
						<%a = a+1;
						} %>
						<%if(!Helper.correctNull((String)hshScoreData.get("score_reason_2")).equalsIgnoreCase("")){ %>
						<tr><td>&nbsp;&nbsp;(<%=a%>) <%=Helper.correctNull((String)hshScoreData.get("score_reason_2")) %></td></tr>
						<%a = a+1;} %>
						<%if(!Helper.correctNull((String)hshScoreData.get("score_reason_3")).equalsIgnoreCase("")){ %>
						<tr><td>&nbsp;&nbsp;(<%=a%>) <%=Helper.correctNull((String)hshScoreData.get("score_reason_3")) %></td></tr>
						<%a = a+1;} %>
						<%if(!Helper.correctNull((String)hshScoreData.get("score_reason_4")).equalsIgnoreCase("")){ %>
						<tr><td>&nbsp;&nbsp;(<%=a%>) <%=Helper.correctNull((String)hshScoreData.get("score_reason_4")) %></td></tr>
						<%a = a+1;} %>
						<%if(!Helper.correctNull((String)hshScoreData.get("score_reason_5")).equalsIgnoreCase("")){ %>
						<tr><td>&nbsp;&nbsp;(<%=a%>) <%=Helper.correctNull((String)hshScoreData.get("score_reason_5")) %></td></tr>
						<%a = a+1;} %>
					</table>
				</td>
			</tr>
		</table>
		<Hr>
		<br>
		<%
		HashMap hshAccountData = new HashMap();
		arrCustAddCol = new ArrayList();
		arrCustAddRow = new ArrayList();
		hshAccountData = (HashMap) hshValues.get("hshAccountData");
		arrCustAddRow = (ArrayList)hshAccountData.get("arrAccountRow");
		intarrCustAddRowSize = arrCustAddRow.size();
		%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><b>ACCOUNT INFORMATION</b></td>
			</tr>
		</table>
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<div id="top">
					<table width="100%"  cellspacing="0" >
						<tr><td align="center"><b>TITLE</b></td></tr>
						<tr>	<td><b>Member Short Name</b></td></tr>
						<tr>	<td><b>Account No</b></td></tr>
						<tr>	<td><b>Account Type</b></td></tr>
						<tr>	<td><b>Ownership Indicator</b></td></tr>
						<tr>	<td><b>Date Opened / Disbursed</b></td></tr>
						<tr>	<td><b>Date of last payment</b></td></tr>
						<tr>	<td><b>Date Closed</b></td></tr>
						<tr>	<td><b>Date Reported</b></td></tr>
						<tr>	<td><b>High credit / Sanction amount</b></td></tr>
						<tr>	<td><b>Current Balance</b></td></tr>
						<tr>	<td><b>Amount Overdue</b></td></tr>
						<tr>	<td><b>Payment History 1</b></td></tr>
						<tr>	<td><b>Payment History 2</b></td></tr>
						<tr>	<td><b>Payment History Start Date </b></td></tr>
						<tr>	<td><b>Payment History End Date </b></td></tr>
						<tr>	<td><b>Status</b></td></tr>
					</table>
					</div>
				</td>
				<%
			if(intarrCustAddRowSize>0)
			{
				for(int i=0;i<intarrCustAddRowSize;i++)
				{
					arrCustAddCol = (ArrayList) arrCustAddRow.get(i);
					%>
					<td>
					<div id="top">
					<table width="100%"  cellspacing="0" >
						<tr><td align="center"><b>ACCOUNT <%=i+1 %></b></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(0)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(1)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(2)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(3)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(4)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(5)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(6)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(7)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCustAddCol.get(8)))) %></td></tr>
						<tr><td>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCustAddCol.get(9)))) %></td></tr>
						<tr><td>&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCustAddCol.get(10)))) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(11)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(12)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(13)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(14)) %></td></tr>
						<tr><td>&nbsp;<%=Helper.correctNull((String)arrCustAddCol.get(15)) %></td></tr>
					</table>
					</div>
				</td>
					<%
				}
			}
					%>
				
			</tr>
		</table>
		</td>
		
	</tr>
	
</table>

</form>
</body>
</html>