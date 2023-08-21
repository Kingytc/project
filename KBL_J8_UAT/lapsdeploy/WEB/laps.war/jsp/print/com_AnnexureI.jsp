<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
String strAmountValue=Helper.correctNull((String)hshValues.get("strAmountValue"));

String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
}


java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

String strFormat = Helper.correctNull((String)request.getParameter("strFormat"));
%>
<html>
<head>
<title>Annexure - I</title>
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
<tr><td align="center" class="title"><br>ANNEXURE	- I</td></tr>
<tr><td>
<table width="70%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td align="left" class="title" width="50%">BRANCH INDICES</td>
<td align="right" width="50%"><%=strAmtValueIn%></td>
</tr>
</table>
</td></tr>
<tr>
<td>
<div id="top">
<table width="70%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td align="left" width="5%">a.</td>
<td align="left" width="65%">Name of the Branch</td>
<td align="right" width="30%"><%=Helper.correctNull((String)hshValues.get("org_name"))%></td>
</tr>
<tr>
<td align="left">b.</td>
<td align="left">Region</td>
<td align="right"><%=Helper.correctNull((String)hshValues.get("Reg_org_name")).toUpperCase()%></td>
</tr>
<tr>
<td align="left">c.</td>
<td align="left">Date of Branch Opening</td>
<td align="right"><%=Helper.correctNull((String)hshValues.get("org_opendate"))%></td>
</tr>
<tr>
<td align="left">d.</td>
<td align="left">Advances as on <%=Helper.correctNull((String)hshValues.get("com_advanceason"))%></td>
<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_advanceamt")))),strAmountValue)%></td>
</tr>
<tr>
<td align="left">e.</td>
<td align="left">Deposits as on <%=Helper.correctNull((String)hshValues.get("com_depositason"))%></td>
<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_depositamt")))),strAmountValue)%></td>
</tr>
<tr>
<td align="left">f.</td>
<td align="left">C/D Ratio</td>
<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblCDRatio"))))%> %</td>
</tr>
<tr>
<td align="left">g.</td>
<td align="left">Inspection Rating as on <%=Helper.correctNull((String)hshValues.get("com_inspectiondate"))%>
<br/><%if(strFormat.equalsIgnoreCase("Y")){ %>&nbsp;(amount net of unrealized interest)<%} %></td>
<td align="right"><%=Helper.correctNull((String)hshValues.get("com_inspectionamount"))%></td>
</tr>
<tr>
<td align="left">h.</td>
<td align="left">NPA at the branch as on <%=Helper.correctNull((String)hshValues.get("com_npaason"))%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull((String)hshValues.get("com_npaamt")),strAmountValue)%></td>
</tr>
<tr>
<td align="left">i.</td>
<td align="left">Percentage of NPA to total advances</td>
<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblPerTotAdvance"))))%>&nbsp;%</td>
</tr>
</table>
</div>
</td>
</tr>
<tr><td><br><br><br><br></td></tr>
</table>
</body>
</html>