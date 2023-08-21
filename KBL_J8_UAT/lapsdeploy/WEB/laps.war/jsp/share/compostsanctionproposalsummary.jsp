<%@include file="../share/directives.jsp"%>
<%
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);

HashMap hsh=new HashMap();
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
ArrayList arrSecPrime=new ArrayList();
ArrayList arrSecColl=new ArrayList();
int intFacCount=Integer.parseInt(Helper.correctInt((String)hshValues.get("strFacCount")));
String strModifiedTerms="",strTemp="",secValue="";

String strBATypeWC		= Helper.correctNull((String)hshValues.get("com_wc_bnkarg"));
String strConsTypeWC	= Helper.correctNull((String)hshValues.get("com_wc_type"));
String strBATypeTL		= Helper.correctNull((String)hshValues.get("com_tl_bnkarg"));
String strConsTypeTL	= Helper.correctNull((String)hshValues.get("com_tl_type"));

String strBATypeWCold		= Helper.correctNull((String)hshValues.get("com_wc_bnkarg_old"));
String strConsTypeWCold	= Helper.correctNull((String)hshValues.get("com_wc_type_old"));
String strBATypeTLold		= Helper.correctNull((String)hshValues.get("com_tl_bnkarg_old"));
String strConsTypeTLold	= Helper.correctNull((String)hshValues.get("com_tl_type_old"));

String strTLValIn="",strPreWC="",strExiWC="";
String strNil= "Nil",strValuesIn="";
String strAmountValue=Helper.correctNull((String)hshValues.get("strAmountValue"));
String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
String strFinValuesIn=Helper.correctNull((String)hshValues.get("strFinvalues"));
String strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));
if(strValIn.equalsIgnoreCase("Rs"))
{
	strValuesIn	= "(Amount in  "+strValIn+".)";
	strTLValIn="";
}
else
{
	strValuesIn	= "(Rs. in  "+strValIn+")";
	strTLValIn=strValIn;
}

if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
}
if(strFinValuesIn.equalsIgnoreCase("C")){
	strFinValuesIn="( Rs. in Crore )";
}else if(strFinValuesIn.equalsIgnoreCase("L")){
	strFinValuesIn="( Rs. in Lacs )";
}else{
	strFinValuesIn="( Amount in Rs. )";
}
java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();

jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
//out.println(hshValues);
%>
<html>
<head>
<title>Post Sanction Modification Summary</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
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
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
	<td>
	<table width="90%" border="0" cellpadding="3" cellspacing="0"  align="center">
	<tr>
	<td>
	<table width="100%" border="0" align="center" cellpadding="3"
						cellspacing="0">
	              <tr> 
	                <td align="center" colspan="4"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	              </tr>
	              <tr align="center" > 
	                <td colspan="4"> 
	                 <b> Branch&nbsp;/&nbsp;Office:&nbsp;<%=Helper.correctNull((String) session.getAttribute("strOrgName"))%></b> 
	                </td>
	              </tr>
	            </table>
	</td>
	</tr>
