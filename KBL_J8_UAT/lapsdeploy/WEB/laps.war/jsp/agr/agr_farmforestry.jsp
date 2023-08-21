<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow=new ArrayList();
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
	if(hshValues!=null)
	{
		arrRow = (ArrayList)hshValues.get("arrRow");
	}
%>
<html>
<head>
<title>Existing Income other than crop	</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/agr/agr_farmforestry.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var editflag = 1;
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 
var auto_appno="<%=Helper.correctNull((String)request.getParameter("appno"))%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";
var schemetype="<%=schemetype%>"
var varpartsno ="<%=Helper.correctNull((String)hshValues.get("partsno"))%>";
function onloading()
{	
	disableFields(true);
	document.all.sel_scheme.value="<%=schemetype%>";
	if(varpartsno!=null)
	{
		document.forms[0].sel_part.value = varpartsno;
	}
	if(varpartsno == "")
	{
		document.forms[0].cmdnew.disabled =true;
	}
	document.forms[0].sel_area.disabled=true;
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" > 
</iframe> 
<%
if(strSessionModuleType.equalsIgnoreCase("AGR"))
{ 
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	<td valign="top">
	<jsp:include page="../share/applurllinkscom.jsp" flush="true">
		<jsp:param name="pageid" value="999" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include>
	</td>
	</tr>
</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
    <td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Existing Income other than crop</td>
	</tr>
	</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td>
		<jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
		<jsp:param name="pageid" value="209" />
		<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include>
		</td>
	</tr>
</table>

	<%}%>
	<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center" style="margin:0 auto;">
    <tr>
    <td>&nbsp;</td>
    </tr>
    <tr> 
    <td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor"  align="center" style="margin:0 auto;">
	
	
	<tr class="datagrid"> 
			<td colspan="13" align="left">&nbsp;Total Area &nbsp;&nbsp; 
			<select name="sel_area">
			<lapschoice:StaticDataNewTag apptype="121"/>
			</select>
			<lapschoice:CurrencyTag name="txt_totareaval"size="15"
			value='<%=Helper.correctDouble((String)hshValues.get("fen_areaval"))%>' maxlength="13" onBlur="TotalInccal();"/>
			</td>
			</tr>
	
	
	<tr class="dataheader"> 
    <td align="center" width="14%" colspan="2" rowspan="2"><b>Particulars</b></td>
    <td align="center" width="8%"  rowspan="2"><b>Yielding Year</b></td>
    <td align="center" width="8%"  colspan="3"><b>Income from Main Product</b></td>
    <td align="center" width="8%"  colspan="3"><b>Income from ByProduct</b></td>
    <td align="center" width="8%"  rowspan="2"><b>Gross Income</b></td>
    <td align="center" width="8%"  rowspan="2"><b>Gross Expenditure</b></td>
    <td align="center" width="8%"  rowspan="2"><b>Net Income</b></td>
    <td align="center" width="8%"  rowspan="2"><b>Total Net Income</b></td>
    </tr>
    
    <tr class="dataheader"> 
    <td align="center" width="8%"><b>Yield <br>(No./Qnty)</b></td>
    <td align="center" width="8%"><b>Sale Price</b></td>
    <td align="center" width="8%"><b>Income</b></td>
    <td align="center" width="8%"><b>Yield(No./Qty)</b></td>
    <td align="center" width="8%"><b>Sale Price</b></td>
    <td align="center" width="8%"><b>Income</b></td>
    </tr>
    
    <tr> 
    <td align="center" width="14%" colspan="2" rowspan="2">
    <select name="sel_part" style="width: 100px" onchange="callunitcost();">
    <option value="" selected="selected">--Select--</option>
    <lapschoice:ActivitySearchTag/>
    </select></td>
    <td align="center" width="8%"><input type="text" name="txt_yieldyear" maxlength="3" size="8" onkeypress="allowNumber(this)"></td>
    <td align="center" width="8%"><input type="text" name="txt_yieldno" maxlength="10" size="8" onkeypress="allowNumber(this)" onblur="TotalInccal();"></td>
    <td align="center" width="8%">
    <lapschoice:CurrencyTag name="txt_salepricemain" size="12" onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" />
    </td>
    <td align="center" width="8%">
	<lapschoice:CurrencyTag name="txt_incomemain" size="12" onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" />
	</td>
	
	
	 <td align="center" width="8%"><input type="text" size="12" name="txt_yieldnoprod" onKeyPress="allowNumber(this)" onblur="TotalInccal();"></td>
    <td align="center" width="8%">
    <lapschoice:CurrencyTag name="txt_salepriceprod" size="12" onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" />
    </td>
    <td align="center" width="8%">
	<lapschoice:CurrencyTag name="txt_incomeprod" size="12" onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" />
	</td>
	 <td align="center" width="8%">
	<lapschoice:CurrencyTag name="txt_grossinc" size="12" onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" />
	</td>
	
    <td align="center" width="8%">
	<lapschoice:CurrencyTag name="txt_grossexp" size="12" onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" />
	</td>
    <td align="center" width="8%">
    <lapschoice:CurrencyTag name="txt_netinc" size="12" onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" />
	</td>
    <td align="center" width="8%">
 	<lapschoice:CurrencyTag name="txt_totnetinc" size="12"  onKeyPress="allowNumber(this)" onBlur="TotalInccal();"
			value='' maxlength="13" /> 
	</td>
    </tr>
	
</table>
    </td>
    </tr>
</table>
	
	<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<br>

	<table width="98%" border="0" cellspacing="1" cellpadding="0" align="center">
    <tr class="dataheader">
    <td align="center" width="3%"></td>
    <td align="center" width="8%">Yielding Year</td>
    <td align="center" width="8%">Yield(No./Qnty)</td>
    <td align="center" width="8%">Sale Price</td>
    <td align="center" width="8%">Income</td>
    <td align="center" width="8%">Yield(No./Qty)</td>
    <td align="center" width="8%">Sale Price</td>
	<td align="center" width="8%">Income</td>
    <td align="center" width="8%">Gross Income</td>
    <td align="center" width="8%">Gross Expenditure</td>
    <td align="center" width="8%">Net Income</td>
    <td align="center" width="8%">Total Net Income</td>
    
  	</tr>
  	
  	
  	
  	<%
			if (arrRow != null && arrRow.size() > 0) 
			{
			for (int i = 0; i < arrRow.size(); i++) 
			{
			arrCol = (ArrayList) arrRow.get(i);
			%>
  	
  	
  	<tr class="datagrid">
    <td align="center" width="3%">
	<input type="radio"	style="border: none" name="radiobutton" value="radiobutton" onClick="javascript:selectValues
	('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctInt((String)arrCol.get(1))%>','<%=Helper.correctInt((String)arrCol.get(2))%>',
	'<%=Helper.correctInt((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>',
	'<%=Helper.correctInt((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(7))%>','<%=Helper.correctNull((String)arrCol.get(8))%>',
	'<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(10))%>','<%=Helper.correctNull((String)arrCol.get(11))%>',
	'<%=Helper.correctNull((String)arrCol.get(12))%>','<%=Helper.correctNull((String)arrCol.get(13))%>')"></td>
	<td align="center" width="8%"><%=Helper.correctNull((String)arrCol.get(2))%></td>
    <td align="center" width="8%"><%=Helper.correctNull((String)arrCol.get(3))%></td>
    <td align="center" width="8%" style="text-align: right;"><%=Helper.correctNull((String)arrCol.get(4))%></td>
    <td align="center" width="8%" style="text-align: right;"><%=Helper.correctNull((String)arrCol.get(5))%></td>
    <td align="center" width="8%"><%=Helper.correctNull((String)arrCol.get(6))%></td>
    <td align="center" width="8%" style="text-align: right;"><%=Helper.correctNull((String)arrCol.get(7))%></td>
	<td align="center" width="8%" style="text-align: right;"><%=Helper.correctNull((String)arrCol.get(8))%></td>
    <td align="center" width="8%" style="text-align: right;"><%=Helper.correctNull((String)arrCol.get(9))%></td>
    <td align="center" width="8%" style="text-align: right;"><%=Helper.correctNull((String)arrCol.get(10))%></td>
    <td align="center" width="8%" style="text-align: right;"><%=Helper.correctNull((String)arrCol.get(11))%></td>
    <td align="center" width="8%" style="text-align: right;"> <%=Helper.correctNull((String)arrCol.get(12))%></td>
  	</tr>
  	<%}}else{ %>
  	<tr class="datagrid">
    <td colspan="12" align="center">No Record found</td>
    <%} %>
  	</tr>
	</table>
	
  
<input type="hidden" name="hidgridno">
<input type="hidden" name="hiddatano">
<input TYPE="hidden" name="radLoan" value="Y">
<input type="hidden" name="hidunitcose" value="<%=Helper.correctDouble((String)hshValues.get("unitcost"))%>">
<input type="hidden" name="hidsno">
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>