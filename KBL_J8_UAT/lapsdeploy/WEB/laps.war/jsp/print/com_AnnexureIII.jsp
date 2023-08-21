<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
HashMap hshsecVal = new HashMap ();
ArrayList arrBARow		= new ArrayList();
ArrayList arrBAOurRow	= new ArrayList();
ArrayList arrBAOtherRow	= new ArrayList();
ArrayList arrCGOurRow	= new ArrayList();
ArrayList arrCGOtherRow	= new ArrayList();
ArrayList arrCol		= new ArrayList();
ArrayList arrExisSecRow	= new ArrayList();
ArrayList arrExisSecCol	= new ArrayList();
ArrayList arrProposSecCol=new ArrayList();
String strOutstandingDate="";
ArrayList arrRow		= new ArrayList();
ArrayList arrGroupConcernDetailsRow=new ArrayList();
ArrayList arrGroupConcernDetailsCol=new ArrayList();
ArrayList arrGroupConcernDetailsRow1=new ArrayList();
ArrayList arrGroupConcernDetailsCol1=new ArrayList();
ArrayList arrPersonalRow	= new ArrayList();
ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
ArrayList arrSingleCons =  new ArrayList();
ArrayList arrMultipleCons = new ArrayList();
ArrayList arrMultiple 	= new ArrayList();
ArrayList arrSingleConsWC = new ArrayList();
ArrayList arrMultipleConsWC = new ArrayList();
ArrayList arrMultipleWC = new ArrayList();
ArrayList arrMultiBnk = new ArrayList();
ArrayList arrColCons	= new ArrayList();
ArrayList arrGroupconcerns	= new ArrayList();
ArrayList arrFinancialRow	= new ArrayList();
ArrayList arrFindataRow	= new ArrayList();
ArrayList arrFindatacol	= new ArrayList();
ArrayList arrGuarRow	= new ArrayList();
ArrayList arrGuarcol	= new ArrayList();
ArrayList arrCooblRow	= new ArrayList();
ArrayList arrSecGroupRow	= new ArrayList();
ArrayList arrproposedsecurityRow = new ArrayList();
String strPreSancSecComments = "",strPostSancSecComments="";
String strPagetype = Helper.correctNull((String)request.getParameter("pageVal"));
String proposalFormat = Helper.correctNull((String)request.getParameter("proposalFormat"));
String secValue = "";
if(strPagetype.equalsIgnoreCase("AN3"))
{
	strPreSancSecComments = Helper.correctNull((String)hshValues.get("cmt_presanccomments")).trim();
	strPostSancSecComments = Helper.correctNull((String)hshValues.get("cmt_postsanccomments")).trim();
	hshValues = (HashMap)hshValues.get("AN3");
}

if(hshValues!=null)
{
	arrBARow		= (ArrayList)hshValues.get("arrBARow");
	arrBAOurRow		= (ArrayList)hshValues.get("arrBAOurRow");
	arrBAOtherRow	= (ArrayList)hshValues.get("arrBAOtherRowNew");
	arrCGOurRow		= (ArrayList)hshValues.get("arrCGOurRow");
	arrCGOtherRow	= (ArrayList)hshValues.get("arrCGOtherRow");
	arrExisSecRow	= (ArrayList)hshValues.get("arrExisSecRow");
	arrPersonalRow	= (ArrayList)hshValues.get("arrPersonalRow");
	arrGroupConcernDetailsRow	= (ArrayList)hshValues.get("arrGroupConcernDetails");
	arrGroupConcernDetailsRow1	= (ArrayList)hshValues.get("arrGroupConcernDetails1");
	strOutstandingDate=Helper.correctNull((String)hshValues.get("strOutstandingDate"));
	hshsecVal = (HashMap)hshValues.get("hshsecdet");
	
	arrSingleCons = (ArrayList)hshValues.get("arrSingleCons");
	arrMultipleCons = (ArrayList)hshValues.get("arrMultipleCons");
	arrMultiple		= (ArrayList)hshValues.get("arrMultiple");
	arrSingleConsWC = (ArrayList)hshValues.get("arrSingleConsWC");
	arrMultipleConsWC = (ArrayList)hshValues.get("arrMultipleConsWC");
	arrMultipleWC 	= (ArrayList)hshValues.get("arrMultipleWC");
	arrMultiBnk		= (ArrayList)hshValues.get("arrMultiBnk");
	arrGroupconcerns = (ArrayList)hshValues.get("arrGroupconcerns");
	arrGuarRow = (ArrayList)hshValues.get("arrGuarantors");
	arrCooblRow= (ArrayList)hshValues.get("arrCoobligant");
}

String strFlag=Helper.correctNull((String)hshsecVal.get("strFlag"));
String strAppSecFlag=Helper.correctNull((String)hshValues.get("COMSEC_APPCOVERAGE"));
String strAppSecManualFlag=Helper.correctNull((String)hshValues.get("COMSEC_SECTYPE"));
String strGroupSecManualFlag=Helper.correctNull((String)hshValues.get("COMSEC_FACGROUPCONCERN"));

String strNil		= "Nil", strVal	= "";
String strValuesIn="";

String strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));

if(strValIn.equalsIgnoreCase("Rs"))
{
	strValuesIn	= "(Amount in  "+strValIn+".)";
}
else
{
	strValuesIn	= "(Rs. in  "+strValIn+")";
}

String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));

if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
}

int iVal=0;

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
String strGroupSecFlag=Helper.correctNull((String)hshValues.get("COMSEC_GROUPCOVERAGE"));
String strGroupconcernSecFlag=Helper.correctNull((String)hshValues.get("COMSEC_ADDITIONALSECCOVERAGE"));
String strAmountValue=Helper.correctNull((String)hshValues.get("com_amountvalue"));
String strFinvaluesin=Helper.correctNull((String)hshValues.get("strFinValuesIn"));
if(strFinvaluesin.equalsIgnoreCase("Rs"))
{
	strFinvaluesin	= "(Amount in  "+strFinvaluesin+".)";
}
else
{
	strFinvaluesin	= "(Rs. in  "+strFinvaluesin+")";
}
String strProposedSecurity=Helper.correctNull((String)hshValues.get("strProposedSecurity"));
String strFormat = Helper.correctNull((String)request.getParameter("strFormat"));
%>
<html>
<head>
<title>Annexure - III</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(!proposalFormat.equalsIgnoreCase("RPN")){ %>
<%if(!strPagetype.equalsIgnoreCase("AN3")) {%>
<tr><td align="center" class="title"><br>ANNEXURE	- III</td></tr>
<tr><td class="title"><br>DETAILS OF CREDIT FACILITIES:</td></tr>
<% } else if(proposalFormat.equalsIgnoreCase("RPN")) {%>
<tr><td class="title"><br>II.&nbsp;DETAILS OF CREDIT FACILITIES:</td></tr>
<%} else {%>
<tr><td class="title"><br>III.&nbsp;DETAILS OF CREDIT FACILITIES:</td></tr>
<% }} %>
<tr><td class="title"><u>a. Applicant</u></td></tr>
<!-- Our Bank -->

<tr>
<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="50%" class="Subtitle">Details of existing Credit facilities with our Bank :</td>
</tr>
</table>
</td>
</tr>


<%
if(arrBAOurRow!=null&&arrBAOurRow.size()>0){ %>
<tr><td align="right"><%=strAmtValueIn%></td></tr>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<%if(!strFormat.equalsIgnoreCase("Y")){ %>
<td width="10%" align="center"><b>Type of Limit</b></td>
<%} %>
<td width="10%" align="center"><b>Limit</b></td>
<td width="10%" align="center"><b>Purpose</b></td>
<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
<td width="10%" align="center"><b>ROI/ Com %</b></td>
<td width="10%" align="center"><b>Balance as on <%=strOutstandingDate%></b></td>
<td width="10%" align="center"><b>Due Date</b></td>
<td width="10%" align="center"><b>Arrears if any</b></td>
</tr>
<%
double dbLimitTotal=0.00,dbbalanceTotal=0.00,dblExposure=0.0;
for(int i=0;i<arrBAOurRow.size();i++){
	arrCol	= (ArrayList)arrBAOurRow.get(i);
	if(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("0")){
		dbLimitTotal=dbLimitTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
		dbbalanceTotal=dbbalanceTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));	
		dblExposure+=Double.parseDouble(Helper.correctDouble((String)arrCol.get(18)));
	}
	
	
