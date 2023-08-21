<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<html>
<head>
<title>Document Recovered</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varorglevel="<%=strOrgLevel%>";
function placevalues()
{
	disableFields(true);
	if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
	{
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].txt_inlandtota1.readOnly=true;
	document.forms[0].txt_foreigntotal.readOnly=true;		
}
function doSave()
{
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_recovered.jsp";
	document.forms[0].hidBeanMethod.value="updateRecoveredStatement";
	document.forms[0].hidBeanGetMethod.value="getRecoveredStatement";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getRecoveredStatement";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_recovered.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_recovered.jsp";
	document.forms[0].hidBeanMethod.value="updateRecoveredStatement";
	document.forms[0].hidBeanGetMethod.value="getRecoveredStatement";	
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
	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		document.forms[0].txt_monworkmonth.readOnly=true;
		document.forms[0].txt_montermmonth.readOnly=true;
		document.forms[0].txt_montermins.readOnly=true;
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
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}
function addInlandTotal()
{
	var txt_inlandthreemonth = document.forms[0].txt_inlandthreemonth.value;
	var txt_inlandsixmonth = document.forms[0].txt_inlandsixmonth.value;
	var txt_inlandmorethansixmonth = document.forms[0].txt_inlandmorethansixmonth.value;	
	if(txt_inlandthreemonth=="")
		txt_inlandthreemonth = "0.00";
	if(txt_inlandsixmonth=="")
		txt_inlandsixmonth = "0.00";
	if(txt_inlandmorethansixmonth=="")
		txt_inlandmorethansixmonth = "0.00";		
	var totalInland = 	eval(txt_inlandthreemonth) + eval(txt_inlandsixmonth)+eval(txt_inlandmorethansixmonth);	
	document.forms[0].txt_inlandtota1.value = totalInland;		
}
function addForeignTotal()
{
	var txt_inlandthreemonth = document.forms[0].txt_foreignthreemonth.value;
	var txt_inlandsixmonth = document.forms[0].txt_foreignsixmonth.value;
	var txt_inlandmorethansixmonth = document.forms[0].txt_foreignmorethansixmonth.value;	
	if(txt_inlandthreemonth=="")
		txt_inlandthreemonth = "0.00";
	if(txt_inlandsixmonth=="")
		txt_inlandsixmonth = "0.00";
	if(txt_inlandmorethansixmonth=="")
		txt_inlandmorethansixmonth = "0.00";		
	var totalInland = 	eval(txt_inlandthreemonth) + eval(txt_inlandsixmonth)+eval(txt_inlandmorethansixmonth);	
	document.forms[0].txt_foreigntotal.value = totalInland;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="frmstock" method="post" class="normal">
<lapschoice:monthlymonitortag pageid="3" />
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>				
            <td class="page_flow">Home -&gt; Monitoring -&gt; Monthly Monitoring Reports -&gt; Int/Inst Recovered</td>
			</tr>
		</table>
		</td>
		</tr>
		</table>
		<lapschoice:MonthlyMonitor />
		<br>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top"> 						
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td width="24%">&nbsp;</td>
                        <td width="8%">&nbsp; </td>
                        <td width="11%">&nbsp; </td>
                        <td  colspan="2">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td  width="24%">Interest on working 
                          capital recovered upto</td>
                        <td  width="8%"> 
                          <input type="text"  name="txt_monworkmonth" tabindex="1" size="12" value="<%=Helper.correctNull((String)hshValues.get("mon_recworkmonth"))%>" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                        </td>
                        <td width="11%"><a href="#" onClick="callCalender('txt_monworkmonth')"
											title="Click to view calender" border="0"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="7"></a></td>
                        <td width="23%"> Quantify arrears if any<font align="right"> 
                          </font></td>
                        <td  colspan="2" width="34%"> 
                          Rs. <lapschoice:CurrencyTag  name="txt_monworkvalue" tabindex="2" value='<%=Helper.correctNull((String)hshValues.get("mon_recworkvalue"))%>' maxlength="10"/> 
                        </td>
                      </tr>
                      <tr> 
                        <td  width="24%">Interest on Term Loan recovered 
                          upto</td>
                        <td  width="8%"> 
                          <input type="text"name="txt_montermmonth" tabindex="3" size="12"  value="<%=Helper.correctNull((String)hshValues.get("mon_rectermmonth"))%>" maxlength="3" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                        </td>
                        <td width="11%"><a href="#" onClick="callCalender('txt_montermmonth')"
											title="Click to view calender" border="0"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="7"></a></td>
                        <td width="23%">Quantify arrears if any</td>
                        <td  width="34%"colspan="2"> Rs. <lapschoice:CurrencyTag name="txt_montermvalue" tabindex="4" value='<%=Helper.correctNull((String)hshValues.get("mon_rectermvalue"))%>' maxlength="15"/> 
                        </td>
                      </tr>
                      <tr> 
                        <td  width="24%">Term Loan installments recovered 
                          upto</td>
                        <td  width="8%"> 
                          <input type="text"name="txt_montermins" tabindex="5" size="12"  value="<%=Helper.correctNull((String)hshValues.get("mon_rectermins"))%>" maxlength="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)">
                        </td>
                        <td width="11%"><a href="#" onClick="callCalender('txt_montermins')"
											title="Click to view calender" border="0"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											width="0" border="0" tabindex="7"></a></td>
                        <td width="23%"> Quantify arrears if any </td>
                        <td  width="34%"colspan="2"> Rs. <lapschoice:CurrencyTag name="txt_monterminsvalue" tabindex="6" value='<%=Helper.correctNull((String)hshValues.get("mon_recterminsvalue")) %>' maxlength="15"/> 
                        </td>
                      </tr>
                      <tr> 
                        <td  colspan="5"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                            <tr class="dataheader"> 
                              <td colspan="3"><b>Age-wise break up of overdue bills </b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="32%"><b>Period</b></td>
                              <td width="25%"><b>Inland</b></td>
                              <td width="43%"><b>Foreign</b></td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="32%">Up to 3 Months</td>
                              <td width="25%">&nbsp;<lapschoice:CurrencyTag name="txt_inlandthreemonth" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_inlandthreemonth")) %>' maxlength="15" onBlur="addInlandTotal()"/> 
                              </td>
                              <td width="43%">&nbsp;<lapschoice:CurrencyTag name="txt_foreignthreemonth" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_foreignthreemonth")) %>' maxlength="15" onBlur="addForeignTotal()"/></td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="32%">3 Months to 6 Months </td>
                              <td width="25%">&nbsp;<lapschoice:CurrencyTag name="txt_inlandsixmonth" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_inlandsixmonth")) %>' maxlength="15" onBlur="addInlandTotal()"/></td>
                              <td width="43%">&nbsp;<lapschoice:CurrencyTag name="txt_foreignsixmonth" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_foreignsixmonth")) %>' maxlength="15" onBlur="addForeignTotal()"/></td>
                            </tr>
                            <tr class="datagrid"> 
                              <td width="32%">More than 6 Months</td>
                              <td width="25%">&nbsp;<lapschoice:CurrencyTag name="txt_inlandmorethansixmonth" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_inlandmorethansixmonth")) %>' maxlength="15" onBlur="addInlandTotal()"/> 
                              </td>
                              <td width="43%">&nbsp;<lapschoice:CurrencyTag name="txt_foreignmorethansixmonth" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_foreignmorethansixmonth")) %>' maxlength="15" onBlur="addForeignTotal()"/> 
                              </td>
                            </tr>
                            <tr class="dataheader"> 
                              <td width="32%">Total</td>
                              <td width="25%">&nbsp;<lapschoice:CurrencyTag name="txt_inlandtota1" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_inlandtotal")) %>' maxlength="15"/></td>
                              <td width="43%">&nbsp;<lapschoice:CurrencyTag name="txt_foreigntotal" tabindex="7" value='<%=Helper.correctNull((String)hshValues.get("mon_foreigntotal")) %>' maxlength="15"/></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td  width="24%">&nbsp;</td>
                        <td  width="8%">&nbsp;</td>
                        <td  width="11%"></td>
                        <td  width="23%">&nbsp;</td>
                        <td width="34%">&nbsp;</td>
                      </tr>
                    </table>
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
