<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>COP/MOF Comments</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";

function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;	
}
function placevalues()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			  document.forms[0].elements[i].readOnly=true;
		}
	}

	if(appstatus=="Open/Pending")
	{
	if(btnenable.toUpperCase()=="Y")
	{
		enableButtons(false,true,true,false);
	}
	else
	{
		enableButtons(true,true,true,false);
	}
	}
	else
	{
		enableButtons(true,true,true,false);
	}

	EditorEnableDisable("id_div","block","id_editor","none");
	
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanGetMethod.value="getCopMofComments";
	document.forms[0].action=appURL+"action/com_realsemargincomment.jsp";
	document.forms[0].submit();
	}
}
function doClose()
{
	window.close();
}
function doEdit()
{
		
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			  
			}
			
		}
	enableButtons(true,false,false,true);
	document.forms[0].cmddelete.disabled=false;	

	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_copmof');
	
}
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanMethod.value="updateCopMofComments";
	document.forms[0].hidBeanGetMethod.value="getCopMofComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_realsemargincomment.jsp"
	document.forms[0].submit();

}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanGetMethod.value="updateCopMofComments";
	document.forms[0].hidSourceUrl.value="/action/com_realsemargincomment.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onload="placevalues()">
<%
	String strType = Helper.correctNull((String) hshValues.get("type"));
	
%>
<form name="frmpri" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top" width="60%">
								<div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("txt_copmof")) %></div></div>
		 	<div id="id_editor">
								<textarea name="txt_copmof"
									cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
									<%=Helper.correctNull((String) hshValues
							.get("txt_copmof"))%></textarea>
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
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable">
	<tr>
		<td colspan="3"><lapschoice:combuttonnew
			btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="flowtype" /> 
<input type="hidden" name="yearfrom" value="1">
<input type="hidden" name="PageType" value="release">
<input type="hidden" name="facilitysno" value="<%=Helper.correctNull((String)request.getParameter("facilitysno"))%>">
<input type="hidden" name="hidSno" value="1">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("hidAppNo"))%>">

</form>
</body>
</html>
