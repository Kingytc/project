<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	request.setAttribute("_cache_refresh", "true");

%>
<laps:handleerror />
<%
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String strorgcode = Helper.correctNull((String) session
			.getAttribute("strOrgCode"));
	String appstatus = Helper.correctNull((String) session
			.getAttribute("appstatus"));
	String strappno = Helper.correctNull((String) session
			.getAttribute("strappno"));

	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize = 0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrPlantDet = new ArrayList();
	ArrayList arrColPlant = new ArrayList();
	ArrayList arrHerdPrjRow = new ArrayList();
	ArrayList arrHerdPrjCol = new ArrayList();
	HashMap hshHerd = new HashMap();
	int arrPlantDetSize = 0;
	int arrHerdPrjSize = 0;

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrIncome");
	}
	if (arrRow != null) {
		arrSize = arrRow.size();
	}
	String strDesc1[] = {
			"No of young males sold&nbsp;&nbsp;<b>(A)</b>",
			"No of young females sold&nbsp;&nbsp;<b>(B)</b>",
			"No of culled adult females sold&nbsp;&nbsp;<b>(C)</b>",
			"No of culled adult males sold&nbsp;&nbsp;<b>(D)</b>",
			"Sale price of Manure<b>(E)</b>",
			"Sale price of Gunny Bags <b>(F)</b>",
			"Total" };

	if (hshValues != null) {
		arrPlantDet = (ArrayList) hshValues.get("arrHortiplant");
	}
	if (arrPlantDet != null) {
		arrPlantDetSize = arrPlantDet.size();
	}
	
	if (hshValues != null) {
		hshHerd = (HashMap) hshValues.get("HshHerdPrjChart");
	}
	if (hshHerd != null) {
		arrHerdPrjRow = (ArrayList) hshHerd.get("arrHerdPrjChart");
	}
	if (arrHerdPrjRow != null) {
		arrHerdPrjSize = arrHerdPrjRow.size();
	}
	
	String strschemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(strschemetype. trim().equalsIgnoreCase(""))
	{
		strschemetype="0";
	}
	String strCategoryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));
	
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
	String strSSIType = Helper.correctNull((String) request
			.getParameter("hidSSIType"));
%>
<html>
<head>
<title>Income</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var plant_name = "<%=Helper.correctNull((String) hshValues.get("strPlantId"))%>";
var yieldingperiod="0";

function onloading()
{	  
	
	calculateTotal();
	computeLambEweCost(0);
	computeLambEweCost(1);
	computeLambEweCost(2);
	computeLambEweCost(3);
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		  enableButtons(false, true, true, true,false);
	    }
	else
	{
		enableButtons(true,true,true,true,true, false);
	}
	}
	else
	{
		enableButtons(true,true,true,true,true, false);
	}
	disabledFields(true);
	 document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value="<%=strschemetype%>";
	

}

function computeIncome()
{
	/*document.forms[0].txt_year1[5].value=NanNumber(roundVal(eval(document.forms[0].txt_year1[4].value)*
			eval(document.forms[0].txt_cost[4].value)));
	document.forms[0].txt_year2[5].value=NanNumber(roundVal(eval(document.forms[0].txt_year2[4].value)*
			eval(document.forms[0].txt_cost[4].value)));
	document.forms[0].txt_year3[5].value=NanNumber(roundVal(eval(document.forms[0].txt_year3[4].value)*
			eval(document.forms[0].txt_cost[4].value)));
	document.forms[0].txt_year4[5].value=NanNumber(roundVal(eval(document.forms[0].txt_year4[4].value)*
			eval(document.forms[0].txt_cost[4].value)));
	document.forms[0].txt_year5[5].value=NanNumber(roundVal(eval(document.forms[0].txt_year5[4].value)*
			eval(document.forms[0].txt_cost[4].value)));
	document.forms[0].txt_year6[5].value=NanNumber(roundVal(eval(document.forms[0].txt_year6[4].value)*
			eval(document.forms[0].txt_cost[4].value)));


	document.forms[0].txt_year1[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year1[7].value)*
			eval(document.forms[0].txt_cost[5].value)));
	document.forms[0].txt_year2[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year2[7].value)*
			eval(document.forms[0].txt_cost[5].value)));
	document.forms[0].txt_year3[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year3[7].value)*
			eval(document.forms[0].txt_cost[5].value)));
	document.forms[0].txt_year4[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year4[7].value)*
			eval(document.forms[0].txt_cost[5].value)));
	document.forms[0].txt_year5[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year5[7].value)*
			eval(document.forms[0].txt_cost[5].value)));
	document.forms[0].txt_year6[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year6[7].value)*
			eval(document.forms[0].txt_cost[5].value)));*/

	calculateTotal();
}
function computeIncomeOfSale(id)
{
	var id1= parseInt(id)+1;
	if(id==5)
	{
	/*	document.forms[0].txt_year1[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year1[7].value)*
				eval(document.forms[0].txt_cost[id].value)));

		document.forms[0].txt_year2[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year2[7].value)*
				eval(document.forms[0].txt_cost[id].value)));

		document.forms[0].txt_year3[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year3[7].value)*
				eval(document.forms[0].txt_cost[id].value)));

		document.forms[0].txt_year4[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year4[7].value)*
				eval(document.forms[0].txt_cost[id].value)));

		document.forms[0].txt_year5[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year5[7].value)*
				eval(document.forms[0].txt_cost[id].value)));

		document.forms[0].txt_year6[8].value=NanNumber(roundVal(eval(document.forms[0].txt_year6[7].value)*
				eval(document.forms[0].txt_cost[id].value)));*/
	}else if(id==4){

	document.forms[0].txt_year1[id1].value=NanNumber(roundVal(eval(document.forms[0].txt_year1[id].value)*
			eval(document.forms[0].txt_cost[id].value)));

	document.forms[0].txt_year2[id1].value=NanNumber(roundVal(eval(document.forms[0].txt_year2[id].value)*
			eval(document.forms[0].txt_cost[id].value)));

	document.forms[0].txt_year3[id1].value=NanNumber(roundVal(eval(document.forms[0].txt_year3[id].value)*
			eval(document.forms[0].txt_cost[id].value)));

	document.forms[0].txt_year4[id1].value=NanNumber(roundVal(eval(document.forms[0].txt_year4[id].value)*
			eval(document.forms[0].txt_cost[id].value)));

	document.forms[0].txt_year5[id1].value=NanNumber(roundVal(eval(document.forms[0].txt_year5[id].value)*
			eval(document.forms[0].txt_cost[id].value)));

	document.forms[0].txt_year6[id1].value=NanNumber(roundVal(eval(document.forms[0].txt_year6[id].value)*
			eval(document.forms[0].txt_cost[id].value)));
	}
	calculateTotal();
}


