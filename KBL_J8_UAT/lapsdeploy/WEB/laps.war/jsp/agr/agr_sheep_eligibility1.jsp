
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			
			int vecsize = 0;
			int vecsize1 = 0;
			
			String strapptype = "";
			String apptype = "";
			String app_status = Helper.correctNull((String) hshValues
					.get("app_status"));
			 
			%>
<%
ArrayList arryCol = new ArrayList();
ArrayList a2 = new ArrayList();
ArrayList a3 = new ArrayList();
ArrayList a4 = new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow  = (ArrayList) hshValues.get("arryRow");
ArrayList arryCol1 = new ArrayList();
ArrayList arryRow1 = new ArrayList();
arryRow1  = (ArrayList) hshValues.get("arryRow1");
ArrayList arryCol4 = new ArrayList();
ArrayList arryRow4 = new ArrayList();
arryRow4  = (ArrayList) hshValues.get("arryRow4");
ArrayList arryCol2 = new ArrayList();
ArrayList arryRow2 = new ArrayList();
arryRow2  = (ArrayList) hshValues.get("arryRow2");
if (arryRow == null) {
	arryRow  = new ArrayList();
}
if (arryRow2 == null) {
	arryRow2 = new ArrayList();
}
if (arryRow1 == null) {
	arryRow1  = new ArrayList();
}

java.text.NumberFormat nf = java.text.NumberFormat
		.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>
<html>
<head>
<title>LAPS -Assesment Form Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/agr_poultrynonrecurring.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";
function costval()
{
var  txt_markettranscost="<%=Helper.correctNull((String)hshValues.get("txt_markettranscost"))%>";
if(txt_markettranscost=="0")
{
document.forms[0].txt_unit[2].value="0";
}
else
{
document.forms[0].txt_unit[2].value="<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>";
}
var  txt_feedadult="<%=Helper.correctNull((String)hshValues.get("txt_feedadult"))%>";
if(txt_feedadult=="0")
{
document.forms[0].txt_unit[3].value="0";
}
else
{
document.forms[0].txt_unit[3].value="<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>";
}
var  txt_vtaidprice="<%=Helper.correctNull((String)hshValues.get("txt_vtaidprice"))%>";
if(txt_vtaidprice=="0")
{
document.forms[0].txt_unit[4].value="0";
}
else
{
document.forms[0].txt_unit[4].value="<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>";
}
var  txt_inspremium="<%=Helper.correctNull((String)hshValues.get("txt_inspremium"))%>";
if(txt_inspremium=="0")
{
document.forms[0].txt_unit[5].value="0";
}
else
{
document.forms[0].txt_unit[5].value="<%=Helper.correctNull((String)hshValues.get("txt_totalanimalno"))%>";
}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"perresult.jsp";
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}	
}

function callamount()
{
for(var m=0;m<=2;m++)
{
var unit=document.forms[0].txt_unit[m].value;
var cost=document.forms[0].txt_cost[m].value;
 if(unit=="")
		{
	unit=1;
			
		}
	if(cost=="")
	{
	cost=0;
		
	}
	
var amount=eval(cost)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount));

}

for(var m=5;m<6;m++)
{
var unit=document.forms[0].txt_unit[m].value;
var cost=document.forms[0].txt_cost[m].value;
 if(unit=="")
		{
	unit=1;
			
		}
	if(cost=="")
	{
	cost=0;
		
	}
	
var amount=eval(cost)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount));

}
}
function doEdit()
{
 	disableFields(true);
 
	enableButtons(true, false, false, true, true);	
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
		document.forms[0].hidSourceUrl.value="/action/agr_sheep_eligibility1.jsp";
		document.forms[0].hidBeanId.value="agrpoultry";
		document.forms[0].hidBeanGetMethod.value="getsheepeligibility";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit(); 		
	}
	disableCommandButtons("load");
}

function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidAction1.value ="delete1";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="action/agr_sheep_eligibility1.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}

