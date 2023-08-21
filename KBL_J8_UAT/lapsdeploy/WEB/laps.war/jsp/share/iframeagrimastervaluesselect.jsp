<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
	String sel_actname=Helper.correctNull((String)hshValues.get("sel_actname"));
	String sel_specifica=Helper.correctNull((String)hshValues.get("sel_specifica"));
	
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var selactname="<%=sel_actname%>";
function loadValues()
{
	//alert("***************"+selactname);

	<%if(Helper.correctNull((String)hshValues.get("stype")).equalsIgnoreCase("ACT"))
	{%>
	
	parent.frames.document.forms[0].txt_activity.options[0].text="<%=Helper.correctNull((String)hshValues.get("sel_actnamedesc"))%>";
	parent.frames.document.forms[0].txt_activity.options[0].value="<%=sel_actname%>";
parent.frames.document.forms[0].txt_activity.value="<%=sel_actname%>"; 
<%-- 	parent.frames.document.forms[0].txt_activity.text="<%=sel_actname%>"; --%>
	
	//window.opener.document.forms[0].txtperapp_branch.value =val2;
	//alert("*******parent.frames.document.forms[0].txt_activity.value********"+parent.frames.document.forms[0].txt_activity.value);
	<%}%>
	
	
	<%if(Helper.correctNull((String)hshValues.get("stype")).equalsIgnoreCase("SPEC"))
	{%>
	
	parent.frames.document.forms[0].txt_activity.options[0].text="<%=Helper.correctNull((String)hshValues.get("sel_actnamedesc"))%>";
	parent.frames.document.forms[0].txt_activity.options[0].value="<%=sel_actname%>";
parent.frames.document.forms[0].txt_activity.value="<%=sel_actname%>"; 


	parent.frames.document.forms[0].sel_specifications.options[0].text="<%=Helper.correctNull((String)hshValues.get("sel_specificadesc"))%>";
	parent.frames.document.forms[0].sel_specifications.options[0].value="<%=sel_specifica%>";
parent.frames.document.forms[0].sel_specifications.value="<%=sel_specifica%>"; 
<%-- 	parent.frames.document.forms[0].txt_activity.text="<%=sel_actname%>"; --%>
	
	//window.opener.document.forms[0].txtperapp_branch.value =val2;
	//alert("*******parent.frames.document.forms[0].sel_specifications.value********"+parent.frames.document.forms[0].sel_specifications.value);
	<%}%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
