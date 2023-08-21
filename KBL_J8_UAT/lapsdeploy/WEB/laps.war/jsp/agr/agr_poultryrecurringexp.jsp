<%@include file="../share/directives.jsp"%>
<%
	ArrayList arryCol = new ArrayList();
	ArrayList arryRow = new ArrayList();
	arryRow  = (ArrayList) hshValues.get("arryRow");
	ArrayList arryCol1 = new ArrayList();
	ArrayList arryCol2 = new ArrayList();
	ArrayList arryRow1 = new ArrayList();
	arryRow1  = (ArrayList) hshValues.get("arryRow1");
	ArrayList arryRow2 = new ArrayList();
	arryRow2  = (ArrayList) hshValues.get("arryRow2");
	ArrayList arryRow3 = new ArrayList();
	ArrayList arryCol3 = new ArrayList();
	arryRow3  = (ArrayList) hshValues.get("arryRow3");
	ArrayList arryRow4 = new ArrayList();
	//ArrayList arryCol4 = new ArrayList();
	arryRow4  = (ArrayList) hshValues.get("arryRow4");
	if (arryRow == null) {
		arryRow  = new ArrayList();
	}
	if (arryRow1 == null) {
		arryRow1  = new ArrayList();
	}
	if (arryRow3 == null) {
		arryRow3  = new ArrayList();
	}
	if (arryRow2== null) {
		arryRow2  = new ArrayList();
	}
	if (arryRow4 == null) {
		arryRow4  = new ArrayList();
	}
	//String l12 = "", r3="",r5="",r7="",r10="",,mo3="",mo4="", l18 = ""n12="",,mo5="";
	
	String l1 = "", l2 = "", l3 = "", l4 = "", l5 = "", l6 = "", l7 = "", l8 = "", l9 = "", l10 = "";
	String l11 = "",  l13 = "", l14 = "", l15 = "", l16 = "", l17 = "";
	String m1 = "", m2 = "",m3 = "", m4 = "", m5 = "", m6 = "",k1="",k4="";
	//String r14="";
	String n1="",n2="",n3="",n4="",n5="",n7="",n8="",n10="",n11="",n6="",n9="";
	String g1="",g2="",g3="",g4="",g5="",c1="",c2="",a1="",a2="",a3="";
	//String mo1="",mo2=""r1="",r2="",r4="",r8="",r11="",r13="",;
	%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/agr_poultryrecurring.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";	
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var s=0;s<document.forms[0].length;s++)
	{
		if(document.forms[0].elements[s].type=="text")
		{
			document.forms[0].elements[s].readOnly=one;
		}	  
	   if(document.forms[0].elements[s].type=="textarea")
		{
			document.forms[0].elements[s].readOnly=one;		  
		}		
	}	
}

function doSave()
{	
   
	enableButtons( true, true, true, true, false);	
	margin();amount();callTotal();callSurplus();
	margin1();amount1();callTotal1();callSurplus1();
	amount2();labourcharge();
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_poultryrecurringexp.jsp";
	document.forms[0].hidBeanMethod.value="updaterecurringData";
	document.forms[0].hidBeanGetMethod.value="getrecurringData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
	disableFields(false);
 	for(var i=0;i<=12;i++)
 	{
	document.forms[0].txt_amount[i].readOnly =true;
    document.forms[0].txt_margin[i].readOnly =true;
    document.forms[0].txt_loanamount[i].readOnly =true;
  	}
 	for(var k=0;k<=4;k++)
 	{
    document.forms[0].txt_margin1[k].readOnly =true;
	document.forms[0].txt_amount1[k].readOnly =true;
    document.forms[0].txt_loanamount1[k].readOnly =true;
    document.forms[0].txt_item1[k].readOnly =true;
    document.forms[0].txt_cost1[k].readOnly =true;
	}
	for(var m=0;m<3;m++)
	{
	document.forms[0].txt_nochicks[m].readOnly =true;
	}
	
	document.forms[0]. txt_totalamount.readOnly =true; 
	document.forms[0]. txt_totalamount1.readOnly =true; 
	document.forms[0]. txt_totalamount2.readOnly =true;
	document.forms[0]. txt_totalmargin.readOnly =true; 
	document.forms[0]. txt_totalmargin1.readOnly =true; 
	document.forms[0]. txt_totalmargin2.readOnly =true; 
	document.forms[0]. txt_totalloanamount.readOnly =true; 
	document.forms[0]. txt_totalloanamount1.readOnly =true; 
	document.forms[0]. txt_totalloanamount2.readOnly =true;   
    document.forms[0].txt_totamount.readOnly =true;
    document.forms[0].txt_totloanamount.readOnly =true;
    document.forms[0].txt_totmargin.readOnly =true;
    document.forms[0].txt_totamount1.readOnly =true;
    document.forms[0].txt_totloanamount1.readOnly =true;
    document.forms[0].txt_totmargin1.readOnly =true;
  	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	 document.forms[0].txt_marginper.readOnly =true;
	  document.forms[0].txt_marginper1.readOnly =true;
	enableButtons(true, false, false, false);	
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
		//document.forms[0].hidSourceUrl.value="/action/agr_poultryrecurringexp.jsp";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getrecurringData";
		document.forms[0].action=appURL+"action/agr_poultryrecurringexp.jsp";
		document.forms[0].submit(); 		
	}

}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updaterecurringData";
	document.forms[0].hidBeanGetMethod.value="getrecurringData";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_poultryrecurringexp.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();
	}		
}

