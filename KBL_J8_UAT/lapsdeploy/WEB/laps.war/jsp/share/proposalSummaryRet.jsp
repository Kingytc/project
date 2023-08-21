<%@include file="../share/directives.jsp"%>
<%
ArrayList arrApptypeRow=new ArrayList();



ArrayList arrApptypeCol=new ArrayList();
ArrayList arrAppLiabRow=new ArrayList();
ArrayList arrOthrbnkRow=new ArrayList();
ArrayList arrRepaySchedule=new ArrayList(); 
ArrayList arrEligCol=new ArrayList();
ArrayList arrEligRow=new ArrayList();
HashMap hshEligdet= new HashMap();


if(hshValues!=null&&hshValues.size()>0)
{
	hshEligdet = (HashMap)hshValues.get("hshCheckElig");
	arrAppLiabRow = (ArrayList) hshValues.get("arrFacRow");
	arrOthrbnkRow = (ArrayList) hshValues.get("arrOthrbnkRow");
	arrApptypeRow = (ArrayList)hshValues.get("arrApptypeRow");
	arrEligRow=(ArrayList)hshEligdet.get("arrRow");
	
	
	
}
String strAmountForm=Helper.correctNull((String)request.getParameter("strAmountVal"));
String strAmountVal="Rs.";
if(strAmountForm.equalsIgnoreCase("L"))
	strAmountVal="Lakhs";
else if(strAmountForm.equalsIgnoreCase("C"))
	strAmountVal="Crores";
String strSchemeCode=Helper.correctNull((String) session.getAttribute("schemeCode"));
String strPrdtype = Helper.correctNull((String)hshValues.get("prd_type"));
String strProductType = Helper.correctNull((String) hshValues
		.get("strProductType"));
String strRepayType = Helper.correctNull((String)hshValues.get("loan_repaymenttype"));

String strSessionModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
String sessionModuleType=strSessionModuleType;

String secValue="";
ArrayList arrpropsecurityRow=new ArrayList();
ArrayList arrpropsecCollRow=new ArrayList();
ArrayList arrpropsecurityCol=new ArrayList();
ArrayList arrpropsecurity=new ArrayList();
arrpropsecurityRow=(ArrayList)hshValues.get("arrRowPri");
arrpropsecCollRow=(ArrayList)hshValues.get("arrRowColl");
String strIntIndx = Helper.correctNull((String)hshValues.get("strIntIndexid"));
//out.println(hshValues);
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Proposal Summary</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
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
	<form name="dopost();">
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
	<td>
		<table width="90%" border="0" cellpadding="3" cellspacing="0"  align="center" class="outertable">
		<tr>
			<td align="center"><br>
			<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
			</td>
		</tr>
		<tr align="center"> 
			<td> <b>PROPOSAL NUMBER:&nbsp;<%=Helper.correctNull((String) hshValues.get("strApplicationNo"))%> </b></td>
		</tr>
		
		<tr align="center"> 
			<td> <b>NAME OF THE LOAN : <%=Helper.correctNull((String)hshValues.get("strDesc")) %> </b></td>
		</tr >

		<tr align="center">
							<td>
							<b>PROPOSAL SUMMARY</b></td>
	</tr>
		</table>
	</td>
