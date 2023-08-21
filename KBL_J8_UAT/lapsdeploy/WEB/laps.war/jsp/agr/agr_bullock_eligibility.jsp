<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Lease Particulars</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var appUrl = "<%=ApplicationParams.getAppUrl()%>";

var surplus= "<%=Helper.correctNull((String)hshValues.get("surplus"))%>"
var totinc= "<%=Helper.correctNull((String)hshValues.get("totinc"))%>"
var totexp= "<%=Helper.correctNull((String)hshValues.get("totexp"))%>"
var noworkdays= "<%=Helper.correctNull((String)hshValues.get("noworkdays"))%>"
var txt_bullockfeed= "<%=Helper.correctNull((String)hshValues.get("txt_bullockfeed"))%>"
var txt_bullockfeednon= "<%=Helper.correctNull((String)hshValues.get("txt_bullockfeednon"))%>"
var txt_vtaidexpenses= "<%=Helper.correctNull((String)hshValues.get("txt_vtaidexpenses"))%>" 
var txt_insurancebullocks= "<%=Helper.correctNull((String)hshValues.get("txt_insurancebullocks" ))%>" 
var txt_insurancecart= "<%=Helper.correctNull((String)hshValues.get("txt_insurancecart"))%>" 
var txt_specify= "<%=Helper.correctNull((String)hshValues.get("txt_specify"))%>" 
var txt_specifycost = "<%=Helper.correctNull((String)hshValues.get("txt_specifycost"))%>"  //chk
var txt_bullockplough = "<%=Helper.correctNull((String)hshValues.get("txt_bullockplough"))%>" 
var txt_carttransport = "<%=Helper.correctNull((String)hshValues.get("txt_carttransport"))%>" 

function onloading()
{	  
	/*document.forms[0].txt_bullockfeed.value=txt_bullockfeed;
	document.forms[0].txt_vtaidexpenses.value=txt_vtaidexpenses;
	document.forms[0].txt_insurancebullocks.value=txt_insurancebullocks;
	document.forms[0].txt_insurancecart.value=txt_insurancecart;
	document.forms[0].txt_specify.value=txt_specify;
	document.forms[0].txt_specifycost.value=txt_specifycost;
	document.forms[0].txt_bullockplough.value=txt_bullockplough;
	document.forms[0].txt_carttransport.value=txt_carttransport;
	document.forms[0].txt_totalexpenses.value=totexp;
	document.forms[0].txt_totalincome.value=totinc;
	document.forms[0].txt_surplus.value=surplus;
	
	*/
	disableFields(true);
		
}
/*function totalexpenses()
{
  var value1=document.forms[0].txt_bullockfeed.value;
  var value2=document.forms[0].txt_vtaidexpenses.value;
  var value3=document.forms[0].txt_insurancebullocks.value;
  var value4=document.forms[0].txt_insurancecart.value;
  var value5=document.forms[0].txt_specifycost.value;

  
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
		if(value4=="")
		{
			value4=0.00;
			
		}
		if(value5=="")
		{
			value5=0.00;
			
		}
	   
document.forms[0].txt_totalexpenses.value=eval(value1)+eval(value2)+eval(value3)+eval(value4)+eval(value5);

}
function totalincome()
{
  var value1=document.forms[0].txt_bullockplough.value;
  var value2=document.forms[0].txt_carttransport.value;
 
  
       if(value1=="")
		{
			value1=0.00;
			
		}
		if(value2=="")
		{
			value2=0.00;
			
		}
	  
	   
document.forms[0].txt_totalincome.value=eval(value1)+eval(value2);

}
function callsurplus()
{
var val1=document.forms[0].txt_totalincome.value;
var val2=document.forms[0].txt_totalexpenses.value;
if(eval(val1)=="")
{
val1="0";
}
if(eval(val2)=="")
{
val2="0";
}
document.forms[0].txt_surplus.value=eval(val1)-eval(val2);
}*/
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
    enableButtons(true, true, false, false, true, true);
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidBeanGetMethod.value="getBullockEconomic";
	document.forms[0].action=appUrl+"action/agr_bullock_eligibility.jsp";
	document.forms[0].submit();
}
function doEdit()
{
	document.forms[0].hideditflag.value ="edit";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, true, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getBullockEconomic";
		document.forms[0].action=appUrl+"action/agr_bullock_eligibility.jsp";
		document.forms[0].submit(); 		
	}	
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
		document.forms[0].action=appUrl+"action/action/agr_bullock_eligibility.jsp";
		document.forms[0].hidBeanGetMethod.value="getBullockEconomic";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}



