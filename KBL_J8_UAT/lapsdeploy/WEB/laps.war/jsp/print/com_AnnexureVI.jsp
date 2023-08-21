<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>

<%
ArrayList arrCol	= new ArrayList();
ArrayList arrRow	= new ArrayList();
ArrayList arrIFCRow	= new ArrayList();
ArrayList arrtotRow	= new ArrayList();

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

String strTOLabel[]	= {"Name of the Company","Year","Type","Fund Based Working Captial limits availed","NonFund Based Working Captial limits availed",
		"Total Working Captial limits availed","Term Loan limits availed","Sales", "Net Profit", "Net Worth"," Debt-Equity Ratio","TOL/ TNW","Current Ratio"};
String strNil	= "Nil";

if(hshValues!=null)
{
	arrIFCRow	= (ArrayList)hshValues.get("arrIFCRow");
	arrtotRow	= (ArrayList)hshValues.get("arrRowtotal");
	arrRow	= (ArrayList)hshValues.get("arrRow");
	
}
String strValuesIn = Helper.correctNull((String)hshValues.get("strValuesIn"));
if(strValuesIn.equalsIgnoreCase("Rs"))
{
	strValuesIn	= "(Amount in  "+strValuesIn+".)";
}
else
{
	strValuesIn	= "(Rs. in  "+strValuesIn+")";
}
String strFlag = Helper.correctNull((String)hshValues.get("strFlag"));
String strFinvaluesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
if(strFinvaluesIn.equalsIgnoreCase("Rs"))
{
	strFinvaluesIn	= "(Amount in  "+strFinvaluesIn+".)";
}
else
{
	strFinvaluesIn	= "(Rs. in  "+strFinvaluesIn+")";
}
%>

<html>
<head>
<title>Annexure - VI</title>
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

<table width="90%" align="center" cellpadding="3" cellspacing="0" border="0">
<% if (!strFlag.equalsIgnoreCase("Y")) { %>
<tr><td align="center" class="title">ANNEXURE VI</td></tr>
<tr><td align="center" class="title">INDUSTRY ANALYSIS AND SWOT ANALYSIS</td></tr>
<%} else { %>
<tr><td align="center" class="title">ANNEXURE II</td></tr>
<tr><td align="left" class="title">INDUSTRY ANALYSIS AND SWOT ANALYSIS</td></tr>
<%} %>
<tr>
<td>&nbsp;</td>
</tr>
<%
if(!(Helper.correctNull((String)hshValues.get("com_comments")).equalsIgnoreCase("")))
{%>
<tr>
<td align="left" class="title">Industry Analysis</td>
</tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("com_comments"))%></td></tr>
<%} %>
<tr>
<td>&nbsp;</td>
</tr>
<tr>		
<td align="left" class="title">Swot Analysis</td>
</tr>
<tr>
<%
if(arrRow!=null&&arrRow.size()>0)
{%>
<%for(int i=0;i<arrRow.size();i++)
	{
		arrCol=(ArrayList)arrRow.get(i);
	%>
	
	<td align="left" class="title"><%=Helper.correctNull((String)arrCol.get(0))%></td>
	</tr>
	<tr>
	<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
	</tr>
	
<%
}%>	

<%}else{%>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>

<!-- Justification for sales -->
<tr><td class="title"><br>INTER COMPANY COMPARISON</td></tr>
<%if(arrIFCRow!=null&&arrIFCRow.size()>0){ %>

<tr><td align="right"> <%=strFinvaluesIn %></td></tr>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%=Helper.correctNull((String)hshValues.get("cmt_comments"))%>

<%for(int i=0;i<3;i++){
%>
<tr>
<td width="3%"><%if(i>2){%><%=i-2%><%}%></td>
<%
if(i<=12){ %>
<td width="47%"><%=strTOLabel[i]%></td>
<%}else if(i==13){ %><td><%=Helper.correctNull((String)hshValues.get("com_freetext1"))%></td>
<%}else if(i==14){ %><td><%=Helper.correctNull((String)hshValues.get("com_freetext2"))%></td>
<%}else if(i==15){ %><td><%=Helper.correctNull((String)hshValues.get("com_freetext3"))%><%} %></td>
	<%
for(int j=0;j<arrIFCRow.size();j++){
	arrCol	= (ArrayList)arrIFCRow.get(j);
	if(!Helper.correctNull((String)arrCol.get(0)).equals("")){
	String temp=Helper.correctNull((String)arrCol.get(2));
	if (temp.trim().equalsIgnoreCase("Audit"))
	{
		temp = "Audited";
	}
	else if (temp .trim().equalsIgnoreCase("Unaudit"))
	{
		temp = "Unaudited";
	}
	else if (temp.trim().equalsIgnoreCase("Estimated"))
	{
		temp = "Estimated";
	}
	else if (temp.trim().equalsIgnoreCase("p"))
	{
	temp = "Projection";
	}
%>
<%if(i==0){ %><td align="center" width="10%"><%=Helper.changetoTitlecase((String)arrCol.get(0))%></td><%} %>
<%if(i==1){ %><td align="center" width="10%"><%=Helper.correctNull((String)arrCol.get(1))%></td><%} %>
<%if(i==2){ %><td align="center" width="10%"><%=temp%></td><%} %>
<%}}}
%>

</tr>

<%
}else{ %>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>
<%
double strTot=0.00;
if(arrIFCRow!=null&&arrIFCRow.size()>0){ 
int k=0,n=0;
for(int i=3;i<16;i++){
strTot=Double.parseDouble(Helper.correctDouble((String)arrtotRow.get(k)));
k++;
if(strTot>0){
	n++;
%>
	
	<tr>
<td width="3%"><%if(i>2){%><%=n%><%}else{ %>&nbsp;<%} %></td>
<%
if(i<=12){ %>
<td width="47%"><%=strTOLabel[i]%></td>
<%}else if(i==13){ %><td><%=Helper.correctNull((String)hshValues.get("com_freetext1"))%></td>
<%}else if(i==14){ %><td><%=Helper.correctNull((String)hshValues.get("com_freetext2"))%></td>
<%}else if(i==15){ %><td><%=Helper.correctNull((String)hshValues.get("com_freetext3"))%><%} %></td>
	<%
for(int j=0;j<arrIFCRow.size();j++){
	arrCol	= (ArrayList)arrIFCRow.get(j);
	if(!Helper.correctNull((String)arrCol.get(0)).equals("")){
%>
<%if(i==3){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td><%} %>
<%if(i==4){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td><%} %>
<%if(i==5){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td><%} %>
<%if(i==6){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td><%} %>
<%if(i==7){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td><%} %>
<%if(i==8){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))%></td><%} %>
<%if(i==9){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(9))))%></td><%} %>
<%if(i==10){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))%></td><%} %>
<%if(i==11){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(11))))%></td><%} %>
<%if(i==12){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%></td><%} %>
<%if(i==13){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13))))%></td><%} %>
<%if(i==14){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(14))))%></td><%} %>
<%if(i==15){ %><td align="right" width="10%"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(15))))%></td><%} %>
<%}}}
%>
</tr>
<%}}%>

</table>
</div>
</td>
</tr>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("cmt_intercomments"))%></td>
</tr>
<tr><td><br></td></tr>
</table>

</body>
</html>