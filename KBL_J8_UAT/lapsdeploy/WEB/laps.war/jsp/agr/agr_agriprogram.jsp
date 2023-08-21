<%@include file="../share/directives.jsp"%>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
    String strAppno=Helper.correctNull((String)request.getParameter("appno")) ;
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
	String strFarmcategory=Helper.correctNull((String)hshValues.get("strFarmcategory"));
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMinimumFractionDigits(2);
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
	}

	%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
</head>
<script type="text/javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var schemetype="<%=schemetype%>";
var vartotprojcost = "<%=Helper.correctDouble((String)hshValues.get("totalprojectcost"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function onloading()
{	
	disabledFields(true);
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	document.forms[0].cmdcomments.disabled=false;
	calcmargin();	
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	clearFields();
	disabledFields(false);
	disableEditButtons(true, true, false, false, true,false,false);
	document.forms[0].txt_unitcost.readOnly=true;
	document.forms[0].txt_unitcostto.readOnly=true;
	document.forms[0].txt_consbankloan.readOnly=true;
	
}
function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
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
	document.forms[0].txt_totalcost.readOnly=true;
	document.forms[0].txt_bankloan.readOnly=true;
	document.forms[0].txt_activityname.readOnly=true;
}
function disableEditButtons(bool1, bool2, bool3, bool4, bool5, bool6, bool7)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdcomments.disabled=bool6;
	document.forms[0].cmdclose.disabled=bool7;
}
function clearFields()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].value="";
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].value="";
		}	   
	}
}
function calcTotCost()
{
	var var_cost=document.forms[0].txt_unitcost.value;
	var var_costapt=document.forms[0].txt_unitadptcost.value;
	var var_whetherunitcostavail=document.forms[0].txt_activityavail.value;
	var var_maxunitcostmas=document.forms[0].txt_unitcostto.value;
	var var_area=document.forms[0].txt_area.value;
	if(var_cost=="")var_cost=0.00;
	if(var_area=="")var_area=0.00;	
	if(var_costapt=="")var_costapt=0.00;
	if(var_maxunitcostmas=="")var_maxunitcostmas=0.00;	
	if(document.forms[0].hidavail2.value=="Y")
	{
		if(parseFloat(document.forms[0].txt_unitadptcost.value)>parseFloat(document.forms[0].txt_unitcostto.value))
		{
			alert("Unit Cost Adopted by branch cannot be greater than Unit Cost as per master");
			//document.forms[0].txt_unitadptcost.focus();
			document.forms[0].txt_unitadptcost.value="";
			return;
		}
		if(parseFloat(document.forms[0].txt_unitadptcost.value)< parseFloat(document.forms[0].txt_unitcost.value))
		{
			alert("Unit Cost Adopted by branch cannot be Lesser than Unit Cost as per master");
			//document.forms[0].txt_unitadptcost.focus();
			document.forms[0].txt_unitadptcost.value="";
			return;
		}
	}
	var var_mincost="";
	if(var_whetherunitcostavail == "Y")
	{
		var_mincost=Math.min(var_maxunitcostmas,var_costapt);
	}
	else
	{
		var_mincost=var_costapt;
	}
	if(var_mincost=="")var_mincost=0.00;
	var var_totcost=eval(var_mincost)*eval(var_area);
	if(var_totcost=="")var_totcost=0.00;	
	document.forms[0].txt_totalcost.value=var_totcost;
	roundtxt(document.forms[0].txt_totalcost);
	var var_margin=document.forms[0].txt_margin.value;
	if(var_margin=="")var_margin=0.00;	
		var var_bankloan=eval(var_totcost)-(eval(var_totcost)*eval(var_margin))/100;
		document.forms[0].txt_bankloan.value=var_bankloan;
		roundtxt(document.forms[0].txt_bankloan);
}


