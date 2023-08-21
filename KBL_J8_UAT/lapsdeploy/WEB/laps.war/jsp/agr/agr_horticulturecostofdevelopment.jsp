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
		arrRow=(ArrayList)hshValues.get("arrHorti");
	}
	if(arrRow!=null)
	{
		arrSize=arrRow.size();
	}
	String strDesc[]={"Preparation of land","Digging pits","Filling back of pits",
					"Cost of plant Material",
					"Planting and staking","Irrigation",
					"Manures and Fertilizers","Inter-Culture Operations","Plant Protection","Inter-crops",
					"Fencing","","","","Total Cost Per hectare"};
	
	
	
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
var yieldingperiod="0";
var varschemetype="<%=schemetype%>";
function onloading()
{	  

	disabledFields(true);
	// callbuttonStatus(document.forms[0].hidUsrMode, document.forms[0].hidWorkflowStatus, 'Edit',document.forms[0].hidWorkflowId);
	for(var i=0;i<15;i++)
	{
		computeRowTotal(i);
	}
	if(plant_name!="")
		document.forms[0].sel_plantName.value=plant_name;
	else
		document.forms[0].sel_plantName.value="s";
	document.forms[0].sel_plantName.disabled=false;
	var varpalntMaterial=0;

<%
				arrColPlant = new ArrayList();
				
				if (arrPlantDet != null) {
					if (arrPlantDet.size() > 0) {

						for (int i = 0; i < arrPlantDet.size(); i++) {

							arrColPlant = (ArrayList) arrPlantDet.get(i);%>
							var pname		=	"<%=Helper.correctNull((String)arrColPlant.get(1))%>";
							
							if(pname==plant_name)
							{
								yieldingperiod = "<%=Helper.correctNull((String)arrColPlant.get(6))%>";
								varpalntMaterial="<%=((FwHelper.parseDouble(Helper.correctDouble((String)arrColPlant.get(5))))*(FwHelper.parseDouble(Helper.correctDouble((String)arrColPlant.get(3)))))%>";
								<% //yield_period	= Integer.parseInt(Helper.correctInt((String)arrColPlant.get(6)));	%>
							}
			<%}}}%>
			document.forms[0].txt_year1[3].value=roundVal(varpalntMaterial);
			document.all.sel_scheme.disabled=false;
			document.all.sel_scheme.value=varschemetype;


			//if(document.forms[0].hidMakerFlag.value=="Y")
			//{
			//	disableEditButtons(false, true, true, true, false, false);	
			//}
			//else
			//{
			//	disableNewButtons(true, true, true, true, true, false);
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
	document.forms[0].hidBeanMethod.value="updateHortiCostOfDevelopmentDetails";
	document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_horticulturecostofdevelopment.jsp";
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
	for(var i=0;i<15;i++)
	{
		document.forms[0].txt_total[i].readOnly=true;
	}
	disableEditButtons(true, false, false, false, false);	
	getVisibleYears(yieldingperiod);	
	<%for(int i=1;i<=7;i++){%>
	document.forms[0].txt_year<%=i%>[3].readOnly=true;;
	<%}%>
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

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].sel_plantName.value="s";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
		document.forms[0].hidBeanId.value="agrlandholdings";
		document.forms[0].action=appUrl+"action/agr_horticulturecostofdevelopment.jsp";
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
		document.forms[0].hidSourceUrl.value="action/agr_horticulturecostofdevelopment.jsp";	
		document.forms[0].hidBeanMethod.value="updateHortiCostOfDevelopmentDetails";
		document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
		document.forms[0].submit();		
	}
}	

