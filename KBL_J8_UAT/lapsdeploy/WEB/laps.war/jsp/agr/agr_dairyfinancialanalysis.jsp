<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*,com.sai.fw.management.utils.FwHelper"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
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
	String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
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
	ArrayList arrBCR = new ArrayList();
	double dblBCR=0.00;

	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
	}
	if (arrRow != null) {
		arrSize = arrRow.size();
	}
	String strDesc[] = { 
			"Recurring Expenditure",
			"TotalIncome", 
			"Net Benefit(Rs.)",
			"DF at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+"%",
			"PWB at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+" % df",
			"PWC at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+" %df", 
			"NPW at "+ Helper.correctNull((String)hshValues.get("DFPERC"))+" % df",
			"DF at "+ Helper.correctNull((String)hshValues.get("DFNXT"))+" %",
			"NPW at "+ Helper.correctNull((String)hshValues.get("DFNXT"))+" % df", 
			"BCR", "IRR" };

	if (hshValues != null) {
		arrBCR=(ArrayList) hshValues.get("arrBCR");
		if(arrBCR!=null && arrBCR.size()>0)
		{
			dblBCR=FwHelper.parseDouble((String)arrBCR.get(2));
		}
		
	}
	String strFacSNo=Helper.getfacilitySno(schemetype);
%>
<html>
<head>
<title>Dairy Financial Analysis</title>
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
var schemetype="<%=schemetype%>";
function onloading()
{	  
	//document.all.hideButton.style.visibility="hidden";
	//document.all.hideButton.style.position="absolute";
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	disabledFields(true);
}
/*function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}*/
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
<body onload="onloading()">
<form name="frmDSCR" method="post" class="normal"><div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
  <div class="menuitems" >
   <script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Agriculture -&gt; Financial Analysis</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="127" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td height="24" valign="top">
		<table width="99%" border="0" cellspacing="1" cellpadding="3" class="outertable">
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
			</tr>
			<%
				for (int i = 0; i < 11; i++) {

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
					name="txt_year1" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(0))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(1))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(2))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(3))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(4))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=dfNF.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(5))))%>"></td>
			<%}else{ %>
				<td align="left" WIDTH="9%"><%=strDesc[i]%></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="1"
					name="txt_year1" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(0))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="2"
					name="txt_year2" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(1))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="3"
					name="txt_year3" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(2))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="4"
					name="txt_year4" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(3))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="5"
					name="txt_year5" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(4))))%>"></td>
				<td WIDTH="5%"><input type="text" maxlength="15" tabindex="6"
					name="txt_year6" size="20" onKeyPress="allowNumber(this)"
					
					style="text-align: right"
					value="<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) arrCol.get(5))))%>"></td>
			<%} %>
			</tr>
			<%
				} }
			%>
	
			
		</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="1">
	<tr valign="top">
		<td align="center" width="100%"><input type="button" name="cmdClose" value="Close"
			onClick="doClose()" class="buttonClose"></td>
		<td><input type="button" name="cmdsave" value="Save"
					onClick="" class="buttonClose" style="visibility:hidden;" disabled="disabled"></td>
	</tr>
</table>
<lapschoice:hiddentag pageid="<%=PageId%>"/>		
<input type="hidden"
	name="hid_pagename" value=""> <input type="hidden"
	name="hidAppType"
	value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>