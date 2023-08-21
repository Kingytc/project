<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
ArrayList arrAppno=(ArrayList)hshValues.get("arrAppno");
ArrayList arrAppno1=(ArrayList)hshValues.get("arrAppno1");
ArrayList arrAppno2=(ArrayList)hshValues.get("arrAppno2");
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

function loadValues()
{
var vararrPolicyno=new Array();




<%
if(arrAppno1!=null)
{ 
		for(int i=0;i<arrAppno1.size();i++)
		{
			%>
			vararrPolicyno["<%=i%>"] = "<%=Helper.correctNull((String)arrAppno1.get(i))%>";
			<%
   	  	}
}


%>

if(vararrPolicyno!="")
{
alert("The Policy no is already made Collateral "+vararrPolicyno);
}


}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
