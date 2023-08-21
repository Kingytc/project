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
		for(int i=0;i<vecProdCode.size();i++)
		{
			String b = (String)vecProdCode.get(i);
			String c = (String)vecProdName.get(i);
	%>
		document.forms[0].prodcat.options[document.forms[0].prodcat.options.length]=new Option("<%= c %>","<%= b %>");
	<%
		}
	 }
	%>
   
	if (prod == "prod")
	{
		if (document.forms[0].prodcat.length > 0)
		{
			parent.frames.document.orgfrm.prodcat.length =document.forms[0].prodcat.length+1;
			for(i=0;i<document.forms[0].prodcat.length;i++)
			{
				parent.frames.document.orgfrm.prodcat.options[i+1].text=document.forms[0].prodcat.options[i].text;
				parent.frames.document.orgfrm.prodcat.options[i+1].value=document.forms[0].prodcat.options[i].value;
			}
		}
	}
	else if (prod =="subprod")
	{
		if (document.forms[0].prodcat.length > 0)
		{
			parent.frames.document.orgfrm.rpselect1.length =document.forms[0].prodcat.length;
			for(i=0;i<document.forms[0].prodcat.length;i++)
			{
				parent.frames.document.orgfrm.rpselect1.options[i].text=document.forms[0].prodcat.options[i].text;
				parent.frames.document.orgfrm.rpselect1.options[i].value=document.forms[0].prodcat.options[i].value;
			}
		}
	}

}

</script>
<style>
select {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399 ;border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399}
</style>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
  <select name="prodcat" style="width:120"  >
                        
</select>


</form>
</body>
</html>
