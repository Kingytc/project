<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
%>
<html>
<head>
<title>Operational Viability</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perloandetails.js"></script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordflag = "<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRecordflag.value = varRecordflag;
 	document.forms[0].hidBeanId.value="mastapplicant";		
	document.forms[0].hidBeanMethod.value="updateOpeViability";
	document.forms[0].hidBeanGetMethod.value="getOpeViability";
	document.forms[0].hidSourceUrl.value="/action/operationalviability.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function calculate()
{
	var vardays=document.forms[0].txtdays_rd_mon.value;
	var vardaykms=document.forms[0].txtno_km_day.value;
	var varfareperkm=document.forms[0].txtfare_perkm.value;
	var varavgincpermth=0;
	var varothrinc=document.forms[0].txtother_incom.value;
	var vartotincome=0;
	var varfuelcostperlit=document.forms[0].txtfuel_perlitre.value;
	var varkmperlit=document.forms[0].txtfuel_perlitre_km.value;
	var varfuelcostpermth=0;
	var vartaxes=document.forms[0].txtmotor_tax.value;
	var varinsurance=document.forms[0].txtinsu_premium.value;
	var varrent=document.forms[0].txtgarage_rent.value;
	var vardepriciation=document.forms[0].txtdepreciation.value;
	var varinterest=document.forms[0].txtint_borrowings.value;
	var varmaintenance=document.forms[0].txtmaintain_exp.value;
	var varoilspareexp=document.forms[0].txtcost_oil_spares.value;
	var varstaffsalary=document.forms[0].txtstaff_salary.value;
	var varoperatordrawing=document.forms[0].txtdraw_oper.value;
	var varothrexpenses=document.forms[0].txtothers.value;
	
	var vartotexp=0;
	var varsurplus=0;
	var varinctaxes=document.forms[0].txtincom_tax.value;
	var varnetsurplus=0;
	var varcashaccruals=0;
	var varinstallment=document.forms[0].txtInstalment_TermLoan.value;
	var vardscr=0;
		
	if(vardays=="")vardays=0;
	if(vardaykms=="")vardaykms=0;
	if(varfareperkm=="")varfareperkm=0;
	if(varothrinc=="")varothrinc=0;	
	if(varfuelcostperlit=="")varfuelcostperlit=0;
	if(varkmperlit=="")varkmperlit=0;
	if(vartaxes=="")vartaxes=0;
	if(varinsurance=="")varinsurance=0;
	if(varrent=="")varrent=0;
	if(vardepriciation=="")vardepriciation=0;
	if(varinterest=="")varinterest=0;
	if(varmaintenance=="")varmaintenance=0;
	if(varoilspareexp=="")varoilspareexp=0;
	if(varstaffsalary=="")varstaffsalary=0;
	if(varoperatordrawing=="")varoperatordrawing=0;
	if(varothrexpenses=="")varothrexpenses=0;
	if(varinctaxes=="")varinctaxes=0;
	if(varinstallment=="")varinstallment=0;
	
	varavgincpermth=eval(vardays)*eval(vardaykms)*eval(varfareperkm);
	vartotincome=eval(varavgincpermth)+eval(varothrinc);
	if(varkmperlit!=0)
		varfuelcostpermth=(eval(vardays)*eval(vardaykms)*eval(varfuelcostperlit))/eval(varkmperlit);
	else
		varfuelcostpermth=0;
		
	vartotexp=eval(varfuelcostpermth)+eval(vartaxes)+eval(varinsurance);
	vartotexp=eval(vartotexp)+eval(varrent)+eval(vardepriciation)+eval(varinterest);
	vartotexp=eval(vartotexp)+eval(varmaintenance)+eval(varoilspareexp)+eval(varstaffsalary);
	vartotexp=eval(vartotexp)+eval(varoperatordrawing)+eval(varothrexpenses);
	
	varsurplus=eval(vartotincome)-eval(vartotexp);
	
	varnetsurplus=eval(varsurplus)-eval(varinctaxes)+eval(varinterest);
	
	varcashaccruals=eval(varnetsurplus)+eval(vardepriciation);
	
	var vartemp=eval(varinterest)+eval(varinstallment);
	if(vartemp!=0)
		vardscr=eval(varcashaccruals)/vartemp;
	else
		vardscr=0;
	
	document.forms[0].txtave_incom.value=varavgincpermth;
	roundtxt(document.forms[0].txtave_incom);
	
	document.forms[0].txttot_incom.value=vartotincome;
	roundtxt(document.forms[0].txttot_incom);
	
	document.forms[0].txtfuel_cost_month.value=varfuelcostpermth;
	roundtxt(document.forms[0].txtfuel_cost_month);

	document.forms[0].txttot_exp.value=vartotexp;
	roundtxt(document.forms[0].txttot_exp);
	
	document.forms[0].txtsurplus.value=varsurplus;
	roundtxt(document.forms[0].txtsurplus);
	
	document.forms[0].txtNet_surplus.value=varnetsurplus;
	roundtxt(document.forms[0].txtNet_surplus);
	
	document.forms[0].intborrowings21.value=varinterest;
	roundtxt(document.forms[0].intborrowings21);
	
	document.forms[0].txtdepreciation_add.value=vardepriciation;
	roundtxt(document.forms[0].txtdepreciation_add);
	
	document.forms[0].txtNet_cash_accruals.value=varcashaccruals;
	roundtxt(document.forms[0].txtNet_cash_accruals);
	
	document.forms[0].txtDSCR.value=vardscr;
	roundtxt(document.forms[0].txtDSCR);
}

