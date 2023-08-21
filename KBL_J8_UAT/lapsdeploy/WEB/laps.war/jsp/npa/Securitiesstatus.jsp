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
<title>ubi</title>
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
function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].sel_security.value=val2;
	document.forms[0].txt_nature.value=val3;
	document.forms[0].txt_renew_valuedate.value=val4;
	document.forms[0].txt_renew_valueamount.value=val5;
	document.forms[0].txt_present_valuedate.value=val6;
	document.forms[0].txt_present_valueamount.value=val7;
	document.forms[0].txt_present_inspecdate.value=val8;
	document.forms[0].txt_present_inspecby.value=val9;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
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
	document.forms[0].sel_security.focus();	
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hidmoduletype.value="STAT";
	disableCommandButtons("edit");
	document.forms[0].sel_security.focus();	
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
		document.forms[0].action=appUrl +"action/Securitiesstatus.jsp";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	var selapptype=document.forms[0].sel_security.options[document.forms[0].sel_security.selectedIndex].value;
	if(selapptype=='S')
	{
		ShowAlert('111',"Type of Security");
		document.forms[0].sel_security.focus();
		return ;
	}
	if(document.forms[0].txt_present_valuedate.value=="")
	{
		ShowAlert('121',"VALUATION DATE AT PRESENT");
		document.forms[0].txt_present_valuedate.focus();
		return ;
	}
	if(document.forms[0].txt_present_valueamount.value=="" || document.forms[0].txt_present_valueamount.value=="0.00")
	{
		ShowAlert('121',"VALUATION AMOUNT AT PRESENT");
		document.forms[0].txt_present_valueamount.focus();
		return ;
	}	
	if(document.forms[0].txt_present_inspecdate.value=="")
	{
		ShowAlert('121',"INSPECTION DATE");
		document.forms[0].txt_present_inspecdate.focus();
		return ;
	}
	if(document.forms[0].txt_present_inspecby.value=="")
	{
		ShowAlert('121',"INSPECTED BY");
		document.forms[0].txt_present_inspecby.focus();
		return ;
	}
	
	document.forms[0].hidmoduletype.value="STAT";
	document.forms[0].hidSourceUrl.value="/action/Securitiesstatus.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updateSecurities";
	document.forms[0].hidBeanGetMethod.value="getSecurities";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidmoduletype.value="STAT";
		document.forms[0].hidSourceUrl.value="/action/Securitiesstatus.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updateSecurities";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
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
	document.forms[0].txt_renew_valuedate.readOnly=true;
}

