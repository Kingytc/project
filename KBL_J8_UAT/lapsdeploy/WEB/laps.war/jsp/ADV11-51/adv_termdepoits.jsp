<%@include file="../share/directives.jsp"%>
<%ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			%>
<html>
<head>
<title>Term Deposits</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function doNew()
{
	disableFields(false);
	disableCommandButtons("new");
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="insert";
	document.forms[0].deposit_date.value ="";
	document.forms[0].txt_name.value="";
	document.forms[0].txt_amount.value="";
	document.forms[0].maturing_date.value="";
	document.forms[0].sel_encumbered.value="0";
	document.forms[0].text_comments.value="";
	document.forms[0].text_comments.disabled=false;
	document.forms[0].deposit_date.focus();
}	
	
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons("edit");	
	document.forms[0].text_comments.disabled=false;
}

function doSave()
{
	if(document.forms[0].txt_name.value=="")
	{
		ShowAlert('121',"Name");
		document.forms[0].txt_name.focus();
		return;
	}
	else
	{
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].hidSourceUrl.value="/action/adv_termdepoits.jsp";
		document.forms[0].hidBeanMethod.value="updateTermdepoits";
		document.forms[0].hidBeanGetMethod.value="getTermdepoits";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getTermdepoits";
		document.forms[0].hidBeanId.value="ADV1151";
		document.forms[0].action=appURL+"action/adv_termdepoits.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="Delete";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].hidSourceUrl.value="/action/adv_termdepoits.jsp";
			document.forms[0].hidBeanMethod.value="updateTermdepoits";
			document.forms[0].hidBeanGetMethod.value="getTermdepoits";	
			document.forms[0].submit();
		}
	}
	else
	{
		
		ShowAlert(158);
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/agrpage.jsp";
		document.forms[0].submit();
	}
}

function selectValues(val1, val2, val3, val4, val5, val6, i,size)
{
    document.forms[0].hidsno.value =val1;
    document.forms[0].deposit_date.value =val2;
	document.forms[0].txt_name.value =val3;
	document.forms[0].txt_amount.value=val4;
	document.forms[0].maturing_date.value=val5;
	document.forms[0].sel_encumbered.value=val6;
	if(size==1)
	{
		document.forms[0].text_comments.value=document.forms[0].hidother.value;		
	}
	else
	{
		document.forms[0].text_comments.value=document.forms[0].hidother[i].value;		
	}
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons("radioselect");
	}
	callencumbered();
}

function disableCommandButtons(val)
{
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
	if(val=="disableall")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="new")
	{
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	 
	}
}
function clearfields()
{
    document.forms[0].deposit_date.value="";
	document.forms[0].txt_name.value="";
	document.forms[0].txt_amount.value="S";
	document.forms[0].maturing_date.value="";
	document.forms[0].sel_encumbered.value="0";
	document.forms[0].text_comments.value="";
}
function callCalender(fname)
 {
	 if(document.forms[0].cmdsave.disabled==false)
	 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
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

function onloading()
{	  
	document.forms[0].hidAction.value ="";
	document.forms[0].text_comments.disabled=true;
	disableFields(true);
	callencumbered();	
}
function callLink(page,bean,method)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appURL+"action/"+page;
			document.forms[0].submit();
		}		