function onloading()
{	 
	/*if(document.forms[0].appstatus.value =='Open/Pending' || )
	{ 
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}*/
	disableFields(true);
	callDSCR();
	calculate();
}

function callDSCR()
{
   	var netprofit=document.forms[0].txtNet_cash_accruals.value;
	var interestonborrowings=document.forms[0].txtint_borrowings.value;
	var Insttermloan=document.forms[0].txtInstalment_TermLoan.value;
	if(netprofit=="")
	{
		netprofit=0.00;
	}
	if(interestonborrowings=="")
	{
		interestonborrowings=0.00;
	}
	if(Insttermloan=="")
	{
		Insttermloan=0.00;
	}
	var numerator=eval(netprofit);
	
	
	var denominator=eval(Insttermloan)+eval(interestonborrowings);
	
	if(numerator=="")
	{
	numerator=0.00;
	}
	if(denominator!="" ||denominator!="0.00")
	{
	var dscr=eval(numerator)/eval(denominator);
	}


if(dscr==""  || dscr=="Infinity.00")
	{
	dscr=0.00;
	}
document.forms[0].txtDSCR.value=eval(NanNumber(dscr));
roundtxt(document.forms[0].txtDSCR);
}
function doClose()
	{
	var con=ConfirmMsg('100');
	if(con)
		{
		window.close();
		}
	}

function doCancel()
	{
	if(ConfirmMsg(102))
		{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getOpeViability";
		document.forms[0].action=appUrl+"action/operationalviability.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
		}
	}

