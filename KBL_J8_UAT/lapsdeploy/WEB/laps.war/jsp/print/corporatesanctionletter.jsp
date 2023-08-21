<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
String strProposalvalue = Helper.correctNull((String) hshValues
		.get("proposalvaluesin"));

if (strProposalvalue.equalsIgnoreCase("C"))
	strProposalvalue = "Crores";
else
	strProposalvalue = "Lacs";


%>
<html>
<head>
<title>Sanction Letter(Annexure b)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" font-family="arial" font-size="11px">
<table width="75%" border="0" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="2" align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><%=Helper.correctNull((String) hshValues.get("organisationname"))%>, <%=Helper.correctNull((String) hshValues.get("organisationaddr1"))%>, 
				<%=Helper.correctNull((String) hshValues.get("organisationaddr2"))%>, <%=Helper.correctNull((String) hshValues.get("organisationcity"))%>, 
				<%=Helper.correctNull((String) hshValues.get("organisationstate"))%>, <%=Helper.correctNull((String) hshValues.get("organisationpin"))%>.<br> 
				Tel No: <%=Helper.correctNull((String) hshValues.get("organisationphone"))%>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="2"><hr></td>
			</tr>
			<tr>
				<td ALIGN="LEFT">REF.NO:<%=Helper.correctNull((String) hshValues.get("facAppno"))%></td>
				<td ALIGN="RIGHT">DATE:<%=Helper.getCurrentDateTime()%></td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" colspan="2">TO<br>

				<%=Helper.correctNull((String) hshValues
							.get("comapp_companyname")).toUpperCase()%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("comapp_regadd1")).toUpperCase()%>,<br>
				<%if(!Helper.correctNull((String) hshValues
					.get("comapp_regadd2")).equals("")){ %> <%=Helper.correctNull((String) hshValues
							.get("comapp_regadd2")).toUpperCase()%>,<br>
				<%} %> <%=Helper.correctNull((String) hshValues.get("city_name")).toUpperCase()%>,<br>
				<%=Helper.correctNull((String) hshValues.get("state_name")).toUpperCase()%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("comapp_regpin"))%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td colspan="2">&nbsp;Dear Sir,</td>
			</tr>
			<tr>
				<td align="center" colspan="2"><U><b>SUB:Your request for sanction /
				Renewal /Enhancement in Credit facilities</b></U></td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;With reference to your
				request letter No ____________________ dated ____________________
				and subsequent correspondence/discussion we had with you/your
				representative, we have pleasure in advising you that we are
				agreeable to sanction/renew/enhance the existing credit facilities
				at our branch to you as detailed hereunder for a period of one year,
				subject to periodical review at the Bank's discretion, for financing
				the ____________________ activities.</p>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
		<td width="51%">&nbsp;</td>
		<td width="49%" align="right"><b>(Rs In <%=strProposalvalue%>)</b>&nbsp;</td>
	</tr>
			<tr>
				<td colspan="2">
				<div id="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td align="center"><b>Facility</b></td>
						<td align="center"><b>Existing Limit</b></td>
						<td align="center"><b>Proposed Limit</b></td>
						<td align="center"><b>Sanctioned Limit</b></td>
					</tr>
		<%
		String strSubLimit = "";
		double dblTotExisting = 0.00;
		double dblTotProposed = 0.00;
		double dblTotSanctioned =0.00;
		  ArrayList arrRow = (ArrayList)hshValues.get("arrFacilityDetails");
			 if(arrRow != null && arrRow.size()>0){
			   
		    	for(int i=0;i<arrRow.size();i++){
		    		ArrayList arrCol = (ArrayList)arrRow.get(i);
		    		if(arrCol != null){
		    			String strGroup = Helper
						.correctNull((String) arrCol.get(7));
	
		    		if (strGroup.trim().equals("0")){
		    			double dblExisting = Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
		    			dblTotExisting = dblExisting + dblTotExisting;
		    			
		    			double dblProposed = Double.parseDouble(Helper.correctDouble((String)arrCol.get(5)));
		    			dblTotProposed = dblProposed + dblTotProposed;
		    			
		    			double dblSanctioned = Double.parseDouble(Helper.correctDouble((String)arrCol.get(6)));
		    			dblTotSanctioned = dblSanctioned + dblTotSanctioned;
		    			
		    	%>
		    	
		    		<tr>
						<td>&nbsp;<b><%=Helper.correctNull((String)arrCol.get(3))%></b></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%></td>
						<td align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%></td>
						
					</tr>
		    	<%}else {

		if ((!strGroup.equals(strSubLimit)) && (!strGroup.trim().equals("0"))) {
			strSubLimit = strGroup;
		%>
		<tr>
		<td colspan="4"><b>&gt;&gt;</b> <b>Sub-Limit</b></td>
	</tr>
	<%} %>
	<tr>
						<td>&nbsp;<%=Helper.correctNull((String)arrCol.get(3))%></td>
						<td align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%>)</td>
						<td align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(5))))%>)</td>
						<td align="right">&nbsp;(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(6))))%>)</td>
						
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
		<td align="right"><%=Helper.formatDoubleValue(dblTotSanctioned)%>&nbsp;</td>
		
	</tr>
					
				</table>
				</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2">
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The terms and conditions
				governing the Credit Facilities as mentioned above are detailed in
				Annexure 'A'. The <b><%=Helper.correctNull((String) hshValues
							.get("comapp_companyname")).toUpperCase()%></b> should also comply with
				all the Government/RBI guidelines as applicable from time to time.</p>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The duplicate of this letter
				may please be returned to us duly signed by an authorised signatory
				of the <b><%=Helper.correctNull((String) hshValues
							.get("comapp_companyname")).toUpperCase()%></b> in token of having accepted the terms
				and conditions as detailed in Annexure.</p>
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<p>Accepted the above on the terms and Conditions mentioned in
				Annexure A</p>
				</td>
			</tr>


			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" colspan="2">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><u></u></td>
					</tr>
					
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td WIDTH="60%">&nbsp;</td>
								<td  WIDTH="40%" align="right">Yours faithfully,&nbsp;</td>
							</tr>
							<tr>
								<td WIDTH="60%">&nbsp;</td>
								<td WIDTH="40%" align="center"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="center"></td>
							</tr>

							<tr>
								<td align="left">Signature of the Borrower</td>
								<td align="right">For Karnataka Bank Ltd.</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="right">Authorised signatory</td>
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
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>
