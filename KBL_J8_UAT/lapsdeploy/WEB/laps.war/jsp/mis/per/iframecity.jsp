<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList vecCityName = (ArrayList)hshValues.get("vecName");
	ArrayList vecCityCode =(ArrayList)hshValues.get("vecCode");
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

function loadValues()
{
<%
//System.out.println("----------------->>>>>>>>>>>>>.");
	 if (vecCityCode.size() > 0)
	 {
%>
			parent.frames.document.forms[0].rpselect1.length ="<%=vecCityCode.size()%>";
<%			for(int i=0;i<vecCityCode.size();i++)
			{
				String b = (String)vecCityCode.get(i);
				String c = (String)vecCityName.get(i);
%>
		    parent.frames.document.forms[0].rpselect1.options[<%=i%>].text="<%=c%>";
			parent.frames.document.forms[0].rpselect1.options[<%=i%>].value="<%=b%>";
<%
			}
	 }
	 else
	 {
%>
		parent.frames.document.forms[0].rpselect1.length =0;
<%	 }
%>
	
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
