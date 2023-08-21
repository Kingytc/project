<%@include file="../share/directives.jsp"%>
<%
String strProcessDate=Helper.correctNull((String)hshValues.get("app_processdate"));
if(strProcessDate.equalsIgnoreCase(""))
	strProcessDate=Helper.getCurrentDateTime();
long lngDatediff=Helper.dateDiff(ApplicationParams.getStrRetailTCEffectDate(),strProcessDate);

	String strConstitution="";
	String strStaff="";
	ArrayList arrRow=new ArrayList();
	ArrayList arrayRow=new ArrayList();
	ArrayList arrayTermsRow=new ArrayList();
	ArrayList arrayPartnersRow=new ArrayList();
	ArrayList arrayGoldRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrayCol=new ArrayList();
	ArrayList arrayTermsCol=new ArrayList();
	ArrayList arrayPartnersCol=new ArrayList();
	ArrayList arrayGoldCol=new ArrayList();
	ArrayList arrayTermType=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
		arrayRow=(ArrayList)hshValues.get("arrayRow");
		arrayTermsRow=(ArrayList)hshValues.get("arrayTermsRow");
		arrayPartnersRow=(ArrayList)hshValues.get("arrayPartnersRow");
		arrayGoldRow=(ArrayList)hshValues.get("arrayGoldRow");
		arrayTermType=(ArrayList)hshValues.get("arrayTermType");
	}
	strConstitution=Helper.correctNull((String)hshValues.get("strConstitution"));
	strStaff=Helper.correctNull((String)hshValues.get("strStaff"));
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strPrdtype = Helper.correctNull((String)hshValues.get("strprdtype"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sanction Letter </title>
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
<script>
function disableStaffNoDesignation()
{
	var varStaff="<%=strStaff%>";
	if(varStaff=="02")
	{
		document.all.id_isStaff.style.visibility="visible";
		document.all.id_isStaff.style.position="absolute";	
	}
	else
	{
		document.all.id_isStaff.style.visibility="hidden";
		document.all.id_isStaff.style.position="relative";
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body onload="disableStaffNoDesignation();">
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td>
		<table width="95%" border="0" cellpadding="2" cellspacing="0"  align="center">
		<tr>
			<td>
				<table width="100%" border="0" align="center" cellpadding="2" cellspacing="0">
				<tr> 
					<td align="center"><br>
						<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg">
					</td>
				</tr>
				<%
					String strHeadOffAddr1=Helper.correctNull((String)hshValues.get("strHeadOffAddr1"));
					String strHeadOffAddr2=Helper.correctNull((String)hshValues.get("strHeadOffAddr2"));
					String strHeadOffCity=Helper.correctNull((String)hshValues.get("strHeadOffCity"));
					String strHeadOffState=Helper.correctNull((String)hshValues.get("strHeadOffState"));
					String strHeadOffZip=Helper.correctNull((String)hshValues.get("strHeadOffZip"));
				%>
				<tr align="center"> 
					<td><b>(Regd. & HO:
						<%if(!strHeadOffAddr1.equalsIgnoreCase("")) {%>
							&nbsp;<%=strHeadOffAddr1%>,
						<%} if(!strHeadOffAddr2.equalsIgnoreCase("")) {%>
							<%=strHeadOffAddr2%>,
						<%} if(!strHeadOffCity.equalsIgnoreCase("")) {%>
							<%=strHeadOffCity%>,
						<%} if(!strHeadOffState.equalsIgnoreCase("")) {%>
							<%=strHeadOffState%>
						<%} if(!strHeadOffZip.equalsIgnoreCase("")) {%>
							- <%=strHeadOffZip%>
						<%} %>)
					</b></td>
				</tr>
				<%if(!Helper.correctNull((String) hshValues.get("orgname")).equalsIgnoreCase("")) {%>
				<!--<tr align="center"> 
					<td><b><%=Helper.correctNull((String) hshValues.get("orgname"))%> </b></td>
				</tr>-->
				<%} %>
				<%
					String orgadd1=Helper.correctNull((String) hshValues.get("orgadd1"));
					String orgadd2=Helper.correctNull((String) hshValues.get("orgadd2"));
					String orgcity=Helper.correctNull((String) hshValues.get("orgcity"));
					String orgstate=Helper.correctNull((String) hshValues.get("orgstate"));
					String orgzip=Helper.correctNull((String) hshValues.get("orgzip"));
					String orgphone=Helper.correctNull((String) hshValues.get("orgphone"));
				%>
				<!--<tr align="center"> 
					<td>
						<b>
						<%if(!orgadd1.equalsIgnoreCase("")) {%>
						<%=orgadd1%>,
						<%} if(!orgadd2.equalsIgnoreCase("")) {%>
						&nbsp;<%=orgadd2%>,
						<%} if(!orgcity.equalsIgnoreCase("")) {%>
						&nbsp;<%=orgcity%>,
						<%} if(!orgstate.equalsIgnoreCase("")) {%>
						&nbsp;<%=orgstate%>
						<%} if(!orgzip.equalsIgnoreCase("")) {%>
						-&nbsp;<%=orgzip%>
						<%}%>.
						<%if(!orgphone.equalsIgnoreCase("")) {%>
						<br>
						Tel No : <%=orgphone%></b>
						<%} %> 
					</td>
				</tr>-->
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
				<tr> 
					<td width="20%">Branch&nbsp;:</td>
					<td width="30%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("homebranch"))%></b></td>
					<td width="20%">Branch Code&nbsp;:</td>
					<td width="30%">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("branchcode"))%></b></td>
				</tr>
				<tr>
					<td <%if(!Helper.correctNull((String)hshValues.get("APP_REFERENCENO")).equalsIgnoreCase("")){ %> rowspan="2"<%} %>>Sanction Ref No&nbsp;:</td>
					<td nowrap="nowrap" colspan="3">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strSanctRefNum"))%></b></td>
				</tr>
				<%if(!Helper.correctNull((String)hshValues.get("APP_REFERENCENO")).equalsIgnoreCase("")){ %>
				<tr>
				<td colspan="3" ><%=Helper.correctNull((String)hshValues.get("APP_REFERENCENO"))%></td>
				</tr>
				<%} %>
				<tr>
					<td>Sanction Dept&nbsp;:</td>
					<td colspan="3">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strSancAppraisalDept"))%></b></td>
				</tr>
				<!--<tr>
					<td>Party file No&nbsp;:</td>
					<td colspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("strPartyFileNo")) %></td>
				</tr>
				--><tr id="id_isStaff">
					<td>Staff No&nbsp;:</td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strStaffID"))%></td>
					<td>Designation&nbsp;:</td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strDesignation")) %></td>
				</tr>
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
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td align="left"><b>APPLICANT/S NAME & ADDRESS</b></td>
		</tr>
		<tr>
			<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
				<%
				if(arrRow!=null&&arrRow.size()>0)
				{
					for(int i=0;i<arrRow.size();i++)
					{
						arrCol=(ArrayList)arrRow.get(i);
						String strVal1=Helper.correctNull((String) arrCol.get(1));
						String strVal2=Helper.correctNull((String) arrCol.get(2));
						String strVal3=Helper.correctNull((String) arrCol.get(3));
						String strVal4=Helper.correctNull((String) arrCol.get(4));
						String strVal5=Helper.correctNull((String) arrCol.get(5));
						String strVal6=Helper.correctNull((String) arrCol.get(6));
						String strVal7=Helper.correctNull((String) arrCol.get(7));
						String strVal8=Helper.correctNull((String) arrCol.get(8));
						String strVal9=Helper.correctNull((String) arrCol.get(9));
				%>
				<tr>
					<td align="center" width="30%">
						<%=Helper.correctNull((String) arrCol.get(0))%>
					</td>
					<td>
						<%if(!strVal1.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal1%>,<br>
						<%} if(!strVal2.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal2%>,<br>
						<%} if(!strVal3.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal3%>,<br>
						<%} if(!strVal4.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal4%>,<br>
						<%} if(!strVal5.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal5%> (Dt),<br>
						<%} if(!strVal6.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal6%> 
						<%} if(!strVal7.equalsIgnoreCase("")){ %>
						&nbsp; - <%=strVal7%>,<br>
						<%} if(!strVal8.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal8%>
						<%} if(!strVal9.equalsIgnoreCase("")){ %>
						&nbsp;<%=strVal9%>.
						<%} %>
					</td>
				</tr>
				<%
					}
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
<%if(arrayRow!=null&&arrayRow.size()>0) {%>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td align="left"><b>GUARANTORS/CO-OBLIGANTS NAME & ADDRESS</b></td>
		</tr>
		<tr>
			<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
				<%if(arrayRow!=null&&arrayRow.size()>0) {
					for(int i=0;i<arrayRow.size();i++){
						arrayCol=(ArrayList)arrayRow.get(i);
						String strGuarVal1=Helper.correctNull((String) arrayCol.get(1));
						String strGuarVal2=Helper.correctNull((String) arrayCol.get(2));
						String strGuarVal3=Helper.correctNull((String) arrayCol.get(3));
						String strGuarVal4=Helper.correctNull((String) arrayCol.get(4));
						String strGuarVal5=Helper.correctNull((String) arrayCol.get(5));
						String strGuarVal6=Helper.correctNull((String) arrayCol.get(6));
						String strGuarVal7=Helper.correctNull((String) arrayCol.get(7));
						String strGuarVal8=Helper.correctNull((String) arrayCol.get(8));
						String strGuarVal9=Helper.correctNull((String) arrayCol.get(9));
						%>
				<tr>
					<td align="center" width="30%">
						<%=Helper.correctNull((String) arrayCol.get(0))%>
					</td>
					<td>
						<%if(!strGuarVal1.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal1%>,<br>
						<%} if(!strGuarVal2.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal2%>,<br>
						<%} if(!strGuarVal3.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal3%>,<br>
						<%} if(!strGuarVal4.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal4%>,<br>
						<%} if(!strGuarVal5.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal5%>,<br>
						<%} if(!strGuarVal6.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal6%>
						<%} if(!strGuarVal7.equalsIgnoreCase("")){ %>
						&nbsp; - <%=strGuarVal7%>,<br>
						<%} if(!strGuarVal8.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal8%>,
						<%} if(!strGuarVal9.equalsIgnoreCase("")){ %>
						&nbsp;<%=strGuarVal9%>.<br>
						<%} %>
					</td>
				</tr>
				<%}}%>
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
<%} %>
<%if(!strConstitution.equalsIgnoreCase("01")&&!strConstitution.equalsIgnoreCase("02")) {%>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td align="left"><b>MANAGEMENT DETAILS</b></td>
		</tr>
		<tr>
			<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
				<tr>
					<td width="15%" align="center">Sl.No</td>
					<td width="50%" align="center">Name of the Partners / Directors / Proprietor / Trustees / Managing committee members</td>
					<td width="15%" align="center">Age(Yrs)</td>
					<td width="20%" align="center">Relationship</td>
				</tr>
				<%
					if(arrayPartnersRow!=null&&arrayPartnersRow.size()>0)
					{
						for(int z=0;z<arrayPartnersRow.size();z++)
						{
							arrayPartnersCol=(ArrayList)arrayPartnersRow.get(z);
				%>
				<tr>
					<td align="center"><%=z+1%></td>
					<td align="left">&nbsp;<%=arrayPartnersCol.get(0)%></td>
					<td align="center"><%=arrayPartnersCol.get(1)%></td>
					<td align="center"><%=arrayPartnersCol.get(2)%></td>
				</tr>
				<%
						}
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
<%} %>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="3">
		<tr>
			<td colspan="2">
				Dear Sir(s)/Madam,<br>
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Your application dated&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strInwardDate"))%></b>&nbsp;for the Credit facility.<br>
				<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;We are pleased to inform the <%=Helper.correctNull((String)hshValues.get("strRenewFlg"))%> of the following facility with the terms and conditions detailed below.
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="3">
		<tr>
			<td align="left"><b>FACILITY DETAILS</b></td>
			<td align="right"><b>Amount in Rs</b></td>
		</tr>
		<tr>
			<td colspan="2">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
					<tr>
						<td width="25%" align="center"><b>Description</b></td>
						<td width="25%" align="center"><b>Facility</b></td>
						<td width="25%" align="center"><b>Description</b></td>
						<td width="25%" align="center"><b>Facility</b></td>
					</tr>
					<tr>
						<td align="left">Nature Of Loan</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdLoanTypeRetail"))%></td>
						<td align="left">Limit (Rs.)</td>
						<td>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strSancAmount"))))%></td>
					</tr>
					<tr>
						<td align="left">Sector of advance</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strMISClassification"))%></td>
						<td align="left">Product Name</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					</tr>
					<tr>
						<td align="left" rowspan="4">Purpose of Advance</td>
						<td rowspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("strLoanPurpose"))%></td>
						<td align="left" rowspan="4">MIS Classification</td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String)hshValues.get("strSector"))%></td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String)hshValues.get("strSubSector"))%></td>
					</tr>
					<tr>
						<td><%=Helper.correctNull((String)hshValues.get("strPurpose"))%></td>
					</tr>
					<tr>
						<td align="left">Period of Loan</td>
						<td>&nbsp;<%=Helper.correctInt((String)hshValues.get("strRepayPeriod"))%>&nbsp;Months</td>
						<td align="left">Rate of Interest (%)</td>
						<td>&nbsp;<%if(Helper.correctNull((String)hshValues.get("strIntType")).equalsIgnoreCase("Floating")){if(Helper.correctNull((String)hshValues.get("strMCLRFlag")).equalsIgnoreCase("Y")){ %><%=Helper.correctNull((String)hshValues.get("mclr_type")) %>  <%}else{ %> Base Rate <%} %>&nbsp;<%=Helper.correctNull((String)hshValues.get("strSymbol"))%>&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblAdjustment"))))%>&nbsp;%<br>
						&nbsp;i.e&nbsp;<%} %><b><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strIntRate"))))%></b> % &nbsp;p.a.
					</tr>
					<tr>
						<td align="left">Interest Demand Frequency</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strIntDemandFreq"))%></td>
						<td align="left">Mode of Operation</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strModeOfOper"))%></td>
					</tr>
					<tr>
						<td align="left">Repayment pattern</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strRepayType"))%></td>
						<td align="left">Due Date of loan</td>
						<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strDueDate"))%></td>
					</tr>
					<tr>
					<td colspan="4">Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("strProcessingFee")) %></b> + Applicable Taxes</td>
					</tr>
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
<%if(Helper.correctNull((String)hshValues.get("strMCLRFlag")).equalsIgnoreCase("Y")){ %>
<tr>
<td>
	<table width="95%" border="0" align="center" cellpadding="2" cellspacing="3">
		<tr>
			<td style="border: none;">Rate of interest is subject to change from time to time.Present applicable <%if(Helper.correctNull((String)hshValues.get("strMCLRFlag")).equalsIgnoreCase("Y")){ %><%=Helper.correctNull((String)hshValues.get("mclr_type")) %>  <%}else{ %> BR <%} %> is &nbsp;<b><%=Helper.correctDouble((String)hshValues.get("dblBaseRate"))%> &nbsp;%</b>&nbsp;p.a.</td>
	</tr>
	</table>
</td>
</tr>
<%} %>
<%if(strPrdtype.equalsIgnoreCase("pG")){ %>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="0">
		<tr>
			<td align="left"><b>BRIEF DESCRIPTION OF SECURITY</b></td>
		</tr>
		<tr>
			<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
					<tr>
						<td align="center" rowspan="2" width="5%">Sl.No</td>
						<td align="center" rowspan="2" width="19%">Description of Gold ornaments</td>
						<td align="center" rowspan="2" width="8%">Quantity</td>
						<td align="center" colspan="2" width="15%">Weight in Articles (gm.) </td>
						<td align="center" rowspan="2" width="8%">Purity</td>
						<td align="center" rowspan="2" width="15%">Last Market Rate as per IBJA</td>
						<td align="center" rowspan="2" width="19%">Average of previous 30 day's closing Gold Rate as per IBJA</td>
						<td align="center" rowspan="2" width="19%">Estimated value of the article <br/>(in Rs.)</td>
					</tr>
					<tr>
						<td align="center">Gross</td>
						<td align="center">Net</td>
					</tr>
					<%
						if(arrayGoldRow!=null&&arrayGoldRow.size()>0)
						{
							for(int y=0;y<arrayGoldRow.size();y++)
							{
								arrayGoldCol=(ArrayList)arrayGoldRow.get(y);
					%>
					<tr>
						<td align="center"><%=y+1%></td>
						<td align="left"><%=Helper.correctNull((String)arrayGoldCol.get(1))%></td>
						<td align="center"><%=Helper.correctInt((String)arrayGoldCol.get(6))%>&nbsp;nos.</td>
						<td align="center"><%=Helper.correctNull((String)arrayGoldCol.get(2))%></td>
						<td align="center"><%=Helper.correctNull((String)arrayGoldCol .get(3))%></td>
						<td align="center"><%=Helper.correctNull((String)arrayGoldCol .get(7))%></td>
						<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrayGoldCol.get(4))))%></td>
						<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrayGoldCol.get(8))))%></td>
						<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrayGoldCol.get(5))))%></td>
					</tr>
					<%
							}
						}
					%>
					<tr>
						<td align="right" colspan="8">Total&nbsp;</td>
						<td align="right">&nbsp;<b><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbESTRATE1"))))%></b></td>
					</tr>
				</table>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
