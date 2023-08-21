<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Gold Eligibility</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
	function doClose() {
		if (ConfirmMsg(100)) {
			document.forms[0].target = "_parent";
			document.forms[0].action = appURL + "action/retailpge.jsp";
			document.forms[0].submit();
		}
	}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>

<body>
<form method="post" class="normal">
<br/>
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
		<td align="center" colspan="12"><b>Eligibility Calculation</b></td>
	</tr>
</table>
<table width="50%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">
	<tr>
		<td width="55%">Loan Amount Requested</td>
		<td width="45%">Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("loan_amtreqd"))))%>
		</td>
	</tr>
	<tr>
		<td width="55%">Appraisal value &amp; Eligibility</td>
		<td width="45%">Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("apprisalvalue"))))%>
		</td>
	</tr>
	<tr>
		<td width="55%">Margin Amount</td>
		<td width="45%">Rs. <%=Helper.formatDoubleValue(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("marginamt"))))%>
		</td>
	</tr>
	<tr>
		<td width="55%">Eligiblity Based on the Margin Amount</td>
		<td width="45%">Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("eligiblemargin"))))%>
		</td>
	</tr>
	<tr>
		<td width="55%">Eligibility Based as per bank circular</td>
		<td width="45%">Rs. <%=Helper.formatDoubleValue(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("bankvalue"))))%>
		</td>
	</tr>
	<tr>
		<td width="55%">Eligible Loan Amount</td>
		<td width="45%">Rs. <%=Helper
							.formatDoubleValue(Double.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("eligible"))))%>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="cmdsave" disabled> 
<lapschoice:agrihiddentag />
</form>
</body>
</html>
