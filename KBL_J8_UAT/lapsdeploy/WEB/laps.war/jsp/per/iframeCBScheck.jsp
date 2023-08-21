<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varcbs_id="<%=Helper.correctNullCBS((String)hshValues.get("cust_id"))%>";
var varcbsidavailflag="<%=Helper.correctNull((String)hshValues.get("CBSIdavailflag"))%>";
var varapp_id="<%=Helper.correctNull((String) hshValues.get("app_id"))%>";
function loadValues()
{
	if(varcbsidavailflag=="N")
	{
		alert("The Customer ID does not exist");
		parent.frames.document.forms[0].txt_introcbs_id.value="";
		parent.frames.document.forms[0].txt_introcbs_id.focus();
		return;
	}
	else if(varcbs_id==varapp_id)
	{
		alert("Introducer ID should not same as customer ID");
		parent.frames.document.forms[0].txt_introcbs_id.value="";
		parent.frames.document.forms[0].txt_introcbs_id.focus();
		return;
	}
	else
	{
		parent.frames.document.forms[0].txt_introducer_name.value="<%=Helper.correctNullCBS((String)hshValues.get("cust_name"))%>";
	}
}
</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form method="post">
</form>
</body>
</html>