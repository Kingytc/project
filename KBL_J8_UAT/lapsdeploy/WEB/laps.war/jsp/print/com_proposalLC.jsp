<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
String strOrgLevel=(String)session.getAttribute("strOrgLevel");
String str_arry="";
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
ArrayList arrFacRow = new ArrayList();
ArrayList arrRecommRow = new ArrayList();
ArrayList arrRowNonBr = new ArrayList();
ArrayList arrColNonBr = new ArrayList();
ArrayList arrDeleRow = new ArrayList();
ArrayList arrBAOurRow = new ArrayList();
ArrayList arrFACexistingRow = new ArrayList();
ArrayList arrFAConlyRow = new ArrayList();
ArrayList arrMCLRRow = new ArrayList();
ArrayList arrRowtemp= new ArrayList();
ArrayList arrColtemp= new ArrayList();
ArrayList arrFacilityTerm0 =  new ArrayList();
ArrayList arrFacilityIdVal0 =  new ArrayList();
ArrayList arrParentID0 =  new ArrayList();
ArrayList arrFacilityTermApp0 =  new ArrayList();
ArrayList arrCol12 = new ArrayList();
ArrayList arrRow12 = new ArrayList();
ArrayList arrOutCol1	= new ArrayList();
ArrayList arrOutRow1= new ArrayList();

