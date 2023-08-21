function callCollateral()
{
	if(document.forms[0].cmdEdit.disabled == true)
	{
		ShowAlert(103);
	}
	else
	{
	document.forms[0].action =strAppUrl+"action/riskpercollateral.jsp";
	document.forms[0].submit();
	}
}

function callLiabilities()
{
	if(document.forms[0].cmdEdit.disabled == true)
	{
		ShowAlert(103);
	}
	else
	{
	document.forms[0].action =strAppUrl+"action/riskperliability.jsp";
	document.forms[0].submit();
	}
}

function callLiquidity()
{
	if(document.forms[0].cmdEdit.disabled == true)
	{
		ShowAlert(103);
	}
	else
	{
	document.forms[0].action = strAppUrl+"action/riskperliquidity.jsp";
	document.forms[0].submit();
	}
}

function buttonDisplay(boolEdit,boolApply,boolCancel,boolClose)
{
	document.forms[0].cmdEdit.disabled = boolEdit;
	document.forms[0].cmdApply.disabled = boolApply;
	document.forms[0].cmdCancel.disabled = boolCancel;
	document.forms[0].cmdClose.disabled = boolClose;

}

function callClose()
{
	
	if(ConfirmMsg(100))
	{
	document.forms[0].action=strAppUrl+"action/risknav.jsp";
	document.forms[0].submit();
	}
}
//Liquidity Tab

var monIncome1;
var monIncome2;
var rent;
var agri;
var otherIncome;
var autoLoan;
var houseRent;
var mortgage;
var monPay;
var otherExp;
var tax;


function fieldLiqDisplay(bool)
{
	document.forms[0].radPriMonIncome[0].disabled = bool;
	document.forms[0].radPriMonIncome[1].disabled = bool;
	document.forms[0].chkMonIncomeRent.disabled = bool;
	document.forms[0].chkMonIncomeAgri.disabled = bool;
	document.forms[0].chkMonIncomeSelfEmp.disabled = bool;
	document.forms[0].chkMonIncomeEmp.disabled = bool;
	document.forms[0].chkMonIncomeOtherInc.disabled = bool;
	document.forms[0].chkMonExpAuto.disabled = bool;
	document.forms[0].chkMonExpHouse.disabled = bool;
	document.forms[0].chkMonExpMort.disabled = bool;
	document.forms[0].chkMonExpMontlyPay.disabled = bool;
}

function callEditLiquidity()
{
	fieldLiqDisplay(false);
	
	if(document.forms[0].chkMonExpMontlyPay.checked == true)
	{
	document.forms[0].txtrsk_lessfinexp.readOnly = false;
	document.forms[0].txtrsk_lessfintax.readOnly = false;
	}

	monIncome1 = document.forms[0].radPriMonIncome[0].checked;
	monIncome2 = document.forms[0].radPriMonIncome[1].checked;
	rent	   = document.forms[0].chkMonIncomeRent.checked;
	agri	   = document.forms[0].chkMonIncomeAgri.checked;
	otherIncome= document.forms[0].chkMonIncomeOtherInc.checked;
	autoLoan   = document.forms[0].chkMonExpAuto.checked;
	houseRent  = document.forms[0].chkMonExpHouse.checked;
	mortgage   = document.forms[0].chkMonExpMort.checked;
	monPay     = document.forms[0].chkMonExpMontlyPay.checked;
	otherExp   = document.forms[0].txtrsk_lessfinexp.value;
	tax        = document.forms[0].txtrsk_lessfintax.value;

	buttonDisplay(true,false,false,true);
}

