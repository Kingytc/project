<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ page import="java.util.*,java.text.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<% request.setAttribute("_cache_refresh", "true"); %>

<laps:handleerror />
<html>
<head>
<title>Annexure corporation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}

#top {
	background-color: #ffffff;
}

#top table {
	border-collapse: collapse;
}

#top td {
	border: 0.5pt solid #000000;
	FONT-SIZE: 16px;
	COLOR: #000000;
	LINE-HEIGHT: 16px;
	FONT-FAMILY: "Book Antiqua"
}

.title {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
	font-weight: bold !important;
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
<table width="100%" align="center" cellpadding="3" cellspacing="0"
	border="0">

	<tr>
		<td align="center" class="title"><br>
		ANNEXURE</td>
	</tr>

	<tr>
		<td align="center" class="title"><br>
		Guarantee Amount wise requirement of financial data</td>
	</tr>
	<tr>
		<td><br>
		</td>
	</tr>
</table>



<table width="95%" border="0" cellspacing="0" align="center"
	cellpadding="3" class="">
	<tr valign="top">
		<td><jsp:include page="../print/com_Corp_Financialprint.jsp"
			flush="true">
			<jsp:param name="pagevalue1"  value="hshReqValues2" />
			<jsp:param name="pagevalue"  value="hshReqValues3" />
		</jsp:include></td>
	</tr>
</table>
<br>
<br>

<table width="100%" border="0" cellspacing="0" align="center"
	cellpadding="3" class="">
	<tr valign="top">
		<td><jsp:include page="../print/com_Corp_AnnexureII.jsp"
			flush="true">
			<jsp:param name="pagevalue" value="hshReqValues5" />
		</jsp:include></td>
	</tr>
</table>




</body>

</html>