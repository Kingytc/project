<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
String strOrgLevel=(String)session.getAttribute("strOrgLevel");
String strOrgName=(String)session.getAttribute("strOrgName");
String strProposalvalue = Helper.correctNull((String) hshValues
		.get("proposalvaluesin"));

if (strProposalvalue.equalsIgnoreCase("C"))
	strProposalvalue = "Crores";
else
	strProposalvalue = "Lacs";
HashMap hshTermsandcond = new HashMap(); 
HashMap hshRecord=new HashMap();
ArrayList arrRecommRow	= new ArrayList();
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
ArrayList arrFacRow=new ArrayList();
ArrayList arrRowNonBr=new ArrayList();
ArrayList arrColNonBr=new ArrayList();
ArrayList arrNERepay=new ArrayList();
ArrayList arrInsBranchRow=new ArrayList();
ArrayList arrMCLRRow=new ArrayList();
ArrayList arrMultipleWC = new ArrayList();
ArrayList arrFacilityTerm0 = (ArrayList)hshValues.get("arrFacilityTerm0");
ArrayList arrFacilityIdVal0 = (ArrayList)hshValues.get("arrFacilityIdVal0");
ArrayList arrParentID0 = (ArrayList)hshValues.get("arrParentID0");
ArrayList arrFacilityTermApp0 = (ArrayList)hshValues.get("arrFacilityTermApp0");
ArrayList arrReval = (ArrayList)hshValues.get("arrReval");
String strmisDesc[] = { "Facility Desc", "Type of Facility and Facility Serail Number",
		"Activity Code", "Main Activity", "Sub Activity",
		"Agriculture/Industry/Service Category type","Sector",
		"Sub sector","Sensitive sector",
		"StandUp India","Government announced scheme","Guarantee Cover By",
		"Guarantee Covered Amount","Sales Turnover of the Applicant",
		"Sales Turnover As on Date",
		"Criteria for Sales Turnover","Investment in Plant & Machineries/Equipments","Industry Name",
		"Investment value as on Date","Criteria for Investment value","Weaker Section","Whether Start up as per definition of Ministry of Commerce and Industry"
		};
ArrayList arrRowtemp= new ArrayList();
ArrayList arrColtemp= new ArrayList();
ArrayList arrBAOurRow= new ArrayList();
String strOutstandingDate="";
String strWCMultiple="";
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	arrFacRow= (ArrayList)hshValues.get("arrFacRow");
	arrRecommRow	= (ArrayList)hshValues.get("arrRecommRow");
	arrRowNonBr		=(ArrayList)hshValues.get("arrRowNonBr");
	arrNERepay		=(ArrayList)hshValues.get("arrtlrec");
	arrMCLRRow		=(ArrayList)hshValues.get("arrMCLR");
	hshTermsandcond =(HashMap)hshValues.get("hshTermsandcond");
	arrInsBranchRow		= (ArrayList)hshTermsandcond.get("arrInsBranchRow");
	strOutstandingDate=Helper.correctNull((String)hshValues.get("strOutstandingDate"));
	arrBAOurRow		= (ArrayList)hshValues.get("arrBAOurRow");
	arrMultipleWC 	= (ArrayList)hshRecord.get("arrMultipleWC");
	strWCMultiple=Helper.correctNull((String)hshRecord.get("StrRemarksFlagWC_M"));
}
hshRecord=(HashMap)hshValues.get("misdetails");
ArrayList arrMISRow	= (ArrayList)hshValues.get("arrMISRow");
ArrayList arrColMIS	= new ArrayList();
java.text.NumberFormat jtn	= java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
String  strNil	= "Nil",strValuesIn="",strWhetherBRAvail="N",strGuar="";
strWhetherBRAvail=Helper.correctNull((String)hshValues.get("strWhetherBRAvail"));

String strValIn = Helper.correctNull((String)hshValues.get("strValuesIn"));

