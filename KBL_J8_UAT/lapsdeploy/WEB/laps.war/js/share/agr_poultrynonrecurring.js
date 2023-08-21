function margin1()
{

var margin_per1=document.forms[0].txt_marginper1.value;
 if(margin_per1=="")
		{
	margin_per1=0;
	document.forms[0].txt_marginper1.value="0";		
		}
document.forms[0].txt_marginper1.value=eval(margin_per1);
roundtxt(document.forms[0].txt_marginper1);
var num=(margin_per1)/100;
var num1="";var str1="";
var amount="";
var str=num.toFixed(2);

for(var m=0;m<=6;m++)
{

var amount_val=document.forms[0].txt_amount1[m].value;
 if(amount_val=="")
		{
	amount_val=0;
			
		}

 amount=eval(str)*eval(amount_val);
document.forms[0].txt_margin1[m].value=eval(amount);	
 num1=(amount);
 str1=num1.toFixed(2);
document.forms[0].txt_margin1[m].value=Math.round(eval(str1));	
roundtxt(document.forms[0].txt_margin1[m]);
}
}

function amount1()
{
for(var m=0;m<=6;m++)
{
var unit=document.forms[0].txt_unit[m].value;
var cost=document.forms[0].txt_cost[m].value;
 if(unit=="")
		{
	unit=0;
			
		}
	if(cost=="")
	{
	cost=0;
		
	}
	var amount1=eval(unit)*eval(cost);
document.forms[0].txt_amount1[m].value=Math.round(eval(amount1));	
roundtxt(document.forms[0].txt_amount1[m]);

}
margin1();
}

function callTotal1()
{
amount1();callSurplus1();
var totalvalue1=0.00;var totalvalue2=0.00;var totalvalue3=0.00;
for(var m=0;m<=6;m++)
     {
var value1 =document.forms[0].txt_amount1[m].value;
var margin= document.forms[0].txt_margin1[m].value;
var loan=document.forms[0].txt_loanamount1[m].value;
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
     
   document.forms[0].txt_totamount1.value= eval(totalvalue1);
   document.forms[0].txt_totmargin1.value= eval(totalvalue2);
   document.forms[0].txt_totloanamount1.value= eval(totalvalue3);
   var num1=(totalvalue1);
   var str1=num1.toFixed(2);
   var num2=(totalvalue2);
   var str2=num2.toFixed(2);
    var num3=(totalvalue3);
   var str3=num3.toFixed(3);
    document.forms[0].txt_totamount1.value=Math.round(eval(str1));
    roundtxt(document.forms[0].txt_totamount1);
   document.forms[0].txt_totmargin1.value= Math.round(eval(str2));
   roundtxt( document.forms[0].txt_totmargin1);
   document.forms[0].txt_totloanamount1.value= Math.round(eval(str3));
   roundtxt(document.forms[0].txt_totloanamount1);
   calculateTotal();
}
function callSurplus1()
{
var i;

for(var m=0;m<=6;m++)
{

var sur1 =  document.forms[0].txt_amount1[m].value;
var sur2=document.forms[0].txt_margin1[m].value;
 
      if(sur1=="")
		{
			sur1=0.00;
			
		}
		if(sur2=="")
		{
			sur2=0.00;
			
		}
 
  document.forms[0].txt_loanamount1[m].value= Math.round(eval(sur1)-eval(sur2));
  roundtxt(document.forms[0].txt_loanamount1[m]);
 	  
   if(eval(document.forms[0].txt_loanamount1[m].value)<0)
  {
 document.forms[0].txt_loanamount1[m].value=0;
  } 
  if(document.forms[0].txt_loanamount1[m].value=="NaN")
	{
	document.forms[0].txt_loanamount1[m].value= "0" ;
	}
}

}
function calculateTotal()
{
var loanamount1=document.forms[0].txt_totloanamount.value;
var loanamount2=document.forms[0].txt_totloanamount1.value;
var amount1=document.forms[0].txt_totamount.value;
var amount2=document.forms[0].txt_totamount1.value;
var margin1=document.forms[0].txt_totmargin.value;
var margin2=document.forms[0].txt_totmargin1.value;

 if(loanamount1=="")
		{
		loanamount1=0.00;
			
		}
		if(loanamount2=="")
		{
			loanamount2=0.00;
			
		}
		 if(amount1=="")
		{
		amount1=0.00;
			
		}
		if(amount2=="")
		{
			amount2=0.00;
			
		}
		 if(margin1=="")
		{
		margin1=0.00;
			
		}
		if(margin2=="")
		{
			margin2=0.00;
			
		}
	document.forms[0].txt_totalloanamount.value=eval(loanamount1)+eval(loanamount2);
	roundtxt(document.forms[0].txt_totalloanamount);
	document.forms[0].txt_totalamount.value=eval(amount1)+eval(amount2);	
	roundtxt(document.forms[0].txt_totalamount);
	document.forms[0].txt_totalmargin.value=eval(margin1)+eval(margin2);	
	roundtxt(document.forms[0].txt_totalmargin);	
}