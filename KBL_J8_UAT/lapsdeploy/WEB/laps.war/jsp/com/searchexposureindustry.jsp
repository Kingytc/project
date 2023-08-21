<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></meta>
<title>Search Exposure To Industry</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<script>
function setValues(val1,val2)
{
	window.opener.document.forms[0].txt_activity.value = val2;
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
				<td align="center">Exposure TO Industry Search</td>
			</tr>
		</table>
		<table class="outertable" width="100%" border="0" cellspacing="1"
			cellpadding="3" align="center">
			<tr class="dataheader">
				<td width="50%" align="center">SINO</td>
				<td width="50%" align="center">ACTIVITY</td>
			<tr>
			<table class="outertable" width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
					<%
						ArrayList arrCol = new ArrayList();
						ArrayList arrRow = new ArrayList();
						if (hshValues != null)
							arrRow = (ArrayList) hshValues.get("arrRow");
						if (arrRow != null && arrRow.size() > 0) {

							for (int i = 0; i < arrRow.size(); i++) {
								arrCol = (ArrayList) arrRow.get(i);
					%>



					<tr class="datagrid">
						<td width="50%" align="center"><a
							href="javascript:setValues('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a></td>
						<td width="50%" align="center"><a
							href="javascript:setValues('<%=Helper.correctNull((String) arrCol.get(0))%>','<%=Helper.correctNull((String) arrCol.get(1))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a></td>



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


					<table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
						<tr>
							<td width="20%"><lapschoice:combuttonnew
								btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
							</td>
						</tr>
					</table>


				</table>
			
		</table>

		</td>
	</tr>
</table>
</form>
</body>
</html>