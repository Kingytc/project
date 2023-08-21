<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
	String strSancBranch=Helper.correctNull((String)hshValues.get("strSancBranch"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	<%
	int a=Integer.parseInt(Helper.correctInt((String)hshValues.get("strEnabledcnt")));
	if (arrRow!=null && arrRow.size() > 0)
	{
		if((Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("cr"))){
			a=arrRow.size();
						}%>			
	parent.frames.document.forms[0].sel_SancBranch.length ="<%=a+1%>";
	parent.frames.document.forms[0].sel_SancBranch.options[0].text="<--select-->";
	parent.frames.document.forms[0].sel_SancBranch.options[0].value="";
	<%int b=1;	
	for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrCol!=null && arrCol.size() > 0){
				if(Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("cr")){
			%>
			parent.frames.document.forms[0].sel_SancBranch.options[<%=b%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].sel_SancBranch.options[<%=b%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			<%b++;}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){
			%>
			parent.frames.document.forms[0].sel_SancBranch.options[<%=b%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].sel_SancBranch.options[<%=b%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			
	  <%	b++;}}
		}
	  
	if(!(strSancBranch.equalsIgnoreCase("s")||strSancBranch.equalsIgnoreCase(""))){%>
	parent.frames.document.forms[0].sel_SancBranch.value="<%=strSancBranch%>";
	<%}else{%>
	parent.frames.document.forms[0].sel_SancBranch.value="";
	<%}}else{%>
	parent.frames.document.forms[0].sel_SancBranch.value="";
	<%}%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>