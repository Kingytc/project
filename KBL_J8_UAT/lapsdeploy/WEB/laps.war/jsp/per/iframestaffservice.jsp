<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	String minservice="",maxservice="",MAX_ELIGIBLE_AMOUNT="";
	minservice=Helper.correctNull((String)hshValues.get("minservice")); 
	 maxservice=Helper.correctNull((String)hshValues.get("maxservice")); 
	 MAX_ELIGIBLE_AMOUNT=Helper.correctNull((String)hshValues.get("MAX_ELIGIBLE_AMOUNT")); 
	 
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
  
function loadValues()
{
	parent.frames.document.forms[0].hidminservice.value="<%=minservice%>";
	parent.frames.document.forms[0].hidmaxservice.value="<%=maxservice%>";
	parent.frames.document.forms[0].hidserviceamount.value="<%=MAX_ELIGIBLE_AMOUNT%>";
	parent.frames.checkcalstaff();
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">

 </form>
</body>
</html>