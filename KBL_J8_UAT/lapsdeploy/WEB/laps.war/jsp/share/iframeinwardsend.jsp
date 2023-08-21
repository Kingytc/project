<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
//System.out.println("hshValues---------------->>>>"+ hshValues);
	String strStatus = Helper.correctNull((String)hshValues.get("Status"));
	String strinwardno = Helper.correctNull((String)hshValues.get("inwardno"));
	String strMessage ="";
	//System.out.println("strStatus"+"   in"+ strStatus);
	ArrayList arrMessage = new ArrayList();
	
	if(hshValues.get("Message")!=null)
	{
		arrMessage = (ArrayList)hshValues.get("Message");
	}
	
	if(arrMessage!=null && arrMessage.size()>0)
	{
		for(int i=0; i<arrMessage.size(); i++)
			strMessage += Helper.correctNull((String)arrMessage.get(i)) + "\\n";
		
	}
	
%>

<html>
<head>
<title>Inward Check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var varStatus = "<%=strStatus%>";
var varinwardno="<%=strinwardno%>";

function loadValues()
{
	if(varStatus.toUpperCase()!="SUCCESS")
	{
		alert("<%=strMessage%>");
		parent.frames.document.forms[0].hidconfirm.value="N";
		
	}
	else
	{
		if(confirm('Please ensure that credit reports are created for company/ Directors/ partners/ proprietor/ applicant/ co-applicant/ guarantors'))
		{
			parent.frames.document.forms[0].remarksFlag.value="true";
			parent.frames.doSend('<%=strinwardno%>');
		}
	}
	
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post"></form>
</body>
</html>