%>
<tr>
<td align="left"><%=i+1%></td>
<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(0))).toUpperCase()%></td>
<%if(!strFormat.equalsIgnoreCase("Y")){ %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(14))%></td>
<%} 
if(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("0")){%>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>
<%}else{ %>
<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>)</td>
<%} %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
<%if(Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("MCLEC")||Helper.correctNull((String)arrCol.get(11)).equalsIgnoreCase("MCLR")){%>
<td align="right"><%=Helper.correctNull((String)arrCol.get(11))%>&nbsp;+&nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>% p.a presently at &nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%>% p.a</td>
<% } else{ %>
<td align="right">&nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%></td>
<%}if(Helper.correctNull((String)arrCol.get(13)).equalsIgnoreCase("0")){ %>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
<%}else{ %>
<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%>)</td>
<%} %>
<td align="center"><%=Helper.correctNull((String)arrCol.get(8))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
</tr>
<%} %>
<%if(!strFormat.equalsIgnoreCase("Y")){ %>
<tr><td colspan="3" align="right"><b>Total</b></td>
<%}else{ %>
<tr><td colspan="2" align="right"><b>Total</b></td>
<%} %>
<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbLimitTotal)),strAmountValue)%></b></td>
<td colspan="3">&nbsp;</td>
<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbbalanceTotal)),strAmountValue)%></b></td>
<td colspan="2">&nbsp;</td></tr>
<%if(strFormat.equalsIgnoreCase("Y")){ %>
<tr>
<td colspan="6"><b>Total Exposure</b></td>
<td align="right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dblExposure)),strAmountValue)%></b>&nbsp;</td>
<td colspan="2">&nbsp;</td></tr>
</tr>
<%} %>
</table>
</div>
</td>
</tr>
<%} else{%>
<tr><td>Nil</td></tr>
<%} %>

<%if(true) { //proposalFormat.equalsIgnoreCase("MCFD")%>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(arrBAOurRow!=null && arrBAOurRow.size()>0){ %>
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<%if(!strFormat.equalsIgnoreCase("Y")) { %>
<td width="10%" align="center"><b>Remarks</b></td>
<td width="10%" align="center"><b>Comments on Repayment</b></td>
<%}else{ %>
<td width="10%" align="center"><b>Repayment Comments</b></td>
<%} %>
</tr>
<%
for(int i=0;i<arrBAOurRow.size();i++){
	arrCol	= (ArrayList)arrBAOurRow.get(i); %>
<tr>
<td align="left"><%=i+1%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
<%if(!strFormat.equalsIgnoreCase("Y")) { %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(15))%></td>
<%} %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(17))%></td>
</tr>
<%}} %>
</table>
</td>
</tr>
<%} %>
<%--<%if(!Helper.correctNull((String)hshValues.get("com_TermLaonREpay")).equalsIgnoreCase("")){ %>
<tr><td><br><b>Terms of repayment incase of Term Loans / DPN loans:</b></td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("com_TermLaonREpay"))%><br></td></tr>
<%} else { %>
<tr><td><b>Terms of repayment incase of Term Loans / DPN loans:</b> Nil</td></tr>
<%} %>--%>
<tr><td>
<br><b>Asset classification : </b>&nbsp;<%=Helper.correctNull((String)hshValues.get("strAssetClassification"))%>
&nbsp;<%if(!Helper.correctNull((String)hshValues.get("com_asscladate")).equals("")) { %>as on <%=Helper.correctNull((String)hshValues.get("com_asscladate"))%><%} %>
</td>
</tr>

<% if(!Helper.correctNull((String)hshValues.get("strCommentonArrears")).equalsIgnoreCase("Nil"))
	{ %>
<tr><td><br><b>Comment on Arrears :</b></td></tr>
<tr>
	<td><%=Helper.correctNull((String)hshValues.get("strCommentonArrears"))%></td>
</tr>
<%} else { %>
	<tr><td><br><b>Comment on Arrears : </b>&nbsp;<%=Helper.correctNull((String)hshValues.get("strCommentonArrears"))%></td></tr>
<%} %>
<tr>
	<td><br>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td width="50%" nowrap colspan="10"><b>Details of Credit facilities with other Banks/ NBFCs/ ECB/ Others :</b></td>
			<td width="50%" align="right"></td>
		</tr>
		</table>
		<br>
		<div id="top">
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
		if(arrBAOtherRow!=null && arrBAOtherRow.size()>0){
			int n=0;
			for(int j=0;j<arrBAOtherRow.size();j++)
			{
				arrCol=(ArrayList)arrBAOtherRow.get(j);
				%>
				<%if(n==0){ n++;%>
				
		 <tr>
		<td width="3%" align="center"><b>S.No</b></td>
		<td width="17%" align="center"><b>Name of the Bank</b></td>
		<td width="17%" align="center"><b>Nature of facility</b></td>
		<td width="10%" align="center"><b>Facility</b></td>
		<td width="10%" align="center"><b>Purpose</b></td>
		<td width="10%" align="center"><b>Limit</b></td>
		<td width="10%" align="center"><b>Balance</b></td>
		<td width="10%" align="center"><b>Balance as on</b></td>
		<td width="10%" align="center"><b>ROI/ Com %</b></td>
		<td width="10%" align="center"><b>Due Date</b></td>
		<td width="10%" align="center"><b>Security Description</b></td>
		<td width="10%" align="center"><b>Security Value</b></td>
		<td width="10%" align="center"><b>Arrears if any</b></td>
		</tr>
		<%} %>
		<tr>
		<td align="center"><%=j+1%></td> 
		<td><%=Helper.correctNull((String)arrCol.get(11))%></td> 
		<td><%=Helper.correctNull((String)arrCol.get(10))%></td> 
		<td><%=Helper.correctNull((String)arrCol.get(0))%></td> 
		<td><%=Helper.correctNull((String)arrCol.get(12))%></td> 
		<td><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>  
		<td><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
		<td><%=Helper.correctNull((String)arrCol.get(7))%></td> 
		<td><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
		<td><%=Helper.correctNull((String)arrCol.get(8))%></td> 
		<td><%=Helper.correctNull((String)arrCol.get(14))%></td>
		<td><%=Helper.correctNull((String)arrCol.get(15))%></td>
		<td><%=Helper.correctNull((String)arrCol.get(9))%></td> 
		</tr>     	
		<%
			}}else{
		%>
		<tr>
		<td colspan="11" align="center">- Nil -</td>
		</tr>
		<%} %>
		</table>
		</div>
	</td>
</tr>
<%if(!strFormat.equalsIgnoreCase("Y")){ %>
<tr>
	<td>
		<div align="left" id="top">
			<jsp:include page="../print/com_consortiumPrint.jsp" flush="true">
			<jsp:param name="pagevalue" value="ANN3"/>
			<jsp:param name="pagevalueAmt" value="<%=strAmtValueIn %>"/>
			</jsp:include>
		</div>
	</td>
</tr>
<%}{ %>
<% if (!Helper.correctNull((String)hshValues.get("fin_comments1bankargmnt")).equalsIgnoreCase("")) { %>
<tr><td><br><b>Remarks:</b></td></tr>
<tr><td style="text-align: justify;"><%=Helper.correctNull((String)hshValues.get("fin_comments1bankargmnt"))%></td></tr>
<%} }%>

