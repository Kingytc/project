<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Borrowing powers</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var select1="<%=Helper.correctNull((String)hshValues.get("borrpow_activity"))%>";
var select2="<%=Helper.correctNull((String)hshValues.get("borrpow_totalborrowing"))%>";
var select3="<%=Helper.correctNull((String)hshValues.get("borrpow_resolution"))%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
function disableCommandButtons(val)
{	
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
function doDelete()
{
	if(varRecordflag == "Y"){
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateadvBorrowingPower";
		document.forms[0].hidBeanGetMethod.value="getadvBorrowingPower";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidSourceUrl.value="action/adv_borrowingpower.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanGetMethod.value="getadvBorrowingPower";
		document.forms[0].action=appUrl +"action/adv_borrowingpower.jsp";
		document.forms[0].hidSourceUrl.value="adv_borrowingpower.jsp";	
	    document.forms[0].submit();	
	}	
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidRecordflag.value=varRecordflag;
	   document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanMethod.value="updateadvBorrowingPower";
		document.forms[0].hidBeanGetMethod.value="getadvBorrowingPower";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/adv_borrowingpower.jsp";
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
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}

function onLoading()
{	
	if(select1!="")
	{
	    document.forms[0].sel_activity.value=select1;		
	}
	else
	{
	    document.forms[0].sel_activity.value="0";	
	}
	if(select2!="")
	{
	    document.forms[0].sel_totborrowings.value=select2;		
	}
	else
	{
	    document.forms[0].sel_totborrowings.value="0";
	}
	if(select3!="")
	{
	    document.forms[0].sel_resolution.value=select3;	
    }
    else
	{
	    document.forms[0].sel_resolution.value="0";
	}
	callResolution();
	disableFields(true);
}	
function callLink(page,bean,method)
{
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function callResolution()
{
	if(document.forms[0].sel_totborrowings.value=="1")
	{
		document.all.resolution.style.visibility="visible";
		document.all.resolution.style.position="relative";
	}
	else
	{
		document.all.resolution.style.visibility="hidden";
		document.all.resolution.style.position="absolute";
		document.forms[0].sel_resolution.value="0";
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="borrowing" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"> <jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; ADV1151 -&gt; Borrowing Power</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application />
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr class="dataheader">
		<td align="center"><b>BORROWING POWER</b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
	<tr class="dataheader">
		<td colspan="2"><b>Borrowing Powers (As per clause No. of
		Memorandum Articles of Association) </b></td>
	</tr>
	<tr class="datagrid">
		<td width="54%">I) Whether the activities for which limits are applied
		for are covered by provisions in the Memorandum of Association</td>
		<td width="46%"><select name="sel_activity" tabindex="1">
			<option value="0" selected="selected">Select</option>
			<option value="1">Yes</option>
			<option value="2">No</option>
		</select></td>
	</tr>
	<tr class="datagrid">
		<td width="54%">Whether total borrowings (excluding temporary
		overdraft not under limit) of the company exceed the total of paid up
		capital and reserves.</td>
		<td width="46%"><select name="sel_totborrowings" tabindex="2"
			onChange="callResolution()">
			<option value="0" selected="selected">Select</option>
			<option value="1">Yes</option>
			<option value="2">No</option>
		</select></td>
	</tr>
	<tr id="resolution" class="datagrid">
		<td width="54%">If so, whether the resolution of the general body
		obtained:</td>
		<td width="46%"><select name="sel_resolution" tabindex="3">
			<option value="0" selected="selected">Select</option>
			<option value="1">Yes</option>
			<option value="2">No</option>
		</select></td>
	</tr>
	<tr class="datagrid">
		<td width="54%">Comments on Search Report(brief details indicating
		Date Charge Created, Amount, Name of party/bank, Nature of charge and
		description of assets)</td>
		<td width="46%"><textarea rows="6" name="text_comments" cols="60"
			tabindex="4" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("borrpow_comments"))%></textarea></td>
	</tr>
	<tr class="datagrid">
		<td colspan="2" >For Sanction Office Use <textarea rows="5"
			name="text_sanction" cols="150" tabindex="5"
			onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("borrpow_sanction"))%></textarea>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="20%"><b>&nbsp;</b></td>
		<td width="60%" align="center"><b><jsp:include page="../ADV11-51/adv_links.jsp" flush="true"></jsp:include> </b></td>
		<td width="20%">&nbsp;<div align="right"><b>Pg.1/19&nbsp;<a
			href="javascript:callLink('adv_commentsonstatus.jsp','ADV1151','getcommentsonstatus')"> Next &gt;&gt; </a></b></div>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
