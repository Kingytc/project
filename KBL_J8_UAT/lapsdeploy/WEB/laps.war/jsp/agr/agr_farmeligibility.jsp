<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<html>
<head>
<title>Appraisal - ELIGIBILITY Calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strAction ="<%=Helper.correctNull((String)hshValues.get("hidAction"))%>";
var totnetincomee="<%=Helper.correctNull((String)hshValues.get("totnetincomee"))%>";
var totnetincomep="<%=Helper.correctNull((String)hshValues.get("totnetincomep"))%>";
var totnetincome="<%=Helper.correctNull((String)hshValues.get("totnetincome"))%>";
//var totmaintenance="<%//=Helper.correctNull((String)hshValues.get("totmaintenance"))%>";
var totcustomerservice="<%=Helper.correctNull((String)hshValues.get("totcustomerservice"))%>";
var totnetincyear="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>";
var TotalExp="<%=Helper.correctNull((String)hshValues.get("Totalexpenset"))%>";


/*function callLink(page,bean,method)
{	
	document.forms[0].hidAction.value="";
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
} */



function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}
	
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

function doSave()
{	
	/*enableButtons( true, false, false, true, true);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanGetMethod.value="getfarmemiData";
	document.forms[0].hidSourceUrl.value="/action/agr_farmeligibility.jsp";	
	document.forms[0].submit(); */
}

function doEdit()
{
	/*disablefields(false);	
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true; */
	
}

function doCancel()
{
	 /* if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	} */
}

function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
	}
}

function onloading()
{	 
	document.forms[0].cmdsave.disabled=true;;
	disablefields(true);
}

function enableButtons( bool2, bool3, bool4,bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool6; 
}

</SCRIPT>

