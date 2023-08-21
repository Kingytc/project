<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
	ArrayList arrCol=new ArrayList();
	String strSancAuth=Helper.correctNull((String)hshValues.get("strSancAuth"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";


function loadValues()
{
	<%
	if(arrRow!=null&&arrRow.size()>0)
	{
	%>
		parent.frames.document.forms[0].sel_mclrtype.length="<%=arrRow.size()+1%>";
		<%
		if(arrRow!=null && arrRow.size()>0)
		{
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=(ArrayList)arrRow.get(i);
				String strId=Helper.correctNull((String)arrCol.get(0))+"@"+Helper.correctNull((String)arrCol.get(2))+"@"+Helper.correctNull((String)arrCol.get(3))+"@"+Helper.correctNull((String)arrCol.get(4));
				String strName=Helper.correctNull((String)arrCol.get(1))+"-"+Helper.correctNull((String)arrCol.get(2));
				
	
			%>
			
			var str1="<%=strId%>";
			var strName1="<%=strName%>";
			
				parent.frames.document.forms[0].sel_mclrtype.options["<%=i+1%>"].value="<%=strId%>";
				parent.frames.document.forms[0].sel_mclrtype.options["<%=i+1%>"].text="<%=strName%>";
			<%
			}
		}
		else
		{

		%>
			parent.frames.document.forms[0].sel_subsector.value="";
			
	<%
		}
	} else{
	%>
	alert("FBIL-TBILL Interest Rate not available for the date selected");
	parent.frames.document.forms[0].sel_mclrtype.length=1;
	//parent.frames.document.forms[0].sel_subsector.value="";
	parent.frames.document.forms[0].sel_mclrtype.options.value="";
	parent.frames.document.forms[0].sel_mclrtype.options.text="<--select-->";
	<%}%>
	parent.frames.document.forms[0].sel_mclrtype.disabled=false;
}
</script>

</head>
<body onLoad="loadValues()">

</body>
</html>