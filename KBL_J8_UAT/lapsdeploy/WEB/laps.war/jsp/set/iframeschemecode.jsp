<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	
	
ArrayList arrCol=(ArrayList)hshValues.get("arrCol");
	String strSchemeId=Helper.correctNull((String)hshValues.get("strSchemeId"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

function loadValues()
{	
	parent.frames.document.forms[0].schemecodeid1.options[0].text="----select----";
	parent.frames.document.forms[0].schemecodeid1.options[0].value="S";
	parent.frames.document.forms[0].schemecodeid1.length ="<%=arrCol.size()+1%>";

<%

	 if (arrCol!=null && arrCol.size() > 0)
	 {			
			for(int i=0;i<arrCol.size();i++)
			{
				String strCode=Helper.correctNull((String)arrCol.get(i));
			%>		
		    parent.frames.document.forms[0].schemecodeid1.options[<%=i+1%>].text="<%=strCode%>";
			parent.frames.document.forms[0].schemecodeid1.options[<%=i+1%>].value="<%=strCode%>";
			
<%	}
	 }
	 else
	 {
%>
		
		parent.frames.document.forms[0].schemecodeid1.length = 1;
		parent.frames.document.forms[0].schemecodeid1.options[0].text="-----select-----";
		parent.frames.document.forms[0].schemecodeid1.options[0].value="S";
<%	 }
%>
parent.frames.document.forms[0].schemecodeid1.value=parent.frames.strscheme_code;
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
