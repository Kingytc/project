<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<laps:handleerror />
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/browserreport1.js"></script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var val = "";
var userid ="<%=session.getAttribute("strUserId")%>";
var repname =window.opener.document.forms[0].repname.value;
var beanid  =window.opener.document.forms[0].hidBeanId.value;
var pagename=window.opener.document.forms[0].hidPage.value;

<% String rep =(String)request.getParameter("repname");%>


</script>
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
-->
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onLoad="load()">
<form name="browsefrm" method="Post">
<table width="300" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertablecolor" bordercolorlight="#8F8369"
	bordercolordark="#FFFFFB">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center">
			<tr>
				<td valign="top" bgcolor="#8F8369"><b><font face="MS Sans Serif"
					size="2" color="#FFFFFF">Choose a Report Profile</font></b></td>
			</tr>
			<tr>
				<td valign="top" height="177"><b></b>
				<div align="center"><b> <select name="listsel" size="10"
					style="width:200">
					<laps:reporttag value='<%=rep%>' />
				</select> </b></div>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable border1">
					<tr>
						<td height="2">
						<table width="3%" border="0" cellspacing="0" cellpadding="5"
							align="center" height="8">
							<tr valign="top">
								<td height="0" width="12%">
								<div align="center"><b> <input type="button" name="run"
									value="Run Report"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold"
									onClick="runrep()"> </b></div>
								</td>
								<td height="0" width="12%">
								<div align="center"><b> <input type="button" name="del"
									value="Delete"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold"
									onClick="deleteProfile()"> </b></div>
								</td>
								<td height="0" width="12%">
								<div align="center"><b> <input type="button" name="show"
									value="Show Profile"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold"
									onClick="showProfile()"> </b></div>
								</td>
								<td height="0" width="12%">
								<div align="center"><b> <input type="button" name="browseclose"
									value="Close"
									style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold"
									onClick="window.close()"> </b></div>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="hidBeanId"> <input type="hidden"
	name="hidSourceUrl"> <input type="hidden" name="hidBeanMethod"> <input
	type="hidden" name="hidAction"> <input type="hidden" name="userid"> <input
	type="hidden" name="repname"> <input type="hidden"
	name="txtprofile_name"> <input type="hidden" name="hidParam" value="">
<input type="hidden" name="hidMethod"></form>
</body>
</html>