if(strValIn.equalsIgnoreCase("Rs"))
{
	strValuesIn	= "(Amount in  "+strValIn+".)";
}
else
{
	strValuesIn	= "(Rs. in  "+strValIn+")";
}
ArrayList arrPromoterRow=new ArrayList();
arrPromoterRow=(ArrayList)hshValues.get("arrPromoterRow");
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
ArrayList arrProRow=(ArrayList)hshValues.get("arrProRow");
String strArr[]={"a","b","c","d","e","f","g","h","i"};
int intSize=0;
String APP_LOANSUBTYPE_DIGI=Helper.correctNull((String)session.getAttribute("APP_LOANSUBTYPE_DIGI"));
String strFormat = Helper.correctNull((String)request.getParameter("strFormat"));
String strAmountValue=Helper.correctNull((String)hshValues.get("com_amountvalue"));
String strAmtValueIn = request.getParameter("pagevalueAmt");

%>
<html>
<head>
<title>Sanction Letter(Branch)</title>
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
.printbreak {
page-break-before: always;
}
</style>

</head>
<body>
<table width="93%" border="0" cellspacing="0" cellpadding="2" align="center">
<tr>
<td valign="top">

		<table width="95%" border="0" cellspacing="0" cellpadding="3" align="center">		
		<tr>
		<td align="center" colspan="2"><b>BRANCH COPY</b></td>
		</tr>
		<tr>
		<td colspan="2" align="center"><br><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
		</tr>
			<%if(!strOrgLevel.equalsIgnoreCase("C")){ %>
<tr><td align="center" width="50%"><b>Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=strOrgName.toUpperCase()%></b></td></tr>
<%}else{%>
	<%if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("008")){ %>
	<tr><td align="center" width="50%"><b><%=Helper.correctNull((String) hshValues.get("com_sancdept")).toUpperCase()%>&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("com_sancbranch")).toUpperCase()%></b></td></tr>
	<%}else if(Helper.correctNull((String)hshValues.get("com_sancdeptcode")).equalsIgnoreCase("010")){ %>
	<tr><td align="center" width="50%"><b><%=Helper.correctNull((String) hshValues.get("com_sancdept")).toUpperCase()%>&nbsp;:&nbsp;<%=Helper.correctNull((String) hshValues.get("com_sancbranch")).toUpperCase()%></b></td></tr>
	<%}else{ %>
	<tr><td align="center" width="50%"><b>Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=strOrgName.toUpperCase()%></b></td></tr>
	<%} %>
