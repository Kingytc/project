<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

			ArrayList vecrow = new ArrayList();
			ArrayList veccol = new ArrayList();
			String[][] row = new String[19][19];
			int vecsize = 0;
			if (hshValues != null) {
				vecrow = (ArrayList) hshValues.get("vecData");
				if(vecrow!=null && vecrow.size()>0)
					vecsize = vecrow.size();
				}
			for (int i = 0; i < 12; i++) {
				for (int j = 0; j < 12; j++) {
					row[i][j] = "";
				}
			}
			if (vecsize != 0) {
				for (int i = 0; i < 12; i++) {
					veccol = (ArrayList) vecrow.get(i);
					for (int j = 0; j < 12; j++) {
						row[i][j] = (String) veccol.get(j);
					}
				}
			} else {
				for (int i = 0; i < 12; i++) {
					//veccol = (ArrayList) vecrow.get(i);
					for (int j = 0; j < 12; j++) {
						row[i][j] = "";
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
var selrepay = "<%=row[0][11]%>";

function doHelp()     
{

}
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

/*function callOnload()
{
	enableButtons(false, true, true, true, true);
	disableFields(true);
}*/

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
	document.forms[0].txt_roi.readOnly=true;
	
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
		document.forms[0].hidSourceUrl.value="/action/agr_farmMechcashflow.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}

function doSave()
{

  for(var i=0;i<12;i++)
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
				alert("Repayment interst should not less than calculated interst");
				document.forms[0].txt_netint[i].focus();
				return;
			}
	}
  document.forms[0].cmdapply.disabled=true;
     document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_farmMechcashflow.jsp";
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
	document.forms[0].txt_roi.readOnly=true;		
	for(var i=0; i<12; i++)
	{
		document.forms[0].txt_netinc[i].readOnly=true;
		document.forms[0].txt_int[i].readOnly=true;
		//document.forms[0].txt_netint[i].readOnly=true;
		document.forms[0].txt_outgoing[i].readOnly=true;
		document.forms[0].txt_aftertax[i].readOnly=true;
		document.forms[0].txt_dscr[i].readOnly=true;
		document.forms[0].txt_surplus[i].readOnly=true;
		document.forms[0].txt_loan[i].readOnly=true;
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
		document.forms[0].action=appURL+"action/agr_farmMechcashflow.jsp";
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
}
function callinterest()
{
var roi=document.forms[0].txt_roi.value;
var amount;
for(var i=0;i<=11;i++)
{
 amount=document.forms[0].txt_loan[i].value;
 document.forms[0].txt_int[i].value=Math.round((eval(roi)/100)*eval(amount));
 document.forms[0].txt_netint[i].value=document.forms[0].txt_int[i].value;

if(document.forms[0].txt_int[i].value=="NaN")
{
document.forms[0].txt_int[i].value="0";
}
if(document.forms[0].txt_netint[i].value=="NaN")
{
document.forms[0].txt_netint[i].value="0";
}
}
}
function callloan()
{
var amount,amount1;
for(var i=0;i<=10;i++)
{
 amount=document.forms[0].txt_loan[i].value;
  amount1=document.forms[0].txt_principal[i].value;
 document.forms[0].txt_loan[i+1].value=Math.round(eval(amount)-eval(amount1));
 
if(document.forms[0].txt_loan[i+1].value=="NaN")
{
document.forms[0].txt_loan[i+1].value="0";
}
if(document.forms[0].txt_principal[i+1].value=="NaN")
{
document.forms[0].txt_principal[i+1].value="0";
}
}

 
}

function repay()
{
for(var i=0;i<12;i++)
{
var txt_principal=document.forms[0].txt_principal[i].value;
if(document.forms[0].txt_principal[i].value=="")
{
txt_principal="0";
}
var txt_netint=document.forms[0].txt_netint[i].value;
if(document.forms[0].txt_netint[i].value=="")
{
txt_netint="0";
}
var txt_repayment=document.forms[0].txt_repayment[i].value;
if(document.forms[0].txt_repayment[i].value=="")
{
txt_repayment="0";
}
document.forms[0].txt_outgoing[i].value=eval(txt_principal)+eval(txt_netint)+eval(txt_repayment);
if(document.forms[0].txt_outgoing[i].value=="NaN")
{
document.forms[0].txt_outgoing[i].value="0";
}

}
}
function surplus()
{

for(var i=0;i<12;i++)
{
var netinc=document.forms[0].txt_netinc[i].value;

if(netinc=="")
{
netinc="0";
}
var txt_outgoing=document.forms[0].txt_outgoing[i].value;

if(txt_outgoing=="")
{
txt_outgoing="0";
}
document.forms[0].txt_surplus[i].value=eval(netinc)-eval(txt_outgoing);
if(document.forms[0].txt_surplus[i].value=="NaN")
{
document.forms[0].txt_surplus[i].value="0";
}
}
}
function calnetprofit()
{
for(var i=0;i<12;i++)
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

}
}
function caldepriciation()
{
for(var i=0;i<12;i++)
{
var txt_netint=document.forms[0].txt_netint[i].value;

if(document.forms[0].txt_netint[i].value=="")
{
txt_netint="0";
}
var txt_aftertax=document.forms[0].txt_aftertax[i].value;

if(document.forms[0].txt_aftertax[i].value=="")
{
txt_aftertax="0";
}
var txt_depri=document.forms[0].txt_depri[i].value;

if(document.forms[0].txt_depri[i].value=="")
{
txt_depri="0";
}
var txt_principal=document.forms[0].txt_principal[i].value;

if(document.forms[0].txt_principal[i].value=="")
{
txt_principal="0";
}
document.forms[0].txt_dscr[i].value=((eval(txt_aftertax)+eval(txt_depri)+eval(txt_netint))/(eval(txt_principal)+eval(txt_netint)));
roundtxt(document.forms[0].txt_dscr[i]);

if(document.forms[0].txt_dscr[i].value=="NaN")
{
document.forms[0].txt_dscr[i].value="0";
}
if(document.forms[0].txt_dscr[i].value=="Infinity")
{
document.forms[0].txt_dscr[i].value="0";
}
if(document.forms[0].txt_dscr[i].value=="-Infinity")
{
document.forms[0].txt_dscr[i].value="0";
}
if(document.forms[0].txt_dscr[i].value=="Infinity.00")
{
document.forms[0].txt_dscr[i].value="0";
}
if(document.forms[0].txt_dscr[i].value=="-Infinity.00")
{
document.forms[0].txt_dscr[i].value="0";
}
}
}*/
function cashFlowCal(j)
{
	var txt_roi=NanNumber(document.forms[0].txt_roi.value);
	
	for(var i=j;i<12;i++)
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
		
		if(i<11)
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
		alert("Repayment interst should not exceed actual interst for the loan");
		document.forms[0].txt_netint[j].value="";
		document.forms[0].txt_netint[j].focus();
		return;
    }
    /*else if(eval(NetInterst)<eval(txt_int))
    {
    	if(eval(txt_principal)>0)
    	{
    		
    	}
    }*/
   
    
}
function doClose()
	{
	if(ConfirmMsg('100'))
		{
		/* document.forms[0].target="_parent";	
		document.forms[0].action=appURL+"action/"+"persearch.jsp";
		document.forms[0].submit(); */
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
		
		}
	}



