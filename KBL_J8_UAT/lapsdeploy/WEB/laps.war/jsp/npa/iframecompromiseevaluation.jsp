<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
//out.print(hshValues);
%>
<script>


function loadValues()
{
	
	parent.frames.document.forms[0].securities_value.value = "<%=Helper.correctNull((String)hshValues.get("realisiblepoint"))%>";	
	parent.frames.document.forms[0].legalposition_value.value = "<%=Helper.correctNull((String)hshValues.get("legalpositionpoint"))%>";
	parent.frames.document.forms[0].means_value.value= "<%=Helper.correctNull((String)hshValues.get("aggregatemeanspoint"))%>";
	parent.frames.document.forms[0].npa_value.value= "<%=Helper.correctNull((String)hshValues.get("ageofnpapoints"))%>";
	parent.frames.document.forms[0].netscore_points.value= "<%=Helper.correctNull((String)hshValues.get("totalscore"))%>";
	
}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
