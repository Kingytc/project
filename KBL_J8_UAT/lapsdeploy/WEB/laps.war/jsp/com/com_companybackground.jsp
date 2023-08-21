<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<%
 String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
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


<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script> 
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function Onloading()
{
	disablefields(true);
	EditorEnableDisable("id_div","block","id_editor","none");
}
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
}

function enablebuttons(editbool,applybool,canbool,delbool,closebool)
{
	document.forms[0].cmdedit.disabled=editbool;
	document.forms[0].cmdsave.disabled=applybool;
	document.forms[0].cmdcancel.disabled=canbool;
	document.forms[0].cmddelete.disabled=delbool;
	document.forms[0].cmdclose.disabled=closebool;
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	disablefields(false);
	enablebuttons(true,false,false,false,true);
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('company_background');
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="compro"
	document.forms[0].hidBeanMethod.value="updateCompanyBackground";
	document.forms[0].hidBeanGetMethod.value="getCompanyBackground";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_companybackground.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getCompanyBackground";
		document.forms[0].action=appURL+"action/com_companybackground.jsp";
		document.forms[0].submit();
	 }
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateCompanyBackground";
		document.forms[0].hidBeanGetMethod.value="getCompanyBackground";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_companybackground.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{ 
	if (document.forms[0].hideditflag.value=="N")
	{
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appUrl+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}

</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
</head>
<body onload="Onloading()">
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
<form name="frmevaluation" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">
		<%
			if (strSessionModuleType.equalsIgnoreCase("AGR")) {
		%> Home -&gt;
		Agriculture -&gt; Application-&gt; Promoters-&gt; Promoter
		Company / Group Companies Background <%}else{%>
		Home -&gt;
		Corporate &amp; SME -&gt; Application-&gt; Promoters-&gt; Promoter
		Company / Group Companies Background
		<%} %>
		</td>
	</tr>
</table>
<span style="display: none"> <lapschoice:borrowertype /></span><lapschoice:application />
<%
	if (!strCategoryType.equalsIgnoreCase("ADC")) {
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				
				<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('compromoters.jsp','compro','getProData')">Promoters
				/ Directors</a></b></b></td>
				<%
					if (strCategoryType.equalsIgnoreCase("CORP")
								|| strCategoryType.equalsIgnoreCase("SME")) {
				%>
				<td class="sub_tab_active" id="prin"><b>Promoter Company / Group Companies Background</b></td>
				<%
					}
				%>
				<td class="sub_tab_inactive" id="prin" nowrap="nowrap"><b><b><a
					href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Group
				Concerns</a></b></b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_shareholdpattern.jsp','executive','getDataShareHoldPattern')">Share Holding Pattern</a></b></b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_promocomments.jsp','compro','getgroupcomments')">Comments</a></b></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%}%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
								</table>
								</td>
							</tr>
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
									<tr>
										<td valign="top">
										<table width="90%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td class="dataheader"><b>Promoter Company / Group
												Companies Background</b></td>
											</tr>
											<tr>
												<td> 
												<div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comback_comment")) %></div></div>
					 							<div id="id_editor">
												<textarea name="company_background" cols="65" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
													.get("comback_comment"))%></textarea>
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
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
</form>
</body>
<!--<script language="JAVASCRIPT1.2">	editor_generate('company_background');-->
</script>
</html>


