<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Financial Position Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var selcomments="<%=Helper.correctNull((String) hshValues.get("selcoment"))%>";
var appno="<%=request.getParameter("appno")%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="compro";
    document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].hidSourceUrl.value="action/FinPositionComm.jsp";	
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
	if(document.forms[0].sel_commentstype.value =="s")
	{
		alert("Please Select comment on");
		document.forms[0].sel_commentstype.focus();
		document.forms[0].txt_comments.value="";
		EditorEnableDisable("id_div","block","id_editor","none");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/FinPositionComm.jsp";
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Open/Pending")	 
	  	{
		  	
		if(document.forms[0].btnenable.value =='Y')
	  	{

			document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		  	document.forms[0].cmdcomments.disabled=false;
	 	}
		else
		{
			//document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		  	document.forms[0].cmdcomments.disabled=false;
			
	  	}
	  	}
		
	 	else
	 	{
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		  	document.forms[0].cmdcomments.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			document.forms[0].cmdcomments.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	if(selcomments=="")
	{
		document.forms[0].sel_commentstype.value="s";
	}
	else
	{
		document.forms[0].sel_commentstype.value=selcomments;
		
	}				
	 disableCommandButtons("load");
	 disableFields(true);
	 EditorEnableDisable("id_div","block","id_editor","none");
}
function doEdit()
{

	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  
	  }
	  
	}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="updateFinancialComments";
		document.forms[0].hidBeanGetMethod.value="getFinancialComments";
		document.forms[0].action=appURL+"action/FinPositionComm.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"action/FinPositionComm.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
	onLoading();
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}
</script>

</head>
<body onload="onLoading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
	<form method = post class="normal">
	<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="11" />
		<jsp:param name="subpageid" value="133" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"	flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
		</tr>
          <tr>
          <%
          String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
          if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt;Agriculture -&gt;
		 Proposal  -&gt; Financial Analysis  -&gt; Financial Position Comments</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
		 Proposal  -&gt; Financial Analysis  -&gt; Financial Position Comments</td>
		<%} %>
         
          </tr>
        </table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="2">
		<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<lapschoice:FinAnalysisTag tabid="5" />			
		</table>
		</td>
	</tr>
</table>

 <table width="98%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr>
<td>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <br>
  <tr> 
    <td width="20%" nowrap="nowrap"><b>Comments On <span class="mantatory">*</span></b>&nbsp;
    <select name="sel_commentstype" tabindex="1" onchange="getCollData()">
		<option value="s" selected>----select----</option>
		<lapschoice:StaticDataTag apptype="141"/>
		</select>
    </td>
  </tr>  
  <tr><td>&nbsp;</td> </tr>  
  <tr class="dataheader"> 
    <td width="20%"> Comments</td>
    </tr>
   <tr class="datagrid"> 
    <td width="60%"> 
      <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comments")) %></div></div>
					 <div id="id_editor">
				
      <textarea name="txt_comments" cols="100"  rows="8" tabindex="2" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea></div>
 </td>
 </tr>
 </table>
  <br>

 </td>
 </tr>
 </table>
 <br> 
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Comments_Audit Trail'/>
<input type="hidden" name="hidPage" value="FPComments">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidCommentPage" value="finposition">
<br>
</form>
</body>
</html>