<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
	String strSancAuth=Helper.correctNull((String)hshValues.get("strSancAuth"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	<%
	int a=Integer.parseInt(Helper.correctInt((String)hshValues.get("strEnabledcnt")))+1;
	if (arrRow!=null && arrRow.size() > 0)
	{
		if((Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("ca")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pa")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("pr")||
						Helper.correctNull((String)session.getAttribute("strappstatus")).equalsIgnoreCase("cr"))){
			a=arrRow.size()+1;
						}%>			
	parent.frames.document.forms[0].sel_SancAuth.length ="<%=a%>";
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
			parent.frames.document.forms[0].sel_SancAuth.options[<%=b%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].sel_SancAuth.options[<%=b%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			<%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){
			b++;%>
			parent.frames.document.forms[0].sel_SancAuth.options[<%=b%>].text="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].sel_SancAuth.options[<%=b%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			
	  <%	}}
		}
	  
	if(!(strSancAuth.equalsIgnoreCase("s")||strSancAuth.equalsIgnoreCase(""))){%>
	parent.frames.document.forms[0].sel_SancAuth.value="<%=strSancAuth%>";
	parent.frames.funsancrefno();
	<%}else{%>
	parent.frames.document.forms[0].sel_SancAuth.value="s";
	<%}}else{%>
	parent.frames.document.forms[0].sel_SancAuth.length =1;
	parent.frames.document.forms[0].sel_SancAuth.options[0].text="<--select-->";
	parent.frames.document.forms[0].sel_SancAuth.options[0].value="s";
	<%}%>
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>