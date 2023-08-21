<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%
	String sta_ots =Helper.correctNull((String)hshValues.get("sta_ots"));
	String sta_otspossible =Helper.correctNull((String)hshValues.get("sta_otspossible"));
	
	String apptype=Helper.correctNull((String)request.getParameter("apptype"));
	if(apptype.equalsIgnoreCase(""))
	{
		apptype=Helper.correctNull((String)hshValues.get("apptype"));
	}
	if(apptype.equalsIgnoreCase(""))
	{
		apptype=Helper.correctNull((String)request.getParameter("hidborrowertype"));
	}
	String appname=Helper.correctNull((String)request.getParameter("borrowername"));
	if(appname.equalsIgnoreCase(""))
	{
		appname=Helper.correctNull((String)hshValues.get("borrowername"));
	}

	String cbsid=Helper.correctNull((String)request.getParameter("cbsid"));
	if(cbsid.equalsIgnoreCase(""))
	{
		cbsid=Helper.correctNull((String)hshValues.get("cbsid"));
	}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var sta_ots="<%=sta_ots%>";
var sta_otspossible="<%=sta_otspossible%>";
function dohlpp()
{}
function showproposal()
{
	
	if(document.forms[0].sel_OTS.value=="1")
	{
		document.all.t1.style.visibility="hidden";
		document.all.t1.style.position="absolute";
		document.all.t4.style.visibility="visible";
		document.all.t4.style.position="relative";
		
		document.all.t2.style.visibility="hidden";
		document.all.t2.style.position="absolute";
		document.all.t3.style.visibility="hidden";
		document.all.t3.style.position="absolute";
		showdetails();
		
		document.forms[0].txt_details.value="";
		document.forms[0].txt_measure.value="";
		
		
	}
	else if(document.forms[0].sel_OTS.value=="2")
	{
		document.all.t4.style.visibility="hidden";
		document.all.t4.style.position="absolute";
		document.all.t1.style.visibility="visible";
		document.all.t1.style.position="relative";
		showdetails();
		document.forms[0].txt_sanctiondate.value="";
		document.forms[0].txt_sancauthority.value="";
		document.forms[0].txt_pwoamount.value="";
		document.forms[0].txt_dummyamount.value="";
		document.forms[0].txt_legalcharge.value="";
		document.forms[0].txt_totaldues.value="";
		document.forms[0].txt_settleamount.value="";
		document.forms[0].txt_claimamount.value="";
		document.forms[0].txt_writeoff.value="";
		document.forms[0].txt_waiver.value="";
		document.forms[0].txt_absortionexp.value="";
		document.forms[0].txt_totalrelief.value="";
		document.forms[0].txt_recoveryeffect.value="";
		document.forms[0].txt_balanceeffect.value="";
		document.forms[0].txt_overdue.value="";
		/*document.forms[0].txt_details.value="";
		document.forms[0].txt_measure.value="";*/
		
				
				
	}
	else
	{
		document.all.t4.style.visibility="hidden";
		document.all.t4.style.position="absolute";
		document.all.t1.style.visibility="hidden";
		document.all.t1.style.position="absolute";
		
		document.all.t2.style.visibility="hidden";
		document.all.t2.style.position="absolute";
		document.all.t3.style.visibility="hidden";
		document.all.t3.style.position="absolute";
		
		document.forms[0].txt_sanctiondate.value="";
		document.forms[0].txt_sancauthority.value="";
		document.forms[0].txt_pwoamount.value="";
		document.forms[0].txt_dummyamount.value="";
		document.forms[0].txt_legalcharge.value="";
		document.forms[0].txt_totaldues.value="";
		document.forms[0].txt_settleamount.value="";
		document.forms[0].txt_claimamount.value="";
		document.forms[0].txt_writeoff.value="";
		document.forms[0].txt_waiver.value="";
		document.forms[0].txt_absortionexp.value="";
		document.forms[0].txt_totalrelief.value="";
		document.forms[0].txt_recoveryeffect.value="";
		document.forms[0].txt_balanceeffect.value="";
		document.forms[0].txt_overdue.value="";
		showdetails();
	}
}