</head>
<body onLoad="onloading()">
<form name="appform" method="post" action="" class="normal">

		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"
					align="center" class="outertable border1">
					<tr>
						<td>

						<table width="98%" border="0" cellspacing="0" cellpadding="2"
							align="center" class="outertable">
							<tr>
								<td>

								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                          <tr> 
                            <td valign="top"> 
                            
                          <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
															
                            <tr> 
                              <td colspan="3">Total 
                                acerage to be covered (Own + Family Holding + 
                                Leased/Share cropper ) </td>
                              <td width="14%"> 
                                <input type="text" name="ownmemacre" size="25"
									readonly style="text-align:right"
									value="<%=Helper.correctNull((String)hshValues.get("ownfamilyacre"))%>"
									onKeyPress="allowNumber(this)">
                                (Acres) 
                              </td>
                              <td width="5%">&nbsp;</td>
                              <td width="30%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="6"><b>No. of hours to be used</b></td>
                            </tr>
                            <tr> 
                              <td colspan="2">On 
                                Farm Operations</td>
                              <td width="24%"> 
                                <input type="text" name="customusage" size="25"
									readonly style="text-align:right"
									value="<%=Helper.correctNull((String)hshValues.get("ownfamilymachine"))%>"
									onKeyPress="allowNumber(this)">
                              </td>
                              <td width="14%">&nbsp;</td>
                              <td width="5%">&nbsp;</td>
                              <td width="30%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="2">Off 
                                Farm Operations</td>
                              <td width="24%"> 
                                <input type="text" name="ownmemmachine" size="25"
									readonly style="text-align:right"
									value="<%=Helper.correctNull((String)hshValues.get("cususage"))%>"
									onKeyPress="allowNumber(this)">
                              </td>
                              <td width="14%"></td>
                              <td width="5%">&nbsp;</td>
                              <td width="30%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td colspan="2">Total</td>
                              <td width="24%"> 
                                <input type="text" name="totowncususage" size="25"
									readonly style="text-align:right"
									value="<%=Helper.correctNull((String)hshValues.get("totowncusmachin"))%>"
									onKeyPress="allowNumber(this)">
                              </td>
                              <td width="14%"></td>
                              <td width="5%">&nbsp;</td>
                              <td width="30%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="22%">Net 
                                Income Before Development</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="24%"><lapschoice:CurrencyTag name="totnetincomee" size="15"
											value='<%=Helper.correctNull((String)hshValues.get("totnetincome_bm"))%>'	/> 
                                <b>(A1)</b> 
                                </td>
                              <td width="22%">Net 
                                Income After Development</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="30%"><lapschoice:CurrencyTag name="totnetincomep" size="15"
											value='<%=Helper.correctNull((String)hshValues.get("totnetincome_am"))%>'/> 
                                <b>(A2)</b> 
                                </td>
                            </tr>
                            <tr> 
                              <td width="22%">Land 
                                Revenue</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_landrevenuebm" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("landrevenue_am"))%>'/> 
                              </td>
                              
                              <td width="22%">Land 
                                Revenue</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_landrevenueam" size="15" 
							   value='<%=Helper.correctNull((String)hshValues.get("landrevenue_am"))%>'/> 
                              </td>
                            </tr>
                            <tr> 
                              <%--<td width="22%">Interest 
                                On Crop Loan</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_intcroploanbm" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_interest_bm"))%>'/> 
                              </td>--%>
                              <td>Interest 
                                On Crop Loan</td>
                              <td><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td><lapschoice:CurrencyTag name="totnetincomee" size="15"
											value='<%=Helper.correctNull((String)hshValues.get("agr_interest_bm"))%>'	/> 
                                </td>
                              <td width="22%">Interest 
                                On Crop Loan</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_intcroploan" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_interest_am"))%>'/> 
                              </td>
                            </tr>
                            <tr> 
                              <%-- <td width="22%">Cost 
                                of Maintanence of bullocks </td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_costbullockbm" size="15" 
							   value='<%=Helper.correctNull((String)hshValues.get("agr_bullock_cost_bm"))%>'/> 
                              </td>--%>
                              <td>Cost of 
                                Maintanence of bullocks </td>
                              <td><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td><lapschoice:CurrencyTag name="totnetincomee" size="15"
											value='<%=Helper.correctNull((String)hshValues.get("agr_bullock_cost_bm"))%>'	/> 
                                </td>
                              <td width="22%">Cost 
                                of Maintanence of bullocks </td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_costbullockam" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_bullock_cost_am"))%>'/> 
                              </td>
                            </tr>
                            <tr> 
                              <%--<td width="22%">Cost 
                                of fuel for Machinery/year</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_costfuelbm" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_fuel_cost_bm"))%>'/> 
                              </td>--%>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td width="22%">Cost 
                                of fuel for Machinery/year</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_costfuelam" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_fuel_cost_am"))%>'/> 
                              </td>
                            </tr>
                            <tr> 
                              <%--<td width="22%">Driver's 
                                Salary </td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_driversalbm" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_salary_bm"))%>'/> 
                              </td>--%>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td width="22%">Driver's 
                                Salary </td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_driversalam" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_salary_am"))%>'/> 
                              </td>
                            </tr>
                            <tr> 
                              <%--<td width="22%">Insurance 
                                and Taxes/year</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_insurencebm" size="15" 
							  value='<%=Helper.correctNull((String)hshValues.get("agr_insurence_bm"))%>'/> 
                              </td>--%>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td width="22%">Insurance 
                                and Taxes/year</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_insurenceam" size="15" 
							  value='<%=Helper.correctNull((String)hshValues.get("agr_insurence_am"))%>'/> 
                              </td>
                            </tr>
                            <tr> 
                              <%--<td width="22%">Cost 
                                of Repairs of Machinery/year</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_costrepairbm" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_repair_cost_bm"))%>'/> 
                              </td>--%>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td width="22%">Cost 
                                of Repairs of Machinery/year</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_costrepairam" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_repair_cost_am"))%>'/> 
                              </td>
                            </tr>
							<tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td width="22%">Others</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_costrepairam" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("agr_other_cost_am"))%>'/> 
                              </td>
                            </tr>
							
                            <tr> 
                              <td width="22%"><b>Total Expenses</b></td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_expensesbm" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("Totalexpense_bm"))%>' /> 
                                <b>(B1)</b> 
                              </td>
                              <td width="22%"><b>Total Expenses</b></td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_expensesam" size="15"  
							  value='<%=Helper.correctNull((String)hshValues.get("Totalexpense_am"))%>'/> 
                                <b>(B2)</b> 
                              </td>
                            </tr>
                            <!-- <tr> 
                                <td width="37%"> 
                                  Maintenance and Repair charges including fuel 
                                  charges per year</td>
                                <td width="3%"><b><%//=ApplicationParams.getCurrency()%></b></td>
                                <td width="21%"> 
                                  <input type="text" name="totmaintenance" size="25"
																	readonly style="text-align:right" value="<%//=Helper.correctNull((String)hshValues.get("totmaintenance"))%>"
																	onKeyPress="allowNumber(this)" onBlur="">
                                 </td>
                                <td width="12%">&nbsp;</td>
                                <td width="27%">&nbsp;</td>
                              </tr> -->
                            <tr> 
                              <td>Net Income 
                                From Hiring(Customer Service)</td>
                              <td><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="totcustomerservicebm" size="15"
												value='0.00' /> 
                                <b>(C1)</b> 
                                </td>
                              <td>Net Income 
                                From Hiring(Customer Service)</td>
                              <td><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="totcustomerserviceam" size="15"
												value='<%=Helper.correctNull((String)hshValues.get("totcustomerservice_am"))%>' /> 
                                <b>(C2)</b> 
                                </td>
                            </tr>
                            <tr> 
                              <%--<td>Income From 
                                Other Sources</td>
                              <td><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_netamt"
																	 onBlur="calTotalNetAmount()" size="20"
																	value='<%=Helper.correctNull((String)hshValues.get("netamt"))%>'/> 
                                 <b>(F1)</b> 
                                </td>--%>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
							  <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <%--<td>Income From 
                                Other Sources</td>
                              <td><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="txt_netamt"
																	 onBlur="calTotalNetAmount()" size="20"
																	value='<%=Helper.correctNull((String)hshValues.get("netamt"))%>'/> 
                                 <b>(F2)</b> 
                                </td>--%>
                            </tr>
                            <tr> 
                              <td width="22%">Net 
                                Incremental Income</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"><lapschoice:CurrencyTag name="totnetincrement" size="15"
												value='<%=Helper.correctNull((String)hshValues.get("netincrementalinc_bm"))%>'/> 
                                <b>(A1-B1+C1=G1)</b> 
                              </td>
                              <td width="22%">Net 
                                Incremental Income</td>
                              <td width="5%"><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"><lapschoice:CurrencyTag name="totnetincrement" size="15"
												value='<%=Helper.correctNull((String)hshValues.get("netincrementalinc_am"))%>'/> 
                                <b>(A2-B2+C2=G2)</b> 
                              </td>
                            </tr>
                            <tr> 
                              <td>Total Net 
                                Income Per Year</td>
                              <td><b><%=ApplicationParams.getCurrency()%></b></td>
                              <td width="14%"> <lapschoice:CurrencyTag name="totnetincyear" size="20"
												value='<%=Helper.correctNull((String)hshValues.get("incrementalincome"))%>' /> 
                                 <b>(G2-G1)</b></td>
                              <td width="5%">&nbsp;</td>
                              <td width="5%">&nbsp;</td>
                              <td width="30%">&nbsp;</td>
                            </tr>
                          </table>
                          </td>
                          </tr>
  
                        <tr>
                           <td valign="top"><table width="5%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="outertable border1">
                                <tr> 
                                  <td valign="top"> <table width="12%" border="0" align="center" cellpadding="0"
											cellspacing="0" bordercolorlight="#FFFFFB"
											bordercolordark="#DEDACF" >
                                      <tr> 
                                        <td> <table width="100%" align="center" border="0" cellspacing="0"	cellpadding="2">
                                            <tr valign="top"> 
                                           
                                           <td><input type="button" name="cmdclose"
															value="Close"
															style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
															onClick="doClose()"></td>
											 <td><input type="hidden" name="cmdsave"
											value="Save"
											style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											onClick="doClose()"></td>
                                            </tr>
                                          </table></td>
                                      </tr>
                                    </table></td>
                              </table></td>
                          </tr>
                        </table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:agrihiddentag />
<input type="button" name="cmdapply" value="Save" disabled style="visibility: hidden;">
</form>
</body>
</html>
