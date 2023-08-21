<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
String strint="0.00";
String strslabintrate ="";
String strslabtoamt ="";
ArrayList arrSlabIntrstval =new ArrayList();
ArrayList arrSlabToAmt = new ArrayList();
String interesttype =(String)hshValues.get("interesttype");
String marginper=Helper.correctNull((String)hshValues.get("margin_perct"));
String strcategorytype = Helper.correctNull((String) request.getParameter("hidCategoryType"));
String strPurposeid = Helper.correctNull((String) request.getParameter("hidpurpose"));

if(interesttype.equals("fixedfloating") || interesttype.equals("slabrate") || interesttype.equals("Combo"))
{	
	if(!Helper.correctNull((String)hshValues.get("prd_interest")).equals(""))
	{
		strint = Helper.correctNull((String)hshValues.get("prd_interest"));
	}
	else
	{
		strint="0.00";
	}
	
	if( interesttype.equals("slabrate"))
	{
		arrSlabIntrstval = (ArrayList)hshValues.get("slab_Tointerest");
		arrSlabToAmt = (ArrayList)hshValues.get("slab_Toamt");	 
		for(int i=0;i<arrSlabIntrstval.size();i++)
		{
			strslabintrate = strslabintrate +arrSlabIntrstval.get(i)+"^";
			strslabtoamt =strslabtoamt +arrSlabToAmt.get(i)+"^";
		}
	}
}