</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body onload="callOnload()">
<form name="finForm" action="" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			height="100%">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					height="100%" class="outertable border1">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="4"
							class="outertable border1">
                      <tr> 
                        <td> <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td height="25"><b>Cash 
                                Flow (All values in Rupees)</b></td>
                            </tr>
                            <tr> 
                              <td> <table width="100%" border="0" cellspacing="0" cellpadding="0"
											bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                                  <tr valign="top"> 
                                    <td colspan="7"> 
                                      <table width="100%" border="0" cellspacing="0"
													cellpadding="3">
                                        <tr align="center"> 
                                          <td rowspan="2" bgcolor="#71694F" width="5%"><font
															color="#FFFFFF">Project 
                                            Year</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="11%"><font
															color="#FFFFFF"> Loan 
                                            At the Beginning</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="7%"><font
															color="#FFFFFF">Interest 
                                            </font><font size="2"> 
                                            <input type="text" name="txt_roi"
											value="<%=Helper.correctNull((String)hshValues.get("loan_modintrate"))%>" size="15" maxlength="12"
											onKeyPress="allowNumber(this)" style="text-align:right">
                                            </font><font
															color="#FFFFFF">(%)&nbsp; 
                                            </font><font
															color="#FFFFFF"> </font><font
															color="#FFFFFF"> </font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="8%"><font
															color="#FFFFFF">Net 
                                            Income (G)</font></td>
                                          <td colspan="2" bgcolor="#71694F"><font
															color="#FFFFFF">Repayment</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="7%"><font color="#FFFFFF" face="MS Sans Serif">Repayment 
                                            to Other loans(C)</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="9%"><font
															color="#FFFFFF">Total 
                                            Repay(B+C=D)</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="11%"><font
															color="#FFFFFF">Surplus(G-D)</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="5%"><font color="#FFFFFF">Tax 
                                            Deduction (T)</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="0%"><font color="#FFFFFF">Net 
                                            Profit after tax(G-D-T=I)</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="10%"><font color="#FFFFFF">Depreciation(D1)</font></td>
                                          <td rowspan="2" bgcolor="#71694F" width="9%"><font color="#FFFFFF">DSCR(I+D1+B)/(A+B)</font></td>
                                        </tr>
                                        <tr align="center"> 
                                          <td bgcolor="#71694F" width="9%"><font face="MS Sans Serif"
															color="#FFFFFF">Principal(A)</font></td>
                                          <td bgcolor="#71694F" width="9%"><font face="MS Sans Serif"
															color="#FFFFFF">Interest(B)</font></td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">I 
                                            </font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan" tabindex="1"
															value="<%=row[0][0]%>" size="15" maxlength="12" onBlur="callCheckLoanAmt(0);cashFlowCal(0)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td width="7%" align="center"> 
                                            <input type="text"
															name="txt_int" value="<%=row[0][1]%>" size="13" onBlur="maxinterst(0);cashFlowCal(0);"
															maxlength="12" onKeyPress="allowDecimals(this)"
															style="text-align:right">
                                          </td>
                                          <td width="8%" align="center"> 
                                            <input type="text"
															name="txt_netinc" value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(0)"
															style="text-align:right" readOnly>
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text" tabindex="2"
															name="txt_principal" value="<%=row[0][3]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="callCheckLoanAmt(0);maxinterst(0);cashFlowCal(0)"
															style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_netint" value="<%=row[0][4]%>" size="15" onBlur="maxinterst(0);cashFlowCal(0)"
															maxlength="12" onKeyPress="allowDecimals(this)"
															style="text-align:right">
                                          </td>
                                          <td width="7%" align="center"> 
                                            <input type="text" tabindex="3"
															name="txt_repayment" value="<%=row[0][7]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(0)" style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_outgoing" value="<%=row[0][5]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(0)"
															style="text-align:right">
                                          </td>
                                          <td width="11%" align="center"> 
                                            <input type="text"
															name="txt_surplus" value="<%=row[0][6]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(0)"
															style="text-align:right">
                                          </td>
                                          <td width="5%" align="center"> 
                                            <input type="text" tabindex="4"
															name="txt_taxdec" value="<%=row[0][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(0)"
															style="text-align:right">
                                          </td>
                                          <td width="0%" align="center"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[0][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(0)"
															style="text-align:right">
                                          </td>
                                          <td width="10%" align="center"> 
                                            <input type="text" tabindex="5"
															name="txt_depri" value="<%=row[0][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(0)"
															style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[0][11]%>" size="15"
															maxlength="12"  onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(0)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="5%" align="center"><b><font size="2"
															face="MS Sans Serif">II</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[1][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(1)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td width="7%" align="center"> 
                                            <input type="text"
															name="txt_int" value="<%=row[1][1]%>" size="13" onBlur="maxinterst(1);cashFlowCal(1);"
															maxlength="12" onKeyPress="allowDecimals(this)"
															style="text-align:right">
                                          </td>
                                          <td width="8%" align="center"> 
                                            <input type="text"
															name="txt_netinc" value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(1)"
															style="text-align:right" readOnly>
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text" tabindex="6"
															name="txt_principal" value="<%=row[1][3]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(1);cashFlowCal(1)"
															style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_netint" value="<%=row[1][4]%>" size="15" onBlur="maxinterst(1);cashFlowCal(1)"
															maxlength="12" onKeyPress="allowDecimals(this)"
															style="text-align:right">
                                          </td>
                                          <td width="7%" align="center"> 
                                            <input type="text" tabindex="7"
															name="txt_repayment" value="<%=row[1][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(1)"	style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_outgoing" value="<%=row[1][5]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(1)"
															style="text-align:right">
                                          </td>
                                          <td width="11%" align="center"> 
                                            <input type="text"
															name="txt_surplus" value="<%=row[1][6]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(1)"
															style="text-align:right">
                                          </td>
                                          <td width="5%" align="center"> 
                                            <input type="text" tabindex="8"
															name="txt_taxdec" value="<%=row[1][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(1)"
															style="text-align:right">
                                          </td>
                                          <td width="0%" align="center"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[1][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(1)"
															style="text-align:right">
                                          </td>
                                          <td width="10%" align="center"> 
                                            <input type="text" tabindex="9"
															name="txt_depri" value="<%=row[1][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(1)"
															style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[1][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(1)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td width="5%" align="center"><b><font size="2"
															face="MS Sans Serif">III</font></b></td>
                                          <td width="11%" align="center"> 
                                            <input type="text"
															name="txt_loan" value="<%=row[2][0]%>" size="15" onBlur="cashFlowCal(2)"
															maxlength="12" onKeyPress="allowDecimals(this)"
															style="text-align:right">
                                          </td>
                                          <td width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[2][1]%>" size="13" maxlength="12" onBlur="maxinterst(2);cashFlowCal(2);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td width="8%" align="center"> 
                                            <input type="text"
															name="txt_netinc" value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(2)"
															style="text-align:right" readOnly>
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_principal" value="<%=row[2][3]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(2);cashFlowCal(2)" style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_netint" value="<%=row[2][4]%>" size="15" onBlur="maxinterst(2);cashFlowCal(2)"
															maxlength="12" onKeyPress="allowDecimals(this)"
															style="text-align:right">
                                          </td>
                                          <td width="7%" align="center"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[2][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(2)" style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_outgoing" value="<%=row[2][5]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(2)"
															style="text-align:right">
                                          </td>
                                          <td width="11%" align="center"> 
                                            <input type="text"
															name="txt_surplus" value="<%=row[2][6]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(2)"
															style="text-align:right">
                                          </td>
                                          <td width="5%" align="center"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[2][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(2)"
															style="text-align:right">
                                          </td>
                                          <td width="0%" align="center"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[2][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(2)"
															style="text-align:right">
                                          </td>
                                          <td width="10%" align="center"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[2][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(2)"
															style="text-align:right">
                                          </td>
                                          <td width="9%" align="center"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[2][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(2)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">IV</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[3][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(3)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[3][1]%>" size="13" maxlength="12" onBlur="maxinterst(3);cashFlowCal(3);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"  onBlur="cashFlowCal(3)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[3][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
														onBlur="maxinterst(3);cashFlowCal(3)"	style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[3][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(3);cashFlowCal(3)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[3][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
													onBlur="cashFlowCal(3)"	style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[3][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(3)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[3][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(3)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[3][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(3)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[3][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(3)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[3][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(3)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[3][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(3)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">V</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[4][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(4)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[4][1]%>" size="13" maxlength="12" onBlur="maxinterst(4);cashFlowCal(4);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(4)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[4][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
														onBlur="maxinterst(4);cashFlowCal(4)"	style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[4][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="maxinterst(4);cashFlowCal(4)"
														 	style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[4][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
														onBlur="cashFlowCal(4)"	style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[4][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(4)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[4][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(4)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[4][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(4)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[4][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(4)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[4][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(4)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[4][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(4)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">VI</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[5][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(5)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[5][1]%>" size="13" maxlength="12" onBlur="maxinterst(5);cashFlowCal(5);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(5)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[5][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
														onBlur="maxinterst(5);cashFlowCal(5)"	style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[5][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="maxinterst(5);cashFlowCal(5)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[5][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(5)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[5][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(5)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[5][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(5)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[5][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(5)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[5][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(5)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[5][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(5)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[5][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(5)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">VII</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[6][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(6)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[6][1]%>" size="13" maxlength="12" onBlur="maxinterst(6);cashFlowCal(6);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(6)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[6][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
														onBlur="maxinterst(6);cashFlowCal(6)"	style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[6][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="maxinterst(6);cashFlowCal(6)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[6][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(6)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[6][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(6)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[6][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(6)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[6][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(6)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[6][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(6)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[6][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(6)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[6][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(6)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" nowrap width="5%"><b><font size="2" face="MS Sans Serif">VIII</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[7][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(7)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[7][1]%>" size="13" maxlength="12" onBlur="maxinterst(7);cashFlowCal(7);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(7)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[7][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
														onBlur="maxinterst(7);cashFlowCal(7)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[7][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="maxinterst(7);cashFlowCal(7)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[7][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
														onBlur="cashFlowCal(7)"	style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[7][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(7)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[7][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(7)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[7][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(7)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[7][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(7)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[7][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(7)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[7][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(7)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">IX 
                                            </font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[8][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(8)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[8][1]%>" size="13" maxlength="12" onBlur="maxinterst(8);cashFlowCal(8);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(8)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[8][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(8);cashFlowCal(8)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[8][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="maxinterst(8);cashFlowCal(8)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[8][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(8)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[8][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(8)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[8][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(8)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[8][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(8)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[8][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(8)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[8][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(8)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[8][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(8)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">X</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[9][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(9)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[9][1]%>" size="13" maxlength="12" onBlur="maxinterst(9);cashFlowCal(9);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(9)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[9][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(9);cashFlowCal(9)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[9][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(9);cashFlowCal(9)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[9][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(9)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[9][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(9)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[9][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(9)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[9][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(9)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[9][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(9)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[9][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(9)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[9][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(9)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">XI</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[10][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(10)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[10][1]%>" size="13" maxlength="12" onBlur="maxinterst(10);cashFlowCal(10);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(10)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[10][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(10);cashFlowCal(10)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[10][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="maxinterst(10);cashFlowCal(10)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[10][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(10)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[10][5]%>" size="15" maxlength="12" onBlur="cashFlowCal(10)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[10][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(10)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[10][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(10)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[10][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(10)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[10][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(10)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[10][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(10)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td align="center" width="5%"><b><font size="2" face="MS Sans Serif">XII</font></b></td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_loan"
															value="<%=row[11][0]%>" size="15" maxlength="12" onBlur="cashFlowCal(11)"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text" name="txt_int"
															value="<%=row[11][1]%>" size="13" maxlength="12" onBlur="maxinterst(11);cashFlowCal(11);"
															onKeyPress="allowDecimals(this)" style="text-align:right">
                                          </td>
                                          <td align="center" width="8%"> 
                                            <input type="text" name="txt_netinc"
															value="<%=Helper.correctNull((String)hshValues.get("totnetincyear"))%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(11)" style="text-align:right" readOnly>
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_principal"
															value="<%=row[11][3]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)"
															onBlur="maxinterst(11);cashFlowCal(11)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_netint"
															value="<%=row[11][4]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="maxinterst(11);cashFlowCal(11)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="7%"> 
                                            <input type="text"
															name="txt_repayment" value="<%=row[11][7]%>" size="13"
															maxlength="12" onKeyPress="allowDecimals(this)"
															onBlur="cashFlowCal(11)" style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text" name="txt_outgoing"
															value="<%=row[11][5]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(11)" style="text-align:right">
                                          </td>
                                          <td align="center" width="11%"> 
                                            <input type="text" name="txt_surplus"
															value="<%=row[11][6]%>" size="15" maxlength="12"
															onKeyPress="allowDecimals(this)" onBlur="cashFlowCal(11)" style="text-align:right">
                                          </td>
                                          <td align="center" width="5%"> 
                                            <input type="text"
															name="txt_taxdec" value="<%=row[11][8]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(11)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="0%"> 
                                            <input type="text"
															name="txt_aftertax" value="<%=row[11][9]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(11)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="10%"> 
                                            <input type="text"
															name="txt_depri" value="<%=row[11][10]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(11)"
															style="text-align:right">
                                          </td>
                                          <td align="center" width="9%"> 
                                            <input type="text"
															name="txt_dscr" value="<%=row[11][11]%>" size="15"
															maxlength="12" onKeyPress="allowDecimals(this)" 
															onBlur="cashFlowCal(11)"
															style="text-align:right">
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                </table></td>
                            </tr>
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
<br>
<lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> 
<lapschoice:agrihiddentag />
</form>
</body>
</html>