<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

			ArrayList vecrow = new ArrayList();
			ArrayList veccol = new ArrayList();
			String[][] row = new String[13][13];
			int vecsize = 0;
			if (hshValues != null) {
				vecrow = (ArrayList) hshValues.get("vecData");
				vecsize = vecrow.size();
			}
			for (int i = 0; i < 6; i++) {
				for (int j = 0; j < 13; j++) {
					row[i][j] = "";
				}
			}
			if (vecsize != 0) {
				for (int i = 0; i < 6; i++) {
					veccol = (ArrayList) vecrow.get(i);
					for (int j = 0; j < 13; j++) {
						row[i][j] = (String) veccol.get(j);
					}
				}
			} else {
				for (int i = 0; i < 6; i++) {
					veccol = (ArrayList) vecrow.get(i);
					for (int j = 0; j < 13; j++) {
						row[i][j] = (String) veccol.get(j);
					}
				}
			}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var varAcctype=new Array();
var varApptype=new Array();
var varchkClick=new Array();
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var sanction_amt="<%=Helper.correctNull((String)hshValues.get("loan_recmdamt" ))%>" ;
var sel_payment = "<%=Helper.correctNull((String)hshValues.get("sel_payment" ))%>" 
function callCalender(name)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		showCal(appURL ,name);
		
	}
}

/*function callinterest()
{
	var roi=document.forms[0].txt_roi.value;
	var amount;
	for(var i=0;i<6;i++)
	{
		amount=document.forms[0].txt_loan[i].value;
		if(amount=="")
		{
			amount=0;
		}
		document.forms[0].txt_int[i].value=eval((eval(roi)/100)*eval(amount));
		document.forms[0].txt_netint[i].value=document.forms[0].txt_int[i].value;
		
		if(document.forms[0].txt_int[i].value=="NaN")
		{
		document.forms[0].txt_int[i].value="0";
		}
		if(document.forms[0].txt_netint[i].value=="NaN")
		{
		document.forms[0].txt_netint[i].value="0";
		}
		
		roundtxt(document.forms[0].txt_int[i]);
		roundtxt(document.forms[0].txt_netint[i]);
	}
}
function calnetprofit()
{
	for(var i=0;i<6;i++)
	{
		var txt_netinc=document.forms[0].txt_netinc[i].value;
		if(document.forms[0].txt_netinc[i].value=="")
		{
			txt_netinc="0";
		}
		var txt_taxdec=document.forms[0].txt_taxdec[i].value;
		if(document.forms[0].txt_taxdec[i].value=="")
		{
			txt_taxdec="0";
		}
		var txt_outgoing=document.forms[0].txt_outgoing[i].value;
		if(document.forms[0].txt_outgoing[i].value=="")
		{
			txt_outgoing="0";
		}
		document.forms[0].txt_aftertax[i].value=eval(txt_netinc)-eval(txt_outgoing)-eval(txt_taxdec);
		if(document.forms[0].txt_aftertax[i].value=="NaN")
		{
			document.forms[0].txt_aftertax[i].value="0";
		}
		
		roundtxt(document.forms[0].txt_taxdec[i]);
		roundtxt(document.forms[0].txt_outgoing[i]);
		roundtxt(document.forms[0].txt_aftertax[i]);
		
	}
}
function caldepriciation()
{
	for(var i=0;i<6;i++)
	{
		var txt_netint=document.forms[0].txt_netint[i].value;
		if(document.forms[0].txt_netint[i].value=="")
		{
			txt_netint="0.00";
		}
		var txt_aftertax=document.forms[0].txt_aftertax[i].value;
		if(document.forms[0].txt_aftertax[i].value=="")
		{
			txt_aftertax="0.00";
		}
		var txt_depri=document.forms[0].txt_depri[i].value;
		if(document.forms[0].txt_depri[i].value=="")
		{
			txt_depri="0.00";
		}
		var txt_principal=document.forms[0].txt_principal[i].value;
		if(document.forms[0].txt_principal[i].value=="")
		{
			txt_principal="0.00";
		}
		document.forms[0].txt_dscr[i].value=((eval(txt_aftertax)+eval(txt_depri)+eval(txt_netint))/(eval(txt_principal)+eval(txt_netint)));
		if(document.forms[0].txt_dscr[i].value=="NaN")
		{
			document.forms[0].txt_dscr[i].value="0.00";
		}
		roundtxt(document.forms[0].txt_dscr[i]);
		roundtxt(document.forms[0].txt_principal[i]);
		roundtxt(document.forms[0].txt_depri[i]);
		roundtxt(document.forms[0].txt_aftertax[i]);
	}
}

function callloan()
{
	var amount,amount1;
	for(var i=0;i<=4;i++)
	{
		amount=document.forms[0].txt_loan[i].value;
		if(amount=="")
		{
			amount=0;
		}
		amount1=document.forms[0].txt_principal[i].value;
		if(amount1=="")
		{
			amount1=0;
		}
		document.forms[0].txt_loan[i+1].value=eval(eval(amount)-eval(amount1));
		 
		if(document.forms[0].txt_loan[i+1].value=="NaN")
		{
			document.forms[0].txt_loan[i+1].value="0.00";
		}
		if(document.forms[0].txt_principal[i+1].value=="NaN")
		{
			document.forms[0].txt_principal[i+1].value="0.00";
		}
		
		roundtxt(document.forms[0].txt_loan[i]);
		roundtxt(document.forms[0].txt_principal[i]);		
	}
	roundtxt(document.forms[0].txt_loan[5]);
	roundtxt(document.forms[0].txt_principal[5]);	
}*/