<!-- Banking Arrangement Term Loan-->
<%{
if(arrBARow!=null&&arrBARow.size()>0){ %>
<tr><td class="title"><br>Term Loan</td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%iVal=0;strVal="";
if(arrBARow!=null&&arrBARow.size()>0){ %>
<tr>
<td width="3%" align="center"><b>SI.No</b></td>
<td width="32%" align="center"><b>Facility</b></td>
<td width="35%" align="center"><b>Name of the Bank</b></td> 
<td width="10%" align="center"><b>Limit</b></td>
<td width="10%" align="center"><b>Outstanding</b></td>
<td width="10%" align="center"><b>O/s as on</b></td>
</tr>
<%for(int i=0;i<arrBARow.size();i++){
	arrCol	= (ArrayList)arrBARow.get(i);
	
	if(Helper.correctNull((String)arrCol.get(17)).equals("2")||Helper.correctNull((String)arrCol.get(17)).equalsIgnoreCase("T")||Helper.correctNull((String)arrCol.get(17)).equalsIgnoreCase("HC"))
	{
		if(strVal.equals(Helper.correctNull((String)arrCol.get(0))))
		{
%>
<tr>
<td align="left"><%=Helper.correctNull((String)arrCol.get(4))%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(14))))),strAmountValue)%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(15))))),strAmountValue)%></td>
<td align="center"><%=Helper.correctNull((String)arrCol.get(16))%></td>
</tr>
<%}else{ %>
<tr>
<td align="left" rowspan="2"><%=++iVal%></td>
<td align="left" rowspan="2"><%=Helper.correctNull((String)arrCol.get(1)).toUpperCase()%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(4)).toUpperCase()%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(14))))),strAmountValue)%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(15))))),strAmountValue)%></td>
<td align="center"><%=Helper.correctNull((String)arrCol.get(16))%></td>
</tr>
<%}strVal	= Helper.correctNull((String)arrCol.get(0)); }}}else{%>
<tr><td style="border: none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>
</tr>

<tr><td class="title"><br>Remarks:</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("TLComments"))%></td></tr>
<%} %>

<%String genComments= Helper.correctNull((String)hshValues.get("hshPerformance"));
if(!(genComments.equalsIgnoreCase(""))){
%>
<tr><td><b>Comment on the performance : </b></td></tr>
<tr><td><%=genComments%></td></tr>
<%}else{ %>
<tr><td><b>Comment on the performance : </b>&nbsp;Nil</td></tr>
<%} %>

<%genComments= Helper.correctNull((String)hshValues.get("hshCreditinforeport"));
if(!(genComments.equalsIgnoreCase(""))){
%>
<tr><td><b>Comment on the Credit Information Report : </b></td></tr>
<tr><td><%=genComments%></td></tr>
<%}else{ %>
<tr><td><b>Comment on the Credit Information Report : </b>&nbsp;Nil</td></tr>
<%} %>

<%genComments= Helper.correctNull((String)hshValues.get("hshConfidentialopinion"));
if(!(genComments.equalsIgnoreCase(""))){
%>
<tr><td><b>Comment on the Confidential Opinion : </b></td></tr>
<tr><td><%=genComments%></td></tr>
<%}else{ %>
<tr><td><b>Comment on the Confidential Opinion : </b>&nbsp;Nil</td></tr>
<%}
if(!proposalFormat.equalsIgnoreCase("RPN")){%>
<tr><td><br><b><u>SECURITIES : </u></b></td></tr>


<%
ArrayList arrpropsecurityRow=new ArrayList();
ArrayList arrpropsecCollRow=new ArrayList();
arrpropsecurityRow=(ArrayList)hshValues.get("arrExistingSecfacwise");
arrpropsecCollRow=(ArrayList)hshValues.get("arrcollateralforEF");
if(!strGroupSecFlag.equalsIgnoreCase("M")){
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td><b><br>A. Already available for the existing facilities : </b><div align="right"><%=strAmtValueIn%></div></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td>
</tr>
<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>

<tr>
<td colspan="4"><b>Prime :</b></td>
</tr>

<% 

if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
	for(int i=0;i<arrpropsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
				  secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%> (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%> <%if(!Helper.correctNull((String)arrpropsecurity.get(5)).equalsIgnoreCase("")){ %><b>(<%=Helper.correctNull((String)arrpropsecurity.get(5)) %>)</<%} %></td>
		 <td  align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>	
		<%} else {%>
		<tr><td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		</tr>
		<%	}}
	}
} }
%>
<%if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
<td colspan="4"><b>Collateral :</b></td>
</tr>
<% 
if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
	for(int i=0;i<arrpropsecCollRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
			 %>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%> <%if(!Helper.correctNull((String)arrpropsecurityCol.get(3)).equalsIgnoreCase("")){ %><b>(<%=Helper.correctNull((String)arrpropsecurityCol.get(3)) %>)</<%} %></td>
		 <td  align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	
	}
} }
%>
</TABLE>
</div><br>
</td>
</tr>
<% }else{ %>
<tr><td><b><br>A. Already available for the existing facilities : </b> Nil</td></tr>
<%}}else if(strGroupSecFlag.equalsIgnoreCase("M")) {%>
<tr><td><b><br>A. Already available for the existing facilities : </b> </td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("COMSEC_GROUPCOMMENTS"))%></td></tr>
<%} 
if(strFormat.equalsIgnoreCase("Y")){
if(!Helper.correctNull((String)hshValues.get("COMRBI_CMDPROCESSLEGAL")).equalsIgnoreCase("")){%>
<tr class="title"><td>Legal Audit :</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("COMRBI_CMDPROCESSLEGAL"))%></td></tr>
<%}}
arrproposedsecurityRow=(ArrayList)hshValues.get("arrproposedFacility");
arrpropsecCollRow=(ArrayList)hshValues.get("arrproposedCollateralSec");
if((arrproposedsecurityRow!=null && arrproposedsecurityRow.size()>0)||(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td><b><br><%if(!strFormat.equalsIgnoreCase("Y")){ %>B. Additional / Fresh securities offered for the proposed facilities/Security released :<%}else{ %>B. Additional Securities Offered:<%} %></b><div align="right"><%=strAmtValueIn%></div></td></tr>
<tr><td><b>Additional / Fresh Securities Offered:</b></td></tr>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">


<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if(arrproposedsecurityRow!=null && arrproposedsecurityRow.size()>0){ %>
<tr align="left">
<td colspan="4"><b>Prime :</b></td>
</tr>
<%for(int i=0;i<arrproposedsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrproposedsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
					secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		<td  rowspan="<%=(arrpropsecurityCol.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		 <td align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>
		<%} else {
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		</tr>		
		<%	}}
	}
}
arrproposedsecurityRow=(ArrayList)hshValues.get("arrproposedCollateralSec");
arrpropsecurity=new ArrayList();
arrpropsecurityCol=new ArrayList();
secValue = "";
%>
<%if(arrproposedsecurityRow!=null && arrproposedsecurityRow.size()>0){%>
<tr align="left">
<td colspan="4"><b>Collateral :</b></td>
</tr>
	<%for(int i=0;i<arrproposedsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrproposedsecurityRow.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	
	}
}
%>
</table>
</div>
</td>
</tr>
<%String strAdditionalsecoffered=Helper.correctNull((String)hshValues.get("hshAdditionalsec")); 
if(!strAdditionalsecoffered.equalsIgnoreCase("")){%>
<tr><td><b>Comments</b></td></tr>
<tr><td><%=strAdditionalsecoffered%></td></tr>
<%}
} else { %>
<tr><td><b><br><%if(!strFormat.equalsIgnoreCase("Y")){ %>B. Additional / Fresh securities offered for the proposed facilities/Security released :<%}else{ %>B. Additional Securities Offered:<%} %></b> Nil</td></tr>
<%}  %>

<%if(!strFormat.equalsIgnoreCase("Y")){ %>
<%arrpropsecurityRow=new ArrayList();
arrpropsecCollRow=new ArrayList();
arrpropsecurityRow=(ArrayList)hshValues.get("arrReleasedSecPrime");
arrpropsecCollRow=(ArrayList)hshValues.get("arrReleasedSecCollateral");
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td><b><br>Released Securities</b><div align="right"><%=strAmtValueIn%></div></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
<tr align="left">
<td colspan="5"><b>Prime :</b></td>
</tr>
<% 

arrpropsecurityCol=new ArrayList();
arrpropsecurity=new ArrayList();
secValue = "";
if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
	for(int i=0;i<arrpropsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
				  secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue)%>)</td>
		<td rowspan="<%=(arrpropsecurityCol.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		 <td align="right" rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		 <td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>
		<%} else {
		%>
		<tr>
		<td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue)%>)</td>
		</tr>		
		<%	}}
	}
} }
if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
<td colspan="4" align="left"><b>Collateral:</b></td>
</tr>
<% 
arrpropsecurityCol=new ArrayList();
arrpropsecurity=new ArrayList();
secValue = "";
if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
	for(int i=0;i<arrpropsecCollRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	
	}
} }
%>
</TABLE>
</div><br>
</td>
</tr>
<%} %>
<tr>
<td>&nbsp;<br></td>
</tr>
<%} %>

