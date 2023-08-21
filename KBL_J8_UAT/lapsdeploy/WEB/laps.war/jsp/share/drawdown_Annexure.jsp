<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol = new ArrayList();
	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>drawdown_Annexure</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}
.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
</head>
<body>

<table class="outertable" width="80%" align="center" border="0">
<tr><td>&nbsp;</td></tr>
<tr><td align="center" class="title"><br>DRAW DOWN SCHEDULE ANNEXURE</td></tr>
<tr><td>&nbsp;</td></tr>
<%if(!Helper.correctNull((String)hshValues.get("strFacDesc")).equalsIgnoreCase("")){ %>
<tr>
<td><b>Facility : <%=Helper.correctNull((String)hshValues.get("strSno")) %> - <%=Helper.correctNull((String)hshValues.get("strFacDesc")) %></b></td>
</tr>
<%} %>
</table>
<table width="80%" align="center" border="0" class="outertable border1">
<% int addrow1 = 0;
if(arrRow!=null)
{
	addrow1 = arrRow.size();
}%>
<tr class="tblhead" align="center">
	<td width="15%" align="center" >Quarter Start Date</td>
	<td width="15%" align="center" >Quarter End Date</td>
	<td>Total outstanding at the end of the Quarter</td>
	<td>Amount to be disbursed during the Quarter</td>
</tr>
<%
if (addrow1 > 0) 
{
	for (int j = 0; j < addrow1; j++)
	{
		arrCol = (ArrayList) arrRow.get(j);
		%> 	
	<tr>
			<td  align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
			<td  align="center"><%=Helper.correctNull((String)arrCol.get(1))%></td>
			<td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
			<td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
	</tr>
	<%}
} else{%>
<tr><td colspan="4" align="center">No Records Found</td></tr>
<%} %>
</table>
</body>
</html>