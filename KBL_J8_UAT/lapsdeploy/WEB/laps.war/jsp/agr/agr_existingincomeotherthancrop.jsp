<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow=new ArrayList();
	ArrayList arrTotRow=new ArrayList();
	ArrayList arrTotCol = new ArrayList();
	arrTotRow=(ArrayList)hshValues.get("totvalues");
	String total1="";
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}
	double dblTenor = Double.parseDouble(Helper.correctDouble((String)hshValues.get("Tenor")));
	int intTenor = Integer.parseInt(Helper.correctInt((String)hshValues.get("Tenor")));	
	String Ltype=Helper.correctNull((String)request.getParameter("apploantype"));
%>
<html>
<head>
<title>Existing Income other than crop	</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/agr/agr_existingincomeotherthancrop.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var editflag = 1;
var appURL  ="<%=ApplicationParams.getAppUrl()%>"; 
var auto_appno="<%=Helper.correctNull((String)request.getParameter("appno"))%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";
var schemetype="<%=schemetype%>";
var varTenor ="<%=Helper.correctNull((String)hshValues.get("Tenor"))%>";
var loantype="<%=Helper.correctNull((String)request.getParameter("apploantype"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function onloading()
{	
	disableFields(true);
	if(loantype=="A"){	
	document.all.sel_scheme.value="<%=schemetype%>";
	}
	document.forms[0].cmdcomments.disabled=false;
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
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
		<jsp:param name="pageid" value="207" />
		<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include>
		</td>
	</tr>
</table>

	<%}else{%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	<td valign="top">
	<jsp:include page="../share/Applurllinkper.jsp" flush="true">
		<jsp:param name="pageid" value="8" />
	</jsp:include>
	</td>
	</tr>
</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
    <td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Existing Income other than crop</td>
	</tr>
	</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
		<jsp:param name="pageid" value="207" />
		</jsp:include>
		</td>
	</tr>
</table>
	<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
    <td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	<td valign="top">
	<table width="100%" border="0" cellspacing="0"	cellpadding="4" class="outertable">
	<tr>
	<td> 
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
    <tr class="dataheader"> 
    <td align="center" rowspan="2" width="5%"><b>S.No.</b></td>
    <td align="center" rowspan="2" width="15%" colspan="2"><b>Particulars</b></td>
    <%if(Ltype.equalsIgnoreCase("P")){ %>
    <td align="center" colspan="5"><b>Year</b></td>
    <%}else{ %>
    <td align="center" colspan="<%=intTenor%>"><b>Year</b></td>
    <%} %>
    </tr>
    <tr class="dataheader"> 
    <%if(Ltype.equalsIgnoreCase("P")){ 
   	 for(int i=0;i<5;i++){ %>
    <td align="center"><%=i+1 %></td>
    <%}}else{ %>
    <% for(int i=0;i<dblTenor;i++){ %>
    <td align="center"><%=i+1 %></td>
    <%} }%>
    </tr>
    <tr> 
    <td  colspan="2">&nbsp;<b>Income</b></td> 
    <td align="center"><input type="text" name="txt_income" size="25" maxlength="20" onkeypress="allowAlphaNumericSpace()"></td>
    <%if(Ltype.equalsIgnoreCase("P")){ 
    for(int i=0;i<5;i++){%>
    <td align="center" ><input type="text" size="12" style="text-align: right" name="txt_inc" maxlength="12" onblur="roundtxt(this);calIncExptot1();" onkeypress="allowNumber(this)"></td>
    <%}}else{ %>
    <% for(int i=0;i<dblTenor;i++){ %>
    <td align="center" ><input type="text" size="12" style="text-align: right" name="txt_inc" maxlength="12" onblur="roundtxt(this);calIncExptot();" onkeypress="allowNumber(this)"></td>
    <%} }%>
  	</tr>
    <tr> 
    <td  colspan="2">&nbsp;<b>Expense</b></td>
    <td align="center"  ><input type="text"  name="txt_expense" size="25" maxlength="20" onkeypress="allowAlphaNumericSpace()"></td>
    <%if(Ltype.equalsIgnoreCase("P")){
    	for(int i=0;i<5;i++){%>
    	<td align="center" ><input type="text" size="12" style="text-align: right" name="txt_exp" maxlength="12" onblur="roundtxt(this);calIncExptot1();" onkeypress="allowNumber(this)"></td>
    <%}}else{ %>
    <% for(int i=0;i<dblTenor;i++){ %>
    <td align="center" ><input type="text" size="12" style="text-align: right" name="txt_exp" maxlength="12" onblur="roundtxt(this);calIncExptot();" onkeypress="allowNumber(this)"></td>
    <%}} %>
    </tr>
    <tr> 
    <td  colspan="3" align="center" class="datagrid">&nbsp;<b>Net Income</b></td>
     <%if(Ltype.equalsIgnoreCase("P")){
    	for(int i=0;i<5;i++){%>
    	 <td align="center"  ><input type="text" size="12" style="text-align: right" name="txt_tot"onblur="roundtxt(this);" readonly="readonly"></td>
    	<%}}else{ %>
    <% for(int i=0;i<dblTenor;i++){ %>
    <td align="center"  ><input type="text" size="12" style="text-align: right" name="txt_tot"onblur="roundtxt(this);" readonly="readonly"></td>
    <%}} %>
    </tr>
    
    
    
</table>
    </td>
    </tr>
</table>
	</td>
    </tr>
</table>
	</td>
    </tr>
	<tr>
	<td>
	<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Comments_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<br>

<table width="85%" border="1" cellspacing="0" cellpadding="2" class="outertable linebor" align="center">
    <tr class="dataheader">
    <td align="center" width="5%"><b>S.No.</b></td>
    <td align="center"  width="25%"><b>Income Particulars</b></td>
    <td align="center"  width="25%"><b>Expense Particulars</b></td>
  	</tr>
  	<%
	if (arrTotRow != null && arrTotRow.size() > 0) 
	{
	for (int i = 0; i < arrTotRow.size(); i++) 
	{
		
	arrRow = (ArrayList) arrTotRow.get(i);
	if(arrRow != null && arrRow.size() > 0)
	{
	for (int j = 0; j < 1; j++)
	{
	arrTotCol = (ArrayList) arrRow.get(j);
  	%>
  	<tr>
   	<td align="center" width="5%">
   	<input type="radio"	style="border: none" name="radiobutton" value="radiobutton" onClick="javascript:selectValues('<%=i+1%>')">
   	</td>
    <td align="center"  width="25%"><b><%=arrTotCol.get(2) %></b></td>
    <td align="center"  width="25%"><b><%=arrTotCol.get(3) %></b></td>
  	</tr>
  	<%}}}}%>
</table>
  
  	</td>
  	</tr>
</table>
<input type="hidden" name="hidgridno">
<input type="hidden" name="hiddatano">
<input TYPE="hidden" name="radLoan" value="Y">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
<input type="hidden" name="hidtenor" value="<%=Helper.correctNull((String)hshValues.get("Tenor")) %>">
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hid_subvention" value="<%=Helper.correctNull((String)request.getParameter("hid_subvention"))%>">
</form>
</body>
</html>