function onLoading()
{
	disableFields(true);
	roundtxt(document.forms[0].txt_renew_valueamount);
	roundtxt(document.forms[0].txt_present_valueamount);
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
<form name="safaeri2" method="post" class="normal">


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><lapstab:staturltag pageid="2" /></td>
			</tr>
			<tr>
				<td valign="top" class="page_flow">Home -&gt; NPA-&gt; Status
				Note -&gt; Present Position -&gt; Securities</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:npaapplication /> <INPUT type="hidden" name="npa_appno"
	value="<%=(String) request.getParameter("npa_appno")%>" /> <lapstab:npapresentpostion
	module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>'
	pageid="2" />
	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
	<tr>
	<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr class="dataheader">
		<td colspan="5" align="center"><b>SECURITIES</b></td>
	</tr>
	<tr>
		
      <td>TYPE OF SECURITY<span class="mantatory">*&nbsp;</span></td>
		<td><select name="sel_security" tabindex="1">
			<option value="S">--SELECT--</option>
			<option value="P">PRIMARY</option>
			<option value="C">COLLATERAL</option>
		</select></td>
		<td>NATURE</td>
		<td>&nbsp;</td>
		<td><input type="text" name="txt_nature" size="50" maxlength="40"
			tabindex="2">
		</td>
	</tr>
	<tr>
		<td colspan="5" align="left"><b>AT THE TIME OF RENEWAL </b></td>
	</tr>
	<tr>
		<td>VALUATION DATE</td>
		<td><input type="text" name="txt_renew_valuedate" size="13"
			maxlength="10" tabindex="3"
			onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
			href="#" onClick="callCalender('txt_renew_valuedate')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="3"></a></td>
		
      <td>VALUATION AMOUNT</td>
		<td><%=ApplicationParams.getCurrency()%></td>
		<td><lapschoice:CurrencyTag name="txt_renew_valueamount"
			tabindex="4" maxlength="15" /></td>
	</tr>
	<tr>
		<td colspan="4" align="left"><b>PRESENT POSITION</b></td>
	</tr>
	<tr>
		
      <td>VALUATION DATE<span class="mantatory">*&nbsp;</span></td>
		<td><input type="text" name="txt_present_valuedate" size="13"
			maxlength="10" tabindex="5"
			onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
			href="#" onClick="callCalender('txt_present_valuedate')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="5"></a></td>
		<td>VALUATION AMOUNT<span class="mantatory">*&nbsp;</span></td>
		<td><%=ApplicationParams.getCurrency()%></td>
		<td><lapschoice:CurrencyTag name="txt_present_valueamount"
			tabindex="6" maxlength="15" /></td>
	</tr>
	<tr>
		
      <td>INSPECTION DATE<span class="mantatory">*&nbsp;</span></td>
		<td><input type="text" name="txt_present_inspecdate" size="13"
			maxlength="10" tabindex="7" 
			onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
			href="#" onClick="callCalender('txt_present_inspecdate')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			border="0" tabindex="7"></a></td>
		
      <td>INSPECTED BY<span class="mantatory">*&nbsp;</span></td>
		<td>&nbsp;</td>
		<td><input type="text" name="txt_present_inspecby" size="20"
			maxlength="100" tabindex="8" onKeyPress="notAllowSplChar()">
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	 align="center" class="outertable">
	<tr class="dataheader">
		<td valign="top">
		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
			<tr >
				
				<td width="13%"  align="center">&nbsp;</td>
				<td width="13%"  align="center">&nbsp;</td>
				<td colspan="2"  align="center"><b>AT THE
				TIME OF RENEWAL</b></td>
				<td colspan="4"  align="center"><b>PRESENT
				POSITION</b></td>
			</tr>
			<tr>
				<td width="3%" >&nbsp;</td>
				<td width="13%"  align="center"><b>TYPE OF
				SECURITY</b></td>
				<td width="13%"  align="center"><b>NATURE</b></td>
				<td width="13%"  align="center"><b>VALUATION
				DATE</b></td>
				<td width="13%"  align="center"><b>
				VALUATION AMOUNT</b></td>
				<td width="13%"  align="center"><b>
				VALUATION DATE</b></td>
				<td width="13%"  align="center"><b>VALUATION
				AMOUNT</b></td>
				<td width="8%"  align="center"><b>INSPECTION
				DATE</b></td>
				<td width="11%"  align="center"><b>INSPECTED
				BY</b></td>
			</tr>
			<%
				vecRow = (ArrayList) hshValues.get("vecRow");
				if (vecRow.size() > 0 && vecRow != null) {
					for (int i = 0; i < vecRow.size(); i++) {
						vecCol = (ArrayList) vecRow.get(i);
			%>
			<tr class="datagrid">
				<td width="3%" align="center"><input type="radio"
					style="border: none" name="radiobutton" value="radiobutton"
					onClick="selectValues('<%=Helper.correctNull((String) vecCol.get(0))%>',
													'<%=Helper.correctNull((String) vecCol.get(1))%>','<%=Helper.correctNull((String) vecCol.get(2))%>',
													'<%=Helper.correctNull((String) vecCol.get(3))%>','<%=Helper.correctNull((String) vecCol.get(4))%>',
                            	'<%=Helper.correctNull((String) vecCol.get(5))%>','<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%>',
                            	'<%=Helper.correctNull((String) vecCol.get(7))%>','<%=Helper.correctNull((String) vecCol.get(8))%>')">
				</td>
				<%
					String security = Helper.correctNull((String) vecCol
									.get(1));
							if (security.equalsIgnoreCase("p")) {
								security = "PRIMARY";
							} else if (security.equalsIgnoreCase("c")) {
								security = "COLLATERAL";
							} else {
								security = " ";
							}
				%>

				<td width="13%">&nbsp;<%=security%></td>
				<td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
				<td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
				<td width="13%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>
				<td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
				<td width="13%" align="right">&nbsp;<%=nf.format(Double
									.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(6))))%></td>
				<td width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
				<td width="11%">&nbsp;<%=Helper.correctNull((String) vecCol.get(8))%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr class="datagrid">
				<td align="center" colspan="11">No Data Found</td>
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
	value="<%=Helper.correctNull((String) hshValues.get("SECU_SNO"))%>" /></form>
</body>
</html>