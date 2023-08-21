<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	
	String strappname=Helper.correctNull((String)request.getParameter("appname"));
	
%>
<html>
<head>
<title>Pre Sanction Inspection report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0" font-size="11px">
<form name="frminspection" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left">
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
			</tr>
			<tr>
				<td align="center"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
			</tr>
			<tr>
				<td align="center"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp;
				<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp;
				<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp;
				<hr />
				</td>
			</tr>
			<tr>
				<td align="center"><b><br>
				GRID OBSERVATION</b></td>
			</tr>
			<tr>
				<td valign="bottom" align="center" colspan="3"><laps:application /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="2" cellpadding="3">
	<tr>
		<td width="3%">&nbsp;</td>
		<td width="43%">&nbsp;</td>
	</tr>
	<tr>
		<td width="3%" valign="top"><b>Observation</b>&nbsp;</td>
		<td width="43%" valign="top">:&nbsp;<%=Helper.correctNull((String)hshValues.get("cg_observation"))%></td>
	</tr>

	<tr>
		<td width="3%">&nbsp;</td>
		<td width="43%">&nbsp;</td>
	</tr>
	<tr>
		<td width="3%" valign="top"><b>Replies</b>&nbsp;</td>
		<td width="43%" valign="top">:&nbsp;<%=Helper.correctNull((String)hshValues.get("cg_replies"))%></td>
	</tr>

</table>
</form>
</body>
</html>

