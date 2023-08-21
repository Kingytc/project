<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%

   String strInterestFac=Helper.correctDouble(Helper.correctNull((String)hshValues.get("strInterest")));
   String strInterestID=Helper.correctDouble(Helper.correctNull((String)hshValues.get("strInterestIndexId")));
   String strInterestBaseRate=Helper.correctDouble(Helper.correctNull((String)hshValues.get("strInterestBaseRate")));
   String strSubFlag=Helper.correctNull((String)hshValues.get("strSubFlag"));


%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

var strInterestFac="<%=strInterestFac%>";
var varSubFlag="<%=strSubFlag%>";
var strInterestID="<%=strInterestID%>";
var strInterestBaseRate="<%=strInterestBaseRate%>";

function loadValues()
{
	

	if(strInterestFac!="" && strInterestFac!="0.00")
	{

		if(varSubFlag=="N")
		{
		parent.frames.document.facility.prd_intrate.value=strInterestFac;
		parent.frames.document.facility.hidIntIdFac.value=strInterestID;
		parent.frames.document.facility.hidBaseRateFac.value=strInterestBaseRate;
		
		}
		else if(varSubFlag=="Y")
		{
			parent.frames.document.facility.prd_subintrate.value=strInterestFac;
			parent.frames.document.facility.hidIntIdFacSub.value=strInterestID;
			parent.frames.document.facility.hidBaseRateFacSub.value=strInterestBaseRate;
		}
		
		

	}	
	else
	{
		if(varSubFlag=="N")
		{
		alert("Interest not defined in the setup for this range");
		parent.frames.document.facility.prd_intrate.value="";
		parent.frames.document.facility.prd_intrate.focus();
		return;
		}
		else if(varSubFlag=="Y")
		{
			alert("Interest not defined in the setup for this range");
			parent.frames.document.facility.prd_subintrate.value="";
			parent.frames.document.facility.prd_subintrate.focus();
			return;

		}
				

	}   
	

}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