function calLiqCancel()
{
	if(ConfirmMsg(102))
	{
	if(monIncome1 == true)
	{
		document.forms[0].radPriMonIncome[0].checked = true;
		document.forms[0].radPriMonIncome[1].checked = false;
	}
	else
	{
		document.forms[0].radPriMonIncome[1].checked = true;
		document.forms[0].radPriMonIncome[0].checked = false;
	}

	if(rent == true)
	{
		document.forms[0].chkMonIncomeRent.checked = true;
	}
	else
	{
		document.forms[0].chkMonIncomeRent.checked = false;
	}

	if(agri == true)
	{
		document.forms[0].chkMonIncomeAgri.checked = true;
	}
	else
	{
		document.forms[0].chkMonIncomeAgri.checked = false;
	}

	if(otherIncome == true)
	{
		document.forms[0].chkMonIncomeOtherInc.checked = true;
	}
	else
	{
		document.forms[0].chkMonIncomeOtherInc.checked = false;
	}

	if(autoLoan == true)
	{
		document.forms[0].chkMonExpAuto.checked = true;
	}
	else
	{
		document.forms[0].chkMonExpAuto.checked = false;
	}

	if(houseRent == true)
	{
		document.forms[0].chkMonExpHouse.checked = true;
	}
	else
	{
		document.forms[0].chkMonExpHouse.checked = false;
	}

	if(mortgage == true)
	{
		document.forms[0].chkMonExpMort.checked = true;
	}
	else
	{
		document.forms[0].chkMonExpMort.checked = false;
	}

	if(monPay == true)
	{
		document.forms[0].chkMonExpMontlyPay.checked = true;
	}
	else
	{
		document.forms[0].chkMonExpMontlyPay.checked = false;
	}

	 document.forms[0].txtrsk_lessfinexp.value = otherExp;

	 document.forms[0].txtrsk_lessfintax.value = tax;

	 fieldLiqDisplay(true);
	 buttonDisplay(false,true,true,false);
	}
}

function callLiqSubmit()
{
		
	var monIncome;
	var monExpenses="";

	if(document.forms[0].radPriMonIncome[0].checked == true)
	{
		monIncome = document.forms[0].radPriMonIncome[0].value + ";";
	}
	else
	{
		monIncome = document.forms[0].radPriMonIncome[1].value + ";";
	}

	if(document.forms[0].chkMonIncomeRent.checked == true)
	{
		monIncome +=  document.forms[0].chkMonIncomeRent.value + ";";
	}

	if(document.forms[0].chkMonIncomeAgri.checked == true)
	{
		monIncome += document.forms[0].chkMonIncomeAgri.value + ";";
	}

	if(document.forms[0].chkMonIncomeSelfEmp.checked == true)
	{
		monIncome += document.forms[0].chkMonIncomeSelfEmp.value + ";";
	}

	if(document.forms[0].chkMonIncomeEmp.checked == true)
	{
		monIncome += document.forms[0].chkMonIncomeEmp.value + ";";
	}

	if(document.forms[0].chkMonIncomeOtherInc.checked == true)
	{
		monIncome += document.forms[0].chkMonIncomeOtherInc.value + ";";
	}
	
	//alert(monIncome);
	
	document.forms[0].hidMonIncomeValues.value = monIncome;
	
	if(document.forms[0].chkMonExpAuto.checked == true)
	{
		monExpenses += document.forms[0].chkMonExpAuto.value + ";";
	}

	if(document.forms[0].chkMonExpHouse.checked == true)
	{
		monExpenses +=  document.forms[0].chkMonExpHouse.value + ";";
	}

	if(document.forms[0].chkMonExpMort.checked == true)
	{
		monExpenses += document.forms[0].chkMonExpMort.value + ";";
	}

	if(document.forms[0].chkMonExpMontlyPay.checked == true)
	{
		monExpenses += document.forms[0].chkMonExpMontlyPay.value + ";";
	}

	//alert(monExpenses);
		
	document.forms[0].hidMonExpenses.value = monExpenses;
	document.forms[0].submit();
}

