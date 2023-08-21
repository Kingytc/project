<%@include file="../share/directives.jsp"%>

<html>
<script>
function loadImage()
{
	document.photo.src="<%=ApplicationParams.getAppUrl()%>img/main_bg.gif";
}

</script>
<link rel="stylesheet"href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadImage()" >
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable tblbdr" >
<tr>
<td>
<img src="<%=ApplicationParams.getAppUrl()%>img/main_bg.gif" name="photo" height="200" width="140" align="right">
</td>
</tr>
</table>

<input type="hidden" name="appno">
<input type="hidden" name="hidId">
<input type="hidden" name="hidDocId" >
</body>
</html>

