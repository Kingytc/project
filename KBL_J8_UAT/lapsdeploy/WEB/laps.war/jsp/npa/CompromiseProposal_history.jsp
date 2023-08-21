<%@include file="../share/directives.jsp"%>
<%String strAppno = Helper.correctNull((String) request.getParameter("npa_appno"));%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
	}
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	 
	}	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
		document.forms[0].action=appURL +"action/CompromiseProposal_history.jsp";
		document.forms[0].submit(); 		
	}	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_history.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateGeneralHistoryData";
		document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}
}
function doSave()
{
	if(document.forms[0].txt_briefhistory.value=="")
	{
		alert("Enter the Brief History");
		document.forms[0].txt_briefhistory.focus();
		return;
	}
	if(document.forms[0].txt_irregularreasons.value=="")
	{
		alert("Enter the Reasons for Account Turning Irregular");
		document.forms[0].txt_irregularreasons.focus();
		return;
	}
	if(document.forms[0].txt_staffaccountability.value=="")
	{
		alert("Enter the Staff Accountability");
		document.forms[0].txt_staffaccountability.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_history.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateGeneralHistoryData";
	document.forms[0].hidBeanGetMethod.value="getGeneralHistoryData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}	  
	}
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appURL+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<body>
<form name="comp1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td><lapstab:otscourltag pageid="2" /></td>
			</tr>
				<tr>
		<td valign="top" class="page_flow">Home -&gt; NPA -&gt; Compromise Proposal -&gt; History</td>
	</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
<INPUT type="hidden" name="npa_appno" value="<%=strAppno%>" /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr align="center" class="dataheader">
						<td><b>BRIEF HISTORY <span class="mantatory">*&nbsp;</span></b></td>
						<td width="10%">&nbsp;</td>
						<td  align="center"><b>REASONS FOR ACCOUNT TURNING IRREGULAR/NPA <span class="mantatory">*&nbsp;</span></b></td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;<textarea name="txt_briefhistory"
							cols="85" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("briefhistory"))%></textarea></td>
						<td width="10%">&nbsp;</td>
						<td width="45%" colspan="2"><textarea name="txt_irregularreasons"
							cols="85" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("irregularreasons"))%></textarea></td>
					</tr>
					<tr align="center" class="dataheader">
						<td ><b>STEPS TAKEN TO RECOVER DUES</b></td>
						<td width="10%">&nbsp;</td>
						<td  align="center"><b>DETAILS OF LEGAL ACTION INITIATED</b></td>
					</tr>
					<tr class="datagrid">
						<td width="45%"><textarea name="txt_recoverduesteps"
							cols="85" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("recoverduesteps"))%></textarea></td>
						<td width="10%">&nbsp;</td>
						<td width="45%"><textarea name="txt_legalaction"
							cols="85" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("legalaction"))%></textarea></td>
					</tr>
					<tr align="center" class="dataheader">
						<td ><b>DETAILS OF SARFAESIA ACTION INITIATED</b></td>
						<td width="10%">&nbsp;</td>
						<td  align="center"><b>DETAILS OF BIFR ACTION, IF ANY</b></td>
					</tr>
					<tr class="datagrid">
						<td width="45%"><textarea name="txt_sarfaesiaaction"
							cols="85" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("sarfaesiaaction"))%></textarea></td>
						<td width="10%">&nbsp;</td>
						<td width="45%"><textarea name="txt_bifraction" cols="85" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
							<%=Helper.correctNull((String) hshValues.get("bifraction"))%></textarea></td>
					</tr>
					<tr align="center" class="dataheader">
						<td ><b>STAFF ACCOUNTABILITY <span class="mantatory">*&nbsp;</span></b></td>
						<td width="10%">&nbsp;</td>
						<td align="center">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="45%"><textarea name="txt_staffaccountability" cols="85" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL">
				<%=Helper.correctNull((String)hshValues.get("staffaccountability"))%></textarea></td>
						<td width="10%">&nbsp;</td>
						<td width="45%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