ArrayList arrRowprop= new ArrayList();
ArrayList arrColprop= new ArrayList();
ArrayList arrRowcgssd= new ArrayList();
ArrayList arrColcgssd= new ArrayList();
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow = (ArrayList)hshValues.get("arrRow");
	arrFacRow = (ArrayList)hshValues.get("arrFacRow");
	arrRecommRow = (ArrayList)hshValues.get("arrRecommRow");
	arrRowNonBr	= (ArrayList)hshValues.get("arrRowNonBr");
	arrDeleRow = (ArrayList)hshValues.get("arrDeleRow");
	arrBAOurRow	= (ArrayList)hshValues.get("arrBAOurRow");
	arrFACexistingRow = (ArrayList)hshValues.get("arrFACexistingRow");
	arrFAConlyRow = (ArrayList)hshValues.get("arrFAConlyRow");
	arrMCLRRow = (ArrayList) hshValues.get("arrMCLR");
	arrFacilityTerm0 = (ArrayList)hshValues.get("arrFacilityTerm0");
      arrFacilityIdVal0 = (ArrayList)hshValues.get("arrFacilityIdVal0");
	 arrParentID0 = (ArrayList)hshValues.get("arrParentID0");
	arrFacilityTermApp0 = (ArrayList)hshValues.get("arrFacilityTermApp0");
	arrRow12 = (ArrayList) hshValues.get("arrRow2");
	arrOutRow1	= (ArrayList) hshValues.get("arrOutRow2");
	str_arry = Helper.correctNull((String) hshValues.get("str_arr"));
	arrRowprop= (ArrayList)hshValues.get("arrRowprop");
	arrRowcgssd= (ArrayList)hshValues.get("arrRowcgssd");
	
}
ArrayList arrMISRow = (ArrayList) hshValues.get("arrMISRow");
ArrayList arrColMIS = new ArrayList();
String strOutstandingDate=Helper.correctNull((String)hshValues.get("strOutstandingDate"));
String strWhetherBRAvail = Helper.correctNull((String)hshValues.get("strWhetherBRAvail"));
String strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));
String strTLValIn="",strValuesIn="",strNil="Nil",strPreWC="",strExiWC="";
String strAmountValue=Helper.correctNull((String)hshValues.get("com_amountvalue"));
String strAmtValueIn=Helper.correctNull((String)hshValues.get("strAmtValueIn"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
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

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
String strFinValuesIn=Helper.correctNull((String)hshValues.get("strFinvalues"));
if(strFinValuesIn.equalsIgnoreCase("C")){
	strFinValuesIn="( Rs. in Crore )";
}else if(strFinValuesIn.equalsIgnoreCase("L")){
	strFinValuesIn="( Rs. in Lacs )";
}else{
	strFinValuesIn="( Amount in Rs. )";
}
String StrverCFR=Helper.correctNull((String)hshValues.get("COM_CFR_VERIFIED"));
String StrNameCFR=Helper.correctNull((String)hshValues.get("COM_CFR_BORNAME"));
String strStatus=Helper.correctNull((String)hshValues.get("STATUS_VERIFIED"));
String strratingperc=Helper.correctNull((String)hshValues.get("COM_CGSSDPERC"));
String strval=Helper.correctNull((String)hshValues.get("com_amountvalue"));
String strDesc[] = { "Capital of the entity", "Promoters Stake",
		"Eligible Amount", "Amount Applied", "Liability of the entity",
		"Maximum loan under the scheme","Recommended (lower of 3,4,5,6)",
		"Entity Name","Operative account number where the borrower is a promoter","Status of the entity","NPA Date"};
String strmisDesc[] = { "Facility Desc", "Type of Facility and Facility Serial Number",
		"Activity Code", "Main Activity", "Sub Activity",
		"Agriculture/Industry/Service Category type","Sector",
		"Sub sector","Sensitive sector",
		"StandUp India","Government announced scheme","Guarantee Cover By",
		"Guarantee Covered Amount","Sales Turnover of the Applicant",
		"Sales Turnover As on Date",
		"Criteria for Sales Turnover","Investment in Plant & Machineries/Equipments","Industry Name",
		"Investment value as on Date","Criteria for Investment value","Weaker Section","Whether Start up as per definition of Ministry of Commerce and Industry"
		};
%>

<html>
<head>
<title>Proposal For LC/BG</title>
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
<body contentEditable="false" designMode="on">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr><td align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td class="title" align="center"><br>PROPOSAL FORMAT FOR LC/ BG AGAINST 100% CASH MARGIN</td>
</tr>
<tr>
<td align="right" width="50%"><b>Proposal Number&nbsp;:&nbsp;</b><%=Helper.correctNull((String)request.getParameter("appno"))%></td>
</tr>
<!-- APPLICANT'S PROFILE -->

	<jsp:include page="../print/com_AnnexureII.jsp" flush="true">
	<jsp:param name="pageVal" value="PROPOSALLC"/>
	</jsp:include>

<!-- END -->


	<td>
		<table width="94%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="50%" class="title">Brief background of the applicant:</td>
			<td width="50%" align="right">&nbsp;</td>
		</tr>
		<tr>
			<td width="50%" class="title"><br>Details of the existing Credit facilities:</td>
			<td width="50%" align="right">&nbsp;</td>
		</tr>
		<% if(arrBAOurRow!=null&&arrBAOurRow.size()>0){ %>
		<tr>
			<td width="50%">&nbsp;</td>
			<td width="50%" align="right"><%=strAmtValueIn%></td>
		</tr>
		<%} %>
		</table>
	</td>
</tr>

<tr>
	<td>
		<div id="top">
		<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
		if(arrBAOurRow!=null&&arrBAOurRow.size()>0){ %>
		<tr>
			<td width="3%" align="center"><b>S.No</b></td>
			<td width="17%" align="center"><b>Nature of facility</b></td>
			<td width="10%" align="center"><b>Limit</b></td>
			<td width="10%" align="center"><b>Purpose</b></td>
			<td width="10%" align="center"><b>Sanction Ref. & Date</b></td>
			<td width="10%" align="center"><b>ROI/ Com %</b></td>
			<td width="10%" align="center"><b>Balance as on <%=strOutstandingDate%></b></td>
			<td width="10%" align="center"><b>Due Date</b></td>
			<td width="10%" align="center"><b>Arrears if any</b></td>
		</tr>
		<%
		double dbLimitTotal=0.00,dbbalanceTotal=0.00;
		for(int i=0;i<arrBAOurRow.size();i++){
			arrCol	= (ArrayList)arrBAOurRow.get(i);
			dbLimitTotal=dbLimitTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(2)));
			dbbalanceTotal=dbbalanceTotal+Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));	
		%>
		<tr>
			<td align="left"><%=i+1%></td>
			<td align="left"><%=Helper.changetoTitlecase(Helper.correctNull((String)arrCol.get(0))).toUpperCase()%></td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;-&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
			<td align="right"><%=Helper.correctNull((String)arrCol.get(11))%>&nbsp;+&nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>% p.a presently at &nbsp;<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))%>% p.a</td>
			<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
			<td align="center"><%=Helper.correctNull((String)arrCol.get(8))%></td>
			<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
		</tr>
		<%} %>
		<tr>
			<td colspan="2" align="right"><b>Total</b></td>
			<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbLimitTotal)),strAmountValue)%></b></td>
			<td colspan="3">&nbsp;</td>
			<td style="text-align: right"><b><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(dbbalanceTotal)),strAmountValue)%></b></td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<%}else{%>
		<tr><td style="border: none;"><%=strNil%></td></tr>
		<%} %>
		</table>
		</div>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(arrBAOurRow!=null && arrBAOurRow.size()>0){ %>
<tr>
<td width="3%" align="center"><b>S.No</b></td>
<td width="17%" align="center"><b>Nature of facility</b></td>
<td width="10%" align="center"><b>Remarks</b></td>
</tr>
<%
for(int i=0;i<arrBAOurRow.size();i++){
	arrCol	= (ArrayList)arrBAOurRow.get(i); %>
<tr>
<td align="left"><%=i+1%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
<td align="left"><%=Helper.correctNull((String)arrCol.get(14))%></td>
</tr>
<%}} %>
</table>
</div>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<%
ArrayList arrpropsecurityRow=new ArrayList();
ArrayList arrpropsecCollRow=new ArrayList();
arrpropsecurityRow=(ArrayList)hshValues.get("arrExistingSecfacwise");
arrpropsecCollRow=(ArrayList)hshValues.get("arrcollateralforEF");
if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td width="50%" class="title"><br>Details of securities for the existing credit facilities:</td>
			<td width="50%" align="right">&nbsp;</td>
		</tr>
		<tr>
			<td width="50%">&nbsp;</td>
			<td width="50%" align="right"><%=strAmtValueIn%></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
	
	<tr>
		<td colspan="4"><b>Prime :</b></td>
	</tr>
	<tr>
		<td  align="center"><b>Facility</b></td>
		<td  align="center"><b>Details of Security</b></td>
		<td  align="center"><b>Value <%=strAmtValueIn%></b></td>
		<td  align="center"><b>Date of Valuation</b></td>
	</tr>
	
	<% 
	String secValue="";
	ArrayList arrpropsecurityCol=new ArrayList();
	ArrayList arrpropsecurity=new ArrayList();
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
			 <td  rowspan="<%=(arrpropsecurityCol.size())%>"> <%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
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
	<%if((arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){  
	ArrayList arrpropsecurityCol=new ArrayList();
	ArrayList arrpropsecurity=new ArrayList();
	if(arrpropsecCollRow!=null && arrpropsecCollRow.size()>0){
		for(int i=0;i<arrpropsecCollRow.size();i++)
		{
			arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(i);
			 if(i==0){%>
			 <tr>
			 <td colspan="4"><b>Collateral : </b></td>
			 </tr>
			 <%} %>
			<tr>
				<td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
				<td  align="right"><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1))))),strAmountValue)%></td>
				<td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
			</tr>		
		<%}
	} }
	%>
	</table>
	</div><br>
	</td>
