<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varsubtype="<%=Helper.correctNull((String)request.getParameter("strSubType"))%>";
var varRowLen="<%=Helper.correctNull((String)request.getParameter("strRowLen"))%>";
var varPosition="<%=Helper.correctNull((String)request.getParameter("strPosition"))%>";
function loadValues()
{
	if(eval(varRowLen)>=1)
	{
		var tab  = parent.frames.document.getElementById("tab_managdet");
		var rowsLength = tab.rows.length;
		if(eval(rowsLength)>1)
	{
		var tab  = parent.frames.document.getElementById("tab_managdet");
		var rowsLength = tab.rows.length;
		<%
		if (arrRow!=null && arrRow.size() > 0)
		{ %>	
		parent.frames.document.forms[0].comapp_divisionSubtype[varPosition].length ="<%=arrRow.size()+1%>";
		<%	for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				if(arrCol!=null && arrCol.size() > 0){
				%>
				parent.frames.document.forms[0].comapp_divisionSubtype[varPosition].options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
				parent.frames.document.forms[0].comapp_divisionSubtype[varPosition].options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
		  <%}}
		  %>
		parent.frames.document.forms[0].comapp_divisionSubtype[varPosition].value=varsubtype;
		  <%
		}else{%>
		parent.frames.document.forms[0].comapp_divisionSubtype[varPosition].length =1;
		parent.frames.document.forms[0].comapp_divisionSubtype[varPosition].options[0] = new Option('select','');
		<%}%>

	}else{
		<%
		if (arrRow!=null && arrRow.size() > 0)
		{ %>			
		
		parent.frames.document.forms[0].comapp_divisionSubtype.length ="<%=arrRow.size()+1%>";
		<%	for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				if(arrCol!=null && arrCol.size() > 0){
				%>
				parent.frames.document.forms[0].comapp_divisionSubtype.options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
				parent.frames.document.forms[0].comapp_divisionSubtype.options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
		  <%}}
		  %>
		parent.frames.document.forms[0].comapp_divisionSubtype.value=varsubtype;
		  <%
		}else{%>
		parent.frames.document.forms[0].comapp_divisionSubtype.length =1;
		parent.frames.document.forms[0].comapp_divisionSubtype.options[0] = new Option('select','');
		<%}%>
	}

	}else{
		<%
		if (arrRow!=null && arrRow.size() > 0)
		{ %>			
		
		parent.frames.document.forms[0].comapp_divisionSubtype.length ="<%=arrRow.size()+1%>";
		<%	for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				if(arrCol!=null && arrCol.size() > 0){
				%>
				parent.frames.document.forms[0].comapp_divisionSubtype.options[<%=i+1%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
				parent.frames.document.forms[0].comapp_divisionSubtype.options[<%=i+1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
		  <%}}
		  %>
		parent.frames.document.forms[0].comapp_divisionSubtype.value=varsubtype;
		  <%
		}else{%>
		parent.frames.document.forms[0].comapp_divisionSubtype.length =1;
		parent.frames.document.forms[0].comapp_divisionSubtype.options[0] = new Option('select','');
		<%}%>
	}
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>