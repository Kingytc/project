<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	
	//out.println("hshValues----"+hshValues);
	Vector vecData = new Vector();
	Vector vecRow  = new Vector();
	int vecsize=0;
	if(hshValues!=null)
	{
		vecData = (Vector)hshValues.get("vecData");
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
		{	vecRow = (Vector)vecData.elementAt(i);
			if(vecRow!=null)
			{			
	%>       
		parent.frames.document.forms[0].idno.value = "<%=Helper.correctNull((String)vecRow.elementAt(0))%>";	
		parent.frames.document.forms[0].selyear.value = "<%=Helper.correctNull((String)vecRow.elementAt(1))%>";
		parent.frames.document.forms[0].tution.value= "<%=Helper.correctNull((String)vecRow.elementAt(2))%>";
		parent.frames.document.forms[0].exam.value= "<%=Helper.correctNull((String)vecRow.elementAt(3))%>";
		parent.frames.document.forms[0].books.value = "<%=Helper.correctNull((String)vecRow.elementAt(7))%>";
		parent.frames.document.forms[0].lodge.value = "<%=Helper.correctNull((String)vecRow.elementAt(5))%>";	
		parent.frames.document.forms[0].lab.value = "<%=Helper.correctNull((String)vecRow.elementAt(4))%>";
		parent.frames.document.forms[0].scholar.value = "<%=Helper.correctNull((String)vecRow.elementAt(9))%>";
		parent.frames.document.forms[0].trvexp.value = "<%=Helper.correctNull((String)vecRow.elementAt(6))%>";
		parent.frames.document.forms[0].ownSource.value = "<%=Helper.correctNull((String)vecRow.elementAt(11))%>";
		
	
		
		
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
