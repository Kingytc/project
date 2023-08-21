<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="../share/directives.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
var Alert = "<%=Helper.correctNull((String)hshValues.get("returnVal"))%>";
function onLoading(){
	if(Alert!="")
	{
		alert(Alert);
		parent.frames.document.forms[0].sel_facility.value = "s";
	}
}
</script>
</head>
<body onload="onLoading()">

</body>
</html>