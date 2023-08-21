<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
String date =Helper.getCurrentDateTime();

String stockData = Helper.correctNull((String)request.getParameter("date"));
String alterFor = Helper.correctNull((String)request.getParameter("alertsfor"));
if(alterFor.equalsIgnoreCase("107"))
{
	alterFor="stock statements";
}
else
{
	alterFor="Bookdebt statements";
}
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
<table width="75%" border="0" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="right">&nbsp;</td>
			</tr>
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"
					></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD. </b></td>
			</tr>
			<tr>
				<td align="center"><B><%=Helper.correctNull((String) hshValues.get("org_name"))%><br>
				<%=Helper.correctNull((String) hshValues.get("org_add1"))%>, <%=Helper.correctNull((String) hshValues.get("org_add2"))%>,
				<%=Helper.correctNull((String) hshValues.get("org_cityname"))%>, <%=Helper.correctNull((String) hshValues.get("org_statename"))%>,
				<%=Helper.correctNull((String) hshValues.get("org_zip"))%> . Tel No : <%=Helper.correctNull((String) hshValues.get("org_phone"))%> </B></td>
			</tr>
			
			<tr>
				<td align="center"><hr></td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=date%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">TO,<br>
M/s.<%=Helper.correctNull((String)hshValues.get("personal_custname"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_address"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_address1"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("city"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("state"))%>,<br>
<%=Helper.correctNull((String)hshValues.get("personal_pincode"))%></td>
			</tr>
			<tr>
				<td></td>
			</tr>
			<tr>
				<td>&nbsp;Dear sir,</td>
			</tr>
			<tr>
				<td>
					<table width="100%">
						<tr>
							<td width="50%">
								<table width="100%">
									<tr>
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>��������� ����������� ��� ���Ԧ��������� �� ��㊾�� �����</b></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3"><b>����� ��⌾�� :</b> </font>&nbsp;<%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">
											��� ����� ���� �� ��� ���� ����� ���� ԛ���� ��������� ��� ��������  ���Ԧ��������� ��� ������ �������� ��, ���� ����� ���� ��ɥ� ����������� ��� ������� ��� �������� ��. ֽ�� ������
												<%=stockData%> 
												���� / �������� ��� ԛ���� ��������� ����� ���㹦� ���� ��, ������� ������ ֽ� ������ ������� �������� ���� ������ ���� ����� ����� ��� ��� ��� ��. 
												</font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">
											�������� ���� ���� ��� ��㋦� ��������� ��� ����� ��� ���Ԧ��������� ��� ���䥡�� ����� ��������� ��� ��������� ��. ���: ������� �������� �� ��� ����� ��� ������ ��� ���Ԧ��������� ��㊾�� ����� ������������ ����. 
											</font>
										</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">�㶾���� ����֦�</font></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="right"> <font face="APS-C-DV-Prakash" size="3">�������</font></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="right"><font face="APS-C-DV-Prakash" size="3">����� ��ƺ����</font></td>
									</tr>
								</table>
							</td>
							<td width="50%">
								<table width="100%">
									<tr>
										<td align="center"><b>Non submission of periodical statements</b></td>
									</tr>
									<tr>
										<td><b>A/c. No. :</b> &nbsp;<%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
									</tr>
									<tr>
										<td>
											It is observed that you are irregular in submission of stock statements
												to the bank which is in violation of sanction stipulations. 
												The stock statements for the month / quarter of 
												<%=stockData%> 
												is not yet received by us, due to which we are not in a position to arrive at the 
												availability of drawing power.
										</td>
									</tr>
									<tr>
										<td>
											Please note that delay in submission of above statements attract penal interest. 
											herefore you are requested to ensure submission of the same on the due dates.
										</td>
									</tr>
									<tr>
										<td>Thanking you,</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>Your faithfully</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>BRANCH MANAGER</td>
									</tr>
								</table>
							</td>
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
