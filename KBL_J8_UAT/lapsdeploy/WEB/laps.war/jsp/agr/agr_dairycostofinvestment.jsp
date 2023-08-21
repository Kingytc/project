<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<%
	
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	String strMargin = Helper.correctNull((String) hshValues
			.get("Margin"));
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strFacSNo=Helper.getfacilitySno(schemetype);
	String strAnimaltype = Helper.correctNull((String)hshValues.get("agr_animaltype"));
	String strAnimaltype1="";
	if(!strAnimaltype.equalsIgnoreCase(""))
	{
		if(strAnimaltype.equalsIgnoreCase("1"))
		{
			strAnimaltype1 = "Cow";
		}
		else
		{
			strAnimaltype1 = "Buffalo";
		}
	}
	
%>
<html>
<head>
<title>Cost of Investment</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var schemetype="<%=schemetype%>";
var varanimaltype="<%=Helper.correctNull((String)hshValues.get("agr_animaltype"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callonLoad()
{
	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	document.all.unitcost.style.visibility="hidden";
	document.all.unitcost.style.position="absolute";
	document.all.marginamt.style.visibility="hidden";
	document.all.marginamt.style.position="absolute";
	document.all.loanamt.style.visibility="hidden";
	document.all.loanamt.style.position="absolute";
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	       disableCmdButtons(false, true, true, true, false);
		}
		else
		{
			disableCmdButtons(true, true, true, true, false);
		}
	}
	else
	{
		disableCmdButtons(true, true, true, true, false);
	}
	
	document.forms[0].sel_animaltype.value = varanimaltype;
	document.forms[0].sel_animaltype.disabled = true;
	disabledFields(true);
}
function doEdit()
{
	disabledFields(false);
	disableCmdButtons(true, false, false, false, true);
	document.forms[0].txt_costofconsofadultshed.readOnly=true;
	document.forms[0].txt_costofcalvesshed.readOnly=true;
	document.forms[0].txt_costofequipment.readOnly=false;
	//document.forms[0].txt_noofanimal.readOnly=true;
	document.forms[0].txt_totalcostofanimal.readOnly=true;
	document.forms[0].txt_costoffencing.readOnly=false;
	document.forms[0].txt_insurancecost.readOnly=true;
	document.forms[0].txt_insurancecost.readOnly=true;
	document.forms[0].txt_totalunitcost.readOnly=true;
}
function doSave()
{
	/*if(NanNumber(parseFloat(document.getElementById('txt_noofadultanimal').value))==0)
	{
		ShowAlert('121',"No. of adult Animals");
		document.getElementById('txt_noofadultanimal').value="";
		document.getElementById('txt_noofadultanimal').focus();
		return;
	}
	if(NanNumber(parseFloat(document.getElementById('txt_yieldingltr').value))==0)
	{
		ShowAlert('121',"yielding litres a day");
		document.getElementById('txt_yieldingltr').value="";
		document.getElementById('txt_yieldingltr').focus();
		return;
	}
	if(NanNumber(parseFloat(document.getElementById('txt_costofanimal').value))==0)
	{
		ShowAlert('121',"Cost of animal");
		document.getElementById('txt_costofanimal').value="";
		document.getElementById('txt_costofanimal').focus();
		return;
	}
	if(NanNumber(parseFloat(document.getElementById('txt_insurancepercent').value))==0)
	{
		ShowAlert('121',"Insurance Percentage");
		document.getElementById('txt_insurancepercent').value="";
		document.getElementById('txt_insurancepercent').focus();
		return;
	}
	if(NanNumber(parseFloat(document.getElementById('txt_totalunitcost').value))==0)
	{
		alert("The Total unit Cost Cannot be Zero");
		return;
	}*/
	if(NanNumber(parseFloat(document.forms[0].txt_noofadultanimal.value))==0)
    {
        ShowAlert('121',"No. of adult Animals");
        document.forms[0].txt_noofadultanimal.value="";
        document.forms[0].txt_noofadultanimal.focus();
        return;
    } 
    if(NanNumber(parseFloat(document.forms[0].txt_yieldingltr.value))==0)
    {
        ShowAlert('121',"yielding litres a day");
        document.forms[0].txt_yieldingltr.value="";
        document.forms[0].txt_yieldingltr.focus();
        return;
    }
    if(NanNumber(parseFloat(document.forms[0].txt_costofanimal.value))==0)
    {
        ShowAlert('121',"Cost of animal");
        document.forms[0].txt_costofanimal.value="";
        document.forms[0].txt_costofanimal.focus();
        return;
    }
    if(NanNumber(parseFloat(document.forms[0].txt_insurancepercent.value))==0)
    {  
        ShowAlert('121',"Insurance Percentage");
        document.forms[0].txt_insurancepercent.value="";
        document.forms[0].txt_insurancepercent.focus();
        return;
    }
    if(NanNumber(parseFloat(document.forms[0].txt_totalunitcost.value))==0)
    {
        alert("The Total unit Cost Cannot be Zero");
        return;
    }
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="insert"
	document.forms[0].hidBeanId.value="agrnursery";
	document.forms[0].hidBeanMethod.value="updateDairyCostofInvestment";
	document.forms[0].hidBeanGetMethod.value="getDairyCostofInvestment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_dairycostofinvestment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidBeanId.value="agrnursery"
		document.forms[0].hidBeanMethod.value="updateDairyCostofInvestment";
		document.forms[0].hidBeanGetMethod.value="getDairyCostofInvestment";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agr_dairycostofinvestment.jsp";
		document.forms[0].submit();
	 }
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
	    document.forms[0].hidBeanId.value="agrnursery"
		document.forms[0].hidBeanGetMethod.value="getDairyCostofInvestment";
	    document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_dairycostofinvestment.jsp";
		document.forms[0].method="post";	
		document.forms[0].submit();
	 }
}
function callcalculateTotal()
{
	if(NanNumber(parseFloat(document.forms[0].txt_noofadultanimal.value))<NanNumber(parseFloat(document.forms[0].txt_firstbatchanimal.value)))
	{
		alert("The first batch of animal should not exceed the no.of adult animals");
		document.forms[0].txt_firstbatchanimal.value="";
		return;
	}
	document.forms[0].txt_costofconsofadultshed.value = parseFloat(document.forms[0].txt_noofadultanimal.value)*
    													parseFloat(document.forms[0].txt_sqftperadultanimal.value)*
	 													parseFloat(document.forms[0].txt_adultshedamtpersqft.value);

	document.forms[0].txt_costofconsofadultshed.value=roundVal(NanNumber(document.forms[0].txt_costofconsofadultshed.value));
	document.getElementById('adultarea').innerHTML=roundVal(NanNumber(parseFloat(document.forms[0].txt_noofadultanimal.value)*
													parseFloat(document.forms[0].txt_sqftperadultanimal.value)))+" sft";

	//document.forms[0].txt_noofanimal.value=document.forms[0].txt_noofadultanimal.value;

	document.forms[0].txt_costofcalvesshed.value = roundVal(NanNumber(parseFloat(document.forms[0].txt_calvesarea.value)*
													parseFloat(document.forms[0].txt_calvesamtpersqft.value)));
	document.forms[0].txt_costofheifersshed.value = roundVal(NanNumber(parseFloat(document.forms[0].txt_heifersarea.value)*
			parseFloat(document.forms[0].txt_heifersamtpersqft.value)));
	
	
	document.forms[0].txt_insurancecost.value = roundVal(NanNumber(parseFloat(document.forms[0].txt_costofanimal.value)*
			parseFloat(document.forms[0].txt_firstbatchanimal.value) * 
			parseFloat(document.forms[0].txt_insurancepercent.value)/100));
	
	document.forms[0].txt_totalcostofanimal.value = roundVal(NanNumber(parseFloat(document.forms[0].txt_costofanimal.value)*
			parseFloat(document.forms[0].txt_noofadultanimal.value)));
	
	document.forms[0].txt_totalunitcost.value = roundVal(NanNumber(parseFloat(document.forms[0].txt_costofconsofadultshed.value)+
										 parseFloat(document.forms[0].txt_costofcalvesshed.value)+
										 parseFloat(document.forms[0].txt_costoffencing.value)+
										 parseFloat(document.forms[0].txt_totalcostofanimal.value)+
										 parseFloat(document.forms[0].txt_costofequipment.value)+
										 parseFloat(document.forms[0].txt_maintenancecost.value)+
										 parseFloat(document.forms[0].txt_insurancecost.value)+
										 parseFloat(document.forms[0].txt_miscellaneouscost.value)+
										 parseFloat(document.forms[0].txt_costofheifersshed.value)+
										 parseFloat(document.forms[0].txt_godowncost.value)));
	 
	document.getElementById('unitcost').innerHTML=document.forms[0].txt_totalunitcost.value;
	document.getElementById('marginamt').innerHTML=roundVal(NanNumber(parseFloat(document.forms[0].txt_totalunitcost.value) * ('<%=strMargin%>'))/100);
	document.getElementById('loanamt').innerHTML=roundVal(NanNumber(parseFloat(document.getElementById('unitcost').innerHTML) - parseFloat(document.getElementById('marginamt').innerHTML)));
}
function disableCmdButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}
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
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callonLoad();callcalculateTotal()">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Agriculture -&gt; Cost Of Investment</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="128" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellpadding="3" cellspacing="5" align="center" class="outertable">
	<tr>
		<td>
		<TABLE BORDER="0" CELLSPACING="3" CELLPADDING="3" WIDTH="98%" class="outertable" align="center">
		<TR > 
            <TD COLSPAN="2" align="center" valign="middle"><b>Select Animal Type</b>
           &nbsp; <select name="sel_animaltype"> 
           <option value="">--Select--</option>
           <option value="1">Cow</option>
           <option value="2">Buffalo</option>
           </select></TD>
          </TR>
		
          <TR CLASS="dataheader"> 
            <TD COLSPAN="2" align="left"><b>Cost of Investment</b></TD>
          </TR>
          <tr> 
            <td colspan="2">&nbsp;<b>1.Cost of Construction of shed for Adult</b></td>
          </tr>
          <TR> 
            <TD nowrap="nowrap" ID="res1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No. of 
              adult <%=strAnimaltype1%> 
              <input type="text" tabindex="1"
					value="<%=Helper.correctInt((String) hshValues
							.get("agr_noofadultanimal"))%>"
					name="txt_noofadultanimal" size="8" maxlength="10"
					onKeyPress="allowInteger(this)" style="text-align: right"
					onBlur="callcalculateTotal();">
              at 
              <INPUT
					TYPE="text" TABINDEX="2"
					VALUE="<%=Helper.correctDouble((String) hshValues
							.get("agr_sqftperadultanimal"))%>"
					NAME="txt_sqftperadultanimal" SIZE="8" MAXLENGTH="10"
					style="text-align: right" ONKEYPRESS="allowInteger(this)"
					onblur="callcalculateTotal()">
              sft. Per <%=strAnimaltype1%> , total area of <span id="adultarea">0.00 sft.</span> 
              &nbsp;@ Rs. 
              <INPUT
					TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_adultshedamtpersqft"))))%>"
					NAME="txt_adultshedamtpersqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal()">
              per sft</TD>
            <TD ID="res2"> 
              <INPUT TYPE="text"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_costofconsofadultshed"))))%>"
					NAME="txt_costofconsofadultshed" size="15" MAXLENGTH="10"
					style="text-align: right" onKeyPress="allowDecimals(this)"
					onblur="roundtxt(this);">
            </TD>
          </TR>
          <tr> 
            <td colspan="2">&nbsp;<b>2.Cost of Construction of shed for Calves &amp; 
              Heifers </b></td>
          </tr>
          <TR> 
            <TD>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Avg. of 
              <input type="text"
			name="txt_noofcalvesanimal" tabindex="4"
					value="<%=Helper.correctNull((String) hshValues
							.get("agr_noofcalvesanimal"))%>"
					 size="8" maxlength="10"
					onKeyPress="allowInteger(this)" style="text-align: right"
					onBlur="callcalculateTotal()">
              Calves 
              ,Total area of 
              <INPUT TYPE="text"
					TABINDEX="6" NAME="txt_calvesarea"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_calvesarea"))))%>"
					 SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal()">
              sft @ Rs. 
              <INPUT TYPE="text" TABINDEX="7"
				NAME="txt_calvesamtpersqft"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_calvesamtpersqft"))))%>"
					 SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal()">
              per sft. </TD>
            <TD VALIGN="top"> 
              <INPUT TYPE="text" NAME="txt_costofcalvesshed"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_costofcalvesshed"))))%>"
					 size="15" MAXLENGTH="10"
					style="text-align: right" onKeyPress="allowDecimals(this)"
					onblur="roundtxt(this);">
            </TD>
          </TR>
          <TR> 
           <TD >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Avg. of
              <input type="text"
			name="txt_noofheifersanimal" tabindex="5"
					value="<%=Helper.correctNull((String) hshValues
							.get("agr_noofheifersanimal"))%>"
					 size="8" maxlength="10"
					onKeyPress="allowInteger(this)" style="text-align: right"
					onBlur="callcalculateTotal();"> Heifers
              ,Total area of 
              <INPUT TYPE="text"
					TABINDEX="6" NAME="txt_heifersarea"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_heifersarea"))))%>"
					 SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal()">
              sft @ Rs. 
              <INPUT TYPE="text" TABINDEX="7"
				NAME="txt_heifersamtpersqft"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_heifersamtpersqft"))))%>"
					 SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal()">
              per sft. </TD>
            <TD VALIGN="top"> 
              <INPUT TYPE="text" NAME="txt_costofheifersshed"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_costofheifersshed"))))%>"
					 size="15" MAXLENGTH="10"
					style="text-align: right" onKeyPress="allowDecimals(this)"
					onblur="roundtxt(this);">
            </TD>
          </TR>
          
          <tr> 
            <td>&nbsp;<b>3.Cost of Equipment like feed troughs, buckets, 
              milk cans etc.,</b></td>
              <td> 
              <INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_costofequipment"))))%>"
					NAME="txt_costofequipment" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)">
            </td>
          </tr>
          
          <tr> 
            <TD >&nbsp;<b>4.Cost of fencing</b> </TD>
            <TD> 
              <INPUT TYPE="text" 
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_costoffencing"))))%>"
					NAME="txt_costoffencing" SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal();">
            </TD>
          </tr>
		  <tr> 
            <td>&nbsp;<b>5.Cost of <%=strAnimaltype1%>, yielding 
              <input type="text" tabindex="12" name="txt_yieldingltr"
					value="<%=Helper
							.correctInt((String) hshValues
									.get("agr_yieldingltr"))%>"
					 size="8" maxlength="10"
					onKeyPress="allowDecimals(this)" style="text-align: right"
					onBlur=" roundtxt(this); callcalculateTotal();">
			litres a day @ Rs. 
			<input type="text" tabindex="13" name="txt_costofanimal"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_costofanimal"))))%>"
					 size="8" maxlength="10"
					onKeyPress="allowDecimals(this)" style="text-align: right"
					onBlur=" roundtxt(this); callcalculateTotal();">
              each, including transportation</b></td>
            <TD> 
              <INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_totalcostofanimal"))))%>"
					NAME="txt_totalcostofanimal" SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);">
            </TD>
          </tr>
          <tr> 
            <td >&nbsp;<b>6.Maintenance cost for first three months(One 
              fourth of first year maintainence expenditure)</b></td>
            <td> 
              <INPUT TYPE="text" TABINDEX="14" NAME="txt_maintenancecost"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_maintenancecost"))))%>"
					 SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal();">
            </td>
          </tr>
		  <tr> 
            <td >&nbsp;<b>7.Insurance Charges for 
              <input type="text" tabindex="15"
					value="<%=Helper.correctInt((String) hshValues
							.get("agr_firstbatchanimal"))%>"
					name="txt_firstbatchanimal" size="8" maxlength="10"
					onKeyPress="allowInteger(this)" style="text-align: right"
					onBlur="callcalculateTotal();"><%=strAnimaltype1%>s 
			 @</b>
			 <input type="text" tabindex="16" name="txt_insurancepercent" 
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_insurancepercent"))))%>"
					size="8" maxlength="10"
					onKeyPress="allowDecimals(this)" style="text-align: right"
					onBlur=" roundtxt(this);checkPercentage(this);callcalculateTotal();">
              <b>% of cost </b></td>
            <td> 
              <INPUT TYPE="text" TABINDEX="17" NAME="txt_insurancecost"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_insurancecost"))))%>"
					 SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal();">
            </td>
          </tr>
           <tr> 
            <td >&nbsp;<b>8.Cost of Office,Godown & Utilities </b></td>
            <td> 
              <INPUT TYPE="text" TABINDEX="17" NAME="txt_godowncost" 
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_costofgodown"))))%>"
					SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal();">
            </td>
          </tr>
          <tr> 
            <td>&nbsp;<b>9.Miscellaneous Expenditure </b></td>
            <td> 
              <INPUT TYPE="text" TABINDEX="17" NAME="txt_miscellaneouscost" 
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_miscellaneouscost"))))%>"
					SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);callcalculateTotal();">
            </td>
          </tr>
          <tr class="datagrid"> 
            <td width="75%">&nbsp;<b>Total Unit Cost</b></td>
            <td width="25%"> 
              <INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshValues
									.get("agr_totunitcost"))))%>"
					NAME="txt_totalunitcost" SIZE="13" MAXLENGTH="10"
					style="text-align: right;background-color:#7a4d98;border-style:none; color:#000000;font-weight:bold;color: #ffffff"
					onblur="roundtxt(this);" ONKEYPRESS="allowDecimals(this)"></td>
          </tr>
		  <tr> 
			<td colspan="2"><b><span id="unitcost">0.00</span></b></td>
          </tr>
		   <tr> 
			<td colspan="2"><b><span id="marginamt">0.00</span></b></td>
          </tr>
		   <tr> 
			<td colspan="2"><b><span id="loanamt">0.00</span></b></td>
          </tr>
        </table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable="Y" />
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAppType">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>