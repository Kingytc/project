<%@ page
	import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@include file="../share/directives.jsp"%>
<%
	request.setAttribute("_cache_refresh", "true");
%>
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

	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);

	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize = 0;
	int subSec = 0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrIncRow = new ArrayList();
	ArrayList arrIncCol = new ArrayList();
	ArrayList arrExpRow = new ArrayList();
	ArrayList arrExpCol = new ArrayList();
	ArrayList arrIncomeRow = new ArrayList();
	ArrayList arrPlantName = new ArrayList();
	ArrayList arrPlantDet = new ArrayList();
	ArrayList arrColPlant = new ArrayList();
	ArrayList arrBCR = new ArrayList();
	int arrPlantDetSize = 0;
	double dblBCR = 0.00;

	if (hshValues != null) {

		arrRow = (ArrayList) hshValues.get("arrRow");
		arrIncomeRow = (ArrayList) hshValues.get("arrIncomeRow");
		arrPlantName = (ArrayList) hshValues.get("arrPlantName");
		arrIncRow = (ArrayList) hshValues.get("arrNetInc");
		arrExpRow = (ArrayList) hshValues.get("arrExpense");
	}
	if (arrRow != null) {
		subSec = arrRow.size();
	}
	if (arrIncomeRow != null) {
		arrSize = arrIncomeRow.size();
	}

	String strDesc[] = {
			"Capital cost(Rs.)",
			"Maintenance cost (Rs.)",
			"Total cost(Rs.)",
			"Income(Rs.)",
			"Net Benefit(Rs.)",
			"DF at "
					+ Helper.correctNull((String) hshValues
							.get("DFPERC")) + "%",
			"PWC at "
					+ Helper.correctNull((String) hshValues
							.get("DFPERC")) + " %df",
			"PWB at "
					+ Helper.correctNull((String) hshValues
							.get("DFPERC")) + " % df",
			"NPW at "
					+ Helper.correctNull((String) hshValues
							.get("DFPERC")) + " % df",
			"DF at "
					+ Helper.correctNull((String) hshValues
							.get("DFNXT")) + " %",
			"NPW at "
					+ Helper.correctNull((String) hshValues
							.get("DFNXT")) + " % df", "BCR", "IRR" };

	if (hshValues != null) {
		arrPlantDet = (ArrayList) hshValues.get("arrHortiplant");
		arrBCR = (ArrayList) hshValues.get("arrBCR");
		if (arrBCR != null && arrBCR.size() > 0) {
			dblBCR = Double.parseDouble(Helper.correctDouble((String) arrBCR.get(2)));
		}

	}
	if (arrPlantDet != null) {
		arrPlantDetSize = arrPlantDet.size();
	}
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
%>
<html>
<head>
<title>Income & Expenditure</title>
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
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var plant_name = "<%=Helper.correctNull((String) hshValues.get("strPlantId"))%>";
var yieldingperiod="0";
var varschemetype="<%=schemetype%>";
function disabledFields(one)
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
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;		  
		}
		if(document.forms[0].elements[i].type=="select-multiple" )
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
}
function onloading()
{	  
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	/*for(var i=0;i<15;i++)
	{
		//computeRowTotal(i);
	}
	if(plant_name!="")
		document.forms[0].sel_plantName.value=plant_name;
	else
		document.forms[0].sel_plantName.value="s";
	
	document.forms[0].sel_plantName.disabled=false;*/
	
	disabledFields(true);
<%/*arrColPlant = new ArrayList();

			 if (arrPlantDet != null) {
			 if (arrPlantDet.size() > 0) {

			 for (int i = 0; i < arrPlantDet.size(); i++) {

			 arrColPlant = (ArrayList) arrPlantDet.get(i);%>
							var pname		=	"<%=Helper.correctNull((String) arrColPlant
			 .get(1))%>";
							
							if(pname==plant_name)
							{
								yieldingperiod = "<%=Helper.correctNull((String) arrColPlant
			 .get(8))%>";
							}
			<%}
			 }
			 }*/%>
			document.all.sel_scheme.disabled=false;
			document.all.sel_scheme.value="<%=schemetype%>";
			<%if(arrIncRow!=null && arrIncRow.size()>0){ %>
				calculatetotincome();
			<%}%>
			<%if(arrExpRow!=null && arrExpRow.size()>0){ %>
				calculatetotExp();
			<%}%>
			calculateNetInc();
}

