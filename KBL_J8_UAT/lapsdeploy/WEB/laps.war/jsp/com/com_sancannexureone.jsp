<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<%
ArrayList arrRow = new ArrayList();
ArrayList arrCol =new ArrayList();
String strProposalvalue = Helper.correctNull((String) hshValues
		.get("proposalvaluesin"));
if (strProposalvalue.equalsIgnoreCase("C"))
	strProposalvalue = "Crores";
else
	strProposalvalue = "Lacs";


String strCompany="Company";
%>
<html>
<head>
<title>Sanction Letter(Annexure b)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0">
	<tr>
		<td width="51%">&nbsp;</td>
		<td width="49%">
		<div align="right"><b>Annexure - A</b></div>
		</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2" align="center"><%=Helper.correctNull((String) hshValues
							.get("comapp_companyname")).toUpperCase()%></td>
							<tr>
		<td colspan="2" align="center"><%=Helper.correctNull((String) hshValues
							.get("comapp_regadd1")).toUpperCase()%>,
								<%if(!Helper.correctNull((String) hshValues
					.get("comapp_regadd2")).equals("")){ %> <%=Helper.correctNull((String) hshValues
							.get("comapp_regadd2")).toUpperCase()%>,
				<%} %> <%=Helper.correctNull((String) hshValues.get("city_name")).toUpperCase()%>,
				<%=Helper.correctNull((String) hshValues.get("state_name")).toUpperCase()%> -
				<%=Helper.correctNull((String) hshValues
							.get("comapp_regpin"))%></td>
	</tr>
	<tr>
		<td colspan="2">
		<div align="center"><b>TERMS &amp; CONDITIONS OF SANCTION</b></div>
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>a. Limits : </b></td>
	</tr>
	<tr>
		<td width="51%">&nbsp;</td>
		<td width="49%" align="right"><b>(Rs In <%=strProposalvalue%>)</b>&nbsp;</td>
	</tr>
</table>
<div id="top">
<table width="100%" border="0">
	<tr>
		<td rowspan="2" width="35%">
		<div align="center"><b>Facility</b></div>
		</td>
		<td rowspan="2" width="15%">
		<div align="center"><b>Existing /New Limit</b></div>
		</td>
		<td rowspan="2" width="15%">
		<div align="center"><b>Sanctioned Limit</b></div>
		</td>
		<td colspan="2" width="20%">
		<div align="center"><b> Rate Of interest </b></div>
		</td>
	</tr>
	<tr>
		<td align="center" width="8%"><b>Existing </b></td>
		
      <td align="center" width="8%"><b>Sanctioned</b></td>
	</tr>
	<%
	 double dblTotExisting = 0.00;
	 double dblTotProposed = 0.00;
	 String strSubLimit = "";
		 arrRow = (ArrayList)hshValues.get("arrFacilityDetails");
			 if(arrRow != null && arrRow.size()>0){
			   
		    	for(int i=0;i<arrRow.size();i++){
		    		arrCol = (ArrayList)arrRow.get(i);
		    		if(arrCol != null){
		    			String strGroup = Helper
						.correctNull((String) arrCol.get(7));
	
		    		if (strGroup.trim().equals("0")){
		    			double dblExisting = Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
		    			dblTotExisting = dblExisting + dblTotExisting;
		    			
		    			double dblProposed = Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
		    			dblTotProposed = dblProposed + dblTotProposed;
		    			
		    	%>
		    	<tr>
		<td><b><%=Helper.correctNull((String)arrCol.get(3))%></b>&nbsp;</td>
		<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>&nbsp;</td>
		<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>&nbsp;</td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</td>
	</tr>
	<%}else {

		if ((!strGroup.equals(strSubLimit)) && (!strGroup.trim().equals("0"))) {
		strSubLimit = strGroup;
		%>
		<tr>
		<td colspan="5"><b>&gt;&gt;</b> <b>Sub-Limit</b></td>
	</tr>
	<%} %>
	<tr>
		<td><%=Helper.correctNull((String)arrCol.get(3))%>&nbsp;</td>
		<td align="right">(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>)&nbsp;</td>
		<td align="right">(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>)&nbsp;</td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(8)) %>&nbsp;</td>
		<td align="center"><%=Helper.correctNull((String)arrCol.get(9)) %>&nbsp;</td>
	</tr>
		    	<% 
		    	
		  }
		 }
		    	}
		}	
						
		    %>
	
	<tr>
		<td><b>TOTAL</b></td>
		<td align="right"><%=Helper.formatDoubleValue(dblTotExisting)%>&nbsp;</td>
		<td align="right"><%=Helper.formatDoubleValue(dblTotProposed)%>&nbsp;</td>
		<td align="center">&nbsp;</td>
		<td align="center">&nbsp;</td>
	</tr>
