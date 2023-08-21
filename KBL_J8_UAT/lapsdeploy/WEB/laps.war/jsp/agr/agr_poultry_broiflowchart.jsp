<%@include file="../share/directives.jsp"%>


<%
	ArrayList arrSal = (ArrayList) hshValues.get("arrSal");
	ArrayList arrChicks = (ArrayList) hshValues.get("arrChicks");
	ArrayList arrFeedCost = (ArrayList) hshValues.get("arrFeedCost");
	ArrayList arrWaterCharge = (ArrayList) hshValues
			.get("arrWaterCharge");
	ArrayList arrElectric = (ArrayList) hshValues.get("arrElectric");
	ArrayList arrVetri = (ArrayList) hshValues.get("arrVetri");
	ArrayList arrInsPre = (ArrayList) hshValues.get("arrInsPre");
	ArrayList arrTransport = (ArrayList) hshValues.get("arrTransport");
	ArrayList arrTotalExpenses = (ArrayList) hshValues
			.get("arrTotalExpenses");
	ArrayList arrNonRecuExpe = (ArrayList) hshValues
	.get("arrNonRecuExpe");

	// String thirdYear=null;
	ArrayList arryCol = new ArrayList();
	ArrayList arryRow = new ArrayList();
	arryRow = (ArrayList) hshValues.get("arryRow");
	ArrayList arryCol1 = new ArrayList();
	ArrayList arryCol2 = new ArrayList();
	ArrayList arryRow1 = new ArrayList();
	arryRow1 = (ArrayList) hshValues.get("arryRow1");
	ArrayList arryRow2 = new ArrayList();
	arryRow2 = (ArrayList) hshValues.get("arryRow2");
	ArrayList arryRow4 = new ArrayList();
	arryRow4 = (ArrayList) hshValues.get("arryRow4");
	ArrayList arryRow5 = new ArrayList();
	//ArrayList arryCol5 = new ArrayList();
	arryRow5 = (ArrayList) hshValues.get("arryRow5");

	if (arryRow == null) {
		arryRow = new ArrayList();
	}
	if (arryRow1 == null) {
		arryRow1 = new ArrayList();
	}
	if (arryRow2 == null) {
		arryRow2 = new ArrayList();
	}
	if (arryRow4 == null) {
		arryRow4 = new ArrayList();
	}
	if (arryRow5 == null) {
		arryRow5 = new ArrayList();

	}

	String strappno = Helper.correctNull((String) request
			.getParameter("appno"));
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
		{
			schemetype="0";
		}
	
	java.text.NumberFormat nf = java.text.NumberFormat
	.getNumberInstance();
	nf.	setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	String strFacSNo=Helper.getfacilitySno(schemetype);
	String strTotExp1=null,strTotExp2=null,strTotExp3=null;
%>
<html>
<head>
<title>LAPS -Assessment Form Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";

var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String) hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String) hshValues
									.get("strAction"))%>";
var  nodata="<%=Helper.correctNull((String) hshValues.get("nodata"))%>";
var strUserMode="<%=Helper.correctNull((String) hshValues
							.get("strUserMode"))%>";
var schemetype="<%=schemetype%>";