<%} %>
		<tr>
		<td align="center" colspan="2"><hr></td></tr>
		<tr>
		<td align="center" colspan="2"><b>&nbsp;&nbsp;&nbsp;<u>CREDIT SANCTION INTIMATION</u></b></td>
		</tr>
		</table>
		</td></tr>
		<tr><td>
		<div id="top">
		<table width="95%"cellspacing="0" cellpadding="3" align="center"> 
		<tr> 
		<td width="40%">Sanction Ref. No.: <%=Helper.correctNull((String)hshValues.get("sanctionrefno")) %>  </td>
		<td width="30%">Branch PF No.: <%=Helper.correctNull((String)hshValues.get("BR_pfno")) %> <br>
		HO PF No.: <%=Helper.correctNull((String)hshValues.get("HO_pfno")) %> </td>
		<td width="30%">Date: <%=Helper.correctNull((String)hshValues.get("processdate")) %> </td>
		</tr>
		
		<%if(arrReval!=null && arrReval.size()>0){
			for(int i=0;i<arrReval.size();i++){
			arrCol=(ArrayList)arrReval.get(i);%>
		<%if(i==0){ %>
		<tr>
		<td colspan="3"><b>Revalidation Ref. No.:</b></td>
		</tr>
		<%} %>
		<tr> 
		<td><%=Helper.correctNull((String)arrCol.get(0)) %>-<%=Helper.correctNull((String)arrCol.get(1)) %>&nbsp;</td>
		<td colspan="2"><%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>
		</tr>
		<%} }%>
		
		
		
		<tr> 
		<td  rowspan="2"><P>To: <br>The Branch Head,<br><%=Helper.changetoTitlecase(Helper.correctNull((String)hshValues.get("homebranch")))%> Branch</td>
		
		<%
				if(arrRow!=null&&arrRow.size()>0)
				{
				for(int i=0;i<arrRow.size();i++)
				{
				arrCol=(ArrayList)arrRow.get(i);
				String strVal1= (Helper.correctNull((String) arrCol.get(0))).toUpperCase();
				String strVal2= Helper.changetoTitlecase(Helper.correctNull((String) arrCol.get(1)));
				String strVal3= Helper.changetoTitlecase(Helper.correctNull((String) arrCol.get(2)));
				String strVal4= Helper.changetoTitlecase(Helper.correctNull((String) arrCol.get(3)));
				String strVal5= Helper.changetoTitlecase(Helper.correctNull((String) arrCol.get(4)));
				String strVal6= Helper.changetoTitlecase(Helper.correctNull((String) arrCol.get(5)));
				String strVal7= Helper.correctNull((String) arrCol.get(6));
				String strVal8= Helper.changetoTitlecase(Helper.correctNull((String) arrCol.get(7)));
					
		%>
		<td colspan="2"><u><b>Name and Address of Applicant:</b></u><br>
		<%if(!strVal1.equalsIgnoreCase("")){ %>
		<%=strVal1%>,<br>
		<%} if(!strVal2.equalsIgnoreCase("")){ %>
		<%=strVal2%>,<br>
		<%} if(!strVal3.equalsIgnoreCase("")){ %>
		<%=strVal3%>,<br>
		<%} if(!strVal4.equalsIgnoreCase("")){ %>
		<%=strVal4%>,<br>
		<%} if(!strVal6.equalsIgnoreCase("")){ %>
		<%=strVal6%>,
		<%} if(!strVal5.equalsIgnoreCase("")){ %>
		<%=strVal5%> (Dt),<br>
		<%} if(!strVal8.equalsIgnoreCase("")){ %>
		<%=strVal8%>
		<%} if(!strVal7.equalsIgnoreCase("")&&!strVal8.equalsIgnoreCase("")){ %>-
		<%} if(!strVal7.equalsIgnoreCase("")){ %>
		<%=strVal7%><br>
		<%} %>
		</td>
		<%}} %>
		</tr> 
		<tr>
		<td  colspan="2">
		<%if(arrProRow!=null && arrProRow.size()>0){ %>
		<b><u>Joint Applicant's:</u></b><br>
		<%for(int k=0;k<arrProRow.size();k++)
		{%>
			<%=Helper.correctNull((String)arrProRow.get(k)) %><br>
		<%}%>
		<%} %>
		</td>
		</tr>
		</table>
		</div></td></tr>

	
	<tr><td>
	<table width="95%"  cellspacing="0" cellpadding="3" align="center"> 
	<tr>
	<td>Ref: Your Loan Application Dated <%=Helper.correctNull((String)hshValues.get("app_inwrddocdate"))%> for Credit Facilities.</td>
	</tr>
	
	<tr>
	<td>&nbsp;</td>
	</tr>
	
	<tr>
	<td style="text-align: justify;">With reference to the above, we are pleased to inform sanction of the following fresh / renewal with/ existing/ enhancement/ reduced credit 
	facilities to <b><%=Helper.correctNull((String)hshValues.get("appname")) %></b> along with terms & conditions of the sanction.</td>
	</tr>
	
	<tr>
	<td>&nbsp;</td>
	</tr>
	
	<tr>
	<td style="text-align: justify;">If the sanctioned facilities are to be released after the stipulated period, please obtain revalidation of the 
	sanction prior to the release.</td>
	</tr>
	
	<tr>
	<td>&nbsp;</td>
	</tr>
	
	<tr>
	<td style="text-align: justify;">Second and third copies are to be mailed to the applicant duly signed by you.  Please note to get back the third 
	copy from the applicant duly signed at the relevant space in token of having accepted the sanctioned limits with all terms and conditions 
	and this copy should be held along with loan documents.</td>
	</tr>
	
	<tr>
	<td>&nbsp;</td>
	</tr>
	<%if(Helper.correctNull((String)hshValues.get("strMCLRFlag")).equalsIgnoreCase("N")){ %>
	<tr>
	<td style="text-align: justify;">Rate of interest is subject to change from time to time.Present Base rate of the Bank is <b><%=Helper.correctDouble((String)hshValues.get("strBaseRate")) %> %</b>.</td>
	</tr>
	<%} %>
	</table>
	</td></tr>

	
	<tr>
	<td align="center"><hr></td>
	</tr>
	
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br><u>1.01 Credit Facilities Sanctioned:</u></td>
				<td align="right" class="title">Sector:<%=Helper.correctNull((String)hshValues.get("com_sector")) %></td>
			</tr>
		</table>
	</td>
