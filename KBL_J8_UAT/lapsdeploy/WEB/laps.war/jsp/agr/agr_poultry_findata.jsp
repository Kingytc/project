<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = new ArrayList();
			ArrayList arryRow = new ArrayList();

			arryRow = (ArrayList) hshValues.get("arryRow");

			if (arryRow == null) {
				arryRow = new ArrayList();
			}
			ArrayList arryCol1 = new ArrayList();
			ArrayList arryRow1 = new ArrayList();

			arryRow1 = (ArrayList) hshValues.get("arryRow1");

			if (arryRow1 == null) {
				arryRow1 = new ArrayList();
			}
			//String l14="",d14="",m14="",n14="",l15="",m15="",n15="",l11="",d11="",m11="",n11="",l12="",d12="",m12="",n12="",l13="",m13="",n13="",d13="";
			String d15 = "", l1 = "", d1 = "", u1 = "", w1 = "";
			String l2 = "", d2 = "", u2 = "", w2 = "", m1 = "", m2 = "";
			//String u11="",w11="",k11="",r11="",u12="",w12="",k12="",r12="",u13="",w13="",k13="",r13="";

			%>
<html>
<head>
<title>Poultry Tech Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var txt_nochicks= "<%=Helper.correctNull((String)hshValues.get("txt_nochicks"))%>";
var txt_costchicks= "<%=Helper.correctNull((String)hshValues.get("txt_costchicks"))%>" ;
var txt_costchickmash= "<%=Helper.correctNull((String)hshValues.get("txt_costchickmash"))%>";
var txt_conchickmash= "<%=Helper.correctNull((String)hshValues.get("txt_conchickmash"))%>" ;
var txt_costgrowermash= "<%=Helper.correctNull((String)hshValues.get("txt_costgrowermash"))%>" ; 
var txt_congrowermash= "<%=Helper.correctNull((String)hshValues.get("txt_congrowermash"))%>" ;
var txt_costlayermash= "<%=Helper.correctNull((String)hshValues.get("txt_costlayermash"))%>" ;
var txt_conlayermash= "<%=Helper.correctNull((String)hshValues.get("txt_conlayermash"))%>" ;
var txt_broodingmor = "<%=Helper.correctNull((String)hshValues.get("txt_broodingmor"))%>" ;
var txt_growingmor= "<%=Helper.correctNull((String)hshValues.get("txt_growingmor"))%>" ;
var txt_layingmor = "<%=Helper.correctNull((String)hshValues.get("txt_layingmor"))%>" ;
var txt_specify1= "<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>" ;
var txt_specify2= "<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>" ;
var txt_electricitycharge= "<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>" ;
var txt_watercharge = "<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>" ;
var txt_vtaid= "<%=Helper.correctNull((String)hshValues.get("txt_vtaid"))%>" ;
var txt_inspremium= "<%=Helper.correctNull((String)hshValues.get("txt_inspremium"))%>" ;
var txt_yieldegg= "<%=Helper.correctNull((String)hshValues.get("txt_yieldegg"))%>" ;
var txt_saleegg= "<%=Helper.correctNull((String)hshValues.get("txt_saleegg"))%>" ;
var txt_saleculled= "<%=Helper.correctNull((String)hshValues.get("txt_saleculled"))%>" ;
var txt_growershed= "<%=Helper.correctNull((String)hshValues.get("txt_growershed"))%>" ;
var txt_yieldmanure= "<%=Helper.correctNull((String)hshValues.get("txt_yieldmanure"))%>" ;
var txt_salemanure= "<%=Helper.correctNull((String)hshValues.get("txt_salemanure"))%>" ;
var txt_salegunny= "<%=Helper.correctNull((String)hshValues.get("txt_salegunny"))%>" ;
var txt_emptybag= "<%=Helper.correctNull((String)hshValues.get("txt_emptybag"))%>" ;
var txt_transportcharge= "<%=Helper.correctNull((String)hshValues.get("txt_transportcharge"))%>" ;

</script>

