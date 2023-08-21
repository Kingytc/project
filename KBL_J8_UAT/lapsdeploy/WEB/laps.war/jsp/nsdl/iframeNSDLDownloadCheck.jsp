<%@include file="../share/directives.jsp"%>
<head>
<script type="text/javascript">
var vStatus	= "<%=Helper.correctNull((String)hshValues.get("SuccessStatus"))%>";
function callStatusAlert()
{
	parent.callStatusAlert(vStatus);
}
</script>
</head>
<body onload="callStatusAlert()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="frm1" method="post">
</form>
</body>