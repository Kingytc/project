<%@ include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%
String app_enchflag = Helper.correctNull((String) hshValues.get("app_enchflag"));
String app_enachdate = Helper.correctNull((String) hshValues.get("Timestramp"));
String EnachUpdate = Helper.correctNull((String) hshValues.get("EnachUpdate"));

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>frame Enach</title>
</head>
<script type="text/javascript">
var app_enchflag = "<%=app_enchflag%>";
var app_enachdate = "<%=app_enachdate%>";
var varEnachUpdate = "<%= EnachUpdate %>";

function loadValues()
{
	parent.frames.document.forms[0].app_enchflag.value=app_enchflag;
	parent.frames.document.forms[0].app_enachdate.value=app_enachdate;
	
	parent.frames.loadPage();

}
</script>
<body onload="loadValues()">
<form action="post"></form>
</body>
<input type="hidden" name="app_enchflag" value="<%=app_enchflag%>">
<input type="hidden" name="app_enachdate" value="<%=app_enachdate%>">

</html>