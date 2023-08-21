<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strLoanType = Helper.correctNull((String)session.getAttribute("sessionModuleType"));
String strPrdType=Helper.correctNull((String)hshValues.get("strProductType"));
String strPageParam = Helper.correctNull((String) session.getAttribute("strModifyterms")).trim();
%>
<html>
<head>
<title>Other Post Sanction Parameters</title>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
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
    document.forms[0].hidPage.value="otherparams";
	document.forms[0].hidBeanMethod.value="updateComments";
	document.forms[0].hidBeanGetMethod.value="getComments";
	document.forms[0].hidSourceUrl.value="action/com_otherpostsanctionparams.jsp";	
	document.forms[0].method="post";
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
		document.forms[0].cmdsave.disabled=true;
	    document.forms[0].hidAction.value="update"
	    document.forms[0].hidBeanId.value="facilities";
	    document.forms[0].hidPage.value="otherparams";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments"
		document.forms[0].hidSourceUrl.value="/action/com_otherpostsanctionparams.jsp";
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
	EditorEnableDisable1("id_div3","none","id_editor3","block");	
	editor_generate('txt_comments3');
	EditorEnableDisable1("id_div4","none","id_editor4","block");	
	editor_generate('txt_comments4');
	EditorEnableDisable1("id_div5","none","id_editor5","block");	
	editor_generate('txt_comments5');
	document.forms[0].hideditflag.value="Y";
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
		if(document.forms[0].btnenable.value =='N')
	  	{
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
	 EditorEnableDisable1("id_div3","block","id_editor3","none");
	 EditorEnableDisable1("id_div4","block","id_editor4","none");
	 EditorEnableDisable1("id_div5","block","id_editor5","none");
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
	    document.forms[0].hidPage.value="otherparams";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"action/com_otherpostsanctionparams.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{	
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
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
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form method=post class="normal">
<%if(strLoanType.equalsIgnoreCase("RET")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="102" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin" width="20%" align="center"><b><b><a
					href="#" onclick="javascript:callLink('perloandetails.jsp','perapplicant','getLoanProducts')">
					Loan Product</a></b></b></td>
			<%if ((strPrdType.equalsIgnoreCase("pI")) && (strPageParam.contains("@SEC@")||strPageParam.contains("@MODSEC@"))) { %>
			<td class="sub_tab_inactive" id="prin"  width="20%"><b><b><a
					href="#" onclick="javascript:callLink('per_instacash.jsp','perapplicant','getinstacash')">
					Insta Cash</a></b></b></td>
					<%} %>
			<%if (strPrdType.equalsIgnoreCase("pE") && strPageParam.contains("@COEX@")) { %>
			<td class="sub_tab_inactive" id="prin"  width="20%" align="center"><b>
			<a href="#" onclick="javascript:callLink('eduparticulars.jsp','eduparticulars','getData')">Course Details</a></b>
			</td>
			<%} %>
			<td class="sub_tab_inactive" id="prin"  width="20%" align="center"><b><b><a
			href="#" onclick="javascript:callLink('percoappguarantor.jsp','perapplicant','getCoAppGuarantor')">
			Co-Applicant / Guarantor</a></b></b></td>
			<td class="sub_tab_active" id="prin" nowrap  width="20%" align="center"><b>Other Post Sanction Parameters</b></td>
			</tr>
</table>
<%}else{ %>
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
<%} %>
<br/><br/>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center">
	<tr>
		<td width="100%">
		<table width="90%" border="0" cellspacing="0" cellpadding="2"
			class="outertable" align="center">
			
			<tr class="dataheader">
				<td>Subject</td>
			</tr>
			<tr>
				<td>
				<div id="id_div">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %></div>
				</div>
				<div id="id_editor"><textarea name="txt_comments" cols="110"
					rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
							         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS")) %>
							             </textarea></div>
				</td>
			</tr>
			<tr class="dataheader">
				<td>Breif History</td>
			</tr>
			<tr>
				<td>
				<div id="id_div1">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS1")) %></div>
				</div>
				<div id="id_editor1"><textarea name="txt_comments1" cols="110"
					rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
							         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS1")) %>
							              </textarea></div>
				</td>
			</tr>
			<tr class="dataheader">
				<td>Present Proposal</td>
			</tr>
			<tr>
				<td>
				<div id="id_div2">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS2")) %></div>
				</div>
				<div id="id_editor2"><textarea name="txt_comments2" cols="110"
					rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
							         		     <%=Helper.correctNull((String)hshValues.get("COM_COMMENTS2")) %>
							              </textarea></div>
				</td>
			</tr>
			
			<tr class="dataheader">
				<td>Recommendations</td>
			</tr>
			<tr>
				<td>
				<div id="id_div3">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS3")) %></div>
				</div>
				<div id="id_editor3"><textarea name="txt_comments3" cols="110"
					rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS3")) %></textarea></div>
				</td>
			</tr>
			<tr class="dataheader">
				<td>Ratification if Any</td>
			</tr>
			<tr>
			<td>
				<div id="id_div4">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS4")) %></div>
				</div>
				<div id="id_editor4"><textarea name="txt_comments4" cols="110"
					rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS4")) %></textarea></div>
				
			</td>	
			</tr>
			<tr class="dataheader">
				<td>Other Relevant Info</td>
			</tr>
			<tr>
			<td>
				<div id="id_div5">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS5")) %></div>
				</div>
				<div id="id_editor5"><textarea name="txt_comments5" cols="110"
					rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("COM_COMMENTS5")) %></textarea></div>
				
			</td>	
			</tr>	
			
			
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'
	btnnames='Edit_Save_Cancel_Delete_Audit Trail' /> <input type="hidden"
	name="hidPage" value=""> <input type="hidden" name="hidBeanId"
	value=""> <input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value=""> <input
	type="hidden" name="hidAction" value=""> <input type="hidden"
	name="hidSourceUrl" value="">
	<input type="hidden" name="hideditflag" value="N">
</form>
</body>
</html>