</tr>
<%} %>



<tr>
	<td>
		<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
		<tr>
			<td><br><b>Asset classification :</b>&nbsp;<%=Helper.correctNull((String)hshValues.get("strAssetClassification"))%>
			&nbsp;as on &nbsp;<%=Helper.correctNull((String)hshValues.get("com_asscladate"))%>
			</td>
		</tr>
		</table>
	</td>
</tr>

<%  String year1 = Helper.correctNull((String)hshValues.get("txt_year1"));
	String year2 = Helper.correctNull((String)hshValues.get("txt_year2"));
	String year3 = Helper.correctNull((String)hshValues.get("txt_year3"));
	String year4 = Helper.correctNull((String)hshValues.get("txt_year4"));
	String year5 = Helper.correctNull((String)hshValues.get("txt_year5"));
	
%>

<%if(!year1.equalsIgnoreCase("")||!year2.equalsIgnoreCase("")||!year3.equalsIgnoreCase("")||!year4.equalsIgnoreCase("")||!year5.equalsIgnoreCase("")) { %>

<tr>
	<td>
		<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
			<tr><td class="title" valign="top"><br>Brief Financials:</td></tr>
			<tr><td align="right"><%=strFinValuesIn%></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">
				<tr> 
                	<td width="25%">&nbsp;Particulars</td>
                	<%if(!year1.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year1"))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year2.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year2"))%>&nbsp;</td>
					<%} %>                  
                    <%if(!year3.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year3"))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year4.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year4"))%>&nbsp;</td>
                  	<%} %>
                  	<%if(!year5.equalsIgnoreCase("")) { %>
                  	<td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_year5"))%>&nbsp;</td>
                  	<%} %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type1"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type2"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type3"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type4"))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="center"><%=Helper.correctNull((String)hshValues.get("txt_type5"))%>&nbsp;</td>
                  <%} %>
                </tr>
                <tr> 
                  <td width="25%">&nbsp;Sales</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netsales5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
              
               <%
               
               if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT41")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT42")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT43")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT44")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT45")))==0) ) )
               		{%>
               			
               			
               	<tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("COM_FREETEXT4"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT41"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT42"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT43"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT44"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("FINGRPCONCERN_FREETEXT45"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
             <%}%>
              
               <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit5")))==0) ) )
          		{%>
               		
               	<tr> 
                  <td width="25%">&nbsp;Net Profit</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_netprofit5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               		
               		  <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet5")))==0) ) )
          		{%>
          		
          		   <tr> 
                  <td width="25%">&nbsp;Net Worth</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_tangnet5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
          		
          		<%} %>	 
              
            
            	
               	<% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw5")))==0) ) )
          		{%>
          		
          		 <tr> 
                  <td width="25%">&nbsp;Debt-Equity Ratio</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_toltnw5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
          		<%} %>
          		
          		
          		  <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio5")))==0) ) )
          		{%>
               <tr> 
                  <td width="25%">&nbsp;TOL/TNW</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_currratio5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               
               
                <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn5")))==0) ) )
          		{%>
          		
          		<tr> 
                  <td width="25%">&nbsp;Current Ratio</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_estproturn5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
          		<%} %>
               
               
                  <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext1")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext2")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext3")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext4")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext5")))==0) ) )
          		{%>
          		
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt1"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext1"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext2"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext3"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext4"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext5"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               
               
                 <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext11")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext12")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext13")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext14")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext15")))==0) ) )
          		{%>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt2"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext11"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext12"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext13"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext14"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext15"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               
               <%} %>
               
                <% if(!((Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext21")))==0) &&
                 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext22")))==0)	&&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext23")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext24")))==0) &&
            	 (Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext25")))==0) ) )
          		{%>
               <tr> 
                  <td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("intcompfreetxt_txt3"))%>&nbsp;</td>
                  <%if(!year1.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext21"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year2.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext22"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year3.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext23"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year4.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext24"))))%>&nbsp;</td>
                  <%} %>
                  <%if(!year5.equalsIgnoreCase("")) { %>
                  <td width="15%" align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("txt_freetext25"))))%>&nbsp;</td>
                  <%} %>
               </tr>
               <%} %>
			</table>
		</div>
	</td>
