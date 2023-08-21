<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
out.print(hshValues);	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

function loadValues()
{
	parent.frames.document.forms[0].namefostudent.value="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("perapp_fname")))%>";
	<%
	String strminor=Helper.correctNull((String)hshValues.get("minor"));
	if(!strminor.equalsIgnoreCase(""))
	{
		if(strminor.equalsIgnoreCase("2"))
		{%>
		parent.frames.document.forms[0].nameof.value="Father";
		parent.frames.document.forms[0].nameofval.value="<%=Helper.correctNull((String)hshValues.get("perapp_fatname"))%>";	
		<%
		}
		else 
		{%>	
		parent.frames.document.forms[0].nameof.value="Guardian";
		parent.frames.document.forms[0].nameofval.value="<%=Helper.correctNull((String)hshValues.get("gua_name"))%>";
		parent.frames.checkgua();
		parent.frames.document.forms[0].guastaterelation.value="<%=Helper.correctNull((String)hshValues.get("guardian"))%>";	
		<%}
	}%>
	
	
	parent.frames.document.forms[0].dob.value="<%=Helper.correctNull((String)hshValues.get("perapp_dob"))%>";
	parent.frames.document.forms[0].age.value="<%=Helper.correctNull((String)hshValues.get("perapp_age"))%>";
	parent.frames.document.forms[0].caste.value="<%=Helper.correctNull((String)hshValues.get("per_caste"))%>";
	<%
	String strrel="";
	String strreligion=Helper.correctNull((String)hshValues.get("perapp_religion"));
	if(!strreligion.equalsIgnoreCase(""))
	{
		if(strreligion.equalsIgnoreCase("001"))
		{
			strrel="Hindu";
		}
		if(strreligion.equalsIgnoreCase("002"))
		{
			strrel="Muslim";
		}
		if(strreligion.equalsIgnoreCase("003"))
		{
			strrel="Christian";
		}
		if(strreligion.equalsIgnoreCase("004"))
		{
			strrel="Sikhs";
		}
		if(strreligion.equalsIgnoreCase("005"))
		{
			strrel="Neo-Budhist";
		}
		if(strreligion.equalsIgnoreCase("006"))
		{
			strrel="Jain";
		}
		if(strreligion.equalsIgnoreCase("007"))
		{
			strrel="Parsi";
		}
		if(strreligion.equalsIgnoreCase("999"))
		{
			strrel="Others";
		}
	}
			
	
	%>
	parent.frames.document.forms[0].selreligion.value="<%=strrel%>";
	<%
	String strMaritStatus="";
	String strmarital=Helper.correctNull((String)hshValues.get("perapp_marstat"));
	if(strmarital.equalsIgnoreCase("1"))
	{
		strMaritStatus="Married";%>
		parent.frames.document.forms[0].noofchildren.value="<%=Helper.correctNull((String)hshValues.get("perapp_childnum"))%>";
	<%}
	if(strmarital.equalsIgnoreCase("2"))
	{
		strMaritStatus="Single";
	}
	if(strmarital.equalsIgnoreCase("3"))
	{
		strMaritStatus="Divorced";
	}
	if(strmarital.equalsIgnoreCase("4"))
	{
		strMaritStatus="Widowed";
	}
	if(strmarital.equalsIgnoreCase("5"))
	{
		strMaritStatus="Other";
	}
	%>
	parent.frames.document.forms[0].mstatus.value="<%=strMaritStatus%>";
	
	parent.frames.document.forms[0].addr1.value="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("perapp_address1")))%>";
	parent.frames.document.forms[0].addr2.value="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("perapp_address2")))%>";
	parent.frames.document.forms[0].addr3.value="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("perapp_address3")))%>";
	parent.frames.document.forms[0].hidcity.value="<%=Helper.correctNull((String)hshValues.get("perapp_city"))%>";
	parent.frames.document.forms[0].hidstate.value="<%=Helper.correctNull((String)hshValues.get("perapp_state"))%>";
	
	parent.frames.document.forms[0].city.value="<%=Helper.correctNull((String)hshValues.get("perapp_cityname"))%>";
	parent.frames.document.forms[0].state.value="<%=Helper.correctNull((String)hshValues.get("perapp_statename"))%>";
	parent.frames.document.forms[0].pincode.value="<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>";
	parent.frames.document.forms[0].mobile.value="<%=Helper.correctNull((String)hshValues.get("perapp_mobile"))%>";
	parent.frames.disableCommandButtons("edit");
	
	
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
