<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrRowP = new ArrayList();
ArrayList arrColP = new ArrayList();
ArrayList arrRowTot = new ArrayList();
ArrayList arrColTot = new ArrayList();
ArrayList arrRowInc = new ArrayList();
ArrayList arrColInc = new ArrayList();
ArrayList arrRowFac = new ArrayList();
ArrayList arrColFac = new ArrayList();
ArrayList arrPHRow = new ArrayList();
ArrayList arrPHCol = new ArrayList();
ArrayList arrRowTotPer = new ArrayList();
if(hshValues!=null)
{
	arrRow = (ArrayList)hshValues.get("arrRow");
	arrRowP = (ArrayList)hshValues.get("arrRowP");
	arrRowTotPer = (ArrayList)hshValues.get("arrRowTot");
	arrRowInc = (ArrayList)hshValues.get("arrRowInc");
	arrRowFac = (ArrayList)hshValues.get("arrRowFac");
	arrPHRow = (ArrayList)hshValues.get("arrPHRow");
	arrRowTot = (ArrayList)hshValues.get("arrFBtotRow");
}
int arraySize=0;
if(arrRow!=null)
{
   arraySize=arrRow.size();
}
String StrSchemeType=request.getParameter("strschemeType");
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

String loantype=Helper.correctNull((String)request.getParameter("apploantype"));
int facTenor=0;
if(strSessionModuleType.equalsIgnoreCase("AGR")){
	facTenor=Integer.parseInt(Helper.correctInt((String)hshValues.get("facTenor")));
}else{
	facTenor=5;
}

int i=0,j=0;
%>
<html>
<head>
<title>Farm Budget</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var loantype="<%=Helper.correctNull((String)request.getParameter("apploantype"))%>";

function onLoad()
{
	disableFields(true);
}

function dobtnClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
}

function doComments()
{
	var hidDemoId=document.forms[0].hidDemoId.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidDemoId+"&hidCommentPage=agrifarmbudget";
	window.open(url,"Comments",prop);
}
</script>
</head>

<body onload="onLoad()">
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
<form name="frmbudget" method=post class="normal">
<%
if(strSessionModuleType.equalsIgnoreCase("AGR"))
{ 
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt;
Financial Analysis -&gt; Assessment -&gt; Farm Budget</span><br>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="19" />
</jsp:include>
<%}else{ %>
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
    <td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Farm Budget</td>
	</tr>
	</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
		<jsp:param name="pageid" value="19" />
		</jsp:include>
		</td>
	</tr>
</table>
	<%} %>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="1" class="outertable border1" align="center">
  <tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  		  <tr>
			<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
  				  <tr class="dataheader">
  				  	<td width="30%"><b>Financial Year</b></td>
  				  	<%
  				  	for(i=0;i<facTenor;i++){ %>
  				  	<td align="center">YEAR <%=i+1 %></td>
  				  	<%}%>
  				  </tr>
  				  <tr class="datagrid">
  				  	<td width="30%"><b>Net Income from Existing Crops </b></td>
  				  	<%for(i=0;i<facTenor;i++)
  				  	{ 
  				  		if (arrRow != null && arrRow.size() > 0) {
  				  			
  				  			arrCol = (ArrayList)arrRow.get(i);
  				  	%>
  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrCol.get(0)))%></td>
  				  	<%}else{%>
  				  	<td align="center">&nbsp;</td>
  				  	
  				  	<%} }%>
  				  </tr>
  				   
  				  <tr class="datagrid">
  				  	<td width="30%"><b>Net Income from Proposed Crops </b></td>
  				  	<%for(i=0;i<facTenor;i++)
  				  	{ 
  				  		if (arrRowP != null && arrRowP.size() > 0) {
  				  			
  				  			arrColP = (ArrayList)arrRowP.get(i);
  				  	%>
  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColP.get(0)))%></td>
  				  	<%}else{%>
  				  	<td align="center">&nbsp;</td>
  				  	
  				  	<%} }%>
  				  </tr>
  				  <%if(strSessionModuleType.equalsIgnoreCase("AGR"))
				  	{
  					if (arrPHRow != null && arrPHRow.size() > 0) 
  				    {
	  				  for(j=0;j<arrPHRow.size();j++){ 
	  				  
	  					arrPHCol = (ArrayList)arrPHRow.get(j);
	  				  %>
	  				  <tr class="datagrid">
	  				  	<td width="30%" nowrap><b>Net Income from Proposed Activity [&nbsp;<%=Helper.correctNull((String) arrPHCol.get(0))%>&nbsp;]</b></td>
	  				  	<%for(i=1;i<=facTenor;i++){ 
	  				  	if(i<=15){%>
	  				  	<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrPHCol.get(i))))%></td>
	  				  	<%}else{%>
	  				  	<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrPHCol.get(15))))%></td>
	  				  	<%}}%>
	  				  </tr>
  				  <%}}else {%>
  				  		<tr class="datagrid">
	  				  	<td width="30%"><b>Net Income from Proposed Activity </b></td>
	  				  	<%for(i=0;i<facTenor;i++){ %>
	  				  	<td align="right">0.00</td>
	  				  	<%} %>
	  				  </tr>
  				  <%}} %>
  				  
  				  <tr class="datagrid">
  				  	<td width="30%"><b>Other Net Income from allied Activities</b></td>
  				  	<%for(i=0;i<facTenor;i++)
  				  	{ 
  				  		if (arrRowInc != null && arrRowInc.size() > 0) {
				  			
				  			arrColInc = (ArrayList)arrRowInc.get(i);
  				  	%>
  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColInc.get(0)))%></td>
  				  	<%}else{%>
  				  	<td align="center">&nbsp;</td>
  				  	
  				  	<%} }%>
  				  </tr>
  				  
  				  <tr class="datagrid">
  				  	<td width="30%"><b>Total Net Income </b></td>
  				  	<%if(strSessionModuleType.equalsIgnoreCase("AGR"))
  				  	{
  				  	for(i=0;i<facTenor;i++)
  				  	{ 
  				  		if (arrRowTot != null && arrRowTot.size() > 0) {
				  			
				  			arrColTot = (ArrayList)arrRowTot.get(i);
  				  	%>
  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColTot.get(0)))%></td>
  				  	<%}else{%>
  				  	<td align="center">&nbsp;</td>
  				  	
  				  	<%} }}else{
  				  	for(i=0;i<5;i++)
  				  	{ 
  				  		if (arrRowTotPer != null && arrRowTotPer.size() > 0) {
				  			
				  			arrColTot = (ArrayList)arrRowTotPer.get(i);
  				  	%>
  				  	<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String) arrColTot.get(0)))%></td>
  				  	<%}else{%>
  				  	<td align="center">&nbsp;</td>
  				  	
  				  	<%} }}%>
  				  </tr>
  				  
  				  <!--<tr class="datagrid" height="25"><td><b>Gross Income</b></td></tr>
  				  <tr class="datagrid" height="25"><td><b>Expenditure</b></td></tr>  	
  				  			  
				-->
				</table>
			</td>
  		  </tr>
		</table>
	</td>
  </tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="1" class="outertable border1" align="center">
<tr><td><input type="button" name="cmdcomments" value="Comments" onClick="doComments()" class="buttonOthers"></td>
<td align="center">
<input type="button" name="cmdclose" value="Close" onClick="dobtnClose()" class="buttonClose">
</td></tr>
</table>
<input type="hidden" name="cmdsave" disabled="true">
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="yearfrom" value="1">
<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<%} %>
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
</form>
</body>
</html>