function callencumbered()		
{

	if(document.forms[0].sel_encumbered.value=="1")
	{
		document.all.encumbered1.style.visibility="visible";
		document.all.encumbered1.style.position="relative";
		document.all.encumbered2.style.visibility="visible";
		document.all.encumbered2.style.position="relative";
	}
	else
	{
		document.all.encumbered1.style.visibility="hidden";
		document.all.encumbered1.style.position="absolute";
		document.all.encumbered2.style.visibility="hidden";
		document.all.encumbered2.style.position="absolute";
		document.forms[0].text_comments.value="";
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmtermdeposits" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="19" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">Home-&gt; Tertiary-&gt; Proposal-&gt;ADV1151 -&gt;Term Deposits
		</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application /><br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
	<tr class="dataheader">
		<td align="center"><b>TERM DEPOSITS</b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr class="dataheader">
						<td  width="18%">Deposit accounts (Including Family Members)</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="datagrid" class="outertable">
					<tr>
						<td  width="18%">Date</td>
						<td  width="34%"><input type="text"
							name="deposit_date" size="12" tabindex="1" maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							style="text-align:left;border-style=groove">
						<a alt="Select date from calender" href="#"
							onClick="callCalender('deposit_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" 
							alt="Select date from calender" tabindex="2"></a></td>
						<td  width="18%">Name<span class="mantatory">*&nbsp;</span></td>
						<td  width="34%">
						<table width="55%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td><input type="text" name="txt_name" tabindex="3" onKeyPress="notAllowSplChar()" maxlength="50"></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td  width="14%">Amount <b><%=ApplicationParams.getCurrency()%></b></td>
						<td  width="34%"><lapschoice:CurrencyTag
							name="txt_amount" onKeyPress="CheckDecimal(this.value)"
							tabindex="4" value='' maxlength="15" /></td>
						<td  width="18%">Maturing on</td>
						<td  width="34%">
						<table width="55%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td><input type="text" name="maturing_date" tabindex="5"
									size="12" maxlength="10"
									onBlur="checkDate(this);checkmindate(this,currentDate)"> <a
									alt="Select date from calender" href="#"
									onClick="callCalender('maturing_date')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									alt="Select date from calender" tabindex="6"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td  width="14%">Encumbered</td>
						<td  width="34%"><select name="sel_encumbered"
							onChange="callencumbered()" tabindex="7">
							<option value="0" selected="selected">select</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select></td>
						<td id="encumbered1"  width="18%">If Encumbered ,
						Explain How</td>
						<td id="encumbered2"  width="34%">
						<table width="43%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td><textarea rows="2" name="text_comments" cols="30"
									tabindex="6" maxlength="4000" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("borrpow_comments"))%></textarea>
								</td>
							</tr>
						</table></td>
					</tr>
				</table>
				</td>
			</tr>
			</table>
			</td>
			</tr>
			</table><br>
			<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
			<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable linebor">
							<tr class="dataheader">
								<td width="3%" align="center"></td>
								<td width="13%" align="center"><b>Date</b></td>
								<td width="14%" align="center"><b>Name</b></td>
								<td width="14%" align="center"><b>Amount</b></td>
								<td width="14%" align="center"><b> Maturing on</b></td>
								<td width="14%" align="center"><b>Unencumbered/Encumbered</b></td>
							</tr>
						<%arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					int size = arrRow.size();
					arrCol = (ArrayList) arrRow.get(i);

					String encumbered = Helper.correctNull((String) arrCol.get(6));
					if (encumbered.equalsIgnoreCase("1")) {
						encumbered = "Yes";
					} else if (encumbered.equalsIgnoreCase("2")) {
						encumbered = "No";
					} else {
						encumbered = "";
					}%>
							<tr class="datagrid">
								<td width="4%"><input type="radio" style="border:none"
									name="radiobutton" value="radiobutton"
									onClick="javascript:selectValues(
											    '<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(2))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>',
												'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>',
												'<%=Helper.correctNull((String)arrCol.get(5))%>',
												'<%=Helper.correctNull((String)arrCol.get(6))%>','<%=i%>','<%=size%>')">
								<input type="hidden" name="hidother"
									value="<%=Helper.correctNull((String)arrCol.get(7))%>"></td>
								<td width="15%" align="center">&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
								<td width="16%">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
								<td width="16%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%></td>
								<td width="16%">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
								<td width="17%">&nbsp;<%=encumbered%></td>
							</tr>
							<%}}%>
							<tr class="datagrid">
								<td width="4%" align="center">&nbsp;</td>
								<td width="15%" >&nbsp;</td>
								<td width="16%" >&nbsp;</td>
								<td width="16%" >&nbsp;</td>
								<td width="16%" >&nbsp;</td>
								<td width="17%" >&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="20%" ><b>&nbsp; <a
			href="javascript:callLink('adv_depositaccounts.jsp','ADV1151','getDepositAccounts')"
			> &lt;&lt; Previous </a>&nbsp;</b></td>
		<td width="60%" align="center"><b> <jsp:include
			page="../ADV11-51/adv_links.jsp" flush="true" />
		 </b></td>
		<td width="20%">&nbsp;
		<div align="right"><b>Pg.10/19&nbsp;<a
			href="javascript:callLink('adv_connectedaccounts.jsp','ADV1151','getconnectedaccts')"
			> Next &gt;&gt; </a></b></div>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno">
</form>
</body>
</html>
