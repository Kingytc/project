<%@ page import="com.sai.laps.helper.*,java.util.*,java.text.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
java.text.NumberFormat nft= java.text.NumberFormat.getInstance();
nft= java.text.NumberFormat.getInstance();
nft.setMaximumFractionDigits(2);
nft.setMinimumFractionDigits(2);
nft.setGroupingUsed(false);

HashMap hshRecord=new HashMap();
HashMap hshFinlValues = new HashMap();
hshRecord=(HashMap)hshValues.get(request.getParameter("pagevalue"));
ArrayList arrRowShare=new ArrayList();
ArrayList arrRowNature=new ArrayList();
ArrayList arrColNature=new ArrayList();
ArrayList arrBAOtherRow	= new ArrayList();
ArrayList arrBuyerDeatails	= new ArrayList();
ArrayList arrSellerDeatails	= new ArrayList();
ArrayList arrKeyPersonInfo	= new ArrayList();
ArrayList arrCaptialInfo	= new ArrayList();
ArrayList arrCol	= new ArrayList();
ArrayList arrRowCIBIL	= new ArrayList();
ArrayList arrColCIBIL	= new ArrayList();
ArrayList arrRowEcgc		= new ArrayList();
ArrayList arrColEcgc		= new ArrayList();
ArrayList arrRowDefault		= new ArrayList();
ArrayList arrColDefault		= new ArrayList();
ArrayList arrGrpexpRow = new ArrayList();
ArrayList arrGrpexpCol = new ArrayList();
ArrayList arrGrpsecRow = new ArrayList();
ArrayList arrGrpsecCol = new ArrayList();
ArrayList arrSecMovement = new ArrayList();
String strFlag="";
String strNil = "Nil";
HashMap	 hshSecdata	= new HashMap();
hshSecdata=(HashMap)hshValues.get("hshsecdet");
hshFinlValues = (HashMap) hshValues.get("hshFinlValues");
double subExpExitotal=0.00,subSecExitot=0.00,subSecProtot=0.00;
double ExpExitot=0.00,SecExitot=0.00,SecProtot=0.00;
double subTotalexp=0.00,totalExp=0.00,subSectot=0.00,Sectot=0.00;
if(hshValues !=null){
	arrGrpexpRow=(ArrayList)hshSecdata.get("arrExposureRow");
	arrGrpsecRow=(ArrayList)hshSecdata.get("Securities");
	strFlag=Helper.correctNull((String)hshSecdata.get("strFlag"));
}

String strECGCIFlag="",strDefaulterFlag="",strCRILCFlag="",strDefaulterDate="",strECGCIDate="";
if(hshRecord!=null)
{
	arrRowShare = (ArrayList)hshRecord.get("Shareholding");
	arrRowNature = (ArrayList)hshRecord.get("Natureofshare");
	arrBuyerDeatails = (ArrayList)hshRecord.get("arrBuyerInfo");
	arrSellerDeatails = (ArrayList)hshRecord.get("arrSellerInfo");
	arrCaptialInfo = (ArrayList)hshRecord.get("arrCaptialInfo");
	arrRowCIBIL = (ArrayList)hshRecord.get("arrRowCIBIL");
	strECGCIFlag=Helper.correctNull((String)hshRecord.get("strECGCIFlag"));
	strDefaulterFlag=Helper.correctNull((String)hshRecord.get("strDefaulterFlag"));
	strCRILCFlag=Helper.correctNull((String)hshRecord.get("strCRILCFlag"));
	arrRowEcgc = (ArrayList)hshRecord.get("arrRowEcgc");
	strECGCIDate=Helper.correctNull((String)hshRecord.get("strECGCIDate"));
	strDefaulterDate=Helper.correctNull((String)hshRecord.get("strDefaulterDate"));
	arrRowDefault = (ArrayList)hshRecord.get("arrRowDefault");
	arrKeyPersonInfo=(ArrayList)hshRecord.get("arrKeyPersonInfo");
}

arrBAOtherRow=(ArrayList)hshValues.get("arrBAOtherRowNew");
arrSecMovement=(ArrayList)hshValues.get("arrSecMovement");
String strAmountvalue=Helper.correctNull((String) hshValues.get("com_amountvalue"));
String strPrevCusID="";
String strAmtValueIn = Helper.correctNull((String)hshValues.get("strAmtValueIn"));
if(strAmtValueIn.equalsIgnoreCase("Rs"))
{
	strAmtValueIn	= "(Amount in  "+strAmtValueIn+".)";
}
else
{
	strAmtValueIn	= "(Rs. in  "+strAmtValueIn+")";
}
String strFinvaluesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
if(strFinvaluesIn.equalsIgnoreCase("Rs"))
{
	strFinvaluesIn	= "(Amount in  "+strFinvaluesIn+".)";
}
else
{
	strFinvaluesIn	= "(Rs. in  "+strFinvaluesIn+")";
}
String strAmountValue = Helper.correctNull((String) hshValues.get("com_amountvalue"));
ArrayList arrProfitability =  new ArrayList();
arrProfitability = (ArrayList)hshValues.get("arrProfitability");
int vecsize = 0;
ArrayList vec = new ArrayList();
ArrayList g2 = new ArrayList();
HashMap hshBenchmark=new HashMap();
hshBenchmark=(HashMap)hshValues.get("hshBenchValues");
if (hshBenchmark != null) {
	vec = (ArrayList) hshBenchmark.get("vecData");
}
if (vec != null) {
	vecsize = vec.size();
}
%>
<tr>
	<td class="title"><br>&nbsp;History and Background:</td>
</tr>
<%
	if (!Helper
			.correctNull((String) hshValues.get("com_commentsbrief"))
			.equalsIgnoreCase("")) {
%>
<tr>
	<td><b>Promoters Background</b><br/><%=Helper.correctNull((String) hshValues
								.get("com_commentsbrief"))%></td>
</tr>
<%
	}
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments1"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>About the Promoters / Directors :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments1"))%></td>
</tr>
<%
}
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments2"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Activity of the applicant :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments2"))%></td>
</tr>
<%
}
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments3"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Product Profile & where it finds its use/application :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments3"))%></td>
</tr>
<%
}%>
<%if(arrBAOtherRow!=null && arrBAOtherRow.size()>0){ %>
<tr>
		<td width="50%" nowrap colspan="10"><b>Banking History :</b></td>
</tr>
<tr>
<td>
<div id="top">
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
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
		<td width="10%" align="center"><b>Limit</b></td>
		<td width="10%" align="center"><b>Start Date</b></td>
		<td width="10%" align="center"><b>Due Date</b></td>
		</tr>
		<%} %>
		<tr>
		<td align="center"><%=j+1%></td> 
		<td><%=Helper.correctNull((String)arrCol.get(11))%></td> 
		<td align="right"><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountvalue)%></td>  
		<td><%=Helper.correctNull((String)arrCol.get(8))%></td> 
		<td><%=Helper.correctNull((String)arrCol.get(13))%></td> 
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

