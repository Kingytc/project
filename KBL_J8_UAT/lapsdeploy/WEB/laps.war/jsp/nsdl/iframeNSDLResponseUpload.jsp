<%@include file="../share/directives.jsp"%>
<%@ page import="javazoom.upload.*"%>
<%
	String todo = "";
	MultipartFormDataRequest mrequest =null;
	String strUploadStatus = "";

	if (MultipartFormDataRequest.isMultipartFormData(request))
	{
		mrequest = new MultipartFormDataRequest(request);
		todo = Helper.correctNull((String)mrequest.getParameter("todo"));	
		
		if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
		{		
			NsdlApplicationBean nsdlBean = new NsdlApplicationBean();
			strUploadStatus = nsdlBean.uploadNSDLResponse(mrequest);
			
		}
	}
	
%>

<%@page import="com.sai.laps.ejb.nsdlapplication.NsdlApplicationBean"%><html>
<script>
	
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
	var varFileUploadedStatus = "<%=strUploadStatus%>"; 
	
	var cnt = 0;
	function doAttach() 
	{	
		document.forms[0].action=appUrl+"action/iframeNSDLResponseUpload.jsp";
		document.forms[0].submit();		

	}
	
	function doClose() 
	{
			window.close();
	}

	function callDoLoad()
	{
		if(varFileUploadedStatus != "")
		{
			alert(varFileUploadedStatus);
			doClose();
		}
	}
</script>
<style type="text/css">

DIV.cellContainer {
  width: 100%; height: 225;
  overflow: auto;
}
</style>

<body onload="callDoLoad()" />
<form method="post" name="upform" enctype="multipart/form-data" class="normal">
  <br>
  <table width="95%" border="0" cellspacing="1" cellpadding="3"
	align="center" class="shadow" >
    <tr> 
      <td valign="top" height="81"> 
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">			
			<td width="25%" nowrap height="13"><b>Upload NSDL Response File</b></td>
		</tr>

		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">	
	     <tr>
			<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="4"  align="center" class="outertable">	
			  <tr class="datagrid"> 
				<td nowrap align="center"> 
				  <input type="file" name="fileNsdl" style="text:readonly">
				</td>								
			  </tr>

			</table>	
				</table>
	   		  </td>
			</tr>
			<tr>
			<td>

		 </td>	
		 </tr>
		</table>
  <br>

  <table border="0" cellspacing="0"
  cellpadding="0" align="center"  class="outerTable">
    <tr> 
      <td> 
        <table border="0" cellspacing="0" cellpadding="3" align="center">
          <tr valign="top"> 
          <td> 
          <input type="button" value="Attach" name="cmdAttach" onclick="doAttach()" class="buttonStyle">
				</td>    
          </tr>
        </table>
      </td>
    </tr>
  </table>

<div align="center"></div>

<input type="hidden" name="todo" value ="upload" >
<input type="hidden" name="hidApplicantId"	value="<%=Helper.correctNull(request.getParameter("hidApplicantId")) %>">
<input type="hidden" name="hidType" value="<%=Helper.correctNull(request.getParameter("hidType"))%>" > 
</form>
</body>
</html>