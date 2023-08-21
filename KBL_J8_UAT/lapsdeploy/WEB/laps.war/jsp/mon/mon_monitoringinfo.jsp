<%@include file="../share/directives.jsp"%>
<%java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
</style>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var infotermscond="<%=Helper.correctNull((String)hshValues.get("mmr_infotermscond"))%>";
var infoprofitabilty="<%=Helper.correctNull((String)hshValues.get("mmr_infoprofitabilty"))%>";
var infocolenders="<%=Helper.correctNull((String)hshValues.get("mmr_infocolenders"))%>";
var infomanageperson="<%=Helper.correctNull((String)hshValues.get("mmr_infomanageperson"))%>";
var varorglevel="<%=strOrgLevel%>";

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
function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	 }
 }	
function onLoading()
{
if(infotermscond!=="")
	{
	  document.forms[0].sel_termscond.value=infotermscond;	
	}
	else
	{
		document.forms[0].sel_termscond.value='0'
	}
if(infoprofitabilty!=="")
	{
	  document.forms[0].sel_profitabilty.value=infoprofitabilty;	
	}
	else
	{
		document.forms[0].sel_profitabilty.value='0'
	}
if(infocolenders!=="")
	{
	  document.forms[0].sel_colenders.value=infocolenders;	
	}
	else
	{
		document.forms[0].sel_colenders.value='0'
	}
	if(infomanageperson!=="")
	{
	  document.forms[0].sel_manageperson.value=infomanageperson;	
	}
	else
	{
		document.forms[0].sel_manageperson.value='0'
	}

	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	else
	{
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	 disableFields(true);
	showReason();	
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateMonitoringInfo";
		document.forms[0].hidBeanGetMethod.value="getMonitoringInfo";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_monitoringinfo.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
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
		document.forms[0].hidSourceUrl.value="mon_monitoringinfo.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getMonitoringInfo";
		document.forms[0].action=appURL +"action/mon_monitoringinfo.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	   document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateMonitoringInfo";
		document.forms[0].hidBeanGetMethod.value="getMonitoringInfo";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/mon_monitoringinfo.jsp";
		document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='textarea')
			{		
			document.forms[0].elements[i].disabled=val;			
		}		 
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();		
	}
}
function callLink(page,bean,method)
{	
	 if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
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
function showReason()
{
		if(document.forms[0].sel_termscond.value=='1')
		{
			document.all.a1.style.visibility="visible";
			document.all.a1.style.position="relative";
		}
		else
		{
			document.all.a1.style.visibility="hidden";
			document.all.a1.style.position="absolute";
			document.forms[0].txt_termreason.value="";
		}
		if(document.forms[0].sel_profitabilty.value=='1')
		{
			document.all.a2.style.visibility="visible";
			document.all.a2.style.position="relative";
		}
		else
		{
			document.all.a2.style.visibility="hidden";
			document.all.a2.style.position="absolute";
			document.forms[0].txt_profitabiltyreason.value="";
		}
		if(document.forms[0].sel_colenders.value=='1')
		{
			document.all.a3.style.visibility="visible";
			document.all.a3.style.position="relative";
		}
		else
		{
			document.all.a3.style.visibility="hidden";
		    document.all.a3.style.position="absolute";
			document.forms[0].txt_colendersreason.value="";
		}
		if(document.forms[0].sel_manageperson.value=='1')
		{
			document.all.a4.style.visibility="visible";
			document.all.a4.style.position="relative";
		}
		else
		{
			document.all.a4.style.visibility="hidden";
			document.all.a4.style.position="absolute";
			document.forms[0].txt_managepersonreason.value="";
		}
}
</script>
</head>
<body onload="onLoading()">
<form name="moninfo" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			 class="outertable">
			<tr>
				<td><lapschoice:monthlymonitortag pageid="8" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		
      <td class="page_flow">Home-&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt; Monitoring Info-&gt;Monitoring Info-1</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			 class="outertable">
			<tr>
				<td><lapschoice:MonthlyMonitor /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="30%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
					<td>
						<lapschoice:MonitoringInfoTag pageid="1"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
    <tr> 
      <td>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr> 
      <td width="5%">1.</td>
      <td width="53%">Terms and conditions not complied if any?</td>
      <td width="42%"> 
        <select name="sel_termscond" tabindex="1" onChange="showReason()">
          <option value="0">--select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
    </tr>
    <tr id="a1"> 
      <td width="5%"></td>
      <td width="53%">Terms and conditions not complied if any(with specific mention 
        about creation / extension of mortgage / charge over Fixed Assets / Current 
        Assets / Collateral Securities / bringing in promoter's contribution etc.</td>
      <td width="42%"> 
        <textarea rows="4" name="txt_termreason" cols="55" tabindex="2"  
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mmr_infotermreason"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="5%">&nbsp;</td>
      <td width="53%">&nbsp;</td>
      <td width="42%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="5%">2</td>
      <td width="53%">Date of latest factory /unit inspection </td>
      <td width="42%"> 
        <input type="text" name="txt_inspectiondate" size="13"
			maxlength="15"
			value="<%=Helper.correctNull((String)hshValues.get("mmr_infoinspectiondate"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
        <a alt="Select date from calender"
											href="#" onClick="callCalender('txt_inspectiondate')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" tabindex="3"
											border=0 alt="Select date from calender" ></a> 
      </td>
    </tr>
    <tr> 
      <td width="5%">3</td>
      <td width="53%"> Adverse feature observed, if any:</td>
      <td width="42%"> 
        <textarea rows="4" name="txt_adversedreason" cols="55" tabindex="4"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mmr_infoadversedreason"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="5%">4.</td>
      <td width="53%">Whether sales/profitability is showing downward trend</td>
      <td width="42%"> 
        <select name="sel_profitabilty" tabindex="5" onChange="showReason()">
          <option value="0">--select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
    </tr>
    <tr id="a2"> 
      <td width="5%">&nbsp;</td>
      <td width="53%">Reasons thereof and corrective action initiated</td>
      <td width="42%"> 
        <textarea rows="4" name="txt_profitabiltyreason" cols="55" tabindex="6"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mmr_infoprofitabiltyreason"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="5%" >&nbsp;</td>
      <td colspan="2" > 
        <table width="100%" class="outertable">
          <tr> 
            <td width="56%">Sales from 1st April upto the previous quarter</td>
            <td width="7%"> 
              <input type="text" name="txt_salesquarter" size="13"
			maxlength="15"
			value="<%=Helper.correctNull((String)hshValues.get("mon_salesquarter"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
            </td>
            <td width="3%"><a alt="Select date from calender"
											href="#" onClick="callCalender('txt_salesquarter')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" tabindex="3"
											border=0 alt="Select date from calender" ></a></td>
            <td width="34%">&nbsp;Rs. <lapschoice:CurrencyTag  name="txt_salesamount"  size="16" maxlength="12" tabindex="2" value='<%=Helper.correctNull((String) hshValues
									.get("mon_salesamount"))%>'/></td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td width="5%">5</td>
      <td width="53%">Any adverse report from the co-lenders/market, about the 
        borrower.</td>
      <td width="42%"> 
        <select name="sel_colenders" tabindex="7" onChange="showReason()">
          <option value="0">--select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
    </tr>
    <tr id="a3"> 
      <td width="5%">&nbsp;</td>
      <td width="53%">Reasons</td>
      <td width="42%"> 
        <textarea rows="4" name="txt_colendersreason" cols="55" tabindex="8"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mmr_infocolendersreason"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td width="5%">6.</td>
      <td width="53%">Any change in the key management persons?</td>
      <td width="42%"> 
        <select name="sel_manageperson" tabindex="9" onChange="showReason()">
          <option value="0">--select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
    </tr>
    <tr id="a4"> 
      <td width="5%">&nbsp;</td>
      <td width="53%">Reasons</td>
      <td width="42%"> 
        <textarea rows="4" name="txt_managepersonreason" cols="55" tabindex="10"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mmr_infomanagepersonreason"))%></textarea>
      </td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
	<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
</form>
</body>
</html>

