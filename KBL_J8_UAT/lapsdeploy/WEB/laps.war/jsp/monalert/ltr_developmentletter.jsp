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
									<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>&nbsp;ÔããŒã ¹ã¨ã ‡ãŠã ãä¡ÌããÊÌã½ãò›</b></font></td>
								</tr>
								<tr>
									<td align="left"><font face="APS-C-DV-Prakash" size="3"><b>Œãã¦ãã ÔãâŒ¾ãã :&nbsp;<%=Helper.correctNull((String)hshValues.get("strcbsaccno"))%></b></font> </td>
								</tr>
								<tr>
									<td><font face="APS-C-DV-Prakash" size="3">‚ãã¹ã‡ãŠãè ‚ããñÀ Ôãñ Ö½ããÀñ ´ãÀã •ããÀãè ãä‡ãŠ¾ãñ Øã¾ãñ <b>Á.<%=Helper.correctNull((String)hshValues.get("FUND_OSAMT"))%></b>. 
										(½ãîÊã + º¾ãã•ã) ‡ãñŠ ÔããŒã¹ã¨ã ‚ãºã ¦ã‡ãŠ ãä¡ÌããÊÌã Öãñ Þãì‡ãñŠ Öö ‚ããñÀ „¶ã‡ãŠã ¼ãìØã¦ãã¶ã ãä‡ãŠ¾ãã •ãã Þãì‡ãŠã Öõ. ‚ãã¹ãÔãñ ‚ã¶ãìÀãñ£ã Öõ ãä‡ãŠ ‚ãã¹ã „‡ã‹¦ã ãä¡ÌããÊÌã ÀããäÍã ‚ããõÀ „Ôã ¹ãÀ ªñ¾ã º¾ãã•ã †Ìãâ ºãö‡ãŠ ¹ãÆ¼ããÀ ÔããäÖ¦ã Ôã½ãÔ¦ã ÀããäÍã ¦ãìÀâ¦ã •ã½ãã ‡ãŠÀ ªò.   </font> </td>
								</tr>
								<tr>
									<td>&nbsp;
										
									</td>
								</tr>
								<tr>
									<td><font face="APS-C-DV-Prakash" size="3">£ã¶¾ãÌããª ÔããäÖ¦ã </font ></td>
								</tr>
								<tr>
									<td>&nbsp;</td>
								</tr>
								<tr>
									<td align="right"><font face="APS-C-DV-Prakash" size="3">¼ãÌãªãè¾ã </font> </td>
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
									<td align="right"><font face="APS-C-DV-Prakash" size="3">ÍããŒãã ¹ãÆºãâ£ã‡ãŠ</font></td>
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
