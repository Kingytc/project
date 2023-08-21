<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrCol");
	//System.out.println("arrRow arrRow : " + arrRow);
	ArrayList arrCol=new ArrayList();
	
	String strScheme=Helper.correctNull((String)hshValues.get("strScheme"));
	String strModule = Helper.correctNull((String)request.getParameter("page")).trim();
	String strsubheadcode= Helper.correctNull((String)request.getParameter("subheadcode"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varsubheadcode="<%=strsubheadcode%>";
function loadValues()
{
	var temp;
	<%
	if (arrRow!=null && arrRow.size() > 0)
	{ %>			
	parent.frames.document.forms[0].selschemehead.length ="<%=arrRow.size()+1%>";
	<%	for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrCol!=null && arrCol.size() > 0){
			%>
			parent.frames.document.forms[0].selschemehead.options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(2))%>";
			parent.frames.document.forms[0].selschemehead.options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(2))%>";
			temp="<%=Helper.correctNull((String)arrCol.get(2))%>";
	  <%}}
	  %>
	  if(parent.frames.sel_schemeheadcode=="")
		{
			parent.frames.document.forms[0].selschemehead.value="S";
		}
		else
		{
			parent.frames.document.forms[0].selschemehead.value=parent.frames.sel_schemeheadcode;
		}
	  <%
	}%>
	if(varsubheadcode!="")
	{
		 parent.frames.document.forms[0].selschemehead.value=varsubheadcode;
	}
	else
	{
		if(parent.frames.document.forms[0].selschemehead.length>1)
		{
	 		parent.frames.document.forms[0].selschemehead.selectedIndex=0;
		}
	}
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>