</tr>
<%} %>
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="title"><br>Present proposal:</td>
		</tr>
		<tr>
			<td><%=Helper.correctNull((String)hshValues.get("presentproposal_comment"))%></td>
		</tr>
		<tr>
			<td align="left" width="50%">&nbsp;</td>
		</tr>
		<tr>
			<td align="right" width="50%"><%=strAmtValueIn%></td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%
			if(arrFACexistingRow!=null&&arrFACexistingRow.size()>0) { 
			
				strExiWC = Helper.correctNull((String)hshValues.get("strExiWClimit")).replace("@","<br>");
			%>
			<tr>
				<td width="30%">Details of existing fund based limits&nbsp;:&nbsp;</td>
				<td align="left" width="">
				<%=strExiWC%>
				</td>
			</tr>
			<%} %>
			<%
			if(arrFAConlyRow!=null&&arrFAConlyRow.size()>0) { 
			
				strPreWC = Helper.correctNull((String)hshValues.get("strPreWClimit")).replace("@","<br>");
			%>
			<tr>
				<td ><br>Details of proposed facilities:</td>
				<td align="left" width="">
				<%=strPreWC%>
				</td>
			</tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>
	<%
if (str_arry.contains("CGSSD@")) {
%>
	<tr>
		<td style="border: none;"  class="title" align="left">&nbsp;&nbsp;&nbsp;&nbsp;Assesment for KBL CGSSD Scheme :</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
	<tr>
	<td>	
	<div id="top">
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
		<%
			int intlength=0;
			
				intlength=(strDesc.length);
				String strstatus="";
			%>
			<tr>
				<td><b>1.<%=strDesc[0] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(0))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
	<tr>
				<td><b>2.<%=strDesc[1] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(1))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>3.<%=strDesc[2] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(2))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>4.<%=strDesc[3] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(3))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>5.<%=strDesc[4] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(4))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>6.<%=strDesc[5] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(5))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>7.<%=strDesc[6] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrColcgssd.get(6))))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>8.<%=strDesc[7] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(7))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>9.<%=strDesc[8] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(8))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b>10.<%=strDesc[9] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
				 strstatus= Helper.correctNull((String)arrColcgssd.get(9));
				if(strstatus.equalsIgnoreCase("S")){
					strstatus="Standard";
				}else if(strstatus.equalsIgnoreCase("N")){
					strstatus="NPA";
				}else{
					strstatus="";
				}
			   %>
			   <td align="right"><%=strstatus%></td>
			   <%} %>
			 </tr>
			 
	        <tr>
				<td><b>11.<%=strDesc[10] %></b><br></td>
				<%for (int m = 0; m < arrRowcgssd.size(); m++) 
				{
				arrColcgssd = (ArrayList) arrRowcgssd.get(m);
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColcgssd.get(10))%></td>
			   <%} %>
			 </tr>
			
	
	</table>
	</div>
	</td>
	</tr>
<%}%>
<tr><td>
<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
<tr>
	<td class="title"><br>Recommendations</td>
