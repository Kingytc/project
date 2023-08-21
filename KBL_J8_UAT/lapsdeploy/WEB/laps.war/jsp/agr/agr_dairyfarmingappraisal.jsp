<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*,java.io.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
ArrayList vecRow = new ArrayList();
ArrayList vecData = new ArrayList();
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
double totalanimal =0;
double averagemilkyeild =0;
int vecsize =0;
double Insurance =0.00;
String ExpensesofLabour = "0";
double noofLabour = 0.00;
double monthsalaryLabour = 0.00;
double veterinaryaid = 0.00;
String ExpensesVeterinaryaid = "0";
String TotalInsurancePremium = "0";
String Electricityexpenses = "0";
String OtherExpenses = "0";
String TotalConstructionCost = "0";
double TotalCostPurchasedAnimals = 0.00;
String TotalCostAnimals = "0.00";
String TotalTransportation = "0";
String TotalMaintainance = "0";
double IBatchanimal = 0.00;
String TotalEquipments = "0";
String TotalProjectCost = "0";
String MarginAmount = "0";
String SubsidyMarginAmount = "0";
String TotalLoanAmount = "0";
String TotalInterestRate = "0";
String Modmargin = "0";
String ModSubsidyMargin ="0";
String ModTotalLoanamount = "0";
String subsidyamt = "0";
String interestrate = "0";
String ModInterestrate = "0";
String ModEMIAmount = "0", Margin ="0", SubsidyMargin = "0";
long totnoofanimals = Integer.parseInt(Helper.correctDouble((String)hshValues.get("totnoofanimals")));
if(Helper.correctNull((String)hshValues.get("loan_subsidyamt")).equalsIgnoreCase(""))
{
	subsidyamt = "0";
}
else
{
	subsidyamt = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_subsidyamt"))));	
}
if(Helper.correctNull((String)hshValues.get("loan_margin")).equalsIgnoreCase(""))
{
	Modmargin = "";
}
else
{
	Modmargin = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_margin"))));
}

if(Helper.correctNull((String)hshValues.get("loan_subsidymargin")).equalsIgnoreCase(""))
{
	ModSubsidyMargin = "";
}
else
{
	ModSubsidyMargin = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_subsidymargin"))));
}

if(Helper.correctNull((String)hshValues.get("loan_amount")).equalsIgnoreCase(""))
{
	ModTotalLoanamount = "0.00";
}
else
{
	ModTotalLoanamount =  nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_amount"))));
}

if(Helper.correctNull((String)hshValues.get("mintrate")).equalsIgnoreCase(""))
{
	interestrate = "0.00";
}
else
{
	interestrate = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mintrate"))));
}

if(Helper.correctNull((String)hshValues.get("loan_interestrate")).equalsIgnoreCase(""))
{
	ModInterestrate = "";
}
else
{
	ModInterestrate = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_interestrate"))));
}

if(Helper.correctNull((String)hshValues.get("loan_emi")).equalsIgnoreCase(""))
{
	ModEMIAmount = "0.00";
}
else
{
	ModEMIAmount= nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_emi"))));
}

// Margin 

if(Helper.correctNull((String)hshValues.get("prd_lvr")).equalsIgnoreCase(""))
{
	Margin = "0.00";
}
else
{
	Margin = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("prd_lvr"))));
}

// Subsidy Margin

if(Helper.correctNull((String)hshValues.get("prd_oldvehiclemargin")).equalsIgnoreCase(""))
{
	SubsidyMargin = "0.00";
}
else
{
	SubsidyMargin = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("prd_oldvehiclemargin"))));
}

if(hshValues!=null)
{
	vecData = (ArrayList)hshValues.get("vecData");
	vecsize = vecData.size();
}
if(vecsize!=0)
{
	for(int i=0; i<vecsize; i++)
	{
		vecRow = (ArrayList) vecData.get(i);
		totalanimal = totalanimal + Double.parseDouble(Helper.correctDouble((String)vecRow.get(0)));
		if(i==0)
		{
			IBatchanimal = Double.parseDouble(Helper.correctDouble((String)vecRow.get(0)));
		}
		averagemilkyeild = averagemilkyeild + Double.parseDouble(Helper.correctDouble((String)vecRow.get(1)));
		TotalCostPurchasedAnimals = TotalCostPurchasedAnimals + Double.parseDouble(Helper.correctDouble((String)vecRow.get(2)));
	}
	averagemilkyeild = averagemilkyeild / 2;
	TotalCostAnimals = nf.format(TotalCostPurchasedAnimals);
}

