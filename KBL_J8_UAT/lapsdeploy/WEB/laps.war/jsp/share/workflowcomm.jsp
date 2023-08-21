<%@include file="../share/directives.jsp"%>
<%
	String strComment = "";
	HashMap hshRecord = new HashMap();
%>
<html>
<head>
<title>Workflow Comments</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script>
var path      ="<%=ApplicationParams.getAppUrl()%>";
var editoption = '<%=Helper.correctNull((String) request.getParameter("editoption")).trim()%>';
var strUserId='<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>';

function onloading()
{
	if(editoption=="N")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	else
	{
		document.forms[0].cmdedit.disabled=false;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
}

function doEdit()
{	
	document.forms[0].comments.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}

function doSave()
{
	if(checktrim(document.forms[0].comments.value)=="")
	{	
		ShowAlert(121,"Current Remarks");
		document.forms[0].comments.focus();
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
	    window.opener.document.forms[0].remarksFlag.value ="true";
	   	document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="mailboxcomments";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/workflowcomm.jsp";
		document.forms[0].submit();
	}
	alert("Close the window and then click send");
}

function doCancel()
{	
	document.forms[0].hidBeanId.value="mailboxcomments";
	appno = document.forms[0].hidappno.value;
	if(ConfirmMsg('102'))
	{
		document.forms[0].comments.value="";
		document.forms[0].comments.readOnly=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}

function doClose()
{	
	if(ConfirmMsg('100'))
	{
		window.close();
	}
}

function dohlp()     
{
  	var hlpvar = path+"phlp/loan_appretail_workflow_remarks.htm";
  	var title = "Remarks";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}
function doPrint()
{	
	document.forms[0].hidBeanId.value="mailboxcomments";
    var appno=document.forms[0].hidappno.value;
  	var purl ="<%=ApplicationParams.getAppUrl()%>action/com_remarksprint.jsp?hidBeanGetMethod=getRemarksData&hidBeanId=mailboxcomments&appno="+appno;
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	var xpos = (screen.width - 750) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'Remarks',prop);
}
</script>

</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<body onload="onloading()">
<form name="auditpage" method="post" class="normal"><i><b>Workflow Comments</b></i><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td colspan="6">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td>Enter Current Recommendations</td>
							</tr>
							<tr>
								<td align="center"><textarea name="comments" cols="115" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" disabled="disabled"></textarea></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top" colspan="6">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td>Earlier Recommendations</td>
							</tr>
							<tr>
								<td align="center">
								<%
									for (int i = 1; i < hshValues.size(); i++) {
										hshRecord = (HashMap) hshValues.get(Integer.toString(i));
										strComment = strComment
												+ hshRecord.get("mail_usrname")
												+ "  -  "
												+ hshRecord.get((String) Helper
														.correctNull("mail_usrdesign"))
												+ "  -  "
												+ hshRecord.get((String) Helper
														.correctNull("mail_pano"))
												+ "  -   sends to "
												+ hshRecord.get("mail_touser")
												+ " on "
												+ hshRecord.get("mail_date")
												+ " ---\n"
												+ hshRecord.get("mail_comments")
												+ "\n"
												+ "\n"
												+ "-----------------------------------------------------------------------------"
												+ "-------------------------------------------------------\n";
									}
								%> <textarea name="txtearaud_text" cols="115" rows="12" readOnly="readonly"> <%=strComment%> </textarea></td>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Print' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidappno" value="<%=request.getParameter("hidappno")%>"> 
<input type="hidden" name="hiduserid" value="<%=request.getParameter("hiduserid")%>"> 
<input type="hidden" name="hiddate" value="<%=request.getParameter("hiddate")%>"> 
<input type="hidden" name="hidtoUser" value="<%=request.getParameter("hidtoUser")%>"> 
<input type="hidden" name="editoption" value="<%=request.getParameter("editoption")%>"> 
<input type="hidden" name="hidtousrid" value="<%=Helper.correctNull(request.getParameter("hidtousrid"))%>">
</form>
</body>
</html>
