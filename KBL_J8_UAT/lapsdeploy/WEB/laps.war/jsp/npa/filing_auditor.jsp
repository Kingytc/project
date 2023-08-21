<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css" />
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varAudittype="<%=Helper.correctNull((String)hshValues.get("audittype"))%>";


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
function calGetData()
{
	
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
	document.forms[0].hidSourceUrl.value="/action/filing_auditor.jsp"
	document.forms[0].submit();
}

function onLoading()
{
	//disableCommandButtons("load");
	if(varAudittype!="")
	{
		document.forms[0].sel_audittype.value=varAudittype;
	}
	disableFields(true);
}
function doEdit()
{ 	
	if(document.forms[0].sel_audittype.value=="0")
	{
		ShowAlert(111,'Audit Type');
		document.forms[0].sel_audittype.focus();
	}
	else
	{
		disableFields(false);
		document.forms[0].hidAction.value ="insert";
		disableCommandButtons("edit");
		document.forms[0].txt_auditdate.focus();	
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/filing_auditor.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		//document.forms[0].hidBeanMethod.value="updateAuditorsObservation";
		document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}	
	
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/filing_auditor.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateAuditorsObservation";
		document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/filing_auditor.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateAuditorsObservation";
	document.forms[0].hidBeanGetMethod.value="getAuditorsObservation";
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
		 
	}
}
function doClose()
	{
	  if(ConfirmMsg('100'))
		{
		document.forms[0].method="post";	
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
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



function PrintReport()
{		
		var npa_appno=document.forms[0].npa_appno.value;
		var hidmoduletype="SUIT";
		var selPrint="Get";
		var CompanyName="<%=request.getParameter("appname")%>";						
		var purl ="<%=ApplicationParams.getAppUrl()%>action/NPA_statuspage_print.jsp?hidBeanGetMethod=getNPAStatuspagePrint&hidBeanId=npa&npa_appno="+npa_appno+"&borrowername="+CompanyName+"&hidmoduletype="+hidmoduletype+"&cbsid="+document.forms[0].cbsid.value+"&sel_audittype="+document.forms[0].sel_audittype.value+"&selPrint="+selPrint;;
		var prop = 'scrollbars=yes,menubar=yes,width=750,height=520';	
		var xpos = (screen.width - 750) / 2;
		var ypos = (screen.height - 520) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
}		
		

</script>
</head>
<body onload="onLoading();">
<form name="prudential_auditirregularities" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="left">
			<tr>
				<td><lapstab:suiturltag pageid="12" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing Of
				Suit -&gt;Audit Observations</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<laps:npaapplication /> <input type="hidden" name="npa_appno"
	value="<%=(String)request.getParameter("npa_appno")%>" />
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td><b>AUDIT OBSERVATION </b></td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"
							align="LEFT">
							<tr>
								<td width="20%"><font size="1" face="MS Sans Serif">Type</font></td>
								<td width="25%"><select name="sel_audittype" tabindex="3"
									onChange="calGetData()">
									<option value="0" selected>----Select----</option>
									<option value="1">Internal Audit</option>
									<option value="2">Concurrent Audit</option>
									<option value="3">Statutory/RBI Audit</option>
								</select></td>
								<td width="20%">DATE OF AUDIT</td>
								<td width="35%">
								<table width="20%" class="outertable">
									<tr>
										<td><input type="text" name="txt_auditdate" size="12"
											maxlength="10"
											value="<%=Helper.correctNull((String)hshValues.get("auditdate"))%>"
											onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
										</td>
										<td><a href="#" onClick="callCalender('txt_auditdate')"
											title="Click to view calender" border=0> <img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0"> </a></td>
									</tr>
								</table>
								</td>
							<tr>
								<td colspan="4"><b>Auditors
								Observations</b></td>
							</tr>
							<tr>
								<td colspan="4"><textarea name="txt_auditor" cols="100"
									rows="10" wrap="VIRTUAL"
									onKeyPress="textlimit(document.forms[0].txt_auditor,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("auditorscomments"))%></textarea>
								</td>
							</tr>
							<tr>
								<td colspan="4"><b> Branch
								reply / comments</b></td>
							</tr>
							<tr>
								<td colspan="4"><textarea name="txt_officer" cols="100"
									rows="10" wrap="VIRTUAL"
									onKeyPress="textlimit(document.forms[0].txt_officer,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("officercomments"))%></textarea>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> 
<input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)request.getParameter("hidclaimsettled"))%>" />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>