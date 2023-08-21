<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<lapschoice:handleerror />

<%
		String strFile ="";
		String strperapp_id = "";
		String strNewPath= "";
		strFile = (String)hshValues.get("strFile");
		strperapp_id = request.getParameter("txtperapp_id");
		//strNewPath = ApplicationParams.getFtpPath();
		
%>

<script>
function downloadfile()
{
	
	var ftpurl="ftp://<%=ApplicationParams.getIP()%>/";
	location.href=ftpurl+"<%=strFile%>";

}
function callSave()
{	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setphoto.jsp?hidDemoId=<%=strperapp_id%>";
	document.forms[0].submit();	
}

</script>
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; border-style: groove; font-weight: bold}
-->
</style>

<body onload="downloadfile()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
<form name="frm1" method="post">
  <input type="button" value="View Photo" onclick="callSave()">
<input type="hidden" name="hidperapp_id"  value="<%=strperapp_id%>" >
<input type="hidden" name="strNewPath"  value= "<%=strNewPath%>" >
<input type="hidden" name="hidBeanGetMethod" value="getSaveFile">

</form>
</body>