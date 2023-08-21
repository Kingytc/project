<%@include file="../share/directives.jsp"%>
<% String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrGrpexpRow = new ArrayList();
ArrayList arrGrpexpCol = new ArrayList();
ArrayList arrGrpsecRow = new ArrayList();
ArrayList arrGrpsecCol = new ArrayList();
double subExpExitotal=0.00,subExpProtot=0.00,subSecExitot=0.00,subSecProtot=0.00,subTotalexp=0.00,totalExp=0.00,subSectot=0.00,Sectot=0.00;
double ExpExitot=0.00,ExpExiProtot=0.00,SecExitot=0.00,SecProtot=0.00,dblRatingExposure=0.00,dblRatingExposureNonFund=0.00;
String strFlag=Helper.correctNull((String)hshValues.get("strFlag"));
if(hshValues !=null){
	//arrRow=(ArrayList)hshValues.get("arrNewRow");
	arrGrpexpRow=(ArrayList)hshValues.get("arrExposureRow");
	arrGrpsecRow=(ArrayList)hshValues.get("Securities");
	int SecSize=arrGrpsecRow.size();
	int ExpSize=arrGrpexpRow.size();

}
java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
nft.setGroupingUsed(false);
dblRatingExposure=Double.parseDouble(Helper.correctDouble((String)hshValues.get("RatingExposureFund")));
dblRatingExposureNonFund=Double.parseDouble(Helper.correctDouble((String)hshValues.get("RatingExposureNonFund")));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<form method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="subpageid" value="107" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
 <%if(strSessionModuleType.equals("AGR")||strSessionModuleType.equals("CORP")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application  -&gt; Security Master -&gt; Attached Securities</td>
	<%}else if(strSessionModuleType.equals("CORP")){%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application  -&gt; Security Master -&gt; Attached Securities</td>
		<%}else{ %>	
		<td class="page_flow">Home -&gt; Retail (including schematic) -&gt; Application  -&gt; Security Master -&gt; Attached Securities</td>	
		<%} %>	
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="22"/>
		</jsp:include>
		</td>
	</tr>
</table>
<%} %>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr  class="dataHeader">
<td  align="center" colspan="4"><b>Details of Advances</td>
<td  align="center" colspan="4"><b>Value of Securities</td>
</tr>
<tr  class="dataHeader">
<td>&nbsp;</td>
<td align="center"><b>Existing Exposure</td>
<td align="center"><b>Proposed Exposure</td>
<td align="center"><b>Total Exposure</td>
<td>&nbsp;</td>
<td align="center"><b>Existing </td>
<td align="center"><b>Proposed </td>
<td align="center"><b>Total </td></tr>
<%int k=0; 
String strFlgchk="";
if(arrGrpexpRow!=null && arrGrpexpRow.size()>0)
	{
	for(int i=0;i<arrGrpexpRow.size();i++)
	{
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("A"))
		{
			
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
			
			
	%>
	<tr class="datagrid"><td colspan="8"><b>Applicant : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr class="datagrid">
	<td><b>Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8))))%></td>
	<% if(arrGrpsecRow!=null && arrGrpsecRow.size()>0)
	{
		for(k=0;k<1;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<% }%>
	</tr>
	<%}else{
		if(!(strFlgchk.equalsIgnoreCase("Y")))
		{
			strFlgchk=Helper.correctNull((String)arrGrpexpCol.get(6));
		}
	}}
	for(int i=0;i<arrGrpexpRow.size();i++)
	{
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("A"))
		{
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
			subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
			ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
		%>
		<tr class="datagrid">
		<td><b>Non-Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9))))%></td>
	<% if(arrGrpsecRow!=null && arrGrpsecRow.size()>1)
	{
		for(;k<2;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<%} %>
	</tr>
			
		<%}
	}%>
	<%
	int SecSize=arrGrpsecRow.size();
	if(SecSize>2){
	for(;k<arrGrpsecRow.size();k++)
	{
		arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
		subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
		Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
		SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
	%>
	<tr class="datagrid">
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	</tr>
	<%}}%>
	<%if(strFlgchk.equalsIgnoreCase("Y")){ %>
	<tr  class="datagrid">
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subExpExitotal)%></td>
	<td align="right"><%=nft.format(subExpProtot)%></td>
	<td align="right"><%=nft.format(subTotalexp)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subSecExitot)%></td>
	<td align="right"><%=nft.format(subSecProtot)%></td>
	<td align="right"><%=nft.format(subSectot)%></td>
	</tr> 
	<% }
	}%>
	