<%} %>

<%if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments12"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Production & Infrastructural Facilities :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments12"))%></td>
</tr>
<%
}
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments13"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Raw Material :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments13"))%></td>
</tr>
<%
}
if(arrSellerDeatails!=null && arrSellerDeatails.size()>0){

%>
<tr>
<td><b>List of Major Suppliers :</b></td>
</tr>
<tr>
<td>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="25%">Domestic</td>
<td width="25%">Place</td>
<td width="25%">Overseas</td>
<td width="25%">Place</td>
</tr>
<%for(int i=0;i<arrSellerDeatails.size();i++){ 
arrCol=(ArrayList)arrSellerDeatails.get(i);%>
<tr>
<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
</tr>
<%} %>
</table>
</div>
</td>
</tr>
<tr><td><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments5"))%>&nbsp;</td></tr>
<%
}
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments4"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Manufacturing Process :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments4"))%></td>
</tr>
<%
}
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments14"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Selling & Marketing Arrangements :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments14"))%></td>
</tr>
<%
}
if(arrBuyerDeatails!=null && arrBuyerDeatails.size()>0){

	%>
	<tr>
	<td><b>List of Major Buyers/Customers :</b></td>
	</tr>
	<tr>
	<td>
	<div id="top">
	<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
	<tr>
	<td width="25%">Domestic</td>
	<td width="25%">Place</td>
	<td width="25%">Overseas</td>
	<td width="25%">Place</td>
	</tr>
	<%for(int i=0;i<arrBuyerDeatails.size();i++){ 
	arrCol=(ArrayList)arrBuyerDeatails.get(i);%>
	<tr>
	<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
	<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
	<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
	<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
	</tr>
	<%} %>
	</table>
	</div>
	</td>
	</tr>
	<tr><td><%=Helper.correctNull((String) hshRecord
								.get("MgmtComments6"))%>&nbsp;</td></tr>
	<%
	}
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments7"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Any other information :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments7"))%></td>
</tr>
<%
}
%>

<% if(arrRowShare!=null&&arrRowShare.size()>0)
	{%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" align="left">Share Holding Pattern :</td>
			</tr>
		</table>
	</td>
</tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
<tr>
<td align="right" colspan="5">Market Values of the Shares </td>
<td align="right" ><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("MrktValOfShares")))),strAmountvalue)%></td>
</tr>
<tr><td>&nbsp;</td>
<td align="center">Shares held by</td>
<td align="center">No. of Shares held</td>
<td align="center">Face Value  </td>
<td align="center">Amount </td>
<td align="center">% of Holding</td>
</tr>
 <%
 ArrayList arrType=new ArrayList();
 double dbltotfaceval=0.0,dbltotamount=0.0,dbltotpercent=0.0;
 long lngtotshares=0;
 for(int i=0;i<arrRowShare.size();i++) {
		ArrayList arrColShare	= (ArrayList)arrRowShare.get(i);
		if(arrType.contains(Helper.correctNull((String)arrColShare.get(1))))
			continue;
		else
			arrType.add(Helper.correctNull((String)arrColShare.get(1)));
		 double dbltotfaceTemp=0.0,dbltotamountTemp=0.0,dbltotpercentTemp=0.0;
		 long lngtotsharestemp=0;
		for(int j=i;j<arrRowShare.size();j++)
		{
			ArrayList arrColSharetemp	= (ArrayList)arrRowShare.get(j);
			if(Helper.correctNull((String)arrColSharetemp.get(1)).equalsIgnoreCase(Helper.correctNull((String)arrColShare.get(1))))
			{
				lngtotsharestemp+=Integer.parseInt(Helper.correctDouble((String)arrColSharetemp.get(2)));
				dbltotfaceTemp+=Double.parseDouble(Helper.correctDouble((String)arrColSharetemp.get(3)));
				dbltotamountTemp+=Double.parseDouble(Helper.correctDouble((String)arrColSharetemp.get(4)));
				dbltotpercentTemp+=Double.parseDouble(Helper.correctDouble((String)arrColSharetemp.get(5)));
			}
		}
	%>
	<tr>
		 <td>&nbsp;</td>
		 <td><%=Helper.correctNull((String)arrColShare.get(1))%></td>
		 <td><%=lngtotsharestemp%></td>
		 <td style="text-align: right"><%=Helper.converAmount(Helper.formatDoubleValue(dbltotfaceTemp),strAmountvalue)%></td>
		 <td style="text-align: right"><%=Helper.converAmount(Helper.formatDoubleValue(dbltotamountTemp),strAmountvalue)%></td>
		 <td style="text-align: right"><%=Helper.converAmount(Helper.formatDoubleValue(dbltotpercentTemp),strAmountvalue)%></td>
		<%
		lngtotshares = lngtotshares + lngtotsharestemp;
		dbltotfaceval = dbltotfaceval +dbltotfaceTemp;
		dbltotamount = dbltotamount + dbltotamountTemp;
		dbltotpercent=dbltotpercent+dbltotpercentTemp;
		%>
									</tr>
	
	<%}%>
	<tr>
	<td colspan="2" align="center"> Total</td>
	<td align="left"><%=lngtotshares %></td>
	<td>&nbsp;</td>
	<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(dbltotamount),strAmountvalue) %></td>
	<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(dbltotpercent),strAmountvalue) %></td>
	</tr>