// Total Insurance Cost

if(Helper.correctNull((String)hshValues.get("inspremium")).equalsIgnoreCase(""))
{
	Insurance = 0.00;
}
else
{
	Insurance = Double.parseDouble(Helper.correctDouble((String)hshValues.get("inspremium")));
}
TotalInsurancePremium = nf.format(totalanimal * Insurance);

// Total Construction Cost

if(Helper.correctNull((String)hshValues.get("totcostconst")).equalsIgnoreCase(""))
{
	TotalConstructionCost = "0.00";
}
else
{
	TotalConstructionCost = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totcostconst"))));
}

// Transportation Cost

if(Helper.correctNull((String)hshValues.get("transcost")).equalsIgnoreCase(""))
{
	TotalTransportation = "0.00";
}
else
{
	TotalTransportation = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("transcost"))) * totnoofanimals);
//	TotalTransportation = TotalTransportation * totnoofanimals;
}

// Maintainance Cost
String feed = "0.00";
feed = Helper.correctNull((String)hshValues.get("feed"));
if(Helper.correctNull((String)hshValues.get("feed")).equalsIgnoreCase(""))
{
	TotalMaintainance = "0.00";
}
else
{
	if(feed.equalsIgnoreCase(""))
	{
		feed = "0.00";
	}
	else
	{
		TotalMaintainance = nf.format(Double.parseDouble(feed));
	}
}

// Total Veterinary Aid Cost

if(Helper.correctNull((String)hshValues.get("vetaid")).equalsIgnoreCase(""))
{
	veterinaryaid = 0.00;
}
else
{
	veterinaryaid = Double.parseDouble(Helper.correctDouble((String)hshValues.get("vetaid")));
}
ExpensesVeterinaryaid = nf.format(veterinaryaid * totalanimal);

// Electricity & Other Expenses 

if(Helper.correctNull((String)hshValues.get("elecexp")).equalsIgnoreCase(""))
{
	Electricityexpenses = "0.00";
}
else
{
	Electricityexpenses = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("elecexp"))) * 12);
}

if(Helper.correctNull((String)hshValues.get("otherexp")).equalsIgnoreCase(""))
{
	OtherExpenses = "0.00";
}
else
{
	OtherExpenses = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("otherexp"))) * totnoofanimals);
}

// Cost of Equipments

if(Helper.correctNull((String)hshValues.get("totequipcost")).equalsIgnoreCase(""))
{
	TotalEquipments = "0.00";
}
else
{
	TotalEquipments = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totequipcost"))));
}

// Labours Cost

if(Helper.correctNull((String)hshValues.get("nooflabour")).equalsIgnoreCase(""))
{
	noofLabour = 0.00;
}
else
{
	noofLabour = Double.parseDouble(Helper.correctDouble((String)hshValues.get("nooflabour")));
}
if(Helper.correctNull((String)hshValues.get("salmonth")).equalsIgnoreCase(""))
{
	monthsalaryLabour = 0.00;
}
else
{
	monthsalaryLabour = Double.parseDouble(Helper.correctDouble((String)hshValues.get("salmonth")));
}
ExpensesofLabour = nf.format(noofLabour * (monthsalaryLabour * 12));

// Total Project Cost

TotalProjectCost = nf.format(Double.parseDouble(TotalCostAnimals) + Double.parseDouble(TotalConstructionCost) + Double.parseDouble(TotalTransportation) + Double.parseDouble(TotalInsurancePremium) + Double.parseDouble(TotalMaintainance) + Double.parseDouble(ExpensesVeterinaryaid) + Double.parseDouble(Electricityexpenses) + Double.parseDouble(TotalEquipments) + Double.parseDouble(ExpensesofLabour) + Double.parseDouble(OtherExpenses));

// Loan Amount

TotalLoanAmount = nf.format(Double.parseDouble(TotalProjectCost) - (Double.parseDouble(MarginAmount) + Double.parseDouble(SubsidyMarginAmount)));

