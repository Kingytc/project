<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>

<laps:handleerror />

<%
	String[] strLable = {
			"Applications Pending at the beginning of Quarter",
			"Applications pending beyond sanction time norms at the beginning of Quarter",
			"Applications received during the Quarter",
			"Applications sanctioned during the Quarter",
			"Out of sanctions made disbursed during the Quarter (inclusive of previous sanctions)",
			"Applications rejected during the Quarter",
			"Applications pending at the end of the Quarter",
			"Applications pending beyond sanction time norms at the end of the Quarter" };

	ArrayList arrrow = new ArrayList();
	ArrayList arrcol = new ArrayList();

	arrrow = (ArrayList) hshValues.get("arrCol");
	//out.println(hshValues);
%>

<html>
<head>
<title>MSME Account Format</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/print_new.css"
	type="text/css">
</head>
<body>
<table align="center" width="100%" cellpadding="3" cellspacing="0"
	border="0">

	<tr>
		<td align="center">
		<table align="center" width="90%" cellpadding="3" cellspacing="0"
			border="0">
			
			 <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
         <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("Org_Name"))%></td>
        </tr> 
			<tr>
				<td align="center" width="80%"><br>
				<br>
				</td>
			</tr>
			<tr>
				<td align="center" width="80%"><b>Annexure A</b></td>
			</tr>
			<tr>
				<td align="center" width="80%"><b>MSME ACCOUNTS - Format
				for reporting of Applications received/ sanctioned/rejected </b><br>
				<%
					if (!(Helper.correctNull((String) hshValues.get("Quarter"))
							.equalsIgnoreCase("Range"))) {
				%>
				<b> for the Quarter ended <%=Helper.correctNull((String) hshValues
										.get("Quarter"))%></b>
				<%
					} else {
				%> <b> From <%=Helper.correctNull((String) hshValues
								.get("hshFromDate"))%>
				To <%=Helper.correctNull((String) hshValues
								.get("hshToDate"))%></b> <%
 	}
 %>
				</td>
			</tr>
			<tr>
				<td align="left" width="80%"><br>
				</td>
			</tr>

			<%
				String strrepotytype = "", reportVal = "";
				if (Helper.correctNull((String) hshValues.get("reporttype"))
						.equalsIgnoreCase("S")) {
			%>
			<tr>
				<td align="center" width="80%"><b>State : <%=Helper.correctNull((String) hshValues
								.get("reportTypeVal"))%></b>
				<br>
				</td>
			</tr>
			<%
				} else if (Helper.correctNull((String) hshValues.get("reporttype"))
						.equalsIgnoreCase("D")) {
			%>
			<tr>
				<td align="center" width="80%"><b>District : <%=Helper.correctNull((String) hshValues
								.get("reportTypeVal"))%></b>
				<br>
				</td>
			</tr>
			<%
				} else if (Helper.correctNull((String) hshValues.get("reporttype"))
						.equalsIgnoreCase("B")) {
			%>
			<tr>
				<td align="center" width="80%"><b>Branch : <%=Helper.correctNull((String) hshValues
								.get("reportTypeVal"))%></b>
				<br>
				</td>
			</tr>
			<%
				}
				//for zonal..
				else if (Helper.correctNull((String) hshValues.get("reporttype"))
						.equalsIgnoreCase("Z")) {
			%>
			<tr>
				<td align="center" width="80%"><b>Zonal : <%=Helper.correctNull((String) hshValues
								.get("reportTypeVal"))%></b>
				<br>
				</td>
			</tr>
			<%
				}
			%>
			<%
				
				if (Helper.correctNull((String) hshValues.get("Quarter")).equalsIgnoreCase("Range"))
				{
				
			%>
			<tr>
				<td style="display: none;" align="left" width="80%"><b>Selected
				Year: &nbsp;</b><%=Helper.correctNull((String) hshValues
								.get("hshreportDate"))%></td>
			</tr>
			<%
				} else  {
					
			%>
			<tr>
				<td align="left" width="80%"><b>Selected Year: &nbsp;</b><%=Helper.correctNull((String) hshValues
								.get("hshreportDate"))%></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td align="left" width="80%"><b>From: &nbsp;</b><%=Helper.correctNull((String) hshValues
									.get("hshFromDate"))%></td>
			</tr>
			<tr>
				<td align="left" width="80%"><b>&nbsp;&nbsp;&nbsp;&nbsp;
				To:&nbsp;</b> <%=Helper.correctNull((String) hshValues.get("hshToDate"))%></td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td align="center">

		<div id="top">
		<table align="center" width="90%" cellpadding="3" cellspacing="0"
			border="0">
			<tr>
				<td align="center" width="80%" colspan="41">* No of A/C's in
				actuals & Amount in Rs. Crore</td>
			</tr>

			<tr>
				<td align="center" width="10%">Sector</td>
				<td align="center" width="16%" colspan="8">Micro Enterprises</td>
				<td align="center" width="16%" colspan="8">Small Enterprises</td>
				<td align="center" width="16%" colspan="8">Micro & Small
				Enterprises</td>
				<td align="center" width="16%" colspan="8">Medium Enterprises</td>
				<td align="center" width="16%" colspan="8">Total MSME</td>
			</tr>

			<tr>
				<td align="center" width="10%">Segment</td>
				<td align="center" width="8%" colspan="4">Mfg</td>
				<td align="center" width="8%" colspan="4">Service</td>
				<td align="center" width="8%" colspan="4">Mfg</td>
				<td align="center" width="8%" colspan="4">Service</td>
				<td align="center" width="8%" colspan="4">Mfg</td>
				<td align="center" width="8%" colspan="4">Service</td>
				<td align="center" width="8%" colspan="4">Mfg</td>
				<td align="center" width="8%" colspan="4">Service</td>
				<td align="center" width="8%" colspan="4">Mfg</td>
				<td align="center" width="8%" colspan="4">Service</td>
			</tr>

			<tr>
				<td align="center" width="10%">&nbsp;</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
				<td align="center" width="4%" colspan="2">FB</td>
				<td align="center" width="4%" colspan="2">NFB</td>
			</tr>

			<tr>
				<td align="center" width="10%">&nbsp;</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
				<td align="center" width="2%">ACS</td>
				<td align="center" width="2%">AMT</td>
			</tr>


			<%
			if(arrrow!=null && arrrow.size()>0){
				if (strLable.length == arrrow.size()) {
					for (int i = 0; i < arrrow.size(); i++) {
						arrcol = (ArrayList) arrrow.get(i);
			%>
			<tr>
				<td align="center" width="10%"><%=Helper.correctNull((String) strLable[i])%></td>
				<%
					for (int k = 0; k < arrcol.size(); k++) {
				%>
				<td align="right" width="2%"><%=Helper.correctNull((String) arrcol.get(k))%></td>
				<%
					}
						}
				%>
			</tr>
			<%
				}}
			%>

		</table>
		</div>
		</td>
	</tr>

	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>
	<tr>
		<td align="center">&nbsp;</td>
	</tr>

</table>
<table align="center" border="0" width="100%" class="outertable">
 <tr>
          <td align="center">
          <lapschoice:combuttonnew btnnames="Print Preview" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /></td>          		
        </tr>
</table>

</body>
</html>