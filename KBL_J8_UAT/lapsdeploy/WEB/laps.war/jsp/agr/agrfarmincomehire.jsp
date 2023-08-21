<%@include file="../share/directives.jsp"%>

<%	String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
	
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
	HashMap hshFarmMachinery = new HashMap();
	HashMap hshLimitDet = new HashMap();
	HashMap hshtotalcost=new HashMap();
	if (hshValues != null) 
	{
		hshFarmMachinery = (HashMap) hshValues.get("hshFarmMachinery");
		hshLimitDet = (HashMap) hshValues.get("hshLimitsDet");
		hshtotalcost=(HashMap) hshValues.get("hshtotalcost");
	}
	
	
	//out.print("2===" +hshFarmMachinery);
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strschemetype="",strfacsno="",stragrschemetype="";
	HashMap hshScheme = new HashMap();
	hshScheme = Helper.splitScheme(schemetype);
	//out.print("1===" +hshScheme);
	if(hshScheme!=null)
	{
		strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
		if(strfacsno.equalsIgnoreCase(""))
			strfacsno = Helper.correctNull((String)hshFarmMachinery.get("facsno"));
		
		stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		if(stragrschemetype.equalsIgnoreCase(""))
			stragrschemetype = Helper.correctNull((String)hshFarmMachinery.get("schemetype"));
	}
%>
<html>
<head>
<title>Agriculture - Farm Machineries Details</title>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" 
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varschemetype="<%=schemetype%>";

function disableEditButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function callonLoad()
{
	if(document.forms[0].appstatus.value=="Processed/Rejected" || document.forms[0].appstatus.value=="Processed/Approved" || document.forms[0].appstatus.value=="Closed/Approved" || document.forms[0].appstatus.value=="Closed/Rejected")
	{
		disableEditButtons(true,true,true,true,false);
	}
	else
	{
		disableEditButtons(false,true,true,true,false);
	}
	disabledFields(true);
	document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value=varschemetype;

	document.forms[0].txt_incfromcustom.value='<%=Helper.correctNull((String) hshFarmMachinery
		.get("incmcustom"))%>';
	document.forms[0].txt_totincfromcustom.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("totincmcustom"))%>';
	document.forms[0].txt_totincfromcustomService.value='<%=Helper.correctNull((String) hshFarmMachinery
				.get("totincmcustom"))%>';							
	document.forms[0].txt_lessoperations.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("lessoperation"))%>';
	document.forms[0].txt_dieselamt.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("amtperlitre"))%>';
	document.forms[0].txt_fuellubricant.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("fuellub"))%>';
	document.forms[0].txt_lubfuelcost.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("fuelcost"))%>';
	document.forms[0].txt_driversal.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("driversalmon"))%>';
	document.forms[0].txt_drivertotsal.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("driversalyr"))%>';
	document.forms[0].txt_insurancetax.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("insuretax"))%>';
	document.forms[0].txt_repairmaintain.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("repairmaintain"))%>';
	document.forms[0].txt_overheadtot.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("totdeduct"))%>';
	document.forms[0].txt_netincome.value='<%=Helper.correctNull((String) hshFarmMachinery
			.get("netincome"))%>';
	document.forms[0].txt_otrexpen.value='<%=Helper.correctNull((String) hshFarmMachinery
				.get("agr_ihs_othrexp"))%>';						
	
	roundtxt(document.forms[0].txt_incfromcustom);
	roundtxt(document.forms[0].txt_totincfromcustom);
	roundtxt(document.forms[0].txt_lessoperations);
	roundtxt(document.forms[0].txt_dieselamt);
	
	roundtxt(document.forms[0].txt_fuellubricant);
	roundtxt(document.forms[0].txt_lubfuelcost);
	roundtxt(document.forms[0].txt_driversal);
	roundtxt(document.forms[0].txt_drivertotsal);
	
	roundtxt(document.forms[0].txt_insurancetax);
	roundtxt(document.forms[0].txt_repairmaintain);
	roundtxt(document.forms[0].txt_overheadtot);
	roundtxt(document.forms[0].txt_netincome);
	roundtxt(document.forms[0].txt_totincfromcustomService);
	roundtxt(document.forms[0].txt_otrexpen);
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
	disableEditButtons(true, false, false, false, false);
	document.forms[0].txt_repairmaintain.readOnly=false;
	document.forms[0].txt_totalhours.readOnly=true;
	document.forms[0].txt_totincfromcustom.readOnly=true;
	document.forms[0].txt_fuellubricant.readOnly=true;
	document.forms[0].txt_lubfuelcost.readOnly=true;
	document.forms[0].txt_drivertotsal.readOnly=true;
	document.forms[0].txt_overheadtot.readOnly=true;
	document.forms[0].txt_netincome.readOnly=true;
	document.forms[0].txt_lessoperations.readOnly=true;
	//document.forms[0].txt_totalacre.readOnly=true;
	document.forms[0].txt_totcostperhour.readOnly=true;
	document.forms[0].txt_fuelcostperannum.readOnly=true;
	document.forms[0].txt_overHeadCostPerAnnum.readOnly=true;
	document.forms[0].txt_totincfromcustomService.readOnly=true;	
}

