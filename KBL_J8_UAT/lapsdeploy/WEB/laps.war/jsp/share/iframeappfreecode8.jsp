<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
String strSelectedValue="",strfreecode8="";

if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	strSelectedValue=Helper.correctNull((String)hshValues.get("strSelectedValue"));
	strfreecode8=Helper.correctNull((String)hshValues.get("freecode8"));

}
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	var varSelectedValue="<%=strSelectedValue%>";
	
	<%  if (arrRow!=null&&arrRow.size() > 0)
		{%>
			parent.frames.document.forms[0].sel_freecode8.length ="<%=arrRow.size()%>";

	<%		for(int i=0;i<arrRow.size();i++)
			{
		
				arrCol=(ArrayList)arrRow.get(i);
				String code=Helper.correctNull((String)arrCol.get(0));
				String description=Helper.correctNull((String)arrCol.get(1));
	%>
			
			    parent.frames.document.forms[0].sel_freecode8.options[<%=i%>].text="<%=description%>";
				parent.frames.document.forms[0].sel_freecode8.options[<%=i%>].value="<%=code%>";

	<%
				String strCode=Helper.correctNull((String)arrCol.get(2));
				if(code.equalsIgnoreCase(strSelectedValue))
				{%>
				parent.frames.document.forms[0].hidFreeCode8.value="<%=strCode%>";
				<%}
			} 
	if(!strSelectedValue.equalsIgnoreCase("")){

			if(arrRow.size() > 1) {%>
		parent.frames.document.forms[0].sel_freecode8.value="<%=strSelectedValue%>";
	<%}else
	{ %>
			parent.frames.document.forms[0].sel_freecode8.options.selected=true;
	<%
		}}}
		else
		{
	%>
			parent.frames.document.forms[0].sel_freecode8.options[0].text="---Select---";
			parent.frames.document.forms[0].sel_freecode8.options[0].value="";
	<%	 }
	%>

	<%if(!strfreecode8.equalsIgnoreCase("")){%>
	parent.frames.document.forms[0].sel_freecode8.value="<%=strfreecode8%>";
	<%}%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
<input type="hidden" name="hidParentLevel">
</form>
</body>
</html>
