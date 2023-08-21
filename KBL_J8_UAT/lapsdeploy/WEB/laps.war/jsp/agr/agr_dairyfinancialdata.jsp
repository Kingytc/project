<%@include file="../share/directives.jsp"%>
<%@ page import="com.sai.fw.management.utils.*"%>
<%@ page import="com.sai.laps.helper.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%
	String strappno = FwHelper.correctNull((String) request
			.getParameter("appno"));
String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
String strFacSNo=Helper.getfacilitySno(schemetype);
String strAnimaltype =Helper.correctNull((String)hshValues.get("animaltype"));
%>
<html>
<head>
<title>Financial Data</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var schemetype="<%=schemetype%>";
function onloading()
{
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
				disableCmdButtons(false, true, true, true, false);
		}
		else
		{
			disableCmdButtons(true, true, true, true, false);
		}
	}
	else
	{
		disableCmdButtons(true, true, true, true, false);
	}
	
	disabledFields(true);
}
function doEdit()
{
	disabledFields(false);
	disableCmdButtons(true, false, false, false, true);
}
function doSave()
{
	disableCmdButtons(true, true, true, true, false);
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidBeanId.value = "agrnursery";
	document.forms[0].hidBeanMethod.value = "updateDairyFinancialData";
	document.forms[0].hidBeanGetMethod.value = "getDairyFinancialData";
	document.forms[0].action = appUrl + "controllerservlet";
	document.forms[0].hidSourceUrl.value = "/action/agr_dairyfinancialdata.jsp";
	document.forms[0].method = "post";
	document.forms[0].submit();
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value = "getDairyFinancialData";
		document.forms[0].hidBeanId.value = "agrnursery";
		document.forms[0].action = appUrl+ "action/agr_dairyfinancialdata.jsp";
		document.forms[0].submit();
	}
}
function doDelete() 
{
	if (ConfirmMsg(101))
	{
		document.forms[0].hidAction.value = "delete";
		document.forms[0].action = appUrl + "action/ControllerServlet";
		document.forms[0].hidBeanId.value = "agrnursery";
		document.forms[0].hidSourceUrl.value = "action/agr_dairyfinancialdata.jsp";
		document.forms[0].hidBeanMethod.value = "updateDairyFinancialData";
		document.forms[0].hidBeanGetMethod.value = "getDairyFinancialData";
		document.forms[0].submit();
	}
}
function disableCmdButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
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
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<form name="frmpri" method="post" class="normal">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
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
		<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Agriculture -&gt; Financial Data</td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="129" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<br>
<table width="98%" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
			<tr class="dataheader">

				<td colspan="4"><b>Income Details </b></td>
			</tr>
			<tr class="datagrid">

				<td width="34%">Sale Price of Milk per ltr.</td>

				<td width="16%"><laps:CurrencyTag name="txt_milkcostperltr"
					tabindex="4" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_milkcost"))%>' size="15" maxlength="18"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
				<td width="34%">Sale of Manure per <%=strAnimaltype%></td>

				<td width="16%"><laps:CurrencyTag name="txt_manurecost"
					tabindex="4" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_manurecost"))%>' size="15" maxlength="18"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
			</tr>
			<tr class="datagrid">
				<td width="34%">Sale Price of Each <%=strAnimaltype%></td>

				<td width="16%"><laps:CurrencyTag name="txt_buffaloecost"
					tabindex="5" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_buffaloecost"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
				<td colspan="2">&nbsp;</td>
			</tr>
		</table>

		</td>
	</tr>
	<tr>
		<td>

		<table width="100%" border="0" cellspacing="0" cellpadding="5">
			<tr class="dataheader">
				<td colspan="4"><b>Expenses Details </b></td>
			</tr>
			<tr class="datagrid">

				<td width="34%">Expenses on Veterianary Aid / Adult / Year</td>

				<td width="16%"><laps:CurrencyTag name="txt_expvetaidadult"
					tabindex="4" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_adult_vetaid"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
				<td width="34%">Expenses on Veterianary Aid / Heifer / Year</td>

				<td width="16%"><laps:CurrencyTag name="txt_expvetaidheifer"
					tabindex="4" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_heifer_vetaid"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
			</tr>
			<tr class="datagrid">
				<td width="34%">Electricity &amp; Other Misc expenses Per Month</td>

				<td width="16%"><laps:CurrencyTag name="txt_expelectricity"
					tabindex="5" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_electric_cost"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
				<td width="34%">Cost of Concentrate Feed/Heifer/Year</td>

				<td width="16%"><laps:CurrencyTag name="txt_heiferfeedcost"
					tabindex="5" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_heifer_feedcost"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
			</tr>
			<tr class="datagrid">
				<td width="34%">No of Labourers</td>
				<td width="16%"><input type="text" name="txt_nooflabour"
					tabindex="11" value="<%=Helper.correctInt((String)hshValues.get("agr_findata_labour_count"))%>" size="10" maxlength="9"
					onKeyPress="allowInteger();"style="text-align: right"></td>
					<td width="34%">Cost of Fodder/Heifer/Year</td>

				<td width="16%"><laps:CurrencyTag name="txt_heiferfoddercost"
					tabindex="5" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_heifer_foddercost"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td></tr>
			<tr class="datagrid">
            	<td width="34%">Salary /Month/labourers</td>
				<td width="16%"><laps:CurrencyTag name="txt_laboursalary"
					tabindex="12" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_labour_salary"))%>' size="15" maxlength="8"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5">

			<tr class="dataheader" align="center">
				<td width="31%">Fodder Type</td>
				<td width="28%">Green fodder</td>
				<td width="15%">Dry fodder</td>
				<td width="26%">Concentrate Type</td>
			</tr>
			<tr class="datagrid" align="center">
				
            <td width="31%" align="left" height="33"><b>Feeding quantity/day during lactation days</b></td>
				
            <td width="28%" height="33">
