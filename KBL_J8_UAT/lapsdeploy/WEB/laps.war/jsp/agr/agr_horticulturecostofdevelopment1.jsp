<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
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
	int yield_period=0;
	int i=0;
			
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	
	ArrayList arrECRow = new ArrayList();
	ArrayList arrECCol = new ArrayList();
	
	if(hshValues!=null)
	{
		arrECRow=(ArrayList)hshValues.get("arrRow");
	}
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	//out.println("gvfg="+hshValues);
	String strCategoryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));
	if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
		strCategoryType = "CORP";
	}
	else if (strCategoryType.equals("")) 
	{
		strCategoryType = Helper.correctNull((String) hshValues.get("categorytype"));
	}
	else if (strCategoryType.equalsIgnoreCase("")) 
	{
		strCategoryType = Helper.correctNull((String) hshValues.get("hidCategoryType"));
		if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
			strCategoryType = "CORP";
		}
		 
	}
	if (strCategoryType.equalsIgnoreCase("")) 
	{
		strCategoryType = Helper.correctNull((String) session.getAttribute("cattype"));
		if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
			strCategoryType = "CORP";
		}
		 
		
	}

	String strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
	if (strSSIType.equalsIgnoreCase("")) {
		strSSIType = Helper.correctNull((String) hshValues.get("hidSSIType"));
	}
	int strYearStarting = Integer.parseInt(Helper.correctInt((String) hshValues.get("strYearStarting")));
	int strYearsUpto = Integer.parseInt(Helper.correctInt((String) hshValues.get("strYearsUpto")));
	int total = Integer.parseInt(Helper.correctInt((String) hshValues.get("total")));			
%>
<html>
<head>
<title>Estimated Cost</title>
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
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var plant_name = "<%=Helper.correctNull((String)hshValues.get("PlantName"))%>";
var varschemetype="<%=schemetype%>";
var yieldingperiod="<%=strYearStarting%>";
var endperiod="<%=strYearsUpto%>";
function onloading()
{
	disabledFields(true);
	if(plant_name!="")
		document.forms[0].sel_plantName.value=plant_name;
	else
		document.forms[0].sel_plantName.value="s";
	document.forms[0].sel_plantName.disabled=false;
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
	totalamount();
}


function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
	}
}
function doSave()
{   
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidBeanMethod.value="updateHortiCostOfDevelopmentDetails";
	document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_horticulturecostofdevelopment1.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doEdit()
{
	disabledFields(false);
	if(document.forms[0].sel_plantName.value=="s")
	{
		alert("Select a plant name");
		document.forms[0].sel_plantName.focus();
		return;
	}
	document.forms[0].hidAction.value="Edit";
	document.forms[0].txt_total.readOnly=true;
	disableEditButtons(true, false, false, false, false);	
	getVisibleYears(yieldingperiod,endperiod);	
}

function getVisibleYears(yieldingperiod,endperiod)
{
	<%for(int m=strYearStarting;m<=total;m++){%>
/// Commended by saravanan
	
	///	document.forms[0].txt_year<%=m%>.readOnly=true;
	<%}%>
}

function make_readOnly(val1,val2,val3,val4,val5,val6,val7)
{
	for(var j=0;j<15;j++)
	{

// Commended by saravanan
		
		/*document.forms[0].txt_year1[j].readOnly	=	val1;
		document.forms[0].txt_year2[j].readOnly	=	val2;
		document.forms[0].txt_year3[j].readOnly	=	val3;
		document.forms[0].txt_year4[j].readOnly	=	val4;
		document.forms[0].txt_year5[j].readOnly	=	val5;
		document.forms[0].txt_year6[j].readOnly	=	val6;
		document.forms[0].txt_year7[j].readOnly	=	val7;*/
	}
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].sel_plantName.value="s";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_horticulturecostofdevelopment1.jsp";
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
		document.forms[0].hidSourceUrl.value="action/agr_horticulturecostofdevelopment1.jsp";	
		document.forms[0].hidBeanMethod.value="updateHortiCostOfDevelopmentDetails";
		document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
		document.forms[0].submit();		
	}
}	

function change_plant()
{
	if(document.forms[0].sel_plantName.value!="s")
	{
    document.forms[0].hidBeanId.value="agrlandholdings";
    document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
    document.forms[0].action=appUrl+"action/agr_horticulturecostofdevelopment1.jsp";
	document.forms[0].submit();
	}
}

