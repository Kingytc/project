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
function showworkstatus()
{
	if(document.forms[0].sel_unit.value=="1")
	{
		document.forms[0].date_unitrunning.value="";
		document.all.close.style.visibility="hidden";
		document.all.close.style.position="absolute";
		document.all.status.style.visibility="visible";
	}
	else if(document.forms[0].sel_unit.value=="2")
	{
		document.all.close.style.visibility="visible";
		document.all.close.style.position="relative";
		document.forms[0].sel_working.value="0";
		document.all.status.style.visibility="hidden";
	}
	else
	{
		document.forms[0].sel_working.value="0";
		document.all.status.style.visibility="hidden";
		document.forms[0].date_unitrunning.value="";
		document.all.close.style.visibility="hidden";
		document.all.close.style.position="absolute";
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_history.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateprudentialpage2Data";
		document.forms[0].hidBeanGetMethod.value="getprudentialpage2Data";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
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

function onLoading()
{
	//disableCommandButtons("load");
	disableFields(true);
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
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getprudentialpage2Data";
		document.forms[0].action=appURL +"action/prudential_history.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	document.forms[0].hidSourceUrl.value="/action/prudential_history.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updateprudentialpage2Data";
	document.forms[0].hidBeanGetMethod.value="getprudentialpage2Data";
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
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
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
		document.forms[0].action=appURL+"action/"+"npa_mainlinknav.jsp";
		document.forms[0].submit();
	}
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
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
<form name="prudential_history" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="left">
			<tr>
				<td><lapstab:pwourltag pageid="2" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Prudential
				Write Off -&gt;History</td>
			</tr>
			<tr>
				<td><laps:npaapplication /> <INPUT type="hidden" name="npa_appno"
					value="<%=(String)request.getParameter("npa_appno")%>" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td width="25%">DATE OF LAST REVIEW / ENHANCEMENT</td>
						<td width="25%">
						<table width="22%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td><input type="text" name="lastreview_date" size="12"
									tabindex="7" maxlength="10"
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')"
									value="<%=Helper.correctNull((String)hshValues.get("lastreview_date"))%>">
								</td>
								<td><a href="#" onClick="callCalender('lastreview_date')"
									title="Click to view calender" border=0> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="7"></a></td>
							</tr>
						</table>
						</td>
						<td colspan="2">DATE OF LAST INSPECTION</td>
						<td>
						<table width="22%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td><input type="text" name="lastinspection_date" size="12"
									tabindex="8" maxlength="10"
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')"
									value="<%=Helper.correctNull((String)hshValues.get("lastinspection_date"))%>">
								</td>
								<td><a href="#" onClick="callCalender('lastinspection_date')"
									title="Click to view calender" border=0> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="8"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="25%">DATE WHEN SUIT FILED</td>
						<td width="25%">
						<table width="22%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td><input type="text" name="suit_date" size="12" maxlength="10"
									tabindex="9"
									value="<%=Helper.correctNull((String)hshValues.get("suit_date"))%>"
									onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
								</td>
								<td><a href="#" onClick="callCalender('suit_date')"
									title="Click to view calender" border=0> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="9"></a></td>
							<tr>
						</table>
						</td>
						<td>AMOUNT OF SUIT FILED</td>
						<td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
						<td><laps:CurrencyTag name="suit_amt" size="20" maxlength="15"
							tabindex="10"
							value='<%=Helper.correctNull((String)hshValues.get("suit_amt"))%>' />
						</td>
					</tr>
					<tr>
						<td>POSITION OF THE SUIT</td>
						<td><textarea rows="5" cols="35" name="txt_suitposition"
							tabindex="11" onKeyPress="textlimit(this,250)"><%=Helper.correctNull((String) hshValues
									.get("suitposition"))%></textarea>
						</td>
						<td colspan="2">FAVOURABLE POINTS MENTIONED BY RECOMMENDING
						AUTHORITY AT THE TIME OF REVIEW/RENEWAL</td>
						<td><textarea rows="5" cols="35" name="txt_enhancement"
							tabindex="12" onKeyPress="textlimit(this,249)" onKeyUp="textlimit(this,249)"><%=Helper.correctNull((String) hshValues
							.get("txt_enhancements"))%></textarea>
						</td>
					</tr>
					<tr>
						<td width="25%">PROSPECTS OF RECOVERY</td>
						<td width="25%"><textarea rows="5" cols="35" name="txt_prospects"
							tabindex="13" onKeyPress="textlimit(this,299)"  onKeyUp="textlimit(this,299)"><%=Helper.correctNull((String) hshValues.get("prospects"))%></textarea>
						</td>
						<td colspan="2"><br>

						</td>
						<td></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trial"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'
	 /> <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidclaimsettled" value="<%=Helper.correctNull((String)hshValues.get("DICGC_settled"))%>" />
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>
