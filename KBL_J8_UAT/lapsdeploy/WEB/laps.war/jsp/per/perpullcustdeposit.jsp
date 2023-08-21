<%@include file="../share/directives.jsp"%>
<%
String strloadFlag=Helper.correctNull((String)hshValues.get("strLoadFlag"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Other Deposit Details</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script>
var varstrloadFlag="<%=strloadFlag%>";
function onLoad()
{
	document.forms[0].cmdsave.disabled=false;
	if(varstrloadFlag=="Y")
	{
		window.opener.loadParent();
		window.close();
	}
}
function callExisting()
{
	document.all.pullsearch.src=appURL+"action/perpullotherdeposit_search.jsp?hidBeanGetMethod=getOtherDepDetails&hidBeanId=perpropertydetails&txtsearch="+document.forms[0].txtsearch.value+"&strBankType="+document.forms[0].strBankType.value;
}
function doSave()
{
	if(ConfirmMsg('178'))
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value ="pulling";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
		document.forms[0].action=appURL+"action/perpullcustdeposit.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{	
	if(ConfirmMsg('100'))
	{
		window.close();
	}
}
</script>
</head>
<body onload="onLoad();callExisting();">
<form name="perpullothdep" method="post" class="normal">
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
<tr>
	<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
				<tr>
					<td>
						<table width="96.5%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="left">
						<tr><td>&nbsp;</td></tr>
						<tr class="dataheader">
							<td width="15%" colspan="2" align="center">Customer Name</td>
							<td width="15%"  align="center">CBS Customer ID</td>
							<td width="20%"  align="center">Account No</td>
							<td width="15%"  align="center">Present Value</td>
							<td width="15%"  align="center">Maturity Date</td>
							<td width="20%"  align="center">Rate Of Interest(%)</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr class="datagrid">
					<td>
						<div align="left">
						<iframe id="pullsearch" width="100%" height="200"
							src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp">
						</iframe>
						</div>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapschoice:combuttonnew btnnames='Save' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_rowcount" value="">
<input type="hidden" name="selaccno" value="">
<input type="hidden" name="txtsearch" value="<%=Helper.correctNull((String) request.getParameter("txtsearch"))%>">
<input type="hidden" name="strBankType" value="1">
<input type="hidden" name="hidAlert" value="<%=Helper.correctNull((String)hshValues.get("strAlert"))%>">
</form>
</body>
</html>