%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var varProductType="<%=Helper.correctNull((String)request.getParameter("varProductType"))%>"
var varPurposeCode = "<%=strPurposeid%>";
var varProposalType="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varDevVal="<%=Helper.correctNull((String)hshValues.get("strDevIntRate"))%>";
var varDevFlag="<%=Helper.correctNull((String)hshValues.get("strDevIntFlag"))%>";
function loadValues()
{
	if(varProposalType=="P")
	{
		if(parent.frames.document.forms[0].sel_mclrtype.value!="")
		{

			parent.frames.document.forms[0].hidcreditrskpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_creditrskpremium"))%>";
			parent.frames.document.forms[0].hidbusstrategicpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_busstrategicpremium"))%>";
			
			parent.frames.document.forms[0].hidCRP.value="<%=Helper.correctDouble((String)hshValues.get("prd_creditrskpremium"))%>";
			parent.frames.document.forms[0].hidBSP.value="<%=Helper.correctDouble((String)hshValues.get("prd_busstrategicpremium"))%>";

			if(parent.frames.document.forms[0].hidcreditrskpremium.value=="0.00" && parent.frames.document.forms[0].hidbusstrategicpremium.value=="0.00")
			{
				alert("Credit Risk Premium & Business Strategic Premium values are zero");
				if(varProductType=="pR")
				{
					parent.frames.document.forms[0].txtloan_intrate.value ="0.00";
					parent.frames.document.forms[0].txtloan_modintrate.value = "0.00";
					parent.frames.document.forms[0].hidifrminterestrates.value ="0.00";
					parent.frames.document.forms[0].hidifrmtoamt.value="0.00";
					return;
				}
				parent.frames.document.forms[0].selectinttype.value="0";
				parent.frames.document.forms[0].sel_mclrtype.value="";
				return;
			}
			
			var varspread=0;
			var varvalue=parent.frames.document.forms[0].sel_mclrtype.value;
			var vararr=varvalue.split("@");
			if(vararr!=null)
			{
				varspread=vararr[1];
				if(parent.frames.document.forms[0].hidODFlag.value=="OD")
					parent.frames.document.forms[0].hidMCLRTableCode.value=vararr[3];
				else
					parent.frames.document.forms[0].hidMCLRTableCode.value=vararr[2];
				parent.frames.document.forms[0].hidBaserate.value=vararr[1];
			}

			varspread=parseFloat(varspread)+
			parseFloat(parent.frames.document.forms[0].hidcreditrskpremium.value)
			+parseFloat(parent.frames.document.forms[0].hidbusstrategicpremium.value);

			varspread=roundVal(varspread);
			

			parent.frames.document.forms[0].txtloan_intrate.value =varspread;
			parent.frames.document.forms[0].txtloan_modintrate.value = varspread;
			parent.frames.document.forms[0].hidifrminterestrates.value =varspread;
			parent.frames.document.forms[0].hidifrmtoamt.value=varspread;
		}
		else
		{
			alert("select Reference Type");
			parent.frames.document.forms[0].txtloan_intrate.value ="";
			parent.frames.document.forms[0].txtloan_modintrate.value = "";
			parent.frames.document.forms[0].hidifrminterestrates.value ="";
			parent.frames.document.forms[0].hidifrmtoamt.value="";
			return;
		}
		parent.frames.document.forms[0].hidInterestIndexId.value="<%=Helper.correctNull((String)hshValues.get("prd_interestid"))%>";
	}
	else
	{
		parent.frames.document.forms[0].hidifrminterestrates.value="";
		parent.frames.document.forms[0].hidifrmtoamt.value="";	
		var interesttype ="<%=interesttype%>";
		parent.frames.document.forms[0].hidifrminteresttype.value = interesttype;
	
		if(varProductType=='pH' && varPurposeCode=='H')
		{
			//parent.frames.document.forms[0].document.forms[0].txtMarginpercent.value="0";
		}
		else if(varProductType=='pA' && varPurposeCode=='U')
		{
			//parent.frames.document.forms[0].document.forms[0].txtMarginpercent.value="0";
		}
		else
		{
			parent.frames.document.forms[0].txtMarginpercent.value="<%=marginper%>";
		}
	
		if(interesttype=="Flexi")
		{	
			/*if("<%//=strint%>"==0.00)
				{
				parent.frames.document.forms[0].txtloan_intrate.value = "";
				parent.frames.document.forms[0].txtloan_modintrate.value = "";
				parent.frames.document.forms[0].hidifrminterestrates.value = "";
				parent.frames.document.forms[0].hidifrmtoamt.value="";	
				//parent.frames.document.forms[0].selectinttype.value="0";
				parent.frames.document.forms[0].selectinttype.focus();
				alert("Interest for Selected Interest Type is not defined in the product");	
				return;
				}
	
			parent.frames.document.forms[0].txtloan_intrate.value = "<%//=strint%>";
			parent.frames.document.forms[0].txtloan_modintrate.value = "<%//=strint%>";
			parent.frames.document.forms[0].hidifrminterestrates.value = "<%//=strstepintrate%>";
			parent.frames.document.forms[0].hidifrmtoamt.value="<%//=strsteptoamt%>";
			callStepUpCalculate()*/
	
		}
		else 
		{
	
			if(parent.frames.document.forms[0].selectinttype.value!="2")
			{
	
				if(varProductType!="pR")
				{
					if("<%=strint%>"==0.00)
					{
						parent.frames.document.forms[0].txtloan_intrate.value = "";
						parent.frames.document.forms[0].txtloan_modintrate.value = "";
						parent.frames.document.forms[0].hidifrminterestrates.value = "";
						parent.frames.document.forms[0].hidifrmtoamt.value="";	
						//parent.frames.document.forms[0].selectinttype.value="0";
						parent.frames.document.forms[0].selectinttype.focus();
						alert("Interest for Selected Interest Type is not defined in the product");
						return;
					}
				}
				
				parent.frames.document.forms[0].txtloan_intrate.value = "<%=strint%>";
				parent.frames.document.forms[0].txtloan_modintrate.value = "<%=strint%>";
				parent.frames.document.forms[0].hidifrminterestrates.value = "<%=strint%>";
				parent.frames.document.forms[0].hidifrmtoamt.value="<%=strint%>";
				parent.frames.document.forms[0].hidcreditrskpremium.value="";
				parent.frames.document.forms[0].hidbusstrategicpremium.value="";	
				parent.frames.document.forms[0].hidCRP.value="";
				parent.frames.document.forms[0].hidBSP.value="";
				parent.frames.document.forms[0].hidMCLRTableCode.value="";
				parent.frames.document.forms[0].sel_mclrtype.value="";	
				parent.frames.document.forms[0].hidBaserate.value="<%=Helper.correctNull((String)hshValues.get("prd_baserate"))%>";	
			}
			else
			{
				if(parent.frames.document.forms[0].sel_mclrtype.value!="")
				{

					if(varDevFlag!="Y")
					{
						parent.frames.document.forms[0].hidcreditrskpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_creditrskpremium"))%>";
						parent.frames.document.forms[0].hidbusstrategicpremium.value="<%=Helper.correctDouble((String)hshValues.get("prd_busstrategicpremium"))%>";
					}

					parent.frames.document.forms[0].hidCRP.value="<%=Helper.correctDouble((String)hshValues.get("prd_creditrskpremium"))%>";
					parent.frames.document.forms[0].hidBSP.value="<%=Helper.correctDouble((String)hshValues.get("prd_busstrategicpremium"))%>";
	
					if(parent.frames.document.forms[0].hidcreditrskpremium.value=="0.00" && parent.frames.document.forms[0].hidbusstrategicpremium.value=="0.00")
					{
						alert("Credit Risk Premium & Business Strategic Premium values are zero");
						if(varProductType=="pR")
						{
							parent.frames.document.forms[0].txtloan_intrate.value ="0.00";
							parent.frames.document.forms[0].txtloan_modintrate.value = "0.00";
							parent.frames.document.forms[0].hidifrminterestrates.value ="0.00";
							parent.frames.document.forms[0].hidifrmtoamt.value="0.00";
							return;
						}
						parent.frames.document.forms[0].selectinttype.value="0";
						parent.frames.document.forms[0].sel_mclrtype.value="";
						return;
					}
					
					var varspread=0;
					var varvalue=parent.frames.document.forms[0].sel_mclrtype.value;
					var vararr=varvalue.split("@");
					if(vararr!=null)
					{
						varspread=vararr[1];
						
						if(parent.frames.document.forms[0].hidODFlag.value=="OD")
							parent.frames.document.forms[0].hidMCLRTableCode.value=vararr[3];
						else
							parent.frames.document.forms[0].hidMCLRTableCode.value=vararr[2];
						
						parent.frames.document.forms[0].hidBaserate.value=vararr[1];
					}
	
					varspread=parseFloat(varspread)+
					parseFloat(parent.frames.document.forms[0].hidcreditrskpremium.value)
					+parseFloat(parent.frames.document.forms[0].hidbusstrategicpremium.value);

					var varspread1=parseFloat(parent.frames.document.forms[0].hidBaserate.value)+
					parseFloat(parent.frames.document.forms[0].hidCRP.value)
					+parseFloat(parent.frames.document.forms[0].hidBSP.value);

					varspread=roundVal(varspread);
					
					parent.frames.document.forms[0].txtloan_intrate.value =varspread1;
					parent.frames.document.forms[0].txtloan_modintrate.value = varspread;
					parent.frames.document.forms[0].hidifrminterestrates.value =varspread;
					parent.frames.document.forms[0].hidifrmtoamt.value=varspread;
				}
				else
				{
					alert("select Reference Type");
					parent.frames.document.forms[0].txtloan_intrate.value ="";
					parent.frames.document.forms[0].txtloan_modintrate.value = "";
					parent.frames.document.forms[0].hidifrminterestrates.value ="";
					parent.frames.document.forms[0].hidifrmtoamt.value="";
					return;
				}
			}
			parent.frames.document.forms[0].hidInterestIndexId.value="<%=Helper.correctNull((String)hshValues.get("prd_interestid"))%>";
			callCalculate()
		} 
		
		if(interesttype=="slabrate")
		{	
			parent.frames.document.forms[0].hidifrminterestrates.value = "<%=strslabintrate%>";
			parent.frames.document.forms[0].hidifrmtoamt.value="<%=strslabtoamt%>";
		}
		parent.frames.calculateLoanAmount();
		parent.frames.Eligibility_check();
		if((varProductType=="pU" && parent.frames.document.forms[0].hidvehicletype.value=='2') || (varProductType=="pA"  && parent.frames.document.forms[0].hidpurpose.value=='2'))
		{
			parent.frames.getMargincalc();
		}
			parent.frames.document.forms[0].hidScore.value = "<%=Helper.correctNull((String)hshValues.get("strScore"))%>";


			if(varDevFlag=="Y")
			{
				parent.frames.document.forms[0].txtloan_modintrate.value = roundVal(varDevVal);
			}
		
	}
}

