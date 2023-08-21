<%@ include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Gold Rate Master History</title>
<script>
function doClose()
{
	window.close();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<br>
&nbsp;<i><b>Gold Rate Master History</b></i>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		<tr>
			<td>
				<table width="95%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
					<tr class="dataheader">
						<td width="14%" align="center" rowspan="2" valign="center">Date Modified</td>
						<td align="center" colspan="2">GL Quick</td>
						<td align="center" colspan="2">GL Classic</td>
						<td align="center" colspan="2">GL Comfort</td>
						<td width="9%" align="center" rowspan="2">GL Staff</td>
						<td width="9%" align="center" rowspan="2">GL Smart</td>
						<td width="14%" align="center" rowspan="2" valign="center">Comments</td>
					</tr>
					<tr class="dataheader">
						<td width="9%" align="center">Retail</td>
						<td width="9%" align="center">Agri</td>
						<td width="9%" align="center">Retail</td>
						<td width="9%" align="center">Agri</td>
						<td width="9%" align="center">Retail</td>
						<td width="9%" align="center">Agri</td>
					</tr>
					<%
					if(arrRow!=null&&arrRow.size()>0)
					{
						for(int i=0;i<arrRow.size();i++)
						{
							arrCol=(ArrayList)arrRow.get(i);
					%>
					<tr class="datagrid">
						<td align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(2))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(4))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(5))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(6))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(7))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(8))%></td>
						<td align="right"><%=Helper.checkDecimal((String)arrCol.get(9))%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%></td>
					</tr>
					<%}}
					else {%>
					<tr class="datagrid">
						<td colspan="9" align="center"><b>
							--No Data Found--</b>
						</td>
					</tr>
					<%} %>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</body>
</html>