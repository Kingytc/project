<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
	
	String StrSchemeType = request.getParameter("strschemeType");
%>
<html>
<head>
<title>Assessment of Restructuring</title>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var appno="<%=request.getParameter("appno")%>";
function onLoad()
{
	EditorEnableDisable("id_div","block","id_editor","none");
	EditorEnableDisable("id_div1","block","id_editor1","none");
	EditorEnableDisable("id_div2","block","id_editor2","none");
	EditorEnableDisable("id_div3","block","id_editor3","none");
	EditorEnableDisable("id_div4","block","id_editor4","none");
	disableFields(true);
}
function disableCmdButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
}
function doEdit()
{
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_project_details');
	EditorEnableDisable("id_div1","none","id_editor1","block");
	editor_generate('txt_restr_reasons');
	EditorEnableDisable("id_div2","none","id_editor2","block");
	editor_generate('txt_restr_justification');
	EditorEnableDisable("id_div3","none","id_editor3","block");
	editor_generate('txt_exirepay_schedule');
	EditorEnableDisable("id_div4","none","id_editor4","block");
	editor_generate('txt_revised_repayschedule');
	disableFields(false);
	disableCmdButtons(true, false, false, false, true);	
}
function doSave()
{   
	disableCmdButtons(true, true, true, true, true);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateRestructuringAss";
	document.forms[0].hidBeanGetMethod.value="getRestructuringAss";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_restructureassessment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getRestructuringAss";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].action=appUrl+"action/com_restructureassessment.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidSourceUrl.value="action/com_restructureassessment.jsp";	
		document.forms[0].hidBeanMethod.value="updateRestructuringAss";
		document.forms[0].hidBeanGetMethod.value="getRestructuringAss";
		document.forms[0].submit();		
	}
}	



</script>
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
<form name="frmbudget" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5>
			<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include>
		</td>
	</tr>
</table>
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;Proposal  -&gt; Assessment -&gt; Assessment of Restructuring</span><br>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<jsp:include page="../com/com_commentstab.jsp" flush="true">
<jsp:param name="tabid" value="36" />
</jsp:include> <br>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center">
	<tr>
	<td>
	<table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
	<tr class="dataheader">
	<td >Details of the project & credit facilities sanctioned</td>
	
	</tr>
	<tr>
	<td>
		<div id="id_div">
		<div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_proj_details")) %></div></div>
		<div id="id_editor">
		 <textarea NAME="txt_project_details" COLS="90" ROWS="7" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" ><%=Helper.correctNull((String)hshValues.get("com_proj_details"))%></textarea>
		</div>
	</td>
	</tr>
	<tr class="dataheader">
	<td>Reasons for Restructuring</td>
	</tr>
	<tr>
	<td>
		<div id="id_div1">
		<div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_restr_reasons")) %></div></div>
		<div id="id_editor1">
		 <textarea NAME="txt_restr_reasons" COLS="90" ROWS="7" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_restr_reasons"))%></textarea>
		</div>
	</td>
	</tr>
	<tr class="dataheader">
	<td>Justification for Restructuring</td>
	</tr>
	<tr>
	<td>
		<div id="id_div2">
		<div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_restr_justification")) %></div></div>
		<div id="id_editor2">
		 <textarea NAME="txt_restr_justification" COLS="90" ROWS="7" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_restr_justification"))%></textarea>
		</div>
	</td>
	</tr>
	<tr class="dataheader">
	<td>Existing Repayment Schedule</td>
	</tr>
	<tr>
	<td>
		<div id="id_div3">
		<div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_exi_repayschedule")) %></div></div>
		<div id="id_editor3">
		<textarea NAME="txt_exirepay_schedule" COLS="90" ROWS="7" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_exi_repayschedule"))%></textarea>
		</div>
	</td>
	</tr>
	<tr class="dataheader">
	<td>Revised Repayment Schedule</td>
	</tr>
	<tr>
	<td>
		<div id="id_div4">
		<div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_revised_repayschedule")) %></div></div>
		<div id="id_editor4">
		 <textarea NAME="txt_revised_repayschedule" COLS="90" ROWS="7" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_revised_repayschedule"))%></textarea>
		</div>
	</td>
	</tr>
	</table>
	</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable="Y" />
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="pagefrom"> 
<INPUT TYPE="hidden" name="strAssessment" value="<%=request.getParameter("strAssessment")%>">
<INPUT TYPE="hidden" name="strschemeType" value="<%=StrSchemeType%>">
</form>
</body>
</html>