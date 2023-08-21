<%@include file="../share/directives.jsp"%>
<%
			ArrayList arryRow = new ArrayList();

			arryRow = (ArrayList) hshValues.get("arryRow");

			if (arryRow == null) {
				arryRow = new ArrayList();
			}

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
var txt_breed = "<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>" 
var txt_agem = "<%=Helper.correctNull((String)hshValues.get("txt_agem" ))%>" 
var txt_maleno= "<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>" 
var txt_malecost= "<%=Helper.correctNull((String)hshValues.get("txt_malecost"))%>" 
var txt_maleamount = "<%=Helper.correctNull((String)hshValues.get("txt_maleamount"))%>"  
var txt_agef= "<%=Helper.correctNull((String)hshValues.get("txt_agef"))%>" 
var txt_femaleno = "<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>" 
var txt_femalecost = "<%=Helper.correctNull((String)hshValues.get("txt_femalecost"))%>" 
var txt_femaleamount = "<%=Helper.correctNull((String)hshValues.get("txt_femaleamount"))%>" 
var txt_totalanimalno = "<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>" 
var txt_totalanimalcost = "<%=Helper.correctNull((String)hshValues.get("txt_totalanimalcost"))%>" 
var txt_totalanimalamount= "<%=Helper.correctNull((String)hshValues.get("txt_totalanimalamount"))%>" 
var txt_marketplace= "<%=Helper.correctNull((String)hshValues.get("txt_marketplace"))%>" 
var txt_marketdistance = "<%=Helper.correctNull((String)hshValues.get("txt_marketdistance"))%>" 
var txt_markettransport = "<%=Helper.correctNull((String)hshValues.get("txt_markettransport"))%>" 
var txt_markettranscost = "<%=Helper.correctNull((String)hshValues.get("txt_markettranscost"))%>" 
var sel_purchase = "<%=Helper.correctNull((String)hshValues.get("sel_purchase"))%>" 
var txt_namepurcom = "<%=Helper.correctNull((String)hshValues.get("txt_namepurcom"))%>" 
var txt_per= "<%=Helper.correctNull((String)hshValues.get("txt_per"))%>" 
var txt_birth= "<%=Helper.correctNull((String)hshValues.get("txt_birth"))%>" 
var txt_annualper= "<%=Helper.correctNull((String)hshValues.get("txt_annualper"))%>" 
var txt_annualpera= "<%=Helper.correctNull((String)hshValues.get("txt_annualpera"))%>" 
var sel_flock= "<%=Helper.correctNull((String)hshValues.get("sel_flock"))%>" 
var txt_migrationpattern = "<%=Helper.correctNull((String)hshValues.get("txt_migrationpattern"))%>" 
var txt_grazingpattern = "<%=Helper.correctNull((String)hshValues.get("txt_grazingpattern"))%>" 
var txt_greenfodder = "<%=Helper.correctNull((String)hshValues.get("txt_greenfodder"))%>" 
var txt_vtaidplace= "<%=Helper.correctNull((String)hshValues.get("txt_vtaidplace"))%>" 
var txt_distancefarm = "<%=Helper.correctNull((String)hshValues.get("txt_distancefarm"))%>" 
var txt_woolplace= "<%=Helper.correctNull((String)hshValues.get("txt_woolplace"))%>" 
var txt_distancewool= "<%=Helper.correctNull((String)hshValues.get("txt_distancewool"))%>" 
var sel_care= "<%=Helper.correctNull((String)hshValues.get("sel_care"))%>" 

</script>

<script>
function checkanimal()
{
	if(document.forms[0].sel_animal.value=="1")
	{
		document.forms[0].txt_kids1.value="kidding";
		document.forms[0].txt_kids2.value="kids";
		document.forms[0].txt_kids3.value="kids";
	}
	if(document.forms[0].sel_animal.value=="2")
	{
		document.forms[0].txt_kids1.value="lambing";
		document.forms[0].txt_kids2.value="lambs";
		document.forms[0].txt_kids3.value="lambs";
	}
	if(document.forms[0].sel_animal.value=="3")
	{
		document.forms[0].txt_kids1.value="kidding";
		document.forms[0].txt_kids2.value="kids";
		document.forms[0].txt_kids3.value="kids";
	}
	if(document.forms[0].sel_animal.value=="4")
	{
		document.forms[0].txt_kids1.value="pigletting";
		document.forms[0].txt_kids2.value="piglets";
		document.forms[0].txt_kids3.value="piglets";
	}
}
function checkper()
{
	var pervalue=document.forms[0].txt_per.value;
	if(pervalue >100)
	{
		alert("Percentage value cannot be greater than zero");
		document.forms[0].txt_per.value="";
		document.forms[0].txt_per.focus();
		return;
	}
}

