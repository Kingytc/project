<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
String strRangeExist=Helper.correctNull((String)hshValues.get("strRangeExist"));
String strDesc=Helper.correctNull((String)hshValues.get("strDesc"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varrangecheck="<%=strRangeExist%>";
var varDesc="<%=strDesc%>";
function loadValues()
{
		parent.frames.document.forms[0].hidRangeExist.value=varrangecheck;
		parent.frames.document.forms[0].hidDescription.value=varDesc;
		parent.frames.doSave();
}
</script>
</head>
<body onLoad="loadValues()">
<form method="post">
</form>
</body>
</html>
