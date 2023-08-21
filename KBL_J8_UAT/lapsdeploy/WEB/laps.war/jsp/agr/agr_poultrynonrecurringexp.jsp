<%@include file="../share/directives.jsp"%>
<%
ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow  = (ArrayList) hshValues.get("arryRow");
ArrayList arryCol1 = new ArrayList();
ArrayList arryRow1 = new ArrayList();
arryRow1  = (ArrayList) hshValues.get("arryRow1");

if (arryRow == null) {
	arryRow  = new ArrayList();
}
if (arryRow1 == null) {
	arryRow1  = new ArrayList();
}
String l1 = "", l2 = "", l3 = "", l4 = "", l5 = "", l6 = "", l7 = "", l8 = "", l9 = "", l10 = "";
String l11 = "", l12 = "", l13 = "", l14 = "", l15 = "", l16 = "", l17 = "", l18 = "";
String m1 = "", m2 = "",m3 = "", m4 = "", m5 = "", m6 = "",k1="";
String r1="",r2="",r3="",r4="",r5="",r6="",r7="",r8="",r9="",r10="",r11="",r12="";
String r13="",r14="",r15="",r16="",r17="",r18="",r19="",r20="",r21="";
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/agr_poultrynonrecurring.js"></script>
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
   
	enableButtons( true, true, true, true, false);	
	margin();amount();callTotal();callSurplus();
	margin1();amount1();callTotal1();callSurplus1();
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_poultrynonrecurringexp.jsp";
	document.forms[0].hidBeanMethod.value="updatenonrecurringData";
	document.forms[0].hidBeanGetMethod.value="getnonrecurringData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
 	for(var i=0;i<=8;i++)
 	{
	document.forms[0].txt_amount[i].readOnly =true;
    document.forms[0].txt_margin[i].readOnly =true;
    document.forms[0].txt_loanamount[i].readOnly =true;
  
 	}
 	for(var k=0;k<=6;k++)
 	{
	document.forms[0].txt_amount1[k].readOnly =true;
    document.forms[0].txt_margin1[k].readOnly =true;
    document.forms[0].txt_loanamount1[k].readOnly =true;
  
 	}
	 document.forms[0]. txt_totalamount.readOnly =true; 
	 document.forms[0]. txt_totalmargin.readOnly =true; 
     document.forms[0]. txt_totalloanamount.readOnly =true; 
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
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getnonrecurringData";
		document.forms[0].action=appURL+"action/agr_poultrynonrecurringexp.jsp";
		document.forms[0].submit(); 		
	}
	
}

function doDelete()
{
if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatenonrecurringData";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_poultrynonrecurringexp.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();	
	}	
}

function onloading()
{	  
	disableFields(true);
	calculateTotal();
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

for(var m=0;m<=8;m++)
{

var amountval=document.forms[0].txt_amount[m].value;
 if(amountval=="")
		{
	amountval=0;
			
		}

 amount=eval(str)*eval(amountval);
document.forms[0].txt_margin[m].value=eval(amount);	
 num1=(amount);
 str1=num1.toFixed(2);
document.forms[0].txt_margin[m].value=Math.round(eval(str1));	
roundtxt(document.forms[0].txt_margin[m]);
}
}

function amount()
{
for(var m=0;m<=8;m++)
{
var sqft=document.forms[0].txt_sq[m].value;
var value=document.forms[0].txt_value[m].value;
 if(sqft=="")
		{
	sqft=0;
			
		}
	if(value=="")
	{
	value=0;
		
	}
	var amount=eval(sqft)*eval(value);
document.forms[0].txt_amount[m].value=eval(amount);	
roundtxt(document.forms[0].txt_amount[m]);
}
margin();
}

