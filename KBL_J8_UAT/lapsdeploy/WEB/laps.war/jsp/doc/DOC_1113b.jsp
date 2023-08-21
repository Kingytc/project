<%@ include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DOC_113b</title>
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

<table width="98%" border="0" cellspacing="1" cellpadding="3"
	class="outertable" align="center">

	<tr>
		<td>

		<table width="95%" border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td align="center"><br>
				<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
			</tr>
			<tr>
				<td align="center">Consent letter from the Co-Obligant / s / Guarantor / s.</td>
				</tr>
				<tr>
				<td>&nbsp;</td>
				</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr>
						<td width="70%">From,</td>
						<td width="10%">Place :</td>
						<td width="20%">&nbsp;</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>Date :</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
					<td colspan="3">&nbsp;</td>
					</tr>
				</table>
			</tr>



			<tr>
				<td>To,</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The Senior Branch Manager,</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;THE KARNATAKA BANK LIMITED,</td>
			</tr>
			<tr>
			    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chamarajpet Branch,Bangalore-18.</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Dear Sir,</td>
			</tr>
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