<!--	<tr>-->
<!--	<td align="center">Post Sanction Modification Summary-->
<!--	</td>-->
<!--	</tr>-->
   
   <%
   for(int i=1;i<=intFacCount;i++)
   {
   	hsh=(HashMap)hshValues.get("hshResult"+i);
   	boolean bflag=true;
   	if(hsh!=null)
   	{
   		strModifiedTerms=Helper.correctNull((String)hsh.get("strModifiedTerms"));
   	%>
   	<tr>
   	<td><b>
   	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
   	Facility : <%=Helper.correctNull((String)hsh.get("strProductSno")) %> - <%}else{ %>Product : <%} %><%=Helper.correctNull((String)hsh.get("strProductDesc")) %></b>
   	</td>
   	</tr>
   	<tr>
   	<td>
   	<div id="top">
   	<table width="100%" border="0" align="center" cellpadding="3"
						cellspacing="0">
						<tr class="tblhead" align="center">
   	<td width="50%">Modified Terms</td>
   	<td>Old Value</td>
   	<td>New Value</td>
   	</tr>
   	<%if(strModifiedTerms.contains("DLA") || strModifiedTerms.contains("INLIM")|| strModifiedTerms.contains("SLILA")){
   		bflag=false;%>
   	<tr>
   	<td rowspan="3" style="padding-bottom: 0px;padding-left: 0px;padding-right: 0px;padding-top: 0px;border-bottom: 0px;border-left: 0px;border-right: 0px;border-top: 0px;">
   	<table width="100%" border="0" align="center" cellpadding="3" cellspacing="0">
		<tr>
		<td rowspan="3"> 
		<%if(strModifiedTerms.contains("DLA")){ %>
		Decreasing Loan Amount 
		<%}else if(strModifiedTerms.contains("INLIM")){ %>
		Increase in Limit of the sub limit 
		<%}else{%>
		Increase in the Staff housing loan Limit
		<%} %>
		</td>
   	<td>Proposed Amount</td>
   	</tr>
   	<tr>
   	<td>Sanction Amount</td>
   	</tr>
   		
   	</table>
   	</td>
   	<td align="right"> Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hsh.get("strOldAmount")))) %></td>
   	<td align="right"> Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hsh.get("strAmount")))) %></td>
   	</tr>
   	<tr>
   	<td align="right"> Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hsh.get("strOldSancAmount")))) %></td>
   	<td align="right"> Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hsh.get("strSancAmount")))) %></td>
   	</tr>
   		
   	<%} %>
   	<%if(strModifiedTerms.contains("DLP")){
	bflag=false;%>
   	<tr>
   	<td>Decreasing Loan Period (Months)</td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strOldReqTerms")) %> Months</td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strReqTerms")) %> Months</td>
   	</tr>
   	<%} %>
   	<%if(strModifiedTerms.contains("MODGSS")){
	bflag=false;%>
	<tr class="tblhead"><td colspan="3">Modification in Government Sponsor Scheme</td>
	</tr>
   	<tr>
   	<td>Government Sponsor Scheme</td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strOldGovtScheme")) %> </td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strGovtScheme")) %> </td>
   	</tr>
   	<tr>
   	<td>Scheme Type</td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldSchemeType")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strSchemeType")) %> </td>
   	</tr>
   	<tr>
   	<td>Subsidy Amount</td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strOldSudsidyAmt")) %> </td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strSudsidyAmt")) %> </td>
   	</tr>
   	<tr>
   	<td>Sponsor Agency</td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldSponserAgency")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strSponserAgency")) %> </td>
   	</tr>
   	<tr>
   	<td>Subsidy type</td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldSubsidyType")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strSubsidyType")) %> </td>
   	</tr>
   	<%if(Helper.correctNull((String)hsh.get("strOldSponserAgency")).equalsIgnoreCase("OTHERS") && !Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
   	<tr>
   	<td>Name of the Agency</td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldAgency")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strAgency")) %> </td>
   	</tr>
   	<%}%>
   	<%if((Helper.correctNull((String)hsh.get("strOldGovtSchemeVal")).equalsIgnoreCase("078")||Helper.correctNull((String)hsh.get("strOldGovtSchemeVal")).equalsIgnoreCase("079"))
   			||(Helper.correctNull((String)hsh.get("strGovtSchemeVal")).equalsIgnoreCase("078")||Helper.correctNull((String)hsh.get("strGovtSchemeVal")).equalsIgnoreCase("079"))){ %>
   	<tr>
   	<td colspan="3" class="tblhead">PMAY Details</td>
   	</tr>
   	<tr>
   	<td>Household Category </td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldPMAY_HOUSECATDESC")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strPMAY_HOUSECATDESC")) %> </td>
   	</tr>
   	<tr>
   	<td>Type of Loan </td>
   		<%strTemp=Helper.correctNull((String)hsh.get("strOldPMAY_LOAN_TYPE"));
   	if(strTemp.equalsIgnoreCase("N"))
   		strTemp="New Acquisition";
   	else if(strTemp.equalsIgnoreCase("E"))
   		strTemp="Extension";
   	else if(strTemp.equalsIgnoreCase("C"))
   		strTemp="New Construction";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strPMAY_LOAN_TYPE"));
   	if(strTemp.equalsIgnoreCase("N"))
   		strTemp="New Acquisition";
   	else if(strTemp.equalsIgnoreCase("E"))
   		strTemp="Extension";
   	else if(strTemp.equalsIgnoreCase("C"))
   		strTemp="New Construction";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	</tr>
   	<tr>
   	<td>Ownership mode </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strOldPMAY_OWN_MODE"));
   	if(strTemp.equalsIgnoreCase("O"))
   		strTemp="Self Owned";
   	else if(strTemp.equalsIgnoreCase("I"))
   		strTemp="Inherited";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strPMAY_OWN_MODE"));
   	if(strTemp.equalsIgnoreCase("O"))
   		strTemp="Self Owned";
   	else if(strTemp.equalsIgnoreCase("I"))
   		strTemp="Inherited";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	</tr>
   	<tr>
   	<td>Whether Borrower owned a Pucca house either in his/her name or in name of family member in any part of India</td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strOldPMAY_BORR_PUCCA"));
   	if(strTemp.equalsIgnoreCase("Y"))
   		strTemp="Yes";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="No";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strPMAY_BORR_PUCCA"));
   	if(strTemp.equalsIgnoreCase("Y"))
   		strTemp="Yes";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="No";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	</tr>
   	<tr>
   	<td>Preference Category</td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strOldPMAY_PREFER_CAT"));
   	if(strTemp.equalsIgnoreCase("01"))
   		strTemp="Disability";
   	else if(strTemp.equalsIgnoreCase("02"))
   		strTemp="Manual Scavenger";
   	else if(strTemp.equalsIgnoreCase("03"))
   		strTemp="Widow";
   	else if(strTemp.equalsIgnoreCase("04"))
   		strTemp="Others";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp %> &nbsp;</td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strPMAY_PREFER_CAT"));
   	if(strTemp.equalsIgnoreCase("01"))
   		strTemp="Disability";
   	else if(strTemp.equalsIgnoreCase("02"))
   		strTemp="Manual Scavenger";
   	else if(strTemp.equalsIgnoreCase("03"))
   		strTemp="Widow";
   	else if(strTemp.equalsIgnoreCase("04"))
   		strTemp="Others";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	</tr>
   	<%if(Helper.correctNull((String)hsh.get("strOldPMAY_PREFER_CAT")).equalsIgnoreCase("04")){ %>
   	<tr>
   	<td>Other Category</td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldPMAY_OTHER_CATEGORY")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strPMAY_OTHER_CATEGORY")) %> </td>
   	</tr>
   	<%} %>
   	<tr>
   	<td>Whether customer has already availed subsidy from Ex- Institute</td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strOldPMAY_SUBSID_INST"));
   	if(strTemp.equalsIgnoreCase("Y"))
   		strTemp="Yes";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="No";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strPMAY_SUBSID_INST"));
   	if(strTemp.equalsIgnoreCase("Y"))
   		strTemp="Yes";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="No";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	</tr>
   	<tr>
   	<td>Source of Application </td>
   <%strTemp=Helper.correctNull((String)hsh.get("strOldPMAY_SOURCE_APP"));
   	if(strTemp.equalsIgnoreCase("DU"))
   		strTemp="Direct/ULB";
   	else if(strTemp.equalsIgnoreCase("G"))
   		strTemp="Govt. designated agency";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="NGO";
   	else if(strTemp.equalsIgnoreCase("D"))
   		strTemp="Developers";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strPMAY_SOURCE_APP"));
   	if(strTemp.equalsIgnoreCase("DU"))
   		strTemp="Direct/ULB";
   	else if(strTemp.equalsIgnoreCase("G"))
   		strTemp="Govt. designated agency";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="NGO";
   	else if(strTemp.equalsIgnoreCase("D"))
   		strTemp="Developers";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	</tr>
   	<tr>
   	<td>Certificate of house ownership from revenue authority of Beneficiary's native district obtained </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strOldPMAY_CERTIF_HOUSEOWN"));
   	if(strTemp.equalsIgnoreCase("Y"))
   		strTemp="Yes";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="No";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="No";
   	else if(strTemp.equalsIgnoreCase("NT"))
   		strTemp="Not Applicable";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strPMAY_CERTIF_HOUSEOWN"));
   	if(strTemp.equalsIgnoreCase("Y"))
   		strTemp="Yes";
   	else if(strTemp.equalsIgnoreCase("N"))
   		strTemp="No";
   	else if(strTemp.equalsIgnoreCase("NT"))
   		strTemp="Not Applicable";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp%> </td>
   	</tr>
   	
   	<%}} %>
   	<%if(strModifiedTerms.contains("MODBA")){
	bflag=false;%>
	<tr class="tblhead"><td colspan="3">Modification in Banking Arrangement</td>
	</tr>
	<tr>
   	<td>Banking Arrangement</td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldBankArrangement")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strBankArrangement")) %> </td>
   	</tr>
   	<%if(Helper.correctNull((String)hsh.get("strOldBankArrangement")).equalsIgnoreCase("Consortium")||Helper.correctNull((String)hsh.get("strBankArrangement")).equalsIgnoreCase("Consortium")){ %>
   	<tr>
   	<td>Name of the Leader Bank</td>
   	<td><%=Helper.correctNull((String)hsh.get("strOldConsortiumName")) %> </td>
   	<td><%=Helper.correctNull((String)hsh.get("strConsortiumName")) %> </td>
   	</tr>
   	<%}%>
	 	<tr  class="tblhead">
   	<td colspan="3" align="center">Existing Proposal</td>
   	</tr>
   	 	<tr>
   	<td colspan="3">
   	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
   	<tr class="tblhead" align="center">
			<tr  class="tblhead">
			<%if((!strBATypeWCold.equalsIgnoreCase("")||!strConsTypeWCold.equalsIgnoreCase(""))&&!strBATypeWCold.equalsIgnoreCase("S")){%>
			<%if(strBATypeWCold.equalsIgnoreCase("C")){ %>
			<td colspan="10">Consortium Details for WC
			</td>
			<%}} %>
			
			<%if((!strBATypeWCold.equalsIgnoreCase("")||!strConsTypeWCold.equalsIgnoreCase(""))&&!strBATypeWCold.equalsIgnoreCase("S")){%>
			<%if(strBATypeWCold.equalsIgnoreCase("M")){ %>
			<td colspan="10">Multiple Banking Details for WC</td>
			<%}} %>
			<%arrRow=new ArrayList();
		   	arrRow=(ArrayList)hshValues.get("arroldOutbankRow");
		   	if(arrRow!=null && arrRow.size()>0)
		   	{ %>
			<tr>
	   	<td >Name of the Bank</td>
	   	<td>Nature of facility </td>
	   	<td >Main limit/ sub limit</td>
	   	<td>Limit </td>
	   	<td>Out Standing</td>
	   	<td>Interest Rate</td>
	   	<td>Asset Classification</td>
	   	<td>Branch Name</td>
	   	<td>Email Id </td>
	   	<td>Remarks</td>
   	</tr>
   		<%
   	
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   	<td><%=Helper.correctNull((String)arrCol.get(9)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(10)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(3)) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(7)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(12)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(15)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(14)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(8)) %></td>
   	</tr>
   	
  <% } }%>
  </table>
   	</td>
   	</tr>
   	<tr>
   	<td colspan="3">
   	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
   	<tr class="tblhead" align="center">
   	
   		<tr class="tblhead">
   	<%if((!strBATypeTLold.equalsIgnoreCase("")||!strConsTypeTLold.equalsIgnoreCase(""))&&!strBATypeTLold.equalsIgnoreCase("S")){ %>
		  	<%if(strBATypeTLold.equalsIgnoreCase("C")){ %>
			<td colspan="11">Consortium Details for TL</td>
			<%}} %>
			<%if((!strBATypeTLold.equalsIgnoreCase("")||!strConsTypeTLold.equalsIgnoreCase(""))&&!strBATypeTLold.equalsIgnoreCase("S")){ %>
		  	<%if(strBATypeTLold.equalsIgnoreCase("M")){ %>
			<td colspan="11">Multiple Details for TL</td>
			<%}} %>
			</tr>
			 	<%arrRow=new ArrayList();
   	arrRow=(ArrayList)hshValues.get("arroldOutbankRowtl");
   	if(arrRow!=null && arrRow.size()>0)
   	{%>
			<tr>
	   	<td >Name of the Bank</td>
	   	<td>Nature of facility </td>
	   	<td >Main limit/ sub limit</td>
	   	<td>Limit </td>
	   	<td>Out Standing</td>
	   	<td>Outstanding as on</td>
	   	<td>Unreleased Portion</td>
	   	<td>interest rate
	   	<td>Branch Name</td>
	   	<td>Email Id </td>
	   	<td>Remarks</td>
   	</tr>
   		<%
  
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   	<td><%=Helper.correctNull((String)arrCol.get(9)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(10)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(3)) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(11)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(12)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(7)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(15)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(14)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(8)) %></td>
   	</tr>
   	
  <% } }%>
   
    	</table>
   	</td>
   	</tr>
	 	<tr  class="tblhead">
   	<td colspan="3" align="center">Proposed Proposal</td>
   	</tr>
   		<tr>
   	<td colspan="3">
   	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
   	<tr class="tblhead" align="center">
			<tr  class="tblhead">
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){%>
			<%if(strBATypeWC.equalsIgnoreCase("C")){ %>
			<td colspan="10">Consortium Details for WC
			</td>
			<%}} %>
			
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){%>
			<%if(strBATypeWC.equalsIgnoreCase("M")){ %>
			<td colspan="10">Multiple Banking Details for WC</td>
			<%}} %>
			 	<% arrRow=new ArrayList();
   	arrRow=(ArrayList)hshValues.get("arrOutbankRow");
   	if(arrRow!=null && arrRow.size()>0)
   	{%>
			<tr>
	   	<td >Name of the Bank</td>
	   	<td>Nature of facility </td>
	   	<td >Main limit/ sub limit</td>
	   	<td>Limit </td>
	   	<td>Out Standing</td>
	   	<td>Interest Rate</td>
	   	<td>Asset Classification</td>
	   	<td>Branch Name</td>
	   	<td>Email Id </td>
	   	<td>Remarks</td>
   	</tr>
   		<%
  
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   	<td><%=Helper.correctNull((String)arrCol.get(9)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(10)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(3)) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(7)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(12)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(15)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(14)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(8)) %></td>
   	</tr>
   	
  <% } }%>
  </table>
   	</td>
   	</tr>
   	<tr>
   	<td colspan="3">
   	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
   	<tr class="tblhead" align="center">
   	
   		<tr class="tblhead">
   	<%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>
		  	<%if(strBATypeTL.equalsIgnoreCase("C")){ %>
			<td colspan="11">Consortium Details for TL</td>
			<%}} %>
			<%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>
		  	<%if(strBATypeTL.equalsIgnoreCase("M")){ %>
			<td colspan="11">Multiple Details for TL</td>
			<%}} %>
			</tr>
			<%arrRow=new ArrayList();
		   	arrRow=(ArrayList)hshValues.get("arrOutbankRowtl");
		   	if(arrRow!=null && arrRow.size()>0)
		   	{ %>
			<tr>
	   	<td >Name of the Bank</td>
	   	<td>Nature of facility </td>
	   	<td >Main limit/ sub limit</td>
	   	<td>Limit </td>
	   	<td>Out Standing</td>
	   	<td>Outstanding as on</td>
	   	<td>Unreleased Portion</td>
	   	<td>interest rate
	   	<td>Branch Name</td>
	   	<td>Email Id </td>
	   	<td>Remarks</td>
   	</tr>
   		<%
   
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   	<td><%=Helper.correctNull((String)arrCol.get(9)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(10)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(3)) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue) %></td>
   	<td ><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(11)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(12)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(7)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(15)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(14)) %></td>
   	<td ><%=Helper.correctNull((String)arrCol.get(8)) %></td>
   	</tr>
   	
  <% } }%>
   
    	</table>
   	</td>
   	</tr>
   	<%} %>
    	
   	
   <%--	<%if(strModifiedTerms.contains("MRI")){ %>
   	<tr>
   	<td>Modification Of Rate of Interest</td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strOldInterest")) %> %</td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strInterest")) %> %</td>
   	</tr>
   	<%} %> --%>
   	<%if(strModifiedTerms.contains("MRI") || strModifiedTerms.contains("BRTOMCLR")){
   	bflag=false;%>
   	
   	<%if(!((Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("F")||
   			Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase(""))&&
   			(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("F") || 
   					Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase(""))))
   			{ %>
   	<tr>
  <%if(strModifiedTerms.contains("MRI")){ %>
   		<td colspan="3" align="center"><b>Modification Of Rate of Interest </b></td>
   	<% } else if(strModifiedTerms.contains("BRTOMCLR")){ %>
   	   		<td colspan="3" align="center"><b> Migration from Base Rate/PLR to Other Reference Rate</b></td>
   	<% } %>
   	</tr>
   	<tr  class="tblhead">
   	<td colspan="3" align="center">Existing Proposal</td>
   	</tr>
   	<tr>
   	<td colspan="3">
   	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
   	<tr class="tblhead" align="center">
	   	<td colspan="2">Type </td>
	   	<td width="10%">Value</td>
   	</tr>
	<%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("F")||Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("")){ %>
	<tr>
   	<td colspan="2">Reference Rate</td>
   	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("strOldBaseInterest")) %></td>
   	</tr>
	<%}else{ %>
	<%if(!Helper.correctNull((String)hsh.get("stroldfbillfreq")).equalsIgnoreCase("")){ %>
	<tr>
	<td colspan="2">FBIL T-BILL Referred Date
	</td>
	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("stroldfbilldate")) %></td>
	</tr>
	<tr>
	<td colspan="2">Interest Reset Frequence
	</td>
	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("stroldfbillfreq")) %></td>
	</tr>
	<%} %>
   	<tr>
   	<td colspan="2"><%=Helper.correctNull((String)hsh.get("strOldMCLRtype")) %> </td>
   	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("strOldMCLRValue")) %></td>
   	</tr>
   	<%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("M")){ %>
   	<tr>
   	<td colspan="3"  class="tblhead">CREDIT RISK PREMIUM</td>
   	</tr>
   	<%} %>
   	<%
   	arrRow=new ArrayList();
   	arrRow=(ArrayList)hsh.get("arrRowOLDCRP");
   	if(arrRow!=null && arrRow.size()>0)
   	{
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
   	<td align="right"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
   	</tr>
   	<%} %>
   	 <%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("M")){ %>
		<tr>
	   	<td colspan="2" class="title"  align="right">Sub Total</td>
	   	<td align="right"><%=Helper.correctNull((String)hsh.get("strOldCRPValue")) %></td>
	   	</tr>
	   	<%} %>
	 <% }else{%>
	 
	 <%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("S")){ %>
	  	<tr>
   	<td colspan="2"> CREDIT RISK PREMIUM</td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strOldCRPValue")) %></td>
   	</tr>
	 <%}else{ %>
   	<tr>
   	<td colspan="3" align="center"> - Nil -</td>
   	</tr>
   	<%} %>
   	<%} %>
   	 <%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("M")){ %>
   		<tr class="tblhead">
   		<%if(Helper.correctNull((String)hsh.get("strOldMCLRCode")).equalsIgnoreCase("O")){ %>
   			<td colspan="3" class="title">BUSINESS STRATEGIC PREMIUM</td>
   			<%}else{ %>
   			<td colspan="3" class="title">FIXED SPREAD</td>
   			<%} %>
   	</tr>
   	<%} %>
   		<%
   	arrRow=new ArrayList();
   	arrRow=(ArrayList)hsh.get("arrRowOLDBSP");
   	if(arrRow!=null && arrRow.size()>0)
   	{
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   		<td width="35%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
   	<td align="right"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
   	</tr>
   	<%} %>
   	 <%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("M")){ %>
   		<tr>
   	<td colspan="2" class="title" align="right">Sub Total</td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strOldBSPValue")) %></td>
   	</tr>
   	<%}}else{%>
   	
   	 <%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("S")){ %>
   	 <tr>
   	 	<%if(Helper.correctNull((String)hsh.get("strOldMCLRCode")).equalsIgnoreCase("O")){ %>
   			<td colspan="2" class="title">BUSINESS STRATEGIC PREMIUM</td>
   			<%}else{ %>
   			<td colspan="2" class="title">FIXED SPREAD</td>
   			<%} %>
   	<!-- <td colspan="2"> BUSINESS STRATEGIC PREMIUM</td> -->
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strOldBSPValue")) %></td>
   	</tr>
   	 <%}else{ %>
   	<tr>
   	<td colspan="3" align="center"> - Nil -</td>
   	</tr>
   	<%}} %>
   	<%} %>
   	<%if(Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("F")||Helper.correctNull((String)hsh.get("strOldIntDef")).equalsIgnoreCase("")){ %>
   	<tr>
   	<td colspan="2">Spread</td>
   	<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hsh.get("strOldInterest")))-Double.parseDouble(Helper.correctDouble((String)hsh.get("strOldBaseInterest")))) %></td>
   	</tr>
   	<%} %>
   	<tr>
   	<td colspan="2" class="title"  align="right">  Final Interest Rate (%)</td>
   	<td align="right"><%=Helper.correctDouble((String)hsh.get("strOldInterest")) %></td>
   	</tr>
 	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>  	
   		<tr>
   		<td> Interest Sub Type </td>
   		<td align="left"><%=Helper.correctNull((String)hsh.get("stroldFACILITY_INTSUBTYPE")) %></td>
   		<td> </td>
   		</tr>
 	 <% } %> 
 	 <tr>
   		<td> Processing Charge </td>
   		<td align="left" colspan="2"> Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stroldprocessingfee")))) %></td>
   		</tr>
   	</table>
   	</td>
   	</tr>
   	<tr  class="tblhead" >
   	<td colspan="3" align="center">Proposed Proposal</td>
   	</tr>
   	<tr>
   	<td colspan="3">
   	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
   	<tr class="tblhead" align="center">
	   	<td colspan="2">Type </td>
	   	<td width="10%">Value</td>
   	</tr>
	<%if(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("F")||Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("")){ %>
	<tr>
   	<td colspan="2">Reference Rate</td>
   	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("strBaseInterest")) %></td>
   	</tr>
	<%}else{ %>
	<%if(!Helper.correctNull((String)hsh.get("strfbillfreq")).equalsIgnoreCase("")){ %>
	<tr>
	<td colspan="2">FBIL T-BILL Referred Date
	</td>
	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("strfbilldate")) %></td>
	</tr>
	<tr>
	<td colspan="2">Interest Reset Frequence
	</td>
	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("strfbillfreq")) %></td>
	</tr>
	<%} %>
   	<tr>
   	<td colspan="2"><%=Helper.correctNull((String)hsh.get("strMCLRtype")) %> </td>
   	<td style="text-align: right;"><%=Helper.correctNull((String)hsh.get("strMCLRValue")) %></td>
   	</tr>
   	<%if(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("M")){ %>
   	<tr>
   	<td colspan="3"  class="tblhead">CREDIT RISK PREMIUM</td>
   	</tr>
   	<%} %>
   	<%
   	arrRow=new ArrayList();
   	arrRow=(ArrayList)hsh.get("arrRowCRP");
   	if(arrRow!=null && arrRow.size()>0)
   	{
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
   	<td align="right"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
   	</tr>
   	<%} %>
   	 <%if(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("M")){ %>
		<tr>
	   	<td colspan="2" class="title"  align="right">Sub Total</td>
	   	<td align="right"><%=Helper.correctNull((String)hsh.get("strCRPValue")) %></td>
	   	</tr>
	   	<%} %>
	 <% }else{%>
	 
	 <%if(!Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("M")){ %>
	  	<tr>
   	<td colspan="2"> CREDIT RISK PREMIUM</td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strCRPValue")) %></td>
   	</tr>
	 <%}else{ %>
   	<tr>
   	<td colspan="3" align="center"> - Nil -</td>
   	</tr>
   	<%} %>
   	<%} %>
   	 <%if(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("M")){ %>
   		<tr class="tblhead">
   		<%if(Helper.correctNull((String)hsh.get("strMCLRCode")).equalsIgnoreCase("O")){ %>
   			<td colspan="3" class="title">BUSINESS STRATEGIC PREMIUM</td>
   			<%}else{ %>
   			<td colspan="3" class="title">FIXED SPREAD</td>
   			<%} %>
   <!-- <td colspan="3" class="title">BUSINESS STRATEGIC PREMIUM</td>  -->	
   	</tr>
   	<%} %>
   		<%
   	arrRow=new ArrayList();
   	arrRow=(ArrayList)hsh.get("arrRowBSP");
   	if(arrRow!=null && arrRow.size()>0)
   	{
   		for(int k=0;k<arrRow.size();k++)
   		{
   			arrCol=(ArrayList)arrRow.get(k);
   	%>
   	<tr>
   		<td width="35%"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
   	<td width="35%"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
   	<td align="right"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
   	</tr>
   	<%} %>
   	 <%if(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("M")){ %>
   		<tr>
   	<td colspan="2" class="title" align="right">Sub Total</td>
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strBSPValue")) %></td>
   	</tr>
   	<%}}else{%>
   	
   	 <%if(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("S")){ %>
   	 <tr>
   	 <%if(Helper.correctNull((String)hsh.get("strMCLRCode")).equalsIgnoreCase("O")){ %>
   			<td colspan="2" class="title">BUSINESS STRATEGIC PREMIUM</td>
   			<%}else{ %>
   			<td colspan="2" class="title">FIXED SPREAD</td>
   			<%} %>
   	<!-- <td colspan="2"> BUSINESS STRATEGIC PREMIUM</td> -->
   	<td align="right"><%=Helper.correctNull((String)hsh.get("strBSPValue")) %></td>
   	</tr>
   	 <%}else{ %>
  	<tr>
   	<td colspan="3" align="center"> - Nil -</td>
   	</tr>
   	<%}} %>
   	<%} %>
   	<%if(Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("F")||Helper.correctNull((String)hsh.get("strIntDef")).equalsIgnoreCase("")){ %>
   	<tr>
   	<td colspan="2">Spread</td>
   	<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hsh.get("strInterest")))-Double.parseDouble(Helper.correctDouble((String)hsh.get("strBaseInterest")))) %></td>
   	</tr>
   	<%} %>
   	<tr>
   	<td colspan="2" class="title"  align="right">  Final Interest Rate (%)</td>
   	<td align="right"><%=Helper.correctDouble((String)hsh.get("strInterest")) %></td>
   	</tr>
   	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>		
   		<tr>
   		<td> Interest Sub Type </td>
   		<td align="left"><%=Helper.correctNull((String)hsh.get("strnewFACILITY_INTSUBTYPE")) %></td>
   		<td> </td>
   		</tr>
    <% } %>
    <tr>
   		<td> Processing Charge </td>
   		<td align="left" colspan="2"> Rs.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strnewprocessingfee")))) %></td>
   		</tr>
    
     <%if(strModifiedTerms.contains("BRTOMCLR")){ %>
 	 	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
 		<tr>
   		<td>Effective date of Migration</td>
   		<td align="left" colspan="2"><%=Helper.correctNull((String)hsh.get("fac_mclr_migration_date")) %></td>
   		</tr>
 	 	<%}else{ %>
 	 	<tr>
   		<td> Effective date of Migration </td>
   		<td align="left" colspan="2"><%=Helper.correctNull((String)hsh.get("LOAN_MCLR_MIGRATION_DATE")) %></td>
   		</tr>
 	 <%}} %>
   	</table>
   	</td>
   	</tr>
   	<%}else{ %>
   	
   	<tr><td colspan="3">
	<table width="100%" cellpadding="3" cellspacing="0" border="0">	
	<tr align="center">
	 <%if(strModifiedTerms.contains("MRI")){ %>
	 	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
   		<td colspan="8" align="center"><b>Modification Of Rate of Interest </b></td>
   		<%}else{ %>
   		<td colspan="6" align="center"><b>Modification Of Rate of Interest </b></td>
   		<%} %>
     <% } else if(strModifiedTerms.contains("BRTOMCLR")){ %>
     	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
   	   		<td colspan="8" align="center"><b> Migration from Base Rate/PLR to Other Reference Rate</b></td>
   	   		<%}else{ %>
   	   		<td colspan="6" align="center"><b> Migration from Base Rate/PLR to Other Reference Rate</b></td>
   	   		<%} %>
   	   		
  	 <% } %>
  	 </tr>
   	<tr  class="tblhead">
	<td colspan="4" class="tblhead" align="center">Existing Proposal</td>
	<td colspan="4" class="tblhead" align="center">Present Proposal</td>
	</tr>
	<tr class="tblhead" align="center">
	<td>Reference Rate</td>
	<td>Spread</td>
	<td>Interest Rate (%)</td>
	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
	<td>Interest Sub Type</td>
	<%} %>
	<td>Reference Rate</td>
	<td>Spread</td>
	<td>Interest Rate (%)</td>
	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
	<td>Interest Sub Type</td>
	<%} %>
	</tr>
	<tr>
	<td align="right"><%=Helper.correctNull((String)hsh.get("strOldBaseInterest")) %> </td>
	<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hsh.get("strOldInterest")))-Double.parseDouble(Helper.correctDouble((String)hsh.get("strOldBaseInterest"))))%> </td>
	<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hsh.get("strOldInterest")))) %> </td>
	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
	<td align="right"><%=Helper.correctNull((String)hsh.get("stroldFACILITY_INTSUBTYPE")) %> </td>
	<%} %>
	<td align="right"><%=Helper.correctNull((String)hsh.get("strBaseInterest")) %> </td>
	<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hsh.get("strInterest")))-Double.parseDouble(Helper.correctDouble((String)hsh.get("strBaseInterest"))))%> </td>
	<td align="right"><%=Helper.correctNull((String)hsh.get("strInterest")) %> </td>
	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
	<td align="right"><%=Helper.correctNull((String)hsh.get("strnewFACILITY_INTSUBTYPE")) %> </td>
	<%} %>
	</tr>
	 <%if(strModifiedTerms.contains("BRTOMCLR")){ %>
 	 	<%if(!Helper.correctNull((String)session.getAttribute("sessionModuleType")).equalsIgnoreCase("RET")){ %>
 		<tr>
   		<td colspan="4">Effective date of Migration</td>
   		<td align="left" colspan="4"><%=Helper.correctNull((String)hsh.get("fac_mclr_migration_date")) %></td>
   		</tr>
 	 	<%}else{ %>
 	 	<tr>
   		<td colspan="4"> Effective date of Migration </td>
   		<td align="left" colspan="4"><%=Helper.correctNull((String)hsh.get("LOAN_MCLR_MIGRATION_DATE")) %></td>
   		</tr>
 	 <%}} %>
	
	</table>
	</td>
	</tr>
   	
   	<%}} %>
   		<%if(strModifiedTerms.contains("CHBRANCH")){
   		bflag=false;%>
   	<tr>
   		<td>Change of facility availing branch</td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strFacAvailBranchOld")) %>  (<%=Helper.correctNull((String)hsh.get("strFacAvailBranchCodeOld")) %>) </td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strFacAvailBranchNew")) %>  (<%=Helper.correctNull((String)hsh.get("strFacAvailBranchCodeNew")) %>)</td>
   	</tr>
   	<%}
 	if(strModifiedTerms.contains("CHDPOWER")){
 	bflag=false;%>
 	<tr class="tblhead" align="center">
 	<td colspan="3">Modification in Drawing Power Indicator</td>
 	</tr>
 	<tr>
 	   	<td>Drawing Power Indicator</td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strDrawingPowerIndicatorOld")) %> </td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strDrawingPowerIndicatorNew")) %> </td>
 	</tr>
 	<tr>
 	   	<td>Drawing Power Amount</td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strDrawingPowerAmountOld")) %> </td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strDrawingPowerAmountNew")) %> </td>
 	</tr>
 	<%}
 	if(strModifiedTerms.contains("CHSCHEMECODE")){
 	bflag=false;%>
 	<tr class="tblhead" align="center">
 	<td colspan="3">Modifications in GL Sub head code and scheme code in CBS details</td>
 	</tr>
 	<tr>
 	   	<td>Scheme Code</td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strSchemeCodeOld")) %> </td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strSchemeCodeNew")) %> </td>
 	</tr>
 	<tr>
 	   	<td>GL Sub Head Code</td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strGLSubHeadCodeOld")) %> </td>
 	   	<td align="center"><%=Helper.correctNull((String)hsh.get("strGLSubHeadCodeNew")) %> </td>
 	</tr>
 	<%}%>
   	<%if(strModifiedTerms.contains("@DCCO")){ 
   	bflag=false;%>
   	<tr>
   		<td><b>Capturing Actual Date of Commencement of commercial operation</b></td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strDACCOOld")) %></td>
   	<td align="center"><%=Helper.correctNull((String)hsh.get("strDACCONew")) %></td>
   	</tr>
	<%}%>
	
   	<%if(strModifiedTerms.contains("DATEEX")){
   	bflag=false;
   	arrRow=(ArrayList)hsh.get("arrDATEEX");
		if(arrRow!=null && arrRow.size()>0){%>
	<tr><td colspan="3">
	<table width="100%" cellpadding="3" cellspacing="0" border="0">					
	<%for(int j=0;j<arrRow.size();j++){ 
	arrCol=(ArrayList)arrRow.get(j);
	if(j==0){%>
	<tr>
	<td rowspan="<%=arrRow.size()+1 %>" width="50%" align="center">Due Date Extension (Only for Working Capital Limits)</td>
	<td align="center" width="25%" class="tblhead">Proposal No</td>
	<td align="center" width="25%" class="tblhead">Due Date</td>
	</tr>
	<%} %>
	<tr>
	<td><%=Helper.correctNull((String)arrCol.get(0)) %></td>
	<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	</tr>
	<%} %>
	</table>
	</td>
		</tr>
	<%}else{%>
   	<tr>
   		<td colspan="3" align="center">- Nil -</td>
   	</tr>
   	<%}} %>

	<%if(strModifiedTerms.contains("REODWC")){
   	bflag=false;
   	arrRow=(ArrayList)hsh.get("arrDATEEX");
		if(arrRow!=null && arrRow.size()>0){%>
	<tr><td colspan="3">
	<table width="100%" cellpadding="3" cellspacing="0" border="0">					
	<%for(int j=0;j<arrRow.size();j++){ 
	arrCol=(ArrayList)arrRow.get(j);
	if(j==0){%>
	<tr>
	<td rowspan="<%=arrRow.size()+1 %>" width="50%" align="center">Short Review (Only for Working Capital Limits)</td>
	<td align="center" width="25%" class="tblhead">Proposal No</td>
	<td align="center" width="25%" class="tblhead">Due Date</td>
	<td align="center" width="25%" class="tblhead">Reviewed Due Date</td>
	</tr>
	<%} %>
	<tr>
	<td><%=Helper.correctNull((String)arrCol.get(0)) %></td>
	<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	<td><%=Helper.correctNull((String)arrCol.get(2)) %></td>
	</tr>
	<%} %>
	</table>
	</td>
		</tr>
	<%}else{%>
   	<tr>
   		<td colspan="3" align="center">- Nil -</td>
   	</tr>
   	<%}} %>
	
	<%if(strModifiedTerms.contains("COEX")){bflag=false;%>
	<tr>
   		<td colspan="3" class="tblhead">Extension of Course period (Only for Education Loans)</td>
   	</tr>
	<tr>
   		<td><b>Course period Extended</b></td>
   		<td align="center">-</td>
   		<td align="center"><%=Helper.correctNull((String)hsh.get("EDU_COURSE_EXTEND")) %> Months</td>
   	</tr>
	<tr>
   		<td><b>Course start date</b></td>
   		<td align="center">-</td>
   		<td align="center"><%=Helper.correctNull((String)hsh.get("EDU_COURSE_STRTDATE")) %></td>
   	</tr>
	<%} %>
	<%if(strModifiedTerms.contains("CHDCCO")){
	bflag=false;%>
   	<tr>
   		<td colspan="3" class="tblhead">Change in DCCO without restructuring</td>
   	</tr>
   	<%
   	arrRow=(ArrayList)hsh.get("arrDcco");
		if(arrRow!=null && arrRow.size()>0){%>
	<tr><td colspan="3">
	<table width="100%" cellpadding="3" cellspacing="0" border="0">					
	<%for(int j=0;j<arrRow.size();j++){ 
	arrCol=(ArrayList)arrRow.get(j);
	if(j==0){%>
	<tr>
	<td rowspan="<%=arrRow.size()+1 %>" width="50%">Date of commencement of commercial operation</td>
	<td align="center" width="25%" class="tblhead">Application No</td>
	<td align="center" width="25%" class="tblhead">DCCO Date</td>
	</tr>
	<%} %>
	<tr>
	<td><%=Helper.correctNull((String)arrCol.get(0)) %></td>
	<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	</tr>
	<%} %>
	</table>
	</td>
		</tr>
	<%}else{
   	%>
   	<tr>
   		<td colspan="3" align="center">- Nil -</td>
   	</tr>
   	<%} %>
   	<tr>
   		<td>Holiday period</td>
   		<td align="center"><%=Helper.correctNull((String)hsh.get("strOldHoliday")) %> months</td>
   		<td align="center"><%=Helper.correctNull((String)hsh.get("strHoliday")) %> months</td>
   	</tr>
   	<tr>
   		<td>Tenor</td>
   		<td align="center"><%=Helper.correctNull((String)hsh.get("strOldTenor")) %> months</td>
   		<td align="center"><%=Helper.correctNull((String)hsh.get("strTenor")) %> months</td>
   	</tr>
   	<%} %>
   		<%if(strModifiedTerms.contains("MRS")){ 
   			bflag=false;
   		if(Helper.correctNull((String)hsh.get("strMRSFlag")).equalsIgnoreCase("Y")){ %>
   		<tr>
 	<td colspan="3" class="tblhead" align="center">Modifications to Repayment Schedule without restructuring</td>
 	</tr>
 	<%} %>
 		<%arrRow=(ArrayList)hsh.get("arrMRSExisting");
 		if(arrRow!=null && arrRow.size()>0){%>
	<tr><td colspan="3"><b>Existing Repayment Schedule</b></td></tr>
	<tr><td colspan="3">
	<table width="100%" cellpadding="3" cellspacing="0" border="0">					
	<tr class="tblhead">
	<td align="center" width="4%"><b>S.No</b></td>
	<td align="center" width="32%"><b>Frequency</b></td>
	<td align="center" width="20%"><b>No of Installments</b></td>
	<td align="center" width="20%"><b>Installment Amount</b></td>
	<td align="center" width="20%"><b>Total</b></td>
	</tr>
	<%for(int j=0;j<arrRow.size();j++){ 
	arrCol=(ArrayList)arrRow.get(j);
	strTemp=Helper.correctNull((String)arrCol.get(0));
	if(strTemp.equalsIgnoreCase("M"))
		strTemp="Monthly";
	else if(strTemp.equalsIgnoreCase("Q"))
		strTemp="Quarterly";
	else if(strTemp.equalsIgnoreCase("H"))
		strTemp="Half Yearly";
	else if(strTemp.equalsIgnoreCase("Y"))
		strTemp="Yearly";
	else
			strTemp="";
	%>
	<tr>
	<td align="center"><%=j+1 %></td>
	<td align="center"><%=strTemp %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(3)) %></td>
	</tr>
	<%} %>
	</table>
	</td>
   	</tr>
   	<%}
 		arrRow=(ArrayList)hsh.get("arrMRSProposed");
 		if(arrRow!=null && arrRow.size()>0){%>
	<tr><td colspan="3"><b>Proposed Repayment Schedule</b></td></tr>
	<tr><td colspan="3">
	<table width="100%" cellpadding="3" cellspacing="0" border="0">					
	<tr class="tblhead">
	<td align="center" width="4%"><b>S.No</b></td>
	<td align="center" width="32%"><b>Frequency</b></td>
	<td align="center" width="20%"><b>No of Installments</b></td>
	<td align="center" width="20%"><b>Installment Amount</b></td>
	<td align="center" width="20%"><b>Total</b></td>
	</tr>
	<%for(int j=0;j<arrRow.size();j++){ 
	arrCol=(ArrayList)arrRow.get(j);
	strTemp=Helper.correctNull((String)arrCol.get(0));
	if(strTemp.equalsIgnoreCase("M"))
		strTemp="Monthly";
	else if(strTemp.equalsIgnoreCase("Q"))
		strTemp="Quarterly";
	else if(strTemp.equalsIgnoreCase("H"))
		strTemp="Half Yearly";
	else if(strTemp.equalsIgnoreCase("Y"))
		strTemp="Yearly";
	else
			strTemp="";
	%>
	<tr>
	<td align="center"><%=j+1 %></td>
	<td align="center"><%=strTemp %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(3)) %></td>
	</tr>
	<%} %>
	</table>
	</td>
   	</tr>
   	<%}
   		} %>
	<%if(strModifiedTerms.contains("MIS@")){
		bflag=false;%>
	<tr>
 	<td colspan="3" class="tblhead" align="center">Change in MIS details including RBI industry codes</td>
 	</tr>
 	<tr><td colspan="3"><b>Existing Data</b></td></tr>
	<tr><td colspan="3">
	<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
		<tr class="tblhead">
		<td width="25%" align="center"><b>Descriptions</b></td>	
		<td width="25%" align="center"><b>Facility</b></td>
		<td width="25%" align="center"><b>Descriptions</b> </td>	
		<td width="25%" align="center"><b>Facility</b></td>				
		</tr>
		<tr>
		<td width="25%">Name of Bank Schematic Loan</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("strBankSchemeDescold")) %></td>
		<td width="25%">Guarantee covered BY</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("app_GuaranteeCoveredold")) %></td>				
		</tr>
		<tr>
		<td width="25%">Sector of Loan</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_sctortloanold"))%></td>
		<td width="25%">Sub Sector</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_subscetroloanold"))%></td>				
		</tr>
		<tr>
		<td width="25%">Weaker Section</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_weaksectionold"))%></td>
		<td width="25%">Sensitive Sector</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_sensitivitysecold"))%></td>				
		</tr>
		<tr>
		<td width="25%">Industry Category Type</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_indcattyepagrold"))%></td>
		<td width="25%">Infrastructure</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_infrastructureold"))%></td>					
		</tr>
		<tr>
		<td width="25%">Activity Code</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("app_activitycodeold")) %></td>
		<td width="25%">Main Activity</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_mainactivitydescold")) %></td>					
		</tr>
		<tr>
		<td width="25%">Sub Activity</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_subactdescold")) %></td>
		<td width="25%">Purpose</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_purposeold")) %></td>					
		</tr>	
		<tr>
		<td width="25%">BSR Code</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_bsrcodedescold")) %></td>
		<td width="25%">BSR1 Code</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_bsr1codedescold")) %></td>					
		</tr>
				<tr>
				
					<td width="25%">Sales Turnover of the Applicant </td>	
					<td width="25%"><%=Helper.correctDouble((String)hsh.get("APP_SALETURNOVER_OLD"))%></td>	
					<td width="25%">Sales Turnover As on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hsh.get("APP_SALESTURNOVER_DATE_OLD")) %></td>				
					</tr>
					<tr>
					<td width="25%">Criteria for Sales Turnover </td>	
					<td width="25%"><%=Helper.correctNull((String)hsh.get("APP_CRITERIA_SALESTURNOVER_OLD")) %></td>
					<td width="25%">Investment in Plant & Machineries/Equipments</td>
					<td width="25%"><%=Helper.correctNull((String)hsh.get("app_plantval_old")) %></td>					
					</tr>
					<tr>
					<td width="25%">Industry Name </td>	
					<td width="25%"><%=Helper.correctNull((String)hsh.get("app_indname_old")) %></td>
					<td width="25%">Investment value as on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hsh.get("APP_INVESTMENT_DATE_OLD")) %></td>					
					</tr>
					
					<tr>
					<td width="25%">Criteria for Investment value</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("APP_CRITERIA_INVESTMENT_OLD")) %></td>
					<td width="25%"></td>	
					<td width="25%"></td>
					</tr>				
		
	</table>
	</td>
	</tr>
	
	<tr><td colspan="3"><b>Proposed Data</b></td></tr>
	<tr><td colspan="3">
	<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
		<tr class="tblhead">
		<td width="25%" align="center"><b>Descriptions</b></td>	
		<td width="25%" align="center"><b>Facility</b></td>
		<td width="25%" align="center"><b>Descriptions</b> </td>	
		<td width="25%" align="center"><b>Facility</b></td>				
		</tr>
		<tr>
		<td width="25%">Name of Bank Schematic Loan</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("strBankSchemeDesc")) %></td>
		<td width="25%">Guarantee covered BY</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("app_Guarantee_Covered")) %></td>				
		</tr>
		<tr>
		<td width="25%">Sector of Loan</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_sctortloan"))%></td>
		<td width="25%">Sub Sector</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_subscetroloan"))%></td>				
		</tr>
		<tr>
		<td width="25%">Weaker Section</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_weaksection"))%></td>
		<td width="25%">Sensitive Sector</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_sensitivitysec"))%></td>				
		</tr>
		<tr>
		<td width="25%">Industry Category Type</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_indcattyepagr"))%></td>
		<td width="25%">Infrastructure</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_infrastructure"))%></td>					
		</tr>
		<tr>
		<td width="25%">Activity Code</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("app_activitycode")) %></td>
		<td width="25%">Main Activity</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_mainactivitydesc")) %></td>					
		</tr>
		<tr>
		<td width="25%">Sub Activity</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_subactdesc")) %></td>
		<td width="25%">Purpose</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_purpose")) %></td>					
		</tr>	
		<tr>
		<td width="25%">BSR Code</td>
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_bsrcodedesc")) %></td>
		<td width="25%">BSR1 Code</td>	
		<td width="25%"><%=Helper.correctNull((String)hsh.get("mis_bsr1codedesc")) %></td>					
		</tr>
					<tr>
	                <td width="25%">Sales Turnover of the Applicant </td>	
					<td width="25%"><%=Helper.correctDouble((String)hsh.get("APP_SALETURNOVER"))%></td>	
					<td width="25%">Sales Turnover As on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hsh.get("APP_SALESTURNOVER_DATE")) %></td>				
					</tr>
					<tr>
					<td width="25%">Criteria for Sales Turnover </td>	
					<td width="25%"><%=Helper.correctNull((String)hsh.get("APP_CRITERIA_SALESTURNOVER")) %></td>
					<td width="25%">Investment in Plant & Machineries/Equipments</td>
					<td width="25%"><%=Helper.correctNull((String)hsh.get("app_plantval")) %></td>					
					</tr>
					<tr>
					<td width="25%">Industry Name </td>	
					<td width="25%"><%=Helper.correctNull((String)hsh.get("app_indname")) %></td>
					<td width="25%">Investment value as on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hsh.get("APP_INVESTMENT_DATE")) %></td>					
					</tr>
					
					<tr>
					<td width="25%">Criteria for Investment value</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("APP_CRITERIA_INVESTMENT")) %></td>
					<td width="25%"></td>	
					<td width="25%"></td>
					</tr>		
	</table>
	</td>
	</tr>
	<%} %>
	<%if(strModifiedTerms.contains("SEC")||strModifiedTerms.contains("MARGIN")||strModifiedTerms.contains("MODSEC")){ 
	bflag=false;%>
	<tr>
 	<td colspan="3" class="tblhead" align="center">Security Details</td>
 	</tr>
 	<tr><td colspan="3"><b>Existing Security Details</b></td></tr>
 	<%arrSecPrime=(ArrayList)hsh.get("arrExisSecPrime");
 	arrSecColl=(ArrayList)hsh.get("arrExisSecCollateral");
 	if((arrSecPrime!=null && arrSecPrime.size()>0)||(arrSecColl!=null && arrSecColl.size()>0)){%>
	<tr><td colspan="3">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">


<tr class="tblhead">
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Margin (%)</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if(arrSecPrime!=null && arrSecPrime.size()>0){ %>
<tr align="left">
<td colspan="5"><b>Prime :</b></td>
</tr>
<%for(int a=0;a<arrSecPrime.size();a++)
	{
		arrRow=(ArrayList)arrSecPrime.get(a);
		if(a==0) {
		%>
		<tr>
		<td rowspan="<%=(arrSecPrime.size())%>"><%=Helper.correctNull((String)arrRow.get(0))%></td>
		</tr>
		<%} else {
		secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrRow.get(1))));
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrRow.get(0)))%></td>
		  <td><%=Helper.correctNull((String)arrRow.get(2))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrRow.get(3))%></td>
		</tr>		
		<%	}
	}
}

