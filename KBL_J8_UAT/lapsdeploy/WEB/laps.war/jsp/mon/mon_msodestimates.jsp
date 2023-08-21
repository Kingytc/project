<%@include file="../share/directives.jsp"%>
<%
	String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
	if(!stryear.equalsIgnoreCase(""))
	{
		stryear=Helper.correctNull((String)hshValues.get("mon_year"));
	}
	String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));
	
	if(!strmonth.equalsIgnoreCase(""))
	{
		strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
	}
	String strmsod=Helper.correctNull((String)hshValues.get("mon_checkmsod"));
	String strstock=Helper.correctNull((String)hshValues.get("mon_checkstock"));
	String strbkdebts=Helper.correctNull((String)hshValues.get("mon_checkbkdebts"));
	String strqpr=Helper.correctNull((String)hshValues.get("mon_checkqpr"));
%>
<html>
<head>
<title></title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";



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
	disableCommandButtons("load");
	disableFields(true);
	
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"controllerservlet";		
		document.forms[0].hidBeanMethod.value="updatemsodestimate";
		document.forms[0].hidBeanGetMethod.value="getmsodestimate";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="action/mon_msodestimates.jsp";	
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
		document.forms[0].hidSourceUrl.value="mon_msodestimates.jsp";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanGetMethod.value="getmsodestimate";
		document.forms[0].action=appUrl +"action/mon_msodestimates.jsp";
	    document.forms[0].submit();	
	}	
	
	disableCommandButtons("load");
}
function doSave()
	{
	
	    document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidBeanMethod.value="updatemsodestimate";
		document.forms[0].hidBeanGetMethod.value="getmsodestimate";
		document.forms[0].hidSourceUrl.value="/action/mon_msodestimates.jsp";
		document.forms[0].action=appUrl +"controllerservlet";
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
	}
	document.forms[0].txt_tradingendstock.readOnly=true;
	document.forms[0].txt_accountingyear.readOnly=true;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
		
	}
}
function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="mon_stockstatement.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	else if(url=="mon_workingcapitalfunds.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	else if(url=="mon_accountwisedetails.jsp")
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	
	else
	{
		document.forms[0].hidBeanId.value="mmrcommon";
	}
	document.forms[0].action=appUrl+"action/"+url;
	document.forms[0].submit();
	
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

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
			showCal(appUrl,name);
		}
}

function calltotal()
		{
	        if (document.forms[0].txt_tradingstock.value!="")   
	        {	
			var stock=roundVal(NanNumber(parseFloat(document.forms[0].txt_tradingstock.value)));
			}
			else
			{
			   stock="0.00";
			}
			if(document.forms[0].txt_tradingpurchase.value!="")
			{
			var  purchase=roundVal(NanNumber(parseFloat(document.forms[0].txt_tradingpurchase.value)));
			}
			else
			{
			    purchase="0.00";
			}
			if(document.forms[0].txt_tradingsale.value!="")
			{
			var  sales=roundVal(NanNumber(parseFloat(document.forms[0].txt_tradingsale.value)));
			}
			else
			{
			    sales="0.00";
			}
			var total=Math.round(eval(stock)+eval(purchase)-eval(sales));
			document.forms[0].txt_tradingendstock.value=NanNumber(total);
			roundtxt(document.forms[0].txt_tradingendstock);
		}
</script>

</head>

