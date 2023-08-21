<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%String date = Helper.getCurrentDateTime();%>
<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="75%" border="1" cellspacing="0" cellpadding="4"
	align="center">
	<tr>
		<td valign="top">

		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD. </b></td>
			</tr>
			<tr>
				<td align="center"><B><%=Helper.correctNull((String) hshValues.get("org_name"))%><br>
				<%=Helper.correctNull((String) hshValues.get("org_add1"))%>, <%=Helper.correctNull((String) hshValues.get("org_add2"))%>,
				<%=Helper.correctNull((String) hshValues.get("org_cityname"))%>, <%=Helper.correctNull((String) hshValues.get("org_statename"))%>
				- <%=Helper.correctNull((String) hshValues.get("org_zip"))%> <br>Tel No :<%=Helper.correctNull((String) hshValues.get("org_phone"))%> </B></td>
			</tr>

			<tr>
				<td>
				<hr>
				</td>
			</tr>
			<tr>
				
          <td ALIGN="RIGHT" height="27">DATE:<%=date%></td>
			</tr>
			<tr>
				<td align="center"><U><b>&nbsp;</b></U></td>
			</tr>
			<tr>
				<td valign="top">To,</td>
			</tr>
			<tr>
				<td><%=Helper.correctNull((String) hshValues
							.get("personal_custname"))%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("personal_address"))%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("personal_address1"))%>,<br>
				<%=Helper.correctNull((String) hshValues.get("city"))%>,<br>
				<%=Helper.correctNull((String) hshValues.get("state"))%>,<br>
				<%=Helper.correctNull((String) hshValues
							.get("personal_pincode"))%></td>
			</tr>
			<tr>
				<td>Dear Sir/Madam,</td>
			</tr>
			<tr>
				<td>
					<table width="100%">
						<tr>
							<td width="50%">
								<table width="100%">
												<tr>
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>����������� �Ԧ�������� ��� ����������</b></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3"><b>����� ��⌾�� : </b> <%=Helper.correctNull((String) hshValues
												.get("strcbsaccno"))%></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">
											������� ���㹦� ������� ��� ������ ����� ������ ̾�㋦� ������ �� ֽ� ������� �������� ������ ���֦�� �� ��� ������ ���� ���ӹ���䪦� ����������� �Ԧ�������� ���� ���� ������ ���㹦� ��� ������ �� ����� ����� ���������� ��㊾�� ����� ��. </font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">
											ֽ� ������� �������� ������ �� ���� ���� ��� Թ���� ��� ���� ������� ���� ����������� ���� ������ ��������������� ����� ��� ����� ����������� �Ԧ�������� ��� ���������� ���� �����㊾�� ������ ��� ���. </font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">�㶾���� ����֦�</font></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="right"><font face="APS-C-DV-Prakash" size="3">�������</font></td>
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
										<td align="center"><b>Renewal of Security Documents</b></td>
									</tr>
									<tr>
										<td><b>A/c. No. : </b> <%=Helper.correctNull((String) hshValues
												.get("strcbsaccno"))%></td>
									</tr>
									<tr>
										<td>
											<p>While thanking you for your patronage, we bring to your notice
											that the security documents executed by you have fallen due for
											renewal.</p>
										</td>
									</tr>
									<tr>
										<td>
											<p>May we, therefore, request you to make it convenient to call on
											us on any working day within a weeks time for expediting the process
											of renewal of security documents.</p>
										</td>
									</tr>
									<tr>
										<td>Thanking you,</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>Yours faithfully</td>
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
<input type="hidden" name="cbsid">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="cbsname" value="">
<input type="hidden" name="ltrcode" value="">
</body>
</html>
