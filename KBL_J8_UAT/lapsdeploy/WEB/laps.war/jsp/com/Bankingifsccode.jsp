<%@ include file="../share/directives.jsp"%>

<%
String strBankname=Helper.correctNull((String)hshValues.get("strBankname"));
String strFINBankname=Helper.correctNull((String)hshValues.get("strFINBankname"));
%>
<html>
<head>
<title>Consortium Details</title>

<script>
var varBankname="<%=strBankname%>";
var strFINBankname="<%=strFINBankname%>";
function loadValues()
{
    parent.frames.document.forms[0].txt_LeadBankName.value = "<%=Helper.correctNull((String)hshValues.get("strBankingname"))%>";
	parent.frames.document.forms[0].txt_perbranch.value = "<%=Helper.correctNull((String)hshValues.get("strBranchname"))%>";
	parent.frames.document.forms[0].txt_email.value=""; 
}


</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>