</table>
</div>
<table width="100%" border="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>*Interst will be charged _______________________________________
		rest.</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<!-- <tr>
		<td><b>b.Allocations:</b> If the
		______________________________________________________ have allocation
		facilities at more than one branch, the following details to be
		provided.</td>
	</tr>
	<tr>
		<td>&nbsp;
		<div id="top">
		<table width="100%" border="0">
			<tr>
				<td>
				<div align="center"><b>Name of the Branch</b></div>
				</td>
				<td>
				<div align="center"><b>Type of credit facilities </b></div>
				</td>
				<td>
				<div align="center"><b>Amount </b></div>
				</td>
				<td>
				<div align="center"><b>TOTAL</b></div>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr> -->
	
	<tr>
		<td><b>b.Security :</b></td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0">
			<tr>
				<td rowspan="2" width="25%" align="center">
				<b>Type of Facility</b>
				</td>
				<td colspan="2" width="75%" align="center">
				<b>Details of Primary security</b>
				</td>
			</tr>
			<tr>
		<td align="center" width="10%"><b>Margin (%)</b></td>
		<td align="center" width="35%"><b>Security</b></td>
	</tr>
			<%
	        arrRow = new ArrayList();
			arrCol = new ArrayList();
			strSubLimit = "";
		    arrRow = (ArrayList)hshValues.get("arrFacilityDetails");
			 if(arrRow != null && arrRow.size()>0){
			   
		    	for(int i=0;i<arrRow.size();i++){
		    		arrCol = (ArrayList)arrRow.get(i);
		    		if(arrCol != null){
		    			String strGroup = Helper
						.correctNull((String) arrCol.get(7));
		    			int introwspan = Integer.parseInt(Helper
	    						.correctInt((String) arrCol.get(11)));
	
		    		if (strGroup.trim().equals("0")){
		    			
		    	%>
		    	<tr>
		    	<td align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<b><%=Helper.correctNull((String) arrCol
										.get(3))%> </b></td>
										
				<%
                ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) arrCol.get(10);
				if(arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						ArrayList arrSecCol = new ArrayList();
						String strBorder = "";
						arrSecCol = (ArrayList)arrSecurities.get(j);
						if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}
						if (j == 0) {

							%>	
							<td align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSecCol.get(1))))%>&nbsp;</td>		
							<td align="left" valign="top"><%=Helper.correctNull((String)arrSecCol.get(0))%>&nbsp;</td>					

						<%} else { %>	
						<tr>
						<td align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSecCol.get(1))))%>&nbsp;</td>		
						<td align="left" valign="top"><%=Helper.correctNull((String)arrSecCol.get(0))%>&nbsp;</td>		
						
				    	<%}
					}
				} else { %>
				     <td valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
				      <td valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
				      
				<%}

				%>
					</tr>
		    	
		    		<%}else {

		if ((!strGroup.equals(strSubLimit)) && (!strGroup.trim().equals("0"))) {
			strSubLimit = strGroup;
		%>
	<tr>
		<td colspan="3"><b>&gt;&gt;</b> <b>Sub-Limit</b></td>
	</tr>
	<%} %>
		<tr>
		<td align="left" valign="top" rowspan="<%=introwspan%>">&nbsp;<%=Helper.correctNull((String) arrCol
										.get(3))%></td>
										
											<%
                ArrayList arrSecurities = new ArrayList();
				arrSecurities = (ArrayList) arrCol.get(10);
				if(arrSecurities != null && arrSecurities.size() > 0) {
					for (int j = 0; j < arrSecurities.size(); j++) {
						ArrayList arrSecCol = new ArrayList();
						String strBorder = "";
						arrSecCol = (ArrayList)arrSecurities.get(j);
						if ((introwspan - 1) == j && j != 0) {
							strBorder = "style=\"border-top-width:0\";";
						} else if (j == 0) {
							strBorder = "style=\"border-bottom-width:0\";";
						} else {
							strBorder = "style=\"border-bottom-width:0;border-top-width:0\"";
						}
						if (j == 0) {

							%>	
							<td align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSecCol.get(1))))%>&nbsp;</td>					
							<td align="left" valign="top"><%=Helper.correctNull((String)arrSecCol.get(0))%>&nbsp;</td>					
							
						<%} else { %>	
						<tr>
						<td align="right" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrSecCol.get(1))))%>&nbsp;</td>					
							<td align="left" valign="top"><%=Helper.correctNull((String)arrSecCol.get(0))%>&nbsp;</td>																		
				    	<%}
					}
				} else { %>
				     <td valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
				     <td valign="top" rowspan="<%=introwspan%>">&nbsp;</td>
				    
				<%}

				%>
					</tr>
					
			    	<% 
		    		
		  }
		 }
		    	}
		}	
						
		    %>
			
			
		</table>
		</div>

		</td>
	</tr>
	
		<%
		    arrRow = new ArrayList();
			arrRow = (ArrayList)hshValues.get("arrPrimarySecRemars");
			if (arrRow != null && arrRow.size() != 0) {

				%>
			<tr>
				<td>
				<table width="90%" border="0" cellspacing="0" cellpadding="3"
					align="center">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td><b>Security Remarks</b></td>
							</tr>
							<%for (int i = 0; i < arrRow.size(); i++) {
    	  arrCol = (ArrayList) arrRow.get(i);
					if (!Helper.formatTextAreaData((String) arrCol.get(0))
							.equalsIgnoreCase("")) {

						%>
							<tr>
								<td valign="top" class="just"><%=Helper.formatTextAreaData((String) arrCol
										.get(0))%>&nbsp;</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
							</tr>

							<%}
				}

			%>
						</table>
						</td>
					</tr>
				</table>
				<%}
%></td>
			</tr>	
</table>
<br>
<div id="top">
<table width="100%" border="0">
	<tr>
		<td width="79%" height="10">
		<div align="center"><b>Full Description of the Coll.Security</b></div>
		</td>
		<td width="21%" height="10">
		<div align="center"><b>Value (<%=ApplicationParams.getCurrency()%>in <%=strProposalvalue%>)</b></div>
		</td>
	</tr>
	            <%ArrayList arrColldetails = new ArrayList();
			ArrayList arrValues = new ArrayList();
			arrColldetails = (ArrayList) hshValues.get("arrColldetails");
			double dbltotal = 0.00;
			if (arrColldetails != null && arrColldetails.size() != 0) {
				for (int i = 0; i < arrColldetails.size(); i++) {
					arrValues = (ArrayList) arrColldetails.get(i);
					dbltotal = dbltotal
							+ Double.parseDouble(Helper
									.correctDouble((String) arrValues.get(1)));

					%>
					<tr>
					
      <td width="79%" height="10"><%=Helper.formatTextAreaData((String) arrValues
									.get(0))%>&nbsp;</td>
		<td width="21%" height="10" align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrValues
													.get(1))))%>&nbsp;</td>
		</tr>											
					 <%}

				%>
					<tr>
					<td width="79%" height="10"><b>TOTAL</b>&nbsp;</td>
		<td width="21%" height="10" align="right"><%=Helper.formatDoubleValue(dbltotal)%>&nbsp;</td>
		</tr>			
					<%} else {

			%>
			<tr>
		<td width="79%" height="10">&nbsp;</td>
		<td width="21%" height="10">&nbsp;</td>
	</tr>
			<%} %>
	