function costchicks()
{
	var  txt_totalcostchicks="<%=Helper.correctNull((String) hshValues
							.get("txt_totalcostchicks"))%>";
	if(txt_totalcostchicks=="")
	{
		txt_totalcostchicks=0;
	}
	for(var m=0;m<=2;m++)
	{
		var ibatch=document.forms[0].txt_ibatch[m].value
		if(ibatch=="")
			{
			ibatch=0;
			}
		var iyear=eval(txt_totalcostchicks)*eval(ibatch);
		//document.forms[0].txt_ibatchiyear[m].value=eval(iyear);
	}
	var val1=document.forms[0].txt_ibatchiyear[0].value;
	var val2=document.forms[0].txt_iibatchiyear[0].value;
	if(val1=="")
		{
		val1=0;
		}
	if(val2=="")
		{
		val2=0;
		}
	if(eval(val1)<eval(val2))
	{
		document.forms[0].txt_iibatchiyear[0].value=eval(val1);
	//	document.forms[0].txt_ibatchiyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[0].value=eval(val2)-eval(val1);
		var val3=document.forms[0].txt_ibatchiyear[1].value;
		var val4=document.forms[0].txt_ibatchiyear[1].value;
		//document.forms[0].txt_ibatchiyear[1].value=eval(val4)-eval(document.forms[0].txt_iibatchiiyear[0].value);
	}
	if(eval(val1)>eval(val2))
	{
		document.forms[0].txt_iibatchiyear[0].value=eval(val2);
		document.forms[0].txt_ibatchiyear[0].value=eval(val1)-eval(val2);
		document.forms[0].txt_iibatchiiyear[0].value="0";
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[0].value=eval(val2);
		document.forms[0].txt_ibatchiyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[0].value="0";
	}
}



