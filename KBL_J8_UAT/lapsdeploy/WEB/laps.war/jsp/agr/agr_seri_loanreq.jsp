<%@include file="../share/directives.jsp"%>
<%
ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow  = (ArrayList) hshValues.get("arryRow");
ArrayList arryRow1 = new ArrayList();
arryRow1  = (ArrayList) hshValues.get("arryRow1");

if (arryRow == null) {
	arryRow  = new ArrayList();
}
if (arryRow1 == null) {
	arryRow1  = new ArrayList();
}
String l1 = "", l2 = "", l3 = "", l4 = "", l5 = "", l6 = "", l7 = "", l8 = "", l9 = "", l10 = "";
String l11 = "", l12 = "",c1="",c2="",c3="",c4="";
String b1 = "", b2 = "", b3 = "",b4 = "", b5 = "", b6 = "", b7 = "",b8 = "", b9 = "", b10 = "";
String b11 = "", b12 = "",d1="",d2="",d3="",d4="",d5="";
String a1 = "", a2 = "", a3 = "", a4 = "", a5 = "", a6 = "", a7 = "", a8 = "", a9 = "", a10 = "";
String a11 = "", a12 = "",a13="",a14="",a15="",a16="",a17="",a18="",a19="",a20="";

%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";

function calleligibility()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_value[1].value;
var val2=document.forms[0].txt_val[1].value;
if(document.forms[0].txt_value[1].value=="")
{
document.forms[0].txt_value[1].value="0";
}
if(area=="")
{
area="0.00";
}
if(val2=="")
{
val2="0.00";
}
if(document.forms[0].txt_val[1].value=="")
{
document.forms[0].txt_val[1].value="0.00";
}
var guntas = document.forms[0].measurement.value;
var totalval1=0.00;
var totalval2=0.00;
		if(val2=="")
		{
			val2=0.00;
			
		}
		if(area=="")
		{
			area=0.00;
			
		}
      var len=area.length;
    var len1=len-1;
   for(var k=0;k<=len;k++)
  {
   
  
   if((area.charAt(k)=="."))
   {
     i = area.indexOf(".");
     str1=area.substring(0,i);
     str = area.substring(i+1,len);
   }
   
   
       } 
      

	
	if(guntas== 'g')
   {
  		guntarate = val2 / 40;
  		guntarate = str * guntarate;
  		acrerate = 	str1* val2; 
  		totalrate = acrerate + guntarate;
   }
  // var totalrate=0.00;
    if(area==".")
   {
   area="0.00";
   }
   
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_specify[1].value= totalrate ;
	roundtxt(document.forms[0].txt_specify[1]);
	if(document.forms[0].txt_specify[1].value=="NaN")
	{
	document.forms[0].txt_specify[1].value= "0" ;
	}
	

  }
function callsalary()
{
for(var m=8;m<9;m++)
{

var value="<%=Helper.correctNull((String)hshValues.get("txt_labourers"))%>";

var unit=document.forms[0].txt_value[8].value;

var unit1=document.forms[0].txt_specify[8].value; 

	if(value=="")
	{
	value=0.00;
		
	}
	if(unit=="")
	{
	unit=0.00;
		
	}
	if(unit1=="")
	{
	unit1=0.00;
		
	}
var amount=eval(value)*eval(unit)*eval(unit1);
document.forms[0].txt_amount[m].value=Math.round(eval(amount));
roundtxt(document.forms[0].txt_amount[m]);	
}
}
function leastval()
{
var val1=document.forms[0].txt_specify[1].value;
var val2=document.forms[0].txt_value[2].value;
if(eval(val1)==eval(val2))
{
document.forms[0].txt_value[3].value=eval(val1);
}
if(eval(val1)<eval(val2))
{
document.forms[0].txt_value[3].value=eval(val1);
}
if(eval(val2)<eval(val1))
{
document.forms[0].txt_value[3].value=eval(val2);
}
if(document.forms[0].txt_value[3].value=="NaN")
{
document.forms[0].txt_value[3].value="0";
}
document.forms[0].txt_amount[1].value=document.forms[0].txt_value[3].value;
roundtxt(document.forms[0].txt_amount[1]);	
}
function amount()
{
for(var m=0;m<1;m++)
{
var sqft=document.forms[0].txt_val[m].value;
var value=document.forms[0].txt_value[m].value;
var unit=document.forms[0].txt_unit[m].value;
 if(sqft=="")
		{
	sqft=0.00;
			
		}
	if(value=="")
	{
	value=0.00;
		
	}
	if(unit=="")
	{
	unit=0.00;
		
	}
	var amount=eval(sqft)*eval(value)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount));