<%}
if(strPrdtype.equalsIgnoreCase("pR")){ %>
<tr>
<td>
		<table width="95%" border="0" align="center" cellpadding="2"
			cellspacing="0">
			<tr>
				<td align="left"><b>Deposit Details</b></td>
			</tr>
			<tr>
				<td>
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">

					<tr align="center" class="header">
						<td width="3%">s.no&nbsp;</td>
						<td width="6%" nowrap>Deposit Type</td>
						<td width="10%" nowrap>Issuing Branch <br/> Post Office</td>
						<td width="10%" nowrap>Account No</td>
						<td width="10%" nowrap>Deposit Owner Name</td>
						<td width="7%" nowrap>Date of Issue</td>
						<td width="8%" nowrap>Face Value <br/>(Rs.)</td>
						<td width="6%" nowrap>ROI %</td>
						<td width="8%" nowrap>Present O/S <br/>(Rs.)</td>
						<td width="8%" nowrap>Maturity<br/> Value <br/>(Rs.)</td>
						<td width="7%" nowrap>Maturity <br/> Date</td>
<!--						<td width="11%">Rate of Interest Charged on Loan / OverDraft-->
<!--						against deposit %</td>-->
					</tr>
					
					<%
						arrRow=(ArrayList)hshValues.get("arrDepositRow");
						if(arrRow!=null&&arrRow.size()>0)
						{
							for(int y=0;y<arrRow.size();y++)
							{
								arrCol=(ArrayList)arrRow.get(y);
					%>
					<tr>
						<td align="center"><%=y+1%></td>
						<td align="center"><%=Helper.correctNull((String) arrCol.get(0))%></td>
						<td align="center"><%=Helper.correctNull((String) arrCol.get(1))%></td>
						<td align="center" valign="top"><%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td><%=Helper.correctNull((String)arrCol.get(2))%></td>
						<td align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(5)))%>&nbsp;</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(6)))%>&nbsp;</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(7)))%>&nbsp;</td>
						<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(9)))%>&nbsp;</td>
						<td align="center"><%=Helper.correctNull((String)arrCol.get(11))%></td>
