<%@include file="../share/directives.jsp"%>
<%		String comments = Helper.correctNull((String) hshValues.get("comments"));			
			HashMap hshAppdata=new HashMap();
			hshAppdata=(HashMap)hshValues.get("hshAppdata");			
			String strAppno="";
			String strcbsid="";
			String appname="";
			String strAppstatus="";
			String appstatus="";
			String strAppname="";
			String readFlag="";
			String strBorrowertype="";
			String strmoduletype="";
			String strBTNEnable="";
			String npaorgscode="";
			String strAppholder="";
			String strOrgname="";			
			strAppno = Helper.correctNull((String) hshAppdata.get("npaappno"));
			strcbsid = Helper.correctNull((String) hshAppdata.get("cbsid"));
			appname = Helper.correctNull((String) hshAppdata.get("customername"));
			strAppname=Helper.encodeAmpersand(appname);
			appstatus = Helper.correctNull((String) hshAppdata.get("status"));
			strBorrowertype = Helper.correctNull((String) hshAppdata.get("demoapptype"));
			strmoduletype = Helper.correctNull((String) hshAppdata.get("moduletype"));
			strBTNEnable = Helper.correctNull((String) hshAppdata.get("btnenable"));
			readFlag= Helper.correctNull((String) hshAppdata.get("readflag"));
			npaorgscode=Helper.correctNull((String) hshAppdata.get("createorgscode"));
			strAppholder=Helper.correctNull((String) hshAppdata.get("holduserid"));
			strOrgname=Helper.correctNull((String) hshAppdata.get("apporgname"));
			if(appstatus.equalsIgnoreCase("OP")||appstatus.equalsIgnoreCase("PP")){
				strAppstatus="Open/Pending";
			}
			else if(appstatus.equalsIgnoreCase("PA")){
				strAppstatus="Processed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("PR")){
				strAppstatus="Processed/Rejected";
			}
			else if(appstatus.equalsIgnoreCase("CA")){
				strAppstatus="Closed/Approved";
			}
			else if(appstatus.equalsIgnoreCase("CR")){
				strAppstatus="Closed/Rejected";
			}%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var compro_proposal="<%=Helper.correctNull((String)hshValues.get("propfor"))%>";
var compro_fraud="<%=Helper.correctNull((String)hshValues.get("fraud"))%>";
var compro_defaulter="<%=Helper.correctNull((String)hshValues.get("defaulter"))%>";
var compro_ecgc="<%=Helper.correctNull((String)hshValues.get("ecgcclaimed"))%>";
var compro_pwo="<%=Helper.correctNull((String)hshValues.get("writeoff"))%>";
var comments="<%=comments%>";
var flag="<%=Helper.correctNull((String)hshValues.get("flag"))%>";
var varOrgLevel="<%=strOrgLevel%>";  

function disableCommandButtons(valedit,valapply,valcancel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;		 
	document.forms[0].cmdclose.disabled=valclose;
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/CompromiseProposal_generalinfo.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateGeneralinfoData";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 
	}
}
function onLoading()
{
	if(comments!="")
	{
		alert(comments);
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}	
	
	if(document.forms[0].appno.value=="NEW")
	{
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		document.forms[0].hideditflag.value="Y";
		document.forms[0].selproptype.focus();
		disableCommandButtons(true,false,true,false);	
	}
	else
	{
		if(compro_proposal!="")
		{
			document.forms[0].selproptype.value=compro_proposal;
		}
		else
		{
			document.forms[0].selproptype.value="0";
		}
		
		if(compro_fraud!="")
		{
			document.forms[0].sel_fraud.value=compro_fraud;
		}
		else
		{
			document.forms[0].sel_fraud.value="0";
		}
		
		if(compro_defaulter!="")
		{
			document.forms[0].sel_defaulter.value=compro_defaulter;
		}
		else
		{
			document.forms[0].sel_defaulter.value="0";
		}
		if(compro_ecgc!="")
		{
			document.forms[0].sel_ecgc.value=compro_ecgc;
		}
		else
		{
			document.forms[0].sel_ecgc.value="0";
		}
		if(compro_pwo!="")
		{
			document.forms[0].sel_pwo.value=compro_pwo;
		}
		else
		{
			document.forms[0].sel_pwo.value="0";
		}
		showProposal();
		showECGC();
		disableFields(true);
		
	}
	document.all.cmddelete.style.visibility="hidden";
	document.all.cmddelete.style.position="absolute";
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,false,false,true);	
	document.forms[0].selproptype.focus();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appUrl+"action/CompromiseProposal_generalinfo.jsp";
		document.forms[0].submit(); 	
	}	
}