function onloading()
{	  
	disableFields(true);
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function margin()
{

	var marginper=document.forms[0].txt_marginper.value;
 	if(marginper=="")
	{
		marginper=0;
		document.forms[0].txt_marginper.value="0";		
	}
	document.forms[0].txt_marginper.value=eval(marginper);
	document.forms[0].txt_marginper1.value=eval(marginper);
	var num=(marginper)/100;
	var num1="";var str1="";
	var amount="";
	var str=num.toFixed(2);

	for(var m=0;m<=12;m++)
	{
		var amountval=document.forms[0].txt_amount[m].value;
 		if(amountval=="")
		{
			amountval=0;
		}
		amount=eval(str)*eval(amountval);
		document.forms[0].txt_margin[m].value=eval(amount);	
		roundtxt(document.forms[0].txt_margin[m]);
		num1=(amount);
		str1=num1.toFixed(2);
		document.forms[0].txt_margin[m].value=Math.round(eval(str1));	
		roundtxt(document.forms[0].txt_margin[m]);
	}
}

function amount()
{
	var mortality1=document.forms[0].txt_mortality1.value;
	var val=document.forms[0].txt_nochicks[0].value;
	if(val=="")
	{
		val=0;
	}
	if(mortality1=="")
	{
		mortality1=0;
	}
	mortality1=((mortality1)/100)*eval(val);
	mortality1=Math.round(mortality1);
	document.forms[0].txt_nochicks[2].value=eval(val)-eval(mortality1);
	for(var m=0;m<=2;m++)
	{
		var sqft=document.forms[0].txt_nochicks[m].value;
		var value=document.forms[0].txt_value[m].value;
		var batch=document.forms[0].txt_noofbatches[m].value;
		var value1=document.forms[0].txt_value1[m].value;
		if(sqft=="")
		{
			sqft=0;
		}
		if(value=="")
		{
			value=0;
		}
		if(batch=="")
		{
			batch=0;
		}
		if(value1=="")
		{
			value1=1;
		}
		var amount=eval(sqft)*eval(value)*eval(value1)*eval(batch);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount));	
		roundtxt(document.forms[0].txt_amount[m]);
	}
	margin();
}

function amount2()
{
	for(var m=3;m<=12;m++)
	{
		var sqft=document.forms[0].txt_charges[m-3].value;
		var varvalue=document.forms[0].txt_value2[m-3].value;
		var batch=document.forms[0].txt_month[m-3].value;
		if(sqft=="")
		{
			sqft=0;
		}
		if(varvalue=="")
		{
			varvalue=0;
		}
		if(batch=="")
		{
			batch=1;
		}
		var amount=eval(sqft)*eval(varvalue)*eval(batch);
		document.forms[0].txt_amount[m].value=Math.round(eval(amount));	
		roundtxt(document.forms[0].txt_amount[m]);
	}
	margin();
}
function amount3()
{

for(var m=0;m<=4;m++)
{

var value=document.forms[0].txt_cost1[m].value;
var batch=document.forms[0].txt_month1[m].value;
 
	if(value=="")
	{
	value=0;
		
	}
	if(batch=="")
	{
	batch=0;
		
	}
	
var amount=eval(value)*eval(batch);
document.forms[0].txt_amount1[m].value=Math.round(eval(amount));	
roundtxt(document.forms[0].txt_amount1[m]);
}


margin();
}

