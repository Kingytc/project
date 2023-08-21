<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="java.util.*"%>
<%
String date = Helper.getCurrentDateTime();
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
String salesdate="";

int intMonth=Integer.parseInt(date.substring(3,5));
int intYear=Integer.parseInt(date.substring(6,10));
if(intMonth<=4)
	salesdate="01/04/"+(intYear-1);
else
	salesdate="01/04/"+intYear;
%>
<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="75%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
			</tr>
			<tr>
				<td align="center"></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD. <br><%=Helper.correctNull((String) hshValues.get("org_name"))%><br>
				<%=Helper.correctNull((String) hshValues.get("org_add1"))%>, <%=Helper.correctNull((String) hshValues.get("org_add2"))%>,
				<%=Helper.correctNull((String) hshValues.get("org_cityname"))%>, <%=Helper.correctNull((String) hshValues.get("org_statename"))%>,
				<%=Helper.correctNull((String) hshValues.get("org_zip"))%>.<br> Tel No : <%=Helper.correctNull((String) hshValues.get("org_phone"))%> </B></td>
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
				M/s. <%=Helper.correctNull((String) hshValues
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
				<td></td>
			</tr>
			<tr>
				<td>Dear Sir/Madam,</td>
			</tr>
			<tr>
				<td>	
					<table width="100%">
						<tr>
							<td width="50%" valign="top">
								<table width="100%">
									<tr>
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>��ɥ� ��������� ��� ���������� </b></font></td>
									</tr>
									<tr>
										
                      <td><font face="APS-C-DV-Prakash" size="3"><b>����� ��⌾�� 
                        :</b></font><%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">
								          ������ ���� ���� ����� ��ɥ� ��������� <%=Helper.correctNull((String) hshValues.get("LIMIT_REVIEWDATE"))%> ���� ��� �������� / ���������� ���� ��� ��. 
										</font></td>
									</tr>
									<tr>
							 			 <td><font face="APS-C-DV-Prakash" size="3"> ������� �������� �� ��� ���� ����� ��� �����Ê ���� ���� �����䜦� ���㦦���� ����������� ���� �������������� / �������������� ��������� ����� �㶾� ��������� �������� / �Ԧ������ ֽ�� ������ ���Ԧ��� ����, �������� ��ɥ� ��������� ���� �������� / ���������� ��㊾�� ��� ����.
                       					 </font></td>
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
										<td align="right"><font face="APS-C-DV-Prakash" size="3">����� ��ƺ����</font></td>
									</tr>
								</table>
							</td>
							<td width="50%">
								<table width="100%">
									<tr>
										<td align="center"><b>Renewal of Credit limits </b></td>
									</tr>
									<tr>
										<td><b>A/c. No. :</b> &nbsp;<%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
									</tr>
									<tr>
										<td>
								            The credit limits availed by you are due for Review / Renewal in 
             								 the month of <%=Helper.correctNull((String) hshValues.get("LIMIT_REVIEWDATE"))%>. 
										</td>
									</tr>
									<tr>
										<td>
											You are requested to call on us and submit the required Audited / Provisional financial papers and other relevant information / documents urgently to enable us to review / renew the Credit Limits. 
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
