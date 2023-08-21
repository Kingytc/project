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
var vararrAppno=new Array();

var vararrAppno1=new Array();

var vararrAppno2=new Array();

var coappname;
<%
if(arrAppno!=null)
{ 
		for(int i=0;i<arrAppno.size();i++)
		{
			%>
			vararrAppno["<%=i%>"] = "<%=Helper.correctNull((String)arrAppno.get(i))%>";
			<%
   	  	}
}

if(arrAppno1!=null)
{ 
		for(int i=0;i<arrAppno1.size();i++)
		{
			%>
			vararrAppno1["<%=i%>"] = "<%=Helper.correctNull((String)arrAppno1.get(i))%>";
			<%
   	  	}
}
if(arrAppno2!=null)
{
	for(int j=0;j<arrAppno2.size();j++)
	{
	%>
		vararrAppno2["<%=j%>"] = "<%=Helper.correctNull((String)arrAppno2.get(j))%>";
	<%
	}
}
%>
if(vararrAppno!="")
{
alert("The Person is Applicant to "+vararrAppno);
}
if(vararrAppno1!="")
{
alert("The Person is Coapplicant to "+vararrAppno1);
}
if(vararrAppno2!="")
{
alert("The Person is Guarantor to "+vararrAppno2);
}
if((vararrAppno1=="") && (vararrAppno2=="") && (vararrAppno==""))
{
alert("The Person is not CoApplicant/Guarantor to any applications");
}

	
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
