<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%-- <%out.println("hshValues======="+hshValues);%> --%>
<script>
function loadValues()
{
	
//alert("00000000000000");
	parent.frames.document.forms[0].hidsno.value = "<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>";	
	parent.frames.document.forms[0].selScheme.value = "<%=Helper.correctNull((String)hshValues.get("strStatId"))%>";
	parent.frames.document.forms[0].sel_state.value = "<%=Helper.correctNull((String)hshValues.get("AGR_DATA_STATE"))%>";
	parent.frames.document.forms[0].sel_actname.value = "<%=Helper.correctNull((String)hshValues.get("AGR_DATA_ACTNAME"))%>";
	parent.frames.document.forms[0].sel_specifica.value = "<%=Helper.correctNull((String)hshValues.get("AGR_DATA_SPECIFICATIONS"))%>";
	parent.frames.document.forms[0].sel_Action.value = "<%=Helper.correctNull((String)hshValues.get("AGR_ACTIVE"))%>";	
	
}
</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
