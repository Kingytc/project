<%@include file="../share/directives.jsp"%>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var varDataFlag="<%=Helper.correctNull((String)hshValues.get("strDataFlag"))%>";
function loadValues()
{
	if(varDataFlag=="Y")
	{
		parent.frames.document.forms[0].txt_username.value = "<%=Helper.correctNull((String)hshValues.get("strName"))%>";
		parent.frames.document.forms[0].cmdunlock.disabled=false;
	}
	else
	{
		parent.frames.document.forms[0].txt_username.value = "";
		parent.frames.document.forms[0].cmdunlock.disabled=true;
	}
}

</script>
</head>

<body bgcolor="#E4E2ED" onLoad="loadValues()">
<form name="bfrm" method="post">

 </form>
</body>
</html>
