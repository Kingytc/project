<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
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
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0">
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
				<%=Helper.correctNull((String) hshValues.get("org_cityname"))%>, <%=Helper.correctNull((String) hshValues.get("org_statename"))%> - 
				<%=Helper.correctNull((String) hshValues.get("org_zip"))%>. <br>Tel No : <%=Helper.correctNull((String) hshValues.get("org_phone"))%> </B></td>
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
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>������� : ������� ���������� ��ɥ� ������������ ��� ����������</b></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">������� ���������� ��㽶��������� ��ɥ� ������������ ���
											<b><%=Helper.correctNull((String)hshValues.get("revdate"))%></b> ���� ��� ���������� ��㊾�� ����� ��.  </font></td>
									</tr>
									<tr>
										<td align="center">
										<div id="top">
											<table width="60%">
											<%
												arrRow=(ArrayList)hshValues.get("arrRow");
												if(arrRow!=null && arrRow.size()>0)
												{
											%>
											<tr>
												<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>��.���.</b></font></td>
												<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>��ɥ� ������ ��� ������</b></font></td>
												<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>�. ���� ���</b></font></td>
											</tr>  
											<%for(int i=0;i<arrRow.size();i++)
											{
												arrCol=(ArrayList)arrRow.get(i);
											%>
											<tr>
												<td><%=(i+1)%></td>
												<td><%=arrCol.get(0)%></td>
												<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.converToLakhs(Helper.correctDouble((String)arrCol.get(1)))))%>
												</td>
											</tr>
										<%
											}
										}
										%>
									</table>
									</div>
									</td>
									</tr>
									<tr>
				      <td><font face="APS-C-DV-Prakash" size="3"> 
                         ֽ� ������� �������� ������ �� ��� ��㋦� ��ɥ� 
                          ������������ ��� ������������� ��� ���� ��㽶��������� 
                          �Ԧ������ �䪶���� --------- ���� ��� ������ ������ 
                          ֽ�� ���Ԧ��� ��� ��.
                        <ol>
                          <li> ������ ����� ��� �������������� ������ ��� 
                            ���� ����� ���� ���� ���������ӛ. </li>
                          <li> ������ ����� ��� �������������� ���� ����� 
                            ����� ���� ����� ���� ���� ���������ӛ. </li>
                          <li> ������ ����� ���� ������ ������� ���� ��������� 
                            (�㊽��/���., �������/���������, �������ホ�) 
                          </li>
                          <li> ���� / ������ ��⊹������� ��� ������ 
                            ����� ��� �������� ���� ���� ����� �����. </li>
                          <li> ���膽� ���. </li>
                          <li> �㶾� ����־��� / ����������� ���� ��ԩ���� 
                            / �������� ��� ����� (�����æ���� ��� ��������� 
                            ��ɥ� / ��㊡��������). </li>
                          <li> ������ ����� ��� ���� ��� / ������ ��� 
                            ��������� ��ƽ�����. </li>
                          <li> ��⊹���� / �㊽�� ��� ���� ��� ���� ��������� 
                            / ����������� ���� ���������� ����� ��� ���� 
                            �������. </li>
                          <li> .������������ ������ ��ƽ����� ( ���� 
                            ��������� ��� ��������� ����������� / ���ԩ����� 
                            ��� ���� ��ɥ� ��� ���� ��, ���� ��������� ���ԩ�� 
                            ��� ����� ������� ������ �� ����� ��� ��ƽ����� 
                            ���Ԧ��� ������ ������. ) </li>
                          <li> ��ƽ��� ����� ��� �����䜦� ��ɥ� ������ ��������� 
                            ���� (�������� ��Ɇ� ������ ���). </li>
                          <li> ���������� ����� ��� �������� ������ �����������. 
                          </li>
                          <li> &THORN;&atilde;&atilde;&Ecirc;&atilde;&icirc; &Igrave;&atilde;&Oacute;&atilde;&Atilde; 
                            <%=salesdate%>  ��� ������ ��� ��� ��� ���� �����-������ ��� ���������. </li>
                          <li> ���� ����� ��� ������ ԩ����� �����䦦���� ��� ����� �㊽��� / ���������� ��� ���, ���� ������ �������.</li>
                        </ol>
                         ��������ӛ �������� / ���� ���� ��㽶��������� ���������㋦� ������������� ���Ԧ��� ���� ����: 
                        
                        <ol>
                          <li> ���� ���� ������ �������������� ���� ������� (������-����� ���� ���������� ������ ������ ̾���������) </li>
                          <li>���������� ��㊪�� �����;�㊦�� / ��� ( ������-�����, ��������� ̾�������, ���Û��, ���ʽ� ���� ������� ������� ��� ��������� ��ɥ� ���Ԧ������ ���) 
                          </li>
                          <li> ���������. ��� �������� ( �����膹����� ��� ������� ���).</li>
                          <li> ����� ��� ������ �������� ������ �������� ���������� (�����膹����� ��� ������� ���). </li>
                        </ol>
                        �������� ���� ���� ��� ���� �����æ� ���������� / ��������� ��� ������� ����������� ������ ��� ������� ��㊆ ����� ��� ���� ���� ������� ���� ��� ���� ����� ��ɥ� ��������� ��� 1% ���� �� ��� ���䥡�� ����� ��� �������� ����� ���� ������ ������, ���� ��� ������ ������� ��� ������� �.______________________________ ������ ���� ����� ��.
                        </font></td>
									</tr>
									<tr><td>&nbsp;</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">���֦�� ��������� ��� ���������� ����֦�. </font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">�㶾���� ����֦�</font></td>
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
										<td align="center"><b>Subject: Renewal of credit limits placed at your disposal</b></td>
									</tr>
									<tr>
										<td><p>The following credit limits placed at your disposal are falling due for renewal in 
											<b><%=Helper.correctNull((String)hshValues.get("revdate"))%></b></p></td>
									</tr>
									<tr>
										<td align="center">
										<div id="top">
											<table width="60%">
											<%
												arrRow=(ArrayList)hshValues.get("arrRow");
												if(arrRow!=null && arrRow.size()>0)
												{
											%>
											<tr>
												<td align="center"><b>S.No</b></td>
												<td align="center"><b>Nature of Limit</b></td>
												<td align="center"><b>Amount Rs. in Lacs</b></td>
											</tr>  
											<%for(int i=0;i<arrRow.size();i++)
											{
												arrCol=(ArrayList)arrRow.get(i);
											%>
											<tr>
												<td><%=(i+1)%></td>
												<td><%=arrCol.get(0)%></td>
												<td align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.converToLakhs(Helper.correctDouble((String)arrCol.get(1)))))%>
												</td>
											</tr>
										<%
											}
										}
										%>
									</table>
									</div>
									</td>
									</tr>
									<tr>
				      <td> 
                        <p> We request you to submit the following documents for 
                          renewal of the above credit facilities immediately. 
                        </p>
					<ol>
						<li>
							Last years' audited Balance Sheet with notes on account &amp; annexure
						</li>	
						<li>
							Last years' audited Profit &amp; Loss statement with notes on accounts &amp annexure
						</li>
						<li>
							Last years' IT returns copy (For firm/company, Directors/Partners, Proprietor)
						</li>
						<li>
							Last years Balance Sheet and Profit &amp; Loss statement of associate / sister concerns
						</li>
						<li>
							CMA data
						</li>
						<li>
							Order book position / contracts / proof of demand (for exporters PC/ FDBP)
						</li>
						<li>
							Last Income tax/sales tax assessment order
						</li>
						<li>
							Credit information forms duly filled in for company/ firm as well as for directors/ partners
						</li>
						<li>
							Statutory clearance certificate (No Overdue certificate from Govt. Agencies Bodies wherever applicable)
						</li>
						<li>
							Lead Bank assessment note (in case of consortium)
						</li>
						<li>
							Insurance policy, as per sanction terms
						</li>
						<li>
							Sales /Purchase during the current year from <%=salesdate%> to till date
						</li>
						<li>
							Addition/Deletion in fixed assets during the year, if any
						</li>
					</ol>
										<p>
										Additional information required for specific sectors:
										</p>
											<ol>
											<li>
												List of projects executed &amp; under process (in case of real estate)
											</li>
											<li>
												Cash budget projection (in case of real estate, contractors, IT, film &amp; sugar industry proposal)
											</li>
											<li>
												RBI registration (in case of NBFC)
											</li>
											<li>
												Declaration on attracting public funds (in case of NBFC)
											</li>
											</ol>
											<p>
											Please note that delayed submission of data as mentioned above beyond the stipulated date will attract penal interest of 1% on all limits enjoyed by you which in your case will work out to  approximately Rs.______________________________Per month.
											</p>
										</td>
									</tr>
									<tr>
										<td><p>Assuring you of our best services.</p></td>
									</tr>
									<tr>
										<td>Thanking you,</td>
									</tr>
									<tr>
										<td align="left">Yours faithfully,</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										
                      <td align="left">BRANCH MANAGER&nbsp;</td>
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