function checkannualper()
{
	var pervalue1=document.forms[0].txt_annualper.value;
	if(pervalue1 > 100)
	{
		alert("Percentage value cannot be greater than zero");
		document.forms[0].txt_annualper.value="";
		document.forms[0].txt_annualper.focus();
		return;
	}
}

function checkannualpera()
{
	var pervalue2=document.forms[0].txt_annualpera.value;
	if(pervalue2 >100)
	{
		alert("Percentage value cannot be greater than zero");
		document.forms[0].txt_annualpera.value="";
		document.forms[0].txt_annualpera.focus();
		return;
	}
}

function checkpurchase()
{
	if(document.forms[0].sel_purchase.value == "1")
	{
		document.all.r4.style.visibility="visible";	
		document.all.r9.style.visibility="visible";		
	}
	else
	{
		document.all.r4.style.visibility="hidden";
		document.all.r9.style.visibility="hidden";
		document.forms[0].txt_namepurcom.value="";
	}
}

function checkflock()
{
	if(document.forms[0].sel_flock.value == "1")
	{
	    document.all.r1.style.visibility="visible";
	    document.all.r2.style.visibility="hidden";
		document.all.r3.style.visibility="hidden";
		document.all.r6.style.visibility="visible";
		document.all.r7.style.visibility="hidden";
		document.all.r8.style.visibility="hidden";
		document.forms[0].txt_grazingpattern.value="";
		document.forms[0].txt_greenfodder.value="";		
	}
	if(document.forms[0].sel_flock.value == "2")
	{
	    document.all.r2.style.visibility="visible";
		document.all.r1.style.visibility="hidden";
		document.all.r3.style.visibility="hidden";		
		document.all.r6.style.visibility="hidden";
		document.all.r7.style.visibility="visible";
		document.all.r8.style.visibility="hidden";		
		document.forms[0].txt_migrationpattern.value="";
		document.forms[0].txt_greenfodder.value="";		
	}
	if(document.forms[0].sel_flock.value == "3")
	{	     
		document.all.r3.style.visibility="visible";
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";		
		document.all.r6.style.visibility="hidden";
		document.all.r7.style.visibility="hidden";
		document.all.r8.style.visibility="visible";		
		document.forms[0].txt_grazingpattern.value="";
		document.forms[0].txt_migrationpattern.value="";		
	}
	if(document.forms[0].sel_flock.value == "0")
	{
		document.all.r3.style.visibility="hidden";
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";		
		document.all.r6.style.visibility="hidden";
		document.all.r7.style.visibility="hidden";
		document.all.r8.style.visibility="hidden";
		document.forms[0].txt_grazingpattern.value="";
		document.forms[0].txt_migrationpattern.value="";
		document.forms[0].txt_greenfodder.value="";		
	}
}
function callamount()
{
	var maleno=document.forms[0].txt_maleno.value;
	var malecost=document.forms[0].txt_malecost.value;
	if(eval(maleno)=="")
	{
		maleno="0";
	}
	if(eval(malecost)=="")
	{
		malecost="0";
	}
	document.forms[0].txt_maleamount.value=eval(maleno)*eval(malecost);
	if(document.forms[0].txt_maleamount.value=="NaN")
	{
		document.forms[0].txt_maleamount.value="0";
	}
	var femaleno=document.forms[0].txt_femaleno.value;
	var femalecost=document.forms[0].txt_femalecost.value;
	if(eval(femaleno)=="")
	{
		femaleno="0";
	}
	if(eval(femalecost)=="")
	{
		femalecost="0";
	}
	document.forms[0].txt_femaleamount.value=eval(femaleno)*eval(femalecost);
	if(document.forms[0].txt_femaleamount.value=="NaN")
	{
		document.forms[0].txt_femaleamount.value="0";
	}
	
	roundtxt(document.forms[0].txt_malecost);
	roundtxt(document.forms[0].txt_maleamount);
	roundtxt(document.forms[0].txt_femalecost);
	roundtxt(document.forms[0].txt_femaleamount);
}

