<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%String date =Helper.getCurrentDateTime();%>
<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
<table width="75%" border="0" cellspacing="0" cellpadding="4"
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
				<td align="center"><B><%=Helper.correctNull((String)hshValues.get("org_name"))%><br>
				<%=Helper.correctNull((String)hshValues.get("org_add1"))%>, <%=Helper.correctNull((String)hshValues.get("org_add2"))%>,
				<%=Helper.correctNull((String)hshValues.get("org_cityname"))%>, <%=Helper.correctNull((String)hshValues.get("org_statename"))%>,
				<%=Helper.correctNull((String)hshValues.get("org_zip"))%>.<br> Tel No : <%=Helper.correctNull((String)hshValues.get("org_phone"))%></B></td>
			</tr>
			<tr>
				<td>
				<hr>
				</td>
			</tr>
			<tr>
				<td ALIGN="RIGHT">DATE:<%=date%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top">TO :<br>
				M/s. <%=Helper.correctNull((String)hshValues.get("personal_custname"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("personal_address"))%> ,<br>
				<%=Helper.correctNull((String)hshValues.get("personal_address1"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("city"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("state"))%>,<br>
				<%=Helper.correctNull((String)hshValues.get("personal_pincode"))%></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>Dear Sir/Madam,</td>
			</tr>
			<tr>
				<td>
					<table width="100%" >
						<tr>
							<td width="50%">
								<table width="100%">
											<tr>
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b> ������</b></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3"><b>����� ��⌾�� :</b> <%=Helper.correctNull((String)hshValues.get("straccno"))%></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">�������� ���� ֽ���� ����� ��� ���� ���� ���� ����� ����������� ������� / ������� ��ɥ� ��������� ��� ���� ����㺣� ������ ����� ��� ��⪼�� ���.</font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">1.����� ����� ������� �. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("INS_COVERAMT"))))%>
											��� ���� ����㺣� ��, ������ ������ ����� ����㶾���� �.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stock_value"))))%>
											 ��� ԛ���� �֦�� ��. �������, ԛ���� ��� ������ ����� ���� ������� ����� �����;�� ��. </font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">2.������ ����������� ��� ԛ���� ���� ����� ��� ԩ��� ���� ���������㊦��� ���������� ���� ��������� �������� ��� ����� ���� ����� ��� ���� ���� �����æ� ��㊾�� ��, ������ ������-������ ��. �������� ԛ���� ���� ����� ��� ����� ���� ������ ����������� ��� �������� ������ �����ӛ ����.</font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">3.������ ����������� ����� ��� ���� ��� ����� ����������� ���� ����� ��.</font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">4.������ ����� �䪶���� ���� ���㹦� ��� ���� �� ����� ����� ���������� ����� ��㊾�� ���� ��. �������� ������ ���� ��� �����ӛ ����.</font>
										</td>
									</tr>
									<tr>									
                     				 	<td><font face="APS-C-DV-Prakash" size="3">�㶾���� ����֦�</font></td>
                   					 </tr>
									 <tr>									
                     				 	<td>&nbsp;</td>
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
                     				 	<td align="right"><font face="APS-C-DV-Prakash" size="3">����� ��ƺ����</font></td>
                   					 </tr>
								</table>
							</td>
							<td width="50%">
								<table width="100%">
									<tr>
										<td align="center"><b> Insurance</b></td>
									</tr>
									<tr>
										<td><b>A/c. No. :</b> <%=Helper.correctNull((String)hshValues.get("straccno"))%></td>
									</tr>
									<tr>
										<td><p>We refer to the insurance cover available for the credit facility
										of working Capital/Term Loan availed by you from our Bank.</p></td>
									</tr>
									<tr>
										<td><p>1.Insurance cover is available only for Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("INS_COVERAMT"))))%>
											as against the normal stock holding of Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stock_value"))))%>
											. Hence Insurance cover for the stock needs to be increased.</p>
										</td>
									</tr>
									<tr>
										<td><p>2.Locations of stock given in the insurance policy and stated in
											the Inspection report submitted by the Inspecting official are not
											matching. Please arrange to get the revised address of the location
											of stock incorporated in the Insurance Policy.</p>
										</td>
									</tr>
									<tr>
										<td><p>3.Insurance Policy is not assigned in favour of the Bank.</p>
										</td>
									</tr>
									<tr>
										<td><p>4.Insurance cover is expired on <%=Helper.correctNull((String)hshValues.get("INS_EXPIRYDATE"))%>
											and not got renewed. Please comply with the above requirements and
											confirm.</p>
										</td>
									</tr>
									<tr>									
                     				 	<td>Thanking you</td>
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
