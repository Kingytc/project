<%@ include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow1");
 ArrayList arrRow = (ArrayList)hshValues.get("arrData");
 ArrayList arrRow9 = (ArrayList)hshValues.get("arrRow9");

ArrayList arryCol = new ArrayList();

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
int a1=1;
String sancAuth=Helper.correctNull((String) hshValues.get("PERM_SANC_AUTH"));	
String strAmntVal = Helper.correctNull((String) request
		.getParameter("strAmntVal"));
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
<title>CRE Annexure</title>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	align="center">
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
	align="center" class="outertable">
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
	align="center" class="outertable">
	<tr>
		<td width="98%" align="left"><b>Permission sought by the
		Branch for entertaining Loan proposal from&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_APPLIANTNAME"))%><br>
		<% ArrayList arrCol1 = new ArrayList();
								if(arrRow!=null && arrRow.size()>0){
								for(int i=0;i<arrRow.size();i++){ 
								arrCol1 = (ArrayList)arrRow.get(i);%> Rs.<u><%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol1.get(1))))%></u>&nbsp;
		under <u><%=(String)arrCol1.get(5)%></u>&nbsp; Scheme &nbsp;<%=(String)arrCol1.get(4)%>&nbsp;".</b><br>
		&emsp;<%}} %>
		</td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td>
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable">
			<tr valign="top">
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Name of the applicant</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_APPLIANTNAME"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Address of the applicant</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_APPLADDRESS"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Constitution</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_CONSTITUTION"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Nature of the Activity</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_ACTIVITY"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Date of Establishment</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_ESTBDATE"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Dealings with us since</td>
				<%if(!Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE")).equals("")){ %>
					<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_DEALINGSINCE"))%></td>
				<% } else { %>
				 	<td width="52%">Not a Customer</td>
				<% } %>
			</tr>
			<tr>
				<td align="center"><%=a1++%></td>
				<td> Background of the applicant</td>
				<td>&nbsp;<%=Helper.correctNull((String) hshValues.get("strBkgroundcmts")) %></td>
		    </tr>
		</table>
		</div>
		</td>
	</tr>

	<%if(!Helper.correctNull((String) hshValues.get("PG_CONSTITUTIONS")).equalsIgnoreCase("01"))
				{%>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td class="title"><%=a1++%>.Management Details</td>
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
				<td>S.no.</td>
				<td>Name</td>
				<td>Concern type</td>
				<td>Sub type</td>
			</tr>
			<% 
				ArrayList arrCol4 = new ArrayList();
				ArrayList arrRow4 = (ArrayList)hshValues.get("arrData4");
				String Designation="";
				if(arrRow4!=null && arrRow4.size()>0)
				{
					for(int i=0;i<arrRow4.size();i++)
					{ 
					arrCol4 = (ArrayList)arrRow4.get(i);
				
				%>


			<tr>
				<td width="5%">&nbsp;<%=i+1%></td>
				<td width="35%">&nbsp;<%=arrCol4.get(0)%></td>
				<td width="30%">&nbsp;<%=arrCol4.get(1)%></td>
				<td width="30%">&nbsp;<%=arrCol4.get(2)%></td>

			</tr>
			<%}}else{ %>
			<tr>
				<td width="5%">&nbsp;</td>
				<td width="35%">&nbsp;</td>
				<td width="30%">&nbsp;</td>
				<td width="30%">&nbsp;</td>
			</tr>
			<%} %>
		</table>
		</div>
		</td>
	</tr>
	<%} %>

	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td class="title"><%=a1++%>.Existing Facility: (if any)</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
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
				<td width="5%"><b>S.No</b></td>
				<td width="10%"><b>Proposal No</b></td>
				<td width="11%"><b>Name of the Borrower</b></td>
				<td width="10%"><b>Module Type</b></td>
				<td width="12%"><b>Limit</b></td>
				<td width="12%"><b>O/s. Bal</b></td>
				<td width="10%"><b>ROI/ Commission</b></td>
				<td width="10%"><b>Due Date</b></td>
				<td width="18%"><b>Arrears</b></td>
			</tr>

			<% 
								ArrayList arrCol5 = new ArrayList();
								ArrayList arrRow5= (ArrayList)hshValues.get("arrData5");
								int e=0;
								if(arrRow5!=null && arrRow5.size()>0)
								{
								for(int i=0;i<arrRow5.size();i++)
								{ 
								arrCol5 = (ArrayList)arrRow5.get(i);
								e=e+1;
								%>

			<tr align="center">
				<td>&nbsp;<%=e%></td>
				<td><%=Helper.correctNull((String)arrCol5.get(0))%>&nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol5.get(3))%>&nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol5.get(2))%>&nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol5.get(6))%>&nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol5.get(7))%>&nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol5.get(8))%>&nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol5.get(9))%>&nbsp;</td>
				<td><%=Helper.correctNull((String)arrCol5.get(10))%>&nbsp;</td>
			</tr>
			<%}%>
			
				<tr align="center">
						<td colspan="4" style="border: none;" align="right">Total</td>
						<td><%=Helper.correctDouble((String)hshValues.get("strExposureTot")) %></td>
						<td><%=Helper.correctDouble((String)hshValues.get("strOutstandingTot")) %></td>
						</tr>				
				<%}else
									{%>
			<tr align="center">
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<%} %>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td class="title"><%=a1++%>.Security Details for the Existing
				Facilities:</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
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
				<td width="12%">Proposal Number</td>
				<td width="11%">Facility S.no</td>
				<td width="12%">Security ID</td>
				<td width="12%">Applicant Name</td>
				<td width="20%">Security Description</td>
				<td width="11%">Security Value</td>
				<td width="11%">Security Type</td>
				<td width="11%">Security Margin (%)</td>
			</tr>
			<% 
							ArrayList arrCol7 = new ArrayList();
							ArrayList arrRow7 = (ArrayList)hshValues.get("arrData7");
							int q=0;
							if(arrRow7!=null && arrRow7.size()>0)
							{
							for(int i=0;i<arrRow7.size();i++)
							{ 
							arrCol7 = (ArrayList)arrRow7.get(i);
							q=q+1;
							%>
			<tr>
				<td style="text-align: center">&nbsp;<%=q%></td>
				<td style="text-align: left">&nbsp;<%=arrCol7.get(0)%></td>
				<td style="text-align: left">&nbsp;<%=arrCol7.get(1)%></td>
				<td style="text-align: left">&nbsp;<%=arrCol7.get(2)%></td>
				<td style="text-align: left">&nbsp;<%=arrCol7.get(3)%></td>
				<td style="text-align: center">&nbsp;<%=arrCol7.get(4)%></td>
				<td style="text-align: right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol7.get(5))))%></td>
				<td style="text-align: center">&nbsp;<%=arrCol7.get(6)%></td>
				<td style="text-align: center">&nbsp;<%=arrCol7.get(7)%></td>

			</tr>
			<%}%>
			
			<tr>
			<td colspan="6" style="border: none;" align="right">Total</td>
			<td align="right"><%=Helper.correctDouble((String)hshValues.get("dblSecTotal")) %></td>
			</tr>
		
		<%} else{%>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
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
				<td class="title"><%=a1++%>.Present request:</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
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
				int q1=0;
				if(arrRow!=null && arrRow.size()>0)
				{
				for(int i=0;i<arrRow.size();i++)
				{ 
				arrCol = (ArrayList)arrRow.get(i);
				q1=q1+1;
				%>
			<tr>
				<td style="text-align: center">&nbsp;<%=q1%></td>
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
				<td class="title"><%=a1++%>.The details of securities available for the proposed facilities and their value</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
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
	<tr>
		<td>
		<div id="top">
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Reasons for switch over to our
				Bank (in case of take over)</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_RSN_SWITCH"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Account introduced by</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_ACC_INTRODBY"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Any Group concerns Business
				Potential</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_GRPCRCN_POT"))%></td>
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
		<table width="98%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td class="title"><%=a1++%>. a)In the case of Project Loan/Term
				Loan / DPN:</td>
				 <td style="text-align:right"  class="title">(All Values are in&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strAmntType"))%>)&nbsp;&nbsp;
			    </td>
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
				<td colspan="2" align="center"><b>Project Cost</b></td>
				<td colspan="2" align="center"><b>Means of Finance</b></td>
				<td colspan="1" align="center"><b> % to total</b></td>
			</tr>
			<tr>
				<td width="28%" align="left">Cost of land</td>
				<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LANDCOST"))%></td>
				<td width="32%" align="left">Promoters Contribution & Internal
				Accruals</td>
				<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_PROMOTCONTRIB"))%></td>
				<td width="12%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_PERCENTTOTAL1"))%></td>
			</tr>
			<tr>
				<td width="28%" align="left">Cost of construction</td>
				<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_CONSTRUCTIONCOST"))%></td>
				<td width="32%" align="left">Advance amount from the
				prospective buyers</td>
				<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_ADVANCEAMT"))%></td>
				<td width="12%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_PERCENTTOTAL2"))%></td>
			</tr>
			<tr>
				<td width="28%">&nbsp;</td>
				<td width="14%">&nbsp;</td>
				<td width="32%" align="left">Proposed Term Loan from Karnataka
				Bank</td>
				<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_LOANFROMKBL"))%></td>
				<td width="12%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_PERCENTTOTAL3"))%></td>
			</tr>
			<tr>
				<td width="28%" align="left"><b>Total Project Cost</b></td>
				<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TOTPROJECTCOST"))%></td>
				<td width="32%" align="left"><b>Total Means of Finance</b></td>
				<td width="14%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TOTMEANSOFFINANCE"))%></td>
				<td width="12%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_PERCENTTOTAL4"))%></td>
			</tr>
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
				<td width="4%" align="center">b)</td>
				<td width="44%" align="left">Sources for the margin money</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SRC_MARGINMONEY"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center">c)</td>
				<td width="44%" align="left">Mode and Source of repayment</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_SRC_REPAYMENT"))%></td>
			</tr>

			<tr>
				<td width="4%" align="center">d)</td>
				<td align="left" colspan="2"><b>Additional information:</b></td>

			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Total area of the site property in
				sq feet</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TOTAREA"))%></td>

			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Total built up area of the
				building in sq feet</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TOTBUILTUPAREA"))%></td>

			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Details of floors that the
				proposed building consists of</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_FLOORDETAILS"))%></td>

			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Total cost of construction per
				sq.feet</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_TOTCONSTCOST"))%></td>

			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Average selling price for sq
				feet(For Residential Flats)</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_AVGSELLINGPRICE_RF"))%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Average selling price per sq
				feet(For commercial Space)</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_AVGSELLINGPRICE_CP"))%></td>
			</tr>

			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Projected rent to be received from
				letting out of the building/shops with details.</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_PROJECTEDRENT"))%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td align="left" width="44%">Confirmation regarding necessary
				permission from the respective authorities for construction of
				building.</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_CONF_AUTH_CONSTBUILD"))%></td>
			</tr>
			<tr>
					<%if(strpermissionfalg.equalsIgnoreCase("Y")){%>
						<td width="4%" align="center"><%=a1++%></td>
						<td   width="44%">Hunter Score</td>
				        <td   width="54%"><%=Helper.correctNull((String) hshValues.get("intHuntScore1"))%></td>
					<%} %>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Concession in Rate of Interest,
				processing charges, Commission on Bank Guarantee, etc. recommended</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_CONCESSION_RECOMMENDED"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Justification for the concession
				sought by the Branch :</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_CONCESSION_JUSTIF"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Details of Visits made by the
				Regional Head, if any.</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_DETOFVISIT"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Background of the party (including
				the details of earlier projects)</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_PARTYBG_EARPROJECTS"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Recommendation by the Branch/RLPC</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_BRANCH"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Sanction Department view</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_HOVIEW"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center"><%=a1++%></td>
				<td width="44%" align="left">Sanction Department Recommendation</td>
				<td width="52%">&nbsp;<%=Helper.correctNull((String) hshValues.get("PG_RECOMMEND_HO"))%></td>
			</tr>
			<tr>
				<td width="4%" align="center" valign="top"><%=a1++%></td>
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
									
             							if (i % 2 == 0) {%>
			<tr>
				<td>&nbsp;</td>
			</tr>
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
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
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
</form>
</body>
</html>