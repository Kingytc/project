function doSave()
{	
	enableButtons( true, true, true, false);
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="/action/agr_coffeeassesment.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeeassesment";
	document.forms[0].hidBeanGetMethod.value="getcoffeeassesment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatecoffeeassesment";
	document.forms[0].hidBeanGetMethod.value="getcoffeeassesment";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].hidSourceUrl.value="action/agr_coffeeassesment.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}

function doEdit()
{
	disablefields(true);
	document.forms[0].txt_bearingarbval.readOnly=false;
	document.forms[0].txt_bearingrobval.readOnly=false;
	document.forms[0].txt_nonbearingarbval.readOnly=false;
	document.forms[0].txt_nonbearingrobval.readOnly=false;
	document.forms[0].txt_cost1.readOnly=false;
	document.forms[0].txt_cost2.readOnly=false;
	document.forms[0].txt_cost3.readOnly=false;
	document.forms[0].txt_cost4.readOnly=false;
	document.forms[0].txt_loanamount.readOnly=false;
	document.forms[0].cmdapply.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
	
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appUrl+"action/perborrowersearch.jsp?hidPageType=EXI";	
		document.forms[0].submit();
	}
}
function doCancel()
{
	document.forms[0].action=appURL+"action/agr_coffeeassesment.jsp";		
	document.forms[0].hidBeanGetMethod.value="getcoffeeassesment";
	document.forms[0].hidBeanId.value="agrcoffee";
	document.forms[0].submit();		
}
function onloading()
{	  
	if(checkSetUpData=="")
	{
		alert("Setup is not defined");
	}
	disablefields(true);
	callcost1();
	callcost2();
	callcost3();
	callcost4();
}
function disablefields(one)
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

function enableButtons( bool2, bool3, bool4,bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool6;
}
function callAverage()
{
var txt_parachmentarb=document.forms[0].txt_parachmentarb.value;
if(eval(txt_parachmentarb)=="")
{
txt_parachmentarb="0";
}
var txt_cherryarb=document.forms[0].txt_cherryarb.value;
if(eval(txt_cherryarb)=="")
{
txt_cherryarb="0";
}
var txt_parachmentrob=document.forms[0].txt_parachmentrob.value;
if(eval(txt_parachmentrob)=="")
{
txt_parachmentrob="0";
}
var txt_cherryrob=document.forms[0].txt_cherryrob.value;
if(eval(txt_cherryrob)=="")
{
txt_cherryrob="0";
}

var txt_parachmentarbval=document.forms[0].txt_parachmentarbval.value;
if(eval(txt_parachmentarbval)=="")
{
txt_parachmentarbval="0";
}
var txt_cherryarbval=document.forms[0].txt_cherryarbval.value;
if(eval(txt_cherryarbval)=="")
{
txt_cherryarbval="0";
}
var txt_parachmentrobval=document.forms[0].txt_parachmentrobval.value;
if(eval(txt_parachmentrobval)=="")
{
txt_parachmentrobval="0";
}
var txt_cherryrobval=document.forms[0].txt_cherryrobval.value;
if(eval(txt_cherryrobval)=="")
{
txt_cherryrobval="0";
}
document.forms[0].txt_totparachmentarbval.value=Math.round(eval(txt_parachmentarb)*eval(txt_parachmentarbval));
var val1=document.forms[0].txt_totparachmentarbval.value;
document.forms[0].txt_totcherryarbval.value=Math.round(eval(txt_cherryarb)*eval(txt_cherryarbval));
var val2=document.forms[0].txt_totcherryarbval.value;
document.forms[0].txt_totparachmentrobval.value=Math.round(eval(txt_parachmentrob)*eval(txt_parachmentrobval));
var val3=document.forms[0].txt_totparachmentrobval.value;
document.forms[0].txt_totcherryrobval.value=Math.round(eval(txt_cherryrob)*eval(txt_cherryrobval));
var val4=document.forms[0].txt_totcherryrobval.value;
 if (document.forms[0].txt_totparachmentarbval.value=="NaN")
		{
		document.forms[0].txt_totparachmentarbval.value="0";
		}
		 if (document.forms[0].txt_totparachmentrobval.value=="NaN")
		{
		document.forms[0].txt_totparachmentrobval.value="0";
		}
		 if (document.forms[0].txt_totcherryrobval.value=="NaN")
		{
		document.forms[0].txt_totcherryrobval.value="0";
		}
		 if (document.forms[0].txt_totcherryarbval.value=="NaN")
		{
		document.forms[0].txt_totcherryarbval.value="0";
		}
   document.forms[0].txt_averageval.value=eval(val1)+eval(val2)+eval(val3)+eval(val4);
   var total=document.forms[0].txt_averageval.value;
 if (document.forms[0].txt_averageval.value=="NaN")
		{
		document.forms[0].txt_averageval.value="0";
		}
	var totalval=0.75*eval(total);
   var num=totalval;
   var str=num.toFixed(2);
   document.forms[0].txt_averagevalper.value=eval(str);
   if (document.forms[0].txt_averagevalper.value=="NaN")
		{
		document.forms[0].txt_averagevalper.value="0";
		}
}

