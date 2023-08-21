<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	parent.frames.document.forms[0].txtdaysfrom.value = "<%=Helper.correctNull((String)hshValues.get("daysfrom"))%>";	
	parent.frames.document.forms[0].txtdaysupto.value = "<%=Helper.correctNull((String)hshValues.get("daysupto"))%>";
	parent.frames.document.forms[0].hidDelFlag.value = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
	parent.frames.disableCommandButtons("select");
}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
