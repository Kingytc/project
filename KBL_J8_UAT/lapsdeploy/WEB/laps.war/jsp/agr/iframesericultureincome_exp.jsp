<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="com.sai.fw.management.utils.*"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%@include file="../share/directives.jsp"%>
<%  ArrayList arrValues = new ArrayList();
	String  strKilogram="";	
	if (hshValues != null) {
		arrValues 	= (ArrayList) hshValues.get("arrPart");
		strKilogram	= (String) hshValues.get("kilogram");
	}	
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>

function loadValues()
{
	<% 
		if(arrValues!=null && arrValues.size()>0){%>
			
		<%for(int j=0;j<arrValues.size();j++)
		{
			ArrayList arrVal = (ArrayList) arrValues.get(j);
			if(arrVal.size()>0){%> 
				
			 parent.frames.document.forms[0].txt_desc["<%=j%>"].value = "<%=FwHelper.correctNull((String)arrVal.get(0))%>";
			 parent.frames.document.forms[0].txt_rate1["<%=j%>"].value = "<%=FwHelper.formatDoubleValue(FwHelper.parseDouble((String)arrVal.get(1)))%>";
			 parent.frames.document.forms[0].txt_total1["<%=j%>"].value = "<%=FwHelper.formatDoubleValue(FwHelper.parseDouble((String)arrVal.get(2)))%>";
			 parent.frames.document.forms[0].txt_rate2["<%=j%>"].value = "<%=FwHelper.formatDoubleValue(FwHelper.parseDouble((String)arrVal.get(3)))%>";
			 parent.frames.document.forms[0].txt_total2["<%=j%>"].value = "<%=FwHelper.formatDoubleValue(FwHelper.parseDouble((String)arrVal.get(4)))%>";
			 <%if(j==0){%>
			 	parent.frames.document.forms[0].txt_kg.value = "<%=FwHelper.parseDouble((String)arrVal.get(5))%>";
			 <%}%>
			
				
		<%}}%>
		
		<%for(int j=arrValues.size();j<10;j++)
		{%>
			parent.frames.document.forms[0].txt_desc["<%=j%>"].value = "";
			parent.frames.document.forms[0].txt_rate1["<%=j%>"].value = "";
			 parent.frames.document.forms[0].txt_total1["<%=j%>"].value = "";
			 parent.frames.document.forms[0].txt_rate2["<%=j%>"].value = "";
			 parent.frames.document.forms[0].txt_total2["<%=j%>"].value = "";
	
		<%}%>
	<%}
		else{%>
		
		 		 
		 for(var i=0;i<parent.frames.document.forms[0].txt_rate1.length;i++)
		{
			parent.frames.document.forms[0].txt_rate1[i].value="";
			parent.frames.document.forms[0].txt_total1[i].value="";
			parent.frames.document.forms[0].txt_rate2[i].value="";
			parent.frames.document.forms[0].txt_total2[i].value="";
			parent.frames.document.forms[0].txt_kg.value="";
			
		}
		 for(var i=5;i<parent.frames.document.forms[0].txt_desc.length;i++)
		{
			parent.frames.document.forms[0].txt_desc[i].value="";
		}
		
		 
	<%}%>
		
		
	
}

 
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>