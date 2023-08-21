<%@include file="../share/directives.jsp"%>
<lapschoice:handleerror />
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
String strSubSectorVal="";
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	strSubSectorVal=Helper.correctNull((String)hshValues.get("strSubSectorVal"));
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
		parent.frames.document.forms[0].sel_subsector.length="<%=arrRow.size()+1%>";
		<%
		if(arrRow.size()>0)
		{
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strDesc=Helper.correctNull((String)arrCol.get(1));
			%>
				parent.frames.document.forms[0].sel_subsector.options["<%=i+1%>"].value="<%=strCode%>";
				parent.frames.document.forms[0].sel_subsector.options["<%=i+1%>"].text="<%=strDesc%>";
			<%
			}
			if(!strSubSectorVal.equalsIgnoreCase(""))
			{
				%>
				parent.frames.document.forms[0].sel_subsector.value="<%=strSubSectorVal%>";
				<%
			}
		}
		else
		{
			arrCol=(ArrayList)arrRow.get(0);
			String strCode=Helper.correctNull((String)arrCol.get(0));
			String strDesc=Helper.correctNull((String)arrCol.get(1));
		%>
			parent.frames.document.forms[0].sel_subsector.value="<%=strCode%>";
			parent.frames.document.forms[0].sel_subsector.text="<%=strDesc%>";
	<%
		}
	}
	%>
}
</script>
</head>
<body onload="callOnLoad();">
<form>
</form>
</body>
</html>