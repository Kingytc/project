<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%request.setAttribute("_cache_refresh", "true");%>
<%@page import="com.sai.fw.management.utils.FwHelper"%>
<laps:handleerror />
<%
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String strorgcode = Helper.correctNull((String) session
			.getAttribute("strOrgCode"));
	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));
	String strappno = Helper.correctNull((String) session
			.getAttribute("strappno"));
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	int yield_period=0;
			
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize=0;
	int arrSize2=0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrCol2 = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrRow2 = new ArrayList();
	ArrayList arrPlantDet = new ArrayList();
	ArrayList arrYearRow = new ArrayList();
	ArrayList arrYearCol = new ArrayList();
	ArrayList arrColPlant = new ArrayList();
	ArrayList arrYearCol2 = new ArrayList();
	
	ArrayList arrFinDripRow = new ArrayList();
	ArrayList arrFinDripCol = new ArrayList();
	ArrayList arrFinCultiRow = new ArrayList();
	ArrayList arrFinCultiCol = new ArrayList();
	int arrPlantDetSize=0;
	int arrYearRowSize=0;
	int arrFinDripRowSize=0;
	int arrFinCultiRowSize=0;
	int intmaxgrow=0;

	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrFinancial"); //Arraylist of financial prog details of year1
	}
	if(arrRow!=null)
	{
		arrSize=arrRow.size();//financial
	}
	String strDesc[]={"Land Development&nbsp;&nbsp; (hectares)","&nbsp;&nbsp;&nbsp;&nbsp;Bore Wells&nbsp;&nbsp; (Nos)","&nbsp;&nbsp;&nbsp;&nbsp;Submersible pumpset&nbsp;&nbsp; (Nos)",
					"&nbsp;&nbsp;&nbsp;&nbsp;Pipeline&nbsp;&nbsp; (m/hectare)","Fencing&nbsp;&nbsp; (hectares)","Labour quaters&nbsp;&nbsp; (Nos)",
					"Store rooms&nbsp;&nbsp; (Nos)","","","","","","",""};
	
	if(hshValues!=null)
	{
		arrPlantDet=(ArrayList)hshValues.get("arrHortiplant");//Arraylist of plant details
	}
	if(arrPlantDet!=null)
	{
		arrPlantDetSize=arrPlantDet.size();//Size of plant arraylist
	}
	if(hshValues!=null)
	{
		arrYearRow=(ArrayList)hshValues.get("arrYearRow");//ArrayList of Estimated cost of all plants
	}
	if(arrYearRow!=null)
	{
		arrYearRowSize=arrYearRow.size();//Size of plant arraylist
	}
	int loopsize=7+(2*arrPlantDetSize); //No of rows in control array
	
	String strmaxgrow = Helper.correctNull((String)hshValues.get("maxgrow"));
	if(strmaxgrow.equals(""))
	{
		intmaxgrow=0;
	}
	else
	{
		intmaxgrow	=	FwHelper.parseInt(Helper.correctNull((String)hshValues.get("maxgrow")));
	}
	if(hshValues!=null)
	{
		arrRow2=(ArrayList)hshValues.get("arrFinancial2"); //Arraylist of financial prog details after year1
	}
	if(arrRow2!=null)
	{
		arrSize2=arrRow2.size();
	}
	//For installation of drip irrigation part
	if(hshValues!=null)
	{
		arrFinDripRow=(ArrayList)hshValues.get("arrFinDrip"); //Arraylist of financial prog details after year1
	}
	if(arrFinDripRow!=null)
	{
		arrFinDripRowSize=arrFinDripRow.size();
	}
	//For cost of cultivation part
	if(hshValues!=null)
	{
		arrFinCultiRow=(ArrayList)hshValues.get("arrFinCulti"); //Arraylist of financial prog details after year1
	}
	if(arrFinCultiRow!=null)
	{
		arrFinCultiRowSize=arrFinCultiRow.size();
	}
	
	
%>

<html>
<head>
<title>Horticulture</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
	<!-- <script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script> -->
 
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var plant_name = "<%=Helper.correctNull((String)hshValues.get("PlantName"))%>";
var margin_percent = "<%=Helper.correctNull((String)hshValues.get("margin"))%>";
var varmaxgrow = "<%=Helper.correctNull((String)hshValues.get("maxgrow"))%>";
var varloopsize="<%=loopsize%>";
var varPlantDetSize="<%=arrPlantDetSize%>";
var varschemetype="<%=schemetype%>";
var totnoofacres=0.00;
var yieldingperiod="0";
var varLandDevt=0;


function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  

	}
}

