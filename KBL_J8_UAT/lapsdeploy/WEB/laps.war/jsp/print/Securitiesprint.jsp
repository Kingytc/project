<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
request.setAttribute("_cache_refresh", "true"); 

if(objValues instanceof java.util.Hashtable)
{
	   hshValues=(HashMap)objValues;
}
String pagevalType = Helper.correctNull((String) request.getParameter("pageVal"));
HashMap	 hshSecdata	= new HashMap();
hshSecdata=(HashMap)hshValues.get("hshsecdet");


if(pagevalType.equalsIgnoreCase("shortnote"))
{
	HashMap hshSec=(HashMap)hshValues.get("AN3");
	
	if(hshSec!=null)
	{
		hshSecdata=(HashMap)hshSec.get("hshsecdet");
	}
}
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

String strAmountValue = Helper.correctNull((String) hshValues.get("com_amountvalue"));
if(strAmountValue.equalsIgnoreCase(""))
	 strAmountValue = Helper.correctNull((String) hshValues.get("strAmountValue"));

java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
nft.setGroupingUsed(false);
%>
<html>
<head>
<title>Securities Print</title>
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>

</head>
<body>
<div id="top">
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
<td>&nbsp;</td>
<td align="center"><b>Existing Exposure</td>
<!--<td align="center"><b>Proposed Exposure</td>
--><td align="center"><b>Proposed Exposure</td>
<td  align="center" colspan="3"><b>Value of Securities</td>
</tr>
<tr>
<%for(int i=0;i<4;i++)
	{
	%>
	<td>&nbsp;</td>
	<%
	}
	%>
<td align="center"><b>Existing </td>
<!--<td align="center"><b>Proposed </td>
--><td align="center"><b>Proposed </td>
</tr>

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
	<tr ><td colspan="6"><b>Applicant : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr>
	<td><b>Fund Based</b></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8))))),strAmountValue)%></td>
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
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
		}
	}
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9))))),strAmountValue)%></td>
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<!--<td align="right"></td>-->
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	</tr>
	<%}}%>
	<%if(strFlgchk.equalsIgnoreCase("Y")){%>
	
	<tr>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subExpExitotal)),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(subExpProtot)),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subTotalexp)),strAmountValue)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subSecExitot)),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(subSecProtot)),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subSectot)),strAmountValue)%></td>
	</tr> 
	<%} %>
	<% }%>
	
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(0))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(1))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(8))))),strAmountValue)%></td>
	
	
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
	%>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(2))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(3))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(9))))),strAmountValue)%></td>
	
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(2))))),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	</tr>
	<%}}%>
	
	
<!--  Securities --> 
	
	<tr >
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subExpExitotal)),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(subExpProtot)),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subTotalexp)),strAmountValue)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subSecExitot)),strAmountValue)%></td>
	<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(subSecProtot)),strAmountValue)%></td>-->
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subSectot)),strAmountValue)%></td>
	</tr>
	<%}}}
	}%>
<tr >
<td><b>Total</b></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(ExpExitot)),strAmountValue)%></td>
<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(ExpExiProtot)),strAmountValue)%></td>-->
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(totalExp)),strAmountValue)%></td>
<td><strong>Total</strong></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(SecExitot)),strAmountValue)%></td>
<!--<td align="right"><%//=Helper.converAmount(Helper.correctNull(nft.format(SecProtot)),strAmountValue)%></td>-->
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Sectot)),strAmountValue)%></td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
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
<!--<td align="right"><%//=nft.format(dblExisprop) %></td>-->
<td align="right"><%=nft.format(dblFincove) %></td>
</tr>
</table></div>
</body>
</html>