function computeLambEweCost(id)
{
		if(id==0)
	{
		<%if (arrHerdPrjRow != null && arrHerdPrjRow.size()>0) {
				arrHerdPrjCol = (ArrayList) arrHerdPrjRow.get(4);%>
				document.forms[0].txt_year1[0].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[0].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(0))))%>));
				document.forms[0].txt_year2[0].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[0].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(1))))%>));
				document.forms[0].txt_year3[0].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[0].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(2))))%>));
				document.forms[0].txt_year4[0].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[0].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(3))))%>));
				document.forms[0].txt_year5[0].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[0].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(4))))%>));
				document.forms[0].txt_year6[0].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[0].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(5))))%>));
			<%}
		%>
		calculateTotal1Year1(id);
	}
	if(id==1)
	{
		<%if (arrHerdPrjRow != null && arrHerdPrjRow.size()>0) {
				arrHerdPrjCol = (ArrayList) arrHerdPrjRow.get(7);%>
				document.forms[0].txt_year1[1].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[1].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(0))))%>));
				document.forms[0].txt_year2[1].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[1].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(1))))%>));
				document.forms[0].txt_year3[1].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[1].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(2))))%>));
				document.forms[0].txt_year4[1].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[1].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(3))))%>));
				document.forms[0].txt_year5[1].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[1].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(4))))%>));
				document.forms[0].txt_year6[1].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[1].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(5))))%>));
			<%}
		%>
		calculateTotal2Year2(id);
	}
	if(id==2)
	{
		<%if (arrHerdPrjRow != null && arrHerdPrjRow.size()>0) {
				arrHerdPrjCol = (ArrayList) arrHerdPrjRow.get(10);%>
				document.forms[0].txt_year1[2].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[2].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(0))))%>));
				document.forms[0].txt_year2[2].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[2].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(1))))%>));
				document.forms[0].txt_year3[2].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[2].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(2))))%>));
				document.forms[0].txt_year4[2].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[2].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(3))))%>));
				document.forms[0].txt_year5[2].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[2].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(4))))%>));
				document.forms[0].txt_year6[2].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[2].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(5))))%>));
			<%}
		%>
		calculateTotal3Year3(id);
	}
	if(id==3)
	{
		<%if (arrHerdPrjRow != null && arrHerdPrjRow.size()>0) {
				arrHerdPrjCol = (ArrayList) arrHerdPrjRow.get(13);%>
				document.forms[0].txt_year1[3].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[3].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(0))))%>));
				document.forms[0].txt_year2[3].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[3].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(1))))%>));
				document.forms[0].txt_year3[3].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[3].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(2))))%>));
				document.forms[0].txt_year4[3].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[3].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(3))))%>));
				document.forms[0].txt_year5[3].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[3].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(4))))%>));
				document.forms[0].txt_year6[3].value=roundVal(NanNumber(NanNumber(document.forms[0].txt_cost[3].value)*
						<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrHerdPrjCol.get(5))))%>));
			<%}
		%>
		calculateTotal4Year4(id);
	}
	calculateTotal();
	
}
function calculateTotal()
{
	var tot=0.00;
	for(var i=0;i<document.forms[0].txt_year1.length;i++)
	{
		if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
		{
			var year1=0;
			year1 =document.forms[0].txt_year1[i].value;
			if(year1=="")
			{
				year1=0;
			}
			tot =eval(tot)+eval(year1);
		}
	}
	document.forms[0].txt_tot1.value = NanNumber(roundVal(tot));
	roundtxt(document.forms[0].txt_tot1);

	tot=0.00;
	for(var i=0;i<document.forms[0].txt_year1.length;i++)
	{
		if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
		{
			var year1=0;
			year1 =document.forms[0].txt_year2[i].value;
			if(year1=="")
			{
				year1=0;
			}
			tot =eval(tot)+eval(year1);
		}
	}
	document.forms[0].txt_tot2.value = NanNumber(roundVal(tot));
	roundtxt(document.forms[0].txt_tot2);  
	

	tot=0.00;
	for(var i=0;i<document.forms[0].txt_year1.length;i++)
	{
		if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
		{
			var year1=0;
			year1 =document.forms[0].txt_year3[i].value;
			if(year1=="")
			{
				year1=0;
			}
			tot =eval(tot)+eval(year1);
		}
	}
	document.forms[0].txt_tot3.value = NanNumber(roundVal(tot));
	roundtxt(document.forms[0].txt_tot3);  
	

	 tot=0.00;
	for(var i=0;i<document.forms[0].txt_year1.length;i++)
	{
		if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
		{
			var year1=0;
			year1 =document.forms[0].txt_year4[i].value;
			if(year1=="")
			{
				year1=0;
			}
			tot =eval(tot)+eval(year1);
		}
	}
	document.forms[0].txt_tot4.value = NanNumber(roundVal(tot));
	roundtxt(document.forms[0].txt_tot4);  
	

	tot=0.00;
	for(var i=0;i<document.forms[0].txt_year1.length;i++)
	{
		if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
		{
			var year1=0;
			year1 =document.forms[0].txt_year5[i].value;
			if(year1=="")
			{
				year1=0;
			}
			tot =eval(tot)+eval(year1);
		}
	}
	document.forms[0].txt_tot5.value = NanNumber(roundVal(tot));
	roundtxt(document.forms[0].txt_tot5);
	

	tot=0.00;
	for(var i=0;i<document.forms[0].txt_year1.length;i++)
	{
		if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
		{
			var year1=0;
			year1 =document.forms[0].txt_year6[i].value;
			if(year1=="")
			{
				year1=0;
			}
			tot =eval(tot)+eval(year1);
		}
	}
	document.forms[0].txt_tot6.value = NanNumber(roundVal(tot));
	roundtxt(document.forms[0].txt_tot6); 
}
function doSave()
{   
	calculateTotal();
	enableButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrnursery";
	document.forms[0].hidBeanMethod.value="updateSheepIncome";
	document.forms[0].hidBeanGetMethod.value="getSheepIncome";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_sheepincome.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function enableButtons(bool1, bool2, bool3, bool4,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	
	document.forms[0].cmdclose.disabled=bool6;
}
function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
	
	
}
function doEdit()
{
	
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);

	for(var i=0;i<document.forms[0].txt_year1.length;i++)
	{
		if(i==0 || i==1 || i==2 || i==3)
		{
		  document.forms[0].txt_year1[i].readOnly=true;	
		  document.forms[0].txt_year2[i].readOnly=true;	
		  document.forms[0].txt_year3[i].readOnly=true;	
		  document.forms[0].txt_year4[i].readOnly=true;		  
		  document.forms[0].txt_year5[i].readOnly=true;		  
		  document.forms[0].txt_year6[i].readOnly=true;		  	  
		}
		if(i==4 || i==5)
		{
			document.forms[0].txt_year1[i].readOnly=false;	
			document.forms[0].txt_year2[i].readOnly=false;	
			document.forms[0].txt_year3[i].readOnly=false;	
			document.forms[0].txt_year4[i].readOnly=false;		  
			document.forms[0].txt_year5[i].readOnly=false;		  
			document.forms[0].txt_year6[i].readOnly=false;
		}
	}

	
	document.forms[0].txt_tot1.readOnly=true;
	document.forms[0].txt_tot2.readOnly=true;	
	document.forms[0].txt_tot3.readOnly=true;	
	document.forms[0].txt_tot4.readOnly=true;	
	document.forms[0].txt_tot5.readOnly=true;	
	document.forms[0].txt_tot6.readOnly=true;		
	///disableEditButtons(true, false, false, false, false, false);	
	enableButtons(true, false, false, false, false);

}
function calculateTotal1Year1(flag)
{
		if(flag==4)
		{
			
			/*document.forms[0].txt_year1[6].value = parseFloat(document.forms[0].txt_year1[4].value)*
			     								parseFloat(document.forms[0].txt_year1[5].value);
			document.forms[0].txt_year1[6].value=NanNumber(document.forms[0].txt_year1[6].value);
			roundtxt(document.forms[0].txt_year1[6]);*/  
		}
		if(flag==5)
		{
			/*document.forms[0].txt_year1[7].value = parseFloat(document.forms[0].txt_year1[6].value)*0.5;
			document.forms[0].txt_year1[7].value=NanNumber(document.forms[0].txt_year1[7].value);
			roundtxt(document.forms[0].txt_year1[7]);*/  
		}
		computeIncome();
		
		/**document.forms[0].txt_tot1.value = (parseFloat(eval(document.forms[0].txt_year1[0].value)))+
				(parseFloat(eval(document.forms[0].txt_year1[1].value)))+
				(parseFloat(eval(document.forms[0].txt_year1[2].value)))+
				(parseFloat(eval(document.forms[0].txt_year1[3].value)))+
				(parseFloat(eval(document.forms[0].txt_year1[6].value)))+
				(parseFloat(eval(document.forms[0].txt_year1[8].value)));
		document.forms[0].txt_tot1.value=NanNumber(document.forms[0].txt_tot1.value);
		roundtxt(document.forms[0].txt_tot1);**/
		  
		var tot=0.00;
		for(var i=0;i<document.forms[0].txt_year1.length;i++)
		{
			if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
			{
				var year1=0;
				year1 =document.forms[0].txt_year1[i].value;
				
				if(year1=="")
				{
					year1=0;
				}
				tot =eval(tot)+eval(year1);
			}
		}
		
		document.forms[0].txt_tot1.value = NanNumber(roundVal(tot));
		roundtxt(document.forms[0].txt_tot1);
}

