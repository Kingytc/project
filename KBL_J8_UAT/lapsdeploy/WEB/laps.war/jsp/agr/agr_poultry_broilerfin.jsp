<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@include file="../share/directives.jsp"%>

<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<%
			ArrayList arryCol = new ArrayList();
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
			ArrayList arryRow11 = (ArrayList) hshValues.get("arryRow11");
			if (arryRow11 == null) {
				arryRow11 = new ArrayList();
			}
			ArrayList arryCol2 = new ArrayList();
			ArrayList arryRow2 = new ArrayList();
			arryRow2 = (ArrayList) hshValues.get("arryRow2");
			if (arryRow2 == null) {
				arryRow2 = new ArrayList();
			}
			
			ArrayList arryColEgg = new ArrayList();
			ArrayList arryRowEgg = new ArrayList();
			arryRowEgg = (ArrayList) hshValues.get("arryRowEgg");
			if (arryRowEgg == null) {
				arryRowEgg = new ArrayList();
			}
			
			String l1 = "", d1 = "", u1 = "", w1 = "";
			String l2 = "", d2 = "", u2 = "", w2 = "", m1 = "", m2 = "";
			String u11 = "", w11 = "", k11 = "", r11 = "", u12 = "", w12 = "", k12 = "", r12 = "", u13 = "", w13 = "", k13 = "", r13 = "";
			String a11="",b11="",a12="",b12="",a13="",b13="";

			String strappno = FwHelper.correctNull((String) request
					.getParameter("appno"));
			if (strappno.equalsIgnoreCase("new")) {
				strappno = "";
			}
			ArrayList arryCol3 = new ArrayList();

			String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
			if(schemetype. trim().equalsIgnoreCase(""))
				{
					schemetype="0";
				}
			
			String strFacSNo=Helper.getfacilitySno(schemetype);
		    String strTypePoultry =FwHelper.correctNull((String)hshValues.get("poultry_poultrytype"));	
			%>
			
<html>
<head>
<title>Poultry Economic Data</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var txt_nochicks= "<%=FwHelper.correctNull((String)hshValues.get("txt_nochicks"))%>";
var txt_costchicks= "<%=FwHelper.correctNull((String)hshValues.get("txt_costchicks"))%>" ;
//var txt_costchickmash= "<%=FwHelper.correctNull((String)hshValues.get("txt_costchickmash"))%>";
//var txt_conchickmash= "<%=FwHelper.correctNull((String)hshValues.get("txt_conchickmash"))%>" ;
//var txt_costgrowermash= "<%=FwHelper.correctNull((String)hshValues.get("txt_costgrowermash"))%>" ; 
//var txt_congrowermash= "<%=FwHelper.correctNull((String)hshValues.get("txt_congrowermash"))%>" ;
//var txt_costGrowermash= "<%=FwHelper.correctNull((String)hshValues.get("txt_costGrowermash"))%>" ; 
//var txt_conGrowermash= "<%=FwHelper.correctNull((String)hshValues.get("txt_conGrowermash"))%>" ;
var txt_broodingmor = "<%=FwHelper.correctNull((String)hshValues.get("poultry_Mortality"))%>" ;
var txt_specify1= "<%=FwHelper.correctNull((String)hshValues.get("txt_specify1"))%>" ;
var txt_specify2= "<%=FwHelper.correctNull((String)hshValues.get("txt_specify2"))%>" ;
var txt_electricitycharge= "<%=FwHelper.correctNull((String)hshValues.get("txt_electricitycharge"))%>" ;
var txt_watercharge = "<%=FwHelper.correctNull((String)hshValues.get("txt_watercharge"))%>" ;
var txt_vtaid= "<%=FwHelper.correctNull((String)hshValues.get("txt_vtaid"))%>" ;
var txt_inspremium= "<%=FwHelper.correctNull((String)hshValues.get("txt_inspremium"))%>" ;
var txt_yieldegg= "<%=FwHelper.correctNull((String)hshValues.get("txt_yieldegg"))%>" ;

var txt_growershed= "<%=FwHelper.correctNull((String)hshValues.get("txt_growershed"))%>" ;
//var txt_yieldmanure= "<%=FwHelper.correctNull((String)hshValues.get("txt_yieldmanure"))%>" ;
//var txt_salemanure= "<%=FwHelper.correctNull((String)hshValues.get("txt_salemanure"))%>" ;
//var txt_salegunny= "<%=FwHelper.correctNull((String)hshValues.get("txt_salegunny"))%>" ;
//var txt_emptybag= "<%=FwHelper.correctNull((String)hshValues.get("txt_emptybag"))%>" ;
var txt_transportcharge= "<%=FwHelper.correctNull((String)hshValues.get("txt_transportcharge"))%>" ;


var varTypePoultry="<%=strTypePoultry%>";

var varequipmenttype =new Array();
var arrSize = '<%=arryRow2.size()%>';
var schemetype="<%=schemetype%>";

var vartxt_totsalebag="<%=FwHelper.correctNull((String)hshValues.get("txt_totsalebag"))%>" ;
var vartxt_totsalemanure="<%=FwHelper.correctNull((String)hshValues.get("txt_totsalemanure"))%>" ;
var varPoulrtyFlag="<%=Helper.correctNull((String)hshValues.get("strPolutryFlag"))%>";

</script>

<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
<%
for(int i=1;i<5;i++)
{
	if(arryRow2!=null && arryRow2.size()>=i)
		{

		arryCol3=(ArrayList)arryRow2.get(i-1);
		if(arryCol3!=null)
		{	
																			
%>  
			varequipmenttype["<%=i-1%>"]="<%=FwHelper.correctNull((String)arryCol3.get(1))%>";
			
<%
			}
		}
}

%>