function calltotal()
{
	var maleno=document.forms[0].txt_maleno.value;
	var femaleno=document.forms[0].txt_femaleno.value;
	if(eval(maleno)=="")
	{
		maleno="0";
	}
	if(eval(femaleno)=="")
	{
		femaleno="0";
	}
	document.forms[0].txt_totalanimalno.value=eval(maleno)+eval(femaleno);
	if(document.forms[0].txt_totalanimalno.value=="NaN")
	{
		document.forms[0].txt_totalanimalno.value="0";
	}
	var malecost=document.forms[0].txt_malecost.value;
	var femalecost=document.forms[0].txt_femalecost.value;
	if(eval(malecost)=="")
	{
		malecost="0";
	}
	if(eval(femalecost)=="")
	{
		femalecost="0";
	}
	document.forms[0].txt_totalanimalcost.value=eval(malecost)+eval(femalecost);
	if(document.forms[0].txt_totalanimalcost.value=="NaN")
	{
		document.forms[0].txt_totalanimalcost.value="0";
	}
	var maleamount=document.forms[0].txt_maleamount.value;
	var femaleamount=document.forms[0].txt_femaleamount.value;
	if(eval(maleamount)=="")
	{
		maleamount="0";
	}
	if(eval(femaleamount)=="")
	{
		femaleamount="0";
	}
	document.forms[0].txt_totalanimalamount.value=eval(maleamount)+eval(femaleamount);
	
	if(document.forms[0].txt_totalanimalamount.value=="NaN")
	{
		document.forms[0].txt_totalanimalamount.value="0";
	}
	
	roundtxt(document.forms[0].txt_malecost);
	roundtxt(document.forms[0].txt_maleamount);
	roundtxt(document.forms[0].txt_femalecost);
	roundtxt(document.forms[0].txt_femaleamount);
	roundtxt(document.forms[0].txt_totalanimalamount);
	roundtxt(document.forms[0].txt_totalanimalcost);
	
}