function callTotal()
{
amount();callSurplus();
var totalvalue1=0.00;var totalvalue2=0.00;var totalvalue3=0.00;
for(var m=0;m<=12;m++)
     {
var value1 =document.forms[0].txt_amount[m].value;
var margin= document.forms[0].txt_margin[m].value;
var loan=document.forms[0].txt_loanamount[m].value;
      if( value1 =="")
		{
			 value1 =0.00;
			
		}
		 if( margin=="")
		{
			margin =0.00;
			
		}
		if(loan=="")
		{
			loan =0.00;
			
		}
	totalvalue1 = eval(value1)+eval(totalvalue1)
	totalvalue2 = eval(margin)+eval(totalvalue2)
	totalvalue3 = eval(loan)+eval(totalvalue3)
	
     }
     
   document.forms[0].txt_totamount.value= eval(totalvalue1);
   document.forms[0].txt_totmargin.value= eval(totalvalue2);
   document.forms[0].txt_totloanamount.value= eval(totalvalue3);
   var num1=(totalvalue1);
   var str1=num1.toFixed(2);
   var num2=(totalvalue2);
   var str2=num2.toFixed(2);
    var num3=(totalvalue3);
   var str3=num3.toFixed(3);
    document.forms[0].txt_totamount.value=Math.round(eval(str1));
    roundtxt(document.forms[0].txt_totamount);
   document.forms[0].txt_totmargin.value= Math.round(eval(str2));
   roundtxt( document.forms[0].txt_totmargin);
   document.forms[0].txt_totloanamount.value= Math.round(eval(str3));
   roundtxt(document.forms[0].txt_totloanamount);
   calculateTotal();
}
function callSurplus()
{
var i;

for(var m=0;m<=12;m++)
{

var sur1 =  document.forms[0].txt_amount[m].value;
var sur2=document.forms[0].txt_margin[m].value;
 
      if(sur1=="")
		{
			sur1=0.00;
			
		}
		if(sur2=="")
		{
			sur2=0.00;
			
		}
 
  document.forms[0].txt_loanamount[m].value= Math.round(eval(sur1)-eval(sur2));
  roundtxt(document.forms[0].txt_loanamount[m]);
 	  
   if(eval(document.forms[0].txt_loanamount[m].value)<0)
  {
 document.forms[0].txt_loanamount[m].value=0;
  } 
  if(document.forms[0].txt_loanamount[m].value=="NaN")
	{
	document.forms[0].txt_loanamount[m].value= "0" ;
	}
}

 
}
function labourcharge()
{
var totalval=0.00;
for(var i=3;i<8;i++)
{
var labour=document.forms[0].txt_loanamount[i].value;
if(eval(labour)=="")
{
labour="0";
}
totalval=eval(labour)+totalval;
document.forms[0].txt_labourcharge.value=eval(totalval);
}
}

