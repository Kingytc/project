<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	String strStatus = Helper.correctNull((String)hshValues.get("Status"));
	String strMessage ="";
	
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
	String hidPage=Helper.correctNull((String)request.getParameter("hidPage"));
	
%>

<html>
<head>
<title>Agriculture Eligibility Check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>

var path="<%=ApplicationParams.getAppUrl()%>";
var varStatus = "<%=strStatus%>";
var hidPage="<%=hidPage%>";

function loadValues()
{
	if(varStatus.toUpperCase()!="SUCCESS")
	{
		alert("<%=strMessage%>");
//		parent.frames.document.forms[0].cmdapply.disabled=true;
		parent.frames.document.forms[0].hidAction.value="";
   		parent.frames.document.forms[0].hid_option.value="";
		parent.frames.enableButtons(true, true, false, true,true);
		parent.frames.disablefields(true);
		parent.frames.document.forms[0].txt_date.readOnly=true;
	}
	else
	{
	//	parent.frames.document.forms[0].cmdapply.disabled=false;
		parent.frames.document.forms[0].hidAction.value="update"
   		parent.frames.document.forms[0].hid_option.value="";
		parent.frames.enableButtons(true, false, false, false, true);
		parent.frames.disablefields(false);
		parent.frames.document.forms[0].txt_date.readOnly=true;		
	}
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post"></form>
</body>
</html>
