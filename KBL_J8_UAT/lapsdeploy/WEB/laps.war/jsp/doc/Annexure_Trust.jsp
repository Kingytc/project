<%@include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow1");
    ArrayList arrRow = (ArrayList)hshValues.get("arrData");
ArrayList arryCol = new ArrayList();
ArrayList arrRow9 = (ArrayList) hshValues.get("arrRow9");

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
String sancAuth=Helper.correctNull((String) hshValues.get("PERM_SANC_AUTH"));
String strpermissionfalg=Helper.correctNull((String) hshValues.get("flag"));

	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style type="text/css">
body,table td {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
}

#top {
	background-color: #ffffff;
}

#top table {
	border-collapse: collapse;
}

#top td {
	border: 0.5pt solid #000000;
	FONT-SIZE: 16px;
	COLOR: #000000;
	LINE-HEIGHT: 16px;
	FONT-FAMILY: "Book Antiqua"
}

.title {
	FONT-SIZE: 16px !important;
	COLOR: #000000 !important;
	FONT-FAMILY: "Book Antiqua" !important;
	font-weight: bold !important;
}
</style>
<title>Trust Annexure</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td align="center"><br>
		<img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	</tr>
	<%if(Helper.correctNull((String)hshValues.get("PERM_SANC_DEPT")).equalsIgnoreCase("008")){ %>
		<tr><td align="center" width="50%">Credit LCFD&nbsp;&nbsp;</td></tr>
		<%}else if(Helper.correctNull((String)hshValues.get("PERM_SANC_DEPT")).equalsIgnoreCase("010")){ 
		String strComSancbranchcode=Helper.correctNull((String)hshValues.get("PERM_SANC_BRANCH"));
		if(strComSancbranchcode.equalsIgnoreCase("MCFD"))
			strComSancbranchcode="Credit MCFD";
		else
			strComSancbranchcode="Credit RFD";
		%>
		<tr><td align="center" width="50%"><%=strComSancbranchcode%>&nbsp;&nbsp;</td></tr>
		<%} else if(Helper.correctNull((String)hshValues.get("PERM_SANC_DEPT")).equalsIgnoreCase("017")){ %>
		<%String strComSancbranchcode = "Centralised Loan Sanctioning Centre";%>
				<tr><td align="center" width="50%"><%=strComSancbranchcode%>&nbsp;&nbsp;</td></tr>
		<%}else{ %>
		<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=strOrgName.toUpperCase()%></td></tr>
		<%} %>
</table>
<div id="top">
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td width="20%"><b>Branch code:</b></td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("hshorg_scode"))%>&nbsp;</td>
		<td width="20%"><b>Date:</b></td>
		<td width="30%"><%=Helper.getCurrentDateTime()%> &nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b>Branch:</b></td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("hshorg_name"))%>&nbsp;</td>
		<td width="20%"><b>Region:</b></td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("hshorg_Regionname"))%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b>Manager Contact no:</b></td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("hshORG_MANAGER_CTNUM"))%>&nbsp;</td>
		<td width="20%"><b>Proposal No:</b></td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("DEV_APPNO"))%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b>Permission Type:</b></td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("DEV_MAINTYPE"))%>&nbsp;</td>
		<td width="20%"><b>Permission SubType:</b></td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("DEV_SUBTYPE"))%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%" nowrap="nowrap"><b>PERMISSION PARAMETERS</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues.get("DEV_DEVPARAMDESC"))%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b>SUBMITTED TO</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues.get("PERM_PROP_SUBMITTED"))%>&nbsp;</td>
	</tr>
	<%if(sancAuth.equals("14")||sancAuth.equals("15")||sancAuth.equals("16")) {  %>
	<tr>
		<td width="20%"><b>Permission Reference No.</b></td>
		<td colspan="3"><%=Helper.correctNull((String)hshValues.get("PERM_REFNO"))%>&nbsp;</td>
	</tr>
	<tr>
		<td width="20%"><b>Sanction date</b></td>
		<td colspan="3"><%=Helper.correctNull((String) hshValues.get("PERM_SANC_DATE"))%>&nbsp;</td>
	</tr>
	<% } %>