function doSave()
{
	if(document.forms[0].selproptype.value=="0")
	{
		ShowAlert(111,'Proposal for settlement');
		document.forms[0].selproptype.focus();
		return;
	}
	if(document.forms[0].txt_propamt.value=="0.00" || document.forms[0].txt_propamt.value=="")
	{
		ShowAlert(121,'Counter Offer Amount');
		document.forms[0].txt_propamt.focus();
		return;
	}
	if(document.forms[0].sel_ecgc.value=="0")
	{
		ShowAlert(111,'ECGC/CGFT/DICGC CLAIM SETTLED');
		document.forms[0].sel_ecgc.focus();
		return;
	}
	if(document.forms[0].sel_pwo.value=="0")
	{
		ShowAlert(111,'WHETHER ACCOUNT IS PRUDENTIALLY WRITTEN OFF :');
		document.forms[0].sel_pwo.focus();
		return;
	}
	
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="updateGeneralinfoData";
	document.forms[0].action=appUrl+"action/CompromiseProposal_generalinfo.jsp";
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
	document.forms[0].txt_constitution.readOnly=true;
	document.forms[0].txt_banksince.readOnly=true;
	document.forms[0].txt_advancesince.readOnly=true;
	document.forms[0].txt_npasince.readOnly=true;	
	document.forms[0].txt_present_act.readOnly=true;
	document.forms[0].txt_present_classfication.readOnly=true;	
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].hideditflag.value=="N")
	{
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
function showProposal()
{
	if(document.forms[0].selproptype.value=="1")
	{
		document.all.pro1.style.visibility="visible";
	}
	else
	{
		document.all.pro1.style.visibility="hidden";
		document.forms[0].txt_propcounteramt.value="";
	}
}
function showECGC()
{
	if(document.forms[0].sel_ecgc.value=="1")
	{
		document.all.ecgc1.style.visibility="visible";
	}
	else
	{
		document.all.ecgc1.style.visibility="hidden";
		document.forms[0].txt_excessdate.value="";
	}
}

function clearAllFeilds()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].value="";
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].value="0";
		}			  
	}
}
</script>
</head>
<body onload="onLoading()">
<form name="comp1" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td><lapstab:otscourltag pageid="1" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Compromise Proposal -&gt;General</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td nowrap><b>Application No :</b></td>
		<td nowrap><b><%=strAppno%></b></td>

		<td nowrap><b>Applicant Name:</b></td>
		<td nowrap><b><%=appname%></b></td>
		
		<td nowrap><b>CBS CUSTOMER ID:</b></td>
		<td nowrap><b><%=strcbsid%></b></td>

		<td nowrap><b>Status:</b></td>
		<td nowrap><b><%=strAppstatus%></b></td>
	</tr>
	<tr class="applicationheader">
		<td nowrap><b>Application Holder:</b></td>
		<td nowrap><b><%=strAppholder%></b></td>
		<td nowrap><b>Application Recd. from:</b></td>
		<td nowrap><b><%=strOrgname%></b></td>		
		<td colspan="4">&nbsp;
		<input type="hidden" name="appstatus" value="<%=appstatus%>">
		<input type="hidden" name="appname" value="<%=strAppname%>">
		<input type="hidden" name="cbsid" value="<%=strcbsid%>">
		<input type="hidden" name="npaorgcode" value="<%=npaorgscode%>">
		<input type="hidden" name="appno" value="<%=strAppno%>">
		<input type="hidden" name="readFlag" value="<%=readFlag%>">
		<input type="hidden" name="hidmoduletype" value="<%=strmoduletype%>">
		<input type="hidden" name="hidborrowertype" value="<%=strBorrowertype%>">
		<input type="hidden" name="btnenable" value="<%=strBTNEnable%>">
		<input type="hidden" name="appholder" value="<%=strAppholder%>">
		<input type="hidden" name="apporgname" value="<%=strOrgname%>">
		</td>		
	</tr>
