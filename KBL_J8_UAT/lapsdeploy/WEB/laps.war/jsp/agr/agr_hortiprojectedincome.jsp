<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%request.setAttribute("_cache_refresh", "true");%>
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

			
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	int arrSize=0;
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrPlantDet = new ArrayList();
	ArrayList arrColPlant = new ArrayList();
	int arrPlantDetSize=0;

	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrHortiProjInc");
	}
	if(arrRow!=null)
	{
		arrSize=arrRow.size();
	}
	String strDesc[]={"Year1","Year2","Year3","Year4 ","Year5",
					"Year6","Year7","Year8",
					"Year9","Year10","Year11",
					"Year12","Year13","Year14","15 Year Onward"};
	
	if(hshValues!=null)
	{
		arrPlantDet=(ArrayList)hshValues.get("arrHortiplant");
	}
	if(arrPlantDet!=null)
	{
		arrPlantDetSize=arrPlantDet.size();
	}
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	
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
	
	
		
%>
<html>
<head>
<title>Projected Income</title>
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
var plant_name = "<%=Helper.correctNull((String)hshValues.get("PlantNameInc"))%>";
var yieldingperiod="0";
var unit_cost="0";
var starting_yield="0";
var totacre="0";
var varschemetype="<%=schemetype%>";
function disableEditButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function onloading()
{	  
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	if(plant_name!="")
		document.forms[0].sel_plantNameInc.value=plant_name;
	else
		document.forms[0].sel_plantNameInc.value="s";	
<%
				arrColPlant = new ArrayList();
				
				if (arrPlantDet != null) {
					if (arrPlantDet.size() > 0) {

						for (int i = 0; i < arrPlantDet.size(); i++) {

							arrColPlant = (ArrayList) arrPlantDet.get(i);%>
							var pname		=	"<%=Helper.correctNull((String)arrColPlant.get(1))%>";
							
							
							if(pname==plant_name)
							{
								yieldingperiod = "<%=Helper.correctInt((String)arrColPlant.get(6))%>";
								unit_cost	=	"<%=Helper.correctNull((String)arrColPlant.get(9))%>";	
								starting_yield	=	parseInt("<%=Helper.correctInt((String)arrColPlant.get(7))%>")+parseInt(yieldingperiod);	
								totacre		=	"<%=Helper.correctNull((String)arrColPlant.get(10))%>";
							}
			<%}}}%>
			//clear_readOnly_fields(starting_yield);
			document.forms[0].txt_yieldStart.value=starting_yield;	//Yielding period start
			//document.forms[0].txt_gross.value=unit_cost;
			document.all.grossVal.innerText=roundVal(unit_cost);
			document.all.sel_scheme.disabled=false;
			document.all.sel_scheme.value=varschemetype;
			document.all.hidtotacre.value=totacre;
			disabledFields(true);
			document.forms[0].sel_plantNameInc.disabled=false;
			//if(document.forms[0].hidMakerFlag.value=="Y")
			//{
			//	disableEditButtons(false, true, true, true, true, false);
			//}
			//else
			//{
			//	disableEditButtons(true, true, true, true, true, false);
			//}	
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
	document.forms[0].hidBeanMethod.value="updateHortiProjectedIncome";
	document.forms[0].hidBeanGetMethod.value="getHortiProjectedIncome";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_hortiprojectedincome.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();	
}
function doEdit()
{
	if(document.forms[0].sel_plantNameInc.value=="s")
	{
		alert("Select a plant name");
		return;
	}
	document.forms[0].hidAction.value="Edit";
	
	for(var i=0;i<15;i++)
	{
		document.forms[0].txt_netInc[i].readOnly=true;
		document.forms[0].txt_grossInc[i].readOnly=true;
	}
	document.forms[0].txt_yieldStart.readOnly=true;
	disabledFields(false);
	disableEditButtons(true, false, false, false, false);	
	make_readOnly(starting_yield);

}

function make_readOnly(starting_yield)
{
	
	if(starting_yield>=15)
	{
		for(var j=0;j<14;j++)
		{
			document.forms[0].txt_netInc[j].readOnly=true;
			document.forms[0].txt_grossInc[j].readOnly=true;
			document.forms[0].txt_yield[j].readOnly=true;
			//document.forms[0].txt_maintenance[j].readOnly=true;
		}
	}
	else
	{
		for(var j=0;j<(starting_yield-1);j++)
		{
			document.forms[0].txt_netInc[j].readOnly=true;
			document.forms[0].txt_grossInc[j].readOnly=true;
			document.forms[0].txt_yield[j].readOnly=true;
			//document.forms[0].txt_maintenance[j].readOnly=true;
		}
	}
}
/**function clear_readOnly_fields(starting_yield)
{
	if(starting_yield>=3 && starting_yield<15)
	{
		for(var j=0;j<(starting_yield-3);j++)
		{
			document.forms[0].txt_netInc[j].value="";
			document.forms[0].txt_grossInc[j].value="";
			document.forms[0].txt_yield[j].value="";
			document.forms[0].txt_maintenance[j].value="";
		}
	}
	else if(starting_yield>15)
	{
		for(var j=0;j<12;j++)
		{
			document.forms[0].txt_netInc[j].value="";
			document.forms[0].txt_grossInc[j].value="";
			document.forms[0].txt_yield[j].value="";
			document.forms[0].txt_maintenance[j].value="";
		}
	}
}*/


function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].sel_plantNameInc.value="s";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getHortiProjectedIncome";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_hortiprojectedincome.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(document.forms[0].sel_plantNameInc.value=="s")
	{
		alert("Select a plant name");
		return;
	}
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].hidSourceUrl.value="action/agr_hortiprojectedincome.jsp";	
		document.forms[0].hidBeanMethod.value="updateHortiProjectedIncome";
		document.forms[0].hidBeanGetMethod.value="getHortiProjectedIncome";
		document.forms[0].submit();		
	}
}	


