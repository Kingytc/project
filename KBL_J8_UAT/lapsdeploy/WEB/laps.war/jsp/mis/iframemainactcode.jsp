<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror />
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
String strSubActCode="",strsubactval="";
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	strSubActCode=Helper.correctNull((String)hshValues.get("strSubActCode"));
	strsubactval=Helper.correctNull((String)hshValues.get("subactval"));
}
%>
<html>
<head>
<script>
function callOnLoad()
{
	<%
	if(arrRow!=null&&arrRow.size()>0)
	{
	%>
		parent.frames.document.forms[0].sel_SubActivity.length="<%=arrRow.size()+1%>";
		<%
		if(arrRow.size()>1)
		{
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strDesc=Helper.correctNull((String)arrCol.get(1));
			%>
				parent.frames.document.forms[0].sel_SubActivity.options["<%=i+1%>"].value="<%=strCode%>";
				parent.frames.document.forms[0].sel_SubActivity.options["<%=i+1%>"].text="<%=strCode%> - <%=strDesc%>";
			<%
			}
			if(!strSubActCode.equalsIgnoreCase(""))
			{
				%>
				parent.frames.document.forms[0].sel_SubActivity.value="<%=strSubActCode%>";
					
				<%
				
			}
			else
			{
				%>
				parent.frames.document.forms[0].sel_SubActivity.value="";
				<%
			}
		}
		else
		{
			arrCol=(ArrayList)arrRow.get(0);
			String strCode=Helper.correctNull((String)arrCol.get(0));
			String strDesc=Helper.correctNull((String)arrCol.get(1));
		%>
			parent.frames.document.forms[0].sel_SubActivity.options[0].value="<%=strCode%>";
			parent.frames.document.forms[0].sel_SubActivity.options[0].text="<%=strCode%> - <%=strDesc%>";
		<%
		}
	}
	%>
	<%if(!strsubactval.equalsIgnoreCase("")){%>
	parent.frames.document.forms[0].sel_SubActivity.value = "<%=strsubactval%>";
	<%}%>
}
</script>
<title>Iframe - Main Activity Code</title>
</head>
<body onload="callOnLoad();">

</body>
</html>