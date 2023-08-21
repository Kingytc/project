<%@include file="../share/directives.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script type="text/javascript">
var commissioncharges = "<%=Helper.correctNull((String) hshValues.get("procfee"))%>";

function onloading()
{		
		parent.document.forms[0].txt_commissionearn.value=commissioncharges;	
}


</script>
<body onload="onloading()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="frm1" method="post">
</form>
</body>
</html>