<%@include file="../share/directives.jsp"%>
<%			ArrayList arrCol = null;
			ArrayList arrRow = null;
			String ourbank = "";
			String ourindex = "";
			String leader = "";
			String leaderindex = "";

			arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					if (((String) arrCol.get(1)).equals("1")) {
						ourbank = "yes";
						ourindex = Integer.toString(i + 1);
					}

					if (((String) arrCol.get(11)).equals("1")) {
						leader = "yes";
						leaderindex = Integer.toString(i + 1);
					}
				}
			}%>
<html>
<head>
<title>Consortium</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";

function placevalues()
{
	disableFields(true);
	disableCommandButtons(false,true,true,true,true,false);
}
function doNew()
{
	 disableFields(false); 
	 disableCommandButtons(true,true,true,false,false,true);
	document.forms[0].hidAction.value ="insert";
	
	document.forms[0].txt_bankname.value ="0";
	document.forms[0].txt_branch.value="";
	document.forms[0].txt_sharepercent.value="";
	document.forms[0].txt_nonfundsharepercent.value="";
	document.forms[0].txt_assetclasification.value="";
	document.forms[0].txt_fundbasedname.value="";
	document.forms[0].txt_fundbasedamount.value="";
	document.forms[0].txt_nonfundbasedname.value="";
	document.forms[0].txt_nonfundbasedamount.value="";
	document.forms[0].txt_overdue.value="";
	document.forms[0].txt_remarks.value="";
	document.forms[0].txt_leadbank.value="0";	
}
function doEdit()
{ 
	document.forms[0].hidAction.value ="update";
	 disableFields(false); 
	 disableCommandButtons(true,true,true,false,false,true);	
}
function doSave()
{
	
	if(document.forms[0].txt_bankname.value=="0")
	{
		alert("Select Name of the Bank");
		document.forms[0].txt_bankname.focus();
		return;
	}	
	if(document.forms[0].hidAction.value == "insert")
	{
		if("<%=ourbank%>" == "yes" && document.forms[0].txt_bankname.value=="1")
		{
			alert("Our Bank option is already selected");
			document.forms[0].txt_bankname.focus();
			return false;
		}
		if("<%=leader%>" == "yes" && document.forms[0].txt_leadbank.value=="1")
		{
			alert("Leader option is already selected");
			document.forms[0].txt_leadbank.focus();
			return false;
		}
	}
	if(document.forms[0].hidAction.value == "update")
	{
		
		if("<%=ourbank%>" == "yes" && "<%=ourindex%>" != document.forms[0].hidserial.value && document.forms[0].txt_bankname.value=="1")
		{
			alert("Our Bank option is already selected");
			document.forms[0].txt_bankname.focus();
			return false;
		}
		if("<%=leader%>" == "yes" && "<%=leaderindex%>" != document.forms[0].hidserial.value && document.forms[0].txt_leadbank.value=="1")
		{
			alert("Leader option is already selected");
			document.forms[0].txt_leadbank.focus();
			return false;
		}
		
	}
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_consortium.jsp";
	document.forms[0].hidBeanMethod.value="updateConsortium";
	document.forms[0].hidBeanGetMethod.value="getConsortium";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getConsortium";
		document.forms[0].hidBeanId.value="mmrcommon";
		document.forms[0].action=appURL+"action/mon_consortium.jsp";	
		document.forms[0].submit();
	}	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value="Delete";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="mmrcommon";
	document.forms[0].hidSourceUrl.value="/action/mon_consortium.jsp";
	document.forms[0].hidBeanMethod.value="updateConsortium";
	document.forms[0].hidBeanGetMethod.value="getConsortium";	
	document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}

function selectValues(val1,val2, val3, val4, val5, val6, val7, val8, val9,val10, val11, val12,val13,val14,val15)
{
 
	document.forms[0].txt_bankname.value =val2;
	document.forms[0].txt_branch.value=val3;
	document.forms[0].txt_sharepercent.value=val4;
	document.forms[0].txt_assetclasification.value=val5;
	document.forms[0].txt_fundbasedname.value=val6;
	document.forms[0].txt_fundbasedamount.value=val7;
	document.forms[0].txt_nonfundbasedname.value=val8;
	document.forms[0].txt_nonfundbasedamount.value=val9;
	document.forms[0].txt_overdue.value=val10;
	document.forms[0].txt_remarks.value=val11;
	document.forms[0].txt_leadbank.value=val12;
	document.forms[0].hidsno.value =val1;
	document.forms[0].txt_nonfundsharepercent.value=val13;
	document.forms[0].txt_fundsharepercent.value=val14;
	document.forms[0].hidserial.value=val15;
	if(document.forms[0].statusflag.value=="O" )
	{
		disableCommandButtons(true,false,false,true,true,false); 
	}

}