</table>
</div>
</td>
</tr>	
	
 <%}
 if(arrRowNature!=null&&arrRowNature.size()>0)
	{%>
	<tr><td class="title">Nature of Shares :</td></tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
	<tr>
	<td>&nbsp;</td>
	<td align="center">Nature of Shares</td>
	<td colspan="2" align="center">Authorised</td>
	<td colspan="2" align="center">Issued / Paid up</td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td align="center">No. of Shares</td>
	<td align="center">Value (Rs.)<br/></td>
	<td align="center">No. of shares</td>
	<td align="center">Value (Rs.)<br/></td>
	</tr>
	<% 
	 for(int i=0;i<arrRowNature.size();i++) {
		 arrColNature	= (ArrayList)arrRowNature.get(i);
	%>
	<tr>
	<td>&nbsp;</td>
	<td><%=Helper.changetoTitlecase(Helper.correctNull((String)arrColNature.get(2)))%></td>
	<td><%=Helper.correctNull((String)arrColNature.get(3))%></td>
	<td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColNature.get(4))))%></td>
	<td><%=Helper.correctNull((String)arrColNature.get(5))%></td>
	 <td style="text-align: right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColNature.get(6))))%></td>
	</tr>	
	<%}%>
	</table>
</div></td>
</tr>
	<% }%>
	
	<tr>
	<td>If listed in S.E. quotation value : <%=Helper.correctNull((String)hshRecord.get("strListedinSE")) %>
	</td>
	</tr>
<%if(arrRowShare!=null&&arrRowShare.size()>0)
	{%>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" align="left">Details of Share Holders :</td>
			</tr>
		</table>
	</td>
</tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
<tr><td>Sl.No&nbsp;</td>
<td align="center">Name of the Share Holder</td>
<td align="center">No. of Shares held</td>
<td align="center">% of Holding</td>
</tr>
<%
double dbltotfaceval=0.0,dbltotamount=0.0,dbltotpercent=0.0;
long lngtotshares=0;
for(int i=0;i<arrRowShare.size();i++) {
		ArrayList arrColShare	= (ArrayList)arrRowShare.get(i);
	%>
	<tr>
		 <td><%=i+1 %>&nbsp;</td>
		 <td><%=Helper.correctNull((String)arrColShare.get(8))%></td>
		 <td align="right"><%=Integer.parseInt(Helper.correctInt((String)arrColShare.get(2)))%></td>
		 <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColShare.get(5))))%></td>
		<%
		lngtotshares = lngtotshares + Integer.parseInt(Helper.correctInt((String)arrColShare.get(2)));
		dbltotpercent=dbltotpercent+Double.parseDouble(Helper.correctDouble((String)arrColShare.get(5)));
		%>
									</tr>
	
	<%}%>
	<tr>
	<td colspan="2" align="center"> Total</td>
	<td align="right"><%=lngtotshares%></td>
	<td align="right"><%=Helper.formatDoubleValue(dbltotpercent) %></td>
	</tr>
</table>
</div>
</td>
</tr>	
	
<%}

if(arrCaptialInfo!=null&&arrCaptialInfo.size()>0)
{%>
<tr>
<td>
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
		<tr>
			<td class="title" align="left">Capital Market information in case of Listed Companies : &nbsp;<%=Helper.correctNull((String)hshRecord.get("strListedinSE")) %> </td>
		</tr>
		<tr>
			<td class="title" align="left">Brief Share Quotation Data in BSE and NSE as on &nbsp;<%=Helper.correctNull((String)hshRecord.get("strShareAson")) %> </td>
		</tr>
	</table>
</td>
</tr>
<tr><td>
<div id="top">
<table width="100%" align="center" cellpadding="3" cellspacing="0">
<td align="center">Particulars</td>
<td align="center">BSE (Rs.)</td>
<td align="center">NSE (Rs.)</td>
</tr>
<%
for(int i=0;i<arrCaptialInfo.size();i++) {
	arrCol	= (ArrayList)arrCaptialInfo.get(i);
	if(i==6){
%>
<tr>
<td colspan="3"> Dividend payment for last three Years</td>
</tr>
<%} %>
<tr>
	 <td><%=Helper.correctNull((String)arrCol.get(0))%></td>
	 <td align="right"><%=Helper.correctNull((String)arrCol.get(1))%></td>
	 <td align="right"><%=Helper.correctNull((String)arrCol.get(2))%></td>
</tr>

<%}%>
</table>
</div>
</td>
</tr>	

<%}

if (!Helper.correctNull((String) hshRecord.get("strShareCmts"))
		.equalsIgnoreCase("")) {
%>
<tr>
<td><b>Comments on Large Movement of Shares :</b><br/><%=Helper.correctNull((String) hshRecord
							.get("strShareCmts"))%></td>
</tr>
<%
}
	%>

<%
if (!Helper
		.correctNull((String) hshRecord.get("MgmtComments15"))
		.equalsIgnoreCase("") || (arrKeyPersonInfo!=null && arrKeyPersonInfo.size()>0)) {
%>
<tr>
<td><b>Details of Key Managerial Persons other than directors/promoters :</b></td>
</tr>
<%if(arrKeyPersonInfo!=null && arrKeyPersonInfo.size()>0){ %>
<tr>
<td>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td width="25%">Name</td>
<td width="25%">Age</td>
<td width="25%">Qualification</td>
<td width="25%">Experience</td>
</tr>
<%for(int i=0;i<arrKeyPersonInfo.size();i++){ 
arrCol=(ArrayList)arrKeyPersonInfo.get(i);%>
<tr>
<td><%=Helper.correctNull((String)arrCol.get(0)) %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>
</tr>
<%} %>
</table>
</div>
</td>
</tr>
<%} %>
<tr>
<td><%=Helper.correctNull((String) hshRecord
							.get("MgmtComments15"))%></td>
</tr>
<%
}	
if (!Helper
			.correctNull((String) hshRecord.get("MgmtComments16"))
			.equalsIgnoreCase("")) {
%>
<tr>
	<td><b>Sourcing of Proposal & Market Enquiry</b><br/><%=Helper.correctNull((String) hshRecord
								.get("MgmtComments16"))%></td>
</tr>
<%
	}
%>

<tr>
<td class="title" align="left" width="50%">Details of CIBIL<br/>
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{%>

<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="20%">Name</td>
	<td align="center" width="10%">CIBIL Refered</td>
	<td align="center" width="10%">Reported Date</td>
	<td align="center" width="10%">CIBIL Score</td>
	<td align="center" width="45%">CIBIL Details</td>
</tr>
<%
strPrevCusID="";int j=0;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));		
	}j=j+1;
%>
<tr>
	<td width="5%"><%=j%></td>
	<td><%=Helper.correctNull((String)arrColCIBIL.get(1))%>
	<%
	String strCIBILDetails=Helper.correctNull((String)arrColCIBIL.get(14));	
