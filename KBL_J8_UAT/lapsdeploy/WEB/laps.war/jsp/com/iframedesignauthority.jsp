<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
	String strSancAuth=Helper.correctNull((String)hshValues.get("strSancAuth"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	<%if (arrRow!=null && arrRow.size() > 0)
	{ %>			
		parent.frames.document.forms[0].seldesignaion.length ="<%=arrRow.size()+1%>";
	<%	for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrCol!=null && arrCol.size() > 0)
			{%>
			parent.frames.document.forms[0].seldesignaion.options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].seldesignaion.options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
	  <%	}
		}
	  
	}else{%>
		parent.frames.document.forms[0].seldesignaion.length =1;
		parent.frames.document.forms[0].seldesignaion.options[0].text="<--select-->";
		parent.frames.document.forms[0].seldesignaion.options[0].value="S";
	<%}%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>