<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
			ArrayList vecCol = new ArrayList();
			%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{
		disableFields(true);
		if(document.forms[0].appstatus.value=="Open/Pending")
		document.forms[0].cmdnew.disabled =false;
	else
		document.forms[0].cmdnew.disabled =true;
		
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	
	
	if(val=="new")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	
}
function selectValues(val1,val2,val3,val4,val5,val6,i,size)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].txt_name.value=val2;
	document.forms[0].txt_branch.value=val3;
	document.forms[0].txt_limit.value=val4;
	document.forms[0].txt_amount.value=val5;
	document.forms[0].txt_bal.value=val6;
	if(size==1)
	{
		document.forms[0].txt_otherdep.value=document.forms[0].hidother.value;		
	}
	else
	{
		document.forms[0].txt_otherdep.value=document.forms[0].hidother[i].value;		
	}	
	roundtxt(document.forms[0].txt_amount);
	roundtxt(document.forms[0].txt_bal);
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
 	 disableCommandButtons("radioselect");
	}
}
function doNew()
{
	disableFields(false);
	disableCommandButtons("new");	
	document.forms[0].hidAction.value ="insert";
document.forms[0].hideditflag.value="Y";
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons("edit");	
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/adv_connectedaccounts.jsp";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidBeanGetMethod.value="getconnectedaccts";
		document.forms[0].hidBeanMethod.value="getconnectedaccts";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}
function doSave()
{
		if(document.forms[0].txt_name.value=="")
		{
			ShowAlert('121',"Name");
			document.forms[0].txt_name.focus();
		}
		else
		{
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].hidSourceUrl.value="/action/adv_connectedaccounts.jsp";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidBeanMethod.value="updateconnectedaccts";
			document.forms[0].hidBeanGetMethod.value="getconnectedaccts";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidSourceUrl.value="/action/adv_connectedaccounts.jsp";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidBeanMethod.value="updateconnectedaccts";
			document.forms[0].hidBeanGetMethod.value="getconnectedaccts";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		
		ShowAlert(158);
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].readOnly=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}
	}
}
function onLoading()
{
		disableFields(true);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);		
	}
}
function callLink(page,bean,method)
	{	
		if (document.forms[0].cmdsave.disabled)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}
		else
		{
		ShowAlert(103);
		}
	}
</script>
</head>
<body onload="onLoading()">
<form name="form1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home-&gt; Tertiary-&gt; Proposal-&gt;ADV1151 -&gt;Connected Accounts</td>
	</tr>
</table>
<lapschoice:borrowertype /> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr class="dataheader">
		<td align="center"><b>CONNECTED ACCOUNTS</b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
	<tr class="dataheader">
		<td colspan="6"><b>Connected accounts(Other trade names, sister concerns etc)</b></td>
	</tr>
	<tr class="dataheader">
		<td width="16%" align="center">Name<span class="mantatory">*&nbsp;</span></td>
		<td width="17%" align="center">Branch</td>
		<td width="16%" align="center">Limit</td>
		<td width="16%" align="center">Amount</td>
		<td width="14%" align="center">Bal. in CD A/C</td>
		<td width="21%" align="center">Other Deposits , if any</td>
	</tr>
	<tr>
		<td width="16%"><input type="text" name="txt_name" tabindex="1"	maxlength="50"></td>
		<td width="17%"><input type="text" name="txt_branch" tabindex="2" maxlength="100"></td>
		<td width="16%"><input type="text" name="txt_limit" tabindex="3" onKeyPress="notAllowSplChar()" maxlength="50">
		</td>
		<td width="16%"><lapschoice:CurrencyTag name="txt_amount" tabindex="4" onKeyPress="allowInteger()" maxlength="12" />
		</td>
		<td width="14%"><lapschoice:CurrencyTag name="txt_bal" tabindex="5" onKeyPress="allowInteger()" maxlength="12" />
		</td>
		<td width="21%"><textarea name="txt_otherdep" cols="25" rows="2" tabindex="6" maxlength="500" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"></textarea></td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
	<tr class="dataheader">
		<td>&nbsp;</td>
		<td align="center" width="24%">Name</td>
		<td align="center" width="25%">Branch</td>
		<td align="center" width="11%">Limit</td>
		<td align="center" width="10%">Amount</td>
		<td align="center" width="10%">Balance</td>
		<td align="center" width="17%">Other
		Deposits</td>
	</tr>
	<%vecRow = (ArrayList) hshValues.get("vecRow");
			if (vecRow != null && vecRow.size() > 0) {
				int size = vecRow.size();
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
	<tr class="datagrid">
		<td width="3%" align="center"> <input
			type="radio" style="border:none" name="radiobutton"
			value="radiobutton"
			onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
						'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
						'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.correctNull((String)vecCol.get(4))%>',
						'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=i%>','<%=size%>')">
		<input type="hidden" name="hidother"
			value="<%=Helper.correctNull((String)vecCol.get(6))%>"> </td>
		<td width="24%">&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
		<td width="25%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
		<td width="11%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
		<td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
		<td width="10%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(5))))%></td>
		<td width="17%" align="right">&nbsp;<%=Helper.correctNull((String) vecCol.get(6))%></td>
	</tr>
	<%}} else {%>
	<tr class="datagrid"><td align="center" colspan="8">No Data Found</td></tr>
	<%}%>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="20%" ><b>&nbsp;
		<a
			href="javascript:callLink('adv_termdepoits.jsp','ADV1151','getTermdepoits')"
			> &lt;&lt; Previous </a>&nbsp;</b></td>
		<td width="60%" align="center"><b>
		<jsp:include page="../ADV11-51/adv_links.jsp" flush="true">
		</jsp:include> </b></td>
		<td width="20%" align="right">&nbsp;
		<b>Pg.11/19&nbsp;<a
			href="javascript:callLink('adv_workingcapital.jsp','ADV1151','getworkingcapital')"
			> Next &gt;&gt; </a></b>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<br>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("advcol_sno"))%>" />
</form>
</body>
</html>