function showdetails()
{
	
  if(document.forms[0].sel_otspossible.value=="1" && document.forms[0].sel_OTS.value=="2" )
	{
		document.all.t2.style.visibility="visible";
		document.all.t2.style.position="relative";
		document.all.t3.style.visibility="hidden";
		document.all.t3.style.position="absolute";
		
		document.forms[0].txt_measure.value="";
		
	}
	else if(document.forms[0].sel_otspossible.value=="2" && document.forms[0].sel_OTS.value=="2")
	{
		document.all.t3.style.visibility="visible";
		document.all.t3.style.position="relative";
		document.all.t2.style.visibility="hidden";
		document.all.t2.style.position="absolute";
		
		document.forms[0].txt_details.value="";
		
	}
	else
	{
		document.all.t2.style.visibility="hidden";
		document.all.t2.style.position="absolute";
		document.all.t3.style.visibility="hidden";
		document.all.t3.style.position="absolute";
		
		document.forms[0].txt_details.value="";
		document.forms[0].txt_measure.value="";
		
	}
}
function onloading()
{
	if(sta_ots!="")
	{
		document.forms[0].sel_OTS.value=sta_ots;
	}
	else
	{
		document.forms[0].sel_OTS.value="0";
	}
	
	if(sta_otspossible!="")
	{
		document.forms[0].sel_otspossible.value=sta_otspossible;
	}
	else
	{
		document.forms[0].sel_otspossible.value="0";
	}
	showproposal();
	showdetails();	
	disableFields(true);
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
		disableFields(true);	 
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
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/npastatusnote_ots.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getStatusnoteOTS";
		document.forms[0].hidBeanMethod.value="getStatusnoteOTS";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	disableCommandButtons("load");
	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	document.forms[0].sel_OTS.focus();	
}
function doSave()
{
	if(document.forms[0].sel_OTS.value=="0")
	{
		alert("Enter Is OTS Approved");
		document.forms[0].sel_OTS.focus();
		return;
	}
	if(document.forms[0].sel_OTS.value=="1")
	{
		if(document.forms[0].txt_sanctiondate.value=="")
		{
			alert("Enter Date of Sanction");
			document.forms[0].txt_sanctiondate.focus()
			return;
		}
		if(document.forms[0].txt_sancauthority.value=="")
		{
			alert("Enter Sanctioning Authority Name");
			document.forms[0].txt_sancauthority.focus()
			return;
		}
		if(document.forms[0].txt_totaldues.value=="")
		{
			alert("Enter the total Dues at the time of Settlement");
			document.forms[0].txt_totaldues.focus()
			return;
		}
		if(document.forms[0].txt_totalrelief.value=="")
		{
			alert("Enter the total Relief Sanctioned at the time of Settlement");
			document.forms[0].txt_totalrelief.focus()
			return;
		}
		if(document.forms[0].txt_balanceeffect.value=="")
		{
			alert("Enter the Balance Recovery");
			document.forms[0].txt_balanceeffect.focus()
			return;
		}
	}
	if(document.forms[0].sel_OTS.value=="2" && document.forms[0].sel_otspossible.value=="0")
	{
		alert("Enter whether OTS Possible");
		document.forms[0].sel_otspossible.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/npastatusnote_ots.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateStatusnoteOTS";
	document.forms[0].hidBeanGetMethod.value="getStatusnoteOTS";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npastatusnote_ots.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateStatusnoteOTS";
		document.forms[0].hidBeanGetMethod.value="getStatusnoteOTS";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
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
 function doClose()
 {
 if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();
		
	}
}	
</script>
</head>

<body  onload="onloading()">
<form name="form1" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapstab:staturltag pageid="7"/>
					</td>
				</tr>
				 <tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA-&gt; Status Note -&gt;OTS Comments  
				</td>
          </tr>
			</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=request.getParameter("npa_appno")%>" />
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td width="44%" >Is OTS approved : <span class="mantatory">*</span></td>
      <td width="56%"> 
        <select name="sel_OTS" onchange="showproposal()">
          <option value="0" selected>--select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
    </tr>
    <tr id="t1"> 
      <td width="44%" >Whether OTS possible?<span class="mantatory">*</span></td>
      <td width="56%"> 
        <select name="sel_otspossible" onchange="showdetails()">
          <option value="0" selected>--select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
    </tr>
    <tr id="t2"> 
      <td width="44%">Give Details</td>
      <td width="56%"> 
        <textarea name="txt_details" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sta_details"))%></textarea>
      </td>
    </tr>
    <tr id="t3"> 
      <td width="44%">Give measures suggetsed for resolving</td>
      <td width="56%"> 
        <textarea name="txt_measure" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("sta_measures"))%></textarea>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" id="t4" class="outertable">
    <tr> 
      <td width="44%">Date of Sanction <span class="mantatory">*</span></td>
      <td width="56%"> 
        <input type="text" name="txt_sanctiondate" value="<%=Helper.correctNull((String)hshValues.get("sta_sanctiondate"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
        <a href="#" onClick="callCalender('txt_sanctiondate')"
				title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="23"></a> </td>
    </tr>
    <tr> 
      <td width="44%">Sanctioning Authority <span class="mantatory">*</span></td>
      <td width="56%"> 
        <input type="text" name="txt_sancauthority" maxlength="25" value="<%=Helper.correctNull((String)hshValues.get("sta_sanctionauth"))%>" onKeyPress="notAllowSplChar()">
      </td>
    </tr>
    <tr> 
      <td width="44%">O/s. in R/L including PWO amount if any at the time of settlement</td>
      <td width="56%"> 
       <lapschoice:CurrencyTag name="txt_pwoamount" maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("sta_pwoamount"))%>'/>
      </td>
    </tr>
    <tr> 
      <td width="44%">O/s. in D/L at the time of settlement</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_dummyamount" value='<%=Helper.correctNull((String)hshValues.get("sta_dummyamount"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Legal Charges at the time of settlement</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_legalcharge" value='<%=Helper.correctNull((String)hshValues.get("sta_legalcharge"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Total Dues at the time of settlement <span class="mantatory">*</span></td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_totaldues" value='<%=Helper.correctNull((String)hshValues.get("sta_totaldues"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Claim Settled amount at the time of settlement</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_claimamount" value='<%=Helper.correctNull((String)hshValues.get("sta_claimamount"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Settlement Amount Approved at the time of settlement</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_settleamount" value='<%=Helper.correctNull((String)hshValues.get("sta_settleamount"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Write-off sanctioned at the time of settlement</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_writeoff" value='<%=Helper.correctNull((String)hshValues.get("sta_writeoff"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Waiver sanctioned at the time of settlement</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_waiver" value='<%=Helper.correctNull((String)hshValues.get("sta_waiver"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Absorption of Expenditure at the time of settlement</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_absortionexp" value='<%=Helper.correctNull((String)hshValues.get("sta_absortion"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Total Relief sanctioned at the time os settlement <span class="mantatory">*</span></td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_totalrelief" value='<%=Helper.correctNull((String)hshValues.get("sta_totalrelief"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Recovery effected after sanction</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_recoveryeffect" value='<%=Helper.correctNull((String)hshValues.get("sta_recoveryeffect"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Balance Recovery<span class="mantatory">*</span></td>
      <td width="56%"> 
       <lapschoice:CurrencyTag name="txt_balanceeffect" value='<%=Helper.correctNull((String)hshValues.get("sta_balanceeffect"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td width="44%">Overdue Recovery</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_overdue" value='<%=Helper.correctNull((String)hshValues.get("sta_overdues"))%>' size="20" maxlength="15"/>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp; </td>
    </tr>
  </table>
  <br>
       <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
</form>
</body>
</html>
