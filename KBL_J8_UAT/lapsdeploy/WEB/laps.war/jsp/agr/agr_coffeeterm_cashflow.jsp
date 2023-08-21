<%@include file = "../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();
			
			ArrayList vecyearlyincome = new ArrayList();

			String stryearlyincome[] = new String[30];
			int intyearsize = 0;
			if (hshValues != null) {
				vecyearlyincome = (ArrayList) hshValues.get("vecyearlyincome");
				intyearsize = Integer.parseInt((String) hshValues
						.get("intyearsize"));
				intyearsize=intyearsize;
			}
			
			if (vecyearlyincome != null && vecyearlyincome.size() > 0) {
				for (int i = 0; i < vecyearlyincome.size(); i++) {
					stryearlyincome[i] = Helper
							.correctNull((String) vecyearlyincome.get(i));
				}
			} else {
				for (int i = 0; i < intyearsize; i++) {
					stryearlyincome[i] = Helper.correctNull("0");
				}
			}
			
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
   
var varApptype=new Array();
var varAcctype=new Array();
var varAcctype1=new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
var sanction_amt="<%=Helper.correctNull((String)hshValues.get("loan_recmdamt" ))%>" ;
var varrepayyrs="<%=intyearsize%>";
var modintrate="<%=Helper.correctNull((String)hshValues.get("loan_modintrate" ))%>" ;
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("auditFlag"))%>";
function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}


function doClose()
{
	document.forms[0].target="_parent";
	document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
	document.forms[0].submit();
}
function callCheckProposedamount(pos)
{	
	var loanamt=document.forms[0].txt_loan[pos].value;
	var proamt=document.forms[0].txt_principal[pos].value;	
	if(eval(proamt) > eval(loanamt))
	{
		alert("Proposed Term Loan cannot be greater than  Loan Amount");
		document.forms[0].txt_termloanp[pos].value="0.00";
		document.forms[0].txt_termloanp[pos].focus();
		return;
	}
}
function callCheckLoanAmt(pos)
{
	var loanamt=document.forms[0].txt_loan[0].value;	
	if(eval(loanamt) > eval(sanction_amt))
	{
		alert("Loan Amount cannot be greater than Eligible Loan Amount");
		document.forms[0].txt_loan[0].value="0.00";
		document.forms[0].txt_loan[0].focus();
		return;
	}
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
	document.forms[0].txt_int[0].readOnly=true;
	//document.forms[0].txt_netinc[0].readOnly=true;
	
	/*for(var i=1;i<25;i++)
	{
		document.forms[0].txt_loan[i].readOnly=true;
	}*/
	
}


function doEdit()
{
 	disableFields(false);
    for(var i=0;i<varrepayyrs;i++)
	{
		document.forms[0].txt_netinc[i].readOnly=true;
		document.forms[0].txt_outgoing[i].readOnly=true;
		document.forms[0].txt_surplus[i].readOnly=true;
		document.forms[0].txt_aftertax[i].readOnly=true;
		document.forms[0].txt_dscr[i].readOnly=true;
		document.forms[0].txt_int[i].readOnly=true;
	}
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, true);	
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getcashflowData";
		document.forms[0].action=appURL+"action/agr_coffeeterm_cashflow.jsp";
		document.forms[0].submit(); 		
	}
	//disableCommandButtons("load");
}

