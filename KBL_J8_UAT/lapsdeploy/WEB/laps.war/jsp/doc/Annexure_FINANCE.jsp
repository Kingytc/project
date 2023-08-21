<%@ include file="../share/directives.jsp"%>

<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow1");
  ArrayList arrRow = (ArrayList)hshValues.get("arrData");
ArrayList arryCol = new ArrayList();
ArrayList arrRow9 = (ArrayList)hshValues.get("arrRow9");


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
<title>Salaried Annexure</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
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
		<%}else{ %>
		<tr><td align="center" width="50%">Branch&nbsp;/&nbsp;Office&nbsp;:&nbsp;<%=strOrgName.toUpperCase()%></td></tr>
		<%} %>
</table>
<div id="top">
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">

	<tr>
		<td width="20%"><b>Branch code:</td>
		<td width="30%"><%=Helper.correctNull((String) hshValues.get("hshorg_scode"))%>&nbsp;</td>
		<td width="20%"><b>Date:</td>
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
		applications from the employees of M/s.&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_EMPLOYERNAME"))%>
		under <% ArrayList arrCol1 = new ArrayList();
								if(arrRow!=null && arrRow.size()>0){
								for(int i=0;i<arrRow.size();i++){ 
								arrCol1 = (ArrayList)arrRow.get(i);%> <br />
		<u><%=(String)arrCol1.get(5)%></u>&emsp; <%}}else{%>________________________________<%} %>Scheme.</b>
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
				<td width="5%" align="center">1.</td>
				<td width="45%"> Name of the Employer </td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_EMPLOYERNAME"))%></td>
			</tr>
			<tr>
				<td width="5%" align="center">2.</td>
				<td width="45%"> Employees are dealing with the branch
				since</td>
				<%if(!Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE")).equals("")){ %>
					<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE"))%></td>
				<% } else { %>
				 	<td width="50%">Not a Customer</td>
				<% } %>
			</tr>
			<tr>
				<td width="5%" align="center">3.</td>
				<td width="45%"> No.of employees drawing salary in the
				Branch</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_NOOFEMP_SALDRAW"))%></td>
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
				<td class="title">4.Present Request:</td>
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
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td width="5%" align="center">5.</td>
				<td width="45%">Scheme Guidelines</td>
				<td width="50%"><%=Helper.correctNull((String) hshValues.get("PG_SCHEME_GUIDELINES"))%>&nbsp;</td>
			</tr>
			<tr>
				<td width="5%" align="center">6.</td>
				<td width="45%"> Deviation observed</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_DEVOBSERVED"))%></td>
			</tr>
			<tr>
				<td width="5%" align="center">7.</td>
				<td width="45%"> Background (about the firm and
				employees)</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("strBkgroundcmts"))%></td>
			</tr>
			<tr>
				<td width="5%" align="center">8.</td>
				<td width="45%">Whether permission has been extended
				earlier for these employees at HO. If yes, furnish details</td>
				<td width="50%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_WHTPERM_EXTENDED"))%></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>

	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="0"
			class="outertable" align="center">
			<tr>
				<td class="title">9.Advances position of the branch:</td>
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
				<td rowspan=2>Particulars</td>
				<td colspan=2>Branch Total</td>
				<td colspan=2>NPAs</td>
				<td colspan=2>% of NPA</td>
				</tr>
			<tr class="tblhead">
				<td>A/cs</td>
				<td>Amount</td>
				<td>A/cs</td>
				<td>Amount</td>
				<td>A/cs</td>
				<td>Amount</td>
			</tr>

			<tr>
				<td>Total Advances</td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TA_BRTOT_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TA_BRTOT_AMT"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TA_NPA_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TA_NPA_AMT"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TA_NPAPER_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TA_NPAPER_AMT"))%></td>
			</tr>
			<tr>
				<td>Loans under Salaried class</td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SL_BRTOT_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SL_BRTOT_AMT"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SL_NPA_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SL_NPA_AMT"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SL_NPAPER_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SL_NPAPER_AMT"))%></td>
			</tr>
			<tr>
				<td>Out of which, Loans to the employees of M/s. <%=Helper.correctNull((String) hshValues.get("PG_EMPLOYERNAME")) %>
				</td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LE_BRTOT_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LE_BRTOT_AMT"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LE_NPA_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LE_NPA_AMT"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LE_NPAPER_ACS"))%></td>
				<td width=3%>&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LE_NPAPER_AMT"))%></td>
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
			    <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
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
						<td>Hunter Score</td>
				        <td><%=Helper.correctNull((String) hshValues.get("intHuntScore1"))%></td>
					<%} %>
			</tr>
			<tr>
				<td width="35%">Branch/RLPC Recommendation:</td><td><%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_BRANCH"))%>&nbsp;
				</td>
			</tr>
			<tr>
				<td>Sanction Department View:</td><td><%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_HOVIEW"))%>&nbsp;
				</td>
			</tr>
			<tr>
				<td>Sanction Department Recommendation:</td><td><%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_HO"))%>&nbsp;</td>
			</tr>
			<tr>
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

			<tr>
				<td>&nbsp;</td>
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