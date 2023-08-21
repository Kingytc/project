<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
			ArrayList vecCol = new ArrayList();%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varecgc="<%=Helper.correctNull((String)hshValues.get("ecgc"))%>";
var varpwo="<%=Helper.correctNull((String)hshValues.get("pwo"))%>";
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;		 
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20)
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
    document.forms[0].txt_ecgc_os.value=val15;
    document.forms[0].txt_ecgc_coverpercent.value=val16;
    document.forms[0].txt_ecgc_claimadmitted.value=val17;
    document.forms[0].txt_ecgc_claimsettled.value=val18;
	document.forms[0].txt_notional.value=val19;
	document.forms[0].txt_facility_hid.value=val20;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
    	disableCommandButtons(false,true,false,true,false);
    	disableFields(false);
	}
	else
	{
		disableCommandButtons(true,true,true,true,false);
		disableFields(true);
	}
}
function doEdit()
{ 	
	disableCommandButtons(true,false,false,false,true);
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	if(varpwo=="1")
		document.forms[0].txt_prodential_writeoff.focus();	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
		document.forms[0].action=appUrl +"action/npacompromise_presentposition.jsp";
		document.forms[0].submit(); 		
	}	
}
function doSave()
{
	if(document.forms[0].txt_nature_limit.value=="")
	{
		ShowAlert('121', 'Nature of limit');
		document.forms[0].txt_nature_limit.focus();
		return;
	}
	if(document.forms[0].txt_dummy_fromdate.value=="")
	{
		alert("Enter Dummy Ledger Interest from date");
		document.forms[0].txt_dummy_fromdate.focus();
		return;
	}
	if(document.forms[0].txt_dummy_todate.value=="")
	{
		alert("Enter Dummy Ledger Interest to Date");
		document.forms[0].txt_dummy_todate.focus();
		return;
	}
	if(document.forms[0].txt_dummy_ledger.value=="")
	{
		alert("Enter Dummy Ledger Interest Amount");
		document.forms[0].txt_dummy_ledger.focus();
		return;
	}
	if(document.forms[0].txt_legal_expenses.value=="")
	{
		alert("Enter the Legal/Other Expences");
		document.forms[0].txt_legal_expenses.focus();
		return;
	}	
	document.forms[0].hidSourceUrl.value="/action/npacompromise_presentposition.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updatePresentPosition";
	document.forms[0].hidBeanGetMethod.value="getPresentPosition";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/npacompromise_presentposition.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updatePresentPosition";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
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
	if(varpwo!="")
	{
		if(varpwo=="1")
		{
			document.all.pwo1.style.visibility="visible";
			document.all.pwo2.style.visibility="visible";
			document.all.pwo3.style.visibility="visible";
		}
		else if(varpwo=="2")
		{
			document.all.pwo1.style.visibility="hidden";
			document.all.pwo2.style.visibility="hidden";
			document.all.pwo3.style.visibility="hidden";
		}
	}
	if(varecgc!="")
	{
		if(varecgc=="1")
		{
			document.all.ecgc1.style.visibility="visible";
			document.all.ecgc2.style.visibility="visible";
			document.all.ecgc3.style.visibility="visible";
			document.all.c1.style.visibility="visible";
			document.all.c2.style.visibility="visible";
		}
		else if(varecgc=="2")
		{
			document.all.ecgc1.style.visibility="hidden";
			document.all.ecgc2.style.visibility="hidden";
			document.all.ecgc3.style.visibility="hidden";
			document.all.c1.style.visibility="hidden";
			document.all.c2.style.visibility="hidden";
		}
	}
	disableFields(true);
	disableCommandButtons(true,true,true,true,false);
}
function doClose()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);		
	}
}
function calSUBTotal()
{
	var running=document.forms[0].txt_running_outstand.value;
	var prodential=document.forms[0].txt_prodential_writeoff.value;
	
	if(running=="")
	{
		running="0.00";
	}
	if(prodential=="")
	{
		prodential="0.00";
	}
	var tempsubtotal=0.00;
	tempsubtotal=eval(running)+eval(prodential);
	document.forms[0].txt_subtotal.value=tempsubtotal;	
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
}
function callLink(page,bean,method)
 {
		if (document.forms[0].cmdsave.disabled)
		{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="OTSCO";
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
		}
		else
		{
		ShowAlert(103);
		}
 }
