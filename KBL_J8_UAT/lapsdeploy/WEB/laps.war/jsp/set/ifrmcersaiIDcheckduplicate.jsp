<%@include file="../share/directives.jsp"%>
<% 
String strrowindexname=Helper.correctNull((String)request.getParameter("strrowindexname"));
	%>
<html>
<head>
<title>Security</title>
<script>
var cersaiID="<%=Helper.correctNull((String)hshValues.get("strCersaiCheck"))%>";
var CUS_SEC_ID="<%=Helper.correctNull((String)hshValues.get("CUS_SEC_ID"))%>";
var varGSTAvail="<%=Helper.correctNull((String)hshValues.get("strGSTAvailability"))%>";
var varCustCBSID="<%=Helper.correctNull((String)hshValues.get("strCustCBSID"))%>";
var varPage="<%=Helper.correctNull((String)request.getParameter("strPage"))%>";
var varAcctAvail="<%=Helper.correctNull((String)hshValues.get("strAccNoAvailability"))%>";

function cerCheckDuplicate()
{
	if(varPage=="Cust"||varPage=="Prop")
	{
		parent.frames.document.forms[0].cmdsave.disabled=false;
	}
	if(cersaiID=="Y"){
		alert("Cersai ID is already mapped with Security ID -->" +CUS_SEC_ID);
		parent.frames.document.forms[0].<%=strrowindexname%>.value="";
		return;
	}
	else if(varGSTAvail=="Y")
	{
		alert("GST No is already mapped with the Customer ID "+varCustCBSID);
		parent.frames.document.forms[0].<%=strrowindexname%>.value="";
		return;
	}
	else if(varAcctAvail=="N")
	{
		alert("Entered Operative Account Number is not Available / SBNRE account is not allowed for selection");
		parent.frames.document.forms[0].<%=strrowindexname%>.value="";
		return;
	}
}

</script>
</head>
<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="cerCheckDuplicate();">
<form name="appfrm" method="post">
</form>
</body>
</html>
