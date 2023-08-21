<%@include file="../share/directives.jsp"%>
<%@page import = "com.sai.laps.ejb.attachphoto.*" %>
<%@ page import="javazoom.upload.*"%>
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<%
	String todo = "", strAppNo = "", strDocId = "", strId = "";
	String strFileAttach = "", strFileName = "";
	HashMap hshResult = new HashMap();
	
	if (!MultipartFormDataRequest.isMultipartFormData(request)) {
		session.setAttribute("strAppNo", Helper.correctNull((String) request.getParameter("appno")));
		session.setAttribute("varAppno", Helper.correctNull((String) request.getParameter("varAppno")));
	}
	String strnbfc = Helper.correctNull((String) request.getParameter("strnbfc"));
	//out.println("strnbfc======="+strnbfc);
	strAppNo = Helper.correctNull((String) session.getAttribute("appno"));
	if(strAppNo.equalsIgnoreCase("")){
		strAppNo = Helper.correctNull((String) session.getAttribute("varAppno"));
	}
	MultipartFormDataRequest multiPartFormDataRequest = null;
	
	if (MultipartFormDataRequest.isMultipartFormData(request)) 
	{
		multiPartFormDataRequest = new MultipartFormDataRequest(request);
		todo = Helper.correctNull((String) multiPartFormDataRequest.getParameter("todo"));
	
		if ((todo != null) && (todo.equalsIgnoreCase("upload"))) 
		{
			AttachPhotoBean attachFile = new AttachPhotoBean();
			hshResult = attachFile.updateExcelDataBulkUpload(multiPartFormDataRequest,
					Helper.correctNull((String) session.getAttribute("strUserId")), 
					Helper.correctNull((String) session.getAttribute("strOrgShortCode")),
					Helper.correctNull((String) session.getAttribute("strSolid")),
					Helper.correctNull((String) session.getAttribute("strOrgCode")),strnbfc);
		}
	}

	if (hshResult != null && hshResult.size() > 0) 
	{
		strFileAttach = Helper.correctNull((String) hshResult.get("strAttach"));
		strFileName = Helper.correctNull((String) hshResult.get("filename"));
		//session.removeAttribute("strUserId");
		//session.removeAttribute("strOrgShortCode");
		//session.removeAttribute("strSolid");
	}
	
%>
<script>
function doButtonAttach()
{	
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/set_bulkupload.jsp";
	document.forms[0].submit();	
}

function onload()
{
	<%if (!todo.equalsIgnoreCase("")) {%>
		alert("File Upload: "+'<%=strFileAttach%>');
		window.close();
		window.opener.doCancel1();
	<%}%>
}

function doButtonClose()
{
	window.close();
}
</script>
</head>

<body onload="onload()">
<form method="post" name="attachfFileForm" enctype="multipart/form-data" class="normal"><br>
<table width="67%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<TD class="sub_tab_active"><b>Attach File</b></td>
	</tr>
	<tr>
		<TD align="center" height="100"><INPUT TYPE="file"  NAME="fileAttach"  STYLE="text: readonly; width: 325px;"></td>
	</tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="3" align="center" class ="outertable">
			<tr valign="top">
				<td><input type="button" name="cmdApply" value="Attach" class="buttonstyle" onClick="doButtonAttach()"></td>
				<td><input type="button" name="cmdClose" value="Close" class="buttonclose" onClick="doButtonClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table>
<tr><td>&nbsp;</td></tr>
</table>
<input type="hidden" name="todo" value="upload"> 
<input type="hidden" name="appno" 	value="<%=strAppNo%>"> 
</form>
</body>
</html>