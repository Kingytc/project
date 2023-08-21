<%@include file="../share/directives.jsp"%>
<%
//ArrayList arryCol = new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow  = (ArrayList) hshValues.get("arryRow");
ArrayList arryCol1 = new ArrayList();
ArrayList arryCol2 = new ArrayList();
ArrayList arryRow1 = new ArrayList();
arryRow1  = (ArrayList) hshValues.get("arryRow1");
ArrayList arryRow2 = new ArrayList();
arryRow2  = (ArrayList) hshValues.get("arryRow2");

if (arryRow == null) {
	arryRow  = new ArrayList();
}
if (arryRow1 == null) {
	arryRow1  = new ArrayList();
}
if (arryRow2 == null) {
	arryRow2  = new ArrayList();
}
//String l14="",d14="",m14="",n14="";
//String a1="",l11="",d11="",m11="",n11="",l15="",m15="",n15="",d15="";
//String l12="",d12="",m12="",n12="",l13="",m13="",n13="",d13="";
//String a2="",a3="",a4="",a5="",a6="",a7="",a8="",a9="",a10="";
ArrayList arrSaleeggs  = (ArrayList) hshValues.get("arrSaleeggs");
ArrayList arrSalebirds  = (ArrayList) hshValues.get("arrSalebirds");
ArrayList arrSalemanure  = (ArrayList) hshValues.get("arrSalemanure");
ArrayList arrSalebag  = (ArrayList) hshValues.get("arrSalebag");
ArrayList arrincvalues  = (ArrayList) hshValues.get("arrincome");
ArrayList arrsurplus  = (ArrayList) hshValues.get("arrsurplus");
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
var  nodata="<%=Helper.correctNull((String)hshValues.get("nodata"))%>";
function costchicks()
{
var  txt_totalcostchicks="<%=Helper.correctNull((String)hshValues.get("txt_totalsaleegg"))%>";
/*for(var m=0;m<=7;m++)
{
var ibatch=document.forms[0].txt_ibatch[m].value
var iyear=eval(txt_totalcostchicks)*eval(ibatch);
document.forms[0].txt_ibatchiyear[m].value=NanNumber(eval(iyear));
roundtxt(document.forms[0].txt_ibatchiyear[m]);
}*/
}
function costfeed()
{
	var  txt_totalchickmash="<%=Helper.correctNull((String)hshValues.get("txt_totsaleculled"))%>";
	/*for(var m=0;m<=7;m++)
	{
		var ibatchfeed=document.forms[0].txt_ibatchfeed[m].value;
		var iiyear=eval(txt_totalchickmash)*eval(ibatchfeed);
		document.forms[0].txt_ibatchiiyear[m].value=NanNumber(eval(iiyear));
		roundtxt(document.forms[0].txt_ibatchiiyear[m]);
	}*/

}
function costgrower()
{
var  txt_totalgrowermash="<%=Helper.correctNull((String)hshValues.get("txt_totsalemanure"))%>";
/*for(var m=0;m<=7;m++)
{
var ibatchgrow=document.forms[0].txt_ibatchgrow[m].value
var iiiyear=eval(txt_totalgrowermash)*eval(ibatchgrow);
document.forms[0].txt_ibatchiiiyear[m].value=NanNumber(eval(iiiyear));
roundtxt(document.forms[0].txt_ibatchiiiyear[m]);
}*/

}
function costmanure()
{
	var  txt_totsalebag="<%=Helper.correctNull((String)hshValues.get("txt_conchickmash"))%>";
	var  txtChickenPurchased ="<%=Helper.correctNull((String)hshValues.get("txt_nochicks"))%>";
	var growing_Marsh ="<%=Helper.correctNull((String)hshValues.get("txt_growingmor"))%>";
	var layerMarsh ="<%=Helper.correctNull((String)hshValues.get("txt_layingmor"))%>";
	var txt_broodingmor = "<%=Helper.correctNull((String)hshValues.get("txt_broodingmor"))%>";
	var txt_salegunny = "<%=Helper.correctNull((String)hshValues.get("txt_salegunny"))%>";
	
	/*
	if(txt_broodingmor=="")
		txt_broodingmor ="0";
	
	if(txtChickenPurchased=="")
		txtChickenPurchased="0";
		
	if(txt_salegunny=="")
		txt_salegunny="0";	
	
	var str=Math.round((eval(txt_broodingmor)/100)*eval(txtChickenPurchased));
	var broodmor=eval(txtChickenPurchased)-eval(str);
	
	if(growing_Marsh=="")
	growing_Marsh ="0";
	var str1=Math.round((eval(growing_Marsh)/100)*eval(broodmor));
	var growmor=eval(broodmor)-eval(str1);
	
	var a="",b="",c="",totalValue="";;
	
	
	
	for(var m=0;m<=7;m++)
	{
		var borderBatches=document.forms[0].borderBatches[m].value;
		var txt_ibatchgrow = document.forms[0].txt_ibatchgrow[m].value;
		var txt_ibatch = document.forms[0].txt_ibatch[m].value;
		
		if(borderBatches=="")
			borderBatches="0";
		if(txt_ibatchgrow=="")
			txt_ibatchgrow="0";
		if(txt_ibatch=="")
			txt_ibatch="0";		
		
		a = (eval(txt_broodingmor) * eval(txtChickenPurchased) * eval(borderBatches));
		b = (eval(growing_Marsh) * eval(broodmor) * eval(txt_ibatchgrow));
		c = (eval(layerMarsh) * eval(growmor) * eval(txt_ibatch));
		
		totalValue = ((eval(a) + eval(b) + eval(c))/eval(100))*eval(txt_salegunny);
		
		document.forms[0].txt_ibatchivyear[m].value=NanNumber(eval(totalValue));
		roundtxt(document.forms[0].txt_ibatchivyear[m]);
	}
*/
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

function doSave()
{	
   
	enableButtons( true, true, true, true, false);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_layerinc.jsp";
	document.forms[0].hidBeanMethod.value="updatepoultryincomeflowData";
	document.forms[0].hidBeanGetMethod.value="getpoultryincomeflowData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(true);
   document.forms[0].hidAction.value ="insert";
   enableButtons(true, false, false, false, true);	
}

function callhelp()
{
	var varQryString = appURL+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="cancel";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getpoultryincomeflowData";
		document.forms[0].action=appURL+"action/agr_poultry_layerinc.jsp";
		document.forms[0].submit(); 		
	}
	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatepoultryincomeflowData";
	document.forms[0].hidBeanGetMethod.value="getpoultryincomeflowData";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_poultry_layerinc.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();
	}		
}

