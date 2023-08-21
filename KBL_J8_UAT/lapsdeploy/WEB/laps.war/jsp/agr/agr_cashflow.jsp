<%@include file="../share/directives.jsp"%>
<%ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
			ArrayList vecyearlyincome = new ArrayList();

			int intyearsize = 0;
			if (hshValues != null) {
				vecyearlyincome = (ArrayList) hshValues.get("vecyearlyincome");
				intyearsize = Integer.parseInt(Helper
						.correctInt((String) hshValues.get("intyearsize")));
			}
			
			String stryearlyincome[] = new String[intyearsize];
			
			if (vecyearlyincome != null && vecyearlyincome.size() > 0) {
				for (int i = 0; i < vecyearlyincome.size() && i<intyearsize; i++) {

					stryearlyincome[i] = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecyearlyincome.get(i))));
				}
			} else {
				for (int i = 0; i < intyearsize; i++) {
					stryearlyincome[i] = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble("0")));
				}
			}

			%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var sanction_amt="<%=Helper.correctNull((String)hshValues.get("loan_recmdamt" ))%>" ;
var modintrate="<%=Helper.correctNull((String)hshValues.get("loan_modintrate" ))%>" ;
var varrepayyrs="<%=intyearsize%>";

function callCheckLoanAmt(pos)
{	
	var loanamt=document.forms[0].txt_loan[pos].value;	
	if(eval(loanamt) > eval(sanction_amt))
	{
		alert("Loan Amount cannot be greater than Eligible Loan Amount");
		document.forms[0].txt_loan[pos].value="0.00";
		document.forms[0].txt_loan[pos].focus();
		return;
	}
	
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}

function callOnload()
{
	disableFields(true);
	cashFlowCal();
}

function disableFields(one)
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

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecashflowData";
		document.forms[0].hidBeanGetMethod.value="getcashflowData";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_cashflow.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}

function doClose()
{
if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
	for(var i=0;i<document.forms[0].txt_netinc.length;i++)
	{
		var NetInterst=document.forms[0].txt_netint[i].value;
		var txt_principal=document.forms[0].txt_principal[i].value;
		var txt_int=document.forms[0].txt_int[i].value;
		
	   if (NetInterst=="")
		{
		   NetInterst=0;
		}
		if (txt_principal=="")
		{
		   txt_principal=0;
		}
		if (txt_int=="")
		{
		   txt_int=0;
		}
		
		if(eval(txt_principal)>0 && eval(NetInterst)<eval(txt_int))
			{
				alert("Repayment interst should not less than calculated interest");
				document.forms[0].txt_netint[i].focus();
				return;
			}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_cashflow.jsp";
	document.forms[0].hidBeanMethod.value="updatecashflowData";
	document.forms[0].hidBeanGetMethod.value="getcashflowData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="insert"; 
	enableButtons(true, false, false, false, true);
	
	for(var i=0; i<document.forms[0].txt_netinc.length; i++)
	{
		document.forms[0].txt_netinc[i].readOnly=true;
		document.forms[0].txt_int[i].readOnly=true;
		//document.forms[0].txt_netint[i].readOnly=true;
		document.forms[0].txt_outgoing[i].readOnly=true;
		document.forms[0].txt_aftertax[i].readOnly=true;
		document.forms[0].txt_dscr[i].readOnly=true;
		document.forms[0].txt_surplus[i].readOnly=true;
		document.forms[0].txt_loan[i].readOnly=true;
		document.forms[0].txt_roi.readOnly=true;		
	}
	document.forms[0].txt_loan[0].readOnly=false;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel"; 
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getcashflowData";
		document.forms[0].action=appURL+"action/agr_cashflow.jsp";
		document.forms[0].submit(); 	
	}
}