function onloading()
{	  
	//document.forms[0].cmdedit.disabled = false;
	if(sel_animal!="")
	{
		document.forms[0].sel_animal.value=sel_animal;
	}
	/*document.forms[0].txt_breed.value=txt_breed;
	document.forms[0].txt_agem.value=txt_agem;
	document.forms[0].txt_maleno.value=txt_maleno;
	document.forms[0].txt_malecost.value=txt_malecost;
	document.forms[0].txt_maleamount.value=txt_maleamount;
	document.forms[0].txt_agef.value=txt_agef;
    document.forms[0].txt_femaleno.value=txt_femaleno;
	document.forms[0].txt_femalecost.value=txt_femalecost;
	document.forms[0].txt_femaleamount.value=txt_femaleamount;
	document.forms[0].txt_totalanimalno.value=txt_totalanimalno;
	document.forms[0].txt_totalanimalcost.value=txt_totalanimalcost;
	document.forms[0].txt_totalanimalamount.value=txt_totalanimalamount;
	document.forms[0].txt_marketplace.value=txt_marketplace;
	document.forms[0].txt_markettranscost.value=txt_markettranscost;
	document.forms[0].txt_marketdistance.value=txt_marketdistance;
	document.forms[0].txt_markettransport.value=txt_markettransport;*/
	if(sel_purchase!="")
	{
		document.forms[0].sel_purchase.value=sel_purchase;
	}
	document.forms[0].txt_namepurcom.value=txt_namepurcom;
	document.forms[0].txt_per.value=txt_per;
	document.forms[0].txt_birth.value=txt_birth;
	document.forms[0].txt_annualper.value=txt_annualper;
   	document.forms[0].txt_annualpera.value=txt_annualpera;
    if(sel_flock!="")
	{
		document.forms[0].sel_flock.value=sel_flock;
	}
	document.forms[0].txt_migrationpattern.value=txt_migrationpattern;
	document.forms[0].txt_grazingpattern.value=txt_grazingpattern;
	document.forms[0].txt_greenfodder.value=txt_greenfodder;
	document.forms[0].txt_vtaidplace.value=txt_vtaidplace;
   	document.forms[0].txt_distancefarm.value=txt_distancefarm;
    document.forms[0].txt_woolplace.value=txt_woolplace;
   	document.forms[0].txt_distancewool.value=txt_distancewool;
    if(sel_care!="")
	{
		document.forms[0].sel_care.value=sel_care;
	}
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
    if(document.forms[0].sel_animal.value == "")
    {
	    alert('Select the type of animal');
	    document.forms[0].sel_animal.focus();
	    return;
    } 
    if(document.forms[0].txt_maleno.value == "")
    {
	    alert('Enter the no of animals');
	    document.forms[0].txt_maleno.focus();
	    return;
    }
    if(document.forms[0].txt_femaleno.value == "")
    {
	    alert('Enter the no of animals');
	    document.forms[0].txt_femaleno.focus();
	    return;
    }
   
	 if(document.forms[0].txt_malecost.value == "")
    {
	    alert('Enter the cost of animals');
	    document.forms[0].txt_malecost.focus();
	    return;
    }
     if(document.forms[0].txt_femalecost.value == "")
    {
	    alert('Enter the cost of animals');
	    document.forms[0].txt_femalecost.focus();
	    return;
    }
    var len = document.forms[0].sel_animal.length;	
    for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_animal.options[i].selected==true)
		 {
			 document.forms[0].sel_animal_text.value = document.forms[0].sel_animal.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_purchase.length;	
    for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_purchase.options[i].selected==true)
		 {
			 document.forms[0].sel_purchase_text.value = document.forms[0].sel_purchase.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_flock.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_flock.options[i].selected==true)
		 {
			 document.forms[0].sel_flock_text.value = document.forms[0].sel_flock.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_care.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_care.options[i].selected==true)
		 {
			 document.forms[0].sel_care_text.value = document.forms[0].sel_care.options[i].text; 
			break;
		 }
	}
	
    callamount();calltotal();
    enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrpoultry";		
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_techdata.jsp";
	document.forms[0].hidBeanMethod.value="updatesheeptechdata";
	document.forms[0].hidBeanGetMethod.value="getsheeptechdata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_maleamount.readOnly=true;
	document.forms[0].txt_femaleamount.readOnly=true;
	document.forms[0].txt_totalanimalno.readOnly=true;
	document.forms[0].txt_totalanimalcost.readOnly=true;
	document.forms[0].txt_totalanimalamount.readOnly=true;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheeptechdata";
		document.forms[0].action=appURL +"action/agr_sheep_techdata.jsp";
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
	 var len = document.forms[0].sel_animal.length;	
    for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_animal.options[i].selected==true)
		 {
			 document.forms[0].sel_animal_text.value = document.forms[0].sel_animal.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_purchase.length;	
    for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_purchase.options[i].selected==true)
		 {
			 document.forms[0].sel_purchase_text.value = document.forms[0].sel_purchase.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_flock.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_flock.options[i].selected==true)
		 {
			 document.forms[0].sel_flock_text.value = document.forms[0].sel_flock.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_care.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_care.options[i].selected==true)
		 {
			 document.forms[0].sel_care_text.value = document.forms[0].sel_care.options[i].text; 
			break;
		 }
	}
	
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatesheeptechdata";
		document.forms[0].hidBeanGetMethod.value="getsheeptechdata";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidSourceUrl.value="action/agr_sheep_techdata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}