function placeValues()
{
	<%
		if(arryRow4.size()!=0)
		{
			
			for(int i=0;i<arryRow4.size();i++)
			{	
				arryCol1 = (ArrayList)  arryRow4.get(i);
				
				if(arryCol1!=null)
				{%>
					document.forms[0].txt_month1[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(2))%>";
				<%}
			}
		}
		%>
		
		<%
		if(arryRow1.size()!=0)
		{
			
			for(int i=0;i<arryRow1.size();i++)
			{	
				arryCol1 = (ArrayList)  arryRow1.get(i);
				
				if(arryCol1!=null)
				{%>
					document.forms[0].txt_item1[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(0))%>";
					document.forms[0].txt_cost1[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(1))%>";
				<%}
			}
		}
		%>
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();onloading();margin();amount();callSurplus();margin1();amount1();callSurplus1();amount2();callTotal();amount3();callTotal1();labourcharge()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
				<tr>
				 <td> 
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
                      <tr> 
                        <td colspan="13"> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                              <tr class="dataheader"> 
                              <%
						
				
				if (arryRow2!=null && arryRow2.size() != 0) {
				arryCol2 = (ArrayList) arryRow2.get(0);
				
				if (arryCol2.size() != 0) {
					 
					k1= Helper.correctNull((String) arryCol2.get(5));
					
				}
			 
			} else  {
				k1 = "";
				}
			%>
                              <td colspan="6"><b>Particulars</b></td>
                                <td align="center" width="9%"><b>Amount(Rs.)</b></td>
                                <td align="center" width="9%"  style="display:none"><b>Margin 
                                  <input type="text" name="txt_marginper"  size="5"
									maxlength="15" value="<%=Helper.correctNull((String)session.getAttribute("MarginPercent"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                % (Rs.)</b></td>
                                <td align="center" width="9%"  style="display:none"><b>Loan 
                                  Amount (Rs.)</b></td>
                            </tr>
                            <tr> 
                              <%
						
				
				if (arryRow!=null && arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(1));
					g1 = Helper.correctNull((String) arryCol.get(2));
					l2=Helper.correctNull((String) arryCol.get(3));
				}
			 
			} else {
				l1 = "";
				l2="";
				g1="";
				
			}

			%>
                              <td colspan="6">Purchase 
                                of 
                                <input type="text" name="txt_nochicks"size="10" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("txt_nochicks"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                number of chicks/batch, 
                                <input type="text" name="txt_noofbatches"size="5" maxlength="4"
									value="<%=g1%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                no. of batches,@Rs. 
                                <input type="text" name="txt_value"size="10" maxlength="7"
									value="<%=Helper.correctNull((String)hshValues.get("txt_costchicks"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                per chick. 
                                <input type="hidden" name="txt_value1" size="10" maxlength="7"
									value="1" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                </td>
                                <td width="9%" > <lapschoice:CurrencyTag name="txt_amount"size="15" maxlength="7"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> <lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"> <lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="7" value="" onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
				if (arryRow.size() >0) {
			arryCol = (ArrayList) arryRow.get(0);
          	c1 = Helper.correctNull((String) arryCol.get(5));
			
				}		  
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l3 = Helper.correctNull((String) arryCol.get(1));
					g2 = Helper.correctNull((String) arryCol.get(2));
				    g3= Helper.correctNull((String) arryCol.get(3));
					l4=Helper.correctNull((String) arryCol.get(4));
				}
			

			} else if (arryRow.size() == 0) {
				l3= "";l4="";g2="";g3="";
			}

			%>
                              <td colspan="6" >Feeding 
                                of 
                                <input type="text" name="txt_nochicks" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("txt_nochicks"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                number of chicks/batch, 
                                <input type="text" name="txt_noofbatches"size="5" maxlength="4"
									value="<%=g2%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                no. of batches,at 
                                <input type="text" name="txt_value"size="10" maxlength="5"
									value="<%=g3%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                kg per chick,@Rs. 
                                <input type="text" name="txt_value1"size="10" maxlength="7"
									value="<%=l4%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                per kg of chick mash.(chick mortality 
                                <input type="text" name="txt_mortality1"size="10" maxlength="4"
									value="<%=Helper.correctNull((String)hshValues.get("txt_broodingmor"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus();checkPercentage(this)"
									style="text-align:right;">
                                %) </td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"  size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center" style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow.size() >0) {
			arryCol = (ArrayList) arryRow.get(0);
          	c2 = Helper.correctNull((String) arryCol.get(6));
			
				}
						if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);
                
				if (arryCol.size() != 0) {
                      
				   l5 = Helper.correctNull((String)  arryCol.get(1));
				   g4 = Helper.correctNull((String) arryCol.get(2));
					g5= Helper.correctNull((String) arryCol.get(3));
					l6= Helper.correctNull((String) arryCol.get(4));
				}
                     
			} else if (arryRow.size() == 0) {
				l5="";
				l6="";
			    g4="";g5="";
			}

			%>
                              <td colspan="6">Feeding 
                                of 
                                <input type="text" name="txt_nochicks" size="10" maxlength="10"
									value="<%=l5%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                number of growers/batch, 
                                <input type="text" name="txt_noofbatches"size="5" maxlength="4"
									value="<%=g4%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                no. of batches,at 
                                <input type="text" name="txt_value"size="10" maxlength="5"
									value="<%=g5%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                kg per Grower@Rs. 
                                <input type="text" name="txt_value1"size="10" maxlength="7"
									value="<%=l6%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                per kg of grower mash.(mortality in Grower 
                                <input type="text" name="txt_mortality2"size="10" maxlength="4"
									value="<%=Helper.correctNull((String)hshValues.get("txt_growingmor"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus();checkPercentage(this)"
									style="text-align:right;">
                                %) </td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td colspan="9"><b>Miscellaneous 
                                Expenses upto economic laying</b></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow3.size() >0) {
			arryCol3 = (ArrayList) arryRow3.get(0);
            m1= Helper.correctNull((String) arryCol3.get(2));
			l7= Helper.correctNull((String) arryCol3.get(3));
				}
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {
					m1= Helper.correctNull((String) arryCol.get(7));
					l7= Helper.correctNull((String) arryCol.get(8));
				  	l8=Helper.correctNull((String) arryCol.get(9));
				
              }
			} else if (arryRow.size() == 0) {
				
				
				l8="0";
				
			}

			%>
                                <td width="19%">Labourers 
                                  salary/wages</td>
                                <td width="8%"> 
                                  <input type="text" name="txt_charges" size="12" maxlength="5"
									value="<%=m1%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;">
                              </td>
                                <td width="15%"> 
                                  no.of labourers @Rs. </td>
                              <td width="7%"> 
                                <input type="text" name="txt_value2" size="10" maxlength="7"
									value="<%=l7%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;">
                              </td>
                              <td width="14%"> 
                                per labourer p.m for </td>
                                <td width="10%"> 
                                  <input type="text" name="txt_month" size="4" maxlength="3"
									value="<%=l8%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;">
                                months.</td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"  size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow3.size() >0) {
			  arryCol3 = (ArrayList) arryRow3.get(1);
              n1= Helper.correctNull((String) arryCol3.get(2));
			  n2= Helper.correctNull((String) arryCol3.get(3));
				}
					if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(5);

				if (arryCol.size() != 0) {
					n1= Helper.correctNull((String) arryCol.get(7));
					n2= Helper.correctNull((String) arryCol.get(8));
					k4=Helper.correctNull((String) arryCol.get(9));
				}

			} else if (arryRow.size() == 0) {
				
				k4="";
			}

			%>
                                <td width="19%">Manager 
                                  salary/wages </td>
                                <td width="8%"> 
                                  <input type="text" name="txt_charges" size="12" maxlength="5"
									value="<%=n1%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;">
                              </td>
                                <td width="15%"> 
                                  no.of Managers @Rs. </td>
                              <td width="7%"> 
                                <input type="text" name="txt_value2" size="10" maxlength="7"
									value="<%=n2%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;">
                              </td
                               >
                              <td width="14%"> per Manager p.m for </td>
                                <td width="10%"> 
                                  <input type="text" name="txt_month" size="4" maxlength="3"
									value="<%=k4%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;">
                                months.</td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"   size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow3.size() >0) {
			  arryCol3 = (ArrayList) arryRow3.get(2);
              n3= Helper.correctNull((String) arryCol3.get(2));
			  n4= Helper.correctNull((String) arryCol3.get(3));
				}
					if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(6);

				if (arryCol.size() != 0) {
				
					n3= Helper.correctNull((String) arryCol.get(7));
					n4= Helper.correctNull((String) arryCol.get(8));
					n5=Helper.correctNull((String) arryCol.get(9));
				}

			} else if (arryRow.size() == 0) {
				
				n5="";
			}

			%>
                              <td width="19%" >Supervisors 
                                salary/wages </td>
                                
                                <td width="8%" > 
                                  <input type="text" name="txt_charges" size="12" maxlength="5"
									value="<%=n3%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;"></td>
                               
                                <td width="15%"> no.of 
                                  Supervisors @Rs. </td>
                               
                              <td width="7%"> 
                                <input type="text" name="txt_value2" size="10" maxlength="7"
									value="<%=n4%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                               
                              <td width="14%"> per Supervisor p.m for </td>
                               
                                <td width="10%"> 
                                  <input type="text" name="txt_month" size="4" maxlength="3"
									value="<%=n5%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;">
                                months.</td>
                              
                              
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"   size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow3!=null && arryRow3.size() >0) {
			  arryCol3 = (ArrayList) arryRow3.get(3);
              n6= Helper.correctNull((String) arryCol3.get(2));
			  n7= Helper.correctNull((String) arryCol3.get(3));
				}
					if (arryRow!=null && arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(7);

				if (arryCol.size() != 0) {
				
					n6= Helper.correctNull((String) arryCol.get(7));
					n7= Helper.correctNull((String) arryCol.get(8));
					n8=Helper.correctNull((String) arryCol.get(9));
				}

			} else {
				
				n8="";
			}

			%>
                                <td width="19%">others 
                                  ie. 
                                  <input type="hidden" name="txt_specify1" 
									value="<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                                  <%=Helper.correctNull((String)hshValues.get("txt_specify1"))%> 
                                  salary/wages </td>
                                
                                <td width="8%"> 
                                  <input type="text" name="txt_charges" size="12" maxlength="5"
									value="<%=n6%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;"></td>
                                
                                <td width="15%">no.of 
                                  persons @Rs. </td>
                               
                              <td width="7%"> 
                                <input type="text" name="txt_value2" size="10" maxlength="7"
									value="<%=n7%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                
                              <td width="14%">per person p.m for </td>
                                
                                <td width="10%"> 
                                  <input type="text" name="txt_month" size="4" maxlength="3"
									value="<%=n8%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;">
                                months.</td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"   size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow3.size() >0) {
			  arryCol3 = (ArrayList) arryRow3.get(4);
              n9= Helper.correctNull((String) arryCol3.get(2));
			  n10= Helper.correctNull((String) arryCol3.get(3));
				}
					if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(8);

				if (arryCol.size() != 0) {
				
					n9= Helper.correctNull((String) arryCol.get(7));
					n10= Helper.correctNull((String) arryCol.get(8));
					n11=Helper.correctNull((String) arryCol.get(9));
				}

			} else if (arryRow.size() == 0) {
				
				n11="";
			}

			%>
                                <td width="19%"> 
                                  others ie
                                   <input type="hidden" name="txt_specify2" 
									value="<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                                   <%=Helper.correctNull((String)hshValues.get("txt_specify2"))%> 
                                  salary/wages </td>
                                <td width="8%"> 
                                  <input type="text" name="txt_charges" size="12" maxlength="5"
									value="<%=n9%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;"></td>
                                <td width="15%"> 
                                  no.of persons@Rs. </td>
                                <td width="7%">
