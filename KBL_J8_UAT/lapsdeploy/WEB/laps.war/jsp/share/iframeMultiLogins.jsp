<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<html>
<head>
<title>Untitled Document</title><SCRIPT TYPE="text/javascript"> function clickIE() {if (document.all) {return false;}} function clickNS(e) {if (document.layers||(document.getElementById&&!document.all)) { if (e.which==2||e.which==3) {return false;}}} if (document.layers) {document.captureEvents(Event.MOUSEDOWN);document.onmousedown=clickNS;} else{document.onmouseup=clickNS;document.oncontextmenu=clickIE;} document.oncontextmenu=new Function("return false")</SCRIPT> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function callonLoad(){
	window.close();
}
	
</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="callonLoad();">
<form name="frm" method="post">
<table border="0"  cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
	<tr>
		<td width="100%">
			Your Current Session is going to Close 
		</td>
	</tr>
</table>

</form>
</body>
</html>