function callAverage1()
{
var txtparachmentarb=document.forms[0].txtparachmentarb.value;
if(eval(txtparachmentarb)=="")
{
txtparachmentarb="0";
}
var txtcherryarb=document.forms[0].txtcherryarb.value;
if(eval(txtcherryarb)=="")
{
txtcherryarb="0";
}
var txtparachmentrob=document.forms[0].txtparachmentrob.value;
if(eval(txtparachmentrob)=="")
{
txtparachmentrob="0";
}
var txtcherryrob=document.forms[0].txtcherryrob.value;
if(eval(txtcherryrob)=="")
{
txtcherryrob="0";
}

var txtparachmentarbval=document.forms[0].txtparachmentarbval.value;
if(eval(txtparachmentarbval)=="")
{
txtparachmentarbval="0";
}
var txtcherryarbval=document.forms[0].txtcherryarbval.value;
if(eval(txtcherryarbval)=="")
{
txtcherryarbval="0";
}
var txtparachmentrobval=document.forms[0].txtparachmentrobval.value;
if(eval(txtparachmentrobval)=="")
{
txtparachmentrobval="0";
}
var txtcherryrobval=document.forms[0].txtcherryrobval.value;
if(eval(txtcherryrobval)=="")
{
txtcherryrobval="0";
}
document.forms[0].txttotparachmentarbval.value=Math.round(eval(txtparachmentarb)*eval(txtparachmentarbval));
var val1=document.forms[0].txttotparachmentarbval.value;
document.forms[0].txttotcherryarbval.value=Math.round(eval(txtcherryarb)*eval(txtcherryarbval));
var val2=document.forms[0].txttotcherryarbval.value;
document.forms[0].txttotparachmentrobval.value=Math.round(eval(txtparachmentrob)*eval(txtparachmentrobval));
var val3=document.forms[0].txttotparachmentrobval.value;
document.forms[0].txttotcherryrobval.value=Math.round(eval(txtcherryrob)*eval(txtcherryrobval));
var val4=document.forms[0].txttotcherryrobval.value;
 if (document.forms[0].txttotparachmentarbval.value=="NaN")
		{
		document.forms[0].txttotparachmentarbval.value="0";
		}
		 if (document.forms[0].txttotparachmentrobval.value=="NaN")
		{
		document.forms[0].txttotparachmentrobval.value="0";
		}
		 if (document.forms[0].txttotcherryrobval.value=="NaN")
		{
		document.forms[0].txttotcherryrobval.value="0";
		}
		 if (document.forms[0].txttotcherryarbval.value=="NaN")
		{
		document.forms[0].txttotcherryarbval.value="0";
		}
   document.forms[0].txt_estimateval.value=eval(val1)+eval(val2)+eval(val3)+eval(val4);
   var total=document.forms[0].txt_estimateval.value;
 if (document.forms[0].txt_estimateval.value=="NaN")
		{
		document.forms[0].txt_estimateval.value="0";
		}
	var totalval=0.75*eval(total);
   var num=totalval;
   var str=num.toFixed(2);
   document.forms[0].txt_estimatevalper.value=eval(str);
   if (document.forms[0].txt_estimatevalper.value=="NaN")
		{
		document.forms[0].txt_estimatevalper.value="0";
		}
		
}

function show_finance()
{
  	if(document.forms[0].cmdedit.disabled)
	{
    	var action=document.forms[0].hidAction.value;
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	 	var url=appURL +"action/scalefinancemasterlist.jsp?&strfrom=District_Master";
		window.open(url,"",prop);
		
    }
    else
    {
         alert('KINDLY CLICK THE EDIT BUTTON');
    }		
} 
function show_finance1()
{
  	if(document.forms[0].cmdedit.disabled)
	{
    	var action=document.forms[0].hidAction.value;
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	 	var url=appURL+"action/scalefinancemasterlist.jsp?&strfrom=District_Master1";
		window.open(url,"",prop);
		
    }
    else
    {
         alert('KINDLY CLICK THE EDIT BUTTON');
    }		
} 
function show_finance2()
{
  	if(document.forms[0].cmdedit.disabled)
	{
    	var action=document.forms[0].hidAction.value;
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	 	var url=appURL+"action/scalefinancemasterlist.jsp?&strfrom=District_Master2";
		window.open(url,"",prop);
		
    }
    else
    {
         alert('KINDLY CLICK THE EDIT BUTTON');
    }		
} 
function show_finance3()
{
  	if(document.forms[0].cmdedit.disabled)
	{
    	var action=document.forms[0].hidAction.value;
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	 	var url=appURL+"action/scalefinancemasterlist.jsp?&strfrom=District_Master3";
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
var area = document.forms[0].txt_bearingareaarb.value;
var val2=document.forms[0].txt_bearingarbval.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totbearingarbval.value= totalrate ;
	if(document.forms[0].txt_totbearingarbval.value=="NaN")
	{
	document.forms[0].txt_totbearingarbval.value= "0" ;
	}
	

  }
 function callEligibility1()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_nonbearingareaarb.value;
var val2=document.forms[0].txt_nonbearingarbval.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totnonbearingarbval.value= totalrate ;
	if(document.forms[0].txt_totnonbearingarbval.value=="NaN")
	{
	document.forms[0].txt_totnonbearingarbval.value= "0" ;
	}
	

  }
 //
 
 function callEligibility3()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_bearingarearob.value;