function doSave()
{
	//document.forms[0].txt_dieselhrsusage.readOnly=false;
	disableEditButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrfarmmachinery";
	document.forms[0].hidBeanMethod.value="updateIncomeHireDetails";
	document.forms[0].hidBeanGetMethod.value="getIncomeHireDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agrfarmincomehire.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
	
}

function doDelete()
{	
	if(ConfirmMsg(101))
	 {
		//document.forms[0].txt_dieselhrsusage.readOnly=false;
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="agrfarmmachinery"
		document.forms[0].hidBeanMethod.value="updateIncomeHireDetails";
		document.forms[0].hidBeanGetMethod.value="getIncomeHireDetails";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agrfarmincomehire.jsp";
		document.forms[0].submit();
	 }	
}

function doCancel()
{	
	if(ConfirmMsg(102))
	 {
		//document.forms[0].txt_dieselhrsusage.readOnly=false;
	    document.forms[0].hidBeanId.value="agrfarmmachinery"
		document.forms[0].hidBeanGetMethod.value="getIncomeHireDetails";
	    document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrfarmincomehire.jsp";
		document.forms[0].hidSourceUrl.value="/action/agrfarmincomehire.jsp";
		document.forms[0].method="post";	
		document.forms[0].submit();
	 }	
}

function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
}

function calculateTotalHours()
{
	document.forms[0].txt_totalhours.value = parseFloat(document.forms[0].txt_onfarm.value)+
										     parseFloat(document.forms[0].txt_offfarm.value)+
											 parseFloat(document.forms[0].txt_hiringfortransport.value);
	document.forms[0].txt_totalhours.value=NanNumber(document.forms[0].txt_totalhours.value);
	roundtxt(document.forms[0].txt_totalhours);
	//document.forms[0].txt_dieselhrsusage.value=document.forms[0].txt_totalhours.value;
	calculateIncomeCustomService();
	calculateFuelLubricant();
	document.forms[0].txt_totincfromcustom.value=NanNumber(document.forms[0].txt_totincfromcustom.value);
}

function calculateIncomeCustomService()
{
	document.forms[0].txt_totincfromcustom.value = parseFloat(document.forms[0].txt_incfromcustom.value)*
    											parseFloat(document.forms[0].txt_totalhours.value);
	roundtxt(document.forms[0].txt_totincfromcustom);
	document.forms[0].txt_totincfromcustom.value=NanNumber(document.forms[0].txt_totincfromcustom.value);
	document.forms[0].txt_totincfromcustomService.value = parseFloat(document.forms[0].txt_totincfromcustom.value);
	roundtxt(document.forms[0].txt_totincfromcustomService);
	calculateRepairandMaintenance();
}

