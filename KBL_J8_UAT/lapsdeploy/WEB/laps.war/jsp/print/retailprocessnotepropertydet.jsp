<%@include file="../share/directives.jsp"%>

<% int i=1;
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
<title>UBI</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
</SCRIPT>
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
  <tr>
		<td>
		
      <table width="100%" border="0" cellpadding="3" cellspacing="0"  align="center" class="outertable">		
			
			<tr>
				<td><b> Property Details [KBL Apna Ghar/Ghar Niveshan/Mortgage Loan]</b></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="40%" align="center"><b>Particulars</b></td>	
					<td width="60%" align="center"><b>Details</b></td>			
					</tr>
					<tr>
					<td width="5%"><b>Survey Number</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("phpa_prop_surveyno"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Plot No</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("phpa_prop_plotno"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Area</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("phpa_site_area"))%>&nbsp; <%=Helper.correctNull((String) hshValues.get("phpa_site_area_measurement"))%></td>			
					</tr>
					<!--<tr>
					<td width="5%"><b>Distance from the branch</b></td>
					<td width="25%"><%//=Helper.correctNull((String) hshValues.get("phpa_branch_distance"))%>&nbsp;</td>
				
					</tr>
					<tr>
					<td width="5%"><b>Age of the Building</b></td>
					<td width="25%"><%//=Helper.correctNull((String) hshValues.get("phpa_premises_age"))%>&nbsp;</td>
				
					</tr>-->
					<tr>
					<td width="5%"><b>Value as per Valuation</b></td>
					<td width="25%">Rs.&nbsp;<%=Helper.correctNull((String) hshValues.get("phpa_site_valuation_cost"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Date of Valuation</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("phpa_site_valuation_date"))%>&nbsp;</td>				
					</tr>	
					<tr>
					<td width="5%"><b>Name of the Bank approved Valuer</b></td>
					<% if(("2122").equalsIgnoreCase(Helper.correctNull((String) hshValues.get("phpa_site_valuer_code")))){%>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("phpa_site_valuer_name"))%> - <%=Helper.correctNull((String) hshValues.get("phpa_site_govtvaluer_name"))%> </td>
					<%}else { %>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("phpa_site_valuer_name"))%>&nbsp;</td>
					<%} %>				
					</tr>
					<tr>
					<td width="5%"><b>Valuer Category Code</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("phpa_VALUER_CATEGORYCODE"))%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="5%"><b>Nature of valuation</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("valuer_valnature"))%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="5%"><b>Nature of Property [Prime/Collateral]</b></td>
					<td width="25%">Prime</td>
					</tr>			    	
				</table>
			</div>
			</td></tr>		
		</table>
		</td>
	</tr>
	<%if(("1").equals(Helper.correctNull((String) hshValues.get("LOAN_GOVT")))&& (("081").equals(Helper.correctNull((String) hshValues.get("GOVT_SCHEME"))) || ("080").equals(Helper.correctNull((String) hshValues.get("GOVT_SCHEME"))))){ %>
			<tr>
				<td><b><%=i++%>. Affordable Housing in Partnership Details</b><span style="float: right;">(Amount in <%=strAmountVal %>)</span></td>
			</tr>
			
			<tr><td>
			<div id="top">
				<table width="100%" border="0" align="center" cellpadding="3"  cellspacing="0" 
				    		class="outertable">
					<tr class="tblhead">
					<td width="40%" align="center"><b>Particulars</b></td>	
					<td width="60%" align="center"><b>Details</b></td>			
					</tr>
					<tr>
					<td width="5%"><b>Whether allotment letter obtained from
				Co-operative Housing Society/Housing Board/ULB/KSDB</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_ALLOTMENT_LETTER"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Whether Income Certificate from revenue
				authority obtained</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_INCOME_CERTIFICATE"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Bank Name of the Implementing Agency</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_BANKNAME"))%>&nbsp; </td>			
					</tr>
					
					<tr>
					<td width="5%"><b>Branch Name of the Implementing Agency</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_BRANCHNAME"))%>&nbsp;</td>			
					</tr>
					<tr>
					<td width="5%"><b>Account Number of the Implementing Agency</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_ACCNUMBER"))%>&nbsp;</td>				
					</tr>	
					
					<tr>
					<td width="5%"><b>IFSC CODE</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_IFSCCODE"))%>&nbsp;</td>				
					</tr>
					<tr>
					<td width="5%"><b>Total Cost of the Project (Amount in <%=strAmountVal %>)</b></td>
					<td width="25%" ><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_COSTLOANPRD")))),strAmountForm)%></td>  
		
					</tr>
					<tr>
					<td width="5%"><b>GOI subsidy amount (Amount in <%=strAmountVal %>)</b></td>
					<td width="25%" ><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_GOI_AMT")))),strAmountForm)%></td>  
		
					</tr>
					
					<tr>
					<td width="5%"><b>GOK subsidy amount(Amount in <%=strAmountVal %>)</b></td>
					<td width="25%" ><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_GOK_AMT")))),strAmountForm)%></td>  
					</tr>
					<tr>
					<td width="5%"><b>Present Accommodation</b></td>
					<td width="25%"><%=Helper.correctNull((String) hshValues.get("AHP_RESIDENT_TYPE"))%></td>
					</tr>
					<tr>
					<td width="5%"><b>Initial deposit or savings from the borrower (Amount in <%=strAmountVal %>)</b></td>
					<td width="25%"><%=Helper.converAmount(Helper.correctNull(Helper.formatDoubleValue(Double.parseDouble((String) hshValues.get("AHP_SAVINGS")))),strAmountForm)%></td>  
					
					</tr>			    	
				</table>
			</div>
			</td></tr>		
		
		<%} %>
		
        
</table>
</body>
</html>