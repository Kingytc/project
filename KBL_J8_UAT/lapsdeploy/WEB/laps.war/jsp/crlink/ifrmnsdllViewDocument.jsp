<%@ page import="com.sai.laps.helper.*,java.util.*,java.io.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />

<html>
<script>
function loadImage()
{
	document.photo.src="<%=ApplicationParams.getAppUrl()%>img/main_bg.gif";
}

</script>
<head>
<title>Document Verification</title>



</head>
<body  onLoad="loadImage()">
<%if(!Helper.correctNull((String)hshValues.get("Message")).equalsIgnoreCase("")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
<tr>
<td  align="center"><%=Helper.correctNull((String)hshValues.get("Message")) %>
</td>
</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="3" >
<tr>
<td>
<img src="<%=ApplicationParams.getAppUrl()%>img/main_bg.gif" name="photo" height="200" width="140" align="right">
</td>
</tr>
</table>
</body>
</html>