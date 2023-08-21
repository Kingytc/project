<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>

<%
String strPagetype = Helper.correctNull((String)request.getParameter("pageVal"));
String proposalFormat = Helper.correctNull((String)request.getParameter("proposalFormat"));

if(strPagetype.equalsIgnoreCase("ANN5"))
{
	hshValues = (HashMap)hshValues.get("ANN5");
}
if(strPagetype.equalsIgnoreCase("shortnote"))
{
	hshValues = (HashMap)hshValues.get("ANN5");
}
if(strPagetype.equalsIgnoreCase("PostSanc"))
{
	hshValues = (HashMap)hshValues.get("ANN5");
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

java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);

ArrayList arrCol		= new ArrayList();
ArrayList arrODCCRow	= new ArrayList();
ArrayList arrBPCRow		= new ArrayList();
ArrayList arrPCSRow		= new ArrayList();
ArrayList arrNFBRow		= new ArrayList();
ArrayList arrBGLmtRow	= new ArrayList();
ArrayList arrBCLmtRow	= new ArrayList();
ArrayList arrBPurRow	= new ArrayList();
ArrayList arrBPurEXRow	= new ArrayList();
ArrayList arrNFBRowIM	= new ArrayList();
ArrayList arrOthDetRow	= new ArrayList();

ArrayList arrImpoCollection	= new ArrayList();
ArrayList arrGoodsLoan	= new ArrayList();
ArrayList arrWareHouseRec	= new ArrayList();
ArrayList arrChequeDiscou	= new ArrayList();
ArrayList arrInLBillsDisco	= new ArrayList();

ArrayList temparrCol	= new ArrayList();

int intODCCRow=0;
if(hshValues!=null)
{
	arrODCCRow	= (ArrayList)hshValues.get("arrODCCRow");
	arrNFBRow	= (ArrayList)hshValues.get("arrNFBRow");
	arrBGLmtRow	= (ArrayList)hshValues.get("arrBGLmtRow");
	arrBCLmtRow	= (ArrayList)hshValues.get("arrBCLmtRow");
	arrBPCRow	= (ArrayList)hshValues.get("arrBPCRow");
	arrPCSRow	= (ArrayList)hshValues.get("arrPCSRow");
	arrBPurRow	= (ArrayList)hshValues.get("arrBPurRow");
	arrBPurEXRow= (ArrayList)hshValues.get("arrBPurEXRow");
	arrNFBRowIM	= (ArrayList)hshValues.get("arrNFBRowIM");
	arrOthDetRow= (ArrayList)hshValues.get("arrOthDetRow");
	
	arrImpoCollection= (ArrayList)hshValues.get("arrImpoCollection");
	arrGoodsLoan= (ArrayList)hshValues.get("arrGoodsLoan");
	arrWareHouseRec= (ArrayList)hshValues.get("arrWareHouseRec");
	arrChequeDiscou= (ArrayList)hshValues.get("arrChequeDiscou");
	arrInLBillsDisco= (ArrayList)hshValues.get("arrInLBillsDisco");
	
	if(arrOthDetRow!=null)
	intODCCRow=arrOthDetRow.size();
	
	if(intODCCRow==0)
		intODCCRow=1;
}
String strNil	= "Nil";
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strAmountValue = Helper.correctNull((String)hshValues.get("com_amountvalue"));
String strCalBased = Helper.correctNull((String)hshValues.get("COM_CALBASE"));
	if(strCalBased.equalsIgnoreCase("2"))
		{
	strCalBased = "Exposure";
		}
	else
	{
		strCalBased= "GBC";
	}
String strSno[]={"i","ii","iii","iv","v","vi","vii","viii","ix","x","xi","xii","xiii","xiv","xv","xvi","xvii","xviii","xix","xx","xxi","xxii","xxiii","xxiv","xxv"};
int a=0;
String strFormat = Helper.correctNull((String)request.getParameter("strFormat"));
%>