function onloading()
{

	
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	      enableButtons(false, true, true, true, false);
		}
		else
		{
			 enableButtons(true, true, true, true, false);
		}
	}
	else
	{
		 enableButtons(true, true, true, true, false);
	}
		
	document.forms[0].txt_nochicks.value=txt_nochicks;
	document.forms[0].txt_costchicks.value=txt_costchicks;
	
	document.forms[0].txt_broodingmor.value=txt_broodingmor;
	document.forms[0].txt_specify1.value=txt_specify1;
	document.forms[0].txt_specify2.value=txt_specify2;
	document.forms[0].txt_electricitycharge.value=txt_electricitycharge;
	document.forms[0].txt_watercharge.value=txt_watercharge;
	document.forms[0].txt_vtaid.value=txt_vtaid;
	document.forms[0].txt_inspremium.value=txt_inspremium;
	document.forms[0].txt_yieldegg.value=txt_yieldegg;
	//document.forms[0].txt_yieldmanure.value=txt_yieldmanure;
	//document.forms[0].txt_salemanure.value=txt_salemanure;
	//document.forms[0].txt_salegunny.value=txt_salegunny;
	//document.forms[0].txt_emptybag.value=txt_emptybag;
	document.forms[0].txt_transportcharge.value=txt_transportcharge;
	document.forms[0].txt_totsalebag.value=vartxt_totsalebag;
	document.forms[0].txt_totsalemanure.value=vartxt_totsalemanure;
	
	disableFields(true);
	totalchicks();
	totalmortality();totbag();
	totalcost();callyield();calltotmanure();
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	document.all.purTable.style.visibility="hidden";
    document.all.purTable.style.position="absolute";

    if(varTypePoultry=="")
    { 
        alert("Please Select the  Type of Poultry");
      	document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrytechdata";
		document.forms[0].action=appUrl +"action/agr_poultry_broilertech.jsp";
		document.forms[0].submit(); 
		   	
    }

    if(varPoulrtyFlag=="Y")
	{
		enableButtons(true, true, true, true, false);
	}
 }

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
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
document.forms[0].txt_totalcostchicks.value=eval(nochicks)*eval(costchicks);
roundtxt(document.forms[0].txt_totalcostchicks);
if(document.forms[0].txt_totalcostchicks.value=="NaN.00")
{
document.forms[0].txt_totalcostchicks.value="0.00";
}

}
function totalmortality()
{
var nochicks=document.forms[0].txt_nochicks.value;
var broodingmor=document.forms[0].txt_broodingmor.value;

var str=Math.round((eval(broodingmor)/100)*eval(nochicks));
var broodmor=eval(nochicks)-eval(str);
document.forms[0].txt_broodingchicks.value=eval(broodmor);
if(document.forms[0].txt_broodingchicks.value=="NaN")
{
document.forms[0].txt_broodingchicks.value="0";
}

}

function totalcost()
{

	var chicks=document.forms[0].txt_nochicks.value;
	if(chicks=="")
		{
		chicks=0;
		}
	var vtaid=document.forms[0].txt_vtaid.value;
	if(vtaid=="")
		{
		vtaid=0;
		}
	var inspremium=document.forms[0].txt_inspremium.value;
	if(inspremium=="")
		{
		inspremium=0;
		}
	//var aidexp=eval(chicks)*eval(vtaid);
	//var totinspremium=eval(chicks)*eval(inspremium);
	//document.forms[0].txt_totalinspremium.value=eval(totinspremium);
	//document.forms[0].txt_totalvtaid.value=eval(aidexp);

var chicks=document.forms[0].txt_nochicks.value;
var vtaid=document.forms[0].txt_vtaid.value;
var inspremium=document.forms[0].txt_inspremium.value;
var aidexp=eval(chicks)*eval(vtaid);
var totinspremium=eval(chicks)*eval(inspremium);
//document.forms[0].txt_totalinspremium.value=NanNumber(eval(totinspremium));
//roundtxt(document.forms[0].txt_totalinspremium);
//document.forms[0].txt_totalvtaid.value=NanNumber(eval(aidexp));
//roundtxt(document.forms[0].txt_totalvtaid);


}
function callyield()
{
	
	var yieldegg=document.forms[0].txt_yieldegg.value;
	if(yieldegg=="")
		{
		yieldegg=0;
		}
	var broodingmor=document.forms[0].txt_broodingchicks.value;
	if(broodingmor=="")
		{
		broodingmor=0;
		}
	document.forms[0].txt_totsaleegg.value=eval(yieldegg)*eval(broodingmor);
roundtxt(document.forms[0].txt_totsaleegg);
}

function calltotmanure() 
{
	//var yieldmanure=document.forms[0].txt_yieldmanure.value;
	//var salemanure=document.forms[0].txt_salemanure.value;
	var salemanure=1;
	var yieldmanure=0;
	if(yieldmanure=="")
		{
		yieldmanure=0;
		}
	if(salemanure=="")
		{
	   salemanure=0;
		}
	//document.forms[0].txt_totsalemanure.value=(eval(yieldmanure)*(eval(salemanure)/1000)).toFixed(2);
}
function totbag()
{
	//var salegunny=document.forms[0].txt_salegunny.value;
	var salegunny=1;
	//var emptybag=document.forms[0].txt_emptybag.value;
	var emptybag=0;
	if(salegunny=="")
		{
		salegunny=0;
		}
	if(emptybag=="")
		{
		emptybag=0;
		}
	//document.forms[0].txt_totsalebag.value=eval(salegunny)*eval(emptybag);
	//roundtxt(document.forms[0].txt_totsalebag);
}

function callconsumption()
{
	
		//var txt_conchickmash=document.forms[0].txt_conchickmash.value;
		//var txt_congrowermash=document.forms[0].txt_congrowermash.value;
		//var txt_conGrowermash=document.forms[0].txt_conGrowermash.value;
		
		//var txt_costchickmash=document.forms[0].txt_costchickmash.value;
		//var txt_costgrowermash=document.forms[0].txt_costgrowermash.value;
		//var txt_costGrowermash=document.forms[0].txt_costGrowermash.value;
		
		//if(txt_congrowermash=="")
			//{
				//txt_congrowermash="0";
			//}
		//if(txt_costchickmash=="")
		//	{
		//		txt_costchickmash="0";
		//	}
		//if(txt_costgrowermash=="")
			//{
				//txt_costgrowermash="0";
			//}
		//if(txt_conchickmash=="")
		//{
			//txt_conchickmash ="0"; 
		//}
		//if(txt_conGrowermash=="")
		//{
			//txt_conGrowermash="0";
		//}
		//if(txt_costGrowermash=="")
		//{
			//txt_costGrowermash="0";
		//}	
		
		//document.forms[0].txt_totalfeedcon.value=eval(txt_conchickmash)+eval(txt_congrowermash)+eval(txt_conGrowermash);
		//roundtxt(document.forms[0].txt_totalfeedcon);
	
		//if(document.forms[0].txt_totalfeedcon.value=="NaN")
			//{
				//document.forms[0].txt_totalfeedcon.value="0";
			//}
		//document.forms[0].txt_totalchickmash.value=eval(txt_costchickmash)*eval(txt_conchickmash);
		//roundtxt(document.forms[0].txt_totalchickmash);
		
		///if(document.forms[0].txt_totalchickmash.value=="NaN")
			//{
				//document.forms[0].txt_totalchickmash.value="0";
		//	}
		//document.forms[0].txt_totalgrowermash.value=eval(txt_costgrowermash)*eval(txt_congrowermash);
		//roundtxt(document.forms[0].txt_totalgrowermash);
		//if(document.forms[0].txt_totalgrowermash.value=="NaN")
			//{
				//document.forms[0].txt_totalgrowermash.value="0";
		//	}

		//document.forms[0].txt_totalGrowermash.value=eval(txt_costGrowermash)*eval(txt_conGrowermash);
		//roundtxt(document.forms[0].txt_totalGrowermash);
		//if(document.forms[0].txt_totalGrowermash.value=="NaN")
			//{
				//document.forms[0].txt_totalGrowermash.value="0";
			//}
	
		
		var val1=document.forms[0].txt_totalchickmash.value;
		var val2=document.forms[0].txt_totalgrowermash.value;
		var val3=document.forms[0].txt_totalGrowermash.value;
			if(val1=="")
				{
					val1="0";
				}
			if(val2=="")
				{
					val2="0";
				}
			if(val3=="")
			{
				val3="0";
			}
			
		
		document.forms[0].txt_totalfeedcost.value=eval(val1)+eval(val2)+eval(val3);
		roundtxt(document.forms[0].txt_totalfeedcost);
			if(document.forms[0].txt_totalfeedcost.value=="NaN")
				{
					document.forms[0].txt_totalfeedcost.value="0";
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
		totalval2 = eval(value2)+eval(totalval2)
		totalval3 = eval(value3)+eval(totalval3)	
	}
document.forms[0].txt_totalnopersons.value= totalval1;
document.forms[0].txt_totalsalarypm.value= totalval2;
roundtxt(document.forms[0].txt_totalsalarypm);
document.forms[0].txt_totalsalarypy.value= totalval3;
roundtxt(document.forms[0].txt_totalsalarypy);

}

