<%@page import="com.sai.laps.ejb.DigitalAppInterface.DigitalAppInterfaceBean"%>
<%@include file="../share/directives.jsp"%>
<%@page import="com.sai.laps.context.*"%>
<%@page import="com.sai.fw.management.utils.*"%>
<%@page import="com.sai.laps.helper.*"%>
<%@page import="com.sai.laps.ejb.attachphoto.*"%>
<%@ page import="javazoom.upload.*"%>
<html>
<head>
<title>Upload Attachments</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<%
	String todo = "", strAppNo = "", strDocType = "", strDocCode = "", strUserID = "",strCBSID="",strfacslno="",strCategory="";
	String strFileAttach = "", strFileName = "",strpage="";
	
	HashMap hshResult = new HashMap();
	if (!MultipartFormDataRequest.isMultipartFormData(request)) {
		session.setAttribute("DocType", Helper.correctNull((String) request.getParameter("DocType")));
		session.setAttribute("DocCode", Helper.correctNull((String) request.getParameter("DocCode")));
		session.setAttribute("appNo", Helper.correctNull((String) request.getParameter("appno")));
		
		session.setAttribute("UserID", Helper.correctNull((String) request.getParameter("UserID")));
		session.setAttribute("strCBSID", Helper.correctNull((String) request.getParameter("strCBSID")));
		session.setAttribute("strfacslno", Helper.correctNull((String) request.getParameter("strfacslno")));
		session.setAttribute("strCategory", Helper.correctNull((String) request.getParameter("strCategory")));
		session.setAttribute("strpageName", "MsmeDoc");


	}
	String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType")).trim();

	strDocType = FwHelper.correctNull((String) session.getAttribute("DocType"));
	strDocCode = FwHelper.correctNull((String) session.getAttribute("DocCode"));
	strAppNo = FwHelper.correctNull((String) session.getAttribute("appNo"));
	if(strAppNo.equalsIgnoreCase("")){
		strAppNo=FwHelper.correctNull((String)session.getAttribute("appno"));
	}
	strUserID = FwHelper.correctNull((String) session.getAttribute("UserID"));
	strCBSID = FwHelper.correctNull((String) session.getAttribute("strCBSID"));
	strfacslno = FwHelper.correctNull((String) session.getAttribute("strfacslno"));
	strCategory = FwHelper.correctNull((String) session.getAttribute("strCategory"));
	String strpageName = FwHelper.correctNull((String) session.getAttribute("strpageName"));
	if(strCBSID.equalsIgnoreCase("")){
		strCBSID=FwHelper.correctNull((String)session.getAttribute("DEV_CBSID"));
	}
	
	MultipartFormDataRequest multiPartFormDataRequest = null;
	
	if (MultipartFormDataRequest.isMultipartFormData(request)) {
		multiPartFormDataRequest = new MultipartFormDataRequest(request);
		todo = Helper.correctNull((String) multiPartFormDataRequest.getParameter("todo"));
		if ((todo != null) && (todo.equalsIgnoreCase("upload"))) {
			
			if(strCategory.equalsIgnoreCase("DIGI"))
			{
				HashMap hashMapval = new HashMap();
				hashMapval.put("multiPartFormDataRequest", multiPartFormDataRequest);
				hashMapval.put("strDocType",strDocType);
				hashMapval.put("strDocCode",strDocCode);
				hashMapval.put("strAppNo",strAppNo);
				hashMapval.put("strUserID",strUserID);
				hashMapval.put("strCBSID",strCBSID);
				hashMapval.put("strUserID",strUserID);
				DigitalAppInterfaceBean digitalAppInterfaceBean = new DigitalAppInterfaceBean();
				digitalAppInterfaceBean.pushDocumentService(hashMapval); 
			}
			else
			{
					if(strpageName.equalsIgnoreCase("MsmeDoc")){
					AttachPhotoBean attachFile = new AttachPhotoBean();
					hshResult = attachFile.uploadAttachment(multiPartFormDataRequest,strDocType,strDocCode,strAppNo,strUserID,strCBSID,strfacslno,strpageName);	
				}else{
					AttachPhotoBean attachFile = new AttachPhotoBean();
					hshResult = attachFile.uploadAttachment(multiPartFormDataRequest,strDocType,strDocCode,strAppNo,strUserID,strCBSID,strfacslno,strCategory);	
					
				}
			}
		}
	}

	if (hshResult != null && hshResult.size() > 0) {
		strFileAttach = FwHelper.correctNull((String) hshResult.get("strAttach"));
		strFileName = FwHelper.correctNull((String) hshResult.get("filename"));
		strpage = FwHelper.correctNull((String) hshResult.get("strpageName"));

		session.removeAttribute("DocType");
		session.removeAttribute("DocCode");
		session.removeAttribute("appNo");
		session.removeAttribute("UserID");	
		session.removeAttribute("strCBSID");	
		session.removeAttribute("strfacslno");	
		session.removeAttribute("strCategory");	
		session.removeAttribute("strpageName");
	}
%>
<script>
function doButtonAttach()
{	
	if(document.forms[0].fileAttach.value!="")
	{
		var value=document.forms[0].fileAttach.value;
		if(value.indexOf(".exe")==-1 && value.indexOf(".csv")==-1 && value.indexOf(".xls")==-1 && value.indexOf(".xlsx")==-1)
		{
			
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perDocumentAttach.jsp";
			document.forms[0].submit();	
		}
		else
		{
			alert("Invalid File Format");
			return;
		}
	}
	else
	{
		alert("Select document to Upload");
		return;
	}
}

function onload()
{
	
	
	
	<%if (!todo.equalsIgnoreCase("")) {%>
	alert("File Upload: "+'<%=strFileAttach%>');
	window.close();

	<%
	if(strFileAttach.equalsIgnoreCase("Success"))
	{
	if(strpage.equalsIgnoreCase("MsmeDoc")){%>
	window.opener.getmsmedocupload();
	<%}}%>
	
	window.opener.callListUpload();	
	<%}%>
}

function doButtonClose()
{
	window.close();
}
</script>
</head>
<body onload="onload()">
<form method="post" name="attachfFileForm" enctype="multipart/form-data" class="normal"><BR>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr class="dataheaderbase">
		<td style="text-align: center;" onmouseover="this.style.color='#0802f5';" onmouseout="this.style.color='#000000';" 
		style="cursor: pointer;">Upload Attachments</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td align="center"> <INPUT TYPE="file" NAME="fileAttach" id="fileAttach" STYLE="text: readonly; width: 500px;"> </td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	    <td align="center">
	        <img src="<%=ApplicationParams.getAppUrl()%>img/attached.jpg" width="30"
			height="25" style="display: inline-block; cursor: pointer;" onclick="doButtonAttach()"
			title="Upload Attachment"/>&nbsp;&nbsp;&nbsp;&nbsp;
	        <img src="<%=ApplicationParams.getAppUrl()%>img/Close.gif" width="25"
			height="20" style="display: inline-block; cursor: pointer;"
			title="Cancel Attachment" onclick="doButtonClose()" />
	    </td>
	</tr>	
	<tr><td>&nbsp;</td></tr>
</table>
<input type="hidden" name="todo" value="upload"> 
<input	type="hidden" name="DocType"> 
<input type="hidden" name="DocCode">
<input type="hidden" name="UserID">
<input type="hidden" name="appno" 	value="<%=strAppNo%>"> 
<input type="hidden" name="hidBeanId" value="commdocument">
<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidAction">
</form>
</body>
</html>