</tr>
	
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><%=strArr[intSize] %><%intSize++; %>) NATURE OF FACILITY AND LIMITS:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">&nbsp;</td>
				<td align="right" width=""><%=strValuesIn%></td>
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
				<td width="3%" align="center"><b>Sl.No</b></td>
				<td width="20%" align="center"><b>Type of Facility</b></td>
				<td width="15%" align="center"><b>Type of Limit</b></td>
				<td width="15%" align="center"><b>Nature of Facility</b></td>
				<td align="center" colspan="2"><b>Amount</b></td>
				<td width="20%" align="center"><b>Remark</b></td>
				<td width="20%" align="center"><b>Purpose</b></td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<%if(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17)))!=0){ %>
			<tr>
				<td align="center" rowspan="3"><%=i + 1%>.</td>
				<td align="left" rowspan="3"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="left" rowspan="3"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<td align="left" rowspan="3"><%=Helper.changetoTitlecase((String)arrCol.get(25))%>&nbsp;</td>
				<td>Loan Sanction Amount</td>
				<%if(!Helper.correctNull((String) arrCol.get(19)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1)))-Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17))))%></td>
				<%}else{ %>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper
							.correctDouble((String) arrCol.get(1))))%></td>
				<%} %>
				<td align="left" rowspan="3"><%=Helper.changetoTitlecase((String)arrCol.get(8))%></td>
				<td align="left" rowspan="3"><%=Helper.changetoTitlecase((String)arrCol.get(16))%></td>
				</tr>
				<tr>
					<td><%=Helper.correctNull((String) arrCol.get(18))%>&nbsp;</td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(17))))%></td>
				</tr>
				<tr class="title">
					<td>Total Loan Sanction Limit</td>
					<td align="right"><%=jtn.format(Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1))))%></td>
				</tr>
				<%}else{ %>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(25))%></td>
				<td align="right" colspan="2"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%><br/>Without any insurance coverage.</td>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(8))%></td>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(16))%></td>
			</tr>
			<%} %>
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
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<% int w=0;
			if(arrRecommRow!=null&&arrRecommRow.size()>0){ 
			boolean bflag=false;
			
			for(int i=0;i<arrRecommRow.size();i++)
			{
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					if(Helper.correctNull((String) arrCol.get(19)).equalsIgnoreCase("SF"))
						bflag=true;
				}
			}%>
			 <%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				{
					if(!Helper.correctNull((String) arrCol.get(19)).equalsIgnoreCase("NC") && !Helper.correctNull((String) arrCol.get(19)).equalsIgnoreCase("")  ){ 

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
			 <% }%>
			<tr>
				<td align="center"><%=w%>.</td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(0)).toUpperCase()%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(18))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(20))%></td>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(21))))%></td>
				<%if(Helper.correctNull((String) arrCol.get(19)).equalsIgnoreCase("SF")){ %>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(17))))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(22))%></td>
				<td align="left"><%=Helper.correctNull((String) arrCol.get(24))%></td>
				<%}
				else if(bflag)
				{%>
				<td align="right" colspan="3">&nbsp;</td>
				<%}  %>
				
				
		   	</tr>
			<%}}} %>
			
	 <%} %>
	 </table>
	 </div>
	 </td>