if(!strCIBILDetails.equalsIgnoreCase(""))
	{
		String[] strArr=strCIBILDetails.split("@");
		for(int a=0;a<1;a++)
		{%>
			<br/>(Previous Score)
		<%}
	}
	%>
	</td>
	<td align="center"><%=Helper.correctNull((String)arrColCIBIL.get(2))%></td>
	<td align="center"><%=Helper.correctNull((String)arrColCIBIL.get(3))%>
<%if(!strCIBILDetails.equalsIgnoreCase(""))
	{
		String[] strArr=strCIBILDetails.split("@");
		for(int a=0;a<strArr.length;a++)
		{
			String[] strArr1=strArr[a].split("-");
			String strValue="";
%>
			<br/><%for(int b=strArr1.length-1;b>strArr1.length-2;b--)
				{
					strValue=strValue+strArr1[b];
				}%>
				(<%=strValue %>)
		<%}
	}%>
</td>
	<td align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%>
<%if(!strCIBILDetails.equalsIgnoreCase(""))
	{
		String[] strArr=strCIBILDetails.split("@");
		for(int a=0;a<strArr.length;a++)
		{
			String[] strArr1=strArr[a].split("-");
			String strValue="";%>
			<br/><%for(int b=0;b<strArr1.length-1;b++)
				{
					strValue=strValue+strArr1[b];
				}%>
				(<%=strValue %>)
		<%}
	}%>
</td>
	<td><%=Helper.correctNull((String)arrColCIBIL.get(5))%></td>
</tr>
<%}}else{%>
<tr><td align="center" style="border:none;">- No Record Found -</td></tr>
<%} %>
</table>
</div>
</td>
</tr>
<tr>
<td class="title" align="left" width="50%">Details of CRIF
<br/>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{%>
<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="20%">Name</td>
	<td align="center" width="10%">CRIF Referred</td>
	<td align="center" width="10%">Reported date</td>
	<td align="center" width="20%">CRIF Score</td>
	<td align="center" width="25%">CRIF Details</td>
	
</tr>
<%
boolean bflag=true;
strPrevCusID="";int j=0;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));		
	}j=j+1;
%>
<tr>
	<td><%=j%></td>
	<td><%=Helper.correctNull((String)arrColCIBIL.get(1))%>
	<%
	String strCRIFDetails=Helper.correctNull((String)arrColCIBIL.get(15));
	if(!strCRIFDetails.equalsIgnoreCase(""))
	{
		String[] strArr=strCRIFDetails.split("@");
		for(int a=0;a<1;a++)
		{%>
			<br/>(Previous Score)
		<%}
	}
	%>
	</td>
	<td align="center"><%=Helper.correctNull((String)arrColCIBIL.get(10))%></td>
	<td align="center"><%=Helper.correctNull((String)arrColCIBIL.get(13))%>
	<%if(!strCRIFDetails.equalsIgnoreCase(""))
	{
		String[] strArr=strCRIFDetails.split("@");
		for(int a=0;a<strArr.length;a++)
		{
			String[] strArr1=strArr[a].split("-");
			String strValue="";
%>
			<br/><%for(int b=strArr1.length-1;b>strArr1.length-2;b--)
				{
					strValue=strValue+strArr1[b];
				}%>
				(<%=strValue %>)
		<%}
	}%>
	</td>
	<td align="center"><%=Helper.correctNull((String)arrColCIBIL.get(11))%>
	<%if(!strCRIFDetails.equalsIgnoreCase(""))
	{
		String[] strArr=strCRIFDetails.split("@");
		for(int a=0;a<strArr.length;a++)
		{
			String[] strArr1=strArr[a].split("-");
			String strValue="";%>
			<br/><%for(int b=0;b<strArr1.length-1;b++)
				{
					strValue=strValue+strArr1[b];
				}%>
				(<%=strValue %>)
		<%}
	}%>
	</td>
	<td><%=Helper.correctNull((String)arrColCIBIL.get(12))%></td>
</tr>
<%
}}else{%>
	<tr>
	<td align="center" colspan="5">- No Record Found -</td>
</tr>
<%}%>
</table>
</div>
</td>
</tr>
<%if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{ %>
<tr>
<td  align="left" width="50%"><b>Details of CRILC Report</b>
<br/>
<%if(strCRILCFlag.equalsIgnoreCase("true")){ %>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
 <% if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{%>

<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="30%">Name</td>
	<td align="center" width="20%">Reported to CRILC</td>
	<td align="center" width="25%">Reported Dated</td>
	<td align="center" width="30%">CRILC Details</td>
</tr>
<%
strPrevCusID="";int j=0;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));		
	}
	
	if(true){
		j=j+1;
		
%>
<tr>
	<td width="5%"><%=j%></td>
	<td width="30%"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColCIBIL.get(6))%></td>
	<td width="25%"><%=Helper.correctNull((String)arrColCIBIL.get(9))%></td>
	<td width="30%"><%=Helper.correctNull((String)arrColCIBIL.get(7))%></td>
</tr>
<%}}
} %>
</table>
</div>
<%}else{ 
for(int i=0;i<arrRowCIBIL.size();i++) {
if(i!=0){
	continue;
}%>
No Adverse observations is observed on CRILC.
<%
}%>
<%} %>
</td>
</tr>
<%} %>
 <% if(arrRowEcgc!=null&&arrRowEcgc.size()>0)
{%>
<tr>
<td align="left" width="50%"><b>Whether in ECGCI specific approval List</b><br/>
<%if(strECGCIFlag.equalsIgnoreCase("true")){ %>
<div id="top">
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
<tr>
<td align="center" width="5%">S.no</td>
<td align="center" width="20%">Name</td>
<td align="center" width="10%">Whether appearing in SAL</td>
<td align="center" width="20%">As on date</td>
<td align="center" width="45%">Comments</td>
</tr>
<%
strPrevCusID="";int j=0;
for(int i=0;i<arrRowEcgc.size();i++) {
	arrColEcgc	= (ArrayList)arrRowEcgc.get(i);
	
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColEcgc.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColEcgc.get(0));		
	}j=j+1;
%>
<tr>
<td width="5%"><%=j%></td>
<td width="20%"><%=Helper.correctNull((String)arrColEcgc.get(1))%></td>
<td width="10%" align="center"><%=Helper.correctNull((String)arrColEcgc.get(2))%></td>
<td width="20%"><%=Helper.correctNull((String)arrColEcgc.get(3))%></td>
<td width="45%"><%=Helper.correctNull((String)arrColEcgc.get(4))%></td>
</tr>
<%} %>
</table>
</div>
<%}else{%>
No references are found in ECGCI SAL list <%if(!strECGCIDate.equalsIgnoreCase("")){ %> as per search report dated <%=strECGCIDate%><%} %>
<%} %>
</td>
</tr>
<%} 
String strCFR=Helper.correctNull((String)hshValues.get("COM_CFR_VERIFIED"));
String StrNameCFR=Helper.correctNull((String)hshValues.get("COM_CFR_BORNAME"));
if(strCFR.equalsIgnoreCase("Y"))
	strCFR="Yes";