arrSecColl=(ArrayList)hsh.get("arrExisSecCollateral");
secValue = "";
%>
<%if(arrSecColl!=null && arrSecColl.size()>0){%>
<tr align="left">
<td colspan="5"><b>Collateral :</b></td>
</tr>
	<%for(int a=0;a<arrSecColl.size();a++)
	{
		arrRow=(ArrayList)arrSecColl.get(a);
			secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrRow.get(1))));
			if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="3"> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrRow.get(0)))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrRow.get(2))%></td>
		</tr>		
		<%	
	}
}
%>
</table>
	</td>
	</tr>
	<%}else{%>
	<tr><td colspan="3" align="center"> - Nil -</td></tr>
	<%}%>
	<tr><td colspan="3"><b>Proposed Security Details</b></td></tr>
 	<%arrSecPrime=(ArrayList)hsh.get("arrPropSecPrime");
 	arrSecColl=(ArrayList)hsh.get("arrPropSecCollateral");
 	if((arrSecPrime!=null && arrSecPrime.size()>0)||(arrSecColl!=null && arrSecColl.size()>0)){%>
	<tr><td colspan="3">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">


<tr class="tblhead">
<td  align="center" width="20%"><b>Facility</b></td>
<td  align="center" width="55%"><b>Details of Security</b></td>
<td  align="center" width="10%"><b>Margin (%)</b></td>
<td  align="center" width="10%"><b>Value</b></td>
<td  align="center" width="15%"><b>Date of Valuation</b></td></tr>
<%if(arrSecPrime!=null && arrSecPrime.size()>0){ %>
<tr align="left" >
<td colspan="5"><b>Prime :</b></td>
</tr>
<%for(int a=0;a<arrSecPrime.size();a++)
	{
		arrRow=(ArrayList)arrSecPrime.get(a);
		if(a==0) {
		%>
		<tr>
		<td rowspan="<%=arrSecPrime.size()%>"><%=Helper.correctNull((String)arrRow.get(0))%></td>
		</tr>
		<%} else {
		secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrRow.get(1))));
		if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrRow.get(0)))%></td>
		  <td><%=Helper.correctNull((String)arrRow.get(2))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrRow.get(3))%></td>
		</tr>		
		<%	}
	}
}

