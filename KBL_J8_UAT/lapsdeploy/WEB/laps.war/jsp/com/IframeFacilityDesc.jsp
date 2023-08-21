<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
 <%
 	ArrayList arrValues = null;
	ArrayList arrRow	=new ArrayList();
	int iSize = 0;
	if (hshValues != null) 
	{
		arrValues = (ArrayList) hshValues.get("arrRow");
		if (arrValues != null && arrValues.size() > 0)
			iSize = arrValues.size();
	}
	
 %>
<html>
<head>
<script>
var selval="<%=Helper.correctNull((String)request.getParameter("val1"))%>";
function callOnload()
{
	<%
	int j=0;
	if (arrValues != null && arrValues.size() > 0)
	{%>
		parent.frames.document.forms[0].sel_Facility.options.length="0";
		parent.frames.document.forms[0].sel_Facility.options[0]=new Option('--Select--','');
		<%for (int i = 0; i < iSize; i++)
		{
			arrRow = (ArrayList) arrValues.get(i);
			j=i;
			%>
			parent.frames.document.forms[0].sel_Facility.options[<%=j+1%>]=new Option('<%=arrRow.get(1)%>','<%=arrRow.get(0)%>');
			parent.frames.document.forms[0].sel_Facility.options[<%=(j+1)%>].title="'<%=arrRow.get(1)%>'";
		<%}
		
		
	}else{
	%>
	parent.frames.document.forms[0].sel_Facility.options.length="0";
	parent.frames.document.forms[0].sel_Facility.options[0]=new Option('--Select--','');

	<%}%>

	if(selval!="")
	{
		parent.frames.document.forms[0].sel_Facility.value=selval;
	}
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body onload="callOnload();">

</body>
</html>