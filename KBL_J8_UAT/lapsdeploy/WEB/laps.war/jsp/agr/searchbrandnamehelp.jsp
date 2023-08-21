<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></meta>
<title>Search Brand Name</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<script>
function setValues(val1,val2)
{
	window.opener.document.forms[0].txt_brandname.value = val2;
	window.close();
}

function doClose()
{
 	window.close();
} 
</script>
<body>
<form>
<table class="outertable border1" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
	<td>
		<table class="outertable" width="100%" border="0" cellspacing="1"
			cellpadding="3" align="center">
			<tr class="datagrid">
				<td align="center">Brand Name Search</td>
			</tr>
			<tr>
			<td>
			<table class="outertable" width="100%" border="0" cellspacing="1"
			cellpadding="3" align="center">
			<tr class="dataheader">
				<td width="50%" align="center">S.No</td>
				<td width="50%" align="center">Brand Name</td>
				</tr>
			<tr>
			<td colspan="2">
			<table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
					<%
						ArrayList vecCol = new ArrayList();
					ArrayList vecRow = new ArrayList();
						if (hshValues != null)
							vecRow = (ArrayList) hshValues.get("vecRow");
						if (vecRow != null && vecRow.size() > 0) {

							for (int i = 0; i < vecRow.size(); i++) {
								vecCol = (ArrayList) vecRow.get(i);
					%>
					<tr class="datagrid">
						<td width="50%" align="center"><a
							href="javascript:setValues('<%=Helper.correctNull((String) vecCol.get(0))%>','<%=Helper.correctNull((String) vecCol.get(3))%>')"><%=Helper.correctNull((String) vecCol.get(0))%></a></td>
						<td width="50%" align="center"><a
							href="javascript:setValues('<%=Helper.correctNull((String) vecCol.get(0))%>','<%=Helper.correctNull((String) vecCol.get(3))%>')"><%=Helper.correctNull((String) vecCol.get(3))%></a></td>
					</tr>
					<%
						}
						} else {
					%>
					<tr class="datagrid">
						<td colspan="7" align="center">No Data Found</td>
					</tr>
					<%
						}
					%>
					<tr>
					<td align="center" colspan="2">
					<table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
						<tr>
							<td width="20%"><lapschoice:combuttonnew
								btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
							</td>
						</tr>
					</table>
					</td></tr>
				</table>
			</td></tr>
		</table>
		</td>
		</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>