function callTotal()
{
amount();callSurplus();
var totalvalue1=0.00;var totalvalue2=0.00;var totalvalue3=0.00;
for(var m=0;m<=8;m++)
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
   //roundtxt(document.forms[0].txt_totamount);
   document.forms[0].txt_totmargin.value= eval(totalvalue2);
   //roundtxt(document.forms[0].txt_totmargin);
   document.forms[0].txt_totloanamount.value= eval(totalvalue3);
   //roundtxt(document.forms[0].txt_totloanamount);
   var num1=(totalvalue1);
   var str1=num1.toFixed(2);
   var num2=(totalvalue2);
   var str2=num2.toFixed(2);
    var num3=(totalvalue3);
   var str3=num3.toFixed(3);
    document.forms[0].txt_totamount.value=Math.round(eval(str1));
    roundtxt(document.forms[0].txt_totamount);
   document.forms[0].txt_totmargin.value= Math.round(eval(str2));
   roundtxt(document.forms[0].txt_totmargin);
   document.forms[0].txt_totloanamount.value= Math.round(eval(str3));
   roundtxt(document.forms[0].txt_totloanamount);
   calculateTotal();
}
function callSurplus()
{
var i;

for(var m=0;m<=8;m++)
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();margin();amount();callTotal();callSurplus();margin1();amount1();callTotal1();callSurplus1()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
						
                  <td> 
					<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
                      <tr> 
                        <td height="568"   colspan="13"> 
						<table width="100%" border="0" cellspacing="2" cellpadding="1" class="outertable">
                            <tr class="dataheader"> 
							 <%
						
				
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					k1= Helper.correctNull((String) arryCol.get(5));
					
				}
			 
			} else if (arryRow.size() == 0) {
				k1 = "";
				}
			%>
                      
                              <td><b>Particulars</b></td>
                              <td align="center"><b>Amount(Rs.)</b></td>
                              <td align="center" style="display:none"><b>Margin 
                                <input type="text" name="txt_marginper"  size="10"
									maxlength="15" value="<%=Helper.correctNull((String)session.getAttribute("MarginPercent"))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;">
                                % (Rs.)</b></td>
                              <td align="center" style="display:none"><b>Loan 
                                Amount (Rs.)</b></td>
                            </tr>
                            <tr> 
                              <%
						
				
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(1));
					l2 = Helper.correctNull((String) arryCol.get(2));
					
				}
			 
			} else if (arryRow.size() == 0) {
				l1 = "";
				l2="";
				
				
			}

			%>
                              <td width="72%" >Construction 
                                of  <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:left;">
                                <input type="text" name="txt_sq"size="10" maxlength="6"
									value="<%=l1%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft Brooder Shed@Rs. 
                                <lapschoice:CurrencyTag name="txt_value"size="10" maxlength="10"
									value='<%=l2%>' onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td width="8%" > 
                                <lapschoice:CurrencyTag name="txt_amount"size="10" maxlength="10"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_margin"size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="13%" style="display:none" > 
                                <lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value=''
									/></td>
                            </tr>
                            <tr> 
                              <%
						  
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l3 = Helper.correctNull((String) arryCol.get(1));
					l4 = Helper.correctNull((String) arryCol.get(2));
				
				}
			

			} else if (arryRow.size() == 0) {
				l3= "";l4="";
			}

			%>
                              <td>Construction 
                                of  <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:left;">
                                <input type="text" name="txt_sq" size="10" maxlength="6"
									value="<%=l3%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft Grower Shed@Rs. &nbsp;
                                <lapschoice:CurrencyTag name="txt_value"size="10" maxlength="15"
									value='<%=l4%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10" maxlength="10"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);
                
				if (arryCol.size() != 0) {
                      
				   l5 = Helper.correctNull((String)  arryCol.get(1));
				   l6 = Helper.correctNull((String) arryCol.get(2));
					
				}
                     
			} else if (arryRow.size() == 0) {
				l5="";
				l6="";
			
			}

			%>
                              <td>Construction 
                                of  <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:left;">
                                <input type="text" name="txt_sq"size="10" maxlength="6"
									value="<%=l5%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft Layer Shed@Rs. &nbsp;&nbsp;&nbsp;&nbsp;
                                <lapschoice:CurrencyTag name="txt_value"size="10" maxlength="15"
									value='<%=l6%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft </td>
                              <td><lapschoice:CurrencyTag name="txt_amount"size="10" maxlength="10"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                             
                              <td colspan="4"><b>Other 
                                Civil Works</b></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {
				
				
					l7 = Helper.correctNull((String) arryCol.get(1));
					l8 = Helper.correctNull((String) arryCol.get(2));
				    m1=Helper.correctNull((String) arryCol.get(3));
				
              }
			} else if (arryRow.size() == 0) {
				
				l7= "";
				l8="";
				m1="";
			}

			%>
                              <td>Construction 
                                of 
                                <input type="text" name="txt_specify" size="15" maxlength="50"
									value="<%=m1%>" onKeyPress=""
									style="text-align:left;">
                                building measuring 
                                <input type="text" name="txt_sq" size="10" maxlength="5"
									value="<%=l7%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft @ Rs.
                                <lapschoice:CurrencyTag name="txt_value" size="10" maxlength="7"
									value='<%=l8%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td><lapschoice:CurrencyTag name="txt_amount"   size="10" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(5);

				if (arryCol.size() != 0) {
				
					l9 = Helper.correctNull((String) arryCol.get(1));
					l10 = Helper.correctNull((String) arryCol.get(2));
					m2=Helper.correctNull((String) arryCol.get(3));
				}

			} else if (arryRow.size() == 0) {
				
				l9="";l10="";m2="";
			}

			%>
                              <td>Construction 
                                of 
                                <input type="text" name="txt_specify" size="15" maxlength="50"
									value="<%=m2%>" onKeyPress=""
									style="text-align:left;">
                                building measuring 
                                <input type="text" name="txt_sq" size="10" maxlength="5"
									value="<%=l9%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft @ Rs. 
                                <lapschoice:CurrencyTag name="txt_value" size="10" maxlength="7"
									value='<%=l10%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10" maxlength="10"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
                 if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(6);
            
				if (arryCol.size() != 0) {
				
					l11 = Helper.correctNull((String) arryCol.get(1));
				    l12 = Helper.correctNull((String) arryCol.get(2));
					m3= Helper.correctNull((String) arryCol.get(3));
				      }
			         } else if (arryRow.size() == 0) {
				l11= "";l12="";m3="";
				
			       }

			%>
                              <td>Construction 
                                of 
                                <input type="text" name="txt_specify" size="15" maxlength="50"
									value="<%=m3%>" onKeyPress=""
									style="text-align:left;">
                                building measuring 
                                <input type="text" name="txt_sq" size="10" maxlength="5"
									value="<%=l11%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft @ Rs. 
                                <lapschoice:CurrencyTag name="txt_value" size="10" maxlength="7"
									value='<%=l12%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td><lapschoice:CurrencyTag name="txt_amount" size="10" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()" style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						
						if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(7);

				if (arryCol.size() != 0) {

					l13 = Helper.correctNull((String) arryCol.get(1));
					l14 = Helper.correctNull((String) arryCol.get(2));
					m4= Helper.correctNull((String) arryCol.get(3));
				}

			} else if (arryRow.size() == 0) {
				l13="";
				l14="";
				m4="";
			}

			%>
                              <td>Construction 
                                of 
                                <input type="text" name="txt_specify" size="15" maxlength="50"
									value="<%=m4%>" onKeyPress=""
									style="text-align:left;">
                                building measuring 
                                <input type="text" name="txt_sq" size="10" maxlength="5"
									value="<%=l13%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft @ Rs.  
                                <lapschoice:CurrencyTag name="txt_value" size="10" maxlength="7"
									value='<%=l14%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td><lapschoice:CurrencyTag name="txt_amount"size="10" maxlength="10"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(8);

				if (arryCol.size() != 0) {

					l15 = Helper.correctNull((String) arryCol.get(1));
					l16= Helper.correctNull((String) arryCol.get(2));
					m5=Helper.correctNull((String) arryCol.get(3));
				}

			} else if (arryRow.size() == 0) {
				l15 = "";
				l16="";
				m5="";
			}

			%>
                              <td>Construction 
                                of 
                                <input type="text" name="txt_specify" size="15" maxlength="50"
									value="<%=m5%>" onKeyPress=""
									style="text-align:left;">
                                building measuring 
                                <input type="text" name="txt_sq" size="10" maxlength="5"
									value="<%=l15%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft @ Rs. 
                                <lapschoice:CurrencyTag name="txt_value" size="10" maxlength="7"
									value='<%=l16%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin"size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <%
						 
					if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(9);
                 
				if (arryCol.size() != 0) {

					l17 = Helper.correctNull((String) arryCol.get(1));
					l18 = Helper.correctNull((String) arryCol.get(2));
					m6=Helper.correctNull((String) arryCol.get(3)); 
              }
			} else if (arryRow.size() == 0) {
				l17="";
				l18="";
				m6="";
				}

			%>
                              <td>Construction 
                                of 
                                <input type="text" name="txt_specify" size="15" maxlength="50"
									value="<%=m6%>" onKeyPress=""
									style="text-align:left;">
                                building measuring 
                                <input type="text" name="txt_sq" size="10" maxlength="5"
									value="<%=l17%>" onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:left;">
                                sq ft @ Rs. 
                                <lapschoice:CurrencyTag name="txt_value" size="10" maxlength="7"
									value='<%=l18%>' onKeyPress="allowInteger()" onBlur="amount();callTotal();callSurplus()"
									style="text-align:right;"/>
                                per sq ft</td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10" maxlength="15"
									value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_margin" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_loanamount"  size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td><b> 
                                Sub-Total</b></td>
                              <td><lapschoice:CurrencyTag name="txt_totamount" size="10"
									maxlength="15" value='' />
									</td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_totmargin" size="10"
									maxlength="15" value='' 
									/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_totloanamount"  size="10"
									maxlength="15" value='' 
									/></td>
                            </tr>
                          </table>
						  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="6"><b>Purchase 
                                of Equipments</b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <%
						
				
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					k1= Helper.correctNull((String) arryCol.get(5));
					
				}
			 
			} else if (arryRow.size() == 0) {
				k1 = "";
				}
			%>
                              <td width="46%"><b>Name 
                                of equipments with specifications</b></td>
                              <td width="8%"><b>No 
                                of units</b></td>
                              <td width="12%"><b>Cost 
                                per unit</b></td>
                              <td width="8%"><b>Amount(Rs.)</b></td>
                              <td width="7%" style="display:none"><b>Margin 
                                <input type="text" name="txt_marginper1"  size="10"
									maxlength="15" value="<%=Helper.correctNull((String)session.getAttribute("MarginPercent"))%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;">
                                % (Rs.)</b></td>
                              <td width="9%" style="display:none"><b>Loan Amount 
                                (Rs.)</b></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow1.size() != 0) {
					
				arryCol1 = (ArrayList) arryRow1.get(0);

				if (arryCol1.size() != 0) {
				
				
					r1 = Helper.correctNull((String) arryCol1.get(1));
					r2 = Helper.correctNull((String) arryCol1.get(2));
				    r3=Helper.correctNull((String) arryCol1.get(3));
				
              }
			} else if (arryRow1.size() == 0) {
				
				r1= "";
				r2="";
				r3="";
			}

			%>
                              <td> 
                                <input type="text" name="txt_item1" size="70" maxlength="100"
									value="<%=r1%>" onKeyPress=""
									style="text-align:left;">
                                </td>
                              <td> 
                                <input type="text" name="txt_unit" size="10" maxlength="5"
									value="<%=r2%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=r3%>' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/>
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_amount1" size="10" maxlength="7"
									value='' onBlur="roundtxt(document.forms[0].txt_amount1)"
									/>
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_margin1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger();checkPercentage(this);" onBlur=""
									style="text-align:right;"/>
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_loanamount1" size="10" maxlength="7"
									value=''  onBlur=""
									/>
                                </td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow1.size() != 0) {
					
				arryCol1 = (ArrayList) arryRow1.get(1);

				if (arryCol1.size() != 0) {
				
				
					r4 = Helper.correctNull((String) arryCol1.get(1));
					r5 = Helper.correctNull((String) arryCol1.get(2));
				    r6=Helper.correctNull((String) arryCol1.get(3));
				
              }
			} else if (arryRow1.size() == 0) {
				
				r4= "";
				r5="";
				r6="";
			}

			%>
                              <td> 
                                <input type="text" name="txt_item1" size="70" maxlength="100"
									value="<%=r4%>" onKeyPress=""
									style="text-align:left;">
                                </td>
                              <td> 
                                <input type="text" name="txt_unit" size="10" maxlength="5"
									value="<%=r5%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=r6%>' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/>
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_amount1" size="10" maxlength="7"
									value=''  onBlur="roundtxt(document.forms[0].txt_amount1)"
									/>
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_margin1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/>
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_loanamount1" size="10" maxlength="7"
									value='' onBlur=""
									/>
                                </td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow1.size() != 0) {
					
				arryCol1 = (ArrayList) arryRow1.get(2);

				if (arryCol1.size() != 0) {
				
				
					r7 = Helper.correctNull((String) arryCol1.get(1));
					r8 = Helper.correctNull((String) arryCol1.get(2));
				    r9=Helper.correctNull((String) arryCol1.get(3));
				
              }
			} else if (arryRow1.size() == 0) {
				
				r7= "";
				r8="";
				r9="";
			}

			%>
                              <td > 
                                <input type="text" name="txt_item1" size="70" maxlength="100"
									value="<%=r7%>" onKeyPress=""
									style="text-align:left;">
                                </td>
                              <td> 
                                <input type="text" name="txt_unit" size="10" maxlength="5"
									value="<%=r8%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=r9%>' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/>
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_amount1" size="10" maxlength="7"
									value='' onBlur="roundtxt(document.forms[0].txt_amount1)"/>
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_margin1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/>
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_loanamount1" size="10" maxlength="7"
									value=''  onBlur=""
									/>
                                </td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow1.size() != 0) {
					
				arryCol1 = (ArrayList) arryRow1.get(3);

				if (arryCol1.size() != 0) {
				
				
					r10 = Helper.correctNull((String) arryCol1.get(1));
					r11 = Helper.correctNull((String) arryCol1.get(2));
				    r12=Helper.correctNull((String) arryCol1.get(3));
				
              }
			} else if (arryRow1.size() == 0) {
				
				r10= "";
				r11="";
				r12="";
			}

			%>
                              <td> 
                                <input type="text" name="txt_item1" size="70" maxlength="100"
									value="<%=r10%>" onKeyPress=""
									style="text-align:left;">
                                </td>
                              <td> 
                                <input type="text" name="txt_unit" size="10" maxlength="5"
									value="<%=r11%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=r12%>' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/>
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_amount1" size="10" maxlength="7"
									value='' onBlur="roundtxt(document.forms[0].txt_amount1)" />
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_margin1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/>
                                </td>
                              <td style="display:none"> 
                               <lapschoice:CurrencyTag name="txt_loanamount1" size="10" maxlength="7"
									value=''  onBlur=""
									/>
                                </td>
                            </tr>
                            <tr> 
							  <%
						
					if (arryRow1.size() != 0) {
					
				arryCol1 = (ArrayList) arryRow1.get(4);

				if (arryCol1.size() != 0) {
				
				
					r13 = Helper.correctNull((String) arryCol1.get(1));
					r14 = Helper.correctNull((String) arryCol1.get(2));
				    r15=Helper.correctNull((String) arryCol1.get(3));
				
              }
			} else if (arryRow1.size() == 0) {
				
				r13= "";
				r14="";
				r15="";
			}

			%>
                              <td> 
                                <input type="text" name="txt_item1" size="70" maxlength="100"
									value="<%=r13%>" onKeyPress=""
									style="text-align:left;">
                                </td>
                              <td> 
                                <input type="text" name="txt_unit" size="10" maxlength="5"
									value="<%=r14%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=r15%>' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/>
                                </td>
                              <td> 
                                <lapschoice:CurrencyTag name="txt_amount1" size="10" maxlength="7"
									value=''  onBlur="roundtxt(document.forms[0].txt_amount1)" />
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_margin1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/>
                                </td>
                              <td style="display:none"> 
                                <lapschoice:CurrencyTag name="txt_loanamount1" size="10" maxlength="7"
									value=''  onBlur=""
									/>
                                </td>
                            </tr>
                            <tr>
							  <%
						
					if (arryRow1.size() != 0) {
					
				arryCol1 = (ArrayList) arryRow1.get(5);

				if (arryCol1.size() != 0) {
				
				
					r16 = Helper.correctNull((String) arryCol1.get(1));
					r17 = Helper.correctNull((String) arryCol1.get(2));
				    r18=Helper.correctNull((String) arryCol1.get(3));
				
              }
			} else if (arryRow1.size() == 0) {
				
				r16= "";
				r17="";
				r18="";
			}

			%>
                              <td>
                                <input type="text" name="txt_item1" size="70" maxlength="100"
									value="<%=r16%>" onKeyPress=""
									style="text-align:left;">
                                </td>
                              <td>
                                <input type="text" name="txt_unit" size="10" maxlength="5"
									value="<%=r17%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=r18%>' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/>
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_amount1" size="10" maxlength="7"
									value='' onBlur="roundtxt(document.forms[0].txt_amount1)" />
                                </td>
                              <td style="display:none">
                                <lapschoice:CurrencyTag name="txt_margin1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/>
                                </td>
                              <td style="display:none">
                                <lapschoice:CurrencyTag name="txt_loanamount1" size="10" maxlength="7"
									value=''  onBlur=""
									/>
                                </td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow1.size() != 0) {
					
				arryCol1 = (ArrayList) arryRow1.get(6);

				if (arryCol1.size() != 0) {
				
				
					r19 = Helper.correctNull((String) arryCol1.get(1));
					r20 = Helper.correctNull((String) arryCol1.get(2));
				    r21=Helper.correctNull((String) arryCol1.get(3));
				
              }
			} else if (arryRow1.size() == 0) {
				
				r19= "";
				r20="";
				r21="";
			}

			%>
                              <td>
                                <input type="text" name="txt_item1" size="70" maxlength="100"
									value="<%=r19%>" onKeyPress=""
									style="text-align:left;">
                                </td>
                              <td>
                                <input type="text" name="txt_unit" size="10" maxlength="5"
									value="<%=r20%>" onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:left;">
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=r21%>' onKeyPress="allowInteger()" onBlur="amount1();callTotal1();callSurplus1()"
									style="text-align:right;"/>
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_amount1" size="10" maxlength="7"
									value=''  onBlur="roundtxt(document.forms[0].txt_amount1)"/>
                                </td>
                              <td style="display:none">
                                <lapschoice:CurrencyTag name="txt_margin1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/>
                                </td>
                              <td style="display:none">
                                <lapschoice:CurrencyTag name="txt_loanamount1" size="10" maxlength="7"
									value='' onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;"/>
                                </td>
                            </tr>
                            <tr class="dataheader"> 
                              <td height="27"><b>Sub-Total</b></td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td><lapschoice:CurrencyTag name="txt_totamount1" size="7"
									  maxlength="15" value=''  />
									</td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_totmargin1" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_totloanamount1" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td ><b>Total</b></td>
							   <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td><lapschoice:CurrencyTag name="txt_totalamount" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									/></td>
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_totalmargin" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									/></td>
                              
                              <td style="display:none"><lapschoice:CurrencyTag name="txt_totalloanamount" size="10"
									maxlength="15" value='' onKeyPress="allowInteger()"
									/></td>
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
</table></td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>








