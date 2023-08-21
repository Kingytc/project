<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@page import="com.sai.fw.management.utils.FwHelper"%>
<lapschoice:handleerror />
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

java.text.NumberFormat dfNF = java.text.NumberFormat
.getNumberInstance();
dfNF.setGroupingUsed(false);
dfNF.setMaximumFractionDigits(3);
dfNF.setMinimumFractionDigits(3);

	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize = 0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrPlantDet = new ArrayList();
	ArrayList arrColPlant = new ArrayList();
	ArrayList arrBCR = new ArrayList();
	int arrPlantDetSize = 0;
	double dblBCR=0.00;

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
	}
	if (arrRow != null) {
		arrSize = arrRow.size();
	}
	String strDesc[] = { 
			"Income(Rs.)", "Total cost(Rs.)", "Net Benefit(Rs.)",
			"DF at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+"%","PWB at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+" % df",
			"PWC at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+" %df", "NPW at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+" % df","DF at "+ Helper.correctNull((String)hshValues.get("DFNXT"))+" %",
			"NPW at "+ Helper.correctNull((String)hshValues.get("DFNXT"))+" % df","BCR","IRR" };

	if (hshValues != null) {
		arrPlantDet = (ArrayList) hshValues.get("arrHortiplant");
		arrBCR=(ArrayList) hshValues.get("arrBCR");
		if(arrBCR!=null && arrBCR.size()>0)
		{
			dblBCR=FwHelper.parseDouble((String)arrBCR.get(2));
		}
		
	}
	if (arrPlantDet != null) {
		arrPlantDetSize = arrPlantDet.size();
	}
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<html>
<head>
<title>DSCR</title>
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
	
	//disabledFields(true);
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
			document.all.sel_scheme.value=varschemetype;

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

function computeRowTotal(id)
{
	
}
function change_plant()
{
	if(document.forms[0].sel_plantName.value!="s")
	{
    document.forms[0].hidBeanId.value="agrnursery";
    document.forms[0].hidBeanGetMethod.value="getHorticultureFinancialAnalysis";
    document.forms[0].action=appUrl+"/action/agr_hortifinancialanalysis.jsp";
	document.forms[0].submit();
	}
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmDSCR" method=post class="normal"><div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
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
      <td class="page_flow">Home -> Agriculture -> Financial Analysis</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="73" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
			<jsp:param name="pageflag" value="Y"/>
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align=center>
	<tr>
		<td height="24" valign="top">
		<table width="99%" border="0" cellspacing="1" cellpadding="3"
			class="datagrid">
			<tr>
				<td colspan="17">&nbsp;</td>
			</tr>
			<tr align="center" class="dataheader">
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
			<%
				for (int i = 0; i < 3; i++) {

					int arrColSize = 0;
					if (i < arrSize) {
						arrCol = (ArrayList) arrRow.get(i);
						if (arrCol != null)
							arrColSize = arrCol.size();
					}
					if (arrColSize > 0) {
						
			%>
			<tr class="datagrid" align="center">
			
			<%if(i==3 || i==7){ %>
			<td align="left" WIDTH="9%"><%=strDesc[i]%></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>);"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(0))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(1))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(2))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(3))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(4))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(5))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year7" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(6))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year8" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(7))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year9" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(8))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year10" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(9))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year11" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(10))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year12" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(11))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year13" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(12))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year14" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(13))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="7"
					name="txt_year15" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(14))))%>"></td>
			<%}else{ %>
				<td align="left" WIDTH="9%"><%=strDesc[i]%></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>);"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(0))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(1))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(2))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(3))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(4))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(5))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year7" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(6))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year8" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(7))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year9" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(8))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year10" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(9))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year11" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(10))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year12" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(11))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year13" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(12))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year14" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(13))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="7"
					name="txt_year15" size="8" onKeyPress="allowNumber(this)"
					onBlur="computeRowTotal(<%=i%>)"
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol
											.get(14))))%>"></td>
			<%} %>
			</tr>
			<%
				} else {
			%>
			<tr class="datagird" align="center">
				<td align="left" WIDTH="9%"><%=strDesc[i]%> <input
					type="hidden" name="txt_desc" value="<%=strDesc[i]%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year7" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year8" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year9" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year10" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year11" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year12" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year13" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year14" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="7"
					name="txt_year15" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right" value=""></td>
			</tr>
			<%
				}
				}
			%>
<!--			<tr class="dataGridColor" align="center">-->
<!--				<td align="left" WIDTH="9%"><b>BCR</b></td>-->
<!--				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="1"-->
<!--					name="txt_year1" size="8" onKeyPress="allowNumber(this)"-->
<!--					onBlur=""-->
<!--					style="text-align: right"-->
<!--					value=""></td>-->
<!--			</tr>
			<tr>		
					<td align="left" WIDTH="9%"><b>IRR</b></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="8" onKeyPress="allowNumber(this)"
					onBlur=""
					style="text-align: right"
					value="<%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("IRR")))%>"></td>
			</tr>-->
		</table>
		</td>
	</tr>
</table>
<br>
	<br>
<lapschoice:combuttonnew	btnnames=""	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	
<br>

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