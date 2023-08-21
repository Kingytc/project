<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
String date =Helper.getCurrentDateTime();
%>


<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>


<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0">
<table width="75%" border="1" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="right">&nbsp;</td>
			</tr>
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD. </b></td>
			</tr>
			<tr>
				<td align="center"><B><%=Helper.correctNull((String)hshValues.get("org_name"))%><br>
				<%=Helper.correctNull((String)hshValues.get("org_add1"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("org_add2"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("org_cityname"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("org_statename"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("org_zip"))%><br>
				Tel No : <%=Helper.correctNull((String)hshValues.get("org_phone"))%>.<br>
				</B></td>
			</tr>
			<tr>
				<td align="center">&nbsp;</td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=date%></td>
			</tr>
			<tr>
				<td align="center"><U><b>&nbsp;</b></U></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td valign="top">TO :<br>
M/s. <%=Helper.correctNull((String)hshValues.get("personal_custname"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_address"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_address1"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("city"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("state"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_pincode"))%>


</td>
			</tr>
			
			<tr>
				<td></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td>&nbsp;Dear sir,</td>
			</tr>
			<tr>
				<td align="center"><U><b>&nbsp;Bill Payment Due date </b></U></td>
			</tr>
			<tr>
				<td align="center"><b>A/c. No. :</b> &nbsp;<%=Helper.correctNull((String)hshValues.get("straccno"))%></td>
			</tr>
			<tr>
				<td>This is to remind you that the bills drawn on you under the Letter of Credit opened on 
				<%=Helper.correctNull((String)hshValues.get("LC_LCOPENDATE"))%> are falling due for payment on
				 <%=Helper.correctNull((String)hshValues.get("LC_BILLS_NOTIONAL_DATE"))%>. 
				 We, therefore, request you to make the necessary arrangements for payment of the same on or 
				 before the due date.  </td>
			</tr>
			<tr>
				<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thanking you,  </td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					
					
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><u></u></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td WIDTH="49%">&nbsp;</td>
								<td WIDTH="51%" align="center">Yours faithfully,</td>
							</tr>
							<tr align="center">
								<td WIDTH="49%"><b> </b></td>
								<td WIDTH="51%"><b>BRANCH MANAGER</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td><b>Note</b> : If due amount is already paid , please ignore this 
                  letter</td>
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
