<%/* NOT EDITABLE - Global Page Directive, Imports, and URIs */%>
<%@include file="../share/directives.jsp"%>
<%@page import = "com.sai.laps.ejb.attachphoto.*" %>
<%@ page import="javazoom.upload.*"%>

<%
	String todo = "";
	//usrObj.setUserId(Helper.correctNull((String)session.getAttribute("strUserId")));
	//usrObj.setOrganizationId(Helper.correctNull((String)session.getAttribute("strOrgCode")));

	MultipartFormDataRequest mrequest =null;

	String strAttachStatus = "";
	//String strAppno = "";
	if (MultipartFormDataRequest.isMultipartFormData(request))
	{
		mrequest = new MultipartFormDataRequest(request);
		todo = Helper.correctNull((String)mrequest.getParameter("todo"));	
		
		if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
		{		
			AttachPhotoBean attDocBean = new AttachPhotoBean();
			strAttachStatus = attDocBean.attachPhoto(mrequest);
			
		}
	}

%>
<html>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script><link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
	
	var appUrl="<%=ApplicationParams.getAppUrl()%>";
	var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
	var cnt = 0;
	function doAttach() 
	{	
		document.forms[0].action=appUrl+"action/ifrmapplicantphoto.jsp";
		document.forms[0].submit();		

	}
	
	function openDocPage(index) 
	{
	
	}
	
	function callDoLoad() 
	{
	
	}
	
	function doClose() 
	{
			window.close();
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
  <table width="80%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable border1">
    <tr> 
      <td valign="top" height="81"> 
		<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
		<tr>			
			<td width="25%" nowrap height="13"><b>Attach Photo/ Document</b></td>
			<td width="75%" nowrap height="13">&nbsp;</td>	
		</tr>
		<tr>
<%
	if (todo.trim().equalsIgnoreCase("upload"))
	{
%>

		<script>
			window.close();
		
		</script>
		<br>
		<br>
		<td align="center"><font color="green"><b>Attaching................</b></font></td>
		<td width="50%" nowrap height="13"><b>&nbsp;</b></td>
<%
	}
	else
	{
%>
		</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">	
	     <tr>
			<td>
			<table width="100%" border="0" cellspacing="1" cellpadding="4"  align="center" class="outertable">	
			  <tr> 
				<td nowrap align="center"> 
				  <input type="file" name="filePhoto" style="text:readonly">
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
          <td> <lapschoice:combuttonnew btnnames='Attach' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</td>    
          </tr>
        </table>
      </td>
    </tr>
  </table>

  <div align="center"></div>

<%
	}
%>


 <input type="hidden" name="todo" value ="upload" >
 <input type="hidden" name="hidApplicantId"	value="<%=Helper.correctNull(request.getParameter("hidApplicantId")) %>">
 <input type="hidden" name="hidType" value="<%=Helper.correctNull(request.getParameter("hidType"))%>" > 
 <input type="hidden" name="hidApplicantionNo"	value="<%=Helper.correctNull(request.getParameter("ApplicationNo")) %>">
 <input type="hidden" name="hidDocumentCode" value="<%=Helper.correctNull(request.getParameter("document_code"))%>" > 
 <iframe id="result" name="ifrmDocOpen" height="0" width="0" src="<%=ApplicationParams.getAppUrl()%>jsp/share/BLANKblank.jsp"> </iframe> 	

</form>
</body>
</html>
