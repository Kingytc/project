<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	
	out.println("hshValues----"+hshValues);
	ArrayList vecRow = new ArrayList();
	ArrayList vecCol  = new ArrayList();
	int vecsize=0;
	if(hshValues!=null)
	{
		vecRow = (ArrayList)hshValues.get("vecRow");
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
		if(vecRow!=null)
		{
			vecsize = vecRow.size();
		}
		for(int i=0;i<vecsize;i++)
		{	vecCol = (ArrayList)vecRow.get(i);
			if(vecCol!=null)
			{			
	%>       
			parent.frames.document.forms[0].txttrmdesc.value = "<%=Helper.correctNull((String)vecCol.get(2))%>";
			parent.frames.document.forms[0].txttrmcontent.value= "<%=Helper.correctNull((String)vecCol.get(3))%>" ;		
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