document.forms[0].txt_cost[m].value="0.00";	
roundtxt(document.forms[0].txt_amount[m]);	
}

}
function checkmargin()
{
	/*var val1=document.forms[0].txt_marginper.value;
	if(val1=="")
	{
		val1="0";
	}
	if(document.forms[0].txt_marginper.value>100)
	{
		alert("Margin % cannot be greater than 100%");
		document.forms[0].txt_marginper.value="";
		document.forms[0].txt_marginper.focus();
		return;
	}*/
}
function callamount()
{
for(var m=4;m<=7;m++)
{

var value=document.forms[0].txt_cost[m].value;
var unit=document.forms[0].txt_unit[m].value;
 
	if(value=="")
	{
	value=0;
		
	}
	if(unit=="")
	{
	unit=0;
		
	}
var amount=eval(value)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount));
	roundtxt(document.forms[0].txt_amount[m]);	
}

for(var m=9;m<=12;m++)
{

var value=document.forms[0].txt_cost[m].value;
var unit=document.forms[0].txt_unit[m].value;
 
	if(value=="")
	{
	value=0;
		
	}
	if(unit=="")
	{
	unit=0;
		
	}
var amount=eval(value)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount));
roundtxt(document.forms[0].txt_amount[m]);		
}

}
function callTotal()


{

var totalvalue1=0.00;
for(var m=0;m<=12;m++)
     {

var loan=document.forms[0].txt_amount[m].value;
      
		if(loan=="")
		{
			loan =0.00;
			
		}
     totalvalue1 = eval(loan)+eval(totalvalue1)
	
     }
     
   document.forms[0].txt_totalamount.value= eval(totalvalue1);
  roundtxt(document.forms[0].txt_totalamount);	
   
}
function marginper()
{
	/*var totalamount=document.forms[0].txt_totalamount.value;
	var marginper=document.forms[0].txt_marginper.value;
	if(eval(marginper)=="")
	{
		marginper="0";
		document.forms[0].txt_marginper.value="0";
	}
	var margin=eval(marginper)/100*eval(totalamount);
	document.forms[0].txt_margin.value=Math.round(eval(margin));*/
}
function subsidyper()
{
	/*var totalamount=document.forms[0].txt_totalamount.value;
	var subsidyper=document.forms[0].txt_subsidyper.value;
	if(eval(subsidyper)=="")
	{
	subsidyper="0";
	document.forms[0].txt_subsidyper.value="0";
	}
	var subsidy=eval(subsidyper)/100*eval(totalamount);
	document.forms[0].txt_subsidy.value=Math.round(eval(subsidy));*/

}
function margin()
{
	/*var totalamount=document.forms[0].txt_totalamount.value;
	var margin=document.forms[0].txt_margin.value;
	if(eval(margin)=="")
	{
		margin="0";
		document.forms[0].txt_margin.value="0";
	}
	var marginper=(eval(margin)*100)/eval(totalamount);
	document.forms[0].txt_marginper.value=Math.round(eval(marginper));*/
}
function subsidy()
{
	/*var totalamount=document.forms[0].txt_totalamount.value;
	var subsidy=document.forms[0].txt_subsidy.value;
	if(eval(subsidy)=="")
	{
		subsidy="0";
		document.forms[0].txt_subsidy.value="0";
	}
	var subsidyper=(eval(subsidy)*100)/eval(totalamount);
	document.forms[0].txt_subsidyper.value=Math.round(eval(subsidyper));*/
}
function loanamount()
{

	/*var totalamount=document.forms[0].txt_totalamount.value;
	
	var subsidy=document.forms[0].txt_subsidy.value;
	if(document.forms[0].txt_subsidy.value=="NaN")
	{
		document.forms[0].txt_subsidy.value="0";
		document.forms[0].txt_subsidyper.value="0";
	}
	var margin=document.forms[0].txt_margin.value;
	if(document.forms[0].txt_margin.value=="NaN")
	{
		document.forms[0].txt_margin.value="0";
		document.forms[0].txt_marginper.value="0";
	}
	document.forms[0].txt_totalloanamount.value=NanNumber(eval(totalamount)-(eval(margin)+eval(subsidy)));*/
}
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


