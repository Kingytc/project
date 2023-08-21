<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
ArrayList arryCol= new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow=(ArrayList)hshValues.get("arryRow");


if(arryRow == null)
{
	arryRow = new ArrayList();
}
String l1="",l2="",l3="",l4="",m1="",m2="";
String f1="",f2="",f3="",f4="";String rr1="",rr2="";
String p1 = "",p2="",p3="";
String p4 = "";
String r1 = "",r2="",r3="";
String r4 = "";
String d1 = "",d2="";
String e1 = "",e2="";
String o1 = "",o2="";
String w1 = "",w2="";
String s1 = "",s2="";
String year1="", year2="";
//String measurement=Helper.correctNull((String)hshValues.get("centGunt"));
String totseason1="",totseason2="",totseason3="",totseason4=""; 
%>
<html>
<head>
<title>LAPS Coffee Hypothecation</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var varApptype=new Array();
var varAcctype=new Array();
var varAcctype1=new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
var measurement = "<%=Helper.correctNull((String)hshValues.get("centGunt"))%>";



function enableButtons( bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function chkcentgunt() 
{
  if(document.forms[0].land_measurement.value == 'g')
		{
    for(var j=0;j<=1;j++)
     {
     var guntas = document.forms[0].txt_guntas[j].value;
		
			if(eval(guntas) > 39)
			{
			 alert("The Data you entered is not valid");
			document.forms[0].txt_guntas[j].value="";
		    document.forms[0].txt_guntas[j].focus();
	         return;
			}
		}
	}	 
}
function check()
{
   var acreageval;var areaval;
   var acreval;
    for(var m=0;m<2;m++)
     {
	 areaval=document.forms[0].txt_area[m].value;
	acreval=document.forms[0].txt_guntas[m].value;
	
	var meas=document.forms[0].land_measurement.value;
	if(areaval=="")
	{
		areaval=0;
	}
	if(acreval=="")
	{
		acreval=0;
	}
	if(meas=="g")
	{
		if(acreval.length==1)
		{
		 	acreageval= areaval+".0"+acreval;
		}
		else
		{
		
			acreageval= areaval+"."+acreval;
		}
	}
	if(meas=="c")
	{
	 	if(acreval.length==1)
		{
	 		acreageval= areaval+".0"+acreval;
		}
		else
		{
	 		acreageval= areaval+"."+acreval;
		}
	}
	document.forms[0].txt_total_area1[m].value=acreageval;
		}
	calculate();callTotal();
}

function callparach()
	  {
var totalvalue1=0.00;var totalvalue2=0.00;var totalvalue3=0.00;
 var totalvalue4=0.00; var totalvalue5=0.00;
for(var m=0;m<=3;m++)
     {
    var value1 =  document.forms[0].txt_totseason[m].value;
      if( value1 =="")
		{
			 value1 =0.00;
			
		}
	totalvalue1 = eval(value1)+eval(totalvalue1)
	
	var value2 =  document.forms[0].txt_item[m].value;
      if( value2 =="")
		{
			 value2 =0.00;
			
		}
	totalvalue2= eval(value2)+eval(totalvalue2)	
	
	var value3 =  document.forms[0].txt_cherry1[m].value;
      if( value3 =="")
		{
			 value3 =0.00;
			
		}
	totalvalue3= eval(value3)+eval(totalvalue3)	
	
	var value4 =  document.forms[0].txt_item1[m].value;
      if( value4 =="")
		{
			 value4 =0.00;
			
		}
	totalvalue4= eval(value4)+eval(totalvalue4)	
	var value5 =  document.forms[0].txt_cherry2[m].value;
      if( value5 =="")
		{
			 value5 =0.00;
			
		}
	totalvalue5= eval(value5)+eval(totalvalue5)					
     }
   document.forms[0].txt_totvalue.value= eval(totalvalue1);
   document.forms[0].txt_paracharb.value= eval(totalvalue2);
   document.forms[0].txt_cherryarb.value= eval(totalvalue3);
   document.forms[0].txt_parachrob.value= eval(totalvalue4);
   document.forms[0].txt_cherryrob.value= eval(totalvalue5);
   roundtxt(document.forms[0].txt_totvalue);
       }
      

function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appUrl+"action/retailpge.jsp";	
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
	calculateTotal();callTotal();callparach();
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="/action/agrcoffeehypo.jsp";
	document.forms[0].hidBeanMethod.value="updatecoffeehypo";
	document.forms[0].hidBeanGetMethod.value="getcoffeehypo";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}