<%if(!proposalFormat.equalsIgnoreCase("MCFD")) {
if(!Helper.correctNull((String)hshValues.get("security_legalopinioncmts")).equalsIgnoreCase("")){ %>
<tr class="title">
<td><%if(!strFormat.equalsIgnoreCase("Y")){ %>
Comments on Legal opinion / Valuation Report :
<%}else{ %>
Comments of Legal Opinion & valuation of the property offered as security
<%} %>
</td>
</tr>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("security_legalopinioncmts")) %></td>
</tr>
<%}} %>

<%if(strFormat.equalsIgnoreCase("Y")){ %>

<%if(!Helper.correctNull((String)hshValues.get("strSecIndpendentEval")).equalsIgnoreCase("")){ %>
<tr class="title"><td>Note on independent evaluation of the value of the properties</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("strSecIndpendentEval")) %></td></tr>
<%}
if(!Helper.correctNull((String)hshValues.get("strSecSection185")).equalsIgnoreCase("")){ %>
<tr class="title"><td>Comment as to section 185 & 186 of Companies Act</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("strSecSection185")) %></td></tr>
<%}
if(!Helper.correctNull((String)hshValues.get("strSecCERSAI")).equalsIgnoreCase("")){ %>
<tr class="title"><td>Comment on Search made in CERSAI database</td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("strSecCERSAI")) %></td></tr>
<%}%>

<%} %>
<%
if(!strProposedSecurity.equalsIgnoreCase("M")){
arrpropsecurityRow=new ArrayList();
arrpropsecCollRow=new ArrayList();
arrpropsecurityRow=(ArrayList)hshValues.get("arrproposedSecfacwise");
arrpropsecCollRow=(ArrayList)hshValues.get("arrRowCollSec");
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr><td><b><br><%if(!strFormat.equalsIgnoreCase("Y")&&(!proposalFormat.equalsIgnoreCase("RPN"))){ %>C. Securities for the proposed / renewed facilities : </b><%}else{ %>  <%} %><div align="right"></div></td></tr>
<% if((!proposalFormat.equalsIgnoreCase("RPN"))){%>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
<tr align="left">
<td colspan="5"><b>Prime :</b></td>
</tr>
<% 

arrpropsecurityCol=new ArrayList();
arrpropsecurity=new ArrayList();
secValue = "";
if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
	for(int i=0;i<arrpropsecurityRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(i);
		  for(int k=0;k<arrpropsecurityCol.size();k++) {
			  arrpropsecurity=(ArrayList)arrpropsecurityCol.get(k);
			  if(k==0) {
				  secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue)%>)</td>
		 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		  <td align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
		<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>
		<%} else {
		%>
		<tr>
		 <td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.converAmount(Helper.correctDouble(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue)%>)</td>
		</tr>		
		<%	}}
	}
} }
if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
<td colspan="4" align="left"><b>Collateral:</b></td>
</tr>
<% 
arrpropsecurityCol=new ArrayList();
arrpropsecurity=new ArrayList();
secValue = "";
if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
	for(int i=0;i<arrpropsecCollRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
		secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1)))),strAmountValue);
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="2"> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrpropsecurityCol.get(0)))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%	
	}
} }
%>
</TABLE>
</div><br>
</td>
</tr>
<% }}else{%>
<tr><td><b><br><%
if(!strFormat.equalsIgnoreCase("Y")&&(!proposalFormat.equalsIgnoreCase("RPN"))){ %>C. Securities for the proposed / renewed facilities : </b><%}else{ %>C. Securities/Consolidated Securities for the proposed limits:   <%} %></b> Nil</td></tr>
<%}}else if(strProposedSecurity.equalsIgnoreCase("M")){%>
<tr><td><b><br>C. Securities for the proposed / renewed facilities :</b> </td></tr>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("strProposedSecurityComments"))%></td>
</tr>
<%} %>
<tr>
			<td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% 
			ArrayList arrpropsecurityCersaiQues=new ArrayList();
			arrpropsecurityCersaiQues=(ArrayList)hshValues.get("arrOutCersaiQues");
			//out.println("arrpropsecurityCersaiQues==>>"+arrpropsecurityCersaiQues);
			if(arrpropsecurityCersaiQues!=null && arrpropsecurityCersaiQues.size()>0)
					{
			%>
			<tr class="tblhead"><td colspan="11"><span style="float: left;"><b>CERSAI Search details : </b></span></td></tr>
					<tr>
					<td  align="center" width="10%"><b>Security ID</b></td>
					<td  align="center" width="10%"><b>CERSAI Search Ref No</b></td>
					<td  align="center" width="5%"><b>CERSAI search Date</b></td>
					<td  align="center" width="10%"><b>CERSAI ID</b></td>
					<td  align="center" width="5%"><b>CERSAI ID Creation Date</b></td>
					<td  align="center" width="10%"><b>Whether property offered is already mortgaged to our Bank</b></td>
					<td  align="center" width="10%"><b>Whether our bank charge reflected</b></td>
					<td  align="center" width="10%"><b>Reason for other bank charge being reflected</b></td>
					<td  align="center" width="10%"><b>Reason for our bank charge not reflecting</b></td>
					<td  align="center" width="10%"><b>Any charge on the property observed</b></td>
					<td  align="center" width="10%"><b>Reason/Remarks For Any charge on the property observed</b></td>
					</tr>
					<%
					arrpropsecurityCol=new ArrayList();
			String SEC_ALREADY_MORTG="",SEC_CHARG_REFLECT="",SEC_OTHERBNK_REMARK="",SEC_REMARK_NOT_REFLECT="",SEC_PROP_OBSERVED="",SEC_REMARKS="";
					
						for(int q=0;q<arrpropsecurityCersaiQues.size();q++)
						{
		
							arrpropsecurityCol=(ArrayList)arrpropsecurityCersaiQues.get(q);
						  
							SEC_ALREADY_MORTG=Helper.correctNull((String)arrpropsecurityCol.get(1));
							if(!SEC_ALREADY_MORTG.equalsIgnoreCase("")){
								if(SEC_ALREADY_MORTG.equalsIgnoreCase("Y"))
								{
									SEC_ALREADY_MORTG = "YES";
								}else if(SEC_ALREADY_MORTG.equalsIgnoreCase("N")){
									SEC_ALREADY_MORTG = "NO";
								}
							}
							SEC_CHARG_REFLECT=Helper.correctNull((String)arrpropsecurityCol.get(2));
							if(!SEC_CHARG_REFLECT.equalsIgnoreCase("")){
								if(SEC_CHARG_REFLECT.equalsIgnoreCase("Y"))
								{
									SEC_CHARG_REFLECT = "YES";
								}else if(SEC_CHARG_REFLECT.equalsIgnoreCase("YO"))
								{
									SEC_CHARG_REFLECT = "Yes, but along with other bank";
								}else if(SEC_CHARG_REFLECT.equalsIgnoreCase("N")){
									SEC_CHARG_REFLECT = "NO";
								}
							}
							SEC_OTHERBNK_REMARK=Helper.correctNull((String)arrpropsecurityCol.get(3));
							SEC_REMARK_NOT_REFLECT=Helper.correctNull((String)arrpropsecurityCol.get(4));
							if(SEC_REMARK_NOT_REFLECT.equalsIgnoreCase("")){
								SEC_REMARK_NOT_REFLECT = "-";
							}
							SEC_PROP_OBSERVED=Helper.correctNull((String)arrpropsecurityCol.get(5));
							
							if(!SEC_PROP_OBSERVED.equalsIgnoreCase("")){
								if(SEC_PROP_OBSERVED.equalsIgnoreCase("Y"))
								{
									SEC_PROP_OBSERVED = "YES";
								}else if(SEC_PROP_OBSERVED.equalsIgnoreCase("N")){
									SEC_PROP_OBSERVED = "NO";
								}
							}else{
								SEC_PROP_OBSERVED = "-";
							}
							SEC_REMARKS=Helper.correctNull((String)arrpropsecurityCol.get(6));
							if(SEC_REMARKS.equalsIgnoreCase("")){
								SEC_REMARKS = "-";
							}
							String Secid = Helper.correctNull((String)arrpropsecurityCol.get(7));
							String cerSearchid = Helper.correctNull((String)arrpropsecurityCol.get(9));
							String cerSearchDate = Helper.correctNull((String)arrpropsecurityCol.get(10));
							String cerid = Helper.correctNull((String)arrpropsecurityCol.get(8));
							String cerDate = Helper.correctNull((String)arrpropsecurityCol.get(11));
							%>
					<tr>
					<% 	if(!Secid.equalsIgnoreCase("")){ %>
					<td  align="center" width="10%"><%=Secid%></td>
					<%}else{ %>
					<td  align="center" width="10%">-</td>
					<%}if(!cerSearchid.equalsIgnoreCase("")){ %>
					<td align="center" width="10%">
											 <% 
												
												String strArr1[]=cerSearchid.split(",");
												for(int r1=0;r1<strArr1.length;r1++)
												{
												%>
												<%=strArr1[r1]%><br/>
												<%	}
												%>
					</td>
					<%}else{ %>	
					<td  align="center" width="10%">-</td>
					<%} %>
					<%if(!cerSearchDate.equalsIgnoreCase("")){ %>
					<td align="center" width="5%"><%
											 String strArr2[]=cerSearchDate.split(",");
												for(int r2=0;r2<strArr2.length;r2++)
												{
													%>
													<%=strArr2[r2]%><br/>
											 <%	}%></td>
					<%}else{ %>
					<td  align="center" width="5%">-</td>
					<%} if(!cerid.equalsIgnoreCase("")){%>
					<td align="center" width="10%">
											 <% 
												String strArr3[]=cerid.split(",");
												for(int r3=0;r3<strArr3.length;r3++)
												{
											%>
												<%=strArr3[r3]%><br/>
												 
											<%	}
												%></td>	
						<%}else{ %>	
						<td  align="center" width="10%">-</td>
						<%} if(!cerDate.equalsIgnoreCase("")){%>					
						<td align="center" width="5%"><%
											 String strArr4[]=cerDate.split(",");
												for(int r4=0;r4<strArr4.length;r4++)
												{
													%>
													<%=strArr4[r4]%><br/>
											 <%	}%></td>
						<%}else{ %>
						<td  align="center" width="5%">-</td>
						<%} if(!SEC_ALREADY_MORTG.equalsIgnoreCase("")){%>
						<td  align="center" width="10%"><%=SEC_ALREADY_MORTG%></td>
						<%}else{ %>
						<td  align="center" width="10%">-</td>
						<%}if(!SEC_CHARG_REFLECT.equalsIgnoreCase("")){ %>
						<td  align="center" width="10%"><%=SEC_CHARG_REFLECT%></td>
						<%}else{ %>
						<td  align="center" width="10%">-</td>
						<%}if(!SEC_OTHERBNK_REMARK.equalsIgnoreCase("")){ %>
						<td  align="center" width="10%"><%=SEC_OTHERBNK_REMARK%></td>
						<%}else{ %>
						<td  align="center" width="10%">-</td>
						<%} %>
						<td  align="center" width="10%"><%=SEC_REMARK_NOT_REFLECT%></td>
						<td  align="center" width="10%"><%=SEC_PROP_OBSERVED%></td>
						<td  align="center" width="10%"><%=SEC_REMARKS%></td>
			</tr>
			<% }} %>
			</table>
			</div>	
			</td> 
			</tr>

