<%@include file="../share/directives.jsp"%>
<%
 String d1="",d2="";
			
ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow  = (ArrayList) hshValues.get("arryRow");


if (arryRow == null) {
	arryRow  = new ArrayList();
}

%>

<html>
<head>
<title>CAPL Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

</script>

<script>
function show_finance()
{
  	if(document.forms[0].cmdedit.disabled)
	{
    	var action=document.forms[0].hidAction.value;
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	 	var url=appURL +"action/scalefinancemasterlist.jsp?&strfrom=District_loanmasterreq";
		window.open(url,"",prop);
		
    }
    else
    {
         alert('KINDLY CLICK THE EDIT BUTTON');
    }		
} 
function callEligibility()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;

if(document.forms[0].txt_area.value=="")
{
document.forms[0].txt_area.value="0.00";
}
var area = document.forms[0].txt_area.value;
if(area==".")
   {
   area="0.00";
   }

var val2=document.forms[0].txt_finval.value;
if(area=="")
{
area="0.00";
}
if(val2=="")
{
val2="0.00";
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
   if(area==".")
   {
   area="0.00";
   }
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_ibatchiyear.value= totalrate ;
	document.forms[0].txt_ibatchiiyear.value= totalrate ;
	roundtxt(document.forms[0].txt_ibatchiyear);
	if(document.forms[0].txt_ibatchiyear.value=="NaN")
	{
	document.forms[0].txt_ibatchiyear.value= "0" ;
	}
	roundtxt(document.forms[0].txt_ibatchiiyear);
	if(document.forms[0].txt_ibatchiyear.value=="NaN")
	{
	document.forms[0].txt_ibatchiiyear.value= "0" ;
	}
	

  }

