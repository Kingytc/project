<%@ page import="com.sai.laps.helper.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%
	String date = Helper.getCurrentDateTime();
%>


<html>
<head>
<title>KARNATAKA BANK LTD.</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
</head>
<body>
<table width="75%" border="0" cellspacing="0" cellpadding="2"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				<td align="center"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
			</tr>
			<tr>
				<td align="center"><b>KARNATAKA BANK LTD.<br>
				<%=Helper.correctNull((String) hshValues.get("org_name"))%><br>
				<%=Helper.correctNull((String) hshValues.get("org_add1"))%>,<br>
				<%=Helper.correctNull((String) hshValues.get("org_add2"))%>, <%=Helper.correctNull((String) hshValues
									.get("org_cityname"))%>,
				<%=Helper.correctNull((String) hshValues
							.get("org_statename"))%>, <%=Helper.correctNull((String) hshValues.get("org_zip"))%>.<br>
				Tel No : <%=Helper.correctNull((String) hshValues.get("org_phone"))%>
				</b></td>
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
				<td></td>
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
				<td></td>
			</tr>
			<tr>
				<td>Dear Sir/Madam,</td>
			</tr>
			<tr>
				<td>
				<table width="100%" border="0">
					<tr>
						<td width="50%">
						<table width="100%" border="0">
							<tr valign="top">
								<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>&#130;&atilde;&atilde;&auml;&brvbar;&atilde;&ordf;&ntilde;&frac34;&atilde;
								&atilde;&auml;&ordm;&atilde;&Ecirc;&atilde;</b></font></td>
							</tr>
							<tr valign="top">
								<td><font size="3" face="APS-C-DV-Prakash"><b>&#140;&atilde;&atilde;&brvbar;&atilde;&atilde;
								&Ocirc;&atilde;&acirc;&#140;&frac34;&atilde;&atilde;</b> <%=Helper.correctNull((String) hshValues.get("straccno"))%></font></td>
							</tr>
							<tr valign="top">
								<td align="justify"><font face="APS-C-DV-Prakash" size="3">Ö½ãò
								‚ã¹ã¶ãñ ãäÀ‡ãŠã¡ãô ‡ãŠãñ ªñŒã¶ãñ Ôãñ —ãã¦ã Öì‚ãã ãä‡ãŠ Á.<b>
								</b><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) hshValues
													.get("billamt"))))%>
								‡ãŠãè †‡ãŠ ãäºãÊã ‰ãŠ. <b><%=Helper.correctNull((String) hshValues
									.get("billno"))%></b>
								ãäª¶ããâ‡ãŠ <b><%=Helper.correctNull((String) hshValues.get("billdate"))%></b>-
								Ôãñ ‚ããä¦ãªñ¾ã Öõ. ¾ããäª ‚ãã¹ã ¦ãìÀâ¦ã ƒÔã ãäºãÊã ‡ãŠãñ œìü¡ã
								ÊãòØãñ, ¦ããñ Ö½ã ‚ãã¹ã‡ãñŠ ‚ã¦¾ãâ¦ã ‚ãã¼ããÀãè ÖãòØãñ. </font></td>
							</tr>
							<tr valign="top">
								<td><font face="APS-C-DV-Prakash" size="3">&pound;&atilde;&frac34;&atilde;&Igrave;&atilde;&atilde;&ordf;
								&Ocirc;&atilde;&atilde;&auml;&Ouml;&brvbar;&atilde;</font></td>
							</tr>
							<tr valign="top">
								<td align="right">&nbsp;</td>
							</tr>
							<tr valign="top">
								<td align="right"><font size="3" face="APS-C-DV-Prakash"><b>&frac14;&atilde;&Igrave;&atilde;&ordf;&atilde;&egrave;&frac34;&atilde;</b></font></td>
							</tr>
							<tr valign="top">
								<td align="right"><font size="3" face="APS-C-DV-Prakash"><b>&Iacute;&atilde;&atilde;&#140;&atilde;&atilde;
								&sup1;&atilde;&AElig;&ordm;&atilde;&acirc;&pound;&atilde;&#135;&atilde;&#138;</b></font></td>
							</tr>
						</table>
						</td>
						<td width="50%">
						<table width="100%" border="0">
							<tr valign="top">
								<td align="center">Bill overdue</td>
							</tr>
							<tr>
								<td>A/c. No. <%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
							</tr>
							<tr valign="top">
								<td align="justify">We observe from our record that a bill
								no. <b><%=Helper.correctNull((String) hshValues
									.get("billno"))%></b>
								for Rs. <b><%=Helper.formatDoubleValue(Double
									.parseDouble(Helper
											.correctDouble((String) hshValues
													.get("billamt"))))%></b>
								is overdue since <b><%=Helper.correctNull((String) hshValues.get("billdate"))%></b>.
								We will be thankful to you if you will realize the above
								mentioned bill immediately.</td>
							</tr>
							<tr valign="top">
								<td>Thanking You</td>
							</tr>
							<tr valign="top">
								<td>&nbsp;</td>
							</tr>
							<tr valign="top">
								<td>Yours faithfully</td>
							</tr>
							<tr valign="top">
								<td>Branch Manager</td>
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
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3">
			<tr>
				
          <td height="29"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="3">
					<tr align="center">
						<td WIDTH="49%"><b> </b></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td><b>Note</b> : If overdue amount is already paid please
				ignore this letter.</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</body>
</html>