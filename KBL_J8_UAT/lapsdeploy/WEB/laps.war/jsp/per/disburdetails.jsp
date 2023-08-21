<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Disbursement Details</title>
<script language="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var sanction_amt="<%=Helper.correctNull((String)hshValues.get("sanction_amount"))%>";
var sanction_date="<%=Helper.correctNull((String)hshValues.get("sanction_date"))%>";
var app_status="<%=Helper.correctNull((String)hshValues.get("app_status"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function dayscalc(fromdt,todt)
{
	var fmonth = eval(fromdt.substring(3, 5)); 
	var fday = eval(fromdt.substring(0, 2));
	var fyear = eval(fromdt.substring(6, 10));
	var tmonth = eval(todt.substring(3, 5));
	var tday = eval(todt.substring(0, 2));
	var tyear = eval(todt.substring(6, 10));
	var totdays = (((eval(tday) + (eval(tmonth) * 30)) + (eval(tyear) * 365)) - ((eval(fday) + (eval(fmonth) * 30)) + (eval(fyear) * 365)));
	return totdays;
}

function chkdate(dat)
{
	if(dat.value.length ==  10)
	{		var diff=0;
		diff = dayscalc(curdate,dat.value);
		if(diff < 0)
		{
			alert("Date  should Greater than Current Date ");
			dat.value="";
	}
	}
}
function comparedate(date1,date2,text_box)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
		if(pgdt.value!="")
		{
			if(Date.parse(pgdt) < Date.parse(maxdt))
			{
				alert("Disbursement Date should be  Sanctioned Date or greater than Sanctioned Date");
				text_box.value="";
				text_box.focus();								
			}			
		}
}
function callTotal()
{
	var amt1=document.forms[0].stage1amt.value;
	var amt2=document.forms[0].stage2amt.value;
	var amt3=document.forms[0].stage3amt.value;
	var amt4=document.forms[0].stage5amt.value;
	var amt5=document.forms[0].stage6amt.value;
	if(amt1=="")
	{
		amt1="0";
	}
	if(amt2=="")
	{
		amt2="0";
	}
	if(amt3=="")
	{
		amt3="0";
	}
	if(amt4=="")
	{
		amt4="0";
	}
	if(amt5=="")
	{
		amt5="0";
	}
	var tot=eval(amt1)+eval(amt2)+eval(amt3)+eval(amt4)+eval(amt5);
	
	var stage1=eval(amt1); 
	var stage2=eval(stage1)+eval(amt2);
	var stage3=eval(stage2)+eval(amt3);
	var stage4=eval(stage3)+eval(amt4);
	var stage5=eval(stage4)+eval(amt5);
	
		if(eval(stage1)>eval(sanction_amt))
		{
			document.forms[0].stage1amt.value="0.00";
			
		}
		if(eval(stage2)>eval(sanction_amt))
		{
			document.forms[0].stage2amt.value="0.00";
		}
		if(eval(stage3)>eval(sanction_amt))
		{
			document.forms[0].stage3amt.value="0.00";
		}
		if(eval(stage4)>eval(sanction_amt))
		{
			document.forms[0].stage5amt.value="0.00";
		}
		if(eval(stage5)>eval(sanction_amt))
		{
			document.forms[0].stage6amt.value="0.00";
		}
	
	if(eval(tot)>eval(sanction_amt))
	{
		alert("Total Disbursement Amount Cannot be greater than Sanction Amount");

		return false;
	}
	document.forms[0].stage4amt.value=tot;
	roundtxt(document.forms[0].stage4amt);
	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		calldisable(true)
		document.forms[0].cmddelete.disabled = true;
		document.forms[0].cmdcancel.disabled = true;
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].cmdedit.disabled = false;
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getdisbursementdetails";
		document.forms[0].action=appURL+"action/disburdetails.jsp";
		document.forms[0].submit();
	}
}

function doDelete()
{
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidBeanId.value="perpropertydetails";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateDataDisbursement";
			document.forms[0].hidBeanGetMethod.value="getdisbursementdetails";
			document.forms[0].hidSourceUrl.value="/action/disburdetails.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
		
}

function placevalues()
{
	document.forms[0].stage1amt.value = "<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stage1amt"))))%>";
	document.forms[0].stage1dt.value = "<%=Helper.correctNull((String)hshValues.get("stage1dt"))%>";
	document.forms[0].stage2amt.value = "<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stage2amt"))))%>";
	document.forms[0].stage2dt.value = "<%=Helper.correctNull((String)hshValues.get("stage2dt"))%>";
	document.forms[0].stage3amt.value = "<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stage3amt"))))%>";
	document.forms[0].stage3dt.value = "<%=Helper.correctNull((String)hshValues.get("stage3dt"))%>";
	document.forms[0].stage4amt.value = "<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalamt"))))%>";
	document.forms[0].stage4dt.value = "<%=Helper.correctNull((String)hshValues.get("totaldt"))%>";
	document.forms[0].stage5amt.value = "<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stage4amt"))))%>";
	document.forms[0].stage5dt.value = "<%=Helper.correctNull((String)hshValues.get("stage4dt"))%>";
	document.forms[0].stage6amt.value = "<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stage5amt"))))%>";
	document.forms[0].stage6dt.value = "<%=Helper.correctNull((String)hshValues.get("stage5dt"))%>";
}