</table>
</div>
<table width="100%" border="0">
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3"><b>c.Guarantee</b>: The credit facility is secured by personal 
      guarantee of the fallowing:</td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <div id="top"> 
        <table width="100%" border="0">
          <% boolean bolguarantee = false;
        boolean corpguarantee = false;
			arrRow = new ArrayList();
			arrCol = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrGuarantors");

			if (arrRow != null && arrRow.size() != 0) {
				bolguarantee = true;

				%>
          <tr> 
            <td width="40%"> 
              <div align="center"><b>Name of the guarantor/s</b></div>
            </td>
            <td width="35%"> 
              <div align="center"><b>Address</b></div>
            </td>
            <td width="25%"> 
              <div align="center"><b>Means (<%=ApplicationParams.getCurrency()%>in 
                <%=strProposalvalue%>)</b></div>
            </td>
          </tr>
          <tr align="center"> 
            <td align="left" colspan="3"><b>PERSONAL GUARANTEE</b></td>
          </tr>
          <%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
          <tr> 
            <td ><%=arrCol.get(0)%>&nbsp;<%=arrCol.get(2)%>&nbsp;<%=arrCol.get(1)%>&nbsp; 
            </td>
            <td>&nbsp;</td>
            <td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>&nbsp;</td>
          </tr>
          <%}
			}

			%>
          <%
				if (Helper.correctNull(
						(String) hshValues.get("sel_applicantguarantee"))
						.equalsIgnoreCase("Y")) {
					if (!bolguarantee) {
						bolguarantee = true;%>
          <tr> 
            <td width="40%"> 
              <div align="center"><b>Name of the guarantor/s</b></div>
            </td>
            <td width="35%"> 
              <div align="center"><b>Address</b></div>
            </td>
            <td width="25%"> 
              <div align="center"><b>Means (<%=ApplicationParams.getCurrency()%>in 
                <%=strProposalvalue%>)</b></div>
            </td>
          </tr>
          <%}%>
          <%if(!corpguarantee){
                	corpguarantee=true;%>
          <tr align="center"> 
            <td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
          </tr>
          <%} %>
          <tr align="center"> 
            <td align="left"><%=Helper.correctNull((String) hshValues
									.get("comapp_companyname"))%>&nbsp; </td>
            <td>&nbsp;&nbsp;</td>
            <td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("TangibleNetworth"))))%>&nbsp;</td>
          </tr>
          <%} %>
          <%arrRow = new ArrayList();
					arrCol = new ArrayList();
					arrRow = (ArrayList) hshValues.get("arrCorpguarantee");
					if (arrRow != null && arrRow.size() > 0) {
						if (!bolguarantee) {
							bolguarantee = true;%>
          <tr> 
            <td width="40%"> 
              <div align="center"><b>Name of the guarantor/s</b></div>
            </td>
            <td width="35%"> 
              <div align="center"><b>Address</b></div>
            </td>
            <td width="25%"> 
              <div align="center"><b>Means (<%=ApplicationParams.getCurrency()%>in 
                <%=strProposalvalue%>)</b></div>
            </td>
          </tr>
          <%} %>
          <%if(!corpguarantee){
                	corpguarantee=true;%>
          <tr align="center"> 
            <td align="left" colspan="3"><b>CORPORATE GUARANTEE</b></td>
          </tr>
          <%} %>
          <%for (int i = 0; i < arrRow.size(); i++) {
                	 arrCol = (ArrayList) arrRow.get(i);

							%>
          <tr align="center"> 
            <td align="left"><%=Helper.correctNull((String) arrCol
											.get(0))%>&nbsp;<%=Helper.correctNull((String) arrCol
											.get(2))%>&nbsp;<%=Helper.correctNull((String) arrCol
											.get(1))%> </td>
            <td>&nbsp;&nbsp;</td>
            <td  align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(4))))%>&nbsp;</td>
          </tr>
          <%}
					}
			
			%>
        </table>
      </div>
      <%if (!bolguarantee) {
			 %>
  <tr> 
    <td>&nbsp;</td>
    <td colspan="2">NIL</td>
  </tr>
  <%	} %>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left"><b>d.</b></td>
    <td align="left"><b>Drawing Power:</b></td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left"><b>&nbsp;</b></td>
    <td align="left"><b>Working Capital</b></td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td align="left"> </td>
    <td colspan="2" align="left">Drawing Power shall be regulated on the basis 
      of total Value of the prime security available less unpaid portion, less 
      goods received on job work basis, less obsolete items Of stock, less stocks 
      older than 90 days and less Margin</td>
  </tr>
  <tr> 
    <td align="left"><b>&nbsp;</b></td>
    <td align="left"><b>Term Loan</b></td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td align="left"> </td>
    <td colspan="2" align="left">In case of Term Loan, the drawing will be permitted depending upon the amount of margin money made available in the account.</td>
  </tr>
  <tr> 
    <td align="center" colspan="3">&nbsp;</td>
  </tr>
  <tr valign="top"> 
    <td><b>e.</b></td>
    <td colspan="2"><b>Other Matter</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <ul>
        <li> The <b><%=strCompany%></b> shall arrange to have the name of the 
          Bank painted/displayed on all the fixed assets charged to the Bank/consortium 
          bankers, to identify such assets. 
        <li>The <b><%=strCompany%></b> should also display notice of the hypothecation 
          of the goods at the place of the business/all its godown. 
        <li>The <b><%=strCompany%></b> shall undertake to provide to the Bank, 
          the right to call for information relating to the business/operations 
          of the concerns, to carry out periodical inspection of their books of 
          accounts and verification of their assets. 
        <li>The <b><%=strCompany%></b> agrees to provide the letter of free access 
          in case of all the godowns of the <b><%=strCompany%></b> in case the 
          same are rented and also to provide periodically a satisfactory proof 
          that the rent of the godown/s have been paid.<br>
      </ul>
    </td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b>f.</b></div>
    </td>
    <td align="justify" colspan="2"><b>Periodicity of stock statements </b>: Monthly/Quarterly</td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" width="2%"><b>g.</b></td>
    <td align="justify" colspan="2"><b>Documents</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr> 
          <td width="15%"><b>Document's</b> <b>code:</b></td>
          <td width="85%"><b>Description of the documents</b></td>
        </tr>
        <%
	 int size1=0,size2=0; 
	arrRow=(ArrayList)hshValues.get("arrDocbybankdet");
	if(arrRow!=null)
	{
	  arrCol=new ArrayList();
	    size1=arrRow.size();
		for(int i=0;i<size1;i++)
		{
		arrCol=(ArrayList)arrRow.get(i);
		   if(arrCol!=null)
		    {
		    %>
        <tr> 
          <td width="15%"><%=Helper.correctNull((String)arrCol.get(0)) %></TD>
          <td width="85%"> <%=Helper.correctNull((String)arrCol.get(1)) %> </td>
        </tr>
        <%
		    }
		}
	}
	else
	   {
	    %>
        <tr> 
          <td width="15%">&nbsp;</td>
          <td width="85%">No documents found</td>
        </tr>
        <% } %>
        <tr> 
          <td width="15%">&nbsp;</td>
          <td width="81%">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" width="37%">&nbsp;</td>
    <td align="justify" width="61%">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b>h.</b></div>
    </td>
    <td align="justify" colspan="2"><b>Penal rate of interest </b></td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b></b></div>
    </td>
    <td align="justify" colspan="2"><b>Working Capital </b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <p>As per instructions from the RBI, the Bank may charge additional interest 
        upto 2% (maximum) above the rate applicable on the entire outstanding 
        in the account(s) under the following circumstances:</p>
    </td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <ul>
        <li>Irregularities in cash credit accounts ;</li>
        <li>Non payment/non acceptance of demand/since bills of exchange on presenting 
          at due dates ;</li>
        <li>Non-submission / delayed submission of renewal data for the period 
          of delay. The renewal data is required to be submitted to the Bank three 
          months before expiry of the validity period of sanction of the Working 
          Capital facilities.</li>
        <li>Non-submission / delayed submission of stock statement for the month 
          for which the statement pertains within 10 days of succeeding month. 
        </li>
        <li> Non-compliance of the terms and conditions given in this letter and 
          the various annexure thereto.</li>
      </ul>
    </td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b></b></div>
    </td>
    <td align="justify" colspan="2"><b>Term Loan</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <ul>
        <li>Default in repayment of loans ;</li>
        <li>The renewal data is required for review of the term loan to be submitted to the Bank every year.</li>
        <li>QPR,MSOD and half yearly statement including cash flow/fund flow statement.</li>
        <li>Non-compliance of the terms and conditions given in this letter and the various annexures thereto.</li>
      </ul>
    </td>
  </tr>
  
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b>i</b>.</div>
    </td>
    <td align="justify" colspan="2"><b>Basis of valuation of stocks :</b> At cost 
      OR market price which ever is less.</td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b>j.</b></div>
    </td>
    <td align="justify" colspan="2"><b>Validity period of sanction </b>:12 months</td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2">If the formalities are not completed by you 
      the limits sanctioned will be treated as cancelled automatically without 
      any communication on the part of the bank unless validity period is extended 
      in writing, Thereafter, party has to apply again for the working capital 
      facility or for extending the period of the WC facility availed by the party. 
      The request will be appraised afresh and sanction/extension of the facility 
      in such cases will be at the sole discretion of the bank.</td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b>k.</b></div>
    </td>
    <td align="justify" colspan="2"><b>Stock Audit :</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"></div>
    </td>
    <td align="justify" colspan="2">Stock audit will be conducted once a year 
      by an outside agency appointed by the Bank, the expenses whereof will be 
      borne by the <b><%=strCompany%></b> .</td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"></div>
    </td>
    <td align="justify" colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" width="2%"> 
      <div align="center"><b>l.</b></div>
    </td>
    <td align="justify" colspan="2"><b>Stock Statement:</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <p>It is essential that the outstanding borrowings at all times are fully 
        covered by the value of the hypothecated security less the stipulated 
        margins. If at any time, the drawing power yielded by the <b><%=strCompany%></b> 
        falls below the amount borrowed, the <b><%=strCompany%></b> should forthwith 
        adjust such excess borrowings under advice to us. In order to ensure compliance 
        with this requirement, it is necessary that appropriate books and records 
        (e.g. a control ledger / register) are maintained by the <b><%=strCompany%></b> 
        showing the relevant particulars on a day to day basis.</p>
      <p> It should be possible for the <b><%=strCompany%></b> to watch the extent 
        of the outstanding borrowing / liability vis-&agrave;-vis the stock position 
        and for the Bank to verify at a future date the declarations and statements 
        required to be submitted to it under the arrangement, on the basis of 
        books and records maintained by the <b><%=strCompany%></b> .</p>
    </td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left">&nbsp;</td>
    <td align="left" colspan="2">The said stock statement should also bear the 
      following certificate:</td>
  </tr>
  <tr> 
    <td align="left">&nbsp;</td>
    <td align="left">&quot;We hereby certify that:</td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <ol>
        <li> The total value of the stock and the book debts hypothecated to the 
          Bank is true and the said book debts are the absolute property of the 
          <b><%=strCompany%></b> and that no part of such assets has been paid 
          for by any parties, the title to which has passed out of the <b><%=strCompany%></b> 
          hand and that the said assets are not subject to any lien, claims or 
          damages of any sort and on the strength of this declaration of the <b><%=strCompany%></b> 
          the advance have been granted.</li>
        <li>No part of the assets/book debts detailed in the statement are obsolete 
          and that the same are in undamaged and good condition.</li>
        <li>The debts are valued at sale price.</li>
        <li>The assets included in the statement do not include assets classified 
          as NPA in our books&quot;.<br>
          Since the <b><%=strCompany%></b> furnish Branch-wise details of pre-payment 
          disbursement and NPA position details in their stock statement, the 
          <b><%=strCompany%></b> should furnish a certificate confirming the correctness 
          of the value of assets hypothecated to the Bank duly signed by the Authorised 
          Signatory of the <b><%=strCompany%></b> , every month/quarter. The statement 
          of outstanding book debt should contain the following: 
          <ul>
            <li>Age-wise break-up of debts(upto 90 days old, 90 to 120 days, 120 
              to 180 days old and above 180 days).</li>
            <li>Overdue debt position.</li>
            <li>Debts which are not recoverable.</li>
            <li>Debts which are doubtful of recovery.<br>
            </li>
          </ul>
        </li>
      </ol>
    </td>
  </tr>
  <tr> 
    <td align="left" width="2%"><b>m.</b></td>
    <td align="justify" colspan="2"><b>QPR Statements</b></td>
  </tr>
  <tr>
  	<td align="left"></td>
  	<td align="justify"  colspan="2">The <b><%=strCompany%></b> shall submit the following Quarterly Progress Report on or before due dates shown there against:</td>
  </tr>
  <tr>
  	<td align="left"></td>
  	<td align="justify"  colspan="2"><div id="top">
  	<table width="100%" border="0"> <tr valign="top"> <td width="29%" align="center"><b>Statement</b></td>
  	<td width="43%" align="center"><b>Pariculars</b></td>
  	<td width="28%" align="center"><b>Due 
