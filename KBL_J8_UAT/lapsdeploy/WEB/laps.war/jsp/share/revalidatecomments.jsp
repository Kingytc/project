<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strStatus=Helper.correctNull((String)hshValues.get("APP_REVALSTATUS"));
if(strStatus.equalsIgnoreCase("op"))
	strStatus="Pending";
else if(strStatus.equalsIgnoreCase("pa"))
	strStatus="Approved";
else if(strStatus.equalsIgnoreCase("pr"))
	strStatus="Rejected";
else
	strStatus="";

%>
<html>
<head>
<title>Revalidation</title>
<script>
var usr_class="";
var usr_func = "";
var usr_dept="";
var flag="";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
var struserpower="<%=Helper.correctNull((String) hshValues.get("strUserClass"))%>";
var struserID="<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>";
var strprd_power="<%=Helper.correctNull((String) hshValues.get("strAuthority"))%>";
var strstatus="<%=Helper.correctNull((String) hshValues.get("APP_STATUS"))%>";
var strAutUser="<%=Helper.correctNull((String) hshValues.get("APP_PROCESSEDBY"))%>";
var strUserID_app="<%=Helper.correctNull((String) hshValues.get("APP_CREATEDBY"))%>";
var strUser_revalidate="<%=Helper.correctNull((String) hshValues.get("APP_REVALIDATEDBY"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("strRecordFlag"))%>";
var varStatus="<%=Helper.correctNull((String) hshValues.get("strStatus"))%>";
var varAccFlag="<%=Helper.correctNull((String) hshValues.get("strAccFlag"))%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}
}

function disableCommandButtons(bool1,bool2,bool3,bool4,bool5,bool6,bool7)
{
		document.forms[0].cmdedit.disabled=bool1;
		document.forms[0].cmdsend.disabled=bool2;
	  	document.forms[0].cmdsave.disabled=bool3;
	  	document.forms[0].cmdcancel.disabled=bool4;
	  	document.forms[0].cmdclose.disabled=bool5;
	  	document.forms[0].cmdapprove.disabled=bool6;
	  	document.forms[0].cmdreject.disabled=bool7;
}

function onLoading()
{
	if(varStatus=="send")
	{
		alert("Request sent Successfully");
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
		window.close();
	}
	else if(varStatus=="approve")
	{
		alert("Request Approved Successfully");
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
		window.close();
	}
	else if(varStatus=="reject")
	{
		alert("Request Rejected");
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].action=appURL+"action/appworkflowaction.jsp";
		document.forms[0].submit();
		window.close();
	}
 		if(document.forms[0].org_name.value=="HEAD OFFICE"){

		document.all.deprt1.style.visibility="visible";
		document.all.deprt1.style.position="relative";
		document.all.deprt2.style.visibility="visible";
		document.all.deprt2.style.position="relative";
		}
		else
		{
		document.all.deprt1.style.visibility="hidden";
		document.all.deprt1.style.position="absolute";
		document.all.deprt2.style.visibility="hidden";
		document.all.deprt2.style.position="absolute";
		}
		EditorEnableDisable("id_div","block","id_editor","none");
		EditorEnableDisable("id_div1","block","id_editor1","none");
		if(strUser_revalidate==struserID)
		{
			disableCommandButtons(false,true,true,true,false,true,true);
			if(varRecordFlag=="Y")
			{
				document.forms[0].cmdsend.disabled=false;
			}
		}
		else if(strUser_revalidate=="" && struserID==document.forms[0].appholder.value)
		{
			disableCommandButtons(false,true,true,true,false,true,true);
			if(varRecordFlag=="Y")
			{
					document.forms[0].cmdsend.disabled=false;
			}
		}
		else
		{
			document.forms[0].cmdsend.disabled=true;
			document.forms[0].cmdapprove.disabled=true;
			document.forms[0].cmdreject.disabled=true;
		}

		if(strstatus=="pa"||strstatus=="pr")
		{
			disableCommandButtons(true,true,true,true,false,true,true);
			document.forms[0].cmdundo.disabled=true;
			if(strUser_revalidate==struserID)
			{
				document.forms[0].cmdundo.disabled=false;
			}
		}
		else
		{
			document.forms[0].cmdundo.disabled=true;
		}
		if(varAccFlag=="Y")
		{
			document.forms[0].cmdundo.disabled=true;
		}
}