<input type="text" name="txt_value2" size="10" maxlength="7"
									value="<%=n10%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                <td width="14%"> per 
                                  person p.m for </td>
                                <td width="10%"> 
                                  <input type="text" name="txt_month" size="4" maxlength="3"
									value="<%=n11%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:left;">
                                months.</td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"  size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(9);

				if (arryCol.size() != 0) {
				
					m2 = Helper.correctNull((String) arryCol.get(7));
					l9=Helper.correctNull((String) arryCol.get(8));
				}

			} else if (arryRow.size() == 0) {
				
				l9="";m2="";
			}

			%>
                                <td width="19%">Water 
                                  charge:Rs. </td>
							    <td width="8%"><lapschoice:CurrencyTag name="txt_charges" size="12" maxlength="6"
									value='<%=m2%>' onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"/></td>
							    <td width="15%"> 
                                  per month for </td>
                              <td width="7%"> 
                                <input type="text" name="txt_value2" size="4" maxlength="3"
									value="<%=l9%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                
                              <td width="14%">months.</td>
                               
                                <td width="10%"> 
                                  <input type="hidden" name="txt_month" 
									value="1" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                              </td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"   size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_margin"size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
                 if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(10);
            
				if (arryCol.size() != 0) {
				
					m3 = Helper.correctNull((String) arryCol.get(7));
				   l11= Helper.correctNull((String) arryCol.get(8));
				      }
			         } else if (arryRow.size() == 0) {
				l11= "";m3="";
				
			       }

			%>
                                <td width="19%">Electricity 
                                  charges Rs.</td> 
                               
                                <td width="8%"> 
                                  <input type="text" name="txt_charges" size="12" maxlength="6"
									value="<%=m3%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                               
                                <td width="15%"> per 
                                  month for </td>
                              <td width="7%"> 
                                <input type="text" name="txt_value2" size="4" maxlength="3"
									value="<%=l11%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                               
                              <td width="14%"> months. </td>
                               
                                <td width="10%"> 
                                  <input type="hidden" name="txt_month" 
									value="1" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                                </td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount" size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_margin" size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
						if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(11);

				if (arryCol.size() != 0) {

					m4 = Helper.correctNull((String) arryCol.get(7));
					l13 = Helper.correctNull((String) arryCol.get(8));
					l14= Helper.correctNull((String) arryCol.get(9));
				}

			} else if (arryRow.size() == 0) {
				l13="";
				l14="";
				m4="";
			}

			%>
                                <td width="19%">Veterinary 
                                  aid Rs. </td>
                                
                              <td width="8%"> 
                                <input type="text" name="txt_charges" size="12" maxlength="6"
									value="<%=m4%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;">
                              </td>
                                <td width="15%">per 
                                  batch for  </td>
                                <td width="7%">
