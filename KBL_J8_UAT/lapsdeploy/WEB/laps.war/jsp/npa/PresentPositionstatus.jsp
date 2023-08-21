
<%@include file="../share/directives.jsp"%>
<%
	ArrayList vecRow = (ArrayList) hshValues.get("vecRow");
	ArrayList vecCol = new ArrayList();
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
%>

<html>
<head>
<title>NPA Present Position</title>
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
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
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
	document.forms[0].hidmoduletype.value="STAT";
	disableCommandButtons("edit");	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hidmoduletype.value="STAT";
	disableCommandButtons("edit");
	document.forms[0].txt_subtotal.readOnly=true;
	document.forms[0].txt_net_dues.readOnly=true;
	document.forms[0].txt_total_dues.readOnly=true;	
	document.forms[0].txt_prodential_writeoff.focus();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
		document.forms[0].action=appUrl +"action/PresentPositionstatus.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(document.forms[0].txt_dummy_fromdate.value=="")
	{
		ShowAlert('111','DUMMY LEDGER INTEREST FROM');
		document.forms[0].txt_dummy_fromdate.focus();
		return;
	}
	if(document.forms[0].txt_dummy_todate.value=="")
	{
		ShowAlert('111','DUMMY LEDGER INTEREST TO');
		document.forms[0].txt_dummy_todate.focus();
		return;
	}
	if(document.forms[0].txt_dummy_ledger.value=="")
	{
		ShowAlert('121','DUMMY LEDGER INTEREST AMOUNT');
		document.forms[0].txt_dummy_ledger.focus();
		return;
	}
	if(document.forms[0].txt_legal_expenses.value=="")
	{
		ShowAlert('121','LEGAL / OTHER EXPENSES');
		document.forms[0].txt_legal_expenses.focus();
		return;
	}
	document.forms[0].hidmoduletype.value="STAT";
	document.forms[0].hidSourceUrl.value="/action/PresentPositionstatus.jsp";
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
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidSourceUrl.value="/action/PresentPositionstatus.jsp";
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
	document.forms[0].txt_dummy_fromdate.readOnly=true;
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
	document.forms[0].hidSourceUrl.value=page;
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].hidmoduletype.value="STAT";
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}
</script>

</head>
<body onload="onLoading()">

<form name="frmpresentposition" method="post" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapstab:staturltag pageid="2" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA -&gt; Status
				Note -&gt; Present Position -&gt; Account</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno"
	value="<%=(String) request.getParameter("npa_appno")%>" /> <lapstab:npapresentpostion
	module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>'
	pageid="1" />
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td>NATURE OF LIMIT</td>
		<td>&nbsp;</td>
		<td><input type="text" name="txt_nature_limit" size="25"
			maxlength="20" class="interfacefields"> <input type="hidden"
			name="txt_facility_hid"></td>
		<td>AMOUNT OF LIMIT</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_amount_limit"
			maxlength="12" /></td>
	</tr>
	<tr>
		<td>RUNNING LEDGER OUTSTANDING</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_running_outstand"
			maxlength="12" onBlur="calSUBTotal()" /></td>
		<td>ADD: AMOUNT PRUDENTIALLY WRITTEN OFF,IF ANY</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_prodential_writeoff"
			tabindex="1" maxlength="12" onBlur="calSUBTotal()" /></td>
	</tr>
	<tr>
		<td>ECGC/DICGC/CGFT CLAIM APPROPRIATED,IF ANY</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_ecgc_claim" tabindex="2"
			maxlength="12" onBlur="calSUBTotal()" /></td>
		<td>SUB-TOTAL</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_subtotal" maxlength="12"
			onBlur="calSUBTotal()" /></td>
	</tr>
	<tr>
		<td>LESS: UNRECOVERED INT., IF ANY</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_unrecover" tabindex="3"
			maxlength="12" onBlur="calSUBTotal()" /></td>
		<td>NET DUES</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_net_dues" maxlength="12"
			onBlur="calSUBTotal()" /></td>
	</tr>
	<tr>
		<td>ADD: DUMMY LEDGER INTEREST FROM<span class="mantatory">*&nbsp;</span></td>
		<td>&nbsp;</td>
		<td><input type="text" name="txt_dummy_fromdate" size="13"
			maxlength="10" tabindex="4"
			value="<%//=Helper.correctNull((String)hshValues.get("txt_dummy_fromdate"))%>"
			onBlur="checkDate(this)"> <a href="#"
			onClick="callCalender('txt_dummy_fromdate')"
			title="Click to view calender"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="4"></a></td>
		<td>DUMMY LEDGER INTEREST TO<span class="mantatory">*&nbsp;</span></td>
		<td>&nbsp;</td>
		<td><input type="text" name="txt_dummy_todate" size="13"
			maxlength="10" tabindex="5"
			value="<%//=Helper.correctNull((String)hshValues.get("date_documents"))%>"
			onBlur="checkDate(this)"> <a href="#"
			onClick="callCalender('txt_dummy_todate')"
			title="Click to view calender"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="5"></a></td>
	</tr>
	<tr>
		<td>
		DUMMY LEDGER INTEREST AMOUNT<span class="mantatory">*&nbsp;</span>
		</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_dummy_ledger" tabindex="6"
			maxlength="12" onBlur="calSUBTotal()" /></td>
		<td>ADD: LEGAL / OTHER EXPENSES<span class="mantatory">*&nbsp;</span></td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_legal_expenses"
			tabindex="7" maxlength="12" onBlur="calSUBTotal()" /></td>
	</tr>
	<tr>
		<td>TOTAL DUES</td>
		<td><b><%=ApplicationParams.getCurrency()%></b></td>
		<td><lapschoice:CurrencyTag name="txt_total_dues" maxlength="12"
			onBlur="calSUBTotal()" /></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>

