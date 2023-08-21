<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow=new ArrayList();
ArrayList arrCol=null;

String stryear=Helper.correctNull((String)request.getParameter("mon_year"));
if(!stryear.equalsIgnoreCase(""))
{
	stryear=Helper.correctNull((String)hshValues.get("mon_year"));
}
String strmonth=Helper.correctNull((String)request.getParameter("mon_month"));

if(!strmonth.equalsIgnoreCase(""))
{
	strmonth=Helper.correctNull((String)hshValues.get("mon_month"));
}%>
<html>
<head>
<title>Facility Enjoyed</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Stock Statement</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varorglevel="<%=strOrgLevel%>";

function placevalues()
{
	if(document.forms[0].applyflag.value == "1")
	{
		if(document.forms[0].btnenable.value=="Y" && varorglevel=='A')
		{
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdedit.disabled=false;
			document.forms[0].cmdclose.disabled=false;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmddelete.disabled=false;	
		}
		else
		{
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdclose.disabled=false;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmddelete.disabled=true;	
		}
		disableFields(true);
	}
	else
	{
		disableFields(false);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}	
}
function callCalender(obj,chechvalue)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var name="";
			if(chechvalue=="1")
			{
				name = "txt_since["+(document.forms[0].txt_since.length-2)+"]";
			}
			else if(chechvalue=="2")
			{
				name = "txt_since["+(document.forms[0].txt_since.length-1)+"]";
			}
			else
			{
				name = "txt_since["+(document.forms[0].txt_since.length-3)+"]";
			}			
			showCal(appURL,name);
	}
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdclose.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdcancel.disabled=false;	
}
function doSave()
{	
	if(!document.forms[0].txt_facility)
	{
		alert("No Data available for the Customer at this time");
		return;
	}
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_facilitiesenjoyed.jsp";
	document.forms[0].hidBeanMethod.value="updateMMRFacility";
	document.forms[0].hidBeanGetMethod.value="getMMRFacility";
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
	document.forms[0].hidSourceUrl.value="/action/mon_facilitiesenjoyed.jsp";
	document.forms[0].hidBeanMethod.value="updateMMRFacility";
	document.forms[0].hidBeanGetMethod.value="getMMRFacility";	
	document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].hidSourceUrl.value="/action/mon_facilitiesenjoyed.jsp";
		document.forms[0].hidBeanMethod.value="getMMRFacility";
		document.forms[0].hidBeanGetMethod.value="getMMRFacility";	
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
function disableFields(val)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=true;
		}
	}	
	for(var i=document.forms[0].txt_facility.length-1;i>document.forms[0].txt_facility.length-4;i--)
	{
		document.forms[0].txt_sanctionlimit[i].readOnly=val;
		document.forms[0].txt_dp[i].readOnly=val;
		document.forms[0].txt_oustanding[i].readOnly=val;
		document.forms[0].txt_ovedueamount[i].readOnly=val;
		document.forms[0].txt_since[i].readOnly=val;
		document.forms[0].txt_debit[i].readOnly=val;
		document.forms[0].txt_current[i].readOnly=val;
		document.forms[0].txt_cummulative[i].readOnly=val;
		document.forms[0].txt_instalment[i].readOnly=val;
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

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="form1" method="post" action="" class="normal">
						<lapschoice:monthlymonitortag pageid="1"/>					
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>           
      <td class="page_flow">Home -&gt; Monitoring-&gt; Monthly Monitoring Reports-&gt; Facilities Enjoyed</td>
          </tr>
        </table>		
	<lapschoice:MonthlyMonitor />
	<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr> 
    	<td width="50%" valign="bottom">         	
        <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td width="20%" class="sub_tab_active"><b>Facilities Enjoyed</b></td>
            <td  width="20%" id="action" class="sub_tab_inactive"><b><a href="javascript:callLink('reasons_excess.jsp','mmrcommon','getReasonsExcessData')">Reasons for excess </a></b></td>
            <td  width="20%" id="action" class="sub_tab_inactive"><b><a href="javascript:callLink('monannexurefacilities.jsp','mmrcommon','getAnnexureFacility')">Annexure</a></b></td>
          </tr>
        </table>
      	</td>
    </tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
    <tr align="center" class="dataheader"> 
      <td rowspan="3" width="4%">S.no</td>
      <td rowspan="3" width="17%">Nature of facilities</td>
      <td rowspan="3" width="8%">Sanctioned limit (Rs)</td>
      <td rowspan="3" width="7%">D.P (Rs)</td>
      <td rowspan="3" width="11%">O/s as on (Rs)</td>
      <td colspan="2" rowspan="2">Excess / Overdues / irregular amount</td>
      <td colspan="3">Turn over</td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td width="12%">&nbsp;</td>
      <td colspan="2">Credit</td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td width="9%">Amount (Rs)</td>
      <td width="10%">Since When</td>
      <td width="12%">Debit current Month (Rs)</td>
      <td width="9%">Current Month (Rs)</td>
      <td width="13%">Cummulative from 1st April (Rs)</td>
    </tr>
    <%
                     
                  arrRow=(ArrayList)hshValues.get("arrRow");
					if(arrRow!=null && arrRow.size()>0 )
					{
						for(int i=0;i<arrRow.size();i++)
						{
						arrCol = (ArrayList)arrRow.get(i);
						if(arrCol!=null && arrCol.size()>0)
					{
					%>
    <tr align="center" class="datagrid"> 
      <td width="4%"><%=i+1%></td>
      <td width="17%"> 
        <input type="text" name="txt_facility" tabindex="1" value="<%=Helper.correctNull((String)arrCol.get(2))%>" size="30" maxlength="10" >
      </td>
      <td width="8%"> <lapschoice:CurrencyTag name="txt_sanctionlimit" tabindex="2" value='<%=Helper.correctNull((String)arrCol.get(3))%>' size="18" maxlength="15" /> 
      </td>
      <td width="7%"> <lapschoice:CurrencyTag name="txt_dp" tabindex="3" value='<%=Helper.correctNull((String)arrCol.get(4))%>' size="18" maxlength="15" /> 
      </td>
      <td width="11%"> <lapschoice:CurrencyTag name="txt_oustanding" tabindex="4" value='<%=Helper.correctNull((String)arrCol.get(5))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_ovedueamount" tabindex="5" value='<%=Helper.correctNull((String)arrCol.get(6))%>' size="18" maxlength="15" /> 
      </td>
      <td width="10%"> 
        <input type="text" name="txt_since" tabindex="6" value="<%=Helper.correctNull((String)arrCol.get(7))%>" size="18" maxlength="15">
      </td>
      <td width="12%"> <lapschoice:CurrencyTag name="txt_debit" tabindex="7" value='<%=Helper.correctNull((String)arrCol.get(8))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_current" tabindex="8" value='<%=Helper.correctNull((String)arrCol.get(9))%>' size="18" maxlength="15" /> 
      </td>
      <td width="13%"> <lapschoice:CurrencyTag name="txt_cummulative" tabindex="9" value='<%=Helper.correctNull((String)arrCol.get(10))%>' size="18" maxlength="15" /> 
      <input type="hidden" name="txt_instalment" value="<%=Helper.correctNull((String)arrCol.get(11))%>" size="18" maxlength="15">
      </td>
      
    </tr>
    <%}
	}
	}%>
    <tr align="center" class="dataheader"> 
      <td width="4%">&nbsp;</td>
      <td width="17%">Sub - Total</td>
      <td width="8%">&nbsp; <lapschoice:CurrencyTag name="sancttotalamount" tabindex="5" value='<%=Helper.correctNull((String)hshValues.get("sanction_amount"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="7%">&nbsp;</td>
      <td width="8%">&nbsp; <lapschoice:CurrencyTag name="ostotalamount" tabindex="5" value='<%=Helper.correctNull((String)hshValues.get("os_amount"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%">&nbsp;</td>
      <td width="10%">&nbsp;</td>
      <td width="12%">&nbsp;</td>
      <td width="9%">&nbsp;</td>
      <td width="13%">&nbsp;</td>
    </tr>
    <tr class="dataheader"> 
      <td colspan="10"><b>Other Loans</b></td>
    </tr>
    <tr align="center" class="datagrid"> 
      <td width="4%">1)</td>
      <td width="17%"> 
        <input type="hidden" name="txt_facility" tabindex="1" value="BL" size="30" maxlength="10">
        <input type="text" name="txt_facilitycheck" tabindex="1" value="Bullion Loan" size="30" maxlength="20">
      </td>
      <td width="8%"> <lapschoice:CurrencyTag name="txt_sanctionlimit" tabindex="12" value='<%=Helper.correctNull((String)hshValues.get("MMRBL_SANCAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="7%"> <lapschoice:CurrencyTag name="txt_dp" tabindex="13" value='<%=Helper.correctNull((String)hshValues.get("MMRBL_DRAWINGPOWER"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="11%"> <lapschoice:CurrencyTag name="txt_oustanding" tabindex="14" value='<%=Helper.correctNull((String)hshValues.get("MMRBL_OSAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_ovedueamount" tabindex="15" value='<%=Helper.correctNull((String)hshValues.get("MMRBL_OVERDUEAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="10%"> 
        <table width="80%" class="outertable">
          <tr> 
            <td width="88%"> 
              <input type="text" name="txt_since" tabindex="16" value="<%=Helper.correctNull((String)hshValues.get("MMRBL_OVERDUESINCE"))%>"  onBlur="checkDate(this);checkmaxdate(this,currentDate)" size="12" maxlength="10">
            </td>
            <td width="12%">&nbsp;<a alt="Select date from calender"  href="javascript:callCalender(this,3)"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a></td>
          </tr>
        </table>
      </td>
      <td width="12%"> <lapschoice:CurrencyTag name="txt_debit" tabindex="17" value='<%=Helper.correctNull((String)hshValues.get("MMRBL_DEBITCURRMONTH"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_current" tabindex="18" value='<%=Helper.correctNull((String)hshValues.get("MMRBL_CREDITCURRMONTH"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="13%"> <lapschoice:CurrencyTag name="txt_cummulative" tabindex="19" value='<%=Helper.correctNull((String)hshValues.get("MMRBL_CREDITURNOVER"))%>' size="18" maxlength="15" /> 
      <input type="hidden" name="txt_instalment" value="<%=Helper.correctNull((String)hshValues.get("MMRBL_INSTALMENT"))%>" size="18" maxlength="10">
      </td>
      
    </tr>
    <tr class="dataheader"> 
      <td colspan="10"><b>Non Fund Based</b></td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td rowspan="3" width="4%">S.no</td>
      <td rowspan="3" width="17%">Nature of facilities</td>
      <td rowspan="3" width="8%">Sanctioned limit (Rs)</td>
      <td rowspan="3" width="7%">D.P (Rs)</td>
      <td rowspan="3" width="11%">O/s as on (Rs)</td>
      <td colspan="2" rowspan="2">Invoked / Devolved</td>
      <td colspan="3">Turn over</td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td width="12%">&nbsp;</td>
      <td colspan="2">Credit</td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td width="9%">Amount (Rs)</td>
      <td width="10%">Since When</td>
      <td width="12%">Debit current Month (Rs)</td>
      <td width="9%">Current Month (Rs)</td>
      <td width="13%">Cummulative from 1st April (Rs)</td>
    </tr>
    <tr align="center" class="datagrid"> 
      <td width="4%">&nbsp;1)</td>
      <td width="17%"> 
        <input type="hidden" name="txt_facility"  value="LC" size="30" maxlength="15">
        <input type="text" name="txt_facilitycheck" tabindex="11" value="Letter of Credit" size="30" maxlength="15">
      </td>
      <td width="8%"> <lapschoice:CurrencyTag name="txt_sanctionlimit" tabindex="20" value='<%=Helper.correctNull((String)hshValues.get("MMRLC_SANCAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="7%"> <lapschoice:CurrencyTag name="txt_dp" tabindex="21" value='<%=Helper.correctNull((String)hshValues.get("MMRLC_DRAWINGPOWER"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="11%"> <lapschoice:CurrencyTag name="txt_oustanding" tabindex="22" value='<%=Helper.correctNull((String)hshValues.get("MMRLC_OSAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_ovedueamount" tabindex="23" value='<%=Helper.correctNull((String)hshValues.get("MMRLC_OVERDUEAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="10%"> 
        <table width="80%" class="outertable">
          <tr> 
            <td width="88%"> 
              <input type="text" name="txt_since" tabindex="24" value="<%=Helper.correctNull((String)hshValues.get("MMRLC_OVERDUESINCE"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)" size="12" maxlength="10">
            </td>
            <td width="12%">&nbsp;<a alt="Select date from calender"  href="javascript:callCalender(this,1)"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a></td>
          </tr>
        </table>
      </td>
      <td width="12%"> <lapschoice:CurrencyTag name="txt_debit" tabindex="25" value='<%=Helper.correctNull((String)hshValues.get("MMRLC_DEBITCURRMONTH"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_current" tabindex="26" value='<%=Helper.correctNull((String)hshValues.get("MMRLC_CREDITCURRMONTH"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="13%"> <lapschoice:CurrencyTag name="txt_cummulative" tabindex="27" value='<%=Helper.correctNull((String)hshValues.get("MMRLC_CREDITURNOVER"))%>' size="18" maxlength="15" /> 
      <input type="hidden" name="txt_instalment" value="<%=Helper.correctNull((String)hshValues.get("MMRLC_INSTALMENT"))%>" size="18" maxlength="15">
      </td>
      
    </tr>
    <tr align="center" class="datagrid"> 
      <td width="4%">2)</td>
      <td width="17%"> 
        <input type="hidden" name="txt_facility" tabindex="1" value="LG" size="30" maxlength="10">
        <input type="text" name="txt_facilitycheck" tabindex="1" value="Letter of Guarantee" size="30" maxlength="20">
      </td>
      <td width="8%"> <lapschoice:CurrencyTag name="txt_sanctionlimit" tabindex="28" value='<%=Helper.correctNull((String)hshValues.get("MMRLG_SANCAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="7%"> <lapschoice:CurrencyTag name="txt_dp" tabindex="29" value='<%=Helper.correctNull((String)hshValues.get("MMRLG_DRAWINGPOWER"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="11%"> <lapschoice:CurrencyTag name="txt_oustanding" tabindex="30" value='<%=Helper.correctNull((String)hshValues.get("MMRLG_OSAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_ovedueamount" tabindex="31" value='<%=Helper.correctNull((String)hshValues.get("MMRLG_OVERDUEAMT"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="10%"> 
        <table width="80%">
          <tr> 
            <td width="88%"> 
              <input type="text" name="txt_since" tabindex="32" value="<%=Helper.correctNull((String)hshValues.get("MMRLG_OVERDUESINCE"))%>" onBlur="checkDate(this);checkmaxdate(this,currentDate)" size="12" maxlength="10">
            </td>
            <td width="12%">&nbsp;<a alt="Select date from calender"  href="javascript:callCalender(this,2)"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a></td>
          </tr>
        </table>
      </td>
      <td width="12%"> <lapschoice:CurrencyTag name="txt_debit" tabindex="33" value='<%=Helper.correctNull((String)hshValues.get("MMRLG_DEBITCURRMONTH"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%"> <lapschoice:CurrencyTag name="txt_current" tabindex="34" value='<%=Helper.correctNull((String)hshValues.get("MMRLG_CREDITCURRMONTH"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="13%"> <lapschoice:CurrencyTag name="txt_cummulative" tabindex="35" value='<%=Helper.correctNull((String)hshValues.get("MMRLG_CREDITURNOVER"))%>' size="18" maxlength="15" /> 
      <input type="hidden" name="txt_instalment" value="<%=Helper.correctNull((String)hshValues.get("MMRLG_INSTALMENT"))%>" size="18" maxlength="10">
      </td>
      
    </tr>
    <tr align="center" class="dataheader"> 
      <td width="4%">&nbsp;</td>
      <td width="17%">Sub - Total</td>
      <td width="8%">&nbsp; <lapschoice:CurrencyTag name="sancttotalamount" tabindex="5" value='<%=Helper.correctNull((String)hshValues.get("nonfundbasedsanctionamout"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="7%">&nbsp;</td>
      <td width="8%">&nbsp; <lapschoice:CurrencyTag name="ostotalamount" tabindex="5" value='<%=Helper.correctNull((String)hshValues.get("nonfundbasedos_amount"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%">&nbsp;</td>
      <td width="10%">&nbsp;</td>
      <td width="12%">&nbsp;</td>
      <td width="9%">&nbsp;</td>
      <td width="13%">&nbsp;</td>
    </tr>
    <tr align="center" class="dataheader"> 
      <td width="4%">&nbsp;</td>
      <td width="17%">Grand - Total</td>
      <td width="8%">&nbsp; <lapschoice:CurrencyTag name="grandsancttotalamount" tabindex="5" value='<%=Helper.correctNull((String)hshValues.get("grandsanction_amount"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="7%">&nbsp;</td>
      <td width="8%">&nbsp; <lapschoice:CurrencyTag name="grandostotalamount" tabindex="5" value='<%=Helper.correctNull((String)hshValues.get("grandos_amount"))%>' size="18" maxlength="15" /> 
      </td>
      <td width="9%">&nbsp;</td>
      <td width="10%">&nbsp;</td>
      <td width="12%">&nbsp;</td>
      <td width="9%">&nbsp;</td>
      <td width="13%">&nbsp;</td>
    </tr>
    <tr align="Center">
	<td colspan="10"><b><font color="red" size="2">Caution !</font></b></td>
	</tr>
	<tr>
      
	  <td colspan="10">
	  <b><font color="red">Note : - </font></b><BR>
       <b><font color="red">1. All Debit balances should be indicated with 
          - (minus) sign<br>
          2. Enter the values under Non Fund based limits in actual Rupees.</font></b><BR>
          <b><font color="#0000ee">3. Above details are directly captured from financle. The limits 
          include sub limits (Within which limits) and Ad-hoc limits. Whenever 
          the sublimits and ad-hoc limits are sanctioned, use the annexure provided 
          to specify the Limits / Sub limits. There is a Provision to print the 
          said annexure seperately which can be attached to the MMR report</font></b>
      </td>
    </tr>    
  </table>
  <br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)hshValues.get("cbsid"))%>"> 
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)hshValues.get("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)hshValues.get("mon_month"))%>">
<input type="hidden" name="applyflag" value="<%=Helper.correctNull((String)hshValues.get("applyflag"))%>"/> 
</form>
</body>
</html>
