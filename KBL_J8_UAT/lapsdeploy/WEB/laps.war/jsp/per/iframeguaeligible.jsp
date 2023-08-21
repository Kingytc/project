<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	out.print("------------------>"+hshValues);
%>
<script>

var guaage="<%=Helper.correctNull((String)hshValues.get("prd_guaminage"))%>";
var prdage="<%=Helper.correctNull((String)hshValues.get("perapp_age"))%>";
function loading()
{
	alert(guaage);
	alert(prdage);
	if(guaage>prdage)
	{
		alert("Guarantor is not Eligible");
		return;
	}
}

</script>

</head>
<body   onload="loading()">
<form name="ifrme" method="post">
</form>
</body>

</html>
