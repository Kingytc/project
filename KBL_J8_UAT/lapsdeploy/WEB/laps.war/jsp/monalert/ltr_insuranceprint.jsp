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
										<td align="center"><font face="APS-C-DV-Prakash" size="3"><b> ºããè½ãã</b></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3"><b>Œãã¦ãã ÔãâŒ¾ãã :</b> <%=Helper.correctNull((String)hshValues.get("straccno"))%></font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">‡ãðŠ¹ã¾ãã ‚ãã¹ã Ö½ããÀñ ºãö‡ãŠ Ôãñ ‚ãã¹ã ´ãÀã Êããè Øã¾ããè ‡ãŠã¾ãÃÍããèÊã ¹ãîâ•ããè / ãä½ã¾ããªãè ¨ãÉ¥ã ÔãìãäÌã£ãã ‡ãñŠ ãäÊã† „¹ãÊãº£ã ºããè½ãã ‡ãŠÌãÀ ‡ãŠã Ôãâª¼ãÃ Êãò.</font></td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">1.ããè½ãã ‡ãŠÌãÀ ‡ãñŠÌãÊã Á. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("INS_COVERAMT"))))%>
											‡ãñŠ ãäÊã† „¹ãÊãº£ã Öõ, •ãºããä‡ãŠ ‚ãã¹ã‡ãñŠ ¹ããÔã Ôãã½ãã¶¾ã¦ã¾ãã Á.<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("stock_value"))))%>
											 ‡ãŠã Ô›ãù‡ãŠ ÀÖ¦ãã Öõ. ƒÔããäÊã†, Ô›ãù‡ãŠ ‡ãñŠ ºããè½ãã ‡ãŠÌãÀ ‡ãŠãñ ºãü¤ã¾ãã •ãã¶ãã ‚ããÌãÍ¾ã‡ãŠ Öõ. </font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">2.ºããè½ãã ¹ãããäÊãÔããè ½ãò Ô›ãù‡ãŠ ÀŒãñ •ãã¶ãñ ‡ãŠã Ô©ãã¶ã †Ìãâ ãä¶ãÀãèàã¥ã‡ãŠ¦ããÃ ‚ããä£ã‡ãŠãÀãè ´ãÀã ãä¶ãÀãèàã¥ã ãäÀ¹ããñ›Ã ½ãò ½ããÊã ÀŒãñ •ãã¶ãñ ‡ãŠã •ããñ ¹ã¦ãã Ìããä¥ãÃ¦ã ãä‡ãŠ¾ãã Öõ, ªãò¶ããñ ‚ãÊãØã-‚ãÊãØã Öõ. ‡ãðŠ¹ã¾ãã Ô›ãù‡ãŠ ÀŒãñ •ãã¶ãñ ‡ãŠã ÔãÖãè ¹ã¦ãã ºããè½ãã ¹ãããäÊãÔããè ½ãò Íãããä½ãÊã ‡ãŠÀã‡ãŠÀ ¹ãìãäÓ› ‡ãŠÀò.</font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">3.ºããè½ãã ¹ãããäÊãÔããè ºãö‡ãŠ ‡ãñŠ ¹ãàã ½ãò ¶ãÖãé Ôã½ã¶ãìªñãäÍã¦ã ‡ãŠãè Øã¾ããè Öõ.</font>
										</td>
									</tr>
									<tr>
										<td><font face="APS-C-DV-Prakash" size="3">4.ºããè½ãã ‡ãŠÌãÀ ãäª¶ããâ‡ãŠ ‡ãŠãñ Ôã½ãã¹¦ã Öãñ Øã¾ãã Öõ ‚ããõÀ ƒÔã‡ãŠã ¶ãÌããè‡ãŠÀ¥ã ¶ãÖãé ãä‡ãŠ¾ãã Øã¾ãã Öõ. ‡ãðŠ¹ã¾ãã ºããè½ãã ‡ãŠÀã ‡ãŠÀ ¹ãìãäÓ› ‡ãŠÀò.</font>
										</td>
									</tr>
									<tr>									
                     				 	<td><font face="APS-C-DV-Prakash" size="3">£ã¶¾ãÌããª ÔããäÖ¦ã</font></td>
                   					 </tr>
									 <tr>									
                     				 	<td>&nbsp;</td>
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