function callnetTrade()
{
	/*var varltradein=parent.frames.document.forms[0].txtloan_tradein.value;
	var varlltradein=parent.frames.document.forms[0].txtloan_loantrade.value;
	if(varltradein == "")
	{
		varltradein = "0.00";
	}
	if(varlltradein == "")
	{
		varlltradein = "0.00";
	}
	vartradein=parseFloat(varltradein)-parseFloat(varlltradein);
	parent.frames.document.forms[0].txtnetTradeIn.value=roundVal(vartradein);*/
}

function callCalculate()
{	
	var varterm=trim(parent.frames.document.forms[0].txtloan_reqterms.value);
	var varcostofloan=parseFloat(roundVal(parent.frames.document.forms[0].txtloan_costloanprd.value));
	var varamtreqst=parseFloat(parent.frames.document.forms[0].txtloan_amtreqd.value);		
	if(varterm!="")
	{
		//callnetTrade();
		var varrecomlvr=parseFloat(parent.frames.document.forms[0].txtMarginpercent.value);
		var vardownpay;
		var varminmargin;// added by suresh for calculating minimum magin
		//var vartradein=parseFloat(parent.frames.document.forms[0].txtnetTradeIn.value);		
		//var varActuallvr;
		var varAmtrecomd;
		
		if(varamtreqst!="0.00" && !isNaN(varamtreqst))
		{
			if(varcostofloan!="0.00" && !isNaN(varcostofloan))
			{
				if(varcostofloan==varamtreqst)
				{
					/*if(vartradein==0)
					{
						vardownpay = varamtreqst - (varamtreqst * (100-varrecomlvr)/100);
						varminmargin=varcostofloan*varrecomlvr/100;
						varActuallvr=varrecomlvr;
						
					}else
					{
						vardownpay=(varamtreqst-(varamtreqst * (100-varrecomlvr)/100))+vartradein;
						varminmargin=varcostofloan*varrecomlvr/100;
						varActuallvr=((varamtreqst-vardownpay)/varamtreqst)*100;
					}*/
					varAmtrecomd=(100-varrecomlvr)*varamtreqst/100;
				}
				else if(varcostofloan > varamtreqst)
				{
					var costLoan = (varcostofloan * (100-varrecomlvr)/100);
					if(costLoan < varamtreqst)
					{
						varAmtrecomd = costLoan;
						vardownpay = (varcostofloan - varAmtrecomd);// + vartradein;
						varminmargin=varcostofloan*varrecomlvr/100;
					}
					else
					{
						varAmtrecomd = varamtreqst;
						vardownpay = (varcostofloan - varAmtrecomd);// + vartradein;
						varminmargin=varcostofloan*varrecomlvr/100;
					}

					/*if(vartradein > 0)
					{
						varAmtrecomd = varAmtrecomd - vartradein;
					}*/
					//varActuallvr=((varcostofloan-vardownpay)/varcostofloan)*100;

				}
				//parent.frames.document.forms[0].txtloan_downpay.value=roundVal(vardownpay);
				parent.frames.document.forms[0].txtloan_downpay.value=NanNumber(roundVal(varminmargin));
				//if(varActuallvr=="")
				//parent.frames.document.forms[0].actLoanValRatio.value=NanNumber(roundVal(varActuallvr));
				parent.frames.document.forms[0].txtloan_recmdamt.value=NanNumber(roundVal(varAmtrecomd));
		callStepSanc();
				/*var varrate=parseFloat(parent.frames.document.forms[0].txtloan_modintrate.value);
				if(varrate!=""||varrate!="0.00")
				{	
					varrate=parseFloat(parent.frames.document.forms[0].txtloan_modintrate.value)/(12*100);
					var term=trim(parent.frames.document.forms[0].txtloan_reqterms.value);//mck

					var mor =trim(parent.frames.document.forms[0].txt_installments.value);//mck
					if(mor=="")
					{
						mor="0";
					}

					var varterm=parseInt(term)-parseInt(mor);
					var denominator=Math.pow(varrate+1,varterm)-1;
					var varnumerator=varrate*Math.pow(varrate+1,varterm);
					var varemi=(varnumerator/denominator)*varAmtrecomd;
					var vartotal=varemi*varterm;
					varemi=Math.round(varemi);
					//parent.frames.document.forms[0].txtmonPay.value=varemi;
					//parent.frames.document.forms[0].txttotPayment.value=roundVal(vartotal);	
				}
				else
				{
					parent.frames.document.forms[0].txtmonPay.value="0.00";
					//parent.frames.document.forms[0].txttotPayment.value="0.00";	
				}*/
			}
			else
			{
				//alert(document.forms[0].hidCategoryType.value);
				if(document.forms[0].hidCategoryType.value=="LAD")
				{
						/*if(varcostofloan=="" || varcostofloan=="0.00")
						{
							ShowAlert('121'," Security Value");
						 	parent.frames.document.forms[0].txtloan_costloanprd.focus();
						 	return;
						}*/
				}	
				else
				  {
					  if(varProductType!='pV')
					  {
						if(parent.frames.document.forms[0].txtloan_costloanprd.value == "")
						{
							//ShowAlert('121',"Cost of the Project");
							parent.frames.document.forms[0].txtloan_costloanprd.value="";
							parent.frames.document.forms[0].txtloan_costloanprd.focus();
							return;
						}
					  }
				  }
			}
			
		}
		else
		{
			ShowAlert('121'," amount requested");
			parent.frames.document.forms[0].txtloan_amtreqd.value="";
			parent.frames.document.forms[0].txtloan_amtreqd.focus();
			return;
		}
	}	
	
}