arrSecColl=(ArrayList)hsh.get("arrPropSecCollateral");
secValue = "";
%>
<%if(arrSecColl!=null && arrSecColl.size()>0){%>
<tr align="left">
<td colspan="5"><b>Collateral :</b></td>
</tr>
	<%for(int a=0;a<arrSecColl.size();a++)
	{
		arrRow=(ArrayList)arrSecColl.get(a);
			secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrRow.get(1))));
			if(secValue.equals("0.00")) secValue=" ";
		%>
		<tr>
		 <td colspan="3"> <%=Helper.changetoTitlecase(Helper.correctNull((String)arrRow.get(0)))%></td>
		 <td align="right"><%=Helper.correctNull(secValue)%></td>
		 <td><%=Helper.correctNull((String)arrRow.get(2))%></td>
		</tr>		
		<%	
	}
}
%>
</table>
	</td>
	</tr>
	<%}else{%>
	<tr><td colspan="3" align="center"> - Nil -</td></tr>
	<%}%>
	<%}
%>

<%if(strModifiedTerms.contains("GUAR")){
bflag=false;%>
	
	<tr>
 	<td colspan="3" class="tblhead" align="center">Guarantor Details</td>
 	</tr>
 	<tr><td colspan="3"><b>Existing Guarantor/ Co-Obligant / Co-Applicant Details</b></td></tr>
 	<%
	arrRow=(ArrayList)hsh.get("arrGuarExis"); 
 	
	if(arrRow!=null && arrRow.size()>0){%>
	<tr><td colspan="3">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr  class="tblhead">
	<td align="center" width="3%">Sl.No</td>
<td align="center" width="35%">Name </td>
<td align="center" width="15%">Type </td>
<td align="center" width="5%">Age <br>(Yrs)</td>
<td align="center" width="10%">Net Worth as on</td>
</tr>
<%for(int a=0;a<arrRow.size();a++){ 
	arrCol=(ArrayList)arrRow.get(a);%>
	<tr>
	<td align="center"><%=a+1 %></td>
	<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(4)) %> - <%=Helper.correctNull((String)arrCol.get(5)) %></td>
	</tr>
	
<%} %>
</table>
</td>
</tr>
	
	<%}else{ %>
	<tr><td colspan="3" align="center"><b>- Nil -</b></td></tr>
	<%} %>
	<tr><td colspan="3"><b>Proposed Guarantor/ Co-Obligant / Co-Applicant Details</b></td></tr>
	<%
	arrRow=(ArrayList)hsh.get("arrGuarProp"); 
	if(arrRow!=null && arrRow.size()>0){%>
	<tr><td colspan="3">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr  class="tblhead">
	<td align="center" width="3%">Sl.No</td>
<td align="center" width="35%">Name </td>
<td align="center" width="15%">Type </td>
<td align="center" width="5%">Age <br>(Yrs)</td>
<td align="center" width="10%">Net Worth as on</td>
</tr>
<%for(int a=0;a<arrRow.size();a++){ 
	arrCol=(ArrayList)arrRow.get(a);%>
	<tr>
	<td align="center"><%=a+1 %></td>
	<td align="left"><%=Helper.correctNull((String)arrCol.get(1)) %></td>
	<td align="left"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(4)) %> - <%=Helper.correctNull((String)arrCol.get(5)) %></td>
	</tr>
	
<%} %>
</table>
</td>
</tr>
	
	<%}else{ %>
	<tr><td colspan="3" align="center"><b>- Nil -</b></td></tr>
	<%}  %>
