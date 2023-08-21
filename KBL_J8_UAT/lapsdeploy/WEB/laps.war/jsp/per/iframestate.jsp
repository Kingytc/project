<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />


<%@page import="com.sai.laps.helper.Helper"%><html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	var hidzip;
	var comcust_zip;
	var cust_zip;
	parent.frames.document.forms[0].hidzip.value="<%=Helper.correctNull((String)hshValues.get("state_validatepin"))%>";
	hidzip=parent.frames.document.forms[0].hidzip.value;
	comcust_zip ="<%=Helper.correctNull((String)request.getParameter("cust_zip"))%>";
	
	if(comcust_zip.length>2)
	{
		cust_zip=comcust_zip.substring(0,2);
	}

	if(hidzip!='~')
	{
		var zipvaild = hidzip.split("~");
		if(!(zipvaild[0] > cust_zip) && (cust_zip> zipvaild[1]))
		{
			alert("The First two digit of the pincode should be between "+zipvaild[0] + " and " +zipvaild[1]);
			parent.frames.document.forms[0].txtcomcust_zip.value="";
			parent.frames.document.forms[0].txtcomcust_zip.focus();
		}
	}
}

</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
