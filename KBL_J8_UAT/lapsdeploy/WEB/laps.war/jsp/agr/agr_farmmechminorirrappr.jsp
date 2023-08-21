<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Appraisal - ELIGIBILITY Calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function doClose()
{
	if(ConfirmMsg('100'))
	{
	document.forms[0].target="_parent";
	document.forms[0].action=appURL+"action/retailpge.jsp";				
	document.forms[0].submit();
	}
		
}

function onloading()
{	  
	disablefields(true);
}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onLoad="onloading()">
<form name="appform" class="normal" method="post" action="">

						<table class="outertable border1" width="80%" align="center" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td valign="top">
								<table class="outertable" width="100%" border="0" align="center" cellspacing="0" cellpadding="4">
									<tr>
										<td width="30%">Net Income Before Development</td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td width="25%"><lapschoice:CurrencyTag name="totnetincomee"
											size="25"
											value='<%=Helper.correctNull((String)hshValues.get("totnetincome_bm"))%>' />
										<b>(A)</b></td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="30%">Net Income After Development</td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td width="25%"><lapschoice:CurrencyTag name="totnetincomep"
											size="25"
											value='<%=Helper.correctNull((String)hshValues.get("totnetincome_am"))%>' />
										<b>(B)</b></td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="30%"><b>Net Incremental Income </b></td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td nowrap="nowrap" width="25%"><lapschoice:CurrencyTag name="totnetincome"
											size="25"
											value='<%=Helper.correctNull((String)hshValues.get("totnetincome"))%>' />
										<b>(B-A=C)</b></td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="30%" nowrap="nowrap">Maintenance and Repair charges including Fuel
										/ Electricity charges per year</td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td width="25%"><lapschoice:CurrencyTag name="totmaintenance"
											size="25"
											value='<%=Helper.correctNull((String)hshValues.get("agr_elecworks"))%>' />
										<b>(D)</b></td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td>Net Income From Sale of Water</td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td><lapschoice:CurrencyTag name="totcustomerservice1"
											size="25"
											value='<%=Helper.correctNull((String)hshValues.get("totcustomerservice1"))%>' />
										<b>(E)</b></td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="30%">Income From Other Sources</td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td width="25%"><lapschoice:CurrencyTag name="txt_netamt"
											size="25"
											value='<%=Helper.correctNull((String)hshValues.get("agr_netIncomeIrrig"))%>' />
										<b>(F)</b></td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="30%">Expected Additional Income after proposed Land
										Development</td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td width="5%"><lapschoice:CurrencyTag name="" size="25"
											value='<%=Helper.correctNull((String)hshValues.get("agr_expect_addition"))%>' />
										<B>(G)</B></td>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="30%"><b>Net Income Per Year</b></td>
										<td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
										<td width="25%"><lapschoice:CurrencyTag name="totnetincyear"
											size="25"
											value='<%=Helper.correctNull((String)hshValues.get("incrementalincome"))%>' />
										<b>(C+E+F+G)-D</b></td>
										<td colspan="2">&nbsp;</td>
									</tr>
								</table></td></tr></table><br>
							<div align="center"><input type="button" name="cmdclose" value="Close"
											class="buttonClose" onClick="doClose()"></div>
							
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="button" name="cmdsave" style="visibility:hidden" disabled/>
</form>
</body>
</html>
