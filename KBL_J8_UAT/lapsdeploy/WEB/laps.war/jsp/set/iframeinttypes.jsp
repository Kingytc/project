<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
	
%>
<html>
<head>
<title>Untitled Document</title>

<script type="text/javascript">
var varRule="<%=Helper.correctNull((String)request.getParameter("strRule"))%>";

function loadValues()
{	
	<%  if (arrRow!=null && arrRow.size() > 0)
	{%>
		parent.frames.document.forms[0].select_rule.length ="<%=arrRow.size()+1%>";
		parent.frames.document.forms[0].select_rule.options[0].text="---Select---";
		parent.frames.document.forms[0].select_rule.options[0].value="";
		
<%		for(int i=0;i<arrRow.size();i++)
		{
			
			arrCol=(ArrayList)arrRow.get(i);
			String code=Helper.correctNull((String)arrCol.get(0));
			String description=Helper.correctNull((String)arrCol.get(1));
			if(description.contains("------"))
			{
				description = description.replace("------","");
			}
%>


		    parent.frames.document.forms[0].select_rule.options[<%=i+1%>].text="<%=description%>";
			parent.frames.document.forms[0].select_rule.options[<%=i+1%>].value="<%=code%>";
			
	<%
			}
	}
	else
	{
%>
		parent.frames.document.forms[0].select_rule.length=1;	
		parent.frames.document.forms[0].select_rule.options[0].text="---Select---";
		parent.frames.document.forms[0].select_rule.options[0].value="";
<%	 }
%>

	if(varRule!="")
	{
		parent.frames.document.forms[0].select_rule.value=varRule;
	}
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
