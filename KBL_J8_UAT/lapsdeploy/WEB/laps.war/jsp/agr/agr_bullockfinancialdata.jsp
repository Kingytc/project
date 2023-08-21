<%@include file="../share/directives.jsp"%>
<%
String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
if(schemetype. trim().equalsIgnoreCase(""))
{
	schemetype="0";
}
%>
<html>
<head>
<title>Lease Particulars</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";

function onloading()
{	  
	disableFields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value="<%=schemetype%>";
}

function checkmargin()
{
	var val1=document.forms[0].txt_margin.value;
	if(val1=="")
	{
		val1="0";
	}
	if(val1>100)
	{
		alert("Margin % cannot be greater than 100%");
		document.forms[0].txt_margin.value="";
		return;
	}
}
function checksubsidy()
{
	var val1=document.forms[0].txt_subsidy.value;
	if(val1=="")
	{
		val1="0";
	}
	if(val1>100)
	{
		alert("Subsidy % cannot be greater than 100%");
		document.forms[0].txt_subsidy.value="";
		return;
	}
}
function worktotal()
{
	var greenfodder=document.forms[0].txt_greenfodderwork.value;
  	var dryfodder=document.forms[0].txt_dryfodderwork.value;
  	var confood=document.forms[0].txt_concentratefoodwork.value;
  
  //var costbullock=document.forms[0].txt_costbullock.value;
  //var costcart=document.forms[0].txt_costcart.value;
  //var insuprem=document.forms[0].txt_insurancepremium.value;
  //var others=document.forms[0].txt_others1.value;
  
       if(greenfodder=="")
		{
			greenfodder=0.00;
			
		}
		if(dryfodder=="")
		{
			dryfodder=0.00;
			
		}
	   if(confood=="")
		{
			confood=0.00;
			
		}
		/* if(costbullock=="")
		{
			costbullock=0.00;
			
		}
		if(costcart=="")
		{
			costcart=0.00;
			
		}
	    if(insuprem=="")
		{
			insuprem=0.00;
			
		}
		 if(others=="")
		{
			others=0.00;
			
		}*/
	document.forms[0].txt_totalwork.value=eval(greenfodder)+eval(dryfodder)+eval(confood);
		roundtxt(document.forms[0].txt_totalwork);
//document.forms[0].txt_total1.value=eval(costbullock)+eval(costcart)+eval(insuprem)+eval(others);

}


function nonworktotal()
{
  var greenfodder=document.forms[0].txt_greenfoddernonwork.value;
  var dryfodder=document.forms[0].txt_dryfoddernonwork.value;
  var confood=document.forms[0].txt_concentratefoodnonwork.value;
  
	if(greenfodder=="")
		{
			greenfodder=0.00;
			
		}
		if(dryfodder=="")
		{
			dryfodder=0.00;
			
		}
	   if(confood=="")
		{
			confood=0.00;
			
		}

	document.forms[0].txt_totalnonwork.value=eval(greenfodder)+eval(dryfodder)+eval(confood);
	roundtxt(document.forms[0].txt_totalnonwork);
}

