<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
ArrayList arrCol=new ArrayList();
%>
<html>
<head>
<title>Security Classification</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varType="<%=Helper.correctNull((String)request.getParameter("sel_Assessment"))%>";
function loadValues()
{	
	<%
	 if (arrRow!=null && arrRow.size() > 0)
	 {%>		
		 parent.frames.document.forms[0].sel_assessment.length ="<%=arrRow.size()+1%>";
		<%for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strClassificationDesc=Helper.correctNull((String)arrCol.get(1));
			%>		
		    parent.frames.document.forms[0].sel_assessment.options[<%=i+1%>].text="<%=strClassificationDesc%>";
			parent.frames.document.forms[0].sel_assessment.options[<%=i+1%>].value="<%=strCode%>";
			
		<%	}
	 }
	 else
	 {
	%>
		
		parent.frames.document.forms[0].sel_assessment.length =1;
		 parent.frames.document.forms[0].sel_assessment.options[0].text="-----select-----";
			parent.frames.document.forms[0].sel_assessment.options[0].value="0";
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