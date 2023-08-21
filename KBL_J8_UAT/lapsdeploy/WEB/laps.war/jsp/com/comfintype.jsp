<%@include file="../share/directives.jsp"%>
<%
	String strcat = "";
	if (!strCategoryType.equalsIgnoreCase(null)) {
		if (strCategoryType.equalsIgnoreCase("OPS")) {
			strcat = "Tertiary";
		} else {
			strcat = "Corporate";
		}

	}
	
%>

<html>
<head>
<title>Financial Type</title>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var varfintype="<%=Helper.correctNull((String) hshValues.get("finmodel"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordFlag"))%>";
function onLoad()
{
	if(varfintype!="")
	{
		document.forms[0].selfintype.value=varfintype;
	}
	else
	{
		document.forms[0].selfintype.value="S";
	}
	disablefields(true);
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}

function DisableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdApply;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function doEdit()
{	
	document.forms[0].hidAction.value="edit";
	disablefields(false);
	DisableControls(true,false,true,false,true);
}

function doSave()
{
	if(document.forms[0].selfintype.value=="S")
	{
		ShowAlert('121','Financial Type');
		document.forms[0].selfintype.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanGetMethod.value="getFinancialtype";
	document.forms[0].hidBeanMethod.value="updateFinancialtype";
	document.forms[0].hidSourceUrl.value="action/comfintype.jsp";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].submit();		
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFinancialtype";
		document.forms[0].hidSourceUrl.value="action/comfintype.jsp";
		//document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].submit();		
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="onLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmfintype" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
	    <%if (strCategoryType.equalsIgnoreCase("CORP")){%>
			<td class="page_flow">Home -&gt;Agriculture -&gt;Application-&gt; Financial Type</td>
		<%}else{ %>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Financial Type</td>
		<%} %>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td valign="top">

		<table width="100%" border="0" cellspacing="2" cellpadding="3"
			class="outertable">
			<tr>&nbsp;</tr>
			<tr>
				<td align="right" width="44%">Financial Type</td>
				<td><select name="selfintype">
					<option value="S">&lt;---Select---&gt;</option>
					<lapschoice:finmaster />
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br />
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="val" value="cma">
</form>
</body>
</html>
