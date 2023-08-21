<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Main & Sub Activity</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var isnew="false";
var activeflag ="<%=Helper.correctNull((String)hshValues.get("mis_show"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function disablecommandbuttons(cmbnew,cmbedit,cmbsave,cmbcancel,cmbdelete,cmbclose)
{
	document.forms[0].cmdnew.disabled = cmbnew;
	document.forms[0].cmdedit.disabled = cmbedit;
	document.forms[0].cmdsave.disabled = cmbsave;
	document.forms[0].cmdcancel.disabled = cmbcancel;
	//document.forms[0].cmddelete.disabled = cmbdelete;
	document.forms[0].cmdclose.disabled = cmbclose;
}
function disableControls(bflag)
{ 
	document.forms[0].txt_SubActDesc.readOnly = bflag;
	document.forms[0].txt_SubActCode.readOnly = bflag;
	document.forms[0].txt_MainActivity.readOnly = true;
	document.forms[0].sel_Visibility.disabled = bflag;
}
function onloading()
{
	if(checktrim(document.forms[0].hidMainActivityDesc.value)=="")
	{
		disablecommandbuttons(false,false,true,true,true,false);
		disableControls(true);
	}
	else
	{
		disablecommandbuttons(false,false,true,true,true,false);
		disableControls(true);
	}
	if(activeflag != "")
	{
	 	document.forms[0].sel_Visibility.value=activeflag;
	}
	else
	{
		document.forms[0].sel_Visibility.value="E";
	}
	if((checktrim(document.forms[0].newmode.value)=="N") && (checktrim(document.forms[0].hidMainActivityDesc.value)==""))
	{
		disablecommandbuttons(false,false,true,true,true,false);
		disableControls(true);
	}
	else if((checktrim(document.forms[0].newmode.value)=="N") && (checktrim(document.forms[0].hidMainActivityDesc.value)!=""))
	{
		disablecommandbuttons(false,false,true,true,false,false);
		disableControls(true);
	}
}
function doNew()
{		
	isnew="true";
	disableControls(false);
	disablecommandbuttons(true,true,false,false,true,true);
	document.forms[0].txt_SubActDesc.focus();
	document.forms[0].txt_SubActDesc.value = "";
	document.forms[0].txt_SubActCode.value = "";
	document.forms[0].txt_MainActivity.value = "";
	document.forms[0].txt_MainActivityCode.value="";
	document.forms[0].hidMainActivityDesc.value = "";
}
function doEdit()
{	
	if(document.forms[0].txt_SubActDesc.value=="")
	{
		ShowAlert('111','Sub Activity Description');
		document.forms[0].txt_SubActDesc.focus();
		return false;
	}
	else
	{
		isnew="false";
		disableControls(false);
		disablecommandbuttons(true,true,false,false,true,true);
		document.forms[0].txt_SubActDesc.focus();
	}
}
function doSave()
{
	if(checktrim(document.forms[0].txt_SubActDesc.value)=="")
	{		
		ShowAlert('121','Sub Activity Description');
		document.forms[0].txt_SubActDesc.focus();
		return false;
	}
	if(checktrim(document.forms[0].txt_SubActCode.value)=="")
	{		
		ShowAlert('121','Sub Activity Code');
		document.forms[0].txt_SubActCode.focus();
		return false;
	}
	if(checktrim(document.forms[0].txt_MainActivity.value)=="")
	{		
		ShowAlert('111','Main Activity');
		document.forms[0].txt_MainActivity.focus();
		return false;
	}	
	if(isnew=="true")
	{
		document.forms[0].hidAction.value="insert";
	}
	else
	{
		document.forms[0].hidAction.value="update";
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].newmode.value ="Y";		
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidBeanMethod.value="updateMISMainSubActivity";
	document.forms[0].hidBeanGetMethod.value="getMISMainSubActivity";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/set_mismainsubactivity.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].action=appURL+"controllerservlet";			
			document.forms[0].hidBeanId.value="mis";
			document.forms[0].hidBeanMethod.value="updateMISMainSubActivity";
			document.forms[0].hidBeanGetMethod.value="getMISMainSubActivity";
			document.forms[0].hidSourceUrl.value="/action/set_mismainsubactivity.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].newmode.value ="N";
		document.forms[0].hidAction.value = "";
		document.forms[0].action=appURL+"action/set_mismainsubactivity.jsp";
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].hidBeanGetMethod.value="getMISMainSubActivity";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function callDescHelp(page)
{	
	if(page=="subactdesc")
	{
		if(isnew!="true")
		{
			var varQryString = appURL+"action/setmissubdeschelp.jsp?page="+page;
			var title = "MISSubActivityHelp";
			var prop = "scrollbars=no,width=500,height=360";	
			prop = prop + ",left=200,top=160";
			window.open(varQryString,title,prop);	
		}
	}
	else
	{
		if(document.forms[0].cmdedit.disabled)
		{
			var varQryString = appURL+"action/setmismainactivityhelp.jsp?id=2&pagename="+page+"&hidBeanId=mis&hidBeanGetMethod=getMainActivitySearch";
			var title = "CBS_DATAS_HELP";
			var prop = "scrollbars=no,width=650,height=400";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);		
		}
		else
		{
			alert("Press Edit button to activate the Main Activity Help");
		}
	}
}
</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home-&gt; Setup -&gt; MIS Setup -&gt; Main & Sub Activity</td>
</tr>
</table>
<br>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
<tr>
	<td>
		<table width="60%" border="0" cellspacing="0" cellpadding="2" class="outertable border1 tableBg" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable">
				<tr> 
					<td>Main Activity</td>
					<td> 
						<input type="text" name="txt_MainActivity" size="75" maxlength="100"
							value="<%=Helper.correctNull((String)hshValues.get("mainactdesc"))%>">
						<input type="hidden" name="txt_MainActivityCode"
							value="<%=Helper.correctNull((String)hshValues.get("mis_mainact"))%>">
						<b>
							<span onClick="callDescHelp('mainactdesc')" style="cursor:hand">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
							</span>
						</b>
					</td>
				</tr>
				<tr> 
					<td>Sub Activity Description</td>
					<td>
						<input type="text" name="txt_SubActDesc" size="75" maxlength="300"
							value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("mis_subactdesc"))%>">
						<b>
							<span onClick="callDescHelp('subactdesc')" style="cursor:hand">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
							</span>
						</b>
					</td>
				</tr>
				<tr> 
					<td>Sub Activity Code</td>
					<td> 
						<input type="text" name="txt_SubActCode" size="18" maxlength="6"
							value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("mis_subactcode"))%>">
					</td>
				</tr>
				<tr> 
					<td>Visibility<span class="mantatory">*</span></td>
					<td>
						<select name="sel_Visibility">
							<option value="E" selected="selected">Enable</option>
							<option value="D">Disable</option>
						</select>
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
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 	
<input type="hidden" name="hidMainActivityDesc" value="<%=Helper.correctDoubleQuotesHtml((String)hshValues.get("hidMainActivityDesc"))%>">
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>"> 
<input type="hidden" name="hidmaxterm" value="<%=request.getParameter("hidmaxterm") %>"> 
<input type="hidden" name="selsno" value=""> 
<input type="hidden" name="newmode" value="<%=request.getParameter("newmode")%>"> 
<input type="hidden" name="hidPageName" value="set_mismainsubactivity.jsp">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