</tr>
<tr>
	<td style="text-align: justify;"><br>In light of the above,<b> M/s.&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_name"))%>.,</b> be sanctioned the following facilities on the terms and conditions, 
	mentioned hereunder under sole/ consortium / multiple banking arrangement :
	</td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>NATURE OF FACILITY AND LIMITS:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="25%" align="center">Type of Facility</td>
				<td width="15%" align="center">Type of Limit</td>
				<td width="15%" align="center">Nature of Facility</td>
				<td align="center" colspan="2">Amount</td>
				<td width="27%" align="center">Facility Availing Branch</td>
		</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<%if(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13)))!=0){ %>
			<tr>
				<td align="center" rowspan="3"><%=i + 1%>.</td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(5))%></td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(22))%></td>
				<td>Loan Sanction Amount</td>
				<%if(!Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))-Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(13)))),strAmountValue)%></td>
				<%}else{ %>
				<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))),strAmountValue)%></td>
				<%} %>
				<td align="left" rowspan="3"><%=Helper.correctNull((String) arrCol.get(14))%></td>	
				</tr>
				<tr>
					<td><%=Helper.correctNull((String) arrCol.get(15))%></td>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(13)))),strAmountValue)%></td>
				</tr>
				<tr class="title">
					<td>Total Loan Sanction Limit</td>
					<td align="right"><%=Helper.converAmount(jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)))),strAmountValue)%></td>
				<%}else{ %>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(22))%></td>
				<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%><br/>Without any insurance coverage.</td>
			    <td align="left"><%=Helper.correctNull((String)arrCol.get(14))%></td>
			<%} %>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
		<div id="top">
		<br></br>
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% int w=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0){
				boolean bflag=false;
			
			for(int i=0;i<arrRecommRow.size();i++)
			{
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					if(Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("SF"))
						bflag=true;
				}
			}
		%>
			 <%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					if(!Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("NC") && !Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("")){
					w++;
			%>
			<%if(w==1) {%>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="20%" align="center">Type of Facility</td>
				<td width="15%"align="center">Insurance Covered Under</td>
				<td width="7%" align="center" >Premium Tenor<br>(in Months)</td>
				<td width="10%" align="center">Loan amount covered under the scheme</td>
				<%if(bflag){ %>
				<td width="10%" align="center">Premium Amount</td>
				<td width="10%" align="center">Operative account number from which<br> premium account will be debited </td>
				<td width="10%" align="center">Company Name </td>
				<%} %>
			 </tr>
			 <%} %>
		
			<tr>
				<td align="center"><%=w%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				
				<td align="left"><%=Helper.correctNull((String) arrCol.get(15))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(17))%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(18))))),strAmountValue)%></td>
				<%if(Helper.correctNull((String) arrCol.get(16)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(19))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(21))%></td>
				<%}else if(bflag){ %>
				<td align="right" colspan="3">&nbsp;</td>
				<%} %>
				
		   	</tr>
			<%}} }%>
			
	 <%} %>
	 </table>
	 </div>
	 </td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>RATE OF INTEREST/ COMMISSION:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0 && strWhetherBRAvail.equalsIgnoreCase("Y")){ 
				int j=0; %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="30%" align="center">Rate of Interest/Commission</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS")){
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
			</tr>
			<%} }} else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			
			</table>
		</div>
	</td>
</tr>

<%if(arrRowNonBr!=null){
	if(arrRowNonBr.size()>0)
	{
		for(int k=0;k<arrRowNonBr.size();k++)
		{
			arrColNonBr=(ArrayList)arrRowNonBr.get(k);
			if(arrColNonBr.size()>0)
			{
			%>
			 <tr>
				<td>
					<div id="top">
						<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
							<tr><td><b><%=Helper.correctNull((String)arrColNonBr.get(0))%></b></td></tr>
							<tr><td><%=Helper.correctNull((String)arrColNonBr.get(1))%></td></tr>
						</table>
					</div>
				</td>
			</tr>	 
			<%	
			}
		}
	}
}
%>
<%if(arrMCLRRow!=null && arrMCLRRow.size()>0){ %>
				<tr>
				<td>
				<div id="top">
						<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
						<tr>
						<td>
				<%for(int k=0;k<arrMCLRRow.size();k++)
				{ %>
				<%=Helper.correctNull((String)arrMCLRRow.get(k))%><br/>
				<%} %>
				</td>
				</tr>
				</table>
				</div>
				</td>
				</tr>
				<%} %>

