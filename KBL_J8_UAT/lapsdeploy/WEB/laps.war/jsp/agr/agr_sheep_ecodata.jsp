<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
			
			arryRow = (ArrayList) hshValues.get("arryRow");
		
			if (arryRow == null) {
				arryRow = new ArrayList();
			}
	String l1="",l2="",l3="",l4="",l5="";
	String m1="",m2="",m3="",m4="",m5="";
	String n1="",n2="",n3="",n4="",n5="";
	String p1="",p2="",p3="",p4="",p5="";
%>
<html>
<head>
<title>SHEEP/GOAT Tech Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var sel_animal= "<%=Helper.correctNull((String)hshValues.get("sel_animal"))%>"
var txt_age = "<%=Helper.correctNull((String)hshValues.get("txt_age"))%>" 
var sel_kids = "<%=Helper.correctNull((String)hshValues.get("sel_kids" ))%>" 
var txt_price= "<%=Helper.correctNull((String)hshValues.get("txt_price"))%>" 
var sel_sale= "<%=Helper.correctNull((String)hshValues.get("sel_sale"))%>" 
var txt_salemanure = "<%=Helper.correctNull((String)hshValues.get("txt_salemanure"))%>"  
var txt_fine= "<%=Helper.correctNull((String)hshValues.get("txt_fine"))%>" 
var txt_fineprice = "<%=Helper.correctNull((String)hshValues.get("txt_fineprice"))%>" 
var txt_medium = "<%=Helper.correctNull((String)hshValues.get("txt_medium"))%>" 
var txt_mediumprice = "<%=Helper.correctNull((String)hshValues.get("txt_mediumprice"))%>" 
var txt_coarse = "<%=Helper.correctNull((String)hshValues.get("txt_coarse"))%>" 
var txt_coarseprice= "<%=Helper.correctNull((String)hshValues.get("txt_coarseprice"))%>" 
var txt_vtaidprice= "<%=Helper.correctNull((String)hshValues.get("txt_vtaidprice"))%>" 
var txt_inspremium= "<%=Helper.correctNull((String)hshValues.get("txt_inspremium"))%>" 
var txt_employee = "<%=Helper.correctNull((String)hshValues.get("txt_employee"))%>" 
var txt_wageemployee = "<%=Helper.correctNull((String)hshValues.get("txt_wageemployee"))%>" 
//var txt_transcost = "<%=Helper.correctNull((String)hshValues.get("txt_transcost"))%>" 
var txt_feedadult= "<%=Helper.correctNull((String)hshValues.get("txt_feedadult"))%>" 
var txt_feedlamb= "<%=Helper.correctNull((String)hshValues.get("txt_feedlamb"))%>" 

function amount()
{
	var fine=document.forms[0].txt_fine.value;
	var fineprice=document.forms[0].txt_fineprice.value;
	if(fine=="")
	{
		fine="0";
	}
	if(fineprice=="")
	{
		fineprice="0.00";
	}
	var medium=document.forms[0].txt_medium.value;
	var mediumprice=document.forms[0].txt_mediumprice.value;
	if(medium=="")
	{
		medium="0";
	}
	if(mediumprice=="")
	{
		mediumprice="0.00";
	}
	var coarse=document.forms[0].txt_coarse.value;
	var coarseprice=document.forms[0].txt_coarseprice.value;
	if(coarse=="")
	{
		coarse="0";
	}
	if(coarseprice=="")
	{
		coarseprice="0.00";
	}
	document.forms[0].txt_amount1.value=eval(fine)*eval(fineprice);
	roundtxt(document.forms[0].txt_amount1);
	
	if(document.forms[0].txt_amount1.value=="NaN")
	{
		document.forms[0].txt_amount1.value="0.00";
	}
	
	document.forms[0].txt_amount2.value=eval(medium)*eval(mediumprice);
	roundtxt(document.forms[0].txt_amount2);
	if(document.forms[0].txt_amount2.value=="NaN")
	{
		document.forms[0].txt_amount2.value="0.00";
	}
	
	document.forms[0].txt_amount3.value=eval(coarse)*eval(coarseprice);
	roundtxt(document.forms[0].txt_amount3);
	if(document.forms[0].txt_amount3.value=="NaN")
	{
		document.forms[0].txt_amount3.value="0.00";
	}
	
	document.forms[0].txt_amount4.value=(eval(fine)*eval(fineprice))+(eval(medium)*eval(mediumprice))+(eval(coarse)*eval(coarseprice));
	roundtxt(document.forms[0].txt_amount4);
	if(document.forms[0].txt_amount4.value=="NaN")
	{
		document.forms[0].txt_amount4.value="0.00";
	}
}