Date</b></td></tr> <tr valign="top"> <td width="29%">QPR-1(Part A,B,C and D)</td><td width="43%">Sales 
and production performance during the quarter vis-a-vis projection and position 
of current.Assetsand Current Liabilities as compared to Estimates.</td><td width="28%">Within 
4 weeks from the close of the quarter starts.</td></tr> <tr valign="top"> <td width="29%">Monthly 
select Operational Data(MSOD)</td><td width="43%">Actual production/ sales/ profit 
during the month.</td><td width="28%">Within a week from the close of the month 
to which the statement relates.</td></tr> <tr valign="top"> <td width="29%">Half Yearly Statement</td><td width="43%">Half-yearly 
operating statement and the fund flow statement.</td><td width="28%">Within six 
weeks from the close of the relative half year.</td></tr> </table></div>
  	</td>
  </tr>
  <tr>
  	<td align="left"></td>
  	<td align="justify" colspan="2">The above data is required on regular basis to ascertain that the financial position of the company is satisfactory and there is no liquidity problem to the ___________________________ and the_____________________will be in position to service the interest and installments regularly.Any delay in receipt or non-receipt of the above statements will attract penal interest on the outstanding for the entire quarter in which the statement was due for submission.</td>
  </tr>
  
  <tr> 
    <td align="left" width="2%"><b>n.</b></td>
    <td align="justify" colspan="2"><b>Other terms and conditions:</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <ol type="i">
        <li> No excess over the limit will be allowed except for emergent temporary 
          need that too at the sole discretion of the Bank, which must be adjusted 
          within a period of 7 days.</li>
        <li>All cheques in the account are to be drawn only relating to genuine 
          business transactions and for approved purposes. Bank is not liable 
          for any loss for return of cheque in case the same appears to be drawn 
          for any other purpose and was returned. All cheques are to be drawn 
          keeping in mind the limit/Drawing Power available in the account. Bank 
          is not responsible for return of any cheque in the account because of 
          the insufficient funds.</li>
        <li>As per existing norms, the account becomes NPA (Sub-standard) just 
          after 90 days if the persisting irregularities are there in the account. 
          Please note that after the account is classified as NPA, the drawings 
          from the account will be stopped and Bank is not responsible for any 
          loss which the borrower may suffer because of the stoppage of operations 
          in the account on the account being classified as NPA.</li>
        <li>The borrower has to comply with all the terms of sanction. Bank is 
          free to recall the advance/stop operations in the account if any time 
          during the currency of our advance, any of the sanction terms are observed 
          to be not complied with by the borrower.</li>
        <li>The <b><%=strCompany%></b> shall not undertake any major capital expenditure 
          programme without our prior consent in writing.</li>
        <li>The <b><%=strCompany%></b> shall have to take prior approval of the 
          Bank in respect of the transaction exceeding 10% of the fund based limit 
          or Rs.50.00 Lacs whichever is less and submit to the Bank the information 
          in the required format. Other transactions exceeding 5% of the fund 
          based limit or Rs.25.00 Lacs whichever is less will have to be reported 
          to us every month.</li>
        <li>Working capital funds granted should not be diverted or invested for 
          the use of the other units of the <b><%=strCompany%></b> /sister concerns 
          of the <b><%=strCompany%></b> /associate concerns of the <b><%=strCompany%></b> 
          .</li>
        <li>The <b><%=strCompany%></b> pro-rata foreign exchange business/deposits, 
          payment of dividend warrant, fixed deposit interest, etc., if any, should 
          be routed through the Bank.</li>
        <li>The Bank shall have the right to examine the books of accounts of 
          the <b><%=strCompany%></b> and to have the <b><%=strCompany%></b> offices 
          inspected from time to time, by its Officer(s) of the Bank and/or qualified 
          auditors and/or technical experts and/or management consultants of the 
          Bank's choice. Cost of such inspections shall be borne by the <b><%=strCompany%></b> 
          .</li>
        <li>An undertaking to the effect that in case of any director/proprietor/partner/guarantor/ 
          person having beneficial interest in the concern is or is appointed 
          in any bank/financial institution as Director, the same should immediately 
          be disclosed to us.
          
          </li>
        <li><p>A declaration to the effect that (i) in case of an individual he is 
          not a specified near relation of any director/senior officer of the 
          bank, (ii) in case of a partnership of H.U.F. firm, none of the partners 
          or none of the members of the H.U.F. is a real relation of the director/senior 
          officer of the bank and (iii) in case of the company, none of it's directors 
          is a relative of any director/senior officer of the bank. (Details of 
          the relationship are given). In case the declaration is found false, 
          then, the Bank would be entitled to revoke and/or recall the credit 
          facility.</p>
          <p>Borrower to give an undertaking in the prescribed format enclosed that the bank can pass all the information about the borrower or his account to RBI/Credit information Bureau of India Ltd. set up by RBI who is authorised to collect, proccess and share credit information on the borrowers among Banks and Financial Institutions.</p></li>
        <li>During the currency of the Bank's credit facilities, the <b><%=strCompany%></b> 
          shall not, without the Bank's prior permission in writing : 
          <ul>
            <li>effect any change or in any way alter the <b><%=strCompany%></b> 
              capital structure;</li>
            <li>formulate any scheme of amalgamation or reconstruction;</li>
            <li>Implement any scheme of expansion or acquisition of fixed assets 
              involving Expenditure exceeding say, Rs.5.00 Lacs to Rs.10.00 Lacs 
              in any accounting year. In other cases, the Bank would appreciate 
              being advised of the details of the proposed investment in fixed 
              assets so that it would be possible for the Bank to examine these 
              and give necessary clearance. It is understood that the Bank would 
              not unreasonably withhold its clearance;</li>
            <li>Invest by way of share capital in or lend or advance funds to 
              or place deposits with any other concern; normal trade credit or 
              security deposits in the normal course of business or advances to 
              employees can, however, be extended;</li>
            <li>Enter into borrowing arrangements either secured or unsecured 
              with any other bank/financial institutions, <b><%=strCompany%></b> 
              or otherwise or accept deposits apart from the existing arrangement;</li>
            <li>Undertake guarantee obligations on behalf of any other concern/s;</li>
            <li>Declare dividends for any year except out of profits relating 
              to that year after making all due and necessary provisions and provided 
              further that no default had occurred in any term repayment obligations 
              and the company are able to maintain adequate Working Capital margin; 
              the quantum of such dividend shall not exceed 20%. A due clearance 
              from the bank i.e. no objection from the bank must be obtained by 
              furnishing all the required details;</li>
            <li>Monies brought in by principal share holders/directors shall not 
              be allowed to be withdrawn;</li>
            <li>The <b><%=strCompany%></b> shall not make any drastic changes 
              in their management sep up without the Bank's prior permission;</li>
            <li>The credit facilities should be utilized by the <b><%=strCompany%></b> 
              for meeting its working capital requirements only;</li>
            <li>The <b><%=strCompany%></b> shall submit to the Bank the quarterly/half 
              yearly operating and funds flow statements as required under the 
              RBI Study group recommendations within the prescribed time limit, 
              to enable the Bank to regulate drawings in the account;</li>
            <li>The drawings in the credit facilities made available to the <b><%=strCompany%></b> 
              shall be regulated on the basis of the quarterly operating and funds 
              flow statements submitted by the <b><%=strCompany%></b>; </li>
            <li>The <b><%=strCompany%></b> shall adhere to any other covenants 
              stipulated by the Bank from time to time;</li>
            <li> The <b><%=strCompany%></b> shall keep the bank informed of the 
              happening of any event likely to have a substantial effect on their 
              profit/business. </li>
          </ul>
        </li>
        <li>The <b><%=strCompany%></b> shall pay on demand to the bank/participating 
          banks/bank, the cost between solicitors /advocates / <b><%=strCompany%></b> 
          / and clients incurred by them or any of them in connection with the 
          registration of the security and certification charges thereof with 
          the registrar of companies, compilation of search/status report, creation 
          of equitable mortgage, payment of legal charges/stamp duty for creation 
          of equitable mortgage/and/or any other matter incidentally arising out 
          of or in connection with this transaction of the borrower with the Bank.</li>
        <li>The <b><%=strCompany%></b> shall pay a sum towards processing charges 
          as per banks norms changing from time to time, for sanction of the subject 
          credit facilities. The <b><%=strCompany%></b> will have to pay the processing 
          charges for the renewal of the limit also in case the limit is renewed 
          after one year at the request of the party.</li>
        <li>The <b><%=strCompany%></b> shall furnish to the Bank 4 certified copies 
          of the balance sheet and profit and loss account statement of the <b><%=strCompany%></b> 
          as soon as the accounts are audited and printed. The <b><%=strCompany%></b> 
          shall also furnish to the Bank, the audited annual accounts, duly analyzed 
          on CMA forms along with the fund flow and cash flow statement 3 months 
          before the renewal is due.</li>
        <li>Hypothecated goods/pledge of goods/goods purchased out of bank's finance 
          should be stored in pucca build godowns and the same should be comprehensively 
          insured for risks like Fire, Burglary, Housebreaking, earthquake, flood 
          and other risks as are applicable to the type of assets, the entire 
          cost of which is to be borne by the concern.</li>
        <li> Borrower to give an undertaking in the prescribed format enclosed 
          that the bank can pass all the information about the borrower or his 
          account to RBI/Credit Information Bureau of India Ltd. set up by RBI 
          who is authorized to collect, process and share credit information on 
          the borrowers among Banks and Financial Institutions.</li>
      </ol>
    </td>
  </tr>
  <tr>
  <td align="left" width="2%"><b></b></td>
    <td align="justify" colspan="2"><b> Additional Terms and Condition for Term Loan:</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2"> 
      <ol type="i">
        <li>The entire amount of term loan along with the margin money will be disbursed to the supplier directly in a phased manner after you provided the satisfactory evidence of the proposed purchase.After the item/s are purchased, the same is to be brought to the unit duly insured, the bills/receipts are to be produced to the bank and you have to get the inspection of the items purchased to the satisfication of thye bank.</li>
         <li>The facility in the form of term loan component will be made available to you in seperate accounts.</li>
          <li>In case of term loan the same will be repayable in________________ monthly/quarterly/half yearly / yearly installments alongwith interest.In case of non payment of any installments bank reserve the right to recall the advance and proceed for the recovery measures which may include recall of advance and also the legal measures at your cost, risk and responsibility.</li>
           <li>In terms of the conditions governing the Cash Credit/ Demand loan/ they are payable on demand and as such the Bank reserves the right to recall the loans as provided for in the agreements executed for the overall limits/ Cash Credit facility, inter alia , if the performance of your unit is not satisfactory or where your________________ , is found to have uised the amount for purposes other than for which the Working Capital facilities are sanctioned or for any other reasons considerd necessary.</li>
            <li>If at any point of time whether the entire loan amount is disbursement or even the partial disbursement is made,it is found that the loan amount have used for purposes other than for which the term loan was sanctioned or for any other reasons considered necessary, the bank is free to recall the advance or to stop further disbursement of loan in case the partial disbursement have been made.Bank is not responsible for any other loss which the borrower may suffer by reason of stoppage of further disbursement or because of the recall of the advance.It will be entirely at your risk cost and consideration.</li>
             <li>If the loans are not repaid on the due dates or not rolled over, on the due dates, they will be considered as irregular advances, and penal interest, as applicable, would be charged thereon and the Bank may also at its discretion call up the entire Working Capital facilities including Loans.</li>
              <li>An undertaking to the effect that in case of director/proprieter/partner/guarantor/person having beneficial interest in the concern is appointed in any bank/financial institution as Director, the same should immediately be disclosed to us.</li>
               <li>The <b><%=strCompany%></b> shall pay a sum towards processing charges at the rate of Rs________________ per ________________ or part thereof , subject to a minimum of Rs________________ for sanction of the subject credit facilities. The <b><%=strCompany%></b> will have to pay the processing charges for the review of the account also @________________</li>
                <li>The assets purchased out of bank's finance should be stored in pucca build godowns and the same should be comprehensively insured for risks like Fire, Burglary ,Housebreaking, earth quack , flood and other risks as are applicable to the type of assets, the entire cost of which is to be bornr by the concern.</li>
                 <li>An undertaking to the effect that in case of any director/proprieter/partner/guarantor/person having beneficial interest in the concern is appointed in any bank/financial institution as Director, the same should be immediately be disclosed to us.</li>
                 <li>A declaration to the effect that i) in case of an individual he is not a specified near relation of any director/ senior officer of the bank. ii)In case of a partnership of H.U.F firm, none of the partners or none of the member of the H.U.F is a real relation of the director/ senior officer of the bank and iii) in case of the company, none of it's directors is relative of any director/ senior officer of the bank.(Details of the relationship be given ).In case the declaration is found false, then, the bank would be entitled to revoke and/or recall the credit facility.</li>
                 <li>Borrower to give an undertaking in the prescribed format enclosed that the bank can pass all the information about the borrower or his account to RBI/ Credit information Bureau of India Ltd. set up by RBI who is authorised to collect, process and share credit information on the borrowers among Banks and Financial Institutions.</li>
       </ol>
     </td>
   </tr>
  <tr> 
    <td align="left" width="2%"><b>o</b></td>
    <td align="justify" colspan="2"><b> NEGATIVE LIEN</b></td>
  </tr>
  <tr> 
    <td align="left" width="2%">&nbsp;</td>
    <td align="justify" colspan="2">The <b><%=strCompany%></b> shall not create, 
      without our prior written consent charge/s on their all or any assets, other 
      than the charge/s created/to be created in favour of the consortium banks 
      for the Working Capital facilities enjoyed by the company.</td>
  </tr>
