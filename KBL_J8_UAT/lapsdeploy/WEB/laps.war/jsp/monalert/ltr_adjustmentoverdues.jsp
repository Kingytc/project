<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%String date = Helper.getCurrentDateTime();
%>
<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="75%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">

		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD. <br>
				<%=Helper.correctNull((String) hshValues.get("org_name"))%><br>
				<%=Helper.correctNull((String) hshValues.get("org_add1"))%>, <%=Helper.correctNull((String) hshValues.get("org_add2"))%>,
				<%=Helper.correctNull((String) hshValues
									.get("org_cityname"))%>, <%=Helper.correctNull((String) hshValues
							.get("org_statename"))%>,
				<%=Helper.correctNull((String) hshValues.get("org_zip"))%>. <br>
				Tel No :<%=Helper.correctNull((String) hshValues.get("org_phone"))%>
				</B></td>
			</tr>
			<tr>
				<td>
				<hr>
				</td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=date%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">TO :<br>
				M/s.&nbsp;<%=Helper.correctNull((String) hshValues
							.get("personal_custname"))%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("personal_address"))%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("personal_address1"))%>,<br>
				<%=Helper.correctNull((String) hshValues.get("city"))%>,<br>
				<%=Helper.correctNull((String) hshValues.get("state"))%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("personal_pincode"))%></td>
			</tr>
			<tr>
				<td>Dear Sir/Madam,</td>
			</tr>
			<tr>
				<td align="center"><U><b>Adjustment of Overdues</b></U></td>
			</tr>
			<tr>
				<td align="center"><b>A/c. No. :</b> &nbsp;<%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
			</tr>
			<tr>
				<td>
				<P>On scrutiny of your accounts, we observe that there is an overdue
				element to the extent of <b> Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("FUND_OVERDUEAMT"))))%> </b> <%-- %>( Rupees <%=Helper.figtoWords((String) hshValues
							.get("FUND_OVERDUEAMT"))%>)--%> being interest not serviced /
				installments not paid from <%=Helper.correctNull((String) hshValues
							.get("fund_overduesince"))%> . In order to maintain the
				performing status of your account, kindly arrange to remit the
				aforesaid overdue amount immediately on receipt of this letter.</P>
				<p>We look forward to your immediate response.</p>
				<p>Thanking you,</p>
				</td>
			</tr>
			<tr>
				<td align="right">Yours faithfully,&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td align="right">BRANCH MANAGER&nbsp;&nbsp;&nbsp;</td>
			</tr>
			<tr>
				<td align="left"><b>Note</b> : If overdue amount is already paid
				please ignore this letter</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