function onloading()
{	
	if(nodata=="Y")
	{
		alert("Enter Data in Layer Flock Replacement page");
	}
  
	disableFields(true);
}

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function calculate()
{
	
	/*var totalvalue1=0.00;var totalvalue2=0.00;
	for(var i=0;i<1;i++)
	{
		var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
		var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
		var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
		var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
		
		document.forms[0].txt_totiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
		roundtxt(document.forms[0].txt_totiyearu);

	}
for(var i=1;i<2;i++)
{
	var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
	var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
	var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
	var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;
	
	document.forms[0].txt_totaliiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
	roundtxt(document.forms[0].txt_totaliiyearu);
}
for(var i=2;i<3;i++)
{
var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;

document.forms[0].txt_totaliiiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
roundtxt(document.forms[0].txt_totaliiiyearu);
}
for(var i=3;i<4;i++)
{
var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;

document.forms[0].txt_totalivyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
roundtxt(document.forms[0].txt_totalivyearu);
}
for(var i=4;i<5;i++)
{
var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;

document.forms[0].txt_totalvyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
roundtxt(document.forms[0].txt_totalvyearu);
}
for(var i=5;i<6;i++)
{
var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;

document.forms[0].txt_totalviyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
roundtxt(document.forms[0].txt_totalviyearu);
}
for(var i=6;i<7;i++)
{
var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;

document.forms[0].txt_totalviiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
roundtxt(document.forms[0].txt_totalviiyearu);
}
for(var i=7;i<8;i++)
{
var txt_ibatchiyear=document.forms[0].txt_ibatchiyear[i].value;
var txt_ibatchiiyear=document.forms[0].txt_ibatchiiyear[i].value;
var txt_ibatchiiiyear=document.forms[0].txt_ibatchiiiyear[i].value;
var txt_ibatchivyear=document.forms[0].txt_ibatchivyear[i].value;

document.forms[0].txt_totalviiiyearu.value=NanNumber(eval(txt_ibatchiyear)+eval(txt_ibatchiiyear)+eval(txt_ibatchiiiyear)+eval(txt_ibatchivyear));
roundtxt(document.forms[0].txt_totalviiiyearu);


}

if(document.forms[0].inc_firstyear)
	{
		var len = document.forms[0].inc_firstyear.length;
		
		var total1="0",inc_firstyear="0";
		var total2="0",inc_secondyear="0";
		var total3="0",inc_thirdyear="0";
		var total4="0",inc_fourthyear="0";
		var total5="0",inc_fifthyear="0";
		var total6="0",inc_sixthyear="0";
		var total7="0",inc_seventhyear="0";
		var total8="0",inc_eigthyear="0";
		
		
		if(len==null)
		{
			if(document.forms[0].inc_firstyear.value=="")
				{
					document.forms[0].inc_firstyear.value="0";
				}
				if(document.forms[0].inc_secondyear.value=="")
				{
					document.forms[0].inc_secondyear.value="0";
				}
				if(document.forms[0].inc_thirdyear.value=="")
				{
					document.forms[0].inc_thirdyear.value="0";
				}
				if(document.forms[0].inc_fourthyear.value=="")
				{
					document.forms[0].inc_fourthyear.value="0";
				}
				if(document.forms[0].inc_fifthyear.value=="")
				{
					document.forms[0].inc_fifthyear.value="0";
				}
				if(document.forms[0].inc_sixthyear.value=="")
				{
					document.forms[0].inc_sixthyear.value="0";
				}
				if(document.forms[0].inc_seventhyear.value=="")
				{
					document.forms[0].inc_seventhyear.value="0";
				}
				if(document.forms[0].inc_eigthyear.value=="")
				{
					document.forms[0].inc_eigthyear.value="0";
				}
			
			total1 = document.forms[0].inc_firstyear.value;
			total2 = document.forms[0].inc_secondyear.value;
			total3 = document.forms[0].inc_thirdyear.value;
			total4 = document.forms[0].inc_fourthyear.value;
			total5 = document.forms[0].inc_fifthyear.value;
			total6 = document.forms[0].inc_sixthyear.value;
			total7 = document.forms[0].inc_seventhyear.value;
			total8 = document.forms[0].inc_eigthyear.value;
			
		}
		else
		{
		 	for(var i =0;i<len;i++)
			{
				inc_firsstyear = document.forms[0].inc_firstyear[i].value;
				inc_secondyear = document.forms[0].inc_secondyear[i].value;
				inc_thirdyear = document.forms[0].inc_thirdyear[i].value;
				inc_fourthyear = document.forms[0].inc_fourthyear[i].value;
				inc_fifthyear = document.forms[0].inc_fifthyear[i].value;
				inc_sixthyear = document.forms[0].inc_sixthyear[i].value;
				inc_seventhyear = document.forms[0].inc_seventhyear[i].value;
				inc_eigthyear = document.forms[0].inc_eigthyear[i].value;
				
				if(document.forms[0].inc_firstyear[i].value=="")
				{
					inc_firsstyear="0";
					document.forms[0].inc_firstyear[i].value="0";
				}
				if(document.forms[0].inc_secondyear[i].value=="")
				{
					inc_secondyear="0";
					document.forms[0].inc_secondyear[i].value="0";
				}
				if(document.forms[0].inc_thirdyear[i].value=="")
				{
					inc_thirdyear="0";
					document.forms[0].inc_thirdyear[i].value="0";
				}
				if(document.forms[0].inc_fourthyear[i].value=="")
				{
					inc_fourthyear="0";
					document.forms[0].inc_fourthyear[i].value="0";
				}
				if(document.forms[0].inc_fifthyear[i].value=="")
				{
					inc_fifthyear="0";
					document.forms[0].inc_fifthyear[i].value="0";
				}
				if(document.forms[0].inc_sixthyear[i].value=="")
				{
					inc_sixthyear="0";
					document.forms[0].inc_sixthyear[i].value="0";
				}
				if(document.forms[0].inc_seventhyear[i].value=="")
				{
					inc_seventhyear="0";
					document.forms[0].inc_seventhyear[i].value="0";
				}
				if(document.forms[0].inc_eigthyear[i].value=="")
				{
					inc_eigthyear="0";
					document.forms[0].inc_eigthyear[i].value="0";
				}
				
				total1 = eval(total1) + eval(inc_firsstyear);
				total2 = eval(total2) + eval(inc_secondyear);
				total3 = eval(total3) + eval(inc_thirdyear);
				total4 = eval(total4) + eval(inc_fourthyear);
				total5 = eval(total5) + eval(inc_fifthyear);
				total6 = eval(total6) + eval(inc_sixthyear);
				total7 = eval(total7) + eval(inc_seventhyear);
				total8 = eval(total8) + eval(inc_eigthyear);
			}
			
			document.forms[0].txt_totiyearu.value=eval(document.forms[0].txt_totiyearu.value)+eval(total1);
			document.forms[0].txt_totaliiyearu.value=eval(document.forms[0].txt_totaliiyearu.value)+eval(total2);
			document.forms[0].txt_totaliiiyearu.value=eval(document.forms[0].txt_totaliiiyearu.value)+eval(total3);
			document.forms[0].txt_totalivyearu.value=eval(document.forms[0].txt_totalivyearu.value)+eval(total4);
			document.forms[0].txt_totalvyearu.value=eval(document.forms[0].txt_totalvyearu.value)+eval(total5);
			document.forms[0].txt_totalviyearu.value=eval(document.forms[0].txt_totalviyearu.value)+eval(total6);
			document.forms[0].txt_totalviiyearu.value=eval(document.forms[0].txt_totalviiyearu.value)+eval(total7);

			document.forms[0].txt_totalviiiyearu.value=eval(document.forms[0].txt_totalviiiyearu.value)+eval(total8);
		}
	}
*/
}
function callsurplus()
{/*
var txt_totiyearu=document.forms[0].txt_totiyearu.value;
var txt_totaliyeare=document.forms[0].txt_totaliyeare.value;
//alert( txt_totaliyeare);
var txt_totiiyearu=document.forms[0].txt_totaliiyearu.value;
var txt_totaliiyeare=document.forms[0].txt_totaliiyeare.value;
var txt_totiiiyearu=document.forms[0].txt_totaliiiyearu.value;
var txt_totaliiiyeare=document.forms[0].txt_totaliiiyeare.value;
var txt_totivyearu=document.forms[0].txt_totalivyearu.value;
var txt_totalivyeare=document.forms[0].txt_totalivyeare.value;
var txt_totvyearu=document.forms[0].txt_totalvyearu.value;
var txt_totalvyeare=document.forms[0].txt_totalvyeare.value;
var txt_totviyearu=document.forms[0].txt_totalviyearu.value;
var txt_totalviyeare=document.forms[0].txt_totalviyeare.value;
var txt_totviiyearu=document.forms[0].txt_totalviiyearu.value;
var txt_totalviiyeare=document.forms[0].txt_totalviiyeare.value;
var txt_totviiiyearu=document.forms[0].txt_totalviiiyearu.value;
var txt_totalviiiyeare=document.forms[0].txt_totalviiiyeare.value;
document.forms[0].txt_totaliyears.value=NanNumber(eval(txt_totiyearu)-eval(txt_totaliyeare));
document.forms[0].txt_totaliiyears.value=NanNumber(eval(txt_totiiyearu)-eval(txt_totaliiyeare));
document.forms[0].txt_totaliiiyears.value=NanNumber(eval(txt_totiiiyearu)-eval(txt_totaliiiyeare));
document.forms[0].txt_totalivyears.value=NanNumber(eval(txt_totivyearu)-eval(txt_totalivyeare));
document.forms[0].txt_totalvyears.value=NanNumber(eval(txt_totvyearu)-eval(txt_totalvyeare));
document.forms[0].txt_totalviyears.value=NanNumber(eval(txt_totviyearu)-eval(txt_totalviyeare));
document.forms[0].txt_totalviiyears.value=NanNumber(eval(txt_totviiyearu)-eval(txt_totalviiyeare));
document.forms[0].txt_totalviiiyears.value=NanNumber(eval(txt_totviiiyearu)-eval(txt_totalviiiyeare));

roundtxt(document.forms[0].txt_totaliyears);
roundtxt(document.forms[0].txt_totaliiyears);
roundtxt(document.forms[0].txt_totaliiiyears);
roundtxt(document.forms[0].txt_totalivyears);
roundtxt(document.forms[0].txt_totalvyears);
roundtxt(document.forms[0].txt_totalviyears);
roundtxt(document.forms[0].txt_totalviiyears);
roundtxt(document.forms[0].txt_totalviiiyears);*/
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();costchicks();costfeed();costgrower();costmanure();calculate();callsurplus()">
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
                        <td > 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td rowspan="2" nowrap><b>Income on </b></td>
                              <td colspan="8" align="center"><b>(Amount 
                                in Rs.) </b></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td align="center"><b>I 
                                Year</b></td>
                              <td align="center"><b>II 
                                Year </b></td>
                              <td align="center"><b>III 
                                Year</b></td>
                              <td align="center"><b>IV 
                                Year</b></td>
                              <td align="center"><b>V 
                                Year</b></td>
                              <td align="center"><b>VI 
                                Year</b></td>
                              <td align="center"><b>VII 
                                Year</b></td>
                              <td align="center"><b>VIII 
                                Year</b></td>
                            </tr>
                            <tr> 
                              <td >Sale of Egg 
                             
                                <input type="hidden" name="txt_ibatch"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                 
                              
                              </td>
                              <td width="7%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="7%" align="center"><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/> </td>
                              <td width="7%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" align="center" ><lapschoice:CurrencyTag name="txt_ibatchiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td width="7%" align="center" > <lapschoice:CurrencyTag name="txt_ibatchiyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSaleeggs.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <td>Sale of 
                                Culled Bird 
                               
                              
                                <input type="hidden" name="txt_ibatchfeed"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                 
                            
                              </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiyear"  size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebirds.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <td>Sale of 
                                Manure 
                             
                                
                                <input type="hidden" name="txt_ibatchgrow"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                 
                              
                              </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalemanure.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalemanure.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrSalemanure.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrSalemanure.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrSalemanure.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrSalemanure.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrSalemanure.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchiiiyear"size="15" maxlength="15"
									value='<%=Helper.correctNull((String) arrSalemanure.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr> 
                              <td>Sale of 
                                Empty Gunny Bags 
                                
                               
                               
                                <input type="hidden" name="txt_ibatchfeed"size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                <input type="hidden" name="borderBatches" size="3"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                 
                              
                              </td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(2))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(3))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(4))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(5))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(6))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_ibatchivyear"size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrSalebag.get(7))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                         
                             
			
			
			<%
			if (arryRow1.size() != 0) 
			{
			   for(int i=0;i<arryRow1.size();i++)
			   {
			       arryCol1 = (ArrayList) arryRow1.get(i);
				   
				   %>
			
					   <tr> 
                              <td>&nbsp;<%=Helper.correctNull((String) arryCol1.get(0))%></td>
                              <td align="center"> 
                                <input type="text" name="inc_firstyear"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(1))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="inc_secondyear"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(2))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="inc_thirdyear"onFocus=""  size="15" maxlength="15"
									value="<%=Helper.correctNull((String) arryCol1.get(3))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td> 
                                <input type="text" name="inc_fourthyear"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(3))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="inc_fifthyear"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(3))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="inc_sixthyear"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(3))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="inc_seventhyear"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(3))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="inc_eigthyear"size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arryCol1.get(3))%>" onKeyPress="allowInteger()"
									style="text-align:right;">
                              </td>
                            </tr>
						<%
							}}
						%>	
                            <tr class="dataheader"> 
                              <td><b>Total(Income)</b></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(0))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(1))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliiiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(2))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalivyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(3))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalvyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(4))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(5))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(6))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviiiyearu" size="15"
									maxlength="15" value='<%=Helper.correctNull((String) arrincvalues.get(7))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td><b>Total(Expenses)</b></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totiyearexpenses"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliiyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totiiyearexpenses"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totaliiiyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totiiiyearexpenses"))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalivyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totivyearexpenses"))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalvyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totvyearexpenses"))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totviyearexpenses"))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviiyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totviiyearexpenses"))%>' onKeyPress="allowInteger()"
									 style="text-align:right;"/></td>
                              <td align="center"><lapschoice:CurrencyTag name="txt_totalviiiyeare" size="15"
									maxlength="15" value='<%=Helper.correctNull((String)hshValues.get("totviiiyearexpenses"))%>' onKeyPress="allowInteger()"
									style="text-align:right;"/></td>
                            </tr>
                            <tr class="dataheader"> 
                              <td><b>Total(Surplus)</b></td>
                              <td align="center"> 
                                <input type="text" name="txt_totaliyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(0))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="txt_totaliiyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(1))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="txt_totaliiiyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(2))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="txt_totalivyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(3))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="txt_totalvyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(4))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="txt_totalviyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(5))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="txt_totalviiyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(6))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
                              </td>
                              <td align="center"> 
                                <input type="text" name="txt_totalviiiyears" size="15"
									maxlength="15" value="<%=Helper.correctNull((String) arrsurplus.get(7))%>" onKeyPress="allowInteger()"
									readonly style="text-align:right;">
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
</td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag/>
</form>
</body>
</html>










