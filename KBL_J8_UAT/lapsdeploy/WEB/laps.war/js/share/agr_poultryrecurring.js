function margin1()
{

var marginper=document.forms[0].txt_marginper.value;
 if(marginper=="")
		{
	marginper=0;
	document.forms[0].txt_marginper.value="0";		
		}
document.forms[0].txt_marginper.value=eval(marginper);
roundtxt(document.forms[0].txt_marginper);
document.forms[0].txt_marginper1.value=eval(marginper);
roundtxt(document.forms[0].txt_marginper1);
var num=(marginper)/100;
var num1="";var str1="";
var amount="";
var str=num.toFixed(2);

for(var m=0;m<=4;m++)
{

var amountval=document.forms[0].txt_amount1[m].value;
 if(amountval=="")
		{
	amountval=0;
			
		}

 amount=eval(str)*eval(amountval);
document.forms[0].txt_margin1[m].value=eval(amount);	
roundtxt(document.forms[0].txt_margin1[m]);
 num1=(amount);
 str1=num1.toFixed(2);
document.forms[0].txt_margin1[m].value=Math.round(eval(str1));
roundtxt(document.forms[0].txt_margin1[m]);	
}
}

function amount1()
{
margin1();


}


function callTotal1()
{
amount1();callSurplus1();
var totalvalue1=0.00;var totalvalue2=0.00;var totalvalue3=0.00;
for(var m=0;m<=4;m++)
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
   roundtxt(document.forms[0].txt_totmargin1);
   document.forms[0].txt_totloanamount1.value= Math.round(eval(str3));
   roundtxt(document.forms[0].txt_totloanamount1);
   calculateTotal();
}
function callSurplus1()
{
var i;

for(var m=0;m<=4;m++)
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
 var totalamount1=eval(amount1)+eval(amount2);
var totalmargin1=eval(margin1)+eval(margin2);
var totalloanamount1=eval(loanamount1)+eval(loanamount2);
var totalamount2=document.forms[0].txt_totalamount1.value;
var totalmargin2=document.forms[0].txt_totalmargin1.value;
var totalloanamount2=document.forms[0].txt_totalloanamount1.value;	
document.forms[0].txt_totalloanamount2.value=NanNumber(eval(totalloanamount1)+eval(totalloanamount2));
roundtxt(document.forms[0].txt_totalloanamount2);
document.forms[0].txt_totalamount2.value=NanNumber(eval(totalamount1)+eval(totalamount2));	
roundtxt(document.forms[0].txt_totalamount2);
document.forms[0].txt_totalmargin2.value=NanNumber(eval(totalmargin1)+eval(totalmargin2));
roundtxt(document.forms[0].txt_totalmargin2);	
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
