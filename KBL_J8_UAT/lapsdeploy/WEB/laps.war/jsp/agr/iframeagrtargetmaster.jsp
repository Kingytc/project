<%@include file="../share/directives.jsp"%>
<%

ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();
int vecsize=0;
if (hshValues != null)
{		arrRow = (ArrayList) hshValues.get("arrRowtargetmaster");				
}
if(arrRow !=null)
{
	vecsize=arrRow.size();
}

%>
<html>
<head>
<title>Target Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<body >

<form method="post" name="IfMaster" class="normal">



<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
	
	</tr>
	
	<%
	
	for(int i=0;i<vecsize;i++)
	{
		arrCol = (ArrayList) arrRow.get(i);
	%>
	
	<tr class="datagrid">
		<td  width="25%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
		<td align="right" width="11%"><%=Helper.checkDecimal((String) arrCol.get(2))%></td>
		
		<td width="25%">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
		<td width="11%">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
		<td width="15%" align="right">&nbsp;<%=Helper.checkDecimal((String) arrCol.get(6))%></td>
		<td width="9%">&nbsp;<%=Helper.correctNull((String) arrCol.get(7))%></td>
	
	</tr>
	<%} if(vecsize <=0)
	{ %>
	<tr class="datagrid">
	<td colspan="6">&nbsp;</td>
	</tr>
	<tr class="datagrid">
	<td colspan="6" align="center">No Data Found</td>
	</tr>
	<tr class="datagrid">
	<td colspan="6">&nbsp;</td>
	</tr>
	<%} %>
</table>

