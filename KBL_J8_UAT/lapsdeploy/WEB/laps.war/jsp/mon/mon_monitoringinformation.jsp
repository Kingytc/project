<%@include file="../share/directives.jsp"%>
<%java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);

			%>

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
	<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";

var monitinfgovtpolicy="<%=Helper.correctNull((String)hshValues.get("mon_monitinfgovtpolicy"))%>";
var monitinfqpr="<%=Helper.correctNull((String)hshValues.get("mon_monitinfqpr"))%>";
var monitinfpenalinterst="<%=Helper.correctNull((String)hshValues.get("mon_monitinfpenalinterst"))%>";
var infocolenders="<%=Helper.correctNull((String)hshValues.get("mmr_infocolenders"))%>";
var monitinfrectification="<%=Helper.correctNull((String)hshValues.get("mon_monitinfrectification"))%>";
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
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }


function onLoading()
{
if(monitinfgovtpolicy!=="")
	{
	  document.forms[0].sel_govtpolicy.value=monitinfgovtpolicy;	
	}
	else
	{
		document.forms[0].sel_govtpolicy.value='0'
	}
if(monitinfqpr!=="")
	{
	  document.forms[0].sel_qpr.value=monitinfqpr;	
	}
	else
	{
		document.forms[0].sel_qpr.value='0'
	}
if(monitinfpenalinterst!=="")
	{
	  document.forms[0].sel_penalinterst.value=monitinfpenalinterst;	
	}
	else
	{
		document.forms[0].sel_penalinterst.value='0'
	}
if(infocolenders!=="")
	{
	  document.forms[0].sel_ledgeroperation.value=infocolenders;	
	}
	else
	{
		document.forms[0].sel_ledgeroperation.value='0'
	}
if(monitinfrectification!=="")
	{
	  document.forms[0].sel_rectification.value=monitinfrectification;	
	}
	else
	{
		document.forms[0].sel_rectification.value='0'
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
	//disableCommandButtons("load");
	showReason();
	showLegal();
	
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updateMonitoringInformation";
		document.forms[0].hidBeanGetMethod.value="getMonitoringInformation";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_monitoringinformation.jsp";	
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
		document.forms[0].hidSourceUrl.value="mon_monitoringinformation.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getMonitoringInformation";
		document.forms[0].action=appURL+"action/mon_monitoringinformation.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	   document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updateMonitoringInformation";
		document.forms[0].hidBeanGetMethod.value="getMonitoringInformation";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/mon_monitoringinformation.jsp";
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
		if(document.forms[0].elements[i].type=='textarea') {
		
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
function showLegal()
{
	if(document.forms[0].sel_govtpolicy.value=='1')
	{
		document.all.l1.style.visibility="visible";
		document.all.l1.style.position="relative";
	}
	else
	{
		document.all.l1.style.visibility="hidden";
		document.all.l1.style.position="absolute";
		document.forms[0].txt_govtpolicyreason.value="";
	}

}
function showReason()
{
		if(document.forms[0].sel_rectification.value=='1')
		{
			document.all.a4.style.visibility="visible";
			document.all.a44.style.visibility="visible";
			document.all.a4.style.position="relative";
			document.all.a44.style.position="relative";
		}
		else
		{
			document.all.a4.style.visibility="hidden";
			document.all.a4.style.position="absolute";
			document.all.a44.style.visibility="hidden";
			document.all.a44.style.position="absolute";
			document.forms[0].txt_rectificationreason.value="";
		}
		
		if(document.forms[0].sel_ledgeroperation.value=='1')
		{
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		document.all.a33.style.visibility="hidden";
		document.all.a33.style.position="absolute";
		document.forms[0].txt_nonsecrutinisereason.value="";
			
		}
		if(document.forms[0].sel_ledgeroperation.value=='2')
		{
		 document.all.a3.style.visibility="visible";
		 document.all.a33.style.visibility="visible";
		 document.all.a3.style.position="relative";  
		 document.all.a33.style.position="relative";	
		}
		if(document.forms[0].sel_ledgeroperation.value=='0')
		{
        document.all.a3.style.visibility="hidden";
        document.all.a3.style.position="absolute";
		document.all.a33.style.visibility="hidden";
		document.all.a33.style.position="absolute";
		document.forms[0].txt_nonsecrutinisereason.value="";
            
			
		}
		
		
		
	if(document.forms[0].sel_qpr.value=='2')
		{
		   for(i=0;i<2;i++)
		   {
			document.all.a2[i].style.visibility="visible";
			document.all.a1[i].style.visibility="visible";
			//document.all.a2[i].style.position="relative";
			//document.all.a1[i].style.position="absolute";
			}
		}
		else if(document.forms[0].sel_qpr.value=='1')
		{
		   for(i=0;i<2;i++)
		   {
			document.all.a2[i].style.visibility="hidden";
			//document.all.a2[i].style.position="absolute";
			document.all.a1[i].style.visibility="hidden";
			//document.all.a1[i].style.position="absolute";
			document.forms[0].txt_penalinterstreason.value="";
			}
		}
		else 
		{
		   for(i=0;i<2;i++)
		   {
			document.all.a2[i].style.visibility="hidden";
			//document.all.a2[i].style.position="absolute";
			document.all.a1[i].style.visibility="hidden";
			//document.all.a1[i].style.position="absolute";
			document.forms[0].txt_penalinterstreason.value="";
			}
		}	
		
		
		
}	




</script>

</head>

<body onload="onLoading()">
<form name="moninfo" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left">
			<tr>
				<td><lapschoice:monthlymonitortag pageid="8" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		
      <td valign="top" colspan=5 class="page_flow">
			Home-&gt; Monitoring-&gt; 
        Monthly Monitoring Reports-&gt;Monitoring Info-&gt;Monitoring Info-2</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
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
				<table width="30%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:MonitoringInfoTag pageid="2"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<br>
<table width="99%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
<tr><td>
<table width="99%" border="0" cellspacing="1" cellpadding="3" class="outertable">
<tr> 
      <td width="1%">7.</td>
      <td >Any labour / legal problems / natural calamities / change 
        in Govt.policy that may affect unit's viability</td>
      <td > 
        <select name="sel_govtpolicy" tabindex="1" onChange="showLegal()">
        <option value="0">--select--</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
      </td>
	  
	  <td width="19%"></td>
      <td  id="l1" width="44%"> 
        <textarea rows="4" name="txt_govtpolicyreason" cols="55" tabindex="2"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mon_monitinfgovtpolicyrson"))%></textarea>
  </tr>
  
<tr> 
      <td width="1%">8.</td>
      <td>Whether submission of Monthly / Quarterly statements / data 
        such as Stock / Book Bebt statements MSOD / QPRs etc is regular?</td>
      <td width="10%"> 
        <select name="sel_qpr"  tabindex="3" onChange="showReason();">
        <option value="0">--select--</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
      </td>
  </tr>
	<tr> 
      <td width="1%"></td>
      <td width="26%" id="a2">Whether penal interest recovered?</td>
      <td width="10%" id="a2"> 
        <select name="sel_penalinterst" tabindex="4">
        <option value="0">--select--</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
    </td>
	  <td width="19%" id="a1"> Reasons for non-charging of penal interest</td>
      <td width="44%" id="a1"> 
        <textarea rows="4" name="txt_penalinterstreason" cols="55" tabindex="5"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mon_monitinfpenalinterstrson"))%></textarea>
  </tr>
  
  <tr> 
      <td width="1%"></td>
      <td width="26%"> </td>
      <td width="10%"> </td>
  </tr>
  
  <tr> 
      <td width="1%">9.</td>
      <td width="26%">Whether ledger operations are scrutinized by nominated Officer?</td>
      <td width="10%"> 
        <select name="sel_ledgeroperation"  tabindex="6" onChange="showReason();">
        <option value="0">--select--</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
     </td>
	   
      <td width="19%" id="a33">Reasons for non-scrutinized by nominated Officer</td>
      <td width="44%" id="a3"> 
        <textarea rows="4" name="txt_nonsecrutinisereason" cols="55" tabindex="7" 
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mon_monitinfnonsecrutiniserson"))%></textarea>
  </tr>
  <tr> 
      <td width="1%">&nbsp;</td>
      <td width="26%">Any adverse feature observed and action initiated for rectification</td>
      <td width="10%"> 
        <select name="sel_rectification" tabindex="6" onChange="showReason();">
        <option value="0">--select--</option>
        <option value="1">Yes</option>
        <option value="2">No</option>
      </select>
      </td>
	    
      <td width="19%" id="a44">Action initiated for rectification</td>
      <td width="44%" id="a4"> 
        <textarea rows="4" name="txt_rectificationreason" cols="55" tabindex="7"
					onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("mon_monitinfrectificationrson"))%></textarea>
  </tr>
		</table>
		</td>
		</tr>
		</table>
		<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 	
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno" >
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
</form>
</body>
</html>