function costfeed()
{
	var  txt_totalchickmash="<%=Helper.correctNull((String) hshValues
							.get("txt_totalfeedcost"))%>";
	var  varbirdsperbatch="<%=Helper.correctNull((String) hshValues
							.get("txt_nochicks"))%>";
	if(txt_totalchickmash=="")
		{
		txt_totalchickmash=0;
		}
	if(varbirdsperbatch=="")
	{
		varbirdsperbatch="0";
	}
	for(var m=0;m<=2;m++)
	{
		var ibatchfeed=document.forms[0].txt_ibatchfeed[m].value;
		if(ibatchfeed=="")
			{
			ibatchfeed=0;
			}
		var iiyear=eval(txt_totalchickmash)*eval(ibatchfeed)*eval(varbirdsperbatch);
		//document.forms[0].txt_ibatchiiyear[m].value=eval(iiyear);
	}
	var val1=NanNumber(document.forms[0].txt_ibatchiiyear[0].value);
	var val2=NanNumber(document.forms[0].txt_iibatchiyear[1].value);
	if(val1=="")
		{
		val1=0;
		}
	if(val2=="")
		{
		val2=0;
		}
	if(eval(val1)<eval(val2))
	{
		document.forms[0].txt_iibatchiyear[1].value=NanNumber(eval(val1));
		//document.forms[0].txt_ibatchiiyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[1].value=NanNumber(eval(val2)-eval(val1));
	}
	if(eval(val1)>eval(val2))
	{
		document.forms[0].txt_iibatchiyear[1].value=NanNumber(eval(val2));
		document.forms[0].txt_ibatchiiyear[0].value=NanNumber(eval(val1)-eval(val2));
		document.forms[0].txt_iibatchiiyear[1].value="0";
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[1].value=eval(val2);
		//document.forms[0].txt_ibatchiiyear[0].value="0";
		//document.forms[0].txt_iibatchiiyear[1].value="0";
	}
}
function costvtaid()
{
	var  txt_totalvtaid="<%=Helper.correctNull((String) hshValues
							.get("txt_totalvtaid"))%>";
	for(var m=0;m<=2;m++)
	{
		var ibatchvt=document.forms[0].txt_ibatchvt[m].value
		var vtyear=eval(txt_totalvtaid)*eval(ibatchvt);
		document.forms[0].txt_ibatchviiiyear[m].value=NanNumber(eval(vtyear));
	}
	var val1=document.forms[0].txt_ibatchviiiyear[0].value;
	var val2=document.forms[0].txt_iibatchiyear[5].value;
	
	if(eval(val1)<eval(val2))
	{
		document.forms[0].txt_iibatchiyear[5].value=eval(val1);
		//document.forms[0].txt_ibatchviiiyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[5].value=eval(val2)-eval(val1);
	}
	if(eval(val1)>eval(val2))
	{
		document.forms[0].txt_iibatchiyear[5].value=eval(val2);
		document.forms[0].txt_ibatchviiiyear[0].value=eval(val1)-eval(val2);
		document.forms[0].txt_iibatchiiyear[5].value="0";
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[5].value=eval(val2);
		//document.forms[0].txt_ibatchviiiyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[5].value="0";
	}
}
function costins()
{
	var  txt_totalinspremium="<%=Helper.correctNull((String) hshValues
							.get("txt_totalinspremium"))%>";
	for(var m=0;m<=2;m++)
	{
	var ibatchin=document.forms[0].txt_ibatchin[m].value
	var inyear=eval(txt_totalinspremium)*eval(ibatchin);
	document.forms[0].txt_ibatchixyear[m].value=NanNumber(eval(inyear));
	}
	var val1=document.forms[0].txt_ibatchixyear[0].value;
	
	var val2=document.forms[0].txt_iibatchiyear[6].value;
	
	if(eval(val1)<eval(val2))
	{
	document.forms[0].txt_iibatchiyear[6].value=eval(val1);
//	document.forms[0].txt_ibatchixyear[0].value="0";
	document.forms[0].txt_iibatchiiyear[6].value=eval(val2)-eval(val1);
	
	}
	if(eval(val1)>eval(val2))
	{
	document.forms[0].txt_iibatchiyear[6].value=eval(val2);
	document.forms[0].txt_ibatchixyear[0].value=eval(val1)-eval(val2);
	document.forms[0].txt_iibatchiiyear[6].value="0";
	
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[6].value=eval(val2);
	//	document.forms[0].txt_ibatchixyear[0].value="0";
		//document.forms[0].txt_iibatchiiyear[6].value="0";
	}
}
function costtransport()
{
	var  txt_transportcharge="<%=Helper.correctNull((String) hshValues
							.get("txt_transportcharge"))%>";
	for(var m=0;m<=2;m++)
	{
		var ibatchtc=document.forms[0].txt_ibatchtc[m].value
		var tryear=eval(txt_transportcharge)*eval(ibatchtc);
		document.forms[0].txt_ibatchxyear[m].value=NanNumber(eval(tryear));
	}
	var val1=document.forms[0].txt_ibatchxyear[0].value;
	
	var val2=document.forms[0].txt_iibatchiyear[7].value;
	
	if(eval(val1)<eval(val2))
	{
		document.forms[0].txt_iibatchiyear[7].value=eval(val1);
		document.forms[0].txt_ibatchxyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[7].value=eval(val2)-eval(val1);
	}
	if(eval(val1)>eval(val2))
	{
		document.forms[0].txt_iibatchiyear[7].value=eval(val2);
		document.forms[0].txt_ibatchxyear[0].value=eval(val1)-eval(val2);
		document.forms[0].txt_iibatchiiyear[7].value="0";
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[7].value=eval(val2);
		document.forms[0].txt_ibatchxyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[7].value="0";
	}
}
function labour()
{
	var val1=document.forms[0].txt_ibatchvyear[0].value;
	//alert(val1);
	var val2=document.forms[0].txt_iibatchiyear[2].value;
	//alert(val2);
	if(eval(val1)<eval(val2))
	{
		document.forms[0].txt_iibatchiyear[2].value=eval(val1);
		//document.forms[0].txt_ibatchvyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[2].value=eval(val2)-eval(val1);
	}
	if(eval(val1)>eval(val2))
	{
		document.forms[0].txt_iibatchiyear[2].value=eval(val2);
		document.forms[0].txt_ibatchvyear[0].value=eval(val1)-eval(val2);
		document.forms[0].txt_iibatchiiyear[2].value="0";
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[2].value=eval(val2);
		document.forms[0].txt_ibatchvyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[2].value="0";
	}
}
function water()
{
	var val1=document.forms[0].txt_ibatchviyear[0].value;
	var val2=document.forms[0].txt_iibatchiyear[3].value;
	if(eval(val1)<eval(val2))
	{
		document.forms[0].txt_iibatchiyear[3].value=eval(val1);
		document.forms[0].txt_ibatchviyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[3].value=eval(val2)-eval(val1);
	}
	if(eval(val1)>eval(val2))
	{
		document.forms[0].txt_iibatchiyear[3].value=eval(val2);
		document.forms[0].txt_ibatchviyear[0].value=eval(val1)-eval(val2);
		document.forms[0].txt_iibatchiiyear[3].value="0";
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[3].value=eval(val2);
		document.forms[0].txt_ibatchviyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[3].value="0";
	}
}
function electricity()
{
	var val1=document.forms[0].txt_ibatchviiyear[0].value;
	var val2=document.forms[0].txt_iibatchiyear[4].value;
	if(eval(val1)<eval(val2))
	{
		document.forms[0].txt_iibatchiyear[4].value=eval(val1);
		document.forms[0].txt_ibatchviiyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[4].value=eval(val2)-eval(val1);
	}
	if(eval(val1)>eval(val2))
	{
		document.forms[0].txt_iibatchiyear[4].value=eval(val2);
		document.forms[0].txt_ibatchviiyear[0].value=eval(val1)-eval(val2);
		document.forms[0].txt_iibatchiiyear[4].value="0";
	}
	if(eval(val1)==eval(val2))
	{
		document.forms[0].txt_iibatchiyear[4].value=eval(val2);
		document.forms[0].txt_ibatchviiyear[0].value="0";
		document.forms[0].txt_iibatchiiyear[4].value="0";
	}
}
function costexpenses0()
{
	
}

