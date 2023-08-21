<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<html>
<script> 
var appUrl="<%=ApplicationParams.getAppUrl()%>";
function loadvalues()
{
	
	parent.frames.document.forms[1].txtsanamount.value = "<%=Helper.correctNull((String)hshValues.get("LOAN_RECMDAMT"))%>";
	parent.frames.document.forms[1].txtprocfees.value = "<%=Helper.correctNull((String)hshValues.get("LOAN_PROCFEE"))%>";
	parent.frames.document.forms[1].txttenure.value = "<%=Helper.correctNull((String)hshValues.get("LOAN_REQTERMS"))%>";
	parent.frames.document.forms[1].txtemi.value="<%=Helper.correctNull((String)hshValues.get("LOAN_EMI"))%>";
	parent.frames.document.forms[1].txtsandate.value = "<%=Helper.correctNull((String)hshValues.get("LOAN_PAPER_DATE"))%>";
	
}
function callcustprof()
{
	var varQryString = appUrl+"action/mastersearchper.jsp?";
	var title = "CUSTOMERPROFILE";
	var prop = "scrollbars=yes,width=1850,height=1450";	
	prop = prop + ",left=50,top=150";
	window.open(varQryString,title,prop);
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<head>
<title></title>



</head>
<body onload="loadvalues()"> 
	
</body>
</html>