function doEdit()
{
 	disableFields(false);
 
	  document.forms[0]. txt_totalamount.readOnly =true; 
	  //document.forms[0]. txt_totalloanamount.readOnly =true; 
	  document.forms[0]. txt_value[3].readOnly =true; 
	  document.forms[0]. txt_unit[1].readOnly =true;
	  document.forms[0]. txt_cost[0].readOnly =true;  
	  document.forms[0]. txt_cost[1].readOnly =true; 
	   document.forms[0]. txt_value[1].readOnly =true;
	    document.forms[0]. txt_cost[0].readOnly =true;  
		document.forms[0]. txt_unit[1].readOnly =true;  
		document.forms[0]. txt_cost[1].readOnly =true;  
	  for(var h=0;h<12;h++)
	  {
	  document.forms[0]. txt_amount[h].readOnly =true;
	  }
	  document.forms[0].hideditflag.value ="Y";
	 document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, true);
	document.forms[0].txt_unit[7].readOnly=true;		
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getseriloanreq";
		document.forms[0].action=appURL+"action/agr_seri_loanreq.jsp";	
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateseriloanreq";
	document.forms[0].hidBeanGetMethod.value="getseriloanreq";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="action/agr_seri_loanreq.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();
	}		
}

function onloading()
{	  
	disableFields(true);
}
function enableButtons(bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{	
   calleligibility();leastval();amount();callamount();callTotal();loanamount();
   
   if(document.forms[0].txt_val[1].value=="" || document.forms[0].txt_val[1].value=="0.00")
   {
   alert('Enter Unit cost per acre');
   document.forms[0].txt_val[1].focus();
   return;
   }
   if(document.forms[0].txt_value[2].value=="")
   {
   alert('Enter Requested Amount');
   document.forms[0].txt_value[2].focus();
   return;
   }
	enableButtons( true, true, true, true, false);	
    document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="/action/agr_seri_loanreq.jsp";
	document.forms[0].hidBeanMethod.value="updateseriloanreq";
	document.forms[0].hidBeanGetMethod.value="getseriloanreq";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function checkRequestRange()
{
  var req_amount="<%=Helper.correctNull((String)hshValues.get("REQUESTED_AMT"))%>";

   if(req_amount==""){req_amount="0.00";}
   var req_amt=document.forms[0].txt_value[2].value;
   if(req_amt==""){req_amt="0.00";}
   if(parseFloat(req_amount)< parseFloat(req_amt))
   {
      alert("Requirement requested Amount should not be greater than "+req_amount); 
      document.forms[0].txt_value[2].value="";
      return false;
      
   }
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();callsalary();calleligibility();leastval();amount();callamount();callTotal();margin();subsidy();marginper();subsidyper();loanamount();">
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
                        <td colspan="13"> 
						<table width="100%" border="0" cellspacing="2" cellpadding="1" class="outertable">
                            <tr class="dataheader"> 
                              <td width="74%"><b>Particulars</b></td>
                              <td width="8%" align="center"><b>No. 
                                of units</b></td>
                              <td width="8%" align="center"><b>Cost 
                                per unit(Rs.)</b></td>
                              <td width="10%" align="center"><b>Amount(Rs.)</b></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(0);

				if (arryCol.size() != 0) {
				
				
					a1 = Helper.correctNull((String) arryCol.get(3));
					a2 = Helper.correctNull((String) arryCol.get(4));
				    a3=Helper.correctNull((String) arryCol.get(5));
				   a4=Helper.correctNull((String) arryCol.get(6));
				
              }
			} else if (arryRow.size() == 0) {
				
				a1= "";
				a2="";
				a3="";a4="";
			}

			%>
                              <td>1)Construction 
                                of rearing shed measuring 
                                <input type="text" name="txt_val" size="10" maxlength="5"
									value="<%=a1%>" onKeyPress="allowNumber(this)" onBlur="callamount();callTotal()">
                                sq ft @ Rs. 
                                <lapschoice:CurrencyTag name="txt_value" size="10" maxlength="9"
									value='<%=a2%>' onBlur="callamount();callTotal()"
									/>
                                per sq ft 
                                <input type="hidden" name="txt_specify" maxlength="5"
											size="15" style="text-align:left" value="" onBlur="calleligibility()">
                                </td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="4"
									value="<%=a4%>" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="amount()"></td>
                              <td>
                                <input type="hidden" name="txt_cost"size="10"
									maxlength="5" value="0" onKeyPress="allowInteger()"
									style="text-align:right;">
                                </td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="9" value='' /></td>
                            </tr>
                            <tr> 
                              <td colspan="4">2)<strong>Cost 
                                of cultivation of mulberry</strong></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {
				
				
					a5= Helper.correctNull((String) arryCol.get(3));
					a6 = Helper.correctNull((String) arryCol.get(4));
				    a7=Helper.correctNull((String) arryCol.get(5));
				  	a8=Helper.correctNull((String) arryCol.get(6));
				
              }
			} else if (arryRow.size() == 0) {
				
				a5= "";
				a6="";
				a7="";a8="";
			}

			%>
                              <td >a)Unit 
                                cost per acre*Area under cultivation<b class="mantatory">*</b> 
                                ( 
                                <input type="text" name="txt_val" maxlength="5" onkeypress="allowNumber(this);"
											size="15" style="text-align:left" value="<%=a5%>" onBlur="calleligibility();leastval();">
                                * 
                                <input type="text" name="txt_value" maxlength="6"
											size="15" style="text-align:left" value="<%=Helper.correctNull((String)hshValues.get("txt_area"))%>.<%=Helper.correctNull((String)hshValues.get("txt_guntas"))%>" onBlur="calleligibility()">
                                = 
                                <lapschoice:CurrencyTag name="txt_specify" maxlength="9"
											size="15" style="text-align:right" value='<%=a7%>' onBlur="calleligibility();leastval();"/>
                                ) (A)</td>
                              <td>
                                <input type="hidden" name="txt_unit"onFocus=""  size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td>
                                <input type="hidden" name="txt_cost"size="10"
									maxlength="9" value="0" onKeyPress="allowInteger()"
									style="text-align:right;">
                               </td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="9" value='' /></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {
				
				
					a9 = Helper.correctNull((String) arryCol.get(3));
					a10 = Helper.correctNull((String) arryCol.get(4));
				    a11=Helper.correctNull((String) arryCol.get(5));
				   a12=Helper.correctNull((String) arryCol.get(6));
				
              }
			} else if (arryRow.size() == 0) {
				
				a9= "";
				a10="";
				a11="";a12="";
			}

			%>
                              <td>Requested 
                                Amount(Rs.)<b class="mantatory">*</b> 
                                <lapschoice:CurrencyTag name="txt_value" maxlength="9"
											size="15" value='<%=a10%>' onBlur="leastval();callamount();callTotal();checkRequestRange()" /> 
                                (B) <b></b> 
                                 
                                <input type="hidden" name="txt_specify" maxlength="4"
											size="15" style="text-align:left" value="" ">
                                <input type="hidden" name="txt_val"  maxlength="6"
											size="15" style="text-align:left" value="">
                              </td>
                              <td><input type="hidden" name="txt_unit"onFocus=""  size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="hidden" name="txt_cost"size="10"
									maxlength="9" value="0" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="hidden" name="txt_amount"  size="10"
									maxlength="9" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(3);

				if (arryCol.size() != 0) {
				
				
					a13 = Helper.correctNull((String) arryCol.get(3));
					a14= Helper.correctNull((String) arryCol.get(4));
				    a15=Helper.correctNull((String) arryCol.get(5));
				   a16=Helper.correctNull((String) arryCol.get(6));
				
              }
			} else if (arryRow.size() == 0) {
				
				a13= "";
				a14="";
				a15="";a16="";
			}

			%>
                              <td>Least of 
                                (A&amp; B)(Rs.) 
                                <lapschoice:CurrencyTag name="txt_value" maxlength="9"
											size="15" value='<%=a14%>' onBlur="callamount();callTotal()" />
                                (C) 
                                <input type="hidden" name="txt_specify" maxlength="5"
											size="15" style="text-align:left" value="" ">
                                <input type="hidden" name="txt_val" maxlength="9"
											size="15" style="text-align:left" value="">
                                </td>
                              <td><input type="hidden" name="txt_unit"onFocus=""  size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="hidden" name="txt_cost"size="10"
									maxlength="9" value="0" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="hidden" name="txt_amount"  size="10"
									maxlength="9" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {
				
				
					a17 = Helper.correctNull((String) arryCol.get(3));
					a18 = Helper.correctNull((String) arryCol.get(4));
				    a19=Helper.correctNull((String) arryCol.get(5));
				  a20=Helper.correctNull((String) arryCol.get(6));
				  c1=Helper.correctNull((String) arryCol.get(7));
				
              }
			} else if (arryRow.size() == 0) {
				
				a17= "";
				a18="";
				a19="";a20="";c1="";
			}

			%>
                              <td>3)Chandrika 
                                <input type="hidden" name="txt_specify" maxlength="5"
											size="15" style="text-align:left" value="" >
                                <input type="hidden" name="txt_val" maxlength="9"
											size="15" style="text-align:left" value="0">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="4"
									value="<%=a20%>" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="callamount();callTotal()" ></td>
                              <td><lapschoice:CurrencyTag name="txt_cost"size="10"
									maxlength="7" value='<%=c1%>' onBlur="callamount();callTotal()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="9" value='' /></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(5);

				if (arryCol.size() != 0) {
				
				
					b1 = Helper.correctNull((String) arryCol.get(3));
					b2 = Helper.correctNull((String) arryCol.get(4));
				    b3=Helper.correctNull((String) arryCol.get(5));
				   b4=Helper.correctNull((String) arryCol.get(6));
				   c2=Helper.correctNull((String) arryCol.get(7));
				
              }
			} else if (arryRow.size() == 0) {
				
				b1= "";
				b2="";
				b3="";b4="";c2="";
			}

			%>
                              <td>4)Trays 
                                <input type="hidden" name="txt_specify" maxlength="9"
											size="15" style="text-align:left" value="">
                                <input type="hidden" name="txt_val" maxlength="9"
											size="15" style="text-align:left" value="0">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="4"
									value="<%=b4%>" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="callamount();callTotal()" ></td>
                              <td><lapschoice:CurrencyTag name="txt_cost"size="10"
									maxlength="7" value='<%=c2%>' onBlur="callamount();callTotal()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="9" value='' /></td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(6);

				if (arryCol.size() != 0) {
				
				
					b5 = Helper.correctNull((String) arryCol.get(3));
					b6= Helper.correctNull((String) arryCol.get(4));
				   b7=Helper.correctNull((String) arryCol.get(5));
				   b8=Helper.correctNull((String) arryCol.get(6));
				c3=Helper.correctNull((String) arryCol.get(7));
              }
			} else if (arryRow.size() == 0) {
				
				b5= "";
				b6="";
				b7="";b8="";c3="";
			}

			%>
                              <td height="26">5)Stand 
                                <input type="hidden" name="txt_specify" maxlength="5"
											size="15" style="text-align:left" value="" >
                                <input type="hidden" name="txt_val" size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="4"
									value="<%=b8%>" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="callamount();callTotal()" ></td>
                              <td><lapschoice:CurrencyTag name="txt_cost"size="10"

									maxlength="7" value='<%=c3%>' onBlur="callamount();callTotal()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="9" value='' /></td>
                            </tr>
                            <tr>
							  <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(7);

				if (arryCol.size() != 0) {
				
				
					b9 = Helper.correctNull((String) arryCol.get(3));
					b10 = Helper.correctNull((String) arryCol.get(4));
				    b11=Helper.correctNull((String) arryCol.get(5));
				   b12=Helper.correctNull((String) arryCol.get(6));
				  c4=Helper.correctNull((String) arryCol.get(7));
              }
			} else if (arryRow.size() == 0) {
				
				b9= "";
				b10="";
				b11="";b12="";c4="";
			}

			%>
                              
                              <td>6)Cost of 
                                Eggs(DFLs) 
                                <input type="hidden" name="txt_specify" maxlength="5"
											size="15" style="text-align:left" value="" >
                                <input type="hidden" name="txt_val" size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="4"
									value='<%=Helper.correctNull((String)hshValues.get("txt_noeggs"))%>' onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="callamount();callTotal()" ></td>
                              <td><lapschoice:CurrencyTag name="txt_cost"size="10"
									maxlength="7" value='<%=c4%>' onBlur="callamount();callTotal()" /></td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="9" value='' /></td>
                            </tr>
                            <tr> 
							 <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(8);

				if (arryCol.size() != 0) {
				
				
					d1 = Helper.correctNull((String) arryCol.get(3));
					d2 = Helper.correctNull((String) arryCol.get(4));
				    d3=Helper.correctNull((String) arryCol.get(5));
				   d4=Helper.correctNull((String) arryCol.get(6));
				  d5=Helper.correctNull((String) arryCol.get(7));
              }
			} else if (arryRow.size() == 0) {
				
				d1= "";
				d2="";
				d3="";d4="";d5="";
			}

			%>
                        
                              <td>7)Wages/Salary 
                                for 
