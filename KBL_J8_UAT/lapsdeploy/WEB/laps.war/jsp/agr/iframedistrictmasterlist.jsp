<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
ArrayList g1 =  new ArrayList();

ArrayList	v = (ArrayList) hshValues.get("vecRow");
if((v == null))
{
	v = new ArrayList();
}
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	
<%  if (v!=null && v.size() > 0)
	{%>
		parent.frames.document.forms[0].txt_district.length ="<%=v.size()+1%>";

		parent.frames.document.forms[0].txt_district.options[0].text="---Select---";
		parent.frames.document.forms[0].txt_district.options[0].value="";
		
<%		for(int i=0;i<v.size();i++)
		{
	
			g1 = (ArrayList)v.get(i);
			String code=Helper.correctNull((String)g1.get(2));
			String description=Helper.correctNull((String)g1.get(3));
			
%>

		    parent.frames.document.forms[0].txt_district.options[<%=i+1%>].text="<%=description%>";
			parent.frames.document.forms[0].txt_district.options[<%=i+1%>].value="<%=code%>";
		
	  <%}
	}else{%>
	parent.frames.document.forms[0].txt_district.length=1;
	parent.frames.document.forms[0].txt_district.options[0].text="---Select---";
	parent.frames.document.forms[0].txt_district.options[0].value="";
	<%}%>		
}
</script>
</head>
<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
<input type ="hidden" name="strStatId" value="<%=Helper.correctNull((String)hshValues.get("strStatId"))%>">

</form>
</body>
</html>
