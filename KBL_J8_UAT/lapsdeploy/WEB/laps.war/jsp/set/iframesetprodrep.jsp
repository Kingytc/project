<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%!
  String strProdid ="";
  ArrayList vecProdCode = new ArrayList();	
  ArrayList vecProdName = new ArrayList();	
  String strFrom="";

%>


<%
	
	vecProdCode =(ArrayList)hshValues.get("vecCodes");
	vecProdName =(ArrayList)hshValues.get("vecValues");
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var prod ="<%=(String)hshValues.get("hidProducts")%>";
function loadValues()
{
	<%
	 if (vecProdCode.size() > 0)
	 {
	%>
		if (prod == "prod")
		{
			parent.frames.document.forms[0].prodcat.length =<%=vecProdCode.size()%>+1;
		}
		else if (prod == "subprod")
		{
			parent.frames.document.forms[0].product.length =<%=vecProdCode.size()%>;
		}
	<%	for(int i=0;i<vecProdCode.size();i++)
		{
			String b = (String)vecProdCode.get(i);
			String c = (String)vecProdName.get(i);
	%>
			if (prod =="prod")
			{
	
				parent.frames.document.forms[0].prodcat.options[<%=i+1%>].text="<%= c %>";
				parent.frames.document.forms[0].prodcat.options[<%=i+1%>].value="<%= b %>";
	
			}
			else if (prod =="subprod")
			{
	
				parent.frames.document.forms[0].product.options[<%=i%>].text="<%= c %>";
				parent.frames.document.forms[0].product.options[<%=i%>].value="<%= b %>";
	
			}	
	<%	}
	
		}
	%>
   
	

}

</script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
</style>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
 
</form>
</body>
</html>