else if(strCFR.equalsIgnoreCase("N"))
	strCFR="No";
else if(strCFR.equalsIgnoreCase("NA"))
	strCFR="Not Applicable";
%>
<tr>
<td><b>Whether Referred to Central Fraud Registry: </b><%=strCFR %>.<%if(!StrNameCFR.equalsIgnoreCase("Y")){ %> No references are found in Central Fraud Registry<%} %> </td>
</tr>
<% if(arrRowDefault!=null&&arrRowDefault.size()>0)
	{%>
<tr>
<td  align="left" width="50%"><b> Whether the name of the Applicant/ Directors. Co-obligants/ Guarantors is in the Defaulters List of RBI</b> <br/>
<%if(strDefaulterFlag.equalsIgnoreCase("true")){ %>
<div id="top">
	<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
	 
	 
	
	<tr>
	<td align="center" width="5%">S.no</td>
	<td align="center" width="20%">Name</td>
	<td align="center" width="10%">Defaulters List</td>
	<td align="center" width="20%">As on date</td>
	<td align="center" width="45%">Comments</td>
	</tr>
	<%
	strPrevCusID="";int j=0;
	for(int i=0;i<arrRowDefault.size();i++) {
		arrColDefault	= (ArrayList)arrRowDefault.get(i);
		
		if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColDefault.get(0))))
		{
			continue;
		}
		else
		{
			strPrevCusID = Helper.correctNull((String)arrColDefault.get(0));		
		}j=j+1;
	%>
	<tr>
	<td width="5%"><%=j%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColDefault.get(1))%></td>
	<td width="10%" align="center"><%=Helper.correctNull((String)arrColDefault.get(2))%></td>
	<td width="20%"><%=Helper.correctNull((String)arrColDefault.get(3))%></td>
	<td width="45%"><%=Helper.correctNull((String)arrColDefault.get(4))%></td>
	</tr>
	<%}%>
	</table>
</div>
<%}else{%>
No references are found in RBI Defaulter list <%if(!strDefaulterDate.equalsIgnoreCase("")){ %> as per search report dated <%=strDefaulterDate%><%} %>
<%} %>
</td>
</tr>
<%}%>

<tr>
	<td class="title"><br>III&nbsp;Details of existing credit facilities and the Security position :</td>
</tr>
<%
	if (!(Helper.correctNull((String) hshValues
			.get("com_commentssecoverage"))).equalsIgnoreCase("")) {
%>
<tr>
	<td><%=Helper.correctNull((String) hshValues
								.get("com_commentssecoverage"))%></td>
</tr>
<%
	}
%>
<%String strAppSecurity=Helper.correctNull((String)hshValues.get("COMSEC_APPCOVERAGE"));
if(!strAppSecurity.equalsIgnoreCase("M")){%>
<tr>
	<td valign="top">
	<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="50%" align="right"><%=strAmtValueIn%>&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>

<tr>
	<td>
	<div id="top">
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
<td>&nbsp;</td>
<td align="center"><b>Existing Exposure</td>
<td align="center"><b>Proposed Exposure</td>
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
<td align="center"><b>Proposed </td>
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
			
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(10)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(10)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
	%>
	<tr ><td colspan="6"><b>Applicant : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr>
	<td><b>TL Exposure</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(10)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)))),strAmountValue)%></td>
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
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
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(12)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(12)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
		%>
		<tr>
		<td><b>WC Exposure</b></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13))))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(12)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13))))),strAmountValue)%></td>
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right">&nbsp;</td>
	<%} %>
	</tr>
			
		<%}
	}
	for(int i=0;i<arrGrpexpRow.size();i++)
	{
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("A"))
		{
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(14)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(14)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
		%>
		<tr>
		<td><b>Credit line for FC</b></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15))))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(14)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15))))),strAmountValue)%></td>
	<% if(arrGrpsecRow!=null && arrGrpsecRow.size()>2)
	{
		for(;k<3;k++)
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	<% }}else{%>
	<td align="right"></td>
	<td align="right"></td>
	<td align="right">&nbsp;</td>
	<%} %>
	</tr>
			
		<%}
	}%>
	<%
	int SecSize=arrGrpsecRow.size();
	if(SecSize>3){
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
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	</tr>
	<%}}%>
	<%if(strFlgchk.equalsIgnoreCase("Y")){%>
	
	<tr>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subExpExitotal)),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subTotalexp)),strAmountValue)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subSecExitot)),strAmountValue)%></td>
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
		subSecExitot=0.00;
		subSecProtot=0.00;
		subTotalexp=0.00;
		subSectot=0.00;
		arrGrpexpCol=(ArrayList)arrGrpexpRow.get(i);
		if(arrGrpexpCol.get(4).equals("O"))
		{
			n++;
			if((arrGrpexpCol.get(6).equals("Y"))){
			subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
			ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
			subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(10)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
			totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(10)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)));
	%>
	<tr><td colspan="6"><b>Group Concern : <%=Helper.correctNull((String)arrGrpexpCol.get(5))%></b></td>
	</tr>
	<tr>
	<td><b>TL Exposure</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(10)))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(10)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(11)))),strAmountValue)%></td>
	
	
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<% }%>
	</tr>
	<%
	subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
	ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
	subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(12)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
	totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(12)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)));
	%>
		<tr>
		<td><b>WC Exposure</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(12)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)))),strAmountValue)%></td>
	
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<% }%>
	</tr>
	
	<%
	subExpExitotal+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
	ExpExitot+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
	subTotalexp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(14)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
	totalExp+=Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(14)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(15)));
	%>
	
	<tr>
		<td><b>Credit line for FC</b></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(12)))+Double.parseDouble(Helper.correctDouble((String)arrGrpexpCol.get(13)))),strAmountValue)%></td>
	
	<% 
	if(arrGrpsecRow!=null && arrGrpsecRow.size()>2)
	{
		for(;k<3;k++)
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
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	<% }}else{%>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<td align="right">&nbsp;</td>
	<% }%>
	</tr>
	
	
	<% int SecSize=arrGrpsecRow.size();
	if(SecSize>3){
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
	<td>&nbsp;</td>
	<td align="left"><%=(String)arrGrpsecCol.get(0)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(1))))),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Double.parseDouble(Helper.correctDouble((String)arrGrpsecCol.get(3))))),strAmountValue)%></td>
	</tr>
	<%}}%>
	
	
