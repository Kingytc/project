<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%request.setAttribute("_cache_refresh", "true");%>
<laps:handleerror />
<%NumberFormat nf = NumberFormat.getInstance();
			nf.setMinimumFractionDigits(2);
			nf.setMaximumFractionDigits(2);
			nf.setGroupingUsed(false);
			ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			ArrayList vecElement = new ArrayList();
			ArrayList vecregionname = new ArrayList();
			vecElement = (ArrayList) hshValues.get("totalregion");
			vecregionname = (ArrayList) hshValues.get("regionname");
			String strlevel = Helper.correctNull((String) hshValues
					.get("levelcode"));

			%>

<html>
<head>
<title>DCB Register</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<form>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	bgcolor="#FFFFFF">
	<tr>
		<td align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
	</tr>
	<tr>
		<td align="center"><strong>Karnataka Bank Ltd.</strong></td>
	</tr>
	<tr>
		<td align="center"><%=Helper.correctNull((String) hshValues.get("branchname"))%></td>
	</tr>
	<tr>
		<td align="center"><b>DCB Register Report</b></td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center" bgcolor="#FFFFFF">
	<tr>
		<td>
		<div id="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			bordercolorlight="#FFFFFB" bordercolor='#eeeeee'>
			<tr>
				<td align="center" width="2%" rowspan="2"><b>&nbsp;</b></td>
				<td align="center" width="13%" rowspan="2"><b>Sector</b></td>
				<td align="center" width="5%" rowspan="2"><b>Scheme</b></td>
				<td align="center" colspan="3"><b>DEMAND</b></td>
				<td align="center" colspan="2"><b>COLLECTION
				(RECOVERY)</b></td>
				<td align="center" colspan="4"><b>OVERDUE
				(BALANCE)</b></td>
				<td align="center" width="8%" rowspan="2"><b>REMARKS</b></td>
			</tr>
			<tr>
				
				<td align="center" width="8%"><b>Arrears</b></td>
				<td align="center" width="8%"><b>Current</b></td>
				<td align="center" width="8%"><b>Total</b></td>
				<td align="center" width="8%"><b>Recovery</b></td>
				<td align="center" width="8%"><b>Advance
				Collection</b></td>
				<td align="center" width="7%"><b>&lt; 1 year </b></td>
				<td align="center" width="8%"><b>1 to 3
				Years </b></td>
				<td align="center" width="8%"><b> &gt; 3 Years
				</b></td>
				<td align="center" width="8%"><b>Total</b></td>

			</tr>
			<%if (vecElement.size() > 0 && vecElement != null)
				vecRow = (ArrayList) vecElement.get(0);

			if (vecRow != null && strlevel.equalsIgnoreCase("A")) {
				if (vecRow.size() > 0) {

					for (int i = 0; i < vecRow.size(); i++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>

			<tr bgcolor="#FFFFFF">
				<td width="2%">&nbsp; <%=i + 1%></td>
				<td width="13%"><%if (Helper.correctNull((String) vecCol.get(0))
								.equals("OTHPS"))
							out.print("Other Priority Sector");//1
						else if (Helper.correctNull(
								(String) vecCol.get(0)).equals("AGRDT"))
							out.print("Agriculture Direct");//1
						else if (Helper.correctNull(
								(String) vecCol.get(0)).equals("SSIDT"))
							out.print("SSI Direct");//1
						else
							out.print("");

						%>&nbsp;</td>
				<td width="5%"><%=Helper.correctNull((String) vecCol.get(1))%>&nbsp;</td>
				
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(4))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(6))%></td>
				<td align="right" width="7%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(8))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(9))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(10))%></td>
				<td>&nbsp;</td>
			</tr>

			<%}
				}
			} else if (vecRow != null && strlevel.equalsIgnoreCase("D")) {
				for (int j = 0; j < vecElement.size(); j++) {
					vecRow = (ArrayList) vecElement.get(j);

					%>

			<tr>
				<td align="left" colspan="13"><b>Branch Name: <%=vecregionname.get(j).toString()%>
				</b></td>
			</tr>
			<%for (int i = 0; i < vecRow.size(); i++) {
						vecCol = (ArrayList) vecRow.get(i);

						%>

			<tr bgcolor="#FFFFFF">
				<td width="2%">&nbsp; <%=i + 1%></td>
				<td width="13%"><%=Helper.correctNull((String) vecCol.get(0))%>&nbsp;</td>
				<td width="5%"><%=Helper.correctNull((String) vecCol.get(1))%>&nbsp;</td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(2))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(4))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(5))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(6))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(8))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(9))%></td>
				<td align="right" width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(10))%></td>
				<td width="8%">&nbsp;</td>
			</tr>
			<%}
				}
			}

			if (vecElement == null || vecElement.size() == 0) {

			%>

			<tr>
				<td align="center" colspan="13">No Data Found</td>
			</tr>
			<%}

		%>
		</table>
		</div>
		</td>
	</tr>
</table>
</form>
</body>
</html>