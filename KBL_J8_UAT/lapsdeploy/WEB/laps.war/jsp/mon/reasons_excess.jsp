<%@include file="../share/directives.jsp"%>
<%	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();	
	arrRow = ((ArrayList)hshValues.get("arrRow"));%>
<html>
<head>
<title>Reasons for Excess</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var renewalcompiled = "<%=Helper.correctNull((String)hshValues.get("renewalcompiled"))%>";
var varorglevel="<%=strOrgLevel%>";

function placevalues()
{
	disableFields(true);
	if(renewalcompiled!="")
	{
		document.forms[0].renewalcompiled.value=renewalcompiled;
	}
	else
	{
			document.forms[0].renewalcompiled.value="S";
	}
	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdcancel.disabled=true;
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}
	
	renewalCompiled();
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmddelete.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	for(var i=0;i<document.forms[0].txt_facility.length;i++)
	{
		document.forms[0].txt_facility[i].readOnly=true;
	}		
}
function doSave()
{	
	for(i=0;i<document.forms[0].txt_facility.length;i++)
	{		
		var varfacility = document.forms[0].txt_facility[i].value;
		var varexcessmonth= document.forms[0].txt_excessmonth[i].value;
		var varcurrentmonth= document.forms[0].txt_excesscurrent[i].value;		
		if(varfacility!="" ||varexcessmonth!="" ||  varcurrentmonth!="")
		{
			if(varfacility=="")
			{
				alert("Please enter Facility");
				document.forms[0].txt_facility[i].focus();
				return;
			}			
			if(varexcessmonth=="")
			{
				alert("Please enter During the month");
				document.forms[0].txt_excessmonth[i].focus();
				return;
			}			
			if(varcurrentmonth=="")
			{
				alert("Please enter From 1st April till current month");
				document.forms[0].txt_excesscurrent[i].focus();
				return;
			}
		}		
	}
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/reasons_excess.jsp";
	document.forms[0].hidBeanMethod.value="updateReasonsExcessData";
	document.forms[0].hidBeanGetMethod.value="getReasonsExcessData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="/action/reasons_excess.jsp";
		document.forms[0].hidBeanMethod.value="updateReasonsExcessData";
		document.forms[0].hidBeanGetMethod.value="getReasonsExcessData";	
		document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(101))
	{			
		document.forms[0].hidAction.value="";
		document.forms[0].action=appURL+"action/reasons_excess.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="reasons_excess.jsp";
		document.forms[0].hidBeanGetMethod.value="getReasonsExcessData";	
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
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
	}
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
			document.forms[0].elements[i].readOnly=val;
		}		
	}	
}

function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal(appURL,fname);
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