<%if(proposalFormat.equalsIgnoreCase("MCFD")&&(!proposalFormat.equalsIgnoreCase("RPN"))) {%>
<%if(!Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")).equalsIgnoreCase("")){ %>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
<%=Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")) %>
</td>
</table>
</div>
</td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("security_legalopinioncmts")).equalsIgnoreCase("")){ %>
<tr class="title">
	<td>
	Comments on Legal opinion / Valuation Report :
	</td>
</tr>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("security_legalopinioncmts")) %></td>
</tr>
<%} }%>
<!-- Starts here.. -->


<%
if(!strAppSecFlag.equalsIgnoreCase("M")){
	if(strFlag.equalsIgnoreCase("E")){%>
<tr>
<td><b> Security coverage for Bank's exposure to the applicant :</b><div align="right"><%=strAmtValueIn%></div></td>
</tr>
<%if(!proposalFormat.equalsIgnoreCase("MCFD") && !strFormat.equalsIgnoreCase("Y")) {%>
<tr>
		<td align="left"><%=Helper.correctNull((String)hshValues.get("cmt_presanccommentsforannex")).trim() %></td>
</tr>
<%}else{ %>
<tr>
			<td><%=strPreSancSecComments%>&nbsp;</td>
		</tr>
<%} %>
<tr>
	<td>
		<div align="left" id="top">
			<jsp:include page="../print/Securitiesprint.jsp" flush="true">
			<jsp:param name="pageVal" value="Security"/>
			</jsp:include>
		</div>
	</td>
</tr>
<%if(!proposalFormat.equalsIgnoreCase("MCFD") && !strFormat.equalsIgnoreCase("Y")) {%>
<tr>
	<td align="left"><%=Helper.correctNull((String)hshValues.get("cmt_postsanccommentsforannex")).trim() %> </td>
</tr>
<%}else{ %>
<tr>
					<td><%=strPostSancSecComments%>&nbsp;</td>
				</tr>
<%}}else{%>
<tr>
<td><b>Security coverage for Bank's exposure to the applicant:</b><%=strNil%></td>
</tr>
<%}}else if(strAppSecFlag.equalsIgnoreCase("M") && strAppSecManualFlag.equalsIgnoreCase("E")){ %>
<tr>
<td><b>Security coverage for Bank's exposure to the applicant:</b></td>
</tr>
<%if(!proposalFormat.equalsIgnoreCase("MCFD") && !strFormat.equalsIgnoreCase("Y")) {%>
<tr>
		<td align="left"><%=Helper.correctNull((String)hshValues.get("cmt_presanccommentsforannex")).trim() %></td>
</tr>
<%}else{ %>
<tr>
			<td><%=strPreSancSecComments%>&nbsp;</td>
		</tr>
<%} %>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS"))%></td>
</tr>
<%if(!proposalFormat.equalsIgnoreCase("MCFD") && !strFormat.equalsIgnoreCase("Y")) {%>
<tr>
	<td align="left"><%=Helper.correctNull((String)hshValues.get("cmt_postsanccommentsforannex")).trim() %> </td>
</tr>
<%}else{ %>
<tr>
					<td><%=strPostSancSecComments%>&nbsp;</td>
				</tr>
<%}%>
<%} }}%>
<!-- End -->
		


<!-- Group Concern Our Bank -->
<tr><td class="title"><br><u> Group Concerns :</u></td></tr>
<%ArrayList arrRow1 = new ArrayList();
String strGrpconcern="";
if(arrGroupconcerns!=null && arrGroupconcerns.size()>0){%>
<tr><td class="Subtitle"><br><b>Details of group concerns / Sister Concerns :</b></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<%for(int s=0;s<arrGroupconcerns.size();s++){
		strGrpconcern=Helper.correctNull((String)arrGroupconcerns.get(s));
int Count=0; %>
<%arrGroupConcernDetailsRow1	= (ArrayList)hshValues.get("arrGroupConcernDetails1"+strGrpconcern);

if((arrGroupConcernDetailsRow1!=null && arrGroupConcernDetailsRow1.size()>0)){
	if(s==0){%>
<tr>
   <td><b>Sl.No</b></td>
   <td><b>Name of the concern</b></td>
   <td><b>Constitution</b></td>
    <td><b>Type of Concern</b></td>
    <td><b>Activity/ Nature of business</b></td>
    <td><b>Bankers</b></td>
</tr>
<%} %>
<%for(int i=0;i<arrGroupConcernDetailsRow1.size();i++){
		arrGroupConcernDetailsCol1=(ArrayList)arrGroupConcernDetailsRow1.get(i);
		arrRow1=(ArrayList)arrGroupConcernDetailsCol1.get(5);
		Count++;
	%>
	<tr>
	<td><%=s+1%></td>
	<td><%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(2)))%>.<%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(1)))%></td>
	<td><%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(0)))%></td>
	<td><%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(8)))%></td>
	<td><%=Helper.correctNull((String)arrGroupConcernDetailsCol1.get(3))%></td>
	<td><%=Helper.correctNull((String)arrGroupConcernDetailsCol1.get(6))%></td>	
	</tr>
