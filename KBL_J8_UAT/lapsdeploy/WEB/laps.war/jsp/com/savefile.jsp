<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<html>
<head>
<script>
</script>
<body >
<form>
<img name ="a" src="<%=hshValues.get("strURL")%>" width="100" height="130">
</form>
</body>
</html>
