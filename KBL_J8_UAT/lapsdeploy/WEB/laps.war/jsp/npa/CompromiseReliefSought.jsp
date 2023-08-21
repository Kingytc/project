<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
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
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{	
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidSourceUrl.value="/action/CompromiseReliefSought.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateCompromiseReliefSought";
		document.forms[0].hidBeanGetMethod.value="getCompromiseReliefSought";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 
	}
}


function onLoading()
{
	disableFields(true);
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	document.forms[0].ledger_date.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/CompromiseReliefSought.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getCompromiseReliefSought";
		document.forms[0].hidBeanMethod.value="getCompromiseReliefSought";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	
	disableCommandButtons("load");
}

function doSave()
	{
	document.forms[0].hidSourceUrl.value="/action/CompromiseReliefSought.jsp";
	document.forms[0].hidBeanId.value="npa";
	document.forms[0].hidBeanMethod.value="updateCompromiseReliefSought";
	document.forms[0].hidBeanGetMethod.value="getCompromiseReliefSought";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	}

function disableFields(val)
{
	for(var i=1;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=true;
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

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}

</script>


<body onload="onLoading()">
<form name="proposalpage3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			 class="outertable">
		<tr>
			<td>
				<lapstab:otscourltag pageid="10"/>
			</td>
	</tr>
	 <tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA -&gt; Compromise Proposal -&gt; Relief Sought
			</td>
	</tr>
</table>
</td>
	</tr>
</table>
<lapschoice:npaapplication /><INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />

<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
  <tr> 
    <td valign="top">
      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr> 
          <td colspan="2"><b><U>RELIEF SOUGHT:</u></b></td>
        </tr>
        <tr> 
          <td align="right"><b>Rs.</b></td>
          <td align="right">&nbsp;</td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <table width="69%" border="1" cellspacing="0" cellpadding="3" align="center" class="outertable">
              <tr> 
                <td width="46%">&nbsp;</td>
                <td width="29%">As per contractual rates</td>
                <td width="25%">As per Notional rate</td>
              </tr>
              <tr> 
                <td width="46%"> 
                <ul>
                  <li>Running Ledger as on 
                    <input type="text" name="ledger_date" size="15"
				maxlength="10" tabindex="1" 
				value="<%=Helper.correctNull((String)hshValues.get("npa_runningledgerdate"))%>">
                    <a href="#" onClick="callCalender('ledger_date')"
				title="Click to view calender" border=0> <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="1"></a></li></ul>
                </td>
                <td width="29%"> 
                  <input type="text" name="txt_runningledger1"  onKeyPress="allowInteger()" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("runningoutstanding"))))%>" tabindex="2">
                </td>
                <td width="25%"> 
                  <input type="text" name="txt_runningledger2" onKeyPress="allowInteger()" tabindex="3" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("runningoutstanding"))))%>">
                </td>
              </tr>
              <tr> 
                <td width="46%"> 
                  <p><b><u>Less:</U> </b></p>
                </td>
                <td width="29%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="46%">Unrecovered Interest</td>
                <td width="29%"> 
                  <input type="text" name="txt_unrecovered1" tabindex="4"  onKeyPress="allowInteger()" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("unrecoveredint"))))%>">
                </td>
                <td width="25%"> 
                  <input type="text" name="txt_unrecovered2" onKeyPress="allowInteger()" tabindex="5" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("unrecoveredint"))))%>">
                </td>
              </tr>
              <tr> 
                <td width="46%"> 
                  <li> Net Dues</li>
                </td>
                <td width="29%"> 
                  <input type="text" name="txt_netdues1" onKeyPress="allowInteger()" tabindex="6" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("netdues"))))%>">
                </td>
                <td width="25%"> 
                  <input type="text" name="txt_netdues2"  onKeyPress="allowInteger()" tabindex="7" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("netdues"))))%>">
                </td>
              </tr>
              <tr> 
                <td width="46%"><b><u>Add:<br>
                  </U></b> </td>
                <td width="29%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="46%"> Unapplied Interest (Dummmy Ledger)
				</td>
                <td width="29%"> 
                  <input type="text" name="txt_unappliedinterest1" tabindex="8"  onKeyPress="allowInteger()" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dummyamt"))))%>">
                </td>
                <td width="25%"> 
                  <input type="text" name="txt_unapplied_interest2" onKeyPress="allowInteger()" tabindex="9"  size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totnotionalinterest"))))%>">
                </td>
              </tr>
              <tr> 
                <td width="46%"> Legal Expenses / other Expenses</td>
                <td width="29%"> 
                  <input type="text" name="txt_Legalexpenses1" onKeyPress="allowInteger()" tabindex="10"  size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("legalotrexp"))))%>">
                </td>
                <td width="25%"> 
                  <input type="text" name="txt_Legalexpenses2" onKeyPress="allowInteger()" tabindex="11"  size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("legalotrexp"))))%>">
                </td>
              </tr>
              <tr> 
                <td width="46%"> 
                  <li> TOTAL DUES (A)</li>
                </td>
                <td width="29%"> 
                  <input type="text" name="txt_Totaldues1" onKeyPress="allowInteger()" tabindex="12" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("Contractualtotdues"))))%>">
                </td>
                <td width="25%"> 
                  <input type="text" name="txt_Totaldues2" onKeyPress="allowInteger()" size="25" tabindex="13" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("Notionaltotdues"))))%>">
                </td>
              </tr>
              <%
              
              %>
              <tr> 
                <td width="46%"><b><u>Less:</u> <br>
                  </b> Settlement Amount (B) </td>
                <td width="29%"> 
                  <input type="text" name="txt_settlementamt1" onKeyPress="allowInteger()" tabindex="14" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("settlementamt"))))%>">
                </td>
                <td width="25%"> 
                  <input type="text" name="txt_settlementamt2" onKeyPress="allowInteger()" tabindex="15" size="25" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("settlementamt"))))%>">
                </td>
              </tr>
              <tr> 
                <td width="46%"><b>Sacrifice: (A)-(B)</b></td>
                <td width="29%"> 
                  <input type="text" name="txt_sacrifice1" size="25" tabindex="16" onKeyPress="allowInteger()" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("Contractualsacrificeamt"))))%>">
                </td>
                <td width="25%"> 
					  <input type="text" name="txt_sacrifice2" size="25" onKeyPress="allowInteger()" tabindex="17" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("Notionalsacrificeamt"))))%>">
                </td>
              </tr>
              <tr> 
                <td width="46%"><b>Of Which</b></td>
                <td width="29%">&nbsp;</td>
                <td width="25%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="46%">Write-off</td>
                <td width="29%"> 
                  <input type="text" name="txt_writeoff" size="25" onKeyPress="allowInteger()" tabindex="18" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sacrificewriteoff"))))%>">
                </td>
                <td width="25%">&nbsp;  </td>
              </tr>
              <tr> 
                <td width="46%">Waiver of interest</td>
                <td width="29%"> 
                  <input type="text" name="txt_waiver" size="25" onKeyPress="allowInteger()" tabindex="19" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("waiveramt"))))%>">
                </td>
                <td width="25%">&nbsp;  
                 
                </td>
              </tr>
              <tr> 
                <td width="46%">Absorption of Legal / Other Expenses</td>
                <td width="29%"> 
                  <input type="text" name="txt_absorption" size="25" tabindex="20"  onKeyPress="allowInteger()" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("saclegalexpenses"))))%>">
                </td>
                <td width="25%">&nbsp;  </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table><br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