function onloading()
{	  

	disableFields(true);
	enableButtons( true, true, true, true, false);
	
}
function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function costfeed()
{
for(var m=3;m<4;m++)
{
var value=document.forms[0].txt_value[m].value;
if(document.forms[0].txt_value[m].value>60)
{
alert("cannot exceed 60 days");
document.forms[0].txt_value[m].value="0";
}
var unit=document.forms[0].txt_unit[m].value;
var cost=document.forms[0].txt_cost[m].value;

 if(unit=="")
		{
	unit=0;
			
		}
	if(document.forms[0].txt_value[m].value=="")
	{
	value=0;
	document.forms[0].txt_value[m].value="";
		
	}
	if(cost=="")
	{
	cost=0;
		
	}
 var amount0=eval(cost)*eval(value)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount0));
document.forms[0].txt_value1.value=document.forms[0].txt_value[m].value;
}

for(var m=4;m<5;m++)
{
var value=document.forms[0].txt_value[m].value;
if(document.forms[0].txt_value[m].value>2)
{
alert("cannot exceed 2 months");
document.forms[0].txt_value[m].value="0";
}
var unit=document.forms[0].txt_unit[m].value;
var cost=document.forms[0].txt_cost[m].value;

 if(unit=="")
		{
	unit=0;
			
		}
	if(document.forms[0].txt_value[m].value=="")
	{
	value=0;
	document.forms[0].txt_value[m].value="";	
	}
	if(cost=="")
	{
	cost=0;
		
	}
 var amount1=eval(cost)*eval(value)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount1));
document.forms[0].txt_value2.value=document.forms[0].txt_value[m].value;
}
for(var m=6;m<7;m++)
{
var value=document.forms[0].txt_value[m].value;
if(document.forms[0].txt_value[m].value>2)
{
alert("cannot exceed 2 months");
document.forms[0].txt_value[m].value="0";
}
var unit=document.forms[0].txt_unit[m].value;
var cost=document.forms[0].txt_cost[m].value;

 if(unit=="")
		{
	unit=0;
			
		}
	if(document.forms[0].txt_value[m].value=="")
	{
	value=0;
	document.forms[0].txt_value[m].value="";	
	}
	if(cost=="")
	{
	cost=0;
		
	}
 var amount2=eval(cost)*eval(value)*eval(unit);
document.forms[0].txt_amount[m].value=Math.round(eval(amount2));
document.forms[0].txt_value3.value=document.forms[0].txt_value[m].value;
}


}