<%} }}%>

</table>
</div>
</td>
</tr>
<%}%>

<%arrRow1 = new ArrayList();
strGrpconcern="";
if(arrGroupconcerns!=null && arrGroupconcerns.size()>0){
	for(int s=0;s<arrGroupconcerns.size();s++){
		strGrpconcern=Helper.correctNull((String)arrGroupconcerns.get(s));
		arrGroupConcernDetailsRow1	= (ArrayList)hshValues.get("arrGroupConcernDetails1"+strGrpconcern);
		
		if((arrGroupConcernDetailsRow1!=null && arrGroupConcernDetailsRow1.size()>0)){
			for(int i=0;i<arrGroupConcernDetailsRow1.size();i++){
				arrGroupConcernDetailsCol1=(ArrayList)arrGroupConcernDetailsRow1.get(i);
				if((arrGroupConcernDetailsCol1!=null && arrGroupConcernDetailsCol1.size()>0)){
					%>
					<tr class="title"><td><b><u><%=Helper.correctNull((String)arrGroupConcernDetailsCol1.get(2)).toUpperCase() %>.<%=Helper.changetoTitlecase(Helper.correctNull((String)arrGroupConcernDetailsCol1.get(1))).toUpperCase() %></u></b></td></tr>
					<%
				}
				}
		}
int Count=0;
arrCGOurRow		= (ArrayList)hshValues.get("arrCGOurRow"+strGrpconcern);
arrSecGroupRow=(ArrayList)hshValues.get("arrExisFacgroupRow"+strGrpconcern);
if(arrSecGroupRow!=null && arrSecGroupRow.size()>0){%>
<tr><td class=""><br><b>Details of existing Credit facilities with our Bank :</b> <div align="right"> <%=strValuesIn %></div> </td></tr>
<%for(int i=0;i<arrSecGroupRow.size();i++){ 
	arrCol	= (ArrayList)arrSecGroupRow.get(i);
%>
<tr><td><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
<%} %>
<%
}else{
if(arrCGOurRow!=null && arrCGOurRow.size()>0)
{ 
ArrayList arr=new ArrayList();
int k=0;
%>
<tr><td class=""><br><b>Details of existing Credit facilities with our Bank :</b> <div align="right"> <%=strAmtValueIn %></div> </td></tr>

<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

<% 
	for(int i=0;i<arrCGOurRow.size();i++){
		arrCol	= (ArrayList)arrCGOurRow.get(i);
	if(k==0) {	
	k++;
%>
<tr><td colspan="3"><b><%=(i+1) %>. Name of the concern </b></td>
<td colspan="6"><b><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(1)))%>.<%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(2)))%></b></td></tr>
<tr><td colspan="3"><b>Rating </b></td>
<%String strTemp=Helper.correctNull((String)arrCol.get(5));
if(strTemp.equalsIgnoreCase("A"))
{
	strTemp="Audited";
}
else if(strTemp.equalsIgnoreCase("E")){
	strTemp="Estimated";	
}
else if(strTemp.equalsIgnoreCase("U")){
	strTemp="Unaudited";
}else if(strTemp.equalsIgnoreCase("P")){
	strTemp="Projection";
}
else
{
	strTemp="";
}
%>
<td colspan="6"><%=Helper.correctNull((String)arrCol.get(3))+"-"+Helper.correctNull((String)arrCol.get(4))%>&nbsp;<%if(!strTemp.equalsIgnoreCase("")){ %>[<%=strTemp%>]<%} %></td></tr>

<%} else { 
if(k==1){
k++;%>
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<td width="10%" align="center"><b>Limit</b></td>
<td width="10%" align="center"><b>Purpose</b></td>
<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
<td width="10%" align="center"><b>ROI/ Com %</b></td>
<td width="10%" align="center"><b>Balance as on &nbsp; - &nbsp;<%=Helper.correctNull((String)arrCol.get(8))%></b></td>
<td width="10%" align="center"><b>Due Date</b></td>
<td width="10%" align="center"><b>Arrears if any</b></td>
</tr>
<%} %>
<tr>
<td align="left"><%=i%> .</td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(1)).toUpperCase()%></td>
<%if(Helper.correctNull((String)arrCol.get(16)).equalsIgnoreCase("M")) {%>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%></td>
<%}else{ %>
<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>)</td>
<%} %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(2))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
<%if(Helper.correctNull((String)arrCol.get(16)).equalsIgnoreCase("M")) {%>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%>&nbsp;</td>
<%}else{ %>
<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%>)&nbsp;</td>
<%} %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%></td>
</tr> <%} 
}%>
</table></div></td></tr> 
<%if(!strFormat.equalsIgnoreCase("Y")){ %>
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(arrCGOurRow!=null && arrCGOurRow.size()>0){ %>
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<td width="10%" align="center"><b>Remarks</b></td>
<td width="10%" align="center"><b>Comments on Repayment</b></td>
</tr>
<%
for(int i=1;i<arrCGOurRow.size();i++){
	arrCol	= (ArrayList)arrCGOurRow.get(i); %>
<tr>
<td align="left"><%=i%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(1)).toUpperCase()%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(14))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(15))%></td>
</tr>
<%}} %>
</table>
</td>
</tr>
<%} %>
<% }else{ %>
<tr><td class=""><br><b>Details of existing Credit facilities with our Bank : </b><%=strNil%> </td></tr>
<%} } %>

<%-- 
<%if(!Helper.correctNull((String)hshValues.get("com_GroupConfac")).equalsIgnoreCase("")){ %>
<tr><td><b>Terms of repayment incase of Term Loans / DPN loans:</b></td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("com_GroupConfac"))%></td></tr>
<%} %>

<%if(!Helper.correctNull((String)hshValues.get("com_Grouprepay")).equalsIgnoreCase("")){ %>
<tr><td><b>Remarks :</b></td></tr>
<tr><td><%=Helper.correctNull((String)hshValues.get("com_Grouprepay"))%></td></tr>
<%} %>--%>
<%
if(!proposalFormat.equalsIgnoreCase("RPN")){
if(!Helper.correctNull((String)hshValues.get("COM_ASSETCLASS"+strGrpconcern)).equalsIgnoreCase("")){ %>
<tr><td><br><b>Asset Classification : </b>&nbsp;<%=Helper.correctNull((String)hshValues.get("COM_ASSETCLASS"+strGrpconcern))%>
&nbsp;<%if(!Helper.correctNull((String)hshValues.get("com_asscladate"+strGrpconcern)).equals("")) { %>as on <%=Helper.correctNull((String)hshValues.get("com_asscladate"+strGrpconcern))%><%} %>
</td></tr>
<%}else{ %>
<tr><td><br><b>Asset Classification : </b>&nbsp;Nil
</td></tr>
<%} %>
<% if(!Helper.correctNull((String)hshValues.get("Arrears"+strGrpconcern)).equalsIgnoreCase("")){%>
<tr><td><b><br>Comment on Arrears :</b></td></tr>
<tr><td><div><%=Helper.correctNull((String)hshValues.get("Arrears"+strGrpconcern))%></div></td></tr>
<%}else{ %>
	<tr><td><br><b>Comment on Arrears : </b>&nbsp;Nil</td></tr>
<%}} %>

