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
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b>¨ãÉ¥ã Ôããè½ãã‚ããò ‡ãŠã ¶ãÌããè‡ãŠÀ¥ã </b></font></td>
									</tr>
									<tr>
										
                      <td><font face="APS-C-DV-Prakash" size="3"><b>Œãã¦ãã ÔãâŒ¾ãã 
                        :</b></font><%=Helper.correctNull((String) hshValues.get("straccno"))%></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">
								          ‚ãã¹ã‡ãñŠ ´ãÀã Êããè Øã¾ããè ¨ãÉ¥ã ÔãìãäÌã£ãã <%=Helper.correctNull((String) hshValues.get("LIMIT_REVIEWDATE"))%> ½ããÖ ½ãò Ôã½ããèàãã / ¶ãÌããè‡ãŠÀ¥ã Öñ¦ãì ªñ¾ã Öõ. 
										</font></td>
									</tr>
									<tr>
							 			 <td><font face="APS-C-DV-Prakash" size="3"> ‚ãã¹ãÔãñ ‚ã¶ãìÀãñ£ã Öõ ãä‡ãŠ ‚ãã¹ã ºãö‡ãŠ ½ãò Ôãâ¹ã‡ãÃŠ ‡ãŠÀò †Ìãâ Ìããâãäœ¦ã ãäÌã¦¦ããè¾ã ãäÌãÌãÀ¥ããò ‡ãŠãè ÊãñŒãã¹ãÀãèãäàã¦ã / ¹ãÆããäÌãû•ã¶ãÊã ¹ãÆãä¦ã¾ããâ ‚ããõÀ ‚ã¶¾ã Ôãâºãâãä£ã¦ã ÔãîÞã¶ãã†â / ªÔ¦ããÌãñ•ã Ö½ãò ¦ãìÀâ¦ã ¹ãÆÔ¦ãì¦ã ‡ãŠÀò, ãä•ãÔãÔãñ ¨ãÉ¥ã Ôããè½ãã‚ããò ‡ãŠãè Ôã½ããèàãã / ¶ãÌããè‡ãŠÀ¥ã ãä‡ãŠ¾ãã •ãã Ôã‡ãñŠ.
                       					 </font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">£ã¶¾ãÌããª ÔããäÖ¦ã</font></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td align="right"><font face="APS-C-DV-Prakash" size="3">¼ãÌãªãè¾ã</font></td>
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