function doHelp()     
{

}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
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
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatesheepcashflow";
		document.forms[0].hidBeanGetMethod.value="getsheepcashflow";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidSourceUrl.value="/action/agr_sheep_cashflow.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}

function doSave()
{  
for(var i=0;i<6;i++)
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
				alert("Repayment interest should not be less than the calculated interest");
				document.forms[0].txt_netint[i].focus();
				return;
			}
		
	}
  //  callinterest();callloan();
    document.forms[0].hidAction.value="insert"; 
	//document.forms[0].hidAction1.value ="insert1"; 
	enableButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrpoultry";		
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_cashflow.jsp";
	document.forms[0].hidBeanMethod.value="updatesheepcashflow";
	document.forms[0].hidBeanGetMethod.value="getsheepcashflow";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value="insert"; 
	enableButtons(true, false, false, false, true);
	
	document.forms[0].txt_roi.readOnly=true;
	
	for(var i=0; i<6; i++)
	{
		document.forms[0].txt_netinc[i].readOnly=true;
		document.forms[0].txt_int[i].readOnly=true;
		//document.forms[0].txt_netint[i].readOnly=true;
		document.forms[0].txt_loan[i].readOnly=true;
		document.forms[0].txt_outgoing[i].readOnly=true;
		document.forms[0].txt_surplus[i].readOnly=true;
		document.forms[0].txt_aftertax[i].readOnly=true;
		document.forms[0].txt_dscr[i].readOnly=true;
		
	}
	document.forms[0].txt_loan[0].readOnly=false;
	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="cancel"; 
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheepcashflow";
		document.forms[0].action=appURL +"action/agr_sheep_cashflow.jsp";
		document.forms[0].submit(); 	
	}
}

/*function totequip(obj1, obj2, obj3, obj4)
{
	var obj11=obj1.value;
	if(obj11=="")
	{
		obj11=0;
	}
	if(obj2=="")
	{
		obj2=0;
	}
	if(obj4=="")
	{
		obj4=0;
	}
	var res=eval((obj2))+eval((obj11))+eval((obj4));
	obj3.value=res;
	roundtxt(obj3);
}

function totsurplus(obj1, obj2, obj3)
{
	if(obj1=="")
	{
		obj1=0;
	}
	if(obj2=="")
	{
		obj2=0;
	}
	var res = eval(obj1) - eval(obj2);
	obj3.value=res;
	roundtxt(obj3);
}*/


function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();

	}
}


