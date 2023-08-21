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
	parent.frames.document.forms[0].txtloan_docfee.value="<%=(String)hshValues.get("docfee")%>";
	parent.frames.document.forms[0].txtloan_procfee.value="<%=(String)hshValues.get("procfee")%>";
}

</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
