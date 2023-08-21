<%@include file="../share/directives.jsp"%>
    <%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
arrRow=(ArrayList)hshValues.get("arrRow");
int applcount=0;
if(arrRow!=null)
	applcount=arrRow.size();
%>
<html>
<head>
<title>Insert title here</title>
<script>
	var appURL = "<%=ApplicationParams.getAppUrl()%>";
	
	function callonload()
	{
		parent.frames.document.forms[0].statuscount.value="<%=Helper.correctNull((String)hshValues.get("statuscount"))%>";
		parent.frames.document.forms[0].applcount.value="<%=applcount%>";
	}
	

</script>
</head>
<body onload="callonload()">
<form name="srchform" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	
	<%
	if(arrRow!=null)
	{
			if(arrRow.size()>0)
			{
					for(int i=0;i<arrRow.size();i++)
					{
						 arrCol=(ArrayList)arrRow.get(i); 
						 %>	
							<tr class="datagrid">
							<td width="10%"><%=Helper.correctNull((String)arrCol.get(0))%> </td>
							<td width="5%" align="center"><%=Helper.correctNull((String)arrCol.get(1))%> </td>
							<td width="10%"><%=Helper.correctNull((String)arrCol.get(2))%> </td>
							<td width="10%"><%=Helper.correctNull((String)arrCol.get(3))%> </td>
							<td width="10%" align="right"><%=Helper.correctNull((String)arrCol.get(4))%> </td>
							<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(5))%> </td>
							<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(6))%> </td>
							<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(7))%> </td>
							<td width="10%"><%=Helper.correctNull((String)arrCol.get(8))%> </td>
							</tr>
							<% } } else	{ %>
							<tr class="datagrid"><td COLSPAN="9" align="center">&nbsp; </td></tr>
							<tr class="datagrid"><td COLSPAN="9" align="center">&nbsp;No Data Found</td></tr>
							<tr class="datagrid"><td COLSPAN="9" align="center">&nbsp; </td></tr>
			
		<% } }  %>
</table>
</form>
</body>
</html>