<input type="text" name="txt_lactgreenfodderwt"
					tabindex="13" value="<%=Helper.correctInt((String)hshValues.get("agr_findata_lact_grnfodderwt"))%>" size="10" maxlength="6"
					onKeyPress="allowNumber(this);"onBlur="roundtxt(this)"
					style="text-align: right"></td>
				
            <td width="15%" height="33">
<input type="text" name="txt_lactdryfodderwt"
					tabindex="15" value="<%=Helper.correctInt((String)hshValues.get("agr_findata_lact_dryfodderwt"))%>" size="10" maxlength="6"
					onKeyPress="allowNumber(this);"onBlur="roundtxt(this)"
					style="text-align: right"></td>
				
            <td width="26%" height="33">
<input type="text" name="txt_lactconcentratefeedwt"
					tabindex="17" value="<%=Helper.correctInt((String)hshValues.get("agr_findata_lact_concnfodderwt"))%>" size="10" maxlength="6"
					onKeyPress="allowNumber(this);"onBlur="roundtxt(this)"
					style="text-align: right"></td>
			</tr>
			<tr class="datagrid" align="center">
				<td width="31%" align="left"><b>Feeding quantity/day during dry days</b></td>
				
            <td width="28%">
              <input type="text" name="txt_drygreenfodderwt"
					tabindex="19" value="<%=Helper.correctInt((String)hshValues.get("agr_findata_dry_grnfodderwt"))%>" size="10" maxlength="6"
					onKeyPress="allowNumber(this);"onBlur="roundtxt(this)"
					style="text-align: right">
            </td>
				<td width="15%"><input type="text" name="txt_drydryfodderwt"
					tabindex="21" value="<%=Helper.correctInt((String)hshValues.get("agr_findata_dry_dryfodderwt"))%>" size="10" maxlength="6"
					onKeyPress="allowNumber(this);"onBlur="roundtxt(this)"
					style="text-align: right"></td>
				<td width="26%"><input type="text" name="txt_dryconcentratefeedwt"
					tabindex="22" value="<%=Helper.correctInt((String)hshValues.get("agr_findata_dry_concnfodderwt"))%>" size="10" maxlength="6"
					onKeyPress="allowNumber(this);"onBlur="roundtxt(this)"
					style="text-align: right"></td>
			</tr>
			<tr class="datagrid" align="center">
				<td width="31%" align="left"><b>Cost Per KG</b></td>
				<td width="28%"><laps:CurrencyTag name="txt_greenfoddercost"
					tabindex="14" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_grnfodder_cost"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
				<td width="15%"><laps:CurrencyTag name="txt_dryfoddercost"
					tabindex="16" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_dryfodder_cost"))%>' size="15" maxlength="9"
					onKeyPress="allowNumber(this)" onBlur="roundtxt(this)" /></td>
				<td width="26%"><laps:CurrencyTag
					name="txt_concentratefoddercost" tabindex="18" value='<%=Helper.correctDouble((String)hshValues.get("agr_findata_concnfodder_cost"))%>' size="15"
					maxlength="9" onKeyPress="allowNumber(this)"
					onBlur="roundtxt(this)" /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable="Y" />
<lapschoice:hiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="hidAppType">
<input type="hidden" name="hidFacSNo" value="<%=strFacSNo%>">
</form>
</body>
</html>