function callStepUpCalculate()
{	
	/*var varterm=trim(parent.frames.document.forms[0].txtloan_reqterms.value);
	var varcostofloan=parseFloat(roundVal(parent.frames.document.forms[0].txtloan_costloanprd.value));
	var varamtreqst=parseFloat(parent.frames.document.forms[0].txtloan_amtreqd.value);
	if(varterm!="")
	{
		callnetTrade();
		var varrecomlvr=parseFloat(parent.frames.document.forms[0].txtMarginpercent.value);
		var vardownpay;
		var vartradein=parseFloat(parent.frames.document.forms[0].txtnetTradeIn.value);		
		var varActuallvr;
		var varAmtrecomd;		
		if(varamtreqst!="0.00" && !isNaN(varamtreqst))
		{		
			if(varcostofloan!="0.00" && !isNaN(varcostofloan))
			{
				if(varcostofloan==varamtreqst)
				{
					if(vartradein==0)
					{
						vardownpay = varamtreqst - (varamtreqst * (100-varrecomlvr)/100);
						varActuallvr=varrecomlvr;						
					}
					else
					{
						vardownpay=(varamtreqst-(varamtreqst * (100-varrecomlvr)/100))+vartradein;
						varActuallvr=((varamtreqst-vardownpay)/varamtreqst)*100;
					}
					varAmtrecomd=(100-varActuallvr)*varamtreqst/100;
				}
				else if(varcostofloan > varamtreqst)
				{					
					var costLoan = (varcostofloan * (100-varrecomlvr)/100);
					if(costLoan < varamtreqst)
					{
						varAmtrecomd = costLoan;
						vardownpay = (varcostofloan - varAmtrecomd) + vartradein;
					}
					else
					{
						varAmtrecomd = varamtreqst;
						vardownpay = (varcostofloan - varAmtrecomd) + vartradein;
					}
					if(vartradein > 0)
					{
						varAmtrecomd = varAmtrecomd - vartradein;
					}
					varActuallvr=((varcostofloan-vardownpay)/varcostofloan)*100;
				}				
				parent.frames.document.forms[0].actLoanValRatio.value=NanNumber(roundVal(varActuallvr));
				parent.frames.document.forms[0].txtloan_recmdamt.value=NanNumber(roundVal(varAmtrecomd));
				callStepSanc();
				var interest="0.00";
				var toamt="0.00";
				var varrate;
				var varterm;
				var denominator;
				var varnumerator;
				var varemi="0.00";
				var vartotal;
				var arrinterestval  = <strstepintrate%>";
				var arrsteptoamt = <strsteptoamt%>";	
				arrinterestval = arrinterestval.split("^");
				arrsteptoamt   = arrsteptoamt.split("^");
				varterm=trim(parent.frames.document.forms[0].txtloan_reqterms.value);
				if(arrinterestval)
				{	for(j=0;j<(arrinterestval.length)-1;j++)
					{
						interest = arrinterestval[j];
						varrate=parseFloat(eval(interest))/(12*100);
						denominator=Math.pow(varrate+1,varterm)-1;
						varnumerator=varrate*Math.pow(varrate+1,varterm);
						toamt = arrsteptoamt[j];
						varemi=eval(varemi)+((varnumerator/denominator)*toamt);					
					}
					vartotal = eval(varemi)*eval(varterm);
					varemi=Math.round(varemi);
					//parent.frames.document.forms[0].txttotPayment.value=roundVal(vartotal);
				}		
				else
				{
					parent.frames.document.forms[0].txtmonPay.value="0.00";
					//parent.frames.document.forms[0].txttotPayment.value="0.00";		
				}
			}
			else
			{
				ShowAlert('121'," cost of loan product");
				parent.frames.document.forms[0].txtloan_costloanprd.value="";
 			    parent.frames.document.forms[0].txtloan_costloanprd.focus();
			}
		}
		else
		{
			ShowAlert('121'," amount requested");
			parent.frames.document.forms[0].txtloan_amtreqd.value="";
			parent.frames.document.forms[0].txtloan_amtreqd.focus();
		}

	}	 */
}

