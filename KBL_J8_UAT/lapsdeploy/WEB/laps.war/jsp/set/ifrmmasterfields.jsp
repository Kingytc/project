<%@include file="../share/directives.jsp"%>

<%
ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();
	String strPos=Helper.correctNull((String)request.getParameter("strPos"));
%>

<html>
<head>
<title>Untitled Document</title>

<script>
function loadValues()
{
	<%
	if(vecRow!=null && vecRow.size()>0){%>
	eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).length ="<%=(vecRow.size())+1%>";
	eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).options[0].text="<--select-->";
	eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).options[0].value="0";
		<%for(int i=0;i<vecRow.size();i++)
		{
			vecCol=(ArrayList)vecRow.get(i);%>
			eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).options[<%=i+1%>].text="<%=Helper.correctNull((String)vecCol.get(3))%>";
			eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).options[<%=i+1%>].value="<%=Helper.correctNull((String)vecCol.get(1))%>";	
			
		<%}
		
	}else{%>
	eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).length =1;
	eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).options[0].text="<--select-->";
	eval("parent.frames.document.forms[0].selmasterfield"+<%=strPos%>).options[0].value="";
	<%}%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>