function disableCommandButtons(cmdnew,cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
		document.forms[0].cmdnew.disabled =cmdnew;
		document.forms[0].cmdedit.disabled=cmdedit;
		document.forms[0].cmddelete.disabled=cmddelete;
		document.forms[0].cmdsave.disabled=cmdsave;
		document.forms[0].cmdcancel.disabled=cmdcancel;
		document.forms[0].cmdclose.disabled=cmdclose;
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

function callCalender(fname)
{
	 showCal(appURL,fname);
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
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placevalues()">
<form name="frmdocumentregister" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="normal">
	<tr>
		<td class="page_flow">Home-&gt;	Monitoring-&gt; Monthly Monitoring Reports-&gt; Consortium-&gt;
		Borrower Info-&gt; Consortium Details</td>
	</tr>
</table>
<lapschoice:MonthlyMonitor />
<lapschoice:MonConsortiumTag pageid="1" />
<br>
	<table width="95%" border="0" cellspacing="0" cellpadding="2" class="outertable">
		<tr>
			<td>
			<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
					<td>
					<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
						<tr  align="center">
							<td colspan="11" align="right"><b>(Rs. in Crore)</b></td>
						</tr>
						<tr class="dataheader" align="center">
							<td colspan="11"><b>Consortium Details(multiple)</b></td>
						</tr>
						<tr class="dataheader">
							<td width="8%">Name of the Bank<span class="mantatory">*&nbsp;</span></td>
							<td width="12%">Bank / Branch</td>


							<td width="6%">
							<div align="center">% share</div>
							</td>
							<td width="8%">Asset classification</td>

							<td colspan="2">
							<div align="center">% share</div>
							</td>
							<td colspan="2">
							<div align="center">Limit</div>
							</td>
							<td width="14%">Overdue</td>
							<td width="11%">Remarks</td>
							<td width="26%">Whether Lead bank</td>
						</tr>
						<tr class="dataheader">
							<td width="8%">&nbsp;</td>
							<td width="12%">&nbsp;</td>
							<td width="6%">&nbsp;</td>
							<td width="8%">&nbsp;</td>
							<td width="4%">Fund based</td>

							<td width="3%">Non Fund based</td>
							
                  <td width="4%">Fund based </td>
							
                  <td width="4%">Non-fund based </td>
							<td width="14%">&nbsp;</td>
							<td width="11%">&nbsp;</td>
							<td width="26%">&nbsp;</td>
						</tr>
						<tr class="datagrid">
							<td width="8%"><select name="txt_bankname">
								<option value="0">--select--</option>
								<option value="1">Our Bank</option>
								<option value="2">Other Bank</option>
							</select></td>
							<td width="12%"><input type="text" name="txt_branch"></td>

							<td width="6%"><input type="text" name="txt_sharepercent"
								size="7"
								onBlur="roundtxt(txt_sharepercent);checkPercentage(this)"
								onKeyPress="allowNumber(this)"></td>

							<td width="8%"><select name="txt_assetclasification" tabindex="1">
								<option value="0">--select--</option>
								<lapschoice:StaticDataNewTag apptype="31" />
							</select></td>
							<td width="4%"><input type="text" name="txt_fundsharepercent"
								size="7"
								onBlur="roundtxt(txt_fundsharepercent);checkPercentage(this)"
								onKeyPress="allowNumber(this)"></td>
							<td width="4%"><input type="text" name="txt_nonfundsharepercent"
								size="7"
								onBlur="roundtxt(txt_nonfundsharepercent);checkPercentage(this)"
								onKeyPress="allowNumber(this)"></td>
							<td width="3%"><input type="hidden" name="txt_fundbasedname"
								size="10" onKeyPress="notAllowSplChar()"> <lapschoice:CurrencyTag
								name="txt_fundbasedamount" value='' maxlength="15" /></td>
							<td width="4%"><input type="hidden" name="txt_nonfundbasedname"
								size="10" onKeyPress="notAllowSplChar()"> <lapschoice:CurrencyTag
								name="txt_nonfundbasedamount" value='' maxlength="15" /></td>
							<td width="4%"><lapschoice:CurrencyTag name="txt_overdue"
								value='' maxlength="15" size="10" /></td>
							<td width="14%"><textarea name="txt_remarks"
								onKeyPress="textlimit(this,3499)" onKeyUp="textlimit(this,3499)"></textarea></td>
							<td width="11%"><select name="txt_leadbank">
								<option value="0">select</option>
								<option value="1">Yes</option>
								<option value="2">No</option>
							</select></td>
						</tr>
						<tr class="dataheader">
							<td width="8%">&nbsp;</td>
							<td width="12%">&nbsp;</td>
							<td width="6%">&nbsp;</td>
							<td width="8%">&nbsp;</td>
							<td width="4%">&nbsp;</td>
							<td width="3%">&nbsp;</td>
							<td width="4%">&nbsp;</td>
							<td width="4%">&nbsp;</td>
							<td width="14%">&nbsp;</td>
							<td width="11%">&nbsp;</td>
							<td width="11%">&nbsp;</td>
						</tr>
					</table>
					</td>
					</tr>
			</table>
			</td>
		</tr>
		</table>
		<br>
		<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
		<br>		
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
					<td>
					<table width="98.3%" border="0" cellspacing="1" cellpadding="3" class="outertable">
						<tr class="dataheader">
							<td width="3%" align="center"></td>
							<td width="10%" align="center"><b>Name of the Bank</b></td>
							<td width="11%" align="center"><b>Branch</b></td>
							<td width="11%" align="center"><b>Share (%)</b></td>
							<td width="11%" align="center"><B>% Fund Based share</B></td>
							<td width="11%" align="center"><B>% Non Fund Based share</B></td>
							<td width="11%" align="center"><B>Asset classification</B></td>
							<td width="11%" align="center"><b>Fund based Amount</b></td>
							<td width="11%" align="center"><b>Non-fund Amount</b></td>
						</tr>
			<%arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
						<tr class="datagrid">
							<td width="3%"><input type="radio" style="border:none"
								name="radiobutton" value="radiobutton"
								onClick="javascript:selectValues(
												'<%=Helper.correctNull((String)arrCol.get(0))%>',
												'<%=Helper.correctNull((String)arrCol.get(1))%>',
											
												'<%=Helper.correctNull((String)arrCol.get(2))%>',
												'<%=Helper.correctNull((String)arrCol.get(3))%>',
												'<%=Helper.correctNull((String)arrCol.get(4))%>',
												'<%=Helper.correctNull((String)arrCol.get(5))%>',
												'<%=Helper.correctNull((String)arrCol.get(6))%>',
												'<%=Helper.correctNull((String)arrCol.get(7))%>',
												'<%=Helper.correctNull((String)arrCol.get(8))%>',
												'<%=Helper.correctNull((String)arrCol.get(9))%>',
												'<%=Helper.replaceForJavaScriptString((String)arrCol.get(10))%>',
												'<%=Helper.correctNull((String)arrCol.get(11))%>',
												'<%=Helper.correctNull((String)arrCol.get(13))%>',
												'<%=Helper.correctNull((String)arrCol.get(14))%>',<%=i+1%>)">
							</td>
							<%String strbankname = "";
					String strbank = Helper.correctNull((String) arrCol.get(1));
					if (strbank.equalsIgnoreCase("1")) {
						strbankname = "Our Bank";
					} else if (strbank.equalsIgnoreCase("2")) {
						strbankname = "Other Bank";
					}%>
							<td width="10%" >&nbsp;<%=strbankname%></td>
							<td width="11%" >&nbsp;<%=Helper.correctNull((String) arrCol.get(2))%></td>
							<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
							<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(14))%></td>
							<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(13))%></td>
							<td width="11%" >&nbsp;<%=Helper.correctNull((String) arrCol.get(12))%></td>
							<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(6))%></td>
							<td width="11%" align="right">&nbsp;<%=Helper.correctNull((String) arrCol.get(8))%></td>
						</tr>
						<%}}%>

					</table>
					</td>
				</tr>
			</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidsno"> 
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("cbsid"))%>">
<input type="hidden" name="mon_year" value="<%=Helper.correctNull((String)request.getParameter("mon_year"))%>">
<input type="hidden" name="mon_month" value="<%=Helper.correctNull((String)request.getParameter("mon_month"))%>">
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="hidserial"></form>
</body>
</html>
