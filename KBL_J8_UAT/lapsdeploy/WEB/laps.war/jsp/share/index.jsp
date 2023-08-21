<%@ page import="java.util.*,com.sai.laps.helper.*"%>
<% request.setAttribute("_cache_refresh", "true"); %>

<html>
<head>
<script>
function doSubmit(page)
{
	if(page=="groups")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setgroups.jsp";
		document.forms[0].submit();
	}
	else if(page=="users")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setusers.jsp";
		document.forms[0].submit();
	}
	else if(page=="products")
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setsearchproducts.jsp";
		document.forms[0].submit();
	}
}
</script>
<body>
<%=ApplicationParams.getXMLFilePath()%>
<br>
<%=ApplicationParams.getXMLFactory()%>
<br>
<%=ApplicationParams.getInitialContext()%>
<br>
<%=ApplicationParams.getProviderUrl()%>
<br>
<%=ApplicationParams.getDataSource()%>
<br>
<%=ApplicationParams.getAppUrl()%>
<br>


<form name="frm" method="post" >
<input type="button" name="groups" value="Groups" onclick="doSubmit('groups')">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" name="users" value="Users" onclick="doSubmit('users')">
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input type="button" name="products" value="Products" onclick="doSubmit('products')">
</form>
</body>
<head>
</html>
