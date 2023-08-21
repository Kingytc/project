<%@include file="../share/CKEditor.jsp"%>
<%String strSessionModule="";
						strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType")); %>
<%@include file="../share/directives.jsp"%>
 
<html>
<head>
<title>Gist Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}
}

function disableCommandButtons(val)
{
	
	if(val=="load")
	{
		if(appstatus=="Open/Pending")
	  	{
		if(btnenable =='Y')
	  	{

			document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=false;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;

	  	}
		else
		{
			//document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	  	}
	 	else
	 	{
	 		//document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;	
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
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
	editor_generate('txt_industryanalysis');
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
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="update_Others";
		document.forms[0].hidBeanGetMethod.value="get_Others";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_commentpage.jsp";
		document.forms[0].submit();
	 }
		
}
function doSave()
{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="update_Others";
		document.forms[0].hidBeanGetMethod.value="get_Others";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_commentpage.jsp";
		document.forms[0].submit();
		

}
function doCancel()
{
	
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="get_Others";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].action=appURL+"action/com_commentpage.jsp";
		document.forms[0].submit();
	 }		
}
function callLink1(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
 	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
}

</script>

</head>
<body onload="onLoading()">
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
	<form method = post class="normal">

<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />

	
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                <tr> 
                <td valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
                            <tr> 
                             <td>
                                <table width="98%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center" >
                                  <tr class="dataheader"> 
                                    <td>Comments</td>
                                  </tr>
                                  <tr > 
                                   <td colspan="2">
            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comments")) %></div></div>
             <div id="id_editor"> <textarea name="txt_industryanalysis" cols="150" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"> 
         		     <%=Helper.correctNull((String)hshValues.get("comments")) %>
              </textarea></div>
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
  <br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidpage" value="odcc">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="PageType" value="odcc">
<input type="hidden" name="hidSrno" value="1">

</form>  
</body>
</html>