function renewalCompiled()
{
	if(document.forms[0].renewalcompiled.value=='Y')
	{
		document.all.l1.style.display="block";
		document.all.l3.style.display="block";
		document.all.l2.style.display="none";
		document.all.l4.style.display="none";
		document.forms[0].ren_submitted_reasons.value="";
	}
	else if(document.forms[0].renewalcompiled.value=='N')
	{
		
		document.all.l1.style.display="none";
		document.all.l3.style.display="none";
		document.all.l2.style.display="block";
		document.all.l4.style.display="block";
		document.forms[0].ren_submitted.value="";
	}
	else
	{
		document.all.l1.style.display="none";
		document.all.l3.style.display="none";
		document.all.l2.style.display="none";
		document.all.l4.style.display="none";
		document.forms[0].ren_submitted_reasons.value="";
		document.forms[0].ren_submitted.value="";
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="form1" method="post" action="" class="normal">
						<lapschoice:monthlymonitortag pageid="1"/>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>            
      <td class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt; Reasons for excess</td>
          </tr>
        </table>
		<lapschoice:MonthlyMonitor />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr> 
    	<td width="50%" valign="bottom">         	
        <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td width="20%" class="sub_tab_inactive"><b><a href="javascript:callLink('mon_facilitiesenjoyed.jsp','mmrcommon','getMMRFacility')">Facilities Enjoyed </a></b></td>
            <td width="20%" id="action" class="sub_tab_active"><b>Reasons for excess</b></td>
            <td width="20%" id="action" class="sub_tab_inactive"><b><a href="javascript:callLink('monannexurefacilities.jsp','mmrcommon','getAnnexureFacility')">Annexure</a></b></td>
          </tr>
        </table>
      	</td>
    </tr>
</table><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr align="center"> 
      <td colspan="4">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr align="center" class="dataheader"> 
      <td colspan="4"><b>&nbsp;Reasons 
        for excess / overdue / irregular amount, whether reported to and ratified 
        by higher office and steps initiated for adjustment to be furnished.</b></td>
    </tr>
    <tr align="center" class="datagrid"> 
      <td colspan="4"> 
        <textarea name="reason_excess" rows="5" cols="180" tabindex="1" onKeyDown="textlimit(this,'3999')" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("downgradereason"))%></textarea>
      </td>
    </tr>
    <tr align="center" colspan="4" class="dataheader"> 
      <td colspan="4"><b>&nbsp;Date 
        of commencement of first instalment should be invariably reported in TL 
        accounts where repayment not yet started. </b></td>
    </tr>
    <tr align="center" class="datagrid"> 
      <td colspan="4"> 
        <textarea name="reason_commencement" rows="5" cols="180" tabindex="2" onKeyDown="textlimit(this,'3999')" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("downgradecommencement"))%></textarea>
      </td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td width="32%"><br>
        <b>If due for renewal, whether renewal proposal submitted </b></td>
      <td width="17%">&nbsp; 
        <select name="renewalcompiled" onChange="renewalCompiled()" tabindex="3">
          <option value="S" selected>&lt;---Select---&gt;</option>
          <option value="Y">Yes</option>
          <option value="N">No</option>
        </select>
      </td>
      <td width="15%" >&nbsp; 
        <div id="l1"><b>date on which submitted</b></div>
        <div id="l2"> <b>the reasons for non submission </b></div>
      </td>
       <td width="36%"> &nbsp; 
        <div id="l3"> 
          <input type="text" name="ren_submitted" size="15" 
                                            maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("ren_submitted")) %>"
                                            onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')" tabindex="4">
          <a alt="Select date from calender" href="#"
																	onClick="callCalender('ren_submitted')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
        </div>
        <div id="l4"> 
          <textarea name="ren_submitted_reasons" rows="2" cols="40" tabindex="4"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("ren_submitted_reasons"))%></textarea>
        </div>
      </td>
    </tr>
    <%if(Helper.correctNull((String)hshValues.get("checkString")).equals("y"))
	{%>
    <tr align="center" class="datagrid"> 
      <td height="35" width="32%"><b>Reason for not adequate charges 
        stipulated are registered with ROC </b></td>
      <td width="17%" height="35"> 
        <textarea name="roc_reasons" rows="2" cols="40" tabindex="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("roc_reasons"))%></textarea>
      </td>
      <td width="15%" height="35">&nbsp;</td>
      <td width="36%" height="35">&nbsp;</td>
    </tr>
    <%}%>
	 <tr align="center"> 
	 
	 <td colspan="4">
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
          <tr class="dataheader"> 
            <td colspan="3"><b>No.of days account remained in excess</b></td>
          </tr>
          <tr class="dataheader"> 
            <td width="32%"><b>Facility</b></td>
            <td width="25%"><b>During the month</b></td>
            <td width="43%"><b>From 1st April till current month</b></td>
          </tr>
          <%if(arrRow!=null)
			{
				int j = 5;
				for(int i =0;i<arrRow.size();i++)
				{	
					arrCol = (ArrayList) arrRow.get(i);
					
					 %>
				  <tr class="datagrid"> 
					<td width="32%"> 
					  <input type="text" name="txt_facility" tabindex="<%=++j%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>" size="50" maxlength="10">
					</td>
					<td width="25%"> 
					  <input type="text" name="txt_excessmonth" tabindex="<%=++j%>" value='<%=Helper.correctNull((String)arrCol.get(1))%>'  size="16" maxlength="12" onKeyPress="allowInteger()">
					</td>
					<td width="43%"> 
					  <input type="text" name="txt_excesscurrent" tabindex="<%=++j%>" value='<%=Helper.correctNull((String)arrCol.get(2))%>'  size="16" maxlength="12" onKeyPress="allowInteger()">
					</td>
				  </tr>
				  <%}} %>
        </table>
</td>
	 </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="auditflag" value="<%=Helper.correctNull((String)hshValues.get("audit_flag")) %>">
</form>
</body>
</html>
