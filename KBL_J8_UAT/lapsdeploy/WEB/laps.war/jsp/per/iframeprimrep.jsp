<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList vecOrgCode =(ArrayList)hshValues.get("vecCodes");
	ArrayList vecOrgName =(ArrayList)hshValues.get("vecValues");
	out.println(hshValues);
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

function loadValues()
{
<%
	 if (vecOrgCode.size() > 0)
	 {
	
		String s = (String)vecOrgCode.get(0);
		
%>

			parent.frames.document.forms[0].selappno.length ="<%=vecOrgCode.size()%>";
			
<%			for(int i=0;i<vecOrgCode.size();i++)
			{
				String b = (String)vecOrgCode.get(i);
				String c = (String)vecOrgName.get(i);
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
<%  }
%>
	
}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
