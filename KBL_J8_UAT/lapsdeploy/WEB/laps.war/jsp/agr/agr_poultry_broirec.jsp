<%@include file="../share/directives.jsp"%>

<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>


<%
	ArrayList arryCol = new ArrayList();
	ArrayList arryRow = new ArrayList();
	arryRow = (ArrayList) hshValues.get("arryRow");
	ArrayList arryCol1 = new ArrayList();
	ArrayList arryRow1 = new ArrayList();
	arryRow1 = (ArrayList) hshValues.get("arryRow1");
	ArrayList arryRow2 = new ArrayList();
	arryRow2 = (ArrayList) hshValues.get("arryRow2");
	ArrayList arryRow3 = new ArrayList();
	ArrayList arryCol3 = new ArrayList();
	arryRow3 = (ArrayList) hshValues.get("arryRow3");
	ArrayList arryRow4 = new ArrayList();
	ArrayList arryCol4 = new ArrayList();
	arryRow4 = (ArrayList) hshValues.get("arryRow4");
	if (arryRow == null) {
		arryRow = new ArrayList();
	}
	if (arryRow1 == null) {
		arryRow1 = new ArrayList();
	}
	if (arryRow3 == null) {
		arryRow3 = new ArrayList();
	}
	if (arryRow2 == null) {
		arryRow2 = new ArrayList();
	}
	if (arryRow4 == null) {
		arryRow4 = new ArrayList();
	}
	String l1 = "", l2 = "", l3 = "", l4 = "", l5 = "", l6 = "", l7 = "", l8 = "", l9 = "";
	String l11 = "", l12 = "", l13 = "", l14 = "", l15 = "", l17 = "";
	String m1 = "", m2 = "", m3 = "", m4 = "", m5 = "", m6 = "", k4 = "";
	String r1 = "", r2 = "", r3 = "", r4 = "", r5 = "", r7 = "", r8 = "", r10 = "", r11 = "", r13 = "", r14 = "";
	String n1 = "", n2 = "", n3 = "", n4 = "", n5 = "", n7 = "", n8 = "", n10 = "", n11 = "", n6 = "", n9 = "";
	String g1 = "", g2 = "", g3 = "", c1 = "";
	String mo1 = "", mo2 = "", mo3 = "", mo4 = "", mo5 = "";
	String strappno = FwHelper.correctNull((String) request.getParameter("appno"));
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
		{
			schemetype="0";
		}
	String strFacSNo=Helper.getfacilitySno(schemetype);

%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/agr_poultryrecurring.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=FwHelper.correctNull((String) hshValues.get("strid"))%>";
var  strAction="<%=FwHelper.correctNull((String) hshValues.get("strAction"))%>";
var strUserMode="<%=FwHelper.correctNull((String) hshValues.get("strUserMode"))%>";
var schemetype="<%=schemetype%>";


function marginper()
{
	var totalamount=document.forms[0].txt_totalloanamount.value;
	var marginper=document.forms[0].txt_marginper.value;
	if(eval(marginper)=="")
	{
		marginper="0";
		document.forms[0].txt_marginper.value="0";
	}
	var margin=eval(marginper)/100*eval(totalamount);
	document.forms[0].txt_margin.value=Math.round(eval(margin));
	roundtxt(document.forms[0].txt_margin);
}