</tr>
		
			<tr>
				<td>
					<!-- <table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
						<tr>
							<td align="center" class="title"><br>
							<b>Proposal Summary</b></td>
						</tr>
					</table> -->
					<br>
					<table width="100%" border="1" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    		<tr>
							<td class="tblhead" align="left"><b>Sanctioning Department</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("sanctiondept"))%></td>
						</tr>
				    	<tr>
							<td class="tblhead" align="left"><b>Sanctioning Authority</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("sanctionauthority"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Borrower Name</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("borrowername"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>CBSID</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("PERAPP_CBSID"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Branch Name</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("ORG_NAME"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Branch SOL ID</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("ORG_SCODE"))%></td>
						</tr>
						<tr> 
							<td class="tblhead" align="left"><b>Constitution</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("CONSTITUTION"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Pan</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("PERAPP_PANNO"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Nature of Business/Activity</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("KYC_natofBussActivity"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Type of Proposal</b></td>
							<td align="left"><%=Helper.correctNull((String) hshValues.get("Typeofproposal"))%></td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Loan Amount</b></td>
							<td align="left"><img src="<%=ApplicationParams.getAppUrl()%>img/INRsymbol.png"><%=Helper.correctNull((String)hshValues.get("strSancAmt")) %> </td>
						</tr>
						<tr>
							<td class="tblhead" align="left"><b>Loan Term</b></td>
							<%if(Helper.correctNull((String)hshValues.get("strHolidayPeriod")).equalsIgnoreCase("0")) {%>
		                           <td><%=Helper.correctNull((String)hshValues.get("strTenor")) %> Months</td>
		                    <%}else{ %>
		                           <td>Repayable in <%=Helper.correctNull((String)hshValues.get("strTenor")) %> Months after an initial holiday period of <%=Helper.correctNull((String)hshValues.get("strHolidayPeriod")) %>  Months.</td>
		                        <%} %>
						</tr>
						
						<tr>
							<td class="tblhead" align="left"><b>Interest Type</b></td>
							<td align="left"><%=Helper.correctNull((String)hshValues.get("strInterestType")) %></td>
						</tr>
						
						<tr>
							<td class="tblhead" align="left"><b>Sanctioned Rate of Interest /Commission</b></td>
							<%if(!Helper.correctNull((String)hshValues.get("strMCLRtype")).equalsIgnoreCase("")){
			strIntIndx = "MCLR";}
		else if(!Helper.correctNull((String)hshValues.get("int_comm")).equalsIgnoreCase("")){
		strIntIndx = "Commission";}
		else{
			if(Helper.correctNull((String)hshValues.get("strInterestType")).equalsIgnoreCase("Floating"))
				if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("S"))
					strIntIndx="Six Month Treaury Bill";
				else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("T"))
					strIntIndx="Ten Years Govt Security";
				else
					strIntIndx = "Base Rate";
			}%>
		<%if(strIntIndx.equalsIgnoreCase("Base Rate")) {%>
		<td>Base Rate + <%=Helper.correctNull((String)hshValues.get("strInterest")) %> % p.a presently at <%=Helper.correctNull((String)hshValues.get("strModifiedInterest")) %>&nbsp;%</td>
		<%}else if(strIntIndx.equalsIgnoreCase("Commission")) {%>
		<td><%=Helper.correctNull((String)hshValues.get("int_comm")) %>&nbsp;</td> 
		<%} else {
		if(Helper.correctNull((String)hshValues.get("strInterestType")).equalsIgnoreCase("Floating")){ %>
		<td> 
		<%if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("S")){%>
			Six Months Treasury Bill
		<%}else if(Helper.correctNull((String)hshValues.get("strMCLRtype_ID")).equalsIgnoreCase("T")){ %>
			Ten Years Govt Security
			<%}else{ %>
			<%=Helper.correctNull((String)hshValues.get("strMCLRtype"))%><% }%> 
		(<%=Helper.correctNull((String)hshValues.get("strMCLRpercent"))%> %) + <%=Helper.correctNull((String)hshValues.get("strMCLRsplit"))%> % presently at <%=Helper.correctNull((String)hshValues.get("strModifiedInterest")) %>&nbsp;%</td>
		<%}else{ %>
		<td><%=Helper.correctNull((String)hshValues.get("strModifiedInterest")) %>&nbsp;%</td>
		<%}} %>
						</tr>
						
						


					</table> 
					<br>
					<br>
                <tr >
                
			<td><b>CIBIL Details:</b></td></tr>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			<td width="5%" align="center">S.No</td>
			<td width="15%" align="center">Name</td>
			<td width="30%" align="center">Applicant Type</td>
			<td width="15%" align="center">Score</td>
			<td width="35%" align="center">Comments</td>
			</tr>
			<%
			if (arrApptypeRow != null && arrApptypeRow.size() > 0) 
			{
			for (int l=0; l < arrApptypeRow.size(); l++) 
			{
				arrApptypeCol = (ArrayList) arrApptypeRow.get(l);
			%>
			<tr>
			<td style="text-align:center"><%=l+1%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(0))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(1))%></td>
			<td align="right"><%=Helper.correctDouble((String)arrApptypeCol.get(2))%></td>
			<td style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(3))%></td>
			</tr>
			<%}} %>
			</table>
			</div>
			</td>
			</tr>
			
			<tr>
			<td ><b>CRILC Details :</b></td>
			</tr>
			
			<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
					<tr class="tblhead">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="15%">Applicant Type</td>
						<td align="center" width="20%">Whether Reported to CRILC?</td>
						<td align="center" width="15%">Reported Date</td>
						<td align="center" width="25%">Comments</td>
					</tr>
					
					<%	boolean bflag=true;
						int n=0;
						
						if (arrApptypeRow != null && arrApptypeRow.size() > 0) 
						{
						for (int l=0; l < arrApptypeRow.size(); l++) 
						{
							arrApptypeCol = (ArrayList) arrApptypeRow.get(l);
							bflag=false;
							n=n+1;
							%>
					
					<tr>
						<td width="5%" style="text-align:center"><%=n%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(0))%></td>
						<td width="15%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(1))%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(4))%></td>
						<td width="25%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(6))%></td>
						<td width="15%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(5))%></td>
					</tr>
					<%}}
						if(bflag)
						{%>			
					
					<tr>
						<td align="center" colspan="6">- No Record Found -</td>
					</tr>
					<%} %>
				</table>
			</div>
			</td>
			</tr>
			
			<tr>
			<td><b>CRIF Details:</b></td>
			</tr>
			
			<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
				
					<tr class="tblhead">
						<td align="center" width="5%">S.no</td>
						<td align="center" width="20%">Name</td>
						<td align="center" width="15%">Applicant Type</td>
						<td align="center" width="20%">Whether referred to CRIF ?</td>
						<td align="center" width="14%">CRIF Score</td>
						<td align="center" width="13%">Comments</td>
						<td align="center" width="13%">Report date</td>
					</tr>	
					
					
					<%	boolean bflag1=true;
						int r=0;
						
						if (arrApptypeRow != null && arrApptypeRow.size() > 0) 
						{
						for (int l=0; l < arrApptypeRow.size(); l++) 
						{
							arrApptypeCol = (ArrayList) arrApptypeRow.get(l);
							bflag1=false;
							r=r+1;
						%>
					
					<tr>
						<td width="5%" style="text-align:center"><%=r%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(0))%></td>
						<td width="15%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(1))%></td>
						<td width="20%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(7))%></td>
						<td width="14%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(8))%></td>
						<td width="13%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(9))%></td>
						<td width="13%" style="text-align:center"><%=Helper.correctNull((String)arrApptypeCol.get(10))%></td>
					</tr>
								
					<%}}
						if(bflag1)
						{%>			
					
					<tr>
						<td align="center" colspan="7">- No Record Found -</td>
					</tr>
					<%} %>
					
				</table>
			</div>
			</td>
			</tr>
	<tr>
	<td>
	<table  class="printbreak" width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">