</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="onloading();">
<form name="appform" class="normal" method="post" action="">

						<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3" >
							<tr>
								<td valign="top" class="cellcontainer">
								
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr class="dataHeader"> 
                              <td width="68%"> 
                                <b>Annual Expenses </b></td>
                              <td width="7%" align="left" valign="center">&nbsp;</td>
                              <td width="25%" align="left" valign="center">&nbsp; </td>
                             </tr>
                            <tr> 
                              <td>Feeding 
                                of Bullocks/Camels/Horses/Donkeys for Working days <br>(Cost of Feeding/Bullock/Camel/Horse/Donkey 
                                * No. of Bullocks/Camels/Horses/Donkeys*&nbsp;<%=Helper.correctNull((String)hshValues.get("noworkdays"))%>&nbsp;days)</td>
                              <td valign="top" align="left">Rs</td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_bullockfeed" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_bullockfeed"))%>'  />
                              </td>
                              
                              </tr>
                              <tr> 
                              <td>Feeding 
                                of Bullocks/Camels/Horses/Donkeys for Non-Working days<br>( Cost of Feeding/Bullock/Camel/Horse/Donkey 
                                * No. of Bullocks/Camels/Horses/Donkeys*&nbsp;<%=Helper.correctNull((String)hshValues.get("nonworkdays"))%>&nbsp;days)</td>
                              <td valign="top" align="left">Rs</td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_bullockfeednon" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_bullockfeednon"))%>'  />
                              </td>
                              </tr>
                              
                              
                            <tr> 
                              <td>Veterinary 
                                Aid Expenses(Veterinary Aid /year *No. of Bullocks/Camels/Horses/Donkeys)</td>
                              <td valign="top" align="left">Rs</td>
                              <td valign="top" align="left">
                                <lapschoice:CurrencyTag name="txt_vtaidexpenses" size="15"  maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_vtaidexpenses"))%>'/>
                              </td></tr>
                            <tr> 
                              <td>Insurance 
                                of Bullocks/Camels/Horses/Donkeys<br>(Insurance Premium/Bullock 
                                *No. of Bullocks/Camels/Horses/Donkeys) </td>
                              <td valign="top" align="left">Rs</td>
                              <td valign="top" align="left">
                                <lapschoice:CurrencyTag name="txt_insurancebullocks" size="15"  maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_insurancebullocks"))%>' />
                              </td>
                              </tr>
                            <tr> 
                              <td>Insurance 
                                of Cart</td>
                              <td valign="top" align=""> <%=ApplicationParams.getCurrency()%></td>
                              <td valign="top" align="left">  
                                <lapschoice:CurrencyTag name="txt_insurancecart" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_insurancecart"))%>'  />
                                </td></tr>
                                
                               <tr> 
                              <td>Repair and Maintenance 
                                of Cart</td>
                              <td valign="top" align=""> <%=ApplicationParams.getCurrency()%></td>
                              <td valign="top" align="left">  
                                <lapschoice:CurrencyTag name="txt_maint" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_maint"))%>' />
                                </td> </tr>
                                
                                
                            <tr> 
                              <td>&nbsp;Others 
                                ( Specify) 
                                <input type="text" name="txt_specify" size="15"  maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_specify"))%>" >
                                ( per annum) &nbsp; 
                                </td>
                              <td valign="top" align=""><%=ApplicationParams.getCurrency()%></td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_specifycost" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_specifycost"))%>' />
                                </td></tr>
                            <tr  class="dataHeader"> 
                              <td><b>Total 
                                Expenses</b></td>
                              <td valign="top" align=""><%=ApplicationParams.getCurrency()%></td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_totalexpenses" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("totexp"))%>'  />
                                <b> (A) </b></td></tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td valign="top" align="right">&nbsp;</td>
                              <td valign="top" align="left">&nbsp;</td></tr>
                            <tr class="dataHeader"> 
                              <td><b>Annual 
                                Income </b></td>
                              <td valign="center" align="right">&nbsp;</td>
                              <td valign="center" align="left">&nbsp;</td></tr>
                            <tr> 
                              <td> Bullocks/Camels/Horses/Donkeys 
                                (Ploughing/Transportation) </td>
                              <td valign="top" align="">Rs</td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_bullockplough" size="15"  maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_bullockplough"))%>'  />
                                </td></tr>
                            <tr> 
                              <td>Cart (Transportation)</td>
                              <td valign="top" align="">Rs</td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_carttransport" size="15"  maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("txt_carttransport"))%>'  />
                                </td></tr>
                            <tr class="dataHeader"> 
                              <td><b>Total 
                                Income</b></td>
                              <td valign="top" align="">Rs</td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_totalincome" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("totinc"))%>' />
                                 <b>(B) 
                                </b></td></tr>
                            <tr class="dataHeader"> 
                              <td><b>Surplus</b></td>
                              <td valign="top" align="">Rs.</td>
                              <td valign="top" align="left"> 
                                <lapschoice:CurrencyTag name="txt_surplus" size="15" maxlength="9" value='<%=Helper.correctNull((String)hshValues.get("surplus"))%>' />
                                <b> (B-A)</b> </td></tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td valign="top" align="right">&nbsp;</td>
                              <td valign="top" align="left">&nbsp; 
                                </td></tr>
                          </table>
								</td>
							</tr>
						</table>
						
<br>
<table  align="center" style="visibility:hidden;position:absolute">
<tr>
<td align="center" >
<input type="button" name="cmdsave" value="Save" class="buttonStyle" disabled="disabled">
</td>
</tr>
</table>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<br>
</form>
</body>
</html>