<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MARGIN:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="30%" align="center">Margin</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%><br/>
				<%if(!Helper.correctNull((String) arrCol.get(25)).equalsIgnoreCase("")){ %>Relaxation in margin as per RBI COVID relief Package Policy : <%=Helper.correctNull((String) arrCol.get(25))%><%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(23)).equalsIgnoreCase("")){ %>Actual Margin(%) :<%=Helper.correctNull((String) arrCol.get(23)) %> <%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(24)).equalsIgnoreCase("")){ %>Relaxed Margin(%):<%=Helper.correctNull((String) arrCol.get(24)) %> <%} %></td>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>PERIOD:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="15%" align="center">Tenor <br>(in Months)</td>
				<td width="15%" align="center">Initial Holiday/ Gestation/ Moratorium Period <br>(in Months)</td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="right"><%=Helper.correctInt((String)arrCol.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(11))%></td>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MODE OF REPAYMENT:</td>
			</tr>
			<tr>
				<td align="right" width=""><%=strAmtValueIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(arrRecommRow!=null&&arrRecommRow.size()>0){ %>
			<tr>
				<td width="3%" align="center">Sl.No</td>
				<td width="47%" align="center">Type of Facility</td>
				<td width="20%" align="center">Limit</td>
				<td width="30%" align="center">Mode of Repayment</td>
			</tr>
			
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

	<tr><td>&nbsp;</td></tr>
	<tr><td><b>REPAYMENT SCHEDULE COMMENTS:</b></td></tr>
	<tr>
		<td>&nbsp;
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
	<%
				if (arrOutRow1 != null && arrOutRow1.size() > 0 )
				{
					for (int i = 0; i < arrOutRow1.size(); i++) 
					{
						arrOutCol1 = (ArrayList) arrOutRow1.get(i);
			%>
				<tr>
					<td align="left" width="20%"  class="title">&nbsp;<u><%=Helper.correctNull((String) arrOutCol1.get(0))%>-<%=Helper.correctNull((String) arrOutCol1.get(1))%> :</u></td></tr>
				<tr><td align="left" width="50%"><%=Helper.correctNull((String) arrOutCol1.get(2))%></td></tr>
	            <%String StrStageWiseRelease=Helper.correctNull((String) arrOutCol1.get(3));
										if(StrStageWiseRelease.equalsIgnoreCase("Y")){
											StrStageWiseRelease="Yes";
										}else if(StrStageWiseRelease.equalsIgnoreCase("N")){
											StrStageWiseRelease="No";
										}else{
											StrStageWiseRelease="";
										}%>
										<% if(!StrStageWiseRelease.equalsIgnoreCase("")){%>
									<tr><td><b>Stage Wise Release Of Loan &nbsp;<b>:</b>&nbsp;&nbsp;&nbsp;</b><%=StrStageWiseRelease%></td></tr>
									<%}
		}
			}else{		
	%>
	<tr><td align="center">&nbsp;Nil</td></tr>
	<%} %>
			</table>
		</td>
	</tr>


<tr>
<%if(strSessionModuleType=="DIGI"){ %>
	<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> (Inclusive of all Taxes)</td>
<%}else {%>
	<td><br>Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> + Applicable Taxes</td>
<%} %>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>

<tr>
		<td>
		<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
				<%if(StrverCFR.equalsIgnoreCase("Y")) {%>
				<tr>
					<td colspan="2" class="title">CFR Verification Details</td>
				</tr>
				<tr>
					<td width="40%">Verification done at Central Fraud Registry Database</td>
					<td width="60%">&nbsp;<b>Yes</b></td>
				</tr>
				<tr>
					<td width="40%">Applicant/Co-applicant/Guarantor/<br>Proprietor/Partner name appears in CFR List</td>
					<td width="60%">&nbsp;<b><%if(StrNameCFR.equalsIgnoreCase("Y")){ %>Yes<%}else{ %>No<%} %></b></td>
				</tr>
				<%
				}if(StrNameCFR.equalsIgnoreCase("Y")) {%>	
				<tr>
					<td width="40%">CFR Deviation Reference Number</td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("COM_CFR_DEV_RENFO"))%></b></td>
				</tr>
				<%}
				if(strStatus.equalsIgnoreCase("A")||strStatus.equalsIgnoreCase("R")) { %>	
				<tr>
					<td width="40%">Deviation approval Status</td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strStatusVer"))%></b></td>
				</tr>
				<tr>
					<td width="40%"><%if(strStatus.equalsIgnoreCase("A")){ %>CFR Deviation Approved By<%}else{ %>CFR Deviation Rejected By<%} %></td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("appuserid"))%></b></td>
				</tr>
				<tr>
					<td width="40%"><%if(strStatus.equalsIgnoreCase("A")){ %>Approved Date<%}else{ %>Rejected Date<%} %></td>
					<td width="60%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("LOAN_APPR_DATE"))%></b></td>
				</tr>
					<%} %>	
						
			</table>
		</div></td>
		</tr>
		
		<tr>
								<td><span title="pagebreak" contentEditable="TRUE"
									onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<tr>
										<td class="title"><br>
										MIS Classification</td>
									</tr>
									<tr>
										<td align="right" width=""><%=strAmtValueIn%></td>
									</tr>
								</table>
								</td>
							</tr>
							<%
										if (arrMISRow != null && arrMISRow.size() > 0) {
											
											int lensize=0;
									%>
									<%for(int i=0;i<arrMISRow.size();i++) {
										
										if(lensize < 4){
											
										arrColtemp.add(i);
										lensize++;
										
										}else{
											arrRowtemp.add(arrColtemp);
											arrColtemp= new ArrayList();
											lensize=0;
											arrColtemp.add(i);
											lensize++;
										}
										
									}
									arrRowtemp.add(arrColtemp);
									}%>
									<%
										if (arrMISRow != null && arrMISRow.size() > 0) {
											arrColtemp= new ArrayList();
											for(int k=0;k<arrRowtemp.size();k++){
												arrColtemp=(ArrayList)arrRowtemp.get(k);
											
									%>
									<tr>
								<td>
								<div id="top"><span title="pagebreak"
									contentEditable="TRUE" onPaste="event.returnValue=false"
									onKeyDown="callKeyDown()"></span>
								<table width="100%" align="center" cellpadding="3"
									cellspacing="0" border="0">
									<%
			int intlength=0;
			String val="";						
				intlength=(strmisDesc.length);
				String strstatus="",strrestruc="";
			%>
		
			
	<tr>
				<td><b><%=strmisDesc[1] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(21))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[2] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(3))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[3] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.changetoTitlecase((String)arrColMIS.get(1))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[4] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.changetoTitlecase((String)arrColMIS.get(2))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[5] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(18))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[6] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(4))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[7] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(5))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[8] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(6))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[20] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(22))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[9] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(7))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[10] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(8))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[11] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(9))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[12] %></b><br></td>
				<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(11)))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[13] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(13)))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[14] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(14))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[15] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(15))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[16] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrColMIS.get(16)))),strAmountValue)%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[17] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(17))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[18] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(19))%></td>
			   <%} %>
			 </tr>
			  <tr>
				<td><b><%=strmisDesc[19] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(20))%></td>
			   <%} %>
			 </tr>
			  <%if(Helper.correctNull((String)arrColMIS.get(24)).equalsIgnoreCase("Y")){%>
			 <tr>
				<td><b><%=strmisDesc[21] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=Helper.correctNull((String)arrColMIS.get(23))%></td>
			   <%}} %>
			 </tr>
				</table>
								</div>
								</td>
							</tr>					<%
										}
											}
										else {
									%>
									<tr>
										<td align="left" style="border: none;"><%=strNil%></td>
									</tr>
									<%
										}
									%>
		<tr>
			<td>&nbsp;</td>
		<tr>
		<tr>
			<td><b> Hunter Details:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"
				cellspacing="0" class="outertable">

				<tr class="tblhead">
					<td align="center" width="30%">S.No</td>
					<td align="center" width="30%">Name</td>
					<td align="center" width="30%">Hunter Score</td>
				</tr>

            <%
				if (arrRow12 != null && arrRow12.size() > 0 )
				{
					for (int m = 0; m < arrRow12.size(); m++) 
					{
						arrCol12 = (ArrayList) arrRow12.get(m);
			%>
				
				<tr align="center" style="border-left: 1px;">

					<td><%=m+1%></td>
					<td><%=Helper.correctNull((String)arrCol12.get(2))%></td>
					<td><%=Helper.correctNull((String)arrCol12.get(1))%></td>
				</tr>
				<%}}else{
				
				%>
	              <tr><td align="center">&nbsp;Nil</td></tr>
	         <%} %>

			</table>
			</div>
			</td>
		</tr>
		<br>
		<tr>
	<td>
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="1">
	<tbody>
	<tr>
			
			<td>Interest Deviation Ref No</td>
			<td><%=Helper.correctNull((String)hshValues.get("com_interest_refno"))%></td>
		</tr>
		<tr>
			<td>Permission Proposal No</td>
			<td><%=Helper.correctNull((String)hshValues.get("APP_PERM_NO"))%></td>
		</tr>
		</table>
		</td>
		</tr>