<% if(arrAppLiabRow.size()!=0){%>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				 <%
				 String strNaturearr[]=null;
				 String strNaturearr1[]=null;
				 ArrayList arrAppLiabCol=new ArrayList();
						if(arrAppLiabRow!=null&&arrAppLiabRow.size()>0)
						{
							for(int k=0;k<arrAppLiabRow.size();k++)
							{
								arrAppLiabCol=(ArrayList)arrAppLiabRow.get(k);
								strNaturearr = Helper.correctNull((String)arrAppLiabCol.get(1)).split("~");
								if(strNaturearr.length==1)
								{
									strNaturearr1[0]=strNaturearr[0];
									strNaturearr1[1]="0.00";
								}else if(strNaturearr.length==2)
								{
									strNaturearr1=strNaturearr;
								}else{
									strNaturearr1[0]="";
									strNaturearr1[1]="0.00";
								}
								if(k==0){
							
					%>
				 <tr>
				<td colspan="10"><b><span style="float:left"> Existing Facilities of the applicant :</span><span style="float:right">(Amount in <%=strAmountVal %>)</span></b></td>
				</tr>
					<tr class="tblhead">
						<td width="10%" align="center"><b>Facility</b></td>
						<td width="10%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Limit </b></td>
						<td width="10%" align="center"><b>Sanction Ref No.</b></td>
						<td width="10%" align="center" nowrap="nowrap"><b>Outstanding <br/> balance</b></td>
						<td width="10%" align="center"><b>Present Status</b></td>
						<td width="10%" align="center"><b>Rate Of Interest (%)</b></td>
						<td width="10%" align="center"><b>EMI / Installment Amount </b></td>
						<td width="10%" align="center"><b>Due Date</b></td>
						<td width="10%" align="center"><b>Arrears if any</b></td>
					</tr>
					<%} %>
					<tr>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(5))%></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(0))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble(strNaturearr1[1]),strAmountForm)%></td>
						<td align="center"><%=Helper.correctNull((String)arrAppLiabCol.get(2))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)arrAppLiabCol.get(3)),strAmountForm)%></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(4))%></td>
						<td align="right"><%=Helper.correctDouble((String)arrAppLiabCol.get(6))%></td>
						<td align="right"><%if(Helper.correctDouble((String)arrAppLiabCol.get(7)).equalsIgnoreCase("0.00")){%>&nbsp;<%}else{%><%=Helper.converAmount(Helper.correctDouble((String)arrAppLiabCol.get(7)),strAmountForm)%><%} %></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(8))%></td>
						<td><%=Helper.correctNull((String)arrAppLiabCol.get(9))%></td>
					</tr>
					<%
					
						}
						}
						
					%>
					
					    	
				</table>
			</div>
			</td></tr>
			
