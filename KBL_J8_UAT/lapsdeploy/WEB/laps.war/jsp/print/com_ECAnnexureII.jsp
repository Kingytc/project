<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();

	arrRow=(ArrayList)hshValues.get("arrRow");
%>
<html>
<head>
<title>Annexure II</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<td align="center" class="title"><br>ANNEXURE II</td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" align="center" cellpadding="0">
		<tr>
			<td valign="top" align="center">Grid Observations &amp; Justification</td>
		</tr>
</table>
</br>
<table width="98%" align="center">
		<tr><td class="title">Clearance by Credit Approval Grid :</td></tr>
		<tr><td>The said proposal is placed before Credit Approval grid meeting dated <%=Helper.correctNull((String)hshValues.get("com_griddate")) %> 
		and the observations received vide e-mail dated 
		<%if(Helper.correctNull((String)hshValues.get("strEmailDate")).equalsIgnoreCase(""))
		{%>________________<%}else{%><%=Helper.correctNull((String)hshValues.get("strEmailDate")) %><%} %>
		 and compliance are enclosed at under.</td></tr>
		</table>
		
<div id="top">
<table width="98%" border="0" cellspacing="0" align="center" cellpadding="0">
		<tr align="center" class="title">
			<td valign="top" width="50%">Observations</td><td width="50%">Justification &nbsp;</td>
		</tr>
		<%if(arrRow!=null && arrRow.size()>0){
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);%>
		<tr>
		<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
		<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
		</tr>
		<%}}else{ %>
		<tr>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		</tr>
		<%} %>
</table>

</div>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
		<td><%=Helper.correctNull((String)hshValues.get("strcomments")) %></td>
	</tr>
</table>
</body>
</html>