function callamount1()
{
	var unit1=document.forms[0].txt_unit1.value;
	var cost1=document.forms[0].txt_cost1.value;
	var crop1=document.forms[0].txt_crop1.value;
			if(eval(cost1==""))
		{
			cost1="0";
		}
			if(eval(crop1==""))
		{
			crop1="0";
		}
			if(eval(unit1==""))
		{
			unit1="0";
		}
	document.forms[0].txt_amount1.value=parseFloat(unit1) * parseFloat(cost1) * parseFloat(crop1);
	document.forms[0].txt_iibatchiiyear.value=parseFloat(unit1) * parseFloat(cost1) * parseFloat(crop1);
	document.forms[0].txt_iibatchiyear.value=document.forms[0].txt_amount1.value;
	roundtxt(document.forms[0].txt_amount1);
	roundtxt(document.forms[0].txt_iibatchiiyear);

}
function callamount2()
{
var unit2=document.forms[0].txt_unit2.value;
var cost2=document.forms[0].txt_cost2.value;
if(eval(cost2==""))
{
cost2="0";
}
if(eval(unit2==""))
{
unit2="0";
}

document.forms[0].txt_amount2.value=parseFloat(unit2) * parseFloat(cost2) * 12;
document.forms[0].txt_iiibatchiiyear.value=parseFloat(unit2) * parseFloat(cost2)*12;
document.forms[0].txt_iiibatchiyear.value=document.forms[0].txt_amount2.value;
roundtxt(document.forms[0].txt_amount2);
roundtxt(document.forms[0].txt_iiibatchiyear);


}
function callTotal()
{
var txt_ibatchiyear=document.forms[0].txt_ibatchiyear.value;
var txt_iibatchiyear=document.forms[0].txt_iibatchiyear.value;
var txt_iiibatchiyear=document.forms[0].txt_iiibatchiyear.value;

if(eval(txt_ibatchiyear)=="")
{
txt_ibatchiyear="0";
}

if(eval(txt_iibatchiyear)=="")
{
txt_iibatchiyear="0";
}
if(eval(txt_iiibatchiyear)=="")
{
txt_iiibatchiyear="0";
}


document.forms[0].txt_totamount1.value=parseFloat(txt_ibatchiyear) + parseFloat(txt_iibatchiyear) + parseFloat(txt_iiibatchiyear);
var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear.value;
var txt_iibatchiiyear=document.forms[0].txt_iibatchiiyear.value;
var txt_iiibatchiiyear=document.forms[0].txt_iiibatchiiyear.value;
if(eval(txt_ibatchiiyear)=="")
{
txt_ibatchiiyear="0";
}
if(eval(txt_iibatchiiyear)=="")
{
txt_iibatchiiyear="0";
}
if(eval(txt_iiibatchiiyear)=="")
{
txt_iiibatchiiyear="0";
}
document.forms[0].txt_totamount2.value=eval(txt_ibatchiiyear)+eval(txt_iibatchiiyear)+eval(txt_iiibatchiiyear);

//var txt_iibatchiyearb=document.forms[0].txt_iibatchiyearb.value;
//var txt_iiibatchiyearb=document.forms[0].txt_iiibatchiyearb.value;
var txt_disinfect1=document.forms[0].txt_disinfect1.value;
//alert(txt_disinfect);

//if(eval(txt_iibatchiyearb)=="")
//{
//txt_iibatchiyearb="0";
//}
//if(eval(txt_iiibatchiyearb)=="")
//{
//txt_iiibatchiyearb="0";
//}
if(eval(txt_disinfect1)=="")
{
txt_disinfect1="0";
}

document.forms[0].txt_totalamount.value=NanNumber(eval(txt_disinfect1));
roundtxt(document.forms[0].txt_totalamount);
roundtxt(document.forms[0].txt_totamount2);
roundtxt(document.forms[0].txt_totamount1);

}
function callamount3()
{
var txt_unit3=document.forms[0].txt_unit3.value;
var txt_cost3=document.forms[0].txt_cost3.value;
var txt_crop3=document.forms[0].txt_crop3.value;
if(eval(txt_unit3)=="")
{
txt_unit3="0";
}
if(eval(txt_cost3)=="")
{
txt_cost3="0";
}
if(eval(txt_crop3)=="")
{
txt_crop3="0";
}
document.forms[0].txt_iyearincome.value=eval(txt_unit3)*eval(txt_cost3)*eval(txt_crop3);
if(document.forms[0].txt_iyearincome.value=="NaN")
{
document.forms[0].txt_iyearincome.value="0";
}
document.forms[0].txt_iiyearincome.value=eval(txt_unit3)*eval(txt_cost3)*eval(txt_crop3);
if(document.forms[0].txt_iiyearincome.value=="NaN")
{
document.forms[0].txt_iiyearincome.value="0";
roundtxt(document.forms[0].txt_iiyearincome);
}
}
function callTotal3()
{
var val1=document.forms[0].txt_iyearincome.value;
if(eval(val1)=="")
{
val1="0";
}
var val2=document.forms[0].txt_iyearincome1.value;
if(eval(val2)=="")
{
val2="0";
}
var val3=document.forms[0].txt_iiyearincome.value;
if(eval(val3)=="")
{
val3="0";
}
var val4=document.forms[0].txt_iiyearincome1.value;
if(eval(val4)=="")
{
val4="0";
}
document.forms[0].txt_totincomeiyear.value=eval(val1)+eval(val2);
if(document.forms[0].txt_totincomeiyear.value=="NaN")
{
document.forms[0].txt_totincomeiyear.value="0";
}
document.forms[0].txt_totincomeiiyear.value=eval(val3)+eval(val4);
if(document.forms[0].txt_totincomeiiyear.value=="NaN")
{
document.forms[0].txt_totincomeiiyear.value="0";
}
roundtxt(document.forms[0].txt_totincomeiyear);
roundtxt(document.forms[0].txt_totincomeiiyear);
}
function callsurplus()
{
callamount3();
var value1=document.forms[0].txt_totincomeiyear.value;
var value2=document.forms[0].txt_totamount1.value;
var value3=document.forms[0].txt_totincomeiiyear.value;

var value4=document.forms[0].txt_totamount2.value;

if(eval(value1)=="")
{
value1="0";
}
if(eval(value2)=="")
{
value2="0";
}
if(eval(value3)=="")
{
value3="0";
}
if(eval(value4)=="")
{
value4="0";
}
document.forms[0].txt_totalincomeiyear.value=eval(value1)-eval(value2);
document.forms[0].txt_totalincomeiiyear.value=eval(value3)-eval(value4);
roundtxt(document.forms[0].txt_totalincomeiyear);
roundtxt(document.forms[0].txt_totalincomeiiyear);

}
function onloading()
{	  
	if(document.forms[0].txt_area.value==".")
	{
		document.forms[0].txt_area.value="0.00";
	}
		
	if(document.forms[0].txt_area.value=="")
	{
		document.forms[0].txt_area.value="0.00";
	}
	disableFields(true);
}