function doSave()
{   
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidBeanMethod.value="updateHortiCostOfDevelopmentDetails";
	document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_horticulturecostofdevelopment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doEdit()
{
	/*if(document.forms[0].sel_plantName.value=="s")
	{
		alert("Select a plant name");
		return;
	}*/
	document.forms[0].hidAction.value="Edit";
	disabledFields(false);
	/*for(var i=0;i<15;i++)
	{
	document.forms[0].txt_total[i].readOnly=true;
	}*/
	disableEditButtons(true, false, false, true, false, false);	
	//getVisibleYears(yieldingperiod);	

}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function getVisibleYears(yieldingperiod)
{
	if(yieldingperiod=="1")
	{
		make_readOnly(false,true,true,true,true,true,true);
	}
	else if(yieldingperiod=="2")
	{
		make_readOnly(false,false,true,true,true,true,true);
	}
	else if(yieldingperiod=="3")
	{
		make_readOnly(false,false,false,true,true,true,true);
	}
	else if(yieldingperiod=="4")
	{
		make_readOnly(false,false,false,false,true,true,true);
	}
	else if(yieldingperiod=="5")
	{
		make_readOnly(false,false,false,false,false,true,true);
	}
	else if(yieldingperiod=="6")
	{
		make_readOnly(false,false,false,false,false,false,true);
	}
	else if(yieldingperiod=="7")
	{
		make_readOnly(false,false,false,false,false,false,false);
	}
	else
	{
		make_readOnly(true,true,true,true,true,true,true);
	}
}

function make_readOnly(val1,val2,val3,val4,val5,val6,val7)
{
	for(var j=0;j<15;j++)
	{
		document.forms[0].txt_year1[j].readOnly	=	val1;
		document.forms[0].txt_year2[j].readOnly	=	val2;
		document.forms[0].txt_year3[j].readOnly	=	val3;
		document.forms[0].txt_year4[j].readOnly	=	val4;
		document.forms[0].txt_year5[j].readOnly	=	val5;
		document.forms[0].txt_year6[j].readOnly	=	val6;
		document.forms[0].txt_year7[j].readOnly	=	val7;
	}
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_hortifinancialanalysis.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(document.forms[0].sel_plantName.value=="s")
	{
		alert("Select a plant name");
		return;
	}
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="action/agr_hortifinancialanalysis.jsp";	
		document.forms[0].hidBeanMethod.value="updateHortiCostOfDevelopmentDetails";
		document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
		document.forms[0].submit();		
	}
}	