<input type="text" name="txt_specify" maxlength="3"
											size="15" style="text-align:left" value="<%=d3%>" onBlur="callsalary();callTotal()" >
                                Months 
                                <input type="hidden" name="txt_val" size="10" maxlength="3"
									value="<%=Helper.correctNull((String)hshValues.get("txt_labourers"))%>" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                <input type="hidden" name="txt_value" maxlength="3"
											size="15" style="text-align:left" value="<%=Helper.correctNull((String)hshValues.get("txt_wage"))%>" onBlur="">
                                </td>
                              <td><input type="hidden" name="txt_unit"onFocus=""  size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="callamount();callTotal()" ></td>
                              <td>
                                <input type="hidden" name="txt_cost"size="10"
									maxlength="9" value="0" onKeyPress="allowInteger()" onBlur="callamount();callTotal()"
									style="text-align:right;">
                                </td>
                              <td><lapschoice:CurrencyTag name="txt_amount"  size="10"
									maxlength="9" value='' /></td>
                            </tr>
                            <tr > 
                              <td colspan="4"><b>Others 
                                Specify</b></td>
                            </tr>
                          </table>
						  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(9);

				if (arryCol.size() != 0) {
				
				
					l1 = Helper.correctNull((String) arryCol.get(5));
					l2 = Helper.correctNull((String) arryCol.get(6));
				    l3=Helper.correctNull((String) arryCol.get(7));
				
              }
			} else if (arryRow.size() == 0) {
				
				l1= "";
				l2="";
				l3="";
			}

			%>
                              <td width="74%">
                                <input type="text" name="txt_specify" size="70" maxlength="40"
									value="<%=l1%>" onKeyPress=""

									style="text-align:left;">
                                <input type="hidden" name="txt_val" size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()" onBlur="callamount();callTotal()"
									style="text-align:right;">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td width="7%">
                                <input type="text" name="txt_unit" size="10" maxlength="9"
									value="<%=l2%>" onKeyPress="allowInteger()" onBlur="callamount();callTotal()"
									style="text-align:right;">
                                </td>
                              <td width="8%">
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=l3%>' onBlur="callamount();callTotal()"
									/>
                                </td>
                              <td width="11%">
                                <lapschoice:CurrencyTag name="txt_amount" size="10" maxlength="9"
									value='' onBlur="callamount();callTotal()"
									/>
                                </td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(10);

				if (arryCol.size() != 0) {
				
				
					l4 = Helper.correctNull((String) arryCol.get(5));
					l5 = Helper.correctNull((String) arryCol.get(6));
				    l6=Helper.correctNull((String) arryCol.get(7));
				
              }
			} else if (arryRow.size() == 0) {
				
				l4= "";
				l5="";
				l6="";
			}

			%>
                              <td>
                                <input type="text" name="txt_specify" size="70" maxlength="40"
									value="<%=l4%>" onKeyPress=""
									style="text-align:left;">
                                <input type="hidden" name="txt_val" size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td>
                                <input type="text" name="txt_unit" size="10" maxlength="9"
									value="<%=l5%>" onKeyPress="allowInteger()" onBlur="callamount();callTotal()"
									style="text-align:right;">
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=l6%>' onBlur="callamount();callTotal()"
									/>
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_amount" size="10" maxlength="9"
									value='' onBlur="callamount();callTotal()"
									/>
                                </td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(11);

				if (arryCol.size() != 0) {
				
				
					l7 = Helper.correctNull((String) arryCol.get(5));
					l8= Helper.correctNull((String) arryCol.get(6));
				    l9=Helper.correctNull((String) arryCol.get(7));
				
              }
			} else if (arryRow.size() == 0) {
				
				l7= "";
				l8="";
				l9="";
			}

			%>
                              <td>
                                <input type="text" name="txt_specify" size="70" maxlength="40"
									value="<%=l7%>" onKeyPress=""style="text-align:left;">
                               <input type="hidden" name="txt_val" size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td>
                                <input type="text" name="txt_unit" size="10" maxlength="9"
									value="<%=l8%>" onKeyPress="allowInteger()" onBlur="callamount();callTotal()"
									style="text-align:right;">
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=l9%>' onBlur="callamount();callTotal()"
									/>
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_amount" size="10" maxlength="9"
									value='' onBlur="callamount();callTotal()"
									/>
                                </td>
                            </tr>
                            <tr> 
                              <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(12);

				if (arryCol.size() != 0) {
				
				
					l10 = Helper.correctNull((String) arryCol.get(5));
					l11 = Helper.correctNull((String) arryCol.get(6));
				    l12=Helper.correctNull((String) arryCol.get(7));
				
              }
			} else if (arryRow.size() == 0) {
				
				l10= "";
				l11="";
				l12="";
			}

			%>
                              <td>
                                <input type="text" name="txt_specify" size="70" maxlength="40"
									value="<%=l10%>" onKeyPress=""
									style="text-align:left;">
                                <input type="hidden" name="txt_val" size="10" maxlength="9"
									value="0" onKeyPress="allowInteger()" 
									style="text-align:right;">
                                <input type="hidden" name="txt_value" maxlength="9"
											size="15" style="text-align:left" value="" onBlur="callamount();callTotal()">
                                </td>
                              <td>
                                <input type="text" name="txt_unit" size="10" maxlength="9"
									value="<%=l11%>" onKeyPress="allowInteger()" onBlur="callamount();callTotal()"
									style="text-align:right;">
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_cost" size="10" maxlength="7"
									value='<%=l12%>' onBlur="callamount();callTotal()"
									/>
                                </td>
                              <td>
                                <lapschoice:CurrencyTag name="txt_amount" size="10" maxlength="9"
									value='' onBlur="callamount();callTotal()"
									/>
                                </td>
                            </tr>
                            <tr> 
                              <td ><b>Total(Amount)(Rs.)</b></td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td><input type="text" name="txt_totalamount" size="10"
									maxlength="9" value="" onKeyPress="allowInteger()"
									readOnly style="text-align:right;"> <b></b></td>

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
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>