function calculateTotal2Year2(flag)
{
		if(flag==4)
		{
		/*	document.forms[0].txt_year2[6].value = parseFloat(document.forms[0].txt_year2[4].value)*
			     								parseFloat(document.forms[0].txt_year2[5].value);
			document.forms[0].txt_year2[6].value=NanNumber(document.forms[0].txt_year2[6].value);
			roundtxt(document.forms[0].txt_year2[6]);  */
		}
		if(flag==5)
		{
			/*document.forms[0].txt_year2[7].value = parseFloat(document.forms[0].txt_year2[6].value)*0.5;
			document.forms[0].txt_year2[7].value=NanNumber(document.forms[0].txt_year2[7].value);
			roundtxt(document.forms[0].txt_year2[7]);*/  
		}computeIncome();
		var tot=0.00;
		for(var i=0;i<document.forms[0].txt_year1.length;i++)
		{
			if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
			{
				var year1=0;
				year1 =document.forms[0].txt_year2[i].value;
				if(year1=="")
				{
					year1=0;
				}
				tot =eval(tot)+eval(year1);
			}
		}
		document.forms[0].txt_tot2.value = NanNumber(roundVal(tot));
		roundtxt(document.forms[0].txt_tot2);  
}

function calculateTotal3Year3(flag)
{
		if(flag==4)
		{
			/*document.forms[0].txt_year3[6].value = parseFloat(document.forms[0].txt_year3[4].value)*
			     								parseFloat(document.forms[0].txt_year3[5].value);
			document.forms[0].txt_year3[6].value=NanNumber(document.forms[0].txt_year3[6].value);
			roundtxt(document.forms[0].txt_year3[6]);  */
		}
		if(flag==5)
		{
	/*		document.forms[0].txt_year3[7].value = parseFloat(document.forms[0].txt_year3[6].value)*0.5;
			document.forms[0].txt_year3[7].value=NanNumber(document.forms[0].txt_year3[7].value);
			roundtxt(document.forms[0].txt_year3[7]);*/  
		}computeIncome();
		var tot=0.00;
		for(var i=0;i<document.forms[0].txt_year1.length;i++)
		{
			if(i==0 || i==1 || i==2 || i==3 ||i==4 || i==5)
			{
				var year1=0;
				year1 =document.forms[0].txt_year3[i].value;
				if(year1=="")
				{
					year1=0;
				}
				tot =eval(tot)+eval(year1);
			}
		}
		document.forms[0].txt_tot3.value = NanNumber(roundVal(tot));
		roundtxt(document.forms[0].txt_tot3);  
}