<input type="text" name="txt_value2" size="5" maxlength="4"
									value="<%=l13%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                <td width="14%">number 
                                  of batches </td>
                                <td width="10%"> 
                                  <input type="hidden" name="txt_month" size="10" maxlength="6"
									value="" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;">
                                </td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_margin"size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(12);

				if (arryCol.size() != 0) {

					m5= Helper.correctNull((String) arryCol.get(7));
					l15=Helper.correctNull((String) arryCol.get(8));
				}

			} else if (arryRow.size() == 0) {
				l15 = "";
				m5="";
			}

			%>
                                <td width="19%">Insurance 
                                  of birds @ Rs. </td>
                                <td width="8%"> 
                                  <input type="text" name="txt_charges" size="12" maxlength="6"
									value="<%=m5%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                <td width="15%"> 
                                  per batch for </td>
                                <td width="7%">
<input type="text" name="txt_value2" size="5" maxlength="4"
									value="<%=l15%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                <td width="14%">number 
                                  of batches.. </td>
                                <td width="10%"> 
                                  <input type="hidden" name="txt_month" size="10" maxlength="15"
									value="1" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                                </td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"  size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_margin"size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						 
					if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(13);
				if (arryCol.size() != 0) {

					m6 = Helper.correctNull((String) arryCol.get(7));
					l17=Helper.correctNull((String) arryCol.get(8)); 
              }
			} else if (arryRow.size() == 0) {
				l17="";
				m6="";
				}

			%>
                                <td width="19%">Transportation 
                                  charges @ Rs. </td>
                                <td width="8%"> 
                                  <input type="text" name="txt_charges" size="12" maxlength="6"
									value="<%=m6%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                <td width="15%">per 
                                  batch for </td>
                                <td width="7%">