function calldisinfect2()
{
	if (document.forms[0].txt_disinfect1.value!=0)
	{
		document.forms[0].txt_disinfect2.value=document.forms[0].txt_disinfect1.value;
	}
	roundtxt(document.forms[0].txt_disinfect2);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{
     callsurplus();
	 callTotal();
	 callTotal3();
    enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agr_seri_economics.jsp";
	document.forms[0].hidBeanMethod.value="updateserieconomics";
	document.forms[0].hidBeanGetMethod.value="getserieconomics";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(true);
	document.forms[0].txt_area.readOnly=true;
	document.forms[0].txt_finval.readOnly=false;
	document.forms[0].txt_unit1.readOnly=true;
	document.forms[0].txt_cost1.readOnly=true;
	document.forms[0].txt_crop1.readOnly=false;
	document.forms[0].txt_unit2.readOnly=true;
	document.forms[0].txt_cost2.readOnly=true;
	document.forms[0].txt_unit3.readOnly=false;
	document.forms[0].txt_cost3.readOnly=false;
	document.forms[0].txt_crop3.readOnly=false;
	document.forms[0].txt_amount2.readOnly=true;
	document.forms[0].txt_specify.readOnly=false;
	document.forms[0].txt_disinfect1.readOnly=false;
	document.forms[0].txt_iyearincome1.readOnly=false;
	document.forms[0].txt_iiyearincome1.readOnly=false;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);	
	document.forms[0].txt_iyearincome1.readOnly=false;	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getserieconomics";
		document.forms[0].action=appURL+"action/agr_seri_economics.jsp";
		document.forms[0].submit(); 		
	}	
}


function calldef()
{

if(document.forms[0].txt_specify.value !="")
{
//document.forms[0].txt_iyearincome1.value=document.forms[0].txt_specify.value;
}

}
function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/"+"retailpge.jsp";				
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
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
		  
	}
}


function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
	  	document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateserieconomics";
		document.forms[0].hidBeanGetMethod.value="getserieconomics";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agr_seri_economics.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();callEligibility();callamount1();callamount2();callTotal();callamount3();callTotal3();callsurplus()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