function calcTotCostAdtbranch()
{
	var var_cost=document.forms[0].txt_unitcost.value;
	var var_costapt=document.forms[0].txt_unitadptcost.value;
	var var_whetherunitcostavail=document.forms[0].txt_activityavail.value;
	var var_maxunitcostmas=document.forms[0].txt_unitcostto.value;
	var var_area=document.forms[0].txt_area.value;
	//alert("================"+document.forms[0].hidpercentageper.value);
	var percentage=document.forms[0].hidpercentageper.value;
	var unitadptcost=document.forms[0].txt_unitadptcost.value;
	var var_maxunitcostmasper=parseFloat(var_maxunitcostmas*percentage/100);
	var_maxunitcostmas=parseFloat(var_maxunitcostmas+var_maxunitcostmasper);
	if(var_cost=="")var_cost=0.00;
	if(var_area=="")var_area=0.00;	
	if(var_costapt=="")var_costapt=0.00;
	if(var_maxunitcostmas=="")var_maxunitcostmas=0.00;	
	if(document.forms[0].hidavail2.value=="Y")
	{
		if(parseFloat(unitadptcost)>parseFloat(var_maxunitcostmas))
		{
			alert("Unit Cost Adopted by branch cannot be greater than Unit Cost as per master");
			//document.forms[0].txt_unitadptcost.focus();
			document.forms[0].txt_unitadptcost.value="";
			return;
		}
		if(parseFloat(unitadptcost)< parseFloat(var_cost))
		{
			alert("Unit Cost Adopted by branch cannot be Lesser than Unit Cost as per master");
			//document.forms[0].txt_unitadptcost.focus();
			document.forms[0].txt_unitadptcost.value="";
			return;
		}
	}
	var var_mincost="";
	if(var_whetherunitcostavail == "Y")
	{
		var_mincost=Math.min(var_maxunitcostmas,var_costapt);
	}
	else
	{
		var_mincost=var_costapt;
	}
	if(var_mincost=="")var_mincost=0.00;
	var var_totcost=eval(var_mincost)*eval(var_area);
	if(var_totcost=="")var_totcost=0.00;	
	document.forms[0].txt_totalcost.value=var_totcost;
	roundtxt(document.forms[0].txt_totalcost);
	var var_margin=document.forms[0].txt_margin.value;
	if(var_margin=="")var_margin=0.00;	
		var var_bankloan=eval(var_totcost)-(eval(var_totcost)*eval(var_margin))/100;
		document.forms[0].txt_bankloan.value=var_bankloan;
		roundtxt(document.forms[0].txt_bankloan);
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanGetMethod.value="getFinProgramme";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agr_agriprogram.jsp";
		document.forms[0].submit();
	}
}
function callActivityHelp(schemeType)
{
	var Type="";
	var appno="<%=strAppno%>";
	if(document.forms[0].cmdsave.disabled==false)
	{
		
			var varQryString = appURL+"action/com_activityhelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getActivityList&appno="+appno;
			var title = "ActivitySearch";
			var prop = "scrollbars=yes,width=700,height=430,status=yes";	
			prop = prop + ",left=50,top=50";		
			window.open(varQryString,title,prop);
		 
	}
}
function doSave()
{	
	if(document.forms[0].sel_year.value=="")
	{
		alert("Select Programme Year")
		document.forms[0].sel_year.focus();
		return;
	}
	if(document.forms[0].txt_activitycode.value=="")
	{
		alert("Enter Activity")
		document.forms[0].txt_activitycode.focus();
		return;
	}
	if(document.forms[0].sel_units.value=="")
	{
		alert("Select Units")
		document.forms[0].sel_units.focus();
		return;
	}
	if(document.forms[0].txt_area.value=="" || document.forms[0].txt_area.value=="0" || document.forms[0].txt_area.value=="0.00")
	{
		alert("Enter the No.")
		document.forms[0].txt_area.focus();
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="bankappfi";
	document.forms[0].hidSourceUrl.value="/action/agr_agriprogram.jsp";
	document.forms[0].hidBeanMethod.value="updateAgriProgramme";
	document.forms[0].hidBeanGetMethod.value="getFinProgramme";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function selectvalues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,txt_spec)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].sel_year.value=val2;
	document.forms[0].txt_activitycode.value=val3;
	document.forms[0].txt_unitcost.value=val4;
	document.forms[0].txt_area.value=val5;
	document.forms[0].txt_totalcost.value=val6;
	document.forms[0].txt_margin.value=val7;
	document.forms[0].txt_bankloan.value=val8;
	document.forms[0].txt_unitadptcost.value=val9;
	document.forms[0].txt_activityname.value=val10;
	document.forms[0].sel_units.value=val13;
	document.forms[0].txt_unitcostto.value=val14;
	document.forms[0].hidavail2.value=val15;
	document.forms[0].txt_spec.value=txt_spec;
	
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
	disableEditButtons(true, false, true, false, false,false,false);
	}
	
}
function doEdit()
{
	disabledFields(false);
	document.forms[0].hidAction.value ="update";
	disableEditButtons(true, true, false, false, false,false,true);
	document.forms[0].txt_unitcost.readOnly=true;
	document.forms[0].txt_unitcostto.readOnly=true;
	document.forms[0].txt_consbankloan.readOnly=false;
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidSourceUrl.value="action/agr_agriprogram.jsp";	
		document.forms[0].hidBeanMethod.value="updateAgriProgramme";
		document.forms[0].hidBeanGetMethod.value="getFinProgramme";
		document.forms[0].submit();	
			
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidDemoId=document.forms[0].hidDemoId.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidDemoId+"&hidCommentPage=physicalfin&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function calcmargin()
{
	var varconsbl = document.forms[0].txt_consbankloan.value;
	var varconstmarg = 	(parseFloat(varconsbl) / parseFloat(vartotprojcost)*100);
	varconstmarg = roundVal(NanNumber(parseFloat(100.00 - varconstmarg)));
	if(varconstmarg=="")
	{
		document.all.id_margin.innerText = document.forms[0].hidmargin.value;
	}
	else
	{
		document.all.id_margin.innerText = varconstmarg;
	}
}

function callSpecificaHelp(schemeType)
{
	alert("1");
	var Type="";
	var appno="<%=strAppno%>";
	var actname=document.forms[0].txt_activityname.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
		//com_activityhelp
			var varQryString = appURL+"action/com_specificationshelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getActivityList&appno="+appno+"&actname="+actname;
			var title = "ActivitySearch";
			var prop = "scrollbars=yes,width=700,height=430,status=yes";	
			prop = prop + ",left=50,top=50";		
			window.open(varQryString,title,prop);
		 
	}
}
</script>
<body onload="onloading()">
<form  method="post" class="normal">
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Application -> Physical and Financial Programme</td>
	</tr>