<%} %>
<%if(strModifiedTerms.contains("LAD")||strModifiedTerms.contains("SUBLIMIT")){
	bflag=false;
arrRow=(ArrayList)hsh.get("arrSubLimit"); 
	if(arrRow!=null && arrRow.size()>0){%>
<tr><td colspan="3" class="tblhead"><b>Sanction of sub-limit for the existing/already sanctioned main limit</b></td></tr>
<tr><td colspan="3"> The Following Sub Limits has been sanctioned under the Main Limit - <%=Helper.correctNull((String)hsh.get("strProductDesc")) %><b></b></td></tr>
	<tr><td colspan="3">
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr  class="tblhead">
	<td align="center" width="3%">Sl.No</td>
<td align="center" width="35%">Facility </td>
<td align="center" width="15%">Tenor </td>
<td align="center" width="15%">Limit </td>
</tr>
<%for(int a=0;a<arrRow.size();a++){ 
	arrCol=(ArrayList)arrRow.get(a);%>
	<tr>
	<td align="center"><%=a+1 %></td>
	<td align="left"><%=Helper.correctNull((String)arrCol.get(0)) %></td>
	<td align="center"><%=Helper.correctNull((String)arrCol.get(2)) %>  Months</td>
	<td align="right"><%=Helper.correctNull((String)arrCol.get(1)) %> </td>
	</tr>
	
<%} %>
</table>
</td>
</tr>
<%}
%>
<%}} %>

