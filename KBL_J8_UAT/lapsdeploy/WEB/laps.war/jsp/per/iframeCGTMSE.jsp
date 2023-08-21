<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varCGTMSEStatus="<%=Helper.correctNullCBS((String)hshValues.get("cbs_static_cgtmse"))%>";

function loadValues()
{
	
	parent.frames.document.forms[0].hidcgtmsestat.value=varCGTMSEStatus;
	if(varCGTMSEStatus=="Y")
	{
		parent.frames.document.all.id_cgtmse.style.visibility="visible";
		parent.frames.document.all.id_cgtmse.style.position="relative";
	}
	else
	{
		parent.frames.document.all.id_cgtmse.style.visibility="hidden";
		parent.frames.document.all.id_cgtmse.style.position="absolute";
		parent.frames.document.forms[0].hidcgtmsestat.value="N";
	}
}
</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form method="post">
</form>
</body>
</html>