function doDelete()
{
if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatecashflowData";
	document.forms[0].hidBeanGetMethod.value="getcashflowData";
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidSourceUrl.value="action/agr_coffeeterm_cashflow.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}

function onloading()
{	  

	disableFields(true);
}

function doSave()
{	
	for(var i=0;i<document.forms[0].txt_netinc.length;i++)
	{
		var NetInterst=document.forms[0].txt_netint[i].value;
		var txt_principal=document.forms[0].txt_principal[i].value;
		var txt_int=document.forms[0].txt_int[i].value;
		var loanamt=document.forms[0].txt_loan[i].value;
		
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
		if (loanamt=="")
		{
		   loanamt=0;
		}
		
		if(eval(txt_principal)>0 && eval(NetInterst)<eval(txt_int))
		{
				alert("Repayment interst should not less than calculated interest for the year "+ (i+1));
				document.forms[0].txt_netint[i].focus();
				return;
		}
		
		if(eval(txt_principal)>eval(loanamt))
	   	{
	   		alert("Repayment principal amount cannot be greater than loan amount for the year :: "+ (i+1));
	   		return ;
	   	}
	} 	
	document.forms[0].hidAuditFlag.value=varRecordFlag;
  	enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agreconomic";
	document.forms[0].hidSourceUrl.value="/action/agr_coffeeterm_cashflow.jsp";
	document.forms[0].hidBeanMethod.value="updatecashflowData";
	document.forms[0].hidBeanGetMethod.value="getcashflowData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
//function cashFlowCal(j) commented as per suresh requirement
function cashFlowCal(i)
{
	var txt_roi=NanNumber(document.forms[0].txt_roi.value);
	
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
}
</script>
</head>
<body onLoad="onloading()" >
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					class="outertable border1">
					<tr>

						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable"
							valign="top">
							<tr class="dataheader">
								<td><b>Cash Flow (All values in Rupees)</b></td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="2" cellpadding="1"
									class="outertable">
									<tr class="dataheader">

										<td rowspan="2" >Project Year</td>

										<td rowspan="2" >Loan at the Begining of
										the year</td>
										<td rowspan="2" align="center" >Interest @
										<input type="text" name="txt_roi" size="6" maxlength="3"
											value="<%=Helper.correctNull((String)hshValues.get("loan_modintrate" ))%>"
											> %</td>
										<td rowspan="2" align="center" >Gross Income (G)</td>
										<td colspan="2" align="center" >Repayment</td>
										<td rowspan="2" align="center" >Repayment to Other loans (C)
										</td>
										<td rowspan="2" align="center" >Total Repay (B+C=D)
										</td>
										<td rowspan="2" align="center" >Surplus (G-D)</td>
										<td rowspan="2" align="center" >Tax Deduction (T)</td>
										<td rowspan="2" align="center" >Net Profit after tax (G-D-T=I)</td>
										<td rowspan="2"  >Depreciation (D1)</td>
										<td rowspan="2"  >DSCR (I+D1+B)/(A+B)</td>
									</tr>
									<tr  class="dataheader"  >
										<td >Principal (A)</td>
										<td >Interest (B)</td>
									</tr>
									
									<%if (hshValues != null) {
				arryRow = (ArrayList) hshValues.get("arrRow");
					if (arryRow != null && arryRow.size() > 0) {
						for (int i = 0; i < intyearsize; i++) {
							if (intyearsize <= arryRow.size()) {
								arryCol = (ArrayList) arryRow.get(i);

							%>
									<tr>
										<td   align="center"><%=i + 1%></td>
										<td align="center"><input type="text" name="txt_loan" size="15"
											maxlength="9"
											value="<%=Helper.correctNull((String)arryCol.get(0))%>"
											onKeyPress="allowNumber(this)"
											onBlur="cashFlowCal(<%=i%>);callCheckLoanAmt(<%=i%>)"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_int"
											size="10" maxlength="10"
											value='<%=Helper.correctNull((String)arryCol.get(1))%>'
											onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_netinc" size="10"
													maxlength="10" value="<%=stryearlyincome[i]%>"
													style="text-align:right" onBlur="cashFlowCal(<%=i%>)" /></td>
										<td align="center"><input type="text" name="txt_principal"
											size="10" maxlength="10"
											value='<%=Helper.correctNull((String)arryCol.get(3))%>'
											onBlur="cashFlowCal(<%=i%>)" onKeyPress="allowNumber(this)"
											style="text-align:right" /></td>			
										<td align="center"><input type="text" name="txt_netint" size="10"
											maxlength="10"
											value='<%=Helper.correctNull((String)arryCol.get(4))%>'
											onBlur="cashFlowCal(<%=i%>);callCheckProposedamount(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
													
										<td align="center"><input type="text" name="txt_repayment" size="10"
											maxlength="10"
											value='<%=Helper.correctNull((String)arryCol.get(7))%>'
											onBlur="cashFlowCal(<%=i%>)" onKeyPress="allowNumber(this)"
											style="text-align:right" /></td>
											
										<td align="center"><input type="text"
											name="txt_outgoing" size="10" maxlength="10"
											value='<%=Helper.correctNull((String)arryCol.get(5))%>'
											onBlur="cashFlowCal(<%=i%>)" onKeyPress="allowNumber(this)"
											style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_surplus"
											size="10" maxlength="10"
											value='<%=Helper.correctNull((String)arryCol.get(6))%>'
											onBlur="cashFlowCal(<%=i%>)" onKeyPress="allowNumber(this)"
											style="text-align:right" /></td>		
										<td align="center"><input type="text" name="txt_taxdec" size="10"
											maxlength="10"
											value='<%=Helper.correctNull((String)arryCol.get(8))%>'
											onBlur="cashFlowCal(<%=i%>)" onKeyPress="allowNumber(this)"
											style="text-align:right" /></td>
										<td align="center"><input type="text"
													name="txt_aftertax"
													value="<%=Helper.correctNull((String)arryCol.get(9))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										<td align="center"><input type="text"
													name="txt_depri"
													value="<%=Helper.correctNull((String)arryCol.get(10))%>"
													size="12" maxlength="15" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										<td align="center"><input type="text"
													name="txt_dscr"
													value="<%=Helper.correctNull((String)arryCol.get(11))%>"
													size="12" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										
										
										
									</tr>
									<%} else {

							%>
									<tr>
										<td  align="center"><%=i + 1%></td>
										<td align="center"><input type="text" name="txt_loan" size="15" value=""
											onKeyPress="allowNumber(this)" maxlength="9"
											onBlur="cashFlowCal(<%=i%>);callCheckLoanAmt(<%=i%>)"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_int" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											style="text-align:right" /></td>
										<td align="center">
										<input type="text" name="txt_netinc" size="10"
													maxlength="10" value="<%=stryearlyincome[i]%>"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_principal" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_netint" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_repayment" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_outgoing"
											size="10" maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_surplus" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_taxdec" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										
										<td align="center"><input type="text"
													name="txt_aftertax" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										<td align="center"><input type="text"
													name="txt_depri" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										<td align="center"><input type="text"
													name="txt_dscr" value="" size="12"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										
									</tr>
									<%}

					}
				}
			else{
				for (int i = 0; i < intyearsize; i++) {
			%>
				<tr>
										<td  align="center"><%=(i + 1)%></td>
										<td align="center"><input type="text" name="txt_loan" size="15" value=""
											onKeyPress="allowNumber(this)" maxlength="9"
											onBlur="cashFlowCal(<%=i%>);callCheckLoanAmt(<%=i%>)"
											style="text-align:right"></td>
										<td align="center"><input type="text" name="txt_int" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											style="text-align:right" /></td>
										<td align="center">
										<input type="text" name="txt_netinc" size="10"
													maxlength="10" value="<%=stryearlyincome[i]%>"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_principal" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_netint" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_repayment" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_outgoing"
											size="10" maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_surplus" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										<td align="center"><input type="text" name="txt_taxdec" size="10"
											maxlength="10" onBlur="cashFlowCal(<%=i%>)"
											onKeyPress="allowNumber(this)" style="text-align:right" /></td>
										
										<td align="center"><input type="text"
													name="txt_aftertax" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										<td align="center"><input type="text"
													name="txt_depri" value="" size="12" maxlength="15"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										<td align="center"><input type="text"
													name="txt_dscr" value="" size="12"
													onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(<%=i%>)" style="text-align:right"></td>
										
									</tr>
			<%} }}%>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
 
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
</table>
	<input type="hidden" name="hidAuditFlag" > 
	<input type="hidden" name="hidtype" value="PLANT" > 
	<lapschoice:agrihiddentag pageid='<%=PageId%>'/>

</form>
</body>
</html>






