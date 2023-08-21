<%@include file="../share/directives.jsp"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
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
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}	  
}
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].txt_term_name.value=val2;
	document.forms[0].sel_termtype.value=val3;
	document.forms[0].txt_no_instalments.value=val4;
	document.forms[0].txt_ins_amount.value=val5;
	document.forms[0].txt_start_date.value=val6;
	document.forms[0].txt_last_date.value=val7;
	document.forms[0].txt_disburse_date.value=val8;
	document.forms[0].txt_noinstalment_rec.value=val9;
	document.forms[0].txt_amount_insreceived.value=val10;
	document.forms[0].txt_instale_date.value=val11;
	document.forms[0].txt_payment_date.value=val12;
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
	document.forms[0].txt_term_name.focus();
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
	document.forms[0].txt_term_name.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
	    document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_termloan.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanGetMethod.value="getFilingtermloan";
		document.forms[0].hidBeanMethod.value="updateFilingtermloan";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit();			
	}	
}

function doSave()
{
if(document.forms[0].txt_term_name.value == "")
	{
		ShowAlert('121','Name Of Term Loan');
		document.forms[0].txt_term_name.focus();
		return;
	}
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_termloan.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateFilingtermloan";
		document.forms[0].hidBeanGetMethod.value="getFilingtermloan";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/filingofsuit_termloan.jsp";
		document.forms[0].hidBeanId.value="npa";
		document.forms[0].hidBeanMethod.value="updateFilingtermloan";
		document.forms[0].hidBeanGetMethod.value="getFilingtermloan";
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
	document.forms[0].txt_disburse_date.readOnly=true;
	document.forms[0].txt_instale_date.readOnly=true;
	document.forms[0].txt_payment_date.readOnly=true;
	document.forms[0].txt_start_date.readOnly=true;
	document.forms[0].txt_last_date.readOnly=true;	
}
function onLoading()
{
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
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			 class="outertable">
			<tr>
				<td><lapstab:suiturltag pageid="5" /></td>
			</tr>
			<tr> 
           <td valign="top" class="page_flow">Home 
				-&gt; NPA-&gt; Filing Of Suit   -&gt;Term Loan Details
 </td>
          </tr>
		</table>
		</td>
	</tr>
</table>
 <lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" /><br>
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
    <td>		
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td colspan="6" align="center"><b>TERM LOAN DETAILS</b></td>
    </tr>
    <tr> 
      <td colspan="2">Name of term loan</td>
      <td> 
        <input type="text" name="txt_term_name" size="35" maxlength="50" tabindex="1"
			>
      </td>
      <td colspan="2">Date of loan first disbursed</td>
      <td> 
        <input type="text" name="txt_disburse_date" size="13" tabindex="2" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
			maxlength="15">
        <a
			href="#" onClick="callCalender('txt_disburse_date')"
			TITLE="Click to view calender" BORDER=0><IMG
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			BORDER="0" TABINDEX="2"></a></td>
    </tr>
    <tr> 
      <td colspan="2">Type of term loan</td>
      <td> 
        <select name="sel_termtype" tabindex="3">
          <option value="1" selected>select</option>
          <option value="2">Short Term</option>
          <option value="3">medium Term</option>
          <option value="4">Long Term</option>
        </select>
      </td>
      <td colspan="2">No of instalments received</td>
      <td> 
        <input type="text" name="txt_noinstalment_rec"
			onKeyPress="allowInteger()" size="35" maxlength="4" tabindex="4"
			>
      </td>
    </tr>
    <tr> 
      <td colspan="2">No of instalments</td>
      <td> 
        <input type="text" name="txt_no_instalments" tabindex="5"
			onKeyPress="allowInteger()" size="35" maxlength="4"
			>
      </td>
      <td>Amount of instalment received</td>
      <td><b><%=ApplicationParams.getCurrency()%></b></td>
      <td> 
        <lapschoice:CurrencyTag name="txt_amount_insreceived" tabindex="6" maxlength="15"
			 size="35" />
      </td>
    </tr>
    <tr> 
      <td>Instalment amount</td>
      <td><b><%=ApplicationParams.getCurrency()%></b></td>
      <td> 
        <lapschoice:CurrencyTag name="txt_ins_amount"
			 size="35" maxlength="15" tabindex="7" />
      </td>
      <td colspan="2">Date of last instalment received</td>
      <td> 
        <input type="text" name="txt_instale_date" size="13" tabindex="8" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
			maxlength="25">
        <a
			href="#" onClick="callCalender('txt_instale_date')"
			TITLE="Click to view calender" BORDER=0><IMG
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			BORDER="0" TABINDEX="8"></a></td>
    </tr>
    <tr> 
      <td colspan="2">Start Date</td>
      <td> 
        <input type="text" name="txt_start_date" size="13" tabindex="9" maxlength="25" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
			>
        <a href="#"
			onClick="callCalender('txt_start_date')"
			TITLE="Click to view calender" BORDER=0><IMG
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			BORDER="0" TABINDEX="9"></a></td>
      <td colspan="2">Date from when default in payment is started</td>
      <td> 
        <input type="text" name="txt_payment_date" size="13" tabindex="10" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
			maxlength="25">
        <a
			href="#" onClick="callCalender('txt_payment_date')"
			TITLE="Click to view calender" BORDER=0><IMG
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			BORDER="0" TABINDEX="10"></a></td>
    </tr>
    <tr> 
      <td colspan="2">Last instalment date</td>
      <td> 
        <INPUT TYPE="text" NAME="txt_last_date" SIZE="13" tabindex="11" MAXLENGTH="25" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
			>
        <a href="#"
			onClick="callCalender('txt_last_date')"
			TITLE="Click to view calender" BORDER=0><IMG
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			BORDER="0" TABINDEX="11"></a></td>
      <td colspan="2">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
      <td>&nbsp;</td>
      <td colspan="2">&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
  </td>
  </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trial" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <br> 
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
<tr align="center">
	<td colspan="2">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
		align="center">
		<tr>
			<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
				<tr class="dataheader">
					<td width="2%" >&nbsp;</td>
					<td width="14%"  align="center"><b>Name of term loan</b></td>
					<td width="14%" align="center"><b>Type of term loan</b></td>
					<td width="14%"  align="center"><b>Date of loan first disbursed</b></td>
					<td width="14%"  align="center"><b> No of instalments received</b></td>
					<td width="14%"  align="center"><b> Amount of instalment received</b></td>
					<td width="14%" align="center"><b>Date of last instalment received</b></td>
					<td width="14%"  align="center"><b>Date from when default in payment is started </b></td>
				</tr>
				<%vecRow = (ArrayList) hshValues.get("vecRow");
			if (vecRow.size() > 0 && vecRow != null) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
				<tr class="datagrid">
					<td width="2%" align=center> <input
						type="radio" style="border:none" name="radiobutton"
						value="radiobutton"
						onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>',
													'<%=Helper.correctNull((String)vecCol.get(3))%>','<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(4))))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(5))%>','<%=Helper.correctNull((String)vecCol.get(6))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.correctNull((String)vecCol.get(8))%>',
                            	'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecCol.get(9))))%>','<%=Helper.correctNull((String)vecCol.get(10))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(11))%>')">
					</td>
					<td width="14%">&nbsp;<%=Helper.correctNull((String) vecCol.get(1))%></td>
					<%String termloantype = Helper.correctNull((String) vecCol
							.get(2));
					if (termloantype.equalsIgnoreCase("1")) {
						termloantype = "";
					} else if (termloantype.equalsIgnoreCase("2")) {
						termloantype = "Short Term";
					} else if (termloantype.equalsIgnoreCase("3")) {
						termloantype = "medium Term";
					} else if (termloantype.equalsIgnoreCase("4")) {
						termloantype = "Long Term";
					}%>
					<td width="14%">&nbsp;<%=termloantype%></td>
					<td width="14%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
					<td width="14%">&nbsp;<%=Helper.correctNull((String) vecCol.get(8))%></td>
					<td width="14%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(9))))%></td>
					<td width="14%">&nbsp;<%=Helper.correctNull((String) vecCol
											.get(10))%></td>
					<td width="14%">&nbsp;<%=Helper.correctNull((String) vecCol
											.get(11))%></td>
				</tr>
				<%}
			} else {

			%>
				<tr class="datagrid">
					<td align=center colspan="10">No
					Data Found</td>
				</tr>
				<%}

			%>
			</table>
			</div>
			</td>
		</tr>
	</table>
	</div>
	</td>
</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_strsno"	value="<%=Helper.correctNull((String)hshValues.get("FIL_SNO"))%>" /> 
</form>
</body>
</html>
