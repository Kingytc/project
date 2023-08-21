<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	ArrayList vecOrgCode =(ArrayList)hshValues.get("vecCodes");
	ArrayList vecOrgName =(ArrayList)hshValues.get("vecValues");
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>


function loadValues()
{
<%
	 if (vecOrgCode.size() > 0)
	 {
		for(int i=0;i<vecOrgCode.size();i++)
		{
			String b = (String)vecOrgCode.get(i);
			String c = (String)vecOrgName.get(i);
%>
		document.forms[0].prodcat.options[document.forms[0].prodcat.options.length]=new Option("<%= c %>","<%= b %>");
<%
		}
	 }
%>
	placeValue();
}

function placeValue()
{
	if (document.forms[0].prodcat.length > 0)
	{
		parent.frames.document.forms[0].rpselect1.length =document.forms[0].prodcat.length;
		for(i=0;i<document.forms[0].prodcat.length;i++)
		{
			parent.frames.document.forms[0].rpselect1.options[i].text=document.forms[0].prodcat.options[i].text;
			parent.frames.document.forms[0].rpselect1.options[i].value=document.forms[0].prodcat.options[i].value;
		}
	}
	else
	{
		parent.frames.document.forms[0].rpselect1.length =0;
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
