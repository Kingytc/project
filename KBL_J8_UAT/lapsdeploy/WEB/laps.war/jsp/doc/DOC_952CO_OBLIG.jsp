<%@ include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DOC 952 CO-OBLIGANT</title>

<script type='text/javascript'>
var docOpenType="<%=Helper.correctNull((String)request.getParameter("docOpenType"))%>";
  document.onkeydown = function (e) {
	  if(docOpenType=="view")
	  {
		alert("Current Operation is not allowed");
		window.event.returnValue = false;
			  }	
	  else
	  {
		  var pressedKey=String.fromCharCode(event.keyCode).toLowerCase();
		  var key=window.event.keyCode;
		  if(key!=18)
		  {
			alert("Current Operation is not allowed");
		    window.event.returnValue=false;
		  }
	  }		
  }
</script>
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}
</style>
</head>
<body onselectstart="return false" ondragstart="return false">
<form>
<table width="95%" border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="center">
			
			<tr>
				<td align="justify" valign="top"><center>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String) hshValues.get("doc_template"))%></center></td>
			</tr>			
			<tr>	
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
</table>
</form>		
</body>
</html>