function change_plant()
{
	if(document.forms[0].sel_plantNameInc.value!="s")
	{
    document.forms[0].hidBeanId.value="agrlandholdings";
    document.forms[0].hidBeanGetMethod.value="getHortiProjectedIncome";
    document.forms[0].action=appUrl+"action/agr_hortiprojectedincome.jsp";
	document.forms[0].submit();
	}

  
}
function computeGross()
{
	for(var k=0;k<15;k++)
	{
		var yieldval	=	document.forms[0].txt_yield[k].value;
		if(yieldval=="")
			yieldval=0;
		document.forms[0].txt_grossInc[k].value		=	roundVal(eval(unit_cost) * eval(yieldval));
		
		document.forms[0].txt_grossInc[k].readOnly	=	true;
	}
}
function computeNetInc()
{
	for(var k=0;k<15;k++)
	{
		var grossval	=	document.forms[0].txt_grossInc[k].value;
		if(grossval=="")
			grossval=0;
		var vartotacre	=	document.forms[0].hidtotacre.value;
		if(vartotacre=="")
			vartotacre=0;
		document.forms[0].txt_netInc[k].value	=	roundVal(eval(grossval)	* eval(vartotacre));
		document.forms[0].txt_netInc[k].readOnly	=	true;
	}
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	</head>
<body onload="onloading()">
<form name="frmDSCR" method=post class="normal">
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
<laps:borrowertype /> 
<laps:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Projected Income</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="72" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<br>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align=center>
  <tr> 
      <td height="24" valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="datagrid">
        <tr>
        	<td colspan="2">Name of the plant</td>
        	<td colspan="9"><select name="sel_plantNameInc" onChange="change_plant()">
        						<option value="s">--Select--</option>
        						<laps:AgrHortiPlantNames  schemetype="<%=schemetype%>"/>
        						</select>
        	</td>
        </tr>
        <tr>
        	<td colspan="2">Yielding Period Start</td>
        	<td><input type="text" name="txt_yieldStart" readOnly style="text-align:right"></td>
        </tr>
       	<tr> <td colspan="11" align="right"><b>All Cost Per Acre</b></td>
       	</tr>
          <tr align="center"  class="dataheader"> 
            
            <td width="8%">Year</td>
            <td width="25%">Yield per acre</td>
            <td width="22%" nowrap>Gross Value @&nbsp;Rs. <span id="grossVal"></span>&nbsp;Per 
              Unit</td>
<!--            <td width="22%">Maintenance</td>-->
            <td width="23%">Gross Income</td>
          </tr>
          
          <%for(int i=0;i<15;i++)
				{ 
        	  
        	  	int arrColSize=0;
				if(i<arrSize)
				{
					arrCol=(ArrayList)arrRow.get(i);
					if(arrCol!=null)
						arrColSize=arrCol.size();
				}
        	  if(arrColSize>0)
        	  {
        		  
				%>
          <tr class="datagrid" align="center"> 
            <td nowrap align="left" width="8%"><B><%= strDesc[i]%></B> 
              <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
           </td>
           		
            <td width="25%"> 
              <input type="text" maxlength="15" tabindex="1"
													name="txt_yield" size="20" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeGross();computeNetInc()"
													style="text-align: right" value="<%=Helper.checkDecimal((String)arrCol.get(4))%>">
            </td>
            <td width="22%"> 
              <input type="text" maxlength="15" tabindex="2"
													name="txt_grossInc" size="20" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this)"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(5))%>">
            </td>
<!--            <td width="22%"> 
              <input type="text" maxlength="15" tabindex="3"
													name="txt_maintenance" size="20" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeNetInc()"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(6))%>">
           </td>-->
            <td width="23%"> 
              <input type="text" maxlength="15" tabindex="4"
													name="txt_netInc" size="20" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right" value="<%=Helper.checkDecimal((String)arrCol.get(7))%>">
            </td>
           
          </tr>
          <%}else{
        %>
        <tr class="datagrid" align="center"> 
         	
            <td nowrap align="left" width="8%"><B><%= strDesc[i]%></B> 
              <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
           </td>
           	
            <td width="25%"> 
              <input type="text" maxlength="15" tabindex="1"
													name="txt_yield" size="20" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);computeGross();computeNetInc()"
													style="text-align: right" value="">
            </td>
            <td width="22%"> 
              <input type="text" maxlength="15" tabindex="2"
													name="txt_grossInc" size="20" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);"
													style="text-align: right" value="">
            </td>
<!--            <td width="22%"> 
              <input type="text" maxlength="15" tabindex="3"
													name="txt_maintenance" size="20" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeNetInc()"
													style="text-align: right" value="">
          </td>-->
            <td width="23%"> 
              <input type="text" maxlength="15" tabindex="4"
													name="txt_netInc" size="20" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);"
													style="text-align: right" value="">
            </td>
            
            
          </tr>
        
        
        
          <%}
       } %>
          
        </table>
      </td>
        </tr>
      </table>
   
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="1">
	<tr valign="top">
		<td>	<laps:combuttonnew
	btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /></td>
	</tr>
</table>
		</td>
	</tr>
</table>
  <input type=hidden name="hidBeanId">
  <input type=hidden name="hidBeanMethod">
  <input type=hidden name="hidBeanGetMethod">
  <input type=hidden name="hidSourceUrl">
  <input type="hidden" name="hidAction">
<input type="hidden" name="hid_pagename" value=""> 
<input type="hidden" name="hidtotacre" value=""> 
<input type="hidden" name="hidAppType" value="<%=Helper.correctNull((String) hshValues.get("hidAppType"))%>">
 </form>
</body>
</html>