<%int z=0;
if(strModifiedTerms.contains("MOEX")){
	bflag=false;
	int intVal=Integer.parseInt(Helper.correctInt((String)hsh.get("strintVal")));%>
	<tr class="tblhead"><td colspan="3">Extension of Moratorium taking into account spells of unemployment/under-employment</td>
	</tr>
	<%for(int c=intVal;c>=0;c--){
	if(intVal!=0){%>
	<tr>
	<td colspan="3" class="tblhead">Proposal Number:<%=Helper.correctInt((String)hsh.get("strProposalNo"+c)) %></td>
	</tr>
	<%} %>
   	<tr>
   	<td>Loan Period</td>
   	<td><%=Helper.correctInt((String)hsh.get("strOldReqTerms"+c)) %></td>
   	<td><%=Helper.correctInt((String)hsh.get("strReqTerms"+c)) %></td>
   	</tr>
   	<tr>
   	<td>Holiday Period</td>
   	<td><%=Helper.correctInt((String)hsh.get("strHolidayEx"+c)) %></td>
   	<td><%=Helper.correctInt((String)hsh.get("strHoliday"+c)) %></td>
   	</tr>
  <%-- 	<tr>
   	<td>Interest to be collected during Holiday</td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strInteresServisedEx"+c));
   	if(strTemp.equals("s"))
   		strTemp="Not Applicable";
   	else if(strTemp.equals("n"))
   		strTemp="No";
   	else if(strTemp.equals("y"))
   		strTemp="Yes";
   	else
   		strTemp="";%>
   	<td><%=strTemp%></td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strInteresServised"+c));
   	if(strTemp.equals("s"))
   		strTemp="Not Applicable";
   	else if(strTemp.equals("n"))
   		strTemp="No";
   	else if(strTemp.equals("y"))
   		strTemp="Yes";
   	else
   		strTemp="";%>
   	<td><%=strTemp%></td>
   	</tr>
   	<tr>
   	<td>Interest charged</td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strLoaninterestchargedEx"+c));
   	if(strTemp.equals("1"))
   		strTemp="To be paid as and when debited";
   	else if(strTemp.equals("2"))
   		strTemp="To be accumulated and added to the principal to calculate EMI";
   	else if(strTemp.equals("3"))
   		strTemp="Quarterly";
   	else if(strTemp.equals("4"))
   		strTemp="Monthly";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp %>&nbsp;</td>
   	<%strTemp=Helper.correctNull((String)hsh.get("strLoaninterestcharged"+c));
   	if(strTemp.equals("1"))
   		strTemp="To be paid as and when debited";
   	else if(strTemp.equals("2"))
   		strTemp="To be accumulated and added to the principal to calculate EMI";
   	else if(strTemp.equals("3"))
   		strTemp="Quarterly";
   	else if(strTemp.equals("4"))
   		strTemp="Monthly";
   	else
   		strTemp="";
   	%>
   	<td><%=strTemp %>&nbsp;</td>
   	</tr>--%> 
   	<tr>
   	<td>Loan EMI</td>
   	<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hsh.get("strEMIEx"+c)))) %></td>
   	<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hsh.get("strEMI"+c)))) %></td>
   	</tr>
   	<%} %>
   	<%} %>

<%
if(bflag)
{%>
<tr align="center">
<td colspan="3">-&nbsp;Nil&nbsp;-</td>
</tr>
<%}
%>
</table>
	</td>
	</tr>
   	
   		
   <%
   }
   %>
   </table>
   	</div>
	</td>
	</tr>
   </table>
   </td>
   </tr>
   <tr>
   <td>&nbsp;</td>
   </tr>
   </table>
</form>
</body>
</html>