<tr>
  <td>
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr class="dataheader"> 
      <td width="69%" rowspan="2"><b>Expenses</b></td>
      <td colspan="2"><b>Amount(Rs.)</b></td>
    </tr>
    <tr class="dataheader"> 
      <td width="15%"><b>I Year</b></td>
      <td width="16%"><b>II Year(onwards)</b></td>
    </tr>
    <tr> 
      <td>Recurring Expenses on cultivation 
        of mulberry Crop<br>
        Scale of Finance * Area under Cultivation=( 
        <lapschoice:CurrencyTag name="txt_finval" maxlength="7" 
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_finval"))%>' onBlur="callEligibility();callTotal();callsurplus()"/>
        <span onClick="show_finance()" style="cursor:hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span> * 
        <input type="text" name="txt_area" maxlength="7" 
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_area")) + "." + Helper.correctNull((String)hshValues.get("txt_guntas"))%>' onBlur="callEligibility();callTotal();callsurplus()">
        )</td>
      <td> 
        <lapschoice:CurrencyTag name="txt_ibatchiyear" maxlength="7"
											size="15" value='0' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
      <td> 
        <lapschoice:CurrencyTag name="txt_ibatchiiyear" maxlength="7"
											size="15" value='0' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
    </tr>
    <tr> 
      <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(7);

				if (arryCol.size() != 0) {
				
				 d2=Helper.correctNull((String) arryCol.get(8));
              }
			} else if (arryRow.size() == 0) {
				
				d2= "";
				
			}

			%>
      <td rowspan="2"> Cost of Eggs(DFLs)<br>
        (No. of units of DFLs * Cost/unit of DFLs * No. of Crops/year)<br> 
         ( 
        <input type="text" name="txt_unit1" maxlength="6" size="15" value='<%=Helper.correctNull((String)hshValues.get("seri_unit"))%>' onBlur="callamount1();callTotal()"/>
        * 
        <lapschoice:CurrencyTag name="txt_cost1" maxlength="6" 
											size="15" value='<%=Helper.correctNull((String)hshValues.get("seri_cost"))%>' onBlur="callamount1();callTotal()"/>
        * 
        <input type="text" name="txt_crop1" maxlength="4"  
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_crop1"))%>' onBlur="callamount1();callTotal()"/>
        = 
        <lapschoice:CurrencyTag name="txt_amount1" maxlength="6" 
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        )</td>
      <td> 
        <lapschoice:CurrencyTag name="txt_iibatchiyear" maxlength="7" 
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
      <td rowspan="2"> 
        <lapschoice:CurrencyTag name="txt_iibatchiiyear" maxlength="7"
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        &nbsp; </td>
    </tr>
    <tr> 
      <!--<td bgcolor="#71694F"> 
        <lapschoice:CurrencyTag name="txt_iibatchiyearb" maxlength="7" 
											size="15" value='<%//=d2%>' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>-->
    </tr>
    <tr> 
      <%
						
					if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(8);

				if (arryCol.size() != 0) {
				
				
				 d1=Helper.correctNull((String) arryCol.get(8));
              }
			} else if (arryRow.size() == 0) {
				
				d1= "";
				
			}

			%>
      <td rowspan="2"> Salary/Wages<br>
        (No. of Employeess * Salary/Months * 12)<br>  
        ( 
        <input type="text" name="txt_unit2" maxlength="6" 
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_labourers"))%>' onBlur="callamount2();callTotal();callsurplus()"/>
        * 
        <lapschoice:CurrencyTag name="txt_cost2" maxlength="7" 
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_wage"))%>' onBlur="callamount2();callTotal();callsurplus()"/>
        * 12= 
        <lapschoice:CurrencyTag name="txt_amount2" maxlength="7" 
											size="15" value='' onBlur="callTotal()"/>
        )</td>
      <td> 
        <lapschoice:CurrencyTag name="txt_iiibatchiyear" maxlength="7"
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
      <td rowspan="2"> 
        <lapschoice:CurrencyTag name="txt_iiibatchiiyear" maxlength="7"  
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        &nbsp; </td>
    </tr>
    <tr><!-- 
      <td bgcolor="#71694F"> 
        <lapschoice:CurrencyTag name="txt_iiibatchiyearb" maxlength="7"
											size="15" value='<%//=d1%>' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
    --></tr>  
    
     
    <tr> 
      <td>Disinfection and other charges</td>
       <td> 
       <lapschoice:CurrencyTag name="txt_disinfect1" maxlength="7" 
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_disinfect1"))%>' onBlur="calldisinfect2();roundtxt(this)" />
		</td>
		
		<td > 
        <lapschoice:CurrencyTag name="txt_disinfect2" maxlength="7" size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_disinfect1"))%>' onBlur="roundtxt(this)"/>
		
		</td>									
    </tr>
    <tr> 
      <td><b>Total(Rs.)</b></td>
      <td> 
        <lapschoice:CurrencyTag name="txt_totamount1" maxlength="7" 
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
      <td rowspan="2"> 
        <lapschoice:CurrencyTag name="txt_totamount2" maxlength="7" 
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
    </tr>
    <tr bgcolor="#71694F" style="display:none"> 
      <td><b>Capitalized 
        Expenses(Rs.)</b></td>
      <td> 
        <lapschoice:CurrencyTag name="txt_totalamount" maxlength="7"
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
    </tr>
    <tr class="dataheader"> 
      <td rowspan="2"><b>Income</b></td>
      <td colspan="2"><b>Amount(Rs.)</b></td>
    </tr>
    <tr class="dataheader"> 
      <td><b>I Year</b></td>
      <td><b>II Year(onwards)</b></td>
    </tr>
    <tr> 
      <td>Anticipated production of cocoons<br>
        ( Production/crop  *  average rate per kg of cocoons  *  no. of crops/year )<br>
        ( 
        <input type="text" name="txt_unit3" maxlength="6" size="15"  value='<%=Helper.correctNull((String)hshValues.get("txt_unit3"))%>' onBlur="callamount3();callTotal3();callsurplus()"/>
        kgs*Rs. 
        <lapschoice:CurrencyTag name="txt_cost3" maxlength="6"
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_cost3"))%>' onKeyPress="allowNumber(this)"  onBlur="callamount3();callTotal3();callsurplus()"/>
        * 
        <input type="text" name="txt_crop3" maxlength="6"
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_crop3"))%>' onBlur="callamount3();callTotal3();callsurplus()"/>
        )&nbsp;  </td>
      <td>
        <lapschoice:CurrencyTag name="txt_iyearincome" maxlength="10"  
											size="15" value='' onBlur="callTotal3()"/>
        </td>
      <td>
        <lapschoice:CurrencyTag name="txt_iiyearincome" maxlength="10" 
											size="15" value='' onBlur="callTotal3()"/>
        </td>
    </tr>
    <tr> 
      <td>Other Income
        <input type="text" name="txt_specify" maxlength="40" size="30" style="text-align:left" value='<%=Helper.correctNull((String)hshValues.get("txt_specify"))%>'/>
        </td>
      <td>
        <lapschoice:CurrencyTag name="txt_iyearincome1" maxlength="10" 
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_iyearincome1"))%>' onKeyPress="allowNumber(this)"  onBlur="calldef();callTotal3();callsurplus();roundtxt(this)" />
        </td>
      <td>
        <lapschoice:CurrencyTag name="txt_iiyearincome1" maxlength="10"
											size="15" value='<%=Helper.correctNull((String)hshValues.get("txt_iiyearincome1"))%>' onKeyPress="allowNumber(this)"   onBlur="callTotal3();callsurplus();roundtxt(this)"/>
        </td>
    </tr>
    
    
    
    <tr> 
      <td><b>Total(Rs.)</b></td>
      <td>
        <lapschoice:CurrencyTag name="txt_totincomeiyear" maxlength="10"
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
      <td>
        <lapschoice:CurrencyTag name="txt_totincomeiiyear" maxlength="10"
											size="15" value='' onBlur="callEligibility();callTotal();callsurplus()"/>
        </td>
    </tr>
    <tr>
      <td><b>Net Income(Rs.)</b></td>
      <td>
        <lapschoice:CurrencyTag name="txt_totalincomeiyear" maxlength="10"
											size="15" value='' onBlur="callTotal3()"/>
        </td>
      <td>
        <lapschoice:CurrencyTag name="txt_totalincomeiiyear" maxlength="10"
											size="15" value='' onBlur="callTotal3()"/>
        </td>
    </tr>
  </table>
  </td>
 </tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type ="hidden" name="measurement" value ="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>



