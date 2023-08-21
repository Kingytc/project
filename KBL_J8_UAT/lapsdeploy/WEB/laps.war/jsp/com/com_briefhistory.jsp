<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>Brief History</title>
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
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var VarDigiLoanType="<%=Helper.correctNull((String)hshValues.get("StrDigiLoanType"))%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="facilities";
    document.forms[0].hidPage.value="brief";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].hidSourceUrl.value="action/com_briefhistory.jsp";	
	document.forms[0].method="post";
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
		document.forms[0].cmdsave.disabled=true;
	    document.forms[0].hidAction.value="update"
	    document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="brief";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments"
		document.forms[0].hidSourceUrl.value="/action/com_briefhistory.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}

function doEdit()
{
	disableFields(false);	
	disableCommandButtons("edit");
	EditorEnableDisable1("id_div","none","id_editor","block");
	editor_generate('txt_comments');
	EditorEnableDisable1("id_div1","none","id_editor1","block");	
	editor_generate('txt_comments1');
	EditorEnableDisable1("id_div2","none","id_editor2","block");	
	editor_generate('txt_comments2');

	 if(VarDigiLoanType=="PC")
	 {
	  document.forms[0].txt_comments.readOnly=true;

	  document.all.digi.style.visibility="visible";
	  document.all.digi.style.position="relative";
	  document.all.digi1.style.visibility="visible";
	  document.all.digi1.style.position="relative";
	  
	 }else{
		  document.forms[0].txt_comments2.readOnly=true;
		  
		  document.all.digi.style.visibility="hidden";
		  document.all.digi.style.position="absolute";
		  document.all.digi1.style.visibility="hidden";
		  document.all.digi1.style.position="absolute";
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
			//document.forms[0].cmdnew.disabled=true;
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
	 EditorEnableDisable1("id_div","block","id_editor","none");
	 EditorEnableDisable1("id_div1","block","id_editor1","none");
	 EditorEnableDisable1("id_div2","block","id_editor2","none");

	 if(VarDigiLoanType=="PC")
	 {
	  document.forms[0].txt_comments.readOnly=true;

	  document.all.digi.style.visibility="visible";
	  document.all.digi.style.position="relative";
	  document.all.digi1.style.visibility="visible";
	  document.all.digi1.style.position="relative";
	  
	 }else{
		  document.forms[0].txt_comments2.readOnly=true;
		  
		  document.all.digi.style.visibility="hidden";
		  document.all.digi.style.position="absolute";
		  document.all.digi1.style.visibility="hidden";
		  document.all.digi1.style.position="absolute";
	 }
}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  
	  }
	  
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="brief";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/com_briefhistory.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function EditorEnableDisable1(name1,val1,name2,val2)
{
	document.getElementById(name1).style.display=val1;
	document.getElementById(name2).style.display=val2;
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
	<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="117" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top"> 
              <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
              <jsp:param name="pageid" value="1" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>          
        </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;
		 Application -&gt; Applicant -&gt; Facilities</td>
<%}else{ %>
<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;Application -&gt; Applicant -&gt; Brief History</td>
<%}%>
</tr>
</table>
		 
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
<lapstab:ComfacilityTab tabid="3"/>
	<%} %>
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
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center" >
                            <tr> 
                               <td>
                                <table width="90%" border="0" cellspacing="0" cellpadding="4" class="outertable" align="center" >
                                  <tr class="dataheader"> 
                                    <td>Comments for Process Note</td>
                                  </tr>
                                  <tr> 
                                     <td>
							             <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div></div>
							             <div id="id_editor"> <textarea name="txt_comments" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
							         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %>
							             </textarea></div>
                                    </td>
                                  </tr>
                                  <tr class="dataheader" id="digi"> 
                                    <td>Additional Information/Comments if any for Process Note</td>
                                  </tr>
                                  <tr id="digi1"> 
                                     <td>
                                     	 <div id="id_div2"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS2")) %></div></div>
							             <div id="id_editor2"> <textarea name="txt_comments2" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
							         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS2")) %>
							             </textarea></div>
                                    </td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td>Comments for Annexure II</td>
                                  </tr>
                                  <tr>
							          <td>
							            <div id="id_div1"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS1")) %></div></div>
							            <div id="id_editor1"> <textarea name="txt_comments1" cols="110" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
							         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS1")) %>
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
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidPage" value="">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
</form>  
</body>
</html>