function doEdit()
{
 	disableFields(false);
 	document.forms[0].txt_item2.readOnly=true;
 	document.forms[0].txt_totcost.readOnly=true;
 	document.forms[0].txt_total_area.readOnly=true;
 	document.forms[0].txt_totother.readOnly=true;
 	document.forms[0].txt_totother2.readOnly=true;
 	document.forms[0].txt_totother1[0].readOnly=true;
 	document.forms[0].txt_totother1[1].readOnly=true;
 	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, true);	
}

function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 


function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getcoffeehypo";
		document.forms[0].action=appUrl+"action/agrcoffeehypo.jsp";
		document.forms[0].submit(); 		
	}
	
}

function doDelete()
{
    if( ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatecoffeehypo";
	document.forms[0].hidBeanGetMethod.value="getcoffeehypo";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="action/agrcoffeehypo.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}


	
function onloading()
{	  
	disableFields(true);
	check();calculate();
}

function calculateTotal()
{
	var totalvalue=0.00;
	var totalvalue1=0.00;var totalvalue2=0.00;
	var totalvalue3=0.00;var totalvalue4=0.00;
	var totalvalue5=0.00;var totalvalue6=0.00;
	var str1;
	var measurement= document.forms[0].measurement.value;
	var str, i1, guntremain,guntval;
	var bool=0;
	for(var i=0;i<2;i++)
	{
       var value1 =  document.forms[0].txt_wage[i].value;
		var value2=document.forms[0].txt_other[i].value;
         var value3 =  document.forms[0].txt_totother1[i].value;
      	var value5 =  document.forms[0].txt_cost[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
               if(value3=="")
		{
			value3=0.00;
		}
		
              if(value5=="")
		{
			value5=0.00;
		}
      	totalvalue = eval(value1)+eval(totalvalue)
		totalvalue1 = eval(value2)+eval(totalvalue1)
        totalvalue2 = eval(value3)+eval(totalvalue2)
		 totalvalue4 = eval(value5)+eval(totalvalue4)
	}
	document.forms[0].txt_totwage.value= totalvalue;
	document.forms[0].txt_totother.value= totalvalue1;
    document.forms[0].txt_totother2.value= totalvalue2;

	 document.forms[0].txt_totcost.value= totalvalue4;
 }
function calculate()
{
	var measurementtype=document.forms[0].land_measurement.value;
	var txt_total_area=document.forms[0].txt_total_area.value;	
	if(txt_total_area=="")
	{
		txt_total_area =0.00;
	}
	var totalvalue1=0.00;	var totalvalue2=0.00;		
	for(var m=0;m<2;m++)
	{
		var value1 =  document.forms[0].txt_guntas[m].value;
	    if( value1 =="")
		{
			value1 =0.;
		}
		var value2= document.forms[0].txt_area[m].value;
		if( value2 =="")
		{
			value2 =0;
		}
		totalvalue1 = eval(value1)+eval(totalvalue1)
		totalvalue2 = eval(value2)+eval(totalvalue2)
	}
    document.forms[0].txt_total_area.value= eval(totalvalue1);
 	document.forms[0].txt_total_area2.value= eval(totalvalue2);
   	document.forms[0].txt_total_area.value=totalvalue2+"."+totalvalue1;
   	if(measurementtype == 'c')
    {
   		var total_value1=document.forms[0].txt_total_area.value;
		var len2 =total_value1.length;
   		var g=0;
  		for(var t=0;t<=len2;t++)
  		{
	  		if((total_value1.charAt(t)=="."))
	  		{
	     		g  =  total_value1.indexOf(".");
	     		acre = total_value1.substring(0,g);
	     		centgunt = total_value1.substring(g+1,len2);
	     		centgunt = centgunt.substring(0,2);
	     		document.forms[0].txt_total_area.value=acre+"."+centgunt;	
	     	}
  		}
  	}
  	if(measurementtype == 'g')
	{
          		var centgunt2="";var len3="";
    			var total_value2=document.forms[0].txt_total_area.value;
				len3 =total_value2.length;
    			var g1=0;
   				var acre1=0;var cent_gunt="";
   				var count = 0;
   				var centgunt1=0;
   				
  				for(var t1=0;t1<=len3;t1++){
  			    
  				if((total_value2.charAt(t1)=="."))
  				 {
  				  
     				g1  =  total_value2.indexOf(".");
     				acre1 = total_value2.substring(0,g1);
     				if(len3>3)
     				{
     				centgunt1 = total_value2.substring(g1+1,5);
					
     				}
     				else{
     				centgunt1 = total_value2.substring(g1+1,len3);
     				
     				}
                  				
     			 }
     				while(centgunt1 >= 40)
     				{
     				   
     				 	centgunt1 = centgunt1 - 40;
     				 		count = count + 1;
     	 		     centgunt1 = "0"+centgunt1;
				 	if((centgunt1.length)>2){
     				centgunt1=centgunt1.substring(1,centgunt1.length);
     				}
     				}
     			    
   			  		 
     		      }
     		       acre1 = eval(acre1) + eval(count);
     		       if(eval(count)>0)
   			       {
   			        
   			     document.forms[0].txt_total_area.value=acre1+"."+centgunt1;
   			     }
     			 
     		  	 }
   				 
 
 
}
function chkVal(obj)
{
	
	
}

 function callTotal()
	  {
	     var totalvalue11=0.00;var tot33=0.00;
	     var totalvalue21=0.00; var totalval1=0.00;
	     var totalval2=0.00; var totalval3=0.00;
	     var totalval4=0.00; var totalval5=0.00;
	     var totalval6=0.00;
		  var value11 =  document.forms[0].txt_wage[0].value;
		 var value21=document.forms[0].txt_other[0].value;
		 var value33 =  document.forms[0].txt_fer[0].value;
		 if(value11=="")
		{
			value11=0.00;
		}
		if(value21=="")
		{
			value21=0.00;
		}
		if(value33=="")
		{
			value33=0.00;
		}
		 var val1 =  document.forms[0].txt_wage[1].value;
		 var val2=document.forms[0].txt_other[1].value;
		 if(val2=="")
		{
			val2=0.00;
		}
		if(val1=="")
		{
			val1=0.00;
		}
	
		totalvalue11 = eval(value11)+eval(totalvalue11)
		totalvalue21 = eval(value21)+eval(totalvalue21)
		tot33=eval(value33)+eval(tot33)
		totalval1 = eval(val1)+eval(totalval1)
		totalval2 = eval(val2)+eval(totalval2)
		
          document.forms[0].txt_totother1[0].value= totalvalue11+totalvalue21+tot33; 
		   document.forms[0].txt_totother1[1].value= totalval1+totalval2; 
	    
       }
      
function caltotCost()
{
var str3,str2,str1,str;
var i;
var measurementtype = document.forms[0].measurement.value;
var guntarate ="";
var acrerate = "";
var totalrate = 0;


for(var j=0;j<=1;j++)
   {
    var area = document.forms[0].txt_total_area1[j].value;
   
   var totalval1=0.00;
   var totalval2=0.00;
   var val2=document.forms[0].txt_totother1[j].value;
    
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
      

	
	if(measurementtype == 'g')
   {
     	guntarate = val2 / 40;
  		guntarate = str * guntarate;
  		acrerate = 	str1* val2; 
  		totalrate = acrerate + guntarate;
  		
   }
   if(measurementtype == 'c')
   {
  		
  		totalrate = eval(area) * eval(val2);
  		
   }
	
	document.forms[0].txt_cost[j].value= totalrate ;
	if(document.forms[0].txt_cost[j].value=="NaN")
	{
	document.forms[0].txt_cost[j].value= "0" ;
	}
	
  }
  
}	  
	  
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onLoad="onloading();callTotal();calculateTotal();callparach()">
<form name="frmpri" method=post>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="50%"> <table width="100%" border="0" cellspacing="0" cellpadding="3"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
          <tr> </tr>
          <tr> 
		     <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(0);
	                   
						if(arryCol.size()!=0)
						{

						 l1=Helper.correctNull((String)arryCol.get(2)); 
						f1=Helper.correctNull((String)arryCol.get(3));
					    p1=Helper.correctNull((String)arryCol.get(4));
					    r1=Helper.correctNull((String)arryCol.get(5));
						totseason1=Helper.correctNull((String)arryCol.get(6));
						year1=Helper.correctNull((String)arryCol.get(14));
					    year2=Helper.correctNull((String)arryCol.get(15));
						
						}
					}
                   
                  
                    else if(arryRow.size()==0){
                        w1="";
                    	o1="";
						d1="";
						e1="";
						
                    }
                    
                    %>
            <td> <table width="100%" border="0" cellspacing="0" cellpadding="4" height="" class="outertable border1">
                <tr> 
                  <td colspan="5" bgcolor="#71694F" ><b><font  color="#FFFFFF">Particulars 
                    of coffee Hypothecation Loan Required</font></b></td>
                </tr>
                <tr> 
                  <td colspan="5" bgcolor="#71694F" align="center" ><b><font  color="#FFFFFF">Estimated 
                    Crop for 20 
                    <input type="text" name="txt_year1" size="2"  maxlength="2" value="<%=year1%>"
												onKeyPress="allowNumber(this)" style="border:0;text-align:left" >
                    - 20 
                    <input type="text" name="txt_year2" size="2"  maxlength="2" value="<%=year2%>"
												onKeyPress="allowNumber(this)" style="border:0;text-align:left" >
                    seasons(in tones) on spikes/blossom/berryset</font></b></td>
                </tr>
                <tr> 
                  <td height="0" colspan="2" align="center" bgcolor="#71694F"><b><font  color="#FFFFFF">Arabica</font></b></td>
                  <td height="0" colspan="2" align="center" bgcolor="#71694F"><b><font  color="#FFFFFF">Robusta</font></b></td>
                  <td bgcolor="#71694F" align="center" nowrap><b><font  color="#FFFFFF">Estimated 
                    Value (Rs.)</font></b></td>
                </tr>
                <tr> 
                  <td height="0" width="20%" bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">Parachment</font></b></td>
                  <td height="0" width="27%" bgcolor="#71694F" align="center"> 
                    <b><font  color="#FFFFFF">Cherry</font></b></td>
                  <td height="0" width="24%" bgcolor="#71694F" align="center"> 
                    <b><font  color="#FFFFFF">Parachment</font></b></td>
                  <td height="0" width="29%" bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">Cherry</font></b></td>
                  <td width="29%" bgcolor="#71694F" align="center"><b><font  color="#FFFFFF">Total</font></b></td>
                </tr>
                <tr> 
                  <td nowrap width="20%"> <div align="center"> 
                      <input type="text" name="txt_item" size="25"  maxlength="40" value="<%=l1%>"
												onKeyPress="allowNumber(this)"  onBlur="callparach()">
                    </div></td>
                  <td nowrap width="27%"> <div align="center"> 
                      <input type="text" name="txt_cherry1" size="25" maxlength="40" value="<%=f1%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="24%"> <div align="center"> 
                      <input type="text" name="txt_item1" size="25" maxlength="50" value="<%=p1%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="29%"> <div align="center"> 
                      <input type="text" name="txt_cherry2" size="25"  maxlength="50" value="<%=r1%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="29%" align="center"><lapschoice:CurrencyTag name="txt_totseason" size="20"  maxlength="10" value='<%=totseason1%>'
												 onBlur="callparach()"/></td>
                </tr>
                <tr> 
                  <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(1);
	                   

						if(arryCol.size()!=0)
						{

						 l2=Helper.correctNull((String)arryCol.get(2)); 
						f2=Helper.correctNull((String)arryCol.get(3));
					    p2=Helper.correctNull((String)arryCol.get(4));
					    r2=Helper.correctNull((String)arryCol.get(5));
						totseason2=Helper.correctNull((String)arryCol.get(6));
					  
					}
                   
                   } 
                    else if(arryRow.size()==0){
                        w2="";
                    	o2="";
                    	d2="";
                    	e2="";
                    		
                    }
                    
                    %>
                  <td nowrap width="20%"> <div align="center"> 
                      <input type="text" name="txt_item" size="25"  maxlength="40" value="<%=l2%>"
												onKeyPress="allowNumber(this)" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="27%"> <div align="center"> 
                      <input type="text" name="txt_cherry1" size="25"  maxlength="40" value="<%=f2%>"
												onKeyPress="allowNumber(this)" onBlur="callparach()" >
</div></td> 
                  <td nowrap width="24%"> <div align="center"> 
                      <input type="text" name="txt_item1" size="25"  maxlength="50" value="<%=p2%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="29%"> <div align="center"> 
                      <input type="text" name="txt_cherry2" size="25"  maxlength="50" value="<%=r2%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="29%" align="center"><lapschoice:CurrencyTag name="txt_totseason" size="20"  maxlength="10" value='<%=totseason2%>'
												  onBlur="callparach()"/></td>
                </tr>
                <tr> 
                  <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(2);
	                   
						if(arryCol.size()!=0)
						{

						l3=Helper.correctNull((String)arryCol.get(2)); 
						f3=Helper.correctNull((String)arryCol.get(3));
					    p3=Helper.correctNull((String)arryCol.get(4));
					    r3=Helper.correctNull((String)arryCol.get(5));
						totseason3=Helper.correctNull((String)arryCol.get(6));
						
					}
                   
                   } 
                    else if(arryRow.size()==0){
                     f3="";p3="";r3="";
                    	
                    }
                    
                    %>
                  <td nowrap width="20%"> <div align="center"> 
                      <input type="text" name="txt_item" size="25"  maxlength="40" value="<%=l3%>"
												onKeyPress="allowNumber(this)" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="27%"> <div align="center"> 
                      <input type="text" name="txt_cherry1" size="25"  maxlength="40" value="<%=f3%>"
												onKeyPress="allowNumber(this)"style="text-align:left" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="24%"> <div align="center"> 
                      <input type="text" name="txt_item1" size="25"  maxlength="50" value="<%=p3%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="29%"> <div align="center"> 
                      <input type="text" name="txt_cherry2" size="25"  maxlength="50" value="<%=r3%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap width="29%" align="center"><lapschoice:CurrencyTag name="txt_totseason" size="20"  maxlength="10" value='<%=totseason3%>'
												 onBlur="callparach()"/></td>
                </tr>
                <tr> 
                  <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(3);
	                   
						if(arryCol.size()!=0)
						{

						l4=Helper.correctNull((String)arryCol.get(2)); 
						f4=Helper.correctNull((String)arryCol.get(3));
					    p4=Helper.correctNull((String)arryCol.get(4));
					    r4=Helper.correctNull((String)arryCol.get(5));
						totseason4=Helper.correctNull((String)arryCol.get(6));
					
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    
                    	 	
                    }
                    
                    %>
                  <td nowrap id="r6" width="20%" height="31"> <div align="center"> 
                      <input type="text" name="txt_item" size="25"  maxlength="40" value="<%=l4%>"
												onKeyPress="allowNumber(this)" onBlur="callparach()">
                    </div></td>
                  <td nowrap id="r6" width="27%" height="31"> <div align="center"> 
                      <input type="text" name="txt_cherry1" size="25"  maxlength="50" value="<%=f4%>"
												onKeyPress="allowNumber(this)"style="text-align:left;"  onBlur="callparach()">
                    </div></td>
                  <td nowrap id="r6" width="24%" height="31"> <div align="center"> 
                      <input type="text" name="txt_item1" size="25"  maxlength="50" value="<%=p4%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()" >
                    </div></td>
                  <td nowrap id="r6" width="29%" height="31"> <div align="center"> 
                      <input type="text" name="txt_cherry2" size="25"  maxlength="50" value="<%=r4%>"
												onKeyPress="allowNumber(this)"style="text-align:left;" onBlur="callparach()">
                    </div></td>
                  <td nowrap id="r6" width="29%" align="center"><lapschoice:CurrencyTag name="txt_totseason" size="20"  maxlength="10" value='<%=totseason4%>'
												 onBlur="callparach()"/></td>
                </tr>
                <tr  bgcolor="#71694F">
                  <td height="32" align="center" nowrap id="r6">