<input type="text" name="txt_value2" size="5" maxlength="4"
									value="<%=l17%>" onKeyPress="allowInteger()" onBlur="amount2();callTotal();callSurplus()"
									style="text-align:right;"></td>
                                <td width="14%"> 
                                  number of batches. </td>
                                <td width="10%"> 
                                  <input type="hidden" name="txt_month" size="10" maxlength="15"
									value="1" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"></td>
                                
                                <td width="9%"><lapschoice:CurrencyTag name="txt_amount"  size="15" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_margin"size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td colspan="6"><b> 
                                Sub-Total</b></td>
                                <td width="9%"> 
                                  <input type="text" name="txt_totamount" size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readOnly style="text-align:right;">
                              </td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_totmargin" size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                                <td width="9%"  style="display:none"> 
                                  <input type="text" name="txt_totloanamount"  size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                            </tr>
                          </table>
						 
                            <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                              <tr class="dataheader"> 
                              <td colspan="4"><b>If 
                                Others Specify</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <%
						
				
				if (arryRow2.size() != 0) {
				arryCol2 = (ArrayList) arryRow2.get(0);
				
				if (arryCol2.size() != 0) {
					 
					k1= Helper.correctNull((String) arryCol2.get(5));
					
				}
			 
			} else if (arryRow2.size() == 0) {
				k1 = "";
				}
			%>
                                <td width="73%"><b>Particulars</b></td>
                                <td width="9%"><b>Amount(Rs.)</b></td>
                                <td width="9%"  style="display:none"><b>Margin 
                                  <input type="text" name="txt_marginper1"  size="5"
									maxlength="15" value="<%=Helper.correctNull((String)session.getAttribute("MarginPercent"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                % (Rs.)</b></td>
                                <td width="9%"  style="display:none"><b>Loan 
                                  Amount (Rs.)</b></td>
                            </tr>
                            <tr> 
                             
							 
                                <td width="73%"> 
                                  <input type="text" name="txt_item1" size="70" maxlength="300"
									value="" onKeyPress=""
									style="text-align:left;">
                                Rs
                                <input type="text" name="txt_cost1" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                for 
                                <input type="text" name="txt_month1" size="10" maxlength="3"
									value="" onKeyPress="allowInteger()" onBlur="amount3();margin1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                months. </td>
                                <td width="9%"> 
                                  <lapschoice:CurrencyTag name="txt_amount1" size="15" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/> </td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_margin1" size="15" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                                <td width="9%"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_loanamount1" size="15" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                            </tr>
                            <tr> 
                            
                                <td width="73%"> 
                                  <input type="text" name="txt_item1" size="70" maxlength="300"
									value="" onKeyPress=""
									style="text-align:left;">
                                Rs
                                <input type="text" name="txt_cost1" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                for 
                                <input type="text" name="txt_month1" size="10" maxlength="3"
									value="" onKeyPress="allowInteger()" onBlur="amount3();margin1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                months. </td>
                                <td width="9%"> 
                                  <lapschoice:CurrencyTag name="txt_amount1" size="15" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/> </td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_margin1" size="15" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                                <td width="9%"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_loanamount1" size="15" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                            </tr>
                            <tr> 
                            
							
                                <td width="73%" > 
                                  <input type="text" name="txt_item1" size="70" maxlength="300"
									value="" onKeyPress=""
									style="text-align:left;">
                                Rs
                                <input type="text" name="txt_cost1" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                for 
                                <input type="text" name="txt_month1" size="10" maxlength="3"
									value="" onKeyPress="allowInteger()" onBlur="amount3();margin1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                months. </td>
                                <td width="9%"> 
                                  <lapschoice:CurrencyTag name="txt_amount1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/> </td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_margin1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                                <td width="9%"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_loanamount1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                            </tr>
                            <tr> 
                             
                                <td width="73%"> 
                                  <input type="text" name="txt_item1" size="70" maxlength="300"
									value="" onKeyPress=""
									style="text-align:left;">
                                Rs.
                                <input type="text" name="txt_cost1" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                for 
                                <input type="text" name="txt_month1" size="10" maxlength="3"
									value="" onKeyPress="allowInteger()" onBlur="amount3();margin1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                months. </td>
                                <td width="9%"> 
                                  <lapschoice:CurrencyTag name="txt_amount1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/> </td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_margin1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                                <td width="9%"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_loanamount1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                            </tr>
                            <tr> 
                             
                                <td width="73%"> 
                                  <input type="text" name="txt_item1" size="70" maxlength="300"
									value="" onKeyPress=""
									style="text-align:left;">
                                Rs. 
                                <input type="text" name="txt_cost1" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                for 
                                  <input type="text" name="txt_month1" size="10" maxlength="3"
									value="" onKeyPress="allowInteger()" onBlur="amount3()"
									style="text-align:left;">
                                months. </td>
                                <td width="9%"> 
                                  <lapschoice:CurrencyTag name="txt_amount1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/> </td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_margin1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                                <td width="9%"  style="display:none"> 
                                  <lapschoice:CurrencyTag name="txt_loanamount1" size="15" maxlength="10"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/> </td>
                            </tr>
                            <tr class="dataheader"> 
                                <td height="27" width="73%"><b>Sub-Total</b></td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_totamount1" size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_totmargin1" size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readOnly style="text-align:right;"></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_totloanamount1" size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                                <td width="73%"><b>Total(Recurring 
                                  Expenses)(A)</b></td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_totalamount" size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_totalmargin" size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readOnly style="text-align:right;"></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_totalloanamount" size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <%
						
				
				if (arryRow2.size() != 0) {
				arryCol2 = (ArrayList) arryRow2.get(0);
				
				if (arryCol2.size() != 0) {
					 
					a1= Helper.correctNull((String) arryCol2.get(6));
					a2= Helper.correctNull((String) arryCol2.get(7));
					a3= Helper.correctNull((String) arryCol2.get(8));
				}
			 
			} else if (arryRow2.size() == 0) {
				a1 = "";a2="";a3="";
				}
			%>
                                <td width="73%"><b>Total(Non-Recurring 
                                  Expenses)(B)</b></td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_totalamount1" size="15"
									maxlength="15" value='<%=a1%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"><lapschoice:CurrencyTag name="txt_totalmargin1" size="15"
									maxlength="15" value='<%=a2%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_totalloanamount1" size="15"
									maxlength="15" value='<%=a3%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader">
                                <td width="73%"><b>Total(Project 
                                  outlay)(A+B)</b></td>
                                <td width="9%"><lapschoice:CurrencyTag name="txt_totalamount2" size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                                <td width="9%" align="center"  style="display:none"> 
                                  <input type="text" name="txt_totalmargin2" size="15"
									maxlength="15" value="" onKeyPress="allowInteger()"
									readOnly style="text-align:right;"></td>
                                <td width="9%"  style="display:none"><lapschoice:CurrencyTag name="txt_totalloanamount2" size="15"
									maxlength="15" value='' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
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
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>	
<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<input type="hidden" name="txt_labourcharge">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>