function cashFlowCal(j)
{
	var txt_roi=NanNumber(document.forms[0].txt_roi.value);
	
	for(var i=j;i<document.forms[0].txt_netinc.length;i++)
	{
		var txt_loan=document.forms[0].txt_loan[i].value;
		var txt_int=document.forms[0].txt_int[i].value;
		var NetIncome=document.forms[0].txt_netinc[i].value;
		var principle=document.forms[0].txt_principal[i].value;
		var repayInterst=document.forms[0].txt_netint[i].value;
		var Repayment=document.forms[0].txt_repayment[i].value;
		var TaxDeduction=document.forms[0].txt_taxdec[i].value;
		var Depreciation=document.forms[0].txt_depri[i].value;
		var tempInterest="0";
		var TotalRepay="0";
		var Surplus="0";
		var NetProfit="0";
		var DSCR="0";
		
		if(txt_roi=="")
		{
			txt_roi="0";
		}
		if(txt_loan=="")
		{
			txt_loan="0";
		}
		if(txt_int=="")
		{
			txt_int="0";
		}
		if(NetIncome=="")
		{
			NetIncome="0";
		}
		if(principle=="")
		{
			principle="0";
		}
		if(repayInterst=="")
		{
			repayInterst="0";
		}
		if(Repayment=="")
		{
			Repayment="0";
		}
		if(TaxDeduction=="")
		{
			TaxDeduction="0";
		}
		if(Depreciation=="")
		{
			Depreciation="0";
		}
		
		tempInterest=eval(txt_loan)*eval(txt_roi)/100;
		
		document.forms[0].txt_int[i].value=NanNumber(tempInterest);
		
		TotalRepay=eval(repayInterst)+eval(Repayment);
		document.forms[0].txt_outgoing[i].value=NanNumber(TotalRepay);
		
		Surplus=eval(NetIncome)-eval(TotalRepay);
		document.forms[0].txt_surplus[i].value=NanNumber(Surplus);
		
		NetProfit=eval(Surplus)-eval(TaxDeduction);
		document.forms[0].txt_aftertax[i].value=NanNumber(NetProfit);
	
		var checkDscr = eval(principle)+eval(repayInterst);
	
		if(checkDscr!=0)
		{
		
			DSCR=((eval(NetProfit)+eval(Depreciation)+eval(repayInterst))/(eval(principle)+eval(repayInterst)));
		}
		else
		{
			DSCR="0.00";
		}
		
		document.forms[0].txt_dscr[i].value=NanNumber(DSCR);
		
		roundtxt(document.forms[0].txt_int[i]);
		roundtxt(document.forms[0].txt_netinc[i]);
		roundtxt(document.forms[0].txt_principal[i]);
		roundtxt(document.forms[0].txt_netint[i]);
		roundtxt(document.forms[0].txt_repayment[i]);
		roundtxt(document.forms[0].txt_outgoing[i]);
		roundtxt(document.forms[0].txt_surplus[i]);
		roundtxt(document.forms[0].txt_taxdec[i]);
		roundtxt(document.forms[0].txt_aftertax[i]);
		roundtxt(document.forms[0].txt_dscr[i]);
		roundtxt(document.forms[0].txt_depri[i]);
		
		if(i<document.forms[0].txt_netinc.length-1)
		{
			document.forms[0].txt_loan[i+1].value=eval(txt_loan)+eval(tempInterest)-eval(principle)-eval(repayInterst);
			roundtxt(document.forms[0].txt_loan[i+1]);
		}
		
	}
}

function maxinterst(j)
{

	var NetInterst=document.forms[0].txt_netint[j].value;
	var txt_int=document.forms[0].txt_int[j].value;
	
	var Loanbeginnig=document.forms[0].txt_loan[j].value;
	var txt_principal=document.forms[0].txt_principal[j].value;
	
	  if (NetInterst=="")
		{
		   NetInterst="0";
		}
		if (txt_int=="")
		{
		   txt_int="0";
		}
		if (Loanbeginnig=="")
		{
		   Loanbeginnig="0";
		}
	   if (txt_principal=="")
		{
		   txt_principal="0";
		}
	
    if(eval(Loanbeginnig)<eval(txt_principal))
	{
	
		alert("Repayment amount should not exceed loan amount");
		document.forms[0].txt_principal[j].value="";
		document.forms[0].txt_principal[j].focus();
		return;
    }
	
	if(eval(NetInterst)>eval(txt_int))
	{
		alert("Repayment interest should not exceed actual interest for the loan");
		document.forms[0].txt_netint[j].value="";
		document.forms[0].txt_netint[j].focus();
		return;
    }
   
}