function doEdit()
{
	if(parseInt(struserpower)< parseInt(strprd_power)){
		EditorEnableDisable("id_div","none","id_editor","block");
		editor_generate('txtarea_comments');
 		EditorEnableDisable("id_div1","block","id_editor1","none");
		}
	else
	{
		EditorEnableDisable("id_div1","none","id_editor1","block");
		editor_generate('txtarea_comments1');
		if(varRecordFlag=="Y")
		{
			EditorEnableDisable("id_div","none","id_editor","block");
	 		editor_generate('txtarea_comments');
		}
		else
		{
			EditorEnableDisable("id_div1","block","id_editor1","none");
		}
 		document.forms[0].cmdsend.disabled=true;
	}
	if(parseInt(struserpower)>= parseInt(strprd_power))
	{
		disableCommandButtons(true,true,false,false,true,false,false);
	}
	else
	{
		disableCommandButtons(true,true,false,false,true,true,true);
	}
	if(varRecordFlag!="Y")
	{
		document.forms[0].cmdapprove.disabled=true;
		document.forms[0].cmdreject.disabled=true;
	}
}

function doSend()
{	
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(112,"Select Recipient");	
		return ;
	}
	if(document.forms[0].hidmail_tousrid.value==struserID)
	{
		alert("From User and Recipient User are Same");	
		return ;
	}
	if(parseInt(document.forms[0].mail_touserclass.value)<parseInt(strprd_power))
	{
		alert("Selected Recipient doesn't have power to Revalidate the proposal ");	
		document.forms[0].mail_tousrid.value==""
		document.forms[0].mail_tousrid.focus();
		return ;
	}
		document.forms[0].hidAction.value="send";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
		document.forms[0].action=appURL+"action/revalidatecomments.jsp";
		document.forms[0].submit();
}

function doSave()
{
	if(strUser_revalidate==struserID )
	{
    	var messageLength1 = CKEDITOR.instances['txtarea_comments1'].getData().replace(/<[^>]*>/gi, '').length;
	    if( !messageLength1 ) {
	        alert( 'Enter Revalidation Approval Comments' );
	        return;
	    }
    }else{
    	var messageLength = CKEDITOR.instances['txtarea_comments'].getData().replace(/<[^>]*>/gi, '').length;
    	if( !messageLength ) {
            alert( 'Enter Reason for Revalidation' );
            return;
        }
    }
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
		document.forms[0].action=appURL+"action/revalidatecomments.jsp";
		document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="getRevalidateComments";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appURL+"action/revalidatecomments.jsp";	
		document.forms[0].submit();
	}
}

function callLink1(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
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
function callOrgHelp()
{
	var appno1="<%=Helper.correctNull((String) hshValues.get("appno"))%>";
	if(document.forms[0].cmdedit.disabled==false){
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?&appno="+appno1;
		window.open(url,"",prop);
	}
}
function callUsersHelp()
{
	if(document.forms[0].cmdedit.disabled==false){
	if(document.forms[0].org_name.value=="HEAD OFFICE")
	{
		if(document.forms[0].usr_department.value=="0")
		{
			ShowAlert(111,"Department");
			document.forms[0].usr_department.focus();
			return;
		}
	}
	usr_dept=document.forms[0].usr_department.value;
	var prop="scrollbars=no,width=400,height=350,top=100,left=250";
	var url=appURL+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value+"&usr_dept="+usr_dept+"&pagefrom=REVAL";
	window.open(url,"hai",prop);
	}
}
function doApprove()
{
	var messageLength = CKEDITOR.instances['txtarea_comments'].getData().replace(/<[^>]*>/gi, '').length;
	if( !messageLength ) {
        alert( 'Enter Reason for Revalidation' );
        return;
    }
	var messageLength1 = CKEDITOR.instances['txtarea_comments1'].getData().replace(/<[^>]*>/gi, '').length;
    if( !messageLength1 ) {
        alert( 'Enter Revalidation Approval Comments' );
        return;
    }
	document.forms[0].hidAction.value="approve";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
	document.forms[0].action=appURL+"action/revalidatecomments.jsp";
	document.forms[0].submit();
}
function doReject()
{
   	var messageLength1 = CKEDITOR.instances['txtarea_comments1'].getData().replace(/<[^>]*>/gi, '').length;
    if( !messageLength1 ) {
        alert( 'Enter Revalidation Approval Comments' );
        return;
    }
	document.forms[0].hidAction.value="reject";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
	document.forms[0].action=appURL+"action/revalidatecomments.jsp";
	document.forms[0].submit();
	
}
function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidBeanId.value="commworkflow";
	document.forms[0].hidBeanGetMethod.value="updateRevalidateComments";
	document.forms[0].action=appURL+"action/revalidatecomments.jsp";
	document.forms[0].submit();
}
</script>
</head>
<body onLoad="onLoading()">
<form name="comments" method="post" class="normal"><lapschoice:application />

