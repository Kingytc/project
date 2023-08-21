<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Security Description</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
function callOnLoad()
{
	disableButtons(false,true,true,true,false);
	disableFields(true);
}
function doEdit()
{
	disableButtons(true,false,false,false,true);
	disableFields(false);
}
function doSave()
{

	if(document.securitydesc.txtar_security_desc.value=="")
	{
		alert("Enter the description for the security");
		document.securitydesc.txtar_security_desc.focus();
		return;
	}
	else
	{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanMethod.value="updateSecurityDesc";
	document.forms[0].hidBeanGetMethod.value="getSecurityDesc";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/per_depsecuritydesc.jsp";
	document.forms[0].submit();
}
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="getSecurityDesc";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].action=appURL+"action/per_depsecuritydesc.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanMethod.value="updateSecurityDesc";
		document.forms[0].hidBeanGetMethod.value="getSecurityDesc";
		document.forms[0].hidSourceUrl.value="/action/per_depsecuritydesc.jsp";
		document.forms[0].action=appURL+"controllerservlet";
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
function disableButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdedit.disabled=cmdedit;
	document.forms[0].cmdsave.disabled=cmdsave;
	document.forms[0].cmdcancel.disabled=cmdcancel;
	document.forms[0].cmddelete.disabled=cmddelete;
	document.forms[0].cmdclose.disabled=cmdclose;
}
function disableFields(binary)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=binary;
		}
	}
}
</script>

</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<body onload="callOnLoad()">
<form name="securitydesc" method="post" class="normal">
<br>
<table width="95%" border="1" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
				
				<tr class="dataheader">
					<td><b>&nbsp;Security Description</b></td>
				</tr>
				<tr>
					<td align="center"><textarea name="txtar_security_desc" onpaste="return false" cols="145" rows="15" onkeyup="textlimitcorp1(this,300);" onkeydown="textlimitcorp1(this,300);"><%=Helper.correctNull((String)hshValues.get("security_desc"))%></textarea>
				</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_delete_Audit Trial' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />

<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>