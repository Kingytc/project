<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var existig_leadnum_inward="<%= Helper.correctNull((String)hshValues.get("existig_leadnum_inward"))%>";
var varLeadStatus="<%= Helper.correctNull((String)hshValues.get("strLeadStatus"))%>";
var varFlag="<%= Helper.correctNull((String)request.getParameter("strFlag"))%>";

function loadValues()
{
	if(varLeadStatus=="N")
	{
		alert("Entered Lead no is not available in LMS. Please enter Available Lead No");
		parent.frames.document.forms[0].txt_leadno.value="";
		if(varFlag=="Y")
		{
			parent.frames.document.forms[0].hidleadflag.value="y";
		}
	}
	else if(varLeadStatus!="" && eval(varLeadStatus)<5)
	{
		alert("Status of the entered lead number is not in  'Document Accepted' status in LMS. Please change and then create LAR.");
		parent.frames.document.forms[0].txt_leadno.value="";
		if(varFlag=="Y")
		{
			parent.frames.document.forms[0].hidleadflag.value="y";
		}
	}
	else if(existig_leadnum_inward!="N")
	{
		alert("The Lead Number already attached with Application Number: "+existig_leadnum_inward+". Please Proceed with another Lead Number");
		parent.frames.document.forms[0].txt_leadno.value="";
		if(varFlag=="Y")
		{
			parent.frames.document.forms[0].hidleadflag.value="y";
		}
	}
	else
	{
		parent.frames.document.forms[0].hidleadflag.value="n";
	}
}
</script>

</head>
<body onLoad="loadValues()">

</body>
</html>