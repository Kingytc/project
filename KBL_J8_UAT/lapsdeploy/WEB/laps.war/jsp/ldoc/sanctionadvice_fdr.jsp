<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arrTermsId");

			ArrayList arrydocCol = null;
			ArrayList arrydocRow = (ArrayList) hshValues.get("arrDocsId");
			ArrayList vecCoApp_col = null;
			ArrayList vecCoApp_Row = (ArrayList) hshValues.get("vecCoApplicant");
%>
<html>
<head>
<title>Sanction Letter for Loan Against Deposit scheme</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
	<tr>
		<td align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
	</tr>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td colspan="2" align="center"><b> KARNATAKA BANK LTD.</b></td>

			</tr>
			<tr>
				<td colspan="2" align="center"><b><%=Helper.correctNull((String) hshValues.get("orgname"))%>
				&nbsp; Branch</b></td>
			</tr>
			 <tr> 
		<td align="center" colspan="3"><strong ><b> <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
				<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; <%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp; 
				<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp; <%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp; 
				. <br>Tel No : <%=Helper.correctNull((String)hshValues.get("orgphone"))%></b></strong>
		     <hr/>
		</td>
	   </tr>
			<tr>
				<td width="64%">Ref.No.&nbsp;:<b>&nbsp;<%=Helper.correctNull((String) hshValues.get("appno"))%></b></td>
				<td width="36%"><font size="2" face="MS Sans Serif">Date: &nbsp;<b><%=Helper.correctNull((String) hshValues
							.get("app_processdate"))%></b></font></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="0" cellpadding="5">
			<tr>
				<td align="center"><b><u>LETTER OF SANCTION</u></b></td>
			</tr>
			<tr>
				<td>To:<br>
				&nbsp; <b><%=Helper.correctNull((String) hshValues.get("Title"))%></b>
				&nbsp; <b><%=Helper.correctNull((String) hshValues.get("appname"))%></b><br>
				<%if (vecCoApp_Row != null) {
				for (int i = 0; i < vecCoApp_Row.size(); i++) {
					vecCoApp_col = (ArrayList) vecCoApp_Row.get(i);
					if (vecCoApp_col != null) {
						String title = Helper.correctNull((String) vecCoApp_col
								.get(0));
						String CoApplicantName = Helper
								.correctNull((String) vecCoApp_col.get(1));

						%> &nbsp; <b><%=title%>.&nbsp;<%=CoApplicantName%></b><br>
				<%}
				}
			}%> &nbsp; <b><%=Helper.correctNull((String) hshValues
							.get("perapp_address1"))%></b><br>
				&nbsp; <b><%=Helper.correctNull((String) hshValues
							.get("perapp_address2"))%></b><br>
				&nbsp; <b><%=Helper.correctNull((String) hshValues
									.get("perapp_city"))%> -<b><%=Helper.correctNull((String) hshValues.get("perapp_zip"))%></b></b><br>
				&nbsp; <b><%=Helper.correctNull((String) hshValues
									.get("perapp_state"))%></b><br>

				</td>
			</tr>
			<tr>
				<td>Dear Sir / Madam,</td>
			</tr>
			<tr>
				<td align="center"><b>SUB: SOD LIMIT / SECURED LOAN</b><br>
				<u>Conveying of sanction Terms and conditions</u><br>
				<br>
				</td>
			</tr>
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="4%">&nbsp;</td>
						<td width="96%">
						<p>With reference to your loan application dated &nbsp;<b><%=Helper.correctNull((String) hshValues
							.get("loan_receivedate"))%></b> . we are pleased to inform you
						that a SOD limit / Secured loan of Rs.&nbsp;<b><%=Helper.formatDoubleValue(Double
							.parseDouble(Helper
									.correctDouble((String) hshValues
											.get("sancamount"))))%></b> (Rupees &nbsp;<b><%=Helper.figtoWords(Helper.correctDouble((String) hshValues
							.get("sancamount")))%></b>) is sanctioned to you against Deposit
						receipt/s / NSC on the following terms and conditions:</p>
						</td>
					</tr>
					<tr>
						<td width="4%" valign="top">
						<li>&nbsp;</li>
						</td>
						<td width="96%">
						<p>Deposit receipt/s NSC / cumulative deposit pass book against
						which the loan is proposed,to be obtained duly discharged by the
						party and lien to be marked in Bank favour.</p>
						</td>
					</tr>

					<tr>
						<td width="4%" valign="top">
						<li>&nbsp;</li>
						</td>
						<td width="96%">
						<p>SOD limit / Secured loan is sanctioned for a period of one year
						or due date of Deposit Receipt / NSC / Cumulative A/c which ever
						is earlier.</p>
						</td>
					</tr>
					<tr>
						<td width="4%" vallign="top">&nbsp;</td>
						<td width="96%">No excess will be allowed.
						<p></p>
						</td>
					</tr>
					<tr>
						<td width="4%" vallign="top">
						<li></li>
						</td>
						<td width="96%">
						<p valign="justify">The following security documents are to be
						executed at the time of disbursement of loan:</p>
						</td>
					</tr>
					<tr>
						<td width="4%">&nbsp;</td>
						<td><%if (arrydocRow != null) {
				for (int i = 0; i < arrydocRow.size(); i++) {
					arrydocCol = (ArrayList) arrydocRow.get(i);
					if (arrydocCol != null) {

						%> <br>
						<b><%=i + 1%>)&nbsp;<%=Helper
												.correctNull((String) arrydocCol
														.get(1))%></b> <%}
				}
			}

			%></td>
					</tr>

					<tr>
						<td width="4%" valign="top">
						<li>&nbsp;</li>
						</td>
						<td width="96%">
						<p align="justify">As the deposite receipt / cumulative a/c is in
						the name of minor an undertaking to be obtained from the guardian
						stating that the loan / overdraft will be utilised for benefit of
						minor.</p>

						</td>
					</tr>

				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">

					<tr>
						<td width="4%" valign="top">
						<li>&nbsp;</li>
						</td>
						<td width="96%">All other term and conditions are applicable to
						the loan / SOD against deposit from time to time</td>
					</tr>


					<tr>
						<td width="4%" valign="top">
						<td><%if (arryRow != null) {
				for (int i = 0; i < arryRow.size(); i++) {
					arryCol = (ArrayList) arryRow.get(i);
					if (arryCol != null) {

						%> <br>
						<b><%=i + 1%>)&nbsp;<%=Helper.correctNull((String) arryCol.get(1))%></b>
						<%}
				}
			}

			%></td>

					</tr>


					<tr>
						<td width="4%">&nbsp;</td>
						<td width="96%">&nbsp;</td>
					</tr>
					<tr>
						<td width="4%">&nbsp;</td>
						<td width="96%">&nbsp;</td>
					</tr>
					<tr>
						<td width="4%">&nbsp;</td>
						<td width="96%">&nbsp;</td>
					</tr>
					<tr>
						<td width="4%">&nbsp;</td>
						<td width="96%">&nbsp;</td>
					</tr>
					<tr>
						<td width="4%">&nbsp;</td>
						<td width="96%">&nbsp;</td>
					</tr>
					<tr>
						<td width="4%" valign="top"></td>
						<td width="96%"><p>We now request you to convey your acceptance (or)
						otherwise of the above terms and conditions and call on us any
						working day to enable us to disburse the loan after proper
						documentation.</p></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>
				<p align="center">
				<table width="98%" border="0" cellspacing="0" cellpadding="5">
					<tr>
						<td width="4%">&nbsp;</td>
						<td width="91%">
						<p align="justify">&nbsp;</p>
						<table width="98%" border="0" cellspacing="0" cellpadding="5"
							height="140">
							<tr>
								<td width="59%" height="135">&nbsp;</td>
								<td width="41%" height="135">
								<p>For Karnataka Bank Ltd.</p>
								<p><br>
								<br>
								<b>CHIEF / BRANCH MANAGER</b></p>
								<p></p>
								<p>&nbsp;</p>
								<p>&nbsp;</p>
								</td>
							</tr>
						</table>
						<table width="98%" border="1" cellspacing="0" cellpadding="5"
							height="197">
							<tr>
								<td height="203">
								<p>Accepted the above Terms and Condition</p>
								<table width="98%" border="0" cellspacing="0" cellpadding="5">
									<tr>
										<td width="59%">
										<p>&nbsp;</p>
										<p><b>Signature of the Applicant/s</b></p>
										<p>&nbsp;</p>
										</td>
										<td width="41%">
										<p>&nbsp;</p>
										<p><b>&nbsp;</b></p>
										<p>&nbsp;</p>
										</td>
									</tr>
									<tr>
										<td width="59%">

										<p>&nbsp;</p>
										<p>&nbsp;</p>
										</td>
										<td width="41%">

										<p>&nbsp;</p>
										<p>&nbsp;</p>
										</td>
									</tr>
								</table>
								<table width="98%" border="0" cellspacing="0" cellpadding="5">
									<tr>
										<td width="59%">Date:</td>
										<td width="41%">&nbsp;</td>
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
		</td>
</table>

<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidAction" value="">

</body>
</html>