</table>
<table width="100%" border="0">
  <tr> 
    <td width="2%">&nbsp;</td>
    <td valign="top"> 
      <ol>
        <li> There will not be any investments in each of the following category 
          without the prior consent of the Bank in writing : 
          <ol type="i">
            <li> Investments in shares of quoted companies;</li>
            <li>Other investments including those of money market;</li>
            <li> Inter corporate loans /deposits;</li>
            <li>Real estate (excluding <b><%=strCompany%></b> own building to 
              house its own offices/factories). The <b><%=strCompany%></b> shall 
              submit to us quarterly statements of the values of assets in each 
              of the above categories, both as at the end of the quarter and the 
              peak level during the quarter, and any transgression from ceiling 
              stipulated above shall be deduct from NOF for arriving at eligible 
              ceiling for bank borrowing. The <b><%=strCompany%></b> shall maintain 
              records in such a manner that the levels of the above investments 
              under each category are indicated separately.<br>
            </li>
          </ol>
        </li>
        <li>The <b><%=strCompany%></b> shall not extend any loan to directors/promoters 
          of any company including associates and subsidiaries.</li>
        <li>The <b><%=strCompany%></b> shall not vest large financial powers in 
          any single individual authority for booking factory business, other 
          investments in money; forex and capital markets. Any single individual 
          as authority in the <b><%=strCompany%></b> should not have financial 
          powers to commit the <b><%=strCompany%></b> under any one of the categories 
          mentioned in paragraph(s), to more that 5 % of the total business of 
          the <b><%=strCompany%></b> .</li>
        <li> An undertaking to be provided to the bank not to permit withdrawal 
          or deposits of advances by family members, friends or directors/partners 
          during the currency of the Bank advance without the prior approval of 
          the bank and should submit an undertaking from such persons not to withdraw 
          their deposits or advances from the borrowing concern.</li>
        <li>In case of limited companies where limits have been sanctioned under 
          the personal guarantee of certain individual/directors, an undertaking 
          in writing should be obtained to the effect that no consideration whether 
          it be by way of commission, brokerage, fees or any other form will be 
          paid by the borrower company or received by the guarantor directly or 
          indirectly for providing the bank with such a guarantee.</li>
        <li> The borrower should undertake not to extend finance to associate 
          concerns during the currency of Bank's advance without the Bank's written 
          consent.</li>
        <li>Certificates/Returns to be submitted : 
          <ul>
          	<li>The company should obtain credit rating from one of the aprroved credit rating agencies at least once a year and a copy of the arting should be submitted to us.Any change in the rating should be advised to us immediately along with the copy of the communication from the rating agency.</li>
            <li>Annual report of the company on completion of audit should be 
              submitted, along with auditor's certificate within 30 days from 
              the date of completion of audit or 6 months of close of the financial 
              year which ever is earlier.</li>
          </ul>
        </li>
        <li> In case of loan being taken over by other bank/financial institution 
          or foreclosure of loan account by adjusting the amount other than company's 
          own sources, the <b><%=strCompany%></b> will be liable to pay 2% penal 
          interest on the entire loan amount. The onus of proving the source of 
          funds towards adjustment of loan account rests with the <b><%=strCompany%></b> 
          .</li>
        <%-- <li>Submit the audited financial statement of March-10 immediately after 
          close of account.</li>
          <li>--%>
          


      </ol>
    </td>
  </tr>
  <tr> 
    <td width="2%"><b>p.</b></td>
    <td valign="top">Other Terms and Condition: </td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td> 
      <ul>
        <li> The release of credit facilities is also subject to vetting of security 
          documents by the bank's approved advocate and bank's internal procedure 
          of credit Process audit.</li>
        <li> Enhance limit will be released only after execution of fresh document 
          and to create and register stipulated charges with the authorities specified 
          for the purpose within stipulated time . </li>
        <li>Fresh valuation of mortgaged property to be done once in three years. 
          Mortgaged property to be insured for all risks as per Bank's norm.</li>
        <li> Service Charges, Cheques Returning charges, Incidental charges, insurance 
          charges,inspection,documentation charges will be levied are as per Bank's 
          rule.</li>
        <li>Penal interest of 1% p.a each will be charged on 
          <ul>
            <li> Delayed submission of CMA/Renewal data for the period beyond 
              1 month from due date.</li>
            <li>Non compliance of term of sanction.</li>
          </ul>
        <li> In following cases the penal interest will be 2% p.a 
          <ul>
            <li> Non submission/delayed submission of QPR/QIS</li>
            <li>Excess over limit/Drawing power</li>
            <li>Adhoc-facility sanctioned, if any</li>
          </ul>
        </li>
        <li> Without prejudice to the nature of the advance (s), these credit 
          facilities will remain in force for a period of one year and is /are 
          subject to annual review. Next review will fall due on or before December.</li>
        <li>Notwithstanding anything contained in the documents executed/to be 
          executed, the rate of interest stipulated will be subject to revision 
          depending on the change in the BPLR of the Bank or depending on the 
          directives of Reserve Bank Of India or the policy of the Bank from time 
          to time which change will be displayed on the notice Board in the Branch 
          or published in the newspaper and no separate notice may be issued by 
          the Bank to the Borrower / guarantor regarding such revision.</li>
        <li>Inter-firm Transaction will not be allowed.</li>
        <li>The entire asset charged/to be charged to the bank i.e. All stocks, 
          factory building, Plant and machinery to be kept fully insured at all 
          times against all risks and original insurance cover note/policy in 
          the name of the Bank a/c borrower firm with Bank's hypothecation clause 
          to be lodged with the bank.</li>
        <li>You shall not, except after prior written permission from us, make 
          any alterations in your constitution, controlling ownership or any documents 
          relating to its constitution or any other material change in your management 
          or in the nature of your business or operations during the period of 
          the subsistence of facilities.</li>
        <li>The bank reserves the right to discontinue any/all the credit facilities 
          granted without giving you any prior notice in case of non-compliance 
          and/or breach of any of the term and conditions based on which the facilities 
          have been sanctioned to you and /and if any information particulars/documents 
          furnished by you are to be incorrect.</li>
        <li>The company is required to submit QIS I, II, III returns. QIS I (Showing 
          estimates) is required to be submitted in the week preceding the commencement 
          of the quarter to which it relates. QIS II (Showing performance) within 
          six weeks from the close of the quarter to which the statements relates 
          and QIS III (half Yearly Statement) within two months from the close 
          of the half year. Any delay without specific approval from the bank 
          will attract penal rate of 2% p.a for the delay period</li>
        <li>Inspection will be done on quarterly basis or as and when required 
          by the bank. The bank has the right of deputing its officials/persons 
          like auditors or management consultant's etc duly authorized by the 
          bank to inspect the units, asset, books of account/record etc from time 
          to time. Also the bank may appoint at its sole discretion/stock/concurrent 
          auditors, valuers etc relating to the company/firm's activity, the cost 
          of which will be borne by the company.</li>
        <li>Preshipment and post shipment limit to be secured by WTPCG &amp; WTPSG 
          scheme of ECGC, with the option to the bank for obtaining comprehensive 
          ECGC coverage depending upon the risk prevailing in the country where 
          export is being made. Premium to ECGC by the bank in respect of WTPCG 
          policy is to be borne by firm/company.</li>
        <li>Packing Credit will be allowed against confirmed order /irrevocable 
          LC opened by prime banks at sight or upto 90 days usance. Confirmed 
          order will be revalidated on or before 180 days if shipment is not effected. 
        </li>
        <li>Bank will obtain status report on drawees before purchase/discount 
          of the bills and such reports will be updated annually availability 
          of a satisfactory status report shall be a pre- requisite for such purchase/discount 
          of bills.</li>
        <li>The firm/company to display bank's hypothecation plate/board at its 
          unit/business premises indicating that assets hypothecated to the bank.</li>
        <li>The company to submit copy of statutory permissions/clearances like 
          NOC from pollution control Board and ensure for timely renewal of same 
          from time to time<br>
        </li>
      </ul>
    </td>
  </tr>
  <tr> 
    <td width="2%"><b>q.</b></td>
    <td> <b>Application Terms and Conditions</b></td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
        <tr> 
          <%
                    ArrayList arr18=new ArrayList();
                    ArrayList arr19=new ArrayList();
                    int arrSize15=0;
                    arr18=(ArrayList)hshValues.get("appterms");
               
                    if(arr18!=null){
                    	
                        arrSize15=  arr18.size();
                           }

                  for(int i=0;i<arrSize15;i++)
                  {
                	  arr19=(ArrayList)arr18.get(i); 
                 
                    		
                    %>
        <tr> 
          <td valign="top" width="3%">&nbsp;<%=i+1 %>.</td>
          <td valign="top" colspan="4">&nbsp;<%=Helper.formatTextAreaData((String)arr19.get(0)) %></td>
        </tr>
        <%
                  }
                    %>
      </table>
    </td>
  </tr>
  <tr> 
    <td width="2%">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<table width="100%" border="0">
  <tr> 
    <td align="justify" colspan="3">&nbsp;</td>
  </tr>
</table>
<table width="100%" border="0">
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">YOURS FAITHFULLY</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">FOR KARNATAKA BANK</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">AUTHORISED SIGNATORY</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%"><b>ACCEPTED ALL THE TERMS AND CONDITIONS</b></td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%"><b>SIGNATURE OF BORROWERS</b></td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%"><b>Place:</b></td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%"><b>Date:</b></td>
    <td width="24%">&nbsp;</td>
  </tr>
  <tr> 
    <td width="76%">&nbsp;</td>
    <td width="24%">&nbsp;</td>
  </tr>
</table>
</body>
</html>