<%} %>					
		
			<br>
			<br>
						<tr>
				<td><b><span style="float: left;"> Other Bank Facilities of Main Applicant: </span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<br>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="10%" align="center"><b>Sl. No</b></td>
					<td width="10%" align="center"><b>Bank Name</b></td>
					<td width="20%" align="center"><b>Type of Facility</b></td>
					<td width="10%" align="center"><b>Limit</b></td> 
					<td width="10%" align="center"><b>Outstanding <br/> Balance</b></td> 
					<td width="10%" align="center"><b>Rate Of Interest (%)</b></td> 
					<td width="10%" align="center"><b>EMI / Installment </b></td> 
					<td width="10%" align="center"><b>Due Date</b></td> 
					<td width="10%" align="center"><b>Arrears if any</b></td> 
					</tr>
					<%if(arrOthrbnkRow!=null && arrOthrbnkRow.size()>0){
						ArrayList arrOthrbnkCol=new ArrayList();
					for(int g=0;g<arrOthrbnkRow.size();g++){
						
						arrOthrbnkCol = (ArrayList)arrOthrbnkRow.get(g);
					%>
					<tr>
					<td align="center"><%=g+1%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(0))%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(1))%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(2)))),strAmountForm)%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(3)))),strAmountForm)%>&nbsp;</td>
					<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(4))))%>&nbsp;</td>
					<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(Double.parseDouble(
							Helper.correctDouble((String)arrOthrbnkCol.get(5)))),strAmountForm)%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(6))%>&nbsp;</td>
					<td><%=Helper.correctNull((String)arrOthrbnkCol.get(7))%>&nbsp;</td>
					</tr>
					<%}}else{ %>
					<tr><td colspan="9" align="center">No data found</td></tr>
					<%} %>				    	
				</table>
			</div>
			</td></tr>
			
			
		