<body  onload="onLoading()">
<form name="safaeri3" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
			<tr>
				<td><lapschoice:monthlymonitortag pageid="5" /></td>
			</tr>
			<tr>
				<td class="page_flow">Home -&gt; Monitoring-&gt; 
  Monthly Monitoring -&gt;Accountwise Details -&gt;MSOD -&gt;Msod Estimates</td>
			</tr>
		</table><br>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left"  class="outertable">
				<tr>
					<td>
						<lapschoice:MonthlyMonitor />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td valign="bottom"> 
        <table width="60%" border="0" cellspacing="1" cellpadding="3"  class="outertable">
          <tr> 
            <td width="20%"  align="center" class="sub_tab_inactive"  id="prin" ><b><a href="javascript:call_page('mon_accountwisedetails.jsp','getAccountwise')" >Accountwise Details</a></b> </td>
            <%if(Helper.correctNull((String)hshValues.get("mon_checkmsod")).equalsIgnoreCase("y"))
		 				 {%>
            <td width="20%"  align="center" class="sub_tab_active" id="prin"><b>MSOD
               </b></td>
                <%} 
              if( Helper.correctNull((String)hshValues.get("mon_checkqpr")).equalsIgnoreCase("y")){%>
            <td width="20%" class="sub_tab_inactive" align="center"id="prin"><b><a href="javascript:call_page('mon_qprperformance.jsp','getQprPerformance')" >QPR
              </a></b></td>
              <%}
		  %>
          </tr>
        </table>
      </td>
    </tr>
  </table>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:MonMSODTag  msod='<%=strmsod%>' stock='<%=strstock%>' bookdebts='<%=strbkdebts%>' pageid="1"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:Monitor strSource="MMR"/>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   
  <table width="99%" border="0"  align="center" height="452" class="outertable border1">
    <tr> 
    <td width="100%" colspan="4">
        <table  width="98%" height="362" cellspacing="0"
    cellpadding="0" border="0" class="outertable">
          <tr> 
            <td width="3%" ><b>A)</b></td>
            <td colspan="3" ><strong>ESTIMATES for the CURRENT ACCOUNTING 
              YEAR <br>( Commencing from </strong> 
              <input type="text" name="txt_accountingyear" size="20" readOnly value="<%=Helper.correctNull((String) hshValues.get("mon_msodaccountingyear"))%>" onBlur="checkDate(this)">
            <a alt="Select date from calender" href="#"
		onClick="callCalender('txt_accountingyear')"
		onMouseOver="window.status='Date Picker';return true;"
		onMouseOut="window.status='';return true;"><img
		src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
		border=0 alt="Select date from calender" ></a><strong>)
		as indicated in the Annual Balance plan/Quartely information system:</strong></td>
        </tr>
        
        <tr> 
          
            <td height="32" colspan="2" align="middle">a)</td>
            <td width="47%" height="32">Production (Qty in MT /Units)</td>
            <td width="49%" height="32"> <input type="text" name="txt_production" size="16" maxlength="12" onKeyPress="allowInteger()" value="<%=Helper.correctNull((String) hshValues.get("mon_msodproduction"))%>"> 
            </td>
        </tr>
        <tr> 
          
            <td height="28" colspan="2" align="middle">b)</td>
            <td width="47%" height="28">Gross Sales (In lac Rs. )</td>
            <td width="49%" height="28"> <lapschoice:CurrencyTag name="txt_grosssales" size="16" maxlength="12" value='<%=Helper.correctNull((String) hshValues.get("mon_msodgrosssales"))%>'/> 
            </td>
        </tr>
        <tr> 
          
            <td height="31" colspan="2" align="middle">c)</td>
            <td width="47%" height="31">Net Sales ( In lac Rs. )</td>
            <td width="49%" height="31"> <lapschoice:CurrencyTag name="txt_netsales" size="16" maxlength="12" value='<%=Helper.correctNull((String) hshValues.get("mon_msodnetsales"))%>'/> 
            </td>
        </tr>
        <tr> 
            <td width="3%" height="21"><b>B)</b></td>
            <td height="21" colspan="3"><strong>PRODUCTION </strong></td>
        </tr>
        <tr> 
          
            <td height="32" colspan="2" align="middle">a)</td>
            <td width="47%" height="32">During the Month (Qty in MT /Units)</td>
            <td width="49%" height="32"> <input type="text" name="txt_prodqty" size="16" maxlength="12" onKeyPress="allowInteger()" value="<%=Helper.correctNull((String) hshValues.get("mon_msodprodqty"))%>"> 
            </td>
        </tr>
        <tr> 
          
            <td height="31" colspan="2" align="middle">b)</td>
            <td width="47%" height="31">During the current accounting year upto 
              the end of the month(Cummulative-in Qty)</td>
            <td width="49%" height="31"> <lapschoice:CurrencyTag name="txt_prodcurrent" size="16" maxlength="12" value='<%=Helper.correctNull((String) hshValues.get("mon_msodprodcurrent"))%>'/> 
            </td>
        </tr>
        <tr> 
            <td width="3%" height="28"><b>C)</b></td>
            <td height="28" colspan="3"><strong>NET SALES (Excl. Excise duty):</strong></td>
        </tr>
        <tr> 
          
            <td height="33" colspan="2" align="middle">a)</td>
            <td width="47%" height="33">During the Month</td>
            <td width="49%" height="33"> <lapschoice:CurrencyTag name="txt_salesmonth" size="16" maxlength="12" value='<%=Helper.correctNull((String) hshValues.get("mon_msodsalesmonth"))%>'/> 
            </td>
        </tr>
        <tr> 
            <td height="28" colspan="2" align="middle">b)</td>
            <td width="47%" height="28">During the current accounting year upto 
              the end of the month (cummulative- In lac Rs. )</td>
            <td width="49%" height="28"> <lapschoice:CurrencyTag name="txt_salescurrent" size="16" maxlength="12" value='<%=Helper.correctNull((String) hshValues.get("mon_msodsalescurrent"))%>'/> 
            </td>
        </tr>
        <tr> 
            <td width="3%" height="27"><b>D)</b></td>
            <td height="27" colspan="3"><strong>IN CASE OF TRADING ACTIVITIES</strong></td>
        </tr>
        <tr> 
            <td height="25" colspan="2" align="middle">a)</td>
            <td width="47%" height="25">Operating stock at the begining of the 
              month</td>
            <td width="49%" height="25"> <lapschoice:CurrencyTag name="txt_tradingstock" size="16" maxlength="12" onBlur="calltotal()" value='<%=Helper.correctNull((String) hshValues.get("mon_msodtradingstock"))%>' /> 
            </td>
        </tr>
        <tr> 
            <td height="26" colspan="2" align="middle">b)</td>
            <td width="47%" height="26"> Purchase during the month </td>
            <td width="49%" height="26"> <lapschoice:CurrencyTag name="txt_tradingpurchase" size="16" maxlength="12" onBlur="calltotal()" value='<%=Helper.correctNull((String) hshValues.get("mon_msodtradingpurchase"))%>'/> 
            </td>
        </tr>
        <tr> 
            <td height="29" colspan="2" align="middle">c)</td>
            <td width="47%" height="29">Sale during the month</td>
            <td width="49%" height="29"> <lapschoice:CurrencyTag name="txt_tradingsale" size="16" maxlength="12" onBlur="calltotal()" value='<%=Helper.correctNull((String) hshValues.get("mon_msodtradingsale"))%>' /> 
            </td>
        </tr>
        <tr> 
            <td height="21" colspan="2" align="middle">&nbsp;</td>
            <td width="47%" height="21" >Closing Stock at the end of the month.</td>
            <td width="49%" height="21"><lapschoice:CurrencyTag name="txt_tradingendstock" size="16" maxlength="12" onBlur="" value='<%=Helper.correctNull((String) hshValues.get("mon_msodtradingendstock"))%>' /></td>
        </tr>
        
      </table>
    </td>
  </tr>
</table>
    

<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="mon_accno" value="<%=Helper.correctNull((String)request.getParameter("mon_accno")) %>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="mon_msod" value="<%=strmsod%>">
<input type="hidden" name="mon_stock" value="<%=strstock%>">
<input type="hidden" name="mon_bkdebts" value="<%=strbkdebts%>">
<input type="hidden" name="mon_qpr" value="<%=strqpr%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>">
</form>
</body>
</html>