function callLink(page,bean,method)
	{	
	if (document.forms[0].cmdapply.disabled)
		{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
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
	document.forms[0].txtDSCR.readOnly=true;
	}

function disableCommandButtons(val)
	{	 
	if(val=="edit")
		{		  
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=true;	 
		disableFields(false);
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
		}
	document.forms[0].txttot_incom.readOnly=true;
	document.forms[0].txtfuel_cost_month.readOnly=true;
	document.forms[0].txttot_exp.readOnly=true;
	document.forms[0].txtsurplus.readOnly=true;
	document.forms[0].intborrowings21.readOnly=true;
	document.forms[0].txtave_incom.readOnly=true;
	document.forms[0].txtNet_surplus.readOnly=true;
	document.forms[0].txtdepreciation_add.readOnly=true;
	document.forms[0].txtNet_cash_accruals.readOnly=true;
	}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable linebor">
					<tr class="dataheader">
						<td width="4%" nowrap="nowrap"><b>S No. </b></td>
						<td width="69%"><b>Operational Viability :</b></td>
						<td width="27%" align="center">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center"><b>1</b></td>
						<td colspan="2" ALIGN="center"><strong>Income per
						month</strong><b>(All values should be taken on Monthly basis)</b></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;i) Number of days in a month the
						vehicle will be on road</td>
						<td valign="middle" align="center" width="27%">&nbsp;
						&nbsp;&nbsp;&nbsp; <input type="text" name="txtdays_rd_mon"
							onKeyPress="allowNumber(this)" size="16" maxlength="2"
							style="text-align: right"
							value="<%=Helper.correctNull((String) hshValues
									.get("days_rd_mon"))%>"
							onBlur="calculate()"></td>
					</tr>
					<tr class="datagrid">
						<td height="23" width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;ii) Number of Kilometers it will
						run per day</td>
						<td valign="middle" align="center" width="27%">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="text"
							name="txtno_km_day" onKeyPress="allowNumber(this)" size="16"
							maxlength="4" style="text-align: right"
							value="<%=Helper.correctNull((String) hshValues.get("no_km_day"))%>"
							onBlur="calculate()"></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;iii) Fare / rate per Kilometer</td>
						<td valign="middle" align="center" width="27%"><b>Rs. </b> <lapschoice:CurrencyTag
							name="txtfare_perkm" size="16" maxlength="3"
							value='<%=Helper.correctNull((String)hshValues.get("fare_perkm"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;iv) Average income per month</td>
						<td valign="middle" align="center" width="27%"><b>Rs. </b> <lapschoice:CurrencyTag
							name="txtave_incom" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("ave_incom"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;v) Any other (out side) income</td>
						<td valign="middle" align="center" width="27%"><b>Rs. </b><lapschoice:CurrencyTag
							name="txtother_incom" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("other_incom"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="dataheader">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td align='right' width="69%">&nbsp;<b> Total income</b></td>
						<td align="center" width="27%"><b>&nbsp;Rs.&nbsp; </b><lapschoice:CurrencyTag
							name="txttot_incom" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("tot_incom"))%>'
							onBlur="calculate()" /> &nbsp;</td>
					</tr>
					<tr class="dataheader">
						<td width="4%" ALIGN="center"><b>2</b></td>
						<td colspan="2" ALIGN="center"><strong>Expenses per
						month</strong><b>(All values should be taken on Monthly basis)</b></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;Cost of fuel per litre</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtfuel_perlitre" size="16" maxlength="3"
							value='<%=Helper.correctNull((String)hshValues.get("fuel_perlitre"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;No of kilometers the vehicle will
						run per litre</td>
						<td valign="middle" align="center" width="27%"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>
						<input type="text" name="txtfuel_perlitre_km"
							onKeyPress="allowNumber(this)" size="16" maxlength="3"
							style="text-align: right"
							value="<%=Helper.correctNull((String) hshValues
							.get("fuel_perlitre_km"))%>"
							onBlur="calculate()"></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;Fuel cost per month</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtfuel_cost_month" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("fuel_cost_month"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;i) Motor and other municipal
						taxes</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtmotor_tax" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("motor_tax"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;ii) Insurance premium</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtinsu_premium" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("insu_premium"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;iii) Garage rent</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtgarage_rent" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("garage_rent"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;iv) Depreciation</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtdepreciation" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("depreciation"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;v) Interest on borrowings</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtint_borrowings" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("int_borrowings"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp; vi) Maintenance expenses</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtmaintain_exp" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("maintain_exp"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;vii) Cost of oil, spares, etc</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtcost_oil_spares" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("cost_oil_spares"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;viii) Staff salary</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtstaff_salary" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("staff_salary"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;ix) Drawings of the operator</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtdraw_oper" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("draw_oper"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;x) Others</td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtothers" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("others"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="dataheader">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%"><strong>Total expenses &nbsp; </strong></td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txttot_exp" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("tot_exp"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="dataheader">
						<td width="4%" ALIGN="center"><b>3</b></td>
						<td width="69%"><b>Surplus : </b></td>
						<td valign="middle" align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtsurplus" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("surplus"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;&nbsp;Income tax, if any</td>
						<td align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtincom_tax" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("incom_tax"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;&nbsp;Interest on borrowings</td>
						<td align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="intborrowings21" size="16" maxlength="12" value=""
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp;Net surplus</td>
						<td align="center" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtNet_surplus" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("Net_surplus"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;&nbsp; Depreciation added back</td>
						<td align="center" valign="middle" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtdepreciation_add" size="16" maxlength="12"
							value='<%=Helper.correctNull((String)hshValues.get("depreciation_add"))%>'
							onBlur="calculate()" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;</td>
						<td align="center" valign="middle" width="27%">&nbsp;</td>
					</tr>
					<tr class="dataheader">
						<td width="4%" ALIGN="center"><b>4</b></td>
						<td width="69%"><strong>Net cash accruals</strong></td>
						<td align="center" valign="middle" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtNet_cash_accruals"
							value='<%=Helper.correctNull((String)hshValues.get("Net_cash_accruals"))%>'
							size="16" maxlength="12" /></td>
					</tr>
					<tr class="datagrid">
						<td width="4%" ALIGN="center">&nbsp;</td>
						<td width="69%">&nbsp;</td>
						<td width="27%" ALIGN="center">&nbsp;</td>
					</tr>
					<tr class="dataheader">
						<td width="4%" ALIGN="center"><b>5</b></td>
						<td width="69%"><b>Instalments of Term Loan</b></td>
						<td align="center" valign="middle" width="27%"><b>Rs.</b> <lapschoice:CurrencyTag
							name="txtInstalment_TermLoan"
							value='<%=Helper.correctNull((String)hshValues.get("instalments_termloan"))%>'
							size="16" maxlength="12" onBlur="calculate()" /></td>
					</tr>
					<tr align="center" class="datagrid">
						<td width="4%">&nbsp;</td>
						<td width="69%">&nbsp;</td>
						<td align="center" valign="middle" width="27%">&nbsp;</td>
					</tr>
					<tr align="center" class="datagrid">
						<td width="4%">&nbsp;</td>
						<td width="69%"><b>DSCR</b></td>
						<td align="center" valign="middle" width="27%"><b>&nbsp;</b>
						<lapschoice:CurrencyTag name="txtDSCR" value='' size="16"
							maxlength="12" /></td>

					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId %>' /> <input type="hidden"
	name="hideditflag"> <input type="hidden" name="selsno" value="">
<input type="hidden" name="hidval"> <INPUT TYPE="hidden"
	name="page"> <input type="hidden" name="txtperapp_appid"
	value="<%=Helper.correctNull((String) hshValues.get("peremp_id"))%>">
<INPUT TYPE="hidden" name="radLoan" value="Y"></form>
</body>
</html>