<input type="text" name="txt_paracharb" size="25"  maxlength="50" value=""
												onKeyPress="notAllowSingleQuote()" style="border:0"></td>
                  <td nowrap id="r6" align="center"><input type="text" name="txt_cherryarb" size="25"  maxlength="50" value=""
												onKeyPress="notAllowSingleQuote()" style="border:0"></td>
                  <td nowrap id="r6" align="center"><input type="text" name="txt_parachrob" size="25"  maxlength="50" value=""
												onKeyPress="notAllowSingleQuote()" style="border:0"></td>
                  <td nowrap id="r6" align="center"><input type="text" name="txt_cherryrob" size="25"  maxlength="50" value=""
												onKeyPress="notAllowSingleQuote()" style="border:0"></td>
                  <td nowrap id="r6" align="center"><lapschoice:CurrencyTag name="txt_totvalue" size="25"  maxlength="10" value=''
												 style="border:0"/></td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(4);
	                   
						if(arryCol.size()!=0)
						{

						m1=Helper.correctNull((String)arryCol.get(8)); 
						w1=Helper.correctNull((String)arryCol.get(9));
					    o1=Helper.correctNull((String)arryCol.get(10));
					    s1=Helper.correctNull((String)arryCol.get(11));
						d1=Helper.correctNull((String)arryCol.get(12));
						e1=Helper.correctNull((String)arryCol.get(13));
					    rr1=Helper.correctNull((String)arryCol.get(16));
					
					
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    m1="";w1="";o1="";s1="";d1="";e1="";rr1="";
                    	 	
                    }
                    
                    %>
                  <td width="13%" align="center" > <div align="center"> 
                      <input type="hidden" name="txt_item2" size="20"  maxlength="50" value="Bearing"
												onKeyPress="notAllowSingleQuote()" style="text-align:left;border:0" readOnly>
                    </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_fer" size="20"  maxlength="50" value="<%=m1%>"
												onKeyPress="allowNumber(this)" style="border:0">
                    </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_wage" size="20"  maxlength="50" value="<%=w1%>"
												onKeyPress="allowNumber(this)" onBlur="calculateTotal();callTotal()" style="border:0;text-align:right">
                    </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_other" size="20"  maxlength="50" value="<%=o1%>"
												onKeyPress="allowNumber(this)" onBlur="calculateTotal();callTotal()" style="border:0;text-align:right">
                    </div></td>
                  <td width="13%" align="center"> <input type="hidden" name="txt_totother1" size="20"  maxlength="50" value="<%=s1%>"
												onKeyPress="allowNumber(this)" onBlur="caltotCost()" style="border:0;text-align:right" readOnly> 
                  </td>
                  <td width="8%"> <div align="center"><b> 
                      <input type="hidden" name="txt_area" size="20"  maxlength="50" value="<%=d1%>"
												onKeyPress="" style="border:0;text-align:right" onBlur="chkcentgunt();check(); caltotCost()">
                      </b> </div></td>
                  <td width="8%"><input type="hidden" name="txt_guntas" size="20"  maxlength="50" value="<%=rr1%>"
												onKeyPress="" style="border:0;text-align:right" onBlur="chkcentgunt();check(); caltotCost()" > 
                    <input type="hidden" name="txt_total_area1" value="" onBlur="caltotCost()"></td>
                  <td width="19%"> <div align="center"> 
                      <input type="hidden" name="txt_cost" size="20"  maxlength="50" value="<%=e1%>"
												onKeyPress="allowNumber(this)" onBlur="calculateTotal()" style="border:0;text-align:right">
                    </div></td>
                </tr>
                <tr> 
                  <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(5);
	                   
						if(arryCol.size()!=0)
						{

						m2=Helper.correctNull((String)arryCol.get(8)); 
						w2=Helper.correctNull((String)arryCol.get(9));
					    o2=Helper.correctNull((String)arryCol.get(10));
					    s2=Helper.correctNull((String)arryCol.get(11));
						d2=Helper.correctNull((String)arryCol.get(12));
						e2=Helper.correctNull((String)arryCol.get(13));
					    rr2=Helper.correctNull((String)arryCol.get(16));
					    
					
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    m2="";w2="";o2="";s2="";d2="";e2="";
                    	 	
                    }
                    
                    %>
                  <td width="13%" align="center" > <div align="center"> 
                      <input type="hidden" name="txt_item2" size="20"  maxlength="50" value="Non-Bearing"
												onKeyPress="notAllowSingleQuote()"  style="border:0" readOnly>
                    </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_fer" size="20"  maxlength="50" value="<%=m2%>"
												onKeyPress="allowNumber(this)" style="border:0">
                    </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_wage" size="20"  maxlength="50" value="<%=w2%>"
												onKeyPress="allowNumber(this)" onBlur="calculateTotal();callTotal()" style="border:0;text-align:right">
                    </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_other" size="20"  maxlength="50" value="<%=o2%>"
												onKeyPress="allowNumber(this)" onBlur="calculateTotal();callTotal()" style="border:0;text-align:right">
                    </div></td>
                  <td width="13%" align="center"> <input type="hidden" name="txt_totother1" size="20"  maxlength="50" value="<%=s2%>"
												onKeyPress="allowNumber(this)" onBlur="caltotCost()" style="border:0;text-align:right" readOnly> 
                  </td>
                  <td> <div align="center"> 
                      <input type="hidden" name="txt_area" size="20"  maxlength="50" value="<%=d2%>"
												onKeyPress="" style="border:0;text-align:right" onBlur="chkcentgunt();check(); caltotCost()" >
                    </div></td>
                  <td><input type="hidden" name="txt_guntas" size="20"  maxlength="50" value="<%=rr2%>"
												onKeyPress="" style="border:0;text-align:right" onBlur="chkcentgunt();check(); caltotCost()"> 
                    <input type="hidden" name="txt_total_area1" value="" onBlur="caltotCost()"></td>
                  <td width="19%"> <div align="center"> 
                      <input type="hidden" name="txt_cost" size="20"  maxlength="50" value="<%=e2%>"
												onKeyPress="allowNumber(this)" onBlur="calculateTotal()" style="border:0;text-align:right">
                    </div></td>
                </tr>
                <tr  > 
                  <td width="13%"><b><font size="2" face="MS Sans Serif" color="#FFFFFF"></font></b></td>
                  <td width="13%"> <div align="center"> </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_totwage" size="20"  maxlength="50" value=""
												onKeyPress="" style="border:0;text-align:right" readOnly>
                    </div></td>
                  <td width="13%"> <div align="center"> 
                      <input type="hidden" name="txt_totother" size="20"  maxlength="50" value=""
												onKeyPress="" style="border:0;text-align:right" readOnly>
                    </div></td>
                  <td width="13%" align="center"> <input type="hidden" name="txt_totother2" size="20"  maxlength="50" value=""
												onKeyPress="" style="border:0;text-align:right" readOnly> 
                  </td>
                  <td colspan="2"> <div align="center"><font	size="2" face="MS Sans Serif" color="#FFFFFF"> 
                      <input type="hidden" name="txt_total_area2"  value=""  size="15%" onKeyPress="allowInteger()" maxlength="" onBlur="">
                      </font> 
                      <input type="hidden" name="txt_total_area" size="20"  maxlength="50" value=""
												onKeyPress="" style="border:0;text-align:right" readOnly>
                    </div></td>
                  <td width="19%"> <div align="center"> 
                      <input type="hidden" name="txt_totcost" size="20"  maxlength="50" value=""
												onKeyPress="" style="border:0;text-align:right" readOnly>
                    </div></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
  
 <lapschoice:combutton btntype="EO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  

  </table>
<lapschoice:agrihiddentag />
</form>
</body>
</html>
