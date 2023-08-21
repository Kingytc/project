<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Security Master</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var status="<%=Helper.correctNull((String)hshValues.get("Status"))%>";

function onloading()
{
	if(status != "")
	{
		alert(status);
	}
}
function createFacilityDetailFile()
{
	if(confirm("Export Facility Details?"))
	{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="createFacilityDetails";
		document.forms[0].action=appURL+"action/com_lapstoirb.jsp";
		document.forms[0].submit();		
	}
}
function createSecurityDetailFile()
{
 	if(confirm("Export Security Details?"))
	{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="createSecurityDetails";
		document.forms[0].action=appURL+"action/com_lapstoirb.jsp";
		document.forms[0].submit();		
	}
}
function createChargeDetailFile()
{
	if(confirm("Export Charge Details?"))
	{
		document.forms[0].hidBeanId.value="LapsToRam";
		document.forms[0].hidBeanGetMethod.value="createChargeDetails";
		document.forms[0].action=appURL+"action/com_lapstoirb.jsp";
		document.forms[0].submit();		
	}
}
function createFinancialdetails()
{
	if(confirm("Export Financial Details?"))
	{
		document.forms[0].hidBeanId.value="financial"
		document.forms[0].hidBeanGetMethod.value="uploadtoRAM";
		document.forms[0].action=appURL+"action/com_lapstoirb.jsp";
		document.forms[0].submit();	
	}
}
function generateexecutivesummary()
{
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="updateFinData";
	document.forms[0].flowtype.value="FI";
	document.forms[0].action=appURL+"action/com_lapstoirb.jsp";
	document.forms[0].submit();
}
function doClose()
{	
 	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
	 	document.forms[0].submit();
	}
}			
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="9" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id"
			value="<%=strBorrowerId%>">
			</td>
			</tr>
			</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application-&gt; Send to IRB
		<span style="display:none"><lapschoice:borrowertype /></span></td>
	</tr>
</table>
<lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="60%" border="0" cellspacing="0" cellpadding="0"  class="outertable border1" align="center">
					<tr>
						<td><br>
						<table width="30%" align="center" border="0" cellspacing="0" cellpadding="6" class="outertable linebor">
							<tr>
								<td align="center" width="30%"><font size="4" color="blue"><b>SEND TO IRB</b></font>
								</td>
							</tr>
							<tr>
								<td align="center" width="30%"><input type="button" name="cmd" value="Facility Details"
									onClick="createFacilityDetailFile()" class="buttonOthers"></td>
							</tr>
							<tr>
								<td align="center" width="30%"><input type="button" name="cmd_sec" value="Security Details"
									onClick="createSecurityDetailFile()" class="buttonOthers"></td>
							</tr>
							<tr>
								<td align="center" width="30%"><input type="button" name="cmd_charge" value="Charge Details"
									onClick="createChargeDetailFile()" class="buttonOthers"></td>
							</tr>
							<tr>
								<td align="center" width="30%"><input type="button" name="cmd_charge" value="Financial Details"
									onClick="createFinancialdetails()" class="buttonOthers"></td>
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
<span style="visibility:hidden">
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> </span>
<input type="hidden" name="flowtype">
<lapschoice:hiddentag  pageid='<%=PageId%>'/>
</form>
</body>
</html>
