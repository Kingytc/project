<%@include file="../share/directives.jsp"%>
<%
HashMap hsh=new HashMap();
int intFacCount=Integer.parseInt(Helper.correctInt((String)hshValues.get("strFacCount")));
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
%>
<html>
<head>
<title>Interest Annexure </title>
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
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="center" class="title"><br>Interest Annexure</td></tr>
<tr><td>&nbsp;</td></tr>

<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%
for(int i=1;i<=intFacCount;i++)
{
	hsh=(HashMap)hshValues.get("hshResult"+i);
	if(hsh!=null)
	{
		String strFacIntDef=Helper.correctNull((String)hsh.get("strIntDefinition"));
%>
	<tr>
   	<td><b>
   	Facility : <%=Helper.correctNull((String)hsh.get("strFacSno")) %> - <%=Helper.correctNull((String)hsh.get("strFacDesc")) %>
   	</td>
   	</tr>
   	<tr>
   	<td>
   	<div id="top">
   	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
   	<tr class="tblhead" align="center">
	   	<td colspan="2">Type </td>
	   	<td width="10%">Value</td>
   	</tr>
   	<tr>
   	<td colspan="2"><%=Helper.correctNull((String)hsh.get("mclr_type")) %> </td>
   	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("mclr_spread")) %></td>
   	</tr>
   	<%if(strFacIntDef.equalsIgnoreCase("M")){ %>
   	<tr>
   	<td colspan="3"  class="tblhead">CREDIT RISK PREMIUM</td>
   	</tr>
   	<%} %>
   	<%
   	arrRow=new ArrayList();
   	arrRow=(ArrayList)hsh.get("arrRowCRP");
   	if(arrRow!=null && arrRow.size()>0)
   	{
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
   	<%if(!strFacIntDef.equalsIgnoreCase("M") && k==0){ %>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strCRKVal"))  %></td>
   	<%}else{%>
   	<td align="right"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
   	<%} %>
   	</tr>
   	<%} %>
   	 <%if(strFacIntDef.equalsIgnoreCase("M")){ %>
		<tr>
	   	<td colspan="2" class="title"  align="right">Sub Total</td>
	   	<td align="right"><%=Helper.correctNull((String)hsh.get("mclr_crp_total")) %></td>
	   	</tr>
	   	<%} %>
	 <% }else{%>
	 
	 <%if(!strFacIntDef.equalsIgnoreCase("M")){ %>
	  	<tr>
   	<td colspan="2"> CREDIT RISK PREMIUM</td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strCRKVal")) %></td>
   	</tr>
	 <%}else{ %>
   	<tr>
   	<td colspan="3" align="center"> - Nil -</td>
   	</tr>
   	<%} %>
   	<%} %>
   	 <%if(strFacIntDef.equalsIgnoreCase("M")){ %>
   		<tr class="tblhead">
   		<%if(Helper.correctNull((String)hsh.get("mclr_type_code")).equalsIgnoreCase("O")){ %>
   			<td colspan="3" class="title">BUSINESS STRATEGIC PREMIUM</td>
   			<%}else{ %>
   			<td colspan="3" class="title">FIXED SPREAD</td>
   			<%} %>
   <!-- <td colspan="3" class="title">BUSINESS STRATEGIC PREMIUM</td>  -->	
   	</tr>
   	<%} %>
   		<%
   	arrRow=new ArrayList();
   	arrRow=(ArrayList)hsh.get("arrRowBSP");
   	if(arrRow!=null && arrRow.size()>0)
   	{
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   		<td width="35%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
   	<%if(!strFacIntDef.equalsIgnoreCase("M") && k==0){ %>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strBSPVal"))  %></td>
   	<%}else{%>
   	<td align="right"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
   	<%} %>
   	</tr>
   	<%} %>
   	 <%if(strFacIntDef.equalsIgnoreCase("M")){ %>
   		<tr>
   	<td colspan="2" class="title" align="right">Sub Total</td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("mclr_bsp_total")) %></td>
   	</tr>
   	<%}}else{%>
   	
   	 <%if(!strFacIntDef.equalsIgnoreCase("M")){ %>
   	 <tr>
   	 <%if(Helper.correctNull((String)hsh.get("mclr_type_code")).equalsIgnoreCase("O")){ %>
   			<td colspan="2" class="title">BUSINESS STRATEGIC PREMIUM</td>
   			<%}else{ %>
   			<td colspan="2" class="title">FIXED SPREAD</td>
   			<%} %>
   	<!-- <td colspan="2"> BUSINESS STRATEGIC PREMIUM</td>  -->
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strBSPVal")) %></td>
   	</tr>
   	 <%}else{ %>
   	<tr>
   	<td colspan="3" align="center"> - Nil -</td>
   	</tr>
   	<%}} %>
   	
   	<tr>
   	<td colspan="2" class="title"  align="right">  Final Interest Rate (%)</td>
   	<td align="right"><%=Helper.correctDouble((String)hsh.get("dblTotalIntRate")) %></td>
   	</tr>
   	
   	<%//if(Double.parseDouble(Helper.correctDouble((String)hsh.get("MCLR_MSME")))>0){ %>
<!--   	<tr>-->
<!--   	<td colspan="3">Borrower is categorized under the MSME category based on the exposure, <b><%//=Helper.correctDouble((String)hsh.get("MCLR_MSME"))%>%</b> is added up with the final Interest rate.</td>-->
<!--   	</tr>-->
   	<%//} %>
   	</table>
   	</div>
   	</td>
   	</tr>
   	

<%}} %>
</table>
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
</table>
</body>
</html>