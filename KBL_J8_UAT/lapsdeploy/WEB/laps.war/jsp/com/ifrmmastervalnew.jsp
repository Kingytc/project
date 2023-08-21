<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
	String strObjectName=Helper.correctNull((String)hshValues.get("strObjectName"));
%>

<html>
<head>
<title>Untitled Document</title>

<script>
function loadValues()
{
	<%
	int a=Integer.parseInt(Helper.correctInt((String)hshValues.get("strActiveCnt")))+1;
	if (arrRow!=null && arrRow.size() > 0)
	{
		if((Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("cr"))){
			a=arrRow.size()+1;
						}%>			
	parent.frames.document.forms[0].<%=strObjectName%>.length ="<%=a%>";
	<%int b=0;	
	for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrCol!=null && arrCol.size() > 0){
				if(Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("cr")){
					b++;
			%>
			parent.frames.document.forms[0].<%=strObjectName%>.options[<%=b%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].<%=strObjectName%>.options[<%=b%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			<%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("Y")){
			b++;%>
			parent.frames.document.forms[0].<%=strObjectName%>.options[<%=b%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].<%=strObjectName%>.options[<%=b%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			
	  <%	}}
		}
	  if(!Helper.correctNull((String)hshValues.get("strVal")).equalsIgnoreCase(""))
	  {%>
	  parent.frames.document.forms[0].<%=strObjectName%>.value="<%=Helper.correctNull((String)hshValues.get("strVal"))%>";
	 <% }
	}else{%>
	parent.frames.document.forms[0].<%=strObjectName%>.length =1;
	parent.frames.document.forms[0].<%=strObjectName%>.options[0].text="<--select-->";
	parent.frames.document.forms[0].<%=strObjectName%>.options[0].value="s";
	<%}%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>