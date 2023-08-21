<%@include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<HTML>
<HEAD>
<TITLE> View Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
	
	<script>
	//added by s.sathya moorthy
	var message="<%=Helper.correctNull((String)hshValues.get("Message"))%>";
	if(message!="")
	alert(message);
	function doClose()
	{
		window.close();
	}
	</script>
	
</HEAD>
<BODY onblur="self.focus()">

<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
  <tr> 
    <td>
      <table  border="0" cellpadding="3" cellspacing="0" width="100%" align="center" class="outertable linebor">
        <tr> 
          <td> 
            <b>Application No:</b><%=Helper.correctNull(request.getParameter("appno"))%></td>
          <td><b>Applicant Name:</b><%=Helper.correctNull(request.getParameter("comapp_companyname"))%>	
            </td>
          <td><b>Document Description:</b><%=Helper.correctNull(request.getParameter("document_description"))%>
         </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td><table cellpadding="1" cellspacing="1" width="98%" align="center" border="0" class="outertable">
        <tr> 
          <td align="center">          
          <iframe align="center" src="<%=ApplicationParams.getAppUrl()%>action/appdocumentscanimage.jsp?hidBeanId=commdocument&hidBeanGetMethod=viewDocumentScanningImage&ApplicationNo=<%=Helper.correctNull((String)request.getParameter("appno"))%>&document_code=<%=Helper.correctNull(request.getParameter("document_code"))%>"
			id="idfrm1" width="850" height="600" scrolling="yes" frameborder=no></iframe>							
		</td>
        </tr>
      </table></td>
  </tr>
</table>
<%

%>
<table width="0%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
  <tr>
      <td> 
          <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
      </td>
    </tr>
  </table>
  
</BODY>
</HTML>
