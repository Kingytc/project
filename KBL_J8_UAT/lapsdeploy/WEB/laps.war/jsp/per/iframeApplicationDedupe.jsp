<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
var appRefNo="<%=Helper.correctNull((String)hshValues.get("applicationrefnumber"))%>";
var appStstus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
function loadValues()
{
	parent.frames.document.forms[0].hidApp_dedupestatus.value=appStstus;
	parent.frames.document.forms[0].hidApp_deduperefno.value=appRefNo;
}
</script>
</head>

<body onLoad="loadValues()"
<body>

</body>
</html>