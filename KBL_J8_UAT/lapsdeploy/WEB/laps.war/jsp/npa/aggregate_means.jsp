<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
			ArrayList vecCol = new ArrayList();
			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);%>
<html>
<head>
<title>Aggregate Means</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script> 
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
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
}  

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}
function doNew()
{	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		
		document.forms[0].hidSourceUrl.value="/action/aggregate_means.jsp";
		document.forms[0].hidBeanId.value="npasetup";
		document.forms[0].hidBeanGetMethod.value="getaggregatemeansData";
		document.forms[0].hidBeanMethod.value="getaggregatemeansData";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}	
	disableCommandButtons("load");
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
	}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg("101"))
		{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="npasetup";
			document.forms[0].hidSourceUrl.value="/action/aggregate_means.jsp";
			document.forms[0].hidBeanMethod.value="updateaggregatemeansData";
			document.forms[0].hidBeanGetMethod.value="getaggregatemeansData";	
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
	
function selectValues(val1,val2,val3,val4)
{	
	document.forms[0].hidAggregate_ID.value=val1;
	document.forms[0].txt_minpercent.value=val2;
	document.forms[0].txt_maxpercent.value=val3;
	document.forms[0].txt_points.value=val4;
	disableCommandButtons("radioselect");	
}
function onLoading()
{		
	disableCommandButtons("load");
}
function doSave()
{
	if(trim(document.forms[0].txt_minpercent.value)=="" )
	{
		alert("Enter Minimum Percentage");
 		document.forms[0].txt_minpercent.focus();
 		return;
	}
	
	if(trim(document.forms[0].txt_maxpercent.value)=="")
	{
		alert("Enter Maximum Percentage");
 		document.forms[0].txt_maxpercent.focus();
 		return;
	}
	
	if(trim(document.forms[0].txt_points.value)=="")
	{
		alert("Enter the Points");
 		document.forms[0].txt_points.focus();
 		return;
	}
	
	if(eval(document.forms[0].txt_minpercent.value)>eval(document.forms[0].txt_maxpercent.value))
	{
		ShowAlert(115,"Maximum Percentage","Minimum Percentage");
		document.forms[0].txt_maxpercent.value="";
		document.forms[0].txt_maxpercent.focus();
		return;
	}
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidSourceUrl.value="/action/aggregate_means.jsp";
	document.forms[0].hidBeanId.value="npasetup";
	document.forms[0].hidBeanMethod.value="updateaggregatemeansData";
	document.forms[0].hidBeanGetMethod.value="getaggregatemeansData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}
</script>
</head>
<body onload="onLoading()">
<form name="aggrmeans" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>		
      <td class="page_flow"> Home -&gt; Setup -&gt; NPA -&gt; Aggregate Means</td>
	</tr>
</table><br>
<table width="55%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">				
			<tr class="dataheader">
				<td colspan="3" align="center" height="30"><strong>Aggregate Means of Borrower's/Guarantors</strong></td>
			</tr>
			<tr>
				<td width="4%" height="35" align="center">1</td>
				<td width="59%" height="35">Minimum Percentage of Crystallised dues</td>
				<td width="37%" height="35"><input type="text" name="txt_minpercent"
					value="" size="5" maxlength="3"
					style="text-align:left;border-style=groove"
					onKeyPress="allowInteger()"></td>
			</tr>
			<tr>
				<td height="33" align="center" width="4%">2</td>
				<td height="33" width="59%">Maximum Percentage of Crystallised dues</td>
				<td width="37%" height="33"><input type="text" name="txt_maxpercent"
					value="" size="5" maxlength="3"
					style="text-align:left;border-style=groove"
					onKeyPress="allowInteger()"></td>
			</tr>
			<tr>
				<td height="33" align="center" width="4%">3</td>
				<td height="33" width="59%">Points to be given</td>
				<td width="37%" height="33"><input type="text" name="txt_points"
					value="" size="5" maxlength="3"
					style="text-align:left;border-style=groove"
					onKeyPress="allowInteger()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table width="75%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable linebor">
			<tr class="dataheader">
				<td width="3%">&nbsp;</td>
				<td width="26%" align="center">Min. Percentage of Crystallised Dues</td>
				<td width="23%" align="center">Max. Percentage of Crystallised Dues </td>
				<td align="center" colspan="2" width="17%">Points</td>
			</tr>
			<%if (vecRow != null && vecRow.size() > 0 ) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
			<tr class="datagrid">
				<td width="3%"><input type="radio" style="border:none"
					name="radiobutton" value="radiobutton"
					onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>'
                            	,'<%=Helper.correctDouble((String)vecCol.get(3))%>')">
				</td>
				<td width="26%" align="center"><%=Helper.correctNull((String) vecCol.get(1))%> </td>
				<td width="23%" align="center"><%=Helper.correctNull((String) vecCol.get(2))%> </td>
				<td align="center" colspan="2" width="17%"><%=Helper.correctNull((String) vecCol.get(3))%></td>
			</tr>
			<%}} else {%>
			<tr class="datagrid">
				<td align="center" colspan="6">No Data Found</td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type ="hidden" name ="hidkeyid" value="set">
<input type="hidden" name="hidAggregate_ID" value="" />
</form>
</body>
</html>