function loadLiqDatas(income,expenses)
{
	
	var monIncome = income.split(";");
	//alert(monIncome.length);
	
	for(i=0;i<monIncome.length;i++)
	{
		
		if(monIncome[i]=="TAKE_HOME")
		{
		document.forms[0].radPriMonIncome[0].checked=true
		}
		if(monIncome[i]=="GROSS_PAY")
		{
			document.forms[0].radPriMonIncome[1].checked=true
		}
		if(monIncome[i]=="ALIMONY")
		{
			document.forms[0].chkMonIncomeRent.checked=true
		}
		if(monIncome[i]=="CHILD_SUPPORT")
		{
			document.forms[0].chkMonIncomeAgri.checked=true
		}
		if(monIncome[i]=="OTHER_EARN")
		{
			document.forms[0].chkMonIncomeOtherInc.checked=true
		}
	}
	var monExpenses = expenses.split(";");
	//alert(monExpenses);

	for(i=0;i<monExpenses.length;i++)
	{
		
		if(monExpenses[i]=="MON_AUTO_LOAN_LIQ")
		{
		document.forms[0].chkMonExpAuto.checked=true
		}
		if(monExpenses[i]=="RENT_PAY")
		{
			document.forms[0].chkMonExpHouse.checked=true
		}
		if(monExpenses[i]=="MORT_PAY_LIQ")
		{
			document.forms[0].chkMonExpMort.checked=true
		}
		if(monExpenses[i]=="MIN_LIAB_PAY_LIQ")
		{
			document.forms[0].chkMonExpMontlyPay.checked=true
		}
	}

	if(finExp != "null")
	{
		document.forms[0].txtrsk_lessfinexp.value = finExp;
	}
	if(finTax != "null")
	{
		document.forms[0].txtrsk_lessfintax.value = finTax;
	}
}

function checkMonthlyPayment()
{
	if(document.forms[0].chkMonExpMontlyPay.checked == true)
	{
	document.forms[0].txtrsk_lessfinexp.readOnly = false;
	document.forms[0].txtrsk_lessfintax.readOnly = false;
	}
	else
	{
	document.forms[0].txtrsk_lessfinexp.readOnly = true;
	document.forms[0].txtrsk_lessfintax.readOnly = true;
	document.forms[0].txtrsk_lessfinexp.value = "";
	document.forms[0].txtrsk_lessfintax.value = "";
	}

}

function checkPercentage(obj)
{
	//alert(obj.value)
	if(parseFloat(obj.value,10) > 100)
	{
		//alert("% cannot be more than 100");
		ShowAlert(104)
		obj.focus();
		return false;
	}
}



// Collateral Tab

var bankVal;
var investVal;
var insuranceVal;
var personalVal;
var homeVal;
var carVal;
var boatVal;
var perPropVal;
var liqAssetVal;


function fieldCollDisplay(bool)
{
	document.forms[0].chkBankBal.disabled = bool;
	document.forms[0].chkInvest.disabled = bool;
	document.forms[0].chkInsure.disabled = bool;
	document.forms[0].chkPersonal.disabled = bool;
	document.forms[0].txtrsk_realcosthome.readOnly = bool;
	document.forms[0].txtrsk_realcostauto.readOnly = bool;
	document.forms[0].txtrsk_realcostboat.readOnly = bool;
	document.forms[0].txtrsk_realcostper.readOnly = bool;
	document.forms[0].txtrsk_realcostliqasset.readOnly = bool;
}

function callCollEdit()
{
	fieldCollDisplay(false);
	bankVal		= document.forms[0].chkBankBal.checked;
	investVal	= document.forms[0].chkInvest.checked;
	insuranceVal= document.forms[0].chkInsure.checked;
	personalVal = document.forms[0].chkPersonal.checked;
	homeVal		= document.forms[0].txtrsk_realcosthome.value;
	carVal      = document.forms[0].txtrsk_realcostauto.value;
	boatVal		= document.forms[0].txtrsk_realcostboat.value;
	perPropVal  = document.forms[0].txtrsk_realcostper.value;
	liqAssetVal = document.forms[0].txtrsk_realcostliqasset.value;
	buttonDisplay(true,false,false,true);
}	

