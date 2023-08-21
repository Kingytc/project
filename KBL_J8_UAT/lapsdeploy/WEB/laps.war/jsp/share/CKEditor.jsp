<%@ page import="com.sai.laps.helper.*"%>
<!DOCTYPE html>
<html>
<head>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
function editor_generate(name)
{
	CKEDITOR.replace( name, {
		height: 260,
		width: 1200,
	} );
}
</script>
</head>
</html>