var val2=document.forms[0].txt_bearingrobval.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totbearingrobval.value= totalrate ;
	if(document.forms[0].txt_totbearingrobval.value=="NaN")
	{
	document.forms[0].txt_totbearingrobval.value= "0" ;
	}
	

  }
         
         //
 function callEligibility4()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_nonbearingarearob.value;
var val2=document.forms[0].txt_nonbearingrobval.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totnonbearingrobval.value= totalrate ;
	if(document.forms[0].txt_totnonbearingrobval.value=="NaN")
	{
	document.forms[0].txt_totnonbearingrobval.value= "0" ;
	}
	

  }
 function callcost1()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_area1.value;
var val2=document.forms[0].txt_cost1.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totcost1.value=Math.round(totalrate);
	if((document.forms[0].txt_totcost1.value=="NaN")||(document.forms[0].txt_totcost1.value==""))
	{
	document.forms[0].txt_totcost1.value= "0" ;
	}
	

  }    
  function callcost2()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_area2.value;
var val2=document.forms[0].txt_cost2.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totcost2.value=Math.round(totalrate) ;
	if(document.forms[0].txt_totcost2.value=="NaN")
	{
	document.forms[0].txt_totcost2.value= "0" ;
	}
	
  }  
function callcost3()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_area3.value;
var val2=document.forms[0].txt_cost3.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totcost3.value= Math.round(totalrate) ;
	if(document.forms[0].txt_totcost3.value=="NaN")
	{
	document.forms[0].txt_totcost3.value= "0" ;
	}
	
  }   
  function callcost4()
{
var str3,str2,str1,str;
var i;

var guntarate ="";
var acrerate = "";
var totalrate = 0;
var area = document.forms[0].txt_area4.value;
var val2=document.forms[0].txt_cost4.value;

var guntas = document.forms[0].land_measurement.value;
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
   if(guntas== 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_totcost4.value= Math.round(totalrate) ;
	if(document.forms[0].txt_totcost4.value=="NaN")
	{
	document.forms[0].txt_totcost4.value= "0" ;
	}
	
  }  
  function callTotal()
  {
  var value1=document.forms[0].txt_totbearingarbval.value;
  var value2=document.forms[0].txt_totnonbearingarbval.value;
   var value3=document.forms[0].txt_totbearingrobval.value;
  var value4=document.forms[0].txt_totnonbearingrobval.value;
   var cost1=document.forms[0].txt_totcost1.value;
  var cost2=document.forms[0].txt_totcost2.value;
   var cost3=document.forms[0].txt_totcost3.value;
  var cost4=document.forms[0].txt_totcost4.value;
 
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
  if(eval(cost1)=="")
  {
  cost1="0";
  }
  if(eval(cost2)=="")
  {
  cost2="0";
  }
   if(eval(cost3)=="")
  {
  cost3="0";
  }
  if(eval(cost4)=="")
  {
  cost4="0";
  }
  document.forms[0].txt_total1.value=eval(value1)+eval(value2);
  document.forms[0].txt_total2.value=eval(value3)+eval(value4);
   document.forms[0].txt_total3.value=eval(cost1)+eval(cost3);
  document.forms[0].txt_total4.value=eval(cost2)+eval(cost4);
  document.forms[0].txt_totalqualamt.value=eval(value1)+eval(value2)+eval(value3)+eval(value4);
   if(document.forms[0].txt_totalantamt.value=="NaN")
	{
	document.forms[0].txt_totalantamt.value="0";
	}
   if(document.forms[0].txt_total3.value=="NaN")
	{
	document.forms[0].txt_total3.value="0";
	}
	 if(document.forms[0].txt_total4.value=="NaN")
	{
	document.forms[0].txt_total4.value="0";
	}
	 document.forms[0].txt_totalantamt.value=eval(document.forms[0].txt_total3.value)+eval(document.forms[0].txt_total4.value);
	
  }                            