function callCollCancel()
{
	if(ConfirmMsg(102))
	{
	if(bankVal == true)
	{
		document.forms[0].chkBankBal.checked = true;
	}
	else
	{
		document.forms[0].chkBankBal.checked = false;
	}

	if(investVal == true)
	{
		document.forms[0].chkInvest.checked = true;
	}
	else
	{
		document.forms[0].chkInvest.checked = false;
	}


	if(insuranceVal == true)
	{
		document.forms[0].chkInsure.checked = true;
	}
	else
	{
		document.forms[0].chkInsure.checked = false;
	}

	if(personalVal == true)
	{
		document.forms[0].chkPersonal.checked = true;
	}
	else
	{
		document.forms[0].chkPersonal.checked = false;
	}

	document.forms[0].txtrsk_realcosthome.value = homeVal;
	document.forms[0].txtrsk_realcostauto.value = carVal;
	document.forms[0].txtrsk_realcostboat.value = boatVal;
	document.forms[0].txtrsk_realcostper.value  = perPropVal;
	document.forms[0].txtrsk_realcostliqasset.value = liqAssetVal;

	fieldCollDisplay(true);
	buttonDisplay(false,true,true,false);
	}
}
	
function callCollSubmit()
{
	var liqAssets	= "";
	var nonLiqAssets= "";
	
	if(document.forms[0].chkBankBal.checked == true)
	{
		liqAssets += document.forms[0].chkBankBal.value + ";";
	}

	if(document.forms[0].chkInvest.checked == true)
	{
		liqAssets += document.forms[0].chkInvest.value + ";";
	}

	if(document.forms[0].chkInsure.checked == true)
	{
		liqAssets += document.forms[0].chkInsure.value + ";";
	}
	
	if(document.forms[0].chkPersonal.checked == true)
	{
		nonLiqAssets = document.forms[0].chkPersonal.value;
	}

	document.forms[0].hidLiqAssets.value = liqAssets;
	document.forms[0].hidNonLiqAssets.value = nonLiqAssets;

	//alert(liqAssets);
	//alert(nonLiqAssets);

	document.forms[0].submit();
}

function loadCollDatas(liqAssets,nonLiqAssets)
{
	var strliqAssets = liqAssets.split(";");
	var strNonLiqAssets = nonLiqAssets;
	
	for(i=0;i<strliqAssets.length;i++)
	{
		if(strliqAssets[i] == "BANK_BAL_COL")
		{
			document.forms[0].chkBankBal.checked = true;
		}
		if(strliqAssets[i] == "STK_VAL_COL")
		{
			document.forms[0].chkInvest.checked = true;
		}
		if(strliqAssets[i] == "LIFE_INS_VAL_COL")
		{
			document.forms[0].chkInsure.checked = true;
		}
	}
	
	if(strNonLiqAssets == "PER_FUR_COL")
	{
		document.forms[0].chkPersonal.checked = true;
	}
}


//Liability
var liabBal1;
var liabBal2;
var crLimit1;
var crLimit2;
var curMort;
var autoLoanBal;
var boatLoanBal;

function fieldLiabDisplay(bool)
{
	document.forms[0].radLiabBal[0].disabled = bool;
	document.forms[0].radLiabBal[1].disabled = bool;

	/*if(document.forms[0].radLiabBal[0].checked = true)
	{
		document.forms[0].radLiab[0].disabled = false;
		document.forms[0].radLiab[1].disabled = false;
	}
	else
	{
		document.forms[0].radLiab[0].disabled = true;
		document.forms[0].radLiab[1].disabled = true;
	}*/

	document.forms[0].chkMortgage.disabled = bool;
	document.forms[0].chkAutoBal.disabled = bool;
	document.forms[0].chkBoatBal.disabled = bool;
	
}

function callLiabEdit()
{
	fieldLiabDisplay(false);
	liabBal1	= document.forms[0].radLiabBal[0].checked;
	liabBal2	= document.forms[0].radLiabBal[1].checked;
	crLimit1	= document.forms[0].radLiab[0].checked;
	crLimit2	= document.forms[0].radLiab[1].checked;
	curMort		= document.forms[0].chkMortgage.checked;
	autoLoanBal = document.forms[0].chkAutoBal.checked;
	boatLoanBal = document.forms[0].chkBoatBal.checked;
	disableCredit();
	buttonDisplay(true,false,false,true);

}