</table>
</div>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td><b>Permission sought by the Branch to entertain the loan
		proposal from&nbsp;&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_APPLIANTNAME"))%>
		for <% ArrayList arrColl = new ArrayList();
								if(arrRow!=null && arrRow.size()>0)	{
									for(int i=0;i<arrRow.size();i++){ 
								arrColl = (ArrayList)arrRow.get(i);%> <br />
		<%=(String)arrColl.get(0)%> of Rs.&nbsp;<u><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrColl.get(1))))%></u>&nbsp;
		under &nbsp;<u><%=(String)arrColl.get(5)%>&nbsp;</u> <%}}else{ %>_______________________________<%} %>&nbsp;Scheme.</b>
		</td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td>
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr valign="top">
				<td align="center" width="5%">1.</td>
				<td width="45%">Name & address of the Borrower Trust</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_APPLIANTNAME"))%><br><%=Helper.correctNull((String) hshValues.get("PG_APPLADDRESS"))%></td>
			</tr>
			<tr>
				<td align="center" width="5%">2.</td>
				<td width="45%">Names of the Present Trustee</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_NAMEOFTRUSTEE"))%></td>
			</tr>
			<tr>
				<td align="center" width="5%">3.</td>
				<td width="45%">Constituted on</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String)hshValues.get("PG_CONSTITUTED_ON"))%></td>
			</tr>
			<tr>
				<td align="center" width="5%">4.</td>
				<td width="45%">Excess of Income over Expenditure (As on<%if(!Helper.correctNull((String) hshValues.get("PG_INCEXPEN_DATE")).equalsIgnoreCase("")){ %>
				<%=Helper.correctNull((String) hshValues.get("PG_INCEXPEN_DATE"))%>
				<%}else{ %>________________<%} %>)</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_EXCESSINCOME"))%></td>
			</tr>
			<tr>
				<td align="center" width="5%">5.</td>
				<td width="45%">Dealing since</td>
					<%if(!Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE")).equals("")){ %>
						<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE"))%></td>
					<% } else { %>
					 	<td width="50%">Not a Customer</td>
					<% } %>		
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td class="title">6.Details of deposit accounts</td>
				<td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;</td>
				
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr class="tblhead">
				<td width="5%">S.No</td>
				<td width="16%">Name</td>
				<td width="15%">Account No.</td>
				<td width="16%">Deposit Amt (Rs.)</td>
				<td width="19%">Present balance (Rs.)</td>
				<td width="14%">Maturity Date</td>
				<td width="15%">Rate of Int (%)</td>
			</tr>
			<% 
							ArrayList arrCol6 = new ArrayList();
							ArrayList arrRow6 = (ArrayList)hshValues.get("arrData6");
							int p=0;
							if(arrRow6!=null && arrRow6.size()>0)
							{
							for(int i=0;i<arrRow6.size();i++)
							{ 
							arrCol6 = (ArrayList)arrRow6.get(i);
							p=p+1;
							%>
			<tr>
				<td style="text-align: center">&nbsp;<%=p%></td>
				<td style="text-align: left">&nbsp;<%=arrCol6.get(0)%></td>
				<td style="text-align: right">&nbsp;<%=arrCol6.get(1)%></td>
				<td style="text-align: right">&nbsp;<%=arrCol6.get(2)%></td>
				<td style="text-align: right">&nbsp;<%=arrCol6.get(3)%></td>
				<td style="text-align: center">&nbsp;<%=arrCol6.get(4)%></td>
				<td style="text-align: center">&nbsp;<%=arrCol6.get(5)%></td>

			</tr>
			<%}} else{%>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<%}%>
		</table>
		</div>
		</td>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td class="title">7.Present Request</td>
				<td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr class="tblhead">
				<td width="5%">S.No</td>
				<td width="15%">Nature of loan/facility</td>
				<td width="15%">Bank Scheme</td>
				<td width="15%">Loan Amount</td>
				<td width="15%">ROI/ Commission</td>
				<td width="15%">Period(including holiday if any)(Months)</td>
				<td width="20%">Purpose of the loan</td>
			</tr>
			<% 
							ArrayList arrCol = new ArrayList();
							int e=0;
							if(arrRow!=null && arrRow.size()>0)
							{
							for(int i=0;i<arrRow.size();i++)
							{ 
							arrCol = (ArrayList)arrRow.get(i);
							e=e+1;
							%>
			<tr>
				<td style="text-align: center">&nbsp;<%=e%></td>
				<td style="text-align: center">&nbsp;<%=arrCol.get(0)%></td>
				<td style="text-align: center">&nbsp;<%=arrCol.get(5)%></td>
				<td style="text-align: right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%></td>
				<td style="text-align: right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%></td>
				<td style="text-align: right">&nbsp;<%=arrCol.get(3)%></td>
				<td style="text-align: center">&nbsp;<%=arrCol.get(4)%></td>
			</tr>
			<%}} else{%>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<%}%>
		</table>
		</div>
		</td>
	</tr>

	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td class="title">8.Security Offered for the proposed facility</td>
				<td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr class="tblhead">
				<td width="15%">Type</td>
				<td width="20%">Value of Securities</td>
				<td width="20%">Comments</td>
			</tr>
			<tr>
				<td>Primary</td>
				<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("PG_PRIME_SECVAL"))))%>&nbsp;</td>
				<td><%=Helper.correctNull((String) hshValues.get("PG_PROPFAC_SEC_PRIME"))%>&nbsp;</td>
			</tr>
			<tr>
				<td>Collateral</td>
				<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) hshValues.get("PG_COLLATERAL_SECVAL"))))%>&nbsp;</td>
				<td><%=Helper.correctNull((String) hshValues.get("PG_PROPFAC_SEC_COLLATERAL"))%>&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
		
					<%if(Helper.correctNull((String) hshValues.get("assessment")).equalsIgnoreCase("Y"))
				{%>
			<tr>
				<td>
		    	<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    		<tr>
						<td class="title">Eligible interest concession based on the parameters:<br/>
								 Rating of the borrower (based on audited financial as on <%=Helper.correctNull((String) hshValues.get("PG_RATINGDATE"))%>): <%=Helper.correctNull((String) hshValues.get("PG_BOR_RATING"))%>
								 </td>
								 </tr>
								 </table>
								 </td>
								 </tr>
						<tr>
						<td>
						<div id="top">
						<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
						
						<tr class="tblhead">
							<td width="45%">General assessment of the party </td>
							<td width="15%">Marks</td>
							<td width="15%">Marks Prescribed By the Br.</td>
							<td width="15%">Marks Awarded at RO/HO</td>
						</tr>
						
						<% 
				//int val1=0;		
				ArrayList arrCol12 = new ArrayList();
				ArrayList arrRow2 = (ArrayList)hshValues.get("arrData1");
				if(arrRow2!=null && arrRow2.size()>0)
				{
				for(int i=0;i<arrRow2.size();i++)
				{ 
				arrCol12 = (ArrayList)arrRow2.get(i);
				%>	
					
						<tr>
							<td>&nbsp;<%=arrCol12.get(0)%>  <%if(!Helper.correctNull((String)arrCol12.get(1)).equalsIgnoreCase("")){%>(<%=Helper.correctNull((String)arrCol12.get(1))%>)<%} %></td>
							<td>&nbsp;<%=arrCol12.get(2)%></td>
							<td>&nbsp;<%=arrCol12.get(3)%></td>
							<td>&nbsp;<%=arrCol12.get(4)%></td>
						</tr>
					<%}}
					else{%>
						<tr>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
						</tr>
					<%} %>
					<tr>
							<td class="title">TOTAL AGGREGATE MARKS</td>
							<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("temp"))%></td>
							<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("temp1"))%></td>
							<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("temp2"))%></td>
						</tr>
					</table></div>
						
					</td>
			</tr>
				<%} %>
				<%if(Helper.correctNull((String) hshValues.get("finance")).equalsIgnoreCase("Y"))
		    	{%>
		    	
		    <tr>
		    <td>
		    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		    <tr>
				<td class="title">Gist of Balance Sheet Analysis</td>
				</tr>
				</table>
				</td>
		    </tr>	
		      <tr>
			    <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;</td>
			    </tr>
		    <tr>
			    <td>
			    <div id="top">
			    	<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
					<tr class="tblhead">
						 <td rowspan="2">Particulars</td>
					<%	
					int colsize=Integer.parseInt(Helper.correctInt((String)hshValues.get("yearno")));
					for(int j=1;j<=colsize;j++)
					 {
					  %>
						 <td><%=Helper.correctNull((String) hshValues.get("txt_year"+j))%>&nbsp;</td>
					 <% } %>
					  </tr>
					 
					 <tr>
					<%	
					for(int j=1;j<=colsize;j++)
					 {
						 String finyeartype=Helper.correctNull((String) hshValues.get("combo"+j));
						 if(finyeartype.equals("a"))
							 finyeartype="Audited";
						 else if(finyeartype.equals("u"))
							 finyeartype="Unaudited";
						 else if(finyeartype.equals("e"))
							 finyeartype="Estimated";
						 else if(finyeartype.equals("p"))
							 finyeartype="Projected";
					  %>
						 <td class="tblhead"><%=finyeartype%>&nbsp;</td>
					 <% } %>
					  </tr>
					 
					 
					 <%
					 	for(int i=1;i<=15;i++)
					 	{
					 	%>	
					 	<tr>
					 		<td><%=Helper.correctNull((String) hshValues.get("hsh_row"+i+"c0"))%>&nbsp;</td>
					 	<%	for(int j=1;j<=colsize;j++)
					 		{
					  %>
								 <td align="right"><%=Helper.correctNull((String) hshValues.get("hsh_row"+i+"c"+j))%>&nbsp;</td>
					 <% }  %>
						 </tr>
					 <% } %>

					 
					 </table>
					 </div>
				 </td>
			 </tr>
			<%} %> 
	<tr>
		<td>
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			
			<tr>
					<%if(strpermissionfalg.equalsIgnoreCase("Y")){%>
						<td   width="45%" colspan="2">Hunter Score</td>
				        <td   width="50%"><%=Helper.correctNull((String) hshValues.get("intHuntScore1"))%></td>
					<%} %>
			</tr>
			<tr>
				<td align="center" width="5%">9.</td>
				<td width="45%">Loan policy guidelines</td>
				<td width="50%"><%=Helper.correctNull((String) hshValues.get("PG_SCHEME_GUIDELINES"))%>&nbsp;</td>
			</tr>
			<tr>
				<td align="center" width="5%">10.</td>
				<td width="45%">Background</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strBkgroundcmts"))%></td>
			</tr>
			<tr>
				<td align="center" width="5%">11.</td>
				<td width="45%">Branch/RLPC Recommendation</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_BRANCH"))%></td>
			</tr>
			<tr>
				<td align="center" width="5%">12.</td>
				<td width="45%">Sanction Department View</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_HOVIEW"))%></td>
			</tr>
			<tr>
				<td align="center" width="5%">13.</td>
				<td width="45%">Sanction Department Recommendation</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_HO"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center" valign="top">14.</td>
				<td colspan="2">
					 <b>Other conditions:</b> 
				        <ol type="i">
				         <%
											if (arrRow9 != null && arrRow9.size() > 0) {
												for (int i = 0; i < arrRow9.size(); i++) {
													arrCol = (ArrayList) arrRow9.get(i);
										%>
				        <li><%=Helper.correctNull((String) arrCol.get(0))%></li>
						<%}%>
						<%} %>
						<li>Collect handling charges of Rs.<%=Helper.correctDouble((String)hshValues.get("PERM_HANDLING_CHARGE")) %> plus applicable taxes.</li>
						</ol>
				</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="98%" align="center" cellpadding="0" cellspacing="0"
			border="0">
			<%
                                   
	 								if(arryRow!=null && arryRow.size()>0)
	 								{
	 										for(int i=0;i<arryRow.size();i++)
	 										{
	 											arryCol=(ArrayList)arryRow.get(i); 
									
                                   %>
			<%
								if (i % 2 == 0) {
												%>
			<tr>
				<td>&nbsp;</td>
			</tr>

			<tr>
				<td align="left"><br>
				<b><%= Helper.correctNull((String)arryCol.get(0))%></b></td>
			</tr>
			<tr>
				<td align="left" class="title"><%= Helper.correctNull((String)arryCol.get(1))%></td>
			</tr>
			<%} else {
										%>

			<tr>
				<td align="right"><br>
				<b><%= Helper.correctNull((String)arryCol.get(0))%></b></td>
			</tr>
			<tr>
				<td align="right" class="title"><%= Helper.correctNull((String)arryCol.get(1))%></td>
			</tr>
			<%
										}
										%>
			<%}} %>



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


</body>
</html>