function checkanimal()
{
	if(document.forms[0].sel_animal.value=="1")
	{
		document.forms[0].txt_kids1.value="kids";
		document.forms[0].txt_kids2.value="kids";
		document.forms[0].txt_kids3.value="kids";
		document.forms[0].txt_kids4.value="kids";
	}
	if(document.forms[0].sel_animal.value=="2")
	{
		document.forms[0].txt_kids1.value="lambs";
		document.forms[0].txt_kids2.value="lambs";
		document.forms[0].txt_kids3.value="lambs";
		document.forms[0].txt_kids4.value="lambs";
	}
}

function checksale()
{
	if(document.forms[0].sel_sale.value == "2")
	{
		document.all.r1.style.visibility="visible";		
	}
	else
	{
		document.all.r1.style.visibility="hidden";		
		document.forms[0].txt_salemanure.value="";
	}
}
function totamount()
{
	for(var i=0;i<5;i++)
	{
		var units=document.forms[0].txt_units[i].value;
		if(units=="")
		{
			units="0";
		}
		var cost=document.forms[0].txt_cost[i].value;
		if(cost=="")
		{
			cost="0";
		}
		var amount=eval(units)*eval(cost);
		document.forms[0].txt_amount[i].value=eval(amount);
		roundtxt(document.forms[0].txt_amount[i]);
		if(document.forms[0].txt_amount[i].value=="NaN")
		{
			document.forms[0].txt_amount[i].value="0.00";
		}
	}
}
function onloading()
{	 
	if(sel_kids!="")
	{
		document.forms[0].sel_kids.value=sel_kids;
	}
	document.forms[0].txt_age.value=txt_age;
	document.forms[0].txt_price.value=txt_price;
	if(sel_sale!="")
	{
		document.forms[0].sel_sale.value=sel_sale;
	}
	/*document.forms[0].txt_salemanure.value=txt_salemanure;
	document.forms[0].txt_fine.value=txt_fine;
	document.forms[0].txt_fineprice.value=txt_fineprice;
	document.forms[0].txt_medium.value=txt_medium;
    document.forms[0].txt_mediumprice.value=txt_mediumprice;
	document.forms[0].txt_coarse.value=txt_coarse;
	document.forms[0].txt_coarseprice.value=txt_coarseprice;
	document.forms[0].txt_vtaidprice.value=txt_vtaidprice;
	document.forms[0].txt_inspremium.value=txt_inspremium;
	document.forms[0].txt_employee.value=txt_employee;
	document.forms[0].txt_wageemployee.value=txt_wageemployee;
	document.forms[0].txt_transcost.value=txt_transcost;
	document.forms[0].txt_feedadult.value=txt_feedadult;
	document.forms[0].txt_feedlamb.value=txt_feedlamb;*/
	disableFields(true);
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
     if(document.forms[0].txt_price.value == "")
    {
	    alert('Enter the sale price of animals');
	    document.forms[0].txt_price.focus();
	    return;
    }
    
    var len = document.forms[0].sel_kids.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_kids.options[i].selected==true)
		 {
			 document.forms[0].sel_kids_text.value = document.forms[0].sel_kids.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_sale.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_sale.options[i].selected==true)
		 {
			 document.forms[0].sel_sale_text.value = document.forms[0].sel_sale.options[i].text; 
			break;
		 }
	}
   amount();
    enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrpoultry";		
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_ecodata.jsp";
	document.forms[0].hidBeanMethod.value="updatesheepecodata";
	document.forms[0].hidBeanGetMethod.value="getsheepecodata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_kids1.readOnly=true;
	document.forms[0].txt_kids2.readOnly=true;
	document.forms[0].txt_kids3.readOnly=true;
	document.forms[0].txt_kids4.readOnly=true;
    document.forms[0].txt_amount1.readOnly=true;
	document.forms[0].txt_amount2.readOnly=true;
	document.forms[0].txt_amount3.readOnly=true;
	document.forms[0].txt_amount4.readOnly=true; 
	for(var i=0;i<5;i++)
	{
	document.forms[0].txt_amount[i].readOnly=true;
	}
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false,false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheepecodata";
		document.forms[0].action=appURL +"action/agr_sheep_ecodata.jsp";
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
	var len = document.forms[0].sel_kids.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_kids.options[i].selected==true)
		 {
			 document.forms[0].sel_kids_text.value = document.forms[0].sel_kids.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_sale.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_sale.options[i].selected==true)
		 {
			 document.forms[0].sel_sale_text.value = document.forms[0].sel_sale.options[i].text; 
			break;
		 }
	}
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatesheepecodata";
		document.forms[0].hidBeanGetMethod.value="getsheepecodata";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidSourceUrl.value="action/agr_sheep_ecodata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();checkanimal();checksale();amount();">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
