<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>


<%

if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}

ArrayList arrOutCol	= new ArrayList();
ArrayList arrOutRow	= new ArrayList();

ArrayList arrOut	= new ArrayList();

String strPagetype = Helper.correctNull((String)request.getParameter("pageVal"));

if(strPagetype.equalsIgnoreCase("FINANCIAL"))
{
	hshValues = (HashMap)hshValues.get("FINANCIAL");
}


arrOutRow = (ArrayList) hshValues.get("Array");

////out.println(arrOutRow);



//////arrOut = (ArrayList) hshValues.get("hshReqValues40");

/////out.println("=============+++"+hshValues.get("hshReqValues40"));
String strFlag = Helper.correctNull((String)hshValues.get("strFlag"));
String strFinvaluesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
String strFormat = Helper.correctNull((String)request.getParameter("strFormat"));


%>


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
<body>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<% if(strPagetype.equalsIgnoreCase("FINANCIAL")) {  %>
<tr><td align="center" class="title"><br>ANNEXURE</td></tr>
<tr><td align="center" class="title"><br>FINANCIAL STATEMENTS</td></tr>
<%}else if (strFormat.equalsIgnoreCase("EAN9")) { %>
<tr><td align="center" class="title"><br>ANNEXURE - IX</td></tr>
<tr><td align="center" class="title"><br>PROJECTED FINANCIAL STATEMENTS</td></tr>
<%}  else if (strFlag.equalsIgnoreCase("Y")) { %>
	<tr><td align="center" class="title"><br>ANNEXURE - IV</td></tr>
	<tr><td align="center" class="title"><br>PROJECTED PROFITABILITY STATEMENT AND BALANCE SHEET</td></tr>
<%}else {  %>
<tr><td align="center" class="title"><br>ANNEXURE - VIII</td></tr>
<tr><td align="center" class="title"><br>PROJECTED FINANCIAL STATEMENTS</td></tr>
<%} %>
<tr><td><br></td></tr>
</table>

<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3">
		<tr>
			<td valign="top"><b>LIABILITIES:</b></td>
		</tr>
		<tr>
			<td align="right">(Rs. in <%=strFinvaluesIn %>)</td>                     
		</tr>
<tr>
<td>
<jsp:include page="../com/com_AnnexureIX_financial_print.jsp" flush="true">
 <jsp:param name="pagevalue" value="hshReqValues" />
</jsp:include>
</td>
</tr>
<tr>
			<td valign="top"><b>ASSETS:</b></td>
		</tr>
		<tr>
			<td align="right">(Rs. in <%=strFinvaluesIn %>)</td>                     
		</tr>
<tr>
<td>

<jsp:include page="../com/com_AnnexureIX_financial_print.jsp" flush="true">
 <jsp:param name="pagevalue" value="hshReqValues1" />
</jsp:include>

</td>
</tr>
<tr>
			<td valign="top"><b>PROFIT AND LOSS ACCOUNT:</b></td>
		</tr>
		<tr>
			<td align="right">(Rs. in <%=strFinvaluesIn %>)</td>                     
		</tr>
<tr>
<td>

<jsp:include page="../com/com_AnnexureIX_financial_print.jsp" flush="true">
 <jsp:param name="pagevalue" value="hshReqValues2" />
</jsp:include>
</td>
</tr>
</table>
<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3">
		<tr>
			<td valign="top"><b>RATIO ANALYSIS:</b></td>
		</tr>
</table>

	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3">
		<tr>
			<td align="left"><br><b>CAPITALISATION/COVERAGE/LIQUIDITY RATIOS :</b></td>                     
		</tr>
		<tr>
			<td align="right">(Rs. in <%=strFinvaluesIn %>)</td>                     
		</tr>
	
		<tr valign="top">
			<td><div id="top">
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues3" />
				</jsp:include>
			</div></td>
		</tr>
		<tr>
			<td align="left"><br><b>PROFITABILITY/TURN OVER/ OPERATING : </b></td>                     
	  	</tr>
	  	<tr>
			<td align="right">(Rs. in <%=strFinvaluesIn%>)</td>                     
		</tr>
	  	
		<tr valign="top">
			<td><div id="top">
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues4" />
				</jsp:include>
			</div></td>
		</tr>
	</table>
</body>

</html>