function callLiabCancel()
{
	if(ConfirmMsg(102))
	{
	if(liabBal1 == true)
	{
		document.forms[0].radLiabBal[0].checked = true;
	}
	else
	{
		document.forms[0].radLiabBal[1].checked = true;
	}

	if(crLimit1 == true)
	{
		document.forms[0].radLiab[0].checked = true;
	}
	else
	{
		document.forms[0].radLiab[1].checked = true;
	}
	
	if(curMort == true)
	{
		document.forms[0].chkMortgage.checked = true;
	}
	else
	{
		document.forms[0].chkMortgage.checked = false;
	}
	
	if(autoLoanBal == true)
	{
		document.forms[0].chkAutoBal.checked = true;
	}
	else
	{
		document.forms[0].chkAutoBal.checked = false;
	}

	if(boatLoanBal == true)
	{
		document.forms[0].chkBoatBal.checked = true;
	}
	else
	{
		document.forms[0].chkBoatBal.checked = false;
	}
	
	fieldLiabDisplay(true);
	document.forms[0].radLiab[0].disabled = true;
	document.forms[0].radLiab[1].disabled = true;
	buttonDisplay(false,true,true,false);
	}
}

function callLiabSubmit()
{
	var liabVal = "";

	if(document.forms[0].radLiabBal[1].checked == true)
	{
		liabVal += document.forms[0].radLiabBal[1].value + ";";
	}
	else
	{
		liabVal += document.forms[0].radLiabBal[0].value + ";";
		if(document.forms[0].radLiab[0].checked == true)
		{
			liabVal += document.forms[0].radLiab[0].value + ";";
		}
		else
		{
			liabVal += document.forms[0].radLiab[1].value + ";";
		}
	}
	
	if(document.forms[0].chkMortgage.checked == true)
	{	
		liabVal += document.forms[0].chkMortgage.value + ";";
	}

	if(document.forms[0].chkAutoBal.checked == true)
	{
		liabVal += document.forms[0].chkAutoBal.value +  ";";
	}

	if(document.forms[0].chkBoatBal.checked == true)
	{
		liabVal += document.forms[0].chkBoatBal.value  + ";";
	}
	//alert(liabVal);

	document.forms[0].hidLiability.value = liabVal;

	document.forms[0].submit();
}

function loadLiabValues(strLiab)
{
	var strLiabilities = strLiab.split(";");
	//alert(strLiab);
	for(i =0;i<strLiabilities.length;i++)
	{
		if(strLiabilities[i] == "Yes")
		{
			document.forms[0].radLiabBal[0].checked = true;
		}
		
		if(strLiabilities[i] == "No")
		{
			document.forms[0].radLiabBal[1].checked = true;
		}

		if(strLiabilities[i] == "CL_COL")
		{
			document.forms[0].radLiab[0].checked = true;
		}
		
		if(strLiabilities[i] == "LIAB_BAL_COL")
		{
			document.forms[0].radLiab[1].checked = true;
		}

		if(strLiabilities[i] == "CUR_MORT_BAL_COL")
		{
			document.forms[0].chkMortgage.checked = true;
		}

		if(strLiabilities[i] == "AUTO_LOAN_BAL_COL")
		{
			document.forms[0].chkAutoBal.checked = true;
		}

		if(strLiabilities[i] == "BOAT_LOAN_BAL_COL")
		{
			document.forms[0].chkBoatBal.checked = true;
		}
	}
}

function disableCredit()
{
	if(document.forms[0].radLiabBal[0].checked == true)
	{
		document.forms[0].radLiab[0].disabled = false;
		document.forms[0].radLiab[1].disabled = false;
	}
	else
	{
		document.forms[0].radLiab[0].disabled = true;
		document.forms[0].radLiab[1].disabled = true;
	}
}