<html>
<head>
<title>Annexure - V</title>
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
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<%if(!(strPagetype.equalsIgnoreCase("ANN5") || strPagetype.equalsIgnoreCase("shortnote")|| strPagetype.equalsIgnoreCase("PostSanc"))) {%>
<tr><td class="title" align="center"><br><br>ANNEXURE V</td></tr>
<%}%>
<tr><td class="title">
<%if(proposalFormat.equals("RPN")) { %>
VIII. 
<%} else if(!strPagetype.equalsIgnoreCase("shortnote") && !strPagetype.equalsIgnoreCase("PostSanc") ){ %>
V .
<%} %>

<%if(proposalFormat.equals("RPN")) { %>
Comments on Conduct of account:
<%} else if(!strPagetype.equalsIgnoreCase("PostSanc")){ %> CONDUCT OF OPERATIONS UNDER THE EXISTING FACILITIES :<%} %></td>
<td align="right"  nowrap="nowrap"><%=strAmtValueIn%></td></tr>

<tr>
	<td colspan="2">
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%if(!proposalFormat.equals("RPN")) { %>
			
				<tr>
					<td width="3%" valign="top">(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%" valign="top">Compliance of the earlier sanction terms</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top"><%=Helper.correctNull((String)hshValues.get("cesComments"))%></td>
				</tr>
				<tr>
					<td width="3%" valign="top">(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%" valign="top">Registration of charge with ROC & latest Search Report</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top"><%=Helper.correctNull((String)hshValues.get("rocComments"))%></td>
				</tr>
				<%if(!strFormat.equalsIgnoreCase("Y")&&(!proposalFormat.equals("RPN"))){ %>
				<tr>
					<td width="3%" valign="top">(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%" valign="top">Registration of EM details with central registry</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top"><%=Helper.correctNull((String)hshValues.get("centralreg"))%></td>
				</tr>
				<%if(!strPagetype.equalsIgnoreCase("PostSanc")){ %>
				<tr>
					<td width="3%" valign="top">(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%" valign="top">Whether charged noted in favor of our bank on the property has been verified</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top"><%=Helper.correctNull((String)hshValues.get("favbank"))%></td>
				</tr>
				<%}}} %>
				<tr>
					<td width="3%" valign="top">(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%" valign="top">Conduct of Term Loan/ DP Note Loan/ DPG</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top"><%=Helper.correctNull((String)hshValues.get("TLComments"))%></td>
				</tr>
				<%if(arrOthDetRow!=null && arrOthDetRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%" valign="top">Period</td>
					<%for(int i=0;i<arrOthDetRow.size();i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="center" colspan="2"><b><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;&nbsp;to&nbsp;&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></b></td>
					<%} else { %>
					<td colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>
				
				<%if((arrODCCRow!=null&&arrODCCRow.size()>0)||(arrBPCRow!=null&&arrBPCRow.size()>0)||(arrPCSRow!=null&&arrPCSRow.size()>0)||
						(arrBPurRow!=null&&arrBPurRow.size()>0)||(arrBPurEXRow!=null && arrBPurEXRow.size()>0)||
						(arrBPurEXRow!=null&&arrBPurEXRow.size()>0)||(arrBPurEXRow!=null&&arrBPurEXRow.size()>0)){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Conduct of Working Capital facilities</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<%} %>
				
				<%if(arrODCCRow!=null&&arrODCCRow.size()>0){ %>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">OD/ CC Limits</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td  width="25%" valign="top">Sanctioned limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Credit Summation</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Debit Summation</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%if(strFormat.equalsIgnoreCase("Y")){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Whether Credit summation Commensurate with the Sales turnover</td>
										<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(16))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%}else{ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments</td>
										<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(14))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Maximum Dr. Balance</td>
										<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Minimum Dr. Balance</td>
										<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Maximum Cr. Balance</td>
				 <%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Minimum Cr. Balance</td>
				 <%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Number of times excess permitted</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(8))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
									<td align="center" class="title">No.</td>
								<td align="center" class="title">Amount</td>							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">No. & Amount of Cheques returned for want of Funds</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(9))%></td>
									<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
						
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Remarks:</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(10))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%if(strFormat.equalsIgnoreCase("Y")){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments (On operation of OD limit along with TOD's granted if any)</td>
										<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrODCCRow.size();j++)
						{
							arrCol	= (ArrayList)arrODCCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(15));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(14))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%}} %>
				
				<!-- BPC Details -->
				
				<%if(arrBPCRow!=null&&arrBPCRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">BPC Details</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Sanctioned Limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPCRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPCRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>	
						<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Cheque purchased</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPCRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(1))%></td>
								<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
						 <%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Cheque returned</td>
				<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPCRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(3))%></td>
								<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%>&nbsp;</td>
						 	<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>	
					
				</tr>
					
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Remarks</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPCRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPCRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(5))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>
				<!-- Packing Credit /Shipping Loan -->
				
				<%if(arrPCSRow!=null&&arrPCSRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Packing Credit /Shipping Loan</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Sanctioned Limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrPCSRow.size();j++)
						{
							arrCol	= (ArrayList)arrPCSRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrPCSRow.size();j++)
						{
							arrCol	= (ArrayList)arrPCSRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
					
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">No. Of Loans released</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrPCSRow.size();j++)
						{
							arrCol	= (ArrayList)arrPCSRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
									<td align="center"><%=Helper.correctInt((String)arrCol.get(1))%></td>
								 	<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
					 	<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%if(strFormat.equalsIgnoreCase("Y")){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">No. of occasion excesses permitted</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrPCSRow.size();j++)
						{
							arrCol	= (ArrayList)arrPCSRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(7))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>	
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Comments</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrPCSRow.size();j++)
						{
							arrCol	= (ArrayList)arrPCSRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(5))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr> 
				<%} %>
				
				<!-- Bills  Purchased:  -->
				
				<%if(arrBPurRow!=null&&arrBPurRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Bills Purchased:</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Inland Bills:</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Sanctioned Limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
									<td align="center" class="title">No.</td>
									<td align="center" class="title">Amount</td>					
			 	<%} 	}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
						
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Inland Bills under LC</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(3))%></td>
								<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%>&nbsp;</td>
		 				<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
					
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Inland bills under collection (Non-LC)</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(5))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%>&nbsp;</td>
											<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Local Bills sent on Collection</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(15))%></td>
								<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(16))))),strAmountValue)%>&nbsp;</td>
					 	<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				
				<%if(arrBPurRow!=null&&arrBPurRow.size()>0){%>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Returns, if any & when reimbursement</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(17))%></td>
									<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(18))))),strAmountValue)%>&nbsp;</td>
					 <%}	}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
					
				<%} %>
				<%if(arrBPurRow!=null&&arrBPurRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">No. of occasion excesses permitted</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(25))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(26))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%
				if(strFormat.equalsIgnoreCase("Y")){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments on IDPMS (Position shall be Discussed)</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(29))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Details of Advance Payment received and remain Unadjusted as on date</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(28))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%}
				%>
				
				<%} %>
				<%} %>
				<%if(arrBPurEXRow!=null && arrBPurEXRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Export Bills:</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Sanctioned Limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>
				<%if(arrBPurEXRow!=null&&arrBPurEXRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Export Bills under LC - sight</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
						<td align="center"><%=Helper.correctInt((String)arrCol.get(7))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
			
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Export Bills under LC - usance</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(9))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))),strAmountValue)%>&nbsp;</td>
						<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
						
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Export Bills (Non-LC)  - sight</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
						 <td align="center"><%=Helper.correctInt((String)arrCol.get(11))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(12))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
					
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Export Bills (Non-LC)  - usance</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(13))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(14))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Export Bills under Direct</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(28))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(29))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Returns, if any & when reimbursement</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(30))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(31))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>
				<%if(arrBPurEXRow!=null&&arrBPurEXRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Export Bills sent on Collection</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(19))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(20))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
					
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Export Bills on advance payment basis</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(21))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(22))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
						
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">ITT received</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					 	  <td align="center"><%=Helper.correctInt((String)arrCol.get(23))%></td>
						  <td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(24))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
						
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">No. Of occasion excesses permitted</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(25))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments:</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td colspan="2" valign="top">&nbsp;<%=Helper.correctInt((String)arrCol.get(26))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%if(strFormat.equalsIgnoreCase("Y")){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments on EDPMS (Position shall be Discussed)</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td colspan="2" valign="top">&nbsp;<%=Helper.correctInt((String)arrCol.get(33))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Details of Advance Payment received and remain Unadjusted as on date</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBPurEXRow.size();j++)
						{
							arrCol	= (ArrayList)arrBPurEXRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(27));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td colspan="2" valign="top">&nbsp;<%=Helper.correctInt((String)arrCol.get(32))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%}} %>
				<%if(!proposalFormat.equals("RPN")){ %>
				<!-- Non Funded Limits - Inland LC -->
				
				<%if((arrNFBRow!=null&&arrNFBRow.size()>0)||(arrNFBRowIM!=null&&arrNFBRowIM.size()>0)||
						(arrBGLmtRow!=null&&arrBGLmtRow.size()>0)||(arrBCLmtRow!=null&&arrBCLmtRow.size()>0)){ %>
						<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Non Funded Limits</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<%} %>
				
				<%if(arrNFBRow!=null&&arrNFBRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">InLand LC Limit</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Sanctioned Inland LC Limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRow.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRow.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>						
				 	<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
					
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Inland LC (DP)</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRow.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(1))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
				 			<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>

				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Inland LC (DA)</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRow.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
						<td align="center"><%=Helper.correctInt((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%>&nbsp;</td>
					 	<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Devolvement under Inland LC</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRow.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
						<td align="center"><%=Helper.correctInt((String)arrCol.get(9))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">No. of occasion excesses permitted</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRow.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(11))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Remarks</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top"><%=Helper.correctNull((String)arrCol.get(12))%>&nbsp;</td>
				</tr>
				<%} %>
				
				<!-- Non Funded Limits - Import LC -->
				
				<%if(arrNFBRowIM!=null&&arrNFBRowIM.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Import LC Limit</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Sanctioned Import LC Limit</td>
				<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRowIM.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRowIM.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
				<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRowIM.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRowIM.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center" class="title">No.</td>
						<td align="center" class="title">Amount</td>		
											<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
					
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Import LC (DP)</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRowIM.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRowIM.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(5))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%>&nbsp;</td>
									<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
						
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Import LC (DA)</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRowIM.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRowIM.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
						<td align="center"><%=Helper.correctInt((String)arrCol.get(7))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))),strAmountValue)%>&nbsp;</td>
									<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
							
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Devolvement under Import LC</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRowIM.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRowIM.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(9))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(10))))),strAmountValue)%>&nbsp;</td>
									<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
							
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">No. of occasion excesses permitted</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrNFBRowIM.size();j++)
						{
							arrCol	= (ArrayList)arrNFBRowIM.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(13));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="right" colspan="2"><%=Helper.correctInt((String)arrCol.get(11))%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Remarks</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top"><%=Helper.correctNull((String)arrCol.get(12))%>&nbsp;</td>
				</tr>
				<%} %>
				
				<!-- Sanctioned Bank Guarantee Limit -->
				
				<%if(arrBGLmtRow!=null&&arrBGLmtRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Bank Guarantee Limit</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Sanctioned Bank Guarantee Limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBGLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBGLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
		
				<tr>
				<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
				<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBGLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBGLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center" class="title">No.</td>
					<td align="center" class="title">Amount</td>			
									<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
					</tr>
							
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Guarantees issued</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBGLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBGLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="right"><%=Helper.correctInt((String)arrCol.get(1))%>&nbsp;</td>
								<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
									<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
									
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Guarantees invoked</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBGLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBGLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
						<td align="right"><%=Helper.correctInt((String)arrCol.get(3))%>&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%>&nbsp;</td>
									<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
								
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Remarks on Guarantees Invoked. Reasons, present status of such guarantees</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBGLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBGLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(6));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>
				
				<!-- Sanctioned Buyers credit limit -->
				
				<%if(arrBCLmtRow!=null&&arrBCLmtRow.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Buyers credit limit</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Sanctioned  Limit</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBCLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBCLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(8));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))),strAmountValue)%>&nbsp;</td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBCLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBCLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(8));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
						<td align="center" class="title">No.</td>
					<td align="center" class="title">Amount</td>			
						<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
						
			
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Buyers credit for LC bills</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBCLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBCLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(8));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(1))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
	
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBCLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBCLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(8));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center"><%=Helper.correctInt((String)arrCol.get(3))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))),strAmountValue)%>&nbsp;</td>
									<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Buyers credit for LC bills</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBCLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBCLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(8));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
								<td align="center"><%=Helper.correctInt((String)arrCol.get(1))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
									
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Devolvement</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBCLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBCLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(8));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(5))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
								
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Remarks</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrBCLmtRow.size();j++)
						{
							arrCol	= (ArrayList)arrBCLmtRow.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(8));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(7))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%}} %>
				
				<%if(strFormat.equalsIgnoreCase("Y")){ %>
				<%if(arrImpoCollection!=null&&arrImpoCollection.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Import Collection bills</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrImpoCollection.size();j++)
						{
							arrCol	= (ArrayList)arrImpoCollection.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>						
					<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrImpoCollection.size();j++)
						{
							arrCol	= (ArrayList)arrImpoCollection.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(2))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrImpoCollection.size();j++)
						{
							arrCol	= (ArrayList)arrImpoCollection.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
					</tr>
				<%}
				if(arrGoodsLoan!=null&&arrGoodsLoan.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Goods Loan</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrGoodsLoan.size();j++)
						{
							arrCol	= (ArrayList)arrGoodsLoan.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>						
					<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrGoodsLoan.size();j++)
						{
							arrCol	= (ArrayList)arrGoodsLoan.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(2))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrGoodsLoan.size();j++)
						{
							arrCol	= (ArrayList)arrGoodsLoan.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
					</tr>
				<%}
				if(arrWareHouseRec!=null&&arrWareHouseRec.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Warehouse Receipt Loan</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrWareHouseRec.size();j++)
						{
							arrCol	= (ArrayList)arrWareHouseRec.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>						
					<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrWareHouseRec.size();j++)
						{
							arrCol	= (ArrayList)arrWareHouseRec.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(2))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrWareHouseRec.size();j++)
						{
							arrCol	= (ArrayList)arrWareHouseRec.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
					</tr>
				<%}
				if(arrChequeDiscou!=null&&arrChequeDiscou.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Cheques Discounted</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrChequeDiscou.size();j++)
						{
							arrCol	= (ArrayList)arrChequeDiscou.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>						
					<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrChequeDiscou.size();j++)
						{
							arrCol	= (ArrayList)arrChequeDiscou.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(2))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrChequeDiscou.size();j++)
						{
							arrCol	= (ArrayList)arrChequeDiscou.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
					</tr>
				<%}
				if(arrInLBillsDisco!=null&&arrInLBillsDisco.size()>0){ %>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top" class="title">Inland Bills Discounted</td>
					<td colspan="<%=intODCCRow+intODCCRow%>" valign="top">&nbsp;</td>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrInLBillsDisco.size();j++)
						{
							arrCol	= (ArrayList)arrInLBillsDisco.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td align="center" class="title">No.</td>
							<td align="center" class="title">Amount</td>						
					<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">&nbsp;</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrInLBillsDisco.size();j++)
						{
							arrCol	= (ArrayList)arrInLBillsDisco.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
					<td align="center"><%=Helper.correctInt((String)arrCol.get(2))%></td>
					<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(3))))),strAmountValue)%>&nbsp;</td>
								<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" valign="top">&nbsp;</td>
					<td width="25%" valign="top">Comments</td>
					<%for(int i=0;i<intODCCRow;i++)
					{
						boolean bflag=true;
						for(int j=0;j<arrInLBillsDisco.size();j++)
						{
							arrCol	= (ArrayList)arrInLBillsDisco.get(j);
							String yearsno=Helper.correctNull((String)arrCol.get(5));
							
							temparrCol =(ArrayList)arrOthDetRow.get(i); 
							String mainyearsno=Helper.correctNull((String)temparrCol.get(5));
							if(yearsno.equalsIgnoreCase(mainyearsno))	
							{
								bflag=false;
							%>
							<td colspan="2">&nbsp;<%=Helper.correctNull((String)arrCol.get(4))%></td>
							<%}
						}
						if(bflag){
						%>
						<td  colspan="2">&nbsp;</td>
					<%} } %>
					</tr>
				<%}%>
				
				<%} %>
				
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;</td>
				</tr>
				
				<!-- Other Business Operation -->
				<%if(!proposalFormat.equals("RPN")){ %>
				<%if(arrOthDetRow!=null&&arrOthDetRow.size()>0){ %>
				<%if(strFormat.equalsIgnoreCase("Y")){ %>
				<tr>
					<td width="3%" >(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%">OD Interest</td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%"> Forex Income</td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(7))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%"> TL Interest Income</td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(8))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%"> Other facilities income</td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(9))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%"> Other Income </td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%"> Total </td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1)))+Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%}else{ %>
				<tr>
					<td width="3%" >(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%">Income Earned by the Bank <br> a) Interest from all facilities</td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(0))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%">b) All other Income</td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))),strAmountValue)%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				<%} %>
				<%} %>
				<tr>
					<td width="3%" >&nbsp;</td>
					<td width="25%">Income leakage noted and recovery status</td>
					<%for(int i=0;i<intODCCRow;i++){
						if(i<arrOthDetRow.size())
						{
							arrCol	= (ArrayList)arrOthDetRow.get(i);
					%>
					<td align="right" colspan="2"><%=Helper.correctNull((String)arrCol.get(2))%>&nbsp;</td>
					<%} else { %>
					<td align="center" colspan="2">&nbsp;</td>
					<%} } %>
				</tr>
				
				<%} %>
			
			<% if(!(Helper.correctNull((String)hshValues.get("otherfac_comm3"))).equalsIgnoreCase("")) {%>
			<tr>
				<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %></td>
				<td width="25%">Submission of Stock/ QOS/ Availability of DP</td>
				<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm3"))%></td>
			</tr>
			<%} %>
			<% if(!(Helper.correctNull((String)hshValues.get("otherfac_comm4"))).equalsIgnoreCase("")) {%>
			<tr>
				<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %></td>
				<td width="25%">Ancillary business given to us. If not Why?</td>
				<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm4"))%></td>
			</tr>
			<%} %>
			<% if(!(Helper.correctNull((String)hshValues.get("otherfac_comm5"))).equalsIgnoreCase("")) {%>
			<tr>
				<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %></td>
				<td width="25%">Whether pro-rata business given to us. If not Why?</td>
				<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm5"))%></td>
			</tr>
			<%} %>
			<% if(!(Helper.correctNull((String)hshValues.get("otherfac_comm6"))).equalsIgnoreCase("")) {%>
			<tr>
				<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %></td>
				<td width="25%">Any diversion of business to other Banks not in consortium - Reasons/ Comments</td>
				<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm6"))%></td>
			</tr>
			<%} %>
			<% if(!(Helper.correctNull((String)hshValues.get("otherfac_comm1"))).equalsIgnoreCase("")) {%>
			<tr>
				<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %> &nbsp; <br/></td>
				<td width="25%">Comments on level of utilization of limit, placement if pro-rata business including ancillary business and insurance
								business, diversion of business to other Banks
				</td>
				<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm1"))%></td>
			</tr>
			<%}if(!(Helper.correctNull((String)hshValues.get("otherfac_comm12"))).equalsIgnoreCase("")) {%>
			<tr>
			<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %></td>
			<td width="25%">Availability of necessary statutory permission/ license/ Approval/ Clearance to keep the borrower as going concern
			</td>
			<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm12"))%></td>
		</tr>
		<%}if(!(Helper.correctNull((String)hshValues.get("otherfac_comm13"))).equalsIgnoreCase("")) {%>
		<tr>
		<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %></td>
		<td width="25%">Details of insurance cover for goods and fixed assets are available
		</td>
		<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm13"))%></td>
	</tr>
	<%} %>
	<%if(!strFormat.equalsIgnoreCase("Y")){ %>
			<tr>
					<td width="3%" >(<%=strSno[a] %>) <%a=a+1; %></td>
					<td width="25%">Any other facilities</td>
					<td colspan="<%=intODCCRow+intODCCRow%>">&nbsp;<%=Helper.correctNull((String)hshValues.get("otherfac_comm9"))%></td>
				</tr>
	<%} %>
	<%if(!strPagetype.equalsIgnoreCase("PostSanc") && !proposalFormat.equals("RPN")){ %>
			<tr>
				<td align="center" width="3%">(<%=strSno[a] %>) <%a=a+1; %></td>
				<td class="title"  colspan="<%=intODCCRow+intODCCRow+1%>">Inspection comments ( Internal/ RBI) and rectification thereof:</td>
			</tr>
			
			<tr>
				<td align="center" width="3%">&nbsp;</td>
				<td align="center" width="25%">&nbsp;</td>
				<td align="center" colspan="<%=intODCCRow%>">Comments</td>
				<td align="center" colspan="<%=intODCCRow%>">Compliance/ Action taken/ time frame for rectification</td>
			</tr>
			<tr>
				<td>A.</td>
				<td width="25%">Internal (position as on <%=Helper.correctNull((String)hshValues.get("IPOAScomrbi_asdate"))%>)</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("IPOAScomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("IPOAScomrbi_compliance"))%></td>
			</tr>
			<tr>
				<td>B.</td>
				<td width="25%">RBI Inspection (position as on <%=Helper.correctNull((String)hshValues.get("RBIPOcomrbi_asdate"))%>)</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("RBIPOcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("RBIPOcomrbi_compliance"))%></td>
			</tr>
			<%if(strFormat.equalsIgnoreCase("Y")){ %>
			<tr>
				<td>C.</td>
				<td width="25%">Stock Audit Reports conducted by  <%=Helper.correctNull((String)hshValues.get("STAURcom_auditconductedby"))%> report dated <%=Helper.correctNull((String)hshValues.get("STAURcomrbi_asdate"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("STAURcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("STAURcomrbi_compliance"))%></td>
			</tr>
			<tr>
				<td>D.</td>
				<td width="25%">Credit Audit Report conducted by  <%=Helper.correctNull((String)hshValues.get("CRAURcom_auditconductedby"))%> report dated <%=Helper.correctNull((String)hshValues.get("CRAURcomrbi_asdate"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("CRAURcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("CRAURcomrbi_compliance"))%></td>
			</tr>
			<%}else{ %>
			<tr>
				<td>C.</td>
				<td width="25%">Stock Audit Reports (position as on <%=Helper.correctNull((String)hshValues.get("STAURcomrbi_asdate"))%>)</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("STAURcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("STAURcomrbi_compliance"))%></td>
			</tr>
			<tr>
				<td>D.</td>
				<td width="25%">Credit Audit Report (position as on <%=Helper.correctNull((String)hshValues.get("CRAURcomrbi_asdate"))%>)</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("CRAURcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("CRAURcomrbi_compliance"))%></td>
			</tr>
			<%} %>
			<tr>
				<td>E.</td>
				<td width="25%">Unit Inspection Reports</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("UNINRcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("UNINRcomrbi_compliance"))%></td>
			</tr>
			<tr>
				<td>F.</td>
				<td width="25%">RMD's observations</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("RMDOBcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("RMDOBcomrbi_compliance"))%></td>
			</tr>
			<tr>
				<td>G.</td>
				<td width="25%">Concurrent Audit Report</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("CONARcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("CONARcomrbi_compliance"))%></td>
			</tr>
			<tr>
				<td>H.</td>
				<td width="25%">Legal Audit</td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("LEGALcomrbi_comments"))%></td>
				<td colspan="<%=intODCCRow%>"><%=Helper.correctNull((String)hshValues.get("LEGALcomrbi_compliance"))%></td>
			</tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>

<%if(!strPagetype.equalsIgnoreCase("shortnote") && !strPagetype.equalsIgnoreCase("PostSanc"))
{ %>
<% if(!(Helper.correctNull((String)hshValues.get("strTransExistingAcc_comments"))).equalsIgnoreCase("")) {%>
<tr>
	<td class="title"><br>Comments on Transaction in the existing accounts :</td>
</tr>
<tr>
	<td><%=Helper.correctNull((String)hshValues.get("strTransExistingAcc_comments"))%></td>
</tr>
<%} %>

<!-- Exposure to Industry -->
<% if(!(Helper.correctNull((String)hshValues.get("fin_comments"))).equalsIgnoreCase("")) {%>
<tr>
	<td class="title"><br>Remarks:</td>
</tr>
<tr>
	<td><%=Helper.correctNull((String)hshValues.get("fin_comments"))%></td>
</tr>
<%} %>
<%if(!strSessionModuleType.equalsIgnoreCase("AGR") && !proposalFormat.equals("RPN")) {%>
<tr><td class="title" colspan="2"><br>Exposure to industry:</td>
</tr>
<tr>
<td align="right"  nowrap="nowrap" colspan="2"><%=strAmtValueIn%></td>
</tr>
<tr>
	<td colspan="2">
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<tr>
					<td align="center" width="20%"><b>Nature of activity</b></td>
					<td align="center" width="20%"><b>Amount of advance <br> as at <br><%=Helper.correctNull((String)hshValues.get("COM_ADVANCEDATE"))%></b></td>
					<td align="center" width="20%"><b>Percentage to <%= strCalBased %> <br> as on <br><%=Helper.correctNull((String)hshValues.get("COM_PERCENTAGEGBCDATE"))%></b></td>
					<td align="center" width="20%"><b>Amount of NPA under this activity</b></td>
					<td align="center" width="20%"><b>% of NPA to <%= strCalBased %></b></td>
				</tr>
				<tr>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("COM_ACTIVITY"))%></td>
					<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("COM_ADVANCEAMOUNT")),strAmountValue)%>&nbsp;</td>
					<td align="right">&nbsp;<%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("COM_GBCPERCENTAGE")))%>&nbsp;</td>
					<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("COM_NPAAMOUNT")),strAmountValue)%>&nbsp;</td>
					<td align="right">&nbsp;<%=Helper.correctDouble((String)hshValues.get("COM_NPAGBCPERCENTAGE"))%>&nbsp;</td>
				</tr>
			</table>
		</div>
	</td>
</tr>
<tr>
	<td colspan="5"><%= strCalBased %> as on &nbsp;<%=Helper.correctNull((String)hshValues.get("COM_GBCDATE"))%> &nbsp;  = Rs.&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("COM_GBCAMOUNT")),strAmountValue)%>&nbsp;lacs</td>
</tr>
<%if(strCalBased.equalsIgnoreCase("GBC")) {%>
<tr>
	<td colspan="5"><b>GBC = Gross Bank Credit.</b></td>
</tr>
<%}} %>
<% if(!(Helper.correctNull((String)hshValues.get("fin_comments1"))).equalsIgnoreCase("")) {%>
<tr>
	<td class="title">Remarks:</td>
</tr>
<tr>
	<td><%=Helper.correctNull((String)hshValues.get("fin_comments1"))%></td>
</tr>
<%}} %>

<tr><td><br></td></tr>
</table>
</body>
</html>