function doSave()
{	
  	enableButtons( true, true, true, true, false);	
    document.forms[0].hidAction.value ="insert";
	document.forms[0].hidAction1.value ="insert1";
	document.forms[0].hidBeanId.value="agrpoultry";
	document.forms[0].hidSourceUrl.value="/action/agr_sheep_eligibility1.jsp";
	document.forms[0].hidBeanMethod.value="updatesheepeligibility";
	document.forms[0].hidBeanGetMethod.value="getsheepeligibility";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
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
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onLoad="onloading();costval();costfeed();callamount()">
<form name="frmpri" method=post>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1"
					bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
					<tr>
						
                  <td> 
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
                      <tr> 
                        <td   colspan="13"> 
<table width="100%" border="0" cellspacing="2" cellpadding="1"
									>
                            <tr bgcolor="#71694F" BORDER="1"> 
                              <td bgcolor="#71694F"><b><font  color="#FFFFFF">Particulars</font></b></td>
                              <td align="center" bgcolor="#71694F"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">No. 
                                of units</font></b></td>
                              <td align="center" bgcolor="#71694F"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Cost 
                                per unit(Rs.)</font></b></td>
                              <td align="center" bgcolor="#71694F"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Amount(Rs.)</font></b></td>
                            </tr>
                            <tr> 
                              <td width="72%" height="26" ><font size="2" face="MS Sans Serif" >Purchase 
                                of sheep/goat(Female) 
                                <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:right;">
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                <input type="hidden" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                </font></td>
                              <td width="7%" > 
                                <input type="text" name="txt_unit"size="10" maxlength="15"
									value="<%=Helper.correctNull((String)hshValues.get("txt_maleno"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td width="10%"> 
                                <input type="text" name="txt_cost"size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_malecost"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td width="11%" > 
                                <input type="text" name="txt_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td><font size="2" face="MS Sans Serif" >Purchase 
                                of sheep/goat(Male) 
                                <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:right;">
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                <input type="hidden" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                </font></td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="15"
									value="<%=Helper.correctNull((String)hshValues.get("txt_femaleno"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_cost"size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_femalecost"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td><font size="2" face="MS Sans Serif">Cost of 
                                transportation of Animals 
                                <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:right;">
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                <input type="hidden" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                </font></td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_cost"size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_markettranscost"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td><font size="2" face="MS Sans Serif">Cost of 
                                Feeding of Breeding Stock(No.of adults*cost of 
                                feeding/animal/day* 
                                <input type="text" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="<%=Helper.correctNull((String)hshValues.get("txt_value1"))%>" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="costfeed()">
                                days ) 
                                <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:right;">
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                </font></td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_cost"size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_feedadult"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td><font size="2" face="MS Sans Serif">Veterinary 
                                Aid(No.of adults*cost ot vt aid/month/animal* 
                                <input type="text" name="txt_value" onFocus=""  size="10" maxlength="15"
									value="<%=Helper.correctNull((String)hshValues.get("txt_value2"))%>" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="costfeed()">
                                months) 
                                <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:right;">
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                </font></td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_cost"size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_vtaidprice"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td><font size="2" face="MS Sans Serif">Insurance 
                                Premium(No.of adults*cost of insurance/animal) 
                                <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:right;">
                                <input type="hidden" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                </font></td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_cost"size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_inspremium"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td><font size="2" face="MS Sans Serif">Labour(no.of 
                                labourers*wages/month* 
                                <input type="hidden" name="txt_specify" size="15" maxlength="100"
									value="" onKeyPress=""
									style="text-align:right;">
                                <input type="text" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="<%=Helper.correctNull((String)hshValues.get("txt_value3"))%>" onKeyPress="allowInteger()"
									style="text-align:right;" onBlur="costfeed()">
                                months) 
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                </font></td>
                              <td><input type="text" name="txt_unit"onFocus=""  size="10" maxlength="15"
									value="<%=Helper.correctNull((String)hshValues.get("txt_employee"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_cost"size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_wageemployee"))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                              <td><input type="text" name="txt_amount"  size="10"
									maxlength="15" value="" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td colspan="4">
							  
							  <% 
				   arryRow=new ArrayList();
				arryCol=(ArrayList)hshValues.get("arryRow");
			
			          %>
                  <% if (arryCol.size()!= 0) {
				 
			          %>
							  <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                  <tr bgcolor="#71694F"> 
                                    <td colspan="4"><font size="2" face="MS Sans Serif" color="#FFFFFF"><strong>Other 
                                      Civil Works</strong></font></td>
                                  </tr>
                                  <tr> 
								   <%
				if(arryCol!=null)
				{				
					for(int m=0;m<arryCol.size();m++)
					{							
						a2 = (ArrayList)arryCol.get(m);
						
						%>
                                    <td width="73%"><font size="2" face="MS Sans Serif" >Construction 
                                      of 
                                      <input type="text" name="txt_specify" size="15" maxlength="100"
									value="<%=Helper.correctNull((String)a2.get(3))%> " onKeyPress=""
									>
                                      shed measuring 
                                      <input type="text" name="txt_sq" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)a2.get(4))%>" onKeyPress="allowNumber(this)" onBlur="amount();callTotal()"
									style="text-align:right;">
                                      sq ft @ Rs.
                                      <input type="text" name="txt_value" size="10" maxlength="15"
									value="<%=Helper.correctNull((String)a2.get(5))%>" onKeyPress="allowInteger()" onBlur="amount();callTotal()"
									style="text-align:right;">
                                      per sq ft</font></td>
                                    <td width="7%"> 
                                      <input type="text" name="txt_unit"onFocus=""  size="10" maxlength="15"
									value="<%=Helper.correctNull((String)a2.get(6))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                                    <td width="8%">
                                      <input type="text" name="txt_cost"size="10"
									maxlength="15" value="0" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                                    <td width="12%"> 
                                      <input type="text" name="txt_amount"  size="10"
									maxlength="15" value="<%=Helper.correctNull((String)a2.get(7))%>" onKeyPress="allowInteger()"
									style="text-align:right;"></td>
                                  </tr>
								    <%}}%>
                                </table>  <%}%></td>
                            </tr>
                          </table>
						  <br>
						  <% 
				   arryRow2=new ArrayList();
				arryCol2=(ArrayList)hshValues.get("arryRow2");
			
			          %>
                                <% if (arryCol2.size()!= 0) {
				 
			          %>
                                
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                            <tr bgcolor="#71694F">
                              <td colspan="4" ><font size="2" face="MS Sans Serif" color="#FFFFFF"><strong>Purchase 
                                of Equipments</strong></font></td>
                            </tr>
                            <tr bgcolor="#71694F"> 
                              <td colspan="4" ><font size="2" face="MS Sans Serif" color="#FFFFFF"><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Name 
                                of equipments with specifications</font></b></font></td>
                            </tr>
                            <tr> 
                              <%
				if(arryCol2!=null)
				{				
					for(int m=0;m<arryCol2.size();m++)
					{							
						a3 = (ArrayList)arryCol2.get(m);
						
						%>
                              <td width="74%"><font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_specify" size="70" maxlength="100"
									value="<%=Helper.correctNull((String)a3.get(3))%>" onKeyPress=""
									style="text-align:left;">
                                <input type="hidden" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                </font></td>
                              <td width="8%"><font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_unit" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)a3.get(4))%>" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                </font></td>
                              <td width="9%"><font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_cost" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)a3.get(5))%>" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                </font></td>
                              <td width="9%"><font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_amount" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)a3.get(6))%>" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                                </font></td>
                            </tr>
                            <%}}%>
                          </table>
                                <%}%>

						  <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td colspan="4"><font size="2" face="MS Sans Serif" >&nbsp; 
                                </font><font size="2" face="MS Sans Serif" >&nbsp; 
                                </font><font size="2" face="MS Sans Serif" >&nbsp;</font> 
                                <% 
				   arryRow4=new ArrayList();
				arryCol4=(ArrayList)hshValues.get("arryRow4");
			
			          %>
                                <% if (arryCol4.size()!= 0) {
				 
			          %>
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                  <tr bgcolor="#71694F"> 
                                    <td colspan="4" ><font size="2" face="MS Sans Serif" color="#FFFFFF"><strong>Other 
                                      Sources</strong></font></td>
                                  </tr>
                                  <tr> 
                                    <%
				if(arryCol4!=null)
				{				
					for(int m=0;m<arryCol4.size();m++)
					{							
						a4 = (ArrayList)arryCol4.get(m);
						
						%>
                                    <td width="74%"><font size="2" face="MS Sans Serif" > 
                                      <input type="text" name="txt_specify" size="70" maxlength="100"
									value="<%=Helper.correctNull((String)a4.get(3))%>" onKeyPress=""
									style="text-align:left;">
                                      <input type="hidden" name="txt_value"onFocus=""  size="10" maxlength="15"
									value="" onKeyPress="allowInteger()"
									style="text-align:right;">
                                      <input type="hidden" name="txt_sq" size="10" maxlength="10"
									value="" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                      </font></td>
                                    <td width="8%"><font size="2" face="MS Sans Serif" > 
                                      <input type="text" name="txt_unit" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)a4.get(4))%>" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                      </font></td>
                                    <td width="9%"><font size="2" face="MS Sans Serif" > 
                                      <input type="text" name="txt_cost" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)a4.get(5))%>" onKeyPress="allowInteger()" onBlur="callTotal()"
									style="text-align:right;">
                                      </font></td>
                                    <td width="9%"><font size="2" face="MS Sans Serif" > 
                                      <input type="text" name="txt_amount" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)a4.get(6))%>" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                                      </font></td>
                                  </tr>
                                  <%}}%>
                                </table>
                                <%}%>
                              </td>
                            </tr>
                            <tr bgcolor="#71694F"> 
                              <td width="73%" ><b><font color="#FFFFFF" size="1" face="MS Sans Serif">Total(Amount)(Rs.)</font></b></td>
                              <td width="8%">&nbsp;</td>
                              <td width="9%">&nbsp;</td>
                              <td width="10%"><input type="text" name="txt_totalamount" size="10"
									maxlength="15" value="<%=Helper.correctNull((String)hshValues.get("txt_totalamount"))%>" onKeyPress="allowInteger()"
									readOnly style="text-align:right;"> <b></b></td>
                            </tr>
                            <tr> 
                              <td colspan="3" align="right"><b></b><b><font size="2" face="MS Sans Serif" >Margin</font> 
                                <font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_marginper" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("txt_margin"))%>" onKeyPress="allowInteger()" onBlur="marginper();loanamount()"
									style="text-align:right;">
                                % </font></b></td>
                              <td nowrap><font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_margin" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("txt_marginper"))%>" onKeyPress="allowInteger()" onBlur="margin();loanamount()"
									style="text-align:right;">
                                </font></td>
                            </tr>
                            <tr> 
                              <td colspan="3" align="right"><font size="2" face="MS Sans Serif" >&nbsp;</font><font size="2" face="MS Sans Serif" ><strong>Subsidy 
                                <input type="text" name="txt_subsidyper" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("txt_subsidyper"))%>" onKeyPress="allowInteger()" onBlur="subsidyper();loanamount()"
									style="text-align:right;">
                                % </strong></font></td>
                              <td><font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_subsidy" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("txt_subsidy"))%>" onKeyPress="allowInteger()" onBlur="subsidy();loanamount()"
									style="text-align:right;">
                                </font></td>
                            </tr>
                            <tr> 
                              <td colspan="3" align="right"><b><font size="2" face="MS Sans Serif" >Loan 
                                Amount(Rs.)</font></b></td>
                              <td><font size="2" face="MS Sans Serif" > 
                                <input type="text" name="txt_totalloanamount1" size="10" maxlength="10"
									value="<%=Helper.correctNull((String)hshValues.get("txt_totalloanamount1"))%>" onKeyPress="allowInteger()" onBlur=""
									style="text-align:right;">
                                </font></td>
                            </tr>
                          </table>

						</td>
					</tr>
				</table>
				
				</td>
			</tr>
			<tr>
				<td><br>
				<table width="12%" border="0" cellpadding="0" cellspacing="0"
					align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
					class="outertablecolor">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="2">
							<tr valign="top">
								
                        <td><input type="button" name="cmdedit" value="Edit"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doEdit()"></td>
								<td><input type="button" name="cmdapply" value="Save"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doSave()"></td>
								<td><input type="button" name="cmdcancel" value="Cancel"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doCancel()"></td>
								<td width="0"><input type="button" name="cmddel" value="Delete"
									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									class="buttoncolor" onClick="doDelete()"></td>
								<td width="0"><input type="button" name="cmdhelp2" value="Help"
									style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									onClick="callhelp()"></td>
								<td width="0"><input type="button" name="cmdclose" value="Close"
									style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
									onClick="doClose()"></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br>
                  </td>
			</tr>
			<tr>
				<td></td>
			</tr>
		</table>
		</td>
	</tr>