function doSave()
{   
	callconsumption();
    callsalary();
	totalchicks();
	totalmortality();totbag();
	callyield();calltotmanure();
	//checkOtherExpenses();
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agriloanassessment";		
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_broilerfin.jsp";
	document.forms[0].hidBeanMethod.value="updatepoultrybroilerfindata";
	document.forms[0].hidBeanGetMethod.value="getpoultrybroilerfindata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].txt_totalfeedcost.readOnly=true;
	document.forms[0].txt_broodingchicks.readOnly=true;
	document.forms[0].txt_totsaleegg.readOnly=true;
     document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, false, false);		
	calculatetotalsaleofegg();
		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getpoultrybroilerfindata";
		document.forms[0].action=appUrl +"action/agr_poultry_broilerfin.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
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

function calculatetotalsaleofegg()
{
	var variyeartot="1";
	var variiyeartot="1";
	var variiiyeartot="1";
	var varivyeartot="1";
	var varvyeartot="1";
	var variyear="";
	var variiyear="";
	var variiiyear="";
	var varivyear="";
	var varvyear="";
	
for(var i=0;i<2;i++)
{
	variyear=document.forms[0].txt_iyearegg[i].value;
	if(variyear=='')
	{
		variyear='0';
	}
	variiyear=document.forms[0].txt_iiyearegg[i].value;
	if(variiyear=='')
	{
		variiyear='0';
	}
	variiiyear=document.forms[0].txt_iiiyearegg[i].value;
	if(variiiyear=='')
	{
		variiiyear='0';
	}
	varivyear=document.forms[0].txt_ivyearegg[i].value;
	if(varivyear=='')
	{
		varivyear='0';
	}
	varvyear=document.forms[0].txt_vyearegg[i].value;
	if(varvyear=='')
	{
		varvyear='0';
	}
	

	variyeartot=roundVal(eval(variyeartot) * eval(variyear));
	variiyeartot=eval(variiyeartot)*eval(variiyear);
	variiiyeartot=eval(variiiyeartot)*eval(variiiyear);
	varivyeartot=eval(varivyeartot)*eval(varivyear);
	varvyeartot=eval(varvyeartot)*eval(varvyear);
}
if( variyeartot=="NaN")
{
	variyeartot='0';
}
if(  variiyeartot=="NaN")
{
	variiyeartot='0';
}
if(variiiyeartot=="NaN")
{
	variiiyeartot='0';
}

if(varivyeartot=="NaN")
{
	varivyeartot='0';
}
if(varvyeartot=="NaN")
{
	varvyeartot='0';
}
document.forms[0].txt_iyearegg[2].value=variyeartot;
document.forms[0].txt_iyearegg[2].readOnly=true;
document.forms[0].txt_iiyearegg[2].value=variiyeartot;
document.forms[0].txt_iiyearegg[2].readOnly=true;
document.forms[0].txt_iiiyearegg[2].value=variiiyeartot;
document.forms[0].txt_iiiyearegg[2].readOnly=true;
document.forms[0].txt_ivyearegg[2].value=varivyeartot;
document.forms[0].txt_ivyearegg[2].readOnly=true;
document.forms[0].txt_vyearegg[2].value=varvyeartot;
document.forms[0].txt_vyearegg[2].readOnly=true;

}
function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatepoultrybroilerfindata";
		document.forms[0].hidBeanGetMethod.value="getpoultrybroilerfindata";
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidSourceUrl.value="action/agr_poultry_broilerfin.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}

//function calrealisticvalue()
//{
//	var eggperbatch = document.forms[0].txt_eggperbatch.value;
//	if(eggperbatch=='')
//	{
	//	eggperbatch ='0';
	//}
//	var salepriceperegg = document.forms[0].txt_salepriceperegg.value;
	//if(salepriceperegg=='')
	//{
	//	salepriceperegg ='0';
	//}
//	var eggrealisation = roundVal(eval(eggperbatch)*eval(salepriceperegg));
	//document.forms[0].txt_eggrealisation.value = eval(eggrealisation);

//}


function funtypepoultry()
{
	if(varTypePoultry=="1")
	{
	document.getElementById('TP1').innerHTML = 'Hatcheries';
	document.getElementById('TP2').innerHTML = 'Hatcheries';
	document.getElementById('TP3').innerHTML = 'of Culled Bird';
	document.getElementById('TP4').innerHTML = 'sale of Culled Birds / Batch';
	}
	else if(varTypePoultry=="2" || varTypePoultry=="4")
	{
		document.getElementById('TP1').innerHTML = 'Layers';
		document.getElementById('TP2').innerHTML = 'Layers';
		document.getElementById('TP3').innerHTML = 'of culled Birds';
		document.getElementById('TP4').innerHTML = 'culled Birds';
	}
	else if (varTypePoultry=="3")
	{
		document.getElementById('TP1').innerHTML = 'Broiler';
		document.getElementById('TP2').innerHTML = 'Broiler';
		document.getElementById('TP3').innerHTML = 'per Broiler Bird';
		document.getElementById('TP4').innerHTML = 'sale of Broiler / Batch';
	}
		
	funHatcheries();
	funIncomeegg();
}

function funHatcheries()
{
if(varTypePoultry=="1")
{

	document.all.PTH1.style.visibility="hidden";
	document.all.PTH1.style.position="absolute";
	document.forms[0].txt_totsalemanure.value="";
	document.all.PTH2.style.visibility="hidden";
	document.all.PTH2.style.position="absolute";
	document.forms[0].txt_totsalebag.value="";
	
}
else
{
	document.all.PTH1.style.visibility="visible";
	document.all.PTH1.style.position="relative";
	document.all.PTH2.style.visibility="visible";
	document.all.PTH2.style.position="relative";
	
}
}