function calculateFuelLubricant()
{
	document.forms[0].txt_fuellubricant.value = parseFloat(document.forms[0].txt_dieseloil.value)*
    											parseFloat(document.forms[0].txt_dieselamt.value) *
    											parseFloat(document.forms[0].txt_totalhours.value);
	roundtxt(document.forms[0].txt_fuellubricant);
	document.forms[0].txt_totcostperhour.value =parseFloat(document.forms[0].txt_dieseloil.value)*
												parseFloat(document.forms[0].txt_dieselamt.value);	
	roundtxt(document.forms[0].txt_totcostperhour);
	document.forms[0].txt_totcostperhour.value=NanNumber(document.forms[0].txt_totcostperhour.value);
	
	document.forms[0].txt_fuellubricant.value=NanNumber(document.forms[0].txt_fuellubricant.value);
	var lubricant_limit="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) 
																hshLimitDet.get("lubricants"))))%>";
	document.forms[0].txt_lubfuelcost.value= (lubricant_limit/100) * parseFloat(document.forms[0].txt_fuellubricant.value);
	roundtxt(document.forms[0].txt_lubfuelcost);
	document.forms[0].txt_fuelcostperannum.value= parseFloat(document.forms[0].txt_fuellubricant.value)+parseFloat(document.forms[0].txt_lubfuelcost.value);
	roundtxt(document.forms[0].txt_fuelcostperannum);
	calculateRepairandMaintenance();
}

function calculateDriverSalary()
{
	document.forms[0].txt_drivertotsal.value = parseFloat(document.forms[0].txt_driversal.value)*12;
	roundtxt(document.forms[0].txt_drivertotsal);
	document.forms[0].txt_drivertotsal.value=NanNumber(document.forms[0].txt_drivertotsal.value);
	calculateTotal();
}

function calculateOverHead()
{
	document.forms[0].txt_overHeadCostPerAnnum.value = parseFloat(document.forms[0].txt_drivertotsal.value)+
													   parseFloat(document.forms[0].txt_insurancetax.value)+
													   parseFloat(document.forms[0].txt_repairmaintain.value)+
													   parseFloat(document.forms[0].txt_otrexpen.value);

	document.forms[0].txt_overHeadCostPerAnnum.value=NanNumber(document.forms[0].txt_overHeadCostPerAnnum.value);
	roundtxt(document.forms[0].txt_overHeadCostPerAnnum);
	calculateTotal();
}
function calculateRepairandMaintenance()
{
	calculateTotal();
}

function calculateTotal()
{
	document.forms[0].txt_overheadtot.value = 	parseFloat(document.forms[0].txt_fuellubricant.value) +
											  	parseFloat(document.forms[0].txt_lubfuelcost.value)  +
												parseFloat(document.forms[0].txt_drivertotsal.value) +
												parseFloat(document.forms[0].txt_insurancetax.value)+
												parseFloat(document.forms[0].txt_repairmaintain.value)+
												parseFloat(document.forms[0].txt_otrexpen.value);
	
	document.forms[0].txt_netincome.value = parseFloat(document.forms[0].txt_totincfromcustom.value) - parseFloat(document.forms[0].txt_overheadtot.value);
	
	document.forms[0].txt_overheadtot.value=NanNumber(document.forms[0].txt_overheadtot.value);
	document.forms[0].txt_netincome.value=NanNumber(document.forms[0].txt_netincome.value);
	roundtxt(document.forms[0].txt_overheadtot);
	roundtxt(document.forms[0].txt_netincome);
	document.forms[0].txt_lessoperations.value=document.forms[0].txt_overheadtot.value;
	roundtxt(document.forms[0].txt_lessoperations);
}