// Margin Amount 

	if(Modmargin!="")
	{
		MarginAmount = nf.format((Double.parseDouble(TotalProjectCost) * Double.parseDouble(Modmargin)) / 100);
	}
	else
	{
		MarginAmount = nf.format((Double.parseDouble(TotalProjectCost) * Double.parseDouble(Margin)) / 100);
	}
	if(ModSubsidyMargin!="")
	{
		SubsidyMarginAmount = nf.format((Double.parseDouble(TotalProjectCost) * Double.parseDouble(ModSubsidyMargin)) / 100);
		
	}
	else
	{
		SubsidyMarginAmount = nf.format((Double.parseDouble(TotalProjectCost) * Double.parseDouble(SubsidyMargin)) / 100);
	
	}
	if(ModInterestrate!="")
	{
		TotalInterestRate = nf.format(Double.parseDouble(ModInterestrate));
	}
	else
	{
		TotalInterestRate = nf.format(Double.parseDouble(interestrate));
	}
	if(ModTotalLoanamount!="")
	{
		TotalLoanAmount = nf.format(Double.parseDouble(ModTotalLoanamount));
	}
	else
	{
		TotalLoanAmount = nf.format(Double.parseDouble(TotalProjectCost) - (Double.parseDouble(MarginAmount) + Double.parseDouble(SubsidyMarginAmount)));
	}
%>
<html>
<head>
<title>Appraisal - EMI Calculation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

var Repaymentperiod = "<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_reqterms"))))%>";
var Holidayperiod = "<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("loan_noofinstallment"))))%>";
var ModEMIAmount = "<%=ModEMIAmount%>";
var Modmargin = "<%=Modmargin%>";
var subsidyamount = "<%=subsidyamt%>";
var Margin = "<%=Margin%>";
var ModSubsidyMargin = "<%=ModSubsidyMargin%>";
var SubsidyMargin = "<%=SubsidyMargin%>";
var interestrate = "<%=TotalInterestRate%>";
var loanamount = "<%=TotalLoanAmount%>";

var tenor = Repaymentperiod - Holidayperiod;
function calculateEMI(interest, tenor, loanamount)
{
	var rate;
	var numerator;
	var denominator;
	var EMI;
	var loanamount = loanamount;
	rate = parseFloat(interest)/(12*100);
	denominator = Math.pow(rate+1, tenor)-1;
	numerator = rate * Math.pow(rate+1, tenor);
	EMI = (numerator / denominator) * loanamount;
	EMI = Math.ceil(EMI);	
	return EMI;
}
EMI = calculateEMI(interestrate, tenor, loanamount);

function callonLoad()
{	
	if(subsidyamount > 0 )
	{
		document.forms[0].txt_subsidyamount.value = subsidyamount;
		
	}
	if(ModEMIAmount!="")
	{
		document.forms[0].txt_EMI.value = eval(ModEMIAmount);
	}
	else
	{
		document.forms[0].txt_EMI.value = eval(EMI);
	}
	if(Modmargin!="")
	{
		document.forms[0].txt_margin.value = Modmargin;
	}
	else
	{
		document.forms[0].txt_margin.value = Margin;
	}
	if(ModSubsidyMargin!="")
	{
		document.forms[0].txt_subsidy.value = ModSubsidyMargin;
	}
	else
	{
		document.forms[0].txt_subsidy.value = SubsidyMargin;
	}
	if(subsidyamount != "")
	{
	 	document.forms[0].txt_subsidyamt.value = subsidyamount;
	}
	if(document.forms[0].hidAction.value=="")
	{		
		document.forms[0].cmdapply.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdclose.disabled=true;
	}
	else
	{
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdclose.disabled=false;
		document.forms[0].cmdcancel.disabled=true;
	}
}

function callmodifyamt()
{
	document.forms[0].txt_subsidyamt.value = 0;
}

function calledit()
{
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}

function callCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}
}

function calculatemargin()
{
	var loan_amt = document.forms[0].txt_totalprojectcost.value;
	var mod_margin = document.forms[0].txt_margin.value;
	var loanamount = 0.00;
	loanamount = eval((loan_amt *  mod_margin)/100);
	document.forms[0].txt_marginamount.value = Math.ceil(loanamount);
}

function calculatemarginsubsidy()
{
	var loan_amt = document.forms[0].txt_totalprojectcost.value;
	var mod_margin = document.forms[0].txt_subsidy.value;
	var loanamount = 0.00;
	loanamount = ((loan_amt *  mod_margin)/100);
	document.forms[0].txt_subsidyamount.value = Math.ceil(loanamount);
}
function calculatemarginsubsidyamt()
{
	var mod_margin = document.forms[0].txt_subsidyamt.value;
	document.forms[0].txt_subsidy.value = 0;
	document.forms[0].txt_subsidyamount.value = Math.ceil(mod_margin);
}

