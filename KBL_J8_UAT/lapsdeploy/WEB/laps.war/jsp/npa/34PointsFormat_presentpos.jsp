<%@include file="../share/directives.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
			ArrayList vecCol = new ArrayList();
			java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
			nf.setMaximumFractionDigits(2);
			nf.setMinimumFractionDigits(2);
			nf.setGroupingUsed(false);%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css" />
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
   if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
    disableCommandButtons("radioselect");
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons("edit");	
	document.forms[0].txt_unrecover.focus();
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
	document.forms[0].txt_unrecover.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{  
	    document.forms[0].hidAction.value ="";	
		document.forms[0].hidSourceUrl.value="/action/34PointsFormat_presentpos.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
		document.forms[0].hidBeanMethod.value="updatePresentPosition";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
	disableCommandButtons("load");
}
function doSave()
{
if(document.forms[0].txt_nature_limit.value == "")
	{
		ShowAlert('121','Nature Of Limit');
		document.forms[0].txt_nature_limit.focus();
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
	alert("Enter the Dummy Ledger Interest To date");
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
		document.forms[0].hidSourceUrl.value="/action/34PointsFormat_presentpos.jsp";
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
		document.forms[0].hidSourceUrl.value="/action/34PointsFormat_presentpos.jsp";
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
	disableCommandButtons("load");
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
function callLink(page,bean,method)
		{
		if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].hidmoduletype.value="SUIT";
		document.forms[0].action=appURL+"action/"+page;
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
<form name="safaeri2" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="left">
			<tr>
				<td><lapstab:suiturltag pageid="6" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Filing Of Suit -&gt;Present Position</td>
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
		<td colspan="2">Nature of Limit</td>
		<td width="15%"><input type="text" name="txt_nature_limit" size="20" maxlength="15" tabindex="22"
			class="interfacefields"> <input type="hidden" name="txt_facility_hid">
		</td>
		<td>Amount of Limit</td>
		<td width="3%">Rs.</td>
		<td width="33%"><input type="text" name="txt_amount_limit" size="20"
			style="text-align:right" maxlength="15" tabindex="22" onKeyPress="allowInteger()"
			class="interfacefields"></td>
	</tr>
	<tr>
		<td width="30%">Running Ledger Outstanding</td>
		<td width="3%">Rs.</td>
		<td width="15%"><input type="text" name="txt_running_outstand"
			size="20" style="text-align:right" maxlength="15" tabindex="22" onKeyPress="allowInteger()"
			class="interfacefields" onBlur="calSUBTotal()"></td>
		<td colspan="2"></td>
		<td width="33%"><input type="hidden" name="txt_prodential_writeoff" size="20" maxlength="15" tabindex="22"
			onBlur="calSUBTotal()"></td>
	</tr>
	<tr>
		<td colspan="2"></td>
		<td width="15%"><input type="hidden" name="txt_ecgc_claim" size="20"
			maxlength="15" tabindex="22" onKeyPress="allowInteger()" onBlur="calSUBTotal()"></td>
		<!--  <td>Sub-Total</td>-->
		<td colspan="2"><input type="hidden" name="txt_subtotal" size="20"
			style="text-align:right" maxlength="15" tabindex="22" onBlur="calSUBTotal()"></td>
	</tr>
	<tr>
		<td>Unrecovered Interest</td>
		<td>Rs.</td>
		<td width="15%"><lapschoice:CurrencyTag name="txt_unrecover" size="20"
			maxlength="15" tabindex="1" onBlur="calSUBTotal()" /></td>
		<td>Net Dues</td>
		<td>Rs.</td>
		<td width="33%"><input type="text" name="txt_net_dues" size="20"
			style="text-align:right" maxlength="15" tabindex="22"
			onKeyPress="allowInteger()" onBlur="calSUBTotal()"></td>
	</tr>
	<tr>
		<td colspan="2">Dummy Ledger Interest From <span class="mantatory">*&nbsp;</span></td>
		<td width="15%"><input type="text" name="txt_dummy_fromdate"
			size="12" maxlength="10" tabindex="2" onBlur="checkDate(this)"> <a href="#"
			onClick="callCalender('txt_dummy_fromdate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="2"></a></td>
		<td colspan="2">Dummy Ledger Interest To <span class="mantatory">*&nbsp;</span></td>
		<td width="33%"><input type="text" name="txt_dummy_todate" size="12"
			maxlength="10" tabindex="3" onBlur="checkDate(this)"> <a href="#"
			onClick="callCalender('txt_dummy_todate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="3"></a></td>
	</tr>
	<tr>
		<td>
		<p>Dummy Ledger Interest Amount <span class="mantatory">*&nbsp;</span></p>
		</td>
		<td>Rs.</td>
		<td width="15%"><lapschoice:CurrencyTag name="txt_dummy_ledger"
			size="20" maxlength="15" tabindex="4" onBlur="calSUBTotal()" /></td>
		<td>Legal / Other Expenses <span class="mantatory">*&nbsp;</span></td>
		<td>Rs.</td>
		<td width="33%"><lapschoice:CurrencyTag name="txt_legal_expenses"
			size="20" maxlength="15" tabindex="5" onBlur="calSUBTotal()" /></td>
	</tr>
	<tr>
		<td>Total Dues</td>
		<td>Rs.</td>
		<td width="15%"><input type="text" name="txt_total_dues" size="20"
			style="text-align:right" maxlength="15" onKeyPress="allowInteger()" onBlur="calSUBTotal()"></td>
		<td colspan="2">&nbsp;</td>
		<td width="33%">&nbsp;</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
					<tr class="dataheader">
						<td >&nbsp;</td>
						<td  align="center"><b>Nature of Limit</b></td>
						<td  align="center"><b>Amount of Limit</b></td>
						<td  align="center"><b>Running Ledger Outstanding</b></td>
						<td  align="center"><b> Legal / Other Expenses</b></td>
						<td  align="center"><b> Sub-Total</b></td>
						<td  align="center"><b>Net Dues</b></td>
						<td  align="center"><b>Total Dues</b></td>
					</tr>
					<%vecRow = (ArrayList) hshValues.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
					<tr class="datgrid">
						<td align=center> <input
							type="radio" style="border:none" name="radiobutton"
							value="radiobutton"
							onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%>',
													'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            	'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(5))))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(6))))%>',
                            	'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(7))))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(8))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(9))%>','<%=Helper.correctNull((String)vecCol.get(10))%>',
                            	'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(11))))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(12))))%>',
                            	'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%>','<%=Helper.correctNull((String)vecCol.get(20))%>')">
						</td>
						<td>&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(2))))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(3))))%></td>
						<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) vecCol
											.get(12))))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
						<td align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(8))))%></td>
						<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) vecCol
											.get(13))))%></td>
					</tr>
					<%}} else {%>
					<tr class="datagrid">
						<td align =center colspan="8">No Data Found</td>
					</tr>
					<%}%>
				</table>
				</td>
			</tr>
		</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>" />
</form>
</body>
</html>
