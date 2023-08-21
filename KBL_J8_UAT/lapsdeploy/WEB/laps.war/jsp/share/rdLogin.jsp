<%@ page import="com.sai.laps.helper.*" %>
<html>
<body>
<script>
function loadData()
{
	alert("Invalid Session or Session has been Expired")
	
	if(window.opener != null)
	{
	window.opener.document.forms[0].target="_top";
	window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
	window.opener.document.forms[0].submit();
	window.close();
	}
	else
	{
	document.forms[0].target="_top";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/login.jsp";
	document.forms[0].submit();
	}
}
</script>
<body onLoad="loadData()">
<form name="f1">

</form>
</body>

</html>