<!--						<td align="right"><%//=Helper.checkDecimal(Helper.correctDouble((String)arrCol.get(12)))%>&nbsp;</td>-->
					</tr>
					<%
							}
						}else{
					%>
					<tr>
					<td align="center" colspan="11">-- Nil --</td>
					</tr>
					<%} %>
				</table>
				</div>
				</td>
			</tr>
		</table>
		</td>
</tr>
<%} %>
<% if(!Helper.correctNull((String)hshValues.get("cmt_retailprimarycomments")).trim().equals("")) { %>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="3" cellspacing="3" class="outertable">
		<tr>
			<td align="left"><b>Primary Security : </b></td>
		</tr>
		<tr>
			<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("cmt_retailprimarycomments"))%></td>
		</tr>
		</table>
	</td>
</tr>
<% } if(!Helper.correctNull((String)hshValues.get("cmt_retailcollateralcomments")).trim().equals("")) { %>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="3" cellspacing="3" class="outertable">
		<tr>
			<td align="left"><b>Collateral Security : </b></td>
		</tr>
		<tr>
			<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("cmt_retailcollateralcomments"))%></td>
		</tr>
		</table>
	</td>
</tr>
<%} %>
<tr>
	<td>&nbsp;</td>
</tr>

<%if(arrayTermType!=null&&arrayTermType.size()>0) {%>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="3">
		<tr>
			<td align="left"><b>Terms & Conditions:</b></td>
		</tr>
		<%int j=1;
		if(lngDatediff>=0){ %>
		<tr>
			<td align="left"><b>General Conditions:</b></td>
		</tr>
		<tr>
			<td align="center"><b>Pre Disbursement Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("G")&&Helper.correctNull((String)arrayTermsCol.get(2)).equalsIgnoreCase("pre")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<tr>
			<td align="center"><b>Post Disbursement Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%j=1;
				if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("G")&&Helper.correctNull((String)arrayTermsCol.get(2)).equalsIgnoreCase("post")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<%} %>
		<tr>
			<td align="center"><b>Specific Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%j=1;
				if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("P")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<tr>
			<td align="center">
			<%if(lngDatediff<0){ %>
				<b>General Conditions:</b>
				<%}else{ %>
				<b>Product based Terms & Conditions:</b>
				<%} %>
			</td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
					<%j=1;
					if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("S")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<%
		if(lngDatediff>=0){%>
		<tr>
			<td align="center"><b>Other Conditions:</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
				<%j=1;
				if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("O")){%>
					<tr>
						<td><p align="justify"><%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}
				if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		<%} %>
		<tr>
			<td align="left"><b>Instructions to the Branch</b></td>
		</tr>
		<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
					<%j=1;
					if(arrayTermsRow!=null&&arrayTermsRow.size()>0){
					for(int i=0;i<arrayTermsRow.size();i++){
					arrayTermsCol=(ArrayList)arrayTermsRow.get(i);
					if(Helper.correctNull((String)arrayTermsCol.get(0)).equalsIgnoreCase("B")){%>
					<tr>
						<td><p align="justify">&nbsp;<%=j++%>.&nbsp;<%=Helper.correctNull((String)arrayTermsCol.get(1))%></p></td>
					</tr>
				<%}}}if(j==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
				</table>
				</div>
			</td>
		</tr>
		</table>
	</td>
</tr>
<%} %>
<tr>
	<td>&nbsp;</td>
</tr>
<tr>
	<td>
		<table width="95%" border="0" align="center" cellpadding="2" cellspacing="3">
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td align="right">&nbsp;<b><%=Helper.correctNull((String)hshValues.get("strSancAuthDesc"))%></b></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I/We acknowledge the receipt of
				Credit sanction intimation and also hereby confirm that the terms and conditions are
				acceptable to me/us. I/We undertake to furnish all necessary particulars required by
				the Bank as and when called for.</p>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td align="left">Signature of the Applicant</td>
		</tr>
		<tr>
			<td align="left">Date:&nbsp;<b><%=Helper.getCurrentDateTime()%></b></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
<br>
<br>
</form>
</body>
</html>