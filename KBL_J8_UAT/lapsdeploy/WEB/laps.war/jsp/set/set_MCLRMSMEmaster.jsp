<%@include file="../share/directives.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
if(hshValues != null)
{
	arrRow = (ArrayList) hshValues.get("arrRow");
}
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=ApplicationParams.getAppUrl()%>css/anylinkmenu.css" />
<link rel="stylesheet" type="text/css" href="<%=ApplicationParams.getAppUrl()%>css/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script type="text/javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script type="text/javascript">
var appurl = "<%=ApplicationParams.getAppUrl()%>";

function fixValues(v0,v1,v2,v3)
{
	document.forms[0].txt_selID.value = v0;
	document.forms[0].txt_amtfrom.value = v1;
	document.forms[0].txt_amtto.value = v2;
	document.forms[0].txt_intrate.value = v3;
	enableButtons(true,false,true,false,true,false);
}

function doSave()
{
	if(document.forms[0].txt_amtfrom.value=="")
	{
		alert("Enter amount from");
		document.forms[0].txt_amtfrom.focus();
		return ;
	}
	if(document.forms[0].txt_amtto.value=="")
	{
		alert("Enter amount to");
		document.forms[0].txt_amtto.focus();
		return ;
	}
	if(document.forms[0].txt_intrate.value=="")
	{
		alert("Enter interest rate");
		document.forms[0].txt_intrate.focus();
		return ;
	}
	
	disabledFields(false);
	document.forms[0].hidSourceUrl.value="/action/set_MCLRMSMEmaster.jsp";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateMCLRMSMEmasterdata";
	document.forms[0].hidBeanGetMethod.value="getMCLRMSMEmasterdata";	
	document.forms[0].action=appurl+"controllerservlet";
	document.forms[0].submit();
}

function onload()
{
	disabledFields(true);
	enableButtons(false,true,true,true,true,false);
}

function doNew()
{
	document.forms[0].hidAction.value="insert";
	disabledFields(false);
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=true;		  
		}
	}
	enableButtons(true,true,false,false,true,true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/set_MCLRMSMEmaster.jsp";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getMCLRMSMEmasterdata";	
		document.forms[0].action=appurl+"controllerservlet";
		document.forms[0].submit();
	}
}

function doEdit()
{
	if(document.forms[0].txt_selID.value=="")
	{
		alert("Select an option to Edit");
		return ;
	}
	document.forms[0].hidAction.value="update";
	disabledFields(false);
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=true;		  
		}
	}
	enableButtons(true,true,false,false,false,true);
}

function doDelete()
{
	alert("Delete option is currently not available");
	return;
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

</script>
<title>MCLR MSME Master</title>
</head>
<body onload="onload();">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="page_flow">
		<td valign="bottom">Home -&gt;Setup -&gt; Admin level controls-&gt; MCLR MSME exposure Master</td>
	</tr>
</table>
<br><br><br><br>
<table width="90%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
<tr><td>
	<table width="75%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td align="center" width="25%">Amount From</td>
			<td align="center" width="25%">Amount To</td>
			<td align="center" width="25%">Interest Rate</td>
		</tr>
		<tr class="datagrid" align="center">
			<td width="8%"><input type="text" maxlength="12" size="30" style="text-align:right" onKeypress="allowNumber(this);" name="txt_amtfrom"></td>
			<td width="8%"><input type="text" maxlength="12" size="30" style="text-align:right" onKeypress="allowNumber(this)" name="txt_amtto"></td>
			<td width="24%"><input type="text" maxlength="5" size="8" style="text-align:right" onKeypress="allowNumber(this)" name="txt_intrate"></td>
		</tr>
	</table>	
	<br><br>
	<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trial" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
	<br><br>
	<table width="60%" border="0" cellspacing="2" cellpadding="3" align="center" class="outertable">
		<tr class="dataheader">
			<td align="center" width="2%">&nbsp;</td>
			<td align="center" width="3%">S.No</td>
			<td align="center" width="23%">Amount From</td>
			<td align="center" width="23%">Amount To</td>
			<td align="center" width="24%">Interest Rate</td>
		</tr>
		<%if(arrRow!=null && arrRow.size()>0){
			for(int i=0;i<arrRow.size();i++){
				arrCol = (ArrayList)arrRow.get(i); %>		
		<tr class="datagrid" align="center">
			<td width="5%" align="center"><input type="radio" name="rad_masterval" onClick="fixValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
																					   '<%=Helper.correctNull((String)arrCol.get(1))%>',
																					   '<%=Helper.correctNull((String)arrCol.get(2))%>',
																					   '<%=Helper.correctNull((String)arrCol.get(3))%>')"></td>
			<td width="5%" align="left"><%=i+1%>&nbsp;</td>
			<td width="20%" align="right"><%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;</td>
			<td width="20%" align="right"><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
			<td width="10%" align="center"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
		</tr>
		<%}}else{ %>
		<tr class="datagrid">
			<td colspan="5" align="center">No data found</td>
		</tr>
		<%} %>
	</table>	 
</td></tr>
</table> 
<lapschoice:hiddentag pageid="<%=PageId%>" /> 
<input type="hidden" maxlength="3" size="7" name="txt_selID">
</body>
</html>