<tr> 
<td valign="top"> 
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
     <tr> 
     <td valign="top" align="center"> 
	<table width="100%"  border="0" cellpadding="3" cellspacing="0" class="outertable">
    <tr> 
      <td colspan="9">Age at which 
        <input type="text" name="txt_kids1"  value="<%=Helper.correctNull((String)hshValues.get("sheep_kids2"))%>"  size="10%" onKeyPress="notAllowSplChar()" maxlength="8">
        are sold 
        <input type="text" name="txt_age"  value="<%=Helper.correctNull((String)hshValues.get("txt_age"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="3">
        Months </td>
    </tr>
    <tr> 
      <td colspan="9"></td>
    </tr>
    <tr> 
      <td nowrap>Sale of 
        <input type="text" name="txt_kids2"  value="<%=Helper.correctNull((String)hshValues.get("sheep_kids2"))%>"  size="10%" onKeyPress="notAllowSplChar()" maxlength="8">
        </td>
      <td> 
        <select name="sel_kids" onChange="">
          <option value="0" selected>select</option>
          <option value="1">Only Males are sold</option>
          <option value="2">Both Males and Females</option>
        </select>
        </td>
      <td colspan="4" nowrap ><b class="mantatory">*</b>Sale price of 
        <input type="text" name="txt_kids3"  value="<%=Helper.correctNull((String)hshValues.get("sheep_kids2"))%>"  size="10%" onKeyPress="notAllowSplChar()" maxlength="6">
        Rs. 
        <lapschoice:CurrencyTag name="txt_price"  value='<%=Helper.correctNull((String)hshValues.get("txt_price"))%>' size="20%" onKeyPress="allowNumber(this)" maxlength="6" />
        each </font></td>
    </tr>
    <tr> 
      <td colspan="5">Sale price of manure/income from penning 
        <select name="sel_sale" onChange="checksale()">
          <option value="0" selected>select</option>
          <option value="1">Manure retrived for own farm</option>
          <option value="2">Sold</option>
        </select>
        </td>
      <td id="r1"> Rs. 
        <lapschoice:CurrencyTag name="txt_salemanure"  value='<%=Helper.correctNull((String)hshValues.get("txt_salemanure"))%>'  size="20%" onKeyPress="allowNumber(this)" maxlength="9" />
        per adult/year</td>
      <td colspan="3">&nbsp;</td>
      <td width="8%">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="10"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td colspan="9" align="center">Sale of Wool / Hairs</td>
          </tr>
          <tr class="dataheader"> 
            <td colspan="3" align="center">Fine</td>
            <td colspan="3" align="center">Medium</td>
            <td colspan="3" align="center">Coarse</td>
          </tr>
          <tr class="dataheader"> 
            <td width="16%">kgs/Animal/year</td>
            <td width="7%">Rs. per Kg</td>
            <td width="10%">Amount(Rs.)</td>
            <td width="13%">kgs/Animal/year</td>
            <td width="9%">Rs. per Kg.</td>
            <td width="10%">Amount(Rs.)</td>
            <td width="13%">kgs/Animal/year</td>
            <td width="13%">Rs. per Kg.</td>
            <td width="9%">Amount(Rs.)</td>
          </tr>
          <tr> 
            <td> 
              <input type="text" name="txt_fine"  value="<%=Helper.correctNull((String)hshValues.get("txt_fine"))%>"  size="8" onKeyPress="allowNumber(this)" maxlength="4" onBlur="amount()">
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_fineprice"  value='<%=Helper.correctNull((String)hshValues.get("txt_fineprice"))%>'  size="8" onKeyPress="allowNumber(this)" maxlength="5" onBlur="amount()"/>
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amount1"  value='0.00'  size="10%" onKeyPress="allowNumber(this)" maxlength="9" />
              </td>
            <td> 
              <input type="text" name="txt_medium"  value="<%=Helper.correctNull((String)hshValues.get("txt_medium"))%>"  size="8" onKeyPress="allowNumber(this)" maxlength="4" onBlur="amount()">
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_mediumprice"  value='<%=Helper.correctNull((String)hshValues.get("txt_mediumprice"))%>'  size="8" onKeyPress="allowNumber(this)" maxlength="5" onBlur="amount()"/>
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amount2"  value='0.00'  size="10%" onKeyPress="allowNumber(this)" maxlength="9"/>
              </td>
            <td> 
              <input type="text" name="txt_coarse"  value="<%=Helper.correctNull((String)hshValues.get("txt_coarse"))%>"  size="8" onKeyPress="allowNumber(this)" maxlength="4" onBlur="amount()">
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_coarseprice"  value='<%=Helper.correctNull((String)hshValues.get("txt_coarseprice"))%>'  size="8" onKeyPress="allowNumber(this)" maxlength="5" onBlur="amount()" />
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amount3"  value='0.00'  size="8" onKeyPress="allowNumber(this)" maxlength="6" />
              </td>
          </tr>
          <tr> 
            <td><strong>Total sale of Wool / Hairs</strong></td>
            <td colspan="4"> Rs. 
              <lapschoice:CurrencyTag name="txt_amount4"  value='0.00'  size="12%" onKeyPress="allowNumber(this)" maxlength="9"/>
              </td>
            <td>&nbsp;</td>
            <td> 
              <input type="hidden" name="sheep_othersale"  value="<%=Helper.correctNull((String)hshValues.get("sheep_othersale"))%>"  size="12%" onKeyPress="allowNumber(this)" maxlength="9">
              </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="9"> 
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                <tr class="dataheader"> 
                  <td colspan="2" align="center"><strong>Income 
                    from other sources</strong></td>
                </tr>
                <tr class="dataheader" align="center"> 
                  <td width="50%">Specify</td>
                  <td width="50%">Amount(Rs.) 
                    per year</td>
                </tr>
                <tr align="center"> 
                  <td> 
                    <input type="text" name="txt_specify1"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>"  size="40%" onKeyPress="" maxlength="35">
                    </td>
                  <td> 
                    <lapschoice:CurrencyTag name="txt_amountspec1"  value='<%=Helper.correctNull((String)hshValues.get("txt_amountspec1"))%>'  size="20%" onKeyPress="allowNumber(this)" maxlength="6" />
                    </td>
                </tr>
                <tr align="center"> 
                  <td> 
                    <input type="text" name="txt_specify2"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>"  size="40%" onKeyPress="" maxlength="35">
                    </td>
                  <td> 
                    <lapschoice:CurrencyTag name="txt_amountspec2"  value='<%=Helper.correctNull((String)hshValues.get("txt_amountspec2"))%>'  size="20%" onKeyPress="allowNumber(this)" maxlength="6" />
                    </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr> 
      <td>Expenses on Veterinary Aid </td>
      <td colspan="5">Rs. 
        <lapschoice:CurrencyTag name="txt_vtaidprice"  value='<%=Helper.correctNull((String)hshValues.get("txt_vtaidprice"))%>'  size="7" onKeyPress="allowNumber(this)" maxlength="5" />
        per adult animal/month</td>
      <td colspan="3" rowspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td>Insurance Premium </td>
      <td colspan="5">Rs. 
        <lapschoice:CurrencyTag name="txt_inspremium"  value='<%=Helper.correctNull((String)hshValues.get("txt_inspremium"))%>'  size="7" onKeyPress="allowNumber(this)" maxlength="5" />
        per adult animal/year </td>
    </tr>
    <tr bordercolordark="#FFFFFF"> 
      <td rowspan="2">Wages/salary per Employee</td>
      <td colspan="8" >No. of Employee 
        <input type="text" name="txt_employee"  value="<%=Helper.correctNull((String)hshValues.get("txt_employee"))%>"  size="5" onKeyPress="allowInteger()" maxlength="3">
        </td>
    </tr>
    <tr> 
                  <td colspan="8">Wages/salary 
                    per employee Rs. <lapschoice:CurrencyTag name="txt_wageemployee"  value='<%=Helper.correctNull((String)hshValues.get("txt_wageemployee"))%>'  size="7" onKeyPress="allowNumber(this)" maxlength="5"/> 
                    per month</td>
    </tr>
    <tr>
      <td>Electricity Expenses</td>
      <td colspan="8"> Rs. 
        <lapschoice:CurrencyTag name="sheep_elecexp"  value='<%=Helper.correctNull((String)hshValues.get("sheep_elecexp"))%>'  size="7" onKeyPress="allowNumber(this)" maxlength="5" />
        per month</td>
    </tr>
    <tr> 
      <td>Maintanence charge</td>
      <td colspan="8"> Rs. 
        <lapschoice:CurrencyTag name="sheep_maincharge"  value='<%=Helper.correctNull((String)hshValues.get("sheep_maincharge"))%>'  size="7" onKeyPress="allowNumber(this)" maxlength="5" />
        per month</td>
    </tr>
	<%--
    <tr> 
      <td>Cost of Transport</td>
                  <td colspan="8">Rs. <lapschoice:CurrencyTag name="txt_transcost"  value='<%=Helper.correctNull((String)hshValues.get("txt_transcost"))%>'  size="7" onKeyPress="allowNumber(this)" maxlength="5" /> 
                    per Animal</td>
    </tr>
	--%>
    <tr> 
      <td rowspan="2" nowrap>Cost of Feeding<font face="MS Sans Serif" size="1"
											color="#000000"><b></b></font></td>
                  <td colspan="7">&nbsp;For 
                    &nbsp;Male Adults Rs. &nbsp;&nbsp;<lapschoice:CurrencyTag name="txt_feedadult"  value='<%=Helper.correctNull((String)hshValues.get("txt_feedadult"))%>'  size="12%" onKeyPress="allowNumber(this)" maxlength="9"/> 
                    per Animal per Day <br>
                    For Female Adults Rs. <lapschoice:CurrencyTag name="txt_feedadult1"  value='<%=Helper.correctNull((String)hshValues.get("txt_feedadult1"))%>'  size="12%" onKeyPress="allowNumber(this)" maxlength="9"/> 
                    per Animal per Day</td>
      <td width="7%" rowspan="2">&nbsp;</td>
    </tr>
    <tr> 
                  <td colspan="7"> For Male 
                    <input type="text" name="txt_kids4"  value="<%=Helper.correctNull((String)hshValues.get("sheep_kids2"))%>"  size="12%" onKeyPress="notAllowSplChar()" maxlength="10">
                    Rs. <lapschoice:CurrencyTag name="txt_feedlamb"  value='<%=Helper.correctNull((String)hshValues.get("txt_feedlamb"))%>'  size="12%" onKeyPress="allowNumber(this)" maxlength="9"/> 
                    per Animal per Day <br>
                    For Female 
                    <input type="text" name="txt_kids41"  value="<%=Helper.correctNull((String)hshValues.get("sheep_kids2"))%>"  size="12%" onKeyPress="notAllowSplChar()" maxlength="10">
                    Rs. <lapschoice:CurrencyTag name="txt_feedlamb1"  value='<%=Helper.correctNull((String)hshValues.get("txt_feedlamb1"))%>'  size="12%" onKeyPress="allowNumber(this)" maxlength="9"/> 
                    per Animal per Day</td>
    </tr>
    <tr> 
      <td colspan="10"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
             <td colspan="2" align="center"><strong> 
                 Other Expenses</strong></td>
          </tr>
          <tr class="dataheader"> 
            <td width="50%" align="center">Specify</td>
            <td width="50%" align="center">Amount(Rs.) per month</td>
          </tr>
          <tr align="center"> 
            <td> 
              <input type="text" name="txt_specify3"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify3"))%>"  size="40%" onKeyPress="" maxlength="35">
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amountspec3"  value='<%=Helper.correctNull((String)hshValues.get("txt_amountspec3"))%>'  size="20%" onKeyPress="allowNumber(this)" maxlength="6"/>
              </td>
          </tr>
          <tr align="center"> 
            <td> 
              <input type="text" name="txt_specify4"  value="<%=Helper.correctNull((String)hshValues.get("txt_specify4"))%>"  size="40%" onKeyPress="" maxlength="35">
              </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amountspec4"  value='<%=Helper.correctNull((String)hshValues.get("txt_amountspec4"))%>'  size="20%" onKeyPress="allowNumber(this)" maxlength="6"/>
              </td>
          </tr>
        </table>
        <br>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr class="dataheader"> 
            <td colspan="4" align="center">Equipments</td>
          </tr>
          <tr class="dataheader" align="center"> 
            <td>Particulars</td>
            <td>No. of units</td>
            <td>Cost per unit(Rs.)</td>
            <td>Amount(Rs.)</td>
          </tr>
          <tr align="center"> 
            <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);
				
				if (arryCol.size() != 0) {
					 
					l1 = Helper.correctNull((String) arryCol.get(3));
					m1 = Helper.correctNull((String) arryCol.get(4));
					n1 = Helper.correctDouble((String) arryCol.get(5));
					p1 = Helper.correctDouble((String) arryCol.get(6));
				
				}
			
			} else if (arryRow.size() == 0) {
				l1 = "";
				m1 = "";
				n1 = "";
				p1 = "";
			
			}

			%>
            <td> 
              <input type="text" name="txt_particulars"  value="<%=l1%>"  size="25" onKeyPress="" maxlength="50">
            </td>
            <td> 
              <input type="text" name="txt_units"  value="<%=m1%>"  size="13" onKeyPress="allowNumber(this)" maxlength="3" onBlur="totamount()">
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_cost"  value='<%=n1%>'  size="13" maxlength="5" onBlur="totamount()"/>
            </td>
            <td>
              <lapschoice:CurrencyTag name="txt_amount"  value='<%=p1%>'  size="13" maxlength="9" />
            </td>
          </tr>
          <tr align="center"> 
            <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);
				
				if (arryCol.size() != 0) {
					 
					l2 = Helper.correctNull((String) arryCol.get(3));
					m2 = Helper.correctNull((String) arryCol.get(4));
					n2 = Helper.correctDouble((String) arryCol.get(5));
					p2 = Helper.correctDouble((String) arryCol.get(6));
				
				}
			
			} else if (arryRow.size() == 0) {
				l2 = "";
				m2= "";
				n2 = "";
				p2 = "";
			
			}

			%>
            <td> 
              <input type="text" name="txt_particulars"  value="<%=l2%>"  size="25%" onKeyPress="" maxlength="50">
            </td>
            <td> 
              <input type="text" name="txt_units"  value="<%=m2%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="3" onBlur="totamount()">
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_cost"  value='<%=n2%>'  size="13%" onKeyPress="allowNumber(this)" maxlength="5" onBlur="totamount()"/>
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amount"  value='<%=p2%>'  size="13%" onKeyPress="allowNumber(this)" maxlength="9"/>
            </td>
          </tr>
          <tr align="center"> 
            <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);
				
				if (arryCol.size() != 0) {
					 
					l3 = Helper.correctNull((String) arryCol.get(3));
					m3 = Helper.correctNull((String) arryCol.get(4));
					n3 = Helper.correctDouble((String) arryCol.get(5));
					p3 = Helper.correctDouble((String) arryCol.get(6));
				
				}
			
			} else if (arryRow.size() == 0) {
				l3 = "";
				m3 = "";
				n3 = "";
				p3 = "";
			
			}

			%>
            <td> 
              <input type="text" name="txt_particulars"  value="<%=l3%>"  size="25%" onKeyPress="" maxlength="50">
            </td>
            <td> 
              <input type="text" name="txt_units"  value="<%=m3%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="3" onBlur="totamount()">
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_cost"  value='<%=n3%>'  size="13%" onKeyPress="allowNumber(this)" maxlength="5" onBlur="totamount()"/>
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amount"  value='<%=p3%>'  size="13%" onKeyPress="allowNumber(this)" maxlength="9"/>
            </td>
          </tr>
          <tr align="center"> 
            <%
				if (arryRow.size() != 0) {
					
				arryCol = (ArrayList) arryRow.get(3);
				if (arryCol.size() != 0) {
					l4 = Helper.correctNull((String) arryCol.get(3));
					m4 = Helper.correctNull((String) arryCol.get(4));
					n4 = Helper.correctDouble((String) arryCol.get(5));
					p4 = Helper.correctDouble((String) arryCol.get(6));
				}
			
			} else if (arryRow.size() == 0) {
				l4 = "";
				m4 = "";
				n4 = "";
				p4 = "";
			
			}

			%>
            <td> 
              <input type="text" name="txt_particulars"  value="<%=l4%>"  size="25%" onKeyPress="" maxlength="50">
            </td>
            <td> 
              <input type="text" name="txt_units"  value="<%=m4%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="3" onBlur="totamount()">
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_cost"  value='<%=n4%>'  size="13%" onKeyPress="allowNumber(this)" maxlength="5" onBlur="totamount()"/>
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amount"  value='<%=p4%>' size="13%" onKeyPress="allowNumber(this)" maxlength="9"/>
            </td>
          </tr>
          <tr align="center"> 
            <%
						
				if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);
				
				if (arryCol.size() != 0) {
					 
					l5 = Helper.correctNull((String) arryCol.get(3));
					m5 = Helper.correctNull((String) arryCol.get(4));
					n5 = Helper.correctDouble((String) arryCol.get(5));
					p5 = Helper.correctDouble((String) arryCol.get(6));
				
				}
			
			} else if (arryRow.size() == 0) {
				l5 = "";
				m5 = "";
				n5 = "";
				p5 = "";
			
			}

			%>
            <td> 
              <input type="text" name="txt_particulars"  value="<%=l5%>"  size="25%" onKeyPress="" maxlength="50">
            </td>
            <td> 
              <input type="text" name="txt_units"  value="<%=m5%>"  size="13%" onKeyPress="allowNumber(this)" maxlength="3" onBlur="totamount()">
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_cost"  value='<%=n5%>'  size="13%" onKeyPress="allowNumber(this)" maxlength="5" onBlur="totamount()"/>
            </td>
            <td> 
              <lapschoice:CurrencyTag name="txt_amount"  value='<%=p5%>'  size="13%" onKeyPress="allowNumber(this)" maxlength="9"/>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  </table>
  </table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid='<%=PageId%>' />
<input type="hidden"	name="sel_animal" value="<%=Helper.correctNull((String)hshValues.get("sel_animal"))%>">
<input type="hidden" name="sel_kids_text" value="">
<input type="hidden" name="sel_sale_text" value="">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>