<!-- Group Concern Other Bank -->
<%if(!strFormat.equalsIgnoreCase("Y")){ 
if((arrGroupConcernDetailsRow1!=null && arrGroupConcernDetailsRow1.size()>0)){ %>
<tr><td><b><br>Details of Credit facilities with other Banks/ NBFCs/ ECB/ Others :</b></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(arrGroupConcernDetailsRow1!=null && arrGroupConcernDetailsRow1.size()>0){
	for(int i=0;i<arrGroupConcernDetailsRow1.size();i++){
		arrGroupConcernDetailsCol1=(ArrayList)arrGroupConcernDetailsRow1.get(i);			
		arrRow1=(ArrayList)arrGroupConcernDetailsCol1.get(5);
		ArrayList arrCol1=new ArrayList();
	%>
	
    <%if(arrRow1!=null && arrRow1.size()>0){
    	int n=0;
    	for(int j=0;j<arrRow1.size();j++)
    	{
    		arrCol1=(ArrayList)arrRow1.get(j);
    		%>
    		<%if(n==0){ n++;%>
    	<tr>
   <td colspan="13"><b><%=i+1 %>. Name of the concern : </b><%=Helper.correctNull((String)arrGroupConcernDetailsCol1.get(1))%></td>
    </tr>
    		
	   <tr>
		<td width="3%" align="center"><b>S.No</b></td>
		<td width="17%" align="center"><b>Name of the Bank</b></td>
		<td width="17%" align="center"><b>Nature of facility</b></td>
		<td width="10%" align="center"><b>Facility</b></td>
		<td width="10%" align="center"><b>Purpose</b></td>
		<td width="10%" align="center"><b>Limit</b></td>
		<td width="10%" align="center"><b>Balance</b></td>
		<td width="10%" align="center"><b>Balance as on</b></td>
		<td width="10%" align="center"><b>ROI/ Com %</b></td>
		<td width="10%" align="center"><b>Due Date</b></td>
		<td width="10%" align="center"><b>Security Description</b></td>
		<td width="10%" align="center"><b>Security Value</b></td>
		<td width="10%" align="center"><b>Arrears if any</b></td>
		</tr>
    <%} %>
    <tr>
		<td align="center"><%=j+1%></td> 
		<td><%=Helper.correctNull((String)arrCol1.get(11))%></td> 
		<td><%=Helper.correctNull((String)arrCol1.get(10))%></td> 
		<td><%=Helper.correctNull((String)arrCol1.get(0))%></td> 
		<td><%=Helper.correctNull((String)arrCol1.get(12))%></td> 
		<td><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(2))))),strAmountValue)%></td>  
		<td><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(6))))),strAmountValue)%></td>
		<td><%=Helper.correctNull((String)arrCol1.get(7))%></td> 
		<td><%=Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(4)))))%></td>
		<td><%=Helper.correctNull((String)arrCol1.get(8))%></td> 
		<td><%=Helper.correctNull((String)arrCol1.get(13))%></td>
		<td><%=Helper.correctNull((String)arrCol1.get(14))%></td>
		<td><%=Helper.correctNull((String)arrCol1.get(9))%></td> 
		</tr>     	
    <%
    	}	}
    }} %>

</table>
</div>
</td>
</tr>
<%}else{%>
<tr><td><b><br>Details of Credit facilities with other Banks/ NBFCs/ ECB/ Others :</b>&nbsp;Nil</td></tr>
<%} }%>
<%
if(!proposalFormat.equalsIgnoreCase("RPN")){
arrExisSecRow=new ArrayList();
ArrayList arrExisSeccolRow=new ArrayList();
arrExisSecRow=(ArrayList)hshValues.get("arrExisSecRow"+strGrpconcern);
arrExisSeccolRow=(ArrayList)hshValues.get("arrExisSeccollRow"+strGrpconcern);
arrSecGroupRow=(ArrayList)hshValues.get("arrExisSecgroupRow"+strGrpconcern);
if(arrSecGroupRow!=null && arrSecGroupRow.size()>0){%>
<tr><td class=""><br><b>Securities already available for the existing facilities of Group Concern: </b> <div align="right"> <%=strValuesIn %></div> </td></tr>
<%for(int i=0;i<arrSecGroupRow.size();i++){ 
	arrCol	= (ArrayList)arrSecGroupRow.get(i);
%>
<tr><td><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
<%} %>
<%
}
else{
if((arrExisSecRow!=null && arrExisSecRow.size()>0) || (arrExisSeccolRow!=null && arrExisSeccolRow.size()>0)){ %>
<tr><td><b><br>Securities already available for the existing facilities of Group Concern: </b><div align="right"><%=strAmtValueIn%></div></td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if((arrExisSecRow!=null && arrExisSecRow.size()>0)) { %>

<tr>
<td colspan="4"><b>Prime :</b></td>
</tr>
<tr>
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>

<% 

ArrayList arrExisSeccoll=new ArrayList();
arrpropsecurity=new ArrayList();
if(arrExisSecRow!=null && arrExisSecRow.size()>0){
	for(int i=0;i<arrExisSecRow.size();i++)
	{
		arrExisSeccoll=(ArrayList)arrExisSecRow.get(i);
		  for(int k=0;k<arrExisSeccoll.size();k++) {
			  arrpropsecurity=(ArrayList)arrExisSeccoll.get(k);
			  if(k==0) {
					secValue = Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3)))),strAmountValue);
					if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		<td  rowspan="<%=(arrExisSeccoll.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
		 <td align="right"  rowspan="<%=(arrExisSeccoll.size())%>"><%=Helper.correctNull(secValue)%></td>
		 <td  rowspan="<%=(arrExisSeccoll.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
		</tr>
		<%} else {
		%>
		<tr>
		<td><%=Helper.correctNull((String)arrpropsecurity.get(0))%>  (<%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))),strAmountValue) %>)</td>
		</tr>		
		<%	}}
	}
} }
%>
<%if((arrExisSeccolRow!=null && arrExisSeccolRow.size()>0)){ %>
<% 
arrpropsecurityCol=new ArrayList();
arrpropsecurity=new ArrayList();
if(arrExisSeccolRow!=null && arrExisSeccolRow.size()>0){
	for(int i=0;i<arrExisSeccolRow.size();i++)
	{
		arrpropsecurityCol=(ArrayList)arrExisSeccolRow.get(i);
		if(i==0) {
		if((arrExisSecRow!=null && arrExisSecRow.size()==0)) { %>
		<tr>
		<td  rowspan="<%=arrExisSeccolRow.size()+1%>"><b>Collateral</b></td>
		<td  align="center" width="55%"><b>Details of Security</b></td>
		<td  align="center" width="10%"><b>Value</b></td>
		<td  align="center" width="15%"><b>Date of Valuation</b></td>
		</tr>
		<%}else{
		%>
		<tr><td  rowspan="<%=arrExisSeccolRow.size()+1%>"><b>Collateral</b></td></tr>
		<%}}  %>
		<tr>
		 <td> <%=Helper.correctNull(Helper.correctNull((String)arrpropsecurityCol.get(0)))%></td>
		 <td  align="right"><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1))))),strAmountValue)%></td>
		 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
		</tr>		
		<%}
} }
%>
</TABLE>
</div><br>
</td>
</tr>
<% }else{ %>
<tr><td><b><br>Securities already available for the existing facilities  of Group Concern: </b> Nil</td></tr>
<%}}%>
<tr><td>&nbsp;</td></tr>

<%String year1="",year2="",year3="",year4="",year5="";
	arrFindataRow = (ArrayList)hshValues.get("arrFinancialdata"+strGrpconcern);
	arrFinancialRow = (ArrayList)hshValues.get("arrFinancialRow"+strGrpconcern);
	int intarrSize=arrFinancialRow.size();
	ArrayList arrfinyear = (ArrayList)hshValues.get("arrfinyear"+strGrpconcern);
	if(arrfinyear.size()>0 && arrfinyear!=null)
	{
		 year1 = Helper.correctNull((String)arrfinyear.get(0));
		 year2 = Helper.correctNull((String)arrfinyear.get(1));
		 year3 = Helper.correctNull((String)arrfinyear.get(2));
		 year4 = Helper.correctNull((String)arrfinyear.get(3));
		 year5 = Helper.correctNull((String)arrfinyear.get(4));
	}
%>