</table>
<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="51" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table><br>
<table width="95%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
						<tr class="dataHeader">
                        <td align="center" rowspan="2">Programme Year</td>
                        <td align="center" rowspan="2">Activity </td>
                        <td align="center" rowspan="2">Specification </td>
                        <td align="center" rowspan="2">Units</td>
                        <td align="center" rowspan="2">No.</td>
                        <td align="center" colspan="2">Unit Cost as per Master</td>
                        <td align="center" rowspan="2">Unit Cost Adopted by branch</td>
                        <td align="center" rowspan="2">Total Cost </td>
                        <td align="center" rowspan="2">Margin (%)</td>
                        <td align="center" rowspan="2">Bank Loan </td>
                        </tr>
                        
                        <tr class="dataHeader">
                        <td align="center">Amount From</td>
                        <td align="center">Amount To</td>
                        </tr>
                        
                        
                        
                        
                        <tr class="dataGrid">
                        <td align="center">
                        <select name="sel_year">
                    <lapschoice:FinYearTenorTag/>
                        </select>
                        </td>
                        <td align="center" nowrap="nowrap"><input type="text" name="txt_activityname" size="25" />
                        <input type="hidden" name="txt_activitycode">    <input type="hidden" name="txt_activityavail">
                        <span onClick="callActivityHelp('<%=schemetype%>')" style="cursor: hand">
                        <img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="2"></span>
                        </td>
                        <td align="center"><input type="text" name="txt_spec"> 
                        <input type="hidden" name="txt_speccode"> 
                        <input type="hidden" name="txt_specfiavail">
                        <span onClick="callSpecificaHelp('<%=schemetype%>')" style="cursor: hand">
                        <img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="3"></span>
                         <td align="center"><select name="sel_units"><lapschoice:StaticDataNewTag apptype="121"/></select></td>
                          <td align="center"><input type="text" name="txt_area" onblur="calcTotCost();"  style="text-align: right"  size="15" onkeypress="allowNumber(this)" /></td>
                        <td align="center"><input type="text" name="txt_unitcost" onblur="calcTotCost();roundtxt(this);" style="text-align: right" size="15" onkeypress="allowNumber(this)"/></td>
                          <td align="center"><input type="text" name="txt_unitcostto" onblur="calcTotCost();roundtxt(this);" style="text-align: right" size="15" onkeypress="allowNumber(this)"/></td>
                        <td align="center"><input type="text" name="txt_unitadptcost" onblur="calcTotCost(); calcTotCostAdtbranch();roundtxt(this);" style="text-align: right" size="15" onkeypress="allowNumber(this)"/></td>
                        <td align="center"><input type="text" name="txt_totalcost" onblur="calcTotCost();roundtxt(this);"   style="text-align: right" size="15" onkeypress="allowNumber(this)"/></td>
                          <td align="center"><input type="text" name="txt_margin" onblur="calcTotCost();roundtxt(this);checkPercentage(this)"   style="text-align: right" size="15" onkeypress="allowNumber(this)"/></td>
                            <td align="center"><input type="text" name="txt_bankloan" onblur="calcTotCost();roundtxt(this);"  style="text-align: right"  size="15" /></td>
                        </tr>
                        </table><br>
                       <lapschoice:combuttonnew
	btnnames="New_Edit_Save_Cancel_Delete_Comments_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	
	<br>