</table>
	</td>
	</tr>
		<br>
		<br>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
						<td colspan="4"><b>Repayment Details:</b></td>
					</tr>		
				    	<br>	
					<tr>
						<td width="25%"><b>Whether EMI</b></td>
						<td width="25%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("WhetherEMI"))%></b></td>
						<td width="25%"><b>Holiday Period</b></td>
						<td width="25%" >&nbsp;<%=Helper.correctInt((String)hshValues.get("strHolidayPeriod"))%>&nbsp;</td>
					</tr>
					<tr>
						<td><b>Installment Frequency</b></td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPeriodicity"))%></td>
						<td><b>Interest Frequency</b></td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strIntFreq"))%></td>		
					</tr>	
					<tr>
						<td><b>Collect Interest During Holiday Period</b></td>
						<td>&nbsp;<b><%=Helper.correctNull((String)hshValues.get("loan_servised"))%></b></td>
						<td><b>No. of installments excluding holiday period</b></td>
						<%int strPeriodicityVal = 1;
						if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Monthly"))
							strPeriodicityVal = 1;
						else if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Quarterly"))
							strPeriodicityVal = 3;
						else if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Half-Yearly"))
							strPeriodicityVal = 6;
						else if(Helper.correctInt((String)hshValues.get("strPeriodicity")).equalsIgnoreCase("Yearly"))
							strPeriodicityVal = 12;
						if(strSchemeCode.equalsIgnoreCase("OD"))
						{ %>
						<td>&nbsp;On Demand&nbsp;</td>
						<%}else{ %>
						<td>&nbsp;<%=Integer.parseInt(Helper.correctInt((String)hshValues.get("loan_noofinstallment")))/strPeriodicityVal%>&nbsp;</td>
						<%} %>									
					</tr>											
					<%if(strPrdtype.equalsIgnoreCase("pE")){
					int intTerms = Integer.parseInt(Helper.correctInt((String)hshValues.get("Terms")));
					int intHoliday = Integer.parseInt(Helper.correctInt((String)hshValues.get("strHolidayPeriod")));
					intTerms = intTerms - intHoliday;
					%>					
					<tr>
					<td><b>EMI/ Installment Amount</b></td>
					<td colspan="3">&nbsp;In <u><%=Helper.correctInt((String)Integer.toString(intTerms))%></u> EMI [EMI will be fixed after Moratorium period of <u><%=Helper.correctInt((String)Integer.toString(intHoliday))%></u> Months]</td>
					</tr>						
					<%}else if(!strPrdtype.equalsIgnoreCase("pG") && !strPrdtype.equalsIgnoreCase("pR"))
					{
						if(!(strRepayType.equalsIgnoreCase("1")) && !strRepayType.equalsIgnoreCase(""))
						{
						if(!(strSchemeCode.equalsIgnoreCase("OD")&& strPrdtype.equalsIgnoreCase("pM")))
						{
						if(arrRepaySchedule!=null && arrRepaySchedule.size()>0)
						{%>
					<tr><td colspan="4"><b>Repayment Schedule</b></td></tr>
					<tr><td colspan="4">
					<table width="100%" cellpadding="3" cellspacing="0" border="0">					
					<tr class="tblhead">
					<td align="center" width="4%"><b>S.No</b></td>
					<td align="center" width="32%"><b>Frequency</b></td>
					<td align="center" width="20%"><b>No of Installments</b></td>
					<td align="center" width="20%"><b>Installment Amount</b></td>
					<td align="center" width="20%"><b>Total</b></td>
					</tr>
					<%
					String strFreq = "",strDesc="";
					
						for(int count = 0;count<arrRepaySchedule.size();count++)
						{					
					    arrEligCol = new ArrayList();
					    arrEligCol = (ArrayList)arrRepaySchedule.get(count);
					    strFreq = Helper.correctInt((String)arrEligCol.get(0));
					    if(strFreq.equalsIgnoreCase("m"))
			    		{
					    	strDesc = "Monthly";
			    		}					    
					    else if(strFreq.equalsIgnoreCase("q"))
			    		{
					    	strDesc = "Quarterly";
			    		}
					    else if(strFreq.equalsIgnoreCase("h"))
			    		{
					    	strDesc = "Half-Yearly";
			    		}
					    else if(strFreq.equalsIgnoreCase("y"))
			    		{
					    	strDesc = "yearly";
			    		}
					    else if(strFreq.equalsIgnoreCase("n"))
			    		{
					    	strDesc = "Not Applicable";
			    		}
					    %>
					    <tr>
					    <td><%=count+1%></td>
					    <td><%=strDesc%></td>
					    <td align="right"><%=Helper.correctInt((String)arrEligCol.get(1))%></td>
					     <td align="right"><%=Helper.correctInt((String)arrEligCol.get(3))%></td>
					    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)arrEligCol.get(2)))%></td>
					    </tr>						    						    					
					<%}%>
					<tr>
					    <td colspan="4" align="right"><b>Total :</b>&nbsp;&nbsp;</td>					    
					    <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshValues.get("RepaySheduleTotal")))%></td>
					</tr>
					</table>
					</td>
					</tr>
					<%String StrRepayComments = Helper.correctNull((String)hshValues.get("repaycomments"));
					String StrStageWiseRelease=Helper.correctNull((String)hshValues.get("stagewiserealse"));
					if(StrStageWiseRelease.equalsIgnoreCase("Y")){
						StrStageWiseRelease="Yes";
					}else if(StrStageWiseRelease.equalsIgnoreCase("N")){
						StrStageWiseRelease="No";
					}else{
						StrStageWiseRelease="";
					}
					if(!StrRepayComments.equalsIgnoreCase(""))
					{%>
						<tr><td colspan="4"><b>Terms of Repayment</b></td></tr>
					<tr><td colspan="4"><%=StrRepayComments%></td></tr>
					<%}if(!StrStageWiseRelease.equalsIgnoreCase("")){%>
					<tr><td colspan="2"><b>Stage Wise Release Of Loan </b></td>
				    <td colspan="2"><%=StrStageWiseRelease%></td></tr>
					<%} %>
					<%}}}else{%>	
					<tr>				
					<td><b>EMI/ Installment Amount</b></td>
					<td style="text-align: right;">&nbsp;<b><%=Helper.correctDouble((String)hshValues.get("loan_emi"))%></b></td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					</tr>	
					<%}}%>														    	
				</table>
			</div>
			</td></tr>
	   
			
		<tr>
			<td><b> Security Details</b></td>
			</tr>
			<%
			if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
			<tr><td>
			<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr class="tblhead"><td colspan="4"><span style="float: left;">Attached Securities : </span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></td></tr>
			<tr>
			<td  align="center" width="20%"><b>Facility</b></td>
			<td  align="center" width="40%"><b>Details of Security</b></td>
			<td  align="center" width="10%"><b>Value</b></td>
			<td  align="center" width="25%"><b>Date of Valuation</b></td></tr>
			<%if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0)) { %>
			<tr align="left">
			<td colspan="4"><b>Prime :</b></td>
			</tr>
			<% 

			arrpropsecurityCol=new ArrayList();
			arrpropsecurity=new ArrayList();
			secValue = "";
			if(arrpropsecurityRow!=null && arrpropsecurityRow.size()>0){
				for(int a=0;a<arrpropsecurityRow.size();a++)
				{
					arrpropsecurityCol=(ArrayList)arrpropsecurityRow.get(a);
						  if(a==0) {
					%>
					<tr>
					<%if(arrpropsecurityRow.size()>2){ %>
					<td rowspan="<%=(arrpropsecurityRow.size())%>"><%=Helper.correctNull((String)arrpropsecurityCol.get(0)).toUpperCase()%></td>
					<%}else{ %>
					<td rowspan="2"><%=Helper.correctNull((String)arrpropsecurityCol.get(0)).toUpperCase()%></td>
					<%} %>
					</tr>
					<%} else {
					secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.converAmount(Helper.correctDouble((String)arrpropsecurityCol.get(1)),strAmountForm)));
					if(secValue.equals("0.00")) secValue=" ";
					%>
					<tr>
					 <td> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
					 <td align="right"><%=secValue%></td>
					 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
					</tr>		
					<%	}
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
				for(int a=0;a<arrpropsecCollRow.size();a++)
				{
					arrpropsecurityCol=(ArrayList)arrpropsecCollRow.get(a);
						secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.converAmount(Helper.correctDouble((String)arrpropsecurityCol.get(1)),strAmountForm)));
						if(secValue.equals("0.00")) secValue=" ";
						%>
						<tr>
						 <td colspan="2"> <%=Helper.correctNull((String)arrpropsecurityCol.get(0))%></td>
						 <td align="right"><%=secValue%></td>
						 <td><%=Helper.correctNull((String)arrpropsecurityCol.get(2))%></td>
						</tr>		
						<%	 } }}
			%>
			</TABLE>
			</div></td>
			</tr>
			<% }else{%>
			<tr><td><b><br>Attached Securities:</b> Nil</td></tr>
			<%} %>
	<tr>
			<td>
			<jsp:include page="../print/per_securitydetails.jsp" flush="true"/>
			</td>
			</tr>
			
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="4"><b>MIS Details</b></td>
				    </tr>
					<tr class="tblhead">
					<td width="25%" align="center"><b>Descriptions</b></td>	
					<td width="25%" align="center"><b>Facility</b></td>
					<td width="25%" align="center"><b>Descriptions</b> </td>	
					<td width="25%" align="center"><b>Facility</b></td>				
					</tr>
					<tr>
				<%if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>	
					<td align="left">Name of Bank Schematic Loan<br><br> Bank Sub Scheme</td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc"))%> <br><br><br>&nbsp;<%=Helper.correctNull((String)hshValues.get("prd_subcatscheme"))%> </td>
				<% } else { %>
					<td width="25%">Name of Bank Schematic Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc")) %></td>
				<% } %>	
					<td width="25%">Guarantee covered BY</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_Guarantee Covered")) %></td>				
					</tr>
					<tr>
					<td width="25%">Activity Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_activitycode")) %></td>
					<td width="25%">Guarantee Covered Amount</td>	
					<td width="25%"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("app_guaranteeamt")),strAmountForm) %></td>		
									
					</tr>
					<tr>
					
					<td width="25%">Main Activity</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_mainactivitydesc")) %></td>	
					<%if(Helper.correctNull((String)hshValues.get("strisGovtScheme")).equalsIgnoreCase("1")){ %>
					<td width="25%" >Name of the Govt Sponsored Scheme</td>
					<td width="25%" colspan="3"><%=Helper.correctNull((String)hshValues.get("mis_govnysponser"))%>
					<%if(!Helper.correctNull((String)hshValues.get("strGovtCategory")).equalsIgnoreCase("")){ %>
					- ( <%=Helper.correctNull((String)hshValues.get("strGovtCategory")) %> )
					<%} %>
					</td>
					<%}else{ %>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<%} %>					
					</tr>
					<tr>
					<td width="25%">Sub Activity</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subactdesc")) %></td>
					<td width="25%">Industry Category Type</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_indcattyepagr"))%></td>
									
					</tr>
					<tr>
					<td width="25%">Purpose</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_purpose")) %></td>	
					<td width="25%">Sector of Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sctortloan"))%></td>
										
					</tr>
					
					<tr>
					<td width="25%">BSR Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsrcodedesc")) %></td>
					<td width="25%">Sub Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subscetroloan"))%></td>
					</tr>	
					<tr>
					
					<td width="25%">BSR1 Code</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsr1codedesc")) %></td>	
					<td width="25%">Sensitive Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sensitivitysec"))%></td>
									
					</tr>
					
					<tr>
					<td width="25%">Investment in Plant & Machineries/Equipments</td>
					<td width="25%"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("app_plantval")),strAmountForm) %></td>
					<td width="25%">Weaker Section</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_weaksection"))%></td>
							
					</tr>		    	
					<tr>
					<td width="25%">Industry Name </td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_indname")) %></td>
					<td width="25%">Infrastructure</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_infrastructure"))%></td>
					</tr>
					<tr>
					<td width="25%">Investment value as on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("APP_INVESTMENT_DATE")) %></td>
					<%if(!Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Government announced scheme</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")) %></td>
					<%} %>					
					</tr>
					<tr>
					<td width="25%">Criteria for Investment value</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("APP_CRITERIA_INVESTMENT")) %></td>
					<%if(!Helper.correctNull((String)hshValues.get("mis_StandupDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Stand Up India</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_StandupDesc")) %></td>		
					<%} %>	
					
					</tr>
					<tr>
						<td width="25%">Sales Turnover of the Applicant </td>	
					<td width="25%"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("PERAPP_SALES_TURNOVER")),strAmountForm)%></td>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					</tr>
					<tr>	
					<td width="25%">Sales Turnover As on Date</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("PERAPP_SALES_TURNOVER_DATE")) %></td>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					</tr>		
					<tr>
					<td width="25%">Criteria for Sales Turnover </td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strcrtsales")) %></td>
					<td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
										
					</tr>
					<tr>
					<%if(Helper.correctNull((String)hshValues.get("minoritychk")).equalsIgnoreCase("Y")){ %>
					<td width="25%">Whether Start up as per definition of Ministry of Commerce and Industry</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strministry")) %></td>
					<%}else{ %>
				     <td width="25%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<%} %>
					</tr>
					
								    	
				</table>
			</div>
			</td></tr>
	
	
	
</td>
	</tr>				
</table>		

<br>
<br>
<br>
</form>
</body>
</html>