<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
ArrayList arrlawyerlist =(ArrayList)hshValues.get("vecValues");
String strtype=Helper.correctNull((String)hshValues.get("strtype"));
//out.println("================================="+hshValues);
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>


function loadValues()
{
	

<%
if(strtype.equalsIgnoreCase("Actname")){
	 if (arrlawyerlist!=null && arrlawyerlist.size() > 0)
	 {
%>
		parent.frames.document.forms[0].txt_activity.length = "<%=arrlawyerlist.size()%>";
<%		
	for(int i=0;i<arrlawyerlist.size();i++)
	{
		ArrayList arrCol=new ArrayList();
		arrCol=(ArrayList)arrlawyerlist.get(i);
%>
			parent.frames.document.forms[0].txt_activity.options[<%=i%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].txt_activity.options[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
<%
		}
	 }
	 else
	{
%>
		parent.frames.document.forms[0].txt_activity.length =0;
<%	}}%>

<%
if(strtype.equalsIgnoreCase("Specname")){
	 if (arrlawyerlist!=null && arrlawyerlist.size() > 0)
	 {
%>
		parent.frames.document.forms[0].sel_specifications.length = "<%=arrlawyerlist.size()%>";
<%		
	for(int i=0;i<arrlawyerlist.size();i++)
	{
		ArrayList arrCol=new ArrayList();
		arrCol=(ArrayList)arrlawyerlist.get(i);
%>
			parent.frames.document.forms[0].sel_specifications.options[<%=i%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].sel_specifications.options[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
<%
		}
	 }
	 else
	{
%>
		parent.frames.document.forms[0].sel_specifications.length =0;
<%	}}%>
	
}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
</form>
</body>
</html>