function totalamount()
{
	var total = parseFloat(document.forms[0].txt_year1.value)+
	parseFloat(document.forms[0].txt_year2.value)+
	parseFloat(document.forms[0].txt_year3.value)+
	parseFloat(document.forms[0].txt_year4.value)+
	parseFloat(document.forms[0].txt_year5.value)+
	parseFloat(document.forms[0].txt_year6.value)+
	parseFloat(document.forms[0].txt_year7.value)+
	parseFloat(document.forms[0].txt_year8.value)+
	parseFloat(document.forms[0].txt_year9.value)+
	parseFloat(document.forms[0].txt_year10.value)+
	parseFloat(document.forms[0].txt_year11.value)+
	parseFloat(document.forms[0].txt_year12.value)+
	parseFloat(document.forms[0].txt_year13.value)+
	parseFloat(document.forms[0].txt_year14.value)+
	parseFloat(document.forms[0].txt_year15.value);
	document.forms[0].txt_total.value=total;
	roundtxt(document.forms[0].txt_total);
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	</head>
<body onload="onloading()">
<form method=post class="normal">
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
      <td class="page_flow">Home -> Agriculture -> Estimated Cost</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="71" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
  <tr> 
      <td height="24" valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="1" class="datagrid">
        <tr>
        	<td colspan="9" align="center">Name of the plant&nbsp;&nbsp;<select name="sel_plantName" onChange="change_plant()">
        						<option value="s">--Select--</option>
        							<lapschoice:AgrHortiPlantNames schemetype="<%=schemetype%>"/>
        						</select>
        	</td>
        </tr>
       	<tr class="dataheader">
       	<td rowspan="2" align="center">Years</td> 
       	<td colspan="8" align="center">Cost/ Year (Rs.)</td>
       	</tr>
       	
          <tr class="dataheader"> 
          <%for(i=1;i<=8;i++){ %>
            <td align="center">Year <%=i%></td>
          <%} %>
          </tr>
 
         
     
        <tr class="datagrid" align="center"> 
        	<td align="left">Total Cost Per acre</td>
        	<%if(arrECRow!=null && arrECRow.size()>0)
        	{
        	for(i=1;i<=8;i++){ 
        	arrECCol = (ArrayList)arrECRow.get(i-1); %>
           	<td> 
              <input type="text" maxlength="15" name="txt_year<%=i%>" size="14" onKeyPress="allowNumber(this)"
				onBlur="roundtxt(this);totalamount();" style="text-align: right" value="<%=Helper.formatDoubleValue(Double.
						parseDouble(Helper.correctNull((String)arrECCol.get(0))))%>">
            </td>
            <%}}else{ 
            for(i=1;i<=8;i++){ %>
            	<td> 
              <input type="text" maxlength="15" name="txt_year<%=i%>" size="14" onKeyPress="allowNumber(this)"
				onBlur="roundtxt(this);totalamount();" style="text-align: right" value="0.00">
            </td>
            <%} }%>
        </tr>
       	<tr class="dataheader">
       	<td rowspan="2" align="center">Years</td> 
       	<td colspan="7" align="center">Cost/ Year (Rs.)</td>
       	<td rowspan="2" align="center">Total</td>
       	</tr>
       	
          <tr class="dataheader"> 
          <%for(i=9;i<=15;i++){ %>
            <td align="center">Year <%=i%></td>
          <%} %>
          </tr>
 
         
     
        <tr class="datagrid" align="center"> 
        	<td align="left">Total Cost Per acre</td>
        	<%if(arrECRow!=null && arrECRow.size()>0)
        	{
        		for(i=9;i<=15;i++){
        		arrECCol = (ArrayList)arrECRow.get(i-1);%>
           	<td> 
              <input type="text" maxlength="15" name="txt_year<%=i%>" size="14" onKeyPress="allowNumber(this)"
            	onBlur="roundtxt(this);totalamount();" style="text-align: right" value="<%=Helper.formatDoubleValue(Double.
            			parseDouble(Helper.correctNull((String)arrECCol.get(0))))%>">
            </td>
            <%}}else{
            	for(i=9;i<=15;i++){%>
            	<td> 
              <input type="text" maxlength="15" name="txt_year<%=i%>" size="14" onKeyPress="allowNumber(this)"
				onBlur="roundtxt(this);totalamount();" style="text-align: right" value="0.00">
            </td>
            <%} }%>
            <td> 
              <input type="text" maxlength="15" name="txt_total" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													style="text-align: right" value="">
            </td>
          </tr>
        
        </table>
      </td>
     </tr>
   </table>
   
<% strappno = Helper.correctNull((String) request.getParameter("appno"));%> 
<br>
<lapschoice:combuttonnew
	btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	
<br>

  <input type=hidden name="hidBeanId">
  <input type=hidden name="hidBeanMethod">
  <input type=hidden name="hidBeanGetMethod">
  <input type=hidden name="hidSourceUrl">
  <input type="hidden" name="hidAction">
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
 </form>
</body>
</html>