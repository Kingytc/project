<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String StrSchemeType=request.getParameter("strschemeType");

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>

<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrCol1 = new ArrayList();

ArrayList arrColl = new ArrayList();

ArrayList arrSubtotal= new ArrayList();
if(hshValues!=null)
{
	arrRow = (ArrayList)hshValues.get("arrRow");
	arrSubtotal= (ArrayList) hshValues.get("arrYears");
}

%>
<html>
<head>
<title>Physical and Financial Programme</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";


function dobtnClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
</script>
</head>

<body >
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
<form name="formphy" method=post class="normal">
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
Financial Analysis -&gt; Assessment -&gt; Physical and Financial Programme</span>
<br>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="90" />
</jsp:include>
<br>

<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <tr>
	<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  		  <tr>
			<td>
			
			
			<table width="88%" border="0" cellspacing="1" cellpadding="0" align="center" class="outertable">
	<tr class="dataheader">
		<td width="10%" align="center">Programme Year</td>
		<td width="15%" align="center">&nbsp;Activity Name</td>
		<td width="15" align="center">&nbsp;Specifications</td>
		<td width="8%" align="center">&nbsp;No.</td>
		<td width="7%" align="center">&nbsp;Units</td>
		<td width="20%" align="center">&nbsp;Unit Cost</td>
		<td width="10%" align="center">&nbsp;Total cost</td>
		<td width="12%" align="center">&nbsp;Margin (%)</td>
		<td width="13%" align="center">&nbsp;Bank Loan</td>
	</tr>
	<%
	ArrayList arrRowCol=new ArrayList();
	if(arrRow!=null && arrRow.size()>0)
	{
		int j=0;
		double dblFirst=0;
		double dblSecond=0;
		int intFirst=0;
		int k=0;
		String strFacSno="0";
		for(int i=0;i<arrRow.size();i++)
		{
		arrCol = (ArrayList)arrRow.get(i);
		if(arrCol!=null && arrCol.size()>0)
		{
			for(int a=0;a<arrCol.size();a++)
			{
				arrRowCol = (ArrayList)arrCol.get(a);
				
		j=a;
		if(a < arrCol.size() -1 )
		arrCol1 = (ArrayList)arrCol.get(++j);
		else
		arrCol1 = (ArrayList)arrCol.get(j);	
		
		
		dblFirst=Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrRowCol.get(8))));
		dblSecond=Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrRowCol.get(8))));
		intFirst=(int)dblFirst;
		strFacSno=Helper.correctInt((String)arrRowCol.get(10));
	//	arrColl=(ArrayList)arrSubtotal.get(i);
	if(a==0){
		%>
		<tr class="dataheader">
		<td colspan="8"><%=Helper.correctNull((String)arrRowCol.get(9))%></td>
		</tr>
		<%} %>
		<tr class="datagrid">
			<td align="center""><%=Helper.correctNull((String)arrRowCol.get(0))%></td>
			<td><%=Helper.correctNull((String)arrRowCol.get(1))%></td>
			<td><%=Helper.correctNull((String)arrRowCol.get(8))%></td>
			<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrRowCol.get(2)))))%></td>
			<td align="center"><%=Helper.correctNull((String)arrRowCol.get(3))%></td>
			<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrRowCol.get(4)))))%></td>
			<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrRowCol.get(5)))))%></td>
			<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrRowCol.get(6)))))%></td>
			<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrRowCol.get(7))))) %></td>
		</tr>
		
		
			
		<%	}%>
		<% //if (dblFirst != dblSecond || (arrSubtotal.size()-1)==i )
			if(arrSubtotal.size()>0)
		{
			arrColl = (ArrayList)arrSubtotal.get(i);
			{
				//++k;
			%>
		<tr class="dataheader">
			<td colspan="5" align="right"><%=Helper.correctNull((String)arrColl.get(1))%>&nbsp;:&nbsp;</td>
			<td align="right""><%=nf.format(Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrColl.get(3)))))%></td>
			<td align="right"">&nbsp;</td>
			<td align="right""><%=nf.format(Double.parseDouble(Helper.correctDouble((String)Helper.correctNull((String)arrColl.get(2)))))%></td>
		</tr>
		<%
		}}%>
		
		<tr class="dataheader">
		<td colspan="6" align="right"><b>Total cost of the project : <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalprojectcost"+strFacSno))))%></b></td>
		<td  align="right" nowrap="nowrap"><b>Margin to Proj cost: <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalmarg"+strFacSno)))) %>%</b></td>
		<td  align="right" nowrap="nowrap"><b>Total Bank Loan : <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalbankloan"+strFacSno)))) %></b></td>
		</tr>
	
	<tr class="dataheader">
		<td colspan="6" align="right"><b>Margin : <%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("consmargin"+strFacSno)))%> %</b>
		<td nowrap="nowrap"><b>Recommended Bank Loan :</b></td>
		<td  align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("consbl"+strFacSno)))%></td>
		</tr>
			
		<%}}} %>
	
	
	
	
</table>
					
			
			
			
			
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
<tr><td align="center">
<input type="button" name="cmdclose" value="Close" onClick="dobtnClose()" class="buttonClose">
</td></tr>
</table>
<br>
<input type="hidden" name="cmdsave" disabled="true">
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
 <input type="hidden" name="yearfrom" value="1">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">




</form>
</body>
</html>
			
			
			
			
			
			
