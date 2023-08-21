<%@include file="../share/directives.jsp"%>
<html>
<head>
<script>
	var appURL = "<%=ApplicationParams.getAppUrl()%>";
	var validateflag="<%= Helper.correctNull((String)hshValues.get("validateflag"))%>";
	
function callonload()
{
	if(validateflag=="Y")
	{	
		alert("Customer ID Validated Successfully, You can proceed for ID Change");
		parent.frames.document.forms[0].cmdchange.disabled=false;
		parent.frames.document.all.idremarks.style.visibility="visible";
		parent.frames.document.all.idremarks.style.position="relative";
	}
	else
	{
		alert("Customer ID Validation Failed");
		parent.frames.document.forms[0].cmdchange.disabled=true;
		parent.frames.document.all.idremarks.style.visibility="hidden";
		parent.frames.document.all.idremarks.style.position="absolute";
	}
}	
</script>
</head>
<body onload="callonload()">


</body>
</html>