<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable linebor" align="center">
	<tr class="dataheader">
	<%if(!strStatus.equalsIgnoreCase("")){ %>
	<td width="10%">Revalidation Status </td>
	<td width="10%"><%=strStatus%></td>
	<%}
	if(!Helper.correctNull((String)hshValues.get("APP_REFERENCENO")).equalsIgnoreCase("")){ %>
		<td width="15%">Revalidation Reference Number </td>
		<td width="40%"><%=Helper.correctNull((String)hshValues.get("APP_REFERENCENO")) %></td>
	<% }%> 
	</tr>
</table>
<br>

<table width="98%" border="0" cellpadding="3" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0"
			class="outertable border1" align="center">
			<tr>
				<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="0"
					class="outertable" align="center">
					<tr class="dataheader">
						<td>Reason for Revalidation</td>
					</tr>
					<tr>
						<td>
						<div id="id_div">
						<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_REVALIDATION_REASON")) %></div>
						</div>
						<div id="id_editor"><textarea name="txtarea_comments"
							cols="30" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_REVALIDATION_REASON")) %></textarea></div>
						</td>
					</tr>

					<tr class="datagrid">
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr id="org">
								<td valign="top">

								<table width="93%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td width="30%" nowrap>Select Organisation</td>
										<td width="60%"><input type="text" name="org_name"
											size="25" readonly="readonly" value="<%=strOrgName%>"><span
											id="idorgselect"> <a href="#"
											onClick="javascript:callOrgHelp()"> <img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"> </a></span></td>
									</tr>
								</table>
								</td>

								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr>

												<td id="deprt1" width="16%">Department<span
													class="mantatory">*&nbsp;</span></td>

												<td id="deprt2" width="15%"><select
													name="usr_department">
													<option value="0">---Select---</option>
													<%String apptypecon = "20";%>
													<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
												</select></td>

												<td width="21%" align="center">Select Recipient</td>

												<td width="48%"><input type="text" name="mail_tousrid"
													size="25" readonly="readonly" value=""> <input
													type="hidden" name="hidmail_tousrid"> <a href="#"
													onClick="javascript:callUsersHelp()"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"> </a></td>
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

					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr class="dataheader">
						<td>Revalidation Approval Comments</td>
					</tr>
					<tr>
						<td>
						<div id="id_div1">
						<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("APP_SANCTION_CMTS")) %></div>
						</div>
						<div id="id_editor1"><textarea name="txtarea_comments1"
							cols="30" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("APP_SANCTION_CMTS")) %></textarea></div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<lapschoice:combuttonnew
			btnnames='Edit_Save_Approve_Reject_Undo_Send_Cancel' btnenable='N' />
		<table width="93%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td><span class="mantatory">Sanction Validity upto :<%=Helper.correctNull((String)hshValues.get("strSancValidity"))%></span></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("APP_REVALFLAG")).equalsIgnoreCase("Y") && Helper.correctNull((String)hshValues.get("APP_REVALSTATUS")).equalsIgnoreCase("pa")){ %>
			<tr>
				<td><span class="mantatory">Revalidation Validity upto :<%=Helper.correctNull((String)hshValues.get("strRevalValidity"))%></span></td>
			</tr>
			<%}else{%>
			<tr>
				<td><span class="mantatory">Not Availed/Revalidated Validity upto :<%=Helper.correctNull((String)hshValues.get("strNotAvailedValidity")) %></span></td>
			</tr>
			<%} %>
		</table>
		<lapschoice:hiddentag /> <input type="hidden" name="org_code"
			value="<%=strOrgCode%>"> <input type="hidden"
			name="hidFacilitysno"
			value="<%=Helper.correctInt((String)hshValues.get("hidFacilitysno"))%>">
		<input type="hidden" name="mail_touserclass"> <input
			type="hidden" name="hiduserClass">
		</form>
</body>
</html>