<table width="95%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
	<tr class="dataheader">
		<td width="5%" align="center"  rowspan="2">Programme Year</td>
		<td width="15%" align="center" rowspan="2">&nbsp;Activity Name</td>
		 <td align="center" rowspan="2">Specification </td>
		<td width="5%" align="center" rowspan="2">&nbsp;Units</td>
		<td width="5%" align="center" rowspan="2">&nbsp;No.</td>
		<td width="20%" align="center" colspan="2">&nbsp;Unit Cost as per Master</td>
		<td width="10%" align="center" rowspan="2">&nbsp;Unit Cost adopted by branch</td>
		<td width="10%" align="center" rowspan="2">&nbsp;Total cost</td>
		<td width="12%" align="center" rowspan="2">&nbsp;Margin (%)</td>
		<td width="13%" align="center" rowspan="2">&nbsp;Bank Loan</td>
	</tr>
	
	<tr class="dataheader">
		<td align="center">Amount From</td>
		<td align="center">Amount To</td>
	</tr>
	<%
	
	if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
		arrCol = (ArrayList)arrRow.get(i);
		
		if(Helper.correctNull((String)arrCol.get(8)).equalsIgnoreCase("0")){
	%>

	<tr class="datagrid"><td colspan="8"> </td></tr>
	<tr class="datagrid">
		<td width="5%" align="center">
		
		<INPUT TYPE="radio" NAME="rd_butt" VALUE="" border="0" style="border: none;"
		onclick="selectvalues('<%=Helper.correctNull((String)arrCol.get(0))%>',
		'<%=Helper.correctNull((String)arrCol.get(1))%>',
		'<%=Helper.correctNull((String)arrCol.get(2))%>',
		'<%=Helper.correctNull((String)arrCol.get(3))%>',
		'<%=Helper.correctNull((String)arrCol.get(4))%>',
		'<%=Helper.correctNull((String)arrCol.get(5))%>',
		'<%=Helper.correctNull((String)arrCol.get(6))%>',
		'<%=Helper.correctNull((String)arrCol.get(7))%>',
		'<%=Helper.correctNull((String)arrCol.get(9))%>',
		'<%=Helper.correctNull((String)arrCol.get(10))%>',
		'<%=Helper.correctNull((String)arrCol.get(11))%>',
		'<%=Helper.correctNull((String)arrCol.get(8))%>','<%=Helper.correctNull((String)arrCol.get(13))%>','<%=Helper.correctNull((String)arrCol.get(14))%>',
		'<%=Helper.correctNull((String)arrCol.get(15))%>',
		'<%=Helper.correctNull((String)arrCol.get(16))%>')"><b>Year <%=Helper.correctNull((String)arrCol.get(1))%></b></td>
		<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
		<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(16))%></td>
		<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(12))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(14))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(9))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
		<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>	
	</tr>
	
	<%}
		
		else
		{ %>
			<tr class="datagrid">
			<td width="5%" align="center">Year<%=Helper.correctNull((String)arrCol.get(1))%>&nbsp;
			</td>
			<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(10))%></td>
			<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(16))%></td>
			<td  align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(12))%></td>
			<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
			<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
			<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(14))))%></td>
			<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(9))))%></td>
			<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
			<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
			<td align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))%></td>	
		</tr>
		
		
		<%}}} %>
	
	<tr class="dataheader">
		<td colspan="8" align="right"><b>Total cost of the project : <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalprojectcost"))))%></b></td>
		<td  align="right"><b>Margin to Proj cost: <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalmarg"))))%>%</b></td>
		<td  align="right"><b>Total Bank Loan : <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalbankloan")))) %></b></td>
		</tr>
		
		
		<tr class="dataheader">
		<td colspan="8" align="right"><b>Margin :<span id="id_margin"></span> %</b>
		<td  align="right"><b>Recommended Bank Loan :</b></td>
		<td  align="right"><input type="text" name="txt_consbankloan" onkeypress="allowNumber(this)"  onblur="roundtxt(this);calcmargin();" style="text-align: right;" value="<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("consbl")))%>"></td>
		</tr>
	
	
</table>
<br>
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidsno">      
<input type="hidden" name="hidcount">      
<input type="hidden" name="hiddesc2">      
<input type="hidden" name="hidamt2">     
<input type="hidden" name="hidavail2">     
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>" >
<input type="hidden" name="hidmargin" value="<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("consmargin")))%>">
<input type="hidden" name="hid_subvention" value="<%=Helper.correctNull((String)request.getParameter("hid_subvention"))%>">
<input type="hidden" name="hidpercentageper">  
</form>
</body>
</html>