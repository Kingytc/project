<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%	
String strNsccheck=Helper.correctNull((String)hshValues.get("Nsccheck"));
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var Nsccheck="<%=strNsccheck%>";
function loadValues()
{
	if(Nsccheck!="")
	{
		alert(" He already avail Nsc Loan So Not Eligible");
		return;
	}
}
</script>
</head>
<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>