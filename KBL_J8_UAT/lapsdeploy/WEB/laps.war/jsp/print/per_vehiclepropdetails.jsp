<%@include file="../share/directives.jsp"%>
<% 
   ArrayList arrDevCol = new ArrayList();
   ArrayList arrDevRow = new ArrayList();
   ArrayList arrvehicledetcol = new ArrayList();
   ArrayList arrvehicledetRow = new ArrayList();
   if(hshValues!=null)
   {
	   arrDevRow = (ArrayList)hshValues.get("arrDevRow");
	   arrvehicledetRow = (ArrayList)hshValues.get("arrvehicledetRow");
   }
   
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehicle Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
  <tr>
		<td>
		
      <table width="100%" border="0" cellpadding="0" cellspacing="0"  class="outertable">		
	<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" cellpadding="3"  cellspacing="0" class="outertable">
			<tr>
			<td width="10%">Security ID</td>
			<td width="10%">Type Of Vehicle</td>
			<td width="10%">Make, Model</td>
			<td width="10%">Cost as per Invoice</td>
			<td width="10%">Road Tax</td>
			<td width="10%">Insurance</td>
			<td width="10%">Value as per Valuation [Incase of Old]</td>
			<td width="10%">Date of Valuation [Incase of Old]</td>
			<td width="10%">Name of the Bank approved Valuer</td>
			<td width="10%">Nature of Property [Prime/Collateral]</td>
			

			</tr>
			   <%
		                if(arrvehicledetRow!=null&&arrvehicledetRow.size()>0)
		                {
		                	for(int j=0;j<arrvehicledetRow.size();j++)
		                	{
		                		arrvehicledetcol=new ArrayList();
		                		arrvehicledetcol=(ArrayList)arrvehicledetRow.get(j);
			                	
			            %>
			<tr>			
			<td width="10%"><%=Helper.correctNull((String)arrvehicledetcol.get(13)) %>
			<td width="10%"><%=Helper.correctNull((String)arrvehicledetcol.get(2)) %>
			<td width="10%"><%=Helper.correctNull((String)arrvehicledetcol.get(3)) %>,<%=Helper.correctNull((String)arrvehicledetcol.get(4)) %></td></td>
			<td width="10%">Rs.<%=Helper.correctDouble((String)arrvehicledetcol.get(6)) %></td>
			<td width="10%">Rs.<%=Helper.correctDouble((String)arrvehicledetcol.get(7)) %></td>
			<td width="10%">Rs.<%=Helper.correctDouble((String)arrvehicledetcol.get(8)) %></td>
			<td width="10%"><%=Helper.correctNull((String)arrvehicledetcol.get(11)) %></td>
			<td width="10%"><%=Helper.correctNull((String)arrvehicledetcol.get(10)) %></td>
			<td width="10%"><%=Helper.correctNull((String)arrvehicledetcol.get(12)) %></td>
			<td width="10%"><%=Helper.correctNull((String)arrvehicledetcol.get(9)) %></td>
			</tr>
			<% }} %>
			</table>
			</div>
			</td>
			</tr>		
		</table>
		</td>
	</tr>
</table>
</body>
</html>