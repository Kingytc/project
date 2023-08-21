<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	
	String strExisValue=Helper.correctDouble((String)hshValues.get("FACILITY_SANCAMT"));
	String strFacNature=Helper.correctDouble((String)hshValues.get("FACILITY_FACNATURE"));
	String strLimittype=Helper.correctDouble((String)hshValues.get("Limittype"));
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type="text/javascript">
var varExisLimit="<%=strExisValue%>";
var varFacNature="<%=strFacNature%>";
var varLimittype="<%=strLimittype%>";

function loadValues()
{	
	if(varFacNature =="2")
	{
		alert("Choose OD facility for renewal of existing account");
		if(varLimittype == "M")
		{
			for(var i=0;i<parent.frames.document.forms[0].sel_restr_acc.options.length;i++)
			{
				parent.frames.document.forms[0].sel_restr_acc.options[i].selected = false;
			}
		}
		else
		{
			for(var i=0;i<parent.frames.document.forms[0].sel_restr_acc_sub.options.length;i++)
			{
				parent.frames.document.forms[0].sel_restr_acc_sub.options[i].selected = false;
			}
		}
		return;
	}
	if(varLimittype == "M")
	{
		parent.frames.document.forms[0].txt_exist_limit.value =  varExisLimit;
	}
	else
	{
		parent.frames.document.forms[0].txt_subexist_limit.value =  varExisLimit;
	}
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
