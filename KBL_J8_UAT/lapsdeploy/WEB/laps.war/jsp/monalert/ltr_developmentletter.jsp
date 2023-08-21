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
				<td align="center"><B><%=Helper.correctNull((String)hshValues.get("org_name"))%></B><br>
				<%=Helper.correctNull((String)hshValues.get("org_add1"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("org_add2"))%>,
				<%=Helper.correctNull((String)hshValues.get("org_cityname"))%>,
				<%=Helper.correctNull((String)hshValues.get("org_statename"))%>,
				 <%=Helper.correctNull((String)hshValues.get("org_zip"))%>. <br>
			Tel No:	 <%=Helper.correctNull((String)hshValues.get("org_phone"))%>. 
				</td>
			</tr>
			<tr>
				<td align="center">&nbsp;</td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=date%></td>
			</tr>
			<tr>
				<td align="center"></td>
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
<%=Helper.correctNull((String)hshValues.get("personal_address"))%> ,<br>
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
									<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>&nbsp;���� ��� ��� ����������</b></font></td>
								</tr>
								<tr>
									<td align="left"><font face="APS-C-DV-Prakash" size="3"><b>����� ��⌾�� :&nbsp;<%=Helper.correctNull((String)hshValues.get("strcbsaccno"))%></b></font> </td>
								</tr>
								<tr>
									<td><font face="APS-C-DV-Prakash" size="3">������� ����� ��� ֽ���� ���� ������ ��㊾�� ���� <b>�.<%=Helper.correctNull((String)hshValues.get("FUND_OSAMT"))%></b>. 
										(����� + �����) ��� ������ ��� ��� �������� ��� ����� �� ����� ����� �������� ��㊾�� ��� ����� ��. ������� �������� �� ��� ���� ��㋦� �������� ������ ����� ��� ��� ��� ����� ���� ����� ��Ƽ��� ����֦� ���Ԧ� ������ ������ ���� ��� ��.   </font> </td>
								</tr>
								<tr>
									<td>&nbsp;
										
									</td>
								</tr>
								<tr>
									<td><font face="APS-C-DV-Prakash" size="3">�㶾���� ����֦� </font ></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td align="right"><font face="APS-C-DV-Prakash" size="3">������� </font> </td>
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
									<td align="center"><b>&nbsp;Devolvement of Letter of Credit  </b></td>
								</tr>
								<tr>
									<td align="left"><b>A/c. No. :&nbsp;<%=Helper.correctNull((String)hshValues.get("strcbsaccno"))%></b> </td>
								</tr>
								<tr>
									<td>The Letter of Credit/Credits opened on your behalf has been devolved amounting 
										to (Principal + Int.)* <b>Rs.<%=Helper.correctNull((String)hshValues.get("FUND_OSAMT"))%></b>. 
										You are requested to make arrangement for immediate payment of the devolved amount along with future 
										interest &amp; charges to the Bank. </td>
								</tr>
								<tr>
									<td>Thanking you,  </td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td>Yours faithfully  </td>
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

					<tr>
          <td align="left"><b>Note</b> : If overdue amount is already paid ,please ignore this letter</td>
        </tr>
				</table>
				</td>
			</tr>
		</table>

</body>
</html>
