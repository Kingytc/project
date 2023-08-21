<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%ArrayList arrRow = new ArrayList();
			ArrayList arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrMailBoxComments");

			%>
<html>
<head>
<title>Remarks of Processing Officers</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmprint" method=post>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	bgcolor="#FFFFFF" align="center">
	<tr>
		<td align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
	</tr>
	<tr>
		<td align="center"><b>Branch / Office - <%=Helper.correctNull((String) hshValues.get("orgName"))%></b>
		<hr />
		</td>
	</tr>
	<tr>
		<td align="center"><b><font size="2">Remarks of Processing Officers
		for</font></b></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="25%"><B>App. Recd. From: </B></td>
				<td width="40%"><%=Helper.correctNull((String) hshValues.get("apporgname"))%>&nbsp;</td>
				<td width="25%" align="right"><B>Application No:</B></td>
				<td width="10%" align="right"><%=Helper.correctNull((String) hshValues.get("appno"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="25%"><B>Name of Borrower:</B></td>
				<td colspan="3" align="left"><%=Helper.correctNull((String) hshValues.get("app_name"))%>&nbsp;</td>
			</tr>		
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td><B>Name</B></td>
				<td><b>P.F No</b></td>
				<td><B>Date</B></td>
			</tr>
			<%if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
				<td><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="3"><%=Helper.formatTextAreaData((String) arrCol.get(0))%>&nbsp;</td>
			</tr>
			<%}
			}

		%>
		</table>
		</div>
		</td>
	</tr>
</table>
<br>
</form>
</body>
</html>