</tr>
	
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br><%=strArr[intSize] %><%intSize++; %>) RATE OF INTEREST/ COMMISSION:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">&nbsp;</td>
				<td align="right" width=""><%=strValuesIn%></td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<div id="top">
			<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<%boolean bflag=true;
			if(arrRecommRow!=null&&arrRecommRow.size()>0 && strWhetherBRAvail.equalsIgnoreCase("Y")){ 
				int j=0;
				bflag=false;%>
			<tr>
				<td width="3%" align="center"><b>Sl.No</b></td>
				<td width="30%" align="center"><b>Type of Facility</b></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td width="20%" align="center"><b>Type of Limit</b></td>
				<%} %>
				<td width="10%" align="center"><b>Limit</b></td>
				<td width="30%" align="center"><b>Rate of Interest/Commission</b></td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
				if(Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("BR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("MCLR")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("SMTB") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("EBLEC") ||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("TYGS")||Helper.correctNull((String)arrCol.get(12)).equalsIgnoreCase("FTBR")){
					j=j+1;
			%>
			<tr>
				<td align="center"><%=j%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<%} %>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
			</tr>
			<%} }} %>
			
			<%if(arrMCLRRow!=null && arrMCLRRow.size()>0){ %>
				<tr>
				<td colspan="5">
				<%for(int k=0;k<arrMCLRRow.size();k++)
				{ %>
				<%=Helper.correctNull((String)arrMCLRRow.get(k))%><br/>
				<%} %>
				</td>
				</tr>
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
				bflag=false;
			%>
		<tr><td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>OTHER RATE OF INTEREST/ COMMISSION:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
		</td></tr>
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
if(bflag){
	%>
	<tr><td>
	<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
								<tr><td><%=strNil %></td></tr>
							</table>
							</td>
							</tr>
	<%}
%>

<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br><%=strArr[intSize] %><%intSize++; %>) MARGIN:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">&nbsp;</td>
				<td align="right" width=""><%=strValuesIn%></td>
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
				<td width="3%" align="center"><b>Sl.No</b></td>
				<td width="28%" align="center"><b>Type of Facility</b></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td width="20%" align="center"><b>Type of Limit</b></td>
				<%} %>
				<td width="11%" align="center"><b>Limit</b></td>
				<td width="34%" align="center"><b>Margin</b></td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<%} %>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(10))%>
				<%if(!Helper.correctNull((String) arrCol.get(28)).equalsIgnoreCase("")){ %>Relaxation in margin as per RBI COVID relief Package Policy : <%=Helper.correctNull((String) arrCol.get(28))%><%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(26)).equalsIgnoreCase("")){ %>Actual Margin(%) :<%=Helper.correctNull((String) arrCol.get(26)) %> <%} %><br/>
				<%if(!Helper.correctNull((String) arrCol.get(27)).equalsIgnoreCase("")){ %>Relaxed Margin(%):<%=Helper.correctNull((String) arrCol.get(27)) %> <%} %>
				</td>
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
				<td class="title"><br><%=strArr[intSize] %><%intSize++; %>) PERIOD:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">&nbsp;</td>
				<td align="right" width=""><%=strValuesIn%></td>
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
				<td width="3%" align="center"><b>Sl.No</b></td>
				<td width="28%" align="center"><b>Type of Facility</b></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td width="15%" align="center"><b>Type of Limit</b></td>
				<%} %>
				<td width="11%" align="center"><b>Limit</b></td>
				<td width="10%" align="center"><b>Tenor <br>(in Months)</b></td>
				<td width="20%" align="center"><b>Initial Holiday/ Gestation/ Moratorium Period <br>(in Months)</b></td>
				<td width="10%" align="center"><b>Due Date</b></td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<%} %>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
				<td align="right"><%=Helper.correctInt((String)arrCol.get(6))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(11))%></td>
				<td align="right"><%=Helper.correctNull((String)arrCol.get(13))%></td>
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
				<td class="title"><br><%=strArr[intSize] %><%intSize++; %>) MODE OF REPAYMENT:</td>
				<td align="right" width="">&nbsp;</td>
			</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title">&nbsp;</td>
				<td align="right" width=""><%=strValuesIn%></td>
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
				<td width="3%" align="center"><b>Sl.No</b></td>
				<td width="28%" align="center"><b>Type of Facility</b></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td width="20%" align="center"><b>Type of Limit</b></td>
				<%} %>
				<td width="15%" align="center"><b>Limit</b></td>
				<td width="30%" align="center"><b>Mode of Repayment</b></td>
			</tr>
			<%for(int i=0;i<arrRecommRow.size();i++){
				arrCol	=  (ArrayList)arrRecommRow.get(i);
			%>
			<tr>
				<td align="center"><%=i+1%>.</td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(0)).toUpperCase()%></td>
				<%if(!strSessionModuleType.equalsIgnoreCase("AGR")){ %>
				<td align="left"><%=Helper.changetoTitlecase((String)arrCol.get(5))%></td>
				<%} %>
				<td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
				<td align="left"><%=Helper.correctNull((String)arrCol.get(9))%></td>
			</tr>
			<%} } else{%>
			<tr><td align="left" style="border:none;"><%=strNil%></td></tr>
			<%} %>
			</table>
		</div>
	</td>
