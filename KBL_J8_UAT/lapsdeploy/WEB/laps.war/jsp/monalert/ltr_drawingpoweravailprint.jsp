<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
String date =Helper.getCurrentDateTime();
%>
<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>


<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<table width="75%" border="1" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="right">&nbsp;</td>
			</tr>
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD. </b></td>
			</tr>
			<tr>
				<td align="center"><B></B></td>
			</tr>
			<tr>
				<td align="center">&nbsp;</td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=date%></td>
			</tr>
			<tr>
				<td align="center"><U><b>&nbsp;</b></U></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td valign="top">To,
				M/s. <%=Helper.correctNull((String)hshValues.get("personal_custname"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_address"))%> ,<br>
<%=Helper.correctNull((String)hshValues.get("personal_address1"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("city"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("state"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_pincode"))%></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td>&nbsp;Dear sir,</td>
			</tr>
			<tr>
				<td align="center"><U><b>&nbsp;Availability of Drawing Power </b></U></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>This is to inform you that based on the stock and / or book debts statements submitted by M/s. <%=Helper.correctNull((String)hshValues.get("personal_custname"))%> for the month of<%=Helper.correctNull((String)hshValues.get("mon_msodmonth"))%>2008 and subsequent stock and / or book debts inspection conducted, the drawing power allotted to the above account comes to Rs.<%=Helper.correctNull((String)hshValues.get("dp"))%>. Based on the share of your Bank in the working capital finance provided to the above party, the drawing power of Rs.<%=Helper.correctNull((String)hshValues.get("dp"))%> is available to your Bank for the month of <%=Helper.correctNull((String)hshValues.get("mon_msodmonth"))%>. </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This is for your information.  </td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					
					
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><u></u></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td WIDTH="49%">&nbsp;</td>
								<td WIDTH="51%" align="center">Yours faithfully,</td>
							</tr>
							<tr align="center">
								<td WIDTH="49%"><b>REGIONAL HEAD </b></td>
								<td WIDTH="51%"><b>BRANCH MANAGER</b></td>
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
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
