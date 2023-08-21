<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
//out.println("iframe ="+hshValues);

%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

function loadValues()
{
	parent.frames.document.forms[0].txtCPRes.value="<%=(String)hshValues.get("curprires")%>";
	parent.frames.document.forms[0].txtRPRes.value="<%=(String)hshValues.get("resprires")%>";
	parent.frames.document.forms[0].txtCIRes.value="<%=(String)hshValues.get("curint")%>";

	parent.frames.document.forms[0].txtRIRes.value="<%=(String)hshValues.get("resint")%>";
	parent.frames.document.forms[0].txtC.value="<%=(String)hshValues.get("curtot")%>";
	parent.frames.document.forms[0].txtN.value="<%=(String)hshValues.get("restot")%>";

	parent.frames.document.forms[0].txtPriRes.value="<%=(String)hshValues.get("prigain")%>";
	parent.frames.document.forms[0].txtIntRes.value="<%=(String)hshValues.get("intgain")%>";
	parent.frames.document.forms[0].txtRPI.value="<%=(String)hshValues.get("totgain")%>";
	//parent.frames.document.forms[0].row1.value="<%=(String)hshValues.get("row1")%>";	
	//parent.frames.document.forms[0].row2.value="<%=(String)hshValues.get("row2")%>";	
	//parent.frames.document.forms[0].row3.value="<%=(String)hshValues.get("row3")%>";
	<%
	String str1=Helper.correctNull((String)hshValues.get("row1"));
	str1=str1.trim();
	String str2=Helper.correctNull((String)hshValues.get("row2"));
	str2=str2.trim();
	String str3=Helper.correctNull((String)hshValues.get("row3"));
	str3=str3.trim();
	%>

	var row1 =  "<%=str1%>";
	var row2 =	"<%=str2%>";
	var row3 =	"<%=str3%>";
	
		if(row1=="P")
		{
			parent.frames.document.all.txtId1.style.color="blue";
		}
		else
		{

			parent.frames.document.all.txtId1.style.color="red";
		}

		if(row2=="P")
		{
			parent.frames.document.all.txtId2.style.color="blue";
		}
		else
		{
			parent.frames.document.all.txtId2.style.color="red";
		}

		if(row3=="P")
		{
			parent.frames.document.all.txtId3.style.color="blue";
		}
		else
		{
			parent.frames.document.all.txtId3.style.color="red";
		}

}

</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