</tr>
<%{ 
		ArrayList arrOutCol1	= new ArrayList();
		ArrayList arrOutRow1	= (ArrayList) hshValues.get("arrOutRow1");
	%>
	
	
	<tr><td><b><%=strArr[intSize] %><%intSize++; %>)REPAYMENT SCHEDULE COMMENTS:</b></td></tr>
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
	
	<%
		}
			}else{		
	%>
	<tr><td align="center">&nbsp;Nil</td></tr>
	<%} 
}%>
<%if(strSessionModuleType=="DIGI" || APP_LOANSUBTYPE_DIGI.equalsIgnoreCase("PC")){%>
<tr><td><b><br><%=strArr[intSize] %><%intSize++; %>)</b> Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> (Inclusive of all Taxes)</td></tr>
<%}else{ %>
<tr><td><b><br><%=strArr[intSize] %><%intSize++; %>)</b> Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("com_processingfee")) %></b> + Applicable Taxes</td></tr>
<%}%>
<%if(!Helper.correctNull((String)hshValues.get("strProposedSecurity")).equalsIgnoreCase("M")){
	ArrayList arrpropsecurityRow=new ArrayList();
	ArrayList arrpropsecCollRow=new ArrayList();
	ArrayList arrpropsecurityCol=new ArrayList();
	ArrayList arrpropsecurity=new ArrayList();
	String secValue="";
	arrpropsecurityRow=(ArrayList)hshValues.get("arrproposedSecfacwise");
	arrpropsecCollRow=(ArrayList)hshValues.get("arrRowCollSec");
	if((arrpropsecurityRow!=null && arrpropsecurityRow.size()>0) || (arrpropsecCollRow!=null && arrpropsecCollRow.size()>0)){ %>
	<tr><td><b><br><%=strArr[intSize] %><%intSize++; %>) Securities for the proposed / renewed facilities : </b><div align="right"><%=strValuesIn%></div></td></tr>
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
	<td colspan="4"><b>Prime :</b></td>
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
					  secValue =Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(3))));
						if(secValue.equals("0.00")) secValue=" ";
			%>
			<tr>
			<td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))%>)</td>
			 <td  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(2))%></td>
			  <td align="right"  rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull(secValue)%></td>
			<td rowspan="<%=(arrpropsecurityCol.size())%>"><%=Helper.correctNull((String)arrpropsecurity.get(4))%></td>
			</tr>
			<%} else {
			%>
			<tr>
			 <td> <%=Helper.correctNull((String)arrpropsecurity.get(0))%> ( <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurity.get(1))))%>)</td>
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
			secValue = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrpropsecurityCol.get(1))));
			if(secValue.equals("0.00")) secValue=" ";
			%>
			<tr>
			 <td colspan="2"> <%=(Helper.correctNull((String)arrpropsecurityCol.get(0)))%></td>
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
	<% }else{%>
	<tr><td><b><br><%=strArr[intSize] %><%intSize++; %>) Securities for the proposed / renewed facilities :</b> Nil</td></tr>
	<%}}else{ %>
<tr><td><b><br><%=strArr[intSize] %><%intSize++; %>) Securities for the proposed / renewed facilities :</b> </td></tr>
<tr>
<td><%=Helper.correctNull((String)hshValues.get("strProposedSecurityComments"))%></td>
</tr>
<%} %>
<%if(!Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")).equalsIgnoreCase("")){ %>
<tr>
<td>
<div id="top">
<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td>
<%=Helper.correctNull((String)hshValues.get("companyinfo_typeofliability")) %>
</td>
</table>
</div>
</td>
</tr>
<%} %>
<!-- End-->
	<%if((arrPromoterRow!=null && arrPromoterRow.size()>0)){ %>
<tr>
<td>
<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br><%=strArr[intSize] %><%intSize++; %>) CO-OBLIGANTS \ GUARANTORS</td>
				<td align="right">&nbsp;</td>
			</tr>
		</table>
