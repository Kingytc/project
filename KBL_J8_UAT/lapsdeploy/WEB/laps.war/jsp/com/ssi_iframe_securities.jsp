<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	
	
	ArrayList vecData = new ArrayList();
	ArrayList vecRow  = new ArrayList();
	int vecsize=0;
	if(hshValues!=null)
	{
		vecData = (ArrayList)hshValues.get("vecData");
	}
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
 <%
		if(vecData!=null)
		{
			vecsize = vecData.size();
		}
		String strSno="";

		for(int i=0;i<vecsize;i++)
		{	vecRow = (ArrayList)vecData.get(i);
			if(vecRow!=null)
			{			
	%>       
		parent.frames.document.forms[0].txtcrd_gradeid.value = "<%=Helper.correctNull((String)vecRow.get(0))%>";
		parent.frames.document.forms[0].txtcrd_naturegrade.value= "<%=Helper.correctNull((String)vecRow.get(1))%>" ;		
		parent.frames.document.forms[0].txtcrd_scorefrom.value= "<%=Helper.correctNull((String)vecRow.get(2))%>";	
		parent.frames.document.forms[0].txtcrd_scoreto.value = "<%=Helper.correctNull((String)vecRow.get(3))%>";
		parent.frames.document.forms[0].txtcrd_gradedefine.value = "<%=Helper.correctNull((String)vecRow.get(4))%>";
<%
		}
	}	
%>

}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