</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();checkanimal();checkflock();checkpurchase()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
	<tr>
		<td valign="top"> 
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
					<tr>
						<td width="20%"></td>
						<td width="15%"></td>
						<td width="6%"></td>
						<td width="4%"></td>
						<td width="4%"></td>
						<td width="22%"></td>
						<td width="7%"></td>
						<td width="12%"></td>
					</tr>
					<tr>
						<td colspan="9">Particulars of Animals<b class="mantatory">*</b>
						<select name="sel_animal" onChange="checkanimal()">
							<option>--select--</option>
							<option value="1">Goat</option>
							<option value="2">Sheep</option>
							<option value="3">Rabbit</option>
							<option value="4">Pig</option>
						</select> </td>
					</tr>
					<tr>
						<td colspan="9">
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="dataheader" align="center">
								<td width="31%">Breed</td>
								<td width="13%">Type</td>
								<td width="17%">Age(Months)</td>
								<td width="13%">No. of Animals<b>(<b class="mantatory">*</b>)</b></td>
								<td width="8%">Cost per Animal(Rs.)<b>(<b class="mantatory">*</b>)</b></td>
								<td width="18%">Amount(Rs.)</td>
							</tr>
							<tr class="datagrid" align="center">
								<td rowspan="2" valign="center" align="center"><input type="text" name="txt_breed"
									value="<%=Helper.correctNull((String)hshValues.get("txt_breed"))%>"
									size="40%" onKeyPress="notAllowSplChar()"
									maxlength="49"></td>
								<td>Male</td>
								<td><input type="text" name="txt_agem"
									value="<%=Helper.correctNull((String)hshValues.get("txt_agem"))%>"
									size="12%" onKeyPress="allowInteger()" maxlength="3"></td>
								<td><input type="text" name="txt_maleno"
									value="<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>"
									size="12%" onKeyPress="allowInteger()" maxlength="4"
									onBlur="callamount();calltotal()"></td>
								<td><lapschoice:CurrencyTag name="txt_malecost"
									value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_malecost"))))%>'
									size="12%" onKeyPress="allowNumber(this)" maxlength="11"
									onBlur="callamount();calltotal()" /></td>
								<td><lapschoice:CurrencyTag name="txt_maleamount"
									value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_maleamount"))))%>'
									size="12%" onKeyPress="allowNumber(this)" maxlength="9"
									onBlur="calltotal()" /></td>
							</tr>
							<tr align="center" class="datagrid">
								<td>Female</td>
								<td><input type="text" name="txt_agef"
									value="<%=Helper.correctNull((String)hshValues.get("txt_agef"))%>"
									size="12%" onKeyPress="allowInteger()" maxlength="3"></td>
								<td><input type="text" name="txt_femaleno"
									value="<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>"
									size="12%" onKeyPress="allowInteger()" maxlength="4"
									onBlur="callamount();calltotal()"></td>
								<td><lapschoice:CurrencyTag name="txt_femalecost"
									value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_femalecost"))))%>'
									size="12%" onKeyPress="allowNumber(this)" maxlength="11"
									onBlur="callamount();calltotal()" /></td>
								<td><lapschoice:CurrencyTag name="txt_femaleamount"
									value='<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_femaleamount"))))%>'
									size="12%" onKeyPress="allowNumber(this)" maxlength="9"
									onBlur="calltotal()" /></td>
							</tr>
							<tr class="dataheader" align="center">
								<td align="center">Total</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><input type="text" name="txt_totalanimalno" value=""
									size="12%" onKeyPress="allowNumber(this)" maxlength="8"></td>
								<td><lapschoice:CurrencyTag name="txt_totalanimalcost"
									value='<%=Helper.correctNull((String)hshValues.get("txt_totalanimalcost"))%>'
									size="12%" onKeyPress="allowNumber(this)" maxlength="11" /></td>
								<td><lapschoice:CurrencyTag name="txt_totalanimalamount"
									value='<%=Helper.correctNull((String)hshValues.get("txt_totalanimalamount"))%>'
									size="12%" onKeyPress="allowNumber(this)" maxlength="9" /></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="9">
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<td colspan="4"><b><u>Market where animals are proposed to be purchased</u></b></td>
							</tr>
							<tr>
								<td width="26%">Place</td>
								<td width="28%"><input type="text" name="txt_marketplace"
									value="<%=Helper.correctNull((String)hshValues.get("txt_marketplace"))%>"
									size="20%" onKeyPress="notAllowSplChar()"
									maxlength="25"></td>
								<td width="18%">Distance
								from the Farm</td>
								<td width="28%"><input type="text" name="txt_marketdistance"
									value="<%=Helper.correctNull((String)hshValues.get("txt_marketdistance"))%>"
									size="12%" onKeyPress="allowNumber(this)" maxlength="5"> (KM)</td>
							</tr>
							<tr>
								<td width="26%">Mode of
								Transport</td>
								<td width="28%"><input type="text" name="txt_markettransport"
									value="<%=Helper.correctNull((String)hshValues.get("txt_markettransport"))%>"
									size="20%" onKeyPress="notAllowSplChar()"
									maxlength="30"></td>
								<td width="18%">Cost of
								Transport per Animal(Rs.)</td>
								<td width="28%"><lapschoice:CurrencyTag
									name="txt_markettranscost"
									value='<%=Helper.correctNull((String)hshValues.get("txt_markettranscost"))%>'
									size="12%" onKeyPress="allowNumber(this)" maxlength="6" /></td>
							</tr>
							<tr>
								<td width="26%">Purchased
								Through</td>
								<td width="28%"> <select
									name="sel_purchase" onChange="checkpurchase()">
									<option value="0" selected>select</option>
									<option value="1">Purchase Committe</option>
									<option value="2">Own Arrangements</option>
								</select> </td>
								<td width="18%" id="r9">Name
								of purchase Committe </td>
								<td width="28%" id="r4"> <input
									type="text" name="txt_namepurcom"
									value="<%=Helper.correctNull((String)hshValues.get("txt_namepurcom"))%>"
									size="20%" onKeyPress="notAllowSplChar()"
									maxlength="29"> </td>
							</tr>
							<tr>
								<td width="26%"> percentage
								of </td>
								<td width="28%"> <input
									type="text" name="txt_kids1"
									value="<%=Helper.correctNull((String)hshValues.get("sheep_kids1"))%>"
									size="12%" onKeyPress="notAllowSplChar()"
									maxlength="8"> is <input type="text" name="txt_per"
									value="<%=Helper.correctNull((String)hshValues.get("txt_per"))%>"
									size="12%" onKeyPress="allowNumber(this)" maxlength="6"
									onblur="checkPercentage(this);"> </td>
								<td width="18%">&nbsp;</td>
								<td width="28%"> </td>
							</tr>
							<tr>
								<td width="26%">Male to
								Female ratio of </td>
								<td width="28%"> <input
									type="text" name="txt_kids2"
									value="<%=Helper.correctNull((String)hshValues.get("sheep_kids2"))%>"
									size="12%" onKeyPress="notAllowSplChar()"
									maxlength="8" > @birth is <input type="text" name="txt_birth"
									value="<%=Helper.correctNull((String)hshValues.get("txt_birth"))%>"
									size="12%" onKeyPress="notAllowSplChar()"
									maxlength="5" onblur="checkPercentage(this)"> </td>
								<td width="18%">&nbsp;</td>
								<td width="28%"> </td>
							</tr>
							<tr>
								<td width="26%">Annual
								Mortality Percentage of</td>
								<td width="28%"><input type="text" name="txt_kids3"
									value="<%=Helper.correctNull((String)hshValues.get("sheep_kids3"))%>"
									size="12%" onKeyPress="notAllowSplChar()"
									maxlength="8"> is <input
									type="text" name="txt_annualper"
									value="<%=Helper.correctNull((String)hshValues.get("txt_annualper"))%>"
									size="12%" onKeyPress="allowNumber(this)" maxlength="3"
									onblur="checkPercentage(this)"> </td>
								<td width="18%">&nbsp;</td>
								<td width="28%"> </td>
							</tr>
							<tr>
								<td width="26%">Annual
								Mortality Percentage in Adults is </td>
								<td width="28%"> <input
									type="text" name="txt_annualpera"
									value="<%=Helper.correctNull((String)hshValues.get("txt_annualpera"))%>"
									size="12%" onKeyPress="allowNumber(this)" maxlength="3"
									onblur="checkPercentage(this)"> </td>
								<td width="18%">&nbsp;</td>
								<td width="28%">&nbsp;</td>
							</tr>
							<tr>
								<td width="26%">Whether the
								Flock is </td>
								<td width="28%"> <select
									name="sel_flock" onChange="checkflock()">
									<option value="0" selected>select</option>
									<option value="1">Migratory</option>
									<option value="2">Range Fed</option>
									<option value="3">Stall Fed</option>
								</select> </td>
								<td colspan="2">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td width="44%" id="r6">Indicate
										Migration Pattern </td>
										<td width="56%" id="r1"> <input
											type="text" name="txt_migrationpattern"
											value="<%=Helper.correctNull((String)hshValues.get("txt_migrationpattern"))%>"
											size="20%" onKeyPress="notAllowSplChar()"
											maxlength="40"> </td>
									</tr>
									<tr>
										<td width="44%" id="r7">Indicate
										availibility of Grazing Land </td>
										<td width="56%" id="r2"> <input
											type="text" name="txt_grazingpattern"
											value="<%=Helper.correctNull((String)hshValues.get("txt_grazingpattern"))%>"
											size="20%" onKeyPress="notAllowSplChar()"
											maxlength="40"> </td>
									</tr>
									<tr>
										<td width="44%" id="r8">Indicate
										Arrangement for supply of Green Fodder </td>
										<td width="56%" id="r3"> <input
											type="text" name="txt_greenfodder"
											value="<%=Helper.correctNull((String)hshValues.get("txt_greenfodder"))%>"
											size="20%" onKeyPress="notAllowSplChar()"
											maxlength="40"> </td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td width="26%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td width="81%">Veterinary
										aid available at</td>
										<td width="19%" align="right">Place </td>
									</tr>
								</table>
								</td>
								<td width="28%"> <input
									type="text" name="txt_vtaidplace"
									value="<%=Helper.correctNull((String)hshValues.get("txt_vtaidplace"))%>"
									size="20%" onKeyPress="notAllowSplChar()"
									maxlength="20"> </td>
								<td width="18%">Distance
								From Farm</td>
								<td width="28%"> <input
									type="text" name="txt_distancefarm"
									value="<%=Helper.correctNull((String)hshValues.get("txt_distancefarm"))%>"
									size="12%" onKeyPress="allowNumber(this)" maxlength="3"> (KM)</td>
							</tr>
							<tr>
								<td width="26%">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td width="82%">Marketing
										of Animals/By Products</td>
										<td width="18%" align="right">Place </td>
									</tr>
								</table>
								</td>
								<td width="28%"> <input
									type="text" name="txt_woolplace"
									value="<%=Helper.correctNull((String)hshValues.get("txt_woolplace"))%>"
									size="20%" onKeyPress="notAllowSplChar()"
									maxlength="20"> </td>
								<td width="18%">Distance
								From Farm</td>
								<td width="28%"> <input
									type="text" name="txt_distancewool"
									value="<%=Helper.correctNull((String)hshValues.get("txt_distancewool"))%>"
									size="12%" onKeyPress="allowNumber(this)" maxlength="3"> (KM) </td>
							</tr>
							<tr>
								<td width="26%">Water
								Facility available </td>
								<td width="28%"> <input
									type="text" name="sheep_waterfac2"
									value="<%=Helper.correctNull((String)hshValues.get("sheep_waterfac"))%>"
									size="25%" onKeyPress="notAllowSplChar()"
									maxlength="10"> </td>
								<td width="18%">Electricity
								available </td>
								<td width="28%"> <input
									type="text" name="sheep_elecfac"
									value="<%=Helper.correctNull((String)hshValues.get("sheep_elecfac"))%>"
									size="25%" onKeyPress="notAllowSplChar()"
									maxlength="10"> </td>
							</tr>
							<tr>
								<td width="26%">Who Will
								take care of the Animal </td>
								<td width="28%"> <select
									name="sel_care" onChange="">
									<option value="0" selected>select</option>
									<option value="1">Self with Family members</option>
									<option value="2">Employees/Labourers</option>
								</select> </td>
								<td width="18%">Market
								Facility</td>
								<td width="28%"><input type="text" name="txt_market"
									value="<%=Helper.correctNull((String)hshValues.get("sheep_marketfacility"))%>"
									size="25%" onKeyPress="notAllowSplChar()"
									maxlength="10"></td>
							</tr>
							<tr>
								<td width="26%">&nbsp;</td>
								<td width="28%">&nbsp;</td>
								<td width="18%">&nbsp;</td>
								<td width="28%">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="9"></td>
					</tr>
					<tr>
						<td colspan="9">
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td width="16%"></td>
								<td width="18%"></td>
								<td width="23%"></td>
								<td width="43%"></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
		</table>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="sel_animal_text" value=""> 
<input type="hidden" name="sel_purchase_text" value=""> 
<input type="hidden" name="sel_flock_text" value=""> 
<input type="hidden" name="sel_care_text" value="">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>"> 
</form>
</body>
</html>