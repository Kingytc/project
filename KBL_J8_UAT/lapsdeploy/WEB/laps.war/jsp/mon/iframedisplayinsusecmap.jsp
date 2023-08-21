<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
	



%>

<html>
<head>
<title>Purpose check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaSc ript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var securitynature= "<%=Helper.correctNull((String)hshValues.get("securitynature"))%>";
var Insurance= "<%=Helper.correctNull((String)hshValues.get("Insurance"))%>";
var path="<%=ApplicationParams.getAppUrl()%>";
var varrecordflag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";

function loadValues()
{
	    if(securitynature !="")
	    {
	    	parent.frames.document.forms[0].sel_securitynature.value=securitynature;
	    	parent.frames.document.forms[0].hidAuditFlag.value=varrecordflag;
	    }
	    else
	    {
	    	parent.frames.document.forms[0].sel_securitynature.value="0";
	    }
	    
		
	if(Insurance!="")
	{
		varinsurance=Insurance.split("@");
		for(var j=0;j<parent.frames.document.forms[0].selinsurance.length;j++)
		{
			
				parent.frames.document.forms[0].selinsurance.options[j].selected=false
			
		}	
		for(var i=0;i<Insurance.length-1;i++)
		{
			var selValue=varinsurance[i];
			
			for(var j=0;j<parent.frames.document.forms[0].selinsurance.length;j++)
			{
				if(parent.frames.document.forms[0].selinsurance.options[j].value==selValue)
				{
					parent.frames.document.forms[0].selinsurance.options[j].selected=true
				}
			}
		}
	}
	else
	{
		for(var j=0;j<parent.frames.document.forms[0].selinsurance.length;j++)
		{
			
				parent.frames.document.forms[0].selinsurance.options[j].selected=false
			
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