<tr><td>&nbsp;</td></tr>
<tr>
<td>
<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<%ArrayList vecNcgtcRow=new ArrayList();
	ArrayList vecNcgtcCol=new ArrayList();
	vecNcgtcRow=(ArrayList)hshValues.get("vecNcgtcRow");
	if(vecNcgtcRow!=null){	vecNcgtcCol=new ArrayList();
				int intncgtcSize = 0;
				intncgtcSize = vecNcgtcRow.size();;%>
				<tr><td colspan="3"><b>KBL Aarogya NCGTC Details</b></td></tr>
				<%for(int s=0;s<intncgtcSize ;s++){
					vecNcgtcCol = (ArrayList) vecNcgtcRow.get(s);%>
	<tr><td colspan="3"><b><%=Helper.correctNull((String)vecNcgtcCol.get(13))%> - <%=Helper.correctNull((String)vecNcgtcCol.get(14))%></b></td></tr>
	<tr class=""><td width="40%" style="text-align: center"><b>Details of the Project</b></td><td width="30%" style="text-align: center"><b>Project description</b></td><td width="30%" style="text-align: center"><b>Eligibility</b></td></tr>
	<%if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("1")){ %>
	<tr><td width="40%">Type of the Project</td><td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td><td width="30%">&nbsp;</td></tr>
	<tr id="t1"><td>New employment likely to be generated in case of greenfield projects&nbsp;</td>	<td><%=Helper.correctNull((String)vecNcgtcCol.get(4))%>&nbsp;</td><td>&nbsp;</td></tr>
	<%}else if(Helper.correctNull((String)vecNcgtcCol.get(2)).equals("2")){ %>
	<tr><td width="40%">Type of the Project</td><td width="30%"><%=Helper.correctNull((String)vecNcgtcCol.get(3))%></td><td width="30%">&nbsp;</td></tr>
	<tr id="t2"><td>Additional employment likely to be generated in case of brownfield&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(5))%>&nbsp;</td><td>&nbsp;</td></tr>
	<%}%>
	<tr><td>Whether the project is in any of the metropolitan cities  Ahmedabad, Bengaluru, Hyderabad, Chennai, Kolkata, Mumbai, New Delhi and Pune&nbsp;</td>
		<td><%=Helper.correctNull((String)vecNcgtcCol.get(6))%>&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(7))%>&nbsp;</td></tr>
	<tr><td>Industry Sector&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(8))%>&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(9))%>&nbsp;</td></tr>	<tr>
		<td>Udyog Aadhaar Number(12 Digits)&nbsp;</td><td><%=Helper.correctNull((String)vecNcgtcCol.get(10))%>&nbsp;</td><td>&nbsp;</td></tr>
	<tr><td width="60%">Project unit pin code</td><td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(11))%></td><td>&nbsp;</td></tr>
	<tr><td width="60%">Nature of the Project</td><td width="40%"><%=Helper.correctNull((String)vecNcgtcCol.get(12))%></td><td>&nbsp;</td></tr>
	<tr><td colspan="3"><b>&nbsp;</b></td></tr>
	<%}} %>