function computeRowTotal(id)
{
	var year1 = document.forms[0].txt_year1[id].value;
	var year2 = document.forms[0].txt_year2[id].value;
	var year3 = document.forms[0].txt_year3[id].value;
	var year4 = document.forms[0].txt_year4[id].value;
	var year5 = document.forms[0].txt_year5[id].value;
	var year6 = document.forms[0].txt_year6[id].value;
	var year7 = document.forms[0].txt_year7[id].value;
	var tot1=0.0,tot2=0.0,tot3=0.0,tot4=0.0,tot5=0.0,tot6=0.0,tot7=0.0,tot8=0.0;
	
	var tot=0.0;
	
	if((year1=="")||(year1=="NaN.00"))
	{
		year1 =0.00;
	}
	if((year2=="")||(year2=="NaN.00"))
	{
		year2 =0.00;
	}
	if((year3=="")||(year3=="NaN.00"))
	{
		year3 =0.00;
	}
	if((year4=="")||(year4=="NaN.00"))
	{
		year4 =0.00;
	}
	if((year5=="")||(year5=="NaN.00"))
	{
		year5 =0.00;
	}
	if((year6=="")||(year6=="NaN.00"))
	{
		year6 =0.00;
	}
	if((year7=="")||(year7=="NaN.00"))
	{
		year7 =0.00;
	}
	
	tot = eval(year1) + eval(year2) + eval(year3) + eval(year4) + eval(year5) + eval(year6)+ eval(year7);
	document.forms[0].txt_total[id].value= roundVal(tot);
	
	for(var j=0;j<14;j++)
	{
		var y1	=	document.forms[0].txt_year1[j].value;
		if(y1=="")
			y1=0;
		tot1=eval(tot1)+eval(y1);

		var y2	=	document.forms[0].txt_year2[j].value;
		if(y2=="")
			y2=0;
		tot2=eval(tot2)+eval(y2);

		var y3	=	document.forms[0].txt_year3[j].value;
		if(y3=="")
			y3=0;
		tot3=eval(tot3)+eval(y3);

		var y4	=	document.forms[0].txt_year4[j].value;
		if(y4=="")
			y4=0;
		tot4=eval(tot4)+eval(y4);

		var y5	=	document.forms[0].txt_year5[j].value;
		if(y5=="")
			y5=0;
		tot5=eval(tot5)+eval(y5);

		var y6	=	document.forms[0].txt_year6[j].value;
		if(y6=="")
			y6=0;
		tot6=eval(tot6)+eval(y6);

		var y7	=	document.forms[0].txt_year7[j].value;
		if(y7=="")
			y7=0;
		tot7=eval(tot7)+eval(y7);
		
	}
	document.forms[0].txt_year1[14].value = roundVal(tot1);
	document.forms[0].txt_year2[14].value = roundVal(tot2);
	document.forms[0].txt_year3[14].value = roundVal(tot3);
	document.forms[0].txt_year4[14].value = roundVal(tot4);
	document.forms[0].txt_year5[14].value = roundVal(tot5);
	document.forms[0].txt_year6[14].value = roundVal(tot6);
	document.forms[0].txt_year7[14].value = roundVal(tot7);

	document.forms[0].txt_year1[14].readOnly	=	true;
	document.forms[0].txt_year2[14].readOnly	=	true;
	document.forms[0].txt_year3[14].readOnly	=	true;
	document.forms[0].txt_year4[14].readOnly	=	true;
	document.forms[0].txt_year5[14].readOnly	=	true;
	document.forms[0].txt_year6[14].readOnly	=	true;
	document.forms[0].txt_year7[14].readOnly	=	true;
}
function change_plant()
{
	if(document.forms[0].sel_plantName.value!="s")
	{
    document.forms[0].hidBeanId.value="agrlandholdings";
    document.forms[0].hidBeanGetMethod.value="getHortiCostOfDevelopmentDetails";
    document.forms[0].action=appUrl+"action/agr_horticulturecostofdevelopment.jsp";
	document.forms[0].submit();
	}
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
<br>

<table width="98%" border="0" cellspacing="0" cellpadding="3"	class="normal" align="center">
  <tr> 
      <td height="24" valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="datagrid">
        <tr>
        	<td colspan="2">Name of the plant</td>
        	<td colspan="9"><select name="sel_plantName" onChange="change_plant()">
        						<option value="s">--Select--</option>
        							<lapschoice:AgrHortiPlantNames schemetype="<%=schemetype%>"/>
        						</select>
        	</td>
        </tr>
       	<tr> <td colspan="11">&nbsp;</td>
       	</tr>
          <tr align="center"  class="dataheader"> 
            <td rowspan="2"  width="3%">No</td>
            <td rowspan="2">Items Of Expenditure</td>
            <td colspan="7">Cost/Year (Rs.)</td>
            
			
			<td rowspan="2">Total</td>
          </tr>
          <tr align="center"  class="dataheader">
            <td> Year I</td>
            <td>Year II</td>
            <td>Year III</td>
            <td>Year IV</td>
            <td>YearV</td>
            <td>Year VI</td>
            <td>Year VII</td>
           
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
          	<%if(i==14){ %>
          	<td>&nbsp;</td>
          	<%}else{ %>
          	
         	 <td nowrap align="center" width="3%"><%= i+1%> </td>
         	 <%} %>
         	 <% if(i<11 || i>13)
         		 {
         		 %>
            <td nowrap align="left"><%= strDesc[i]%> 
            <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
           </td>
           		<%} else{%>
           			<td align="left"><input type="text" maxlength="100" name="txt_desc" size="20" align="left" onKeyPress="notAllowSingleAndDoubleQuote()"
           			 value="<%=Helper.correctNull((String)arrCol.get(3)) %>"></td>
           		
          <%}  %> 
            <td> 
              <input type="text" maxlength="15" tabindex="1"
													name="txt_year1" size="14" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="<%=Helper.checkDecimal((String)arrCol.get(4))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="2"
													name="txt_year2" size="14" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>)"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(5))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="3"
													name="txt_year3" size="14" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>)"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(6))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="4"
													name="txt_year4" size="14" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>)"
													style="text-align: right" value="<%=Helper.checkDecimal((String)arrCol.get(7))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="5"
													name="txt_year5" size="13" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>)"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(8))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="6"
													name="txt_year6" size="13" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>)"
													style="text-align: right" value="<%=Helper.checkDecimal((String) arrCol.get(9))%>">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="7"
													name="txt_year7" size="13" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>)"
													style="text-align: right" value="<%=Helper.checkDecimal((String)arrCol.get(10))%>">
            </td>
            
            <td> 
              <input type="text" maxlength="15" tabindex="9"
													name="txt_total" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													style="text-align: right" value="">
            </td>
          </tr>
          <%}else{
        %>
        <tr class="datagrid" align="center"> 
        	<%if(i==14){ %>
          	<td>&nbsp;</td>
          	<%}else{ %>
         	 <td nowrap align="center" width="3%"><%= i+1%> </td>
         	 <%} %>
         	 
         	 
         	  <% if(i<11 || i>13)
         		 {
         		 %>
            <td nowrap align="left"><%= strDesc[i]%> 
            <input type="hidden" name="txt_desc" value="<%= strDesc[i]%>">
           </td>
           		<%} else{%>
           			<td align="left"><input type="text" maxlength="100" name="txt_desc"  size="20" align="left" onKeyPress="notAllowSingleAndDoubleQuote()"></td>
           		
          <%}  %> 
         	 
            <td> 
              <input type="text" maxlength="15" tabindex="1"
													name="txt_year1" size="14" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="2"
													name="txt_year2" size="14" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="3"
													name="txt_year3" size="14" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="4"
													name="txt_year4" size="14" onKeyPress="allowNumber(this)"
														 onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="5"
													name="txt_year5" size="13" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="6"
													name="txt_year6" size="13" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="">
            </td>
            <td> 
              <input type="text" maxlength="15" tabindex="7"
													name="txt_year7" size="13" onKeyPress="allowNumber(this)" 
													onBlur="roundtxt(this);computeRowTotal(<%=i%>);"
													style="text-align: right" value="">
            </td>
            
            <td> 
              <input type="text" maxlength="15" tabindex="9"
													name="txt_total" size="15" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"
													style="text-align: right" value="">
            </td>
          </tr>
        
        
        
          <%}
       } %>
          
        </table>
      </td>
        </tr>
      </table>
   <%
	strappno = Helper.correctNull((String) request
			.getParameter("appno"));
%> 
	
	
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