function subsidyper()
{
	var totalamount=document.forms[0].txt_totalloanamount.value;
	var subsidyper=document.forms[0].txt_subsidyper.value;
	if(eval(subsidyper)=="")
	{
		subsidyper="0";
		document.forms[0].txt_subsidyper.value="0";
	}
	var subsidy=eval(subsidyper)/100*eval(totalamount);
	document.forms[0].txt_subsidy.value=Math.round(eval(subsidy));
	roundtxt(document.forms[0].txt_subsidy);
}
function margin()
{
	var totalamount=document.forms[0].txt_totalloanamount.value;
	var margin=document.forms[0].txt_margin.value;
	if(eval(margin)=="")
	{
		margin="0";
		document.forms[0].txt_margin.value="0";
	}
	var marginper=(eval(margin)*100)/eval(totalamount);
	document.forms[0].txt_marginper.value=Math.round(eval(marginper));
	if(document.forms[0].txt_marginper.value == "NaN" || document.forms[0].txt_marginper.value == "NaN.00")
	{
		document.forms[0].txt_marginper.value = "0.00"
	}
}
function subsidy()
{
	var totalamount=document.forms[0].txt_totalloanamount.value;
	var subsidy=document.forms[0].txt_subsidy.value;
	if(eval(subsidy)=="")
	{
		subsidy="0";
		document.forms[0].txt_subsidy.value="0";
	}
	var subsidyper=(eval(subsidy)*100)/eval(totalamount);
	document.forms[0].txt_subsidyper.value=Math.round(eval(subsidyper));
	if(document.forms[0].txt_subsidyper.value == "NaN" || document.forms[0].txt_subsidyper.value == "NaN.00")
	{
		document.forms[0].txt_subsidyper.value = "0.00"
	}
}
function loanamount()
{
	var totalamount=document.forms[0].txt_totalloanamount.value;	
	var subsidy=document.forms[0].txt_subsidy.value;
	if(document.forms[0].txt_subsidy.value=="NaN")
	{
		document.forms[0].txt_subsidy.value="0";
		document.forms[0].txt_subsidyper.value="0";
	}
	var margin=document.forms[0].txt_margin.value;
	if(document.forms[0].txt_margin.value=="NaN")
	{
		document.forms[0].txt_margin.value="0";
		document.forms[0].txt_marginper.value="0";
	}
	document.forms[0].txt_totalloanamount2.value=eval(totalamount)-(eval(margin)+eval(subsidy));
	roundtxt(document.forms[0].txt_totalloanamount2);
	if(document.forms[0].txt_totalloanamount1.value=="")
	{
		document.forms[0].txt_totalloanamount1.value=document.forms[0].txt_totalloanamount2.value;
	}
	if(document.forms[0].txt_totalloanamount1.value=="?" || document.forms[0].txt_totalloanamount1.value=="NaN" || document.forms[0].txt_totalloanamount1.value=="NaN.00")
	{
		document.forms[0].txt_totalloanamount1.value="0.00";
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
function callTotal()
{
	var totalvalue=0.00;
	var val1=document.forms[0].txt_amount1[0].value;
	var val2=document.forms[0].txt_amount1[1].value;
	var val3=document.forms[0].txt_amount1[2].value;
	var val4=document.forms[0].txt_amount1[3].value;
	var val5=document.forms[0].txt_amount1[4].value;
	for(var i=0;i<12;i++)
	{
		var amount=document.forms[0].txt_amount[i].value;
		if(eval(amount)=="")
		{
			amount="0";
		}
		totalvalue = eval(amount)+eval(totalvalue)
		document.forms[0].txt_totalloanamount.value=Math.round(eval(totalvalue))+Math.round(eval(val1))+Math.round(eval(val2))+Math.round(eval(val3))+Math.round(eval(val4))+Math.round(eval(val5));
		roundtxt(document.forms[0].txt_totalloanamount);
	}
	if(document.forms[0].txt_totalloanamount1.value=="NaN" || document.forms[0].txt_totalloanamount1.value=="NaN.00")
	{
		document.forms[0].txt_totalloanamount1.value="0.00";
	}
	calculateTotal();
}
function doSave()
{	
	 enableButtons( true, true, true, true, false);	
     amount();callTotal();labourcharge();
	 if(document.forms[0].txt_totalloanamount1.value=="")
     {
  		document.forms[0].txt_totalloanamount1.value=document.forms[0].txt_totalloanamount2.value;
     }
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agriloanassessment";
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_broirec.jsp";
	document.forms[0].hidBeanMethod.value="updatebroirecurringData";
	document.forms[0].hidBeanGetMethod.value="getbroirecurringData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	for(var i=0;i<12;i++){
		//document.forms[0].txt_unit[i].readOnly=true;
		document.forms[0].txt_cost[i].readOnly=true;
		document.forms[0].txt_amount[i].readOnly=true;
	}

	for(var j=0;j<5;j++){
		//document.forms[0].txt_unit1[j].readOnly=true;
		document.forms[0].txt_item1[j].readOnly=true;
		document.forms[0].txt_cost1[j].readOnly=true;
		document.forms[0].txt_amount1[j].readOnly=true;
	}
	
	for(var k=0;k<2;k++)
	{
		document.forms[0].txt_value3[k].readOnly=true;
	}

	for(var v=0;v<=11;v++)
	{
		document.forms[0].txt_value1[v].readOnly=true;
	}
	
	for(var u=0;u<=6;u++)
	{
		if(u>=2)
		{
			document.forms[0].txt_value2[u].readOnly=true;
		}
	}
	
	for(var y=0;y<=4;y++)
	{
		document.forms[0].txt_costval1[y].readOnly=true;
	}
	document.forms[0].txt_totalloanamount.readOnly=true;
	document.forms[0].txt_totalnonrecurring.readOnly=true;
	document.forms[0].txt_reqprojectcost.readOnly=true;
    document.forms[0].hidAction.value ="insert";
    enableButtons(true, false, false, false, false);	
}

function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidBeanGetMethod.value="getbroirecurringData";
		document.forms[0].action=appUrl+"action/agr_poultry_broirec.jsp";
		document.forms[0].submit(); 		
	}
	//disableCommandButtons("load");
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";		
		document.forms[0].hidBeanMethod.value="updatebroirecurringData";
		document.forms[0].hidBeanGetMethod.value="getbroirecurringData";
		document.forms[0].hidBeanId.value="agriloanassessment";
		document.forms[0].hidSourceUrl.value="action/agr_poultry_broirec.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}
}