<!--  Securities --> 
	
	<tr >
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subExpExitotal)),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subTotalexp)),strAmountValue)%></td>
	<td align="left">Sub total</td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subSecExitot)),strAmountValue)%></td>
	<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(subSectot)),strAmountValue)%></td>
	</tr>
	<%}}}
	}%>
<tr >
<td><b>Total</b></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(ExpExitot)),strAmountValue)%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(totalExp)),strAmountValue)%></td>
<td><strong>Total</strong></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(SecExitot)),strAmountValue)%></td>
<td align="right"><%=Helper.converAmount(Helper.correctNull(nft.format(Sectot)),strAmountValue)%></td>
</tr>
<tr>
	<td colspan="3">&nbsp;</td>
	<%double dblExiscove=0.00,dblExisprop=0.00,dblFincove=0.00;
	if(ExpExitot>0)
	{
		dblExiscove=(SecExitot/ExpExitot)*100;
	}
	if(totalExp>0)
		dblExisprop=(SecProtot/totalExp)*100;
	if(totalExp>0)
		dblFincove=(Sectot/totalExp)*100;
	%>
<td><b>Coverage(%)</b></td>
<td align="right"><%=nft.format(dblExiscove) %></td>
<td align="right"><%=nft.format(dblFincove) %></td>
</tr>
</table></div>
	</td>