function calculateTotal4Year4(flag)
{
		if(flag==4)
		{
			/*document.forms[0].txt_year4[6].value = parseFloat(document.forms[0].txt_year4[4].value)*
			     								parseFloat(document.forms[0].txt_year4[5].value);
			document.forms[0].txt_year4[6].value=NanNumber(document.forms[0].txt_year4[6].value);
			roundtxt(document.forms[0].txt_year4[6]);  */
		}
		if(flag==5)
		{
			/*document.forms[0].txt_year4[7].value = parseFloat(document.forms[0].txt_year4[6].value)*0.5;
			document.forms[0].txt_year4[7].value=NanNumber(document.forms[0].txt_year4[7].value);
			roundtxt(document.forms[0].txt_year4[7]);*/  
		}
		computeIncome();
		var tot=0.00;
		for(var i=0;i<document.forms[0].txt_year1.length;i++)
		{
			if(i==0 || i==1 || i==2 || i==3 || i==4 || i==5)
			{
				var year1=0;
				year1 =document.forms[0].txt_year4[i].value;
				if(year1=="")
				{
					year1=0;
				}
				tot =eval(tot)+eval(year1);
			}
		}
		document.forms[0].txt_tot4.value = NanNumber(roundVal(tot));
		roundtxt(document.forms[0].txt_tot4);  
}

