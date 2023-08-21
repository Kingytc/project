<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	HashMap hshFixedCost = new HashMap();
	HashMap hshRecurringCost = new HashMap();
	ArrayList arrDFRow = new ArrayList();
	ArrayList arrDFCol = new ArrayList();

	if (hshValues != null) {
		hshFixedCost = (HashMap) hshValues.get("hshFixedCost");
		hshRecurringCost = (HashMap) hshValues.get("hshRecurringCost");
		arrDFRow = (ArrayList) hshValues.get("arrRow"); 

	}
	String strMargin = Helper.correctNull((String) hshValues
			.get("strMargin"));
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String strschemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(strschemetype. trim().equalsIgnoreCase(""))
	{
		strschemetype="0";
	}
	

	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
	
%>
<html>
<head>
<title>Agriculture - SHEEP REARING</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
var vardf = "<%=Helper.correctNull((String)hshFixedCost.get("agr_fxd_df"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
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
function callonLoad()
{
	calculateUnitCost();
	calculateMargin();

/*	if(vardf=="")
		document.forms[0].sel_df.value="s";
	else
		document.forms[0].sel_df.value=vardf; */
	
	disabledFields(true);
		if(appstatus=="Open/Pending")
		{
			if(document.forms[0].btnenable.value.toUpperCase()=="Y")
			{
	           enableButtons(false, true, true, true,false);
			}
			else
			{
				enableButtons(true, true, true, true,false);
			}
		}
		else
		{
			enableButtons(true, true, true, true,false);
		}
			
	
	
	 document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value="<%=strschemetype%>";

	document.all.id_margin.style.visibility="hidden";
	document.all.id_margin.style.position="absolute";

	// Hide by vinoth kumar on 30 MARCH 2014
	document.all.HideFixedCostDetails.style.visibility="hidden";
	document.all.HideFixedCostDetails.style.position="absolute";
	document.all.HideTotalUnitCostDetails.style.visibility="hidden";
	document.all.HideTotalUnitCostDetails.style.position="absolute";	
}

function enableButtons(bool1, bool2, bool3, bool4,  bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	
	document.forms[0].cmdclose.disabled=bool6;
}
function calcostofvet()
{
	document.forms[0].txt_costofvetenary.value=parseFloat(document.forms[0].txt_noofanimal.value)*
	parseFloat(document.forms[0].txt_costofvetenaryperanimal.value);
}

//function calinsprem()
//{
	//document.forms[0].txt_costofinsurance.value=parseFloat(document.forms[0].txt_insurpremiumpercanim.value)+
	//parseFloat(document.forms[0].txt_insurperccostofshed.value);
//}
function calinsprem()
{
	var valanimalcost=document.forms[0].txt_costofeweram.value;
	var valshedcost=document.forms[0].txt_costofsheds.value;
	var valaniper=document.forms[0].txt_insurpremiumpercanim.value;
	var valshedper=document.forms[0].txt_insurperccostofshed.value;
	document.forms[0].txt_costofinsurance.value=(((parseFloat(valaniper)/100)*valanimalcost)+((parseFloat(valshedper)/100)*valshedcost))
	
}
function doEdit()
{
	
	document.forms[0].hidAction.value="insert";
	disabledFields(false);
	enableButtons(true, false, false, false, false);
	document.forms[0].txt_costofconsofshed.readOnly=true;
	document.forms[0].txt_costofoficecons.readOnly=true;
	document.forms[0].txt_costofequipment.readOnly=true;
	document.forms[0].txt_totala.readOnly=true;
	document.forms[0].txt_costofeweram.readOnly=true;
	document.forms[0].txt_costofcultivation.readOnly=true;
	document.forms[0].txt_totalquantitykg.readOnly=false;
	document.forms[0].txt_cstfeed.readOnly=true;
	document.forms[0].txt_costofwage.readOnly=true;
	document.forms[0].txt_electricityperyear.readOnly=true;
	document.forms[0].txt_totalb.readOnly=true;
	document.forms[0].txt_totalunitcost.readOnly=true; 
	document.forms[0].txt_margin.readOnly=true;
	document.forms[0].txt_costofinsurance.readOnly=true;
    
}