</table><br>
<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable border1">
	<tr>
		<td colspan="3">
		<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr>
				<td width="30%">PROPOSAL FOR SETTLEMENT</td>
				<td width="30%"><select name="selproptype" onChange="showProposal()" tabindex="1">
					<option value="0" selected>----Select----</option>
					<option value="1">COUNTER OFFER</option>
					<option value="2">COMPROMISE</option>
				</select></td>
				<td width="25%">PRESENT CLASSIFICATION</td>
				<td><input type="text" name="txt_present_classfication" size="20"
					maxlength="10" tabindex="2" class="interfacefields"
					value="<%=Helper.correctNull((String)hshValues.get("presentclassification"))%>">
				</td>
			</tr>
			<tr>
				<td width="25%">PROVISION HELD</td>
				<td colspan="3"><input type="text" name="txt_provision" size="20"
					style="text-align:right" maxlength="10" tabindex="3" onKeyPress="allowInteger()"
					value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("provision"))))%>">
				</td>
			</tr>
			<tr>
				<td width="25%">OTS AMOUNT PROPOSED</td>
				<td colspan="3">Rs. <input type="text" name="txt_propamt" size="16"
					style="text-align:right" maxlength="12" tabindex="4" onKeyPress="allowDecimals()"
					value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("propamt"))))%>">
				</td>
			</tr>
			<tr id="pro1">
				<td width="25%">COUNTER OFFER AMOUNT</td>
				<td colspan="3">Rs. <input type="text" name="txt_propcounteramt"
					size="16" style="text-align:right" maxlength="12" tabindex="5" onKeyPress="allowDecimals()"
					value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("propcounteramt"))))%>">
				</td>
			</tr>
			<tr>
				<td>EFFECT ON PROFITABILTY</td>
				<td><input type="text" name="txt_effect_profit" size="20"
					maxlength="50" tabindex="6" value="<%=Helper.correctNull((String)hshValues.get("compro_effectprofit"))%>">
				</td>

				<td>CONSTITUTION</td>
				<td><input type="text" name="txt_constitution" size="20" maxlength="10" tabindex="22"
					value="<%=Helper.correctNull((String)hshValues.get("constitution"))%>" class="interfacefields"></td>
			</tr>
			
			<tr>
				<td width="25%">PRESENT ACTIVITY</td>
				<td colspan="3"><input type="text" name="txt_present_act" value="<%=Helper.correctNull((String) hshValues.get("activity"))%>" >
				</td>
			</tr>
			<tr>
				<td>BANKING SINCE</td>
				<td><input type="text" name="txt_banksince" size="12" maxlength="10" tabindex="22" onBlur="checkDate(this)"
					value="<%=Helper.correctNull((String)hshValues.get("banksince"))%>">
				<a href="#" onClick="callCalender('txt_banksince')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="2"></a></td>

				<td>ADVANCE SINCE</td>
				<td><input type="text" name="txt_advancesince" size="12"
					maxlength="10" tabindex="22" onBlur="checkDate(this)"
					value="<%=Helper.correctNull((String)hshValues.get("advancesince"))%>">
				<a href="#" onClick="callCalender('txt_advancesince')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="2"></a></td>
			</tr>
			<tr>
				<td width="25%">NPA SINCE</td>
				<td><input type="text" name="txt_npasince" size="12"
					maxlength="10" tabindex="22"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')"
					value="<%=Helper.correctNull((String)hshValues.get("npasince"))%>">
				<a href="#" onClick="callCalender('txt_npasince')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="2"></a></td>
			
				<td>SECTOR CODE</td>
				<td><input type="text" name="txt_sector" size="20"
					maxlength="10" tabindex="8" value="<%=Helper.correctNull((String)hshValues.get("sector"))%>">
				</td>
			</tr>
			<tr>
				<td width="25%">WHETHER ACCOUNT IS CLASSIFIED AS FRAUD</td>
				<td colspan="2"><select name="sel_fraud" tabindex="9">
					<option value="0" selected>----Select----</option>
					<option value="1">YES</option>
					<option value="2">NO</option>
				</select></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td width="25%">WHETHER ACCOUNT IS CLASSIFIED AS WILFULL DEFAULTER</td>
				<td colspan="3"><select name="sel_defaulter" tabindex="10">
					<option value="0" selected>----Select----</option>
					<option value="1">YES</option>
					<option value="2">NO</option>
				</select></td>
			</tr>
			<tr>
				<td width="25%">ECGC/CGFT/DICGC CLAIM SETTLED</td>
				<td><select name="sel_ecgc" onChange="showECGC()"
					tabindex="11">
					<option value="0" selected>----Select----</option>
					<option value="1">YES</option>
					<option value="2">NO</option>
				</select></td>
				<td id="ecgc1"  colspan="2">&nbsp; <input type="text"
					name="txt_excessdate" size="15" maxlength="10" tabindex="12"
					value="<%=Helper.correctNull((String)hshValues.get("sinceexcess"))%>"
					onBlur="checkDate(this)"> <a href="#"
					onClick="callCalender('txt_excessdate')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="12"></a></td>
			</tr>
			<tr>
				<td width="25%">WHETHER ACCOUNT IS PRUDENTIALLY WRITTEN OFF :</td>
				<td colspan="3"><select name="sel_pwo" tabindex="13">
					<option value="0" selected="selected">----Select----</option>
					<option value="1">YES</option>
					<option value="2">NO</option>
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
 <br>
 <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 <br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDataFlag" value="<%=Helper.correctNull((String)hshValues.get("recordFlag"))%>">
</form>
</body>
</html>