</table>
</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td class="title"><br>TERMS AND CONDITIONS:</td></tr>

<%
	int j=0;
	int sub=0;
	int main=0;
	String prevSno="";
	String currParentId="";
	String termsno = "";
	boolean booflag=true;
	boolean subflag=true;

	if(arrFacilityTerm0!=null && arrFacilityTerm0.size()>0)
	{ %>
		<tr><td class="title"><b>Specific:</b></td></tr>
	<%	j=arrFacilityTerm0.size();
		for(int i=0;i<arrFacilityTerm0.size();i++)
		{
			termsno = Helper.correctNull((String) arrFacilityIdVal0.get(i));
			currParentId=Helper.correctNull((String) arrParentID0.get(i));
			if(currParentId.equalsIgnoreCase("0") && subflag==true )
			{
				booflag=true;
				sub=0;
			}
			if(booflag)
			{
				main = main+1;
				prevSno=Helper.correctNull((String) arrFacilityIdVal0.get(i));
				booflag=false;
			}
		%>
		<%if(currParentId.equalsIgnoreCase("0"))
		{
			subflag=true;
		%>
		<tr> 
		  	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="100%" >
			      	<tr>
			      		<td width="2%" valign="top"><%=main%>.</td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
		</tr>
		<%}
		if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
		{
		%>
		<tr> 
	      	<td valign="top" nowrap="nowrap">
		      	<table cellpadding="3" cellspacing="0" width="98%" align="right">
			      	<tr>
			      		<td width="2%" valign="top">&nbsp;<%=main%>.<%=++sub%></td>
			      		<td style="text-align: justify;"><%=arrFacilityTerm0.get(i)%></td>
			      	</tr>
		      	</table>
	      	</td>
	    </tr>
		
		<%}
		}
	} %>
	<%
	if(arrFacilityTermApp0!=null)
	{
		for(int i=0;i<arrFacilityTermApp0.size();i++)
		{  main = main+1;
		%>
		<tr > 
		  <td align="center"> 
		    <div align="left" style="text-align: justify;"><%=main%>.&nbsp;<%=arrFacilityTermApp0.get(i)%></div>
		  </td>
		</tr>
		<%
		}
	} %>
	
<!-- Terms and Conditon - General -->
   <jsp:include page="../print/com_AnnexureVII.jsp" flush="true">  
   <jsp:param name="pagetype" value="sancborrower" />       
   </jsp:include>
<!-- End -->
			   
<tr>
	<td>
		<table width="95%" align="center" cellpadding="0" cellspacing="0" border="0">
		<%if(arrDeleRow!=null&&arrDeleRow.size()>0)
		{ 
			for(int i=0;i<arrDeleRow.size();i++)
			{
				arrCol	=  (ArrayList)arrDeleRow.get(i);
		%>
			<%if(i%2==0){ %>
			<tr><td align="left"><br><%=Helper.correctNull((String)arrCol.get(0))%></td></tr>
			<tr><td align="left" class="title"><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
			<%}else{ %>
			<tr><td align="right"><br><%=Helper.correctNull((String)arrCol.get(0))%></td></tr>
			<tr><td align="right" class="title"><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
			<%} %>
		<%} } %>
		</table>
	</td>
</tr>
</table>	
</table>
</td>
</tr></tbody></table>

</body>
</html>