function computeRowTotal(id)
{
	
}
function change_plant()
{
	if(document.forms[0].sel_plantName.value!="s")
	{
    document.forms[0].hidBeanId.value="agreconomic";
    document.forms[0].hidBeanGetMethod.value="getHorticultureIncomeExp";
    document.forms[0].action=appUrl+"/action/agr_hortifinancialanalysis.jsp";
	document.forms[0].submit();
	}
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	//document.forms[0].cmdhelp.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function calculatetotincome()
{
	<%for(int i=1;i<=15;i++)
	{%>
		var totinc=0,incyear=0;
		<%for(int inc=1;inc<=arrIncRow.size();inc++) {%>
			totinc = eval(totinc) + eval(document.forms[0].txt_incyear<%=inc%><%=i%>.value);
			incyear = totinc;
		<%}%>
		document.forms[0].txt_inctot<%=i%>.value = incyear;
		roundtxt(document.forms[0].txt_inctot<%=i%>)
	<%}%>
}

function calculatetotExp()
{
	<%for(int i=1;i<=15;i++)
	{%>
		var totexp=0,expyear=0;
		<%for(int inc=1;inc<=arrExpRow.size();inc++) {%>
			totexp = eval(totexp) + eval(document.forms[0].txt_Expyear<%=inc%><%=i%>.value);
			expyear = totexp;
		<%}%>
		document.forms[0].txt_exptot<%=i%>.value = expyear;
		roundtxt(document.forms[0].txt_exptot<%=i%>)
	<%}%>
}

function calculateNetInc()
{
	<%for(int i=1;i<=15;i++)
	{
		if(arrExpRow==null || arrExpRow.size()==0){ %>
		document.forms[0].txt_netinc<%=i%>.value = eval(document.forms[0].txt_inctot<%=i%>.value);
		roundtxt(document.forms[0].txt_netinc<%=i%>);
		<%}else if(arrIncRow==null || arrIncRow.size()==0){ %>
		document.forms[0].txt_netinc<%=i%>.value = eval(document.forms[0].txt_exptot<%=i%>.value);
		roundtxt(document.forms[0].txt_netinc<%=i%>);
		<%}else{ %>
		document.forms[0].txt_netinc<%=i%>.value = eval(document.forms[0].txt_inctot<%=i%>.value) - 
																eval(document.forms[0].txt_exptot<%=i%>.value);
		roundtxt(document.forms[0].txt_netinc<%=i%>);
	<%	}
	}%>
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmDSCR" method=post class="normal">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Total Income & Expenditure</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="89" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" align="center" cellspacing="0" cellpadding="3" 	class="outertable">
	<tr>
		<td height="24" valign="top">
		<table width="99%" border="0" cellspacing="1" cellpadding="3"
			class="datagrid">
			
			<tr>
				<td colspan="17">&nbsp;</td>
			</tr>
			<tr align="center" class="dataHeader">
				<td WIDTH="9%">
				<P>Particulars/Year</P>
				</td>
				<td WIDTH="5%">1</td>
				<td WIDTH="5%">2</td>
				<td WIDTH="5%">3</td>
				<td WIDTH="5%">4</td>
				<td WIDTH="5%">5</td>
				<td WIDTH="5%">6</td>
				<td WIDTH="5%">7</td>
				<td WIDTH="5%">8</td>
				<td WIDTH="5%">9</td>
				<td WIDTH="5%">10</td>
				<td WIDTH="5%">11</td>
				<td WIDTH="5%">12</td>
				<td WIDTH="5%">13</td>
				<td WIDTH="5%">14</td>
				<td WIDTH="5%">15-25</td>
			</tr>
			<tr class="dataHeader">
			<td colspan="16">Income Details</td>
			</tr>
			<%
			if(arrIncRow !=null && arrIncRow.size()>0){
				for (int i = 0; i < arrIncRow.size(); i++) {
						arrIncCol = (ArrayList) arrIncRow.get(i);
			%>
			<tr class="datagird" align="center">
				<td align="left" WIDTH="9%" NOWRAP HEIGHT="38"><b><%=Helper	.correctNull((String) arrIncCol.get(0))%></b></td>
				<%for(int inc=1;inc<=15;inc++){ %>
				<td WIDTH="5%" HEIGHT="38"><input type="text" maxlength="15"
					tabindex="1" name="txt_incyear<%=i+1%><%=inc%>" size="10"
					onKeyPress="allowNumber(this)" style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) arrIncCol.get(inc))))%>"></td>
				<%} %>
			</tr>
			<%}%>
			<tr class="datagird" align="center">
				<td align="left" WIDTH="9%" NOWRAP HEIGHT="38"><b>A TOTAL INCOME</b></td>
			<%for(int inc=1;inc<=15;inc++){ %>	
				<td WIDTH="5%" HEIGHT="38"><input type="text" maxlength="15"
					tabindex="1" name="txt_inctot<%=inc%>" size="10"
					onKeyPress="allowNumber(this)" style="text-align: right"
					value=""></td>
			<%}%>
			</tr>
			<%}else {%>
			<tr class="datagird" align="center">
				<td align="center" colspan="16">No Income Details found</td>
			</tr>
			<%}	%>
			
			<tr class="dataHeader">
			<td colspan="16">Expenditure Details</td>
			</tr>
			<%
			if(arrExpRow !=null && arrExpRow.size()>0){
				for (int i = 0; i < arrExpRow.size(); i++) {
					arrExpCol = (ArrayList) arrExpRow.get(i);
			%>
			<tr class="datagird" align="center">
				<td align="left" WIDTH="9%" NOWRAP HEIGHT="38"><b><%=Helper	.correctNull((String) arrExpCol.get(0))%></b></td>
				<%for(int exp=1;exp<=15;exp++){ %>
				<td WIDTH="5%" HEIGHT="38"><input type="text" maxlength="15"
					tabindex="1" name="txt_Expyear<%=i+1%><%=exp%>" size="10"
					onKeyPress="allowNumber(this)" style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
									.correctDouble((String) arrExpCol.get(exp))))%>"></td>
				<%}%>
			</tr>
			<%}%>
			<tr class="datagird" align="center">
				<td align="left" WIDTH="9%" NOWRAP HEIGHT="38"><b>B TOTAL EXPENDITURE</b></td>
			<%for(int exp=1;exp<=15;exp++){ %>	
				<td WIDTH="5%" HEIGHT="38"><input type="text" maxlength="15"
					tabindex="1" name="txt_exptot<%=exp%>" size="10"
					onKeyPress="allowNumber(this)" style="text-align: right"
					value=""></td>
			<%}%>
			</tr>
			<%}else {%>
			<tr class="datagird" align="center">
				<td align="center" colspan="16">No Expenditure Details found</td>
			</tr>
			<%}	%>
			
			<tr class="dataheader" align="center">
				<td align="left" WIDTH="9%" NOWRAP><b>NET INCOME (A - B)</b></td>
			<%for(int net=1;net<=15;net++){ %>	
				<td WIDTH="5%"><input type="text" maxlength="15"
					tabindex="1" name="txt_netinc<%=net%>" size="10"
					onKeyPress="allowNumber(this)" style="text-align: right"
					value=""></td>
			<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames=''	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type=hidden name="hidBeanId"> <input type=hidden
	name="hidBeanMethod"> <input type=hidden
	name="hidBeanGetMethod"> <input type=hidden name="hidSourceUrl">
<input type="hidden" name="hidAction"> <input type="hidden"
	name="hid_pagename" value=""> <input type="hidden"
	name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
	<input type="hidden" name="cmdsave" disabled>
</form>
</body>
</html>