function calculateTotalAcre()
{
	//var varownfar=document.forms[0].txt_owmfarm.value;
	//var varfamilyfarm=document.forms[0].txt_familyholding.value;
	//if(trim(document.forms[0].txt_owmfarm.value)=="")
	//	varownfar=0;
	//if(trim(document.forms[0].txt_familyholding.value)=="")
	//	varfamilyfarm=0;
	
	//var vartotal =parseFloat(document.forms[0].txt_owmfarm.value)+parseFloat(document.forms[0].txt_familyholding.value);
	//document.forms[0].txt_totalacre.value=vartotal;
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body onLoad="callonLoad();calculateRepairandMaintenance();calculateFuelLubricant();calculateOverHead()">
<!-- <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">
				if (document.all && window.print)
				{
					ie5menu.className = menuskin;
					document.oncontextmenu = showmenuie5;
					document.body.onclick = hidemenuie5;
				}
				</script></div>
</div>-->
<form name="frmcushire" method="post" class="normal">
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
      <td class="page_flow">Home -> Agriculture -> Income from custom Hire Service</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="61" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<jsp:include page="../share/help.jsp" flush="true" />
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0"></iframe> 
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">

	<tr>
		<td>
		<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="3" WIDTH="100%" class="outertable">
		<TR CLASS="dataheader"> 
		 <TD COLSPAN="5"  align="left">Income</TD>
		 <!--  
            <TD COLSPAN="5"  align="left">Extent of Land</TD>
          </TR>
          <tr><td COLSPAN="1"  align="left"> Extent of Land under cultivation by the party</td>
          <td COLSPAN="5" align="left"><input type="text"  name="txt_extentofland" onkeypress="allowDecimals(this)" style="text-align:right" size="8" MAXLENGTH="10"
          value="<%=Helper.correctDouble((String)hshFarmMachinery.get("agr_extentofland"))%>">
          (acres) </td>
          </tr>
          <TR CLASS="dataheader"> 
            <TD COLSPAN="5"  align="left">Total hectares to be covered </TD>
          </TR>
          <TR> 
            <TD width="48%">Own farm </TD>
            <TD width="15%"> 
              <INPUT TYPE="text"
					value="<%=Helper.correctInt((String) hshFarmMachinery.get("agr_ihs_ownfarm"))%>" style="text-align:right"
					NAME="txt_owmfarm" size="8" MAXLENGTH="10"
					onKeyPress="allowDecimals(this)" onblur="calculateTotalAcre()">
            
              (acres)</TD>
          </TR>
          <TR> 
            <TD width="48%">Family holding</TD>
            <TD width="15%"> 
              <INPUT TYPE="text"
					value="<%=Helper.correctInt((String) hshFarmMachinery.get("agr_ihs_familyfarm"))%>" style="text-align:right"
					NAME="txt_familyholding" size="8" MAXLENGTH="10"
					onKeyPress="allowDecimals(this)" onblur="calculateTotalAcre()">

              (acres)</TD>
          </TR>
          <TR> 
            <TD align="right" width="48%" ><b>Total</b></TD>
            <TD width="15%"> 
              <INPUT TYPE="text" 
					value="<%=Helper.correctNull((String) hshFarmMachinery.get("onfarm"))%>" 
					style="text-align:right"
					NAME="txt_totalacre" size="8" MAXLENGTH="10"
					onKeyPress="allowDecimals(this)" onblur="calculateTotalHours();" readOnly>
    
              (acres)</TD>
          </TR>
          -->
          <TR> 
            <TD COLSPAN="5" CLASS="dataheader" align="left">Annual Usage In Hours</TD>
          </TR>
          <TR> 
            <TD WIDTH="48%" nowrap ID="res1">1. On farm operations</TD>
            <TD ID="res2" WIDTH="15%"> 
              <INPUT TYPE="text"
					value="<%=Helper.correctNull((String) hshFarmMachinery
							.get("onfarm"))%>" style="text-align:right"
					NAME="txt_onfarm" size="8" MAXLENGTH="10"
					onKeyPress="allowDecimals(this)" onblur="calculateTotalHours();">
            </TD>
          </TR>
          <tr> 
            <Td WIDTH="48%"></td>
          </tr>
          <TR> 
            <TD WIDTH="48%">2. Off farm operations (Hiring for tillage)</TD>
            <TD VALIGN="top" WIDTH="15%"> 
              <INPUT TYPE="text"
					value="<%=Helper.correctNull((String) hshFarmMachinery
							.get("offfarm"))%>" style="text-align:right"
					NAME="txt_offfarm" size="8" MAXLENGTH="10"
					onKeyPress="allowDecimals(this)" onblur="calculateTotalHours();">
            </TD>
          </TR>
          <tr> 
            <TD WIDTH="48%">3. Hiring for transportation hours</TD>
            <TD WIDTH="15%"> 
              <INPUT TYPE="text"
					VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("hiringtrans"))%>" style="text-align:right"
					NAME="txt_hiringfortransport" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" onblur="calculateTotalHours();">
            </TD>
          </tr>
          <tr> 
            <td WIDTH="48%"><B>4.Total no. of hours used annually </B> </td>
            <td>&nbsp;</td>
            <td WIDTH="15%"> 
              <INPUT TYPE="text" 
					VALUE="<%=Helper.correctNull((String) hshFarmMachinery
							.get("totalhrs"))%>"
					NAME="txt_totalhours" SIZE="10" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)"
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;">
            </td>
          </tr>
          <tr> 
            <td WIDTH="48%">5.Charges per hour </td>
            <td WIDTH="15%"><lapschoice:CurrencyTag
					name="txt_incfromcustom" maxlength="15" size="15"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);calculateIncomeCustomService();"
					other="readOnly" /></td>
          </tr>
          <tr> 
            <td WIDTH="48%"><B>Income from customer service (4*5)</B></td>
            <td width="15%" >&nbsp;</td>
            <td width="12%" >&nbsp;</td>
            <td width="20%"  align="right"><lapschoice:CurrencyTag
					name="txt_totincfromcustom" maxlength="15"  size="15"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);" other="readOnly" /> </td>
          </tr>
          <tr> 
          <td COLSPAN="5" CLASS="dataheader"><B>Expenditure</B></td>
          </tr>
          <tr> 
          <td COLSPAN="5" CLASS="dataheader"><B>Fuel and lubricants </B></td>
          </tr>
          <tr> 
            <td width="48%"> Diesel Oil per hour </td>
            <td width="15%"> 
              <INPUT TYPE="text"
					VALUE="<%=Helper.correctNull((String) hshFarmMachinery.get("nooflitres"))%>"
					NAME="txt_dieseloil" SIZE="8" MAXLENGTH="4" style="text-align:right"
					onblur="calculateFuelLubricant();" ONKEYPRESS="allowDecimals(this)">&nbsp;Lts
            </td>
          </tr>
          <tr> 
            <td width="48%" >Cost Per litre&nbsp; &nbsp; &nbsp; </td>
            <td width="15%"> <lapschoice:CurrencyTag
					name="txt_dieselamt" maxlength="15" size="15"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);calculateFuelLubricant();" other="readOnly" />
            </td>
          </tr>
          <tr> 
            <td width="48%">Total Cost Per Hour</td>
            <td width="15%"><lapschoice:CurrencyTag
					name="txt_totcostperhour" maxlength="15"  size="15"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);calculateFuelLubricant();" other="readOnly" /></td>
          </tr>
          <tr> 
            <td nowrap width="48%" align="left"><B>Fuel Per Annum (Total hour * Cost Per hour)</B></td>
            <td WIDTH="15%">&nbsp;</td>
            <td WIDTH="12%"><lapschoice:CurrencyTag
					name="txt_fuellubricant" maxlength="15"  size="15"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);" other="readOnly" /></td>
            <td WIDTH="20%">&nbsp;</td>
            <td WIDTH="5%">&nbsp;</td>
          </tr>
          <tr> 
            <td WIDTH="48%" align="left"><B>Lubricants cost @ <%=nf.format(Double.parseDouble(Helper.correctDouble
            						((String) hshLimitDet.get("lubricants"))))%>% of fuel cost</B>
            </td>
            <td WIDTH="15%">&nbsp;</td>
            <td WIDTH="12%"><lapschoice:CurrencyTag name="txt_lubfuelcost"
					maxlength="15"  size="15"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);" other="readOnly" /></td>
            <td WIDTH="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="48%"><B>Fuel and Lubricants Cost Per Annum</B></td>
            <td colspan="2">&nbsp;</td>
            
            <td width="20%" align="right"><lapschoice:CurrencyTag
					name="txt_fuelcostperannum" maxlength="15"  size="15"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);calculateFuelLubricant();" other="readOnly" /></td>
          </tr>

          <tr class="dataheader"> 
            <td colspan="5">Overhead costs </td>           
          </tr>
          <tr> 
            <td WIDTH="48%">&nbsp;</td>
            <td WIDTH="15%" align="center">Month</td>
            <td WIDTH="12%" align="center">Year</td>
            <td WIDTH="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td WIDTH="48%">1. Driver's salary Per Month </td>
            <td WIDTH="15%"><lapschoice:CurrencyTag
					name="txt_driversal" maxlength="15" size="15"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);calculateDriverSalary();calculateTotal();calculateOverHead()" other="readOnly" /></td>
            <td WIDTH="12%"><lapschoice:CurrencyTag name="txt_drivertotsal"
					maxlength="15"  size="15"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);" other="readOnly" /></td>
            <td WIDTH="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td WIDTH="48%">2. Insurance and taxes</td>
            <td WIDTH="15%">&nbsp;</td>
            <td WIDTH="12%"><lapschoice:CurrencyTag name="txt_insurancetax"
					maxlength="15" size="15"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);calculateTotal();calculateOverHead()" other="readOnly" /></td>
            <td WIDTH="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td WIDTH="48%">3. Repairs and maintenance </td>
            <td WIDTH="15%">&nbsp;</td>
            <td WIDTH="12%"><lapschoice:CurrencyTag
					name="txt_repairmaintain" maxlength="15"  size="15"
					onKeyPress="allowDecimals(this)" style="text-align:right" 
					onBlur="roundtxt(this);calculateTotal();calculateOverHead()"/></td>
            <td WIDTH="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td WIDTH="48%">4. Other Expenses </td>
            <td WIDTH="15%">&nbsp;</td>
            <td WIDTH="12%"><lapschoice:CurrencyTag
					name="txt_otrexpen" maxlength="15"  size="15" onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);calculateTotal();calculateOverHead()"/></td>
            <td WIDTH="20%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="48%"><B>Overhead Cost Per Annum</B></td>
            <td colspan="2">&nbsp;</td>
            <td width="20%" align="right"><lapschoice:CurrencyTag
					name="txt_overHeadCostPerAnnum" maxlength="15" size="15"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);calculateFuelLubricant();" other="readOnly" /></td>
          </tr>
          <tr> 
            <td WIDTH="48%"><b>Total Operation And Maintenance Cost</b> </td>
            <td WIDTH="15%">&nbsp;</td>
            <td WIDTH="12%">&nbsp;</td>
            <td WIDTH="20%" align="right"><lapschoice:CurrencyTag name="txt_overheadtot"
					maxlength="15"  size="25"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);" other="readOnly" /></td>
          </tr>
           <tr class="dataheader"> 
            <td colspan="5">Net Income Calculation </td>           
          </tr>
         
          <tr> 
            <td width="48%">Total Income From Custom Service</td>
             <td colspan="2">&nbsp;</td>
            <td width="20%" align="right"><lapschoice:CurrencyTag
					name="txt_totincfromcustomService" maxlength="15"  size="25"
					onKeyPress="allowDecimals(this)"
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);" other="readOnly" /></td>
          </tr>
          <tr> 
            <td WIDTH="48%" nowrap><b>Less</b>: Total Operation And Maintenance Cost</td>
            <td WIDTH="15%">&nbsp;</td>
            <td WIDTH="12%">&nbsp;</td>
            <td WIDTH="20%" align="right"><lapschoice:CurrencyTag
					name="txt_lessoperations" maxlength="15" size="25"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);" other="readOnly" /></td>
          </tr>
          <tr> 
            <td HEIGHT="27" WIDTH="48%">Net income from custom service 
              <BR>
            </td>
            <td HEIGHT="27" WIDTH="15%">&nbsp;</td>
            <td HEIGHT="27" WIDTH="12%">&nbsp;</td>
            <td HEIGHT="27" WIDTH="20%" align="right"><lapschoice:CurrencyTag
					name="txt_netincome" maxlength="15"  size="25"
					onKeyPress="allowDecimals(this)" 
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onBlur="roundtxt(this);" other="readOnly" /></td>
          </tr>
        </TABLE>
		</TD>
	</TR>
</TABLE>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail"	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId"> 
<INPUT TYPE="hidden" NAME="hidfacsno" VALUE="<%=strfacsno%>">
<INPUT TYPE="hidden" NAME="hidscheme" VALUE="<%=stragrschemetype%>">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl"> 
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE=""> 
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="">
<input type="hidden" name="hidappno" value="<%=request.getParameter("appno")%>">
<INPUT TYPE="hidden" NAME="hidOtherMethod" VALUE=""> 
<input type="hidden" name="hidAppType">
</form>
</body>
</html>