</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnload()">
<form class="normal" name="finForm" action="" method="post">
		
				<table class="outertable border1" width="100%" border="0" cellspacing="0" align="center" cellpadding="4">
					<tr>
						<td width="100%">
						<table class="outertable" width="100%" border="0" align="center" cellspacing="0" cellpadding="3">
							<tr>

								<td><b>Cash Flow (All values in Rupees)</b></td>
							</tr>
							<tr>
								<td>
								<table class="outertable" width="100%" border="0" align="center" cellspacing="0" cellpadding="0">
									<tr valign="top">
										<td colspan="7">

										<table class="outertable" width="100%" border="0" align="center" cellspacing="1" cellpadding="3">
											<tr class="dataHeader">
												<td align="center" rowspan="2"  >Proj Year</td>
												<td  align="center" rowspan="2"  >Loan At the Beginning</td>
												<td  align="center" rowspan="2"  >Interest <input type="text" name="txt_roi"
													value="<%=Helper.correctNull((String)hshValues.get("loan_modintrate"))%>"
													size="5" maxlength="15" onKeyPress="allowNumber(this)"
													style="text-align:right"> (%)&nbsp;</td>

												<td  align="center" rowspan="2"  >Gross Income (G)</td>
												<td  align="center" colspan="2" >Repayment</td>
												<td  align="center" rowspan="2"  >Repayment to Other loans(C)</td>
												<td  align="center" rowspan="2"  >Total Repay(B+C=D)</td>
												<td  align="center" rowspan="2"  >Surplus(G-D)</td>
												<td  align="center" rowspan="2"  >Tax Deduction (T)</td>
												<td  align="center" rowspan="2"  >Net Profit after tax(G-D-T=I)</td>
												<td align="center"  rowspan="2"  >Depreciation(D1)</td>
												<td  align="center" rowspan="2"  >DSCR(I+D1+B)/(A+B)</td>
											</tr>
											<tr class="dataHeader" >
												<td align="center">Principal(A)</td>
												<td align="center">Interest(B)</td>
											</tr>
											<%if (hshValues != null) {
												arrRow = (ArrayList) hshValues.get("arrRow");
				for (int i = 0; i < intyearsize; i++) {
					if (arrRow != null && arrRow.size() > 0
							&& i < arrRow.size()) {
						arrCol = (ArrayList) arrRow.get(i);

						%>

											<tr  class="dataGrid">
												<td align="center" ><%=(i + 1)%></td>
												<td align="center"><input type="text" name="txt_loan"
													value="<%=Helper.correctNull((String)arrCol.get(0))%>"
													size="12" maxlength="15"
													onBlur="callCheckLoanAmt(<%=i%>);cashFlowCal(<%=i%>)"
													onKeyPress="allowDecimals(this)" style="text-align:right;" />
												</td>
												<td align="center">
													<input type="text"
													name="txt_int"
													value="<%=Helper.correctNull((String)arrCol.get(1))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="maxinterst(<%=i%>);cashFlowCal(<%=i%>);"
													style="text-align:right"></td>

												<td align="center"><input type="text"
													name="txt_netinc" value="<%=stryearlyincome[i] %>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"
													readOnly="readonly"></td>
												<td align="center"><input type="text"
													name="txt_principal"
													value="<%=Helper.correctNull((String)arrCol.get(3))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="maxinterst(<%=i%>);cashFlowCal(<%=i%>)"
													style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_netint"
													value="<%=Helper.correctNull((String)arrCol.get(4))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>);maxinterst(<%=i%>)"
													style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_repayment"
													value="<%=Helper.correctNull((String)arrCol.get(7))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_outgoing"
													value="<%=Helper.correctNull((String)arrCol.get(5))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_surplus"
													value="<%=Helper.correctNull((String)arrCol.get(6))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(0)" style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_taxdec"
													value="<%=Helper.correctNull((String)arrCol.get(8))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_aftertax"
													value="<%=Helper.correctNull((String)arrCol.get(9))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
												<td align="center"><input type="text"
													name="txt_depri"
													value="<%=Helper.correctNull((String)arrCol.get(10))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
												<td align="center"><input type="text"
													name="txt_dscr"
													value="<%=Helper.correctNull((String)arrCol.get(11))%>"
													size="7" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
											</tr>
											<%}

					else {%>





											<tr  class="dataGrid">
												<td align="center"  ><%=(i+1)%></td>
												<td align="center"><input type="text" name="txt_loan"
													value="" size="12" maxlength="15"
													onBlur="callCheckLoanAmt(<%=i%>);cashFlowCal(<%=i%>)"
													onKeyPress="allowDecimals(this)" style="text-align:right;" />
												</td>
												<td align="center"><input type="text"
													name="txt_int" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="maxinterst(<%=i%>);cashFlowCal(<%=i%>);"
													style="text-align:right"></td>
												<td align="center"><input type="text"
													name="txt_netinc" value="<%=stryearlyincome[i] %>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"
													readOnly="readonly"></td>
												<td align="center"><input type="text"
													name="txt_principal" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="maxinterst(<%=i%>);cashFlowCal(<%=i%>)"
													style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_netint" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>);maxinterst(<%=i%>)"
													style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_repayment" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_outgoing" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_surplus" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(0)"
													style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_taxdec" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
												<td align="center"><input type="text"
													name="txt_aftertax" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
												<td align="center"><input type="text"
													name="txt_depri" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
												<td align="center"><input type="text"
													name="txt_dscr" value="" size="7"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
											</tr>

											<%}
				}
			}%>


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
				<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>