function calculateTotal5Year5(flag)
{
		if(flag==4)
		{
			/*document.forms[0].txt_year5[6].value = parseFloat(document.forms[0].txt_year5[4].value)*
			     								parseFloat(document.forms[0].txt_year5[5].value);
			document.forms[0].txt_year5[6].value=NanNumber(document.forms[0].txt_year5[6].value);
			roundtxt(document.forms[0].txt_year5[6]);  */
		}
		if(flag==5)
		{
			/*document.forms[0].txt_year5[7].value = parseFloat(document.forms[0].txt_year5[6].value)*0.5;
			document.forms[0].txt_year5[7].value=NanNumber(document.forms[0].txt_year5[7].value);
			roundtxt(document.forms[0].txt_year5[7]);*/  
		}computeIncome();
		var tot=0.00;
		for(var i=0;i<document.forms[0].txt_year1.length;i++)
		{
			if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
			{
				var year1=0;
				year1 =document.forms[0].txt_year5[i].value;
				if(year1=="")
				{
					year1=0;
				}
				tot =eval(tot)+eval(year1);
			}
		}
		document.forms[0].txt_tot5.value = NanNumber(roundVal(tot));
		roundtxt(document.forms[0].txt_tot5);
}

function calculateTotal6Year6(flag)
{
		if(flag==4)
		{
		
			/*document.forms[0].txt_year6[6].value = parseFloat(document.forms[0].txt_year6[4].value)*
			     								parseFloat(document.forms[0].txt_year6[5].value);
			document.forms[0].txt_year6[6].value=NanNumber(document.forms[0].txt_year6[6].value);
			roundtxt(document.forms[0].txt_year6[6]);  */
		}
		if(flag==5)
		{
			/*document.forms[0].txt_year6[7].value = parseFloat(document.forms[0].txt_year6[6].value)*0.5;
			document.forms[0].txt_year6[7].value=NanNumber(document.forms[0].txt_year6[7].value);
			roundtxt(document.forms[0].txt_year6[7]);*/  
		}computeIncome();
		var tot=0.00;
		for(var i=0;i<document.forms[0].txt_year1.length;i++)
		{
			if(i==0 || i==1 || i==2 || i==3||i==4 || i==5)
			{
				var year1=0;
				year1 =document.forms[0].txt_year6[i].value;
				if(year1=="")
				{
					year1=0;
				}
				tot =eval(tot)+eval(year1);
			}
		}
		document.forms[0].txt_tot6.value = NanNumber(roundVal(tot));
		roundtxt(document.forms[0].txt_tot6);  
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getSheepIncome";
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].action=appUrl+"action/agr_sheepincome.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrnursery";
		document.forms[0].hidSourceUrl.value="action/agr_sheepincome.jsp";	
		document.forms[0].hidBeanMethod.value="updateSheepIncome";
		document.forms[0].hidBeanGetMethod.value="getSheepIncome";
		document.forms[0].submit();		
	}
}	



</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmDSCR" method=post class="normal">
<!--<div id="ie5menu" class="skin0" onMouseover="highlightie5()"-->
<!--	onMouseout="lowlightie5()" onClick="jumptoie5()">-->
<!--<div class="menuitems"><script language="JavaScript1.2">-->
<!---->
<!--if (document.all && window.print)-->
<!--{-->
<!--	ie5menu.className = menuskin;-->
<!--	document.oncontextmenu = showmenuie5;-->
<!--	document.body.onclick = hidemenuie5;-->
<!--}-->
<!--</script></div>-->
<!--</div>-->


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
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
	<td class="page_flow">Home -> Agriculture -> Income </td>
	
	</tr>
</table>
<laps:borrowertype /> 
<laps:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="78" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>