function callStepSanc()
{
	//var reqAmt = parent.frames.document.forms[0].txtloan_amtreqd.value;
	var costPrd = roundVal(parent.frames.document.forms[0].txtloan_costloanprd.value);
	//var sancAmt = roundVal(parent.frames.document.forms[0].txtloan_sancamt.value);
	var margin = parent.frames.document.forms[0].txtMarginpercent.value;
	
	/*if(sancAmt == "0.00" && sancAmt =="")
	{
		return;
	}
	var downpay = parseFloat(costPrd) - parseFloat(sancAmt);	
	var varrate=parseFloat(parent.frames.document.forms[0].txtloan_modintrate.value)/(12*100);
	var varterm=trim(parent.frames.document.forms[0].txtloan_reqterms.value)
	var denominator=Math.pow(varrate+1,varterm)-1;
	var varnumerator=varrate*Math.pow(varrate+1,varterm);
	var varemi=(varnumerator/denominator)*sancAmt;
	var vartotal=varemi*varterm;*/
	parent.frames.document.forms[0].txtloan_recmdamt.value=NanNumber(roundVal(parseFloat(costPrd) - (parseFloat(costPrd)*(parseFloat(margin)/100))));
	/*if(isNaN(varemi))
	{
		varemi = 0.00;
	}
	if(isNaN(vartotal))
	{
		vartotal=0.00;
	}
	if(parent.frames.document.forms[0].selrepaymenttype.value=="1" || parent.frames.document.forms[0].selrepaymenttype.value=="0")
	{
		varemi=Math.round(varemi);
		//parent.frames.document.forms[0].txttotPayment.value=roundVal(vartotal);
	}
	else
	{
		parent.frames.document.forms[0].txtmonPay.value="";
		parent.frames.document.forms[0].txttotPayment.value="";
	}*/
}
</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
<input type="hidden" name="hidCategoryType">
 </form>
</body>
</html>
