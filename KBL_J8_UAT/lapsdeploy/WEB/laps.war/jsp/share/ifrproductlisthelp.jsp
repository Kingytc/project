<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />


<%


  ArrayList arryRow = new ArrayList();	
  ArrayList arryCol = new ArrayList();	
  

  arryRow = (ArrayList)hshValues.get("arryRow");
 
	String strConcat="";
	String strPrdvalue="";
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>

function loadValues()
{				
	<%if (arryRow.size() > 0)
	 {
		for(int i=0;i<arryRow.size();i++)
		{
			arryCol = (ArrayList)arryRow.get(i);
			
			strConcat=(String)arryCol.get(1)+"-";
			strConcat=strConcat+(String)arryCol.get(2)+"-";
			strConcat=strConcat+(String)arryCol.get(3)+"-";
			strConcat=strConcat+(String)arryCol.get(4);
			
			strPrdvalue = (String)arryCol.get(0)+"$"+(String)arryCol.get(5)+"$"+(String)arryCol.get(6)+
			"$"+(String)arryCol.get(7)+"$"+(String)arryCol.get(8)+"$"+(String)arryCol.get(9)+"$"
			+(String)arryCol.get(10)+"$"+strConcat;
			
			
	%>
	parent.frames.document.forms[0].producthelp.options[parent.frames.document.forms[0].producthelp.options.length]=new Option('<%=strConcat%>','<%=strPrdvalue%>');
	<%
		}
	 }
	%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
 

</form>
</body>
</html>
