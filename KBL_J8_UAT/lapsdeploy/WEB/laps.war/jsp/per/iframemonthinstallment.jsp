<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";

function loadValues()
{
	parent.frames.document.forms[0].txtmonPay.value = "<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("emi"))))%>";
}

</script>
</head>

<body bgcolor="#E4E2ED" onLoad="loadValues()">
<form name="bfrm" method="post">

 </form>
</body>
</html>
