<%@ include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DOC 959J</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}

#top {
	background-color: #ffffff;
}

#top table {
	border-collapse: collapse;
}

#top td {
	border: 0.5pt solid #000000;
	FONT-SIZE: 16px;
	COLOR: #000000;
	LINE-HEIGHT: 16px;
	FONT-FAMILY: "Book Antiqua"
}

.title {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
	font-weight: bold !important;
}
</style>
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
</head>
<body onselectstart="return false" ondragstart="return false">

<table width="98%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">

	<tr>
		<td>

		<table width="95%" border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="center">
			
			<tr>
				<td align="justify" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String) hshValues
									.get("doc_template"))%></td>
			</tr>
			
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
</table>

</body>
</html>