function onloading()
{	  
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	document.all.marginid.innerText=margin_percent;
	varLandDevt = document.forms[0].txt_unit[0].value;
	disabledFields(true);
	//computeTotalAfter2Years();
	computeGrandTotal();
	
	if(varPlantDetSize=='0')
	{
		alert("Enter plant Details");
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	
	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
	
}
function computeTotCost(id)
{
	var varland = document.forms[0].txt_unit[0].value;
	var varunit = document.forms[0].txt_unit[id].value;
	var varunitcost = document.forms[0].txt_unitCost[id].value;
	
	if(id!=3)
	{
		document.forms[0].txt_totalCost[id].value	=	roundVal(NanNumber(eval(varunit)*eval(varunitcost)));
	}
	if(id==3)
	{
		document.forms[0].txt_totalCost[id].value	=	roundVal(NanNumber(eval(varunit)*eval(varunitcost)*eval(varland)));
	}

	//document.forms[0].txt_margin[id].value=roundVal(NanNumber(parseFloat(margin_percent)/100*parseFloat(document.forms[0].txt_totalCost[id].value)));
	//document.forms[0].txt_bankLoan[id].value=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalCost[id].value)-parseFloat(document.forms[0].txt_margin[id].value)));
	//document.forms[0].txt_unit[4].value=roundVal(NanNumber(eval(varland)));
	//document.forms[0].txt_unit[4].readOnly=true;
	
	computeColumnTotal();

}

function compmargin()
{ 	
	var vartemp="";
    for(var m=0;m<(document.forms[0].txt_bankLoan.length);m++)
	{
    	 vartemp=(parseFloat(eval(document.forms[0].txt_totalCost[m].value)))-(parseFloat(eval(document.forms[0].txt_totalCost[m].value))*parseFloat(eval(document.forms[0].txt_margin[m].value)/100));
		if(isNaN(vartemp))
		{
			vartemp="0.00";
		}
       document.forms[0].txt_bankLoan[m].value=vartemp;

   
	}
	
}

function compdripmargin()
    {
	if(document.forms[0].txt_marginDrip.length >1)
	{		
	for(var m=0;m<(document.forms[0].txt_bankLoanDrip.length);m++)
	{

	document.forms[0].txt_bankLoanDrip[m].value=(parseFloat(document.forms[0].txt_totalCostDrip[m].value))-(parseFloat(document.forms[0].txt_totalCostDrip[m].value)*parseFloat(document.forms[0].txt_marginDrip[m].value)/100);
	var nan=NanNumber(document.forms[0].txt_bankLoanDrip[m].value);
	document.forms[0].txt_bankLoanDrip[m].value=nan;
  	}	
	}
	else
	{					
	document.forms[0].txt_bankLoanDrip.value=(parseFloat(document.forms[0].txt_totalCostDrip.value))-(parseFloat(document.forms[0].txt_totalCostDrip.value)*parseFloat(document.forms[0].txt_marginDrip.value)/100); 
	}
	}

function compcostofcul()
{
if(document.forms[0].txt_marginCulti.length >1)
{		
for(var m=0;m<(document.forms[0].txt_bankLoanCulti.length);m++)
{

document.forms[0].txt_bankLoanCulti[m].value=(parseFloat(document.forms[0].txt_totalCostCulti[m].value))-(parseFloat(document.forms[0].txt_totalCostCulti[m].value)*parseFloat(document.forms[0].txt_marginCulti[m].value)/100);    
}	
}
else
{					
document.forms[0].txt_bankLoanCulti.value=(parseFloat(document.forms[0].txt_totalCostCulti.value))-(parseFloat(document.forms[0].txt_totalCostCulti.value)*parseFloat(document.forms[0].txt_marginCulti.value)/100); 
}
}
	
function computeTotCostDrip(id)
{
	
	varunit=0;
	varunitcost=0;
	var vartotunit=0;
	var totnoofacres=0;
	if(document.forms[0].txt_unitCulti.length>=2)
	{
		for(k=0;k<document.forms[0].txt_unitCulti.length;k++)
		{
			//vartotunit=eval(vartotunit)+NanNumber(eval(document.forms[0].txt_unitCulti[k].value));
			var varUnit = document.forms[0].txt_unitCulti[k].value;
			if(varUnit=="")
				varUnit=0;
			vartotunit=eval(vartotunit)+eval(varUnit);
		}
	}
	else
	{
		vartotunit=NanNumber(eval(document.forms[0].txt_unitCulti.value));
	}
	
	var varland = document.forms[0].txt_unit[0].value;
	if(eval(vartotunit)>eval(varland))
	{
		alert("Unit of Cost of Cultivation Exceeds the Land Development");
		if(document.forms[0].txt_unitCulti.length>=2)
		{
			document.forms[0].txt_unitCulti[id].focus();
			document.forms[0].txt_unitCulti[id].value="0";
		}
		else
		{
			document.forms[0].txt_unitCulti.focus();
			document.forms[0].txt_unitCulti.value="0";
		}
		//totnoofacres=0.00;
		return false;
	}
	totnoofacres=0.00;
	for(var j=0;j<eval(varPlantDetSize);j++)
	{
		if(document.forms[0].txt_unitDrip.length>=2)
		{
			totnoofacres=NanNumber(parseFloat(totnoofacres)+parseFloat(document.forms[0].txt_unitDrip[j].value));
		}
		else
		{
			totnoofacres=NanNumber(parseFloat(totnoofacres)+parseFloat(document.forms[0].txt_unitDrip.value));
			
		}
	}
	
	if(eval(totnoofacres)>eval(varland))
	{
		alert("Unit of Installation of Drip Irrigation Exceeds the Land Development");
		if(document.forms[0].txt_unitDrip.length>=2)
		{
			document.forms[0].txt_unitDrip[id].focus();
			document.forms[0].txt_unitDrip[id].value="0";
		}
		else
		{
			document.forms[0].txt_unitDrip.focus();
			document.forms[0].txt_unitDrip.value="0";
		}
		totnoofacres=0.00;
		return false;
	}

	if(document.forms[0].txt_unitDrip.length>=2)
	{
		varunit = document.forms[0].txt_unitDrip[id].value;
		varunitcost = document.forms[0].txt_unitCostDrip[id].value;
		document.forms[0].txt_totalCostDrip[id].value	=	roundVal(NanNumber(eval(varunit)*eval(varunitcost)));
		//document.forms[0].txt_marginDrip[id].value=roundVal(NanNumber(parseFloat(margin_percent)/100*parseFloat(document.forms[0].txt_totalCostDrip[id].value)));
		//document.forms[0].txt_bankLoanDrip[id].value=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalCostDrip[id].value)-parseFloat(document.forms[0].txt_marginDrip[id].value)));
	}
	else
	{
		varunit = document.forms[0].txt_unitDrip.value;
		varunitcost = document.forms[0].txt_unitCostDrip.value;
		document.forms[0].txt_totalCostDrip.value	=	roundVal(NanNumber(eval(varunit)*eval(varunitcost)));
		//document.forms[0].txt_marginDrip.value=roundVal(NanNumber(parseFloat(margin_percent)/100*parseFloat(document.forms[0].txt_totalCostDrip.value)));
		//document.forms[0].txt_bankLoanDrip.value=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalCostDrip.value)-parseFloat(document.forms[0].txt_marginDrip.value)));
	}

	varunit=0;
	varunitcost=0;
	if(document.forms[0].txt_unitCulti.length>=2)
	{
		varunit = document.forms[0].txt_unitCulti[id].value;
		varunitcost = document.forms[0].txt_unitCostCulti[id].value;
		document.forms[0].txt_totalCostCulti[id].value	=	roundVal(NanNumber(eval(varunit)*eval(varunitcost)));
		//document.forms[0].txt_marginCulti[id].value=roundVal(NanNumber(parseFloat(margin_percent)/100*parseFloat(document.forms[0].txt_totalCostCulti[id].value)));
		//document.forms[0].txt_bankLoanCulti[id].value=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalCostCulti[id].value)-parseFloat(document.forms[0].txt_marginCulti[id].value)));
	}
	else
	{
		varunit = document.forms[0].txt_unitCulti.value;
		varunitcost = document.forms[0].txt_unitCostCulti.value;
		document.forms[0].txt_totalCostCulti.value=roundVal(NanNumber(eval(varunit)*eval(varunitcost)));
	//	document.forms[0].txt_marginCulti.value=roundVal(NanNumber(parseFloat(margin_percent)/100*parseFloat(document.forms[0].txt_totalCostCulti.value)));
		//document.forms[0].txt_bankLoanCulti.value=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalCostCulti.value)-parseFloat(document.forms[0].txt_marginCulti.value)));
		vartotunit = NanNumber(eval(document.forms[0].txt_unitCulti.value));
	}
	
	
	
	for(var m=0;m<document.forms[0].txt_unit2.length;m++)
	{
		document.forms[0].txt_unit2[m].value=roundVal(NanNumber(eval(vartotunit)));
	}
	computeColumnTotal();
	computeTotalAfter2Years();
	
}
function computeColumnTotal()
{
	var totl=0.0,tot2=0.0,tot3=0.0;
	var totlDrip=0.0,tot2Drip=0.0,tot3Drip=0.0;
	var totlCulti=0.0,tot2Culti=0.0,tot3Culti=0.0;
	for(var m=0;m<(document.forms[0].txt_totalCost.length);m++)
	{
		var t = document.forms[0].txt_totalCost[m].value;
		if(t=="")
			t=0.0;
		totl	=	eval(totl)+eval(t);
	}
	

	if(document.forms[0].txt_totalCostDrip.length>=2)
	{
		for(var m=0;m<(document.forms[0].txt_totalCostDrip.length);m++)
		{
			var t = document.forms[0].txt_totalCostDrip[m].value;
			if(t=="")
				t=0.0;
			totlDrip	=	eval(totlDrip)+eval(t);
		}
	}
	else
	{
		totlDrip = NanNumber(parseFloat(eval(document.forms[0].txt_totalCostDrip.value)));
	}
	
	if(document.forms[0].txt_totalCostDrip.length>=2)
	{
		for(var m=0;m<(document.forms[0].txt_totalCostCulti.length);m++)
		{
			var t = document.forms[0].txt_totalCostCulti[m].value;
			if(t=="")
				t=0.0;
			totlCulti	=	eval(totlCulti)+eval(t);
		}
	}
	else
	{
		totlCulti = NanNumber(parseFloat(eval(document.forms[0].txt_totalCostCulti.value)));
	
	}
	
	document.forms[0].txt_totalCost2[0].value=roundVal(NanNumber(eval(totl)+eval(totlDrip)+eval(totlCulti)));
	
	//For bank loan total
	//for(var m=0;m<(document.forms[0].txt_bankLoan.length);m++)
	//{
		//var t = document.forms[0].txt_bankLoan[m].value;
		//if(t=="")
		//	t=0.0;
		//tot2	=	eval(tot2)+eval(t);
	//}
	if(document.forms[0].txt_bankLoanDrip.length>=2)
	{
	for(var m=0;m<(document.forms[0].txt_bankLoanDrip.length);m++)
		{
			var t = document.forms[0].txt_bankLoanDrip[m].value;
			if(t=="")
				t=0.0;
			tot2Drip	=	eval(tot2Drip)+eval(t);
		}
	}
	else
	{
		tot2Drip = NanNumber(parseFloat(document.forms[0].txt_bankLoanDrip.value));
	}
	if(document.forms[0].txt_bankLoanDrip.length>=2)
	{
	
		for(var m=0;m<(document.forms[0].txt_bankLoanCulti.length);m++)
		{
			var t = document.forms[0].txt_bankLoanCulti[m].value;
			if(t=="")
				t=0.0;
			tot2Culti	=	eval(tot2Culti)+eval(t);
		}
	}
	else
	{
		tot2Culti = NanNumber(parseFloat(document.forms[0].txt_bankLoanCulti.value));
	}
	document.forms[0].txt_bankLoan2[0].value=roundVal(NanNumber(eval(tot2)+eval(tot2Drip)+eval(tot2Culti)));
	
	//For margin total
	for(var m=0;m<(document.forms[0].txt_margin.length);m++)
	{
		var t = document.forms[0].txt_margin[m].value;
		if(t=="")
			t=0.0;
		tot3	=	eval(tot3)+eval(t);
	}
	if(document.forms[0].txt_marginDrip.length>=2)
	{
	
		for(var m=0;m<(document.forms[0].txt_marginDrip.length);m++)
		{
			var t = document.forms[0].txt_marginDrip[m].value;
			if(t=="")
				t=0.0;
			tot3Drip	=	eval(tot3Drip)+eval(t);
		}
	}
	else
	{
		tot3Drip = NanNumber(parseFloat(document.forms[0].txt_marginDrip.value));
	}
	if(document.forms[0].txt_marginCulti.length>=2)
	{
	
		for(var m=0;m<(document.forms[0].txt_marginCulti.length);m++)
		{
			var t = document.forms[0].txt_marginCulti[m].value;
			if(t=="")
				t=0.0;
			tot3Culti	=	eval(tot3Culti)+eval(t);
		}
	}
	else
	{
		tot3Culti = NanNumber(parseFloat(document.forms[0].txt_marginCulti.value));
	}
	document.forms[0].txt_margin2[0].value=roundVal(NanNumber(eval(tot3)+eval(tot3Drip)+eval(tot3Culti)));
}

//For computing total cost after 2 years
function computeTotalAfter2Years()
{

	var varyear2tot=0.0,varyear2=0.0,varyear2unit=0.0,varm=0,vargrandtotal=0.0,vargrandbankloan=0.0,vargrandmargin=0.0;
	<%
	for(int i=0;i<(intmaxgrow-1);i++)
	{ %>
		varyear2tot=0.0;
		
		<%for(int m=0;m<arrPlantDetSize;m++)
				{
					
					if(arrYearRow!=null && (arrYearRow.size()-1)>=m)
					{
						arrYearCol2=(ArrayList)arrYearRow.get(m);
						double dblyear2=0.0;
						if(i<6)
						 dblyear2	=	FwHelper.parseDouble(Helper.correctDouble((String)arrYearCol2.get(i+2)));
						else
							 dblyear2	=	FwHelper.parseDouble(Helper.correctDouble((String)arrYearCol2.get(i+1)));

						%>
						
						varyear2="<%=dblyear2%>";
						varm="<%=m%>";
						if(document.forms[0].txt_unitCulti.length>=2)
						{
							//alert("computemethod, varyear2tot="+varyear2tot);
							//alert("computemethod, txt_unitCulti="+eval(document.forms[0].txt_unitCulti[eval(varm)].value));
							//alert("computemethod,varyear2="+varyear2);
							if(document.forms[0].txt_unitCulti[eval(varm)].value=="")
								var varunitculti=0;
							else
								var varunitculti=document.forms[0].txt_unitCulti[eval(varm)].value;
							varyear2tot	=	eval(varyear2tot) +(eval(varunitculti)
										*eval(varyear2));
							//alert("computemethod, varyear2tot==="+varyear2tot);
						}
						else
						{
							varyear2tot	=	varyear2tot +(eval(document.forms[0].txt_unitCulti.value)
									*eval(varyear2));
						}
						document.forms[0].txt_totalCost2[<%=(i+1)%>].value = roundVal(NanNumber(varyear2tot));
						document.forms[0].txt_margin2[<%=(i+1)%>].value = roundVal(NanNumber(parseFloat(margin_percent)/100
											*parseFloat(document.forms[0].txt_totalCost2[<%=(i+1)%>].value)));
						document.forms[0].txt_bankLoan2[<%=(i+1)%>].value=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalCost2[<%=(i+1)%>].value)
																-parseFloat(document.forms[0].txt_margin2[<%=(i+1)%>].value)));
						
						
				<%
					
				}else{%>
						document.forms[0].txt_totalCost2[<%=(i+1)%>].value=roundVal(NanNumber(varyear2tot));
						document.forms[0].txt_margin2[<%=(i+1)%>].value=roundVal(NanNumber(varyear2tot));
						document.forms[0].txt_bankLoan2[<%=(i+1)%>].value=roundVal(NanNumber(varyear2tot));
				<%}
				}
	}
	%>
	
	
	computeGrandTotal();
	
}
function computeGrandTotal()
{
	//Grand Total calculation
	var vargrandtotal=0.0,vargrandbankloan=0.0,vargrandmargin=0.0,vartotunit=0.0;
	
	for(var k=0;k<(varmaxgrow);k++)
	{
		vargrandtotal	=	eval(vargrandtotal)+NanNumber(parseFloat(document.forms[0].txt_totalCost2[k].value));
		vargrandmargin	=	eval(vargrandmargin)+parseFloat(document.forms[0].txt_margin2[k].value);
		vargrandbankloan	=	eval(vargrandbankloan)+parseFloat(document.forms[0].txt_bankLoan2[k].value);
		//alert(vargrandtotal);
	}
	//alert(vargrandtotal);
	if(varmaxgrow!="")
	{
		document.forms[0].txt_totalCost2[eval(varmaxgrow)].value=roundVal(NanNumber(parseFloat(vargrandtotal)));
		document.forms[0].txt_margin2[eval(varmaxgrow)].value = roundVal(NanNumber(parseFloat(vargrandmargin)));
		document.forms[0].txt_bankLoan2[eval(varmaxgrow)].value = roundVal(NanNumber(parseFloat(vargrandbankloan)));
		document.forms[0].txt_unit2[eval(varmaxgrow)].value = document.forms[0].txt_unit2[0].value;
			
	}
	
	var varland = document.forms[0].txt_unit[0].value;
	
}
function doSave()
{   
   
	for(var j=0;j<eval(varPlantDetSize);j++)
	{
		if(document.forms[0].txt_unitDrip.length>=2)
		{
			totnoofacres=NanNumber(parseFloat(totnoofacres)+parseFloat(document.forms[0].txt_unitDrip[j].value));
		}
		else
		{
			totnoofacres=NanNumber(parseFloat(totnoofacres)+parseFloat(document.forms[0].txt_unitDrip.value));
			
		}
	}
	var varland = document.forms[0].txt_unit[0].value;
	if(eval(totnoofacres)>eval(varland))
	{
		alert("Unit of Installation of Drip Irrigation Exceeds the Land Development");
		totnoofacres=0.00;
		return false;
	}
	totnoofacres=0.00;
	for(var j=0;j<eval(varPlantDetSize);j++)
	{
		if(document.forms[0].txt_unitDrip.length>=2)
		{
			totnoofacres=NanNumber(parseFloat(totnoofacres)+parseFloat(document.forms[0].txt_unitCulti[j].value));
		}
		else
		{
			totnoofacres=NanNumber(parseFloat(totnoofacres)+parseFloat(document.forms[0].txt_unitCulti.value));
			
		}
	}
	if(eval(totnoofacres)>eval(varland))
	{
		alert("Unit of Cost of Cultivation Exceeds the Land Development");
		totnoofacres=0.00;
		return false;
	}
	document.forms[0].hidloopsize.value=varloopsize;
	document.forms[0].hidSecondLoop.value=varmaxgrow;
	document.forms[0].hidPlantDetSize.value=varPlantDetSize;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidBeanMethod.value="updateHortiFinancialProgramme";
	document.forms[0].hidBeanGetMethod.value="getHortiFinancialProgramme";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_hortifinancialprogramme.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
	compmargin();
	compdripmargin();
	compcostofcul();
	
	
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	
	disableEditButtons(true, false, false, false, false);
	for(var k=0;k<document.forms[0].txt_totalCost.length;k++)
	{
		document.forms[0].txt_totalCost[k].readOnly=true;	
		document.forms[0].txt_margin[k].readOnly=false;	
		document.forms[0].txt_bankLoan[k].readOnly=true;	
	}
	
	for(var m=0;m<(eval(varmaxgrow)+1);m++)
	{
		 document.forms[0].txt_unit2[m].readOnly=true;
		 document.forms[0].txt_totalCost2[m].readOnly=true;
		 document.forms[0].txt_bankLoan2[m].readOnly=true;
		 document.forms[0].txt_margin2[m].readOnly=false;
	}
	if(document.forms[0].txt_totalCostDrip.length>=2)
	{
		for(var k=0;k<document.forms[0].txt_totalCostDrip.length;k++)
		{
			document.forms[0].txt_totalCostDrip[k].readOnly=true;	
			document.forms[0].txt_marginDrip[k].readOnly=false;	
			document.forms[0].txt_bankLoanDrip[k].readOnly=true;	
		}
	}
	else
	{
		document.forms[0].txt_totalCostDrip.readOnly=true;	
		document.forms[0].txt_marginDrip.readOnly=false;	
		document.forms[0].txt_bankLoanDrip.readOnly=true;
	}
	if(document.forms[0].txt_totalCostCulti.length>=2)
	{
		for(var k=0;k<document.forms[0].txt_totalCostCulti.length;k++)
		{
			
			document.forms[0].txt_unitCostCulti[k].readOnly=true;	
			document.forms[0].txt_totalCostCulti[k].readOnly=true;	
			document.forms[0].txt_marginCulti[k].readOnly=false;	
			document.forms[0].txt_bankLoanCulti[k].readOnly=true;	
		}
	}
	else
	{
		document.forms[0].txt_unitCostCulti.readOnly=true;	
		document.forms[0].txt_totalCostCulti.readOnly=true;	
		document.forms[0].txt_marginCulti.readOnly=false;	
		document.forms[0].txt_bankLoanCulti.readOnly=true;
	}
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getHortiFinancialProgramme";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_hortifinancialprogramme.jsp";
		document.forms[0].submit(); 		
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="action/agr_hortifinancialprogramme.jsp";	
		document.forms[0].hidBeanMethod.value="updateHortiFinancialProgramme";
		document.forms[0].hidBeanGetMethod.value="getHortiFinancialProgramme";
		document.forms[0].submit();		
	}
}	

