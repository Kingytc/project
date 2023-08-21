<%@include file="../share/CKEditor.jsp"%>
<%String strSessionModule="";
strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType")); 

%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Gist Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
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
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
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
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=false;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
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
		document.forms[0].hidSourceUrl.value="/action/com_industryanalysis.jsp";
		document.forms[0].submit();
	 }
		
}
function doSave()
{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="update_Others";
		document.forms[0].hidBeanGetMethod.value="get_Others";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_industryanalysis.jsp";
		document.forms[0].submit();
}
function doCancel()
{
	
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="get_Others";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].action=appURL+"action/com_industryanalysis.jsp";
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
<div class="menuitems">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
	<form method ="post" class="normal">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	
</table>
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="22" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
<table width="100%" border="0" cellspacing="1" cellpadding="0"> 
<%if(strSessionModule.equalsIgnoreCase("corp")){ %>
	<tr>
		 
      <td class="page_flow">Home -&gt; Corporate & SME  -&gt; Proposal -&gt; Exposure to Industry / Other Info -&gt; Industry analysis</td>
	</tr>
	<%}else{ %>
	<tr>
		 
      <td class="page_flow">Home -&gt; Agriculture  -&gt; Proposal -&gt; Exposure to Industry / Other Info -&gt; Industry analysis</td>
	</tr>
	<%} %> 
</table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> <td>
 	<table width="50%" border="0" cellspacing="1" cellpadding="3"> 
	<tr align="center">
	 	<td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap"> <a href="javascript:callLink1('com_Exposuretoindustry.jsp','comproposal','getExposureIndustry')">Exposure to Industry</a></td>
		 <td width="13%" height="14" class="sub_tab_active" nowrap="nowrap">Industry analysis</td>
		 <td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		 <a href="javascript:callLink1('com_swotanalysis.jsp','compro','get_swotanalysis')">Swot Analysis</a></td> 
		 <td width="13%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		 <a href="javascript:callLink1('com_interfirmcomp.jsp','comassestsliab','getInterfirmComp')">Inter Firm Comparsion</a></td>
		 <td width="12%" height="14" class="sub_tab_inactive" nowrap="nowrap">
		 <a href="javascript:callLink1('com_management.jsp','compro','get_Management')">Other Details</a></td> </tr> 
	</table>
	
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
                                <table width="90%" border="0" cellspacing="0" cellpadding="4" class="outertable border1" align="center" >
                                  <tr class="dataheader"> 
                                    <td>Comments</td>
                                  </tr>
                                  <tr > 
                                   <td colspan="2">
            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comments")) %></div></div>
             <div id="id_editor"> <textarea name="txt_industryanalysis" cols="150" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" >
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
  </td></tr></table>
  <br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidpage" value="Industry">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidSrno" value="1">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
</form>
</body>
</html>