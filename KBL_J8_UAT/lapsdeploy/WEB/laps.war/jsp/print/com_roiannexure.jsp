<%@include file="../share/directives.jsp"%>
<%
	HashMap hsh=new HashMap();
	int intFacCount=Integer.parseInt(Helper
			.correctInt((String)hshValues.get("strFacCount")));
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	ArrayList arrCol1=new ArrayList();
	String strFormat=Helper.correctNull((String)request
			.getParameter("strFormat"));
%>
<html>
<head>
<%
	if(strFormat.equalsIgnoreCase("EAN8"))
	{
%>
<title>ANNEXURE VIII</title>
<%
	}
	else
	{
%>
<title>ANNEXURE VI</title>
<%
	}
%>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
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
</head>
<body>
<table width="95%" align="center" cellpadding="3" cellspacing="0"
	border="0">
	<%
		if(strFormat.equalsIgnoreCase("EAN8"))
		{
	%>
	<tr>
		<td align="center" class="title"><br>
		ANNEXURE VIII</td>
	</tr>
	<tr>
		<td align="center" class="title"><br>
		RATE OF INTEREST FOR EXPORT FINANCE</td>
	</tr>
	<%
		}
		else
		{
	%>
	<tr>
		<td align="center" class="title"><br>
		ANNEXURE VI</td>
	</tr>
	<tr>
		<td align="center" class="title"><u>Worksheet for calculation
		of effective interest rate for General Loans </u><br />
		[Other than Schematic (including retail), Forex Credit and
		Agricultural Credit]</td>
	</tr>
	<%
		}
	%>
	<tr>
		<td>&nbsp;</td>
	</tr>

	<tr>
		<td>
		<table width="95%" align="center" cellpadding="3" cellspacing="0"
			border="0">
			<%
				for(int i=1;i<=intFacCount;i++)
				{
					hsh=(HashMap)hshValues.get("hshResult"+i);
					if(hsh!=null)
					{
			%>
			<%
				if(strFormat.equalsIgnoreCase("EAN8"))
						{
			%>
			<tr>
				<td><b>Facility : <%=Helper.correctNull((String)hsh
										.get("strFacSno"))%> - <%=Helper.correctNull((String)hsh
										.get("strFacDesc"))%></b></td>
			</tr>
			<%
				if(!Helper.correctNull(
									(String)hsh.get("strROIComments"))
									.equalsIgnoreCase(""))
							{
			%>
			<tr>
				<td><%=Helper.correctNull((String)hsh
											.get("strROIComments"))%>&nbsp;</td>
			</tr>
			<%
				}
							else
							{
			%>
			<tr align="center">
				<td>- Nil - &nbsp;</td>
			</tr>
			<%
				}
			%>
			<%
				}
						else
						{
			%>
			<tr>
				<td>
				<div id="top">
				<table width="98%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<tr class="title">
						<td width="50%">Branch</td>
						<td width="50%"><%=Helper.correctNull((String)hsh
										.get("strDisbBranch"))%>&nbsp;</td>
					</tr>
					<tr class="title">
						<td>Name of the Borrower</td>
						<td><%=Helper.correctNull((String)hsh
										.get("strAppName"))%>&nbsp;</td>
					</tr>
					<tr class="title">
						<td>Nature of the Loan/Facility</td>
						<td><%=Helper.correctNull((String)hsh
										.get("strFacSno"))%> - <%=Helper.correctNull((String)hsh
										.get("strFacDesc"))%>&nbsp;</td>
					</tr>
					<tr class="title">
						<td>Amount</td>
						<td><%=Helper.correctNull((String)hsh
										.get("strFacSancAmt"))%>&nbsp;</td>
					</tr>
					<tr class="title">
						<td>Sector of the Loan</td>
						<td><%=Helper.correctNull((String)hsh
										.get("strSector"))%>&nbsp;</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>

			<tr>
				<td>
				<div id="top">
				<table width="98%" align="center" cellpadding="3" cellspacing="0"
					border="0">
					<%
						if(!Helper.correctNull(
											(String)hsh.get("strMCLRtypeDesc"))
											.equalsIgnoreCase(""))
									{
					%>
					<tr class="title">
						<td width="5%">A</td>
						<td width="70%" colspan="3"><%=Helper.correctNull((String)hsh
											.get("strMCLRtypeDesc"))%>&nbsp;</td>
						<td width="25%" style="text-align: right;"><%=Helper.correctNull((String)hsh
											.get("mclr_spread"))%>&nbsp;</td>
					</tr>
					<%
						}
									arrRow=(ArrayList)hsh.get("arrRowCRP");
									if(arrRow!=null&&arrRow.size()>0 )
									{%>
									
									<tr class="title">
						<td>B</td>
						<td colspan="2">Credit Risk Premium&nbsp;</td>
						<td width="25%" style="text-align: right;">&nbsp;</td>
						<td rowspan="<%=Helper.correctInt((String)hsh.get("strCRPCnt")) %>">&nbsp;</td>
					</tr>
										<%for(int a=0;a<arrRow.size()-1;a++)
										{
											arrCol=(ArrayList)arrRow.get(a);
											for(int b=0;b<arrCol.size();b++)
											{
												arrCol1=(ArrayList)arrCol.get(b);
					%>
					<tr>
						<td>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol1.get(0)) %>&nbsp;</td>
						<td style="text-align: right;"><%=Helper.correctNull((String)arrCol1.get(1)) %>&nbsp;</td>
						<%if(b==0){ %>
						<td style="text-align: right;"><%=Helper.correctNull((String)arrCol1.get(2)) %>&nbsp;</td>
						<%}else if(b==1){ %>
						<td rowspan="<%=arrCol.size()-1 %>"  style="text-align: right;"><%=Helper.correctNull((String)arrCol1.get(2)) %>&nbsp;</td>
						<%} %>
						</tr>
						<%
											}
										}
										%>
										<tr class="title">
									<td>&nbsp;</td>
									<td colspan="3">Sub total&nbsp;</td>
									<td width="25%" style="text-align: right;"><%=Helper.correctNull((String)hsh.get("mclr_crp_total")) %>&nbsp;</td>
								</tr>
												<%
									}
									arrRow=(ArrayList)hsh.get("arrRowBSP");
									if(arrRow!=null&&arrRow.size()>0)
									{%>
									
									<tr class="title">
						<td>C</td>
						<td colspan="2">BUSINESS STRATEGY PREMIUM&nbsp;</td>
						<td width="25%" style="text-align: right;">&nbsp;</td>
						<td  rowspan="<%=Helper.correctInt((String)hsh.get("strBSPCnt")) %>">&nbsp;</td>
						
					</tr>
										<%
										for(int a=0;a<arrRow.size()-1;a++)
										{
											arrCol=(ArrayList)arrRow.get(a);
											for(int b=0;b<arrCol.size();b++)
											{
												arrCol1=(ArrayList)arrCol.get(b);
					%>
					<tr>
						<td>&nbsp;</td>
						<td><%=Helper.correctNull((String)arrCol1.get(0)) %>&nbsp;</td>
						<td style="text-align: right;"><%=Helper.correctNull((String)arrCol1.get(1)) %>&nbsp;</td>
						<%if(b==0){ %>
						<td style="text-align: right;"><%=Helper.correctNull((String)arrCol1.get(2)) %>&nbsp;</td>
						<%}else if(b==1){ %>
						<td rowspan="<%=arrCol.size()-1 %>"  style="text-align: right;"><%=Helper.correctNull((String)arrCol1.get(2)) %>&nbsp;</td>
						<%} %>
						</tr>
						<%
											}
										}%>
							<tr class="title">
						<td>&nbsp;</td>
						<td colspan="3">Sub total&nbsp;</td>
						<td width="25%" style="text-align: right;"><%=Helper.correctNull((String)hsh.get("mclr_bsp_total")) %>&nbsp;</td>
					</tr>
									<%}
					%>
					
					<tr class="title">
						<td>&nbsp;</td>
						<td colspan="3">Effective Interest Rate (A+B+C)&nbsp;</td>
						<td width="25%" style="text-align: right;"><%=Helper.correctNull((String)hsh.get("strSacnIntRate")) %>&nbsp;</td>
					</tr>
					
				</table>
				</div>
				</td>
			</tr>
			<%
				}
			%>

			<%
				}%>
				
				<tr>
		<td>&nbsp;</td>
	</tr>
			<%	}
			%>
			
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</body>
</html>