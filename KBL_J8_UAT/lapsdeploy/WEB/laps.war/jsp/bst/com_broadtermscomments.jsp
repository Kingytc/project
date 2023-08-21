<%@include file="../share/directives.jsp"%>
<%String Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));%>
<html>
<head>
<title>Proposal</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varbrn_level="<%=Helper.correctNull((String)hshValues.get("branch_level"))%>";
function placeValues()
{
	disableFields(true);
	if(varbrn_level!="")
	{
		document.forms[0].sel_level.value=varbrn_level;
	}
	else
	{
		document.forms[0].sel_level.value="S";
	}
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidpagedesc.value="repayment','prepayment";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermscomments.jsp";
		document.forms[0].submit();
	 }
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	 	document.forms[0].hidBeanId.value="broadsancterms"
	 	document.forms[0].hidpagedesc.value="repayment','prepayment";
		document.forms[0].hidBeanMethod.value="updateBroadTermsProposalComments";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermscomments.jsp";
 		document.forms[0].submit();
	 }
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	if(document.forms[0].sel_level.value=='S')
	{
		alert("Select a Facility");
		document.forms[0].sel_level.focus();
		return true;
	}
	else
	{
		disableFields(false);
		enableButtons(true,false,false,false,true);
	}
}
function doSave()
{
	enableButtons(true,true,true,true,false);
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidpagedesc.value="repayment','prepayment";
		document.forms[0].hidBeanMethod.value="updateBroadTermsProposalComments";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermscomments.jsp";
		document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/combstpge.jsp";
		document.forms[0].submit();
	}
}
function callLink1(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)

	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].hidpagedesc.value="creditrating~promotorsbackground~projectnature~loanpolicy~guarantee";
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		Alert(103);
	}
}
function getValues()
{
		document.forms[0].hidBeanId.value="broadsancterms"
		document.forms[0].hidpagedesc.value="repayment','prepayment";
		document.forms[0].hidBeanGetMethod.value="getBroadTermsProposalComments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_broadtermscomments.jsp";
		document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form name="frmpri" method="post" class="normal">
<lapstab:applurllinkbst pageid='4' category='bst' valuesin='<%=Valuesin%>' />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Corporate &amp; SME -&gt; Broad Terms of Proposal -&gt; Repayment Terms</td>
	</tr>
</table>
<lapschoice:BST />
<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
	<tr>
	<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><select name="sel_level" onchange="getValues()">
			<option value="S">---Select---</option>
			<lapschoice:bsttermfinfac />
		</select></td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td>Repayment Terms</td>	
		<td><textarea name="comments" cols="80" wrap="VIRTUAL"
			rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("repayment_comments"))%></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td>Prepayment Terms</td>	
		<td><textarea name="comments" cols="80" wrap="VIRTUAL"
			rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("prepayment_comments"))%></textarea>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidpagedesc">
</form>
</body>
</html>

