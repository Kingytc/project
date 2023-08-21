<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	String loantype = Helper.correctNull((String) hshValues
			.get("app_loantype"));
%>
<html>
<head>
<title>LEGAL COMPLIANCE CERTIFICATE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/report.css"
	type="text/css">
</head>

<body>

<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
	</tr>
	<tr>
		<td align="center"><%=Helper.correctNull((String) hshValues
							.get("branprocessedby"))%></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td width="79%">Ref.No.:<%=Helper.correctNull((String) hshValues.get("appno"))%></td>
				<td align="left" width="21%">Date :<%=Helper.correctNull((String) hshValues
							.get("app_processdate"))%></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td align="center"><b>LEGAL COMPLIANCE CERTIFICATE</b></td>
	</tr>

	<tr>
		<td>
		<div id="top">
		<table width="96%" border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td width="40%">Name of the Account</td>
				<td width="40%"><%=Helper.decodeAmpersand((String) hshValues.get("appname"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="40%">Branch Name</td>
				<td width="40%"><%=Helper.correctNull((String) hshValues.get("apporgname"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="40%">Nature of Transaction</td>
				<td width="20%">Sanctioning of credit limit/s</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<p align="justify">I / We certify that all the laid down systems
		and procedures as applicable to the transaction detailed above have
		been complied with by me / us, to the best of my / our knowledge.</p>
		</td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="96%" border="0" cellspacing="0" cellpadding="4">
			<tr>
				<td colspan="2" align="center" valign="top">Name of the
				Official</td>
				<td colspan="2" align="center" valign="top">Name of the
				Official</td>
			</tr>
			<tr>
				<td width="15%" valign="top">Signature:<br>
				<br>
				<br>
				<br>
				<br>
				</td>
				<td width="35%" valign="top">&nbsp;</td>
				<td width="15%" valign="top">Signature:<br>
				<br>
				<br>
				<br>
				<br>
				</td>
				<td width="35%" valign="top">&nbsp;</td>
			</tr>
			<tr>
				<td width="15%" valign="top">Name:</td>
				<td width="35%" valign="top"><%=Helper.correctNull((String) hshValues.get("username1"))%>&nbsp;</td>
				<td width="15%" valign="top">Name:</td>
				<td width="35%" valign="top"><%=Helper.correctNull((String) hshValues.get("username2"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="15%" valign="top">Designation :</td>
				<td width="35%" valign="top"><%=Helper.correctNull((String) hshValues
									.get("desig1"))%>&nbsp;</td>
				<td width="15%" valign="top">Designation :</td>
				<td width="35%" valign="top"><%=Helper.correctNull((String) hshValues
									.get("desig2"))%>&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
</body>
</html>