<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList vecAppno =(ArrayList)hshValues.get("vecValues");
ArrayList vecUserNames =(ArrayList)hshValues.get("vecUser");
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>


function loadValues()
{

<%
	 if (vecAppno.size() > 0)
	 {
%>
		parent.frames.document.forms[0].selappno.length = "<%=vecAppno.size()%>";
<%		for(int i=0;i<vecAppno.size();i++)
		{
				String b = (String)vecAppno.get(i);
				

				String c = (String)vecUserNames.get(i);
				
				
				
%>
			parent.frames.document.forms[0].selappno.options[<%=i%>].text="<%=c%>";
			parent.frames.document.forms[0].selappno.options[<%=i%>].value="<%=b%>";
<%
		}
	 }
	 else
	{
%>
		parent.frames.document.forms[0].selappno.length =0;
<%	}%>
	
}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
</form>
</body>
</html>