function enableButtons(bool1)
{
	document.forms[0].cmdapply.disabled=bool1;
}

function doSave()
{

	document.forms[0].cmdapply.disabled=true;
	document.forms[0].hidAction.value="load";
	document.forms[0].hidBeanId.value="agriapprisal";
	document.forms[0].hidBeanMethod.value="updatedairyfarmingData";
	document.forms[0].hidBeanGetMethod.value="getDatadairyfindata";
	document.forms[0].hidSourceUrl.value="/action/agr_dairyfarmingappraisal.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		//document.forms[0].action = appURL+"action/persearch.jsp";
		//document.forms[0].submit();
	}
}

function calTotalinterst()
{
	var loanamount = eval(document.forms[0].txt_loanamount.value);
	var interestrate = eval(document.forms[0].txt_interest.value);
	EMI = calculateEMI(interestrate, tenor, loanamount);
	document.forms[0].txt_EMI.value = eval(EMI);
}

function calTotalLoan()
{
	document.forms[0].txt_loanamount.value = Math.ceil(eval(document.forms[0].txt_totalprojectcost.value) - (eval(document.forms[0].txt_marginamount.value) + eval(document.forms[0].txt_subsidyamount.value)));
	var loanamount = eval(document.forms[0].txt_loanamount.value);
	EMI = calculateEMI(interestrate, tenor, loanamount);
	document.forms[0].txt_EMI.value = eval(EMI);
	CalculateLeastAmount();
}

