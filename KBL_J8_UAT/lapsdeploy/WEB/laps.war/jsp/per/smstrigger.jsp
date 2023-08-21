<%@ include file="../share/directives.jsp"%>
<%
	String strUserID = Helper.correctNull((String) session
			.getAttribute("strUserId"));
	String strAppid = Helper.correctNull((String) hshValues
			.get("strAppid"));
	ArrayList arryRow = (ArrayList) hshValues.get("arrRow1");
	ArrayList arryCol = new ArrayList();
	ArrayList g1 = new ArrayList();
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMinimumFractionDigits(2);
	nf.setMaximumFractionDigits(2);
	nf.setGroupingUsed(false);
%>
<html>
<head>
<title>MSME</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doClose() {
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doSmstrigger()
{	

	///document.forms[0].action = appURL+"action/smstrigger.jsp";
	document.forms[0].hidBeanMethod.value="updsmsTrigger";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].action = appURL + "controllerservlet";
   // document.forms[0].action=appURL+"action/smstrigger.jsp";	
    document.forms[0].hidSourceUrl.value="/action/smstrigger.jsp";
    
	document.forms[0].submit();
	
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="">
<form method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
		<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable">
					<tr>
						<td valign="top"><br>
						
						<table width="90%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<tr>
								<td valign="top" align="center">
								<table width="60%" border="1" cellspacing="0" cellpadding="0"
									align="center" class="outertable">
									<tr>
										<td align="center">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											align="center" class="outertable">
											<tr class="datagrid" align="center">
												
												<td>
												<input type="button" name="cmdsms" value="SMS TRIGGER"
													onClick="doSmstrigger()" class="buttonStyle" />
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
	</tr>
</table>
</td>
</tr>
</table>
<br>
<tr>
<td>
<table border="1" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="0%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="middle">
				<td align="center"><input type="button" name="cmdclose"
					value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag />
</form>
</body>
</html>