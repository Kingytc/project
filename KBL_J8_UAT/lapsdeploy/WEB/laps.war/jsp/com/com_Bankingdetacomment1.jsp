<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor")); %>
<html>
<head>
<title>Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script> 

var appUrl = "<%=Helper.correctNull((String)request.getParameter("appURL"))%>";
var strAppno = "<%=Helper.correctNull((String)request.getParameter("appno"))%>";
var appstatus = "<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var pagetype="<%=Helper.correctNull((String)request.getParameter("pagetype"))%>"
var pagettype1="";

function placevalues()
{	
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].hidNonPoolFlag.value=="Y")
		{
			EnableButtons(true,true,true,true,false);
		}
		else
		{
			EnableButtons(false,true,true,true,false);
		}
	}
	else
	{
		EnableButtons(true,true,true,true,false);
	}
	disableFields(true);
	
	EditorEnableDisable("id_div","block","id_editor","none");
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function doEdit()
{
	//disableFields(false);
	
	EnableButtons(true,false,false,false,true)

	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('exec_summ_company');
}

function EnableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getcom_Bankingdetacommentdata";
		document.forms[0].action=appUrl+"action/com_Bankingdetacomment1.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		window.close();
	}
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updatecom_Rbicommentsdata";
	document.forms[0].hidBeanGetMethod.value="getcom_Bankingdetacommentdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_Bankingdetacomment1.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updatecom_Rbicommentsdata";
		document.forms[0].hidBeanGetMethod.value="getcom_Bankingdetacommentdata";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_Bankingdetacomment1.jsp";
		document.forms[0].submit();
	 }
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 200;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
</head>

<body onload="placevalues()">

<form method="post" class="normal">

<table width="99%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	
	
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt;Banking Arrangement -&gt; Banking Details -&gt; Comments </td>
	</tr>
</table>
<br>
<table width="99%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td width="99%"class="dataheader">Comments</td>
		</tr>
		</table>
		

<table width="99%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td >
			<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
			  <tr>	
				   <td width="75%" >  <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS"))%></div></div>
                                    <div id="id_editor">      <textarea name="exec_summ_company" cols="60" rows="7" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS"))%></textarea></div>
                                        
    
			</tr>
		</table>
	</td>
	</tr>
	</table>

<br>


<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidpagetype" value="<%=Helper.correctNull((String)request.getParameter("hidpagetype"))%>">
<input type="hidden" name="appno" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
<input type="hidden" name="appstatus" value="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>">



<br>
</form>
</body>
</html>
 