function costexpenses1()
{

}
function costexpenses2()
{
	
}
function costexpenses3()
{
	
}
function costexpenses4()
{

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

function doApply()
{	
   
	enableButtons( true, false, false, true, true);	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="agriloanassessment";
	document.forms[0].hidSourceUrl.value="/action/agr_poultry_broiflowchart.jsp";
	document.forms[0].hidBeanMethod.value="updatepoultrybroiflowchartData";
	document.forms[0].hidBeanGetMethod.value="getpoultrybroiflowchartData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(true);
   document.forms[0].hidAction.value ="insert";
   enableButtons(true, false, false, false, true);	
   
  
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
		document.forms[0].hidBeanGetMethod.value="getpoultrybroiflowchartData";
		document.forms[0].action=appUrl+"action/agr_poultry_broiflowchart.jsp";
		document.forms[0].submit(); 		
	}
	
}

function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updatepoultrybroiflowchartData";
	document.forms[0].hidBeanGetMethod.value="getpoultrybroiflowchartData";
	document.forms[0].hidBeanId.value="agriloanassessment";
	document.forms[0].hidSourceUrl.value="action/agr_poultry_broiflowchart.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
}

function onloading()
{	  
	//disableNewButtons(true, true, true, true, true, true, false);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	disableFields(true);
	
}
function enableButtons( bool2, bool3, bool4, bool5, bool6)
{	
	document.forms[0].cmdEdit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdCancel.disabled=bool4;
	document.forms[0].cmdDelete.disabled=bool5;
	document.forms[0].cmdClose.disabled = bool6;
}
function calculate()
{

}


function totlastexp()
{	

}

