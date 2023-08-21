<%@ page import="com.sai.laps.helper.*,java.util.HashMap" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request"/>
<laps:handleerror/>

<%
	out.println(hshValues.get("message"));
	out.println(hshValues.get("appno"));
    out.println(hshValues);
	String strMessage = (String)hshValues.get("message");
	String strSearch = request.getParameter("radSearch");
	String strAppno = (String)hshValues.get("appno");
%>

<html>
<head>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/perloanhist.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var strAppno = "<%=strAppno%>";
</script>
</head>
<body onload="showMessage('<%=strMessage%>','<%=strSearch%>')">
<form method="post" action="">

<input type="hidden" name="hidBeanGetMethod" value="getLoanProducts">
<!--<input type="hidden" name="appno"  value="<%=request.getParameter("txtSearch")%>">-->
<input type="hidden" name="radLoan"  value="<%=request.getParameter("radLoan")%>">


</form>
</body>
</html>