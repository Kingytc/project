<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.laps.helper.*,java.util.*,com.sai.fw.management.utils.FwHelper"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	request.setAttribute("_cache_refresh", "true");
String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
String strAnimaltype =Helper.correctNull((String)hshValues.get("animaltype"));

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
	String strProductFor=(String) session.getAttribute("strProductFor");


	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize = 0,arrColSize=0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrNoOfAnimalsRow = new ArrayList();
	HashMap hshFinancialData = new HashMap();
	
	double dblLabourCount =0;
	double dblSalary =0;
	String strLactTotal="",strDryTotal="";
	double dblLabourCost =0,dblElectricity=0,dblAdultVet=0,dblHeiferVet=0;
	double dbl_lact_green=0,dbl_lact_dry=0,dbl_lact_concentrate=0,dbl_dry_green=0,dbl_dryfodder=0,dbl_dry_concentrate=0;
	double dbl_greencost=0,dbl_drycost=0,dbl_concentratecost=0,dbl_lactation_total=0,dbl_dry_total=0;
	int intLabourCount=0;
	if (hshValues != null) {
		arrNoOfAnimalsRow = (ArrayList) hshValues.get("arrNoOfAnimals");
		hshFinancialData = (HashMap)hshValues.get("hshFinancialData");
		strLactTotal = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_lactation_total"))));
		strDryTotal = nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_dry_total"))));
		String strLabour = Helper.correctNull((String)hshFinancialData.get("agr_findata_labour_count"));
		if(!strLabour.equalsIgnoreCase(""))
		{
			intLabourCount = Integer.parseInt(strLabour);
		}
		dblLabourCount =Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_labour_count")));
		dblSalary =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_labour_salary")));
		dblElectricity =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_electric_cost")));
		dblAdultVet =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_adult_vetaid")));
		dblHeiferVet =Double.parseDouble(Helper.correctDouble((String) hshFinancialData.get("agr_findata_heifer_vetaid")));
		dblLabourCost = dblLabourCount*dblSalary;
		
	}
	if (arrNoOfAnimalsRow != null) {
		arrSize = arrNoOfAnimalsRow.size();
	}
	
	

	String strDesc[]={"No.Of "+strAnimaltype+"","Lactation Days","Cost of feed & fodder @ Rs."+strLactTotal+"/day (Lactation)",
			"Dry Days","Cost of feed & fodder@ Rs."+strDryTotal+"/day (Dry days)","No of Heifers",
			"Cost of concentrated feed @ Rs."+nf.format(Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_heifer_feedcost"))))+"/Heifer per year",
			"Cost of fooder @ Rs."+nf.format(Double.parseDouble(Helper.correctDouble((String)hshFinancialData.get("agr_findata_heifer_foddercost"))))+"/Heifer per year",
			"Cost of "+intLabourCount+" Labour @ Rs."+nf.format(dblSalary)+"/Per Month"
			,"Electricity & Other misc exp @ Rs."+nf.format(dblElectricity)+"/Per Month",
			"Veterinary aid @ Rs."+nf.format(dblAdultVet)+"/Adult and Rs."+nf.format(dblHeiferVet)+"/Heifer Per year","Insurance Charges"
			,"Total Expenditure"};
	String strFacSNo=Helper.getfacilitySno(schemetype);
%>
<html>
<head>
<title>Recurring Expenditure</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<Script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var prd_type="<%=prd_type%>";
var schemetype="<%=schemetype%>";

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<script>
function callOnLoad()
{
	disabledFields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
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
<body onload="callOnLoad()">
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
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Agriculture -&gt; Recurring expenditure</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="126" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="3" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td>
	        <table width="100%" border="0" cellspacing="1" cellpadding="3"  class="outertable">
	
				<tr class="dataheader" align="center">
			            <td width="40%">Particulars</td>
			            <td>Year I</td>
			            <td>Year II</td>
			            <td>Year III</td>
			            <td>Year IV</td>
			            <td>Year V</td>
			            <td>Year VI</td>
			    </tr>
			    <%  for(int i=0;i<arrSize;i++)
			  		{
			    	  if(i<=12)
			    	  {
			    		arrCol = (ArrayList)arrNoOfAnimalsRow.get(i);
			    		if(arrCol!=null)
							arrColSize=arrCol.size();
				    	if(arrColSize>0)
				    	{
				    %>
				    		<tr align="center" class="datagrid">
				    			<td width="35%" align="left"><%= strDesc[i]%></td>
				    			<td><input type="text" name="txt_year1" size="15" value="<%=Helper.correctNull((String)arrCol.get(0))%>" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year2" size="15" value="<%=Helper.correctNull((String)arrCol.get(1))%>" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year3"  size="15" value="<%=Helper.correctNull((String)arrCol.get(2))%>" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year4" size="15"  value="<%=Helper.correctNull((String)arrCol.get(3))%>" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year5"  size="15" value="<%=Helper.correctNull((String)arrCol.get(4))%>" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year6"  size="15" value="<%=Helper.correctNull((String)arrCol.get(5))%>" style="text-align:right"></td>
				    		</tr>
				    
				  	<%
				    	}
				    	else
				    	{%>
				    		<tr align="center" class="datagrid">
				    			<td width="40%" align="left"><%= strDesc[i]%></td>
				    			<td><input type="text" name="txt_year1" size="15" value="" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year2" size="15" value="" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year3"  size="15" value="" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year4" size="15"  value="" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year5"  size="15" value="" style="text-align:right"></td>
				    			<td><input type="text" name="txt_year6"  size="15" value="" style="text-align:right"></td>
				    		</tr>
				    	<%}
			  		   } 
			  		}
			    	  
			  	%>
			  </table>
		</td>
	</tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="43%" border="0" cellspacing="0" cellpadding="1">
			<tr valign="top">
				<td><input type="button" name="cmdClose" value="Close"
					onClick="doClose()" class="buttonClose"></td>
					<td><input type="button" name="cmdsave" value="Save"
					onClick="" class="buttonClose" style="visibility:hidden;" disabled="disabled"></td>
			</tr>
			
		</table>
		</td>
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