</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	</head>
<body onload="onloading()">
<form name="frmDSCR" method="post" class="normal">
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
<laps:borrowertype /> 
<laps:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Cost of Cultivation</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="86" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<br>

<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class=shadow align=center>
  <tr> 
      <td height="24" valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="datagrid">
       
       	
          <tr align="center"  class="dataheader"> 
            
            <td>Particulars</td>
           	<td>Unit</td>
            <td>Unit Cost(Rs)</td>
            <td>Total Cost(Rs)</td>
          
            <td>Margin <span id="marginid"></span>%</td>
              <td>Bank Loan(Rs)</td>
            
          </tr>
          <tr>
          	<td  align="left"><b>Year 1</b></td>
          </tr>
          
          <%for(int i=0;i<7;i++)
				{ 
        	  
        	  	int arrColSize=0;
				if(i<arrSize)
				{
					arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null)
						arrColSize=arrCol.size();
				}
        	  if(arrColSize>0)
        	  {
				%>
          <tr class="datagrid" align="center"> 
         	 <td nowrap align="left"><%= strDesc[i]%> 
           		 <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
            </td>
           
            <td> 
              <input type="text" maxlength="15" name="txt_unit" size="15" 
            	<%if(i==1 || i==2 ||i==5 || i==6 ){ %>	onKeyPress="allowInteger()" 
            	value="<%=Helper.checkPercentageDecimalPoint((String)arrCol.get(2))%>" onBlur="compmargin();computeTotCost(<%=i%>);" <%}else{ %>
            	onKeyPress="allowNumber(this)" onBlur="roundtxt(this);compmargin();computeTotCost(<%=i%>);"
            	
				value="<%=Helper.checkDecimal((String)arrCol.get(2))%>"<%} %> style="text-align: right" >
            </td>
           
           	 <td> 
              <input type="text" maxlength="15" name="txt_unitCost" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compmargin();computeTotCost(<%=i%>);"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(3))%>">
            </td>
            <td> 
              <input type="text" maxlength="15"
													name="txt_totalCost" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(4))%>">
            </td>
            <td> 
            <input type="text" maxlength="15" 
													name="txt_margin" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right" onBlur="compmargin()" value="<%=Helper.checkDecimal((String)arrCol.get(5))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" 
													name="txt_bankLoan" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compmargin()"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(6))%>">
            </td>
            </tr>
            <%if(i==0){ %>
            	<tr>
            		<td ><b>Minor Irrigation</b></td>
            	</tr>
            <%} %>
           
          <%}else{
        %>
        <tr class="datagrid" align="center"> 
         
            <td nowrap align="left"><%= strDesc[i]%> 
           		 <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
            </td>
           	<td> 
              <input type="text" maxlength="15" name="txt_unit" size="15" 
            	<%if(i==1 || i==2 ||i==5 || i==6 ){ %>	onKeyPress="allowInteger()"  onBlur="compmargin();computeTotCost(<%=i%>);"<%}else{ %>
            	onKeyPress="allowNumber(this)" onBlur="roundtxt(this);compmargin();computeTotCost(<%=i%>);"
            	<%} %>style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_unitCost" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compmargin();computeTotCost(<%=i%>);"
													style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_totalCost" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" name="txt_margin" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);compmargin()"	style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" name="txt_bankLoan" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);compmargin()"
													style="text-align: right" value="">
             </td>
           
           </tr>
          
            <%if(i==0){ %>
            	<tr>
            		<td ><b>Minor Irrigation</b></td>
            	</tr>
            <%} %>
            
          <%}
       } %>
       
       <tr >
      		 <td colspan="6"><b>Installation of Drip Irrigation</b></td>
       </tr>
       
       
       
          <%for(int i=0;i<(arrPlantDetSize);i++)  //up to plantdet size
				{ 
        	  
        	  	int arrColSize=0;
				if(i<arrFinDripRowSize)
				{
					arrFinDripCol=(ArrayList)arrFinDripRow.get(i);
					if(arrFinDripCol!=null)
						arrColSize=arrFinDripCol.size();
				}
        	  if(arrColSize>0)
        	  {
				%>
          <tr class="datagrid" align="center"> 
         	
            <%    
            	arrColPlant = (ArrayList) arrPlantDet.get(i);
            %>
            <td nowrap align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)arrColPlant.get(2))%>
            <input type="hidden" name="txt_hortidripsno" value="<%=Helper.correctNull((String)arrColPlant.get(1))%>"></td>
            <td> 
              <input type="text" maxlength="15" name="txt_unitDrip" size="15" 
            	onKeyPress="allowNumber(this)" onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
				style="text-align: right" value="<%=Helper.checkDecimal((String)arrFinDripCol.get(2))%>">
            </td>
           	 <td> 
              <input type="text" maxlength="15" 
													name="txt_unitCostDrip" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrFinDripCol.get(3))%>">
            </td>
            
            <td> 
              <input type="text" maxlength="15"
													name="txt_totalCostDrip" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this)"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrFinDripCol.get(4))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" 
													name="txt_marginDrip" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compdripmargin()"
													style="text-align: right" value="<%=Helper.checkDecimal((String)arrFinDripCol.get(5))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" 
													name="txt_bankLoanDrip" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compdripmargin()"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrFinDripCol.get(6))%>">
            </td>
            </tr>
            
          <%}else{
        %>
        <tr class="datagrid" align="center"> 
         	
            <%    
            	arrColPlant = (ArrayList) arrPlantDet.get(i);
            %>
           	<td nowrap align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)arrColPlant.get(2))%>
            <input type="hidden" name="txt_hortidripsno" value="<%=Helper.correctNull((String)arrColPlant.get(1))%>"></td>
           	<td> 
              <input type="text" maxlength="15" name="txt_unitDrip" size="15" 
            	onKeyPress="allowNumber(this)" onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
            	style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_unitCostDrip" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
													style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_totalCostDrip" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this)"
													style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_marginDrip" size="15" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);compdripmargin()"
													style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_bankLoanDrip" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compdripmargin()"
													style="text-align: right" value="">
             </td>
           </tr>
          
          <%}
       } %>
       
       <tr>
      		 <td colspan="6"><b>Cost of Cultivation</b></td>
       </tr>
       
       
       
       
       
          <%for(int i=0;i<(arrPlantDetSize);i++)//up to plant det size
				{ 
        	  
        	  	int arrColSize=0;
				if(i<arrFinCultiRowSize)
				{
					arrFinCultiCol=(ArrayList)arrFinCultiRow.get(i);
					if(arrFinCultiCol!=null)
						arrColSize=arrFinCultiCol.size();
				}
        	  if(arrColSize>0)
        	  {
				%>
          <tr class="datagrid" align="center"> 
         	
            <%
            	arrColPlant = (ArrayList) arrPlantDet.get(i);
            %>
    		 	<td nowrap align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)arrColPlant.get(2))%>
            	 <input type="hidden" name="txt_horticultisno" value="<%=Helper.correctNull((String)arrColPlant.get(1))%>"></td>
            	
            <td> 
              <input type="text" maxlength="15" name="txt_unitCulti" size="15" 
            	onKeyPress="allowNumber(this)" onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
            	style="text-align: right" value="<%=Helper.checkDecimal((String)arrFinCultiCol.get(2))%>">
            </td>
            <%
            	 if((arrYearRow.size()-1)>=i)
            	 {
            		arrYearCol = (ArrayList) arrYearRow.get(i);
            	%>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_unitCostCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrYearCol.get(1))%>">
            </td>
            <%}else{ %>
            
             <td> 
              <input type="text" maxlength="15" 
													name="txt_unitCostCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <%} %>
            <td> 
              <input type="text" maxlength="15"
													name="txt_totalCostCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrFinCultiCol.get(4))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" 
													name="txt_marginCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compcostofcul()"
													style="text-align: right" value="<%=Helper.checkDecimal((String)arrFinCultiCol.get(5))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" 
													name="txt_bankLoanCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compcostofcul()"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrFinCultiCol.get(6))%>">
            </td>
            </tr>
           
            
          
          <%}else{
        %>
        <tr class="datagrid" align="center"> 
         	
            <%
         	   
            	arrColPlant = (ArrayList) arrPlantDet.get(i);
            %>
    		 	<td nowrap align="left">&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)arrColPlant.get(2))%>
    		 	 <input type="hidden" name="txt_horticultisno" value="<%=Helper.correctNull((String)arrColPlant.get(1))%>"></td>
    		 	
           	 <td> 
              <input type="text" maxlength="15" name="txt_unitCulti" size="15" 
            	onKeyPress="allowNumber(this)" onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
            	style="text-align: right" value="">
             </td>
             <%if((arrYearRow.size()-1)>=i)
   			 {
            	arrYearCol = (ArrayList) arrYearRow.get(i);
            	%>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_unitCostCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrYearCol.get(1))%>">
            </td>
              <%}else{ %>
            
             <td> 
              <input type="text" maxlength="15" 
													name="txt_unitCostCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeTotCostDrip(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <%} %>
            
             <td> 
              <input type="text" maxlength="15" 
													name="txt_totalCostCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_marginCulti" size="15" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);compcostofcul()"
													style="text-align: right" value="">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_bankLoanCulti" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);compcostofcul()"
													style="text-align: right" value="">
             </td>
           
           </tr>
          
          <%}
       } %>
       
       
       
       
       
       
       <tr class="dataheader">
       		<td colspan="6">Cost Of Cultivation</td>
       </tr>
       <%for(int i=0;i<(intmaxgrow+1);i++)
				{ 
				int arrColSize2=0;
				if(i<arrSize2)
				{
					arrCol2=(ArrayList)arrRow2.get(i);
					if(arrCol2!=null)
						arrColSize2=arrCol2.size();
				}
				if(arrColSize2>0)
	        	  {
        	  %>
          <tr align="center" class="datagrid" >
          <%if(i!= (intmaxgrow)){%>
          	<td align="left" ><b>Year<%=i+1%>&nbsp;Cost of Cultivation</b></td>
          	  <%} else{%>
            <td align="right"><b>Total</b></td>
            <%} %>
          	<td><input type="text" maxlength="15" name="txt_unit2" size="15" 
            	  onKeyPress="allowNumber(this)" 
            		style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="<%=Helper.checkDecimal((String)arrCol2.get(2))%>"></td>
            <td>&nbsp;</td>
          
            
            <td> <input type="text" maxlength="15" 
													name="txt_totalCost2" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="<%=Helper.checkDecimal((String)arrCol2.get(3))%>"></td>
			<td> 
              <input type="text" maxlength="15" 
													name="txt_margin2" size="15" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);"
													style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="<%=Helper.checkDecimal((String)arrCol2.get(4))%>">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_bankLoan2" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="<%=Helper.checkDecimal((String)arrCol2.get(5))%>">
             </td>
          </tr>
          <%}else{%>
				
				<tr align="center" class="datagrid" >
			 <%if(i!= (intmaxgrow)){%>
          	<td align="left" ><b>Year<%=i+1%>&nbsp;Cost of Cultivation</b></td>
          	 <%} else{%>
            <td align="right"><b>Total</b></td>
            <%} %>
          	<td><input type="text" maxlength="15" name="txt_unit2" size="15" 
            	  onKeyPress="allowNumber(this)" 
            		style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="0.00"></td>
            <td>&nbsp;</td>
            
            <td> <input type="text" maxlength="15" 
													name="txt_totalCost2" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="0.00"></td>
			<td> 
              <input type="text" maxlength="15" 
													name="txt_margin2" size="15" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);"
													style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="0.00">
             </td>
             <td> 
              <input type="text" maxlength="15" 
													name="txt_bankLoan2" size="15" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right;background-color:#F4F7FC;border-style:none; color:#000000;font-weight:bold;" value="0.00">
             </td>
          </tr>
			
				<% }} %>
        </table>
      </td>
        </tr>
      </table>
   
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="1">
	<tr valign="top">
		<td>
		<laps:combuttonnew
	btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		
		
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>
  <input type=hidden name="hidBeanId">
  <input type=hidden name="hidBeanMethod">
  <input type=hidden name="hidBeanGetMethod">
  <input type=hidden name="hidSourceUrl">
  <input type="hidden" name="hidAction">
  <input type="hidden" name="hidloopsize">
  <input type="hidden" name="hidSecondLoop">
  <input type="hidden" name="hidPlantDetSize">
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
 </form>
</body>
</html>