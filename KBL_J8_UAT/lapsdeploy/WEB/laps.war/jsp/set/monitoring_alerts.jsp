<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="select")
	{	 
		 document.forms[0].cmdedit.disabled=false;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=false;	 
		 disableFields(true);
	}
}

function getValues()
{
	if(document.forms[0].selalertfor.value!='0' && 
		document.forms[0].selassettype.value!='0')
	{
		document.all.ifrm.src=appURL+"action/iframemonitoringalerts.jsp?"+
								"hidBeanGetMethod=getMonitoringAlerts&hidBeanId=monitoringsetup&hidAction=get"+
								"&alertfor="+document.forms[0].selalertfor.value+"&assettype="+document.forms[0].selassettype.value;		
	}
	else
	{
		disableCommandButtons("load");
		document.forms[0].txtdaysfrom.value="";
		document.forms[0].txtdaysupto.value="";
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		
		document.forms[0].hidSourceUrl.value="/action/monitoring_alerts.jsp";
		document.forms[0].hidBeanId.value="monitoringsetup";
		document.forms[0].hidBeanGetMethod.value="getMonitoringAlerts";
		document.forms[0].hidBeanMethod.value="getMonitoringAlerts";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}	
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='radio')
	 	{
	 		document.forms[0].elements[i].disabled=(!val);
		}	 	  
	}
}
function doDelete()
{
	var varRecordFlag = document.forms[0].hidDelFlag.value;
	if(varRecordFlag=="Y")
	{
		if (ConfirmMsg("101"))
		{
		    assignData();
			document.forms[0].hidAction.value="delete";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="monitoringsetup";
			document.forms[0].hidSourceUrl.value="/action/monitoring_alerts.jsp";
			document.forms[0].hidBeanMethod.value="updateMonitoringAlerts";
			document.forms[0].hidBeanGetMethod.value="getMonitoringAlerts";	
			document.forms[0].submit();
		}
	}
	else if(varRecordFlag == "N" || varRecordFlag == "")
	{
		ShowAlert(158);
	}
}

function placevalues()
{
	document.forms[0].txtdaysfrom.value="";
	document.forms[0].txtdaysupto.value="";
	disableCommandButtons("load");
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
	if(eval(document.forms[0].txtdaysfrom.value) > eval(document.forms[0].txtdaysupto.value)){
		alert("Days From should be lesser than Days Upto");
		return;
	}
	
    assignData();
    document.forms[0].cmdsave.disabled = true;
    document.forms[0].hidSourceUrl.value="/action/monitoring_alerts.jsp";
	document.forms[0].hidBeanId.value="monitoringsetup";
	document.forms[0].hidBeanMethod.value="updateMonitoringAlerts";
	document.forms[0].hidBeanGetMethod.value="getMonitoringAlerts";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function assignData()
{
   document.forms[0].hid_selassettype.value=document.forms[0].selassettype.options[document.forms[0].selassettype.selectedIndex].text;
   document.forms[0].hid_selalertfor.value=document.forms[0].selalertfor.options[document.forms[0].selalertfor.selectedIndex].text;
}
</script>
</head>
<body onload="placevalues()">
<form name="mon_assetclassification" method="post" class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt;Monitoring Alerts</td>
	</tr>
</table><br>
<table class="outertable border1" width="48%" border="0" cellspacing="0" cellpadding="5" align="center" >
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="3" cellpadding="3" align="center">
			<tr class="dataheader">
				<td colspan="3" align="center"><b>Monitoring Alerts</b></td>
			</tr>
			<tr>
				<td width="10%" align="center">1</td>
				<td width="43%">Alert For</td>
				<td width="47%"><select name="selalertfor" tabindex="1"
					onChange="getValues()">
					<option value="0">--select--</option>
					<%String apptype = "34";%>
					<lapschoice:StaticDataNewTag apptype="<%=apptype%>" />
				</select>
				<input type="hidden" name="hid_selalertfor">
				</td>
			</tr>
			<tr>
				<td align="center" width="10%">4</td>
				<td width="43%">Asset Classification Type</td>
				<td width="47%"><select name="selassettype" tabindex="2" onChange="getValues()">
					<option value="0">--select--</option>
					<%apptype = "33";%>
					<lapschoice:StaticDataNewTag apptype="<%=apptype%>" />
				</select></td>
				<input type="hidden" name="hid_selassettype">
			</tr>
			<tr>
				<td width="10%" align="center">2</td>
				<td width="43%">Days From</td>
				<td width="47%"><input type="text" name="txtdaysfrom" tabindex="3"
					value="<%=Helper.correctNull((String)hshValues.get("DAYSFROM"))%>" size="5"
					maxlength="3" style="text-align:left;border-style=groove"
					onKeyPress="allowDecimals(this)"></td>
			</tr>
			<tr>
				<td align="center" width="10%">3</td>
				<td width="43%">Days Upto</td>
				<td width="47%"><input type="text" name="txtdaysupto" tabindex="4"
					value="<%=Helper.correctNull((String)hshValues.get("DAYSUPTO"))%>" size="5"
					maxlength="4" style="text-align:left;border-style=groove"
					onKeyPress="allowDecimals(this)"></td>
			</tr>
			
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe> 
<input type ="hidden" name ="hidkeyid" value="set">
<input type="hidden" name="hidDelFlag" value="">
</form>
</body>
</html>
