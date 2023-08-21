<%@ include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%
String strcersaireq = Helper.correctNull((String) hshValues.get("strcersaireq"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script type="text/javascript">
var varcersaireq = "<%=strcersaireq%>";
function loadValues()
{
	parent.frames.document.forms[0].hid_croptypefromstat.value=varcersaireq;
}
</script>
<body onload="loadValues()">
<form action="post"></form>
</body>
</html>