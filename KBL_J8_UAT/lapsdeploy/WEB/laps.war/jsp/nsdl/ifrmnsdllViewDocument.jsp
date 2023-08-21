<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Document Verification</title>
</head>
<body>
<%if(!Helper.correctNull((String)hshValues.get("Message")).equalsIgnoreCase("")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
<tr>
<td  align="center" style="color: #942188;"><%=Helper.correctNull((String)hshValues.get("Message")) %>
</td>
</tr>
</table>
<%} %>
</body>
</html>