function funFeedingc()
{
	
	document.forms[0].txt_ibatchfeed.value	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading();calculate();totlastexp()">

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
      <td class="page_flow">Home -> Agriculture -> State of Expense</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="102" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>

<table width="100%" border="0" cellpadding="1" cellspacing="2" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
					<tr>
						<td>
						<table width="98%" border="0" cellspacing="1" cellpadding="2"  class="outertable" align="center" >
							<tr>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td>
								<table width="90%" align="center" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
									<tr>
										<td width="45%" rowspan="2" nowrap class="dataheader"><b>Expenditure
										On </b></td>
										<td colspan="5" align="center" class="dataheader"><b>(Amount
										in <%=ApplicationParams.getCurrency()%>) </b></td>
									</tr>
									<tr>
										<td align="center" class="dataheader" WIDTH="22%"><b>I
										Year</b></td>
										<td align="center" class="dataheader" WIDTH="17%"><b>II
										Year </b></td>
										<td align="center" class="dataheader" WIDTH="17%"><b>III
										Year </b></td>
										<td align="center" class="dataheader" WIDTH="17%"><b>IV
										Year </b></td>
										<td align="center" class="dataheader" WIDTH="16%"><b>V
										Year(onwards)</b></td>
									</tr>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%">Purchase of chicks <%
											for (int i = 1; i < 4; i++) {
												if (arryRow2 != null && arryRow2.size() >= i) {
													arryCol2 = (ArrayList) arryRow2.get(i - 1);
										%> <input type="hidden" name="txt_ibatch" size="3"
											maxlength="15" value="<%=arryCol2.get(1)%>"
											onKeyPress="allowInteger()" style="text-align: right;">
										<%
 	} else {
 %> <input type="hidden" name="txt_ibatch" size="3" maxlength="15"
											onKeyPress="allowInteger()" style="text-align: right;">
										<%
 	}
 	}
 %>
										</td>
										<%if(arrChicks!=null && arrChicks.size()>0){ %>
										<td width="22%" align="center"><input type="text"
											name="txt_ibatchiyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrChicks.get(0))%>"
											style="text-align: right;"></td>
										<td width="17%" align="center"><input type="text"
											name="txt_ibatchiyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrChicks.get(1))%>"
											style="text-align: right;"></td>
										<td width="16%" rowspan="2" align="center"><input
											type="text" name="txt_ibatchiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrChicks.get(2))%>" style="text-align: right;"></td>
											
											<td width="16%" rowspan="2" align="center"><input
											type="text" name="txt_ibatchiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrChicks.get(3))%>" style="text-align: right;"></td>
											
											<td width="16%" rowspan="2" align="center"><input
											type="text" name="txt_ibatchiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrChicks.get(4))%>" style="text-align: right;"></td> 
											
											<% }else{%>
											<td width="22%" align="center"><input type="text"
											name="txt_ibatchiyear" size="20" maxlength="15" 
											value=""
											style="text-align: right;"></td>
										<td width="17%" align="center"><input type="text"
											name="txt_ibatchiyear" size="20" maxlength="15" 
											value=""
											style="text-align: right;"></td>
										<td width="16%" rowspan="2" align="center"><input
											type="text" name="txt_ibatchiyear" size="20" maxlength="15"
											value="" style="text-align: right;"></td>
											<td width="16%" rowspan="2" align="center"><input
											type="text" name="txt_ibatchiyear" size="20" maxlength="15"
											value="" style="text-align: right;"></td>
											<td width="16%" rowspan="2" align="center"><input
											type="text" name="txt_ibatchiyear" size="20" maxlength="15"
											value="" style="text-align: right;"></td>
											<%} %>
									</tr>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(1);

												/*if (arryCol.size() != 0) {
													 
													//a1 =Helper.correctNull((String) arryCol.get(0));
													
												}*/

											} else if (arryRow.size() == 0) {
												//a1 = "";

											}
										%>
									</tr>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%">Feeding of chicks <%
											for (int i = 1; i < 4; i++) {
												if (arryRow2 != null && arryRow2.size() >= i) {
													arryCol2 = (ArrayList) arryRow2.get(i - 1);
										%> <input type="hidden" name="txt_ibatchfeed" size="3"
											maxlength="15" value="<%=arryCol2.get(1)%>"
											onKeyPress="allowInteger()" style="text-align: right;">
										<%
											} else {
										%> <input type="hidden" name="txt_ibatchfeed" size="3"
											maxlength="15" value="" onKeyPress="allowInteger()"
											style="text-align: right;"> <%
 	}
 	}
 %>
										</td>
										<%if(arrFeedCost!=null && arrFeedCost.size()>0){ %>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchiiyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrFeedCost.get(0))%>"
											style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchiiyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrFeedCost.get(1))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchiiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrFeedCost.get(2))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchiiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrFeedCost.get(3))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchiiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrFeedCost.get(4))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%}else{ %>
											<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchiiyear" size="20" maxlength="15" 
											value=""
											style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchiiyear" size="20" maxlength="15" 
											value=""
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchiiyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchiiyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchiiyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%} %>
									</tr>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(2);

												/*if (arryCol.size() != 0) {
													 
													a2 =Helper.correctNull((String) arryCol.get(0));
													
												}*/

											} /*else if (arryRow.size() == 0) {
														//a2 = "";
														
														
													}*/
										%>
									</tr>
									<%if(arrSal!=null && arrSal.size()>0){ %>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%"> Salary / Wages</td>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchvyear2" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrSal.get(0))%>"
											style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchvyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrSal.get(1))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchvyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrSal.get(2))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchvyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrSal.get(3))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchvyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrSal.get(4))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
									</tr>
									<%} %>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(4);

												/*if (arryCol.size() != 0) {
													 
													a5=Helper.correctNull((String) arryCol.get(0));
													
												}*/

											} else if (arryRow.size() == 0) {
												//a5 = "";

											}
										%>
									</tr>
									<% if(arrWaterCharge!=null && arrWaterCharge.size()>0){%>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%">Water charges</td>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchviyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrWaterCharge
									.get(0))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchviyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrWaterCharge
									.get(1))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrWaterCharge
									.get(2))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrWaterCharge
									.get(3))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrWaterCharge
									.get(4))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
									</tr>
									<%} %>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(5);

												/*if (arryCol.size() != 0) {
													 
													a6 =Helper.correctNull((String) arryCol.get(0));
													
												}*/

											} else if (arryRow.size() == 0) {
												//a6 = "";

											}
										%>
									</tr>
									<%if(arrElectric!=null && arrElectric.size()>0){ %>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%">Electricity charges</td>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchviiyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrElectric.get(0))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchviiyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrElectric.get(1))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrElectric.get(2))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrElectric.get(3))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrElectric.get(4))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
									</tr>
									<%} %>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(6);

												/*if (arryCol.size() != 0) {
													 
													a7=Helper.correctNull((String) arryCol.get(0));
													
												}*/

											} /*else if (arryRow.size() == 0) {
														a7 = "";
														
														
													}*/
										%>
									</tr>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%">Veterinary aid <%
											for (int i = 1; i < 4; i++) {
												if (arryRow2 != null && arryRow2.size() >= i) {
													arryCol2 = (ArrayList) arryRow2.get(i - 1);
										%> <input type="hidden" name="txt_ibatchvt" size="3"
											maxlength="15" value="<%=arryCol2.get(1)%>"
											onKeyPress="allowInteger()" style="text-align: right;">
										<%
 	} else {
 %> <input type="hidden" name="txt_ibatchvt" size="3" maxlength="15"
											value="" onKeyPress="allowInteger()"
											style="text-align: right;"> <%
 	}
 	}
 %>
										</td>
										<%if(arrVetri!=null && arrVetri.size()>0){%>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchviiiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrVetri.get(0))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchviiiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrVetri.get(1))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiiyear" size="20"
											maxlength="15" value="<%=Helper.correctNull((String) arrVetri.get(2))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiiyear" size="20"
											maxlength="15" value="<%=Helper.correctNull((String) arrVetri.get(3))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiiyear" size="20"
											maxlength="15" value="<%=Helper.correctNull((String) arrVetri.get(4))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%}else{ %>
											<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchviiiyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchviiiyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiiyear" size="20"
											maxlength="15" value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiiyear" size="20"
											maxlength="15" value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchviiiyear" size="20"
											maxlength="15" value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%} %>
									</tr>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(7);

												/*if (arryCol.size() != 0) {
													 
													a8 =Helper.correctNull((String) arryCol.get(0));
													
												}*/

											} /*else if (arryRow.size() == 0) {
														a8 = "";
														
														
													}*/
										%>
									</tr>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%">Insurance of birds <%
											for (int i = 1; i < 4; i++) {
												if (arryRow2 != null && arryRow2.size() >= i) {
													arryCol2 = (ArrayList) arryRow2.get(i - 1);
										%> <input type="hidden" name="txt_ibatchin" size="3"
											maxlength="15" value="<%=arryCol2.get(1)%>"
											onKeyPress="allowInteger()" style="text-align: right;">
										<%
 	} else {
 %> <input type="hidden" name="txt_ibatchin" size="3" maxlength="15"
											value="" onKeyPress="allowInteger()"
											style="text-align: right;"> <%
 	}
 	}
 %>
										</td>
										<%if(arrInsPre!=null && arrInsPre.size()>0){ %>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchixyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrInsPre.get(0))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchixyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrInsPre.get(1))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchixyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrInsPre.get(2))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchixyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrInsPre.get(3))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchixyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrInsPre.get(4))%>" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%}else{ %>
											<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchixyear" size="20" maxlength="15" 
											value=""
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchixyear" size="20" maxlength="15" 
											value=""
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchixyear" size="20" maxlength="15"
											value="" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchixyear" size="20" maxlength="15"
											value="" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchixyear" size="20" maxlength="15"
											value="" onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%} %>
									</tr>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(8);

												if (arryCol.size() != 0) {

													//a9 =Helper.correctNull((String) arryCol.get(0));

												}

											} else if (arryRow.size() == 0) {
												//a9 = "";

											}
										%>
									</tr>
									<tr class="datagrid">
										<td rowspan="2" WIDTH="45%">Transportation charges <%
											for (int i = 1; i < 4; i++) {
												if (arryRow2 != null && arryRow2.size() >= i) {
													arryCol2 = (ArrayList) arryRow2.get(i - 1);
										%> <input type="hidden" name="txt_ibatchtc" size="3"
											maxlength="15" value="<%=arryCol2.get(1)%>"
											onKeyPress="allowInteger()" style="text-align: right;">
										<%
 	} else {
 %> <input type="hidden" name="txt_ibatchtc" size="3" maxlength="15"
											value="" onKeyPress="allowInteger()"
											style="text-align: right;"> <%
 	}
 	}
 %>
										</td>
										<%if(arrTransport!=null && arrTransport.size()>0){ %>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchxyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrTransport.get(0))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchxyear" size="20" maxlength="15" 
											value="<%=Helper.correctNull((String) arrTransport.get(1))%>"
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchxyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrTransport.get(2))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchxyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrTransport.get(3))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchxyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arrTransport.get(4))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%}else{ %>
											<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchxyear" size="20" maxlength="15" 
											value=""
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchxyear" size="20" maxlength="15" 
											value=""
											onKeyPress="allowInteger()" style="text-align: right;"></td>
										<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchxyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchxyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td rowspan="2" align="center" WIDTH="16%"><input
											type="text" name="txt_ibatchxyear" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<%} %>
									</tr>
									<tr class="datagrid">
										<%
											if (arryRow.size() != 0) {
												arryCol = (ArrayList) arryRow.get(9);

												if (arryCol.size() != 0) {

													//a10 =Helper.correctNull((String) arryCol.get(0));

												}

											} else if (arryRow.size() == 0) {
												//a10 = "";

											}
										%>
										</tr>
										
										
