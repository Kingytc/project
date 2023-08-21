<%@ include file="../share/directives.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].txt_nature_limit.value=val2;
	document.forms[0].txt_amount_limit.value=val3;
	document.forms[0].txt_running_outstand.value=val4;
	document.forms[0].txt_prodential_writeoff.value=val5;
	document.forms[0].txt_ecgc_claim.value=val6;
	document.forms[0].txt_subtotal.value=val7;
	document.forms[0].txt_unrecover.value=val8;
	document.forms[0].txt_net_dues.value=val9;
	document.forms[0].txt_dummy_fromdate.value=val10;
	document.forms[0].txt_dummy_todate.value=val11;
	document.forms[0].txt_dummy_ledger.value=val12;
	 document.forms[0].txt_legal_expenses.value=val13;
    document.forms[0].txt_total_dues.value=val14;
	document.forms[0].txt_facility_hid.value=val15;
	if(document.forms[0].btnenable.value=="Y")
	{
    	disableCommandButtons("radioselect");
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");
	document.forms[0].txt_nature_limit.focus();	
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
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
	document.forms[0].txt_ecgc_claim.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/prudential_presentposition.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
		document.forms[0].hidBeanMethod.value="updatePresentPosition";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}
function doSave()
{
	if(trim(document.forms[0].txt_nature_limit.value)=="")
	{
		ShowAlert('121', 'Nature of limit');
		return;
	}
	if(document.forms[0].txt_dummy_fromdate.value=="")
	{
		alert("Enter the Dummy Ledger Interest From date");
		document.forms[0].txt_dummy_fromdate.focus();
		return;
	}
	if(document.forms[0].txt_dummy_todate.value=="")
	{
		alert("Enter the Dummy Ledger Interest To Date");
		document.forms[0].txt_dummy_todate.focus();
		return;
	}
	if(document.forms[0].txt_dummy_ledger.value=="")
	{
		alert("Enter the Dummy Ledger Interest Amount");
		document.forms[0].txt_dummy_ledger.focus();
		return;
	}
	if(document.forms[0].txt_legal_expenses.value=="")
	{
		alert("Enter the Legal / Other Expences");
		document.forms[0].txt_legal_expenses.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/prudential_presentposition.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updatePresentPosition";
	document.forms[0].hidBeanGetMethod.value="getPresentPosition";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/prudential_presentposition.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updatePresentPosition";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
		document.forms[0].action=appURL+"controllerservlet";
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
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].disabled=(!val);
		}		 
	}
	document.forms[0].txt_subtotal.readOnly=true;
	document.forms[0].txt_total_dues.readOnly=true;
	document.forms[0].txt_net_dues.readOnly=true;
	document.forms[0].txt_dummy_todate.readOnly=true;
	
	document.forms[0].txt_nature_limit.readOnly=true;
	document.forms[0].txt_amount_limit.readOnly=true;
	document.forms[0].txt_running_outstand.readOnly=true;
}
function onLoading()
{
var varecgcsettled="<%=Helper.correctNull((String)hshValues.get("ecgc"))%>";
	if(varecgcsettled!="")
	{
		if(varecgcsettled=="1")
		{
			document.all.ecgclbl.style.visibility="visible";
			document.all.ecgctxt.style.visibility="visible";
			document.all.ecgcrs.style.visibility="visible";
		}
		else if(varecgcsettled=="2")
		{
			document.all.ecgclbl.style.visibility="hidden";
			document.all.ecgctxt.style.visibility="hidden";
			document.all.ecgcrs.style.visibility="hidden";
		}
	}
	disableFields(true);
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
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

function calSUBTotal()
{
	var running=document.forms[0].txt_running_outstand.value;
	var prodential=document.forms[0].txt_prodential_writeoff.value;
	var ecgcamount=document.forms[0].txt_ecgc_claim.value;
	
	if(running=="")
	{
		running="0.00";
	}
	if(prodential=="")
	{
		prodential="0.00";
	}
	if(ecgcamount=="")
	{
		ecgcamount="0.00";
	}

	var tempsubtotal=0.00;
	tempsubtotal=eval(running)+eval(prodential)+eval(ecgcamount);
	document.forms[0].txt_subtotal.value=tempsubtotal;
	roundtxt(document.forms[0].txt_subtotal);
	var subtotal=document.forms[0].txt_subtotal.value;
	var unrecover=document.forms[0].txt_unrecover.value;
	if(subtotal=="")
	{
		subtotal="0.00";
	}
	if(unrecover=="")
	{
		unrecover="0.00";
	}
	var tempnetdues=eval(subtotal)-eval(unrecover);
	document.forms[0].txt_net_dues.value=tempnetdues;
	roundtxt(document.forms[0].txt_net_dues);
	var netdues=document.forms[0].txt_net_dues.value;
	
	var dummyledger=document.forms[0].txt_dummy_ledger.value;
	var legalexp=document.forms[0].txt_legal_expenses.value;
	if(dummyledger=="")
	{
		dummyledger="0.00";
	}
	if(legalexp=="")
	{
		legalexp="0.00";
	}
	var total=eval(netdues)+eval(dummyledger)+eval(legalexp);
    document.forms[0].txt_total_dues.value=total;
    roundtxt(document.forms[0].txt_total_dues);
}
</script>
</head>
<body onload="onLoading()">
<form name="prudential_presentposition" method="post" class="normal">
<lapstab:pwourltag pageid="4"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
           <td class="page_flow">Home -&gt; NPA -&gt; Prudential Write Off -&gt; Present Position</td>
          </tr>
        </table>
<lapschoice:npaapplication />
		<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />		
<lapstab:npapresentpostion module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="1" /><br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3"  class="outertable">
               <tr> 
                  <td width="27%">NATURE OF LIMIT</td>
                  <td width="3%">&nbsp;</td>
                  <td width="24%"> 
                    <input type="text" name="txt_nature_limit" size="25"
						maxlength="23" 
						value="" class="interfacefields">
						
						<input type="hidden" name="txt_facility_hid">
                  </td>
                  <td width="22%">AMOUNT OF LIMIT</td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="21%"> <lapschoice:CurrencyTag name="txt_amount_limit" size="18"
				maxlength="12" 
				value='' /> </td>
                </tr>
                <tr> 
                  <td width="27%">RUNNING LEDGER OUTSTANDING</td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="24%"> <lapschoice:CurrencyTag name="txt_running_outstand" size="16"
				maxlength="12"  
				value=''
				onBlur="calSUBTotal()"/> </td>
				<td id="ecgclbl">ECGC/DICGC/CGFT CLAIM APPROPRIATED</td>
                  <td id="ecgcrs"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td id="ecgctxt"> <lapschoice:CurrencyTag name="txt_ecgc_claim" size="16"
						maxlength="12" tabindex="1" value='' onBlur="calSUBTotal()"/> 
					<input type="hidden" name="txt_prodential_writeoff" size="18"
				maxlength="12" 
				value=""
				onBlur="calSUBTotal()"></td>                
                </tr>
                <tr> 
                  <td>SUB-TOTAL</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td> <lapschoice:CurrencyTag name="txt_subtotal" size="16" 
					maxlength="12" onBlur="calSUBTotal()"/> </td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
                </tr>
                <tr> 
                  <td width="27%">UNRECOVERED INTEREST, IF ANY</td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="24%"> <lapschoice:CurrencyTag name="txt_unrecover" size="16"
				maxlength="12" tabindex="2"
				value='' onBlur="calSUBTotal()"/> </td>
                  <td width="22%">NET DUES</td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="21%"> <lapschoice:CurrencyTag name="txt_net_dues" size="16"
				maxlength="12" 
				value='' onBlur="calSUBTotal()"/> </td>
                </tr>
                <tr> 
                  <td width="27%" >DUMMY LEDGER INTEREST FROM <span class="mantatory">*&nbsp;</span>
                  </td>
                  <td width="3%">&nbsp;</td>
                  <td width="24%" > 
                    <table width="30%">
                      <tr> 
                        <td> 
                          <input type="text" name="txt_dummy_fromdate" size="12"
					maxlength="10" 	value="" tabindex="3"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
                        </td>
                        <td> <a href="#" onClick="callCalender('txt_dummy_fromdate')"
				title="Click to view calender" border=0> <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				width="0" border="0" tabindex="3"></a> </td>
                      </tr>
                    </table>
                  </td>
                  <td width="22%" >DUMMY LEDGER INTEREST TO <span class="mantatory">*&nbsp;</span>
                  </td>
                  <td width="3%">&nbsp;</td>
                  <td width="21%" > 
                    <table>
                      <tr> 
                        <td> 
                          <input type="text" name="txt_dummy_todate" size="12"
						maxlength="10" value=""  tabindex="4"
						onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
                        </td>
                        <td> <a href="#" onClick="callCalender('txt_dummy_todate')"
					title="Click to view calender" border=0> <img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					width="0" border="0" tabindex="4"></a> </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="27%" > DUMMY LEDGER INTEREST AMOUNT <span class="mantatory">*&nbsp;</span>
                  </td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="24%" > <lapschoice:CurrencyTag name="txt_dummy_ledger" size="16"
				maxlength="12" tabindex="5" 
				value='' onBlur="calSUBTotal()"/> </td>
                  <td width="22%" > LEGAL / OTHER EXPENSES<span class="mantatory">*&nbsp;</span>
                  </td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="21%" > <lapschoice:CurrencyTag name="txt_legal_expenses" size="16"
				maxlength="12" tabindex="6" 
				value='' onBlur="calSUBTotal()"/> </td>
                </tr>
                <tr> 
                  <td width="27%">TOTAL DUES</td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td width="24%"> <lapschoice:CurrencyTag name="txt_total_dues" size="16"
				maxlength="12" 
				value='' onBlur="calSUBTotal()"/> </td>
                  <td width="22%">&nbsp;</td>
				  <td width="3%">&nbsp;</td>
                  <td width="21%">&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table><br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trial"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'	 />
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
  	<tr> 
    	<td valign="top" > 
        	<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
            	<tr>
                	<td>
	                	<table width="98.3%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
                  			<tr class="dataheader"> 
				            	<td width="4%" >&nbsp;&nbsp;&nbsp;</td>
				                <td width="14%"  align="center"><b>NATURE OF LIMIT</b></td>
								<td width="14%"  align="center"><b>AMOUNT OF LIMIT</b></td>
                    			<td width="14%"  align="center" wrap><b>RUNNING LEDGER OUTSTANDING</b></td>
					            <td width="14%"  align="center" wrap><b> LEGAL 	/ OTHER EXPENSES</b></td>
					            <td width="14%"  align="center"> <b> SUB-TOTAL</b></td>
					            <td width="14%"  align="center"><b>NET DUES</b></td>
					            <td width="14%" class="tabactivenew" align="center"><b>TOTAL DUES</b></td></tr>                  			
				  <%vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow.size()>0 && vecRow!=null)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);%>                  
                  <tr class="datagrid">
                  			<td width="4%" align=center> 
                    			<input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
					                            	'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(5))))%>',
					                            	'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(7))))%>',
                            						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%>',
                            						'<%=Helper.correctNull((String)vecCol.get(9))%>',
                            						'<%=Helper.correctNull((String)vecCol.get(10))%>',
                            						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(11))))%>',
                            						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(12))))%>',
                            						'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%>'
													,'<%=Helper.correctNull((String)vecCol.get(20))%>')">
                      				</td>                    
                  			<td width="14%">&nbsp;<%=Helper.correctNull((String)vecCol.get(1))%></td>
                  			<td width="14%" align="right">&nbsp;
                  				<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%></td>
                  			<td width="14%" align="right">&nbsp;
                  				<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%></td>
                  			<td width="14%" align="right">&nbsp;
                  				<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(12))))%></td>
                  			<td width="14%" align="right">&nbsp;
                  				<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%></td>
                  			<td width="14%" align="right">&nbsp;
                  				<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%></td>
                  			<td width="14%" align="right">&nbsp;
                 				<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%></td>
                  		</tr>
                  <%}}else{%>
                  <tr class="datagrid"> 
                    <td align="center" colspan="10">No Data Found</td>
                  </tr>
                  <%}%>
             </table>
             </td>
             </tr>
                </table>                
            </td>
          </tr>
        </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
	<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>"/>
</form>
</body>
</html>