function onloading()
{	  
	enableButtons(false, true, true, true, false);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
}

function calculateTotal()
{
	var operand1=parseFloat(document.forms[0].txt_totalloanamount.value);
	var operand2=parseFloat(document.forms[0].txt_totalnonrecurring.value);
	if(operand1=="NaN" || operand1=="")operand1=0.00;
	if(operand2=="NaN" || operand2=="")operand2=0.00;
	var result=parseFloat(operand1+operand2);
	if(result=="NaN" || result=="")result=0.00;
	document.forms[0].txt_reqprojectcost.value=result.toFixed(2);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function amount()
{
	for(var i=0;i<12;i++)
	{
		var value1=document.forms[0].txt_value1[i].value;
		var value2=document.forms[0].txt_value2[i].value;
		var value3=document.forms[0].txt_value3[i].value;
		if(eval(value1==""))
		{
			value1="0";
		}
		if(eval(value2==""))
		{
			value2="0";
		}
		if(eval(value3==""))
		{
			value3="0";
		}
		document.forms[0].txt_amount[i].value=eval(value1)*eval(value2)*eval(value3);
		roundtxt(document.forms[0].txt_amount[i]);
	}
}
function amount1()
{
	for(var k=0;k<5;k++)
	{
		var value1=document.forms[0].txt_month1[k].value;
		var value2=document.forms[0].txt_costval1[k].value;		
		if(eval(value1==""))
		{
			value1="0";
		}
		if(eval(value2==""))
		{
			value2="0";
		}		
		document.forms[0].txt_amount1[k].value=eval(value1)*eval(value2);
		roundtxt(document.forms[0].txt_amount1[k]);	
	}
}
function labourcharge()
{
	var totalval=0.00;
	for(var i=2;i<7;i++)
	{
		var labour=document.forms[0].txt_amount[i].value;
		if(eval(labour)=="")
		{
			labour="0";
		}
		totalval=eval(labour)+totalval;
		document.forms[0].txt_labourcharge.value=eval(totalval);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body
	onLoad="onloading();amount();amount1();callTotal();margin();marginper();subsidy();subsidyper();loanamount();labourcharge()">
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
<form name="frmpri" method=post>

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
      <td class="page_flow">Home -> Agriculture -> Recurring Expense</td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="100" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>

<table width="98%" border="0" cellspacing="0" cellpadding="5" class="shadow outertable border1" align="center">

	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="1"
							bordercolorlight="#FFFFFF" bordercolordark="#dleef">
							<tr>
								<td colspan="13">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable border1">
									<tr BORDER="1" bordercolorlight="#FFFFFF"
										bordercolordark="#dleef">
										<td class="dataheader" align="center"><b>Particulars</b></td>
										<td class="dataheader" align="center"> <b>
										Amount (<%=ApplicationParams.getCurrency()%>)</b></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow != null && arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(1);

												if (arryCol.size() != 0) {

													l1 = FwHelper.correctNull((String) arryCol.get(1));
													g1 = FwHelper.correctNull((String) arryCol.get(2));
													l2 = FwHelper.correctNull((String) arryCol.get(3));
												}

											} else if (arryRow.size() == 0) {
												l1 = "";
												l2 = "";
												g1 = "";

											}
										%>
										<td width="72%">Purchase of <input type="text"
											name="txt_value1" size="10" maxlength="10" readonly
											value="<%=FwHelper.correctNull((String) hshValues
							.get("txt_nochicks"))%>"
											onBlur="amount();callTotal()" style="text-align: left;">
										number of chicks/batch, <input type="text" name="txt_value2"
											size="10" maxlength="4" readonly value="<%=g1%>"
											onBlur="amount();callTotal()" onKeyPress="allowInteger()"
											style="text-align: left;"> no. of batches,@<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value3" size="10" maxlength="15"
											value='<%=FwHelper.correctNull((String)hshValues.get("txt_costchicks"))%>'
											onBlur="amount();callTotal()" /> per chick.</td>
										<td align="center"><input type="hidden" name="txt_unit"
											size="0" maxlength="15" value="0" onKeyPress="allowInteger()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost" size="0" maxlength="15" value="0"> <lapschoice:CurrencyTag
											name="txt_amount" size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" > 
										<%
											if (arryRow != null && arryRow.size() > 0) {
												arryCol = (ArrayList) arryRow.get(0);
												c1 = FwHelper.correctNull((String) arryCol.get(5));

											}
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(2);

												if (arryCol.size() != 0) {

													l3 = FwHelper.correctNull((String) arryCol.get(1));
													g2 = FwHelper.correctNull((String) arryCol.get(2));
													g3 = FwHelper.correctNull((String) arryCol.get(3));
													l4 = FwHelper.correctNull((String) arryCol.get(4));
												}

											} else if (arryRow.size() == 0) {

												l3 = "";
												l4 = "";
												g2 = "";
												g3 = "";
											}
										%>
										<td>Feeding of <input type="text" name="txt_value1"
											size="10" maxlength="10" readOnly
											value="<%=FwHelper.correctNull((String) hshValues
							.get("txt_nochicks"))%>"
											onBlur="amount();callTotal()" style="text-align: left;">
										number of chicks/batch, <input type="text" name="txt_value2"
											size="10" maxlength="4" value="<%=g2%>"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											readOnly style="text-align: left;"> no. of
										batches,at@<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag name="txt_value3"
											size="10" maxlength="15"
											value='<%=FwHelper.correctNull((String)hshValues.get("txt_totalfeedcost"))%>'
											onBlur="amount();callTotal()" /> per chick.</td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0"><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
									<tr>
										<td colspan="2" class="dataheader"><b>Miscellaneous
										Expenses upto economic laying</b></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow3.size() > 0) {
												arryCol3 = (ArrayList) arryRow3.get(0);
												m1 = FwHelper.correctNull((String) arryCol3.get(2));
												l7 = FwHelper.correctNull((String) arryCol3.get(3));
											}
											if (arryRow != null && arryRow.size() != 0) {

												arryCol = (ArrayList) arryRow.get(3);

												if (arryCol.size() != 0) {
													l8 = FwHelper.correctNull((String) arryCol.get(3));

												}
											} else if (arryRow.size() == 0) {

												l8 = "0";

											}
										%>
										<td>Labourers salary/wages <input type="text"
											name="txt_value1" size="15" maxlength="10" readOnly
											value="<%=m1%>" onBlur="amount();callTotal()"
											style="text-align: left;"> no.of labourers @<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value2" size="10" maxlength="10" value="<%=l7%>"
											onBlur="amount();callTotal()" /> per labourer p.m for <input
											type="text" name="txt_value3" size="10" maxlength="3"
											value="<%=l8%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										months.</td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0" /><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow3.size() > 0) {
												arryCol3 = (ArrayList) arryRow3.get(1);
												n1 = FwHelper.correctNull((String) arryCol3.get(2));
												n2 = FwHelper.correctNull((String) arryCol3.get(3));
											}
											if (arryRow != null && arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(4);

												if (arryCol.size() != 0) {

													k4 = FwHelper.correctNull((String) arryCol.get(3));
												}

											} else if (arryRow.size() == 0) {

												k4 = "";
											}
										%>
										<td>Manager salary/wages <input type="text"
											name="txt_value1" size="15" maxlength="10" readOnly
											value="<%=n1%>" onBlur="amount();callTotal()"
											style="text-align: left;"> no.of Managers @<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value2" size="10" maxlength="10" value='<%=n2%>'
											onBlur="amount();callTotal()" /> per Manager p.m for <input
											type="text" name="txt_value3" size="10" maxlength="3"
											value="<%=k4%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										months.</td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0" /><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow3.size() > 0) {
												arryCol3 = (ArrayList) arryRow3.get(2);
												n3 = FwHelper.correctNull((String) arryCol3.get(2));
												n4 = FwHelper.correctNull((String) arryCol3.get(3));
											}
											if (arryRow != null && arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(5);

												if (arryCol.size() != 0) {

													n5 = FwHelper.correctNull((String) arryCol.get(3));
												}

											} else if (arryRow.size() == 0) {

												n5 = "";
											}
										%>
										<td>Supervisors salary/wages <input type="text"
											name="txt_value1" size="15" maxlength="10" readOnly
											value="<%=n3%>" onBlur="amount();callTotal()"
											style="text-align: left;"> no.of Supervisors @<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value2" size="10" maxlength="10" value="<%=n4%>"
											onBlur="amount();callTotal()" /> per Supervisor p.m for <input
											type="text" name="txt_value3" size="10" maxlength="3"
											value="<%=n5%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										months.</td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0" /><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow3 != null && arryRow3.size() > 0) {
												arryCol3 = (ArrayList) arryRow3.get(3);
												n6 = FwHelper.correctNull((String) arryCol3.get(2));
												n7 = FwHelper.correctNull((String) arryCol3.get(3));
											}
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(6);

												if (arryCol.size() != 0) {

													n8 = FwHelper.correctNull((String) arryCol.get(3));
												}

											} else if (arryRow.size() == 0) {

												n8 = "";
											}
										%>
										<td>others ie. <input type="hidden" name="txt_specify1"
											value="<%=FwHelper.correctNull((String) hshValues
							.get("txt_specify1"))%>"
											onKeyPress="allowInteger()" onBlur=""
											style="text-align: right;"> <b><%=FwHelper.correctNull((String) hshValues
							.get("txt_specify1"))%>
										</b> salary/wages <input type="text" name="txt_value1" size="15"
											maxlength="10" readOnly value="<%=n6%>"
											onBlur="amount();callTotal()" style="text-align: left;">
										no.of persons @<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag name="txt_value2"
											size="10" maxlength="10" value='<%=n7%>'
											onBlur="amount();callTotal()" /> per person p.m for <input
											type="text" name="txt_value3" size="10" maxlength="3"
											value="<%=n8%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										months.</td>
										<td align="center"><input type="hidden" name="txt_cost"
											size="0" maxlength="15" value="0"><INPUT
											TYPE="hidden" NAME="txt_unit2" ONFOCUS="" SIZE="0"
											MAXLENGTH="15" VALUE="0" ONKEYPRESS="allowInteger()"
											STYLE="text-align: left;"><lapschoice:CurrencyTag
											name="txt_amount" size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow3.size() > 0) {
												arryCol3 = (ArrayList) arryRow3.get(4);
												n9 = FwHelper.correctNull((String) arryCol3.get(2));
												n10 = FwHelper.correctNull((String) arryCol3.get(3));
											}
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(7);

												if (arryCol.size() != 0) {

													n11 = FwHelper.correctNull((String) arryCol.get(3));
												}

											} else if (arryRow.size() == 0) {

												n11 = "";
											}
										%>
										<td>others ie <input type="hidden" name="txt_specify2"
											value="<%=FwHelper.correctNull((String) hshValues
							.get("txt_specify2"))%>"
											onKeyPress="allowInteger()" onBlur=""
											style="text-align: right;"> <b><%=FwHelper.correctNull((String) hshValues
							.get("txt_specify2"))%></b>
										salary/wages <input type="text" name="txt_value1" size="15"
											maxlength="10" readOnly value="<%=n9%>"
											onBlur="amount();callTotal()" style="text-align: left;">
										no.of persons@<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag name="txt_value2"
											size="10" maxlength="10" value='<%=n10%>'
											onBlur="amount();callTotal()" /> per person p.m for <input
											type="text" name="txt_value3" size="10" maxlength="3"
											value="<%=n11%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										months.</td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0" /><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(8);

												if (arryCol.size() != 0) {

													m2 = FwHelper.correctNull((String) arryCol.get(1));
													l9 = FwHelper.correctNull((String) arryCol.get(2));
												}

											} else if (arryRow.size() == 0) {

												l9 = "";
												m2 = "";
											}
										%>
										<td>Water charge:<%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value1" size="15" maxlength="10"
											value='<%=FwHelper.correctNull((String)hshValues.get("txt_watercharge"))%>'
											onBlur="amount();callTotal()" /> per month for <input
											type="text" name="txt_value2" size="10" maxlength="3"
											value="<%=l9%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										months. <input type="hidden" name="txt_value3" size="10"
											maxlength="15" value="1" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: right;">
										</td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0" /><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(9);

												if (arryCol.size() != 0) {

													m3 = FwHelper.correctNull((String) arryCol.get(1));
													l11 = FwHelper.correctNull((String) arryCol.get(2));
												}
											} else if (arryRow.size() == 0) {
												l11 = "";
												m3 = "";

											}
										%>
										<td>Electricity charges <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value1" size="15" maxlength="10"
											value='<%=FwHelper.correctNull((String)hshValues.get("txt_electricitycharge"))%>'
											onBlur="amount();callTotal()" /> per month for <input
											type="text" name="txt_value2" size="10" maxlength="4"
											value="<%=l11%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										months. <input type="hidden" name="txt_value3" size="10"
											maxlength="15" value="1" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: right;">
										</td>
										<td align="center"><input type="hidden" name="txt_unit"
											size="0" maxlength="15" value="0" onKeyPress="allowInteger()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost" size="0" maxlength="15" value="0" /><lapschoice:CurrencyTag
											name="txt_amount" size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(10);

												if (arryCol.size() != 0) {

													m4 = FwHelper.correctNull((String) arryCol.get(1));
													l13 = FwHelper.correctNull((String) arryCol.get(2));
													l14 = FwHelper.correctNull((String) arryCol.get(3));
												}

											} else if (arryRow.size() == 0) {
												l13 = "";
												l14 = "";
												m4 = "";
											}
										%>
										<td>Veterinary aid <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value1" size="15" maxlength="10"
											value='<%=FwHelper.correctNull((String)hshValues.get("txt_totalvtaid"))%>'
											onBlur="amount();callTotal()" /> per batch for <input
											type="text" name="txt_value2" size="10" maxlength="3"
											value="<%=l13%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										number of batches <input type="hidden" name="txt_value3"
											size="10" maxlength="6" value="1" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: right;">
										</td>
										<td align="center"><input type="hidden" name="txt_unit"
											size="0" maxlength="15" value="0" onKeyPress="allowInteger()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost" size="0" maxlength="15" value="0" /><lapschoice:CurrencyTag
											name="txt_amount" size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(11);

												if (arryCol.size() != 0) {

													m5 = FwHelper.correctNull((String) arryCol.get(1));
													l15 = FwHelper.correctNull((String) arryCol.get(2));
												}

											} else if (arryRow.size() == 0) {
												l15 = "";
												m5 = "";
											}
										%>
										<td>Insurance of birds @ <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value1" size="15" maxlength="10"
											value='<%=FwHelper.correctNull((String)hshValues.get("txt_totalinspremium"))%>'
											onBlur="amount();callTotal()" /> per batch for <input
											type="text" name="txt_value2" size="10" maxlength="3"
											value="<%=l15%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										number of batches.. <input type="hidden" name="txt_value3"
											size="10" maxlength="15" value="1"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: right;"></td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0" /><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(12);

												if (arryCol.size() != 0) {

													m6 = FwHelper.correctNull((String) arryCol.get(1));
													l17 = FwHelper.correctNull((String) arryCol.get(2));
												}
											} else if (arryRow.size() == 0) {
												l17 = "";
												m6 = "";
											}
										%>
										<td>Transportation charges @ <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_value1" size="15" maxlength="10"
											value='<%=FwHelper.correctNull((String)hshValues.get("txt_transportcharge"))%>'
											onBlur="amount();callTotal()" /> per batch for <input
											type="text" name="txt_value2" size="10" maxlength="4"
											value="<%=l17%>" onKeyPress="allowInteger()"
											onBlur="amount();callTotal()" style="text-align: left;">
										number of batches. <input type="hidden" name="txt_value3"
											size="10" maxlength="15" value="1"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: right;"></td>
										<td align="center"><input type="hidden" name="txt_unit"
											onFocus="" size="0" maxlength="15" value="0"
											onKeyPress="allowInteger()" style="text-align: left;">
										<input type="hidden" name="txt_cost" size="0" maxlength="15"
											value="0" /><lapschoice:CurrencyTag name="txt_amount"
											size="18" maxlength="15" value="" /></td>
									</tr>
								</table>
								<table width="100%" border="1" cellspacing="0" cellpadding="3"
									bordercolorlight="#FFFFFF" bordercolordark="#dleef">
									<tr>
										<td colspan="3" class="dataheader"><b>If Others
										Specify</b></td>
									</tr>
									<tr>
										<td align="center" class="dataheader"><b>Particulars</b></td>
										<td colspan="2" class="dataheader" align="center"><b> Amount
										(<%=ApplicationParams.getCurrency()%>)</b></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow4.size() > 0) {
												arryCol4 = (ArrayList) arryRow4.get(0);
												mo1 = FwHelper.correctNull((String) arryCol4.get(2));
											}
											if (arryRow1 != null && arryRow1.size() > 0) {

												arryCol1 = (ArrayList) arryRow1.get(0);

												if (arryCol1.size() != 0) {

													r1 = FwHelper.correctNull((String) arryCol1.get(0));
													r2 = FwHelper.correctNull((String) arryCol1.get(1));

												}
											} else if (arryRow1.size() == 0) {

												r1 = "";
												r2 = "";

											}
										%>
										<td width="71%"><input type="text" name="txt_item1"
											size="70" maxlength="50" value="<%=r1%>" onKeyPress=""
											style="text-align: left;"> <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_costval1" size="10" maxlength="10" value='<%=r2%>' />
										for <input type="text" name="txt_month1" size="10"
											maxlength="3" value="<%=mo1%>" onKeyPress="allowInteger()"
											onBlur="amount1();callTotal()" style="text-align: left;">
										months.</td>
										<td colspan="2" align="center"><input type="hidden"
											name="txt_unit1" size="0" maxlength="10" value="0"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost1" size="0" maxlength="10" value="0"
											onBlur="amount();callTotal()" /> <lapschoice:CurrencyTag
											name="txt_amount1" size="18" maxlength="10" value=""
											onBlur="amount();callTotal()" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow4.size() > 0) {
												arryCol4 = (ArrayList) arryRow4.get(1);
												mo2 = FwHelper.correctNull((String) arryCol4.get(2));
											}
											if (arryRow1 != null && arryRow1.size() > 1) {

												arryCol1 = (ArrayList) arryRow1.get(1);

												if (arryCol1.size() != 0) {

													r4 = FwHelper.correctNull((String) arryCol1.get(0));
													r5 = FwHelper.correctNull((String) arryCol1.get(1));

												}
											} else if (arryRow1.size() == 0) {

												r4 = "";
												r5 = "";

											}
										%>
										<td><input type="text" name="txt_item1" size="70"
											maxlength="50" value="<%=r4%>" onKeyPress=""
											style="text-align: left;"> <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_costval1" size="10" maxlength="10" value='<%=r5%>' />
										for <input type="text" name="txt_month1" size="10"
											maxlength="3" value="<%=mo2%>" onKeyPress="allowInteger()"
											onBlur="amount1();callTotal()" style="text-align: left;">
										months.</td>
										<td colspan="2" align="center"><input type="hidden"
											name="txt_unit1" size="0" maxlength="10" value="0"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost1" size="0" maxlength="10" value="0"
											onBlur="amount();callTotal()" /> <lapschoice:CurrencyTag
											name="txt_amount1" size="18" maxlength="10" value=""
											onBlur="amount();callTotal()" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow4.size() > 0) {
												arryCol4 = (ArrayList) arryRow4.get(2);
												mo3 = FwHelper.correctNull((String) arryCol4.get(2));
											}
											if (arryRow1 != null && arryRow1.size() > 2) {

												arryCol1 = (ArrayList) arryRow1.get(2);

												if (arryCol1.size() != 0) {

													r7 = FwHelper.correctNull((String) arryCol1.get(0));
													r8 = FwHelper.correctNull((String) arryCol1.get(1));

												}
											} else if (arryRow1.size() == 0) {

												r7 = "";
												r8 = "";

											}
										%>
										<td><input type="text" name="txt_item1" size="70"
											maxlength="50" value="<%=r7%>" onKeyPress=""
											style="text-align: left;"> <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_costval1" size="10" maxlength="10" value="<%=r8%>" />
										for <input type="text" name="txt_month1" size="10"
											maxlength="3" value="<%=mo3%>" onKeyPress="allowInteger()"
											onBlur="amount1();callTotal()" style="text-align: left;">
										months.</td>
										<td colspan="2" align="center"><input type="hidden"
											name="txt_unit1" size="0" maxlength="10" value="0"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost1" size="0" maxlength="10" value="0"
											onBlur="amount();callTotal()" /> <lapschoice:CurrencyTag
											name="txt_amount1" size="18" maxlength="10" value=""
											onBlur="amount();callTotal()" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow4 != null && arryRow4.size() > 0) {
												arryCol4 = (ArrayList) arryRow4.get(3);
												mo4 = FwHelper.correctNull((String) arryCol4.get(2));
											}
											if (arryRow1 != null && arryRow1.size() > 3) {

												arryCol1 = (ArrayList) arryRow1.get(3);

												if (arryCol1.size() != 0) {

													r10 = FwHelper.correctNull((String) arryCol1.get(0));
													r11 = FwHelper.correctNull((String) arryCol1.get(1));

												}
											} else if (arryRow1.size() == 0) {

												r10 = "";
												r11 = "";

											}
										%>
										<td><input type="text" name="txt_item1" size="70"
											maxlength="50" value="<%=r10%>" onKeyPress=""
											style="text-align: left;"> <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_costval1" size="10" maxlength="10" value='<%=r11%>' />
										for <input type="text" name="txt_month1" size="10"
											maxlength="3" value="<%=mo4%>" onKeyPress="allowInteger()"
											onBlur="amount1();callTotal()" style="text-align: left;">
										months.</td>
										<td colspan="2" align="center"><input type="hidden"
											name="txt_unit1" size="0" maxlength="10" value="0"
											onKeyPress="allowInteger()" onBlur="amount();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost1" size="0" maxlength="10" value="0"
											onBlur="amount();callTotal()" /> <lapschoice:CurrencyTag
											name="txt_amount1" size="18" maxlength="10" value=""
											onBlur="amount();callTotal()" /></td>
									</tr>
									<tr class="datagrid" >
										<%
											if (arryRow4.size() > 0) {
												arryCol4 = (ArrayList) arryRow4.get(4);
												mo5 = FwHelper.correctNull((String) arryCol4.get(2));
											}
											if (arryRow1 != null && arryRow1.size() > 4) {

												arryCol1 = (ArrayList) arryRow1.get(4);

												if (arryCol1.size() != 0) {

													r13 = FwHelper.correctNull((String) arryCol1.get(0));
													r14 = FwHelper.correctNull((String) arryCol1.get(1));

												}
											} else if (arryRow1.size() == 0) {

												r13 = "";
												r14 = "";
											}
										%>
										<td><input type="text" name="txt_item1" size="70"
											maxlength="50" value="<%=r13%>" onKeyPress=""
											style="text-align: left;"> <%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
											name="txt_costval1" size="10" maxlength="10" value='<%=r14%>' />
										for <input type="text" name="txt_month1" size="10"
											maxlength="3" value="<%=mo5%>" onKeyPress="allowInteger()"
											onBlur="amount1();callTotal()" style="text-align: left;">
										months.</td>
										<td colspan="2" align="center"><input type="hidden"
											name="txt_unit1" size="0" maxlength="10" value="0"
											onKeyPress="allowInteger()" onBlur="amount1();callTotal()"
											style="text-align: left;"> <input type="hidden"
											name="txt_cost1" size="0" maxlength="10" value="0"
											onBlur="amount();callTotal()" /> <lapschoice:CurrencyTag
											name="txt_amount1" size="18" maxlength="10" value=""
											onBlur="amount();callTotal()" /></td>
									</tr>
									<tr class="datagrid" >
										<td align="center"><b>Total (Recurring Expenses)</b></td>
										<td colspan="2" align="center"><input type="text"
											name="txt_totalloanamount" size="18" maxlength="15" value=""
											onKeyPress="allowInteger()" readOnly
											style="text-align: right;"></td>
									</tr>
									<tr class="datagrid" >
										<td align="center"><b>Total (Non-Recurring Expenses)</b>
										</td>
										<td colspan="2" align="center"><input type="text"
											name="txt_totalnonrecurring" size="18" maxlength="15"
											value="<%=FwHelper.correctNull(""
							+ hshValues.get("tot_non_recurring"))%>"
											onKeyPress="allowInteger()" readOnly
											style="text-align: right;"> <input type="hidden"
											name="txt_totalloanamount2" size="10" maxlength="10" value="" />
										<!-- or say --> <input type="hidden"
											name="txt_totalloanamount1" size="10" maxlength="10"
											value='<%=FwHelper.correctNull((String) hshValues
							.get("txt_totalloanamount1"))%>'>
										</td>
									</tr>
									<tr class="datagrid" >
										<td align="center"><b>Required Project Cost</b></td>
										<td colspan="2" align="center"><b> <input type="text"
											name="txt_reqprojectcost" size="18" maxlength="15" value=""
											onKeyPress="allowInteger()" readOnly
											style="text-align: right;"> <input type="hidden"
											name="txt_marginper" size="10" maxlength="10"
											value='<%=FwHelper
							.correctNull((String) hshValues.get("txt_margin"))%>'
											onBlur="marginper();loanamount()" /> <input
											type="hidden" name="txt_margin" size="10" maxlength="10"
											value='<%=FwHelper.correctNull((String) hshValues
							.get("txt_marginper"))%>'
											onBlur="margin();loanamount()" /> </b></td>
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
<br>
<lapschoice:combuttonnew
	btnnames="Edit_Save_Delete_Cancel"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<input type="hidden" name="measurement" value="<%=FwHelper.correctNull((String) hshValues.get("land_measurement"))%>">
<input type="hidden" name="txt_labourcharge" value=""> 
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">
<input type="hidden" name="txt_subsidyper" size="10" maxlength="10" value='<%=FwHelper.correctNull((String) hshValues.get("txt_subsidyper"))%>'
	onBlur="subsidyper();loanamount()" /> 
<input type="hidden" name="txt_subsidy" size="10" maxlength="10" value='<%=FwHelper.correctNull((String) hshValues.get("txt_subsidy"))%>'
	onBlur="subsidy();loanamount()" />
	<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
	
</form>
</body>
</html>