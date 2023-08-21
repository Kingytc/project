<%@include file="../share/directives.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS Classification Activity Master</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate="<%=Helper.getCurrentDateTime()%>"

function Onload()
{
	var varsocialInfra = document.forms[0].txt_social_infra_val.value.split("@");
	
	for(var j=0;j<varsocialInfra.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_social_infra.options.length;i++)
		{
			if(document.forms[0].sel_social_infra.options[i].value==varsocialInfra[j])
			{			
				document.forms[0].sel_social_infra.options[i].selected=true;

				//For design issue in IE 8,9&10 by Guhan
				//document.forms[0].sel_social_infra.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}
	
	var varrenewenergy = document.forms[0].txt_renew_energy_val.value.split("@");
	
	for(var j=0;j<varrenewenergy.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_renew_energy.options.length;i++)
		{
			if(document.forms[0].sel_renew_energy.options[i].value==varrenewenergy[j])
			{			
				document.forms[0].sel_renew_energy.options[i].selected=true;

				//For design issue in IE 8,9&10 by Guhan
				//document.forms[0].sel_renew_energy.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}
	
	var varrenewenergyindv = document.forms[0].txt_renew_energy_indv_val.value.split("@");
	
	for(var j=0;j<varrenewenergyindv.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_renew_energy_indv.options.length;i++)
		{
			if(document.forms[0].sel_renew_energy_indv.options[i].value==varrenewenergyindv[j])
			{			
				document.forms[0].sel_renew_energy_indv.options[i].selected=true;

				//For design issue in IE 8,9&10 by Guhan
			//	document.forms[0].sel_renew_energy_indv.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}
	
	var varAgriAnciActivity = document.forms[0].txt_agri_anci_acti_val.value.split("@");
	
	for(var j=0;j<varAgriAnciActivity.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_agri_anci_acti.options.length;i++)
		{
			if(document.forms[0].sel_agri_anci_acti.options[i].value==varAgriAnciActivity[j])
			{			
				document.forms[0].sel_agri_anci_acti.options[i].selected=true;

				//For design issue in IE 8,9&10 by Guhan
			//	document.forms[0].sel_agri_anci_acti.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}

	var varAgriInfra = document.forms[0].txt_agri_infra_val.value.split("@");
	
	for(var j=0;j<varAgriInfra.length;j++)
	{
		for(var i=0;i<document.forms[0].sel_agri_infra.options.length;i++)
		{
			if(document.forms[0].sel_agri_infra.options[i].value==varAgriInfra[j])
			{			
				document.forms[0].sel_agri_infra.options[i].selected=true;

				//For design issue in IE 8,9&10 by Guhan
			//	document.forms[0].sel_agri_anci_acti.options[i].style.background="#C3C3C3";
				break;
			}		
		}
	}
	
	doEnableButtons(false,true,true,false);
	disabledFields(true);
}

function doEdit()
{
	doEnableButtons(true,false,false,true);
	disabledFields(false);
}

function doSave()
{
	document.forms[0].txt_social_infra_val.value="";
	document.forms[0].txt_renew_energy_val.value="";
	document.forms[0].txt_renew_energy_indv_val.value="";
	document.forms[0].txt_agri_anci_acti_val.value="";
	document.forms[0].txt_agri_infra_val.value="";
	for(var i=0;i<document.forms[0].sel_social_infra.options.length;i++)
	{
		if(document.forms[0].sel_social_infra.options[i].selected)
		{			
			document.forms[0].txt_social_infra_val.value=document.forms[0].txt_social_infra_val.value+document.forms[0].sel_social_infra.options[i].value+"@";
		}		
	}
	for(var i=0;i<document.forms[0].sel_renew_energy.options.length;i++)
	{
		if(document.forms[0].sel_renew_energy.options[i].selected)
		{			
			document.forms[0].txt_renew_energy_val.value=document.forms[0].txt_renew_energy_val.value+document.forms[0].sel_renew_energy.options[i].value+"@";
		}		
	}
	for(var i=0;i<document.forms[0].sel_renew_energy_indv.options.length;i++)
	{
		if(document.forms[0].sel_renew_energy_indv.options[i].selected)
		{			
			document.forms[0].txt_renew_energy_indv_val.value=document.forms[0].txt_renew_energy_indv_val.value+document.forms[0].sel_renew_energy_indv.options[i].value+"@";
		}		
	}
	for(var i=0;i<document.forms[0].sel_agri_anci_acti.options.length;i++)
	{
		if(document.forms[0].sel_agri_anci_acti.options[i].selected)
		{			
			document.forms[0].txt_agri_anci_acti_val.value=document.forms[0].txt_agri_anci_acti_val.value+document.forms[0].sel_agri_anci_acti.options[i].value+"@";
		}		
	}
	for(var i=0;i<document.forms[0].sel_agri_infra.options.length;i++)
	{
		if(document.forms[0].sel_agri_infra.options[i].selected)
		{			
			document.forms[0].txt_agri_infra_val.value=document.forms[0].txt_agri_infra_val.value+document.forms[0].sel_agri_infra.options[i].value+"@";
		}		
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidSourceUrl.value="/action/misclassiActivity_master.jsp";
	document.forms[0].hidBeanGetMethod.value="getClassificationActivityMaster";
	document.forms[0].hidBeanMethod.value="updateClassificationActivityMaster";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEnableButtons(edit,save,cancel,close)
{
	document.forms[0].cmdedit.disabled=edit;	
	document.forms[0].cmdsave.disabled=save;	
	document.forms[0].cmdcancel.disabled=cancel;	
	document.forms[0].cmdclose.disabled=close;	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].hidSourceUrl.value="/action/misclassiActivity_master.jsp";
		document.forms[0].hidBeanGetMethod.value="getClassificationActivityMaster";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
		{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
		}
}
	
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="Onload()">
<form class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; MIS Classification Activity Master</td>
</tr>
</table>
<br>
<br>
<table class="outertable border1 tableBg" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
<tr>
	<td valign="top">
	
		<table class="outertable" width="100%" border="0" cellpadding="5" cellspacing="0" align="center">
		<tr>
			<td width="20%">Social Infrastructure</td>
			<td width="29%">
			<select multiple="multiple" name="sel_social_infra" size="10" style="width: 95%">
			<lapschoice:MISActivityCodeTag apptype="M" />
			</select>
			<input type="hidden" name="txt_social_infra_id" value="1">
			<input type="hidden" name="txt_social_infra_val" value="<%=Helper.correctNull((String)hshValues.get("social_infra"))%>">
			</td>
		
			<td width="20%">Renewable Energy</td>
			<td width="29%">
			<select multiple="multiple" name="sel_renew_energy" size="10" style="width: 95%">
			<lapschoice:MISActivityCodeTag apptype="M"  />
			</select>
			<input type="hidden" name="txt_renew_energy_id" value="1">
			<input type="hidden" name="txt_renew_energy_val" value="<%=Helper.correctNull((String)hshValues.get("renew_energy"))%>">
			</td>
		</tr>
		
		<tr>
			<td>Renewable Energy for individual purpose</td>
			<td>
			<select multiple="multiple" name="sel_renew_energy_indv" size="10" style="width: 95%">
			<lapschoice:MISActivityCodeTag apptype="M" />
			</select>
			<input type="hidden" name="txt_renew_energy_indv_id" value="1">
			<input type="hidden" name="txt_renew_energy_indv_val" value="<%=Helper.correctNull((String)hshValues.get("renew_energy_indv"))%>">
			</td>

			<td>Agriculture / Ancillary activities</td>
			<td>
			<select multiple="multiple" name="sel_agri_anci_acti" size="10" style="width: 95%">
			<lapschoice:MISActivityCodeTag apptype="M" />
			</select>
			<input type="hidden" name="txt_agri_anci_acti_id" value="1">
			<input type="hidden" name="txt_agri_anci_acti_val" value="<%=Helper.correctNull((String)hshValues.get("agri_anci_activity"))%>">
			</td>
		</tr>
		<tr>
			<td>Agriculture Infrastructure</td>
			<td>
			<select multiple="multiple" name="sel_agri_infra" size="10" style="width: 95%">
			<lapschoice:MISActivityCodeTag apptype="M" />
			</select>
			<input type="hidden" name="txt_agri_infra" value="1">
			<input type="hidden" name="txt_agri_infra_val" value="<%=Helper.correctNull((String)hshValues.get("agri_infra"))%>">
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hidSNo">
</form>
</body>
</html>