<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
request.setAttribute("_cache_refresh", "true"); 

if(objValues instanceof java.util.Hashtable)
{
	   hshValues=(HashMap)objValues;
}

HashMap	 hshSecdata	= new HashMap();
hshSecdata=(HashMap)hshValues.get("hshsecdet");

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrGrpexpRow = new ArrayList();
ArrayList arrGrpexpCol = new ArrayList();
ArrayList arrGrpsecRow = new ArrayList();
ArrayList arrGrpsecCol = new ArrayList();
String strFlag="";
double subExpExitotal=0.00,subExpProtot=0.00,subSecExitot=0.00,subSecProtot=0.00;
double ExpExitot=0.00,ExpExiProtot=0.00,SecExitot=0.00,SecProtot=0.00;
double subTotalexp=0.00,totalExp=0.00,subSectot=0.00,Sectot=0.00;
if(hshValues !=null){
	arrGrpexpRow=(ArrayList)hshSecdata.get("arrExposureRow");
	arrGrpsecRow=(ArrayList)hshSecdata.get("Securities");
	strFlag=Helper.correctNull((String)hshSecdata.get("strFlag"));
}

java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
nft.setGroupingUsed(false);

String strAmountForm=Helper.correctNull((String)request.getParameter("strAmountVal"));
String strAmountVal="Rs.";
if(strAmountForm.equalsIgnoreCase("L"))
	strAmountVal="Lakhs";
else if(strAmountForm.equalsIgnoreCase("C"))
	strAmountVal="Crores";
%>
<html>
<head>
<title>Securities Print</title>
</head>
<body>

<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" id="top" align="center">
<tr class="tblhead">
<td colspan="6"><span style="float: left;">Security Coverage :</span><span style="float: right;"> (Amount. in <%=strAmountVal %>)</span></td>
</tr>
<tr class="tblhead">
<td  align="center" colspan="3"><b>Details of Advances</td>
<td  align="center" colspan="3"><b>Value of Securities</td>
</tr>
<tr>

<td align="center"><b>&nbsp;</td>
<td align="center"><b>Existing</td>
<!--<td align="center"><b>Proposed Exposure</td>-->
<td align="center"><b>Proposed / Total</td>
<td align="center"><b>&nbsp;</td>
<td align="center"><b>Existing </td>
<!--<td align="center"><b>Proposed </td>-->
<td align="center"><b>Proposed / Total </td></tr>


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
	<tr><td colspan="6"><b>Applicant : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr>
	<td><b>Fund Based</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)))),strAmountForm)%></td>
	<% if(arrGrpsecRow!=null && arrGrpsecRow.size()>0)
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
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)))),strAmountForm)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<!--<td align="right">&nbsp;</td>-->
	<td align="right">&nbsp;</td>
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
		<tr>
		<td><b>Non-Fund Based</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)))),strAmountForm)%></td>
	<% if(arrGrpsecRow!=null && arrGrpsecRow.size()>1)
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
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)))),strAmountForm)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<!--<td align="right">&nbsp;</td>-->
	<td align="right">&nbsp;</td>
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
		SecExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)));
		SecProtot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2)));
		subSectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
		Sectot+=Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)));
	%>
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<!--<td>&nbsp;</td>-->
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)))),strAmountForm)%></td>
	</tr>
	<%}}%>
	<%if(strFlgchk.equalsIgnoreCase("Y")){%>
	
	<tr>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(nft.format(subExpExitotal),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(subExpProtot)%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(subTotalexp),strAmountForm)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(nft.format(subSecExitot),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(subSecProtot)%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(subSectot),strAmountForm)%></td>
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
	<tr><td colspan="6"><b>Group Concern : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr>
	<td><b>Fund Based</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8)))),strAmountForm)%></td>
	
	
	<% 
	arrGrpsecRow=(ArrayList)hshSecdata.get("Securities"+n);
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
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)))),strAmountForm)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<!--<td align="right">&nbsp;</td>-->
	<td align="right">&nbsp;</td>
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
		<tr>
		<td><b>Non-Fund Based</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9)))),strAmountForm)%></td>
	
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
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)))),strAmountForm)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<!--<td align="right">&nbsp;</td>-->
	<td align="right">&nbsp;</td>
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
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<!--<td>&nbsp;</td>-->
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1)))),strAmountForm)%></td>
	<!--<td align="right"><%//=nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3)))),strAmountForm)%></td>
	</tr>
	<%}}%>
	
	
<!--  Securities --> 
	
	<tr >
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(nft.format(subExpExitotal),strAmountForm)%></td>
	<!--<td align="right"><%=Helper.converAmount(nft.format(subExpProtot),strAmountForm)%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(subTotalexp),strAmountForm)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(nft.format(subSecExitot),strAmountForm)%></td>
	<!--<td align="right"><%=Helper.converAmount(nft.format(subSecProtot),strAmountForm)%></td>-->
	<td align="right"><%=Helper.converAmount(nft.format(subSectot),strAmountForm)%></td>
	</tr>
	<%}}}
	}%>
<tr >
<td><b>Total</b></td>
<td align="right"><%=Helper.converAmount(nft.format(ExpExitot),strAmountForm)%></td>
<!--<td align="right"><%=Helper.converAmount(nft.format(ExpExiProtot),strAmountForm)%></td>-->
<td align="right"><%=Helper.converAmount(nft.format(totalExp),strAmountForm)%></td>
<td><strong>Total</strong></td>
<td align="right"><%=Helper.converAmount(nft.format(SecExitot),strAmountForm)%></td>
<!--<td align="right"><%=Helper.converAmount(nft.format(SecProtot),strAmountForm)%></td>-->
<td align="right"><%=Helper.converAmount(nft.format(Sectot),strAmountForm)%></td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
	<%double dblExiscove=0.00,dblExisprop=0.00,dblFincove=0.00;
	double dblExistingExp=Double.parseDouble(Helper.correctDouble((String)hshSecdata.get("dblRestrValFund")))+Double.parseDouble(Helper.correctDouble((String)hshSecdata.get("dblRestrValNF")));
	ExpExitot=ExpExitot-dblExistingExp;
	if(ExpExitot>0)
	{
		dblExiscove=(SecExitot/ExpExitot)*100;
	}
		dblExisprop=(SecProtot/ExpExiProtot)*100;
		dblFincove=(Sectot/totalExp)*100;
	%>
<td><b>Coverage(%)</b></td>
<td align="right"><%=nft.format(dblExiscove) %></td>
<!--<td align="right"><%//=nft.format(dblExisprop) %></td>-->
<td align="right"><%=nft.format(dblFincove) %></td>
</tr>
</table>
</body>
</html>