</td>
</tr>
<tr>
	<td align="center">
	<div id="top">
		<table width="80%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title" align="center">S.no</td>
				<td class="title" align="center">Name</td>
				<td class="title" align="center">Type</td>
			</tr>
			<%for(int i=0;i<arrPromoterRow.size();i++)
			{
				arrCol=(ArrayList)arrPromoterRow.get(i);
				if(arrCol!=null&&arrCol.size()>0){%>
			<tr>
				<td align="center"><%=i+1 %></td>
				<td><%=Helper.correctNull((String)arrCol.get(0)) %></td>
				<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%} }%>
		</table>
		</div>
	</td>
</tr>
<%} %>
<%if(Helper.correctNull((String)hshValues.get("strgeclavailable")).equalsIgnoreCase("Y")){ %>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td class="title"><br>MIS Classification</td>
			</tr>
		</table>
		
				<tr>
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
			   <td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(11))))%></td>
			   <%} %>
			 </tr>
			 <tr>
				<td><b><%=strmisDesc[13] %></b><br></td>
					<%for(int i=0;i<arrColtemp.size();i++) 
				{
						val=arrColtemp.get(i).toString();
				arrColMIS	=  (ArrayList)arrMISRow.get(Integer.parseInt(val));
			   %>
			   <td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(13))))%></td>
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
			   <td align="right"><%=jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(16))))%></td>
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
<%} %>
<tr><td class="title">SPECIFIC TERMS AND CONDITIONS:</td></tr>
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
			      		<td width="3%" valign="top"><%=main%>.</td>
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
			      		<td valign="top">&nbsp;&nbsp;<%=main%>.<%=++sub%></td>
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
	}else{%>
	<tr><td style="border: none;"><%=strNil%></td></tr>
	<% }%>


	<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr> 
    <td valign="top"> 
    <jsp:include page="../print/com_AnnexureVII.jsp" flush="true">  
    <jsp:param name="pagetype" value="sancbranch" />       
    </jsp:include>
    </td>
	</tr>	
	</table>
	</td>
	</tr>
	
	
	<tr>
	<td>&nbsp;</td>
	</tr>	
	<tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td><b>&nbsp;&nbsp;&nbsp;&nbsp;AUTHORISED SIGNATORY</b></td></tr>	
	<tr>
	<td><hr></td>
	</tr>
	
	<tr>
	<td>&nbsp;</td>
	</tr>	
	<tr>
	<td>&nbsp;</td>
	</tr>
	
	<tr>
	<td><b>&nbsp;&nbsp;&nbsp;&nbsp;<u>For HO use:</u></b></td></tr>	
	<!-- Below table used to get the Facility Details -->
	<tr>
	<td colspan="2">
	<div id="top">
	<table width="95%"cellspacing="0" cellpadding="3" align="center"> 
	<tr> 
	<td width="25%" nowrap="nowrap"><b>Nature of A/c No</b></td>
	<td width="17%" align="center">&nbsp;</td>
	<td width="25%" align="center">&nbsp;</td>
	<td width="17%" align="center">&nbsp;</td>
	<td width="17%" align="center">&nbsp;</td>
	</tr>
	<tr> 
	<td width="25%" nowrap="nowrap"><b>Date of Release</b></td>
	<td width="17%" align="center">&nbsp;</td>
	<td width="25%" align="center">&nbsp;</td>
	<td width="17%" align="center">&nbsp;</td>
	<td width="17%" align="center">&nbsp;</td>
	</tr>
	<tr> 
	<td width="25%" nowrap="nowrap"><b>Due Date</b></td>
	<td width="17%" align="center">&nbsp;</td>
	<td width="25%" align="center">&nbsp;</td>
	<td width="17%" align="center">&nbsp;</td>
	<td width="17%" align="center">&nbsp;</td>
	</tr>
	</table>
	<br>
	<br>
	</div>
	</td>
	</tr>
	<!-- End-->
	
	
	<tr>
	<td>&nbsp;</td>
	</tr>	
	<tr>
	<td>&nbsp;</td>
	</tr>
	<tr>
	<td><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Clerk&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Officer/Manager/Senior Manager</b></td></tr>