function doSave()
{
	//document.forms[0].txt_dieselhrsusage.readOnly=false;
	enableButtons(true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrnursery";
	document.forms[0].hidBeanMethod.value="updateSheepRearingCostOfProject";
	document.forms[0].hidBeanGetMethod.value="getSheepRearingCostOfProject";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_sheeprearcostofproj.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
	
}

function doDelete()
{
	
	if(ConfirmMsg(101))
	 {
		
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="agrnursery"
		document.forms[0].hidBeanMethod.value="updateSheepRearingCostOfProject";
		document.forms[0].hidBeanGetMethod.value="getSheepRearingCostOfProject";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agr_sheeprearcostofproj.jsp";
		document.forms[0].submit();
	 }
	
}
function calculateTotal()
{
	document.forms[0].txt_totalcost.value=parseFloat(document.forms[0].txt_costoftrailer.value)+
										  parseFloat(document.forms[0].txt_costoftractor.value)+
										  parseFloat(document.forms[0].txt_costofimplements.value);
	roundtxt(document.forms[0].txt_totalcost);
}
function doCancel()
{
	
	if(ConfirmMsg(102))
	 {
		//document.forms[0].txt_dieselhrsusage.readOnly=false;
	    document.forms[0].hidBeanId.value="agrnursery"
		document.forms[0].hidBeanGetMethod.value="getSheepRearingCostOfProject";
	    document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_sheeprearcostofproj.jsp";
		document.forms[0].hidSourceUrl.value="/action/agr_sheeprearcostofproj.jsp";
		document.forms[0].method="post";	
		document.forms[0].submit();
	 }
	
	
}
function calculateFixedCostofShed()
{
	document.forms[0].txt_costofconsofshed.value = parseFloat(document.forms[0].txt_noofanimal.value)*
										     parseFloat(document.forms[0].txt_sqftperanimal.value)*
											 parseFloat(document.forms[0].txt_shedamtpersqft.value);
	document.forms[0].txt_costofconsofshed.value=NanNumber(document.forms[0].txt_costofconsofshed.value);
	roundtxt(document.forms[0].txt_costofconsofshed);
	
	calculateFixedCostTotalA();
	
}

function calculateFixedCostConsofOffice()
{
	document.forms[0].txt_costofoficecons.value = parseFloat(document.forms[0].txt_areaofsqft.value)*
										     parseFloat(document.forms[0].txt_roomamtpersqft.value);
	document.forms[0].txt_costofoficecons.value=NanNumber(document.forms[0].txt_costofoficecons.value);
	roundtxt(document.forms[0].txt_costofoficecons);


	document.forms[0].txt_costoffeedcons.value = parseFloat(document.forms[0].txt_feedareaofsqft.value)*
    parseFloat(document.forms[0].txt_feedamtpersqft.value);
	document.forms[0].txt_costoffeedcons.value=NanNumber(document.forms[0].txt_costoffeedcons.value);
	roundtxt(document.forms[0].txt_costoffeedcons);


	document.forms[0].txt_costoflabourcons.value = parseFloat(document.forms[0].txt_areaoflaboursqft.value)*
	parseFloat(document.forms[0].txt_labouramtpersqft.value);
	document.forms[0].txt_costoflabourcons.value=NanNumber(document.forms[0].txt_costoflabourcons.value);
	roundtxt(document.forms[0].txt_costoflabourcons);
	
	calculateFixedCostTotalA();
	
}

function calculateFixedCostEquipment()
{
	document.forms[0].txt_costofequipment.value = parseFloat(document.forms[0].txt_equipcostperanimal.value)*
										     parseFloat(document.forms[0].txt_noofanimalforequip.value);
	document.forms[0].txt_costofequipment.value=NanNumber(document.forms[0].txt_costofequipment.value);
	roundtxt(document.forms[0].txt_costofequipment);
	
	calculateFixedCostTotalA();
	
}


function calcosfen()
{
	document.forms[0].txt_costoffencing.value=parseFloat(document.forms[0].txt_fencingcost.value)*
    									parseFloat(document.forms[0].txt_fenper.value);
}
function calculateFixedCostTotalA()
{
	document.forms[0].txt_totala.value = parseFloat(document.forms[0].txt_costofconsofshed.value)+
										     parseFloat(document.forms[0].txt_costofoficecons.value)+
										     parseFloat(document.forms[0].txt_costoffencing.value)+
										     parseFloat(document.forms[0].txt_costofequipment.value)+
										     parseFloat(document.forms[0].txt_costofwatersource.value)+
										     parseFloat(document.forms[0].txt_othercost.value);
	document.forms[0].txt_totala.value=NanNumber(document.forms[0].txt_totala.value);
	roundtxt(document.forms[0].txt_totala);
	calculateUnitCost();
	
}
function calculateRecurringCostofEweslamb()
{
	document.forms[0].txt_costofeweram.value = (parseFloat(document.forms[0].txt_noofadults.value)*
												parseFloat(document.forms[0].txt_costofewes.value))+
										     (parseFloat(document.forms[0].txt_nooframs.value)*
											 parseFloat(document.forms[0].txt_costofram.value));
	document.forms[0].txt_costofeweram.value=NanNumber(document.forms[0].txt_costofeweram.value);
	roundtxt(document.forms[0].txt_costofeweram);
	
	calculateRecurringCostTotalB();
	
}
function calculateRecurringCostofCult()
{
	document.forms[0].txt_costofcultivation.value = parseFloat(document.forms[0].txt_cultivationacre.value)*
										     			parseFloat(document.forms[0].txt_cultivationcstperacre.value);
	document.forms[0].txt_costofcultivation.value=NanNumber(document.forms[0].txt_costofcultivation.value);
	roundtxt(document.forms[0].txt_costofcultivation);
	
	calculateRecurringCostTotalB();
	
}

function calculateRecurringCostFeed()
{
	
	var varAdults=(parseFloat(document.forms[0].txt_feedconcentrateadultkg.value) *
			parseFloat(document.forms[0].txt_feednoofadults.value)*
			parseFloat(document.forms[0].txt_totalquantitykg.value));
	var varYoung=(parseFloat(document.forms[0].txt_feednooflambs.value) *
			parseFloat(document.forms[0].txt_feedconcentratelamb.value)*
			parseFloat(document.forms[0].txt_amtoffeedperkg.value));
	
	/*document.forms[0].txt_cstfeed.value = (parseFloat(document.forms[0].txt_feedconcentrateadultkg.value) *
													parseFloat(document.forms[0].txt_feednoofadults.value)*
													parseFloat(document.forms[0].txt_totalquantitykg.value))+
										  (parseFloat(document.forms[0].txt_feednooflambs.value) *
															parseFloat(document.forms[0].txt_feedconcentratelamb.value)*
															parseFloat(document.forms[0].txt_amtoffeedperkg.value));
	document.forms[0].txt_cstfeed.value=NanNumber(document.forms[0].txt_cstfeed.value);*/
	document.forms[0].txt_cstfeed.value=NanNumber(varAdults)+NanNumber(varYoung);
	document.forms[0].txt_cstfeed.value=NanNumber(document.forms[0].txt_cstfeed.value);
	roundtxt(document.forms[0].txt_cstfeed);


		

	
	//document.forms[0].txt_costoffeed.value=parseFloat(document.forms[0].txt_totalquantitykg.value) *
	//									parseFloat(document.forms[0].txt_amtoffeedperkg.value);
	//document.forms[0].txt_costoffeed.value=NanNumber(document.forms[0].txt_costoffeed.value);
	//roundtxt(document.forms[0].txt_costoffeed);

	calculateRecurringCostTotalB();
	
}

function calculateRecurringCostWages()
{
	document.forms[0].txt_costofwage.value = parseFloat(document.forms[0].txt_nooflabours.value)*
    											parseFloat(document.forms[0].txt_amtperlabour.value);
	roundtxt(document.forms[0].txt_costofwage);
	document.forms[0].txt_costofwage.value=NanNumber(document.forms[0].txt_costofwage.value);
	calculateRecurringCostTotalB();
}

function calculateRecurringCostElectricity()
{
	document.forms[0].txt_electricityperyear.value = parseFloat(document.forms[0].txt_electricitypermonth.value)*
    											12;
	roundtxt(document.forms[0].txt_electricityperyear);
	document.forms[0].txt_electricityperyear.value=NanNumber(document.forms[0].txt_electricityperyear.value);
	calculateRecurringCostTotalB();
}



function calculateRecurringCostTotalB()
{
	document.forms[0].txt_totalb.value = parseFloat(document.forms[0].txt_costofeweram.value)+
										    parseFloat(document.forms[0].txt_costofcultivation.value)+
										    parseFloat(document.forms[0].txt_cstfeed.value)+
										    parseFloat(document.forms[0].txt_costofwage.value)+
										    parseFloat(document.forms[0].txt_costofvetenary.value)+
										    parseFloat(document.forms[0].txt_costofinsurance.value)+
										    parseFloat(document.forms[0].txt_electricityperyear.value)+
										    parseFloat(document.forms[0].txt_costofsheds.value) ;
	document.forms[0].txt_totalb.value=NanNumber(document.forms[0].txt_totalb.value);
	roundtxt(document.forms[0].txt_totalb);
	calculateUnitCost();

}

function calculateUnitCost()
{

	document.forms[0].txt_totalunitcost.value  =parseFloat(document.forms[0].txt_totala.value)+
												parseFloat(document.forms[0].txt_totalb.value);
	document.forms[0].txt_totalunitcost.value=NanNumber(document.forms[0].txt_totalunitcost.value);
	roundtxt(document.forms[0].txt_totalunitcost);
	calculateMargin();
}

function calculateMargin()
{
	document.forms[0].txt_margin.value = parseFloat(document.forms[0].txt_totalunitcost.value) * ('<%=strMargin%>')/100;

	document.forms[0].txt_margin.value=NanNumber(document.forms[0].txt_margin.value);
	roundtxt(document.forms[0].txt_margin);
}
function callLink(page,bean,method)
{	
	if (document.forms[0].cmdApply.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
}
function  callLink1(page)
{
	if (document.forms[0].cmdApply.disabled)
	{
		 document.forms[0].hidBeanGetMethod.value="getAgencyDetails";
		 document.forms[0].hidBeanId.value="agrlandholdings";
	 	document.forms[0].action=appURL+"action/"+page;
		 document.forms[0].submit();
	}
	 else
		{
			ShowAlert(103);
		}
}
</script>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callonLoad();">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
	<tr>
	<td class="page_flow">Home -> Agriculture -> Cost of Project </td>
	
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="122" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>

<br>

<table width="80%" border="0" cellpadding="5" cellspacing="0"
	align="center" class="outertable border1">
	<tr>
		<td>
		<TABLE BORDER="0" CELLSPACING="1" CELLPADDING="3" WIDTH="100%" class="outertable">
		<TR id="HideFixedCostDetails">
		<TD COLSPAN="4">
		    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="3" WIDTH="100%" class="outertable">
			<TR>
				<TD COLSPAN="4" CLASS="dataheader" align="left"><B>A.
				Fixed Cost</B></TD>
			</TR>
			<tr>
				<td colspan="4"><b>1.Cost of Construction of shed</b></td>	  
			</tr>
			<TR>
				
				<TD  nowrap ID="res1">
				&nbsp;&nbsp;&nbsp;&nbsp;No. of Animals <INPUT TYPE="text" TABINDEX="1"
					VALUE="<%=Helper.correctNull((String) hshFixedCost
							.get("agr_fxd_noofanimals"))%>"
					NAME="txt_noofanimal" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowInteger(this)" style="text-align: right"
					onblur="calculateFixedCostofShed();calcostofvet();"> at <INPUT
					TYPE="text" TABINDEX="1"
					VALUE="<%=Helper.correctNull((String) hshFixedCost
							.get("agr_fxd_sqftperanimal"))%>"
					NAME="txt_sqftperanimal" SIZE="8" MAXLENGTH="10"
					style="text-align: right" ONKEYPRESS="allowInteger(this)"
					onblur="calculateFixedCostofShed()">sft. Per animal @ Rs. <INPUT
					TYPE="text" TABINDEX="1"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_cstofconspersqft"))))%>"
					NAME="txt_shedamtpersqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostofShed()"> per sft<BR>
				&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD ID="res2" >&nbsp;</TD>
				<TD ID="res2" ><INPUT TYPE="text"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_costofconstruction"))))%>"
					NAME="txt_costofconsofshed" size="15" MAXLENGTH="10"
					style="text-align: right" onKeyPress="allowDecimals(this)"
					onblur="roundtxt(this);"></TD>
				<TD ID="res2" >&nbsp;</TD>
			</TR>
			<tr>
				<Td ></td>
				<Td></td>
			</tr>
			<tr>
				<td colspan="4"><b>2.Cost of Construction of office room</b></td>	  
			</tr>
			<TR>
			
				<TD >&nbsp;&nbsp;&nbsp;&nbsp;Total area of <INPUT TYPE="text"
					TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_officesqft"))))%>"
					NAME="txt_areaofsqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostConsofOffice()">
				sft @ Rs. <INPUT TYPE="text" TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_offconsamtpersqft"))))%>"
					NAME="txt_roomamtpersqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostConsofOffice()">per
				sft. If required :</TD>
				<TD VALIGN="top" >&nbsp;</TD>
				<TD VALIGN="top" ><INPUT TYPE="text"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_costofconsoff"))))%>"
					NAME="txt_costofoficecons" size="15" MAXLENGTH="10"
					style="text-align: right" onKeyPress="allowDecimals(this)"
					onblur="roundtxt(this);"></TD>
					<TD>&nbsp;</TD>
			</TR>
			
			<!-- Added by Arsath on 06/03/2014 as per the new requirements -->
			
			<tr>
				<td colspan="4"><b>3.Cost of Construction of  feed storage room</b></td>	  
			</tr>
			<TR>
			
				<TD >&nbsp;&nbsp;&nbsp;&nbsp;Total area of <INPUT TYPE="text"
					TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_feedstosqft"))))%>"
					NAME="txt_feedareaofsqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostConsofOffice()">
				sft @ Rs. <INPUT TYPE="text" TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_feedconsamtpersqft"))))%>"
					NAME="txt_feedamtpersqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostConsofOffice()">per
				sft. If required :</TD>
				<TD VALIGN="top" >&nbsp;</TD>
				<TD VALIGN="top" ><INPUT TYPE="text"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_costofconsfeed"))))%>"
					NAME="txt_costoffeedcons" size="15" MAXLENGTH="10"
					style="text-align: right" onKeyPress="allowDecimals(this)"
					onblur="roundtxt(this);"></TD>
					<TD>&nbsp;</TD>
			</TR>
			
			<tr>
				<td colspan="4"><b>4.Cost of Construction of labour quarters</b></td>	  
			</tr>
			<TR>
			
				<TD >&nbsp;&nbsp;&nbsp;&nbsp;Total area of <INPUT TYPE="text"
					TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_laboursqft"))))%>"
					NAME="txt_areaoflaboursqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostConsofOffice()">
				sft @ Rs. <INPUT TYPE="text" TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_labconsamtpersqft"))))%>"
					NAME="txt_labouramtpersqft" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostConsofOffice()">per
				sft. If required :</TD>
				<TD VALIGN="top" >&nbsp;</TD>
				<TD VALIGN="top" ><INPUT TYPE="text"
					value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_costofconslab"))))%>"
					NAME="txt_costoflabourcons" size="15" MAXLENGTH="10"
					style="text-align: right" onKeyPress="allowDecimals(this)"
					onblur="roundtxt(this);"></TD>
					<TD>&nbsp;</TD>
			</TR>
			
			<!-- End -->
			
			
			<tr>
				<td colspan="4"><b>5.Cost of fencing</b></td>	  
			</tr>
			<tr>
				
				<TD >&nbsp;&nbsp;&nbsp;&nbsp;Total Perimeter <INPUT TYPE="text" TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_cstoffencpersqft"))))%>"
					NAME="txt_fencingcost" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur=" roundtxt(this); calculateFixedCostTotalA();calcosfen();"> @ Rs.<INPUT TYPE="text" TABINDEX="2"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("AGR_FXD_FENPER"))))%>"
					NAME="txt_fenper" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur=" roundtxt(this); calculateFixedCostTotalA();calcosfen();">&nbsp;per meter</TD>
				<TD >&nbsp;</TD>
				<TD ><INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_costoffencing"))))%>"
					NAME="txt_costoffencing" SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this); calculateFixedCostTotalA();calcosfen();"></TD>
				<TD>&nbsp;</TD>
			</tr>
			<tr>
				<td colspan="4"><b>6.cost of equipments</b></td>	  
			</tr>
			<tr>
				
				<td >&nbsp;&nbsp;&nbsp;&nbsp;Cost per animal <INPUT TYPE="text"
					TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_equicstperanim"))))%>"
					NAME="txt_equipcostperanimal" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostEquipment()">&nbsp;
				No. of animals <INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_noofanimequip"))))%>"
					NAME="txt_noofanimalforequip" SIZE="8" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					ONBLUR="roundtxt(this);calculateFixedCostEquipment()"></td>
				<td ></td>
				<td ><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_totequipcost"))))%>"
					NAME="txt_costofequipment" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"></td>
				<TD>&nbsp;</TD>
			</tr>
			
			<tr>
				<td ><b>5.Cost of water source, bore well, pump set,
				pipelines etc., ( if required )</b></td>
				<td ></td>
				<td ><INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_costofwater"))))%>"
					NAME="txt_costofwatersource" SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostTotalA();"></td>
				<TD>&nbsp;</TD>
			</tr>
			<tr>
				
				<td ><b>7.Others, if any</b></td>
				<td ></td>
				<td ><INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_othercost"))))%>"
					NAME="txt_othercost" SIZE="15" MAXLENGTH="10"
					ONKEYPRESS="allowDecimals(this)" style="text-align: right"
					onblur="roundtxt(this);calculateFixedCostTotalA();"></td>
				<TD>&nbsp;</TD>
			</tr>
			<tr>
				<td ><b>Total</b></td>
				<td >&nbsp;</td>
				<td >&nbsp;</td>
				<td ><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshFixedCost
									.get("agr_fxd_total"))))%>"
					NAME="txt_totala" SIZE="15" MAXLENGTH="10"
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onblur="roundtxt(this);" ONKEYPRESS="allowDecimals(this)">
				<B>(A)</B></td>
			</tr>
			</table>
			</TD>
			</TR>			
			<tr>
				<TD COLSPAN="4" CLASS="dataheader" align="left"><B>B.
				Recurring Expenditure</B></TD>
			</tr>
			<tr>
				<td colspan="4"><b>1.Cost of Animals</b></td>	 
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;No of adult males&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=Helper.correctNull((String) hshRecurringCost
							.get("agr_rec_noofadult"))%>"
					NAME="txt_noofadults" SIZE="8" MAXLENGTH="10"
					onblur="calculateRecurringCostofEweslamb();"
					style="text-align: right" ONKEYPRESS="allowInteger(this)">&nbsp;&nbsp;&nbsp;&nbsp;
					Amount&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_costofperewe"))))%>"
					NAME="txt_costofewes" SIZE="8" MAXLENGTH="10"
					onblur="roundtxt(this);calculateRecurringCostofEweslamb();"
					style="text-align: right" ONKEYPRESS="allowDecimals(this)">&nbsp;per male</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;No. of adult females&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=Helper.correctNull((String) hshRecurringCost
							.get("agr_rec_noofram"))%>"
					NAME="txt_nooframs" SIZE="8" MAXLENGTH="10"
					onblur="calculateRecurringCostofEweslamb();"
					style="text-align: right" ONKEYPRESS="allowInteger(this)">&nbsp;&nbsp;&nbsp;&nbsp;
					Amount&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_costofperram"))))%>"
					NAME="txt_costofram" SIZE="8" MAXLENGTH="10"
					onblur="roundtxt(this);calculateRecurringCostofEweslamb();"
					style="text-align: right" ONKEYPRESS="allowDecimals(this)">&nbsp;per female
				</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;Total Cost of animal</td>
				<td>&nbsp;</td>
				<td><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totcosteweram"))))%>"
					NAME="txt_costofeweram" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="4"><b>2.Cost of cultivation of fodder crops</b></td>	 
			</tr>
			<TR>
				 
				<TD >&nbsp;&nbsp;&nbsp;&nbsp;No.of acres&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<INPUT
					TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_areaofcultivation"))))%>"
					NAME="txt_cultivationacre" SIZE="8" MAXLENGTH="10"
					onblur="roundtxt(this);calculateRecurringCostofCult();"
					style="text-align: right" ONKEYPRESS="allowDecimals(this)">&nbsp;&nbsp;&nbsp;&nbsp;
				Amount&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_costofcultperacre"))))%>"
					NAME="txt_cultivationcstperacre" SIZE="8" MAXLENGTH="10"
					onblur="roundtxt(this);calculateRecurringCostofCult();"
					style="text-align: right" ONKEYPRESS="allowDecimals(this)"> per acre per annum
				</TD>
				<TD >&nbsp;</TD>
				<TD ><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_costofcult"))))%>"
					NAME="txt_costofcultivation" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"></TD>
					<TD >&nbsp;</TD>
			</TR>
			<tr>
				<td colspan="4"><b>3.Cost of feed</b></td>	 
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;No. of adults &nbsp;<INPUT TYPE="text"
					TABINDEX="3"
					VALUE="<%=Helper.correctNull((String) hshRecurringCost
							.get("agr_rec_noofadtforfed"))%>"
					NAME="txt_feednoofadults" SIZE="8" MAXLENGTH="10"
					onblur="calculateRecurringCostFeed();" style="text-align: right"
					ONKEYPRESS="allowInteger(this)"> @
				<INPUT TYPE="text"
					TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_feedconcadtperday"))))%>"
					NAME="txt_feedconcentrateadultkg" SIZE="8" MAXLENGTH="10"
					onblur="roundtxt(this);calculateRecurringCostFeed();"
					style="text-align: right" ONKEYPRESS="allowDecimals(this)">&nbsp;Kg per day per adult&nbsp;
				@<INPUT
					TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totfeedkg"))))%>"
					NAME="txt_totalquantitykg" SIZE="8" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);calculateRecurringCostFeed();" 
					ONKEYPRESS="allowDecimals(this)">rs. Per kg.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										
					
				<TD >&nbsp;</TD>
				<TD ><input type="text" name="txt_cstfeed" style="text-align: right" value="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totcost"))))%>" size="15" onBlur=""></TD>
				<TD >&nbsp;</TD>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;No. of young ones&nbsp;&nbsp;<INPUT
					TYPE="text" TABINDEX="3" style="text-align: right"
					VALUE="<%=Helper.correctNull((String) hshRecurringCost
							.get("agr_rec_nooflamforfed"))%>"
					NAME="txt_feednooflambs" SIZE="8" MAXLENGTH="10"
					onblur="calculateRecurringCostFeed();"
					ONKEYPRESS="allowInteger(this)"> @
				<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_feedconclambperday"))))%>"
					NAME="txt_feedconcentratelamb" SIZE="8" MAXLENGTH="10"
					onblur="roundtxt(this);calculateRecurringCostFeed();"
					style="text-align: right" ONKEYPRESS="allowDecimals(this)">&nbsp;Kg per day per young one
					@&nbsp;<INPUT
					TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_feedamtperkg"))))%>"
					NAME="txt_amtoffeedperkg" SIZE="8" MAXLENGTH="10"
					style="text-align: right"
					onblur="roundtxt(this);calculateRecurringCostFeed();"
					ONKEYPRESS="allowDecimals(this)">rs. Per kg&nbsp;.
					
				<TD >&nbsp;</TD>
				<TD >&nbsp;</TD>
				<TD >&nbsp;</TD>
			</tr>
		<!-- <tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;Total quantity&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<INPUT
					TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totfeedkg"))))%>"
					NAME="txt_totalquantitykg" SIZE="8" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)">Kg.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					Amount&nbsp;<INPUT
					TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_feedamtperkg"))))%>"
					NAME="txt_amtoffeedperkg" SIZE="8" MAXLENGTH="10"
					style="text-align: right"
					onblur="roundtxt(this);calculateRecurringCostFeed();"
					ONKEYPRESS="allowDecimals(this)">&nbsp;per kg.
					</td>
					<TD >&nbsp;</TD>
				<td><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totfeedamt"))))%>"
					NAME="txt_costoffeed" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"></td>
					<TD >&nbsp;</TD>
				
			</tr>-->
			<tr>
				<td colspan="4"><b>4.Wages for Labourers</b></td>	 
			</tr>
			<TR>
				
				<TD >&nbsp;&nbsp;&nbsp;&nbsp;No. of Labours &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=Helper.correctNull((String) hshRecurringCost
							.get("agr_rec_nooflabours"))%>"
					NAME="txt_nooflabours" SIZE="8" MAXLENGTH="10"
					onblur="roundtxt(this);calculateRecurringCostWages();"
					style="text-align: right" ONKEYPRESS="allowDecimals(this)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;
				Cost per labour&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_wageperannum"))))%>"
					NAME="txt_amtperlabour" SIZE="8" MAXLENGTH="10"
					style="text-align: right"
					onblur="roundtxt(this);calculateRecurringCostWages();"
					ONKEYPRESS="allowDecimals(this)"> per annum </TD>
				<TD ></TD>
				<TD ><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totwage"))))%>"
					NAME="txt_costofwage" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"></TD>
					<TD >&nbsp;</TD>
			</TR>
			<TR>
				<TD ><b>5.Cost of veterinary aid, medicines, vaccines
				etc., @ Rs.<!--<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_vetcostperanim"))))%>"
					NAME="txt_costofvetenaryperanimal" SIZE="8" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this)"
					ONKEYPRESS="allowDecimals(this)"> per animal (including
				lambs)--></b></TD>
				<TD ></TD>
				<TD ><INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totvetcost"))))%>"
					NAME="txt_costofvetenary" SIZE="15" MAXLENGTH="10"
					style="text-align: right"
					onblur="roundtxt(this);calculateRecurringCostTotalB()"
					ONKEYPRESS="allowDecimals(this)"></TD>
				<TD >&nbsp;</TD>
			</TR>
			<TR>
				<TD ><b>6.Cost of sheds,
				equipment etc., @ Rs.</b></TD>
				<TD ></TD>
				<TD ><INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_costofshed"))))%>"
					NAME="txt_costofsheds" SIZE="15" MAXLENGTH="10"
					style="text-align: right"
					onblur="roundtxt(this);calculateRecurringCostTotalB();"
					ONKEYPRESS="allowDecimals(this)"></TD>
				<TD >&nbsp;</TD>
			</TR>
			<tr> 
				<td colspan="4"><b>7.Insurance premium</b></td>	 
			</tr>
			<TR> 
			
				<TD >&nbsp;&nbsp;&nbsp;&nbsp;Insurance premium @ <INPUT TYPE="text"
					TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_insperccstofanim"))))%>"
					NAME="txt_insurpremiumpercanim" SIZE="8" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);calinsprem();"
					ONKEYPRESS="allowDecimals(this)"> % of cost of animals and
				@&nbsp;&nbsp;<INPUT TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_insurpercstofshed"))))%>"
					NAME="txt_insurperccostofshed" SIZE="8" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);calinsprem();"
					ONKEYPRESS="allowDecimals(this)"> % of cost of sheds,
				equipment etc.,</TD>
				<TD ></TD>
				<TD ><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totinsuramt"))))%>"
					NAME="txt_costofinsurance" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);calinsprem();"
					ONKEYPRESS="allowDecimals(this)"></TD>
				<TD >&nbsp;</TD>
			</TR>
			<TR>
				<TD ><b>8.Electricity and miscellaneous charges @ Rs. <INPUT
					TYPE="text" TABINDEX="3"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_elecpermonth"))))%>"
					NAME="txt_electricitypermonth" SIZE="8" MAXLENGTH="10"
					style="text-align: right"
					onblur="roundtxt(this);calculateRecurringCostElectricity()"
					ONKEYPRESS="allowDecimals(this)"> per month for 12 months</b></TD>
				<TD ></TD>
				<TD ><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshRecurringCost.get("agr_rec_elecperyear"))))%>"
					NAME="txt_electricityperyear" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"></TD>
					<TD >&nbsp;</TD>
			</TR>
			<TR>
				
				<TD >&nbsp;</TD>				
				<TD align="right"><b>Total :</b>&nbsp;&nbsp;&nbsp;&nbsp;</TD>
				<TD ><INPUT TYPE="text"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_totalb"))))%>"
					 NAME="txt_totalb" SIZE="15" MAXLENGTH="10"
					 style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					onblur="roundtxt(this);" ONKEYPRESS="allowDecimals(this)">
				</TD>
			</TR>
			<TR id="HideTotalUnitCostDetails">
		    <TD COLSPAN="4">
		    <TABLE BORDER="0" CELLSPACING="1" CELLPADDING="3" WIDTH="100%" class="outertable">
			<tr>
				<TD COLSPAN="4" CLASS="dataheader" align="left"><B>
				Total Unit Cost Calculations</B></TD>
			</tr>
			<TR>
				<TD ><b>Total Unit Cost </b><B>(A + B)</B></TD>
				<TD >&nbsp;</TD>
				<TD >&nbsp;</TD>
				<TD ><INPUT TYPE="text" VALUE=""
					NAME="txt_totalunitcost" SIZE="15" MAXLENGTH="10"
					onblur="roundtxt(this);"
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;"
					ONKEYPRESS="allowDecimals(this)"> </TD>
			</TR>
			</TABLE>
			</TD>
			</TR>
			<TR id="id_margin">
				
				<TD ><b>Applicants Margin&nbsp;(<%=Helper.correctNull(strMargin)%> % of the unit cost)</b></TD>
				<TD >&nbsp;</TD>
				<TD >&nbsp;</TD>
				
				<TD><INPUT TYPE="text" VALUE="" NAME="txt_margin"
					SIZE="15" MAXLENGTH="10" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"
					style="text-align: right;background-color:#EEF2F9;border-style:none; color:#000000;font-weight:bold;">
					
				</TD>
			</TR>
		<!--  	<TR>
				
				<TD >Bank Loan</TD>
				<TD >&nbsp;</TD>
				<TD >&nbsp;</TD>
				<TD align="right"><INPUT TYPE="text" TABINDEX="4"
					VALUE="<%=nf.format(Double.parseDouble(Helper
							.correctDouble((String) hshRecurringCost
									.get("agr_rec_bankloan"))))%>"
					NAME="txt_bankloan" SIZE="15" MAXLENGTH="10"
					style="text-align: right" onblur="roundtxt(this);"
					ONKEYPRESS="allowDecimals(this)"></TD>
			</TR>
	    	<TR>
				
				<TD >DF at</TD>
				<TD >&nbsp;</TD>
				<TD >&nbsp;</TD>
				<TD align="right">
						<select name="sel_df" TABINDEX="4">
							<option value="s">--Select--</option>
							<%
								if(arrDFRow!=null && arrDFRow.size()>0)
								{
									for(int i=0;i<arrDFRow.size();i++)
									{
										arrDFCol = (ArrayList)arrDFRow.get(i);
										out.print("<option value="+arrDFCol.get(1));
										out.print(">"+arrDFCol.get(1)+"</option>");
									}
								}
							%>
						</select>
				</TD>
			</TR>-->
			
		</TABLE>
		</TD>
	</TR>
</TABLE>
<br>
<%String strappno = request.getParameter("appno");%> 
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
 <input type="hidden" name="hidAction"> <input
	type="hidden" name="hidBeanId"> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanGetMethod" value=""> <input type="hidden"
	name="hidSourceUrl"> <INPUT TYPE="hidden" NAME="hidPageSource"
	VALUE=""> <INPUT TYPE="hidden" NAME="hidMethod" VALUE="">
<input type="hidden" name="hidappno"
	value="<%=request.getParameter("appno")%>"> <INPUT
	TYPE="hidden" NAME="hidOtherMethod" VALUE=""> <input
	type="hidden" name="hidAppType"></form>
</body>
</html>