<%if(!year1.equalsIgnoreCase("")){ %>
<tr><td><b>Financial position of group concerns:</b></td></tr>
<tr>
<td>Company Name:
<b><%=Helper.correctNull((String)hshValues.get("compyname"+strGrpconcern))%></b></td>
</tr>
<tr><td align="right"><%=strFinvaluesin %></td></tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
				
                <%
                ArrayList strType= new ArrayList();
                ArrayList strYear= new ArrayList();
                for(int i=0;i<arrFindataRow.size();i++)
                {
                	arrFindatacol = new ArrayList();
                	arrFindatacol = (ArrayList)arrFindataRow.get(i);
                	strType.add(Helper.correctNull((String)arrFindatacol.get(1)));
                	strYear.add(Helper.correctNull((String)arrFindatacol.get(0)));
                		
                }
                %>
                
                <tr> 
                	<td width="25%">&nbsp;Year</td>
                	<%if(!year1.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)strYear.get(0))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year2.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)strYear.get(1))%>&nbsp;</td>
					<%} %>                  
                    <%if(!year3.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)strYear.get(2))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year4.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)strYear.get(3))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year5.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)strYear.get(4))%>&nbsp;</td>
                  	<%} %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Type</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)strType.get(0))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)strType.get(1))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)strType.get(2))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)strType.get(3))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)strType.get(4))%>&nbsp;</td>
                  <%} %>
                </tr>
                 <%
                	double dblSales1=0,intSales2=0,intSales3=0,intSales4=0,intSales5=0,total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(3)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(3)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(3)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(3)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(3)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
                <%if(total!=0){ %>
                <tr> 
                  <td width="25%">&nbsp;Sales</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%} %>
                <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(18)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(18)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(18)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(18)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(18)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
               <% if(intarrSize>=3){%>
               <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;
                  <%=Helper.correctNull((String)arrFinancialRow.get(3))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%}} %>
                <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(4)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(4)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(4)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(4)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(4)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
                <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;Net Profit</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
                   
               <%} %>
                           <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(6)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(6)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(6)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(6)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(6)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
                <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;Net Worth</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%} %>
               
                         <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(8)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(8)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(8)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(8)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(8)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
                <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;Debt-Equity Ratio</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
					 <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
				</tr>
               <%} %>
               
                       <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(9)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(9)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(9)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(9)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(9)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
                <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;TOL/TNW</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%} %>
                        <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(10)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(10)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(10)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(10)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(10)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
               <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;Current Ratio</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%} %>
                       <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(15)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(15)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(15)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(15)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(15)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
               <% if(intarrSize>=1){%>
               <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)arrFinancialRow.get(0))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%}} %>
               
                      <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(16)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(16)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(16)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(16)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(16)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
               
               <% if(intarrSize>=2){%>
               <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)arrFinancialRow.get(1))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
				  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%}}%>
               
                    <%
                	dblSales1=0;
                	intSales2=0;
                	intSales3=0;
                	intSales4=0;
                	intSales5=0;
                	total=0; 
                	for(int i=0;i<arrFindataRow.size();i++)
                	{
                		arrFindatacol = new ArrayList();
                		arrFindatacol = (ArrayList)arrFindataRow.get(i);
                		if(i==0)
                		{
                			dblSales1=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(17)));	
                		}
                		if(i==1)
                		{
                			intSales2=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(17)));	
                		}
                		if(i==2)
                		{
                			intSales3=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(17)));	
                		}
                		if(i==3)
                		{
                			intSales4=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(17)));	
                		}
                		if(i==4)
                		{
                			intSales5=Double.parseDouble(Helper.correctDouble((String)arrFindatacol.get(17)));	
                		}
                		
                		total=dblSales1+intSales2+intSales3+intSales4+intSales5;
                	}
                %>
               
               
               <% if(intarrSize>=3){%>
               <%if(total!=0){ %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)arrFinancialRow.get(2))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(dblSales1)%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales2)%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales3)%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales4)%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(intSales5)%>&nbsp;</td>
                  <%} %>
               </tr>
               <%}} %>
			</table>
		</div>
	</td>
</tr>
<%}else{ %>
<tr><td><b>Financial position of group concerns:&nbsp;</b>Nil</td></tr>
<%}} %>
<!-- End -->
<%}}else{%>
<tr><td class="Subtitle"><br><b>Details of group concerns :</b> <%=strNil%></td></tr>

<tr><td class=""><br><b>Details of existing Credit facilities with our Bank : </b><%=strNil%> </td></tr>

<%} %>
<%if(!strFormat.equalsIgnoreCase("Y")){ %>
<tr><td class="title">Details of Co-obligants/Guarantors/Partners/Directors :</td></tr>
<%
ArrayList arrPromotors=new ArrayList();
String strPromotors="",strPrevCusID="";
arrPromotors=(ArrayList)hshValues.get("arrPromotors");
for(int s=0;s<arrPromotors.size();s=s+2){
		strPromotors=Helper.correctNull((String)arrPromotors.get(s));
		arrCGOurRow		= (ArrayList)hshValues.get("arrPromoOurRow"+strPromotors);
		
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrPromotors.get(s+1))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrPromotors.get(s+1));		
	}
	
	%>
		<tr><td><u><b><%=Helper.changetoTitlecase(Helper.correctNull((String)arrPromotors.get(s+1))).toUpperCase()%></b></u>&nbsp;</td></tr>
		<%if(arrCGOurRow!=null && arrCGOurRow.size()>0){%>
<tr>
<td class="title">Details of existing Credit facilities with our Bank : <div align="right"> <%=strAmtValueIn %></div></td>
</tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">

<% int k=0;
	for(int i=0;i<arrCGOurRow.size();i++){
		arrCol	= (ArrayList)arrCGOurRow.get(i);
	if(k==0) {	
	k++;
%>
<tr><td colspan="3"><b><%=(i+1) %>. Name of the concern </b></td>
<td colspan="6"><b><%=Helper.changetoTitlecase(Helper.correctNull((String)arrPromotors.get(s+1)))%></b></td></tr>
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<td width="10%" align="center"><b>Limit</b></td>
<td width="10%" align="center"><b>Purpose</b></td>
<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
<td width="10%" align="center"><b>ROI/ Com %</b></td>
<td width="10%" align="center"><b>Balance as on <%=Helper.correctNull((String)arrCol.get(8))%></b></td>
<td width="10%" align="center"><b>Due Date</b></td>
<td width="10%" align="center"><b>Arrears if any</b></td>
</tr>
<%}  %>
<tr>
<td align="left"><%=i+1%> .</td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(1)).toUpperCase()%></td>
<%if(Helper.correctNull((String)arrCol.get(16)).equalsIgnoreCase("M")) {%>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%></td>
<%}else{ %>
<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>)</td>
<%} %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(2))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(4))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
<%if(Helper.correctNull((String)arrCol.get(16)).equalsIgnoreCase("M")) {%>
<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%>&nbsp;</td>
<%}else{ %>
<td align="right">(<%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%>)&nbsp;</td>
<%} %>
<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%></td>
</tr> <% }
%>
</table></div></td></tr> 
<tr>
<td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<td width="10%" align="center"><b>Remarks</b></td>
<td width="10%" align="center"><b>Comments on Repayment</b></td>
</tr>
<%
for(int i=1;i<arrCGOurRow.size();i++){
	arrCol	= (ArrayList)arrCGOurRow.get(i); %>
<tr>
<td align="left"><%=i+1%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(1)).toUpperCase()%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(14))%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(15))%></td>
</tr>
<%} %>
</table>
</td>
</tr>
<%}else{ %>
<tr>
<td class="title">Details of existing Credit facilities with our Bank : &nbsp;</b>Nil</td></td>
</tr>
<%}} %>

<%} %>

<%
if(!proposalFormat.equalsIgnoreCase("RPN")){
strFlag=Helper.correctNull((String)hshsecVal.get("strFlag"));
if(!strAppSecFlag.equalsIgnoreCase("M")){
if(!(strFlag.equalsIgnoreCase("E"))){%>
<tr>
<td>Security coverage for Bank's exposure to the Group:<div align="right"><%=strAmtValueIn%></div></td>
</tr>
<tr>
	<td>
		<div align="left" id="top">
			<jsp:include page="../print/Securitiesprint.jsp" flush="true">
			<jsp:param name="pageVal" value="Security"/>
			</jsp:include>
		</div>
	</td>
</tr>
<%}else{%>
<tr>
<td>Security coverage for Bank's exposure to the Group:<%=strNil%></td>
</tr>
<%}}else if(strAppSecFlag.equalsIgnoreCase("M") && strAppSecManualFlag.equalsIgnoreCase("C")){ %>
<tr>
<td>Security coverage for Bank's exposure to the Group:</div></td>
</tr>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS"))%></td>
</tr>
<%}%>
<tr><td><br></td></tr>
<%if(strFormat.equalsIgnoreCase("Y")) {%>
<tr><td class="title">Inter Locking of Funds</td></tr>
<%if(!Helper.correctNull((String)hshValues.get("strInterLockingFunds")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("strInterLockingFunds")) %></td></tr>
<%}else{ %>
<tr><td>- Nil -</td></tr>
<%}}} %>
<tr>
	<td><br>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		</table>
		<br>
		<div id="top">
		</div>
	</td>
</tr>
</table>

</body>
</html>