function CalculateLeastAmount()
{
	var eligibleamount = document.forms[0].txt_loanamount.value;
	var prdLoanamount = document.forms[0].txt_prdLoanamount.value;
	var amountrequested =  document.forms[0].txt_amountrequested.value;
	var Leastamount = 0;
	if(eval(eligibleamount) < eval(prdLoanamount))
	{
	   if (eval(eligibleamount) < eval(amountrequested))
	   {
	   		Leastamount = eligibleamount;
	   }
	   else
	   {
	   		Leastamount = amountrequested;
	   }
	}
	else if(eval(prdLoanamount) < eval(amountrequested))
	{
	 	Leastamount = prdLoanamount;
	}
	else
	{
		Leastamount = amountrequested;
	}
	document.forms[0].txt_leastamount.value = Leastamount;
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad();CalculateLeastAmount()">
<form name="appform" method="post" action="">
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable border1"
	align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"
					align="center">
					<tr>

						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td width="3%">&nbsp;</td>
                              <td width="57%">Cost 
                                for Purchase of Animals</td>
                              <td width="3%"> <%=ApplicationParams.getCurrency()%></td>
                              <td width="37%"><input type="text" name="txt_purchaseanimals"
											maxlenght="10" size="15" style="text-align:right" value="<%=TotalCostAnimals%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Cost of 
                                Construction of Shed</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_constructionshed"
											maxlenght="10" size="15" style="text-align:right" value="<%=TotalConstructionCost%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td><font size="2" face="MS Sans Serif">Cost of 
                                Transportation</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_transportation"
											maxlenght="10" size="15" style="text-align:right" value="<%=TotalTransportation%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Insurance 
                                Expenses for First year</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_insuranceexpenses"
											maxlenght="10" size="15" style="text-align:right" value="<%=TotalInsurancePremium%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Cost of 
                                maintainance</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_mainatainance" maxlenght="10" value="<%=TotalMaintainance%>"
											size="15" style="text-align:right"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Cost of 
                                Veterinary Aid</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_veterinaryaid" maxlenght="10"
											size="15" style="text-align:right" value="<%=ExpensesVeterinaryaid%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Cost of 
                                Electricity</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_electricity" maxlenght="10"
											size="15" style="text-align:right" value="<%=Electricityexpenses%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Cost of 
                                Equipments/ Machineries</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_equipments" maxlenght="10"
											size="15" style="text-align:right" value="<%=TotalEquipments%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Cost of 
                                Labours</td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_labours" maxlenght="10" value="<%=ExpensesofLabour%>"
											size="15" style="text-align:right"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Other Expenses 
                                </td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_otherexpenses" maxlenght="10"
											size="15" style="text-align:right" value="<%=OtherExpenses%>"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td><b>Total 
                                Project Cost</b></td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_totalprojectcost" value="<%=TotalProjectCost%>"
											maxlenght="10" size="15" style="text-align:right"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Margin at&nbsp;&nbsp;&nbsp; 
                                <input
											type="text" name="txt_margin" maxlenght="10" size="15" value=""
											style="text-align:right" onBlur="calculatemargin();calTotalLoan()">
                                % </td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td><input type="text" name="txt_marginamount" maxlenght="10" value="<%=MarginAmount%>"
											size="15" style="text-align:right"></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Subsidy 
                                at 
                                <input
											type="hidden" name="txt_subsidy" maxlenght="10" size="15" value=""
											style="text-align:right" onBlur="calculatemarginsubsidy();calTotalLoan();CalculateLeastAmount()" onChange="callmodifyamt()">
                                or&nbsp;&nbsp; 
                                <input
											type="text" name="txt_subsidyamt" maxlenght="10" size="15" value=""
											style="text-align:right" onchange ="calculatemarginsubsidyamt()" onBlur="calTotalLoan();CalculateLeastAmount()">
                                </td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td> 
                                <input type="text"
											name="txt_subsidyamount" maxlenght="10" size="15"  value="<%=SubsidyMarginAmount%>"
											style="text-align:right">
                                </td>
                            </tr>
                            <tr>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td><b>Eligible 
                                Loan Amount</b> </td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td> 
                                <input type="text"
											name="txt_loanamount" maxlenght="10" size="15" value="<%=TotalLoanAmount%>"											style="text-align:right">
                                </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td><b> Loan 
                                Amount According to Scheme</b> </td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td> 
                                <input type="text"
											name="txt_prdLoanamount" maxlenght="10" size="15" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("productmaxamount"))))%>"
											style="text-align:right" onBlur="calTotalinterst()">
                                </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td><b>Loan 
                                Amount Requested</b></td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td> 
                                <input type="text"
											name="txt_amountrequested" maxlenght="10" size="15" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("amtreqd"))))%>"
											style="text-align:right" onBlur="calTotalinterst()">
                                </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td><b> Loan 
                                Amount Recommended</b> </td>
                              <td> <%=ApplicationParams.getCurrency()%></td>
                              <td> 
                                <input type="text"
											name="txt_leastamount" maxlenght="10" size="15" value=""
											style="text-align:right" onBlur="calTotalinterst()">
                                </td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Repayment 
                                Period </td>
                              <td>&nbsp;</td>
                              <td><%=Helper.correctNull((String)hshValues.get("loan_reqterms"))%>&nbsp;Months</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Initial 
                                Repayment Holiday</td>
                              <td>&nbsp;</td>
                              <td><%=Helper.correctNull((String)hshValues.get("loan_noofinstallment"))%>&nbsp; 
                                Months</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Interest 
                                Rate </td>
                              <td>&nbsp;</td>
                              <td> 
                                <input type="text"
											name="txt_interest" maxlenght="10" size="15" value="<%=TotalInterestRate%>"
											style="text-align:right" onBlur="calTotalinterst()">
                                %</td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td>Equal Monthly 
                                Installments </td>
                              <td>&nbsp;</td>
                              <td>
                                <input type="text" style="text-align:right"
											name="txt_EMI" maxlenght="10" size="15" value="">
                                &nbsp; </td>
                            </tr>
                          </table>
								</td>
							</tr>
						</table>
						<br>
						<table width="12%" border="0" align="center" cellpadding="0"
							cellspacing="0" class="outertable" class="blackfont">
							<tr>
								<td valign="top">
								<table width="12%" border="0" align="center" cellpadding="0"
									cellspacing="0" class="blackfont">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="2">
											<tr valign="top">
												<td><input type="button" name="cmdedit"
													value="Edit"
													style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
													onClick="calledit()"></td>
												<td><input type="button" name="cmdapply"
													value="Save"
													style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
													onClick="doSave()"></td>
												<td><input type="button" name="cmdcancel"
													value="Cancel"
													style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
													onClick="callCancel()"></td>
												<td><input type="button" name="cmdclose"
													value="Close"
													style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
													onClick="doClose()"></td>
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
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="<%=Helper.correctNull((String)hshValues.get("hidAction"))%>"></form>

</body>
</html>