<%
int n=0;
if(arrGrpexpRow!=null && arrGrpexpRow.size()>0)
	{
	for(int i=0;i<arrGrpexpRow.size();i++)
	{
		subExpExitotal=0.00;
		subExpProtot=0.00;
		subSecExitot=0.00;
		subSecProtot=0.00;
		subTotalexp=0.00;
		subSectot=0.00;
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("O"))
		{
			n++;
			if((arrGrpexpCol.get(6).equals("Y"))){
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)));
			ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)));
	%>
	<tr class="datagrid"><td colspan="8"><b>Group Concern : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr class="datagrid">
	<td><b>Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8))))%></td>
	
	<% 
	arrGrpsecRow=(ArrayList)hshValues.get("Securities"+n);
	if(arrGrpsecRow!=null && arrGrpsecRow.size()>0)
	{
		for(k=0;k<1;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<% }%>
	</tr>
	<%
	subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
	subExpProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
	ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)));
	ExpExiProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3)));
	subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
	totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)));
	%>
		<tr class="datagrid">
		<td><b>Non-Fund Based</b></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9))))%></td>
	<% 
	if(arrGrpsecRow!=null && arrGrpsecRow.size()>1)
	{
		for(;k<2;k++)
		{
			arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
			subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
			SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
			subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
			Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right"></td>
	<% }%>
	</tr>
	
	
	<% int SecSize=arrGrpsecRow.size();
	if(SecSize>2){
	for(;k<arrGrpsecRow.size();k++)
	{
		arrGrpsecCol=(ArrayList)arrGrpsecRow.get(k);
		subSecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		subSecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
		Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<tr class="datagrid">
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>
	<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))%></td>
	</tr>
	<%}}%>
	
	
<!--  Securities --> 
	<tr  class="datagrid">
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subExpExitotal)%></td>
	<td align="right"><%=nft.format(subExpProtot)%></td>
	<td align="right"><%=nft.format(subTotalexp)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=nft.format(subSecExitot)%></td>
	<td align="right"><%=nft.format(subSecProtot)%></td>
	<td align="right"><%=nft.format(subSectot)%></td>
	</tr>
	<%}}}
	}%>
<tr  class="datagrid">
<td><b>Total</b></td>
<td align="right"><%=nft.format(ExpExitot)%></td>
<td align="right"><%=nft.format(ExpExiProtot)%></td>
<td align="right"><%=nft.format(totalExp)%></td>
<td><strong>Total</strong></td>
<td align="right"><%=nft.format(SecExitot)%></td>
<td align="right"><%=nft.format(SecProtot)%></td>
<td align="right"><%=nft.format(Sectot)%></td>
</tr>
<tr class="datagrid">
	<td colspan="4">&nbsp;</td>
	<%double dblExiscove=0.00,dblExisprop=0.00,dblFincove=0.00;
	if(ExpExitot>0)
	{
		dblExiscove=(SecExitot/ExpExitot)*100;
	}
	if(ExpExiProtot>0)
		dblExisprop=(SecProtot/ExpExiProtot)*100;
	if(totalExp>0)
		dblFincove=(Sectot/totalExp)*100;
	%>
<td><b>Coverage(%)</b></td>
<td align="right"><%=nft.format(dblExiscove) %></td>
<td align="right"><%=nft.format(dblExisprop) %></td>
<td align="right"><%=nft.format(dblFincove) %></td>
</tr>
<tr  class="datagrid"><td colspan="3"><b>Total Rating Exposure Fund Based</b></td>
<td align="right"><%=nft.format(dblRatingExposure) %></td>
<td colspan="4">&nbsp;</td>
</tr>
<tr  class="datagrid"><td colspan="3"><b>Total Rating Exposure Non Fund Based</b></td>
<td align="right"><%=nft.format(dblRatingExposureNonFund) %></td>
<td colspan="4">&nbsp;</td>
</tr>
</table>
<input type="hidden" name="hid_categoryType" value=""><br>
<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="cmdsave" disabled="disabled">
</form>
</body>
</html>