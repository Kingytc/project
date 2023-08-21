<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.ArrayList"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
ArrayList arrRow = null;
			ArrayList arrCol = null;
			double dblsubtotal = 0.0;
			double dbltotal = 0.0;
			String strValuesin = Helper.correctNull((String) request
					.getParameter("valuesin"));

			String strInwardno = Helper.correctNull((String) request
					.getParameter("inwardno"));
String facnature="";
%>
<html>
<head>
<title>Recommendations by Branch</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0" class="bgcolor">
<form method="post">

<table width="80%" border="0" cellspacing="0" cellpadding="5"
	align="center" valign="top">
	<tr>
		<td align="center" colspan="2"><img
			src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
	</tr>
	<tr>
		<td align="center" colspan="2">INTER OFFICE LETTER</td>
	</tr>
	<tr>
		<td valign="top" align="center" colspan="2">
		<div id="top">
		<table width="90%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td valign="top"><b> FROM:<br>
				The Branch Manager<br>
				<%=Helper.correctNull((String) hshValues.get("branchname"))%> </b></td>
				<td valign="top"><b> TO:<br>
				The Asst Gen Manager,<br>
				Saral<br>
				<%=Helper.correctNull((String) hshValues
									.get("regionalname"))%> </b></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td align="left" colspan="2">InwardNo : <%=strInwardno%></td>
	</tr>
	<tr>
		<td align="center" colspan="2">Sub:<u>Recommendations for sanction</u></td>
	</tr>
	<tr>
		<td colspan="2"><%=Helper.decodeAmpersand(Helper.correctNull((String) hshValues.get("appname")))%>
		has requested for sanction of following limits:</td>
	</tr>
	<tr>
		<td colspan="2">
		<div id="top">
		<table border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="3" align="right"><b>( <%=ApplicationParams.getCurrency()%>
				<%=strValuesin%> )</b></td>
			</tr>
			<tr>
				<td width="40%"><b>Nature of Facility</b></td>
				<td width="20%"><b>Limits Applied for</b></td>
				<td width="40%"><b>Purpose</b></td>
			</tr>
			<%arrRow = new ArrayList();
			int count = 0;
			arrRow = (ArrayList) hshValues.get("arrCLApplied");
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td colspan="3" align="left"><b>Contigent Limits</b></td>
			</tr>
			<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					if (Helper.correctNull((String) arrCol.get(3)).equals("0")) {
						count = 0;
						dblsubtotal = dblsubtotal
								+ Double.parseDouble(Helper
										.correctDouble((String) arrCol.get(1)));

						%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
			</tr>
			<%} else {
						if (count == 0) {%>
			<tr>
				<td colspan="3"><b>&gt;&gt;SubLimit</b></td>
			</tr>

			<%}

						%>
			<tr>
			<td>
			Nature of Facility
			</td>
			<%
			 if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("1"))
 			{
 				facnature="Contingent Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("2"))
 			{
 				facnature="Working capital Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("3"))
 			{
 				facnature="Term Loan/DPGL Limits";
 			}
 			else
 			{
 				facnature="";
 			}
			%>
			<td colspan="2"> 
			<%=facnature %>
			</td>
			
			</tr>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right">(<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%>)</td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
			</tr>


			<%count++;
					}

				%>

			<%}%>
			<tr>
				<td>Sub-Total&nbsp;</td>
				<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblsubtotal)%></td>
				<td>&nbsp;</td>
			</tr>
			<%dbltotal = dbltotal + dblsubtotal;
				dblsubtotal = 0.0;
			}

			%>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrWCApplied");
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td colspan="3" align="left"><b>Working Capital Limits</b></td>
			</tr>
			<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					if (Helper.correctNull((String) arrCol.get(3)).equals("0")) {
						count = 0;
						dblsubtotal = dblsubtotal
								+ Double.parseDouble(Helper
										.correctDouble((String) arrCol.get(1)));

						%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
			</tr>
			<%} else {
						if (count == 0) {

						%>
			<tr>
				<td colspan="3"><b>&gt;&gt;SubLimit</b></td>
			</tr>
			<%}

						%>
			<tr>
			<td>
			Nature of Facility
			</td>
			<%
			 if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("1"))
 			{
 				facnature="Contingent Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("2"))
 			{
 				facnature="Working capital Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("3"))
 			{
 				facnature="Term Loan/DPGL Limits";
 			}
 			else
 			{
 				facnature="";
 			}
			%>
			<td colspan="2">
			<%=facnature %>
			</td>
			
			</tr>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right">(<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%>)</td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
			</tr>
			<%count++;
					}
				}%>
			<tr>
				<td>Sub-Total&nbsp;</td>
				<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblsubtotal)%></td>
				<td>&nbsp;</td>
			</tr>
			<%dbltotal = dbltotal + dblsubtotal;
				dblsubtotal = 0.0;
			}

			%>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrTLApplied");
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td colspan="3" align="left"><b>Term Loan/DPGL Limits</b></td>
			</tr>
			<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					if (Helper.correctNull((String) arrCol.get(3)).equals("0")) {
						count = 0;
						dblsubtotal = dblsubtotal
								+ Double.parseDouble(Helper
										.correctDouble((String) arrCol.get(1)));

						%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
			</tr>
			<%} else {
						if (count == 0) {%>
			<tr>
				<td colspan="3"><b>&gt;&gt;SubLimit</b></td>
			</tr>
			<%}

						%>
						<tr>
			<td>
			Nature of Facility
			</td>
			<%
			 if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("1"))
 			{
 				facnature="Contingent Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("2"))
 			{
 				facnature="Working capital Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("3"))
 			{
 				facnature="Term Loan/DPGL Limits";
 			}
 			else
 			{
 				facnature="";
 			}
			%>
			<td colspan="2">
			<%=facnature %>
			</td>
			
			</tr>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right">(<%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%>)</td>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
			</tr>
			<%count++;
					}
				}%>
			<tr>
				<td>Sub-Total&nbsp;</td>
				<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblsubtotal)%></td>
				<td>&nbsp;</td>
			</tr>
			<%dbltotal = dbltotal + dblsubtotal;
				dblsubtotal = 0.0;
			}

			%>
			<tr>
				<td><b> Grand Total </b></td>
				<td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {

				%>
		<td colspan="2">Prime/Collateral Securities</td>
	</tr>
	<tr>
		<td colspan="2">
		<div id="top">
		<table border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td width="80%"><b>Nature/ Description of collateral security
				indicating area &amp; location of property</b></td>
				<td width="20%"><b>Present Value (Rs. <%=strValuesin%>)</b></td>
			</tr>
			<%for (int intprime = 0, intcoll = 0, i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);

					%>
			<%if (Helper.correctNull((String) arrCol.get(0)).equals("1")) {
						intprime++;
						if (intprime == 1) {

						%>
			<tr>
				<td colspan="2"><b> Primary Security </b></td>
			</tr>
			<%}

						%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
			</tr>
			<%} else if (Helper.correctNull((String) arrCol.get(0))
							.equals("2")) {
						intcoll++;
						if (intcoll == 1) {

						%>
			<tr>
				<td colspan="2"><b> Collateral Security </b></td>
			</tr>
			<%}

						%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
										.parseDouble(Helper
												.correctDouble((String) arrCol
														.get(1))))%></td>
			</tr>
			<%}
				}%>
		</table>
		</div>
		</td>
		<%}

			%>
	</tr>
	<tr>
		<td colspan="2">Looking into the market reputation of the party, we
		propose to recommend for the following limits:</td>
	</tr>
	<tr>
		<td colspan="2">
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td colspan="2" align="right"><b>( <%=ApplicationParams.getCurrency()%>
				<%=strValuesin%> )</b></td>
			</tr>
			<tr>
				<td width="60%"><b>Nature of Facility</b></td>
				<td width="40%"><b>Limits recommended for</b></td>
			</tr>
			<%dblsubtotal = 0.0;
			dbltotal = 0.0;
			arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrCLRecmd");
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td colspan="2" align="left"><b>Contigent Limits</b></td>
			</tr>
			<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					if(Helper.correctNull((String)arrCol.get(2)).equals("0"))
					{
					count=0;	
					dblsubtotal = dblsubtotal
							+ Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)));

					%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))%></td>
			</tr>
			<%}else{ if(count==0){ %>
			<tr>
				<td colspan="2"><b>&gt;&gt;SubLimit</b></td>
			</tr>
			<%} %>
			<tr>
			<td>
			Nature of Facility
			</td>
			<%
			 if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("1"))
 			{
 				facnature="Contingent Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("2"))
 			{
 				facnature="Working capital Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("3"))
 			{
 				facnature="Term Loan/DPGL Limits";
 			}
 			else
 			{
 				facnature="";
 			}
			%>
			<td>
			<%=facnature %>
			</td>
			
			</tr>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right">(<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))%>)</td>
			</tr>
			<%count++;} %>
			<%}%>
			<tr>
				<td>Sub-Total&nbsp;</td>
				<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblsubtotal)%></td>
			</tr>
			<%dbltotal = dbltotal + dblsubtotal;
				dblsubtotal = 0.0;
			}

			%>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrWCRecmd");
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td colspan="2" align="left"><b>Working Capital Limits</b></td>
			</tr>
			<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					if(Helper.correctNull((String)arrCol.get(2)).equals("0"))
					{
					count=0;
					dblsubtotal = dblsubtotal
							+ Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)));

					%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))%></td>
			</tr>
			<%}else{ if(count==0){ %>
			<tr>
				<td colspan="2"><b>&gt;&gt;SubLimit</b></td>
			</tr>
			<%} %>
			<tr>
			<td>
			Nature of Facility
			</td>
			<%
			 if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("1"))
 			{
 				facnature="Contingent Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("2"))
 			{
 				facnature="Working capital Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("3"))
 			{
 				facnature="Term Loan/DPGL Limits";
 			}
 			else
 			{
 				facnature="";
 			}
			%>
			<td>
			<%=facnature %>
			</td>
			
			</tr>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right">(<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))%>)</td>
			</tr>
			<%count++;} %>
			<%}%>
			<tr>
				<td>Sub-Total&nbsp;</td>
				<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblsubtotal)%></td>
			</tr>
			<%dbltotal = dbltotal + dblsubtotal;
				dblsubtotal = 0.0;
			}

			%>
			<%arrRow = new ArrayList();
			arrRow = (ArrayList) hshValues.get("arrTLRecmd");
			if (arrRow != null && arrRow.size() > 0) {

				%>
			<tr>
				<td colspan="2" align="left"><b>Term Loan/DPGL Limits</b></td>
			</tr>
			<%for (int i = 0; i < arrRow.size(); i++) {
					arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					if(Helper.correctNull((String)arrCol.get(2)).equals("0"))
					{
					count=0;
					dblsubtotal = dblsubtotal
							+ Double.parseDouble(Helper
									.correctDouble((String) arrCol.get(1)));

					%>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right"><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))%></td>
			</tr>
			<%}else{ if(count==0){ %>
			<tr>
				<td colspan="2"><b>&gt;&gt;SubLimit</b></td>
			</tr>
			<%} %>
			<tr>
			<td>
			Nature of Facility
			</td>
			<%
			 if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("1"))
 			{
 				facnature="Contingent Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("2"))
 			{
 				facnature="Working capital Limits";
 			}
 			else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("3"))
 			{
 				facnature="Term Loan/DPGL Limits";
 			}
 			else
 			{
 				facnature="";
 			}
			%>
			<td>
			<%=facnature %>
			</td>
			
			</tr>
			<tr>
				<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
				<td align="right">(<%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) arrCol
													.get(1))))%>)</td>
			</tr>
			<%count++;} %>
			<%}%>
			<tr>
				<td>Sub-Total&nbsp;</td>
				<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblsubtotal)%></td>
			</tr>
			<%dbltotal = dbltotal + dblsubtotal;
				dblsubtotal = 0.0;
			}

			%>
			<tr>
				<td><b> Grand Total</b></td>
				<td align="right"><%=Helper.formatDoubleValue(dbltotal)%></td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="2"><b>Recommendations by Branch</b></td>
	</tr>
	<tr>
		<td colspan="2"><%=Helper.formatTextAreaData((String) hshValues
							.get("brrecomdations"))%></td>
	</tr>
	<tr>
		<td colspan="2">However the above recommendation is subject to
		economic viability, technical feasibility &amp; MPBF limits of the
		bank.</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td align="right">&nbsp;</td>
	</tr>
	<tr>
		<td width="50%">&nbsp;</td>
		<td width="50%" align="right"><b>Branch Head</b></td>
	</tr>
</table>


</form>
</body>
</html>
