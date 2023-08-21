<%@include file="../share/directives.jsp"%>


<%
String strProcessDate=Helper.correctNull((String)hshValues.get("app_processdate"));
if(strProcessDate.equalsIgnoreCase(""))
	strProcessDate=Helper.getCurrentDateTime();
long lngDatediff=Helper.dateDiff(ApplicationParams.getStrRetailTCEffectDate(),strProcessDate);
	int i=1;
    int k=0;
	HashMap hshResult=new HashMap();
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	ArrayList arrayCol=new ArrayList();
	ArrayList arrIncAssessmentData = new ArrayList();
	ArrayList arrAssessmentData = new ArrayList();
	ArrayList arrAssessmentDisp = new ArrayList();
	ArrayList arrayRow=new ArrayList();
	ArrayList arrGoldRow=new ArrayList();
	ArrayList arrDepdet=new ArrayList();
	
	ArrayList arrGurdetails = new ArrayList();
	ArrayList arrDeleRow=(ArrayList)hshValues.get("arrDelRow");
int arraySize=0;
if(arrRow!=null)
{
   arraySize=arrRow.size();
}
	if(hshValues!=null){
	arrRow = (ArrayList) hshValues.get("arrRow");
	arrayRow = (ArrayList) hshValues.get("arrayRow");
	arrGurdetails=(ArrayList)hshValues.get("arrGuardetailsRow");
	arrGoldRow=(ArrayList)hshValues.get("arrGoldRow");
	arrDepdet=(ArrayList)hshValues.get("arrDepdet");
	hshResult=(HashMap)hshValues.get("hshResult");
	}
	String strMargin="";
	HashMap hshIncAssessmentValues = new HashMap();
	if(hshResult!=null&&hshResult.size()>0)
	{
		if (hshResult.get("hshInc") != null) 
		{
			hshIncAssessmentValues = (HashMap) hshResult.get("hshInc");
		}
		if (hshIncAssessmentValues.get("arrIncAssessment") != null) 
		{
			arrIncAssessmentData = (ArrayList) hshIncAssessmentValues.get("arrIncAssessment");
		}
		if (hshResult.get("arrAssessment") != null) 
		{
			arrAssessmentData = (ArrayList) hshResult.get("arrAssessment");
		}
		
		strMargin=Helper.correctDouble((String)hshResult.get("strGoldMargin"));
	}
	int intarrSize1=0;
	if(arrRow!=null)
	{
		intarrSize1=arrRow.size();
	}
	
		String eligible="";
		String strPrdtype = Helper.correctNull((String)hshValues.get("prd_type"));

		ArrayList arrAppBasicInfo=new ArrayList();
		arrAppBasicInfo=(ArrayList)hshValues.get("arrAppBasicInfo");
		String strTemp="";
		int intTemp=0;
		String strAmountForm=Helper.correctNull((String)request.getParameter("strAmountVal"));
		String strAmountVal="Rs.";
		if(strAmountForm.equalsIgnoreCase("L"))
			strAmountVal="Lakhs";
		else if(strAmountForm.equalsIgnoreCase("C"))
			strAmountVal="Crores";
	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<title>Process Note</title>
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
<table width="100%" border="1" cellspacing="0" cellpadding="0">
  <tr>
		<td>
		
      <table width="90%" border="0" cellpadding="3" cellspacing="0"  align="center">
	        <tr><td>
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
			</td></tr>
			
			<tr><td>
			<div id="top">
				    <table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    	<tr>
				    		<td width="16%"><b>Proposal ID</b></td>
				    		<td width="16%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strApplicationNo"))%></td>
				    		<td width="16%"><b>Borrower ID</b></td>
				    		<td width="16%">&nbsp;<%=Helper.correctNull((String) hshValues.get("cbsid"))%></td>
				    		<td width="16%"><b>Proposal Type</b></td>
				    		<td width="20%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strAppType"))%></td>
				    	</tr>
				    	
				    	<tr>
				    		<td><b>Branch:</b></td>
				    		<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("homebranch"))%></td>
				    		<td><b>Region:</b></td>
				    		<td colspan="2">&nbsp;<%=Helper.correctNull((String)hshValues.get("strOrgRegionName"))%></td>
				    	</tr>
				    	<tr>
				    		<td colspan="2"><b>Date Of Application</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("strAppReceivedDate"))%></td>
				    	</tr>
				    	<%if(!Helper.correctNull((String)hshValues.get("clpudate")).equalsIgnoreCase("")){ %>
				    	<tr>
				    		<td colspan="2"><b>Date of receipt of Physical Loan papers @ CLPU</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("clpudate"))%></td>
				    	</tr>
				    	<%} %>
				    	<%if(!Helper.correctNull((String)hshValues.get("app_clpudate")).equalsIgnoreCase("")){ %>
						<tr>
							<td colspan="2"><b>Date of receipt of complete information @ CLPU</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("app_clpudate"))%></td>
				    	</tr>
				    	<%} %>
				    	<%if(!Helper.correctNull((String)hshValues.get("app_cpcdate")).equalsIgnoreCase("")){ %>
				    	<tr>
				    		<td colspan="2"><b>Date of receipt of complete information @ CPC/RO/HO</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("app_cpcdate"))%></td>
				    	</tr>
				    	<%} %>
				    	<%if(!Helper.correctNull((String)hshValues.get("APP_ROHODATE")).equalsIgnoreCase("")){ %>
				    	<tr>
				    		<td colspan="2"><b>Date of receipt @ RO/HO with Branch recommendations</b></td>
				    		<td colspan="4">&nbsp;<%=Helper.correctNull((String)hshValues.get("APP_ROHODATE"))%></td>
				    	</tr>
				    	<%} %>
					</table>
					</div>
			</td></tr>
			
			<tr>
				<td>
					<table>
						<tr>
							<td width="3%"><b><%=i++%>.</b></td>
							<td width="40%"><b>(a) Sanctioning Authority</b></td>
							<td width="10%" align="center">:</td>
							<td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("sancauth"))%></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><b>(b) Purpose of credit facilities sought</b></td>
							<td width="10%" align="center">:</td>
							<td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("loan_purposeofloan"))%></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td><b>(c) Applicant Details</b></td>
							<td align="center">:</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
			<tr>
				<td width="25%"><b>Name of the Applicant</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("cus_name"))%></td>
			</tr>
			<tr>
				<td width="25%"><b>Communication Address</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_address1"))%><br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_address2"))%>&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_address3"))%><br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_district"))%>,&nbsp;<br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_city"))%>,&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_zip"))%><br>
								&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_state"))%>,&nbsp;<%=Helper.correctNull((String) hshValues.get("txtperapp_country"))%><br></td>
			</tr>
			<tr>
				<td width="25%"><b>Constitution</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strConstitution"))%></td>
			</tr>
			<tr>
				<td width="25%"><b>Dealing With us since</b></td>
				<td width="25%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strBankingSince"))%></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("COMINFO_GSTINREG")).equalsIgnoreCase("Y")){ %>
			<tr>
				<td width="25%"><b>GSTIN No.</b></td>
				<%String[] strArr=Helper.correctNull((String)hshValues.get("COMINFO_GSTIN")).split("@");
			%>
			<td align="left"><%
			for(int a=0;a<strArr.length;a++)
			{
			out.println(strArr[a]);%>
			</br/>
			<%}
			%></td>
			</tr>
			<%} %>
			
			<tr>
			<td align="left" ><b>Borrower status<b></td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("perapp_status"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Any relation to Bank Staff/Executive/Director<b> </td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff"))%></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("005")||Helper.correctNull((String)hshValues.get("perapp_relation_bankstaff_val")).equalsIgnoreCase("006")){ %>
			<tr>
			<td align="left" ><b>Staff ID <b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relat_staffid"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Staff Name<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%} else{%>
			<tr>
			<td align="left" ><b>Name of Bank's Director<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_relation_staffname"))%></td>
			</tr>
			<%}%>
			<tr>
			<td align="left" ><b>Relation to the borrower<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("perapp_blood_relation"))%></td>
			</tr>
			</table>
			</div>
			</td></tr>
			<%if(Helper.correctNull((String)hshValues.get("indinfo_is_staff")).equalsIgnoreCase("02")){ %>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;Staff Details</span><span style="float: right;"></span></b></td>
			</tr>
			
			<tr>
			<td>
			<div id="top">
			<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr>
			<td align="left" ><b>Staff ID<b> </td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("indinfo_staff_id"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Department Name<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("peremp_department"))%></td>
			</tr>
			<tr>
			<td align="left" ><b>Date of Joining<b> </td>
			<td align="left" ><%=Helper.correctNull((String)hshValues.get("indinfo_dateof_joining"))%></td>
			</tr>
			<tr>
			<td align="left" > <b>Retirement Date<b></td>
			<td align="left"><%=Helper.correctNull((String)hshValues.get("peremp_retdate"))%></td>
			</tr>
			</table>
			</div>
			</td></tr>
			<%} %>
			</table>
			</div>
			</td></tr>
			
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;(d) Joint Borrower Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="20%" align="center"><b>Name of the Borrower</b></td>
						<td width="20%" align="center"><b>Communication Address</b></td>
						<td width="20%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Relationship</td>
					</tr>
					<%
					if(arrayRow!=null&&arrayRow.size()>0)
					{
						for(int j=0;j<arrayRow.size();j++)
						{
							arrayCol=(ArrayList)arrayRow.get(j);
					%>
					<tr>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(0))%></td>
						<td align="left"><%=Helper.correctNull((String)arrayCol.get(1))%>&nbsp;</td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(2))%>&nbsp;</td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(5))%>&nbsp;</td>
					</tr>
					<%
						}
					}else{
					%>
					<tr>
					<td colspan="4" align="center"> - Nil -</td>
					</tr>
					<%} %>
				</table>
			</div>
			</td></tr>
			<tr>
				<td><b><span style="float: left;">&nbsp;&nbsp;(e) Guarantor/Co-obligant Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="20%" align="center"><b>Name of the Guarantor</b></td>
						<td width="20%" align="center"><b>Communication Address</b></td>
						<td width="20%" align="center"><b>Constitution</b></td>
						<td width="20%" align="center"><b>Relationship</td>
					</tr>
					<%
					if(arrGurdetails!=null&&arrGurdetails.size()>0)
					{
						arrayCol=new ArrayList();
						for(int j=0;j<arrGurdetails.size();j++)
						{
							arrayCol=(ArrayList)arrGurdetails.get(j);
					%>
					<tr>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(0))%></td>
						<td align="left"><%=Helper.correctNull((String)arrayCol.get(1))%>&nbsp;</td>
						<td align="center">&nbsp;<%=Helper.correctNull((String)arrayCol.get(2))%>&nbsp;</td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrayCol.get(5))%>&nbsp;</td>
					</tr>
					<%
						}
					}else{
					%>
					<tr>
					<td colspan="4" align="center"> - Nil -</td>
					</tr>
					<%} %>
				</table>
			</div>
			</td></tr>
			
			<%if(true){ %>
			<tr>
				<td>&nbsp;&nbsp;<b>(f) Basic Details :</b></td>
			</tr>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
						<td width="20%" align="center">&nbsp;</td>
						<td width="20%" align="center"><b>IT PAN</b></td>
						<td width="20%" align="center"><b>E-Mail ID</b></td>
						<td width="20%" align="center"><b>Mobile</td>
						<td width="20%" align="center"><b>Aadhar No</td>
					</tr>
					<%
					if(arrAppBasicInfo!=null && arrAppBasicInfo.size()>0){
						for(int j=0;j<arrAppBasicInfo.size();j++){
						arrCol=(ArrayList)arrAppBasicInfo.get(j);
						if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("a"))
						{strTemp="Applicant";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("c"))
						{strTemp="Co - Applicant";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("g"))
						{strTemp="Guarantor";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("o"))
						{strTemp="Co-Obligant";}
						else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("p"))
						{strTemp="Sole Properitier";}%>
					<tr>
						<td align="left" nowrap="nowrap">&nbsp;<%=Helper.correctNull((String)arrCol.get(0)) %> - <%=strTemp%></td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(3)) %>&nbsp;</td>					
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(2)) %>&nbsp;</td>					
						<td align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(5)) %>&nbsp;</td>					
					</tr>
					<%}}%>
				</table>
			</div>
			</td></tr>
			<%} %>
			<tr>
				<td><b><span style="float: left;"><%=i++%>.Present Proposal:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="5%" align="center"><b>Sl. No</b></td>
					<td width="15%" align="center"><b>Facility</b></td>
					<td width="15%" align="center"><b>Purpose of Loan under Bank Scheme</b></td>
					<td width="15%" align="center"><b>Limit </b></td>
					<td width="15%" align="center"><b>Period Sought</b></td>
					</tr>
					<tr>
					<td align="center">1.</td>
					<td><%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("LoanPurpose"))%></td>
					<td align="right">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("Limit")),strAmountForm)%></td>
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("loan_noofinstallment"))%> months</td>
					</tr>				    	
				</table>
			</div>
			</td></tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<%if(strPrdtype.equalsIgnoreCase("pG")){ %>
			<tr>
				<td><b><span style="float: left;"><%=i++%>. BRIEF DESCRIPTION OF SECURITY:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td>
			</tr>
			<tr><td>
			<div id="top">
			<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0" class="outertable">
				<TR  align="center"  class="tblhead">
					<TD WIDTH="4%" ROWSPAN="2"><B> Sl.No&nbsp;</B></TD>
					<TD WIDTH="21%" ROWSPAN="2"><B>Description of Articles</B></TD>
					<TD WIDTH="10%" ROWSPAN="2"><b>Quantity&nbsp;(Nos.)</b></TD>
					<TD COLSPAN="2"><B>Weight Of Articles (gm.)</B><B></B></TD>
					<TD WIDTH="10%" ROWSPAN="2"><B>Purity </B></TD>
					<TD WIDTH="13%" ROWSPAN="2"><B>Last Market Rate as per IBJA &nbsp;</B></TD>
					<TD WIDTH="13%" ROWSPAN="2"><B>Average of previous 30 day's closing Gold Rate as per IBJA</B></TD>
					<TD WIDTH="13%" ROWSPAN="2"><B><B>Estimated value of the
					article&nbsp;</B></B></TD>
				</TR>
				<TR class="tblhead">
					<TD WIDTH="8%" align="center"><B>Gross</B></TD>
					<TD WIDTH="8%" align="center" nowrap><B>Net (in 22 carat)</B></TD>
				</TR>
				
				<%if(arrGoldRow!=null && arrGoldRow.size()>0){
					double dblTotal=0;
						for (int l = 0; l < arrGoldRow.size(); l++) {
						arrCol = (ArrayList) arrGoldRow.get(l);
						dblTotal+=Double.parseDouble(Helper.correctDouble((String) arrCol.get(8)));%>
				<TR valign="top">
					<TD WIDTH="4%" ALIGN="center"><%=l+1 %></TD>
					<TD WIDTH="21%" ALIGN="left"><%=Helper.correctNull((String) arrCol.get(2))%></TD>
					<TD WIDTH="10%" ALIGN="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(9))%></TD>
					<TD WIDTH="8%" ALIGN="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></TD>
					<TD WIDTH="8%" ALIGN="left"><%=Helper.correctNull((String) arrCol.get(4))%></TD>
					<TD WIDTH="10%" ALIGN="left"><%=Helper.correctNull((String) arrCol.get(5))%></TD>
					<TD WIDTH="13%" ALIGN="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(6)),strAmountForm)%></TD>
					<TD WIDTH="13%" ALIGN="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(7)),strAmountForm)%></TD>
					<TD WIDTH="13%" ALIGN="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(8)),strAmountForm)%></TD>
				</TR>
						
				<%}%>
				<tr class="title">
				<td align="right" colspan="8">Total &nbsp; </td>
				<td align="right"><%=Helper.converAmount(Helper.formatDoubleValue(dblTotal),strAmountForm) %>&nbsp;</td>
				</tr>
				<%}else{ %>
				<tr>
				<td align="center" colspan="9"> - Nil -</td>
				</tr>
				<%} %>
			</TABLE>
			</div>
			</TD>
			</TR>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%if(!Helper.correctNull((String)hshValues.get("strAppraiserName")).equalsIgnoreCase("")){ %>
			<tr>
			<td>
			<div id="top">
			<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable">
				<TR class="tblhead">
				<td colspan="4"><%=i++%>. Appraisar Details</td>
				</TR>
				<tr>
				<td class="tblhead">Appraisar Name</td>
				<td><%=Helper.correctNull((String)hshValues.get("strAppraiserName")) %></td>
				<td class="tblhead">Appraisal Done on</td>
				<td><%=Helper.correctNull((String)hshValues.get("strAppraisalDoneon")) %></td>
				</tr>
			</TABLE>
			</div>	
 			</td>
			</tr>
			
			<tr>
				<td><b>Comments:</b><br><%=Helper.correctNull((String)hshValues.get("strAppraiserComments")) %></td>
			</tr>
			<%} %>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("strAgriLoanType")).equalsIgnoreCase("C")){
			ArrayList arrGoldAgri=(ArrayList)hshValues.get("arrGoldAgri");
			if(arrGoldAgri!=null && arrGoldAgri.size()>0){
			%>
			<tr>
			<td><b><%=i++%>. AGRI Gold Loan</b></td>
			</tr>
			<%if(Helper.correctNull((String)hshValues.get("strAgriType")).equalsIgnoreCase("P")){%>
			<tr>
			<td><b>Agri-Production</b></td>
			</tr>
			<%}else if(Helper.correctNull((String)hshValues.get("strAgriType")).equalsIgnoreCase("Q")){%>
			<tr>
			<td><b>Agri-Quick</b></td>
			</tr>
			<%}else if(Helper.correctNull((String)hshValues.get("strAgriType")).equalsIgnoreCase("S")){%>
			<tr>
			<td><b>Agri-Subvention</b></td>
			</tr>
			<%}%>
			<tr>
			<td>
			<div id="top">
			<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable">
				<TR class="tblhead" align="center">
				<td width="5%" align="center">S.No</td>
				<td width="25%" align="center">Area Under Cultivation(in acres)</td>
				<td width="35%" align="center">Nature of crops grown</td>
				<td width="20%" align="center">Scale of Finance</td>
				<td width="15%" align="center">Eligible loan amount</td>
				</TR>
				<%
				for(int l=0;l<arrGoldAgri.size();l++)
				{
				arrCol=(ArrayList)arrGoldAgri.get(l);%>
				<tr>
				<td><%=l+1 %></td>
				<td><%=Helper.correctDouble((String)arrCol.get(1))%></td>
				<td><%=Helper.correctDouble((String)arrCol.get(2))%></td>
				<td><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(3)),strAmountForm)%></td>
				<td><%=Helper.converAmount(Helper.correctDouble((String)arrCol.get(4)),strAmountForm)%></td>
				</tr>
					
				<%}
				%>
				<tr>
				<td colspan="4">A) Total</td>
				<td><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAgriTotalAmt")),strAmountForm)%>&nbsp;</td>
				</tr>
				<tr>
				<td colspan="4">B) Loan for Post harvest Expenses</td>
				<td><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAgriMarginVal")),strAmountForm)%>&nbsp;</td>
				</tr>
				<tr>
				<td colspan="4">Total Eligible Loan amount as per Scale of Finance/Cropping Pattern [A+B]</td>
				<td><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAgriEligAmt")),strAmountForm)%>&nbsp;</td>
				</tr>
			</TABLE>
			</div>
			</td>
			</tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<%} %>
			<%}else if(Helper.correctNull((String)hshValues.get("strAgriLoanType")).equalsIgnoreCase("A")){ %>
			<tr><td><b><%=i++%>. WORKING CAPITAL REQUIREMENT OF ALLIED ACTIVITIES</b> </td></tr>
			<tr><td><b><span style="float: left;">Loan Amount Eligible as per Expenditure per Operating Cycle</span></b><span style="float: right;">(Amount in <%=strAmountVal %>)</span> </td></tr>
			
			<tr>
			<td>
			<div id="top">
			<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="3" class="outertable">
			<tr>
			<td>S.no</td>
			<td>Description</td>
			<td>Amount</td>
			</tr>
			<tr>
			<td align="center" width="5%">1</td>
			<td width="65%">Total Recurring Expenses for One Year/Cycle </td>
			<td><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAgriTotalAmt")),strAmountForm)%>&nbsp;</td>
			</tr>
			<tr>
			<td align="center">2</td>
			<td width="45%"><%=Helper.correctDouble((String)hshValues.get("dblRecurrexpMargin"))%> % of the Recurring expenses  </td>
			<td><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAgriMarginVal")),strAmountForm)%>&nbsp;</td>
			</tr>
			<tr>
			<td align="center" width="5%">3</td>
			<td width="45%">Total Recurring Expenses for One Year/Cycle </td>
			<td><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strAgriEligAmt")),strAmountForm)%>&nbsp;</td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			
			<%} %>
			
			<%}else if(strPrdtype.equalsIgnoreCase("pR")){ %>
			<tr><td>&nbsp;</td></tr>
			<tr><td><b><span style="float: left;"><%=i++%>. DEPOSIT DETAILS </span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td></tr>
			
			<tr>
			<td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr class="tblhead">
					<td width="3%"><b>Sl.No</b></td>
					<td width="5%"><b>Deposit Type</b></td>
<!--					<td width="10%"><b>Issuing Branch</b></td>-->
					<td width="8%"><b>Account No</b></td>
					<td width="8%"><b>Deposit Owner Name</b></td>
					<td width="6%"><b>Date of Issue</b></td>
					<td width="8%"><b>Face Value</b></td>
					<td width="6%"><b>Rate of Interest %</b></td>
					<td width="8%"><b>Present O/S</b></td>
					<td width="7%"><b>Present O/S as on</b></td>
					<td width="8%"><b>Maturity Value</b></td>
					<td width="7%"><b>Maturity Date</b></td>
				</tr>
				<%if(arrDepdet!=null && arrDepdet.size()>0){
					for (int l = 0; l < arrDepdet.size(); l++) {
					arrCol=(ArrayList)arrDepdet.get(l);%>
					<tr valign="top">
							<td align="center"><%=l+1 %>
							</td>
							<%
								String strBankType=Helper.correctNull((String) arrCol.get(14));
								if(strBankType.equalsIgnoreCase("1"))
								{
									strBankType="Own";																
								}
								else if(strBankType.equalsIgnoreCase("2"))
								{
									strBankType="3rd Party";
								}
							%>
							<td align="center"><%=strBankType%></td>
<!--							<td align="center"><%//=Helper.correctNull((String) arrCol.get(1))%></td>-->
							<td align="center" valign="top"><%=Helper.correctNull((String)arrCol.get(3))%></td>
							<td align="center"><%=Helper.correctNull((String)arrCol.get(2))%></td>
							<td align="center"><%=Helper.correctNull((String)arrCol.get(4))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(5)),strAmountForm)%>&nbsp;</td>
							<td align="right"><%=Helper.checkDecimal(Helper.correctDouble((String) arrCol.get(6)))%>&nbsp;</td>
							<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(7)),strAmountForm)%>&nbsp;</td>
							<td align="center"><%=Helper.correctNull((String)arrCol.get(8))%></td>
							<td align="right"><%=Helper.converAmount(Helper.correctDouble((String) arrCol.get(9)),strAmountForm)%>&nbsp;</td>
							<td align="center"><%=Helper.correctNull((String) arrCol.get(11))%></td>
						</tr>
				
				<%}} %>
			</table>
			</div>
			</td>
			</tr>
			
			<%} %>
			
			<tr><td>&nbsp;</td></tr>
			<% if(hshResult.get("arrAssessment") != null)
			{%>
			<tr>
				<td>
					<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" class="outertable">
			<tr class="tblhead">
				<td colspan="2"><b><%=i++%>. ASSESSMENT BASED ON COST</b></td>
			</tr>
			<%	if (arrAssessmentData != null && arrAssessmentData.size() > 0)
				{
					for (int j = 0; j < arrAssessmentData.size(); j++)
					{	
					arrAssessmentDisp=(ArrayList)arrAssessmentData.get(j);
					%>
					<%if(Helper.correctNull((String)arrAssessmentDisp.get(0)).equalsIgnoreCase("Margin Required")){%>
					<tr>
						<td align="left"><%=arrAssessmentDisp.get(0)%></td>
						<td align="right"><%=Helper.removeHTMLTags((String)arrAssessmentDisp.get(1))%></td>
					</tr>
					<%}else{ %>
					<tr>
						<td align="left"><%=arrAssessmentDisp.get(0)%></td>
						<td align="right"><%=Helper.converAmount(Helper.correctDouble(Helper.removeHTMLTags((String)arrAssessmentDisp.get(1)).toString()),strAmountForm)%></td>
					</tr>
					<%}}
				}%>
			</table>
			</div>
				</td>
			</tr>
			
			<%} %>
			<%if(!Helper.correctNull((String)hshValues.get("assesscomments")).equalsIgnoreCase("")){ %>
			<tr>
			<td><b>Comments on Assessment :</b></td>
			</tr>
			<%} %>
			<tr>
			<td><%=Helper.correctNull((String)hshValues.get("assesscomments")) %></td>
			</tr>
			
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="4"><%=i++%>. MIS Details</td>
				    </tr>
					<tr class="tblhead">
					<td width="25%" align="center"><b>Descriptions</b></td>	
					<td width="25%" align="center"><b>Facility</b></td>
					<td width="25%" align="center"><b>Descriptions</b> </td>	
					<td width="25%" align="center"><b>Facility</b></td>				
					</tr>
					<tr>
					<td width="25%">Name of Bank Schematic Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("strBankSchemeDesc")) %></td>
					<td width="25%">Guarantee covered BY</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_Guarantee Covered")) %></td>				
					</tr>
					<tr>
					<td width="25%">Sector of Loan</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sctortloan"))%></td>
					<td width="25%">Sub Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subscetroloan"))%></td>				
					</tr>
					<tr>
					<td width="25%">Weaker Section</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_weaksection"))%></td>
					<td width="25%">Sensitive Sector</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_sensitivitysec"))%></td>				
					</tr>
					<tr>
					<td width="25%">Industry Category Type</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_indcattyepagr"))%></td>
					<td width="25%">Infrastructure</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_infrastructure"))%></td>					
					</tr>
					<tr>
					<td width="25%">Activity Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("app_activitycode")) %></td>
					<td width="25%">Main Activity</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_mainactivitydesc")) %></td>					
					</tr>
					<tr>
					<td width="25%">Sub Activity</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_subactdesc")) %></td>
					<td width="25%">Purpose</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_purpose")) %></td>					
					</tr>	
					<tr>
					<td width="25%">BSR Code</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsrcodedesc")) %></td>
					<td width="25%">BSR1 Code</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_bsr1codedesc")) %></td>					
					</tr>
					<%if(Helper.correctNull((String)hshValues.get("strisGovtScheme")).equalsIgnoreCase("1")){ %>
					<tr>
					<td width="25%" >Name of the Govt Sponsored</td>
					<td width="25%" colspan="3"><%=Helper.correctNull((String)hshValues.get("mis_govnysponser"))%></td>
					</tr>
					<%} %>	
					<tr>
					<%if(!Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Government announced scheme</td>
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_GovtSchemeDesc")) %></td>
					<%} %>
					<%if(!Helper.correctNull((String)hshValues.get("mis_StandupDesc")).equalsIgnoreCase("")){ %>
					<td width="25%">Stand Up India</td>	
					<td width="25%"><%=Helper.correctNull((String)hshValues.get("mis_StandupDesc")) %></td>		
					<%} %>			
					</tr>			    	
				</table>
			</div>
			</td></tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="4"><%=i++%>. CBS Details</td>
				    </tr>
				     <tr >
					<td width="50%" align="center" colspan="2" ><b>Facility Availing Branch</b></td>	
					<td width="50%" colspan="2" ><%=Helper.correctNull((String)hshValues.get("strOrg_Name")) %></td>	
					</tr>
				</table>
			</div>
			</td></tr>
			
			<%String strrec=Helper.correctNull((String)hshValues.get("Recommendation"));
			
			
			if(!strrec.equalsIgnoreCase("")){ %>
			<tr>
			<td>
			<div id="top">
			<table width="100%">
			<tr class="tblhead">
			
			<td><b><%=i++%>.RECOMMENDATION:</b></td></tr>
			<tr>
			<td style="text-align: justify">&nbsp;<%=Helper.correctNull((String)hshValues.get("Recommendation")) %></td>
			</tr>
			</table>
			</div>
			</td>
			</tr>
			<%} %>
			<tr>
			<td>&nbsp;</td>
			</tr>
			
			<%  String strfacnature=Helper.correctNull((String)hshValues.get("facnature"));
			
			if(!strfacnature.equalsIgnoreCase("")){
			%>
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
				    <tr>
				    <td colspan="8"><b><span style="float: left;">A. Sanction Details:</span><span style="float: right;">(Amount in <%=strAmountVal %>)</span></b></td></tr>
					<tr class="tblhead">
						<td width="5%" align="center">Sl. No</td>
						<td width="15%" align="center">Facility</td>
						<td align="center" colspan="2">Limit</td>
						<td width="10%" align="center">Rate Of Interest (%)</td>
						<td width="15%" align="center">Margin (%)</td>
						<td width="5%" align="center">Period (in Months)</td>
						<td width="15%" align="center">Mode of repayment</td>	
					</tr>
					<%if(Double.parseDouble(Helper.correctDouble((String)hshValues.get("strInsurancePremium")))!=0){%>
					<tr>
					<td align="center" rowspan="3">1.</td>
					<td rowspan="3">&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					<td>Loan Sanction Amount</td>
					<td align="right">&nbsp;<%=Helper.converAmount(String.valueOf(Double.parseDouble(Helper.correctDouble((String)hshValues.get("SancAmount")))-Double.parseDouble(Helper.correctDouble((String)hshValues.get("strInsurancePremium")))),strAmountForm)%>&nbsp;</td>
					<td align="center" rowspan="3">&nbsp;
					<%=Helper.correctDouble((String)hshValues.get("ROI"))%>&nbsp;
					</td>
					<td align="center" rowspan="3">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Margin"))%>&nbsp;</td>
					<td align="center" rowspan="3">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Terms"))%>&nbsp;</td>		
					<td align="center" rowspan="3">&nbsp;<%=Helper.correctDouble((String)hshValues.get("repaytype"))%>&nbsp;</td>
					</tr>
					<tr>
					<td>Premium for Met Loan &amp; Life Suraksha</td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("strInsurancePremium")),strAmountForm)%></td>
					</tr>
					<tr>
					<td>Total Loan Sanction Limit</td>
					<td align="right"><%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("SancAmount")),strAmountForm)%></td>
					</tr>
					<%}else{ %>
					<tr>
					<td align="center">1.</td>
					<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("strPrdDesc"))%></td>
					<td align="right" colspan="2">&nbsp;<%=Helper.converAmount(Helper.correctDouble((String)hshValues.get("SancAmount")),strAmountForm)%>&nbsp;</td>
					<td align="center">&nbsp;
					<%=Helper.correctDouble((String)hshValues.get("ROI"))%>&nbsp;
					</td>
					<%if(strPrdtype.equalsIgnoreCase("pR")){ %>
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Margin"))%>&nbsp;</td>
					<%}else{ %>
					<td align="center">&nbsp;<%=strMargin%>&nbsp;</td>
					<%} %>
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("Terms"))%>&nbsp;</td>		
					<td align="center">&nbsp;<%=Helper.correctDouble((String)hshValues.get("repaytype"))%>&nbsp;</td>
					</tr>
					<%} %>	
					<tr>
					<%if(Helper.correctNull((String)hshValues.get("strProcessingFee")).equals("W")) {%>
						<td colspan="8">Processing Charges : Waived </td>	
					<% }else { %>
						<td colspan="8">Processing Charges : Rs. <b><%=Helper.correctNull((String)hshValues.get("strProcessingFee")) %></b> + Applicable Taxes</td>	
					<% } %>
					</tr>
				</table>
			</div>
			</td></tr>
			<%} %>
			<tr>
			<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b>Terms and Conditions:</b></td>
			</tr>
			<%if(lngDatediff>=0){ %>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>General Conditions:</b></td>
			</tr>
			<tr>
				<td style="border: none;"><b>Pre Disbursement Conditions:</b></td>
			</tr>
			<% 
				k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("G") &&(Helper.correctNull((String)arrCol.get(2))).equalsIgnoreCase("pre")){
			%>

			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%} %> 
			<tr>
				<td style="border: none;"><br/><b>Post Disbursement Conditions:</b></td>
			</tr>
			<% 
				k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("G") &&(Helper.correctNull((String)arrCol.get(2))).equalsIgnoreCase("post")){
			%>

			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%} %> 
			</table>
			</div>
			</td>
			</tr>
			
			
			<%} %>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>Specific Conditions:</b></td>
			</tr>
			<% 
					k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("P")){
			%>

			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
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
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;">
				<%if(lngDatediff<0){ %>
				<b>General Conditions:</b>
				<%}else{ %>
				<b>Product based Terms & Conditions:</b>
				<%} %>
				</td>
			</tr>
			
			<% 
					k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("S")){
			%>
			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
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
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>Instructions to the branch:</b></td>
			</tr>
			
			<% 
					k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("B")){
			%> 
			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
			{%>
			<tr>
				<td align="justify">- Nil -</td>
			</tr>
			<%}%>
			</table>
			</div>
			</td>
			</tr>
			<%if(lngDatediff>=0){ %>
			<tr>
			<td>
			<div id="top">
			<table  width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
			<tr>
				<td style="border: none;"><b>Other Terms & Conditions:</b></td>
			</tr>
			<% 
				k=1;
					intarrSize1=0;
					if(arrRow!=null && arrRow.size()>0){			
					intarrSize1=arrRow.size();
					for (int j=0;j<intarrSize1;j++){ 
					
					arrCol = (ArrayList) arrRow.get(j);
					if((Helper.correctNull((String)arrCol.get(0))).equalsIgnoreCase("O")){
			%>

			<tr>
				<td align="justify"><%=k++%>.&nbsp;<%=Helper.correctNull((String)arrCol.get(1)) %></td>
			</tr>
			<%}}}
			if(k==1)
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
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			
			<tr><td>
				<span title="pagebreak" contentEditable="TRUE" onPaste="event.returnValue=false" onKeyDown="callKeyDown()"></span>
				<table width="100%" align="center" cellpadding="3" cellspacing="0" border="0">
				<%
				if (arrDeleRow != null && arrDeleRow.size() > 0) {
				for (i = 0; i < arrDeleRow.size(); i++) {
				arrCol = (ArrayList) arrDeleRow.get(i);
				%>
				<%
				if (i % 2 == 0) {
				%>
				<tr><td align="left"><br><%=Helper.correctNull((String) arrCol.get(1))%></td></tr>
				<tr><td align="left" class="title"><%=Helper.correctNull((String) arrCol.get(4))%></td></tr>
				<%
				} else {
				%>
				<tr><td align="right"><br><%=Helper.correctNull((String) arrCol.get(1))%></td></tr>
				<tr><td align="right" class="title"><%=Helper.correctNull((String) arrCol.get(4))%></td></tr>
				<%
				}
				%>
				<%
				}
				}
				%>
			</table>
			</td></tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b>Sanction Date: </b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<br>
</body>
</html>