<script>
function onloading()
{	  
	/*if (document.forms[0].app_status.value!="")
	{
		if (document.forms[0].app_status.value=="pa")
		{	
			 document.forms[0].cmdnew.disabled = true;
			 document.forms[0].cmdedit.disabled = true;
			 alert("unable to modify APPROVED APPLICATION !!!")
		}
	}*/
	
	/*document.forms[0].txt_nochicks.value=txt_nochicks;
	document.forms[0].txt_costchicks.value=txt_costchicks;
	document.forms[0].txt_costchickmash.value=txt_costchickmash;
	document.forms[0].txt_conchickmash.value=txt_conchickmash;
	document.forms[0].txt_costgrowermash.value=txt_costgrowermash;
	document.forms[0].txt_congrowermash.value=txt_congrowermash;
	document.forms[0].txt_costlayermash.value=txt_costlayermash;
	document.forms[0].txt_conlayermash.value=txt_conlayermash;
	document.forms[0].txt_broodingmor.value=txt_broodingmor;
	document.forms[0].txt_growingmor.value=txt_growingmor;
	document.forms[0].txt_layingmor.value=txt_layingmor;
	document.forms[0].txt_specify1.value=txt_specify1;
	document.forms[0].txt_specify2.value=txt_specify2;
    document.forms[0].txt_electricitycharge.value=txt_electricitycharge;
	document.forms[0].txt_watercharge.value=txt_watercharge;
	document.forms[0].txt_vtaid.value=txt_vtaid;
	document.forms[0].txt_inspremium.value=txt_inspremium;
    document.forms[0].txt_yieldegg.value=txt_yieldegg;
	document.forms[0].txt_saleegg.value=txt_saleegg;
	document.forms[0].txt_saleculled.value=txt_saleculled;
	document.forms[0].txt_yieldmanure.value=txt_yieldmanure;
    document.forms[0].txt_salemanure.value=txt_salemanure;
	document.forms[0].txt_salegunny.value=txt_salegunny;
	document.forms[0].txt_emptybag.value=txt_emptybag;
	document.forms[0].txt_transportcharge.value=txt_transportcharge;
	*/
	disableFields(true);
	totalchicks();
	totalmortality();totbag();
	totalcost();callyield();totculls();calltotmanure();	
}
function callsalary()
{
 for(var i=0;i<=4;i++)
	{		
  	var value1=document.forms[0].txt_noperson[i].value;
	var value2 =  document.forms[0].txt_salarypm[i].value;
	var value3=eval(value1)*eval(value2);
	if(eval(value3==""))
	{
	value3="0";
	}
	document.forms[0].txt_salarypy[i].value=NanNumber(eval(value3));
	roundtxt(document.forms[0].txt_salarypy[i]);
	if(document.forms[0].txt_salarypy[i].value=="NaN")
	{
	document.forms[0].txt_salarypy[i].value="0";
	}
		}
}
function totalchicks()
{
var nochicks=document.forms[0].txt_nochicks.value;
var costchicks=document.forms[0].txt_costchicks.value;
if(eval(nochicks)=="")
{
nochicks="0";
}
if(eval(costchicks)=="")
{
costchicks="0";
}
document.forms[0].txt_totalcostchicks.value=NanNumber(eval(nochicks)*eval(costchicks));
roundtxt(document.forms[0].txt_totalcostchicks);

if(document.forms[0].txt_totalcostchicks.value=="NaN")
{
document.forms[0].txt_totalcostchicks.value="0";
}
}
function totalmortality()
{
var nochicks=document.forms[0].txt_nochicks.value;
var broodingmor=document.forms[0].txt_broodingmor.value;
var growingmor=document.forms[0].txt_growingmor.value;
var layingmor=document.forms[0].txt_layingmor.value;
var str=Math.round((eval(broodingmor)/100)*eval(nochicks));
var broodmor=eval(nochicks)-eval(str);
document.forms[0].txt_broodingchicks.value=NanNumber(eval(broodmor));
var str1=Math.round((eval(growingmor)/100)*eval(broodmor));
var growmor=eval(broodmor)-eval(str1);
document.forms[0].txt_growingchicks.value=NanNumber(eval(growmor));
var str2=Math.round((eval(layingmor)/100)*eval(growmor));
var laymor=eval(growmor)-eval(str2);
document.forms[0].txt_layingchicks.value=NanNumber(eval(laymor));
if(document.forms[0].txt_layingchicks.value=="NaN")
{
document.forms[0].txt_layingchicks.value="0";
}

}
function constotal()
{
	var chicks=document.forms[0].txt_nochicks.value;
	var brood=document.forms[0].txt_broodingchicks.value;
	var grow=document.forms[0].txt_growingchicks.value;
	var lay=document.forms[0].txt_layingchicks.value;
	var costchickmash=document.forms[0].txt_costchickmash.value;
	var conchickmash=document.forms[0].txt_conchickmash.value;
	var costgrowermash=document.forms[0].txt_costgrowermash.value;
	var congrowermash=document.forms[0].txt_congrowermash.value;
	var costlayermash=document.forms[0].txt_costlayermash.value;
	var conlayermash=document.forms[0].txt_conlayermash.value;
	
	document.forms[0].txt_totalchickmash.value=NanNumber(Math.round((eval(costchickmash)*eval(conchickmash)*eval(chicks))));
	roundtxt(document.forms[0].txt_totalchickmash);
	document.forms[0].txt_totalgrowermash.value=NanNumber(Math.round((eval(costgrowermash)*eval(congrowermash)*eval(brood))));
	roundtxt(document.forms[0].txt_totalgrowermash);
	document.forms[0].txt_totallayermash.value=NanNumber(Math.round((eval(costlayermash)*eval(conlayermash)*eval(grow))));
	roundtxt(document.forms[0].txt_totallayermash);
	
	if(document.forms[0].txt_totalchickmash.value=="NaN")
	{
		document.forms[0].txt_totalchickmash.value="0";
	}
}
function totalcost()
{
var chicks=document.forms[0].txt_nochicks.value;
var vtaid=document.forms[0].txt_vtaid.value;
var inspremium=document.forms[0].txt_inspremium.value;
var aidexp=eval(chicks)*eval(vtaid);
var totinspremium=eval(chicks)*eval(inspremium);

document.forms[0].txt_totalinspremium.value=eval(totinspremium);
roundtxt(document.forms[0].txt_totalinspremium);
document.forms[0].txt_totalvtaid.value=eval(aidexp);
roundtxt(document.forms[0].txt_totalvtaid);
if(document.forms[0].txt_totalinspremium.value=="NaN.00")
{
document.forms[0].txt_totalinspremium.value="0.00";
}
if(document.forms[0].txt_totalvtaid.value=="NaN.00")
{
document.forms[0].txt_totalvtaid.value="0.00";
}
}
function callyield()
{
	var yieldegg=document.forms[0].txt_yieldegg.value;
	var salegg=document.forms[0].txt_saleegg.value;
	var broodingmor=document.forms[0].txt_broodingchicks.value;
	var growingmor=document.forms[0].txt_growingchicks.value;
	var layingmor=document.forms[0].txt_layingchicks.value;
	if(yieldegg=="")
	{
		yieldegg=0;
	}
	if(salegg=="")
	{
		salegg=0;
	}
	if(growingmor=="")
	{
		growingmor=0;
	}
	document.forms[0].txt_totsaleegg.value=eval((yieldegg)*eval(salegg)*eval(growingmor));
	roundtxt(document.forms[0].txt_totsaleegg);
	if(document.forms[0].txt_totsaleegg.value=="NaN.00")
	{
		document.forms[0].txt_totsaleegg.value="0.00";
	}
}
function totculls()
{
var broodingmor=document.forms[0].txt_broodingchicks.value;
var growingmor=document.forms[0].txt_growingchicks.value;
var layingmor=document.forms[0].txt_layingchicks.value;
var saleculled=document.forms[0].txt_saleculled.value;
document.forms[0].txt_totsaleculled.value=eval(saleculled)*eval(layingmor);
roundtxt(document.forms[0].txt_totsaleculled);
if(document.forms[0].txt_totsaleculled.value=="NaN.00")
{
document.forms[0].txt_totsaleculled.value="0";
}
}
function calltotmanure()
{
var yieldmanure=document.forms[0].txt_yieldmanure.value;
var salemanure=document.forms[0].txt_salemanure.value;
var broodingmor=document.forms[0].txt_broodingchicks.value;
var growingmor=document.forms[0].txt_growingchicks.value;
var layingmor=document.forms[0].txt_layingchicks.value;

layingmor=eval(layingmor)/1000;
document.forms[0].txt_totsalemanure.value=Math.round(eval(layingmor)*eval(yieldmanure)*eval(salemanure));
roundtxt(document.forms[0].txt_totsalemanure);
if(document.forms[0].txt_totsalemanure.value=="NaN.00")
{
document.forms[0].txt_totsalemanure.value="0";
}
}
function totbag()
{
var salegunny=document.forms[0].txt_salegunny.value;
var emptybag=document.forms[0].txt_emptybag.value;
var broodingmor=document.forms[0].txt_broodingchicks.value;
var growingmor=document.forms[0].txt_growingchicks.value;
var layingmor=document.forms[0].txt_layingchicks.value;

layingmor=eval(layingmor)/100;
document.forms[0].txt_totsalebag.value=Math.round(eval(layingmor)*eval(salegunny)*eval(emptybag));
roundtxt(document.forms[0].txt_totsalebag);
if(document.forms[0].txt_totsalebag.value=="NaN.00")
{
document.forms[0].txt_totsalebag.value="0";
}
}
function callTotal()
{
callsalary();
var totalval1=0.00;
var totalval2=0.00;var totalval3=0.00;
 for(var i=0;i<=4;i++)
	{		
       var value3=document.forms[0].txt_salarypy[i].value;
		var value1=document.forms[0].txt_noperson[i].value;
		var value2 =  document.forms[0].txt_salarypm[i].value;
		if(value2=="")
		{
			value2=0.00;
		}
		if(value1=="")
		{
			value1=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		totalval1 = eval(value1)+eval(totalval1)
		totalval2 = NanNumber(eval(value2)+eval(totalval2))
		totalval3 = NanNumber(eval(value3)+eval(totalval3))	
	}
document.forms[0].txt_totalnopersons.value= totalval1;
document.forms[0].txt_totalsalarypm.value= totalval2;
roundtxt(document.forms[0].txt_totalsalarypm);
document.forms[0].txt_totalsalarypy.value= totalval3;
roundtxt(document.forms[0].txt_totalsalarypy);

}
function callconsumption()
{
	var txt_conchickmash=document.forms[0].txt_conchickmash.value;
	var txt_congrowermash=document.forms[0].txt_congrowermash.value;
	var txt_conlayermash=document.forms[0].txt_conlayermash.value;
	if(txt_conchickmash=="")
	{
		txt_conchickmash="0";
	}
	if(txt_congrowermash=="")
	{
		txt_congrowermash="0";
	}
	if(txt_conlayermash=="")
	{
		txt_conlayermash="0";
	}
	document.forms[0].txt_totalfeedcon.value=eval(txt_conchickmash)+eval(txt_congrowermash)+eval(txt_conlayermash);
}

function callMortality()
{
	var txt_broodingmor=document.forms[0].txt_broodingmor.value;
	var txt_growingmor=document.forms[0].txt_growingmor.value;
	var txt_layingmor=document.forms[0].txt_layingmor.value;
	if(txt_broodingmor=="")
	{
		txt_broodingmor="0";
	}
	if(txt_growingmor=="")
	{
		txt_growingmor="0";
	}
	if(txt_layingmor=="")
	{
		txt_layingmor="0";
	}
	document.forms[0].txt_totalmor.value=eval(txt_broodingmor)+eval(txt_growingmor)+eval(txt_layingmor);
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

     if(document.forms[0].txt_costchicks.value=="")
	{
	alert("Enter Cost per chick");
	document.forms[0].txt_costchicks.focus();
	return;
	}  
	if(document.forms[0].txt_broodingmor.value=="")
	{
	alert("Enter Brooding % of Mortality");
	document.forms[0].txt_broodingmor.focus();
	return;
	} 
    if(document.forms[0].txt_growingmor.value=="")
	{
	alert("Enter Growing % of Mortality ");
	document.forms[0].txt_growingmor.focus();
	return;
	}  
	if(document.forms[0].txt_layingmor.value=="")
	{
	alert("Enter Laying % of Mortality ");
	document.forms[0].txt_layingmor.focus();
	return;
	}  

    if(document.forms[0].txt_yieldegg.value=="")
	{
	alert("Enter Average Yield of Eggs per bird/year ");
	document.forms[0].txt_yieldegg.focus();
	return;
	}  




    enableButtons(true, true, true, true, true, false);
	callMortality();callconsumption();
	callTotal();
	totalchicks();
	totalmortality();totbag();
	totalcost();callyield();totculls();calltotmanure();
	document.forms[0].hidBeanId.value="agrpoultry";		
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_findata.jsp";
	document.forms[0].hidBeanMethod.value="updatepoultryfindata";
	document.forms[0].hidBeanGetMethod.value="getpoultryfindata";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function check()
{
if(document.forms[0].txt_totalcostchicks.value="NaN")
{
document.forms[0].txt_totalcostchicks.value="0";
}
if(document.forms[0].txt_totalchickmash.value="NaN")
{
document.forms[0].txt_totalchickmash.value="0";
}
if(document.forms[0].txt_totalgrowermash.value="NaN")
{
document.forms[0].txt_totalgrowermash.value="0";
}
if(document.forms[0].txt_totallayermash.value="NaN")
{
document.forms[0].txt_totallayermash.value="0";
}
if(document.forms[0].txt_broodingchicks.value="NaN")
{
document.forms[0].txt_broodingchicks.value="0";
}
if(document.forms[0].txt_growingchicks.value="NaN")
{
document.forms[0].txt_growingchicks.value="0";
}
if(document.forms[0].txt_layingchicks.value="NaN")
{
document.forms[0].txt_layingchicks.value="0";
}
if(document.forms[0].txt_totalvtaid.value="NaN")
{
document.forms[0].txt_totalvtaid.value="0";
}
if(document.forms[0].txt_totalinspremium.value="NaN")
{
document.forms[0].txt_totalinspremium.value="0";
}
if(document.forms[0].txt_totsaleegg.value="NaN")
{
document.forms[0].txt_totsaleegg.value="0";
}
if(document.forms[0].txt_totsaleculled.value="NaN")
{
document.forms[0].txt_totsaleculled.value="0";
}
if(document.forms[0].txt_totsalemanure.value="NaN")
{
document.forms[0].txt_totsalemanure.value="0";
}
if(document.forms[0].txt_totsalebag.value="NaN")
{
document.forms[0].txt_totsalebag.value="0";
}
}
function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_totalfeedcon.readOnly=true;
	document.forms[0].txt_totalmor.readOnly=true;
	document.forms[0].txt_totalcostchicks.readOnly=true;
	document.forms[0].txt_totalchickmash.readOnly=true;
	document.forms[0].txt_totalgrowermash.readOnly=true;
	document.forms[0].txt_totallayermash.readOnly=true;
	document.forms[0].txt_broodingchicks.readOnly=true;
	document.forms[0].txt_growingchicks.readOnly=true;
	document.forms[0].txt_layingchicks.readOnly=true;
	document.forms[0].txt_totsalebag.readOnly=true;
	document.forms[0].txt_totalvtaid.readOnly=true;
	document.forms[0].txt_totalinspremium.readOnly=true;
	document.forms[0].txt_totsaleegg.readOnly=true;
	document.forms[0].txt_totsaleculled.readOnly=true;
	document.forms[0].txt_totsalemanure.readOnly=true;
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, true, false, false, false, true);
		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getpoultryfindata";
		document.forms[0].action=appURL +"action/agr_poultry_findata.jsp";
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
		document.forms[0].hidBeanMethod.value="updatepoultryfindata";
		document.forms[0].hidBeanGetMethod.value="getpoultryfindata";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidSourceUrl.value="action/agr_poultry_findata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

function placeValues()
{
	<%
		if(arryRow1.size()!=0)
		{
			
			for(int i=0;i<arryRow1.size();i++)
			{	
				arryCol1 = (ArrayList)  arryRow1.get(i);
				
				if(arryCol1!=null)
				{%>
					document.forms[0].txt_exp[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(0))%>";
					document.forms[0].txt_iyear[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(1))%>";
				<%}
			}
		}
	arryRow1 = (ArrayList) hshValues.get("arryRow2");%>
	
	
	<%if(arryRow1!=null && arryRow1.size()!=0)
	{
		
		for(int i=0;i<arryRow1.size();i++)
		{	
			arryCol1 = (ArrayList)  arryRow1.get(i);
			
			if(arryCol1!=null)
			{%>
				document.forms[0].txt_src[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(0))%>";
				document.forms[0].txt_iyearsrc[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(1))%>";
				document.forms[0].txt_iiyearsrc[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(2))%>";
				document.forms[0].txt_iiiyearsrc[<%=i%>].value="<%=Helper.correctNull((String)arryCol1.get(3))%>";
			
			<%}
		}
	}
	%>
	
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues();onloading();callMortality();callconsumption();callTotal();constotal()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
<tr>
 <td>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr class="dataheader">
		<td colspan="3" align="center">Financial Data</td>
	</tr>
	<tr>
		<td width="45%">No. of chicks
		purchased per batch</td>
		<td width="3%">&nbsp;</td>
		<td width="52%"> <input
			type="text" name="txt_nochicks"
			value="<%=Helper.correctNull((String)hshValues.get("txt_nochicks"))%>"
			size="10" onKeyPress="allowInteger()" maxlength="5"
			onBlur="totalchicks()"> </td>
	</tr>
	<tr>
		<td width="45%">Cost per chick<b class="mantatory">*</b></td>
		<td width="3%"><%=ApplicationParams.getCurrency()%></td>
		<td width="52%"><lapschoice:CurrencyTag
			name="txt_costchicks"
			value='<%=Helper.correctNull((String)hshValues.get("txt_costchicks"))%>'
			size="10" onKeyPress="allowNumber(this)" maxlength="5"
			onBlur="totalchicks()" /> </td>
	</tr>
	<tr>
		<td width="45%">Cost of chicks per
		batch</td>
		<td width="3%"><%=ApplicationParams.getCurrency()%></td>
		<td width="52%"> <lapschoice:CurrencyTag
			name="txt_totalcostchicks" value='' size="18"
			onKeyPress="allowNumber(this)" maxlength="25" /> </td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr class="dataheader">
		<td colspan="8" align="center">Mortality Provision </td>
	</tr>
	<tr>
		<td colspan="8" align="center">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td width="34%" align="center">Stage</td>
				<td width="23%" align="center">% of Mortality<b class="mantatory">*</b></td>
				<td width="43%" align="center">No. of Chicks per Batch(After
				Mortality)</td>
			</tr>
			<tr>
				<td align="center">Brooding</td>
				<td align="center"><input type="text" name="txt_broodingmor"
					value="<%=Helper.correctNull((String)hshValues.get("txt_broodingmor"))%>"
					size="8" onKeyPress="allowNumber(this)" maxlength="5"
					onBlur="checkPercentage(this);callMortality();totalmortality()"></td>
				<td align="center"> <input
					type="text" name="txt_broodingchicks" value="" size="10"
					onKeyPress="allowNumber(this)" maxlength="6"> </td>
			</tr>
			<tr>
				<td align="center">Growing</td>
				<td align="center"><input type="text" name="txt_growingmor"
					value="<%=Helper.correctNull((String)hshValues.get("txt_growingmor"))%>"
					size="8" onKeyPress="allowNumber(this)" maxlength="5"
					onBlur="checkPercentage(this);callMortality();totalmortality()"></td>
				<td align="center"> <input
					type="text" name="txt_growingchicks" value="" size="10"
					onKeyPress="allowNumber(this)" maxlength="5"> </td>
			</tr>
			<tr>
				<td align="center">Laying</td>
				<td align="center"><input type="text" name="txt_layingmor"
					value="<%=Helper.correctNull((String)hshValues.get("txt_layingmor"))%>"
					size="8" onKeyPress="allowNumber(this)" maxlength="3"
					onBlur="checkPercentage(this);callMortality();totalmortality()"></td>
				<td align="center"> <input
					type="text" name="txt_layingchicks" value="" size="10"
					onKeyPress="allowNumber(this)" maxlength="5"> </td>
			</tr>
			<tr class="dataheader">
				<td align="center">Total</td>
				<td align="center"><input type="text" name="txt_totalmor" value=""
					size="8" onKeyPress="allowNumber(this)" maxlength="5"></td>
				<td align="center">&nbsp;</td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td colspan="5" align="center">Feeding Expenses </td>
			</tr>
			<tr class="dataheader">
				<td width="12%" align="center">Type of feed</td>
				<td width="18%" align="center">cost per kg(Rs.)</td>
				<td align="center" colspan="2">consumption of feed/bird(Kgs)</td>
				<td width="37%" align="center">Total Cost of Consumption /batch(Rs.)</td>
			</tr>
			<tr>
				<td align="center" width="12%">Chick
				Mash</td>
				<td align="center" width="18%"><lapschoice:CurrencyTag
					name="txt_costchickmash"
					value='<%=Helper.correctNull((String)hshValues.get("txt_costchickmash"))%>'
					size="20%" onKeyPress="allowNumber(this)" maxlength="3" /></td>
				<td align="center" colspan="2">&nbsp;&nbsp;&nbsp; <input type="text"
					name="txt_conchickmash"
					value="<%=Helper.correctNull((String)hshValues.get("txt_conchickmash"))%>"
					size="20%" onKeyPress="allowNumber(this)" maxlength="5"
					onBlur="callconsumption();constotal();" style="text-align:left">(During Brooding Period)</td>
				<td align="center" width="37%">
				<lapschoice:CurrencyTag name="txt_totalchickmash" value=''
					size="20%" onKeyPress="allowNumber(this)" maxlength="6" /> </td>
			</tr>
			<tr>
				<td align="center" width="12%">Grower
				Mash</td>
				<td align="center" width="18%"><lapschoice:CurrencyTag
					name="txt_costgrowermash"
					value='<%=Helper.correctNull((String)hshValues.get("txt_costgrowermash"))%>'
					size="20%" onKeyPress="allowNumber(this)" maxlength="3" /></td>
				<td align="center" colspan="2">&nbsp;&nbsp; <input type="text"
					name="txt_congrowermash"
					value="<%=Helper.correctNull((String)hshValues.get("txt_congrowermash"))%>"
					size="20%" onKeyPress="allowNumber(this)" maxlength="5"
					onBlur="callconsumption();constotal();" style="text-align:left">(During Growing Period)</td>
				<td align="center" width="37%">
				<lapschoice:CurrencyTag name="txt_totalgrowermash" value=''
					size="20%" onKeyPress="allowNumber(this)" maxlength="6" /> </td>
			</tr>
			<tr>
				<td align="center" width="12%">Layer
				Mash</td>
				<td align="center" width="18%"><lapschoice:CurrencyTag
					name="txt_costlayermash"
					value='<%=Helper.correctNull((String)hshValues.get("txt_costlayermash"))%>'
					size="20%" onKeyPress="allowNumber(this)" maxlength="3" /></td>
				<td align="center" colspan="2"><input type="text"
					name="txt_conlayermash"
					value="<%=Helper.correctNull((String)hshValues.get("txt_conlayermash"))%>"
					size="20%" onKeyPress="allowNumber(this)" maxlength="5"
					onBlur="callconsumption();constotal();" style="text-align:left">(During Laying Period)</td>
				<td align="center" width="37%">
				<lapschoice:CurrencyTag name="txt_totallayermash" value=''
					size="20%" onKeyPress="allowNumber(this)" maxlength="6" /> </td>
			</tr>
			<tr class="dataheader">
				<td colspan="3" align="left">Total Feed Consumption per bird upto Culling(Kgs)
				</td>
				<td width="26%"><input type="text" name="txt_totalfeedcon"
					value="" size="20%" onKeyPress="allowNumber(this)" maxlength="6"
					style="text-align:left"></td>
				<td width="37%">&nbsp;</td>

			</tr>
		</table>

		</td>
	</tr>
	<tr class="dataheader">
		<td colspan="8" align="center">Expenditure on salaries/wages</td>
	</tr>
	<tr class="dataheader">
		<td align="center">Category</td>
		<td align="center">No.of
		Persons</td>
		<td align="center">Salary
		per month(Rs.)</td>
		<td colspan="5" align="center" nowrap>Total Salary(Rs.)</td>
	</tr>
	<tr>
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);

				if (arryCol.size() != 0) {

					l1 = Helper.correctNull((String) arryCol.get(2));
					d1 = Helper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				l1 = "0";
				d1 = "0";

			}

			%>
		<td>Labourers</td>
		<td align="center"><input type="text" name="txt_noperson"
			value="<%=l1%>" size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()"></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_salarypm"
			value='<%=d1%>' size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()" /></td>
		<td colspan="5" align="center"><lapschoice:CurrencyTag
			name="txt_salarypy" value='' size="20%" maxlength="6" /></td>
	</tr>
	<tr>
		<td align="">Manager</td>
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					u1 = Helper.correctNull((String) arryCol.get(2));
					w1 = Helper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				u1 = "0";
				w1 = "0";

			}

			%>
		<td align="center"><input type="text" name="txt_noperson"
			value="<%=u1%>" size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()"></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_salarypm"
			value='<%=w1%>' size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()" /></td>
		<td colspan="5" align="center"><lapschoice:CurrencyTag
			name="txt_salarypy" value='' size="20%"
			onKeyPress="allowNumber(this)" maxlength="6" /></td>
	</tr>
	<tr>
		<td>Supervisor</td>
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l2 = Helper.correctNull((String) arryCol.get(2));
					d2 = Helper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				l2 = "";
				d2 = "";

			}

			%>
		<td align="center"><input type="text" name="txt_noperson"
			value="<%=l2%>" size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()"></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_salarypm"
			value='<%=d2%>' size="20%" maxlength="6"
			onBlur="callTotal();callsalary()" /></td>
		<td colspan="5" align="center"><lapschoice:CurrencyTag
			name="txt_salarypy" value='' size="20%"
			onKeyPress="allowNumber(this)" maxlength="6" /></td>
	</tr>
	<tr>
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);

				if (arryCol.size() != 0) {

					u2 = Helper.correctNull((String) arryCol.get(2));
					w2 = Helper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				u2 = "";
				w2 = "";
			}

			%>
		<td><input type="text" name="txt_specify1"
			value="<%=Helper.correctNull((String)hshValues.get("txt_specify1"))%>"
			size="20%" onKeyPress="notAllowSplChar()" maxlength="99"></td>
		<td align="center"><input type="text" name="txt_noperson"
			value="<%=u2%>" size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()"></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_salarypm"
			value='<%=w2%>' size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()" /></td>
		<td colspan="5" align="center"><lapschoice:CurrencyTag
			name="txt_salarypy" value='' size="20%"
			onKeyPress="allowNumber(this)" maxlength="6" /></td>
	</tr>
	<tr>
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {

					m1 = Helper.correctNull((String) arryCol.get(2));
					m2 = Helper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				m1 = "";
				m2 = "";

			}

			%>
		<td><input type="text" name="txt_specify2"
			value="<%=Helper.correctNull((String)hshValues.get("txt_specify2"))%>"
			size="20%" onKeyPress="notAllowSplChar()" maxlength="99"></td>
		<td align="center"><input type="text" name="txt_noperson"
			value="<%=m1%>" size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()"></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_salarypm"
			value='<%=m2%>' size="20%" onKeyPress="allowNumber(this)"
			maxlength="6" onBlur="callTotal();callsalary()" /></td>
		<td colspan="5" align="center"><lapschoice:CurrencyTag
			name="txt_salarypy" value='' size="20%"
			onKeyPress="allowNumber(this)" maxlength="6" /></td>
	</tr>
	<tr class="dataheader">
		<td align="center">Total</td>
		<td align="center"><input type="text" name="txt_totalnopersons"
			value="" size="20%" onKeyPress="allowNumber(this)" maxlength="6"></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_totalsalarypm"
			value='' size="20%" onKeyPress="allowNumber(this)" maxlength="6" /></td>
		<td colspan="5" align="center"><lapschoice:CurrencyTag
			name="txt_totalsalarypy" value='' size="20%"
			onKeyPress="allowNumber(this)" maxlength="6" /></td>
	</tr>
	<tr class="dataheader">
		<td colspan="8" align="left"><strong>Miscellaneous Expenses on charges:</strong></td>
	</tr>
	<tr>
		<td colspan="2">Electricity</td>
		<td colspan="6">Rs. <lapschoice:CurrencyTag
			name="txt_electricitycharge"
			value='<%=Helper.correctNull((String)hshValues.get("txt_electricitycharge"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8" />per month</td>
	</tr>
	<tr>
		<td colspan="2">Water Charges</td>
		<td colspan="6">Rs. <lapschoice:CurrencyTag name="txt_watercharge"
			value='<%=Helper.correctNull((String)hshValues.get("txt_watercharge"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8" />per month</td>
	</tr>
	<tr>
		<td colspan="2">Veterinary Aid
		Expenses </td>
		<td colspan="5">Rs. <lapschoice:CurrencyTag name="txt_vtaid"
			value='<%=Helper.correctNull((String)hshValues.get("txt_vtaid"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="totalcost()" /> per Bird
		</td>
		<td>Cost per batch Rs. <lapschoice:CurrencyTag
			name="txt_totalvtaid" value='' size="20%"
			onKeyPress="allowNumber(this)" maxlength="6" /> </td>
	</tr>
	<tr>
		<td colspan="2">Insurance Premium</td>
		<td colspan="5">Rs. <lapschoice:CurrencyTag name="txt_inspremium"
			value='<%=Helper.correctNull((String)hshValues.get("txt_inspremium"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="totalcost()" /> per Bird
		</td>
		<td>Cost per batch Rs. <lapschoice:CurrencyTag
			name="txt_totalinspremium" value='' size="20%"
			onKeyPress="allowNumber(this)" maxlength="6" /> </td>
	</tr>
	<tr>
		<td colspan="2">Transportation
		Charges</td>
		<td colspan="6">Rs. <lapschoice:CurrencyTag name="txt_transportcharge"
			value='<%=Helper.correctNull((String)hshValues.get("txt_transportcharge"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8" />per Batch</td>
	</tr>
	<tr>
		<td colspan="8">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td>Other Expenses</td>
				<td>per month(Rs.)</td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_exp" value="" size="40%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td><lapschoice:CurrencyTag name="txt_iyear" value='' size="40%"
					onKeyPress="allowNumber(this)" maxlength="8" /></td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_exp" value="" size="40%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td><lapschoice:CurrencyTag name="txt_iyear" value='' size="40%"
					onKeyPress="allowNumber(this)" maxlength="8" /></td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_exp" value="" size="40%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td><lapschoice:CurrencyTag name="txt_iyear" value='' size="40%"
					onKeyPress="allowNumber(this)" maxlength="8" /></td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_exp" value="" size="40%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td><lapschoice:CurrencyTag name="txt_iyear" value='' size="40%"
					onKeyPress="allowNumber(this)" maxlength="8" /></td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_exp" value="" size="40%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td><lapschoice:CurrencyTag name="txt_iyear" value='<%=d15%>'
					size="40%" onKeyPress="allowNumber(this)" maxlength="8" /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">Average Yield of
		Eggs per bird(During Laying Period)<b><font size="1"
			color="#FF0000">*</b></td>
		<td colspan="6"><input type="text" name="txt_yieldegg"
			value="<%=Helper.correctNull((String)hshValues.get("txt_yieldegg"))%>"
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="callyield()"></td>
	</tr>
	<tr>
		<td colspan="2">Average sale price
		of eggs(Rs.)</td>
		<td colspan="6"><lapschoice:CurrencyTag name="txt_saleegg"
			value='<%=Helper.correctNull((String)hshValues.get("txt_saleegg"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="callyield()" /> /egg</td>
	</tr>
	<tr>
		<td colspan="2">Total sales realisation from eggs/batch(Rs.)</td>
		<td colspan="6"><lapschoice:CurrencyTag name="txt_totsaleegg" value=''
			size="20%" /></td>
	</tr>
	<tr>
		<td colspan="2">Average sale price
		of culled birds(Rs.)</td>
		<td colspan="6"><lapschoice:CurrencyTag name="txt_saleculled"
			value='<%=Helper.correctNull((String)hshValues.get("txt_saleculled"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="totculls()" /> /bird</td>
	</tr>
	<tr>
		<td colspan="2" nowrap>Total sales
		realisation from culled birds/batch(Rs.)</td>
		<td colspan="6"><lapschoice:CurrencyTag name="txt_totsaleculled"
			value='' size="20%" onKeyPress="allowNumber(this)" /></td>
	</tr>
	<tr>
		<td colspan="2">Average yield of
		manure per bird</td>
		<td colspan="6"><input type="text" name="txt_yieldmanure"
			value="<%=Helper.correctNull((String)hshValues.get("txt_yieldmanure"))%>"
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="calltotmanure()"> kgs</td>
	</tr>
	<tr>
		<td colspan="2">Average sale price
		of Manure(Rs.)</td>
		<td colspan="6"><lapschoice:CurrencyTag name="txt_salemanure"
			value='<%=Helper.correctNull((String)hshValues.get("txt_salemanure"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="calltotmanure()" /> /tonne</td>
	</tr>
	<tr>
		<td colspan="2" nowrap>Total sales
		realisation from Manure/batch(Rs.)</td>
		<td colspan="6"><lapschoice:CurrencyTag name="txt_totsalemanure"
			value='' size="20%" onKeyPress="allowNumber(this)" maxlength="8" /></td>
	</tr>
	<tr>
		<td colspan="2">Sale Price of
		empty Gunny Bags(Rs.)</td>
		<td colspan="6"><lapschoice:CurrencyTag name="txt_salegunny"
			value='<%=Helper.correctNull((String)hshValues.get("txt_salegunny"))%>'
			size="20%" onKeyPress="allowNumber(this)" maxlength="8"
			onBlur="totbag()" /> /bag
			<input type="hidden" name="txt_emptybag">
	<input type="hidden" name="txt_totsalebag">
			</td>
	</tr>
	
	<%--<tr > 
      <td colspan="2">No.of empty Gunny bags</td>
      <td colspan="6"><input type="text" name="txt_emptybag"  value="<%//=Helper.correctNull((String)hshValues.get("txt_emptybag"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="8" onBlur="totbag()">
        /100 birds</td>
    </tr>
    <tr > 
      <td colspan="2">Total sales realisation 
        from empty Gunny bags/batch(Rs.)</td>
      <td colspan="6"><lapschoice:CurrencyTag name="txt_totsalebag"  value=''  size="20%" onKeyPress="allowNumber(this)" maxlength="8"/></td>
    </tr>--%>
	<tr>
		<td colspan="8">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr class="dataheader">
				<td>Other Sources of Income</td>
				<td>I year(Rs.)</td>
				<td>II year(Rs.)</td>
				<td>III year(onwards)(Rs.)</td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_src" value="" size="20%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iiyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iiiyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_src" value="" size="20%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iiyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iiiyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
			</tr>
			<tr>

				<td> <input type="text"
					name="txt_src" value="" size="20%" onKeyPress="notAllowSplChar()"
					maxlength="80"> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iiyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>
				<td> <lapschoice:CurrencyTag
					name="txt_iiiyearsrc" value='' size="20%"
					onKeyPress="allowNumber(this)" maxlength="8" /> </td>

			</tr>
		</table>
		</td>
	</tr>
</table>
<p class="mantatory"><b> *
Incase of EMU/ Duck farming Economic Data related to male birds are to
be taken along with female birds</b></p>
</td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>">
</form>
</body>
</html>



