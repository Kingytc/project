<%@ page import="com.sai.laps.helper.*,java.util.*,java.io.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
	String strFileName="", strFileAvailable="", strFileLocation="";
	if(hshValues != null)
	{
		strFileAvailable = Helper.correctNull((String) hshValues.get("NSDLFileDownloaded"));
		strFileName = Helper.correctNull((String) hshValues.get("NSDLFileName"));
		strFileLocation = Helper.correctNull((String) hshValues.get("NSDLFileDownloadedLocation"));
	}
%>
<html>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
function fnCallDownload()
{
	var varFileName = "<%=strFileName%>";
	var varFileAvailable = "<%=strFileAvailable%>";
	var varFileLocation = "<%=strFileLocation%>" + varFileName;
	var appURL = "<%=ApplicationParams.getAppUrl()%>";
	if(varFileAvailable == "Y")
	{
		alert("File is Downloaded successfully in Location"+varFileLocation);
	}
	else if(varFileAvailable == "N")
	{
		alert("File not Found");
	}
	parent.frames.Loadpage();
}
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnCallDownload()" >
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="3" >
<tr>
<td>

</td>
</tr>
</table>
<input type="hidden" name="appno">
<input type="hidden" name="hidId">
<input type="hidden" name="hidDocId" >
</form>
</body>
</html>