<!--										<tr class="datagrid">-->
<!--										<td  WIDTH="45%">Non Recuring Expenses</td>-->
<!--										<td align="center" WIDTH="22%"><input type="text"-->
<!--											name="txt_NonRec" size="20" maxlength="15" -->
<!--											value=""-->
<!--											onKeyPress="allowInteger()" style="text-align: right;"></td>-->
<!--										<td align="center" WIDTH="17%"><input type="text"-->
<!--											name="txt_NonRec1" size="20" maxlength="15" -->
<!--											value="0.00"-->
<!--											onKeyPress="allowInteger()" style="text-align: right;"></td>-->
<!--										<td  align="center" WIDTH="16%"><input-->
<!--											type="text" name="txt_NonRec2" size="20" maxlength="15"-->
<!--											value="0.00" onKeyPress="allowInteger()"-->
<!--											style="text-align: right;"></td>-->
<!--									</tr>	-->
										
										
										
										<%if (arryRow1 != null && arryRow1.size() > 0){ %>
									
									
									
									<tr class="dataheader">
									<td colspan="6">Other Charges</td>
									</tr>
									<%} %>
									
									<%
										if (arryRow1 != null && arryRow1.size() > 0) {
											for (int i = 0; i < arryRow1.size(); i++) {

												arryCol1 = (ArrayList) arryRow1.get(i);
									%>
									<tr class="datagrid">
										<td WIDTH="45%"><%=Helper.correctNull((String) arryCol1.get(0))%></td>
										<td align="center" WIDTH="22%"><input type="text"
											name="txt_ibatchexpiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arryCol1.get(1))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td align="center" WIDTH="17%"><input type="text"
											name="txt_ibatchexpiyear" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arryCol1.get(2))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
										<td align="center" WIDTH="16%"><input type="text"
											name="txt_ibatchexpiyear" onFocus="" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arryCol1.get(3))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td align="center" WIDTH="16%"><input type="text"
											name="txt_ibatchexpiyear" onFocus="" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arryCol1.get(5))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
											<td align="center" WIDTH="16%"><input type="text"
											name="txt_ibatchexpiyear" onFocus="" size="20" maxlength="15"
											value="<%=Helper.correctNull((String) arryCol1.get(6))%>" 
											onKeyPress="allowInteger()"
											style="text-align: right;"></td>
									</tr>
									<%
										}
										}
									%>
									
									<tr class="datagrid">
										<td class="dataheader" WIDTH="45%" align="center"><b>Total(Expenditure)</b></td>
										<%if(arrTotalExpenses!=null && arrTotalExpenses.size()>0){ %>
										<td align="center" class="dataheader" WIDTH="22%"><input
											type="text" name="txt_totiyearu" size="20" maxlength="15"
											value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrTotalExpenses.get(0))))%>" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
										<td align="center" class="dataheader" WIDTH="17%"><input
											type="text" name="txt_totaliiyearu" size="20" maxlength="15"
											value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrTotalExpenses.get(1))))%>" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
										<td align="center" class="dataheader" WIDTH="16%"><input
											type="text" name="txt_totaliiiyearu" size="20" maxlength="15"
											value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrTotalExpenses.get(2))))%>" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
											<td align="center" class="dataheader" WIDTH="16%"><input
											type="text" name="txt_totaliiiyearu" size="20" maxlength="15"
											value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrTotalExpenses.get(3))))%>" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
											<td align="center" class="dataheader" WIDTH="16%"><input
											type="text" name="txt_totaliiiyearu" size="20" maxlength="15"
											value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String) arrTotalExpenses.get(4))))%>" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
											<%}else{ %>
											<td align="center" class="dataheader" WIDTH="22%"><input
											type="text" name="txt_totiyearu" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
										<td align="center" class="dataheader" WIDTH="17%"><input
											type="text" name="txt_totaliiyearu" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
										<td align="center" class="dataheader" WIDTH="16%"><input
											type="text" name="txt_totaliiiyearu" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
											<td align="center" class="dataheader" WIDTH="16%"><input
											type="text" name="txt_totaliiiyearu" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
											<td align="center" class="dataheader" WIDTH="16%"><input
											type="text" name="txt_totaliiiyearu" size="20" maxlength="15"
											value="" 
											onKeyPress="allowInteger()" readonly
											style="text-align: right;"></td>
											<%} %>
									</tr>
									
								</table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr align="center">
						<td width="0"><input type="button" name="cmdclose"
							value="Close" class="buttonClose" onClick="doClose()"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="measurement" value=""> <input
			type="hidden" name="cmdsave" disabled></td>
	</tr>
</table>
<input
	type="hidden" name="hidBeanId" value=""> 
	 <input type="hidden"
	name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>