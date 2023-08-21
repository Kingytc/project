<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>

<laps:handleerror/>
<html>
<head>
<title>Annexure - IV</title>
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
<%
String strFinvaluesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
if(strFinvaluesIn.equalsIgnoreCase("Rs"))
{
	strFinvaluesIn	= "(Amount in  "+strFinvaluesIn+".)";
}
else
{
	strFinvaluesIn	= "(Rs. in  "+strFinvaluesIn+")";
}
String strPage=Helper.correctNull((String)request.getParameter("pagefrom"));
%>
<body>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(strPage.equalsIgnoreCase("strDelegation") || strPage.equalsIgnoreCase("annx")){ %>
<tr><td align="center" class="title"><br>ANNEXURE</td></tr>
<%}else {%>
<tr><td align="center" class="title"><br>ANNEXURE	- IV</td></tr>
<%} %>
<tr><td align="center" class="title"><br>FINANCIAL STATEMENTS/ RATIO ANALYSIS</td></tr>
<tr><td><br><br></td></tr>
</table>

<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3">
<tr> <td valign="top"><b>BALANCE SHEET :</b><br></td></tr>
</table>

 <table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
  <tr> <td align="right"> <%=strFinvaluesIn%></td>                     
 </tr></table>
 <table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
  <tr> <td align="right">As on</td>                     
 </tr>
 </table>
<div id="top">
 <table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
<tr><td align="left">
<b> LIABILITIES :</b></td>                     
  </tr>
<tr valign="top"><td>
<jsp:include page="../print/com_financialprint.jsp" flush="true">
 <jsp:param name="pagevalue" value="hshReqValues" />
</jsp:include></td></tr>
<tr><td align="left">
 <b>ASSETS : </b></td>                     
  </tr>
<tr valign="top"><td>
<jsp:include page="../print/com_financialprint.jsp" flush="true">
 <jsp:param name="pagevalue" value="hshReqValues1" />
</jsp:include></td></tr></table>
</div>
<br>

<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
<tr><td align="left">
<b> PROFIT AND LOSS ACCOUNT:</b></td>                     
  </tr></table>
  
<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
  <tr> <td align="right"><%=strFinvaluesIn %></td>                     
 </tr>
 </table>

<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
  <tr> <td align="right">For the year ended</td>                     
 </tr>
 </table>
 
<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
<tr valign="top"><td>
<jsp:include page="../print/com_financialprint.jsp" flush="true">
<jsp:param name="pagevalue" value="hshReqValues2" />
</jsp:include></td></tr>
</table>

<br>

 <table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
  <tr> <td align="right"><%=strFinvaluesIn%>/ As on / For the year ended</td>                     
 </tr></table>
 
 
<div id="top">
<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
<tr><td align="left">
<b> CAPITALISATION/COVERAGE/LIQUIDITY RATIOS :</b></td>                     
  </tr>
<tr valign="top"><td>
<jsp:include page="../print/com_financialprint.jsp" flush="true">
 <jsp:param name="pagevalue" value="hshReqValues3" />
</jsp:include></td></tr>
<tr><td align="left">
 <b>PROFITABILITY/TURN OVER/ OPERATING : </b></td>                     
  </tr>
<tr valign="top"><td>
<jsp:include page="../print/com_financialprint.jsp" flush="true">
 <jsp:param name="pagevalue" value="hshReqValues4" />
</jsp:include></td></tr>
</table>
</div>





<br>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%ArrayList arrcol=new ArrayList();
ArrayList arrrow=new ArrayList();
arrrow=(ArrayList)hshValues.get("arrCommentsRow");
if(arrrow!=null && arrrow.size()>0)
{
%>
<tr>
<td>
<b>FINANCIAL POSITION COMMENTS :</b>
</td>
</tr>
	
<%for(int i=0;i<arrrow.size();i++) {
	arrcol=(ArrayList)arrrow.get(i);

%>
<tr>
<td>
<b><%=Helper.correctNull((String)arrcol.get(0)) %> :</b>
</td>
</tr>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
</tr>
<tr>
<td>
<%=Helper.correctNull((String)arrcol.get(1)) %>
</td>
</tr>
</table></div>
</td>
</tr><%} } %>
</table>

</body>

</html>