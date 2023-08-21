<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);

%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var installmentpaid = "<%=Helper.correctNull((String)hshValues.get("tlr_instalmentpaid"))%>";
var intserviced = "<%=Helper.correctNull((String)hshValues.get("tlr_intserviced"))%>";

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

	//disableCommandButtons("load");
	if(installmentpaid != "")
	{
		document.forms[0].sel_installment.value=installmentpaid;
	}
	else
	{
		document.forms[0].sel_installment.value="S";
	}
	if(intserviced != "")
	{
		document.forms[0].sel_interestservice.value=intserviced;
	}
	else
	{
		document.forms[0].sel_interestservice.value="S";
	}
	disableFields(true);
}
function doDelete()
{
	   if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateTLAccountData";
			document.forms[0].hidBeanGetMethod.value="getTLAccountData";
			document.forms[0].hidBeanId.value="reviewtermloantwo";
			document.forms[0].hidSourceUrl.value="action/tlr_opertlaccount.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	if(document.forms[0].reviewOf.value=="")
	{
		alert("Select Review of");
		return;
	}	
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}
function callDescHelp(page)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="tlr_opertlaccount.jsp";
		document.forms[0].hidBeanId.value="reviewtermloantwo";
		document.forms[0].hidBeanGetMethod.value="getTLAccountData";
		document.forms[0].action=appURL +"action/tlr_opertlaccount.jsp";
	    document.forms[0].submit();	
	}	
}
function doSave()
{
	document.forms[0].hidInsReg.value = document.forms[0].sel_installment[document.forms[0].sel_installment.selectedIndex].text;
	document.forms[0].hidIntReg.value = document.forms[0].sel_interestservice[document.forms[0].sel_interestservice.selectedIndex].text;
	    document.forms[0].hidBeanId.value="reviewtermloantwo";
	    document.forms[0].hidBeanMethod.value="updateTLAccountData";
		document.forms[0].hidBeanGetMethod.value="getTLAccountData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/tlr_opertlaccount.jsp";
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
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
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
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].reviewOf.disabled=false;
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}


</script>

</head>

<body onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="8" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt; Operations of Account -&gt; TL Account</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><lapschoice:MonitorReview /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="30%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
			<tr>
				<td width="15%" align="center" class="sub_tab_inactive">
							<b> <a
							href="JavaScript:callOtherLink('tlr_opercdaccount.jsp','reviewtermloantwo','getCDAccountData')"
							>CD Account</a></b> </td>		
				<td width="15%" align="center" class="sub_tab_active">
				<b>TL Account</b></td>	
										
			</tr>
		</table>
		</td>
	</tr>
</table><br>
<table width="90%" border="0" cellspacing="0" cellpadding="1" align="center" class="outertable border1">
<tr align="center">
  <td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
      <tr> 
        <td align="center" width="35%">Date of first disbursal</td>
        <td> 
          <table>
            <tr> 
              <td> 
                <input type="text" name="txt_disbursal" size="12"
							maxlength="10" value="<%=Helper.correctNull((String) hshValues.get("tlr_disbursaldate"))%>"
							onBlur="checkDate(this)">
              </td>
              <td> <a
							alt="Select date from calender" href="#"
							onClick="callCalender('txt_disbursal')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;">&nbsp;<img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
							alt="Select date from calender"></a> </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr> 
        <td align="center">Repayment Schedule</td>
        <td> 
          <textarea name="txt_repayschedule" cols="75" value="" wrap="VIRTUAL" rows="10" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
								.get("tlr_repay"))%></textarea>
        </td>
      </tr>
      <tr> 
        <td align="center">Whether installments 
          are paid regularly?</td>
        <td> 
          <select name="sel_installment">
            <option value="S" selected>&lt;---Select---&gt;</option>
            <option value="1">Yes</option>
            <option value="2">No</option>
            <option value="3">Not Applicable</option>
          </select>
        </td>
      </tr>
      <tr> 
        <td align="center">Whether interest serviced 
          regularly?</td>
        <td> 
          <select name="sel_interestservice">
            <option value="S" selected>&lt;---Select---&gt;</option>
            <option value="1">Yes</option>
            <option value="2">No</option>
            <option value="3">Not Applicable</option>
          </select>
        </td>
      </tr>
 </table> 
 </td>
 </tr>
</table><br>  
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>">
 <input type="hidden" name="hidInsReg">
 <input type="hidden" name="hidIntReg">
 <input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("AuditFlag"))%>">
 </form>
</body>
<script language="javascript1.2">
editor_generate('txt_repayschedule');
</script> 
</html>

