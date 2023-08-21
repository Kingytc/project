<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Comments</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
function callOnLoad()
{
	EditorEnableDisable("id_div","block","id_editor","none");
	if(appstatus=="Open/Pending")
	{
	if(btnenable.toUpperCase()=="Y")
	{
		disableButtons(false,true,true,true,false);
	}
	else
	{
		disableButtons(true,true,true,true,false);
	}
	}
	else
	{
		disableButtons(true,true,true,true,false);
	}
	
	disableFields(true);
	
}
function doEdit()
{
	disableButtons(true,false,false,false,true);
	disableFields(false);
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_bankingcomments.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action=appURL+"action/com_bankingcomments.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].hidSourceUrl.value="/action/com_bankingcomments.jsp";
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
<body onLoad="callOnLoad();">
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
<form name="comments" method="post" class="normal">
&nbsp;<i><b>
<%
	String strCommentPage=Helper.correctNull((String)request.getParameter("hidPage1"));
	if(strCommentPage.equalsIgnoreCase(""))
		strCommentPage = Helper.correctNull((String) hshValues.get("hidPage"));
	if(strCommentPage.equalsIgnoreCase("ourbankcomments"))
	{%>
		Comments on Our Bank Facilities
	<%}
	else if(strCommentPage.equalsIgnoreCase("otherbankcomments"))
	{%>
		Comments on Other bank Facilities
	<%}
	else if(strCommentPage.equalsIgnoreCase("extrating"))
	{%>
		Comments on External Rating
	<%}
%>
</b></i>
<br>
<table width="98%" border="0" cellpadding="3" cellspacing="3" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
				<tr class="dataheader">
					<td>Enter Comments</td>
				</tr>
				<tr>
					<td >
					 <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div></div>
					 <div id="id_editor"><textarea name="txt_comments" cols="117"rows="8" onKeyPress="textlimit(this,3999)"  onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS"))%></textarea></div></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidPage" value="<%=strCommentPage%>">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>">
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="btnenable" value="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>">
<input type="hidden" name="appstatus" value="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>">
</form>
</body>
<!-- <script language="JavaScript1.2">
var config = new Object(); // create new config object

config.width = "90%";
config.height = "50";
config.bodyStyle = 'background-color: white; font-family: "Verdana"; font-size: x-small;';
config.debug = 0;
	
	editor_generate('txt_comments',config);
	//setTimeout(function() { editor_modeUpdate("txtarea_comments","disable") }, 100);
</script>-->
</html>