function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdclose.disabled = false;
}

function callOnload()
{
	
	calldisable(true);
}

function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
	
    }
	document.forms[0].appno.disabled=false;
	document.forms[0].appname.disabled=false;
	document.forms[0].appstatus.disabled=false;
	/*if(app_status=="pa")
	{
		document.forms[0].cmdedit.disabled = false;
	}
	else
	{
		document.forms[0].cmdedit.disabled = true;
	}	*/
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;	
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanMethod.value="updateDataDisbursement";
	document.forms[0].hidBeanGetMethod.value="getdisbursementdetails";
	document.forms[0].hidSourceUrl.value="/action/disburdetails.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
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

</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callOnload(); placevalues()">
<form name="colForm" method="post" class="normal"><jsp:include
	page="../share/help.jsp" flush="true"/>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td colspan="2"><b>Disbursement Details</b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td id="mainlnk" colspan="2"><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="55%" border="0" align="center" cellpadding="3" cellspacing="0" class="outertable linebor">
			<tr class="dataheader" align="center">
			<td width="30%">
			<b>Stages</b>
			</td>
			<td width="33%">
			<b>Disbursed
			Amount </b>
			</td>
			<td width="37%">
			<b>Disbursed
			On (DD/MM/YYYY)</b>
			</td>
			</tr>
			<tr class="datagrid">
				<td>First Stage </td>
				<td align="center">
				<lapschoice:CurrencyTag name="stage1amt"
					onBlur="callTotal()" onChange="callTotal()" size="16" maxlength="15" />
				</td>
				<td align="center">
				<table width="50%" border="0" align="center" class="outertable">
						<tr>
							<td><input type="text" name="stage1dt" size="12"
					onBlur="checkDate(this);comparedate(this.value,sanction_date,this)" maxlength="10" disabled="disabled">
					</td>
							<td>
							<a href="#" onClick="callCalender('stage1dt')"
							title="Click to view calender" border="0"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex=""></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr class="datagrid">
				<td>Second Stage </td>
				<td align="center">
				<lapschoice:CurrencyTag name="stage2amt"
					onBlur="callTotal()" onChange="callTotal()"size="16"	maxlength="15"/>
				</td>
				<td align="center">
				<table width="50%" border="0" align="center" class="outertable">
						<tr>
							<td><input type="text" name="stage2dt" size="12"
					onBlur="checkDate(this);comparedate(this.value,sanction_date,this)" maxlength="10">
							</td>
							<td>
							<a href="#" onClick="callCalender('stage2dt')"
							title="Click to view calender" border="0"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex=""></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr class="datagrid">
				<td>Third Stage </td>
				<td>
				<div align="center"><lapschoice:CurrencyTag name="stage3amt"
					onBlur="callTotal()" onChange="callTotal()" size="16" maxlength="15" /></div>
				</td>
				<td align="center">
				<table width="50%" border="0" align="center" class="outertable">
						<tr>
							<td>
							 <input type="text" name="stage3dt" size="12"
								onBlur="checkDate(this);comparedate(this.value,sanction_date,this)" maxlength="10">
							</td>
							<td>
							<a href="#" onClick="callCalender('stage3dt')"
							title="Click to view calender" border="0"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex=""></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr class="datagrid">
				<td>Fourth Stage </td>
				<td>
				<div align="center"><lapschoice:CurrencyTag name="stage5amt"
					onBlur="callTotal()" onChange="callTotal()" size="16" maxlength="15"/></div>
				</td>
				<td align="center">
				<table width="50%" border="0" align="center">
						<tr>
							<td>
							<input type="text" name="stage5dt" size="12"
							onBlur="checkDate(this);comparedate(this.value,sanction_date,this)" maxlength="10">
							</td>
							<td>
							<a href="#" onClick="callCalender('stage5dt')"
							title="Click to view calender" border="0"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex=""></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr class="datagrid">
				<td>Fifth Stage </td>
				<td>
				<div align="center"><lapschoice:CurrencyTag name="stage6amt"
					onBlur="callTotal()" onChange="callTotal()" size="16" maxlength="15"/></div>
				</td>
				<td align="center">
					<table width="50%" border="0" align="center" class="outertable">
						<tr>
							<td>
							<input type="text" name="stage6dt" size="12"
							onBlur="checkDate(this);comparedate(this.value,sanction_date,this)" maxlength="10">
							</td>
							<td>
							<a href="#" onClick="callCalender('stage6dt')"
							title="Click to view calender" border="0"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex=""></a>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr class="dataheader">
				<td>Total</td>
				<td  align="center">
				<input type="text" name="stage4amt"
					onkeypress="allowNumber(this)" size="16" maxlength="15" onblur="callTotal()"
					style="text-align:right">
				</td>
				<td align="center">
				<input type="hidden" name="stage4dt" size="12" maxlength="10">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' />
</form>
</body>
</html>