</script>
</head>
<body onload="onLoading()">
<form name="frmnpaotscoppaccnt" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td><lapstab:otscourltag pageid="3"/></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Compromise
				Proposal -&gt; Present Position -&gt; Account</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno"
	value="<%=(String)request.getParameter("npa_appno")%>" /> <lapstab:npapresentpostion
	module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>'
	pageid="1" /><br>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>
				<td>NATURE OF LIMIT</td>
				<td>&nbsp;</td>
				<td><input type="text" name="txt_nature_limit" size="25"
					maxlength="20" tabindex="22" > <input type="hidden"
					name="txt_facility_hid"></td>
				<td>AMOUNT OF LIMIT</td>
				<td><b>Rs.</b></td>
				<td><input type="text" name="txt_amount_limit" size="16"
					style="text-align:right" maxlength="12" tabindex="22"
					onKeyPress="allowInteger()"></td>
			</tr>
			<tr>
				<td>RUNNING LEDGER OUTSTANDING</td>
				<td><b>Rs</b>.</td>
				<td><input type="text" name="txt_running_outstand" size="16"
					style="text-align:right" maxlength="12" tabindex="22"
					onKeyPress="allowInteger()" onBlur="calSUBTotal()"></td>
				<td id="pwo1">O/S.&nbsp; AMOUNT PRUDENTIALLY WRITTEN OFF,IF ANY</td>
				<td id="pwo2"><b>Rs</b>.</td>
				<td id="pwo3"><lapschoice:CurrencyTag name="txt_prodential_writeoff"
					size="16" maxlength="12" tabindex="1" onBlur="calSUBTotal()" /></td>
			</tr>
			<tr>
				<td id="ecgc1">ECGC/DICGC/CGFT CLAIM APPROPRIATED</td>
				<td id="ecgc2"><b>Rs</b>.</td>
				<td id="ecgc3"><lapschoice:CurrencyTag name="txt_ecgc_claim"
					size="16" maxlength="12" tabindex="2" onBlur="calSUBTotal()" /></td>
				<td>SUB-TOTAL</td>
				<td><b>Rs</b>.</td>
				<td><input type="text" name="txt_subtotal" size="16"
					style="text-align:right" maxlength="12" tabindex="22"
					onKeyPress="allowDecimals()" onBlur="calSUBTotal()"></td>
			</tr>
			<tr>
				<td>UNRECOVERED INT., IF ANY</td>
				<td><b>Rs</b>.</td>
				<td><lapschoice:CurrencyTag name="txt_unrecover" size="16"
					maxlength="12" tabindex="3" onBlur="calSUBTotal()" /></td>
				<td>NET DUES</td>
				<td><b>Rs.</b></td>
				<td><input type="text" name="txt_net_dues" size="16"
					style="text-align:right" maxlength="12" tabindex="22"
					onKeyPress="allowDecimals()" onBlur="calSUBTotal()"></td>
			</tr>
			<tr>
				<td>DUMMY LEDGER INTEREST FROM <span class="mantatory">*&nbsp;</span></td>
				<td>&nbsp;</td>
				<td><input type="text" name="txt_dummy_fromdate" size="15"
					maxlength="10" tabindex="4" onBlur="checkDate(this)"> <a href="#"
					onClick="callCalender('txt_dummy_fromdate')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="4"></a></td>
				<td>DUMMY LEDGER INTEREST TO <span class="mantatory">*&nbsp;</span></td>
				<td>&nbsp;</td>
				<td><input type="text" name="txt_dummy_todate" size="15"
					maxlength="10" tabindex="5" onBlur="checkDate(this)"> <a href="#"
					onClick="callCalender('txt_dummy_todate')"
					title="Click to view calender" border=0><img
					src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
					border="0" tabindex="5"></a></td>
			</tr>
			<tr>
				<td>DUMMY LEDGER INTEREST AMOUNT <span class="mantatory">*&nbsp;</span></td>
				<td><b>Rs</b>.</td>
				<td><lapschoice:CurrencyTag name="txt_dummy_ledger" size="16"
					maxlength="12" tabindex="6" value='' onBlur="calSUBTotal()" /></td>
				<td>LEGAL / OTHER EXPENSES <span class="mantatory">*&nbsp;</span></td>
				<td><b>Rs.</b></td>
				<td><lapschoice:CurrencyTag name="txt_legal_expenses" size="16"
					maxlength="12" tabindex="7" value='' onBlur="calSUBTotal()" /></td>
			</tr>
			<tr>
				<td>TOTAL DUES</td>
				<td><b>Rs</b>.</td>
				<td><input type="text" name="txt_total_dues" size="16"
					style="text-align:right" maxlength="12" tabindex="22"
					onKeyPress="allowDecimals()" value="<%%>" onBlur="calSUBTotal()"></td>
				<td>NOTIONAL INTEREST <b>@ <%=Helper.formatDoubleValue(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("notionalintrate"))))%>&nbsp;%</b></td>
				<td><b>Rs.</b></td>
				<td><lapschoice:CurrencyTag name="txt_notional" size="16"
					maxlength="12" tabindex="8" /></td>
			</tr>
			<tr id="c1">
				<td>% of cover available</td>
				<td><b>Rs</b>.</td>
				<td><lapschoice:CurrencyTag name="txt_ecgc_coverpercent" size="16"
					maxlength="12" tabindex="8" onBlur="" /></td>
				<td>Claim admitted</td>
				<td><b>Rs</b>.</td>
				<td><lapschoice:CurrencyTag name="txt_ecgc_claimadmitted" size="16"
					maxlength="12" tabindex="9" onBlur="" /></td>
			</tr>
			<tr id="c2">
				<td>Claim settled</td>
				<td><b>Rs</b>.</td>
				<td><lapschoice:CurrencyTag name="txt_ecgc_claimsettled" size="16"
					maxlength="12" tabindex="10" onBlur="" /></td>
				<td>O/s. at the time claim is lodged with ECGC</td>
				<td><b>Rs</b>.</td>
				<td><lapschoice:CurrencyTag name="txt_ecgc_os" size="16"
					maxlength="12" tabindex="11" onBlur="" /></td>
			</tr>

		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			 align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="98.3%" border="0" cellspacing="0" cellpadding="1" class="outertable linebor">
					<tr class="dataheader">
						<td colspan="9"  align="right">Rs.</td>
					</tr>
					<tr class="dataheader">
						<td width="4%" >&nbsp;</td>
						<td width="18%"  align="center"><b>NATURE OF LIMIT</b></td>
						<td width="13%"  align="center"><b>AMOUNT OF LIMIT</b></td>
						<td width="13%"  align="center"><b>RUNNING LEDGER OUTSTANDING</b></td>
						<td width="13%"  align="center"><b> LEGAL / OTHER EXPENSES</b></td>
						<td width="13%"  align="center"><b> SUB-TOTAL</b></td>
						<td width="13%"  align="center"><b>NET DUES</b></td>
						<td width="13%"  align="center"><b>TOTAL DUES</b></td>
					</tr>
					<%double dblTotcost = 0.0;
			vecRow = (ArrayList) hshValues.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);
					dblTotcost = dblTotcost
							+ Double.parseDouble(Helper.correctDouble((String) vecCol.get(13)));%>
					<tr class="datagrid">
						<td width="4%" align=center><input type="radio"
							style="border:none" name="radiobutton" value="radiobutton"
							onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%>',
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
					                            	'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%>',
					                            	'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(15))))%>',
					                            	'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(16))))%>',
					                            	'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(17))))%>',
					                            	'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(18))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(19))))%>'
													,'<%=Helper.correctNull((String)vecCol.get(20))%>')">
						</td>
						<td width="18%">&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper.correctDouble((String) vecCol.get(2))))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper.correctDouble((String) vecCol.get(3))))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper.correctDouble((String) vecCol.get(12))))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper.correctDouble((String) vecCol.get(6))))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper.correctDouble((String) vecCol.get(8))))%></td>
						<td width="13%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper.correctDouble((String) vecCol.get(13))))%></td>
					</tr>
					<%}} else {%>
					<tr class="datagrid">
						<td align="center" colspan="8">No Data Found</td>
					</tr>
					<%}%>
					<tr class="datagrid">
						<td width="4%" align=center>&nbsp;</td>
						<td width="4%" align=center>&nbsp;</td>
						<td width="4%" align=center>&nbsp;</td>
						<td width="4%" align=center>&nbsp;</td>
						<td width="4%" align=center>&nbsp;</td>
						<td width="4%" align=center>&nbsp;</td>
						<td width="13%" align="center"><b>TOTAL </b></td>
						<td width="13%" align="right"><%=Helper.formatDoubleValue(dblTotcost)%>&nbsp;</td>
					</tr>
				</table>		
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>" />
</form>
</body>