function funIncomeegg()
{
	if(varTypePoultry=="3")
	{
		document.all.PTI1.style.visibility="visible";
		document.all.PTI1.style.position="relative";
		document.all.PT3.style.visibility="visible";
		document.all.PT3.style.position="relative";
		document.all.FIN1.style.visibility="visible";
		document.all.FIN1.style.position="relative";
		document.all.FIN2.style.visibility="visible";
		document.all.FIN2.style.position="relative";
		document.all.FIN3.style.visibility="visible";
		document.all.FIN3.style.position="relative";
	}
	else
	{
		document.all.PTI1.style.visibility="hidden";
		document.all.PTI1.style.position="absolute";
		document.all.PT3.style.visibility="hidden";
		document.all.PT3.style.position="absolute";
		document.all.FIN1.style.visibility="hidden";
		document.all.FIN1.style.position="absolute";
		document.all.FIN2.style.visibility="hidden";
		document.all.FIN2.style.position="absolute";
		document.all.FIN3.style.visibility="hidden";
		document.all.FIN3.style.position="absolute";
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
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="onloading();callsalary();callTotal();funtypepoultry()">

<form name="frmpri" method="post" class="normal">

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
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Economic Data</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="98" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>

<table width="98%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center" >
	<tr>
		<td width="100%">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>
				<td colspan="2"  class="dataheader">Financial Data
				</td>
			</tr>
			<tr class="datagrid">
				<td width="39%">No. of day old chick purchased per batch</td>
				<td width="30%"><input type="text" name="txt_nochicks"
					value="<%=FwHelper.correctNull((String)hshValues.get("txt_nochicks"))%>"
					size="20%" onKeyPress="allowInteger()" maxlength="8"
					style="text-align:right" onBlur="totalchicks()"></td>
			</tr>
			<tr class="datagrid" id="FIN1">
				<td>Cost per day-old chick</td>
				<td><lapschoice:CurrencyTag name="txt_costchicks"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_costchicks"))%>'
					size="20%" maxlength="6" onBlur="totalchicks()" onBlur="roundtxt(this);"/></td>
			</tr>
			<tr class="datagrid" id="FIN2">
				<td>Total Cost of &nbsp;<label id="TP1"> Broiler  </label> &nbsp; Birds per batch</td>
				<td><lapschoice:CurrencyTag name="txt_totalcostchicks" value=""
					size="20%" maxlength="6" onBlur="roundtxt(this);"/></td>
			</tr>
			
			<tr class="datagrid" id="FIN3">
				<td>Total Number of Batch</td> 
				<td><input type="text" name="txt_numberbatch" size="20" maxlength="8" value="<%=FwHelper.correctNull((String)hshValues.get("poultry_totnobatch"))%>" style="text-align: right" onBlur="roundtxt(this);"></td>
			</tr>
			
			
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" id="PT3">
			<tr>
				<td colspan="3"  class="dataheader">Feeding
				Expenses</td>
			</tr>
			<tr>
				<td width="20%" align="center" class="dataheader">Type of feed</td>
				<!--<td width="29%" align="center" class="dataheader">Cost per Kg</td>
				<td width="25%" align="center" class="dataheader">Consumption of
				feed/bird (Kgs)</td>
				--><td width="26%" align="center" class="dataheader" colspan="2" >Cost of
				Consumption of feed/bird</td>
			</tr>
			<tr class="datagrid">
				<td>Starter Mash</td>
				<!--<td align="center"><lapschoice:CurrencyTag name="txt_costchickmash"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_costchickmash"))%>'
					size="20%" maxlength="10" onBlur="callconsumption()" /></td>
				<td align="center"><input type="text" name="txt_conchickmash"
					value="<%=FwHelper.correctNull((String)hshValues.get("txt_conchickmash"))%>"
					size="20%" onKeyPress="allowNumber(this)" maxlength="5"
					style="text-align:right" onBlur="callconsumption()"></td>
				--><td  colspan="2" ><lapschoice:CurrencyTag name="txt_totalchickmash"
					size="20%" maxlength="6" value='<%=FwHelper.correctNull((String)hshValues.get("poultry_Startermash"))%>' onBlur="callconsumption();roundtxt(this);" /></td>
			</tr>
			
			<tr class="datagrid">
				<td >Grower Mash/ Finisher Feed</td>
				<!--<td align="center"><lapschoice:CurrencyTag name="txt_costGrowermash"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_costGrowermash"))%>'
					size="20%" maxlength="10" onBlur="callconsumption()" /></td>
				<td align="center"><input type="text" name="txt_conGrowermash"
					value="<%=FwHelper.correctNull((String)hshValues.get("txt_conGrowermash"))%>"
					size="20%" onKeyPress="allowNumber(this)" maxlength="5"
					style="text-align:right" onBlur="callconsumption()"></td>
				--><td  colspan="2" ><lapschoice:CurrencyTag name="txt_totalGrowermash"
					size="20%" maxlength="6" value='<%=FwHelper.correctNull((String)hshValues.get("poultry_Growermash"))%>' onBlur="callconsumption();roundtxt(this);"/></td>
			</tr>
			
			<tr class="datagrid">
				<td >Finisher Mash</td>
				<!--<td align="center"><lapschoice:CurrencyTag name="txt_costgrowermash"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_costgrowermash"))%>'
					size="20%" maxlength="8" onBlur="callconsumption()" /></td>
				<td align="center"><input type="text" name="txt_congrowermash"
					value="<%=FwHelper.correctNull((String)hshValues.get("txt_congrowermash"))%>"
					size="20%" onKeyPress="allowNumber(this)" maxlength="5"
					style="text-align:right" onBlur="callconsumption()"></td>
				--><td  colspan="2" ><lapschoice:CurrencyTag
					name="txt_totalgrowermash"  size="20%" maxlength="6" value='<%=FwHelper.correctNull((String)hshValues.get("poultry_Finishermash"))%>' onBlur="callconsumption();roundtxt(this);"/></td>
			</tr>
			<tr class="datagrid">
				<td  align="center"><b>Total</b></td>
				<!--<td align="center"><input type="text" name="txt_totalfeedcon"
					value="" size="20%" maxlength="6" style="text-align:right" /></td>
				--><td ><lapschoice:CurrencyTag name="txt_totalfeedcost"
					size="20%" maxlength="6" value='<%=FwHelper.correctNull((String)hshValues.get("Feeding_tot"))%>'/></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr>
				<td colspan="9"  class="dataheader">Mortality
				Provision</td>
			</tr>
			
					<tr>
						<td width="34%" align="center" class="dataheader">Stage</td>
						<td width="23%" align="center" class="dataheader">% of
						Mortality</td>
						<td colspan="7" width="43%" align="center" class="dataheader">No. of Chicks
						per Batch(After Mortality)</td>
					</tr>
					<tr class="datagrid">
						<td align="center"><label id="TP2">Broiler</label></td>
						<td align="center"><input type="text" name="txt_broodingmor"
							value='<%=FwHelper.correctDouble((String)hshValues.get("poultry_Mortality"))%>'
							size="20%" maxlength="5"
							onBlur="totalmortality();checkPercentage(this);"
							style="text-align:right" onBlur="roundtxt(this);"/></td>
						<td colspan="7" align="center"><input type="text" name="txt_broodingchicks"
							value="" size="20%" onKeyPress="allowNumber(this)" maxlength="6"
							style="text-align:right" onBlur="roundtxt(this);"></td>
					</tr>
				
			
			
			<tr>
				<td colspan="9"  class="dataheader">Expenditure on
				salaries/wages</td>
			</tr>
			<tr>
				<td align="center" class="dataheader" WIDTH="284">Category</td>
				<td align="center" class="dataheader" WIDTH="191">No.of Persons</td>
				<td align="center" class="dataheader" WIDTH="265">Salary per
				month</td>
				<td colspan="6" align="center" nowrap class="dataheader">Total
				Salary</td>
			</tr>
			<tr class="datagrid">
				<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);

				if (arryCol.size() != 0) {

					l1 = FwHelper.correctNull((String) arryCol.get(2));
					d1 = FwHelper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				l1 = "";
				d1 = "";

			}

			%>
				<td width="284">Labourers</td>
				<td width="191" align="center"><input type="text"
					name="txt_noperson" value="<%=l1%>" size="20%"
					onKeyPress="allowNumber(this)" maxlength="3"
					onBlur="callsalary();callTotal()" style="text-align:right" onBlur="roundtxt(this);"></td>
				<td width="265" align="center"><lapschoice:CurrencyTag
					name="txt_salarypm" value='<%=d1%>' size="20%" maxlength="6"
					onBlur="callsalary();callTotal()" onBlur="roundtxt(this);" /></td>
				<td colspan="6" align="center"><lapschoice:CurrencyTag
					name="txt_salarypy" value="" size="20%" maxlength="6" onBlur="roundtxt(this);" /></td>
			</tr>
			<tr class="datagrid">
				<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					u1 = FwHelper.correctNull((String) arryCol.get(2));
					w1 = FwHelper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				u1 = "";
				w1 = "";

			}

			%>
				<td align="" WIDTH="284">Manager</td>
				<td align="center" WIDTH="191"><input type="text"
					name="txt_noperson" value="<%=u1%>" size="20%"
					style="text-align:right" onKeyPress="allowNumber(this)"
					maxlength="3" onBlur="callsalary();callTotal()"></td>
				<td align="center" WIDTH="265"><lapschoice:CurrencyTag
					name="txt_salarypm" value='<%=w1%>' size="20%" maxlength="6"
					onBlur="callsalary();callTotal()" onBlur="roundtxt(this);"/></td>
				<td colspan="6" align="center"><lapschoice:CurrencyTag
					name="txt_salarypy" value='' size="20%" maxlength="6" onBlur="roundtxt(this);"/></td>
			</tr>
			<tr class="datagrid">
				<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l2 = FwHelper.correctNull((String) arryCol.get(2));
					d2 = FwHelper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				l2 = "";
				d2 = "";

			}

			%>
				<td WIDTH="284">Supervisor</td>
				<td align="center" WIDTH="191"><input type="text"
					name="txt_noperson" value="<%=l2%>" size="20%"
					style="text-align:right" onKeyPress="allowNumber(this)"
					maxlength="3" onBlur="callsalary();callTotal()" onBlur="roundtxt(this);"></td>
				<td align="center" WIDTH="265"><lapschoice:CurrencyTag
					name="txt_salarypm" value='<%=d2%>' size="20%" maxlength="6"
					onBlur="callsalary();callTotal()" onBlur="roundtxt(this);"/></td>
				<td colspan="6" align="center"><lapschoice:CurrencyTag
					name="txt_salarypy" value='' size="20%" maxlength="6" onBlur="roundtxt(this);"/></td>
			</tr>
			<tr class="datagrid">
				<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(3);

				if (arryCol.size() != 0) {

					u2 = FwHelper.correctNull((String) arryCol.get(2));
					w2 = FwHelper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				u2 = "";
				w2 = "";

			}

			%>
				<td WIDTH="284"><input type="text" name="txt_specify1"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_specify1"))%>'
					size="20%" ></td>
				<td align="center" WIDTH="191"><input type="text"
					name="txt_noperson" value="<%=u2%>" size="20%"
					style="text-align:right" onKeyPress="allowNumber(this)"
					maxlength="3" onBlur="callsalary();callTotal()" onBlur="roundtxt(this);"></td>
				<td align="center" WIDTH="265"><lapschoice:CurrencyTag
					name="txt_salarypm" value='<%=w2%>' size="20%" maxlength="6"
					onBlur="callsalary();callTotal()" onBlur="roundtxt(this);"/></td>
				<td colspan="6" align="center"><lapschoice:CurrencyTag
					name="txt_salarypy" value='' size="20%" maxlength="6" onBlur="roundtxt(this);"/></td>
			</tr>
			<tr class="datagrid">
				<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(4);

				if (arryCol.size() != 0) {

					m1 = FwHelper.correctNull((String) arryCol.get(2));
					m2 = FwHelper.correctNull((String) arryCol.get(3));

				}

			} else if (arryRow.size() == 0) {
				m1 = "";
				m2 = "";

			}

			%>
				<td WIDTH="284"><input type="text" name="txt_specify2"
					value="<%=FwHelper.correctNull((String)hshValues.get("txt_specify2"))%>"
					size="20%" ></td>
				<td align="center" WIDTH="191"><input type="text"
					name="txt_noperson" value="<%=m1%>" size="20%"
					style="text-align:right" onKeyPress="allowNumber(this)"
					maxlength="3" onBlur="callsalary();callTotal()" onBlur="roundtxt(this);"></td>
				<td align="center" WIDTH="265"><lapschoice:CurrencyTag
					name="txt_salarypm" value='<%=m2%>' size="20%" maxlength="6"
					onBlur="callsalary();callTotal()" onBlur="roundtxt(this);"/></td>
				<td colspan="6" align="center"><lapschoice:CurrencyTag
					name="txt_salarypy" value='' size="20%" maxlength="6" onBlur="roundtxt(this);" /></td>
			</tr>
			<tr class="datagrid">
				<td align="center" WIDTH="284"><b>Total</b></td>
				<td align="center" WIDTH="191"><input type="text"
					name="txt_totalnopersons" value="" size="20%"
					onKeyPress="allowNumber(this)" style="text-align:right"
					maxlength="3" onBlur="roundtxt(this);"></td>
				<td align="center" WIDTH="265"><lapschoice:CurrencyTag
					name="txt_totalsalarypm" value='' size="20%" maxlength="6" onBlur="roundtxt(this);"/></td>
				<td colspan="6" align="center"><lapschoice:CurrencyTag
					name="txt_totalsalarypy" value='' size="20%" maxlength="6" onBlur="roundtxt(this);"/></td>
			</tr>
			<tr>
				<td colspan="9" align="left" class="dataheader"><b>Miscellaneous
				Expenses on :</b></td>
			</tr>
			<tr class="datagrid">
				<td WIDTH="284">Electricity</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_electricitycharge"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_electricitycharge"))%>'
					size="20%" maxlength="10" onBlur="roundtxt(this);"/> per month</td>
			</tr>
			<tr class="datagrid">
				<td WIDTH="284">Water Charges</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_watercharge"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_watercharge"))%>'
					size="20%" maxlength="10" onBlur="roundtxt(this);"/> per month</td>
			</tr>
			<tr class="datagrid">
				<td WIDTH="284">Veterinary Aid Expenses</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_vtaid"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_vtaid"))%>'
					size="20%" maxlength="5" onBlur="totalcost()" onBlur="roundtxt(this);"/> per Batch</td>
				<!--<td width="213">Cost per batch <lapschoice:CurrencyTag
					name="txt_totalvtaid" value="" size="20%" maxlength="10" /></td>
			--></tr>
			<tr class="datagrid">
				<td WIDTH="284">Insurance Premium</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_inspremium"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_inspremium"))%>'
					size="20%" maxlength="5" onBlur="totalcost()" onBlur="roundtxt(this);"/> per Batch</td>
				<!--<td WIDTH="213">Cost per batch <lapschoice:CurrencyTag
					name="txt_totalinspremium" value="" size="20%" maxlength="10" /></td>
			--></tr>
			<tr class="datagrid">
				<td WIDTH="284">Transportation Charges</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_transportcharge"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_trnasportcharge"))%>'
					size="20%" maxlength="8" onBlur="roundtxt(this);"/> per Batch</td>
			</tr>
			<tr>
				<td colspan="9">
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="dataheader" WIDTH="28%">Other Expenses</td>
						<td class="dataheader" WIDTH="19%">
						<div align="center">I Year</div>
						</td>
						<td class="dataheader" WIDTH="27%">
						<div align="center">II Year</div>
						</td>
						<td class="dataheader" WIDTH="26%">
						<div align="center">III Year </div>
						</td>
						<td class="dataheader" WIDTH="27%">
						<div align="center">IV Year</div>
						</td>
						<td class="dataheader" WIDTH="26%">
						<div align="center">V Year (onwards)</div>
						</td>
					</tr>
					<%for (int i = 0; i < 5; i++) {
				if (arryRow1 != null && arryRow1.size() > i) {
					arryCol1 = (ArrayList) arryRow1.get(i);

					%>
					<tr align="center" class="datagrid">
						<td WIDTH="28%"><input type="text" name="txt_exp"
							value='<%=FwHelper.correctNull((String) arryCol1.get(0))%>'
							size="40" maxlength="80" /></td>
						<td WIDTH="19%">
						<div align="center"><lapschoice:CurrencyTag name="txt_iyear"
							value='<%=FwHelper.checkDecimal(FwHelper.correctNull((String) arryCol1.get(1)))%>'
							size="15" maxlength="10"  onBlur="roundtxt(this);"/></div>
						</td>
						<td WIDTH="27%">
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyear"
							value='<%=FwHelper.checkDecimal(FwHelper.correctNull((String) arryCol1.get(2)))%>'
							size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td WIDTH="26%">
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyear"
							value='<%=FwHelper.checkDecimal(FwHelper.correctNull((String) arryCol1.get(3)))%>'
							size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td WIDTH="26%">
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyear"
							value='<%=FwHelper.checkDecimal(FwHelper.correctNull((String) arryCol1.get(3)))%>'
							size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td WIDTH="26%">
						<div align="center"><lapschoice:CurrencyTag name="txt_vyear"
							value='<%=FwHelper.checkDecimal(FwHelper.correctNull((String) arryCol1.get(3)))%>'
							size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
					</tr>
					<%} else {%>
					<tr align="center" class="datagrid">
						<td WIDTH="28%"><input type="text" name="txt_exp" value=''
							size="40" maxlength="80" /></td>
						<td WIDTH="19%">
						<div align="center"><lapschoice:CurrencyTag name="txt_iyear"
							value='' size="15" maxlength="10" onBlur="roundtxt(this);" /></div>
						</td>
						<td WIDTH="27%">
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyear"
							value='' size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td WIDTH="26%">
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyear"
							value='' size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td WIDTH="26%">
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyear"
							value='' size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td WIDTH="26%">
						<div align="center"><lapschoice:CurrencyTag name="txt_vyear"
							value='' size="15" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
					</tr>
					<%}
			}

			%>
				</table>
				</td>
			</tr>
			<tr class="dataheader">
				<td colspan="9" >Income / Batch</td>
			</tr>
			<tr class="datagrid">
				<td WIDTH="284">Average Sale price  <label id="TP3">per Broiler Bird</label> (<%=ApplicationParams.getCurrency()%>)</td>
				<td WIDTH="191" colspan="8"><lapschoice:CurrencyTag name="txt_yieldegg"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_yieldegg"))%>'
					size="20%" maxlength="5" onBlur="roundtxt(this);callyield()" /></td>
				<!--<td id="egg1" WIDTH="265">Number of Eggs / Batch</td>
				<td id="egg2" colspan="6" align="center"><input type="text"
					name="txt_eggperbatch" maxlength="8" onKeyPress="allowInteger()"
					style="text-align:right" onBlur="calrealisticvalue()"
					value='<%=FwHelper.correctNull((String)hshValues.get("poultry_eggperbatach"))%>'></td>
			--></tr>
			<tr class="datagrid">
				<td WIDTH="284">Total realisation from  <label id="TP4">sale of Broilers /Batch</label> (<%=ApplicationParams.getCurrency()%>)</td>
				<td WIDTH="191" colspan="8"><lapschoice:CurrencyTag name="txt_totsaleegg"
					value="" size="20%" /></td>
				<!--<td id="egg3" WIDTH="265">Sale Price of Egg (<%=ApplicationParams.getCurrency()%>)</td>
				<td id="egg4" colspan="6" align="center"><input type="text" style="text-align:right"
					name="txt_salepriceperegg" size="20" onBlur="roundtxt(this);calrealisticvalue()"
					value='<%=FwHelper.correctNull((String)hshValues.get("poultry_eggsaleprice"))%>'></td>
			--></tr>
			<!--<tr class="datagrid">
				<td height="31" WIDTH="284">Average yield of manure per batch</td>
				<td WIDTH="191" colspan="8"><input type="text" name="txt_yieldmanure"
					value="<%=FwHelper.correctNull((String)hshValues.get("txt_yieldmanure"))%>"
					size="20%" onKeyPress="allowNumber(this)" style="text-align:right"
					maxlength="8" onBlur="calltotmanure()"> kgs</td>
			    <td id="egg5" WIDTH="265">Total Realisation from Sale of Egg / Batch (<%=ApplicationParams.getCurrency()%>)</td>
				<td id="egg6" colspan="6" align="center"><input type="text"
					name="txt_eggrealisation" size="20" onKeyPress="allowNumber(this)" readOnly
					style="text-align:right" maxlength="15" value='<%=FwHelper.correctNull((String)hshValues.get("poultry_eggrealisationvalue"))%>'></td>
			</tr>
			--><!--<tr class="datagrid">
				<td WIDTH="284">Average sale price of Manure(<%=ApplicationParams.getCurrency()%>)</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_salemanure"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_salemanure"))%>'
					size="20%" maxlength="8" onBlur="calltotmanure()" /> /tonne</td>
			</tr>
			--><tr class="datagrid" id="PTH1">
				<td nowrap WIDTH="284"> Sale Price of Manure / Batch (<%=ApplicationParams.getCurrency()%>)</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_totsalemanure"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_totsalemanure"))%>' size="20%" maxlength="8" onBlur="roundtxt(this);" /></td>
			</tr>
			<!--<tr class="datagrid">
				<td WIDTH="284">Sale Price of empty Gunny Bags(<%=ApplicationParams.getCurrency()%>)</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_salegunny"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_salegunny"))%>'
					size="20%" maxlength="5" onBlur="totbag()" /> /bag</td>
			</tr>
			--><!--<tr class="datagrid">
				<td WIDTH="284">No.of empty bags</td>
				<td colspan="8"><input type="text" name="txt_emptybag"
					value="<%=FwHelper.correctNull((String)hshValues.get("txt_emptybag"))%>"
					size="20%" style="text-align:right" onKeyPress="allowNumber(this)"
					maxlength="5" onBlur="totbag()"> /batch</td>
			</tr>
			--><tr class="datagrid" id="PTH2">
				<td WIDTH="284">Sale Price of Empty Bags(<%=ApplicationParams.getCurrency()%>)</td>
				<td colspan="8"><lapschoice:CurrencyTag name="txt_totsalebag"
					value='<%=FwHelper.correctNull((String)hshValues.get("txt_emptybag"))%>' size="20%" maxlength="8" onBlur="roundtxt(this);"/></td>
			</tr>
			<!--  for Egg sale yearwise-->
			<tr id="PTI1">
				<td colspan="9">
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="dataheader">Income from Egg Sale</td>
						<td class="dataheader">
						<div align="center">I Year</div>
						</td>
						<td class="dataheader">
						<div align="center">II Year</div>
						</td>
						<td class="dataheader">
						<div align="center">III Year</div>
						</td>
						<td class="dataheader">
						<div align="center">IV Year</div>
						</td>
						<td class="dataheader">
						<div align="center">V Year(onwards)</div>
						</td>
					</tr>
					<tr align="center" class="datagrid">
						<%if (arryRowEgg != null && arryRowEgg.size() > 0) {
							arryColEgg = (ArrayList) arryRowEgg.get(0);
				if (arryColEgg.size() != 0) {
					w11 = FwHelper.correctDouble((String) arryColEgg.get(0));
					k11 = FwHelper.correctDouble((String) arryColEgg.get(1));
					r11 = FwHelper.correctDouble((String) arryColEgg.get(2));
					a11 = FwHelper.correctDouble((String) arryColEgg.get(3));
					b11 = FwHelper.correctDouble((String) arryColEgg.get(4));
				}

			} else if (arryRowEgg.size() == 0) {
				w11 = "";
				k11 = "";
				r11 = "";
				b11="";
				a11="";
			}

			%>
						<td align="left">Number of Eggs / Batch</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iyearegg"
							value='<%=w11%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyearegg"
							value='<%=k11%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyearegg"
							value='<%=r11%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyearegg"
							value='<%=a11%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_vyearegg"
							value='<%=b11%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
					</tr>
					<tr align="center" class="datagrid">
						<%if (arryRowEgg != null && arryRowEgg.size() > 1) {
							arryColEgg = (ArrayList) arryRowEgg.get(1);

				if (arryCol1.size() != 0) {

					w12 = FwHelper.correctDouble((String) arryColEgg.get(0));
					k12 = FwHelper.correctDouble((String) arryColEgg.get(1));
					r12 = FwHelper.correctDouble((String) arryColEgg.get(2));
					a12 = FwHelper.correctDouble((String) arryColEgg.get(2));
					b12 = FwHelper.correctDouble((String) arryColEgg.get(2));
				}

			} else if (arryRowEgg.size() == 0) {
				w12 = "";
				k12 = "";
				r12 = "";
				a12 = "";
				b12 = "";

			}

			%>
						<td align="left">Sale Price of Egg (Rs.)</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iyearegg"
							value='<%=w12%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyearegg"
							value='<%=k12%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyearegg"
							value='<%=r12%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyearegg"
							value='<%=a12%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_vyearegg"
							value='<%=b12%>' size="20%" maxlength="7" onBlur="calculatetotalsaleofegg();roundtxt(this);"/></div>
						</td>
					</tr>
					<tr align="center" class="datagrid">
						<%if (arryRowEgg != null && arryRowEgg.size() > 2) {
							arryColEgg = (ArrayList) arryRowEgg.get(2);

				if (arryColEgg.size() != 0) {

					w13 = FwHelper.correctDouble((String) arryColEgg.get(0));
					k13 = FwHelper.correctDouble((String) arryColEgg.get(1));
					r13 = FwHelper.correctDouble((String) arryColEgg.get(2));
					a13 = FwHelper.correctDouble((String) arryColEgg.get(2));
					b13 = FwHelper.correctDouble((String) arryColEgg.get(2));
				}

			} else if (arryRowEgg.size() == 0) {
				w13 = "";
				k13 = "";
				r13 = "";
				a13 = "";
				b13 = "";
			}

			%>
						<td align="left" nowrap>Total Realisation from Sale of <br>Egg / Batch (Rs.)</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iyearegg"
							value='<%=w13%>' size="20%" maxlength="30" /></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyearegg"
							value='<%=k13%>' size="20%" maxlength="30" /></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyearegg"
							value='<%=r13%>' size="20%" maxlength="30" /></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyearegg"
							value='<%=a13%>' size="20%" maxlength="30" /></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_vyearegg"
							value='<%=b13%>' size="20%" maxlength="30" /></div>
						</td>
					</tr>
				</table>
				</td>
				</tr>
				<!-- end Egg Sale yearwise -->
			<tr>
				<td colspan="9">
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="dataheader">Other Sources of Income</td>
						<td class="dataheader">
						<div align="center">I Year</div>
						</td>
						<td class="dataheader">
						<div align="center">II Year</div>
						</td>
						<td class="dataheader">
						<div align="center">III Year</div>
						</td>
						<td class="dataheader">
						<div align="center">IV Year</div>
						</td>
						<td class="dataheader">
						<div align="center">V Year(onwards)</div>
						</td>
					</tr>
					<tr align="center" class="datagrid">
						<%if (arryRow11 != null && arryRow11.size() > 0) {
				arryCol1 = (ArrayList) arryRow11.get(0);
				if (arryCol1.size() != 0) {
					u11 = FwHelper.correctNull((String) arryCol1.get(0));
					if (u11.equalsIgnoreCase("nil"))
						u11 = "";
					w11 = FwHelper.correctNull((String) arryCol1.get(1));
					k11 = FwHelper.correctNull((String) arryCol1.get(2));
					r11 = FwHelper.correctNull((String) arryCol1.get(3));
					a11 = FwHelper.correctNull((String) arryCol1.get(5));
					b11 = FwHelper.correctNull((String) arryCol1.get(6));
				}

			} else if (arryRow11.size() == 0) {
				u11 = "";
				w11 = "";
				k11 = "";
				r11 = "";
				a11 = "";
				b11 = "";

			}

			%>
						<td><input type="text" name="txt_src" value="<%=u11%>" size="35%"
							 maxlength="80"></td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iyearsrc"
							value='<%=w11%>' size="20%" maxlength="10" onBlur="roundtxt(this);" /></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyearsrc"
							value='<%=k11%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyearsrc"
							value='<%=r11%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyearsrc"
							value='<%=a11%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_vyearsrc"
							value='<%=b11%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
					</tr>
					<tr align="center" class="datagrid">
						<%if (arryRow11 != null && arryRow11.size() > 1) {
				arryCol1 = (ArrayList) arryRow11.get(1);

				if (arryCol1.size() != 0) {

					u12 = FwHelper.correctNull((String) arryCol1.get(0));
					if (u12.equalsIgnoreCase("nil"))
						u12 = "";
					w12 = FwHelper.correctNull((String) arryCol1.get(1));
					k12 = FwHelper.correctNull((String) arryCol1.get(2));
					r12 = FwHelper.correctNull((String) arryCol1.get(3));
					a12 = FwHelper.correctNull((String) arryCol1.get(5));
					b12 = FwHelper.correctNull((String) arryCol1.get(6));
				}

			} else if (arryRow11.size() == 0) {
				u12 = "";
				w12 = "";
				k12 = "";
				r12 = "";
				a12 = "";
				b12 = "";

			}

			%>
						<td><input type="text" name="txt_src" value="<%=u12%>" size="35%"
							 maxlength="80" ></td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iyearsrc"
							value='<%=w12%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyearsrc"
							value='<%=k12%>' size="20%" maxlength="10" onBlur="roundtxt(this);" /></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyearsrc"
							value='<%=r12%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyearsrc"
							value='<%=a12%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_vyearsrc"
							value='<%=b12%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
					</tr>
					<tr align="center" class="datagrid">
						<%if (arryRow11 != null && arryRow11.size() > 2) {
				arryCol1 = (ArrayList) arryRow11.get(2);

				if (arryCol1.size() != 0) {

					u13 = FwHelper.correctNull((String) arryCol1.get(0));
					if (u13.equalsIgnoreCase("nil"))
						u13 = "";
					w13 = FwHelper.correctNull((String) arryCol1.get(1));
					k13 = FwHelper.correctNull((String) arryCol1.get(2));
					r13 = FwHelper.correctNull((String) arryCol1.get(3));
					a13 = FwHelper.correctNull((String) arryCol1.get(5));
					b13 = FwHelper.correctNull((String) arryCol1.get(6));
				}

			} else if (arryRow11.size() == 0) {
				u13 = "";
				w13 = "";
				k13 = "";
				r13 = "";
				a13 = "";
				b13 = "";

			}

			%>
						<td><input type="text" name="txt_src" value="<%=u13%>" size="35%"
							 maxlength="80" ></td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iyearsrc"
							value='<%=w13%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiyearsrc"
							value='<%=k13%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_iiiyearsrc"
							value='<%=r13%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_ivyearsrc"
							value='<%=a13%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
						<td>
						<div align="center"><lapschoice:CurrencyTag name="txt_vyearsrc"
							value='<%=b13%>' size="20%" maxlength="10" onBlur="roundtxt(this);"/></div>
						</td>
					</tr>
				</table>
				
				<table id="purTable" width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr class="dataheader">
						<td colspan="3"><b>Purchase of Equipments/Machinery/cages</b></td>
					</tr>
					<tr align="center" class="dataheader">
						<td width="26%">Purchase of Equipments</td>
						<td width="27%">Specifications</td>
						<td width="27%">No. of units</td>
						<td width="20%">Unit Cost</td>
					</tr>
					<%for (int i = 0; i < 4; i++) {
				if (arryRow2 != null && arryRow2.size() > i) {
					arryCol2 = (ArrayList) arryRow2.get(i);
					if (arryCol2 != null) {

						%>
					<tr align="center">
						<td WIDTH="26%"><select name="sel_equipmentname" onChange="">
							<option value="0" selected>--Select--</option>
							<option value="1">Equipment Brooders</option>
							<option value="2">Feeders</option>
							<option value="3">Bukharies</option>
							<option value="4">Waterers</option>
							<option value="5">Nest Boxes</option>
							<option value="6">Grit Feeders</option>
							<option value="7">Egg Fillers</option>
							<option value="8">Egg Boxes</option>
							<option value="9">Water Arrangement - Pumpset / Channels</option>
							<option value="10">Feed Grinder Cum Mixer Weighing Equipment</option>
							<option value="11">Incubator / Hatcher / Setter / Generator & etc</option>
							<option value="12">Transport Vehicle</option>
						</select></td>
						<td><input type="text" name="txt_item1" size="70" maxlength="100"
							value="<%=FwHelper.correctNull((String) arryCol2.get(2))%>"
							onKeyPress="" style="text-align:left;" onBlur="roundtxt(this);"></td>
						<td><input type="text" name="txt_unit" size="20" maxlength="5"
							value="<%=FwHelper.correctNull((String) arryCol2.get(3))%>"
							onKeyPress="allowInteger()" style="text-align:right;" onBlur="roundtxt(this);"></td>
						<td><lapschoice:CurrencyTag name="txt_cost" size="20"
							maxlength="10"
							value='<%=FwHelper.correctNull((String) arryCol2.get(4))%>' onBlur="roundtxt(this);"/></td>
					</tr>
					<%}
				} else {

				%>
					<tr align="center">
						<td WIDTH="26%"><select name="sel_equipmentname" onChange="">
							<option value="0" selected>--Select--</option>
							<option value="1">Equipment Brooders</option>
							<option value="2">Feeders</option>
							<option value="3">Bukharies</option>
							<option value="4">Waterers</option>
							<option value="5">Nest Boxes</option>
							<option value="6">Grit Feeders</option>
							<option value="7">Egg Fillers</option>
							<option value="8">Egg Boxes</option>
							<option value="9">Water Arrangement - Pumpset / Channels</option>
							<option value="10">Feed Grinder Cum Mixer Weighing Equipment</option>
							<option value="11">Incubator / Hatcher / Setter / Generator & etc</option>
							<option value="12">Transport Vehicle</option>
						</select></td>
						<td><input type="text" name="txt_item1" size="70" maxlength="100"
							value=""></td>
						<td><input type="text" name="txt_unit" size="20" maxlength="5"
							onKeyPress="allowInteger()" style="text-align:right;"></td>
						<td><lapschoice:CurrencyTag name="txt_cost" size="20"
							maxlength="10" value='' onBlur="roundtxt(this);"/></td>
					</tr>
					<%}
			}

			%>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<br>
<lapschoice:combuttonnew
	btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		
<input type="hidden" name="hidAction">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidSourceUrl">
<INPUT TYPE="hidden" name="hidAppType" value="">
<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>