function cashFlowCal(j)
{
	var txt_roi=NanNumber(document.forms[0].txt_roi.value);
	
	for(var i=j;i<6;i++)
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
		
		if(i<5)
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
	
	var alertMsgs = new Array();
	
	alertMsgs[0] = "First";
	alertMsgs[1] = "Second";
	alertMsgs[2] = "Third";
	alertMsgs[3] = "Fourth";
	alertMsgs[4] = "Fifth";
	alertMsgs[5] = "Sixth";
	
	 if(eval(Loanbeginnig)<eval(txt_principal))
	{
	
		alert("Repayment amount of "+alertMsgs[j]+" year should not exceed loan amount");
		document.forms[0].txt_principal[j].value="";
		//document.forms[0].txt_principal[j].focus();
		return;
    }
	   
	if(eval(NetInterst)>eval(txt_int))
	{
		alert("Repayment interest of "+alertMsgs[j]+" should not exceed actual interest for the loan");
		document.forms[0].txt_netint[j].value="";
		//document.forms[0].txt_netint[j].focus();
		return;
    }
   
   
}

function callCheckLoanAmt(pos)
{	
	var loanamt=document.forms[0].txt_loan[pos].value;	
	
	if(eval(loanamt) > eval(sanction_amt))
	{
		alert("Loan Amount cannot be greater than Eligible Loan Amount");
		document.forms[0].txt_loan[pos].value="0.00";
		document.forms[0].txt_loan[pos].focus();
		//roundtxt(document.forms[0].txt_loan[pos]);
		
		return;
	}
}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="callOnload()">
<form name="finForm" action="" method="post">
<table width="100%" border="1" cellspacing="0" cellpadding="5"
	bgcolor="#DEDACF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td>
				<table width="100%" border="1" cellspacing="0" cellpadding="5"
					height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr>
						<td valign="top">
						<table width="100%" border="1" cellspacing="0" cellpadding="4"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3">
									<tr>
										<td height="25"><font ><b>Cash
										Flow (All values in Rupees)</b></font></td>
									</tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											bordercolorlight="#EBEBF8" bordercolordark="#82829F">
											<tr valign="top">
												<td colspan="7">
												<table width="100%" border="1" cellspacing="0"
													cellpadding="3" bordercolorlight="#8F8369"
													bordercolordark="#FFFFFB">
													<tr align="center">
														<td rowspan="2" bgcolor="#71694F" width="4%"><font
															 color="#FFFFFF">Project
														Year</font></td>
														<td rowspan="2" bgcolor="#71694F" width="6%"><font
															 color="#FFFFFF"> Loan At
														the Beginning</font></td>
														<td rowspan="2" bgcolor="#71694F" width="6%"><font
															 color="#FFFFFF">Interest </font><font
															face="MS Sans Serif" size="2"> <input type="text"
															name="txt_roi"
															value="<%=Helper.correctNull((String)hshValues.get("loan_modintrate"))%>"
															size="5" maxlength="5" onKeyPress="allowNumber(this)"
															style="text-align:right" onBlur=""> </font><font size="1"
															face="MS Sans Serif" color="#FFFFFF">(%)&nbsp; </font></td>
														<td rowspan="2" bgcolor="#71694F" width="4%"><font
															 color="#FFFFFF">Gross
														Income (G)</font></td>
														<td colspan="2" bgcolor="#71694F"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Repayment</font></td>
														<td rowspan="2" bgcolor="#71694F" width="6%"><font
															color="#FFFFFF" >Repayment
														to Other loans(C)</font></td>
														<td rowspan="2" bgcolor="#71694F" width="5%"><font
															 color="#FFFFFF">Total
														Repay(B+C=D)</font></td>
														<td rowspan="2" bgcolor="#71694F" width="4%"><font
															 color="#FFFFFF">Surplus(G-D)</font></td>
														<td rowspan="2" bgcolor="#71694F" width="10%"><font
															 color="#FFFFFF">Tax
														Deduction (T)</font></td>
														<td rowspan="2" bgcolor="#71694F" width="10%"><font
															 color="#FFFFFF">Net Profit
														after tax(G-D-T=I)</font></td>
														<td rowspan="2" bgcolor="#71694F" width="10%"><font
															 color="#FFFFFF">Depreciation(D1)</font></td>
														<td rowspan="2" bgcolor="#71694F" width="25%"><font
															 color="#FFFFFF">DSCR(I+D1+B)/(A+B)</font></td>
													</tr>
													<tr align="center">
														<td bgcolor="#71694F" width="5%"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Principal(A)</font></td>
														<td bgcolor="#71694F" width="5%"><font size="1"
															face="MS Sans Serif" color="#FFFFFF">Interest(B)</font></td>
													</tr>
													<tr>
														<td align="left" width="4%"><font size="2"
															face="MS Sans Serif">I year</font></td>
														<td align="center" > 
                                            <lapschoice:CurrencyTag name="txt_loan"
															value='<%=row[0][1]%>' size="14" maxlength="10" onBlur="callCheckLoanAmt(0);cashFlowCal(0)"
															onKeyPress="allowDecimals(this)" style="text-align:right"/>
                                          </td>
														<td width="6%" align="center"><input type="text"
															name="txt_int" value="<%=row[0][2]%>" size="13"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
														<td width="4%" align="center"><input type="text"
															name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totiyearincome"))%>"
															size="14" maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right" readOnly>
														</td>
														<td width="5%" align="center"><lapschoice:CurrencyTag
															name="txt_principal" value='<%=row[0][4]%>'size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0);maxinterst(0)"
															style="text-align:right"/></td>
														<td width="5%" align="center"><lapschoice:CurrencyTag
															name="txt_netint" value='<%=row[0][5]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0);maxinterst(0);"
															style="text-align:right"/></td>
														<td width="6%" align="center"><input type="text"
															name="txt_repayment" value="<%=row[0][8]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
														<td width="5%" align="center"><input type="text"
															name="txt_outgoing" value="<%=row[0][6]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
														<td width="4%" align="center"><input type="text"
															name="txt_surplus" value="<%=row[0][7]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_taxdec" value="<%=row[0][9]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_aftertax" value="<%=row[0][10]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_depri" value="<%=row[0][11]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
														<td width="25%" align="center"><input type="text"
															name="txt_dscr" value="<%=row[0][12]%>" size="8"
															maxlength="5" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)" style="text-align:right"></td>
													</tr>
													<tr>
														<td width="4%" align="left"><font size="2"
															face="MS Sans Serif">II year</font></td>
														<td align="center" width="6%"><lapschoice:CurrencyTag
															name="txt_loan" value='<%=row[1][1]%>' size="14"
															maxlength="15" onKeyPress="allowDecimals(this)"
															style="text-align:right" onBlur="cashFlowCal(1)"/></td>
														<td width="6%" align="center"><input type="text"
															name="txt_int" value="<%=row[1][2]%>" size="13"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
														<td width="4%" align="center"><input type="text"
															name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totiiyearincome"))%>"
															size="14" maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right" readOnly>
														</td>
														<td width="5%" align="center"><lapschoice:CurrencyTag
															name="txt_principal" value='<%=row[1][4]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(1);cashFlowCal(1)"
															style="text-align:right"/></td>
														<td width="5%" align="center"><lapschoice:CurrencyTag
															name="txt_netint" value='<%=row[1][5]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(0);cashFlowCal(0)"
															style="text-align:right"/></td>
														<td width="6%" align="center"><input type="text"
															name="txt_repayment" value="<%=row[1][8]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
														<td width="5%" align="center"><input type="text"
															name="txt_outgoing" value="<%=row[1][6]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
														<td width="4%" align="center"><input type="text"
															name="txt_surplus" value="<%=row[1][7]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_taxdec" value="<%=row[1][9]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_aftertax" value="<%=row[1][10]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_depri" value="<%=row[1][11]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
														<td width="25%" align="center"><input type="text"
															name="txt_dscr" value="<%=row[1][12]%>" size="8"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(1)" style="text-align:right"></td>
													</tr>
													<tr>
														<td width="4%" align="left"><font size="2"
															face="MS Sans Serif">III year</font></td>
														<td width="6%" align="center"><lapschoice:CurrencyTag
															name="txt_loan" value='<%=row[2][1]%>' size="14"
															maxlength="15" onKeyPress="allowDecimals(this)"
															style="text-align:right" onBlur="cashFlowCal(2)"/></td>
														<td width="6%"><input type="text" name="txt_int"
															value="<%=row[2][2]%>" size="13" maxlength="9"
															onKeyPress="allowDecimals(this)" style="text-align:right"
															onBlur="cashFlowCal(2)"></td>
														<td width="4%" align="center"><input type="text"
															name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totiiiyearincome"))%>"
															size="14" maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right" readOnly>
														</td>
														<td width="5%" align="center"><lapschoice:CurrencyTag
															name="txt_principal" value='<%=row[2][4]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(2);cashFlowCal(2)"
															style="text-align:right"/></td>
														<td width="5%" align="center"><lapschoice:CurrencyTag
															name="txt_netint" value='<%=row[2][5]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(2);cashFlowCal(2)"
															style="text-align:right"/></td>
														<td width="6%" align="center"><input type="text"
															name="txt_repayment" value="<%=row[2][8]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right"></td>
														<td width="5%" align="center"><input type="text"
															name="txt_outgoing" value="<%=row[2][6]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right"></td>
														<td width="4%" align="center"><input type="text"
															name="txt_surplus" value="<%=row[2][7]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_taxdec" value="<%=row[2][9]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_aftertax" value="<%=row[2][10]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right"></td>
														<td width="10%" align="center"><input type="text"
															name="txt_depri" value="<%=row[2][11]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right"></td>
														<td width="25%" align="center"><input type="text"
															name="txt_dscr" value="<%=row[2][12]%>" size="8"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right"></td>
													</tr>
													<tr>
														<td align="left" width="4%"><font size="2"
															face="MS Sans Serif">IV year</font></td>
														<td align="center" width="6%"><lapschoice:CurrencyTag
															name="txt_loan" value='<%=row[3][1]%>' size="14"
															maxlength="15" onKeyPress="allowDecimals(this)"
															style="text-align:right" onBlur="cashFlowCal(3)"/></td>
														<td align="center" width="6%"><input type="text"
															name="txt_int" value="<%=row[3][2]%>" size="13"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right"></td>
														<td align="center" width="4%"><input type="text"
															name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totivyearincome"))%>"
															size="14" maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right" readOnly>
														</td>
														<td align="center" width="5%"><lapschoice:CurrencyTag
															name="txt_principal" value='<%=row[3][4]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(3);cashFlowCal(3)"
															style="text-align:right"/></td>
														<td align="center" width="5%"><lapschoice:CurrencyTag
															name="txt_netint" value='<%=row[3][5]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(3);cashFlowCal(3)"
															style="text-align:right"/></td>
														<td align="center" width="6%"><input type="text"
															name="txt_repayment" value="<%=row[3][8]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right"></td>
														<td align="center" width="5%"><input type="text"
															name="txt_outgoing" value="<%=row[3][6]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right"></td>
														<td align="center" width="4%"><INPUT TYPE="text"
															NAME="txt_surplus" VALUE="<%=row[3][7]%>" size="14"
															MAXLENGTH="9" ONKEYPRESS="allowDecimals(this)"
															onBlur="cashFlowCal(3)" STYLE="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_taxdec" value="<%=row[3][9]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_aftertax" value="<%=row[3][10]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_depri" value="<%=row[3][11]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right"></td>
														<td align="center" width="25%"><input type="text"
															name="txt_dscr" value="<%=row[3][12]%>" size="8"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(3)" style="text-align:right"></td>
													</tr>
													<tr>
														<td align="left" width="4%"><font size="2"
															face="MS Sans Serif">V year</font></td>
														<td align="center" width="6%"><lapschoice:CurrencyTag
															name="txt_loan" value='<%=row[4][1]%>' size="14"
															maxlength="15" onKeyPress="allowDecimals(this)"
															style="text-align:right" onBlur="cashFlowCal(4)"/></td>
														<td align="center" width="6%"><input type="text"
															name="txt_int" value="<%=row[4][2]%>" size="13"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
														<td align="center" width="4%"><input type="text"
															name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totvyearincome"))%>"
															size="14" maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right" readOnly>
														</td>
														<td align="center" width="5%"><lapschoice:CurrencyTag
															name="txt_principal" value='<%=row[4][4]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(4);cashFlowCal(4)"
															style="text-align:right"/></td>
														<td align="center" width="5%"><lapschoice:CurrencyTag
															name="txt_netint" value='<%=row[4][5]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(4);cashFlowCal(4)"
															style="text-align:right"/></td>
														<td align="center" width="6%"><input type="text"
															name="txt_repayment" value="<%=row[4][8]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
														<td align="center" width="5%"><input type="text"
															name="txt_outgoing" value="<%=row[4][6]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
														<td align="center" width="4%"><input type="text"
															name="txt_surplus" value="<%=row[4][7]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_taxdec" value="<%=row[4][9]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_aftertax" value="<%=row[4][10]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_depri" value="<%=row[4][11]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
														<td align="center" width="25%"><input type="text"
															name="txt_dscr" value="<%=row[4][12]%>" size="8"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(4)" style="text-align:right"></td>
													</tr>
													<tr>
														<td align="left" width="4%"><font size="2"
															face="MS Sans Serif">VI year</font></td>
														<td align="center" width="6%"><lapschoice:CurrencyTag
															name="txt_loan" value='<%=row[5][1]%>' size="14"
															maxlength="15" onKeyPress="allowDecimals(this)"
															style="text-align:right" onBlur="cashFlowCal(5)"/></td>
														<td align="center" width="6%"><input type="text"
															name="txt_int" value="<%=row[5][2]%>" size="13"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
														<td align="center" width="4%"><input type="text"
															name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totviyearincome"))%>"
															size="14" maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right" readOnly>
														</td>
														<td align="center" width="5%"><lapschoice:CurrencyTag
															name="txt_principal" value='<%=row[5][4]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(5);cashFlowCal(5)"
															style="text-align:right"/></td>
														<td align="center" width="5%"><lapschoice:CurrencyTag
															name="txt_netint" value='<%=row[5][5]%>' size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(5);cashFlowCal(5)"
															style="text-align:right"/></td>
														<td align="center" width="6%"><input type="text"
															name="txt_repayment" value="<%=row[5][8]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
														<td align="center" width="5%"><input type="text"
															name="txt_outgoing" value="<%=row[5][6]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
														<td align="center" width="4%"><input type="text"
															name="txt_surplus" value="<%=row[5][7]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_taxdec" value="<%=row[5][9]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_aftertax" value="<%=row[5][10]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
														<td align="center" width="10%"><input type="text"
															name="txt_depri" value="<%=row[5][11]%>" size="14"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
														<td align="center" width="25%"><input type="text"
															name="txt_dscr" value="<%=row[5][12]%>" size="8"
															maxlength="9" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right"></td>
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
						</td>
					</tr>
					<%--<tr>
						<td valign="top">
						<table width="100%" border="0">
							<tr>
								<td><font face="MS Sans Serif" size="2"> <input type="hidden"
									name="txt_holiday"
									value="<%=Helper.correctNull((String)hshValues.get("txt_holiday"))%>"
									size="14" maxlength="9" onKeyPress="allowNumber(this)"
									style="text-align:right"> </font><font size="1"
									face="MS Sans Serif">&nbsp; </font><font face="MS Sans Serif"
									size="2"> <input type="hidden" name="txt_installment"
									value="<%=Helper.correctNull((String)hshValues.get("txt_installment"))%>"
									size="14" maxlength="9" onKeyPress="allowInteger()"
									style="text-align:right"> <input type="hidden"
									name="txt_lastinstallment"
									value="<%=Helper.correctNull((String)hshValues.get("txt_lastinstallment"))%>"
									size="14" maxlength="9" onKeyPress="allowNumber(this)"
									style="text-align:right"> <input type="hidden"
									name="sel_payment"
									value="<%=Helper.correctNull((String)hshValues.get("sel_payment"))%>"
									size="14" maxlength="9" onKeyPress="allowNumber(this)"
									style="text-align:right"> <input type="hidden" name="txt_adte"
									value="<%=Helper.correctNull((String)hshValues.get("txt_date"))%>"
									size="14" maxlength="9" onKeyPress="allowNumber(this)"
									style="text-align:right"> </font></td>
							</tr>
						</table>
						</td>
					</tr>--%>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
 <lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <lapschoice:agrihiddentag/>
 </form>
 
</body>
</html>