</table>
<br>
<br>
<%if(arrBAOurRow.size()!=0) {%>
<div id="top" class="printbreak">
<br>
			<div  align="center"><b>Details of existing credit 
facilities of the borrower with our Bank.</b></div>
			
<br>
<br>	
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
	arrCol= new ArrayList();
	arrCol	= (ArrayList)arrBAOurRow.get(i);
	System.out.println(arrCol);
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
<%} %>
<div id="top" class="printbreak">
<br>
			<div  align="center"><b>Details of existing credit 
facilities of the borrower with other Bank.</b></div>
			
<br>
<br>	
<%
String intRate1="" ,totalIntRate="";
if(arrMultipleWC!=null && arrMultipleWC.size()>0)
{ 
	totalIntRate = Helper.correctNull((String)hshRecord.get("dblWCMtplIntRate"));
%>
	<tr>
		<td class="title"><br>Working Capital:</td>
	</tr>
	<tr>
		<td align="right" width=""><%=strAmtValueIn%></td>
	</tr>
	<tr>
		<td>
			<div id="top">
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
					<tr>
						<td width="15%" align="center">Name of the Bank</td>
						<td width="15%" align="center">Facility</td>
						<td width="10%" align="center">Type</td>
						<td width="8%" align="center">Limit</td>
						<td width="8%" align="center">Outstanding</td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td width="8%" align="center">Interest (%)</td>
						<% } %><td width="10%" align="center">Branch Name</td>
						<td width="10%" align="center">Email Id</td>
						<%if(strWCMultiple.equalsIgnoreCase("Y")){ %>
						<td width="24%" align="center">Remarks</td>
						<%} %>
						
					</tr>
			<%	for(int i=0;i<arrMultipleWC.size();i++)
				{
					arrCol	= (ArrayList)arrMultipleWC.get(i);
				%>
					<tr>
					<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(9))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull(Helper.correctNull((String)arrCol.get(10))).toUpperCase()%></td>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))),strAmountValue)%></td>
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="right">
						<%
							intRate1 = Helper.correctNull((String)arrCol.get(7));
							if(intRate1.equals("")) {
								out.print(intRate1);
							}
							else {
								out.print(Helper.checkDecimal(intRate1));
							}}
							%>
						</td>
							<td align="left"><%=Helper.correctNull((String)arrCol.get(13))%></td>
						
												<td align="left"><%=Helper.correctNull((String)arrCol.get(12))%></td>
						<% if(strWCMultiple.equalsIgnoreCase("Y")){ %>
						<td align="left"><%=Helper.correctNull((String)arrCol.get(8))%></td>
						<%} %>
											
						
					</tr>
			<%}  if(arrMultipleWC!=null && arrMultipleWC.size()>0) { %>
				<tr>
						<td align="left">TOTAL</td>
						<td align="left">&nbsp;</td>
						<td align="left">&nbsp;</td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCMtplLimit"))))),strAmountValue)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctNull(jtn.format(Double.parseDouble(Helper.correctDouble((String)hshRecord.get("dblWCMtplOutstand"))))),strAmountValue)%></td>
						<!--<td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)hshRecord.get("dblWCMtplIntRate")))%></td>
						-->
						<% if(!totalIntRate.equals("0.0") && !totalIntRate.equals("0.00")) { %>
						<td align="left">&nbsp;</td>
						<% }%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%if(strWCMultiple.equalsIgnoreCase("Y")){%>
						<td align="left">&nbsp;</td>
						<%} %>
						
					</tr>
				
				<% } %>
				</table>
			</div>
		</td>
	</tr>
<% }  %>
</div>

</body>
</html>