function callMargin()
{
var totalcost=document.forms[0].txt_total1.value;
var margin=document.forms[0].txt_margin.value;
if(eval(margin)=="")
{
margin="0";
document.forms[0].txt_margin.value="0";
document.forms[0].txt_marginval.value="0";
document.forms[0].txt_marginamt.value="0";
}
var margin1=Math.round((eval(margin)/100)*eval(totalcost));
document.forms[0].txt_marginval.value=NanNumber(eval(margin1));
document.forms[0].txt_marginamt.value=NanNumber(eval(margin1));
if(eval(margin1)=="")
{
margin1="0";
document.forms[0].txt_marginamt.value="0";
}
if(document.forms[0].txt_marginval.value=="NaN")
{
document.forms[0].txt_marginval.value="0";
document.forms[0].txt_marginamt.value="0";
}
}
function callSubsidy()
{
var totalcost=document.forms[0].txt_total1.value;
var subsidy=document.forms[0].txt_subsidy.value;
if(eval(subsidy)=="")
{
subsidy="0";
document.forms[0].txt_subsidy.value="0";
document.forms[0].txt_subsidyval.value="0";
document.forms[0].txt_subsidyamt.value="0";
}
var subsidy1=Math.round((eval(subsidy)/100)*eval(totalcost));
document.forms[0].txt_subsidyval.value=NanNumber(eval(subsidy1));
document.forms[0].txt_subsidyamt.value=NanNumber(eval(subsidy1));
if(eval(subsidy1)=="")
{
subsidy1="0";
document.forms[0].txt_subsidyamt.value="0";
}
if(document.forms[0].txt_subsidyamt.value=="NaN")
{
document.forms[0].txt_subsidyval.value="0";
document.forms[0].txt_subsidyamt.value="0";
}
}
function callMargin1()
{
var totalcost=document.forms[0].txt_total1.value;
var marginval=document.forms[0].txt_marginval.value;
document.forms[0].txt_marginamt.value=NanNumber(eval(marginval));
if(eval(marginval)=="")
{
marginval="0";
document.forms[0].txt_marginamt.value="0";
}
var value1=Math.round(eval(marginval)/eval(totalcost)*100);
var value2=eval(value1);
value2=value2.toFixed(2);
document.forms[0].txt_margin.value=NanNumber(eval(value2));
if(eval(value2)=="")
{
value2="0";
document.forms[0].txt_margin.value="0";
}
}
function callSubsidy1()
{
var totalcost=document.forms[0].txt_total1.value;
var subsidyval=document.forms[0].txt_subsidyval.value;
document.forms[0].txt_subsidyamt.value=NanNumber(eval(subsidyval));
if(eval(subsidyval)=="")
{
subsidyval="0";
document.forms[0].txt_subsidyamt.value="0";
}
var value3=Math.round(eval(subsidyval)/eval(totalcost)*100);
var value4=eval(value3);
value4=value4.toFixed(2);
document.forms[0].txt_subsidy.value=NanNumber(eval(value4));
if(eval(value4)=="")
{
value4="0";
document.forms[0].txt_subsidy.value="0";
}
}
function totalamount()
{
callMargin();
callMargin1();
callSubsidy();
callSubsidy1();
var val1=document.forms[0].txt_total1.value;
var val2=document.forms[0].txt_marginamt.value;
var val3=document.forms[0].txt_subsidyamt.value;
var val4=eval(val2)+eval(val3);
var val5=Math.round(eval(val1)-eval(val4));
document.forms[0].txt_loanamount.value=NanNumber(eval(val5));

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
    if(document.forms[0].txt_greenfodderwork.value=="" || document.forms[0].txt_greenfodderwork.value=="0.00")
	{
	alert("Enter Green Fodder for Working days");
	document.forms[0].txt_greenfodderwork.focus();
	return;
	}  
	if(document.forms[0].txt_dryfodderwork.value=="" || document.forms[0].txt_dryfodderwork.value=="0.00")
	{
	alert("Enter Dry Fodder for Working days");
	document.forms[0].txt_dryfodderwork.focus();
	return;
	} 
    if(document.forms[0].txt_concentratefoodwork.value=="" || document.forms[0].txt_concentratefoodwork.value=="0.00")
	{
	alert("Enter Concentrate Food  for Working days ");
	document.forms[0].txt_concentratefoodwork.focus();
	return;
	}  
	if((document.forms[0].txt_greenfoddernonwork.value=="")||(document.forms[0].txt_greenfoddernonwork.value=="0.00"))
	{
	alert("Enter Green Fodder for Non-Working days");
	document.forms[0].txt_greenfoddernonwork.focus();
	return;
	}  
	if(document.forms[0].txt_dryfoddernonwork.value=="" ||document.forms[0].txt_dryfoddernonwork.value=="0.00")
	{
	alert("Enter Dry Fodder for Non-Working days");
	document.forms[0].txt_dryfoddernonwork.focus();
	return;
	} 
    if(document.forms[0].txt_concentratefoodnonwork.value=="" || document.forms[0].txt_concentratefoodnonwork.value=="0.00")
	{
	alert("Enter Concentrate Food  for Non-Working days ");
	document.forms[0].txt_concentratefoodnonwork.focus();
	return;
	}  
    enableButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidSourceUrl.value="/action/agr_bullockfinancialdata.jsp";
	document.forms[0].hidBeanMethod.value="updateBullockFinancial";
	document.forms[0].hidBeanGetMethod.value="getBullockFinancial";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_totalwork.readOnly=true;
	document.forms[0].txt_totalnonwork.readOnly=true;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getBullockFinancial";
		document.forms[0].action=appURL+"action/agr_bullockfinancialdata.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
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
		document.forms[0].hidBeanMethod.value="updateBullockFinancial";
		document.forms[0].hidBeanGetMethod.value="getBullockFinancial";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidSourceUrl.value="action/agr_bullockfinancialdata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

</script>


<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

</head>
<body onload="onloading();">
<!--  callMargin();callMargin1();callSubsidy();callSubsidy1();totalamount()"> -->
<form name="appform" method="post" action="" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Financial Data</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="152" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellpadding="5" cellspacing="0" class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="98%" border="0" cellspacing="0" cellpadding="5"
					align="center" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top" class="cellcontainer">


								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td colspan="6"><b>Expenses on feeding
										Bullocks/Camels/Horses/Donkeys (per day / per
										Bullock/Camel/Horse/Donkey)</b></td>
									</tr>
									<tr>
										<td width="33%" class="dataheader" colspan="7"><b>Working days</b></td>
									</tr>
									<tr>
										<td width="33%">Green Fodder<b>*</b></td>
										<td width="18%" align="left"><lapschoice:CurrencyTag
											name="txt_greenfodderwork" size="15" maxlength="6"
											onBlur="worktotal();roundtxt(this)"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_greenfodderwork"))%>' /></td>
										<td width="14%" align="left">&nbsp;</td>
										<td width="2%" align="left">&nbsp;</td>
										<td width="32%" align="left"></td>
									</tr>
									<tr>
										<td width="33%">Dry Fodder<b>*</b></td>
										
										<td align="left" width="18%"><lapschoice:CurrencyTag
											name="txt_dryfodderwork" size="15" maxlength="6"
											onBlur="worktotal();roundtxt(this)"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_dryfodderwork"))%>' /></td>
										<td align="left" width="14%">&nbsp;</td>
										<td align="left" width="2%"></td>
										<td align="left" width="32%"></td>
									</tr>
									<tr>
										<td width="33%">Concentrate Food<b>*</b></td>
										<td align="left" width="18%"><lapschoice:CurrencyTag
											name="txt_concentratefoodwork" size="15" maxlength="6"
											onBlur="worktotal();roundtxt(this)"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_concentratefoodwork"))%>' /></td>
										<td align="left" width="14%">&nbsp;</td>
										<td align="left" width="2%">&nbsp;</td>
										<td align="left" width="32%"></td>
									</tr>
									<tr>
										<td width="33%" align="right"><b>Total</b></td>
										<td align="left" width="18%"><lapschoice:CurrencyTag
											name="txt_totalwork" size="15" maxlength="6"
											onBlur="worktotal();roundtxt(this)"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_totalwork"))%>' />
										</td>
										<td align="left" width="14%">&nbsp;</td>
										<td align="left" width="2%">&nbsp;</td>
										<td align="left" width="32%">&nbsp;</td>
									</tr>
									
									<tr>
										<td colspan="6" class="dataheader"><b>Non-Working days</b></td>
									</tr>
									<tr>
										<td width="33%">Green Fodder<b>*</b></td>
										<td width="18%" align="left"><lapschoice:CurrencyTag
											name="txt_greenfoddernonwork" size="15" maxlength="6"
											onBlur="nonworktotal();roundtxt(this)"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_greenfoddernonwork"))%>' />
										</td>
										<td width="14%" align="left">&nbsp;</td>
										<td width="2%" align="left">&nbsp;</td>
										<td width="32%" align="left"></td>
									</tr>
									<tr>
										<td width="33%">Dry Fodder<b>*</b></td>
										<td valign="center" width="18%"><lapschoice:CurrencyTag
											name="txt_dryfoddernonwork" size="15" maxlength="6"
											onBlur="nonworktotal();roundtxt(this)"
											value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_dryfoddernonwork"))))%>' /></td>
										<td valign="center" align="right" width="14%">&nbsp;</td>
										<td valign="center" align="left" colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="33%">Concentrate Food<b>*</b></td>
										<td valign="center" width="18%"><lapschoice:CurrencyTag
											name="txt_concentratefoodnonwork" size="15" maxlength="6"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_concentratefoodnonwork"))%>'
											onKeyPress="allowNumber(this)"
											onBlur="nonworktotal();roundtxt(this)" /></td>
										<td valign="center" align="right" width="14%">&nbsp;</td>
										<td valign="center" align="left" colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="33%" align="right"><b>Total</b></td>
										<td valign="center" width="18%"><lapschoice:CurrencyTag
											name="txt_totalnonwork" size="15" maxlength="6"
											onBlur="nonworktotal();roundtxt(this)"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_totalnonwork"))%>' /></td>
										<td valign="center" align="right" width="14%">&nbsp;</td>
										<td valign="center" align="left" colspan="2">&nbsp;</td>
									</tr>
									
									<tr>
										<td colspan="7" class="dataheader"><b>Other Expenses</b></td>
									</tr>
									<tr>
										<td width="33%">Veterinary Aid Expenses <br>
										( per annum/Bullock/Camel/Horse/Donkey)</td>
										
										<td align="left"><lapschoice:CurrencyTag
											name="txt_veterinaryaid" size="15" maxlength="6"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_veterinaryaid"))%>' /></td>
										<td valign="center">&nbsp;</td>
										<td valign="center" colspan="2"></td>
									</tr>
									<tr>
										<td width="33%">Insurance of Bullocks/Camels/Horses/Donkeys<br>
										( per annum / Bullock/Camel/Horse/Donkey)</td>
										
										<td width="18%" align="left"><lapschoice:CurrencyTag
											name="txt_insurancebullock" size="15" maxlength="6"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_insurancebullock"))%>' /></td>
										<td valign="center" width="14%">&nbsp;</td>
										<td valign="center" align="left" colspan="2">&nbsp; </td>
									</tr>
									<tr>
										<td width="33%">Insurance of Cart <br>
										( per annum / cart)</td>
										
										<td width="18%" align="left"><lapschoice:CurrencyTag
											name="txt_insurancecart" size="15" maxlength="6"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_insurancecart"))%>' /></td>
										<td valign="center" width="14%">&nbsp;</td>
										<td valign="center" align="left" colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="33%">Repair and Maintenance of Cart <br>
										( per day / Bullock/Camel/Horse/Donkey)</td>
										
										<td width="18%" align="left"><lapschoice:CurrencyTag
											name="txt_mainten" size="15" maxlength="6"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_mainten"))%>' /></td>
										<td valign="center" width="14%">&nbsp;</td>
										<td valign="center" align="left" colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td width="33%">Others ( Specify) <input type="text"
											name="txt_other" size="15" maxlength="15"
											value="<%=Helper.correctNull((String)hshValues.get("txt_other"))%>"
											onKeyPress=""> ( per day)</td>
										
										<td width="18%" align="left"><lapschoice:CurrencyTag
											maxlength="6" name="txt_otherexpenses" size="15"
											value='<%=Helper.correctDouble((String)hshValues.get("txt_otherexpenses"))%>' /></td>
										<td valign="center" width="14%">&nbsp;</td>
										<td valign="center" align="left" colspan="2">&nbsp;</td>
									</tr>
									<!-- 
    
                            <tr> 
                              <td width="31%">&nbsp;</td>
                              <td valign="center" align="right" colspan="3">&nbsp;</td>
                              <td valign="center" align="left" colspan="2">&nbsp;</td>
                              
                             
                            <tr> 
                              <td width="31%"><b>Loan 
                                Particulars</b></td>
                              <td valign="center" align="right" colspan="3">&nbsp;</td>
                              <td valign="center" align="left" colspan="2">&nbsp;</td>
                            <tr> 
                              <td width="31%">Cost 
                                of Bullocks/Camels/Horses/Donkeys</td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_costbullock" size="15"  maxlength="6" value='<%=Helper.correctNull((String)hshValues.get("txt_costbullock"))%>'  onKeyPress="allowNumber(this)" onBlur="total()" /> 
                              </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2"><font face="MS Sans Serif" size="1"> 
                                
                                </td>
                            <tr> 
                              <td width="31%">Cost 
                                of cart</td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_costcart" size="15"  maxlength="6" value='<%=Helper.correctNull((String)hshValues.get("txt_insurancepremium"))%>'  onKeyPress="allowNumber(this)" onBlur="total()" /> 
                              </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2"><font face="MS Sans Serif" size="1"> 
                                
                                </td>
                            <tr> 
                              <td width="31%">Insurance 
                                Premium </td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_insura" size="15" maxlength="6" value='<%=Helper.correctNull((String)hshValues.get("txt_total1"))%>'  onKeyPress="allowNumber(this)" onBlur="" /> </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2"><font face="MS Sans Serif" size="1"> 
                                
                                </td>
                            <tr> 
                              <td width="31%">Others 
                                ( Specify) 
                                <input type="text" name="txt_others2" size="15"  maxlength="25" value="<%=Helper.correctNull((String)hshValues.get("txt_others2"))%>"  onKeyPress="">
                                </td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_total1" size="15" maxlength="6" value='<%=Helper.correctNull((String)hshValues.get("txt_total1"))%>'  onKeyPress="allowNumber(this)" onBlur="" /> </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2"><font face="MS Sans Serif" size="1"> 
                                
                                </td>
                            <tr> 
                              <td width="31%">Total</td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_total1" size="15" maxlength="6" value='<%=Helper.correctNull((String)hshValues.get("txt_total1"))%>'  onKeyPress="allowNumber(this)" onBlur="" /> </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2">&nbsp; </td>
                            <tr> 
                              <td width="31%">Margin 
                                <input type="text" name="txt_margin" size="7" maxlength="3" value="<%=Helper.correctNull((String)hshValues.get("txt_margin"))%>"  onKeyPress="allowNumber(this)" onBlur="checkmargin();callMargin();totalamount()">
                                % or <%//=ApplicationParams.getCurrency()%> 
                                <input type="text" name="txt_marginval" size="15" maxlength="6" value="<%=Helper.correctNull((String)hshValues.get("txt_marginval"))%>"  onKeyPress="allowNumber(this)" onBlur="callMargin1();totalamount()">
                                </td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_total1" size="15" maxlength="6" value='<%=Helper.correctNull((String)hshValues.get("txt_total1"))%>'  onKeyPress="allowNumber(this)" onBlur="" /> </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2">
                              </td>
                            <tr> 
                              <td width="31%">Subsidy 
                                <input type="text" name="txt_subsidy" size="7" maxlength="3" value="<%=Helper.correctNull((String)hshValues.get("txt_subsidy"))%>"  onKeyPress="allowNumber(this)" onBlur="checksubsidy();callSubsidy();totalamount()">
                                % or <%//=ApplicationParams.getCurrency()%> 
                                <input type="text" name="txt_subsidyval" size="15" maxlength="6" value="<%=Helper.correctNull((String)hshValues.get("txt_subsidyval"))%>"  onKeyPress="allowNumber(this)" onBlur="callSubsidy1();totalamount()">
                                </td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag name="txt_subsidyamt" size="15" maxlength="6" value=''  onKeyPress="allowNumber(this)" onBlur="" /> 
                                </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2"> 
                                </td>
                            <tr> 
                              <td width="31%">Loan 
                                Amount</td>
                              <td valign="center" align="right" width="3%"><font face="MS Sans Serif" size="1"><%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag name="txt_loanamount" size="15"  maxlength="15" value=''  onKeyPress="allowNumber(this)" /> 
                                 </td>
                              <td valign="center" align="right" width="19%">&nbsp;</td>
                              <td valign="center" align="right" width="15%">&nbsp;</td>
                              <td valign="center" align="left" colspan="2"> 
                                </td>
                                </tr> -->
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
<br>
  <lapschoice:hiddentag pageid="<%=PageId%>"/>
   <input  type="hidden" name="audit_flag" value='<%=Helper.correctNull((String)hshValues.get("audit_flag"))%>'>
  </form>
</body>
</html>