<br>
<table width="95%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1" align="center">
	<tr>
		<td height="24" valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center" class="dataHeader">
				<td WIDTH="5%">S.No</td>
				<td WIDTH="19%">Particulars</td>
				
				<td WIDTH="3%">Average weight</td>
				<td WIDTH="3%">Rate/kg</td>
				
				<td WIDTH="5%">Sale price /Animal</td>
				<td WIDTH="11%">YEAR I</td>
				<td WIDTH="11%">YEAR II</td>
				<td WIDTH="11%">YEAR III</td>
				<td WIDTH="11%">YEAR IV</td>
				<td WIDTH="11%">YEAR V</td>
				<td WIDTH="11%">YEAR VI</td>
			</tr>
			<%
				for (int i = 0; i <6; i++) {

					int arrColSize = 0;
					if (i < arrSize) {
						arrCol = (ArrayList) arrRow.get(i);

						if (arrCol != null)
							arrColSize = arrCol.size();
					}
					if (arrColSize > 0) {
			%>
			<tr class="dataGridColor" align="center" valign="top">
				<%
					if (i <= 3) {
				%>
				<td align="center" WIDTH="5%" valign="top"><%=i + 1%></td>
				<td WIDTH="19%" align="left" ><%=strDesc1[i]%></td>
				<%
					}else{                        
				%>
				<td align="center" WIDTH="5%" valign="top"><%=i + 1%></td>
				<td WIDTH="19%" align="left" ><%=strDesc1[i]%></td>
				<%
					} 
				%>
				<%if(i<4 ){ %>
				
				<td  VALIGN="MIDDLE"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="7" NAME="txt_avgwt" SIZE="15"
					onblur=""
					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" 
					VALUE="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(7))))%>"></td>
				<td  VALIGN="MIDDLE"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="7" NAME="txt_rateperkg" SIZE="15"
					onblur=""
					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" 
					VALUE="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(8))))%>"></td>
				<td  VALIGN="MIDDLE"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="7" NAME="txt_cost" SIZE="15"
					onblur="computeLambEweCost('<%=i%>');"
					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" 
					VALUE="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))%>"></td>
					<%}else{ %>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td> 
					<%} %>
				<td WIDTH="11%" VALIGN="MIDDLE" HEIGHT="30"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="1" NAME="txt_year1" SIZE="15"
					ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"
					onblur="calculateTotal1Year1('<%=i%>');"
					VALUE="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(0))))%>"></td>
				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="2" NAME="txt_year2" SIZE="15"
					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"
					ONBLUR="roundtxt(this);calculateTotal2Year2('<%=i%>');"
					VALUE="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(1))))%>"></td>
				<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
					maxlength="15" tabindex="3" name="txt_year3" SIZE="15"
					onKeyPress="allowDecimal(this)" style="text-align: right"
					onblur="roundtxt(this);calculateTotal3Year3('<%=i%>');"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(2))))%>"></td>
				<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
					maxlength="15" tabindex="4" name="txt_year4" SIZE="15"
					onKeyPress="allowDecimal(this)" style="text-align: right"
					onblur="roundtxt(this);calculateTotal4Year4('<%=i%>');"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(3))))%>"></td>
				<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
					maxlength="15" tabindex="5" name="txt_year5" SIZE="15"
					onKeyPress="allowDecimal(this)" style="text-align: right"
					onblur="roundtxt(this);calculateTotal5Year5('<%=i%>');"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(4))))%>"></td>
				<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
					maxlength="15" tabindex="6" name="txt_year6" SIZE="15"
					onKeyPress="allowDecimal(this)" style="text-align: right"
					onblur="roundtxt(this);calculateTotal6Year6('<%=i%>');"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(5))))%>"></td>
			</tr>
			<%if(i>3){ %>
			
			<%if(i==5){ %>
			<Tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></Tr>
			
			<%} %>
			
<!--			<tr class="dataGridColor" align="center" valign="bottom">-->
			
					<%//if(i==4){%>
						
<!--				<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="7" NAME="txt_avgwt" SIZE="15"-->
<!--					onblur=""-->
<!--					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--					VALUE=""></td>-->
<!--				<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="7" NAME="txt_rateperkg" SIZE="15"-->
<!--					onblur=""-->
<!--					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--					VALUE=""></td>-->
					
<!--				<td  VALIGN="MIDDLE" nowrap="nowrap" ><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="7" NAME="txt_cost" SIZE="15"-->
<!--					onblur=""-->
<!--					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--					VALUE=""></td>-->
			<%//}else{ %>
<!--			<td>&nbsp;</td>-->
<!--			<td>&nbsp;</td>-->
<!--			<td>&nbsp;</td>-->
				<%//} %>
<!--				<td WIDTH="11%" VALIGN="MIDDLE" HEIGHT="30"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="1" NAME="txt_year1" SIZE="15"-->
<!--					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--					ONBLUR="roundtxt(this);calculateTotal1Year1('');"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="2" NAME="txt_year2" SIZE="15"-->
<!--					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--					ONBLUR="roundtxt(this);calculateTotal2Year2('');"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="3" NAME="txt_year3" SIZE="15"-->
<!--					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--					ONBLUR="roundtxt(this);calculateTotal3Year3('');"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="4" NAME="txt_year4" SIZE="15"-->
<!--					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--					ONBLUR="roundtxt(this);calculateTotal4Year4('');"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="5" NAME="txt_year5" SIZE="15"-->
<!--					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--					ONBLUR="roundtxt(this);calculateTotal5Year5('');"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="6" NAME="txt_year6" SIZE="15"-->
<!--					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--					ONBLUR="roundtxt(this);calculateTotal6Year6('');"-->
<!--					VALUE=""></td>-->
<!--			</tr>-->
			<%
				//if (i== 5) {
			%>
<!--			<tr class="dataGridColor" align="center" valign="top">-->
			
<!--			<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="7" NAME="txt_avgwt" SIZE="15"-->
<!--					onblur=""-->
<!--					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--					VALUE=""></td>-->
<!--			<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="7" NAME="txt_rateperkg" SIZE="15"-->
<!--					onblur=""-->
<!--					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--					VALUE=""></td>-->
			
<!--			<td  VALIGN="MIDDLE">dfsdf4332<INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="1" NAME="txt_cost" SIZE="15"-->
<!--					onblur="computeIncomeOfSale('');"-->
<!--					ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text" MAXLENGTH="15" TABINDEX="1" NAME="txt_year1" SIZE="15" -->
<!--					ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right" ONBLUR="roundtxt(this);"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="2" NAME="txt_year2" SIZE="15"-->
<!--					ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="3" NAME="txt_year3" SIZE="15"-->
<!--					ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="4" NAME="txt_year4" SIZE="15"-->
<!--					ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="5" NAME="txt_year5" SIZE="15"-->
<!--					ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--					VALUE=""></td>-->
<!--				<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--					MAXLENGTH="15" TABINDEX="6" NAME="txt_year6" SIZE="15"-->
<!--					ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--					VALUE=""></td>-->
<!--			</tr>-->
			
			<%
				//}
			 }
			%>
			<%
				} else {
					%>
					<tr class="dataGridColor" align="center" valign="top">
						<%
							if (i <= 3) {
						%>
						<td align="center" WIDTH="5%" valign="top"><%=i + 1%></td>
						<td WIDTH="19%" align="left" ><%=strDesc1[i]%></td>
						<%
							}else {
						%>
						<td align="center" WIDTH="5%" valign="top"><%=i + 1%></td>
						<td WIDTH="19%" align="left" ><%=strDesc1[i]%></td>
						<%
							} 
						%>
						<%if(i<4 ){ %>
						<td  VALIGN="MIDDLE"><INPUT TYPE="text"
							MAXLENGTH="15" TABINDEX="7" NAME="txt_avgwt" SIZE="15"
							onblur=""
							ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" 
							VALUE=""></td>
						<td  VALIGN="MIDDLE"><INPUT TYPE="text"
							MAXLENGTH="15" TABINDEX="7" NAME="txt_rateperkg" SIZE="15"
							onblur=""
							ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" 
							VALUE=""></td>
					
						
						
						<td  VALIGN="MIDDLE"><INPUT TYPE="text"
							MAXLENGTH="15" TABINDEX="1" NAME="txt_cost" SIZE="15"
							onblur="computeLambEweCost('<%=i%>');"
							ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" 
							VALUE=""></td>
							<%}else{ %>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td> 
							<%} %>
						<td WIDTH="11%" VALIGN="MIDDLE" HEIGHT="30"><INPUT TYPE="text"
							MAXLENGTH="15" TABINDEX="1" NAME="txt_year1" SIZE="15"
							ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"
							onblur="calculateTotal1Year1('<%=i%>');"
							VALUE=""></td>
						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"
							MAXLENGTH="15" TABINDEX="2" NAME="txt_year2" SIZE="15"
							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"
							ONBLUR="roundtxt(this);calculateTotal2Year2('<%=i%>');"
							VALUE=""></td>
						<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
							maxlength="15" tabindex="3" name="txt_year3" SIZE="15"
							onKeyPress="allowDecimal(this)" style="text-align: right"
							onblur="roundtxt(this);calculateTotal3Year3('<%=i%>');"
							value=""></td>
						<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
							maxlength="15" tabindex="4" name="txt_year4" SIZE="15"
							onKeyPress="allowDecimal(this)" style="text-align: right"
							onblur="roundtxt(this);calculateTotal4Year4('<%=i%>');"
							value=""></td>
						<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
							maxlength="15" tabindex="5" name="txt_year5" SIZE="15"
							onKeyPress="allowDecimal(this)" style="text-align: right"
							onblur="roundtxt(this);calculateTotal5Year5('<%=i%>');"
							value=""></td>
						<td WIDTH="11%" VALIGN="MIDDLE"><input type="text"
							maxlength="15" tabindex="6" name="txt_year6" SIZE="15"
							onKeyPress="allowDecimal(this)" style="text-align: right"
							onblur="roundtxt(this);calculateTotal6Year6('<%=i%>');"
							value=""></td>
					</tr>
					<%if(i>3){ %>
					
					<%if(i==5){ %>
					<Tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></Tr>
					
					<%} %>
					
<!--					<tr class="dataGridColor" align="center" valign="bottom">-->
					
							<%//if(i==4){%>
					
<!--						<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="7" NAME="txt_avgwt" SIZE="15"-->
<!--							onblur=""-->
<!--							ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--							VALUE=""></td>-->
<!--						<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="7" NAME="txt_rateperkg" SIZE="15"-->
<!--							onblur=""-->
<!--							ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--							VALUE=""></td>	-->
<!--						<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="1" NAME="txt_cost" SIZE="15"-->
<!--							onblur="computeIncomeOfSale('<%=i%>');"-->
<!--							ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--							VALUE=""></td>-->
					<%//}else{ %>
<!--					<td>&nbsp;</td>-->
<!--					<td>&nbsp;</td>-->
<!--					<td>&nbsp;</td> -->
						<%//} %>
<!--						<td WIDTH="11%" VALIGN="MIDDLE" HEIGHT="30"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="1" NAME="txt_year1" SIZE="15"-->
<!--							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--							ONBLUR="roundtxt(this);calculateTotal1Year1('<%=i%>');"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="2" NAME="txt_year2" SIZE="15"-->
<!--							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--							ONBLUR="roundtxt(this);calculateTotal2Year2('<%=i%>');"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="3" NAME="txt_year3" SIZE="15"-->
<!--							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--							ONBLUR="roundtxt(this);calculateTotal3Year3('<%=i%>');"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="4" NAME="txt_year4" SIZE="15"-->
<!--							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--							ONBLUR="roundtxt(this);calculateTotal4Year4('<%=i%>');"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="5" NAME="txt_year5" SIZE="15"-->
<!--							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--							ONBLUR="roundtxt(this);calculateTotal5Year5('<%=i%>');"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="6" NAME="txt_year6" SIZE="15"-->
<!--							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--							ONBLUR="roundtxt(this);calculateTotal6Year6('<%=i%>');"-->
<!--							VALUE=""></td>-->
<!--					</tr>-->
					<%
						//if (i== 5) {
					%>
<!--					<tr class="dataGridColor" align="center" valign="top">-->
<!--					<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--						MAXLENGTH="15" TABINDEX="7" NAME="txt_avgwt" SIZE="15"-->
<!--						onblur=""-->
<!--						ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--						VALUE=""></td>-->
<!--					<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--						MAXLENGTH="15" TABINDEX="7" NAME="txt_rateperkg" SIZE="15"-->
<!--						onblur=""-->
<!--						ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--						VALUE=""></td>-->
<!--					-->
<!--					-->
<!--					<td  VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="1" NAME="txt_cost" SIZE="15"-->
<!--							onblur="computeIncomeOfSale('');"-->
<!--							ONKEYPRESS="allowNumber(this)" STYLE="text-align: right" -->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="1" NAME="txt_year1" SIZE="15"-->
<!--							ONKEYPRESS="allowDecimal(this)" STYLE="text-align: right"-->
<!--							ONBLUR="roundtxt(this);"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="2" NAME="txt_year2" SIZE="15"-->
<!--							ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="3" NAME="txt_year3" SIZE="15"-->
<!--							ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="4" NAME="txt_year4" SIZE="15"-->
<!--							ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="5" NAME="txt_year5" SIZE="15"-->
<!--							ONKEYPRESS="allowInteger(this)" STYLE="text-align: right"-->
<!--							VALUE=""></td>-->
<!--						<td WIDTH="11%" VALIGN="MIDDLE"><INPUT TYPE="text"-->
<!--							MAXLENGTH="15" TABINDEX="6" NAME="txt_year6" SIZE="15"-->
<!--							ONKEYPRESS="allowInteger(this)" STYLE="text-align: right" VALUE=""></td>-->
<!--					</tr>-->
					
					<%
						//}
					 }
					%>
					<%
						}
				}
			%>
			<tr>
				<td></td>
				<Td ALIGN="LEFT"><b>Total (A+B+C+D+E+F)</b></Td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td WIDTH="11%" align="center"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="1" NAME="txt_tot1" size="15"
					ONKEYPRESS="allowDecimal(this)" ONBLUR="roundtxt(this);"
					style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
					VALUE=""></td>
				<td WIDTH="11%" align="center"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="2" NAME="txt_tot2" size="15"
					ONKEYPRESS="allowDecimal(this)" ONBLUR="roundtxt(this);"
					style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
					VALUE=""></td>
				<td WIDTH="11%" align="center"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="3" NAME="txt_tot3" size="15"
					ONKEYPRESS="allowDecimal(this)" ONBLUR="roundtxt(this);"
					style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
					VALUE=""></td>
				<td WIDTH="11%" align="center"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="4" NAME="txt_tot4" size="15"
					ONKEYPRESS="allowDecimal(this)" ONBLUR="roundtxt(this);"
					style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
					VALUE=""></td>
				<td WIDTH="11%" align="center"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="5" NAME="txt_tot5" size="15"
					ONKEYPRESS="allowDecimal(this)" ONBLUR="roundtxt(this);"
					style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
					VALUE=""></td>
				<td WIDTH="11%" align="center"><INPUT TYPE="text"
					MAXLENGTH="15" TABINDEX="6" NAME="txt_tot6" size="15"
					ONKEYPRESS="allowDecimal(this)" ONBLUR="roundtxt(this);"
					style="text-align: right;background-color:#e7edf8;border-style:none; color:#000000;font-weight:bold;"
					VALUE=""></td>
			</tr>
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
<laps:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<input type="hidden" name="hidBeanId"> <input type="hidden"
	name="hidBeanMethod"> <input type="hidden"
	name="hidBeanGetMethod"> <input type="hidden"
	name="hidSourceUrl"> <input type="hidden" name="hidAction">
<input type="hidden" name="hid_pagename" value=""> <input
	type="hidden" name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
</form>
</body>
</html>