<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<div class="cellContainer">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	 align="center" class="outertable">
	<tr >
		<td valign="top">
		<div align="left">

		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" >
			<tr class="dataheader">
				<td width="4%" >&nbsp;</td>
				<td width="20%"  align="center"><b>NATURE
				OF LIMIT</b></td>
				<td width="12%"  align="center"><b>AMOUNT
				OF LIMIT</b></td>
				<td width="12%"  align="center"><b>RUNNING
				LEDGER OUTSTANDING</b></td>
				<td width="12%"  align="center"><b> LEGAL
				/ OTHER EXPENSES</b></td>
				<td width="12%"  align="center"><b>
				SUB-TOTAL</b></td>
				<td width="12%"  align="center"><b>NET
				DUES</b></td>
				<td width="16%"  align="center"><b>TOTAL
				DUES</b></td>
			</tr>
			<%
				vecRow = (ArrayList) hshValues.get("vecRow");
				if (vecRow.size() > 0 && vecRow != null) {
					for (int i = 0; i < vecRow.size(); i++) {
						vecCol = (ArrayList) vecRow.get(i);
			%>
			<tr class="datagrid">
				<td width="4%" align="center"><input type="radio"
					style="border: none" name="radiobutton" value="radiobutton"
					onClick="selectValues('<%=Helper.correctNull((String) vecCol.get(0))%>',
													'<%=Helper.correctNull((String) vecCol.get(1))%>','<%=Helper.correctNull((String) vecCol.get(2))%>',
													'<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(3))))%>','<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%>',
                            	'<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(5))))%>','<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%>',
                            	'<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(7))))%>','<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(8))))%>',
                            	'<%=Helper.correctNull((String) vecCol.get(9))%>','<%=Helper.correctNull((String) vecCol
											.get(10))%>',
                            	'<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) vecCol
											.get(11))))%>','<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) vecCol
											.get(12))))%>',
                            	'<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) vecCol
											.get(13))))%>','<%=Helper.correctNull((String) vecCol
											.get(20))%>')">
				</td>
				<td width="20%">&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
				<td width="12%" align="right">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
				<td width="12%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(3))))%></td>
				<td width="12%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) vecCol
											.get(12))))%></td>
				<td width="12%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
				<td width="12%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(8))))%></td>
				<td width="16%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) vecCol
											.get(13))))%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr class="datagrid">
				<td align="center" colspan="10">No Data Found</td>
			</tr>
			<%
				}
			%>
		</table>
		</div>
		</td>
	</tr>
</table>
</div>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_strsno"
	value="<%=Helper.correctNull((String) hshValues.get("PRE_SNO"))%>" /></form>
</body>
</html>