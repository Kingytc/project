<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%String strSessionModule="";
 strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType")); %>
<%
String strpagetype = Helper.correctNull((String) hshValues.get("page"));
%>
<html>
<head>
<title>Comments</title>
<script>
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
var VARLOANSUBTYPEDIGI="<%=strSessionModule%>";
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
			document.forms[0].cmdedit.disabled=false;
			if(VARLOANSUBTYPEDIGI=="DIGI")
			{
	 	  	document.forms[0].cmddelete.disabled=true;
			}else{
		 	  	document.forms[0].cmddelete.disabled=false;
			}		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		}
		else
		{
			document.forms[0].cmdedit.disabled=true;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		}
		
	}
	if(val=="edit")
	{
	  	document.forms[0].cmdedit.disabled=true;
	  	document.forms[0].cmddelete.disabled=true;
	  	document.forms[0].cmdsave.disabled=false;
	  	document.forms[0].cmdcancel.disabled=false;
	  	document.forms[0].cmdclose.disabled=false;
	    disableFields(false);
	}
}

function onLoading()
{
	
	 disableFields(true);
	 EditorEnableDisable("id_div","block","id_editor","none");
	
	
	<%if(!(strpagetype.equalsIgnoreCase("PrintInterFirmComparsion")|| strpagetype.equalsIgnoreCase("MovementShares") || strpagetype.equalsIgnoreCase("shareholdpattern")||
			strpagetype.equalsIgnoreCase("Takeover")|| strpagetype.equalsIgnoreCase("fvccmts")|| strpagetype.equalsIgnoreCase("section185")|| strpagetype.equalsIgnoreCase("Independenteval")
			|| strpagetype.equalsIgnoreCase("cersaicmts"))){ %>
		
		EditorEnableDisable("id_div1","block","id_editor1","none");
<%}%>
if(btnenable.toUpperCase()=="Y")
{
	disableCommandButtons("load");
}

if(VARLOANSUBTYPEDIGI=="DIGI")
{
	 document.all.digi.style.visibility="visible";
	 document.all.digi.style.position="relative";
}else{
	document.all.digi.style.visibility="hidden";
	 document.all.digi.style.position="absolute";
}

}

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txtarea_comments');
	<%if(!(strpagetype.equalsIgnoreCase("PrintInterFirmComparsion")|| strpagetype.equalsIgnoreCase("MovementShares")|| strpagetype.equalsIgnoreCase("shareholdpattern")|| 
			strpagetype.equalsIgnoreCase("Takeover")|| strpagetype.equalsIgnoreCase("fvccmts")|| strpagetype.equalsIgnoreCase("section185")|| strpagetype.equalsIgnoreCase("Independenteval")
			|| strpagetype.equalsIgnoreCase("cersaicmts"))){ %>
	EditorEnableDisable("id_div1","none","id_editor1","block");
	editor_generate('txtarea_comments1');
	<%}%>
	if(VARLOANSUBTYPEDIGI=="DIGI")
	{
		document.forms[0].txtarea_comments.readOnly=true;
	}
	
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

function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	if(document.forms[0].hidPageType.value !="otherbank" && document.forms[0].hidPageType.value !="swot" && document.forms[0].hidPageType.value !="swotind" && document.forms[0].hidPageType.value !="Method1" && document.forms[0].hidPageType.value !="Method2" && document.forms[0].hidPageType.value !="Assessmentofwc" && document.forms[0].hidPageType.value !="ExposuretoIndustry")
	{
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comments.jsp";
		document.forms[0].submit();
	}
	else if(document.forms[0].hidPageType.value =="swot" || document.forms[0].hidPageType.value =="swotind" || document.forms[0].hidPageType.value =="Method1" || document.forms[0].hidPageType.value =="Method2" || document.forms[0].hidPageType.value =="Assessmentofwc" || document.forms[0].hidPageType.value =="ExposuretoIndustry")
	{
		document.forms[0].hidPage.value=document.forms[0].hidPageType.value;
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comments.jsp";
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].hidBeanMethod.value="updateBankComments";
		document.forms[0].hidBeanGetMethod.value="getBankComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comments.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].action=appURL+"action/comments.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="perfinancial";
		document.forms[0].hidBeanMethod.value="updateComments";
		document.forms[0].hidBeanGetMethod.value="getComments";
		document.forms[0].hidSourceUrl.value="/action/comments.jsp";
		document.forms[0].action=appURL+"controllerservlet";
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
<body onLoad="onLoading()">
<form name="comments" method="post" class="normal">
<i><b>
<%
	String strCommentPage=Helper.correctNull((String)request.getParameter("hidCommentPage"));
	if(strCommentPage.equalsIgnoreCase("L"))
	{%>
		Comments on Other Bank Facilities
	<%}
	else if(strCommentPage.equalsIgnoreCase("C"))
	{%>
		Comments on Guarantor's
	<%}
%>
</b></i>
<table width="98%" border="0" cellpadding="3" cellspacing="3" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
					<tr class="dataheader">
						<td><%if(strpagetype.equalsIgnoreCase("cusratingnew")){ %>External Rating rationale <%}else{ %>Comments<%} %></td>
					</tr>
					<tr><td>
					  <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("cmt_comments")) %></div></div>
	                 <div id="id_editor"> <textarea name="txtarea_comments" cols="150" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
	         		     <%=Helper.correctNull((String)hshValues.get("cmt_comments")) %>
	                 </textarea></div>
					</td></tr>
					<tr><td>&nbsp;</td></tr>
					<%if(!(strpagetype.equalsIgnoreCase("PrintInterFirmComparsion")|| strpagetype.equalsIgnoreCase("MovementShares") || strpagetype.equalsIgnoreCase("shareholdpattern")|| 
							strpagetype.equalsIgnoreCase("Takeover")||strpagetype.equalsIgnoreCase("fvccmts")||strpagetype.equalsIgnoreCase("Independenteval")||strpagetype.equalsIgnoreCase("section185")
							||strpagetype.equalsIgnoreCase("cersaicmts"))){ %>
					<%if(strpagetype.equalsIgnoreCase("cusratingnew")){ %>
					<tr class="dataheader">
						<td>Reason for Downgradation/Migration in rating if any/Non Investment Grade category of Risk rating and reasons for recommending the proposal (Both Internal & External rating as the case may be)</td>
					</tr>
					<%} %>
					 <tr class="dataheader" id="digi"> 
                                    <td>Additional Information/Comments if any for Process Note</td>
                       </tr>
						<tr>
						<td>	<div id="id_div1"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("cmt_cmtinter")) %></div></div>
		 					<div id="id_editor1"><textarea name="txtarea_comments1" cols="150" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("cmt_cmtinter")) %></textarea></div>
		  				</td>
					</tr>
					<%} %>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidCommentPage" value="<%=Helper.correctNull((String)request.getParameter("hidCommentPage"))%>">
<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("hidAppNo"))%>">
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidCommentPage"))%>">
<INPUT TYPE="hidden" name="hidDemoId"	value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidPage">
<input type="hidden" name="hidPageId">
</form>
</body>
</html>