</tr>
<%}else if(strAppSecurity.equalsIgnoreCase("M")){ %>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("COMSEC_APPCOMMENTS"))%></td>
</tr>
<%} %>
<%
	String year1 = Helper.correctNull((String) hshFinlValues
			.get("txt_year1"));
		if (!(Helper.correctNull((String) hshValues
				.get("com_commentssecoverage1"))).equalsIgnoreCase("")) {
%>

<tr><td><%=Helper.correctNull((String) hshValues
									.get("com_commentssecoverage1"))%></td></tr>
<%
	}%>
	<tr class="title">
		<td>Analysis of Movement of Security Coverage (excluding Stock & Book Debts) and Analysis of Movement of Credit Exposure against the Networth for last 5 years</td>
	</tr>
	<tr class="title"><td align="right"><%=strAmtValueIn %>&nbsp;</td></tr>	
	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0" cellpadding="4"	align="center">
			<tr class="title">
				<td width="20%" align="center">Year</td>
				<td width="20%" align="center">Total Exposure</td>
				<td width="20%" align="center">Security Coverage (%)</td>
				<td width="20%" align="center">Networth of the Borrower</td>
				<td width="20%" align="center"> (Exposure/NW)(Times)</td>
			</tr>
			<%if(arrSecMovement!=null && arrSecMovement.size()>0){
			for(int i=0;i<arrSecMovement.size();i++){
				arrCol=(ArrayList)arrSecMovement.get(i);%>
			<tr>
			<td><%=Helper.correctNull((String)arrCol.get(0)) %> - <%=Helper.correctNull((String)arrCol.get(1)) %></td>
			<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)))),strAmountvalue) %></td>
			<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))%></td>
			<td align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)))),strAmountvalue) %></td>
			<td align="right"><%=nft.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)))) %></td>
			</tr>
			
			<%}}else{ %>
			<tr>
			<td colspan="5"><%=strNil %></td>
			</tr>
			<%} %>
		</table>
		</div>
		</td>
		</tr>	
		
		<%if (!year1.equalsIgnoreCase("")) {
%>

<tr><td><br>The details of the existing credit facilities and the securities available are enclosed in annexure III.</td></tr>
<tr>
	<td>
		<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
			<tr>
				<td class="title" valign="top"><br>IV &nbsp;Financial & Business Performance :</td>
			</tr>
		</table>
	</td>
</tr>
<tr><td>Detailed Analysis of the financial statements of last 3 years is furnished in  annexure IV.
The brief financial indicators are highlighted below :</td></tr>



<tr>
<td><%=Helper.correctNull((String) hshValues.get("fin_comments_interfirm")) %></td>
</tr>

<%
	String year2 = Helper.correctNull((String) hshFinlValues
				.get("txt_year2"));
		String year3 = Helper.correctNull((String) hshFinlValues
				.get("txt_year3"));
		String year4 = Helper.correctNull((String) hshFinlValues
				.get("txt_year4"));
		String year5 = Helper.correctNull((String) hshFinlValues
				.get("txt_year5"));
%>
<tr><td align="right"><%=strFinvaluesIn%>&nbsp;</td></tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
				<tr> 
                	<td width="25%">&nbsp;Year</td>
                	<%
                		if (!year1.equalsIgnoreCase("")) {
                	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year1"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year2.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year2"))%>&nbsp;</td>
					<%
						}
					%>                  
                    <%
                                      	if (!year3.equalsIgnoreCase("")) {
                                      %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year3"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year4.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year4"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                  	<%
                  		if (!year5.equalsIgnoreCase("")) {
                  	%>
                  	<td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_year5"))%>&nbsp;</td>
                  	<%
                  		}
                  	%>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Type</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type1"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type2"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type3"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type4"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="center"><%=Helper.correctNull((String) hshFinlValues
									.get("txt_type5"))%>&nbsp;</td>
                  <%
                  	}
                  %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Sales</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
									.correctDouble((String) hshFinlValues
											.get("txt_netsales5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
              
               <%
                             	if (!((Double.parseDouble(Helper
                             				.correctDouble((String) hshFinlValues
                             						.get("FINGRPCONCERN_FREETEXT41"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT42"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT43"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT44"))) == 0) && (Double
                             				.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("FINGRPCONCERN_FREETEXT45"))) == 0))) {
                             %>
               			
               			
               	<tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues
									.get("COM_FREETEXT4"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT41"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT42"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT43"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT44"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft
												.format(Double
														.parseDouble(Helper
																.correctDouble((String) hshFinlValues
																		.get("FINGRPCONCERN_FREETEXT45"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
             <%
                            	}
                            %>
              
               <%
                             	if (!((Double.parseDouble(Helper
                             				.correctDouble((String) hshFinlValues
                             						.get("txt_netprofit1"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit2"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit3"))) == 0)
                             				&& (Double.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit4"))) == 0) && (Double
                             				.parseDouble(Helper
                             						.correctDouble((String) hshFinlValues
                             								.get("txt_netprofit5"))) == 0))) {
                             %>
               		
               	<tr> 
                  <td width="25%">&nbsp;Net Profit</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_netprofit5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               		
               		  <%
               		               		  	if (!((Double.parseDouble(Helper
               		               		  				.correctDouble((String) hshFinlValues
               		               		  						.get("txt_tangnet1"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet2"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet3"))) == 0)
               		               		  				&& (Double.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet4"))) == 0) && (Double
               		               		  				.parseDouble(Helper
               		               		  						.correctDouble((String) hshFinlValues
               		               		  								.get("txt_tangnet5"))) == 0))) {
               		               		  %>
          		
          		   <tr> 
                  <td width="25%">&nbsp;Net Worth</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_tangnet5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
          		
          		<%
          		          			}
          		          		%>	 
              
            
            	
               		  <%
	                                       	               		  	if (!((Double.parseDouble(Helper
	                                       	               		  				.correctDouble((String) hshFinlValues
	                                       	               		  						.get("txt_toltnw1"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw2"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw3"))) == 0)
	                                       	               		  				&& (Double.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw4"))) == 0) && (Double
	                                       	               		  				.parseDouble(Helper
	                                       	               		  						.correctDouble((String) hshFinlValues
	                                       	               		  								.get("txt_toltnw5"))) == 0))) {
	                                       	               		  %>
          		
          		 <tr> 
                  <td width="25%">&nbsp;Debt-Equity Ratio</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_toltnw5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
          		<%
          			}
          		%>
          		
          		
          		  <%
          		          		          		  	if (!((Double.parseDouble(Helper
          		          		          		  				.correctDouble((String) hshFinlValues
          		          		          		  						.get("txt_currratio1"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio2"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio3"))) == 0)
          		          		          		  				&& (Double.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio4"))) == 0) && (Double
          		          		          		  				.parseDouble(Helper
          		          		          		  						.correctDouble((String) hshFinlValues
          		          		          		  								.get("txt_currratio5"))) == 0))) {
          		          		          		  %>
               <tr> 
                  <td width="25%">&nbsp;TOL/TNW</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_currratio5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
               
                <%
                                              	if (!((Double.parseDouble(Helper
                                              				.correctDouble((String) hshFinlValues
                                              						.get("txt_estproturn1"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn2"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn3"))) == 0)
                                              				&& (Double.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn4"))) == 0) && (Double
                                              				.parseDouble(Helper
                                              						.correctDouble((String) hshFinlValues
                                              								.get("txt_estproturn5"))) == 0))) {
                                              %>
          		
          		<tr> 
                  <td width="25%">&nbsp;Current Ratio</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_estproturn5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
          		<%
                         			}
                         		%>
               
               
                  <%
                                                	if (!((Double.parseDouble(Helper
                                                				.correctDouble((String) hshFinlValues
                                                						.get("txt_freetext1"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext2"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext3"))) == 0)
                                                				&& (Double.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext4"))) == 0) && (Double
                                                				.parseDouble(Helper
                                                						.correctDouble((String) hshFinlValues
                                                								.get("txt_freetext5"))) == 0))) {
                                                %>
          		
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt1"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext1"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext2"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext3"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext4"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext5"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
               
                 <%
                                               	if (!((Double.parseDouble(Helper
                                               				.correctDouble((String) hshFinlValues
                                               						.get("txt_freetext11"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext12"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext13"))) == 0)
                                               				&& (Double.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext14"))) == 0) && (Double
                                               				.parseDouble(Helper
                                               						.correctDouble((String) hshFinlValues
                                               								.get("txt_freetext15"))) == 0))) {
                                               %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt2"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext11"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext12"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext13"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext14"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext15"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               
               <%
                              	}
                              %>
               
                <%
                               	if (!((Double.parseDouble(Helper
                               				.correctDouble((String) hshFinlValues
                               						.get("txt_freetext21"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext22"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext23"))) == 0)
                               				&& (Double.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext24"))) == 0) && (Double
                               				.parseDouble(Helper
                               						.correctDouble((String) hshFinlValues
                               								.get("txt_freetext25"))) == 0))) {
                               %>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String) hshFinlValues
									.get("intcompfreetxt_txt3"))%>&nbsp;</td>
                  <%
                  	if (!year1.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext21"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year2.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext22"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year3.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext23"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year4.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext24"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
                  <%
                  	if (!year5.equalsIgnoreCase("")) {
                  %>
                  <td width="15%" align="right"><%=nft.format(Double.parseDouble(Helper
										.correctDouble((String) hshFinlValues
												.get("txt_freetext25"))))%>&nbsp;</td>
                  <%
                  	}
                  %>
               </tr>
               <%
               	}
               %>
			</table>
		</div>
	</td>
</tr>

<tr>
<td><%=Helper.correctNull((String) hshValues.get("fin_comments_interfirm1")) %></td>
</tr>



<%
	}
		
		if (vecsize != 0 && vec != null) {
			 %>
			<tr>
				<td>
					<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
						<tr>
							<td class="title"><br>&nbsp;Compliance to loan policy:</td>
						</tr>
						<tr>
						<td>The bank has stipulated the following benchmarks in order to limit the magnitude of credit risks:</td>
						</tr>
						<tr>
							<td align="right" width=""><%=strFinvaluesIn%></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<div id="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
						   	<tr >
								<td width="10%" align="center"><b>Particulars</b></td>
								<td width="10%" align="center"><b>BenchMark Value</b></td>
								<td width="10%" align="center"><b>Current Value</b></td>
								<td width="10%" align="center"><b>Remarks</b></td>
							</tr>
							 <%
							 	for (int l = 0; l < vecsize; l++) {
							 			if (l < vecsize) {
							 				g2 = (ArrayList) vec.get(l);
							 %>
			                     <tr> 
			                       <td align="left" nowrap width="30%">&nbsp;<%=Helper.correctNull((String) g2.get(2))%></td>
			                       <td align="center" nowrap width="20%"><%=Helper.correctNull((String) g2.get(3))%></td>
			                       <td align="right" nowrap width="20%"><%=Helper
															.correctNull((String) g2
																	.get(5))%></td>
			                       <td align="left" width="30%"><%=Helper.correctNull((String) g2.get(6))%></td>
			                     </tr>
			                 <%
			                 	}
			                 		}
			                 %>
						</table>
					</div>
				</td>
			</tr>
			<%if(!Helper.correctNull((String) hshValues.get("fin_benchmarkcmts")).equalsIgnoreCase("")) {%>
			<tr><td class="title">Comments:</td></tr>
			<tr><td><%=Helper.correctNull((String) hshValues.get("fin_benchmarkcmts")) %></td></tr>
			 <%
			}}	
%>
<tr><td class="title"><br>V &nbsp;Transactions in the existing accounts :</td></tr>


<tr>
<td>
<table width="98%" align="center" cellpadding="3" cellspacing="0" border="0" >
<tr>
<td class="title">1.	Compliance to Sanctioned Terms and Conditions</td></tr>
<%if(!Helper.correctNull((String)hshValues.get("cesComments")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("cesComments")) %>&nbsp;</td></tr>
<%}else{ %>
<tr><td><%=strNil %>&nbsp;</td></tr>
<%} %>
<tr>
<td class="title">2.	Inspection Comments (Both Internal & Reserve Bank of India) and Compliance</td></tr>
<%if(!Helper.correctNull((String)hshValues.get("IPOASCMDPROCESSNOTE")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("IPOASCMDPROCESSNOTE")) %>&nbsp;</td></tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("RBIPOCMDPROCESSNOTE")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("RBIPOCMDPROCESSNOTE")) %>&nbsp;</td></tr>
<%}
if(Helper.correctNull((String)hshValues.get("IPOASCMDPROCESSNOTE")).equalsIgnoreCase("") && Helper.correctNull((String)hshValues.get("RBIPOCMDPROCESSNOTE")).equalsIgnoreCase("")){%>
<tr><td><%=strNil %>&nbsp;</td></tr>
<%} %>
<tr>
<td class="title">3.	Stock & Credit Audit and Compliance</td></tr>
<%if(!Helper.correctNull((String)hshValues.get("STAURCMDPROCESSNOTE")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("STAURCMDPROCESSNOTE")) %>&nbsp;</td></tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("CRAURCMDPROCESSNOTE")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("CRAURCMDPROCESSNOTE")) %>&nbsp;</td></tr>
<%}
if(Helper.correctNull((String)hshValues.get("STAURCMDPROCESSNOTE")).equalsIgnoreCase("") && Helper.correctNull((String)hshValues.get("CRAURCMDPROCESSNOTE")).equalsIgnoreCase("")){%>
<tr><td><%=strNil %>&nbsp;</td></tr>
<%} %>
<tr>
<td class="title">4.	Conduct of the account: (How many times (in days), the account was in S1/S2/S3/NPA/Irregular Status/Regular Status etc) </td></tr>
<%if(!Helper.correctNull((String)hshValues.get("strConductOffAcccmts")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("strConductOffAcccmts")) %>&nbsp;</td></tr>
<%}else{ %>
<tr><td><%=strNil %>&nbsp;</td></tr>
<%} %>
<tr>
<td class="title">5.	Comment on Customer Profitability (FTP) and RAROC (Risk Adjusted Return on Capital - Data provided by Risk Management Department) </td></tr>
<tr>			
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
<tr>
<td>
<div id="top">
<table  width="95%" align="center" cellpadding="3" cellspacing="0" border="1">
<tr align="center" class="title">
<td width="5%">Sl.No &nbsp;</td>
<td width="15%">Particulars &nbsp;</td>
<td width="25%">FTP - Profit/(Loss) &nbsp;</td>
<td width="25%">FTP Yield (%) &nbsp;</td>
<td width="25%">RAROC &nbsp;</td>
</tr>
<%if(arrProfitability!=null &&  arrProfitability.size()>0){
	for(int c=0;c<arrProfitability.size();c++){
	arrCol=(ArrayList)arrProfitability.get(c);
%>
<tr>
<td><%=c+1 %>&nbsp;</td>
<td><%=Helper.correctNull((String)arrCol.get(0)) %> - <%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(2)),strAmountvalue) %>&nbsp;</td>
<td align="right"><%=Helper.correctDouble((String)arrCol.get(3)) %>&nbsp;</td>
<td align="right"><%=Helper.correctDouble((String)arrCol.get(4)) %>&nbsp;</td>
</tr>
<%}}else{ %>
<tr>
<td colspan="5" align="center"><%=strNil %>&nbsp;</td>
</tr>
<%} %>
</table>
</div>
</td>
</tr>

<tr>
<td class="title">The breakup of FTP for the period (Latest available) is as under:</td>
</tr>
<tr>			
	<td align="right" width=""><%=strAmtValueIn%></td>
</tr>
<tr>
<td>
<div id="top">
<table  width="50%" cellpadding="3" cellspacing="0" border="0">
<tr align="center" class="title">
<td width="30%">Description &nbsp;</td>
<td width="20%">Amount &nbsp;</td>
</tr>
<tr>
<td>Asset Margin &nbsp;</td>
<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strFTPAmtAM")),strAmountvalue) %>&nbsp;</td>
</tr>
<tr>
<td>Liability Margin &nbsp;</td>
<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strFTPAmtLM")),strAmountvalue) %>&nbsp;</td>
</tr>
<tr>
<td>Other Income &nbsp;</td>
<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strFTPAmtOI")),strAmountvalue) %>&nbsp;</td>
</tr>
<tr>
<td>Other Expenditure &nbsp;</td>
<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strFTPAmtOE")),strAmountvalue) %>&nbsp;</td>
</tr>
<tr>
<td>Total &nbsp;</td>
<td  align="right"><%=Helper.converAmount(nft.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strFTPAmtAM")))+Double.parseDouble(Helper.correctDouble((String)hshValues.get("strFTPAmtLM")))
		+Double.parseDouble(Helper.correctDouble((String)hshValues.get("strFTPAmtOI")))+Double.parseDouble(Helper.correctDouble((String)hshValues.get("strFTPAmtOE")))),strAmountvalue) %>&nbsp;</td>
</tr>
</table>
</div>
</td>
</tr>

<%if(!Helper.correctNull((String)hshValues.get("strFTPcmts")).equalsIgnoreCase("")){ %>
<tr><td><%=Helper.correctNull((String)hshValues.get("strFTPcmts")) %>&nbsp;</td></tr>
<%} %>
<tr><td>The conduct of the accounts along with the audit observations are furnished in annexure IV.</td></tr>