</table></td>
</tr>
<table></table>
	<tr>
		<%String strappno = request.getParameter("appno");%>

		<td><input type="hidden" name="hidAction">
		<input type="hidden" name="hidAction1"> <input type="hidden"
			name="hidBeanId" value=""> <input type="hidden"
			name="hidBeanMethod" value=""> <input type="hidden"
			name="hidBeanGetMethod" value=""> <input type="hidden"
			name="hidSourceUrl" value=""> <input type="hidden" name="hidApp_type"
			value="A"> <input type="hidden" name="hidflag" value=""> <input
			type="hidden" name="hideditflag"> <input type="hidden" name="selsno"
			value=""> <input type="hidden" name="hidval">  <input
			type="hidden" name="page">   
		 <input
			type="hidden" name="radLoan" value="Y"> <input
			type="hidden" name="app_status" value="<%=app_status%>"><input type="hidden"
			name="hid_sno"
			value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
			<input type="hidden" name="measurement" value="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">
			<input type="hidden" name="txt_value1" value="<%=Helper.correctNull((String)hshValues.get("txt_value1"))%>">
		    <input type="hidden" name="txt_value2" value="<%=Helper.correctNull((String)hshValues.get("txt_value2"))%>">
		    <input type="hidden" name="txt_value3" value="<%=Helper.correctNull((String)hshValues.get("txt_value3"))%>">
		
			</td>
	</tr>
</table>
  </form>
</body>
</html>

